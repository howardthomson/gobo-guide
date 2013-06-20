note
	description: "Scanner for Eiffel texts, using gelex"

	todo: "[
		scan string -- multi line strings to complete, save input for display &c
		Fix inheritance hierarchy - SCANNER inherits from SCANNER_GOBO !!

		Editing:
			delete_backward_1 does not correctly deal with a backspace when the cursor is already
			at the start of the line, thus putting the symbols on the before line at the end of the line above

			delete_forward does not work at all!
	]"

class SCANNER_EIFFEL

-- The Eiffel Scanner

inherit

	EDP_EIFFEL_SCANNER
		export {EDP_SYMBOL_EDITOR}
			s_raw_text,
			s_edit_text
		end

	POSITION_ROUTINES

create

	make_from_string

feature {NONE} -- Creation

	make_scanner
		do
			create symbols.make (512)
		end

feature { EDP_CLASS }

	Status_null			: INTEGER = 1	-- Initial creation value	
	Status_no_file		: INTEGER = 2	-- Unable to read file
	Status_rescan		: INTEGER = 3	-- Rescan required after edit
	Status_scan_failed	: INTEGER = 4	-- Scan has failed
	Status_ok			: INTEGER = 5	-- OK

	scan_status: INTEGER

	scanned_ok: BOOLEAN
		do
			Result := scan_status = Status_ok
		end

feature { NONE }

	trace_parse: BOOLEAN = false;	-- Enable trace of parsing process

feature {EDP_SYMBOL_EDITOR, EDP_CLASS_WINDOW} -- symbol info

	symbols: DS_ARRAYED_LIST [ SCANNER_SYMBOL ]  -- The symbols

feature {ANY} -- symbol info

	num_symbols: INTEGER
		do
			Result := symbols.count
		end

feature { NONE }

	drop_comments: BOOLEAN = false	-- do not save comments in scan process, if true

	symbol_start_position: INTEGER_64

	set_symbol_start_position
		do
			symbol_start_position := current_position
		end

feature { ANY }

	current_position: INTEGER_64
		do
			Result := pos_init (line, column + eif_tab_offset)
		end

--------------------------------------------------------------------------------

feature { NONE }

	add_symbol (type: INTEGER; special: INTEGER)
		local
			new_symbol: SCANNER_SYMBOL
		do
			create new_symbol
			new_symbol.set (type, special, symbol_start_position)
			symbols.force_last (new_symbol)
		end

--------------------------------------------------------------------------------

	-- "......." => s_string
	-- ".......% => s_string_prefix
	-- %.......% => s_string_infix
	-- %......." => s_string_suffix

	-- What about "[ ... ]" ???
	-- Also "{ ... }"


--------------------------------------------------------------------------------

feature { ANY }

	the_class: EDP_CLASS_FILE

	make_from_string (ec: EDP_CLASS_FILE; s: STRING)
			-- Scan Eiffel class file from string
		do
			the_class := ec
			make_lex
			scan_status := Status_null
			set_input_buffer (new_string_buffer (s))
			scan

			if scan_status /= Status_scan_failed then
				scan_status := Status_ok
			end
			create edit_string.make (0)
		end

	rescan
			-- Rescan the raw_text symbols
		require
--			scan_status = Status_rescan
-- Change export status of scan_status and Status_rescan ?
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i > symbols.count
			loop
				if (symbols @ i).type = s_raw_text then

					-- Accumulate consecutive raw text
					-- Set start condition
					-- set_input_buffer(....)
				--# scan
					-- Adjust 'i' to account for deleted raw_text and inserted scanned symbols
					--	....
					-- Check that ending start_condition is compatible with the next symbol
					print (start_condition.out)
				end
				i := i + 1
			end
			if scan_status = Status_rescan then
				scan_status := Status_ok
			else
				check scan_status = Status_scan_failed end
			end
		ensure
			status_set: scan_status = Status_ok or else scan_status = Status_scan_failed
		end

	reset
		-- Set current_symbol_index to first Symbol
		do
			current_symbol_index := 0
		end; -- reset
--------------------------------------------------------------------------------

	file_name: STRING
		do
			Result := the_class.filename
		end

--------------------------------------------------------------------------------

	current_symbol : SCANNER_SYMBOL

	current_symbol_index : INTEGER;   -- Index of current_symbol in symbols from 0

feature {NONE}

	select_next_symbol (skip_comments: BOOLEAN)
		-- Move to next symbol, skipping comments if 'skip_comments' is true
		-- Combine multi-line string segments
		-- Combine "and then" & "or else" keywords
		--## convert once "..." into once_string "..." TODO
		--## TODO: do #NOT# change the symbol array; return a new symbol
		-- 		where combination or adaptation is needed
		require
			current_symbol_index >= 0
		local
			ct: INTEGER
			ms: STRING
			p1: INTEGER_64
		do
			--trace("select_next_symbol%N")

			if current_symbol_index < num_symbols then
				current_symbol_index := current_symbol_index + 1;
			end

			current_symbol := symbols @ current_symbol_index
			if skip_comments then
				from
				until
					current_symbol_index >= num_symbols or else
					current_symbol.type /= s_comment
				loop
					current_symbol_index := current_symbol_index + 1
					current_symbol := symbols @ current_symbol_index
				end
			end

			ct := current_symbol.type
			if ct = s_and
			then -- 'and then' ?
				if current_symbol_index < num_symbols and then (symbols @ (current_symbol_index + 1)).type = s_then then
					current_symbol := current_symbol.twin
					current_symbol.set (s_and_then, 0, current_symbol.position)
					current_symbol_index := current_symbol_index + 1;
				end
			elseif ct = s_or
			then  -- 'or else' ?
				if current_symbol_index < num_symbols and then (symbols @ (current_symbol_index + 1)).type = s_else then
					current_symbol := current_symbol.twin
					current_symbol.set(s_or_else, 0, current_symbol.position)
					current_symbol_index := current_symbol_index + 1;
				end;
			elseif ct = s_string_prefix
			then -- Multi-line string
				create ms.make (256)
				ms.append (repository @ current_symbol.special)
				p1 := current_symbol.position
				from
				until
					current_symbol_index >= num_symbols	or else	ct = s_string_suffix
				loop
					current_symbol_index := current_symbol_index + 1
					ct := (symbols @ current_symbol_index).type
					ms.append (repository @ (symbols @ current_symbol_index).special)
				end -- multi-line string
				create current_symbol
				current_symbol.set (s_string, repository # ms, p1)
			elseif ct = s_character_escaped
			then -- Convert %xx to yy
				create current_symbol
				current_symbol.set(s_character, current_symbol.special, current_symbol.position)
			elseif ct = s_character_decimal_1
				or ct = s_character_decimal_2
				or ct = s_character_decimal_3
			then -- Convert %/123/ to yy
				create current_symbol
				current_symbol.set (s_character, current_symbol.special, current_symbol.position)
			end
		ensure
			current_symbol_index = num_symbols or current_symbol_index > old current_symbol_index;
		end; -- next_symbol
		-------------------

	next_symbol
		-- Move to next symbol, skipping comments
		require
			current_symbol_index >= 0
		do
			select_next_symbol (true)
		ensure
			current_symbol.type /= s_comment
		end

	next_symbol_or_comment
		-- Move to next symbol; do not skip comments
		do
			select_next_symbol (false)
		end

--------------------------------------------------------------------------------

feature {NONE} -- symbol lookup by position

	set_edit_index (l, c: INTEGER): BOOLEAN
			-- Find symbol index for line/column
			-- same line: within or after symbol, or before first symbol on line
			-- empty line: last symbol of previous non-empty line

			-- Result true if openable symbol at the specified line, column
			-- edit_index set to index of symbol to open or insert
		local
			min, max, mid: INTEGER
			s: SCANNER_SYMBOL
		--	p: INTEGER_64
			sw: INTEGER
			new_edit_index: INTEGER
		do
			check_assertion("non_zero_symbol_count", symbols.count /= 0)

				-- Scenarios:
				--		[l,c] before first symbol
				--		.....
--	print(once "l: "); print(l.out); print_newline
--	print(once "c: "); print(c.out); print_newline
--	print(once "----------------%N")


			from
				min := 1
				max := num_symbols + 1
			until
				min >= max or new_edit_index /= 0
			loop
				mid := (min+max) // 2
--	print("min,mid,max (before): ");
--	print(min.out); print(",")
--	print(mid.out); print(",")
--	print(max.out);
--	print_newline
				if mid > num_symbols then
					new_edit_index := mid
				else
					s := symbols @ mid
				--	p := s.position

					if l > s.line then
						min := mid + 1
					elseif l < s.line then
						if max /= mid then
							max := mid
						else
							new_edit_index := mid
						end
					else
							-- Here, on the right line
						sw := s.width (scanner)
						if c > (s.column + sw) then
							min := mid + 1
						elseif c < s.column then
							if max /= mid then
								max := mid
							else
								new_edit_index := mid
							end
						else
							new_edit_index := mid
							Result := True
						end
					end
				end
--	print("min,mid,max (after): ");
--	print(min.out); print(",")
--	print(mid.out); print(",")
--	print(max.out);
--	print_newline
			end
			if not Result then
--	print("Result False - Set from exit value of mid%N")
				new_edit_index := mid + 1
			end
			edit_index := new_edit_index

--	print("symbol_index_at: "); print(Result.out); print_newline
--	print("new_edit_index: "); print(new_edit_index.out); print_newline
--	print("min: "); print(min.out); print_newline
--	print("max: "); print(max.out); print_newline
--	print("mid: "); print(mid.out); print_newline
--	print("-----------------"); print_newline

		--	edp_trace.st("Symbol_index_at(").n(l.out).n(", ").n(c.out).n("): ").n(Result.out).d

--			check_assertion("set_edit_index:1",
--						(Result /= 0) implies (symbols @ Result).line <= l)
--			check_assertion("set_edit_index:2",
--						(Result /= 0 and then (symbols @ Result).line = l)
--								implies (symbols @ Result).column <= c)
--			check_assertion("set_edit_index:3",
--						(symbols.count > Result) implies
--							((symbols @ (Result + 1)).line > l
--						or else (symbols @ (Result + 1)).column > c))

		ensure
--			Result /= 0 implies (symbols @ Result).line <= l
--			(Result /= 0 and then (symbols @ Result).line = l)
--				implies (symbols @ Result).column <= c
		end -- set_edit_index

	print_newline
		do
			print (once "%N")
		end

feature {SCANNER_SYMBOL} -- Editing routines

	edit_string: STRING

feature {NONE} -- Editing routines

	edit_index: INTEGER
			-- Index in symbols of current symbol to edit

	edit_offset: INTEGER
			-- Column offset from edit symbol of insertion cursor

	edit_symbol: SCANNER_SYMBOL
			-- unique symbol, of type s_edit_text, corresponding to edit_string content

	scanner: SCANNER
		do
			Result ?= Current
		end

feature {EDP_SYMBOL_EDITOR} -- Editing routines

	cursor_column: INTEGER
		do
check_invariant
			if edit_symbol /= Void then
				Result := edit_symbol.column + edit_offset
			elseif edit_index /= 0 then
				Result := (symbols @ edit_index).column
			else
				Result := 1
			end
		end

	cursor_line: INTEGER
		do
check_invariant
			if edit_symbol /= Void then
				Result := edit_symbol.line
			elseif edit_index /= 0 then
				Result := (symbols @ edit_index).line
			else
				Result := 1
			end
		end

	symbol (i: INTEGER): SCANNER_SYMBOL
		do
			Result := symbols @ i
		end

	symbol_position (i: INTEGER): INTEGER_64
		do
			Result := (symbols @ i).position
		end

	insert_character (c: CHARACTER; a_line, a_column: INTEGER)
		do
		end

	insert_string (s: STRING; a_line, a_column: INTEGER)
		do
		end

	delete_forward (a_line, a_column: INTEGER)
		do
		end

	delete_backward (a_line, a_column: INTEGER)
			-- Delete 'n' characters back
		local
			i, j: INTEGER
			l_line: INTEGER
			l_deleted: INTEGER	-- No of deleted lines
		do
check_invariant
			set_insertion_point(a_line, a_column)
			if edit_offset > 0
			or else edit_symbol.column > 1
			or else edit_symbol.line > 1 then
				l_deleted := delete_backward_1
			end
				-- Move following symbols up for deleted lines
			if l_deleted /= 0 then
				from
					i := edit_index
				until
					i > symbols.count
				loop
					(symbols @ i).incr_line (- l_deleted)
					i := i + 1
				end
			end
check_invariant
print_status
		end

	print_status
			-- DEBUG -- trace values after each delete_backward
		do
			print(once "edit_index: "); print(edit_index.out); print(once "%N")
			if edit_symbol /= Void then
				print(once "edit_string: "); print(edit_string); print(once "%N")
			else
				print(once "edit_string: "); print("Void"); print(once "%N")
			end
			print(once "edit_offset: "); print(edit_offset.out); print(once "%N")
			print(once "cursor_line: "); print(cursor_line.out); print(once "%N")
			print(once "cursor_column: "); print(cursor_column.out); print(once "%N")
			print(once "----------------------------------%N")
		end

--	place_cursor (l, c: INTEGER) is
--			-- TEMP for debugging
--		local
--			r: BOOLEAN
--		do
--			r := set_edit_index(l, c)
--		--	set_insertion_point(l, c)
--			print("==========================================%N")
--		end

feature {NONE}

	delete_backward_1: INTEGER
			-- backspace one character
			-- Result = 1 if backspace into previous line
			-- Result = 0 otherwise
		require

		local
			i, j: INTEGER
			l_line: INTEGER
			l_edit_index: INTEGER
			l_coll_diff: INTEGER
		do
				-- Possible scenarios:
				--	1: Remove one character from current symbol
				--	2: Select previous (adjacent on same line) symbol and remove character
				--	3: Move current symbol (not at leftmost column) leftward
				--	4: Move current symbol up one line
				--	5: Move current symbol to end of previous line

			if edit_offset > 0 then
					-- remove within the current symbol
				edit_string.remove (edit_offset)
				edit_offset := edit_offset - 1
if edit_offset < 0 then print("#4 edit_offset FAIL%N") end
				l_coll_diff := -1
				j := edit_index + 1
				Result := 0
			elseif edit_index > 1 then
				if adjacent_symbols(edit_index - 1) then
						-- Select previous adjacent symbol on the same line and remove character
					l_edit_index := edit_index
					close_edit_symbol
					open_edit_symbol(l_edit_index - 1, True)
					edit_string.remove(edit_offset)
					edit_offset := edit_offset - 1
if edit_offset < 0 then print("#3 edit_offset FAIL%N") end
					l_coll_diff := -1
					j := edit_index + 1
					Result := 0
				elseif cursor_column > 1 then
						-- Move edit_symbol 'leftwards'
					l_coll_diff := -1
					j := edit_index
				elseif (symbols @ (edit_index - 1)).line < (cursor_line - 1) then
						-- Move edit_symbol up one line, previous line empty
					Result := 1
					l_coll_diff := 0
				else
						-- Move edit_symbol to end of previous line
					Result := 1
					j := edit_index
					l_coll_diff := (symbols @ (edit_index - 1)).column
								+ (symbols @ (edit_index - 1)).width (scanner) - 1
				end
			end

			if l_coll_diff /= 0 then
					-- Move following symbols on the same line leftwards
				from
					l_line := edit_symbol.line
				until
					j > symbols.count or else (symbols @ j).line > l_line
				loop
					(symbols @ j).incr_column (l_coll_diff)
					j := j + 1
				end
			end
		end

	adjacent_symbols (i: INTEGER): BOOLEAN
			-- are symbols at i and i+1 adjacent ?
			-- are they on the same line ?
		require
			enough_symbols: symbols.count >= (i + 1)
		local
			s1, s2: SCANNER_SYMBOL
		do
			s1 := symbols @ i
			s2 := symbols @ (i + 1)
			if s1.line = s2.line
			and then s1.column + s1.width (scanner) = s2.column
			then
				Result := True
			end
		end

	Xinsert_string (s: STRING)
		require
			valid_string: s /= Void and then s.count = 1
			valid_insertion_point: (symbols @ edit_index).type = s_edit_text
			valid_offset: edit_offset >= 0
		local
			i, l_line: INTEGER
		do
			edit_string.insert_string(s, edit_offset + 1)
			edit_offset := edit_offset + 1
			edit_symbol.set_width (0)	-- unset
			from
				i := edit_index + 1
				l_line := edit_symbol.line
			until
				i > symbols.count or else (symbols @ i).line > l_line
			loop
				(symbols @ i).incr_column (1)
				i := i + 1
			end
		end


	set_insertion_point (a_line, a_column: INTEGER)
			-- Set edit cursor at line/column
		local
			index, offset: INTEGER
			s: SCANNER_SYMBOL
			openable: BOOLEAN
		do
			if num_symbols = 0 then
				check_assertion ("check #2: consistent_edit_index",
					edit_index = 0
				)
				check_assertion ("check #3: consistent_edit_offset",
					edit_offset = 0
				)
				insert_edit_symbol (1, a_line, a_column)
				edit_string.wipe_out
				check
					correct_line: edit_symbol.line = a_line
				end
			else
		--		close_edit_symbol
					-- Lookup nearest symbol before target line/column
				if edit_symbol /= Void
				and then edit_symbol.line = a_line
				and then a_column <= edit_symbol.column + edit_symbol.width (scanner) then
					-- Within current edit symbol
					--### Note: line below will not work for embedded tabs in edit_string
					edit_offset := a_column - edit_symbol.column
if edit_offset < 0 then print("#1 edit_offset FAIL%N") end
					check
						correct_line: edit_symbol.line = a_line
					end
				else
					if edit_symbol /= Void then
						close_edit_symbol
					end
					openable := set_edit_index (a_line, a_column)
print("set_edit_index = "); print(edit_index.out); print("%N")
					if not openable then

						check_assertion("check #1",
							-- The target line must be a blank line
							-- or the target column must be before the first symbol on the line
							symbols.count > index implies
									(symbols @ (index + 1)).line > a_line
							or else (symbols @ (index + 1)).column > a_column
						)
						insert_edit_symbol (edit_index, a_line, a_column)
						check
							correct_line: edit_symbol.line = a_line
						end
					else
							-- open existing symbol
						s := symbols @ edit_index
						edit_string.wipe_out
						edit_string.append (s.text (scanner))
						edit_offset := a_column - s.column
if edit_offset < 0 then print("#2 edit_offset FAIL%N") end
						s.set_type (s_edit_text)
						edit_symbol := s
						check
							correct_line: edit_symbol.line = a_line
						end
					end
				end
			end
		--	edp_trace.st("set_insertion_point: edit_offset = ").n(edit_offset.out).d
		ensure
			valid_insertion_symbol: (symbols @ edit_index).type = s_edit_text
			valid_insertion_offset: edit_offset >= 0 and edit_offset <= edit_string.count
			correct_line:			edit_symbol.line = a_line
			valid_column:			edit_symbol.column <= a_column
		--	correct_end:			at_start implies ???
		end

	debug_editing: BOOLEAN = True

	insert_edit_symbol (at, a_line, a_column: INTEGER)
			-- Create and insert an s_edit_text symbols
			-- after symbol index 'at'
		require
			existing_position: at >= 1 and at <= (num_symbols + 1)
		local
			prev_s, s: SCANNER_SYMBOL
			p: INTEGER_64
		do
			create s
			p := pos_init (a_line, a_column)
			s.set (s_edit_text, 0, p)
			symbols.put (s, at)
			edit_symbol := s
			edit_index := at
			edit_offset := 0
			edit_string.wipe_out
			check -- look for consistent, monotonic increase of line,column sequence
				at > 1 implies (symbols @ (at - 1)).column < a_column
					   or else (symbols @ (at - 1)).line   < a_line
				num_symbols > at implies (symbols @ (at + 1)).column > a_column
								 or else (symbols @ (at + 1)).line   > a_line
			end -- check
		ensure
			e1:	edit_index = at
			e2:	edit_offset = 0
			e3:	edit_symbol /= Void and (symbols @ edit_index) = edit_symbol
			e4:	symbols.count = old symbols.count + 1
			e5: edit_string.count = 0
		end

	open_edit_symbol (at: INTEGER; at_end: BOOLEAN)
		do
			edit_symbol := symbols @ at
			edit_index := at
			edit_string.wipe_out
			edit_string.append (edit_symbol.text (scanner))
			edit_symbol.set_type(s_edit_text)
			if at_end then
				edit_offset := edit_symbol.width (scanner)
			else
				edit_offset := 0
			end
		end

	close_edit_symbol
			-- finalize existing edit symbol
		require
			valid_edit_symbol: edit_symbol /= Void and then edit_symbol.type = s_edit_text
			edit_open: edit_index /= 0 and then (symbols @ edit_index) = edit_symbol
		local
			s: SCANNER_SYMBOL
		do
			if edit_symbol /= Void then
		--		if debug_editing then edp_trace.st ("Close_edit_point, edit_string = ").n(edit_string).d end
				if edit_string.count /= 0 then
					edit_symbol.set_type(s_raw_text)
					edit_symbol.set_special(repository # edit_string)
					s := edit_symbol; edit_symbol := Void --### TEMP to maintain invariant for next line
		--			if debug_editing then edp_trace.st ("Close_edit_point, symbol text = ").n(s.text(scanner)).d end
				else
					symbols.remove (edit_index)
				end
			--	edit_index := 0
				edit_symbol := Void
				edit_offset := 0
			end
		end

	valid_edit_position (index, offset: INTEGER): BOOLEAN
			-- Is the specified position valid
		local
			s: SCANNER_SYMBOL
		do
			if num_symbols = 0 then
				Result := (index = 0) and (offset = 0)
			else
				if index /= 0 then
						-- Cursor position ok as derived from symbol position and offset?
					s := (symbols @ index)
					Result := (s.column + offset) >= 0
				else
						-- Cursor line has no symbols on it
					Result := True
				end
			end
		end

	check_invariant
		do
			check_assertion(once "symbols_not_void", symbols /= Void)

			check_assertion(once "edit_string_not_void", edit_string /= Void)

			check_assertion(once "valid_edit_index_1",	(num_symbols = 0 implies edit_index = 0))
			check_assertion(once "valid_edit_index_2",	edit_index /= 0 implies (edit_index >= 1 and edit_index <= num_symbols))
			check_assertion(once "valid_edit_symbol_1",	edit_symbol /= Void implies edit_symbol.type = s_edit_text)
			check_assertion(once "valid_edit_symbol_2",	edit_symbol /= Void implies (symbols @ edit_index) = edit_symbol)
			check_assertion(once "valid_edit_offset",	edit_symbol /= Void implies edit_offset <= edit_string.count)

			check_assertion(once "valid_edit_offset",	edit_offset >= 0)

		--	check_assertion(once "valid_line",		edit_index /= 0 implies cursor_line >= 1	)
		--	check_assertion(once "valid_column",	edit_index /= 0 implies cursor_column >= 1	)
		end

	check_assertion(s: STRING; b: BOOLEAN)
		do
			if not b then
				print(once "ASSERTION FAILURE: ")
				print(s)
				print(once "%N")
			end
		end

feature -- File Save

	save_to_file (save_file_name: STRING)
			-- Save symbols as text to the named file
		local
			i, nb: INTEGER			-- Current/maximum scanner index
			s: SCANNER_SYMBOL		-- Current SCANNER_SYMBOL
			f: KL_TEXT_OUTPUT_FILE	-- File output stream
			l, c: INTEGER			-- Last line, column
			tl, tc: INTEGER			-- Target line, column
			tabc: INTEGER			-- Next tab column
		do
			l := 1
			c := 1
			nb := symbols.count
			create f.make (save_file_name)
			f.open_write
			if f.is_open_write then
				from
					i := 1
				until
					i > nb
				loop
					s := symbols @ i
					tl := s.line
					if tl > l then
						c := 1
						from until l >= tl loop
							f.put_string (once "%N")
							l := l + 1
						end
					end
					tc := s.column
					from until c >= tc loop
						tabc := ((((c - 1) + 4) // 4) * 4) + 1
						if tc >= tabc then
							f.put_character ('%T')
							c := tabc
						else
							f.put_character (' ')
							c := c + 1
						end
					end
					f.put_string (s.text (scanner))
					c := c + s.width (scanner)
					i := i + 1
				end
				f.put_character ('%N')
				f.close
			else
				-- ERROR TODO
				print ("Failed to create test output file!%N")
			end
		end


invariant

	symbols_not_void:		symbols /= Void;

	edit_string_not_void:	edit_string /= Void

	valid_edit_index_1:		(num_symbols = 0 implies edit_index = 0)
	valid_edit_index_2:		edit_index /= 0 implies (edit_index >= 1 and edit_index <= num_symbols)
	valid_edit_symbol_1:	edit_symbol /= Void implies edit_symbol.type = s_edit_text
	valid_edit_symbol_2:	edit_symbol /= Void implies (symbols @ edit_index) = edit_symbol
	valid_edit_offset:		edit_symbol /= Void implies edit_offset <= edit_string.count

end -- SCANNER_EIFFEL
