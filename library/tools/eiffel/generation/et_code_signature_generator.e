note

	description:

		"Code signature generator"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 2004-2010, Eric Bezault and others"
	license: "MIT License"

class ET_CODE_SIGNATURE_GENERATOR

inherit

	ET_TOKEN_CODES

	ET_AST_NULL_PROCESSOR
		rename
			make as make_null
		redefine
			process_assigner_instruction,
			process_assignment,
			process_assignment_attempt,
			process_attribute,
			process_bang_instruction,
			process_bit_constant,
			process_binary_integer_constant,
			process_bracket_expression,
			process_c1_character_constant,
			process_c2_character_constant,
			process_c3_character_constant,
			process_call_agent,
			process_call_expression,
			process_call_instruction,
			process_check_instruction,
			process_constant_attribute,
			process_convert_builtin_expression,
			process_convert_from_expression,
			process_convert_to_expression,
			process_create_expression,
			process_create_instruction,
			process_current,
			process_current_address,
			process_debug_instruction,
			process_deferred_function,
			process_deferred_procedure,
			process_do_function,
			process_do_function_inline_agent,
			process_do_procedure,
			process_do_procedure_inline_agent,
			process_equality_expression,
			process_expression_address,
			process_extended_attribute,
			process_external_function,
			process_external_function_inline_agent,
			process_external_procedure,
			process_external_procedure_inline_agent,
			process_false_constant,
			process_feature_address,
			process_hexadecimal_integer_constant,
			process_identifier,
			process_if_instruction,
			process_infix_cast_expression,
			process_infix_expression,
			process_inspect_instruction,
			process_loop_instruction,
			process_manifest_array,
			process_manifest_tuple,
			process_manifest_type,
			process_named_object_test,
			process_object_equality_expression,
			process_object_test,
			process_octal_integer_constant,
			process_old_expression,
			process_old_object_test,
			process_once_function,
			process_once_function_inline_agent,
			process_once_manifest_string,
			process_once_procedure,
			process_once_procedure_inline_agent,
			process_parenthesized_expression,
			process_precursor_expression,
			process_precursor_instruction,
			process_prefix_expression,
			process_regular_integer_constant,
			process_regular_manifest_string,
			process_regular_real_constant,
			process_result,
			process_result_address,
			process_retry_instruction,
			process_semicolon_symbol,
			process_special_manifest_string,
			process_static_call_expression,
			process_static_call_instruction,
			process_strip_expression,
			process_true_constant,
			process_underscored_integer_constant,
			process_underscored_real_constant,
			process_unique_attribute,
			process_verbatim_string,
			process_void
		end

create

	make

feature -- Attributes

	code_hash: HASH_STREAM_SHA1

	current_dynamic_system: ET_DYNAMIC_SYSTEM
	
feature -- Creation

	make (a_dynamic_system: ET_DYNAMIC_SYSTEM)
		do
			current_dynamic_system := a_dynamic_system
		end

feature -- Hash generation

	assign_code_hashes
			-- For each dynamic_type, generate and assign hashes for each routine
		local
			l_dynamic_types: DS_ARRAYED_LIST [ET_DYNAMIC_TYPE]
			l_type: ET_DYNAMIC_TYPE
			i, nb: INTEGER
			l_features: ET_DYNAMIC_FEATURE_LIST
			l_feature: ET_DYNAMIC_FEATURE
			l_other_precursors: ET_DYNAMIC_PRECURSOR_LIST
			l_precursor: ET_DYNAMIC_PRECURSOR
			j, nb2: INTEGER
			k, nb3: INTEGER
			l_count: INTEGER
			l_id: INTEGER
		do
			l_dynamic_types := current_dynamic_system.dynamic_types
			nb := l_dynamic_types.count
			from i := 1 until i > nb loop
				l_type := l_dynamic_types.item (i)
				l_count := l_count + 1
				l_type.set_id (l_count)
				if l_type.is_alive or l_type.has_static then
						-- Process dynamic queries.
					l_features := l_type.queries
					nb2 := l_features.count
					from j := 1 until j > nb2 loop
						l_feature := l_features.item (j)
						l_feature.set_id (j)
						l_precursor := l_feature.first_precursor
						if l_precursor /= Void then
							l_precursor.set_id (1)
							l_other_precursors := l_feature.other_precursors
							if l_other_precursors /= Void then
								nb3 := l_other_precursors.count
								from k := 2 until k > nb3 loop
									l_other_precursors.item (k).set_id (k)
									k := k + 1
								end
							end
						end
						j := j + 1
					end
						-- Process dynamic procedures.
					l_id := nb2 + 1
					l_features := l_type.procedures
					nb2 := l_features.count
					from j := 1 until j > nb2 loop
						l_feature := l_features.item (j)
						l_feature.set_id (l_id)
						l_precursor := l_feature.first_precursor
						if l_precursor /= Void then
							l_precursor.set_id (1)
							l_other_precursors := l_feature.other_precursors
							if l_other_precursors /= Void then
								nb3 := l_other_precursors.count
								from k := 2 until k > nb3 loop
									l_other_precursors.item (k).set_id (k)
									k := k + 1
								end
							end
						end
						l_id := l_id + 1
						j := j + 1
					end
				end
				i := i + 1
			end

		end

feature {ET_AST_NODE} -- Processing

	process_assigner_instruction (an_instruction: ET_ASSIGNER_INSTRUCTION)
			-- Process `an_instruction'.
		do
--			print_assigner_instruction (an_instruction)
		end

	process_assignment (an_instruction: ET_ASSIGNMENT)
			-- Process `an_instruction'.
		do
--			print_assignment (an_instruction)
		end

	process_assignment_attempt (an_instruction: ET_ASSIGNMENT_ATTEMPT)
			-- Process `an_instruction'.
		do
--			print_assignment_attempt (an_instruction)
		end

	process_attribute (a_feature: ET_ATTRIBUTE)
			-- Process `a_feature'.
		do
--			print_attribute (a_feature)
		end

	process_bang_instruction (an_instruction: ET_BANG_INSTRUCTION)
			-- Process `an_instruction'.
		do
--			print_bang_instruction (an_instruction)
		end

	process_binary_integer_constant (a_constant: ET_BINARY_INTEGER_CONSTANT)
			-- Process `a_constant'.
		do
--			print_binary_integer_constant (a_constant)
		end

	process_bit_constant (a_constant: ET_BIT_CONSTANT)
			-- Process `a_constant'.
		do
--			print_bit_constant (a_constant)
		end

	process_bracket_expression (an_expression: ET_BRACKET_EXPRESSION)
			-- Process `an_expression'.
		do
--			print_bracket_expression (an_expression)
		end

	process_c1_character_constant (a_constant: ET_C1_CHARACTER_CONSTANT)
			-- Process `a_constant'.
		do
--			print_character_constant (a_constant)
		end

	process_c2_character_constant (a_constant: ET_C2_CHARACTER_CONSTANT)
			-- Process `a_constant'.
		do
--			print_character_constant (a_constant)
		end

	process_c3_character_constant (a_constant: ET_C3_CHARACTER_CONSTANT)
			-- Process `a_constant'.
		do
--			print_character_constant (a_constant)
		end

	process_call_agent (an_expression: ET_CALL_AGENT)
			-- Process `an_expression'.
		do
			if an_expression = current_agent then
--				print_call_agent_body_declaration (an_expression)
			else
--				print_call_agent (an_expression)
			end
		end

	process_call_expression (an_expression: ET_CALL_EXPRESSION)
			-- Process `an_expression'.
		do
--			print_call_expression (an_expression)
		end

	process_call_instruction (an_instruction: ET_CALL_INSTRUCTION)
			-- Process `an_instruction'.
		do
--			print_call_instruction (an_instruction)
		end

	process_check_instruction (an_instruction: ET_CHECK_INSTRUCTION)
			-- Process `an_instruction'.
		do
--			print_check_instruction (an_instruction)
		end

	process_constant_attribute (a_feature: ET_CONSTANT_ATTRIBUTE)
			-- Process `a_feature'.
		do
--			print_constant_attribute (a_feature)
		end

	process_convert_builtin_expression (an_expression: ET_CONVERT_BUILTIN_EXPRESSION)
			-- Process `an_expression'.
		do
--			print_convert_builtin_expression (an_expression)
		end

	process_convert_from_expression (an_expression: ET_CONVERT_FROM_EXPRESSION)
			-- Process `an_expression'.
		do
--			print_convert_from_expression (an_expression)
		end

	process_convert_to_expression (an_expression: ET_CONVERT_TO_EXPRESSION)
			-- Process `an_expression'.
		do
--			print_convert_to_expression (an_expression)
		end

	process_create_expression (an_expression: ET_CREATE_EXPRESSION)
			-- Process `an_expression'.
		do
--			print_create_expression (an_expression)
		end

	process_create_instruction (an_instruction: ET_CREATE_INSTRUCTION)
			-- Process `an_instruction'.
		do
--			print_create_instruction (an_instruction)
		end

	process_current (an_expression: ET_CURRENT)
			-- Process `an_expression'.
		do
--			print_current (an_expression)
		end

	process_current_address (an_expression: ET_CURRENT_ADDRESS)
			-- Process `an_expression'.
		do
--			print_current_address (an_expression)
		end

	process_debug_instruction (an_instruction: ET_DEBUG_INSTRUCTION)
			-- Process `an_instruction'.
		do
--			print_debug_instruction (an_instruction)
		end

	process_deferred_function (a_feature: ET_DEFERRED_FUNCTION)
			-- Process `a_feature'.
		do
--			print_deferred_function (a_feature)
		end

	process_deferred_procedure (a_feature: ET_DEFERRED_PROCEDURE)
			-- Process `a_feature'.
		do
--			print_deferred_procedure (a_feature)
		end

	process_do_function (a_feature: ET_DO_FUNCTION)
			-- Process `a_feature'.
		do
--			print_do_function (a_feature)
		end

	process_do_function_inline_agent (an_agent: ET_DO_FUNCTION_INLINE_AGENT)
			-- Process `an_agent'.
		do
			if an_agent = current_agent then
--				print_do_function_inline_agent_body_declaration (an_agent)
			else
--				print_do_function_inline_agent (an_agent)
			end
		end

	process_do_procedure (a_feature: ET_DO_PROCEDURE)
			-- Process `a_feature'.
		do
--			print_do_procedure (a_feature)
		end

	process_do_procedure_inline_agent (an_agent: ET_DO_PROCEDURE_INLINE_AGENT)
			-- Process `an_agent'.
		do
			if an_agent = current_agent then
--				print_do_procedure_inline_agent_body_declaration (an_agent)
			else
--				print_do_procedure_inline_agent (an_agent)
			end
		end

	process_equality_expression (an_expression: ET_EQUALITY_EXPRESSION)
			-- Process `an_expression'.
		do
--			print_equality_expression (an_expression)
		end

	process_expression_address (an_expression: ET_EXPRESSION_ADDRESS)
			-- Process `an_expression'.
		do
--			print_expression_address (an_expression)
		end

	process_extended_attribute (a_feature: ET_EXTENDED_ATTRIBUTE)
			-- Process `a_feature'.
		do
--			print_extended_attribute (a_feature)
		end

	process_external_function (a_feature: ET_EXTERNAL_FUNCTION)
			-- Process `a_feature'.
		do
--			print_external_function (a_feature)
		end

	process_external_function_inline_agent (an_agent: ET_EXTERNAL_FUNCTION_INLINE_AGENT)
			-- Process `an_agent'.
		do
			if an_agent = current_agent then
--				print_external_function_inline_agent_body_declaration (an_agent)
			else
--				print_external_function_inline_agent (an_agent)
			end
		end

	process_external_procedure (a_feature: ET_EXTERNAL_PROCEDURE)
			-- Process `a_feature'.
		do
--			print_external_procedure (a_feature)
		end

	process_external_procedure_inline_agent (an_agent: ET_EXTERNAL_PROCEDURE_INLINE_AGENT)
			-- Process `an_agent'.
		do
			if an_agent = current_agent then
--				print_external_procedure_inline_agent_body_declaration (an_agent)
			else
--				print_external_procedure_inline_agent (an_agent)
			end
		end

	process_false_constant (a_constant: ET_FALSE_CONSTANT)
			-- Process `a_constant'.
		do
			extend_character (false_keyword_code)
		end

	process_feature_address (an_expression: ET_FEATURE_ADDRESS)
			-- Process `an_expression'.
		do
--			print_feature_address (an_expression)
		end

	process_hexadecimal_integer_constant (a_constant: ET_HEXADECIMAL_INTEGER_CONSTANT)
			-- Process `a_constant'.
		do
			extend_integer (builtin_natural_64_class)
			extend_natural_64 (a_constant.value)
		end

	process_identifier (an_identifier: ET_IDENTIFIER)
			-- Process `an_identifier'.
		do
			if an_identifier.is_argument then
--				print_formal_argument (an_identifier)
			elseif an_identifier.is_temporary then
--				print_temporary_variable (an_identifier)
			elseif an_identifier.is_local then
--				print_local_variable (an_identifier)
			elseif an_identifier.is_object_test_local then
--				print_object_test_local (an_identifier)
			elseif an_identifier.is_agent_open_operand then
--				print_agent_open_operand (an_identifier)
			elseif an_identifier.is_agent_closed_operand then
--				print_agent_closed_operand (an_identifier)
			elseif an_identifier.is_instruction then
--				print_unqualified_identifier_call_instruction (an_identifier)
			else
--				print_unqualified_identifier_call_expression (an_identifier)
			end
		end

	process_if_instruction (an_instruction: ET_IF_INSTRUCTION)
			-- Process `an_instruction'.
		do
--			print_if_instruction (an_instruction)
		end

	process_infix_cast_expression (an_expression: ET_INFIX_CAST_EXPRESSION)
			-- Process `an_expression'.
		do
--			print_infix_cast_expression (an_expression)
		end

	process_infix_expression (an_expression: ET_INFIX_EXPRESSION)
			-- Process `an_expression'.
		do
--			print_infix_expression (an_expression)
		end

	process_inspect_instruction (an_instruction: ET_INSPECT_INSTRUCTION)
			-- Process `an_instruction'.
		do
--			print_inspect_instruction (an_instruction)
		end

	process_loop_instruction (an_instruction: ET_LOOP_INSTRUCTION)
			-- Process `an_instruction'.
		do
--			print_loop_instruction (an_instruction)
		end

	process_manifest_array (an_expression: ET_MANIFEST_ARRAY)
			-- Process `an_expression'.
		do
--			print_manifest_array (an_expression)
		end

	process_manifest_tuple (an_expression: ET_MANIFEST_TUPLE)
			-- Process `an_expression'.
		do
--			print_manifest_tuple (an_expression)
		end

	process_manifest_type (an_expression: ET_MANIFEST_TYPE)
			-- Process `an_expression'.
		do
--			print_manifest_type (an_expression)
		end

	process_named_object_test (an_expression: ET_NAMED_OBJECT_TEST)
			-- Process `an_expression'.
		do
--			print_object_test (an_expression)
		end

	process_object_equality_expression (an_expression: ET_OBJECT_EQUALITY_EXPRESSION)
			-- Process `an_expression'.
		do
--			print_object_equality_expression (an_expression)
		end

	process_object_test (an_expression: ET_OBJECT_TEST)
			-- Process `an_expression'.
		do
--			print_object_test (an_expression)
		end

	process_octal_integer_constant (a_constant: ET_OCTAL_INTEGER_CONSTANT)
			-- Process `a_constant'.
		do
--			print_octal_integer_constant (a_constant)
		end

	process_old_expression (an_expression: ET_OLD_EXPRESSION)
			-- Process `an_expression'.
		do
--			print_old_expression (an_expression)
		end

	process_old_object_test (an_expression: ET_OLD_OBJECT_TEST)
			-- Process `an_expression'.
		do
--			print_object_test (an_expression)
		end

	process_once_function (a_feature: ET_ONCE_FUNCTION)
			-- Process `a_feature'.
		do
--			print_once_function (a_feature)
		end

	process_once_function_inline_agent (an_agent: ET_ONCE_FUNCTION_INLINE_AGENT)
			-- Process `an_agent'.
		do
			if an_agent = current_agent then
--				print_once_function_inline_agent_body_declaration (an_agent)
			else
--				print_once_function_inline_agent (an_agent)
			end
		end

	process_once_manifest_string (an_expression: ET_ONCE_MANIFEST_STRING)
			-- Process `an_expression'.
		do
--			print_once_manifest_string (an_expression)
		end

	process_once_procedure (a_feature: ET_ONCE_PROCEDURE)
			-- Process `a_feature'.
		do
--			print_once_procedure (a_feature)
		end

	process_once_procedure_inline_agent (an_agent: ET_ONCE_PROCEDURE_INLINE_AGENT)
			-- Process `an_agent'.
		do
			if an_agent = current_agent then
--				print_once_procedure_inline_agent_body_declaration (an_agent)
			else
--				print_once_procedure_inline_agent (an_agent)
			end
		end

	process_parenthesized_expression (an_expression: ET_PARENTHESIZED_EXPRESSION)
			-- Process `an_expression'.
		do
--			print_parenthesized_expression (an_expression)
		end

	process_precursor_expression (an_expression: ET_PRECURSOR_EXPRESSION)
			-- Process `an_expression'.
		do
--			print_precursor_expression (an_expression)
		end

	process_precursor_instruction (an_instruction: ET_PRECURSOR_INSTRUCTION)
			-- Process `an_instruction'.
		do
--			print_precursor_instruction (an_instruction)
		end

	process_prefix_expression (an_expression: ET_PREFIX_EXPRESSION)
			-- Process `an_expression'.
		do
--			print_prefix_expression (an_expression)
		end

	process_regular_integer_constant (a_constant: ET_REGULAR_INTEGER_CONSTANT)
			-- Process `a_constant'.
		do
--			print_regular_integer_constant (a_constant)
		end

	process_regular_manifest_string (a_string: ET_REGULAR_MANIFEST_STRING)
			-- Process `a_string'.
		do
--			print_regular_manifest_string (a_string)
		end

	process_regular_real_constant (a_constant: ET_REGULAR_REAL_CONSTANT)
			-- Process `a_constant'.
		do
--			print_regular_real_constant (a_constant)
		end

	process_result (an_expression: ET_RESULT)
			-- Process `an_expression'.
		do
--			print_result (an_expression)
		end

	process_result_address (an_expression: ET_RESULT_ADDRESS)
			-- Process `an_expression'.
		do
--			print_result_address (an_expression)
		end

	process_retry_instruction (an_instruction: ET_RETRY_INSTRUCTION)
			-- Process `an_instruction'.
		do
--			print_retry_instruction (an_instruction)
		end

	process_semicolon_symbol (a_symbol: ET_SEMICOLON_SYMBOL)
			-- Process `a_symbol'.
		do
			-- Do nothing.
		end

	process_special_manifest_string (a_string: ET_SPECIAL_MANIFEST_STRING)
			-- Process `a_string'.
		do
--			print_special_manifest_string (a_string)
		end

	process_static_call_expression (an_expression: ET_STATIC_CALL_EXPRESSION)
			-- Process `an_expression'.
		do
--			print_static_call_expression (an_expression)
		end

	process_static_call_instruction (an_instruction: ET_STATIC_CALL_INSTRUCTION)
			-- Process `an_instruction'.
		do
--			print_static_call_instruction (an_instruction)
		end

	process_strip_expression (an_expression: ET_STRIP_EXPRESSION)
			-- Process `an_expression'.
		do
--			print_strip_expression (an_expression)
		end

	process_true_constant (a_constant: ET_TRUE_CONSTANT)
			-- Process `a_constant'.
		do
			extend_character (true_keyword_code)
		end

	process_underscored_integer_constant (a_constant: ET_UNDERSCORED_INTEGER_CONSTANT)
			-- Process `a_constant'.
		do
--			print_underscored_integer_constant (a_constant)
		end

	process_underscored_real_constant (a_constant: ET_UNDERSCORED_REAL_CONSTANT)
			-- Process `a_constant'.
		do
--			print_underscored_real_constant (a_constant)
		end

	process_unique_attribute (a_feature: ET_UNIQUE_ATTRIBUTE)
			-- Process `a_feature'.
		do
--			print_unique_attribute (a_feature)
		end

	process_verbatim_string (a_string: ET_VERBATIM_STRING)
			-- Process `a_string'.
		do
--			print_verbatim_string (a_string)
		end

	process_void (an_expression: ET_VOID)
			-- Process `an_expression'.
		do
			extend_character (void_keyword_code)
		end

feature -- Signature processing

	extend_character (a_character: CHARACTER)
		do
		end

end