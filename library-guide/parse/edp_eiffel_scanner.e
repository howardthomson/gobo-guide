note

	description:

		"Scanners for Eiffel parsers"

	copyright: "Copyright (c) 1999-2003, Eric Bezault and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date: 2003/04/18 15:52:30 $"
	revision: "$Revision: 1.5 $"

	todo: "[
		Setup start_condition for rescanning edited raw text
			Either:
			1: Always re-scan from the initial token of a string sequence OR
			2: Setup start_condition based on the type of the preceding token(s)
			2 preferable, esp. if only the immediately preceding token is sufficient
		strings and continuations
			EDP_PROJECT::read_environment
			start position of multi-segment string tokens
		quoted characters
			EDP_CLUSTER_PATH_SET::process -- line 2
			s_character_escaped bug
		multi-line strings
			" [ ... ] " and " { ... } "
		tabs within comments
		quotes surrounding re-displayed strings (done temp!)
		prepare for updated/altered spec for free operators
		use 'more' facility of scanner
		
		check for valid escaped character - treat as raw text or what ?

		remove <CR> from input - check at end of line in strings/comments etc
	]"

	string_notes: "[
		s_string:	Simple string, on one line, without escapes
		string prefixes: s_string_prefix, s_str_left_bracket, s_str_left_brace
		string infixes: s_string_infix, s_string_escaped, s_string_decimal_x,
			s_str_gap_start, s_str_gap_end
		string termination: s_string_suffix, s_str_right_bracket, str_right_brace
	]"

	done: "[
		Strings done:
			s_string, s_string_prefix, s_string_infix, s_string_suffix
		Hexadecimal integers
		multi-line comments ?? (Header comment(s) etc)
			Treat as parsing group
		scanner_symbol position (line/column) now correct @ 29-10-04
	]"

	notes: "[
		String matching depends on match length, including the characters after the '/' break
		indication. Rules are only selected on the basis of their order in the rules after match
		length has been established.
	]"
	
deferred class EDP_EIFFEL_SCANNER

inherit

	YY_COMPRESSED_SCANNER_SKELETON
		rename
			make as make_compressed_scanner_skeleton,
			reset as reset_compressed_scanner_skeleton
		redefine
			pre_action,
			post_action,
			post_eof_action
		end

	EDP_RENAME_EIFFEL_SYMBOLS
--	EDP_EIFFEL_SYMBOLS
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
		export {NONE}
			all
		select	-- For EDP/GEC
			s_tilde,
			s_right_brace,
			s_left_brace,
			s_right_bracket,
			s_left_bracket,
			s_right_parenthesis,
			s_left_parenthesis,
			s_query,
			s_exclamation_mark,
			s_dollar_sign,
			s_dot,
			s_comma,
			s_semicolon,
			s_colon,
			s_equal,
			s_gt,
			s_lt,
			s_power,
			s_divide,
			s_times,
			s_minus,
			s_plus
		end

	UT_CHARACTER_CODES
		export {NONE} all end

	KL_IMPORTED_INTEGER_ROUTINES
	KL_IMPORTED_STRING_ROUTINES
	KL_SHARED_PLATFORM

	EDP_GLOBAL
	

feature -- Status report

	valid_start_condition (sc: INTEGER): BOOLEAN
			-- Is `sc' a valid start condition?
		do
			Result := (INITIAL <= sc and sc <= STR_VERBATIM)
		end

feature {NONE} -- Implementation

	yy_build_tables
			-- Build scanner tables.
		do
			yy_nxt := yy_nxt_template
			yy_chk := yy_chk_template
			yy_base := yy_base_template
			yy_def := yy_def_template
			yy_ec := yy_ec_template
			yy_meta := yy_meta_template
			yy_accept := yy_accept_template
			yy_acclist := yy_acclist_template
		end

	yy_execute_action (yy_act: INTEGER)
			-- Execute semantic action.
		do
if yy_act <= 93 then
if yy_act <= 47 then
if yy_act <= 24 then
if yy_act <= 12 then
if yy_act <= 6 then
if yy_act <= 3 then
if yy_act <= 2 then
if yy_act = 1 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
pre_action
--|#line 151 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 151")
end
	-- Ignore separators
						fx_trace_local(0, <<"Rule match: 1 ==>", text, "<==">>)
						last_token := s_whitespace
					
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
pre_action
--|#line 155 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 155")
end
	-- Ignore separators
					--	fx_trace_local(0, <<"Rule match: 2 ==>", text, "<==">>)
						last_token := s_whitespace
					
end
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
pre_action
--|#line 159 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 159")
end
	-- Expand tab positions
					--	fx_trace_local(0, <<"Rule match: 3 ==>", text, "<==">>)
						last_token := s_whitespace
						t_col := column + eif_tab_offset - 1	-- 0 offset
						t_col := ((t_col + 4) // 4) * 4
						t_col := t_col + (3 * (text_count - 1))
						eif_tab_offset := t_col - column
					
end
else
if yy_act <= 5 then
if yy_act = 4 then
yy_set_line (0)
	yy_position := yy_position + yy_end - yy_start - yy_more_len
pre_action
--|#line 167 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 167")
end
	-- Ignore Newlines
					--	fx_trace_local(0, <<"Rule match: 4 ==>", text, "<==">>)
						last_token := s_whitespace
						eif_tab_offset := 0
					
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
pre_action
--|#line 176 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 176")
end
 -- Comment to end of line
						fx_trace_local(0, <<"Rule match: 5 ==>", text, "<==">>)
						last_token := s_comment
					--	eif_tab_offset := 0
						last_any_value := text_substring (1, text_count)
					
end
else
	yy_column := yy_column + 3
	yy_position := yy_position + 3
pre_action
--|#line 185 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 185")
end
last_token := process_operator (s_str_plus)		-- "+"
end
end
else
if yy_act <= 9 then
if yy_act <= 8 then
if yy_act = 7 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
pre_action
--|#line 186 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 186")
end
last_token := process_operator (s_str_minus)	-- "-"
else
	yy_column := yy_column + 3
	yy_position := yy_position + 3
pre_action
--|#line 187 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 187")
end
last_token := process_operator (s_str_star)		-- "*"
end
else
	yy_column := yy_column + 3
	yy_position := yy_position + 3
pre_action
--|#line 188 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 188")
end
last_token := process_operator (s_str_slash)	-- "/"
end
else
if yy_act <= 11 then
if yy_act = 10 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
pre_action
--|#line 189 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 189")
end
last_token := process_operator (s_str_div)		-- "/"
else
	yy_column := yy_column + 4
	yy_position := yy_position + 4
pre_action
--|#line 190 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 190")
end
last_token := process_operator (s_str_mod)		-- "\"
end
else
	yy_column := yy_column + 3
	yy_position := yy_position + 3
pre_action
--|#line 191 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 191")
end
last_token := process_operator (s_str_power)	-- "^"
end
end
end
else
if yy_act <= 18 then
if yy_act <= 15 then
if yy_act <= 14 then
if yy_act = 13 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
pre_action
--|#line 192 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 192")
end
last_token := process_operator (s_str_lt)		-- "<"
else
	yy_column := yy_column + 4
	yy_position := yy_position + 4
pre_action
--|#line 193 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 193")
end
last_token := process_operator (s_str_le)		-- "<="
end
else
	yy_column := yy_column + 3
	yy_position := yy_position + 3
pre_action
--|#line 194 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 194")
end
last_token := process_operator (s_str_gt)		-- ">"
end
else
if yy_act <= 17 then
if yy_act = 16 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
pre_action
--|#line 195 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 195")
end
last_token := process_operator (s_str_ge)		-- ">="
else
	yy_column := yy_column + 5
	yy_position := yy_position + 5
pre_action
--|#line 196 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 196")
end
last_token := process_operator (s_str_not)		-- "not"
end
else
	yy_column := yy_column + 5
	yy_position := yy_position + 5
pre_action
--|#line 197 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 197")
end
last_token := process_operator (s_str_and)		-- "and"
end
end
else
if yy_act <= 21 then
if yy_act <= 20 then
if yy_act = 19 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
pre_action
--|#line 198 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 198")
end
last_token := process_operator (s_str_or)		-- "or"
else
	yy_column := yy_column + 5
	yy_position := yy_position + 5
pre_action
--|#line 199 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 199")
end
last_token := process_operator (s_str_xor)		-- "xor"
end
else
	yy_column := yy_column + 10
	yy_position := yy_position + 10
pre_action
--|#line 200 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 200")
end
last_token := process_operator (s_str_andthen)	-- "and then"
end
else
if yy_act <= 23 then
if yy_act = 22 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
pre_action
--|#line 201 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 201")
end
last_token := process_operator (s_str_orelse)	-- "or else"
else
	yy_column := yy_column + 9
	yy_position := yy_position + 9
pre_action
--|#line 202 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 202")
end
last_token := process_operator (s_str_implies)	-- "implies"
end
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
pre_action
--|#line 206 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 206")
end
	-- New definition of Free operator imminent XXX

								fx_trace_local(0, <<"Rule match: XX ==>", text, "<==">>)
								if is_operator then
									-- Preceding token is 'infix' or 'prefix'
									is_operator := False
									last_token := s_str_freeop
								else
									last_token := s_string
								end
								last_any_value := text_substring (1, text_count - 0)	-- TEMP retain "'s
							
end
end
end
end
else
if yy_act <= 36 then
if yy_act <= 30 then
if yy_act <= 27 then
if yy_act <= 26 then
if yy_act = 25 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
pre_action
--|#line 223 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 223")
end
	-- Includes empty string ""
								fx_trace_local(0, <<"Rule match: 13 ==>", text, "<==">>)
								last_token := s_string
								last_any_value := text
							
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
pre_action
--|#line 235 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 235")
end
	-- " only
								fx_trace_local(0, <<"Rule match: 14 ==>", text, "<==">>)
								set_start_condition(IN_STR)
								last_token := s_string_prefix
								last_any_value := text
							
end
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
pre_action
--|#line 236 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 236")
end
	-- " only
								fx_trace_local(0, <<"Rule match: 14 ==>", text, "<==">>)
								set_start_condition(IN_STR)
								last_token := s_string_prefix
								last_any_value := text
							
end
else
if yy_act <= 29 then
if yy_act = 28 then
	yy_end := yy_end - 1
	yy_column := yy_column + 2
	yy_position := yy_position + 2
pre_action
--|#line 237 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 237")
end
	-- " only
								fx_trace_local(0, <<"Rule match: 14 ==>", text, "<==">>)
								set_start_condition(IN_STR)
								last_token := s_string_prefix
								last_any_value := text
							
else
	yy_end := yy_end - 1
	yy_column := yy_column + 1
	yy_position := yy_position + 1
pre_action
--|#line 238 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 238")
end
	-- " only
								fx_trace_local(0, <<"Rule match: 14 ==>", text, "<==">>)
								set_start_condition(IN_STR)
								last_token := s_string_prefix
								last_any_value := text
							
end
else
	yy_end := yy_end - 1
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
pre_action
--|#line 254 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 254")
end

								fx_trace_local(0, <<"Rule match: 14a: start verbatim string ==>", text, "<==">>)
								if text_item(2) = '{' then
									set_start_condition(STR_VERBATIM)
									last_token := s_str_left_brace
								else
									set_start_condition(STR_VERBATIM_LA)
									last_token := s_str_left_bracket
								end
								eif_string_valid := True
							
end
end
else
if yy_act <= 33 then
if yy_act <= 32 then
if yy_act = 31 then
	yy_end := yy_end - 1
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
pre_action
--|#line 255 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 255")
end

								fx_trace_local(0, <<"Rule match: 14a: start verbatim string ==>", text, "<==">>)
								if text_item(2) = '{' then
									set_start_condition(STR_VERBATIM)
									last_token := s_str_left_brace
								else
									set_start_condition(STR_VERBATIM_LA)
									last_token := s_str_left_bracket
								end
								eif_string_valid := True
							
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
pre_action
--|#line 282 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 282")
end
	-- end of s_string, s_string_suffix
								fx_trace_local(0, <<"Rule match: 23 ==>", text, "<==">>)
								last_token := s_string_suffix
								last_any_value := text
								set_start_condition (INITIAL)
							
end
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
pre_action
--|#line 289 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 289")
end
	-- End of verbatim string
								fx_trace_local(0, <<"Rule: Verbatim string end ==>", text, "<==">>)
								if text_item(1) = '}' then
									last_token := s_str_right_brace
								else
									last_token := s_str_right_bracket
								end
								set_start_condition(INITIAL)
								last_any_value := text
							
end
else
if yy_act <= 35 then
if yy_act = 34 then
	yy_end := yy_start + yy_more_len + 1
	yy_column := yy_column + 1
	yy_position := yy_position + 1
pre_action
--|#line 305 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 305")
end

								last_token := s_str_gap_start
								set_start_condition(STR_GAP)
							
else
yy_set_column (1)
	yy_position := yy_position + yy_end - yy_start - yy_more_len
pre_action
--|#line 310 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 310")
end

								last_token := s_whitespace
							
end
else
	yy_end := yy_start + yy_more_len + 1
	yy_column := yy_column + 1
	yy_position := yy_position + 1
pre_action
--|#line 315 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 315")
end
	-- Transition from end of gap to start of infix / suffix continuation
								fx_trace_local(0, <<"Rule match 21b ==>", text, "<==">>)
								last_token := s_str_gap_end
								set_start_condition(IN_STR)
							
end
end
end
else
if yy_act <= 42 then
if yy_act <= 39 then
if yy_act <= 38 then
if yy_act = 37 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
pre_action
--|#line 328 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 328")
end
	--
								fx_trace_local(0, <<"Rule match 18a: extend string standard ==>", text, "<==">>)
								last_token := s_string_infix
								last_any_value := text
							
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
pre_action
--|#line 336 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 336")
end

								fx_trace_local(0, <<"Rule match 18a: extend string standard ==>", text, "<==">>)
								last_token := s_string_infix
								last_any_value := text
							
end
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
pre_action
--|#line 344 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 344")
end

								fx_trace_local(0, <<"Rule match 18a: extend string standard ==>", text, "<==">>)
								last_token := s_string_infix
								last_any_value := text
							
end
else
if yy_act <= 41 then
if yy_act = 40 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
pre_action
--|#line 351 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 351")
end

								fx_trace_local(0, <<"Rule match: 15 ==>", text, "<==">>)
								last_token := s_string_decimal_1
								last_any_value := text_substring(3,3)
							
else
	yy_column := yy_column + 5
	yy_position := yy_position + 5
pre_action
--|#line 357 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 357")
end

								fx_trace_local(0, <<"Rule match: 15 ==>", text, "<==">>)
							--	eif_buffer.append_string(text)
								last_token := s_string_decimal_2
								last_any_value := text_substring(3,4)
							
end
else
	yy_column := yy_column + 6
	yy_position := yy_position + 6
pre_action
--|#line 365 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 365")
end

								fx_trace_local(0, <<"Rule match: 16 ==>", text, "<==">>)
								if text_substring(3,5).to_integer > Platform.Maximum_character_code then
									last_token := s_raw_text
								else
									last_token := s_string_decimal_3
									last_any_value := text_substring(3,5)
								end
							
end
end
else
if yy_act <= 45 then
if yy_act <= 44 then
if yy_act = 43 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
pre_action
--|#line 376 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 376")
end

								fx_trace_local(0, <<"Rule match: 17 ==>", text, "<==">>)
								last_token := s_raw_text
								last_any_value := text
							
else
	yy_end := yy_start + yy_more_len + 2
	yy_column := yy_column + 2
	yy_position := yy_position + 2
pre_action
--|#line 383 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 383")
end

								fx_trace_local(0, <<"Rule match: 18 ==>", text, "<==">>)
								last_token := s_string_escaped
								last_any_value := text
							
end
else
	yy_end := yy_end - 1
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
pre_action
--|#line 390 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 390")
end
	-- erroneous end of string
								fx_trace_local(0, <<"Rule match: 20 ==>", text, "<==">>)
								last_token := s_raw_text
								last_any_value := text
								set_start_condition (INITIAL)
							
end
else
if yy_act = 46 then
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
pre_action
--|#line 398 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 398")
end

								last_token := s_raw_text
								last_any_value := text
								set_start_condition(IN_STR)
							
else
	yy_end := yy_end - 1
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
pre_action
--|#line 405 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 405")
end

								fx_trace_local(0, <<"Rule match: 22 ==>", text, "<==">>)
								last_token := s_raw_text
								last_any_value := text
								set_start_condition (INITIAL)
							
end
end
end
end
end
else
if yy_act <= 70 then
if yy_act <= 59 then
if yy_act <= 53 then
if yy_act <= 50 then
if yy_act <= 49 then
if yy_act = 48 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
pre_action
--|#line 414 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 414")
end
last_token := s_plus
else
	yy_column := yy_column + 1
	yy_position := yy_position + 1
pre_action
--|#line 415 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 415")
end
last_token := s_minus
end
else
	yy_column := yy_column + 1
	yy_position := yy_position + 1
pre_action
--|#line 416 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 416")
end
last_token := s_times
end
else
if yy_act <= 52 then
if yy_act = 51 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
pre_action
--|#line 417 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 417")
end
last_token := s_divide
else
	yy_column := yy_column + 1
	yy_position := yy_position + 1
pre_action
--|#line 418 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 418")
end
last_token := s_power
end
else
	yy_column := yy_column + 1
	yy_position := yy_position + 1
pre_action
--|#line 419 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 419")
end
last_token := s_equal
end
end
else
if yy_act <= 56 then
if yy_act <= 55 then
if yy_act = 54 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
pre_action
--|#line 420 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 420")
end
last_token := s_gt
else
	yy_column := yy_column + 1
	yy_position := yy_position + 1
pre_action
--|#line 421 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 421")
end
last_token := s_lt
end
else
	yy_column := yy_column + 1
	yy_position := yy_position + 1
pre_action
--|#line 422 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 422")
end
last_token := s_dot
end
else
if yy_act <= 58 then
if yy_act = 57 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
pre_action
--|#line 423 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 423")
end
last_token := s_semicolon
else
	yy_column := yy_column + 1
	yy_position := yy_position + 1
pre_action
--|#line 424 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 424")
end
last_token := s_comma
end
else
	yy_column := yy_column + 1
	yy_position := yy_position + 1
pre_action
--|#line 425 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 425")
end
last_token := s_colon
end
end
end
else
if yy_act <= 65 then
if yy_act <= 62 then
if yy_act <= 61 then
if yy_act = 60 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
pre_action
--|#line 426 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 426")
end
last_token := s_exclamation_mark
else
	yy_column := yy_column + 1
	yy_position := yy_position + 1
pre_action
--|#line 427 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 427")
end
last_token := s_left_parenthesis
end
else
	yy_column := yy_column + 1
	yy_position := yy_position + 1
pre_action
--|#line 428 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 428")
end
last_token := s_right_parenthesis
end
else
if yy_act <= 64 then
if yy_act = 63 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
pre_action
--|#line 429 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 429")
end
last_token := s_left_brace
else
	yy_column := yy_column + 1
	yy_position := yy_position + 1
pre_action
--|#line 430 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 430")
end
last_token := s_right_brace
end
else
	yy_column := yy_column + 1
	yy_position := yy_position + 1
pre_action
--|#line 431 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 431")
end
last_token := s_left_bracket
end
end
else
if yy_act <= 68 then
if yy_act <= 67 then
if yy_act = 66 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
pre_action
--|#line 432 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 432")
end
last_token := s_right_bracket
else
	yy_column := yy_column + 1
	yy_position := yy_position + 1
pre_action
--|#line 433 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 433")
end
last_token := s_dollar_sign
end
else
	yy_column := yy_column + 1
	yy_position := yy_position + 1
pre_action
--|#line 434 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 434")
end
last_token := s_query
end
else
if yy_act = 69 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
pre_action
--|#line 435 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 435")
end
last_token := s_tilde
else
	yy_column := yy_column + 2
	yy_position := yy_position + 2
pre_action
--|#line 437 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 437")
end
last_token := s_div
end
end
end
end
else
if yy_act <= 82 then
if yy_act <= 76 then
if yy_act <= 73 then
if yy_act <= 72 then
if yy_act = 71 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
pre_action
--|#line 438 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 438")
end
last_token := s_mod
else
	yy_column := yy_column + 2
	yy_position := yy_position + 2
pre_action
--|#line 439 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 439")
end
last_token := s_not_equal
end
else
	yy_column := yy_column + 2
	yy_position := yy_position + 2
pre_action
--|#line 440 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 440")
end
last_token := s_ge
end
else
if yy_act <= 75 then
if yy_act = 74 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
pre_action
--|#line 441 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 441")
end
last_token := s_le
else
	yy_column := yy_column + 2
	yy_position := yy_position + 2
pre_action
--|#line 442 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 442")
end
last_token := s_bangbang
end
else
	yy_column := yy_column + 2
	yy_position := yy_position + 2
pre_action
--|#line 443 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 443")
end
last_token := s_arrow
end
end
else
if yy_act <= 79 then
if yy_act <= 78 then
if yy_act = 77 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
pre_action
--|#line 444 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 444")
end
last_token := s_dot_dot
else
	yy_column := yy_column + 2
	yy_position := yy_position + 2
pre_action
--|#line 445 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 445")
end
last_token := s_left_array
end
else
	yy_column := yy_column + 2
	yy_position := yy_position + 2
pre_action
--|#line 446 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 446")
end
last_token := s_right_array
end
else
if yy_act <= 81 then
if yy_act = 80 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
pre_action
--|#line 447 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 447")
end
last_token := s_assign
else
	yy_column := yy_column + 2
	yy_position := yy_position + 2
pre_action
--|#line 448 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 448")
end
last_token := s_reverse
end
else
	yy_column := yy_column + 5
	yy_position := yy_position + 5
pre_action
--|#line 453 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 453")
end
last_token := s_alias
end
end
end
else
if yy_act <= 88 then
if yy_act <= 85 then
if yy_act <= 84 then
if yy_act = 83 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
pre_action
--|#line 454 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 454")
end
last_token := s_all
else
	yy_column := yy_column + 3
	yy_position := yy_position + 3
pre_action
--|#line 455 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 455")
end
last_token := s_and
end
else
	yy_column := yy_column + 2
	yy_position := yy_position + 2
pre_action
--|#line 456 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 456")
end
last_token := s_as
end
else
if yy_act <= 87 then
if yy_act = 86 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
pre_action
--|#line 457 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 457")
end
last_token := s_bit		-- 
else
	yy_column := yy_column + 5
	yy_position := yy_position + 5
pre_action
--|#line 458 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 458")
end
last_token := s_check
end
else
	yy_column := yy_column + 5
	yy_position := yy_position + 5
pre_action
--|#line 459 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 459")
end
last_token := s_class
end
end
else
if yy_act <= 91 then
if yy_act <= 90 then
if yy_act = 89 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
pre_action
--|#line 460 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 460")
end
last_token := s_create
else
	yy_column := yy_column + 8
	yy_position := yy_position + 8
pre_action
--|#line 461 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 461")
end
last_token := s_creation
end
else
	yy_column := yy_column + 7
	yy_position := yy_position + 7
pre_action
--|#line 462 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 462")
end
last_token := s_current
end
else
if yy_act = 92 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
pre_action
--|#line 463 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 463")
end
last_token := s_debug
else
	yy_column := yy_column + 8
	yy_position := yy_position + 8
pre_action
--|#line 464 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 464")
end
last_token := s_deferred
end
end
end
end
end
end
else
if yy_act <= 139 then
if yy_act <= 116 then
if yy_act <= 105 then
if yy_act <= 99 then
if yy_act <= 96 then
if yy_act <= 95 then
if yy_act = 94 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
pre_action
--|#line 465 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 465")
end
last_token := s_do
else
	yy_column := yy_column + 4
	yy_position := yy_position + 4
pre_action
--|#line 466 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 466")
end
last_token := s_else
end
else
	yy_column := yy_column + 6
	yy_position := yy_position + 6
pre_action
--|#line 467 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 467")
end
last_token := s_elseif
end
else
if yy_act <= 98 then
if yy_act = 97 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
pre_action
--|#line 468 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 468")
end
last_token := s_end
else
	yy_column := yy_column + 6
	yy_position := yy_position + 6
pre_action
--|#line 469 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 469")
end
last_token := s_ensure
end
else
	yy_column := yy_column + 8
	yy_position := yy_position + 8
pre_action
--|#line 470 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 470")
end
last_token := s_expanded
end
end
else
if yy_act <= 102 then
if yy_act <= 101 then
if yy_act = 100 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
pre_action
--|#line 471 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 471")
end
last_token := s_export
else
	yy_column := yy_column + 8
	yy_position := yy_position + 8
pre_action
--|#line 472 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 472")
end
last_token := s_external
end
else
	yy_column := yy_column + 5
	yy_position := yy_position + 5
pre_action
--|#line 473 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 473")
end
last_token := s_false
end
else
if yy_act <= 104 then
if yy_act = 103 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
pre_action
--|#line 474 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 474")
end
last_token := s_feature
else
	yy_column := yy_column + 4
	yy_position := yy_position + 4
pre_action
--|#line 475 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 475")
end
last_token := s_from
end
else
	yy_column := yy_column + 6
	yy_position := yy_position + 6
pre_action
--|#line 476 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 476")
end
last_token := s_frozen
end
end
end
else
if yy_act <= 111 then
if yy_act <= 108 then
if yy_act <= 107 then
if yy_act = 106 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
pre_action
--|#line 477 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 477")
end
last_token := s_if
else
	yy_column := yy_column + 7
	yy_position := yy_position + 7
pre_action
--|#line 478 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 478")
end
last_token := s_implies
end
else
	yy_column := yy_column + 8
	yy_position := yy_position + 8
pre_action
--|#line 479 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 479")
end
last_token := s_indexing
end
else
if yy_act <= 110 then
if yy_act = 109 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
pre_action
--|#line 480 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 480")
end

										is_operator := True
										last_token := s_infix
									
else
	yy_column := yy_column + 7
	yy_position := yy_position + 7
pre_action
--|#line 484 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 484")
end
last_token := s_inherit
end
else
	yy_column := yy_column + 7
	yy_position := yy_position + 7
pre_action
--|#line 485 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 485")
end
last_token := s_inspect
end
end
else
if yy_act <= 114 then
if yy_act <= 113 then
if yy_act = 112 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
pre_action
--|#line 486 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 486")
end
last_token := s_invariant
else
	yy_column := yy_column + 2
	yy_position := yy_position + 2
pre_action
--|#line 487 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 487")
end
last_token := s_is
end
else
	yy_column := yy_column + 4
	yy_position := yy_position + 4
pre_action
--|#line 488 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 488")
end
last_token := s_like
end
else
if yy_act = 115 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
pre_action
--|#line 489 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 489")
end
last_token := s_local
else
	yy_column := yy_column + 4
	yy_position := yy_position + 4
pre_action
--|#line 490 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 490")
end
last_token := s_loop
end
end
end
end
else
if yy_act <= 128 then
if yy_act <= 122 then
if yy_act <= 119 then
if yy_act <= 118 then
if yy_act = 117 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
pre_action
--|#line 491 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 491")
end
last_token := s_not
else
	yy_column := yy_column + 8
	yy_position := yy_position + 8
pre_action
--|#line 492 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 492")
end
last_token := s_obsolete
end
else
	yy_column := yy_column + 3
	yy_position := yy_position + 3
pre_action
--|#line 493 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 493")
end
last_token := s_old
end
else
if yy_act <= 121 then
if yy_act = 120 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
pre_action
--|#line 494 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 494")
end
last_token := s_once
else
	yy_column := yy_column + 2
	yy_position := yy_position + 2
pre_action
--|#line 495 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 495")
end
last_token := s_or
end
else
	yy_column := yy_column + 9
	yy_position := yy_position + 9
pre_action
--|#line 496 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 496")
end
last_token := s_precursor
end
end
else
if yy_act <= 125 then
if yy_act <= 124 then
if yy_act = 123 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
pre_action
--|#line 497 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 497")
end

										is_operator := True
										last_token := s_prefix
									
else
	yy_column := yy_column + 8
	yy_position := yy_position + 8
pre_action
--|#line 501 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 501")
end
last_token := s_redefine
end
else
	yy_column := yy_column + 6
	yy_position := yy_position + 6
pre_action
--|#line 502 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 502")
end
last_token := s_rename
end
else
if yy_act <= 127 then
if yy_act = 126 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
pre_action
--|#line 503 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 503")
end
last_token := s_require
else
	yy_column := yy_column + 6
	yy_position := yy_position + 6
pre_action
--|#line 504 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 504")
end
last_token := s_rescue
end
else
	yy_column := yy_column + 6
	yy_position := yy_position + 6
pre_action
--|#line 505 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 505")
end
last_token := s_result
end
end
end
else
if yy_act <= 134 then
if yy_act <= 131 then
if yy_act <= 130 then
if yy_act = 129 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
pre_action
--|#line 506 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 506")
end
last_token := s_retry
else
	yy_column := yy_column + 6
	yy_position := yy_position + 6
pre_action
--|#line 507 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 507")
end
last_token := s_select
end
else
	yy_column := yy_column + 8
	yy_position := yy_position + 8
pre_action
--|#line 508 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 508")
end
last_token := s_separate
end
else
if yy_act <= 133 then
if yy_act = 132 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
pre_action
--|#line 509 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 509")
end
last_token := s_strip
else
	yy_column := yy_column + 4
	yy_position := yy_position + 4
pre_action
--|#line 510 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 510")
end
last_token := s_then
end
else
	yy_column := yy_column + 4
	yy_position := yy_position + 4
pre_action
--|#line 511 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 511")
end
last_token := s_true
end
end
else
if yy_act <= 137 then
if yy_act <= 136 then
if yy_act = 135 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
pre_action
--|#line 512 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 512")
end
last_token := s_undefine
else
	yy_column := yy_column + 6
	yy_position := yy_position + 6
pre_action
--|#line 513 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 513")
end
last_token := s_unique
end
else
	yy_column := yy_column + 5
	yy_position := yy_position + 5
pre_action
--|#line 514 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 514")
end
last_token := s_until
end
else
if yy_act = 138 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
pre_action
--|#line 515 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 515")
end
last_token := s_variant
else
	yy_column := yy_column + 4
	yy_position := yy_position + 4
pre_action
--|#line 516 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 516")
end
last_token := s_when
end
end
end
end
end
else
if yy_act <= 162 then
if yy_act <= 151 then
if yy_act <= 145 then
if yy_act <= 142 then
if yy_act <= 141 then
if yy_act = 140 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
pre_action
--|#line 517 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 517")
end
last_token := s_xor
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
pre_action
--|#line 522 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 522")
end

				fx_trace_local(0, <<"Rule match: 6 ==>", text, "<==">>)
				last_token := s_identifier
				last_any_value := text
			
end
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
pre_action
--|#line 531 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 531")
end

				fx_trace_local(0, <<"Rule match: 7 ==>", text, "<==">>)
				last_token := s_freeop
				last_any_value := text
			
end
else
if yy_act <= 144 then
if yy_act = 143 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
pre_action
--|#line 543 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 543")
end
last_token := s_character; last_any_value := text
else
	yy_column := yy_column + 3
	yy_position := yy_position + 3
pre_action
--|#line 546 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 546")
end
last_token := s_character_escaped; last_any_value := text
end
else
	yy_column := yy_column + 4
	yy_position := yy_position + 4
pre_action
--|#line 547 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 547")
end
last_token := s_character_escaped; last_any_value := text
end
end
else
if yy_act <= 148 then
if yy_act <= 147 then
if yy_act = 146 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
pre_action
--|#line 548 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 548")
end
last_token := s_character_escaped; last_any_value := text
else
	yy_column := yy_column + 4
	yy_position := yy_position + 4
pre_action
--|#line 549 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 549")
end
last_token := s_character_escaped; last_any_value := text
end
else
	yy_column := yy_column + 4
	yy_position := yy_position + 4
pre_action
--|#line 550 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 550")
end
last_token := s_character_escaped; last_any_value := text
end
else
if yy_act <= 150 then
if yy_act = 149 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
pre_action
--|#line 551 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 551")
end
last_token := s_character_escaped; last_any_value := text
else
	yy_column := yy_column + 4
	yy_position := yy_position + 4
pre_action
--|#line 552 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 552")
end
last_token := s_character_escaped; last_any_value := text
end
else
	yy_column := yy_column + 4
	yy_position := yy_position + 4
pre_action
--|#line 553 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 553")
end
last_token := s_character_escaped; last_any_value := text
end
end
end
else
if yy_act <= 157 then
if yy_act <= 154 then
if yy_act <= 153 then
if yy_act = 152 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
pre_action
--|#line 554 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 554")
end
last_token := s_character_escaped; last_any_value := text
else
	yy_column := yy_column + 4
	yy_position := yy_position + 4
pre_action
--|#line 555 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 555")
end
last_token := s_character_escaped; last_any_value := text
end
else
	yy_column := yy_column + 4
	yy_position := yy_position + 4
pre_action
--|#line 556 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 556")
end
last_token := s_character_escaped; last_any_value := text
end
else
if yy_act <= 156 then
if yy_act = 155 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
pre_action
--|#line 557 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 557")
end
last_token := s_character_escaped; last_any_value := text
else
	yy_column := yy_column + 4
	yy_position := yy_position + 4
pre_action
--|#line 558 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 558")
end
last_token := s_character_escaped; last_any_value := text
end
else
	yy_column := yy_column + 4
	yy_position := yy_position + 4
pre_action
--|#line 559 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 559")
end
last_token := s_character_escaped; last_any_value := text
end
end
else
if yy_act <= 160 then
if yy_act <= 159 then
if yy_act = 158 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
pre_action
--|#line 560 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 560")
end
last_token := s_character_escaped; last_any_value := text
else
	yy_column := yy_column + 4
	yy_position := yy_position + 4
pre_action
--|#line 561 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 561")
end
last_token := s_character_escaped; last_any_value := text
end
else
	yy_column := yy_column + 4
	yy_position := yy_position + 4
pre_action
--|#line 562 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 562")
end
last_token := s_character_escaped; last_any_value := text
end
else
if yy_act = 161 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
pre_action
--|#line 563 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 563")
end
last_token := s_character_escaped; last_any_value := text
else
	yy_column := yy_column + 4
	yy_position := yy_position + 4
pre_action
--|#line 564 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 564")
end
last_token := s_character_escaped; last_any_value := text
end
end
end
end
else
if yy_act <= 174 then
if yy_act <= 168 then
if yy_act <= 165 then
if yy_act <= 164 then
if yy_act = 163 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
pre_action
--|#line 565 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 565")
end
last_token := s_character_escaped; last_any_value := text
else
	yy_column := yy_column + 4
	yy_position := yy_position + 4
pre_action
--|#line 566 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 566")
end
last_token := s_character_escaped; last_any_value := text
end
else
	yy_column := yy_column + 4
	yy_position := yy_position + 4
pre_action
--|#line 567 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 567")
end
last_token := s_character_escaped; last_any_value := text
end
else
if yy_act <= 167 then
if yy_act = 166 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
pre_action
--|#line 569 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 569")
end
	-- '%/d/'
						fx_trace_local(0, <<"Rule match: 8 ==>", text, "<==">>)
					--	code_ := text_substring (4, text_count - 2).to_integer
						last_token := s_character_decimal_1
						last_any_value := text_substring(4,4); --	INTEGER_.to_character (code_)	-- TEMP
					
else
	yy_column := yy_column + 7
	yy_position := yy_position + 7
pre_action
--|#line 575 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 575")
end
	-- '%/dd/'
						fx_trace_local(0, <<"Rule match: 9 ==>", text, "<==">>)
					--	code_ := text_substring (4, text_count - 2).to_integer
						last_token := s_character_decimal_2
						last_any_value := text_substring(4,5); --	INTEGER_.to_character (code_)	-- TEMP
					
end
else
	yy_column := yy_column + 8
	yy_position := yy_position + 8
pre_action
--|#line 581 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 581")
end
	-- '%/ddd/'
						fx_trace_local(0, <<"Rule match: 10 ==>", text, "<==">>)
					--	code_ := text_substring (4, text_count - 2).to_integer
						last_token := s_character_decimal_3
						last_any_value := text_substring(4,6); --	INTEGER_.to_character (code_)	-- TEMP
					
end
end
else
if yy_act <= 171 then
if yy_act <= 170 then
if yy_act = 169 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
pre_action
--|#line 590 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 590")
end

						fx_trace_local(0, <<"Rule match: 11 ==>", text, "<==">>)
						last_token := s_character_escaped;
						last_any_value := text;	-- WAS text_item (3)
					
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
pre_action
--|#line 596 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 596")
end

							fx_trace_local(0, <<"Rule match: 12 ==>", text, "<==">>)
							last_token := s_raw_text	-- Catch-all rules (no backing up)
						
end
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
pre_action
--|#line 597 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 597")
end

							fx_trace_local(0, <<"Rule match: 12 ==>", text, "<==">>)
							last_token := s_raw_text	-- Catch-all rules (no backing up)
						
end
else
if yy_act <= 173 then
if yy_act = 172 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
pre_action
--|#line 605 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 605")
end
last_token := s_bit_sequence; last_any_value := text
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
pre_action
--|#line 610 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 610")
end
	-- Hexadecimal integer
						last_token := s_integer; last_any_value := text
					
end
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
pre_action
--|#line 614 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 614")
end

						last_token := s_integer
						last_any_value := text
					
end
end
end
else
if yy_act <= 180 then
if yy_act <= 177 then
if yy_act <= 176 then
if yy_act = 175 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
pre_action
--|#line 618 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 618")
end
last_token := s_integer; last_any_value := text
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
pre_action
--|#line 619 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 619")
end
last_token := s_raw_text	-- Catch-all rule (no backing up)
end
else
	yy_end := yy_end - 1
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
pre_action
--|#line 624 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 624")
end

						last_token := s_real
						last_any_value := text
					
end
else
if yy_act <= 179 then
if yy_act = 178 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
pre_action
--|#line 625 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 625")
end

						last_token := s_real
						last_any_value := text
					
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
pre_action
--|#line 626 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 626")
end

						last_token := s_real
						last_any_value := text
					
end
else
	yy_end := yy_end - 1
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
pre_action
--|#line 630 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 630")
end

						last_token := s_real
						last_any_value := text
					
end
end
else
if yy_act <= 183 then
if yy_act <= 182 then
if yy_act = 181 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
pre_action
--|#line 631 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 631")
end

						last_token := s_real
						last_any_value := text
					
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
pre_action
--|#line 632 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 632")
end

						last_token := s_real
						last_any_value := text
					
end
else
yy_set_line_column
	yy_position := yy_position + 1
pre_action
--|#line 651 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 651")
end
	-- Catch-all rules (no backing up)
										fx_trace_local(0, <<"Rule match: 24a ==>", text, "<==">>)
									last_token := s_raw_text
									last_any_value := text
									set_start_condition (INITIAL)
								
end
else
if yy_act = 184 then
yy_set_line_column
	yy_position := yy_position + 1
pre_action
--|#line 658 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 658")
end
	--### Should accumulate raw_text here, and flush out in post_action ###
					--#####################################################################
					fx_trace(0, << "Rule match: 25 ==>", text, "<== line/col: ", line.out, "/", (column+eif_tab_offset).out >>)
						-- Note position is probably wrong, after text rather than before
					last_token := s_raw_text
					last_any_value := text
					if not file_name_reported then
						file_name_reported := True
						fx_trace(0, << once "Scanning error in: %"", file_name, once "%"" >>)
					end
					fx_trace(0, <<" [default single char rule ??]: ">>)
				
else
yy_set_line_column
	yy_position := yy_position + 1
pre_action
--|#line 0 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 0")
end
last_token := yyError_token
fatal_error ("scanner jammed")
end
end
end
end
end
end
end
			post_action
		end

	yy_execute_eof_action (yy_sc: INTEGER)
			-- Execute EOF semantic action.
		do
			inspect yy_sc
when 0, 1, 2, 3, 4 then
--|#line 0 "edp_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'edp_eiffel_scanner.l' at line 0")
end
	-- End of file
					last_token := s_eof
					terminate
				
			else
				terminate
			end
			post_eof_action
		end

feature {NONE} -- Table templates

	yy_nxt_template: SPECIAL [INTEGER]
		once
			Result := yy_fixed_array (<<
			    0,   12,   13,   14,   15,   16,   17,   18,   19,   20,
			   12,   21,   22,   23,   24,   25,   26,   27,   28,   29,
			   30,   31,   32,   33,   34,   35,   36,   37,   38,   39,
			   40,   41,   42,   43,   44,   45,   45,   46,   45,   45,
			   47,   45,   48,   49,   50,   45,   51,   52,   53,   54,
			   55,   56,   57,   45,   45,   58,   59,   60,   61,   12,
			   39,   40,   41,   42,   44,   45,   47,   48,   45,   51,
			   52,   53,   54,   55,   62,   63,   64,   66,   67,   68,
			   69,  174,   70,  120,  121,   71,   66,   67,   68,   69,
			  463,   70,  135,  136,   71,   73,   74,   75,   76,   73,

			   74,   75,   76,   77,  122,  126,  174,   77,   79,   80,
			   81,   82,  127,   83,  123,  463,   84,   79,   80,   81,
			   82,  149,   83,  137,  138,   84,  175,   88,   80,   89,
			   90,  150,   91,  375,  161,   84,   88,   80,   89,   90,
			  162,   91,  547,  124,   84,  125,  125,  125,  375,  154,
			  318,  168,  128,  155,  129,  129,  130,  175,  128,  176,
			  129,  129,  130,   85,  131,  128,  156,  130,  130,  130,
			  131,  151,   85,  152,  168,  375,  318,  141,  194,  142,
			  154,   86,   92,  153,  143,  195,  132,  217,  176,  156,
			   86,   92,  220,  133,  211,  131,  221,  151,  152,  133,

			   93,  131,  305,  141,  142,  308,  133,  143,  180,   93,
			  100,  101,  181,  102,  170,  182,  306,  103,  104,  220,
			  105,  145,  106,  221,  310,  146,  662,  172,  107,  171,
			  108,  147,  109,  305,  148,  157,  308,  173,  492,  306,
			  110,  218,  158,  159,  485,  111,  112,  310,  160,  520,
			  145,  146,  171,  319,  147,  113,  172,  148,  114,  115,
			  173,  116,  164,  109,  332,  157,  197,  204,  159,  313,
			  111,  160,  165,  195,  166,  183,  180,  117,  167,  520,
			  181,  180,  184,  182,  319,  181,  333,  180,  182,  185,
			  233,  181,  313,  164,  182,  332,  553,  227,  165,  166,

			  554,  167,  188,  189,  190,  188,  196,  197,  198,  199,
			  201,  202,  340,  201,  195,  314,  341,  333,  203,  192,
			  199,  197,  198,  205,  330,  209,  214,  209,  195,  210,
			  315,  210,  211,  209,  211,  209,  215,  222,  340,  210,
			  211,  209,  211,  216,  331,  210,  314,  330,  211,  662,
			  662,  662,  662,  315,  225,  230,  225,  649,  226,  648,
			  226,  227,  234,  227,  225,  231,  192,  331,  226,  225,
			  225,  227,  232,  236,  226,  342,  227,  227,  238,  212,
			  328,  212,  239,  425,  238,  240,  238,  223,  244,  212,
			  245,  240,  329,  240,  344,  212,  647,  213,  342,  213,

			  646,   99,  238,   99,   99,  645,  243,  213,  228,  240,
			  228,  328,  238,  213,  425,  426,  246,  344,  228,  240,
			  301,  301,  301,  238,  228,  238,  229,  247,  229,  249,
			  240,  238,  240,  238,  428,  251,  229,  239,  240,  248,
			  240,  237,  229,  238,  529,  238,  426,  239,  250,  239,
			  240,  238,  240,  238,  252,  239,  643,  239,  240,  302,
			  240,  259,  260,  238,  259,  428,  100,  239,  348,  261,
			  240,  238,  253,  303,  529,  263,  304,  626,  240,  264,
			  265,  254,  264,  618,  100,  255,  350,  261,  292,  292,
			  292,  348,  316,  257,  256,  439,  317,  253,  296,  296,

			  296,  293,  304,  128,  557,  298,  298,  299,  440,  350,
			  609,  297,  355,  355,  355,  131,  262,  256,  269,  317,
			  607,  270,  271,  272,  273,  606,  427,  294,  604,  128,
			  274,  299,  299,  299,  557,  311,  275,  441,  276,  312,
			  277,  278,  279,  280,  133,  281,  131,  282,  194,  427,
			  322,  283,  323,  284,  324,  195,  285,  286,  287,  288,
			  289,  290,  335,  441,  516,  325,  311,  194,  326,  312,
			  133,  345,  336,  197,  195,  337,  346,  338,  339,  358,
			  195,  322,  323,  324,  587,  180,  203,  347,  325,  181,
			  516,  326,  182,  335,  416,  416,  416,  336,  337,  580,

			  338,  339,  345,  183,  180,  180,  184,  359,  181,  181,
			  347,  182,  182,  180,  195,  185,  579,  181,  446,  575,
			  182,  188,  189,  190,  188,  196,  197,  198,  199,  201,
			  358,  573,  201,  195,  415,  415,  415,  203,  199,  197,
			  198,  199,  201,  358,  217,  201,  195,  194,  204,  446,
			  203,  211,  366,  572,  195,  199,  197,  198,  205,  367,
			  209,  209,  209,  195,  210,  362,  222,  211,  211,  211,
			  214,  209,  209,  215,  571,  210,  210,  429,  211,  211,
			  209,  217,  216,  569,  210,  211,  209,  211,  211,  568,
			  210,  448,  209,  211,  430,  233,  211,  225,  218,  211,

			  429,  226,  227,  225,  227,  225,  368,  236,  433,  369,
			  227,  233,  227,  469,  212,  227,  223,  430,  227,  230,
			  225,  371,  448,  517,  226,  212,  212,  227,  372,  225,
			  231,  433,  213,  226,  212,  225,  227,  232,  469,  226,
			  223,  225,  227,  213,  213,  226,  225,  566,  227,  517,
			  227,  228,  213,  227,  238,  238,  238,  565,  376,  377,
			  378,  240,  240,  240,  238,  455,  238,  234,  239,  229,
			  239,  240,  238,  240,  228,  237,  239,  238,  238,  240,
			  382,  239,  383,  228,  240,  240,  437,  385,  390,  228,
			  461,  386,  229,  373,  385,  379,  455,  396,  396,  396,

			  564,  229,  524,  259,  387,  380,  259,  229,  386,  437,
			  434,  385,  238,  237,  558,  438,  388,  381,  538,  240,
			  384,  461,  264,  389,  435,  264,  379,  386,  524,  480,
			  385,  413,  413,  413,  375,  417,  417,  417,  438,  456,
			  381,  434,  194,  384,  293,  414,  459,  414,  418,  195,
			  415,  415,  415,  420,  452,  420,  375,  453,  421,  421,
			  421,  128,  456,  422,  422,  423,  424,  424,  424,  459,
			  294,  466,  457,  131,  419,  128,  359,  423,  423,  423,
			  302,  302,  302,  195,  366,  452,  371,  453,  375,  528,
			  458,  367,  525,  372,  466,  470,  471,  471,  471,  486,

			  486,  486,  133,  457,  131,  302,  504,  366,  371,  522,
			  521,  367,  372,  458,  367,  372,  133,  238,  238,  302,
			  472,  239,  473,  238,  240,  240,  531,  475,  238,  238,
			  240,  504,  477,  239,  495,  240,  240,  497,  368,  481,
			  482,  482,  482,  483,  483,  483,  484,  484,  484,  487,
			  487,  487,  531,  519,  474,  498,  293,  495,  373,  476,
			  497,  488,  418,  488,  514,  512,  489,  489,  489,  490,
			  490,  490,  421,  421,  421,  491,  491,  491,  498,  526,
			  474,  501,  294,  503,  505,  485,  506,  493,  419,  422,
			  422,  423,  493,  508,  423,  423,  423,  513,  515,  131,

			  494,  494,  494,  518,  501,  532,  503,  505,  523,  506,
			  526,  527,  530,  511,  492,  555,  508,  543,  543,  543,
			  513,  515,  533,  534,  534,  534,  518,  510,  302,  509,
			  131,  523,  507,  302,  527,  530,  532,  238,  238,  302,
			  555,  239,  239,  238,  240,  240,  502,  239,  559,  500,
			  240,  539,  540,  540,  540,  483,  483,  483,  542,  542,
			  542,  544,  544,  544,  545,  545,  545,  561,  541,  489,
			  489,  489,  536,  546,  546,  546,  556,  418,  567,  559,
			  537,  560,  535,  548,  548,  548,  549,  549,  549,  550,
			  550,  550,  561,  562,  545,  545,  545,  485,  552,  556,

			  302,  302,  302,  419,  560,  535,  537,  551,  563,  567,
			  578,  570,  547,  574,  576,  577,  562,  581,  582,  583,
			  583,  583,  238,  238,  238,  492,  239,  239,  239,  240,
			  240,  240,  499,  563,  570,  496,  574,  576,  577,  133,
			  593,  578,  581,  588,  589,  589,  589,  591,  591,  591,
			  611,  478,  590,  585,  590,  584,  375,  591,  591,  591,
			  592,  592,  592,  545,  545,  545,  294,  478,  586,  595,
			  595,  595,  596,  596,  596,  611,  594,  597,  597,  597,
			  598,  598,  598,  605,  584,  608,  485,  599,  599,  599,
			  600,  586,  600,  617,  610,  598,  598,  598,  602,  602,

			  602,  612,  613,  614,  615,  616,  605,  619,  547,  621,
			  620,  603,  622,  583,  583,  583,  608,  610,  617,  492,
			  480,  658,  238,  478,  612,  613,  239,  615,  616,  240,
			  619,  375,  621,  238,  614,  620,  634,  239,  238,  642,
			  240,  640,  239,  641,  658,  240,  627,  589,  589,  589,
			  375,  639,  623,  591,  591,  591,  591,  591,  591,  628,
			  628,  628,  419,  375,  629,  642,  629,  375,  625,  630,
			  630,  630,  640,  631,  641,  631,  639,  624,  632,  632,
			  632,  632,  632,  632,  633,  633,  633,  598,  598,  598,
			  635,  635,  635,  598,  598,  598,  636,  636,  636,  637,

			  624,  637,  644,  238,  638,  638,  638,  239,  238,  634,
			  240,  375,  651,  371,  238,  240,  371,  366,  652,  364,
			  547,  240,  630,  630,  630,  366,  361,  644,  357,  653,
			  653,  653,  632,  632,  632,  419,  632,  632,  632,  654,
			  654,  654,  650,  655,  352,  655,  659,  468,  656,  656,
			  656,  597,  597,  597,  638,  638,  638,  657,  657,  657,
			  628,  628,  628,  467,  634,  465,  238,  650,  485,  659,
			  660,  464,  462,  240,  656,  656,  656,  661,  661,  661,
			  635,  635,  635,  654,  654,  654,  460,  300,  300,  454,
			  419,  300,  300,  300,  451,  450,  492,  449,  447,  485,

			  445,  444,  443,  442,  436,  432,  431,  412,  411,  410,
			  409,  408,  407,  406,  405,  404,  547,  403,  402,  492,
			  401,  400,  547,   65,   65,   65,   65,   65,   65,   65,
			   65,   65,   65,   65,   65,   65,   65,   65,   65,   65,
			   65,   65,   65,   65,   65,   65,   65,   65,   72,   72,
			   72,   72,   72,   72,   72,   72,   72,   72,   72,   72,
			   72,   72,   72,   72,   72,   72,   72,   72,   72,   72,
			   72,   72,   72,   78,   78,   78,   78,   78,   78,   78,
			   78,   78,   78,   78,   78,   78,   78,   78,   78,   78,
			   78,   78,   78,   78,   78,   78,   78,   78,   87,   87,

			   87,   87,   87,   87,   87,   87,   87,   87,   87,   87,
			   87,   87,   87,   87,   87,   87,   87,   87,   87,   87,
			   87,   87,   87,   99,   99,  399,   99,   99,   99,   99,
			   99,   99,   99,   99,   99,   99,   99,   99,   99,   99,
			   99,   99,   99,   99,   99,   99,   99,   99,  118,  398,
			  397,  395,  394,  393,  118,  118,  118,  118,  118,  118,
			  118,  118,  118,  118,  118,  118,  118,  118,  118,  118,
			  118,  118,  118,  119,  119,  392,  119,  119,  119,  119,
			  119,  119,  119,  119,  119,  119,  119,  119,  119,  119,
			  119,  119,  119,  119,  119,  119,  119,  119,  140,  140,

			  391,  390,  140,  140,  140,  140,  140,  140,  140,  140,
			  140,  140,  140,  140,  179,  179,  179,  179,  179,  179,
			  179,  179,  179,  179,  179,  179,  179,  179,  179,  179,
			  179,  179,  179,  179,  179,  179,  179,  179,  179,  186,
			  186,  186,  186,  186,  186,  186,  186,  186,  186,  186,
			  186,  186,  186,  186,  186,  186,  186,  186,  186,  186,
			  186,  186,  186,  186,  191,  191,  191,  191,  191,  191,
			  191,  375,  375,  375,  191,  191,  191,  191,  191,  375,
			  191,  191,  191,  191,  191,  193,  193,  193,  193,  193,
			  193,  193,  193,  193,  193,  193,  193,  193,  193,  193,

			  193,  193,  193,  193,  193,  193,  193,  193,  193,  193,
			  200,  200,  200,  200,  200,  200,  200,  200,  200,  200,
			  200,  200,  200,  200,  200,  200,  200,  200,  200,  200,
			  200,  200,  200,  200,  200,  206,  206,  206,  206,  206,
			  206,  206,  206,  206,  206,  206,  206,  206,  206,  206,
			  206,  206,  206,  206,  206,  206,  206,  206,  206,  206,
			  208,  208,  208,  208,  208,  208,  208,  208,  208,  208,
			  208,  208,  208,  208,  208,  208,  208,  208,  208,  208,
			  208,  208,  208,  208,  208,  210,  210,  210,  210,  210,
			  210,  210,  210,  210,  210,  210,  210,  210,  210,  210,

			  210,  210,  210,  210,  210,  210,  210,  210,  210,  210,
			  219,  219,  219,  219,  219,  375,  219,  219,  219,  219,
			  219,  219,  219,  219,  219,  219,  219,  219,  219,  219,
			  219,  219,  219,  219,  219,  224,  224,  224,  224,  224,
			  224,  224,  224,  224,  224,  224,  224,  224,  224,  224,
			  224,  224,  224,  224,  224,  224,  224,  224,  224,  224,
			  226,  226,  226,  226,  226,  226,  226,  226,  226,  226,
			  226,  226,  226,  226,  226,  226,  226,  226,  226,  226,
			  226,  226,  226,  226,  226,  235,  235,  235,  235,  235,
			  235,  235,  235,  235,  235,  235,  235,  235,  235,  235,

			  235,  235,  235,  235,  235,  235,  235,  235,  235,  235,
			  241,  241,  241,  241,  241,  241,  241,  241,  241,  241,
			  241,  241,  241,  241,  241,  241,  241,  241,  241,  241,
			  241,  241,  241,  241,  241,  101,  101,  101,  101,  101,
			  101,  101,  101,  101,  101,  101,  101,  101,  101,  101,
			  101,  101,  101,  101,  101,  101,  101,  101,  101,  101,
			  258,  258,  258,  258,  258,  258,  258,  258,  258,  258,
			  258,  258,  258,  258,  258,  258,  258,  258,  258,  258,
			  258,  258,  258,  258,  258,  266,  266,  375,  266,  266,
			  266,  266,  266,  266,  266,  266,  266,  266,  266,  266,

			  266,  266,  266,  266,  266,  266,  266,  266,  266,  266,
			  268,  268,  375,  268,  268,  268,  268,  268,  268,  268,
			  268,  268,  268,  268,  268,  268,  268,  268,  268,  268,
			  268,  268,  268,  268,  268,  122,  122,  375,  122,  122,
			  122,  122,  122,  122,  122,  122,  122,  122,  122,  122,
			  122,  122,  122,  122,  122,  122,  122,  122,  122,  122,
			  295,  295,  295,  295,  295,  295,  295,  295,  242,  295,
			  295,  295,  295,  295,  295,  295,  295,  295,  295,  295,
			  295,  295,  295,  295,  295,  351,  351,  351,  351,  351,
			  351,  351,  351,  351,  351,  351,  351,  351,  351,  351,

			  351,  351,  351,  351,  351,  351,  351,  351,  351,  351,
			  182,  182,  182,  182,  182,  182,  182,  182,  182,  182,
			  182,  182,  182,  182,  182,  182,  182,  182,  182,  182,
			  182,  182,  182,  182,  182,  191,  191,  191,  191,  191,
			  191,  191,  191,  191,  191,  191,  191,  191,  191,  191,
			  191,  191,  191,  191,  191,  191,  191,  191,  191,  191,
			  356,  356,  356,  356,  356,  356,  356,  356,  356,  356,
			  356,  356,  356,  356,  356,  356,  356,  356,  356,  356,
			  356,  356,  356,  356,  356,  360,  360,  360,  360,  360,
			  360,  360,  360,  360,  360,  360,  360,  360,  360,  360,

			  360,  360,  360,  360,  360,  360,  360,  360,  360,  360,
			  211,  211,  211,  211,  211,  211,  211,  211,  211,  211,
			  211,  211,  211,  211,  211,  211,  211,  211,  211,  211,
			  211,  211,  211,  211,  211,  363,  363,  363,  363,  363,
			  363,  363,  363,  363,  363,  363,  363,  363,  363,  363,
			  363,  363,  363,  363,  363,  363,  363,  363,  363,  363,
			  365,  365,  365,  365,  365,  365,  365,  365,  365,  365,
			  365,  365,  365,  365,  365,  365,  365,  365,  365,  365,
			  365,  365,  365,  365,  365,  227,  227,  227,  227,  227,
			  227,  227,  227,  227,  227,  227,  227,  227,  227,  227,

			  227,  227,  227,  227,  227,  227,  227,  227,  227,  227,
			  370,  370,  370,  370,  370,  370,  370,  370,  370,  370,
			  370,  370,  370,  370,  370,  370,  370,  370,  370,  370,
			  370,  370,  370,  370,  370,  374,  374,  374,  374,  374,
			  374,  374,  374,  374,  374,  374,  374,  374,  374,  374,
			  374,  374,  374,  374,  374,  374,  374,  374,  374,  374,
			  240,  240,  240,  240,  240,  240,  240,  240,  240,  240,
			  240,  240,  240,  240,  240,  240,  240,  240,  240,  240,
			  240,  240,  240,  240,  240,  367,  367,  367,  367,  367,
			  367,  367,  367,  367,  367,  367,  367,  367,  367,  367,

			  367,  367,  367,  367,  367,  367,  367,  367,  367,  367,
			  372,  372,  372,  372,  372,  372,  372,  372,  372,  372,
			  372,  372,  372,  372,  372,  372,  372,  372,  372,  372,
			  372,  372,  372,  372,  372,  385,  385,  385,  385,  385,
			  385,  385,  385,  385,  385,  385,  385,  385,  385,  385,
			  385,  385,  385,  385,  385,  385,  385,  385,  385,  385,
			  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,
			  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,
			  479,  479,  479,  479,  479,  601,  601,  601,  601,  601,
			  601,  601,  601,  238,  601,  601,  601,  601,  601,  601,

			  601,  601,  601,  601,  601,  601,  601,  601,  601,  601,
			  375,  233,  364,  217,  207,  361,  357,  354,  189,  187,
			  353,  352,  349,  343,  334,  327,  321,  320,  309,  307,
			  291,  267,  242,   97,   96,   95,   94,   95,  207,  187,
			   95,  178,  177,  169,  163,  144,  139,  134,   98,   97,
			   96,   95,   94,  662,   11,  662,  662,  662,  662,  662,
			  662,  662,  662,  662,  662,  662,  662,  662,  662,  662,
			  662,  662,  662,  662,  662,  662,  662,  662,  662,  662,
			  662,  662,  662,  662,  662,  662,  662,  662,  662,  662,
			  662,  662,  662,  662,  662,  662,  662,  662,  662,  662,

			  662,  662,  662,  662,  662,  662,  662,  662,  662,  662,
			  662,  662,  662,  662,  662,  662,  662,  662,  662,  662,
			  662,  662,  662,  662,  662,  662,  662,  662,  662,  662,
			  662, yy_Dummy>>)
		end

	yy_chk_template: SPECIAL [INTEGER]
		once
			Result := yy_fixed_array (<<
			    0,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    3,    3,    3,
			    3,   54,    3,   21,   21,    3,    4,    4,    4,    4,
			  343,    4,   35,   35,    4,    5,    5,    5,    5,    6,

			    6,    6,    6,    5,   27,   29,   54,    6,    7,    7,
			    7,    7,   29,    7,   27,  343,    7,    8,    8,    8,
			    8,   42,    8,   37,   37,    8,   55,    9,    9,    9,
			    9,   42,    9,  660,   47,    9,   10,   10,   10,   10,
			   47,   10,  654,   28,   10,   28,   28,   28,  652,   44,
			  154,   50,   30,   44,   30,   30,   30,   55,   31,   56,
			   31,   31,   31,    7,   30,   32,   44,   32,   32,   32,
			   31,   43,    8,   43,   50,  651,  154,   39,   72,   39,
			   44,    7,    9,   43,   39,   72,   30,   83,   56,   44,
			    8,   10,   85,   30,   83,   30,   85,   43,   43,   31,

			    9,   31,  142,   39,   39,  146,   32,   39,   65,   10,
			   18,   18,   65,   18,   52,   65,  144,   18,   18,   93,
			   18,   41,   18,   93,  148,   41,   93,   53,   18,   52,
			   18,   41,   18,  142,   41,   46,  146,   53,  635,  144,
			   18,   83,   46,   46,  628,   18,   18,  148,   46,  454,
			   41,   41,   52,  155,   41,   18,   53,   41,   18,   18,
			   53,   18,   49,   18,  165,   46,   75,   75,   46,  151,
			   18,   46,   49,   75,   49,   66,   66,   18,   49,  454,
			   66,   68,   68,   66,  155,   68,  166,   69,   68,   69,
			   91,   69,  151,   49,   69,  165,  498,   91,   49,   49,

			  498,   49,   71,   71,   71,   71,   73,   73,   73,   73,
			   74,   74,  170,   74,   73,  152,  170,  166,   74,   71,
			   76,   76,   76,   76,  163,   78,   79,   79,   76,   78,
			  152,   79,   78,   86,   79,   81,   81,   86,  170,   81,
			   86,   82,   81,   82,  164,   82,  152,  163,   82,   84,
			   84,   84,   84,  152,   87,   88,   88,  620,   87,  619,
			   88,   87,   91,   88,   89,   89,   84,  164,   89,   92,
			   90,   89,   90,   92,   90,  171,   92,   90,   99,   78,
			  162,   79,   99,  303,  103,   99,  104,   86,  103,   81,
			  104,  103,  162,  104,  173,   82,  617,   78,  171,   79,

			  616,  101,  101,  101,  101,  615,  101,   81,   87,  101,
			   88,  162,  105,   82,  303,  307,  105,  173,   89,  105,
			  133,  133,  133,  106,   90,  107,   87,  106,   88,  107,
			  106,  108,  107,  109,  309,  108,   89,  109,  108,  106,
			  109,   92,   90,  110,  465,  111,  307,  110,  107,  111,
			  110,  112,  111,  113,  108,  112,  611,  113,  112,  133,
			  113,  114,  114,  115,  114,  309,  114,  115,  175,  114,
			  115,  116,  109,  141,  465,  116,  141,  588,  116,  117,
			  117,  110,  117,  574,  117,  111,  177,  117,  125,  125,
			  125,  175,  153,  113,  112,  320,  153,  109,  128,  128,

			  128,  125,  141,  129,  502,  129,  129,  129,  320,  177,
			  562,  128,  192,  192,  192,  129,  115,  112,  120,  153,
			  559,  120,  120,  120,  120,  556,  308,  125,  554,  130,
			  120,  130,  130,  130,  502,  149,  120,  321,  120,  149,
			  120,  120,  120,  120,  129,  120,  129,  120,  193,  308,
			  159,  120,  159,  120,  159,  193,  120,  120,  120,  120,
			  120,  120,  169,  321,  448,  159,  149,  194,  159,  149,
			  130,  174,  169,  198,  194,  169,  174,  169,  169,  200,
			  198,  159,  159,  159,  539,  179,  200,  174,  159,  179,
			  448,  159,  179,  169,  294,  294,  294,  169,  169,  530,

			  169,  169,  174,  183,  183,  184,  184,  202,  183,  184,
			  174,  183,  184,  185,  202,  185,  529,  185,  326,  523,
			  185,  188,  188,  188,  188,  196,  196,  196,  196,  197,
			  197,  521,  197,  196,  414,  414,  414,  197,  199,  199,
			  199,  199,  201,  201,  210,  201,  199,  204,  204,  326,
			  201,  210,  222,  520,  204,  205,  205,  205,  205,  222,
			  208,  212,  213,  205,  208,  212,  213,  208,  212,  213,
			  214,  214,  215,  215,  519,  214,  215,  310,  214,  215,
			  216,  218,  216,  517,  216,  218,  219,  216,  218,  515,
			  219,  328,  223,  219,  311,  226,  223,  224,  210,  223,

			  310,  224,  226,  228,  224,  229,  222,  228,  315,  229,
			  228,  234,  229,  349,  208,  234,  213,  311,  234,  230,
			  230,  236,  328,  450,  230,  214,  215,  230,  236,  231,
			  231,  315,  208,  231,  216,  232,  231,  232,  349,  232,
			  219,  235,  232,  214,  215,  235,  237,  513,  235,  450,
			  237,  224,  216,  237,  248,  250,  252,  511,  248,  250,
			  252,  248,  250,  252,  254,  336,  253,  226,  254,  224,
			  253,  254,  255,  253,  230,  228,  255,  257,  256,  255,
			  256,  257,  256,  231,  257,  256,  318,  258,  274,  232,
			  341,  258,  230,  236,  258,  253,  336,  274,  274,  274,

			  510,  231,  458,  259,  259,  254,  259,  232,  259,  318,
			  316,  259,  262,  235,  503,  319,  262,  255,  481,  262,
			  257,  341,  264,  264,  316,  264,  253,  264,  458,  479,
			  264,  292,  292,  292,  477,  296,  296,  296,  319,  337,
			  255,  316,  358,  257,  292,  293,  339,  293,  296,  358,
			  293,  293,  293,  297,  334,  297,  475,  334,  297,  297,
			  297,  298,  337,  298,  298,  298,  301,  301,  301,  339,
			  292,  346,  338,  298,  296,  299,  359,  299,  299,  299,
			  302,  302,  302,  359,  365,  334,  370,  334,  473,  462,
			  338,  365,  459,  370,  346,  355,  355,  355,  355,  416,

			  416,  416,  298,  338,  298,  301,  434,  368,  373,  456,
			  455,  368,  373,  338,  368,  373,  299,  380,  379,  302,
			  379,  380,  379,  381,  380,  379,  467,  381,  384,  382,
			  381,  434,  384,  382,  425,  384,  382,  427,  365,  396,
			  396,  396,  396,  413,  413,  413,  415,  415,  415,  417,
			  417,  417,  467,  453,  380,  428,  413,  425,  370,  382,
			  427,  418,  417,  418,  445,  443,  418,  418,  418,  419,
			  419,  419,  420,  420,  420,  421,  421,  421,  428,  460,
			  380,  431,  413,  433,  435,  415,  436,  422,  417,  422,
			  422,  422,  423,  438,  423,  423,  423,  444,  446,  422,

			  424,  424,  424,  452,  431,  468,  433,  435,  457,  436,
			  460,  461,  466,  442,  421,  499,  438,  485,  485,  485,
			  444,  446,  471,  471,  471,  471,  452,  441,  422,  440,
			  422,  457,  437,  423,  461,  466,  468,  472,  474,  424,
			  499,  472,  474,  476,  472,  474,  432,  476,  504,  430,
			  476,  482,  482,  482,  482,  483,  483,  483,  484,  484,
			  484,  486,  486,  486,  487,  487,  487,  506,  483,  488,
			  488,  488,  474,  489,  489,  489,  501,  487,  514,  504,
			  476,  505,  472,  490,  490,  490,  491,  491,  491,  492,
			  492,  492,  506,  508,  493,  493,  493,  484,  494,  501,

			  494,  494,  494,  487,  505,  472,  476,  493,  509,  514,
			  527,  518,  489,  522,  524,  526,  508,  532,  534,  534,
			  534,  534,  535,  536,  537,  491,  535,  536,  537,  535,
			  536,  537,  429,  509,  518,  426,  522,  524,  526,  494,
			  544,  527,  532,  540,  540,  540,  540,  542,  542,  542,
			  565,  389,  541,  536,  541,  535,  388,  541,  541,  541,
			  543,  543,  543,  545,  545,  545,  544,  387,  537,  546,
			  546,  546,  547,  547,  547,  565,  545,  548,  548,  548,
			  549,  549,  549,  555,  535,  561,  542,  550,  550,  550,
			  551,  537,  551,  572,  564,  551,  551,  551,  552,  552,

			  552,  566,  567,  568,  569,  570,  555,  578,  546,  581,
			  579,  552,  583,  583,  583,  583,  561,  564,  572,  549,
			  386,  644,  584,  385,  566,  567,  584,  569,  570,  584,
			  578,  383,  581,  585,  568,  579,  597,  585,  586,  608,
			  585,  606,  586,  607,  644,  586,  589,  589,  589,  589,
			  378,  604,  584,  590,  590,  590,  591,  591,  591,  592,
			  592,  592,  597,  377,  593,  608,  593,  376,  586,  593,
			  593,  593,  606,  594,  607,  594,  604,  585,  594,  594,
			  594,  595,  595,  595,  596,  596,  596,  598,  598,  598,
			  599,  599,  599,  600,  600,  600,  602,  602,  602,  603,

			  585,  603,  614,  623,  603,  603,  603,  623,  624,  602,
			  623,  374,  624,  372,  625,  624,  369,  367,  625,  363,
			  595,  625,  629,  629,  629,  362,  360,  614,  356,  630,
			  630,  630,  631,  631,  631,  602,  632,  632,  632,  633,
			  633,  633,  623,  634,  351,  634,  646,  348,  634,  634,
			  634,  636,  636,  636,  637,  637,  637,  638,  638,  638,
			  653,  653,  653,  347,  636,  345,  650,  623,  630,  646,
			  650,  344,  342,  650,  655,  655,  655,  656,  656,  656,
			  657,  657,  657,  661,  661,  661,  340,  690,  690,  335,
			  636,  690,  690,  690,  333,  331,  638,  329,  327,  653,

			  325,  324,  323,  322,  317,  313,  312,  290,  289,  288,
			  287,  286,  285,  284,  283,  282,  656,  281,  280,  657,
			  279,  278,  661,  663,  663,  663,  663,  663,  663,  663,
			  663,  663,  663,  663,  663,  663,  663,  663,  663,  663,
			  663,  663,  663,  663,  663,  663,  663,  663,  664,  664,
			  664,  664,  664,  664,  664,  664,  664,  664,  664,  664,
			  664,  664,  664,  664,  664,  664,  664,  664,  664,  664,
			  664,  664,  664,  665,  665,  665,  665,  665,  665,  665,
			  665,  665,  665,  665,  665,  665,  665,  665,  665,  665,
			  665,  665,  665,  665,  665,  665,  665,  665,  666,  666,

			  666,  666,  666,  666,  666,  666,  666,  666,  666,  666,
			  666,  666,  666,  666,  666,  666,  666,  666,  666,  666,
			  666,  666,  666,  667,  667,  277,  667,  667,  667,  667,
			  667,  667,  667,  667,  667,  667,  667,  667,  667,  667,
			  667,  667,  667,  667,  667,  667,  667,  667,  668,  276,
			  275,  273,  272,  271,  668,  668,  668,  668,  668,  668,
			  668,  668,  668,  668,  668,  668,  668,  668,  668,  668,
			  668,  668,  668,  669,  669,  270,  669,  669,  669,  669,
			  669,  669,  669,  669,  669,  669,  669,  669,  669,  669,
			  669,  669,  669,  669,  669,  669,  669,  669,  670,  670,

			  269,  268,  670,  670,  670,  670,  670,  670,  670,  670,
			  670,  670,  670,  670,  671,  671,  671,  671,  671,  671,
			  671,  671,  671,  671,  671,  671,  671,  671,  671,  671,
			  671,  671,  671,  671,  671,  671,  671,  671,  671,  672,
			  672,  672,  672,  672,  672,  672,  672,  672,  672,  672,
			  672,  672,  672,  672,  672,  672,  672,  672,  672,  672,
			  672,  672,  672,  672,  673,  673,  673,  673,  673,  673,
			  673,  263,  251,  249,  673,  673,  673,  673,  673,  247,
			  673,  673,  673,  673,  673,  674,  674,  674,  674,  674,
			  674,  674,  674,  674,  674,  674,  674,  674,  674,  674,

			  674,  674,  674,  674,  674,  674,  674,  674,  674,  674,
			  675,  675,  675,  675,  675,  675,  675,  675,  675,  675,
			  675,  675,  675,  675,  675,  675,  675,  675,  675,  675,
			  675,  675,  675,  675,  675,  676,  676,  676,  676,  676,
			  676,  676,  676,  676,  676,  676,  676,  676,  676,  676,
			  676,  676,  676,  676,  676,  676,  676,  676,  676,  676,
			  677,  677,  677,  677,  677,  677,  677,  677,  677,  677,
			  677,  677,  677,  677,  677,  677,  677,  677,  677,  677,
			  677,  677,  677,  677,  677,  678,  678,  678,  678,  678,
			  678,  678,  678,  678,  678,  678,  678,  678,  678,  678,

			  678,  678,  678,  678,  678,  678,  678,  678,  678,  678,
			  679,  679,  679,  679,  679,  246,  679,  679,  679,  679,
			  679,  679,  679,  679,  679,  679,  679,  679,  679,  679,
			  679,  679,  679,  679,  679,  680,  680,  680,  680,  680,
			  680,  680,  680,  680,  680,  680,  680,  680,  680,  680,
			  680,  680,  680,  680,  680,  680,  680,  680,  680,  680,
			  681,  681,  681,  681,  681,  681,  681,  681,  681,  681,
			  681,  681,  681,  681,  681,  681,  681,  681,  681,  681,
			  681,  681,  681,  681,  681,  682,  682,  682,  682,  682,
			  682,  682,  682,  682,  682,  682,  682,  682,  682,  682,

			  682,  682,  682,  682,  682,  682,  682,  682,  682,  682,
			  683,  683,  683,  683,  683,  683,  683,  683,  683,  683,
			  683,  683,  683,  683,  683,  683,  683,  683,  683,  683,
			  683,  683,  683,  683,  683,  684,  684,  684,  684,  684,
			  684,  684,  684,  684,  684,  684,  684,  684,  684,  684,
			  684,  684,  684,  684,  684,  684,  684,  684,  684,  684,
			  685,  685,  685,  685,  685,  685,  685,  685,  685,  685,
			  685,  685,  685,  685,  685,  685,  685,  685,  685,  685,
			  685,  685,  685,  685,  685,  686,  686,  245,  686,  686,
			  686,  686,  686,  686,  686,  686,  686,  686,  686,  686,

			  686,  686,  686,  686,  686,  686,  686,  686,  686,  686,
			  687,  687,  244,  687,  687,  687,  687,  687,  687,  687,
			  687,  687,  687,  687,  687,  687,  687,  687,  687,  687,
			  687,  687,  687,  687,  687,  688,  688,  243,  688,  688,
			  688,  688,  688,  688,  688,  688,  688,  688,  688,  688,
			  688,  688,  688,  688,  688,  688,  688,  688,  688,  688,
			  689,  689,  689,  689,  689,  689,  689,  689,  241,  689,
			  689,  689,  689,  689,  689,  689,  689,  689,  689,  689,
			  689,  689,  689,  689,  689,  691,  691,  691,  691,  691,
			  691,  691,  691,  691,  691,  691,  691,  691,  691,  691,

			  691,  691,  691,  691,  691,  691,  691,  691,  691,  691,
			  692,  692,  692,  692,  692,  692,  692,  692,  692,  692,
			  692,  692,  692,  692,  692,  692,  692,  692,  692,  692,
			  692,  692,  692,  692,  692,  693,  693,  693,  693,  693,
			  693,  693,  693,  693,  693,  693,  693,  693,  693,  693,
			  693,  693,  693,  693,  693,  693,  693,  693,  693,  693,
			  694,  694,  694,  694,  694,  694,  694,  694,  694,  694,
			  694,  694,  694,  694,  694,  694,  694,  694,  694,  694,
			  694,  694,  694,  694,  694,  695,  695,  695,  695,  695,
			  695,  695,  695,  695,  695,  695,  695,  695,  695,  695,

			  695,  695,  695,  695,  695,  695,  695,  695,  695,  695,
			  696,  696,  696,  696,  696,  696,  696,  696,  696,  696,
			  696,  696,  696,  696,  696,  696,  696,  696,  696,  696,
			  696,  696,  696,  696,  696,  697,  697,  697,  697,  697,
			  697,  697,  697,  697,  697,  697,  697,  697,  697,  697,
			  697,  697,  697,  697,  697,  697,  697,  697,  697,  697,
			  698,  698,  698,  698,  698,  698,  698,  698,  698,  698,
			  698,  698,  698,  698,  698,  698,  698,  698,  698,  698,
			  698,  698,  698,  698,  698,  699,  699,  699,  699,  699,
			  699,  699,  699,  699,  699,  699,  699,  699,  699,  699,

			  699,  699,  699,  699,  699,  699,  699,  699,  699,  699,
			  700,  700,  700,  700,  700,  700,  700,  700,  700,  700,
			  700,  700,  700,  700,  700,  700,  700,  700,  700,  700,
			  700,  700,  700,  700,  700,  701,  701,  701,  701,  701,
			  701,  701,  701,  701,  701,  701,  701,  701,  701,  701,
			  701,  701,  701,  701,  701,  701,  701,  701,  701,  701,
			  702,  702,  702,  702,  702,  702,  702,  702,  702,  702,
			  702,  702,  702,  702,  702,  702,  702,  702,  702,  702,
			  702,  702,  702,  702,  702,  703,  703,  703,  703,  703,
			  703,  703,  703,  703,  703,  703,  703,  703,  703,  703,

			  703,  703,  703,  703,  703,  703,  703,  703,  703,  703,
			  704,  704,  704,  704,  704,  704,  704,  704,  704,  704,
			  704,  704,  704,  704,  704,  704,  704,  704,  704,  704,
			  704,  704,  704,  704,  704,  705,  705,  705,  705,  705,
			  705,  705,  705,  705,  705,  705,  705,  705,  705,  705,
			  705,  705,  705,  705,  705,  705,  705,  705,  705,  705,
			  706,  706,  706,  706,  706,  706,  706,  706,  706,  706,
			  706,  706,  706,  706,  706,  706,  706,  706,  706,  706,
			  706,  706,  706,  706,  706,  707,  707,  707,  707,  707,
			  707,  707,  707,  240,  707,  707,  707,  707,  707,  707,

			  707,  707,  707,  707,  707,  707,  707,  707,  707,  707,
			  239,  227,  221,  211,  206,  203,  195,  191,  190,  186,
			  182,  181,  176,  172,  168,  161,  158,  156,  147,  145,
			  121,  119,  100,   97,   96,   95,   94,   80,   77,   70,
			   67,   59,   57,   51,   48,   40,   38,   33,   17,   16,
			   15,   14,   13,   11,  662,  662,  662,  662,  662,  662,
			  662,  662,  662,  662,  662,  662,  662,  662,  662,  662,
			  662,  662,  662,  662,  662,  662,  662,  662,  662,  662,
			  662,  662,  662,  662,  662,  662,  662,  662,  662,  662,
			  662,  662,  662,  662,  662,  662,  662,  662,  662,  662,

			  662,  662,  662,  662,  662,  662,  662,  662,  662,  662,
			  662,  662,  662,  662,  662,  662,  662,  662,  662,  662,
			  662,  662,  662,  662,  662,  662,  662,  662,  662,  662,
			  662, yy_Dummy>>)
		end

	yy_base_template: SPECIAL [INTEGER]
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,   75,   84,   93,   97,  106,  115,  125,
			  134, 2553, 2554, 2550, 2548, 2546, 2544, 2542,  203,    0,
			 2554,   73, 2554, 2554, 2554, 2554, 2554,   87,  125,   86,
			  134,  140,  147, 2521, 2554,   67, 2554,   97, 2520,  137,
			 2508,  185,   88,  131,  120,    0,  201,   97, 2501,  232,
			  105, 2510,  181,  191,   39,   97,  123, 2499, 2554, 2485,
			 2554, 2554, 2554, 2554, 2554,  205,  273, 2537,  278,  284,
			 2536,  300,  175,  304,  308,  263,  318, 2535,  322,  324,
			 2534,  332,  338,  184,  347,  189,  330,  351,  353,  361,
			  367,  287,  366,  216, 2534, 2532, 2530, 2528, 2554,  375,

			 2529,  399, 2554,  381,  383,  409,  420,  422,  428,  430,
			  440,  442,  448,  450,  459,  460,  468,  477,    0, 2520,
			  511, 2519,    0, 2554, 2554,  468, 2554, 2554,  478,  485,
			  511, 2554,    0,  400, 2554, 2554, 2554, 2554, 2554, 2554,
			    0,  436,  170,    0,  168, 2496,  176, 2495,  178,  505,
			    0,  222,  283,  448,  110,  224, 2484,    0, 2482,  518,
			    0, 2486,  349,  276,  297,  232,  255,    0, 2491,  530,
			  272,  329, 2490,  345,  539,  422, 2489,  440, 2554,  582,
			 2554, 2518, 2517,  601,  602,  610, 2516, 2554,  619, 2554,
			 2515, 2514,  492,  545,  564, 2513,  623,  627,  570,  636,

			  576,  640,  604, 2512,  644,  653, 2511, 2554,  657, 2554,
			  641, 2510,  658,  659,  668,  669,  677, 2554,  678,  683,
			 2554, 2509,  649,  689,  694, 2554,  692, 2508,  700,  702,
			  717,  726,  732, 2554,  708,  738,  718,  743, 2554, 2507,
			 2490, 2065, 2554, 2034, 2009, 1984, 1812, 1676,  751, 1670,
			  752, 1669,  753,  763,  761,  769,  775,  774,  784,  801,
			 2554, 2554,  809, 1668,  820, 2554, 2554, 2554, 1590, 1589,
			 1564, 1542, 1541, 1540,  777, 1539, 1538, 1514, 1410, 1409,
			 1407, 1406, 1404, 1403, 1402, 1401, 1400, 1399, 1398, 1397,
			 1396, 2554,  811,  830,  574, 2554,  815,  838,  843,  857,

			    0,  846,  860,  354,    0,    0,    0,  384,  479,  405,
			  631,  645, 1373, 1372,    0,  659,  781, 1371,  739,  767,
			  454,  497, 1370, 1365, 1368, 1356,  589, 1365,  662, 1353,
			    0, 1352,    0, 1361,  823, 1356,  736,  790,  841,  800,
			 1353,  761, 1335,   48, 1338, 1332,  826, 1326, 1310,  671,
			    0, 1341, 2554, 2554, 2554,  876, 1325, 2554,  839,  873,
			 1323, 2554, 1322, 1316, 2554,  881, 2554, 1314,  904, 1313,
			  883, 2554, 1310,  905, 1308, 2554, 1264, 1260, 1247,  915,
			  914,  920,  926, 1228,  925, 1220, 1217, 1164, 1153, 1148,
			 2554, 2554, 2554, 2554, 2554, 2554,  920, 2554, 2554, 2554,

			 2554, 2554, 2554, 2554, 2554, 2554, 2554, 2554, 2554, 2554,
			 2554, 2554, 2554,  923,  614,  926,  879,  929,  946,  949,
			  952,  955,  969,  974,  980,  887, 1096,  890,  907, 1099,
			 1014,  935, 1009,  937,  864,  938,  940,  999,  944,    0,
			  996,  990,  961,  913,  951,  931,  952,    0,  524,    0,
			  683,    0,  954,  916,  215,  869,  872,  959,  762,  839,
			  948,  965,  845,    0,    0,  410,  963,  886,  976,    0,
			 2554, 1003, 1034,  885, 1035,  853, 1040,  831, 2554,  826,
			 2554,  807, 1032, 1035, 1038,  997, 1041, 1044, 1049, 1053,
			 1063, 1066, 1069, 1074, 1080,    0,    0,    0,  263,  973,

			    0, 1030,  470,  781, 1016, 1033, 1025,    0, 1047, 1066,
			  767,  720,    0,  710, 1047,  652,    0,  650, 1065,  622,
			  616,  598, 1067,  586, 1066,    0, 1067, 1081,    0,  579,
			  566,    0, 1075, 2554, 1099, 1119, 1120, 1121, 2554,  573,
			 1124, 1137, 1127, 1140, 1107, 1143, 1149, 1152, 1157, 1160,
			 1167, 1175, 1178,    0,  485, 1135,  492,    0,    0,  487,
			    0, 1156,  477,    0, 1147, 1108, 1153, 1154, 1174, 1156,
			 1158,    0, 1151,    0,  450,    0,    0,    0, 1159, 1168,
			    0, 1161, 2554, 1193, 1219, 1230, 1235, 2554,  466, 1227,
			 1233, 1236, 1239, 1249, 1258, 1261, 1264, 1203, 1267, 1270,

			 1273, 2554, 1276, 1284, 1209,    0, 1209, 1211, 1199,    0,
			    0,  421,    0,    0, 1260,  372,  357,  363,    0,  326,
			  324,    0, 2554, 1300, 1305, 1311, 2554, 2554,  185, 1302,
			 1309, 1312, 1316, 1319, 1328,  179, 1331, 1334, 1337,    0,
			    0,    0,    0,    0, 1173,    0, 1300,    0,    0,    0,
			 1363,  172,  145, 1340,   83, 1354, 1357, 1360,    0,    0,
			  130, 1363, 2554, 1422, 1447, 1472, 1497, 1522, 1547, 1572,
			 1588, 1613, 1638, 1662, 1684, 1709, 1734, 1759, 1784, 1809,
			 1834, 1859, 1884, 1909, 1934, 1959, 1984, 2009, 2034, 2059,
			 1377, 2084, 2109, 2134, 2159, 2184, 2209, 2234, 2259, 2284,

			 2309, 2334, 2359, 2384, 2409, 2434, 2459, 2484, yy_Dummy>>)
		end

	yy_def_template: SPECIAL [INTEGER]
		once
			Result := yy_fixed_array (<<
			    0,  662,    1,  663,  663,  664,  664,  665,  665,  666,
			  666,  662,  662,  662,  662,  662,  662,  662,  667,  668,
			  662,  669,  662,  662,  662,  662,  662,  662,  662,  662,
			  662,  662,  662,  662,  662,  662,  662,  662,  662,  670,
			  670,  670,  670,  670,  670,  670,  670,  670,  670,  670,
			  670,  670,  670,  670,  670,  670,  670,  670,  662,  662,
			  662,  662,  662,  662,  662,  671,  671,  662,  671,  671,
			  672,  673,  674,  674,  675,  674,  674,  676,  677,  677,
			  662,  677,  677,  678,  673,  679,  679,  680,  680,  680,
			  680,  681,  682,  682,  662,  662,  662,  662,  662,  667,

			  683,  684,  662,  667,  667,  667,  667,  667,  667,  667,
			  667,  667,  667,  667,  685,  667,  667,  685,  668,  686,
			  687,  686,  688,  662,  662,  662,  662,  662,  689,  662,
			  662,  662,  690,  662,  662,  662,  662,  662,  662,  662,
			  670,  670,  670,  670,  670,  670,  670,  670,  670,  670,
			  670,  670,  670,  670,  670,  670,  670,  670,  670,  670,
			  670,  670,  670,  670,  670,  670,  670,  670,  670,  670,
			  670,  670,  670,  670,  670,  670,  670,  670,  662,  671,
			  662,  691,  692,  671,  671,  671,  672,  662,  662,  662,
			  662,  693,  662,  674,  674,  694,  674,  675,  674,  674,

			  675,  675,  674,  695,  674,  674,  676,  662,  677,  662,
			  678,  696,  679,  679,  677,  677,  677,  662,  678,  679,
			  662,  697,  698,  679,  680,  662,  681,  699,  682,  682,
			  680,  680,  680,  662,  681,  682,  700,  682,  662,  701,
			  702,  683,  662,  701,  701,  701,  701,  701,  667,  701,
			  667,  701,  667,  667,  667,  667,  667,  667,  685,  685,
			  662,  662,  667,  701,  685,  662,  662,  662,  662,  662,
			  662,  662,  662,  662,  662,  662,  662,  662,  662,  662,
			  662,  662,  662,  662,  662,  662,  662,  662,  662,  662,
			  662,  662,  662,  662,  662,  662,  662,  662,  662,  662,

			  690,  662,  662,  670,  670,  670,  670,  670,  670,  670,
			  670,  670,  670,  670,  670,  670,  670,  670,  670,  670,
			  670,  670,  670,  670,  670,  670,  670,  670,  670,  670,
			  670,  670,  670,  670,  670,  670,  670,  670,  670,  670,
			  670,  670,  670,  670,  670,  670,  670,  670,  670,  670,
			  670,  691,  662,  662,  662,  662,  694,  662,  674,  674,
			  695,  662,  703,  697,  662,  698,  662,  703,  698,  704,
			  700,  662,  704,  700,  701,  662,  701,  701,  701,  667,
			  667,  667,  667,  701,  667,  705,  706,  705,  701,  705,
			  662,  662,  662,  662,  662,  662,  662,  662,  662,  662,

			  662,  662,  662,  662,  662,  662,  662,  662,  662,  662,
			  662,  662,  662,  662,  662,  662,  662,  662,  662,  662,
			  662,  662,  662,  662,  662,  670,  670,  670,  670,  670,
			  670,  670,  670,  670,  670,  670,  670,  670,  670,  670,
			  670,  670,  670,  670,  670,  670,  670,  670,  670,  670,
			  670,  670,  670,  670,  670,  670,  670,  670,  670,  670,
			  670,  670,  670,  670,  670,  670,  670,  670,  670,  670,
			  662,  662,  667,  701,  667,  701,  667,  701,  662,  706,
			  662,  662,  662,  662,  662,  662,  662,  662,  662,  662,
			  662,  662,  662,  689,  662,  670,  670,  670,  670,  670,

			  670,  670,  670,  670,  670,  670,  670,  670,  670,  670,
			  670,  670,  670,  670,  670,  670,  670,  670,  670,  670,
			  670,  670,  670,  670,  670,  670,  670,  670,  670,  670,
			  670,  670,  670,  662,  662,  667,  667,  667,  662,  662,
			  662,  662,  662,  662,  662,  662,  662,  662,  662,  662,
			  662,  662,  707,  670,  670,  670,  670,  670,  670,  670,
			  670,  670,  670,  670,  670,  670,  670,  670,  670,  670,
			  670,  670,  670,  670,  670,  670,  670,  670,  670,  670,
			  670,  670,  662,  662,  667,  667,  667,  662,  662,  662,
			  662,  662,  662,  662,  662,  662,  662,  662,  662,  662,

			  662,  662,  662,  662,  670,  670,  670,  670,  670,  670,
			  670,  670,  670,  670,  670,  670,  670,  670,  670,  670,
			  670,  670,  662,  667,  667,  667,  662,  662,  662,  662,
			  662,  662,  662,  662,  662,  662,  662,  662,  662,  670,
			  670,  670,  670,  670,  670,  670,  670,  670,  670,  670,
			  667,  701,  701,  662,  662,  662,  662,  662,  670,  670,
			  701,  662,    0,  662,  662,  662,  662,  662,  662,  662,
			  662,  662,  662,  662,  662,  662,  662,  662,  662,  662,
			  662,  662,  662,  662,  662,  662,  662,  662,  662,  662,
			  662,  662,  662,  662,  662,  662,  662,  662,  662,  662,

			  662,  662,  662,  662,  662,  662,  662,  662, yy_Dummy>>)
		end

	yy_ec_template: SPECIAL [INTEGER]
		once
			Result := yy_fixed_array (<<
			    0,    1,    1,    1,    1,    1,    1,    1,    1,    2,
			    3,    1,    1,    4,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    5,    6,    7,    8,    9,   10,    8,   11,
			   12,   13,   14,   15,   16,   17,   18,   19,   20,   21,
			   22,   22,   22,   22,   22,   22,   22,   22,   23,   24,
			   25,   26,   27,   28,    8,   29,   30,   31,   32,   33,
			   34,   35,   36,   37,   38,   39,   40,   41,   42,   43,
			   44,   45,   46,   47,   48,   49,   50,   51,   52,   53,
			   54,   55,   56,   57,   58,   59,    1,   60,   61,   62,

			   63,   33,   64,   35,   65,   37,   38,   39,   66,   41,
			   67,   43,   44,   68,   69,   70,   71,   72,   73,   51,
			   52,   53,   54,   74,    8,   75,   76,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,

			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1, yy_Dummy>>)
		end

	yy_meta_template: SPECIAL [INTEGER]
		once
			Result := yy_fixed_array (<<
			    0,    1,    2,    3,    2,    4,    1,    5,    1,    1,
			    6,    7,    7,    8,    1,    1,    1,    1,    9,    7,
			   10,   10,   11,    1,    1,   12,    1,   13,    1,   14,
			   14,   14,   15,   10,   16,   17,   18,   17,   17,   17,
			   19,   17,   20,   17,   17,   21,   21,   21,   21,   21,
			   22,   17,   17,   17,   23,    1,    1,    1,    1,   24,
			   10,   10,   10,   10,   10,   17,   17,   17,   17,   17,
			   17,   17,   17,   25,    1,    1,    1, yy_Dummy>>)
		end

	yy_accept_template: SPECIAL [INTEGER]
		once
			Result := yy_fixed_array (<<
			    0,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    2,    4,    7,   10,   13,   16,   19,   21,
			   24,   27,   29,   32,   35,   38,   41,   44,   47,   50,
			   53,   56,   59,   62,   65,   68,   71,   74,   77,   80,
			   83,   86,   89,   92,   95,   98,  101,  104,  107,  110,
			  113,  116,  119,  122,  125,  128,  131,  134,  137,  140,
			  142,  145,  148,  151,  154,  157,  161,  166,  171,  176,
			  181,  185,  188,  190,  193,  198,  201,  204,  207,  210,
			  214,  218,  222,  226,  229,  231,  233,  236,  239,  243,
			  247,  251,  254,  257,  259,  260,  261,  262,  263,  264,

			  265,  266,  267,  268,  269,  270,  271,  272,  273,  274,
			  275,  276,  277,  278,  279,  279,  280,  281,  281,  282,
			  283,  284,  285,  286,  287,  288,  290,  291,  292,  292,
			  294,  296,  297,  297,  298,  299,  300,  301,  302,  303,
			  304,  305,  306,  307,  309,  310,  311,  312,  313,  314,
			  315,  317,  318,  319,  320,  321,  322,  323,  325,  326,
			  327,  329,  330,  331,  332,  333,  334,  335,  337,  338,
			  339,  340,  341,  342,  343,  344,  345,  346,  347,  348,
			  349,  351,  352,  352,  354,  356,  358,  358,  359,  359,
			  360,  360,  360,  361,  361,  362,  363,  364,  366,  366,

			  366,  366,  367,  370,  371,  372,  373,  373,  375,  376,
			  378,  379,  379,  380,  381,  383,  385,  387,  388,  389,
			  390,  391,  392,  394,  395,  396,  398,  399,  399,  400,
			  401,  403,  405,  407,  408,  409,  410,  412,  413,  414,
			  415,  415,  415,  416,  418,  420,  422,  424,  426,  427,
			  429,  430,  432,  433,  434,  435,  436,  437,  438,  439,
			  440,  441,  442,  443,  445,  446,  447,  448,  450,  451,
			  452,  453,  454,  455,  456,  457,  458,  459,  460,  461,
			  462,  463,  464,  465,  466,  467,  468,  469,  470,  471,
			  472,  473,  475,  477,  477,  477,  478,  480,  481,  483,

			  485,  486,  487,  488,  489,  491,  493,  495,  496,  497,
			  498,  499,  500,  501,  502,  504,  505,  506,  507,  508,
			  509,  510,  511,  512,  513,  514,  515,  516,  517,  518,
			  519,  521,  522,  524,  525,  526,  527,  528,  529,  530,
			  531,  532,  533,  534,  535,  536,  537,  538,  539,  540,
			  541,  543,  543,  545,  546,  547,  548,  548,  549,  551,
			  553,  553,  555,  556,  556,  557,  558,  560,  560,  561,
			  562,  563,  565,  565,  566,  566,  568,  570,  572,  574,
			  575,  576,  577,  578,  580,  581,  581,  582,  583,  585,
			  586,  587,  589,  591,  593,  595,  597,  598,  600,  602,

			  604,  606,  608,  610,  612,  614,  616,  618,  620,  622,
			  624,  626,  628,  630,  632,  632,  634,  634,  636,  636,
			  636,  636,  638,  640,  642,  643,  644,  645,  646,  647,
			  648,  649,  650,  652,  653,  654,  655,  656,  657,  658,
			  660,  661,  662,  663,  664,  665,  666,  667,  669,  670,
			  672,  673,  675,  676,  677,  678,  679,  680,  681,  682,
			  683,  684,  685,  686,  688,  690,  691,  692,  693,  694,
			  696,  698,  699,  700,  702,  703,  705,  706,  708,  709,
			  709,  711,  712,  713,  714,  716,  716,  716,  718,  718,
			  722,  722,  724,  724,  724,  726,  728,  730,  732,  733,

			  734,  736,  737,  738,  739,  740,  741,  742,  744,  745,
			  746,  747,  748,  750,  751,  752,  753,  755,  756,  757,
			  758,  759,  760,  761,  762,  763,  765,  766,  767,  769,
			  770,  771,  773,  774,  776,  777,  778,  779,  780,  781,
			  782,  783,  783,  785,  785,  786,  787,  791,  791,  791,
			  793,  793,  794,  794,  796,  797,  798,  799,  801,  803,
			  804,  806,  807,  808,  810,  811,  812,  813,  814,  815,
			  816,  817,  819,  820,  822,  823,  825,  827,  829,  830,
			  831,  833,  834,  836,  837,  838,  839,  840,  841,  842,
			  843,  843,  844,  844,  844,  844,  848,  848,  849,  850,

			  850,  850,  851,  852,  853,  854,  856,  857,  858,  859,
			  861,  863,  864,  866,  868,  869,  870,  871,  872,  874,
			  875,  876,  878,  879,  880,  881,  882,  883,  884,  885,
			  885,  886,  886,  888,  888,  888,  889,  890,  890,  891,
			  893,  895,  897,  899,  901,  902,  904,  905,  907,  909,
			  911,  912,  914,  916,  917,  919,  919,  921,  922,  924,
			  926,  928,  930,  930, yy_Dummy>>)
		end

	yy_acclist_template: SPECIAL [INTEGER]
		once
			Result := yy_fixed_array (<<
			    0,  186,  184,  185,    3,  184,  185,    4,  184,  185,
			    2,  184,  185,    1,  184,  185,   60,  184,  185,  184,
			  185,  142,  184,  185,   67,  184,  185,  184,  185,   61,
			  184,  185,   62,  184,  185,   50,  184,  185,   48,  184,
			  185,   58,  184,  185,   49,  184,  185,   56,  184,  185,
			   51,  184,  185,  174,  184,  185,  174,  184,  185,  174,
			  184,  185,   59,  184,  185,   57,  184,  185,   55,  184,
			  185,   53,  184,  185,   54,  184,  185,   68,  184,  185,
			  141,  184,  185,  141,  184,  185,  141,  184,  185,  141,
			  184,  185,  141,  184,  185,  141,  184,  185,  141,  184,

			  185,  141,  184,  185,  141,  184,  185,  141,  184,  185,
			  141,  184,  185,  141,  184,  185,  141,  184,  185,  141,
			  184,  185,  141,  184,  185,  141,  184,  185,  141,  184,
			  185,  141,  184,  185,  141,  184,  185,   65,  184,  185,
			  184,  185,   66,  184,  185,   52,  184,  185,   63,  184,
			  185,   64,  184,  185,   69,  184,  185,  183,  184,  185,
			 -222,    3,  183,  184,  185, -222,    4,   45,  183,  184,
			  185,    2,  183,  184,  185, -222,    1,  183,  184,  185,
			 -222,  183,  184,  185, -217,  183,  184,  185,  184,  185,
			    3,  184,  185,    4,   47,  184,  185, -220,    2,  184,

			  185,    1,  184,  185,  184,  185, -231,  184,  185, -224,
			    3,  184,  185, -224,    4,   45,  184,  185,    2,  184,
			  185, -224,    1,  184,  185, -224,  184,  185, -224,  184,
			  185,  184,  185,  184,  185, -224,  184,  185, -223,    3,
			  184,  185, -223,    2,  184,  185, -223,    1,  184,  185,
			 -223,  184,  185, -223,  184,  185, -223,  184,  185,    3,
			    4,    2,    1,   75, -211, -210, -211,   29, -211, -211,
			 -211, -211, -211, -211, -211, -211, -211, -211, -211, -211,
			 -211,  142,  170,  170,  170,    5,   76,   77,  179,  182,
			   70,   72,  174,  176,  174,  176,  172,  176,   80,   78,

			   74,   73,   79,   81,  141,  141,  141,   85,  141,  141,
			  141,  141,  141,  141,  141,   94,  141,  141,  141,  141,
			  141,  141,  141,  106,  141,  141,  141,  113,  141,  141,
			  141,  141,  141,  141,  141,  121,  141,  141,  141,  141,
			  141,  141,  141,  141,  141,  141,  141,   71, -222,  -37,
			   45, -217,    3, -222,    2, -222,    1, -222,  -32,   34,
			   43,   47, -231,    3,   47, -220, -220,    4,  -35,   47,
			 -231,    2,    1,   36,  -46, -224,  -39,   45, -224, -224,
			 -224,    3, -224,    2, -224,    1, -224,  -39, -224, -224,
			   45, -218, -218, -224, -224, -223,  -38,   45, -223, -223,

			 -223,    3, -223,    2, -223,    1, -223,  -38, -223, -223,
			 -218, -223, -223,  -26, -210,  -25,   24, -210,    8, -210,
			    6, -210,    7, -210,    9, -210, -211,   13, -210, -211,
			   15, -210, -211, -211, -211, -211, -211, -211, -212, -212,
			   30,   28, -211,   12, -210, -212,   31,  170,  143,  170,
			  170,  170,  170,  170,  170,  170,  170,  170,  170,  170,
			  170,  170,  170,  170,  170,  170,  170,  170,  170,  170,
			  170,  170,  170,  144,  170,  179,  182,  177,  179,  182,
			  177,  174,  176,  174,  176,  173,  176,  176,  141,   83,
			  141,   84,  141,   86,  141,  141,  141,  141,  141,  141,

			  141,  141,   97,  141,  141,  141,  141,  141,  141,  141,
			  141,  141,  141,  141,  141,  141,  141,  141,  141,  117,
			  141,  141,  119,  141,  141,  141,  141,  141,  141,  141,
			  141,  141,  141,  141,  141,  141,  141,  141,  141,  141,
			  141,  140,  141,  -32,  -37,  -37,   44,   43,  -46,  -35,
			   47,    4,   47,  -35,  -46, -218,  -33, -224,  -33,  -39,
			 -224, -218, -223,  -33,  -38, -223,  -25,  -26,   10, -210,
			   14, -210,   16, -210, -211, -211, -211, -211,   19, -210,
			 -211, -210,   30,   11, -210,   31,  169,  161,  169,  159,
			  169,  160,  169,  162,  169,  163,  169,  171,  164,  169,

			  165,  169,  145,  169,  146,  169,  147,  169,  148,  169,
			  149,  169,  150,  169,  151,  169,  152,  169,  153,  169,
			  154,  169,  155,  169,  156,  169,  157,  169,  158,  169,
			  179,  182,  179,  182,  179,  182,  178,  181,  174,  176,
			  174,  176,  176,  141,  141,  141,  141,  141,  141,  141,
			   95,  141,  141,  141,  141,  141,  141,  141,  104,  141,
			  141,  141,  141,  141,  141,  141,  141,  114,  141,  141,
			  116,  141,  141,  120,  141,  141,  141,  141,  141,  141,
			  141,  141,  141,  141,  141,  141,  133,  141,  134,  141,
			  141,  141,  141,  141,  139,  141,   40,   43,   43, -211,

			   18, -210, -211,   17, -210, -211,   20, -210,  -27,  -25,
			  -27,  171,  171,  179,  179,  182,  179,  182,  178,  179,
			  181,  182,  178,  181,  175,  176,   82,  141,   87,  141,
			   88,  141,  141,  141,   92,  141,  141,  141,  141,  141,
			  141,  141,  102,  141,  141,  141,  141,  141,  109,  141,
			  141,  141,  141,  115,  141,  141,  141,  141,  141,  141,
			  141,  141,  141,  129,  141,  141,  141,  132,  141,  141,
			  141,  137,  141,  141,   41,   43,   43, -211, -211, -211,
			  166,  171,  171,  179,  182,  182,  179,  178,  179,  181,
			  182,  178,  181,  177,   89,  141,  141,  141,  141,   96,

			  141,   98,  141,  141,  100,  141,  141,  141,  105,  141,
			  141,  141,  141,  141,  141,  141,  141,  123,  141,  141,
			  125,  141,  141,  127,  141,  128,  141,  130,  141,  141,
			  141,  136,  141,  141,   42,   43,   43, -211, -211, -211,
			  167,  171,  171,  179,  178,  179,  181,  182,  182,  178,
			  180,  182,  180,  141,   91,  141,  141,  141,  141,  103,
			  141,  107,  141,  141,  110,  141,  111,  141,  141,  141,
			  141,  141,  126,  141,  141,  141,  138,  141,   43, -211,
			 -211, -211,  168,  171,  182,  182,  178,  179,  181,  182,
			  181,   90,  141,   93,  141,   99,  141,  101,  141,  108,

			  141,  141,  118,  141,  141,  124,  141,  131,  141,  135,
			  141, -211,   23, -210,   22, -210,  182,  181,  182,  181,
			  182,  181,  112,  141,  122,  141,   21, -210,  181,  182, yy_Dummy>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER = 2554
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER = 662
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER = 663
			-- Mark between normal states and templates

	yyNull_equiv_class: INTEGER = 1
			-- Equivalence code for NULL character

	yyReject_used: BOOLEAN = false
			-- Is `reject' called?

	yyVariable_trail_context: BOOLEAN = true
			-- Is there a regular expression with
			-- both leading and trailing parts having
			-- variable length?

	yyReject_or_variable_trail_context: BOOLEAN = true
			-- Is `reject' called or is there a
			-- regular expression with both leading
			-- and trailing parts having variable length?

	yyNb_rules: INTEGER = 185
			-- Number of rules

	yyEnd_of_buffer: INTEGER = 186
			-- End of buffer rule code

	yyLine_used: BOOLEAN = true
			-- Are line and column numbers used?

	yyPosition_used: BOOLEAN = true
			-- Is `position' used?

	INITIAL: INTEGER = 0
	IN_STR: INTEGER = 1
	STR_GAP: INTEGER = 2
	STR_VERBATIM_LA: INTEGER = 3
	STR_VERBATIM: INTEGER = 4
			-- Start condition codes

feature -- User-defined features



feature {NONE} -- Error reporting

	file_name: STRING
		deferred
		end

	file_name_reported: BOOLEAN		

feature {NONE} -- Local variables

--	i_, nb_: INTEGER
--	char_: CHARACTER
	str_: STRING	-- String holding variable
--	code_: INTEGER
	t_col: INTEGER	-- Tab column calculation

feature {NONE} -- Initialization

	make_lex
			-- Create a new Eiffel scanner.
		do
			make_with_buffer (Empty_buffer)
--			eif_buffer := STRING_.make (Init_buffer_size)
			create eif_buffer.make (Init_buffer_size)
			eif_tab_offset := 0
			create_keyword := True
			make_scanner
		end

	make_scanner
		deferred
		end

feature -- Initialization

	reset_scanner
			-- Reset scanner before scanning next input.
		do
			reset_compressed_scanner_skeleton
			eif_tab_offset := 0
			eif_buffer.wipe_out
		end

feature -- Access

	eif_buffer: STRING
			-- Buffer for lexical tokens

	eif_tab_offset: INTEGER
			-- column offset due to tabs

	eif_last_col, eif_last_line: INTEGER
			-- line col at end of last token

	is_operator: BOOLEAN
			-- Parsing an operator declaration?

	eif_in_token: INTEGER
			-- Type of partial string tracking

	eif_string_type: INTEGER
			-- Track type of next (partial) string token

	eif_string_valid: BOOLEAN
			-- Is the current string valid
			-- or should it be treated as s_raw_text ?

feature -- Status report

	create_keyword: BOOLEAN
			-- Should `create' be considered as
			-- a keyword (otherwise identifier)?

feature {NONE} -- Processing

	process_operator (op: INTEGER): INTEGER
			-- Process current token as operator `op' or as
			-- an Eiffel string depending on the context
		require
			text_count_large_enough: text_count > 2
		do
			if is_operator then
				is_operator := False
				Result := op
			else
				Result := s_string
				last_any_value := text_substring (2, text_count - 1)
			end
		end

	pre_action
		do
			--symbol_start_position := current_position
			set_symbol_start_position
		end

	set_symbol_start_position
		deferred
		end

feature	
	token_count: INTEGER -- TEMP
	max_column,
	max_line: INTEGER

feature {NONE}

	post_action
		local
			s: STRING
		do

			-- Update max_column for GUI content width
			if (column + eif_tab_offset) > max_column then
				max_column := column + eif_tab_offset
			end
			if line > max_line then
				max_line := line
			end

			if last_token = s_identifier then
				s ?= last_any_value
				add_symbol(last_token, repository # s)
				token_count := token_count + 1
			elseif last_token /= s_whitespace then

				inspect last_token

				when s_integer,
					s_real,
					s_bit_sequence,

					s_string,
					s_string_prefix,
					s_str_left_bracket,
					s_str_left_brace,
					s_string_infix,
					s_string_suffix,
					s_str_right_brace,
					s_str_right_bracket,
					s_freeop,
					s_comment
					then
						s ?= last_any_value
						add_symbol(last_token, repository # s)
				when s_character then
						s ?= last_any_value
						add_symbol(last_token, (s @ 2).code)	-- ???
				when s_character_escaped then
						s ?= last_any_value
						add_symbol(last_token, (s @ 3).code)
				when s_string_escaped then
						s ?= last_any_value
						add_symbol(last_token, (s @ 2).code)
				when s_string_decimal_1, s_character_decimal_1 then
						s ?= last_any_value
						add_symbol(last_token, (s @ 1).code - ('0').code)
				when s_string_decimal_2, s_character_decimal_2 then
						s ?= last_any_value
						add_symbol(last_token, 
							 10 * ((s @ 1).code - ('0').code)
							+ 1 * ((s @ 2).code - ('0').code))
				when s_string_decimal_3, s_character_decimal_3 then
						s ?= last_any_value
						add_symbol(last_token,
							 100 * ((s @ 1).code - ('0').code)
							+ 10 * ((s @ 2).code - ('0').code)
							+  1 * ((s @ 3).code - ('0').code))
				else
					add_symbol(last_token, 0)
				end
				token_count := token_count + 1
			end

			if last_token = s_string_prefix then
				-- remember line/column for start of string token

			--#DEBUG
			--	fx_trace_local(0, <<"line: ", line.out, " column: ", (column + eif_tab_offset).out,
			--			" position: ", position.out," scan cond: ", start_cond_str, " ",token_name(last_token), ": ", eif_buffer>>)
			--#DEBUG-end
			
			elseif last_token = s_string_infix then
				-- do nothing

			--#DEBUG
			--	fx_trace_local(0, <<"line: ", line.out, " column: ", (column + eif_tab_offset).out,
			--			" position: ", position.out," scan cond: ", start_cond_str, " ",token_name(last_token), ": ", eif_buffer>>)
			--#DEBUG-end

			elseif last_token /= s_whitespace then 

				-- position after last displayed token is at
				--	eif_last_line, eif_last_col
				-- start of current token is at
				--	line, (column + eif_tab_offset)
				
				if line /= eif_last_line then
					eif_last_col := 1
					from
					until
						eif_last_line >= line
					loop
			--			io.put_string("%N")
						eif_last_line := eif_last_line + 1
					end
				end
				from
				until
					eif_last_col >= (column + eif_tab_offset)
				loop
			--		io.put_string(" ")
					eif_last_col := eif_last_col + 1
				end
				s := token_string(last_token)
			--	io.put_string(s)

			--#DEBUG
			--	fx_trace_local(0, <<"line: ", line.out, " column: ", (column + eif_tab_offset).out,
			--			" position: ", position.out," scan cond: ", start_cond_str, " ",token_name(last_token), ": ", s>>)
			--#DEBUG-end
			
				eif_last_col := eif_last_col + s.count
				last_any_value := Void
			else
				check last_token = s_whitespace end
				
			end
		end

	add_symbol(i: INTEGER; s: INTEGER)
		deferred
		end

	start_cond_str: STRING
		do
			if		start_condition = INITIAL			then	Result := once "INITIAL"
			elseif	start_condition = IN_STR			then	Result := once "IN_STR"
			elseif	start_condition = STR_VERBATIM		then	Result := once "VERBATIM"
			elseif	start_condition = STR_VERBATIM_LA 	then	Result := once "VERBATIM_LA"
			elseif	start_condition = STR_GAP			then	Result := once "STR_GAP"
			else	Result := once "???"
			end
		end

	post_eof_action
		do
		--	fx_trace(0, <<once "Token count: ", token_count.out>>)
		--	list_file
		end

	fx_trace_local(n: INTEGER; sa: ARRAY[STRING])
		do
	--		fx_trace(n, sa)
		end

feature {SCANNER_SYMBOL}

	token_string(t: INTEGER): STRING
		do
		--	inspect last_token
			inspect t

			when s_alias		then Result := once "alias"
			when s_all			then Result := once "all"
			when s_as			then Result := once "as"
			when s_bit			then Result := once "BIT"
			when s_check		then Result := once "check"
			when s_class		then Result := once "class"
			when s_create		then Result := once "create"
			when s_creation		then Result := once "creation"
			when s_debug		then Result := once "debug"
			when s_deferred		then Result := once "deferred"
			when s_do			then Result := once "do"
			when s_else			then Result := once "else"
			when s_elseif		then Result := once "elseif"
			when s_end			then Result := once "end"
			when s_ensure		then Result := once "ensure"
			when s_expanded		then Result := once "expanded"
			when s_export		then Result := once "export"
			when s_external		then Result := once "external"
			when s_feature		then Result := once "feature"
			when s_from			then Result := once "from"
			when s_frozen		then Result := once "frozen"
			when s_if			then Result := once "if"
			when s_indexing		then Result := once "indexing"
			when s_infix		then Result := once "infix"
			when s_inherit		then Result := once "inherit"
			when s_inspect		then Result := once "inspect"
			when s_invariant	then Result := once "invariant"
			when s_is			then Result := once "is"
			when s_like			then Result := once "like"
			when s_local		then Result := once "local"
			when s_loop			then Result := once "loop"
			when s_obsolete		then Result := once "obsolete"
			when s_old			then Result := once "old"
			when s_once			then Result := once "once"
			when s_precursor	then Result := once "Precursor"
			when s_prefix		then Result := once "prefix"
			when s_redefine		then Result := once "redefine"
			when s_rename		then Result := once "rename"
			when s_require		then Result := once "require"
			when s_rescue		then Result := once "rescue"
			when s_retry		then Result := once "retry"
			when s_select		then Result := once "select"
			when s_separate		then Result := once "separate"
			when s_strip		then Result := once "strip"
			when s_then			then Result := once "then"
			when s_undefine		then Result := once "undefine"
			when s_unique		then Result := once "unique"
			when s_until		then Result := once "until"
			when s_variant		then Result := once "variant"
			when s_when			then Result := once "when"

			when s_true			then Result := once "True"		-- True Boolean Value
			when s_false		then Result := once "False"		-- False Boolean Value
			when s_current		then Result := once "Current"
			when s_result		then Result := once "Result"

			when s_and			then Result := once "and"
			when s_and_then		then Result := once "and then"
			when s_or			then Result := once "or"
			when s_or_else		then Result := once "or else"
			when s_not			then Result := once "not"
			when s_xor			then Result := once "xor"
			when s_implies		then Result := once "implies"

			when s_semicolon          	then Result := once ";"
			when s_comma              	then Result := once ","
			when s_colon              	then Result := once ":"
			when s_dot                	then Result := once "."
			when s_exclamation_mark   	then Result := once "!"
			when s_arrow              	then Result := once "->"
			when s_dot_dot	         	then Result := once ".."
			when s_left_parenthesis   	then Result := once "("
			when s_right_parenthesis 	then Result := once ")"
			when s_left_bracket       	then Result := once "["
			when s_right_bracket      	then Result := once "]"
			when s_left_brace         	then Result := once "{"
			when s_right_brace        	then Result := once "}"
			when s_left_array			then Result := once "<<"
			when s_right_array		 	then Result := once ">>"
			when s_assign	           	then Result := once ":="			
			when s_reverse   	     	then Result := once "?="
			when s_dollar_sign        	then Result := once "$"
		--	when s_percent            	then Result := once "%%"
			when s_plus               	then Result := once "+"
			when s_minus              	then Result := once "-"
			when s_times              	then Result := once "*"
			when s_divide 			  	then Result := once "/"
			when s_equal              	then Result := once "="
			when s_not_equal          	then Result := once "/="
			when s_lt               	then Result := once "<"
			when s_gt       	      	then Result := once ">"
			when s_le		    	  	then Result := once "<="
			when s_ge			    	then Result := once ">="
			when s_div                	then Result := once "//"
			when s_mod                	then Result := once "\\"
			when s_power              	then Result := once "^"
			when s_bangbang				then Result := once "!!"

			when s_str_left_brace		then Result := once "%"{"
			when s_str_right_brace		then Result := once "%"}"
			when s_str_left_bracket		then Result := once "%"["
			when s_str_right_bracket	then Result := once "%"]"

  				
--			when s_free            		then Result := s.strings_n(special);		-- Free operator string   
--			when s_identifier           then Result := s.strings_n(special);		-- Feature, class or tag name                                  
--			when s_integer              then Result := once "<INTEGER>";			-- Integer Constant e.g. "42" or "12_345_678"
--			when s_string, s_string_prefix, s_string_infix, s_string_postfix
--											then Result := s.strings_n(special);	-- String Constant e.g. '"ha%/108/lo"' 
--			--when s_line_continue		then Result := once "%%"						-- Line/String continuation character        
--			when s_character            then Result := once "<CHARACTER>";			-- Character Constant e.g. "'c'" or "'%B'"    
--			when s_real                 then Result := s.strings_n(special);		-- Real Constant e.g. "1234.5678e-90"            
--			when s_bit_sequence         then Result := s.strings_n(special);		-- 010101B          
--			when s_comment              then Result := s.strings_n(special);		-- Comment, started by "--"             
			when s_eof                  then Result := once "<EOF>";					-- End Of File               

			else
				Result ?= last_any_value
				if Result = Void then
					fx_trace_local(0, <<" last_token: ", last_token.out>>)
					Result := once "####"
				end
			end
		end

feature {NONE} -- Constants

	Init_buffer_size: INTEGER = 256
				-- Initial size for `eif_buffer'

invariant

	eif_buffer_not_void: eif_buffer /= Void

end
