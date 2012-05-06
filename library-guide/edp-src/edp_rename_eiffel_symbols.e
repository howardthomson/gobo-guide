--|---------------------------------------------------------|
--| Copyright (c) Howard Thomson 1999,2000,2001,2006		|
--| 52 Ashford Crescent										|
--| Ashford, Middlesex TW15 3EB								|
--| United Kingdom											|
--|---------------------------------------------------------|
class EDP_RENAME_EIFFEL_SYMBOLS

inherit	--insert

--	EDP_EIFFEL_SYMBOLS
	ET_EIFFEL_TOKENS

	
		rename
			E_AGENT 				as		 s_agent,
			E_ALIAS		 			as		 s_alias,	
			E_ALL 					as		 s_all,
			E_AS		 			as		 s_as,
			E_CHECK 				as		 s_check,
			E_CLASS 				as		 s_class,
			E_CREATE 				as		 s_create,
			E_CREATION 				as		 s_creation,
			E_DEBUG 				as		 s_debug,
			E_DEFERRED 				as		 s_deferred,
			E_DO 					as		 s_do,
			E_ELSE 					as		 s_else,
			E_ELSEIF 				as		 s_elseif,
			E_END 					as		 s_end,
			E_ENSURE 				as		 s_ensure,
			E_EXPANDED 				as		 s_expanded,
			E_EXPORT 				as		 s_export,
			E_EXTERNAL 				as		 s_external,
			E_FEATURE 				as		 s_feature,
			E_FROM 					as		 s_from,
			E_FROZEN 				as		 s_frozen,
			E_IF 					as		 s_if,
			E_INDEXING 				as		 s_indexing,
			E_INFIX 				as		 s_infix,
			E_INHERIT 				as		 s_inherit,
			E_INSPECT 				as		 s_inspect,
			E_INVARIANT 			as		 s_invariant,
			E_IS 					as		 s_is,
			E_LIKE 					as		 s_like,
			E_LOCAL 				as		 s_local,
			E_LOOP 					as		 s_loop,
			E_OBSOLETE 				as		 s_obsolete,
			E_OLD 					as		 s_old,
			E_ONCE 					as		 s_once,
			E_PREFIX 				as		 s_prefix,
			E_RECAST 				as		 s_recast,
			E_REDEFINE 				as		 s_redefine,
			E_REFERENCE 			as		 s_reference,
			E_RENAME 				as		 s_rename,
			E_REQUIRE 				as		 s_require,
			E_RESCUE 				as		 s_rescue,
			E_RETRY 				as		 s_retry,
			E_SELECT 				as		 s_select,
			E_SEPARATE 				as		 s_separate,
			E_STRIP 				as		 s_strip,
			E_THEN 					as		 s_then,
			E_UNDEFINE 				as		 s_undefine,
			E_UNIQUE 				as		 s_unique,
			E_UNTIL 				as		 s_until,
			E_VARIANT 				as		 s_variant,
			E_WHEN 					as		 s_when,
			E_PRECURSOR 			as		 s_precursor,
			E_TRUE 					as		 s_true,
			E_FALSE 				as		 s_false,
			E_CURRENT 				as		 s_current,
			E_RESULT 				as		 s_result,
			E_AND 					as		 s_and,
			E_OR 					as		 s_or,
			E_NOT 					as		 s_not,
			E_XOR 					as		 s_xor,
			E_IMPLIES 				as		 s_implies,


			E_CHARACTER 			as		 s_character,

			E_INTEGER 				as		 s_integer,
			E_REAL 					as		 s_real,
			E_BIT		 			as		 s_bit_sequence,
			E_IDENTIFIER 			as		 s_identifier,
			E_STRING 				as		 s_string,


			E_ARROW 				as		 s_arrow,
			E_DOTDOT 				as		 s_dot_dot,
			E_LARRAY 				as		 s_left_array,
			E_RARRAY 				as		 s_right_array,
			E_ASSIGN 				as		 s_assign,
			E_REVERSE 				as		 s_reverse,

			E_STRPLUS 				as		 s_str_plus,
			E_STRMINUS 				as		 s_str_minus,
			E_STRSTAR 				as		 s_str_star,
			E_STRSLASH 				as		 s_str_slash,
			E_STRDIV 				as		 s_str_div,
			E_STRMOD 				as		 s_str_mod,
			E_STRPOWER 				as		 s_str_power,
			E_STRLT 				as		 s_str_lt,
			E_STRLE 				as		 s_str_le,
			E_STRGT 				as		 s_str_gt,
			E_STRGE 				as		 s_str_ge,
			E_STRAND 				as		 s_str_and,
			E_STROR 				as		 s_str_or,
			E_STRXOR 				as		 s_str_xor,
			E_STRNOT 				as		 s_str_not,
			E_STRANDTHEN 			as		 s_str_andthen,
			E_STRORELSE 			as		 s_str_orelse,
			E_STRIMPLIES 			as		 s_str_implies,
			E_STRFREEOP				as		 s_str_freeop,

			E_BREAK		 			as		 s_whitespace,
			
			E_NE		 			as		 s_not_equal,
			E_LE 					as		 s_le,
			E_GE 					as		 s_ge,
			E_DIV 					as		 s_div,
			E_MOD 					as		 s_mod,
			E_FREEOP 				as		 s_freeop
		end

	UT_CHARACTER_CODES
		rename
	--		Question_mark_code		as		 s_query,
	--		Dollar_code 			as		 s_dollar_sign,
	--		Equal_code 				as		 s_equal,

	--		Plus_code				as		 s_plus,
	--		Minus_code 				as		 s_minus,
	--		Star_code 				as		 s_times,
	--		Slash_code 				as		 s_divide,

	--		Caret_code 				as		 s_power,
	--		Less_than_code			as		 s_lt,
	--		Greater_than_code		as		 s_gt,
	--		Exclamation_code 		as		 s_exclamation_mark,
	--		Left_parenthesis_code	as		 s_left_parenthesis,
	--		Right_parenthesis_code 	as		 s_right_parenthesis,
	--		Left_bracket_code		as		 s_left_bracket,
	--		Right_bracket_code 		as		 s_right_bracket,
	--		Left_brace_code 		as		 s_left_brace,
	--		Right_brace_code 		as		 s_right_brace,
	--		Dot_code 				as		 s_dot,
	--		Semicolon_code 			as		 s_semicolon,
	--		Colon_code 				as		 s_colon,
	--		Comma_code 				as		 s_comma,
	--		Tilde_code 				as		 s_tilde
		end

feature
		--	E_and_then 				as		 s_and_then,
		--	E_or_else 				as		 s_or_else,

		--	E_character_escaped 	as		 s_character_escaped,
		--	E_character_decimal_1 	as		 s_character_decimal_1,
		--	E_character_decimal_2 	as		 s_character_decimal_2,
		--	E_character_decimal_3 	as		 s_character_decimal_3,

		--	E_string_prefix 		as		 s_string_prefix,
		--	E_str_left_bracket 		as		 s_str_left_bracket,
		--	E_str_left_brace 		as		 s_str_left_brace,
		--	E_string_infix 			as		 s_string_infix,
		--	E_string_escaped 		as		 s_string_escaped,
		--	E_string_decimal_1 		as		 s_string_decimal_1,
		--	E_string_decimal_2 		as		 s_string_decimal_2,
		--	E_string_decimal_3 		as		 s_string_decimal_3,
		--	E_str_gap_start 		as		 s_str_gap_start,
		--	E_str_gap_end 			as		 s_str_gap_end,
		--	E_string_suffix 		as		 s_string_suffix,
		--	E_STR_RIGHT_BRACKET 	as		 s_str_right_bracket,
		--	E_STR_RIGHTBRACE 		as		 s_str_right_brace,
		--	E_COMMENT 				as		 s_comment,
		--	E_bangbang 				as		 s_bangbang,
		--	E_raw_text 				as		 s_raw_text,
		--	E_edit_text 			as		 s_edit_text,
		--	E_eof 					as		 s_eof,		-- == 0
		--	E_BIT 					as		 s_bit,



	 s_and_then				: INTEGER = 401
	 s_or_else				: INTEGER = 402

	 s_character_escaped	: INTEGER = 403
	 s_character_decimal_1	: INTEGER = 404
	 s_character_decimal_2	: INTEGER = 405
	 s_character_decimal_3	: INTEGER = 406

	 s_string_prefix		: INTEGER = 407
	 s_str_left_bracket		: INTEGER = 408
	 s_str_left_brace		: INTEGER = 409
	 s_string_infix			: INTEGER = 410
	 s_string_escaped		: INTEGER = 411
	 s_string_decimal_1		: INTEGER = 412
	 s_string_decimal_2		: INTEGER = 413
	 s_string_decimal_3		: INTEGER = 414
	 s_str_gap_start		: INTEGER = 415
	 s_str_gap_end			: INTEGER = 416
	 s_string_suffix		: INTEGER = 417
	 s_str_right_bracket	: INTEGER = 418
	 s_str_right_brace		: INTEGER = 419
	 s_comment				: INTEGER = 420
	 s_bangbang				: INTEGER = 421
	 s_raw_text				: INTEGER = 422
	 s_edit_text			: INTEGER = 423
	 s_eof					: INTEGER = 424
	 s_bit					: INTEGER = 425



--	s_eof: INTEGER is 0

end