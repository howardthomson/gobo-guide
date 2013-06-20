note

	todo: "[
		Implement text regeneration for:
			characters: single, escaped, and escaped_digits
			free operator strings
			escaped characters within strings
	]"
--------------------------------------------------------------------------------
-- FEC -- Native Eiffel Compiler for SUN/SPARC
--
--  Copyright (C) 1997 Fridtjof Siebert
--    EMail: fridi@gr.opengroup.org
--    SMail: Fridtjof Siebert
--           5b rue du 26 mai 1944
--           38940 St. Martin le Vinoux
--           Grenoble
--
--  This program is free software; you can redistribute it and/or modify
--  it under the terms of the GNU Lesser General Public License as published by
--  the Free Software Foundation; Version 2.
--
--  This program is distributed in the hope that it will be useful,
--  but WITHOUT ANY WARRANTY; without even the implied warranty of
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--  GNU Lesser General Public License for more details.
--
--  You should have received a copy of the GNU Lesser General Public License
--  along with this program; if not, write to the Free Software
--  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
--
--------------------------------------------------------------------------------

class SCANNER_SYMBOL

inherit

	COMPARABLE

	HASHABLE
		undefine
			is_equal	-- use is_equal from COMPARABLE
		end

	ANY
		undefine
			is_equal	-- use is_equal from COMPARABLE
		end

	EDP_RENAME_EIFFEL_SYMBOLS	-- Gobo geyacc generated symbols
		rename
			Question_mark_code		as		 s_query,
			Dollar_code 			as		 s_dollar_sign,
			Equal_code 				as		 s_equal,

			Plus_code				as		 s_plus,
			Minus_code 				as		 s_minus,
			Star_code 				as		 s_times,
			Slash_code 				as		 s_divide,

			Caret_code 				as		 s_power,
			Less_than_code			as		 s_lt,
			Greater_than_code		as		 s_gt,
			Exclamation_code 		as		 s_exclamation_mark,
			Left_parenthesis_code	as		 s_left_parenthesis,
			Right_parenthesis_code 	as		 s_right_parenthesis,
			Left_bracket_code		as		 s_left_bracket,
			Right_bracket_code 		as		 s_right_bracket,
			Left_brace_code 		as		 s_left_brace,
			Right_brace_code 		as		 s_right_brace,
			Dot_code 				as		 s_dot,
			Semicolon_code 			as		 s_semicolon,
			Colon_code 				as		 s_colon,
			Comma_code 				as		 s_comma,
			Tilde_code 				as		 s_tilde
		undefine
			is_equal	-- use is_equal from COMPARABLE
		end

	EDP_GLOBAL
		undefine
			is_equal	-- use is_equal from COMPARABLE
		end

	DIFF_SYMBOL
		undefine
			is_equal
		end

	POSITION_ROUTINES
		undefine
			is_equal	-- use is_equal from COMPARABLE
		end

create {SCANNER_GOBO}

	make

create {ANY}

	default_create

feature -- Creation

	make
		do
		end

feature { ANY }

	type: INTEGER		-- Symbol type as in SCANNER_SYMBOLS

	sequence: INTEGER
		-- Sequence in which the symbol was either read from the originating
		-- source text, or inserted into the altered symbol set.
		-- Line and Column number NOT stored here, only relative column no
		-- Line no deduced from tree information

	position: INTEGER_64  -- Position in source text

	cached_width: INTEGER

	width (s: SCANNER): INTEGER
		require
		--	valid_type: type = s_edit_text implies cached_width
				-- text only in editing class instance
		local
			t: STRING
		do
			if cached_width = 0	then
				t := string_value (s)
				cached_width := string_width (t)
			end
			Result := cached_width
		end

	set_width (new_width: INTEGER)
		do
			cached_width := new_width
		end

	line: INTEGER
		do
			Result := pos_line (position)
		end

	column: INTEGER
		do
			Result := pos_column (position)
		end

feature {NONE}

	string_width (s: STRING): INTEGER
			-- Calculate width of string 's' carting from current position,
			-- and allowing for tabs and tab positions
			-- Tab positions build-in as every 4 columns
		local
			i, nb: INTEGER	-- Index into string 's'
			j1, j2: INTEGER	-- start, current/end column
			c: CHARACTER
		do
			from
				i := 1
				nb := s.count
				j1 := pos_column (position)
				j2 := j1
			until
				i > nb
			loop
				c := s @ i
				if c /= '%T' then
					j2 := j2 + 1
				else
					j2 := (((j2 - 1) // 4) * 4) + 1
				end
				i := i + 1
			end
			Result := j2 - j1
		end

feature { SCANNER_EIFFEL, SCANNER_GOBO, EDP_SYMBOL_EDITOR, SCANNER_SYMBOL }

	incr_column (by: INTEGER)
			-- Adjust column position, to the right
		require
--			valid_new_column: (pos_column (position) + by) >= 0
		do
--			position.init(position.line, position.column + by, 0)
			position := pos_init (pos_line (position), pos_column (position) + by)
		end

	incr_line (by: INTEGER)
			-- Adjust line position, down
		require
--			valid_new_column: (pos_line (position) + by) >= 0
		do
--			position.init(position.line + by, position.column, 0)
			position := pos_init (pos_line (position) + by, pos_column (position))
		end

	special: INTEGER;

	set (new_type: INTEGER; new_special: INTEGER; new_position: INTEGER_64)
		do
			type := new_type
			position := new_position
			special := new_special
		end

	set_type (a_type: INTEGER)
		do
			type := a_type
		end

	set_special (a_special: INTEGER)
		do
			special := a_special
		end

	set_position (a_position: INTEGER_64)
		do
			position := a_position
		end

	text, string_value (s: SCANNER): STRING
		local
			exp_tabs: BOOLEAN	-- Flag to expand tabs
		do
			inspect type

			when
				s_alias,	s_all,		s_and, 		s_as,		s_bit,		s_check,
				s_class,	s_create,	s_creation,	s_current,
										s_debug,	s_deferred,	s_do,		s_else,
				s_elseif,	s_end,		s_ensure,	s_expanded,	s_export,	s_external,
				s_false,	s_feature,	s_from,		s_frozen,	s_if,		s_implies,
				s_indexing,	s_infix,	s_inherit,	s_inspect,	s_invariant,s_is,
				s_like,		s_local,	s_loop,		s_not,  	s_obsolete,	s_old,
				s_once,		s_or,  		s_precursor,s_prefix,	s_redefine,	s_rename,
				s_require,	s_rescue,	s_result,
										s_retry,	s_select,	s_separate,	s_strip,
				s_then,		s_true,		s_undefine,	s_unique,	s_until,	s_variant,
				s_when,		s_xor
				then
					Result := s.token_string(type)
			when s_semicolon          	then Result := once ";"
			when s_comma              	then Result := once ","
			when s_colon              	then Result := once ":"
			when s_dot                	then Result := once "."
			when s_exclamation_mark   	then Result := once "!"
			when s_bangbang				then Result := once "!!"
			when s_arrow              	then Result := once "->"
			when s_dot_dot         		then Result := once ".."
			when s_left_parenthesis   	then Result := once "("
			when s_right_parenthesis 	then Result := once ")"
			when s_left_bracket       	then Result := once "["
			when s_right_bracket      	then Result := once "]"
			when s_left_brace         	then Result := once "{"
			when s_right_brace        	then Result := once "}"
			when s_left_array		 	then Result := once "<<"
			when s_right_array		 	then Result := once ">>"
			when s_assign   	       	then Result := once ":="
			when s_reverse	        	then Result := once "?="
			when s_dollar_sign        	then Result := once "$"
		--	when s_percent            	then Result := once "%%"
			when s_plus               	then Result := once "+"
			when s_minus              	then Result := once "-"
			when s_times              	then Result := once "*"
			when s_divide 			  	then Result := once "/"
			when s_equal              	then Result := once "="
			when s_not_equal          	then Result := once "/="
			when s_lt   	           	then Result := once "<"
			when s_gt   	          	then Result := once ">"
			when s_le			      	then Result := once "<="
			when s_ge			    	then Result := once ">="
			when s_div                	then Result := once "//"
			when s_mod                	then Result := once "\\"
			when s_power              	then Result := once "^"
			when s_and_then           	then Result := once "and then"
			when s_or_else            	then Result := once "or else"

			when s_str_plus				then Result := once "%"+%""
			when s_str_minus			then Result := once "%"-%""
			when s_str_star				then Result := once "%"*%""
			when s_str_slash			then Result := once "%"/%""
			when s_str_div				then Result := once "%"//%""
			when s_str_mod				then Result := once "%"\\%""
			when s_str_power			then Result := once "%"^%""

			when s_str_lt              	then Result := once "%"<%""
			when s_str_gt             	then Result := once "%">%""
			when s_str_le		      	then Result := once "%"<=%""
			when s_str_ge		    	then Result := once "%">=%""

			when s_str_not				then Result := once "%"not%""
			when s_str_and				then Result := once "%"and%""
			when s_str_or				then Result := once "%"or%""
			when s_str_xor				then Result := once "%"xor%""
			when s_str_andthen			then Result := once "%"and then%""
			when s_str_orelse			then Result := once "%"or else%""
			when s_str_implies			then Result := once "%"implies%""

			when s_str_left_bracket		then Result := once "%"["
			when s_str_left_brace		then Result := once "%"{"

			when s_freeop				then Result := repository @ special;		-- Free operator
			when s_str_freeop      		then Result := repository @ special;		-- Free operator string

			when s_identifier           then Result := repository @ special;	-- Feature, class or tag name
				if Result = Void then
				--#	fx_trace (0, <<"SCANNER_SYMBOL::string_value - s_identifier: Void lookup value">>)
					Result := once "?"
				end
			when s_integer              then Result := repository @ special;		-- Integer Constant e.g. "42" or "12_345_678"
			when s_string,
				 s_string_prefix,
				 s_string_infix,
				 s_string_suffix,
				 s_str_right_bracket,
				 s_str_right_brace		then Result := repository @ special;		-- String Constant e.g. '"ha%/108/lo"'
				 							exp_tabs := True
			when s_string_escaped		then Result := escaped (False, True)					-- %X within string
			when s_string_decimal_1		then Result := decimal (False, 1)					-- e.g. %/1/ within string
			when s_string_decimal_2		then Result := decimal (False, 2)					-- e.g. %/12/ within string
			when s_string_decimal_3		then Result := decimal (False, 3)					-- e.g. %/123/ within string
			when s_str_gap_start,
				 s_str_gap_end			then Result := once "%%"							-- Line/String continuation character
			when s_character            then Result := escaped (True, False)					-- Character Constant e.g. "'c'" or "'%B'"
			when s_character_escaped	then Result := escaped (True, True)					-- Character Constant Escaped e.g. '%N'
			when s_character_decimal_1	then Result := decimal (True, 1)						-- e.g. '%/1/'
			when s_character_decimal_2	then Result := decimal (True, 2)						-- e.g. '%/12/'
			when s_character_decimal_3	then Result := decimal (True, 3)						-- e.g. '%/123/'
			when s_real                 then Result := repository @ special;		-- Real Constant e.g. "1234.5678e-90"
			when s_bit_sequence         then Result := repository @ special;		-- 010101B
			when s_comment              then Result := repository @ special;		-- Comment, started by "--"
											exp_tabs := True
			when s_raw_text				then Result := repository @ special;		-- Edited or scan-failed raw text
			when s_edit_text			then Result := s.edit_string						-- Currently edited string
			when s_whitespace			then Result := once ""								-- Non-displayable infill
			when s_eof                  then Result := once "<EOF>";						-- End Of File

			else
			--	Result := once "#"
			end
			if Result = Void then
				Result := once "?"
	--			fx_trace(0, << "SCANNER_SYMBOL::string_value - Void Result for symbol type: ", s.token_string(type), type.out >>)
			end
		end

	escaped (quoted, is_escaped: BOOLEAN): STRING
		local
			s: STRING
			c: CHARACTER
		do
			s := symbol_string; s.wipe_out
			if quoted then s.extend ('%'') end
			if is_escaped then
				s.extend ('%%')
				s.extend (special.to_character_8)
			else
				s.extend (special.to_character_8)
			end
			if quoted then s.extend ('%'') end
			Result := s
		end

	decimal (quoted: BOOLEAN; w: INTEGER): STRING
			-- re-generate decimal character code
		require
			width_ok: w >= 1 and then w <= 3
			width_sufficient: w = 1 implies special <= 9
					  or else w = 2 implies special <= 99
					  or else special <= 255
		local
			s: STRING
		do
			s := symbol_string; s.wipe_out
			if quoted then s.extend ('%'') end
			s.extend ('%%')
			s.extend ('/')
			s.append (special.out)
			-- ## TODO ## ??

			s.extend('/')
			if quoted then s.extend('%'') end
			Result := s
		end

	symbol_string: STRING
		once
			create Result.make (10)
		end

feature -- for COMPARABLE

	infix "<" (other: like Current): BOOLEAN
		do
			if type < other.type
			or else (type = other.type and then special < other.special) then
				Result := True
			end
		end

feature -- for HASHABLE

	hash_code: INTEGER
		do
			Result := (special * 256) + type
		end

feature -- Status assigned by parsing process

	is_class_name: BOOLEAN
		do
		end

	is_feature_name: BOOLEAN
		do
		end

end -- SCANNER_SYMBOL
