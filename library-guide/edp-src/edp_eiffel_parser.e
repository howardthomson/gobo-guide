--|---------------------------------------------------------|
--| Copyright (c) Howard Thomson 1999,2000,2001,2006		|
--| 52 Ashford Crescent										|
--| Ashford, Middlesex TW15 3EB								|
--| United Kingdom											|
--|---------------------------------------------------------|
note

	description:

		"Eiffel Parser for EDP"

	copyright: "Howard Thomson"
	license: "Eiffel Forum License v2 (see forum.txt)"

class EDP_EIFFEL_PARSER

inherit

	ET_EIFFEL_PARSER
		rename
			strings as gobo_strings
		undefine
			gobo_strings
		redefine
		--	parse_file,
			reset,
			has_break,
			has_comment,
			last_literal_count,
			last_literal,
			last_identifier,
			read_token
		--	strings
		end

-- insert

	EDP_GLOBAL

--	EDP_FILE_NAMES
--		rename
--			make as make_edp_file_names
--		end

create

	make, make_with_factory

feature -- Creation / Initialization

	reset
		do
			scanner := Void
			precursor
		end

feature -- Access

	scanner: SCANNER

feature -- Parsing

	x_parse_file (a_file: KI_CHARACTER_INPUT_STREAM; a_filename: STRING; a_time_stamp: INTEGER; a_cluster: ET_CLUSTER)
			-- Parse all classes in `a_file' within cluster `a_cluster'.
			-- `a_filename' is the filename of `a_file' and `a_time_stamp'
			-- its time stamp just before it was open.
			-- Set `overriding_class_added' if a class overriding
			-- another one has been added.
		require
			a_file_not_void: a_file /= Void
			a_file_open_read: a_file.is_open_read
			a_filename_not_void: a_filename /= Void
			a_cluster_not_void: a_cluster /= Void
		do
			overriding_class_added := False
			if not is_null then
				debug ("GELINT")
					std.error.put_string ("Parsing file '")
					std.error.put_string (a_filename)
					std.error.put_line ("%'")
				end
				filename := a_filename
				time_stamp := a_time_stamp
				cluster := a_cluster

				-- Create scanner, from a_filename


				yyparse
				reset
			end
		rescue
			reset
		end

feature -- Tokens

	has_break: BOOLEAN
			-- Has a break been scanned?
		do
			if scanner = Void then
				Result := Precursor
			else
				check false end
				-- Note ensure assertion!
			-- Result := False
			end
--		ensure
--			definition: Result = (last_break_end > last_text_count)
		end

	has_comment: BOOLEAN
			-- Has a comment been scanned?
		do
			if scanner = Void then
				Result := Precursor
			else
				check false end
				-- Note ensure assertion!
				-- Result := False
			end
--		ensure
--			definition: Result = (last_comment_end > last_text_count)
		end

	last_literal_count: INTEGER
			-- Number of characters in `last_literal'
		do
			if scanner = Void then
				Result := Precursor
			else
				check false end
				-- Note ensure assertion!
			end
--		ensure
--			last_literal_count_positive: Result >= 0
--			definition: Result = last_literal.count
		end

	last_literal: STRING
			-- Last literal scanned
		do
			if scanner = Void then
				Result := Precursor
			else
				check False end
			end
--		ensure
--			last_literal_not_void: Result /= Void
		end

	last_identifier: ET_IDENTIFIER
			-- Last identifier scanned
		local
		do
			if scanner = Void then
				Result := Precursor
			else
				check false end
			end
--		ensure
--			last_identifier_not_void: Result /= Void
		end

feature {NONE} -- Processing

--###################################################################################

	read_token
		do
			if scanner /= Void then
				read_scanner_token
			else
				precursor
			end
		end

	read_scanner_token
			-- Read next token from the scanner
			-- Combine/skip scanner tokens as necessary
		local
			l_symbol: SCANNER_SYMBOL
			s_type: INTEGER	-- TEMP
		do
			last_token := s_type	-- symbol.type
			inspect s_type	-- symbol.type

			when E_AGENT		then	last_et_keyword_value := ast_factory.new_agent_keyword		(Current)
										last_et_keyword_value.set_scanner_symbol (l_symbol)
			when E_ALIAS		then	last_et_keyword_value := ast_factory.new_alias_keyword		(Current)
										last_et_keyword_value.set_scanner_symbol (l_symbol)
			when E_ALL			then	last_et_keyword_value := ast_factory.new_all_keyword		(Current)
										last_et_keyword_value.set_scanner_symbol (l_symbol)
			when E_AS			then	last_et_keyword_value := ast_factory.new_as_keyword			(Current)
										last_et_keyword_value.set_scanner_symbol (l_symbol)
			when E_CHECK		then	last_et_keyword_value := ast_factory.new_check_keyword		(Current)
										last_et_keyword_value.set_scanner_symbol (l_symbol)
			when E_CLASS		then	last_et_keyword_value := ast_factory.new_class_keyword		(Current)
										last_et_keyword_value.set_scanner_symbol (l_symbol)
			when E_CREATION 	then	last_et_keyword_value := ast_factory.new_creation_keyword	(Current)
										last_et_keyword_value.set_scanner_symbol (l_symbol)
			when E_DEBUG		then	last_et_keyword_value := ast_factory.new_debug_keyword		(Current)
										last_et_keyword_value.set_scanner_symbol (l_symbol)
			when E_DEFERRED		then	last_et_keyword_value := ast_factory.new_deferred_keyword	(Current)
										last_et_keyword_value.set_scanner_symbol (l_symbol)
			when E_DO			then	last_et_keyword_value := ast_factory.new_do_keyword			(Current)
										last_et_keyword_value.set_scanner_symbol (l_symbol)
			when E_ELSE			then	last_et_keyword_value := ast_factory.new_else_keyword		(Current)
										last_et_keyword_value.set_scanner_symbol (l_symbol)
			when E_ELSEIF		then	last_et_keyword_value := ast_factory.new_elseif_keyword		(Current)
										last_et_keyword_value.set_scanner_symbol (l_symbol)
			when E_END			then	last_et_keyword_value := ast_factory.new_end_keyword		(Current)
										last_et_keyword_value.set_scanner_symbol (l_symbol)
			when E_ENSURE		then	last_et_keyword_value := ast_factory.new_ensure_keyword		(Current)
										last_et_keyword_value.set_scanner_symbol (l_symbol)
			when E_EXPANDED 	then 	last_et_keyword_value := ast_factory.new_expanded_keyword	(Current)
										last_et_keyword_value.set_scanner_symbol (l_symbol)
			when E_EXPORT		then	last_et_keyword_value := ast_factory.new_export_keyword		(Current)
										last_et_keyword_value.set_scanner_symbol (l_symbol)
			when E_EXTERNAL 	then	last_et_keyword_value := ast_factory.new_external_keyword	(Current)
										last_et_keyword_value.set_scanner_symbol (l_symbol)
			when E_FEATURE		then	last_et_keyword_value := ast_factory.new_feature_keyword	(Current)
										last_et_keyword_value.set_scanner_symbol (l_symbol)
			when E_FROM			then	last_et_keyword_value := ast_factory.new_from_keyword		(Current)
										last_et_keyword_value.set_scanner_symbol (l_symbol)
			when E_FROZEN		then	last_et_keyword_value := ast_factory.new_frozen_keyword		(Current)
										last_et_keyword_value.set_scanner_symbol (l_symbol)
			when E_IF			then	last_et_keyword_value := ast_factory.new_if_keyword			(Current)
										last_et_keyword_value.set_scanner_symbol (l_symbol)
			when E_INDEXING 	then	last_et_keyword_value := ast_factory.new_indexing_keyword	(Current)
										last_et_keyword_value.set_scanner_symbol (l_symbol)
			when E_INFIX		then	last_et_keyword_value := ast_factory.new_infix_keyword		(Current)
										last_et_keyword_value.set_scanner_symbol (l_symbol)
			when E_INHERIT		then	last_et_keyword_value := ast_factory.new_inherit_keyword	(Current)
										last_et_keyword_value.set_scanner_symbol (l_symbol)
			when E_INSPECT		then	last_et_keyword_value := ast_factory.new_inspect_keyword	(Current)
										last_et_keyword_value.set_scanner_symbol (l_symbol)
			when E_INVARIANT 	then	last_et_keyword_value := ast_factory.new_invariant_keyword	(Current)
										last_et_keyword_value.set_scanner_symbol (l_symbol)
			when E_IS			then	last_et_keyword_value := ast_factory.new_is_keyword			(Current)
										last_et_keyword_value.set_scanner_symbol (l_symbol)
			when E_LIKE			then	last_et_keyword_value := ast_factory.new_like_keyword		(Current)
										last_et_keyword_value.set_scanner_symbol (l_symbol)
			when E_LOCAL		then	last_et_keyword_value := ast_factory.new_local_keyword		(Current)
										last_et_keyword_value.set_scanner_symbol (l_symbol)
			when E_LOOP			then	last_et_keyword_value := ast_factory.new_loop_keyword		(Current)
										last_et_keyword_value.set_scanner_symbol (l_symbol)
			when E_OBSOLETE 	then	last_et_keyword_value := ast_factory.new_obsolete_keyword	(Current)
										last_et_keyword_value.set_scanner_symbol (l_symbol)
			when E_OLD			then	last_et_keyword_value := ast_factory.new_old_keyword		(Current)
										last_et_keyword_value.set_scanner_symbol (l_symbol)
			when E_PREFIX		then	last_et_keyword_value := ast_factory.new_prefix_keyword		(Current)
										last_et_keyword_value.set_scanner_symbol (l_symbol)
			when E_REDEFINE		then	last_et_keyword_value := ast_factory.new_redefine_keyword	(Current)
										last_et_keyword_value.set_scanner_symbol (l_symbol)
			when E_RENAME		then	last_et_keyword_value := ast_factory.new_rename_keyword		(Current)
										last_et_keyword_value.set_scanner_symbol (l_symbol)
			when E_REQUIRE		then	last_et_keyword_value := ast_factory.new_require_keyword	(Current)
										last_et_keyword_value.set_scanner_symbol (l_symbol)
			when E_RESCUE		then	last_et_keyword_value := ast_factory.new_rescue_keyword		(Current)
										last_et_keyword_value.set_scanner_symbol (l_symbol)
			when E_SELECT		then	last_et_keyword_value := ast_factory.new_select_keyword		(Current)
										last_et_keyword_value.set_scanner_symbol (l_symbol)
			when E_SEPARATE 	then	last_et_keyword_value := ast_factory.new_separate_keyword	(Current)
										last_et_keyword_value.set_scanner_symbol (l_symbol)
			when E_STRIP		then	last_et_keyword_value := ast_factory.new_strip_keyword		(Current)
										last_et_keyword_value.set_scanner_symbol (l_symbol)
			when E_THEN			then	last_et_keyword_value := ast_factory.new_then_keyword		(Current)
										last_et_keyword_value.set_scanner_symbol (l_symbol)
			when E_UNDEFINE		then	last_et_keyword_value := ast_factory.new_undefine_keyword	(Current)
										last_et_keyword_value.set_scanner_symbol (l_symbol)
			when E_UNIQUE		then	last_et_keyword_value := ast_factory.new_unique_keyword		(Current)
										last_et_keyword_value.set_scanner_symbol (l_symbol)
			when E_UNTIL		then	last_et_keyword_value := ast_factory.new_until_keyword		(Current)
										last_et_keyword_value.set_scanner_symbol (l_symbol)
			when E_VARIANT		then	last_et_keyword_value := ast_factory.new_variant_keyword	(Current)
										last_et_keyword_value.set_scanner_symbol (l_symbol)
			when E_WHEN			then	last_et_keyword_value := ast_factory.new_when_keyword		(Current)
										last_et_keyword_value.set_scanner_symbol (l_symbol)

			when E_ASSIGN then
				if use_assign_keyword then
					last_et_keyword_value := ast_factory.new_assign_keyword (Current)
					last_et_keyword_value.set_scanner_symbol(l_symbol)
				else
					last_token := E_IDENTIFIER
					last_et_identifier_value := ast_factory.new_identifier (Current)
					last_et_identifier_value.set_scanner_symbol (l_symbol)
				end

			when E_ATTRIBUTE then
				if use_attribute_keyword then
					last_et_keyword_value := ast_factory.new_attribute_keyword (Current)
					last_et_keyword_value.set_scanner_symbol(l_symbol)
				else
					last_token := E_IDENTIFIER
					last_et_identifier_value := ast_factory.new_identifier (Current)
					last_et_identifier_value.set_scanner_symbol (l_symbol)
				end

			when E_CONVERT then
				if use_convert_keyword then
					last_et_keyword_value := ast_factory.new_convert_keyword (Current)
					last_et_keyword_value.set_scanner_symbol(l_symbol)
				else
					last_token := E_IDENTIFIER
					last_et_identifier_value := ast_factory.new_identifier (Current)
					last_et_identifier_value.set_scanner_symbol (l_symbol)
				end

			when E_CREATE then
				if use_create_keyword then
					last_et_keyword_value := ast_factory.new_create_keyword (Current)
					last_et_keyword_value.set_scanner_symbol(l_symbol)
				else
					last_token := E_IDENTIFIER
					last_et_identifier_value := ast_factory.new_identifier (Current)
					last_et_identifier_value.set_scanner_symbol (l_symbol)
				end

			when E_RECAST then
				if use_recast_keyword then
					last_et_keyword_value := ast_factory.new_recast_keyword (Current)
					last_et_keyword_value.set_scanner_symbol(l_symbol)
				else
					last_token := E_IDENTIFIER
					last_et_identifier_value := ast_factory.new_identifier (Current)
					last_et_identifier_value.set_scanner_symbol (l_symbol)
				end

			when E_REFERENCE then
				if use_reference_keyword then
					last_et_keyword_value := ast_factory.new_reference_keyword (Current)
					last_et_keyword_value.set_scanner_symbol(l_symbol)
				else
					last_token := E_IDENTIFIER
					last_et_identifier_value := ast_factory.new_identifier (Current)
					last_et_identifier_value.set_scanner_symbol (l_symbol)
				end

			when E_ONCE then
		--		ps := peek_symbol
		--		if ps /= Void and then is_string_type(ps.type) then
					-- E_ONCE_STRING ???
					-- ....
		--		else
					last_et_keyword_value := ast_factory.new_once_keyword (Current)
		--		end

			when E_AND			then	last_et_keyword_operator_value := ast_factory.new_and_keyword		(Current)
										last_et_keyword_operator_value.set_scanner_symbol (l_symbol)
			when E_OR			then	last_et_keyword_operator_value := ast_factory.new_or_keyword		(Current)
										last_et_keyword_operator_value.set_scanner_symbol (l_symbol)
			when E_XOR			then	last_et_keyword_operator_value := ast_factory.new_xor_keyword		(Current)
										last_et_keyword_operator_value.set_scanner_symbol (l_symbol)
			when E_NOT			then	last_et_keyword_operator_value := ast_factory.new_not_keyword		(Current)
										last_et_keyword_operator_value.set_scanner_symbol (l_symbol)
			when E_IMPLIES		then	last_et_keyword_operator_value := ast_factory.new_implies_keyword	(Current)
										last_et_keyword_operator_value.set_scanner_symbol (l_symbol)

			when E_TRUE			then	last_et_boolean_constant_value := ast_factory.new_true_keyword		(Current)
										last_et_boolean_constant_value.set_scanner_symbol (l_symbol)
			when E_FALSE		then	last_et_boolean_constant_value := ast_factory.new_false_keyword		(Current)
										last_et_boolean_constant_value.set_scanner_symbol (l_symbol)

			when E_VOID		 	then	last_et_void_value := ast_factory.new_void_keyword					(Current)
										last_et_void_value.set_scanner_symbol (l_symbol)
			when E_RETRY	 	then	last_et_retry_instruction_value := ast_factory.new_retry_keyword	(Current)
										last_et_retry_instruction_value.set_scanner_symbol (l_symbol)
			when E_RESULT	 	then	last_et_result_value := ast_factory.new_result_keyword				(Current)
										last_et_result_value.set_scanner_symbol (l_symbol)
			when E_CURRENT	 	then	last_et_current_value := ast_factory.new_current_keyword			(Current)
										last_et_current_value.set_scanner_symbol (l_symbol)
			when E_PRECURSOR	then	last_et_precursor_keyword_value := ast_factory.new_precursor_keyword(Current)
										last_et_precursor_keyword_value.set_scanner_symbol (l_symbol)

			when E_BIT			then	last_et_identifier_value := ast_factory.new_identifier				(Current)
										last_et_identifier_value.set_scanner_symbol (l_symbol)
			when E_TUPLE		then	last_et_identifier_value := ast_factory.new_identifier				(Current)
										last_et_identifier_value.set_scanner_symbol (l_symbol)

			when E_IDENTIFIER	then	last_et_identifier_value := ast_factory.new_identifier (Current)
										last_et_identifier_value.set_scanner_symbol (l_symbol)

			when Plus_code		then	last_et_symbol_operator_value := ast_factory.new_plus_symbol		(Current)
										last_et_symbol_operator_value.set_scanner_symbol (l_symbol)
			when Minus_code		then	last_et_symbol_operator_value := ast_factory.new_minus_symbol		(Current)
										last_et_symbol_operator_value.set_scanner_symbol (l_symbol)
			when Star_code		then	last_et_symbol_operator_value := ast_factory.new_times_symbol		(Current)
										last_et_symbol_operator_value.set_scanner_symbol (l_symbol)
			when Slash_code		then	last_et_symbol_operator_value := ast_factory.new_divide_symbol		(Current)
										last_et_symbol_operator_value.set_scanner_symbol (l_symbol)

			when Caret_code		then	last_et_symbol_operator_value := ast_factory.new_power_symbol		(Current)
										last_et_symbol_operator_value.set_scanner_symbol (l_symbol)

			when E_DIV			then	last_et_symbol_operator_value := ast_factory.new_div_symbol		(Current)
										last_et_symbol_operator_value.set_scanner_symbol (l_symbol)
			when E_MOD			then	last_et_symbol_operator_value := ast_factory.new_mod_symbol		(Current)
										last_et_symbol_operator_value.set_scanner_symbol (l_symbol)

			when Greater_than_code		then last_et_symbol_operator_value := ast_factory.new_gt_symbol 		(Current)
											 last_et_symbol_operator_value.set_scanner_symbol (l_symbol)
			when Less_than_code			then last_et_symbol_operator_value := ast_factory.new_lt_symbol 		(Current)
											 last_et_symbol_operator_value.set_scanner_symbol (l_symbol)

			when E_GE					then last_et_symbol_operator_value := ast_factory.new_ge_symbol 		(Current)
											 last_et_symbol_operator_value.set_scanner_symbol (l_symbol)
			when E_LE					then last_et_symbol_operator_value := ast_factory.new_le_symbol 		(Current)
											 last_et_symbol_operator_value.set_scanner_symbol (l_symbol)

			when Equal_code				then last_et_symbol_value := ast_factory.new_equal_symbol				(Current)
											 last_et_symbol_value.set_scanner_symbol (l_symbol)
			when Dot_code				then last_et_symbol_value := ast_factory.new_dot_symbol					(Current)
											 last_et_symbol_value.set_scanner_symbol (l_symbol)
			when Comma_code				then last_et_symbol_value := ast_factory.new_comma_symbol				(Current)
											 last_et_symbol_value.set_scanner_symbol (l_symbol)
			when Colon_code				then last_et_symbol_value := ast_factory.new_colon_symbol				(Current)
											 last_et_symbol_value.set_scanner_symbol (l_symbol)
			when Exclamation_code		then last_et_symbol_value := ast_factory.new_bang_symbol				(Current)
											 last_et_symbol_value.set_scanner_symbol (l_symbol)
			when Left_parenthesis_code	then last_et_symbol_value := ast_factory.new_left_parenthesis_symbol	(Current)
											 last_et_symbol_value.set_scanner_symbol (l_symbol)
			when Right_parenthesis_code	then last_et_symbol_value := ast_factory.new_right_parenthesis_symbol	(Current)
											 last_et_symbol_value.set_scanner_symbol (l_symbol)
			when Left_brace_code		then last_et_symbol_value := ast_factory.new_left_brace_symbol			(Current)
											 last_et_symbol_value.set_scanner_symbol (l_symbol)
			when Right_brace_code		then last_et_symbol_value := ast_factory.new_right_brace_symbol			(Current)
											 last_et_symbol_value.set_scanner_symbol (l_symbol)
			when Left_bracket_code		then last_et_symbol_value := ast_factory.new_left_bracket_symbol		(Current)
											 last_et_symbol_value.set_scanner_symbol (l_symbol)
			when Right_bracket_code		then last_et_symbol_value := ast_factory.new_right_bracket_symbol		(Current)
											 last_et_symbol_value.set_scanner_symbol (l_symbol)
			when Dollar_code			then last_et_symbol_value := ast_factory.new_dollar_symbol				(Current)
											 last_et_symbol_value.set_scanner_symbol (l_symbol)
			when Tilde_code				then last_et_symbol_value := ast_factory.new_tilde_symbol				(Current)
											 last_et_symbol_value.set_scanner_symbol (l_symbol)

			when Semicolon_code			then last_et_semicolon_symbol_value := ast_factory.new_semicolon_symbol (Current)
											 last_et_semicolon_symbol_value.set_scanner_symbol (l_symbol)
			when Question_mark_code		then last_et_question_mark_symbol_value := ast_factory.new_question_mark_symbol (Current)
											 last_et_question_mark_symbol_value.set_scanner_symbol (l_symbol)


			when E_NE					then last_et_symbol_value := ast_factory.new_not_equal_symbol			(Current)
											 last_et_symbol_value.set_scanner_symbol (l_symbol)
			when E_RARRAY				then last_et_symbol_value := ast_factory.new_right_array_symbol			(Current)
											 last_et_symbol_value.set_scanner_symbol (l_symbol)
			when E_LARRAY				then last_et_symbol_value := ast_factory.new_left_array_symbol			(Current)
											 last_et_symbol_value.set_scanner_symbol (l_symbol)
			when E_ARROW				then last_et_symbol_value := ast_factory.new_arrow_symbol				(Current)
											 last_et_symbol_value.set_scanner_symbol (l_symbol)
			when E_DOTDOT				then last_et_symbol_value := ast_factory.new_dotdot_symbol				(Current)
											 last_et_symbol_value.set_scanner_symbol (l_symbol)
			when E_ASSIGN_SYMBOL		then last_et_symbol_value := ast_factory.new_assign_symbol				(Current)
											 last_et_symbol_value.set_scanner_symbol (l_symbol)
			when E_REVERSE				then last_et_symbol_value := ast_factory.new_assign_attempt_symbol		(Current)
											 last_et_symbol_value.set_scanner_symbol (l_symbol)

			when E_UNKNOWN				then last_et_position_value := current_position

			when	E_STRPLUS,
					E_STRMINUS,
					E_STRSTAR,
					E_STRSLASH,
					E_STRDIV,
					E_STRMOD,
					E_STRPOWER,

					E_STRLT,
					E_STRLE,
					E_STRGT,
					E_STRGE,

					E_STRAND,
					E_STROR,
					E_STRXOR,
					E_STRNOT,

					E_STRANDTHEN,
					E_STRORELSE,
					E_STRIMPLIES then
						last_et_manifest_string_value := ast_factory.new_regular_manifest_string (Current)
						last_et_symbol_value.set_scanner_symbol (l_symbol)

		else
				check False end
			end
		end

invariant

end
