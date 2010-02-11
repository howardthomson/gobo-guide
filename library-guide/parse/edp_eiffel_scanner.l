%{
indexing

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
	
%}

%x IN_STR			-- inside s_string, s_string_prefix, s_string_infix, s_string_suffix
%x STR_GAP			-- between % at end-of-line and % at start of next line
%x STR_VERBATIM_LA	-- "[ ... ]"	Verbatim string, left aligned [leading whitespace stripped]
%X STR_VERBATIM		-- "{ ... }"	Verbatim string

%option nodefault outfile="edp_eiffel_scanner.e"
%option position line pre-action post-action post-eof-action

%%

----------/** Separators **/----------------------------------------------------

<*>[ ]+				{	-- Ignore separators
						fx_trace_local(0, <<"Rule match: 1 ==>", text, "<==">>)
						last_token := s_whitespace
					}
<*>[\r]+			{	-- Ignore separators
					--	fx_trace_local(0, <<"Rule match: 2 ==>", text, "<==">>)
						last_token := s_whitespace
					}
<*>[\t]+			{	-- Expand tab positions
					--	fx_trace_local(0, <<"Rule match: 3 ==>", text, "<==">>)
						last_token := s_whitespace
						t_col := column + eif_tab_offset - 1	-- 0 offset
						t_col := ((t_col + 4) // 4) * 4
						t_col := t_col + (3 * (text_count - 1))
						eif_tab_offset := t_col - column
					}
<*>\n+				{	-- Ignore Newlines
					--	fx_trace_local(0, <<"Rule match: 4 ==>", text, "<==">>)
						last_token := s_whitespace
						eif_tab_offset := 0
					}

----------/** Eiffel comments **/-----------------------------------------------

--	"--"[^\r]*			{ -- Comment to end of line
"--".*				{ -- Comment to end of line
						fx_trace_local(0, <<"Rule match: 5 ==>", text, "<==">>)
						last_token := s_comment
					--	eif_tab_offset := 0
						last_any_value := text_substring (1, text_count)
					}

----------/** Eiffel strings **/------------------------------------------------

\"\+\"								last_token := process_operator (s_str_plus)		-- "+"
\"-\"								last_token := process_operator (s_str_minus)	-- "-"
\"\*\"								last_token := process_operator (s_str_star)		-- "*"
\"\/\"								last_token := process_operator (s_str_slash)	-- "/"
\"\/\/\"							last_token := process_operator (s_str_div)		-- "/"
\"\\\\\"							last_token := process_operator (s_str_mod)		-- "\"
\"^\"								last_token := process_operator (s_str_power)	-- "^"
\"<\"								last_token := process_operator (s_str_lt)		-- "<"
\"<=\"								last_token := process_operator (s_str_le)		-- "<="
\">\"								last_token := process_operator (s_str_gt)		-- ">"
\">=\"								last_token := process_operator (s_str_ge)		-- ">="
\"[nN][oO][tT]\"					last_token := process_operator (s_str_not)		-- "not"
\"[aA][nN][dD]\"					last_token := process_operator (s_str_and)		-- "and"
\"[oO][rR]\"						last_token := process_operator (s_str_or)		-- "or"
\"[xX][oO][rR]\"					last_token := process_operator (s_str_xor)		-- "xor"
\"[aA][nN][dD]\ [tT][hH][eE][nN]\"	last_token := process_operator (s_str_andthen)	-- "and then"
\"[oO][rR]\ [eE][lL][sS][eE]\"		last_token := process_operator (s_str_orelse)	-- "or else"
\"[iI][mM][pP][lL][iI][eE][sS]\"	last_token := process_operator (s_str_implies)	-- "implies"

------------/** Free Operator **/------------------------------------------------------------

\"[@#|&][^%" \t\r\n]*\"		{	-- New definition of Free operator imminent XXX

								fx_trace_local(0, <<"Rule match: XX ==>", text, "<==">>)
								if is_operator then
									-- Preceding token is 'infix' or 'prefix'
									is_operator := False
									last_token := s_str_freeop
								else
									last_token := s_string
								end
								last_any_value := text_substring (1, text_count - 0)	-- TEMP retain "'s
							}

							
------------/** String: complete on one line without % escapes **/------------------------------
-- <INITIAL> s_string <INITIAL> ----------------

\"[^%"\n]*\"/.*\n			{	-- Includes empty string ""
								fx_trace_local(0, <<"Rule match: 13 ==>", text, "<==">>)
								last_token := s_string
								last_any_value := text
							}

------------/** Transition into string state **/------------------------------------------------

-- Transition into Simple string: <INITIAL> ".... <IN_STR>
--	\"[[{][ \t]*[^"% \t\n]+/.*\n |	-- Permits "[... and "{... requiring at least one non-blank before end-of-line
-- This excluded "[%"" from fec_src/back/call_command - line 268

\"[^\[{"%\n][^"%\n]*/.*\n |		-- Permits "... excluding "[... and "{...
\"[[{][^"%\n]+/["%\n].*\n |	-- Permits "[... and "{... requiring at least one non-blank before end-of-line
\"[[{]/% |
\"/%						{	-- " only
								fx_trace_local(0, <<"Rule match: 14 ==>", text, "<==">>)
								set_start_condition(IN_STR)
								last_token := s_string_prefix
								last_any_value := text
							}

-- Transition into Verbatim string: <INITIAL> ".... <STR_VERBATIMxx>

--	\"\[[^\]"%\n]*/.*\n |
--	\"\{[^}"%\n]*/.*\n

-- ##NOTE## Verbatim strings, in ETL4(?) permit a Simple_string between the " and the [|{, which must match
-- a corresponding Simple_string between the ]|} and closing ".
-- That is not currently allowed for.

\"\[[ \t]*/\n |
\"\{[ \t]*/\n				{
								fx_trace_local(0, <<"Rule match: 14a: start verbatim string ==>", text, "<==">>)
								if text_item(2) = '{' then
									set_start_condition(STR_VERBATIM)
									last_token := s_str_left_brace
								else
									set_start_condition(STR_VERBATIM_LA)
									last_token := s_str_left_bracket
								end
								eif_string_valid := True
							}


--###################################

--	s_str_left_bracket		-- "[
--	s_str_right_bracket		-- ]"
--	s_str_left_brace		-- "{
--	s_str_right_brace		-- }"




------------------------------------------
-- String termination handling

-- End of string
<IN_STR>[^"%\n]*\"/.*\n		{	-- end of s_string, s_string_suffix
								fx_trace_local(0, <<"Rule match: 23 ==>", text, "<==">>)
								last_token := s_string_suffix
								last_any_value := text
								set_start_condition (INITIAL)
							}

<STR_VERBATIM,STR_VERBATIM_LA>[^\]}"%\n]*[]}]\"/.*\n	{	-- End of verbatim string
								fx_trace_local(0, <<"Rule: Verbatim string end ==>", text, "<==">>)
								if text_item(1) = '}' then
									last_token := s_str_right_brace
								else
									last_token := s_str_right_bracket
								end
								set_start_condition(INITIAL)
								last_any_value := text
							}


-----------------------------------------------------------
-- Inside and end of gaps between partial strings ---------

-- Gap Start
<IN_STR>%/[ \t]*\r?\n		{
								last_token := s_str_gap_start
								set_start_condition(STR_GAP)
							}
-- Permitted inter-gap characters
<STR_GAP>[ \t]*\r?\n[ \t]*/.*\n	{
								last_token := s_whitespace
							}

-- Gap end
<STR_GAP>%/.*\n				{	-- Transition from end of gap to start of infix / suffix continuation
								fx_trace_local(0, <<"Rule match 21b ==>", text, "<==">>)
								last_token := s_str_gap_end
								set_start_condition(IN_STR)
							}


-- Inside string continuation --------------------------------
--------------------------------------------------------------

-- <IN_STR,VERBATIMxx> ... <IN_STR,VERBATIMxx>: Infix string content

-- Plain text
<IN_STR>[^%"\n]+/.*\n		{	--
								fx_trace_local(0, <<"Rule match 18a: extend string standard ==>", text, "<==">>)
								last_token := s_string_infix
								last_any_value := text
							}
-- Plain text
--	<STR_VERBATIM>[^}%\n]+/.*\n	{	--
--	<STR_VERBATIM>([^}%\n]|(}[^"%\n]))+}/\r?\n	{	--
<STR_VERBATIM>([^}%\n]|(}[^"%\n]))+}?/.*\n	{
								fx_trace_local(0, <<"Rule match 18a: extend string standard ==>", text, "<==">>)
								last_token := s_string_infix
								last_any_value := text
							}
-- Plain text
--	<STR_VERBATIM_LA>[^\]%\n]+/.*\n			{	--
--	<STR_VERBATIM_LA>([^\]%\n]|(\][^"%\n]))+\]/\r?\n
<STR_VERBATIM_LA>([^\]%\n]|(\][^"%\n]))+\]?/.*\n	{
								fx_trace_local(0, <<"Rule match 18a: extend string standard ==>", text, "<==">>)
								last_token := s_string_infix
								last_any_value := text
							}

-- String %/ddd/ construct
<IN_STR,STR_VERBATIM,STR_VERBATIM_LA>%\/[0-9]{1}\/		{
								fx_trace_local(0, <<"Rule match: 15 ==>", text, "<==">>)
								last_token := s_string_decimal_1
								last_any_value := text_substring(3,3)
							}
-- String %/ddd/ construct
<IN_STR,STR_VERBATIM,STR_VERBATIM_LA>%\/[0-9]{2}\/		{
								fx_trace_local(0, <<"Rule match: 15 ==>", text, "<==">>)
							--	eif_buffer.append_string(text)
								last_token := s_string_decimal_2
								last_any_value := text_substring(3,4)
							}
							
-- String %/ddd/ construct
<IN_STR,STR_VERBATIM,STR_VERBATIM_LA>%\/[0-9]{3}\/		{
								fx_trace_local(0, <<"Rule match: 16 ==>", text, "<==">>)
								if text_substring(3,5).to_integer > Platform.Maximum_character_code then
									last_token := s_raw_text
								else
									last_token := s_string_decimal_3
									last_any_value := text_substring(3,5)
								end
							}

-- Erroneous %/ddd/ construct
<IN_STR,STR_VERBATIM,STR_VERBATIM_LA>%\/([0-9]+(\/)?)?	{
								fx_trace_local(0, <<"Rule match: 17 ==>", text, "<==">>)
								last_token := s_raw_text
								last_any_value := text
							}

-- String %x construct
<IN_STR,STR_VERBATIM,STR_VERBATIM_LA>%[ABCDFHLNQRSTUV%'"()<>]/.*\n	{
								fx_trace_local(0, <<"Rule match: 18 ==>", text, "<==">>)
								last_token := s_string_escaped
								last_any_value := text
							}

---------------/** Raw Text not matched by other string rules **/--------------------------
<IN_STR,STR_VERBATIM,STR_VERBATIM_LA>[^"%\n]*/\n			{	-- erroneous end of string
								fx_trace_local(0, <<"Rule match: 20 ==>", text, "<==">>)
								last_token := s_raw_text
								last_any_value := text
								set_start_condition (INITIAL)
							}

-- Erroneous text between start-of-line and gap end
<STR_GAP>[^%]*%/.*\n		{
								last_token := s_raw_text
								last_any_value := text
								set_start_condition(IN_STR)
							}
							
-- Erroneous text between gap start and end-of-line
<STR_GAP>[^%]*/\n			{
								fx_trace_local(0, <<"Rule match: 22 ==>", text, "<==">>)
								last_token := s_raw_text
								last_any_value := text
								set_start_condition (INITIAL)
							}

----------/** Eiffel symbols **/------------------------------------------------

"+"					last_token := s_plus
"-"					last_token := s_minus
"*"					last_token := s_times
"/"					last_token := s_divide
"^"					last_token := s_power
"="					last_token := s_equal
">"					last_token := s_gt
"<"					last_token := s_lt
"."					last_token := s_dot
";"					last_token := s_semicolon
","					last_token := s_comma
":"					last_token := s_colon
"!"					last_token := s_exclamation_mark
"("					last_token := s_left_parenthesis
")"					last_token := s_right_parenthesis
"{"					last_token := s_left_brace
"}"					last_token := s_right_brace
"["					last_token := s_left_bracket
"]"					last_token := s_right_bracket
"$"					last_token := s_dollar_sign
"?"					last_token := s_query
"~"					last_token := s_tilde

"//"				last_token := s_div
"\\\\"				last_token := s_mod
"/="				last_token := s_not_equal
">="				last_token := s_ge
"<="				last_token := s_le
"!!"				last_token := s_bangbang
"->"				last_token := s_arrow
".."				last_token := s_dot_dot
"<<"				last_token := s_left_array
">>"				last_token := s_right_array
":="				last_token := s_assign
"?="				last_token := s_reverse


----------/** Reserved words **/------------------------------------------------

[aA][lL][iI][aA][sS]					last_token := s_alias
[aA][lL][lL]							last_token := s_all
[aA][nN][dD]							last_token := s_and
[aA][sS]								last_token := s_as
[bB][iI][tT]							last_token := s_bit		-- 
[cC][hH][eE][cC][kK]					last_token := s_check
[cC][lL][aA][sS][sS]					last_token := s_class
[cC][rR][eE][aA][tT][eE]				last_token := s_create
[cC][rR][eE][aA][tT][iI][oO][nN]		last_token := s_creation
[cC][uU][rR][rR][eE][nN][tT]			last_token := s_current
[dD][eE][bB][uU][gG]					last_token := s_debug
[dD][eE][fF][eE][rR][rR][eE][dD]		last_token := s_deferred
[dD][oO]								last_token := s_do
[eE][lL][sS][eE]						last_token := s_else
[eE][lL][sS][eE][iI][fF]				last_token := s_elseif
[eE][nN][dD]							last_token := s_end
[eE][nN][sS][uU][rR][eE]				last_token := s_ensure
[eE][xX][pP][aA][nN][dD][eE][dD]		last_token := s_expanded
[eE][xX][pP][oO][rR][tT]				last_token := s_export
[eE][xX][tT][eE][rR][nN][aA][lL]		last_token := s_external
[fF][aA][lL][sS][eE]					last_token := s_false
[fF][eE][aA][tT][uU][rR][eE]			last_token := s_feature
[fF][rR][oO][mM]						last_token := s_from
[fF][rR][oO][zZ][eE][nN]				last_token := s_frozen
[iI][fF]								last_token := s_if
[iI][mM][pP][lL][iI][eE][sS]			last_token := s_implies
[iI][nN][dD][eE][xX][iI][nN][gG]		last_token := s_indexing
[iI][nN][fF][iI][xX]				{
										is_operator := True
										last_token := s_infix
									}
[iI][nN][hH][eE][rR][iI][tT]			last_token := s_inherit
[iI][nN][sS][pP][eE][cC][tT]			last_token := s_inspect
[iI][nN][vV][aA][rR][iI][aA][nN][tT]	last_token := s_invariant
[iI][sS]								last_token := s_is
[lL][iI][kK][eE]						last_token := s_like
[lL][oO][cC][aA][lL]					last_token := s_local
[lL][oO][oO][pP]						last_token := s_loop
[nN][oO][tT]							last_token := s_not
[oO][bB][sS][oO][lL][eE][tT][eE]		last_token := s_obsolete
[oO][lL][dD]							last_token := s_old
[oO][nN][cC][eE]						last_token := s_once
[oO][rR]								last_token := s_or
[pP][rR][eE][cC][uU][rR][sS][oO][rR]	last_token := s_precursor
[pP][rR][eE][fF][iI][xX]			{
										is_operator := True
										last_token := s_prefix
									}
[rR][eE][dD][eE][fF][iI][nN][eE]		last_token := s_redefine
[rR][eE][nN][aA][mM][eE]				last_token := s_rename
[rR][eE][qQ][uU][iI][rR][eE]			last_token := s_require
[rR][eE][sS][cC][uU][eE]				last_token := s_rescue
[rR][eE][sS][uU][lL][tT]				last_token := s_result
[rR][eE][tT][rR][yY]					last_token := s_retry
[sS][eE][lL][eE][cC][tT]				last_token := s_select
[sS][eE][pP][aA][rR][aA][tT][eE]		last_token := s_separate
[sS][tT][rR][iI][pP]					last_token := s_strip
[tT][hH][eE][nN]						last_token := s_then
[tT][rR][uU][eE]						last_token := s_true
[uU][nN][dD][eE][fF][iI][nN][eE]		last_token := s_undefine
[uU][nN][iI][qQ][uU][eE]				last_token := s_unique
[uU][nN][tT][iI][lL]					last_token := s_until
[vV][aA][rR][iI][aA][nN][tT]			last_token := s_variant
[wW][hH][eE][nN]						last_token := s_when
[xX][oO][rR]							last_token := s_xor


----------/** Eiffel identifiers **/--------------------------------------------

[a-zA-Z][a-zA-Z0-9_]*	{
				fx_trace_local(0, <<"Rule match: 6 ==>", text, "<==">>)
				last_token := s_identifier
				last_any_value := text
			}


----------/** Eiffel free operators **/-----------------------------------------

[@#|&][^%" \t\r\n]*	{
				fx_trace_local(0, <<"Rule match: 7 ==>", text, "<==">>)
				last_token := s_freeop
				last_any_value := text
			}

		-- Note: Accepts non-printable characters as well,
		-- provided that they are not break characters.


----------/** Eiffel characters **/---------------------------------------------

\'[^%\n']\'			last_token := s_character; last_any_value := text
	-- The following line is not correct Eiffel but
	-- it appears in some Halstenbach Eiffel libraries.
\'\'\'				last_token := s_character_escaped; last_any_value := text
\'%A\'				last_token := s_character_escaped; last_any_value := text
\'%B\'				last_token := s_character_escaped; last_any_value := text
\'%C\'				last_token := s_character_escaped; last_any_value := text
\'%D\'				last_token := s_character_escaped; last_any_value := text
\'%F\'				last_token := s_character_escaped; last_any_value := text
\'%H\'				last_token := s_character_escaped; last_any_value := text
\'%L\'				last_token := s_character_escaped; last_any_value := text
\'%N\'				last_token := s_character_escaped; last_any_value := text
\'%Q\'				last_token := s_character_escaped; last_any_value := text
\'%R\'				last_token := s_character_escaped; last_any_value := text
\'%S\'				last_token := s_character_escaped; last_any_value := text
\'%T\'				last_token := s_character_escaped; last_any_value := text
\'%U\'				last_token := s_character_escaped; last_any_value := text
\'%V\'				last_token := s_character_escaped; last_any_value := text
\'%%\'				last_token := s_character_escaped; last_any_value := text
\'%\'\'				last_token := s_character_escaped; last_any_value := text
\'%\"\'				last_token := s_character_escaped; last_any_value := text
\'%\(\'				last_token := s_character_escaped; last_any_value := text
\'%\)\'				last_token := s_character_escaped; last_any_value := text
\'%<\'				last_token := s_character_escaped; last_any_value := text
\'%>\'				last_token := s_character_escaped; last_any_value := text

\'%\/[0-9]{1}\/\'	{	-- '%/d/'
						fx_trace_local(0, <<"Rule match: 8 ==>", text, "<==">>)
					--	code_ := text_substring (4, text_count - 2).to_integer
						last_token := s_character_decimal_1
						last_any_value := text_substring(4,4); --	INTEGER_.to_character (code_)	-- TEMP
					}
\'%\/[0-9]{2}\/\'	{	-- '%/dd/'
						fx_trace_local(0, <<"Rule match: 9 ==>", text, "<==">>)
					--	code_ := text_substring (4, text_count - 2).to_integer
						last_token := s_character_decimal_2
						last_any_value := text_substring(4,5); --	INTEGER_.to_character (code_)	-- TEMP
					}
\'%\/[0-9]{3}\/\'	{	-- '%/ddd/'
						fx_trace_local(0, <<"Rule match: 10 ==>", text, "<==">>)
					--	code_ := text_substring (4, text_count - 2).to_integer
						last_token := s_character_decimal_3
						last_any_value := text_substring(4,6); --	INTEGER_.to_character (code_)	-- TEMP
					}
					
	-- The following line is not correct Eiffel but
	-- it appears in some Visual Eiffel libraries.
\'%.\'				{
						fx_trace_local(0, <<"Rule match: 11 ==>", text, "<==">>)
						last_token := s_character_escaped;
						last_any_value := text;	-- WAS text_item (3)
					}

\'.{1,2}			|
\'%\/[0-9]+(\/)?		{
							fx_trace_local(0, <<"Rule match: 12 ==>", text, "<==">>)
							last_token := s_raw_text	-- Catch-all rules (no backing up)
						}


----------/** Eiffel bits **/---------------------------------------------------

[0-1]+[bB]				last_token := s_bit_sequence; last_any_value := text


----------/** Eiffel integers **/-----------------------------------------------

0[xX][0-9a-fA-F]+	{	-- Hexadecimal integer
						last_token := s_integer; last_any_value := text
					}

[0-9]+				{
						last_token := s_integer
						last_any_value := text
					}
[0-9]{1,3}(_[0-9]{3})+	last_token := s_integer; last_any_value := text
[0-9][0-9_]+			last_token := s_raw_text	-- Catch-all rule (no backing up)


---------/** Eiffel reals **/---------------------------------------------------

[0-9]+\./[^.0-9]					|
[0-9]+\.[0-9]*[eE][+-]?[0-9]+		|
[0-9]*\.[0-9]+([eE][+-]?[0-9]+)?	{
						last_token := s_real
						last_any_value := text
					}
[0-9]{1,3}(_[0-9]{3})+\./[^.0-9]	|
[0-9]{1,3}(_[0-9]{3})*\.([0-9]{1,3}(_[0-9]{3})*)?[eE][+-]?[0-9]{1,3}(_[0-9]{3})*	|
([0-9]{1,3}(_[0-9]{3})*)?\.[0-9]{1,3}(_[0-9]{3})*([eE][+-]?[0-9]{1,3}(_[0-9]{3})*)?	{
						last_token := s_real
						last_any_value := text
					}

		-- The first and fourth expressions use a trailing context
		-- to make sure that an integer followed by two dots is
		-- not recognized as a real followed by a dot.

--------------------------------------------------------------------------------

<*><<EOF>>		{	-- End of file
					last_token := s_eof
					terminate
				}

--------------------------------------------------------------------------------
-- s_raw_text ------------------------------------------------------------------

<IN_STR>.|\n					{	-- Catch-all rules (no backing up)
										fx_trace_local(0, <<"Rule match: 24a ==>", text, "<==">>)
									last_token := s_raw_text
									last_any_value := text
									set_start_condition (INITIAL)
								}
					--#####################################################################
<*>.|\n			{	--### Should accumulate raw_text here, and flush out in post_action ###
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
				}

--	<*>.|\n	{
--			fx_trace(0, <<"PANIC -- Default rule ???">>)
--		}
--------------------------------------------------------------------------------
%%

feature {NONE} -- Error reporting

	file_name: STRING is
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

	make_lex is
			-- Create a new Eiffel scanner.
		do
			make_with_buffer (Empty_buffer)
--			eif_buffer := STRING_.make (Init_buffer_size)
			create eif_buffer.make (Init_buffer_size)
			eif_tab_offset := 0
			create_keyword := True
			make_scanner
		end

	make_scanner is
		deferred
		end

feature -- Initialization

	reset_scanner is
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

	process_operator (op: INTEGER): INTEGER is
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

	pre_action is
		do
			--symbol_start_position := current_position
			set_symbol_start_position
		end

	set_symbol_start_position is
		deferred
		end

feature	
	token_count: INTEGER -- TEMP
	max_column,
	max_line: INTEGER

feature {NONE}

	post_action is
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

	add_symbol(i: INTEGER; s: INTEGER) is
		deferred
		end

	start_cond_str: STRING is
		do
			if		start_condition = INITIAL			then	Result := once "INITIAL"
			elseif	start_condition = IN_STR			then	Result := once "IN_STR"
			elseif	start_condition = STR_VERBATIM		then	Result := once "VERBATIM"
			elseif	start_condition = STR_VERBATIM_LA 	then	Result := once "VERBATIM_LA"
			elseif	start_condition = STR_GAP			then	Result := once "STR_GAP"
			else	Result := once "???"
			end
		end

	post_eof_action is
		do
		--	fx_trace(0, <<once "Token count: ", token_count.out>>)
		--	list_file
		end

	fx_trace_local(n: INTEGER; sa: ARRAY[STRING]) is
		do
	--		fx_trace(n, sa)
		end

feature {SCANNER_SYMBOL}

	token_string(t: INTEGER): STRING is
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

	Init_buffer_size: INTEGER is 256
				-- Initial size for `eif_buffer'

invariant

	eif_buffer_not_void: eif_buffer /= Void

end
