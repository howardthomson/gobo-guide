indexing

	description:

		"External string parser"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 2004-2006, Eric Bezault and others"
	author "Howard Thomson"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date: 2006/04/15 22:02:00 $"
	revision: "$Revision: 1.51 $"

	edp_mods: "[
		New class helper for ET_C_GENERATOR for
		'C external ...' clauses
	]"

class ET_EXTERNAL_PARSER

inherit

	ANY
	
	KL_SHARED_STRING_EQUALITY_TESTER
		export
	--		{ANY} generating_type, is_equal, standard_is_equal
			{NONE} all
		end

	KL_IMPORTED_STRING_ROUTINES
		export
	--	{ANY} generating_type, is_equal, standard_is_equal
		{NONE} all end
	
feature -- Attributes

	source: ET_MANIFEST_STRING
	string: STRING
	src_index: INTEGER
	count: INTEGER
	stop_char: CHARACTER

	do_tracing: BOOLEAN is False
	
feature -- Initialisation

	start(ms: ET_MANIFEST_STRING) is
			-- Initialise for parsing from the manifest string
		do
			source := ms
			string := ms.value
			src_index := 1
			count := string.count
			stop_char := '%U'
			skip_white_space
		end

feature

	set_stop_char (c: CHARACTER) is
		do
			stop_char := c
		end

feature -- Parse routines

	tail: STRING is
		require
			not_is_off: not is_off
		do
			Result := string.substring (src_index, count)
		end

	match_keyword(s: STRING): BOOLEAN is
			-- Does the keyword match at the current position
			-- either followed by white-space or at the end
		do
			if do_tracing then
				print("Looking for keyword: "); print(s)
				print(" ("); print(src_index.out); print(") ... ")
			end
			if check_match_keyword(s) then
				Result := True
				src_index := src_index + s.count
				skip_white_space
			end
			if do_tracing then
				print(src_index.out); print(" ")
				if Result then
					print("found")
				else
					print("no match")
				end
				print("%N")
			end
		end

	check_match_keyword(s: STRING): BOOLEAN is
			-- Does the keyword match at the current position
			-- either followed by white-space or at the end
		local
			k: STRING
			sc: INTEGER
		do
			sc := s.count
			if sc <= (count - src_index + 1) then
				-- there are sufficient characters left to match
				k := string.substring (src_index, src_index + sc - 1)
				if STRING_.same_case_insensitive (k, s)
				and then ((src_index + sc) > count or else is_white(src_index + sc)) then
					Result := True
				end
			end
		end

	match_character (c: CHARACTER): BOOLEAN is
			-- Does the current character match at the current position ?
		do
			if src_index <= count and then c = string.item (src_index) then
				src_index := src_index + 1
				Result := True
				skip_white_space
			end
		end

	is_white(i: INTEGER): BOOLEAN is
			-- is the character at index 'i' a white-space character ?
		require
			i <= count
		do
			inspect string.item (i)
			when ' ', '%T', '%R', '%N' then
				Result := True
			else
			end
		end

	an_identifier: STRING is
			-- Get an Identifier
			-- Void if none
		local
			stop: BOOLEAN
			c: CHARACTER
		do
			if do_tracing then			
				print("Looking for Identifier ... ");
			end
			from
				create Result.make(10)
				stop := False
			until
				src_index > count or stop
			loop
				c := string.item (src_index)
				inspect c
				when ' ', '%R', '%T', '%N' then
					stop := True
				else
					Result.append_character (c)
					src_index := src_index + 1
				end
			end
			skip_white_space
			if do_tracing then
				if Result /= Void then			
					print("found: "); print(Result);
				else
					print("not found")
				end
				print("%N")
			end
		end

	a_signature: STRING is
			-- Match "(....)"
			-- Exclude the brackets from the result
		require
			not_off: not is_off
			current_char_is_lparen: item = '('
		local
			stop: BOOLEAN
			c: CHARACTER
		do
			from
				stop := False
				src_index := src_index + 1
				create Result.make (10)
			until
				src_index > count or stop
			loop
				c := string.item (src_index)
				if c = ')' then
					stop := True
				else
					Result.append_character (c)
				end
				src_index := src_index + 1
			end
		end

	a_signature_result: STRING is
			-- Match ": ..."
			-- Exclude the colon from the result
			-- Stop on '|' or 'use'
		require
			not_off: not is_off
			current_char_is_colon: item = ':'
		local
			stop: BOOLEAN
			c: CHARACTER
			last_is_alpha: BOOLEAN
		do
			from
				stop := False
				src_index := src_index + 1
				create Result.make (10)
			until
				src_index > count or stop
			loop
				c := string.item (src_index)
				if c = '|' then
					stop := True
				elseif (not last_is_alpha) and then check_match_keyword ("use") then
					stop := True
				else
					Result.append_character (c)
					src_index := src_index + 1
				end
			end
			skip_white_space
		end
		
	a_filename: STRING is
			-- Get a file name
			-- Either "..." or <...>
		local
			stop: BOOLEAN
			c: CHARACTER
			tc: CHARACTER	-- expected terminating character: " or >
		do
			skip_white_space
			if not is_off then
				tc := item
				if tc = '"' or tc = '<' then
					-- possible filename starting ...
					from
						stop := false
						create Result.make (10)
						src_index := src_index + 1
					until
						src_index > count or stop
					loop
						c := string.item (src_index)
						if c = tc then
							stop := True
						else
							Result.append_character (c)
							src_index := src_index + 1
						end
					end
					if (not stop) or Result.count = 0 then
						Result := Void
					end
				end
			end
			-- TODO
		end

	item: CHARACTER is
			-- item at current position
		require
			not is_off
		do
			Result := string.item (src_index)
		end

	is_off: BOOLEAN is
		do
			Result := src_index > count
		end

	advance is
			-- advance one character and skip white space
		require
			not is_off
		do
			src_index := src_index + 1
			skip_white_space
		end

	skip_white_space is
		local
			stop: BOOLEAN
		do
			from
				stop := False
			until
				src_index > count or stop
			loop
				inspect string.item (src_index)
				when ' ', '%R', '%T', '%N' then
					src_index := src_index + 1
				else
					stop := True
				end
			end
		end				
end 