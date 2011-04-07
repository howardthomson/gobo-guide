	print_deep_twin_function (a_type: ET_DYNAMIC_TYPE)
			-- Print 'GE_deep_twin' function for type `a_type' to `current_file'
			-- and its signature to `header_file'.
		require
			a_type_not_void: a_type /= Void
		local
			l_special_type: ET_DYNAMIC_SPECIAL_TYPE
			l_tuple_type: ET_DYNAMIC_TUPLE_TYPE
			l_has_nested_references: BOOLEAN
			i, nb: INTEGER
			l_queries: ET_DYNAMIC_FEATURE_LIST
			l_attribute: ET_DYNAMIC_FEATURE
			l_attribute_type_set: ET_DYNAMIC_TYPE_SET
			l_attribute_type: ET_DYNAMIC_TYPE
			l_item_type_sets: ET_DYNAMIC_TYPE_SET_LIST
			old_type: ET_DYNAMIC_TYPE
			old_file: KI_TEXT_OUTPUT_STREAM
			l_temp: ET_IDENTIFIER
			l_dynamic_type_set: ET_DYNAMIC_TYPE_SET
			l_count_type: ET_DYNAMIC_TYPE
		do
			old_type := current_type
			current_type := a_type
				-- Print signature to `header_file' and `current_file'.
			old_file := current_file
			current_file := current_function_header_buffer
			header_file.put_string (c_extern)
			header_file.put_character (' ')
			print_type_declaration (a_type, header_file)
			print_type_declaration (a_type, current_file)
			header_file.put_character (' ')
			current_file.put_character (' ')
			header_file.put_string (c_ge_deep_twin)
			current_file.put_string (c_ge_deep_twin)
			header_file.put_integer (a_type.id)
			current_file.put_integer (a_type.id)
			header_file.put_character ('(')
			current_file.put_character ('(')
			print_type_declaration (current_type, header_file)
			print_type_declaration (current_type, current_file)
			if current_type.is_expanded then
				header_file.put_character ('*')
				current_file.put_character ('*')
			end
			header_file.put_character (' ')
			current_file.put_character (' ')
			print_current_name (header_file)
			print_current_name (current_file)
			header_file.put_character (',')
			header_file.put_character (' ')
			current_file.put_character (',')
			current_file.put_character (' ')
			header_file.put_string (c_ge_deep)
			header_file.put_character ('*')
			header_file.put_character (' ')
			header_file.put_character ('d')
			current_file.put_string (c_ge_deep)
			current_file.put_character ('*')
			current_file.put_character (' ')
			current_file.put_character ('d')
			header_file.put_character (')')
			current_file.put_character (')')
			header_file.put_character (';')
			header_file.put_new_line
			current_file.put_new_line
				-- Print body to `current_file'.
			current_file.put_character ('{')
			current_file.put_new_line
			indent
				-- Declare the Result entity.
			print_indentation
			print_type_declaration (a_type, current_file)
			current_file.put_character (' ')
			print_result_name (current_file)
			current_file.put_character (';')
			current_file.put_new_line
			current_file := current_function_body_buffer
			if a_type.base_class.is_type_class then
-- TODO: this built-in routine could be inlined.
					-- Cannot have two instances of class TYPE representing the same Eiffel type.
				print_indentation
				print_result_name (current_file)
				current_file.put_character (' ')
				current_file.put_character ('=')
				current_file.put_character (' ')
				print_current_name (current_file)
				current_file.put_character (';')
				current_file.put_new_line
			else
				l_has_nested_references := a_type.has_nested_reference_attributes
				if l_has_nested_references then
					print_indentation
					current_file.put_string (c_ge_deep)
					current_file.put_character ('*')
					current_file.put_character (' ')
					current_file.put_character ('t')
					current_file.put_character ('0')
					current_file.put_character (' ')
					current_file.put_character ('=')
					current_file.put_character (' ')
					current_file.put_character ('d')
					current_file.put_character (';')
					current_file.put_new_line
				end
				l_special_type ?= a_type
				if l_special_type /= Void then
					l_attribute_type_set := l_special_type.item_type_set
					l_attribute_type := l_attribute_type_set.static_type
					print_indentation
					print_result_name (current_file)
					current_file.put_character (' ')
					current_file.put_character ('=')
					current_file.put_character (' ')
					current_file.put_string (c_ge_new)
					current_file.put_integer (l_special_type.id)
					current_file.put_character ('(')
					print_attribute_special_count_access (tokens.current_keyword, l_special_type, False)
					current_file.put_character (',')
					current_file.put_character (' ')
					current_file.put_string (c_eif_false)
					current_file.put_character (')')
					current_file.put_character (';')
					current_file.put_new_line
					print_indentation
					if not l_special_type.is_expanded then
						current_file.put_character ('*')
					end
					print_type_cast (l_special_type, current_file)
					current_file.put_character ('(')
					print_result_name (current_file)
					current_file.put_character (')')
					current_file.put_character (' ')
					current_file.put_character ('=')
					current_file.put_character (' ')
					if not l_special_type.is_expanded then
						current_file.put_character ('*')
					end
					print_type_cast (l_special_type, current_file)
					current_file.put_character ('(')
					print_current_name (current_file)
					current_file.put_character (')')
					current_file.put_character (';')
					current_file.put_new_line
					if not l_has_nested_references then
							-- Copy items if they are not reference objects or expanded
							-- objects containing (recursively) reference attributes.
						print_indentation
						current_file.put_string (c_memcpy)
						current_file.put_character ('(')
						print_attribute_special_item_access (tokens.result_keyword, l_special_type, False)
						current_file.put_character (',')
						print_attribute_special_item_access (tokens.current_keyword, l_special_type, False)
						current_file.put_character (',')
						print_attribute_special_count_access (tokens.current_keyword, l_special_type, False)
						current_file.put_character ('*')
						current_file.put_string (c_sizeof)
						current_file.put_character ('(')
						print_type_declaration (l_attribute_type, current_file)
						current_file.put_character (')')
						current_file.put_character (')')
						current_file.put_character (';')
						current_file.put_new_line
					end
				elseif a_type.is_expanded then
					print_indentation
					print_result_name (current_file)
					current_file.put_character (' ')
					current_file.put_character ('=')
					current_file.put_character (' ')
					current_file.put_character ('*')
					print_current_name (current_file)
					current_file.put_character (';')
					current_file.put_new_line
				else
					print_indentation
					print_result_name (current_file)
					current_file.put_character (' ')
					current_file.put_character ('=')
					current_file.put_character (' ')
					current_file.put_string (c_ge_new)
					current_file.put_integer (a_type.id)
					current_file.put_character ('(')
					current_file.put_string (c_eif_false)
					current_file.put_character (')')
					current_file.put_character (';')
					current_file.put_new_line
					print_indentation
					current_file.put_character ('*')
					print_type_cast (a_type, current_file)
					current_file.put_character ('(')
					print_result_name (current_file)
					current_file.put_character (')')
					current_file.put_character (' ')
					current_file.put_character ('=')
					current_file.put_character (' ')
					current_file.put_character ('*')
					print_type_cast (a_type, current_file)
					current_file.put_character ('(')
					print_current_name (current_file)
					current_file.put_character (')')
					current_file.put_character (';')
					current_file.put_new_line
				end
				if l_has_nested_references then
						-- Allocate a 'GE_deep' struct to keep track of already twined
						-- reference objects, or use 'd' if not a null pointer (which
						-- means that the current object is not the root of the deep twin).
					print_indentation
					current_file.put_string (c_if)
					current_file.put_character (' ')
					current_file.put_character ('(')
					current_file.put_character ('!')
					current_file.put_character ('t')
					current_file.put_character ('0')
					current_file.put_character (')')
					current_file.put_character (' ')
					current_file.put_character ('{')
					current_file.put_new_line
					indent
					print_indentation
					current_file.put_string ("t0 = GE_deep_new();")
					current_file.put_new_line
					dedent
					print_indentation
					current_file.put_character ('}')
					current_file.put_new_line
					if not a_type.is_expanded then
							-- Keep track of reference objects already twined.
						print_indentation
						current_file.put_string ("GE_deep_put")
						current_file.put_character ('(')
						print_current_name (current_file)
						current_file.put_character (',')
						current_file.put_character (' ')
						print_result_name (current_file)
						current_file.put_character (',')
						current_file.put_character (' ')
						current_file.put_character ('t')
						current_file.put_character ('0')
						current_file.put_character (')')
						current_file.put_character (';')
						current_file.put_new_line
					end
						-- Twin reference attributes or expanded attributes that
						-- contain themselves (recursively) reference attributes
					if l_special_type /= Void then
							-- Twin items.
						if l_special_type.attribute_count < 1 then
								-- Internal error: class "SPECIAL" should have at least the
								-- feature 'count' as first feature.
								-- Already reported in ET_DYNAMIC_SYSTEM.compile_kernel.
							set_fatal_error
							error_handler.report_giaaa_error_cl ("__CLASS__", "__LINE__")
						else
							l_dynamic_type_set := result_type_set_in_feature (l_special_type.queries.first)
							l_count_type := l_dynamic_type_set.static_type
							if l_attribute_type_set.is_empty then
									-- If the dynamic type set of the items is empty,
									-- then the items is always Void. No need to twin
									-- it in that case.
							elseif l_attribute_type.is_expanded then
									-- If the items are expanded.
									-- We need to deep twin them only if they themselves contain
									-- (recursively) reference attributes. Otherwise we can copy
									-- their contents without further ado.
								if l_attribute_type.has_nested_reference_attributes then
									l_temp := new_temp_variable (l_count_type)
									print_indentation
									current_file.put_string (c_for)
									current_file.put_character (' ')
									current_file.put_character ('(')
									print_temp_name (l_temp, current_file)
									current_file.put_character (' ')
									current_file.put_character ('=')
									current_file.put_character (' ')
									print_attribute_special_count_access (tokens.current_keyword, l_special_type, False)
									current_file.put_character (' ')
									current_file.put_character ('-')
									current_file.put_character (' ')
									current_file.put_character ('1')
									current_file.put_character (';')
									current_file.put_character (' ')
									print_temp_name (l_temp, current_file)
									current_file.put_character (' ')
									current_file.put_character ('>')
									current_file.put_character ('=')
									current_file.put_character (' ')
									current_file.put_character ('0')
									current_file.put_character (';')
									current_file.put_character (' ')
									print_temp_name (l_temp, current_file)
									current_file.put_character ('-')
									current_file.put_character ('-')
									current_file.put_character (')')
									current_file.put_character (' ')
									current_file.put_character ('{')
									current_file.put_new_line
									indent
									print_set_deep_twined_attribute (l_attribute_type_set, agent print_attribute_special_indexed_item_access (l_temp,  tokens.result_keyword, a_type, False))
									dedent
									print_indentation
									current_file.put_character ('}')
									current_file.put_new_line
									mark_temp_variable_free (l_temp)
								end
							else
									-- We are in the case of reference items.
								l_temp := new_temp_variable (l_count_type)
								print_indentation
								current_file.put_string (c_for)
								current_file.put_character (' ')
								current_file.put_character ('(')
								print_temp_name (l_temp, current_file)
								current_file.put_character (' ')
								current_file.put_character ('=')
								current_file.put_character (' ')
								print_attribute_special_count_access (tokens.current_keyword, l_special_type, False)
								current_file.put_character (' ')
								current_file.put_character ('-')
								current_file.put_character (' ')
								current_file.put_character ('1')
								current_file.put_character (';')
								current_file.put_character (' ')
								print_temp_name (l_temp, current_file)
								current_file.put_character (' ')
								current_file.put_character ('>')
								current_file.put_character ('=')
								current_file.put_character (' ')
								current_file.put_character ('0')
								current_file.put_character (';')
								current_file.put_character (' ')
								print_temp_name (l_temp, current_file)
								current_file.put_character ('-')
								current_file.put_character ('-')
								current_file.put_character (')')
								current_file.put_character (' ')
								current_file.put_character ('{')
								current_file.put_new_line
								indent
								print_set_deep_twined_attribute (l_attribute_type_set, agent print_attribute_special_indexed_item_access (l_temp,  tokens.result_keyword, a_type, False))
								dedent
								print_indentation
								current_file.put_character ('}')
								current_file.put_new_line
								mark_temp_variable_free (l_temp)
							end
						end
					else
						l_queries := a_type.queries
						nb := a_type.attribute_count
						from i := 1 until i > nb loop
							l_attribute := l_queries.item (i)
							l_attribute_type_set := l_attribute.result_type_set
							l_attribute_type := l_attribute_type_set.static_type
							if l_attribute_type_set.is_empty then
									-- If the dynamic type set of the attribute is empty,
									-- then this attribute is always Void. No need to twin
									-- it in that case.
							elseif l_attribute_type.is_expanded then
									-- If the attribute is expanded, then its contents has
									-- already been copied. We need to deep twin it only if
									-- it itself contains (recursively) reference attributes.
								if l_attribute_type.has_nested_reference_attributes then
									print_set_deep_twined_attribute (l_attribute_type_set, agent print_attribute_access (l_attribute, tokens.result_keyword, a_type, False))
								end
							else
								print_set_deep_twined_attribute (l_attribute_type_set, agent print_attribute_access (l_attribute, tokens.result_keyword, a_type, False))
							end
							i := i + 1
						end
						l_tuple_type ?= a_type
						if l_tuple_type /= Void then
							l_item_type_sets := l_tuple_type.item_type_sets
							nb := l_item_type_sets.count
							from i := 1 until i > nb loop
								l_attribute_type_set := l_item_type_sets.item (i)
								l_attribute_type := l_attribute_type_set.static_type
								if l_attribute_type_set.is_empty then
										-- If the dynamic type set of the item is empty,
										-- then this item is always Void. No need to twin
										-- it in that case.
								elseif l_attribute_type.is_expanded then
										-- If the item is expanded, then its contents has
										-- already been copied. We need to deep twin it only if
										-- it itself contains (recursively) reference attributes.
									if l_attribute_type.has_nested_reference_attributes then
										print_set_deep_twined_attribute (l_attribute_type_set, agent print_attribute_tuple_item_access (i, tokens.result_keyword, a_type, False))
									end
								else
									print_set_deep_twined_attribute (l_attribute_type_set, agent print_attribute_tuple_item_access (i, tokens.result_keyword, a_type, False))
								end
								i := i + 1
							end
						end
					end
						-- Free previously allocated 'GE_deep' struct, if any (i.e. if
						-- the current object was the root object of the deep twin).
					print_indentation
					current_file.put_string (c_if)
					current_file.put_character (' ')
					current_file.put_character ('(')
					current_file.put_character ('t')
					current_file.put_character ('0')
					current_file.put_character (' ')
					current_file.put_character ('!')
					current_file.put_character ('=')
					current_file.put_character (' ')
					current_file.put_character ('d')
					current_file.put_character (')')
					current_file.put_character (' ')
					current_file.put_character ('{')
					current_file.put_new_line
					indent
					print_indentation
					current_file.put_string ("GE_deep_free(t0);")
					current_file.put_new_line
					dedent
					print_indentation
					current_file.put_character ('}')
					current_file.put_new_line
				elseif not a_type.is_expanded then
						-- Keep track of reference objects already twined.
						-- If 'd' is a null pointer, then there is no need
						-- to keep track of this object because it is the
						-- only object to be twined: it is the root object
						-- of the deep twin ('d' being a null pointer) and
						-- it has not reference attributes.
					print_indentation
					current_file.put_string (c_if)
					current_file.put_character (' ')
					current_file.put_character ('(')
					current_file.put_character ('d')
					current_file.put_character (')')
					current_file.put_character (' ')
					current_file.put_character ('{')
					current_file.put_new_line
					indent
					print_indentation
					current_file.put_string ("GE_deep_put")
					current_file.put_character ('(')
					print_current_name (current_file)
					current_file.put_character (',')
					current_file.put_character (' ')
					print_result_name (current_file)
					current_file.put_character (',')
					current_file.put_character (' ')
					current_file.put_character ('d')
					current_file.put_character (')')
					current_file.put_character (';')
					current_file.put_new_line
					dedent
					print_indentation
					current_file.put_character ('}')
					current_file.put_new_line
				end
			end
				-- Return the deep twined object.
			print_indentation
			current_file.put_string (c_return)
			current_file.put_character (' ')
			print_result_name (current_file)
			current_file.put_character (';')
			current_file.put_new_line
			dedent
			current_file.put_character ('}')
			current_file.put_new_line
			current_file.put_new_line
			current_file := old_file
			flush_to_c_file
			reset_temp_variables
			current_type := old_type
		end

	print_deep_twin_polymorphic_call_function (a_target_type_set: ET_DYNAMIC_TYPE_SET)
			-- Print 'GE_deep_twin<type-id>x' function to `current_file' and its signature to `header_file'.
			-- 'GE_deep_twin<type-id>x' corresponds to a polymorphic call to 'deep_twin'
			-- whose target has `a_target_type_set' as dynamic type set.
			-- 'type-id' is the type-id of the static type of the target.
		require
			a_target_type_set_not_void: a_target_type_set /= Void
		local
			l_target_dynamic_type_ids: DS_ARRAYED_LIST [INTEGER]
			l_target_dynamic_types: DS_HASH_TABLE [ET_DYNAMIC_TYPE, INTEGER]
			l_static_type: ET_DYNAMIC_TYPE
			l_dynamic_type: ET_DYNAMIC_TYPE
			l_type_id: INTEGER
			l_temp: ET_IDENTIFIER
			i, nb: INTEGER
			l_switch: BOOLEAN
			old_type: ET_DYNAMIC_TYPE
		do
			l_static_type := a_target_type_set.static_type
			old_type := current_type
			current_type := l_static_type
				-- Print signature to `header_file' and `current_file'.
			header_file.put_string (c_extern)
			header_file.put_character (' ')
			print_type_declaration (l_static_type, header_file)
			print_type_declaration (l_static_type, current_file)
			header_file.put_character (' ')
			current_file.put_character (' ')
			header_file.put_string (c_ge_deep_twin)
			current_file.put_string (c_ge_deep_twin)
			header_file.put_integer (l_static_type.id)
			current_file.put_integer (l_static_type.id)
			header_file.put_character ('x')
			current_file.put_character ('x')
			header_file.put_character ('(')
			current_file.put_character ('(')
			print_type_declaration (current_type, header_file)
			print_type_declaration (current_type, current_file)
			if current_type.is_expanded then
				header_file.put_character ('*')
				current_file.put_character ('*')
			end
			header_file.put_character (' ')
			current_file.put_character (' ')
			print_current_name (header_file)
			print_current_name (current_file)
			header_file.put_character (',')
			header_file.put_character (' ')
			current_file.put_character (',')
			current_file.put_character (' ')
			header_file.put_string (c_ge_deep)
			header_file.put_character ('*')
			header_file.put_character (' ')
			header_file.put_character ('t')
			header_file.put_character ('0')
			current_file.put_string (c_ge_deep)
			current_file.put_character ('*')
			current_file.put_character (' ')
			current_file.put_character ('t')
			current_file.put_character ('0')
			header_file.put_character (')')
			current_file.put_character (')')
			header_file.put_character (';')
			header_file.put_new_line
			current_file.put_new_line
				-- Print body to `current_file'.
			current_file.put_character ('{')
			current_file.put_new_line
			indent
			l_target_dynamic_type_ids := target_dynamic_type_ids
			l_target_dynamic_types := target_dynamic_types
			nb := a_target_type_set.count
			from i := 1 until i > nb loop
				l_dynamic_type := a_target_type_set.dynamic_type (i)
				l_type_id := l_dynamic_type.id
				l_target_dynamic_type_ids.force_last (l_type_id)
				l_target_dynamic_types.force_last (l_dynamic_type, l_type_id)
				i := i + 1
			end
			l_target_dynamic_type_ids.sort (dynamic_type_id_sorter)
			if l_switch or l_target_dynamic_type_ids.count > 20 then
					-- Use switch statement.
				print_indentation
				current_file.put_string (c_switch)
				current_file.put_character (' ')
				current_file.put_character ('(')
				print_attribute_type_id_access (tokens.current_keyword, l_static_type, False)
				current_file.put_character (')')
				current_file.put_character (' ')
				current_file.put_character ('{')
				current_file.put_new_line
				nb := l_target_dynamic_type_ids.count
				from i := 1 until i > nb loop
					l_type_id := l_target_dynamic_type_ids.item (i)
					l_dynamic_type := l_target_dynamic_types.item (l_type_id)
					print_indentation
					current_file.put_string (c_case)
					current_file.put_character (' ')
					current_file.put_integer (l_type_id)
					current_file.put_character (':')
					current_file.put_new_line
					indent
					print_indentation
					current_file.put_string (c_return)
					current_file.put_character (' ')
					current_file.put_character ('(')
					print_adapted_deep_twin_call (tokens.current_keyword, l_dynamic_type, l_static_type)
					current_file.put_character (')')
					current_file.put_character (';')
					current_file.put_new_line
					dedent
					i := i + 1
				end
				print_indentation
				current_file.put_character ('}')
				current_file.put_new_line
			else
				print_indentation
				current_file.put_string (c_int)
				current_file.put_character (' ')
				l_temp := temp_variable
				print_temp_name (l_temp, current_file)
				current_file.put_character (' ')
				current_file.put_character ('=')
				current_file.put_character (' ')
				print_attribute_type_id_access (tokens.current_keyword, l_static_type, False)
				current_file.put_character (';')
				current_file.put_new_line
					-- Use binary search.
				print_deep_twin_binary_search_polymorphic_call (l_static_type, 1, l_target_dynamic_type_ids.count, l_target_dynamic_type_ids, l_target_dynamic_types)
			end
			l_target_dynamic_type_ids.wipe_out
			l_target_dynamic_types.wipe_out
			print_indentation
			current_file.put_string (c_return)
			current_file.put_character (' ')
			print_default_entity_value (l_static_type, current_file)
			current_file.put_character (';')
			current_file.put_new_line
			dedent
			current_file.put_character ('}')
			current_file.put_new_line
			current_file.put_new_line
			flush_to_c_file
			current_type := old_type
		end

	print_deep_twin_binary_search_polymorphic_call (a_target_static_type: ET_DYNAMIC_TYPE; l, u: INTEGER; a_target_dynamic_type_ids: DS_ARRAYED_LIST [INTEGER]; a_target_dynamic_types: DS_HASH_TABLE [ET_DYNAMIC_TYPE, INTEGER])
			-- Print to `current_file' dynamic binding code for the call to 'GE_deep_twin'
			-- whose target's static type is `a_target_static_type' and whose target's
			-- dynamic types are those stored in `a_target_dynamic_types' whose type-id is
			-- itself stored between indexes `l' and `u' in `a_target_dynamic_type_ids'.
			-- The generated code uses binary search to find out which feature to execute.
		require
			a_target_static_type_not_void: a_target_static_type /= Void
			a_target_dynamic_type_ids_not_void: a_target_dynamic_type_ids /= Void
			a_target_dynamic_types_not_void: a_target_dynamic_types /= Void
			no_void_target_dynamic_type: not a_target_dynamic_types.has_void_item
			consistent_count: a_target_dynamic_types.count = a_target_dynamic_type_ids.count
			l_large_enough: l >= 1
			l_small_enough: l <= u
			u_small_enough: u <= a_target_dynamic_type_ids.count
		local
			t: INTEGER
			l_dynamic_type: ET_DYNAMIC_TYPE
			l_type_id: INTEGER
			l_temp: ET_IDENTIFIER
		do
			l_temp := temp_variable
			if l = u then
				l_type_id := a_target_dynamic_type_ids.item (l)
				l_dynamic_type := a_target_dynamic_types.item (l_type_id)
				print_indentation
				current_file.put_string (c_return)
				current_file.put_character (' ')
				current_file.put_character ('(')
				print_adapted_deep_twin_call (tokens.current_keyword, l_dynamic_type, a_target_static_type)
				current_file.put_character (')')
				current_file.put_character (';')
				current_file.put_new_line
			elseif l + 1 = u then
				l_type_id := a_target_dynamic_type_ids.item (l)
				l_dynamic_type := a_target_dynamic_types.item (l_type_id)
				current_file.put_string (c_if)
				current_file.put_character (' ')
				current_file.put_character ('(')
				print_temp_name (l_temp, current_file)
				current_file.put_character ('=')
				current_file.put_character ('=')
				current_file.put_integer (l_type_id)
				current_file.put_character (')')
				current_file.put_character (' ')
				current_file.put_character ('{')
				current_file.put_new_line
				print_indentation
				current_file.put_string (c_return)
				current_file.put_character (' ')
				current_file.put_character ('(')
				print_adapted_deep_twin_call (tokens.current_keyword, l_dynamic_type, a_target_static_type)
				current_file.put_character (')')
				current_file.put_character (';')
				current_file.put_new_line
				current_file.put_character ('}')
				current_file.put_character (' ')
				current_file.put_string (c_else)
				current_file.put_character (' ')
				current_file.put_character ('{')
				current_file.put_new_line
				l_type_id := a_target_dynamic_type_ids.item (u)
				l_dynamic_type := a_target_dynamic_types.item (l_type_id)
				print_indentation
				current_file.put_string (c_return)
				current_file.put_character (' ')
				current_file.put_character ('(')
				print_adapted_deep_twin_call (tokens.current_keyword, l_dynamic_type, a_target_static_type)
				current_file.put_character (')')
				current_file.put_character (';')
				current_file.put_new_line
				current_file.put_character ('}')
				current_file.put_new_line
			else
				t := l + (u - l) // 2
				l_type_id := a_target_dynamic_type_ids.item (t)
				current_file.put_string (c_if)
				current_file.put_character (' ')
				current_file.put_character ('(')
				print_temp_name (l_temp, current_file)
				current_file.put_character ('<')
				current_file.put_character ('=')
				current_file.put_integer (l_type_id)
				current_file.put_character (')')
				current_file.put_character (' ')
				current_file.put_character ('{')
				current_file.put_new_line
				print_deep_twin_binary_search_polymorphic_call (a_target_static_type, l, t, a_target_dynamic_type_ids, a_target_dynamic_types)
				current_file.put_character ('}')
				current_file.put_character (' ')
				current_file.put_string (c_else)
				current_file.put_character (' ')
				current_file.put_character ('{')
				current_file.put_new_line
				print_deep_twin_binary_search_polymorphic_call (a_target_static_type, t + 1, u, a_target_dynamic_type_ids, a_target_dynamic_types)
				current_file.put_character ('}')
				current_file.put_new_line
			end
		end

	print_set_deep_twined_attribute (an_attribute_type_set: ET_DYNAMIC_TYPE_SET; a_print_attribute_access: PROCEDURE [ANY, TUPLE])
			-- Print to `current_file' the instructions needed to deep twin an attribute
			-- of `current_type' whose dynamic type set is `an_attribute_type_set'.
			-- `a_print_attribute_access' is used to print to `current_file'
			-- the code to access this attribute. Indeed, it can be a "regular"
			-- attribute, but it can also be items of a SPECIAL object, fields
			-- of a TUPLE object, closed operands of an Agent object, ...
		require
			an_attribute_type_set_not_void: an_attribute_type_set /= Void
			an_attribute_type_set_not_empty: not an_attribute_type_set.is_empty
			a_print_attribute_access_not_void: a_print_attribute_access /= Void
		local
			l_attribute_type: ET_DYNAMIC_TYPE
			l_temp1, l_temp2: ET_IDENTIFIER
		do
			l_attribute_type := an_attribute_type_set.static_type
			l_temp1 := new_temp_variable (l_attribute_type)
			print_indentation
			print_temp_name (l_temp1, current_file)
			current_file.put_character (' ')
			current_file.put_character ('=')
			current_file.put_character (' ')
			a_print_attribute_access.call ([])
			current_file.put_character (';')
			current_file.put_new_line
			if l_attribute_type.is_expanded then
					-- No need to test whether the attribute is Void or not:
					-- expanded attributes are never Void.
				print_indentation
				a_print_attribute_access.call ([])
				current_file.put_character (' ')
				current_file.put_character ('=')
				current_file.put_character (' ')
				print_deep_twined_attribute (l_temp1, an_attribute_type_set)
				current_file.put_character (';')
				current_file.put_new_line
			else
					-- If the attribute is Void, then there is no need to twin it.
				print_indentation
				current_file.put_string (c_if)
				current_file.put_character (' ')
				current_file.put_character ('(')
				print_temp_name (l_temp1, current_file)
				current_file.put_character (')')
				current_file.put_character (' ')
				current_file.put_character ('{')
				current_file.put_new_line
				indent
				l_temp2 := new_temp_variable (l_attribute_type)
				print_indentation
				print_temp_name (l_temp2, current_file)
				current_file.put_string (" = GE_deep_item(")
				print_temp_name (l_temp1, current_file)
				current_file.put_string (", t0);")
				current_file.put_new_line
				print_indentation
				a_print_attribute_access.call ([])
				current_file.put_character (' ')
				current_file.put_character ('=')
				current_file.put_character (' ')
				current_file.put_character ('(')
				print_temp_name (l_temp2, current_file)
				current_file.put_character ('?')
					-- The object has not been twined yet.
				print_temp_name (l_temp2, current_file)
				current_file.put_character (':')
				current_file.put_character ('(')
				print_deep_twined_attribute (l_temp1, an_attribute_type_set)
				current_file.put_character (')')
				current_file.put_character (')')
				current_file.put_character (';')
				current_file.put_new_line
				dedent
				print_indentation
				current_file.put_character ('}')
				current_file.put_new_line
				mark_temp_variable_free (l_temp2)
			end
			mark_temp_variable_free (l_temp1)
		end

	print_deep_twined_attribute (an_attribute: ET_EXPRESSION; an_attribute_type_set: ET_DYNAMIC_TYPE_SET)
			-- Print to `current_file' deep twined version of the attribute `an_attribute'
			-- belonging to `current_type', with dynamic type set `an_attribute_type_set'.
			-- The test for Void-ness of the attribute is assumed to have
			-- been generated elsewhere. And the attribute is assumed not to
			-- have been deep twined already.
		require
			an_attribute_not_void: an_attribute /= Void
			an_attribute_type_set_not_void: an_attribute_type_set /= Void
			an_attribute_type_set_not_empty: not an_attribute_type_set.is_empty
		local
			i, nb: INTEGER
			l_attribute_type: ET_DYNAMIC_TYPE
			l_dynamic_type: ET_DYNAMIC_TYPE
			l_standalone_type_set: ET_DYNAMIC_STANDALONE_TYPE_SET
		do
			l_attribute_type := an_attribute_type_set.static_type
			nb := an_attribute_type_set.count
			if nb = 1 then
					-- Monomorphic call.
				l_dynamic_type := an_attribute_type_set.dynamic_type (1)
				deep_twin_types.force_last (l_dynamic_type)
				print_adapted_deep_twin_call (an_attribute, l_dynamic_type, l_attribute_type)
			elseif nb = 2 then
					-- Polymorphic with only two possible types at run-time.
				l_dynamic_type := an_attribute_type_set.dynamic_type (1)
				deep_twin_types.force_last (l_dynamic_type)
				current_file.put_character ('(')
				current_file.put_character ('(')
				print_attribute_type_id_access (an_attribute, l_attribute_type, False)
				current_file.put_character ('=')
				current_file.put_character ('=')
				current_file.put_integer (l_dynamic_type.id)
				current_file.put_character (')')
				current_file.put_character ('?')
				print_adapted_deep_twin_call (an_attribute, l_dynamic_type, l_attribute_type)
				current_file.put_character (':')
				l_dynamic_type := an_attribute_type_set.dynamic_type (2)
				deep_twin_types.force_last (l_dynamic_type)
				print_adapted_deep_twin_call (an_attribute, l_dynamic_type, l_attribute_type)
				current_file.put_character (')')
			else
					-- Polymorphic with more than two possible types at run-time.
					-- Wrap this polymorphic call into a funtion that will be
					-- shared by other polymorphic calls having the same target
					-- static type.
					--
					-- First, register all what is needed so that this shared
					-- function will be generated correctly.
				deep_feature_target_type_sets.search (l_attribute_type)
				if deep_feature_target_type_sets.found then
					l_standalone_type_set := deep_feature_target_type_sets.found_item
				else
					if standalone_type_sets.count > deep_feature_target_type_sets.count then
						l_standalone_type_set := standalone_type_sets.item (deep_feature_target_type_sets.count + 1)
						l_standalone_type_set.reset (l_attribute_type)
					else
						create l_standalone_type_set.make (l_attribute_type)
						standalone_type_sets.force_last (l_standalone_type_set)
					end
					deep_feature_target_type_sets.force_last_new (l_standalone_type_set, l_attribute_type)
				end
				l_standalone_type_set.put_types (an_attribute_type_set)
				from i := 1 until i > nb loop
					deep_twin_types.force_last (an_attribute_type_set.dynamic_type (i))
					i := i + 1
				end
					-- Now call the shared function that will trigger the
					-- polymorphic call.
				current_file.put_string (c_ge_deep_twin)
				current_file.put_integer (l_attribute_type.id)
				current_file.put_character ('x')
				current_file.put_character ('(')
				print_target_expression (an_attribute, l_attribute_type, False)
				current_file.put_character (',')
				current_file.put_character (' ')
				current_file.put_character ('t')
				current_file.put_character ('0')
				current_file.put_character (')')
			end
		end

	print_adapted_deep_twin_call (a_target: ET_EXPRESSION; a_target_type, a_result_type: ET_DYNAMIC_TYPE)
			-- Print to `current_file' a call to the 'GE_deep_twin' function that
			-- will deep twin `a_target' of type `a_target_type'.
			-- `a_result_type' is the static type of the result expected by the caller,
			-- used to adapt the result of 'GE_deep_twin' if needed (see header comment
			-- of `print_adapted_expression' for details).
			-- The test for Void-ness of the target is assumed to have
			-- been generated elsewhere.
		require
			a_target_not_void: a_target /= Void
			a_target_type_not_void: a_target_type /= Void
			a_result_type_not_void: a_result_type /= Void
		do
			print_adapted_expression (agent print_deep_twin_call (a_target, a_target_type), a_target_type, a_result_type)
		end

	print_deep_twin_call (a_target: ET_EXPRESSION; a_target_type: ET_DYNAMIC_TYPE)
			-- Print to `current_file' a call to the 'GE_deep_twin' function that
			-- will deep twin `a_target' of type `a_target_type'.
			-- The test for Void-ness of the target is assumed to have
			-- been generated elsewhere.
			-- Note that the result of 'GE_deep_twin' is not adapted to match the
			-- kind of result type expected by the caller. It is recommended to
			-- use `print_adapted_deep_twin_call' whenever possible.
		require
			a_target_not_void: a_target /= Void
			a_target_type_not_void: a_target_type /= Void
		do
			current_file.put_string (c_ge_deep_twin)
			current_file.put_integer (a_target_type.id)
			current_file.put_character ('(')
			print_target_expression (a_target, a_target_type, False)
			current_file.put_character (',')
			current_file.put_character (' ')
			current_file.put_character ('t')
			current_file.put_character ('0')
			current_file.put_character (')')
		end

	deep_twin_types: DS_HASH_SET [ET_DYNAMIC_TYPE]
			-- Types of object that need to be deep twined

	deep_equal_types: DS_HASH_SET [ET_DYNAMIC_TYPE]
			-- Types of object that need deep equality

	deep_feature_target_type_sets: DS_HASH_TABLE [ET_DYNAMIC_STANDALONE_TYPE_SET, ET_DYNAMIC_TYPE]
			-- Dynamic type sets of target of deep feature (deep twin or deep equal),
			-- indexed by target static type

feature {NONE} -- Built-in feature generation

	print_builtin_any_conforms_to_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' the body of `a_feature' corresponding
			-- to built-in feature 'ANY.conforms_to'.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		local
			l_arguments: ET_FORMAL_ARGUMENT_LIST
			l_argument_type_set: ET_DYNAMIC_TYPE_SET
			l_conforming_types: ET_DYNAMIC_TYPE_HASH_LIST
			l_non_conforming_types: ET_DYNAMIC_TYPE_HASH_LIST
			l_dynamic_type: ET_DYNAMIC_TYPE
			i, nb: INTEGER
		do
			l_arguments := a_feature.arguments
			if l_arguments = Void or else l_arguments.count /= 1 then
					-- Internal error: this error should have been reported by the parse.
				set_fatal_error
				error_handler.report_giaaa_error_cl ("__CLASS__", "__LINE__")
			else
				l_argument_type_set := argument_type_set (1)
				nb := l_argument_type_set.count
				l_conforming_types := conforming_types
				l_conforming_types.resize (nb)
				l_non_conforming_types := non_conforming_types
				l_non_conforming_types.resize (nb)
				from i := 1 until i > nb loop
					l_dynamic_type := l_argument_type_set.dynamic_type (i)
					if current_type.conforms_to_type (l_dynamic_type) then
						l_conforming_types.put_last (l_dynamic_type)
					else
						l_non_conforming_types.put_last (l_dynamic_type)
					end
					i := i + 1
				end
				if l_non_conforming_types.is_empty then
						-- `current_type' conforms to all types of `l_argument_type_set'.
					print_indentation
					print_result_name (current_file)
					current_file.put_character (' ')
					current_file.put_character ('=')
					current_file.put_character (' ')
					current_file.put_string (c_eif_true)
					current_file.put_character (';')
					current_file.put_new_line
				elseif l_conforming_types.is_empty then
						-- `current_type' conforms to none of the types of `l_argument_type_set'.
					print_indentation
					print_result_name (current_file)
					current_file.put_character (' ')
					current_file.put_character ('=')
					current_file.put_character (' ')
					current_file.put_string (c_eif_false)
					current_file.put_character (';')
					current_file.put_new_line
				elseif l_non_conforming_types.count < l_conforming_types.count then
					print_indentation
					current_file.put_string (c_switch)
					current_file.put_character (' ')
					current_file.put_character ('(')
					print_attribute_type_id_access (l_arguments.formal_argument (1).name, current_dynamic_system.any_type, True)
					current_file.put_character (')')
					current_file.put_character (' ')
					current_file.put_character ('{')
					current_file.put_new_line
					nb := l_non_conforming_types.count
					from i := 1 until i > nb loop
						l_dynamic_type := l_non_conforming_types.dynamic_type (i)
						print_indentation
						current_file.put_string (c_case)
						current_file.put_character (' ')
						current_file.put_integer (l_dynamic_type.id)
						current_file.put_character (':')
						current_file.put_new_line
						i := i + 1
					end
					indent
					print_indentation
					print_result_name (current_file)
					current_file.put_character (' ')
					current_file.put_character ('=')
					current_file.put_character (' ')
					current_file.put_string (c_eif_false)
					current_file.put_character (';')
					current_file.put_new_line
					print_indentation
					current_file.put_string (c_break)
					current_file.put_character (';')
					current_file.put_new_line
					dedent
					print_indentation
					current_file.put_string (c_default)
					current_file.put_character (':')
					current_file.put_new_line
					indent
					print_indentation
					print_result_name (current_file)
					current_file.put_character (' ')
					current_file.put_character ('=')
					current_file.put_character (' ')
					current_file.put_string (c_eif_true)
					current_file.put_character (';')
					current_file.put_new_line
					dedent
					print_indentation
					current_file.put_character ('}')
				else
					print_indentation
					current_file.put_string (c_switch)
					current_file.put_character (' ')
					current_file.put_character ('(')
					print_attribute_type_id_access (l_arguments.formal_argument (1).name, current_dynamic_system.any_type, True)
					current_file.put_character (')')
					current_file.put_character (' ')
					current_file.put_character ('{')
					current_file.put_new_line
					nb := l_conforming_types.count
					from i := 1 until i > nb loop
						l_dynamic_type := l_conforming_types.dynamic_type (i)
						print_indentation
						current_file.put_string (c_case)
						current_file.put_character (' ')
						current_file.put_integer (l_dynamic_type.id)
						current_file.put_character (':')
						current_file.put_new_line
						i := i + 1
					end
					indent
					print_indentation
					print_result_name (current_file)
					current_file.put_character (' ')
					current_file.put_character ('=')
					current_file.put_character (' ')
					current_file.put_string (c_eif_true)
					current_file.put_character (';')
					current_file.put_new_line
					print_indentation
					current_file.put_string (c_break)
					current_file.put_character (';')
					current_file.put_new_line
					dedent
					print_indentation
					current_file.put_string (c_default)
					current_file.put_character (':')
					current_file.put_new_line
					indent
					print_indentation
					print_result_name (current_file)
					current_file.put_character (' ')
					current_file.put_character ('=')
					current_file.put_character (' ')
					current_file.put_string (c_eif_false)
					current_file.put_character (';')
					current_file.put_new_line
					dedent
					print_indentation
					current_file.put_character ('}')
				end
				l_conforming_types.wipe_out
				l_non_conforming_types.wipe_out
			end
		end

	print_builtin_any_copy_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'ANY.copy'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		do
			print_builtin_any_standard_copy_call (a_feature, a_target_type, a_check_void_target)
		end

	print_builtin_any_deep_twin_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'ANY.deep_twin'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		do
			deep_twin_types.force_last (a_target_type)
			current_file.put_string (c_ge_deep_twin)
			current_file.put_integer (a_target_type.id)
			current_file.put_character ('(')
			print_target_expression (call_operands.first, a_target_type, a_check_void_target)
			current_file.put_character (',')
			current_file.put_character (' ')
			current_file.put_character ('0')
			current_file.put_character (')')
		end

	print_builtin_any_generating_type_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'ANY.generating_type'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_string: STRING
			l_result_type: ET_DYNAMIC_TYPE
			l_universe: ET_UNIVERSE
			l_any_class: ET_CLASS
		do
			l_result_type := result_type_set_in_feature (a_feature).static_type
			l_any_class := a_feature.static_feature.implementation_class
			l_universe := l_any_class.universe
			if l_universe = Void then
					-- Internal error: class ANY should be know at this stage.
				set_fatal_error
				error_handler.report_giaaa_error_cl ("__CLASS__", "__LINE__")
			elseif l_universe.string_32_type.same_named_type (l_result_type.base_type, l_any_class, l_any_class) then
				current_file.put_string (c_ge_ms32)
			else
				current_file.put_string (c_ge_ms8)
			end
			current_file.put_character ('(')
			l_string := a_target_type.base_type.unaliased_to_text
			print_escaped_string (l_string)
			current_file.put_character (',')
			current_file.put_character (' ')
			current_file.put_integer (l_string.count)
			current_file.put_character (')')
		end

	print_builtin_any_generator_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'ANY.generator'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_string: STRING
			l_result_type_set: ET_DYNAMIC_TYPE_SET
		do
			l_result_type_set := a_feature.result_type_set
			if l_result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error_cl ("__CLASS__", "__LINE__")
			else
				if l_result_type_set.static_type = current_dynamic_system.string_32_type then
					current_file.put_string (c_ge_ms32)
				else
					current_file.put_string (c_ge_ms8)
				end
				current_file.put_character ('(')
				l_string := a_target_type.base_class.upper_name
				print_escaped_string (l_string)
				current_file.put_character (',')
				current_file.put_character (' ')
				current_file.put_integer (l_string.count)
				current_file.put_character (')')
			end
		end

	print_builtin_any_is_deep_equal_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' then body of `a_feature' corresponding
			-- to built-in feature 'ANY.is_deep_equal'.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		do
-- TODO
print ("ET_C_GENERATOR.print_builtin_any_is_deep_equal_body%N")
		end

	print_builtin_any_same_type_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'ANY.same_type'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_argument: ET_EXPRESSION
			l_argument_type_set: ET_DYNAMIC_TYPE_SET
			l_argument_static_type: ET_DYNAMIC_TYPE
		do
			if call_operands.count /= 2 then
					-- Internal error: this should already have been reported in ET_FEATURE_FLATTENER.
				set_fatal_error
				error_handler.report_giaaa_error_cl ("__CLASS__", "__LINE__")
			elseif a_feature.result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error_cl ("__CLASS__", "__LINE__")
			else
				l_argument := call_operands.item (2)
				l_argument_type_set := dynamic_type_set (l_argument)
				l_argument_static_type := l_argument_type_set.static_type
				if not l_argument_type_set.has_type (a_target_type) then
-- TODO: check to see whether we need to call 'copy' on the argument
-- as part of the argument passing attachment.
					current_file.put_string (c_eif_false)
				elseif l_argument_type_set.count = 1 then
-- TODO: check to see whether we need to call 'copy' on the argument
-- as part of the argument passing attachment.
						-- `a_target_type' is one of the types held in `l_argument_type_set'
						-- (see the if-branch above). Now we know that it is the only one.
					current_file.put_string (c_eif_true)
				else
-- TODO: check to see whether we need to call 'copy' on the argument
-- as part of the argument passing attachment.
					print_type_cast (a_feature.result_type_set.static_type, current_file)
					current_file.put_character ('(')
						-- We know that the argument is equipped with a type-id
						-- attribute, otherwise `l_argument_static_type' would have
						-- to be a non-generic expanded type, and this is covered
						-- by the elseif-branch just above. Indeed non-generic
						-- expanded types cannot be polymorphic, so the number
						-- of types in `l_argument_type_set' can only be one.
					print_attribute_type_id_access (l_argument, l_argument_static_type, True)
					current_file.put_character ('=')
					current_file.put_character ('=')
					current_file.put_integer (a_target_type.id)
					current_file.put_character (')')
				end
			end
		end

	print_builtin_any_standard_is_equal_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'ANY.standard_is_equal'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_target: ET_EXPRESSION
			l_target_type_set: ET_DYNAMIC_TYPE_SET
			l_target_static_type: ET_DYNAMIC_TYPE
			l_argument: ET_EXPRESSION
			l_argument_type_set: ET_DYNAMIC_TYPE_SET
			l_special_type: ET_DYNAMIC_SPECIAL_TYPE
		do
			if call_operands.count /= 2 then
					-- Internal error: this should already have been reported in ET_FEATURE_FLATTENER.
				set_fatal_error
				error_handler.report_giaaa_error_cl ("__CLASS__", "__LINE__")
			elseif a_feature.result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error_cl ("__CLASS__", "__LINE__")
			else
				l_target := call_operands.first
				l_argument := call_operands.item (2)
				l_target_type_set := dynamic_type_set (l_target)
				l_argument_type_set := dynamic_type_set (l_argument)
				if a_target_type.is_expanded and then a_target_type.is_basic then
					print_type_cast (a_feature.result_type_set.static_type, current_file)
					current_file.put_character ('(')
					current_file.put_character ('(')
					print_unboxed_expression (l_target, a_target_type, a_check_void_target)
					current_file.put_character (')')
					current_file.put_character ('=')
					current_file.put_character ('=')
					current_file.put_character ('(')
					print_attachment_expression (l_argument, l_argument_type_set, a_target_type)
					current_file.put_character (')')
					current_file.put_character (')')
				else
					print_type_cast (a_feature.result_type_set.static_type, current_file)
					current_file.put_character ('(')
					current_file.put_character ('!')
					current_file.put_string (c_memcmp)
					current_file.put_character ('(')
					l_target_static_type := l_target_type_set.static_type
					if l_target_static_type.is_expanded then
							-- Current value.
						current_file.put_character ('&')
						current_file.put_character ('(')
						print_expression (l_target)
						current_file.put_character (')')
					elseif a_target_type.is_expanded and not a_target_type.is_generic then
							-- We need to unbox the object.
						current_file.put_character ('&')
						current_file.put_character ('(')
						print_boxed_attribute_item_access (l_target, a_target_type, a_check_void_target)
						current_file.put_character (')')
					else
						print_expression (l_target)
					end
					current_file.put_character (',')
					current_file.put_character (' ')
					if a_target_type.is_expanded then
-- TODO: address of what when constant or result of a function?
						current_file.put_character ('&')
						current_file.put_character ('(')
						print_attachment_expression (l_argument, l_argument_type_set, a_target_type)
						current_file.put_character (')')
					else
						print_attachment_expression (l_argument, l_argument_type_set, a_target_type)
					end
					current_file.put_character (',')
					current_file.put_character (' ')
					current_file.put_string (c_sizeof)
					current_file.put_character ('(')
					print_type_name (a_target_type, current_file)
					current_file.put_character (')')
					l_special_type ?= a_target_type
					if l_special_type /= Void then
						current_file.put_character ('+')
						current_file.put_character ('(')
						print_attribute_special_count_access (l_target, l_special_type, a_check_void_target)
							-- The struct already contains one element of the SPECIAL, hence the -1 below.
						current_file.put_character ('-')
						current_file.put_character ('1')
						current_file.put_character (')')
						current_file.put_character ('*')
						current_file.put_string (c_sizeof)
						current_file.put_character ('(')
						print_type_declaration (l_special_type.item_type_set.static_type, current_file)
						current_file.put_character (')')
					end
					current_file.put_character (')')
					current_file.put_character (')')
				end
			end
		end

	print_builtin_any_standard_copy_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static_binding) to `a_feature'
			-- corresponding to built-in feature 'ANY.standard_copy'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_target: ET_EXPRESSION
			l_target_type_set: ET_DYNAMIC_TYPE_SET
			l_argument: ET_EXPRESSION
			l_argument_type_set: ET_DYNAMIC_TYPE_SET
			l_special_type: ET_DYNAMIC_SPECIAL_TYPE
			l_temp: ET_IDENTIFIER
			l_dynamic_type_set: ET_DYNAMIC_TYPE_SET
			l_count_type: ET_DYNAMIC_TYPE
		do
			if call_operands.count /= 2 then
					-- Internal error: this should already have been reported in ET_FEATURE_FLATTENER.
				set_fatal_error
				error_handler.report_giaaa_error_cl ("__CLASS__", "__LINE__")
			else
				l_special_type ?= a_target_type
				l_target := call_operands.first
				l_argument := call_operands.item (2)
				l_target_type_set := dynamic_type_set (l_target)
				l_argument_type_set := dynamic_type_set (l_argument)
				if l_special_type /= Void then
-- TODO: both objects have to be of the same type.
					if l_special_type.attribute_count < 1 then
							-- Internal error: class "SPECIAL" should have at least the
							-- feature 'count' as first feature.
							-- Already reported in ET_DYNAMIC_SYSTEM.compile_kernel.
						set_fatal_error
						error_handler.report_giaaa_error_cl ("__CLASS__", "__LINE__")
					else
						l_dynamic_type_set := result_type_set_in_feature (l_special_type.queries.first)
						l_count_type := l_dynamic_type_set.static_type
						print_indentation
						l_temp := new_temp_variable (l_count_type)
						print_temp_name (l_temp, current_file)
						current_file.put_character (' ')
						current_file.put_character ('=')
						current_file.put_character (' ')
						print_attribute_special_count_access (l_argument, l_special_type, True)
						current_file.put_character (';')
						current_file.put_new_line
						print_indentation
						current_file.put_string (c_if)
						current_file.put_character (' ')
						current_file.put_character ('(')
						print_temp_name (l_temp, current_file)
						current_file.put_character ('<')
						current_file.put_character ('=')
						print_attribute_special_count_access (l_target, l_special_type, a_check_void_target)
						current_file.put_character (')')
						current_file.put_character (' ')
						current_file.put_character ('{')
						current_file.put_new_line
						indent
						print_indentation
						if not l_special_type.is_expanded then
							current_file.put_character ('*')
						end
						print_type_cast (l_special_type, current_file)
						current_file.put_character ('(')
						print_expression (l_target)
						current_file.put_character (')')
						current_file.put_character (' ')
						current_file.put_character ('=')
						current_file.put_character (' ')
						if not l_special_type.is_expanded then
							current_file.put_character ('*')
						end
						print_type_cast (l_special_type, current_file)
						current_file.put_character ('(')
						print_expression (l_argument)
						current_file.put_character (')')
						current_file.put_character (';')
						current_file.put_new_line
							-- Copy items.
						print_indentation
						current_file.put_string (c_memcpy)
						current_file.put_character ('(')
							-- Note that we already checked that the target and the argument were not Void.
							-- So no need to check it again here, hence the False argument in the calls below.
						print_attribute_special_item_access (l_target, l_special_type, False)
						current_file.put_character (',')
						print_attribute_special_item_access (l_argument, l_special_type, False)
						current_file.put_character (',')
						print_attribute_special_count_access (l_argument, l_special_type, False)
						current_file.put_character ('*')
						current_file.put_string (c_sizeof)
						current_file.put_character ('(')
						print_type_declaration (l_special_type.item_type_set.static_type, current_file)
						current_file.put_character (')')
						current_file.put_character (')')
						current_file.put_character (';')
						current_file.put_new_line
						dedent
						print_indentation
						current_file.put_character ('}')
						current_file.put_character (' ')
						current_file.put_string (c_else)
						current_file.put_character (' ')
						current_file.put_character ('{')
						current_file.put_new_line
						indent
-- TODO: what to do if Current is not large enough?
						print_info_message_call ("Exception in SPECIAL.standard_copy: target not big enough")
						dedent
						print_indentation
						current_file.put_character ('}')
						current_file.put_new_line
					end
				elseif a_target_type.is_expanded then
					print_indentation
					print_unboxed_expression (l_target, a_target_type, a_check_void_target)
					current_file.put_character (' ')
					current_file.put_character ('=')
					current_file.put_character (' ')
					current_file.put_character ('(')
					print_attachment_expression (l_argument, l_argument_type_set, a_target_type)
					current_file.put_character (')')
					current_file.put_character (';')
					current_file.put_new_line
				else
					print_indentation
					current_file.put_character ('*')
					print_type_cast (a_target_type, current_file)
					current_file.put_character ('(')
					print_expression (l_target)
					current_file.put_character (')')
					current_file.put_character (' ')
					current_file.put_character ('=')
					current_file.put_character (' ')
					current_file.put_character ('*')
					print_type_cast (a_target_type, current_file)
					current_file.put_character ('(')
					print_attachment_expression (l_argument, l_argument_type_set, a_target_type)
					current_file.put_character (')')
					current_file.put_character (';')
					current_file.put_new_line
				end
			end
		end

	print_builtin_any_standard_twin_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' the body of `a_feature' corresponding
			-- to built-in feature 'ANY.standard_twin'.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		local
			l_special_type: ET_DYNAMIC_SPECIAL_TYPE
		do
			l_special_type ?= current_type
			if l_special_type /= Void then
				print_indentation
				print_result_name (current_file)
				current_file.put_character (' ')
				current_file.put_character ('=')
				current_file.put_character (' ')
				current_file.put_string (c_ge_new)
				current_file.put_integer (l_special_type.id)
				current_file.put_character ('(')
				print_attribute_special_count_access (tokens.current_keyword, l_special_type, False)
				current_file.put_character (',')
				current_file.put_character (' ')
				current_file.put_string (c_eif_false)
				current_file.put_character (')')
				current_file.put_character (';')
				current_file.put_new_line
				print_indentation
				if not l_special_type.is_expanded then
					current_file.put_character ('*')
				end
				print_type_cast (l_special_type, current_file)
				current_file.put_character ('(')
				print_result_name (current_file)
				current_file.put_character (')')
				current_file.put_character (' ')
				current_file.put_character ('=')
				current_file.put_character (' ')
				if not l_special_type.is_expanded then
					current_file.put_character ('*')
				end
				print_type_cast (l_special_type, current_file)
				current_file.put_character ('(')
				print_current_name (current_file)
				current_file.put_character (')')
				current_file.put_character (';')
				current_file.put_new_line
					-- Copy items.
				print_indentation
				current_file.put_string (c_memcpy)
				current_file.put_character ('(')
				print_attribute_special_item_access (tokens.result_keyword, l_special_type, False)
				current_file.put_character (',')
				print_attribute_special_item_access (tokens.current_keyword, l_special_type, False)
				current_file.put_character (',')
				print_attribute_special_count_access (tokens.current_keyword, l_special_type, False)
				current_file.put_character ('*')
				current_file.put_string (c_sizeof)
				current_file.put_character ('(')
				print_type_declaration (l_special_type.item_type_set.static_type, current_file)
				current_file.put_character (')')
				current_file.put_character (')')
				current_file.put_character (';')
				current_file.put_new_line
			elseif current_type.base_class.is_type_class then
-- TODO: this built-in routine could be inlined.
					-- Cannot have two instances of class TYPE representing the same Eiffel type.
				print_indentation
				print_result_name (current_file)
				current_file.put_character (' ')
				current_file.put_character ('=')
				current_file.put_character (' ')
				print_current_name (current_file)
				current_file.put_character (';')
				current_file.put_new_line
			elseif current_type.is_expanded then
				print_indentation
				print_result_name (current_file)
				current_file.put_character (' ')
				current_file.put_character ('=')
				current_file.put_character (' ')
				current_file.put_character ('*')
				print_current_name (current_file)
				current_file.put_character (';')
				current_file.put_new_line
			else
				print_indentation
				print_result_name (current_file)
				current_file.put_character (' ')
				current_file.put_character ('=')
				current_file.put_character (' ')
				current_file.put_string (c_ge_new)
				current_file.put_integer (current_type.id)
				current_file.put_character ('(')
				current_file.put_string (c_eif_false)
				current_file.put_character (')')
				current_file.put_character (';')
				current_file.put_new_line
				print_indentation
				current_file.put_character ('*')
				print_type_cast (current_type, current_file)
				current_file.put_character ('(')
				print_result_name (current_file)
				current_file.put_character (')')
				current_file.put_character (' ')
				current_file.put_character ('=')
				current_file.put_character (' ')
				current_file.put_character ('*')
				print_type_cast (current_type, current_file)
				current_file.put_character ('(')
				print_current_name (current_file)
				current_file.put_character (')')
				current_file.put_character (';')
				current_file.put_new_line
			end
		end

	print_builtin_any_tagged_out_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' the body of `a_feature' corresponding
			-- to built-in feature 'ANY.tagged_out'.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		local
			l_special_type: ET_DYNAMIC_SPECIAL_TYPE
			l_string: STRING
			l_result_type_set: ET_DYNAMIC_TYPE_SET
		do
			l_result_type_set := current_feature.result_type_set
			if l_result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error_cl ("__CLASS__", "__LINE__")
			else
-- TODO
				print_indentation
				print_result_name (current_file)
				current_file.put_character (' ')
				current_file.put_character ('=')
				current_file.put_character (' ')
				l_string := current_type.base_type.unaliased_to_text
				if l_result_type_set.static_type = current_dynamic_system.string_32_type then
					current_file.put_string (c_ge_ms32)
				else
					current_file.put_string (c_ge_ms8)
				end
				current_file.put_character ('(')
				print_escaped_string (l_string)
				current_file.put_character (',')
				current_file.put_character (' ')
				current_file.put_integer (l_string.count)
				current_file.put_character (')')
				current_file.put_character (';')
				current_file.put_new_line
				l_special_type ?= current_type
				if l_special_type /= Void then
				elseif current_type.is_basic then
				else
				end
			end
		end

	print_builtin_any_twin_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' the body of `a_feature' corresponding
			-- to built-in feature 'ANY.twin'.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		local
			l_special_type: ET_DYNAMIC_SPECIAL_TYPE
			l_copy_feature: ET_DYNAMIC_FEATURE
		do
			l_special_type ?= current_type
			if l_special_type /= Void then
				print_indentation
				print_result_name (current_file)
				current_file.put_character (' ')
				current_file.put_character ('=')
				current_file.put_character (' ')
				current_file.put_string (c_ge_new)
				current_file.put_integer (l_special_type.id)
				current_file.put_character ('(')
				print_attribute_special_count_access (tokens.current_keyword, l_special_type, False)
				current_file.put_character (',')
				current_file.put_character (' ')
				current_file.put_string (c_eif_false)
				current_file.put_character (')')
				current_file.put_character (';')
				current_file.put_new_line
				print_indentation
				if not current_type.is_expanded then
					current_file.put_character ('*')
				end
				print_type_cast (current_type, current_file)
				current_file.put_character ('(')
				print_result_name (current_file)
				current_file.put_character (')')
				current_file.put_character (' ')
				current_file.put_character ('=')
				current_file.put_character (' ')
				if not current_type.is_expanded then
					current_file.put_character ('*')
				end
				print_type_cast (current_type, current_file)
				current_file.put_character ('(')
				print_current_name (current_file)
				current_file.put_character (')')
				current_file.put_character (';')
				current_file.put_new_line
					-- Copy items.
-- TODO: should we rather call SPECIAL.copy?
				print_indentation
				current_file.put_string (c_memcpy)
				current_file.put_character ('(')
				print_attribute_special_item_access (tokens.result_keyword, l_special_type, False)
				current_file.put_character (',')
				print_attribute_special_item_access (tokens.current_keyword, l_special_type, False)
				current_file.put_character (',')
				print_attribute_special_count_access (tokens.current_keyword, l_special_type, False)
				current_file.put_character ('*')
				current_file.put_string (c_sizeof)
				current_file.put_character ('(')
				print_type_declaration (l_special_type.item_type_set.static_type, current_file)
				current_file.put_character (')')
				current_file.put_character (')')
				current_file.put_character (';')
				current_file.put_new_line
			elseif current_type.base_class.is_type_class then
-- TODO: this built-in routine could be inlined.
					-- Cannot have two instances of class TYPE representing the same Eiffel type.
				print_indentation
				print_result_name (current_file)
				current_file.put_character (' ')
				current_file.put_character ('=')
				current_file.put_character (' ')
				print_current_name (current_file)
				current_file.put_character (';')
				current_file.put_new_line
			elseif current_type.is_expanded then
-- TODO: call 'copy' if redefined.
				print_indentation
				print_result_name (current_file)
				current_file.put_character (' ')
				current_file.put_character ('=')
				current_file.put_character (' ')
				current_file.put_character ('*')
				print_current_name (current_file)
				current_file.put_character (';')
				current_file.put_new_line
			else
				print_indentation
				print_result_name (current_file)
				current_file.put_character (' ')
				current_file.put_character ('=')
				current_file.put_character (' ')
				current_file.put_string (c_ge_new)
				current_file.put_integer (current_type.id)
				current_file.put_character ('(')
				current_file.put_string (c_eif_true)
				current_file.put_character (')')
				current_file.put_character (';')
				current_file.put_new_line
-- TODO: should the object be duplicated, or should
-- we just get a blank copy before calling `copy'?
-- TODO: call 'copy' only when redefined.
				l_copy_feature := current_type.seeded_dynamic_procedure (current_system.copy_seed, current_dynamic_system)
				if l_copy_feature = Void then
						-- Internal error: this should already have been reported in ET_FEATURE_FLATTENER.
					set_fatal_error
					error_handler.report_giaaa_error_cl ("__CLASS__", "__LINE__")
				else
					if not l_copy_feature.is_generated then
						l_copy_feature.set_generated (True)
						called_features.force_last (l_copy_feature)
					end
					print_indentation
					print_routine_name (l_copy_feature, current_type, current_file)
					current_file.put_character ('(')
					if exception_trace_mode then
						current_file.put_string (current_call_info)
						current_file.put_character (',')
						current_file.put_character (' ')
					end
					if current_type.is_expanded then
						current_file.put_character ('&')
						print_result_name (current_file)
						current_file.put_character (',')
						current_file.put_character (' ')
						current_file.put_character ('*')
						print_current_name (current_file)
					else
						print_result_name (current_file)
						current_file.put_character (',')
						current_file.put_character (' ')
						print_current_name (current_file)
					end
					current_file.put_character (')')
					current_file.put_character (';')
					current_file.put_new_line
				end
			end
		end

	print_builtin_arguments_argument_count_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'ARGUMENTS.argument_count'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_result_type_set: ET_DYNAMIC_TYPE_SET
		do
			l_result_type_set := a_feature.result_type_set
			if l_result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error_cl ("__CLASS__", "__LINE__")
			else
				print_type_cast (l_result_type_set.static_type, current_file)
				current_file.put_character ('(')
				current_file.put_string (c_ge_argc)
				current_file.put_character (' ')
				current_file.put_character ('-')
				current_file.put_character (' ')
				current_file.put_character ('1')
				current_file.put_character (')')
			end
		end

	print_builtin_arguments_argument_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' the body of `a_feature' corresponding
			-- to built-in feature 'ARGUMENTS.argument'.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		local
			l_arguments: ET_FORMAL_ARGUMENT_LIST
			l_result_type_set: ET_DYNAMIC_TYPE_SET
		do
			l_result_type_set := current_feature.result_type_set
			l_arguments := a_feature.arguments
			if l_arguments = Void or else l_arguments.count /= 1 then
					-- Internal error: this error should have been reported by the parser.
				set_fatal_error
				error_handler.report_giaaa_error_cl ("__CLASS__", "__LINE__")
			elseif l_result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error_cl ("__CLASS__", "__LINE__")
			else
				print_indentation
				current_file.put_string (c_char)
				current_file.put_character ('*')
				current_file.put_character (' ')
				current_file.put_character ('s')
				current_file.put_character (' ')
				current_file.put_character ('=')
				current_file.put_character (' ')
				current_file.put_string (c_ge_argv)
				current_file.put_character ('[')
				print_argument_name (l_arguments.formal_argument (1).name, current_file)
				current_file.put_character (']')
				current_file.put_character (';')
				current_file.put_new_line
				print_indentation
				print_result_name (current_file)
				current_file.put_character (' ')
				current_file.put_character ('=')
				current_file.put_character (' ')
				if l_result_type_set.static_type = current_dynamic_system.string_32_type then
					current_file.put_string (c_ge_ms32)
				else
					current_file.put_string (c_ge_ms8)
				end
				current_file.put_string ("(s,strlen(s))")
				current_file.put_character (';')
				current_file.put_new_line
			end
		end

	print_builtin_boolean_and_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'BOOLEAN.infix "and"'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_target: ET_EXPRESSION
			l_argument: ET_EXPRESSION
			l_actual_type_set: ET_DYNAMIC_TYPE_SET
			l_formal_type: ET_DYNAMIC_TYPE
		do
			if call_operands.count /= 2 then
					-- Internal error: this should already have been reported in ET_FEATURE_FLATTENER.
				set_fatal_error
				error_handler.report_giaaa_error_cl ("__CLASS__", "__LINE__")
			elseif a_feature.result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error_cl ("__CLASS__", "__LINE__")
			else
				l_target := call_operands.first
				l_argument := call_operands.item (2)
				print_type_cast (a_feature.result_type_set.static_type, current_file)
				current_file.put_character ('(')
				current_file.put_character ('(')
				if a_target_type.is_basic then
					print_unboxed_expression (l_target, a_target_type, a_check_void_target)
				else
-- TODO: use feature `item'.
					set_fatal_error
					error_handler.report_giaaa_error_cl ("__CLASS__", "__LINE__")
				end
				current_file.put_character (')')
				current_file.put_character ('&')
				current_file.put_character ('&')
				current_file.put_character ('(')
				l_actual_type_set := dynamic_type_set (l_argument)
				l_formal_type := argument_type_set_in_feature (1, a_feature).static_type
				print_attachment_expression (l_argument, l_actual_type_set, l_formal_type)
				current_file.put_character (')')
				current_file.put_character (')')
			end
		end

	print_builtin_boolean_and_then_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'BOOLEAN.infix "and then"'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_target: ET_EXPRESSION
			l_argument: ET_EXPRESSION
			l_actual_type_set: ET_DYNAMIC_TYPE_SET
			l_formal_type: ET_DYNAMIC_TYPE
		do
			if call_operands.count /= 2 then
					-- Internal error: this should already have been reported in ET_FEATURE_FLATTENER.
				set_fatal_error
				error_handler.report_giaaa_error_cl ("__CLASS__", "__LINE__")
			elseif a_feature.result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error_cl ("__CLASS__", "__LINE__")
			else
				l_target := call_operands.first
				l_argument := call_operands.item (2)
				print_type_cast (a_feature.result_type_set.static_type, current_file)
				current_file.put_character ('(')
				current_file.put_character ('(')
				if a_target_type.is_basic then
					print_unboxed_expression (l_target, a_target_type, a_check_void_target)
				else
-- TODO: use feature `item'.
					set_fatal_error
					error_handler.report_giaaa_error_cl ("__CLASS__", "__LINE__")
				end
				current_file.put_character (')')
				current_file.put_character ('&')
				current_file.put_character ('&')
				current_file.put_character ('(')
				l_actual_type_set := dynamic_type_set (l_argument)
				l_formal_type := argument_type_set_in_feature (1, a_feature).static_type
				print_attachment_expression (l_argument, l_actual_type_set, l_formal_type)
				current_file.put_character (')')
				current_file.put_character (')')
			end
		end

	print_builtin_boolean_implies_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'BOOLEAN.infix "implies"'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_target: ET_EXPRESSION
			l_argument: ET_EXPRESSION
			l_actual_type_set: ET_DYNAMIC_TYPE_SET
			l_formal_type: ET_DYNAMIC_TYPE
		do
			if call_operands.count /= 2 then
					-- Internal error: this should already have been reported in ET_FEATURE_FLATTENER.
				set_fatal_error
				error_handler.report_giaaa_error_cl ("__CLASS__", "__LINE__")
			elseif a_feature.result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error_cl ("__CLASS__", "__LINE__")
			else
				l_target := call_operands.first
				l_argument := call_operands.item (2)
				print_type_cast (a_feature.result_type_set.static_type, current_file)
				current_file.put_character ('(')
				current_file.put_character ('(')
				current_file.put_character ('!')
				current_file.put_character ('(')
				if a_target_type.is_basic then
					print_unboxed_expression (l_target, a_target_type, a_check_void_target)
				else
-- TODO: use feature `item'.
					set_fatal_error
					error_handler.report_giaaa_error_cl ("__CLASS__", "__LINE__")
				end
				current_file.put_character (')')
				current_file.put_character (')')
				current_file.put_character ('|')
				current_file.put_character ('|')
				current_file.put_character ('(')
				l_actual_type_set := dynamic_type_set (l_argument)
				l_formal_type := argument_type_set_in_feature (1, a_feature).static_type
				print_attachment_expression (l_argument, l_actual_type_set, l_formal_type)
				current_file.put_character (')')
				current_file.put_character (')')
			end
		end

	print_builtin_boolean_item_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'BOOLEAN_REF.item'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_target: ET_EXPRESSION
		do
			l_target := call_operands.first
			if a_target_type.is_basic then
				print_unboxed_expression (l_target, a_target_type, a_check_void_target)
			else
					-- Internal attribute.
				print_attribute_access (a_feature, l_target, a_target_type, a_check_void_target)
			end
		end

	print_builtin_boolean_not_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'BOOLEAN.prefix "not"'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_target: ET_EXPRESSION
		do
			if a_feature.result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error_cl ("__CLASS__", "__LINE__")
			else
				l_target := call_operands.first
				print_type_cast (a_feature.result_type_set.static_type, current_file)
				current_file.put_character ('(')
				current_file.put_character ('!')
				current_file.put_character ('(')
				if a_target_type.is_basic then
					print_unboxed_expression (l_target, a_target_type, a_check_void_target)
				else
-- TODO: use feature `item'.
					set_fatal_error
					error_handler.report_giaaa_error_cl ("__CLASS__", "__LINE__")
				end
				current_file.put_character (')')
				current_file.put_character (')')
			end
		end

	print_builtin_boolean_or_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'BOOLEAN.infix "or"'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_target: ET_EXPRESSION
			l_argument: ET_EXPRESSION
			l_actual_type_set: ET_DYNAMIC_TYPE_SET
			l_formal_type: ET_DYNAMIC_TYPE
		do
			if call_operands.count /= 2 then
					-- Internal error: this should already have been reported in ET_FEATURE_FLATTENER.
				set_fatal_error
				error_handler.report_giaaa_error_cl ("__CLASS__", "__LINE__")
			elseif a_feature.result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error_cl ("__CLASS__", "__LINE__")
			else
				l_target := call_operands.first
				l_argument := call_operands.item (2)
				print_type_cast (a_feature.result_type_set.static_type, current_file)
				current_file.put_character ('(')
				current_file.put_character ('(')
				if a_target_type.is_basic then
					print_unboxed_expression (l_target, a_target_type, a_check_void_target)
				else
-- TODO: use feature `item'.
					set_fatal_error
					error_handler.report_giaaa_error_cl ("__CLASS__", "__LINE__")
				end
				current_file.put_character (')')
				current_file.put_character ('|')
				current_file.put_character ('|')
				current_file.put_character ('(')
				l_actual_type_set := dynamic_type_set (l_argument)
				l_formal_type := argument_type_set_in_feature (1, a_feature).static_type
				print_attachment_expression (l_argument, l_actual_type_set, l_formal_type)
				current_file.put_character (')')
				current_file.put_character (')')
			end
		end

	print_builtin_boolean_or_else_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'BOOLEAN.infix "or else"'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_target: ET_EXPRESSION
			l_argument: ET_EXPRESSION
			l_actual_type_set: ET_DYNAMIC_TYPE_SET
			l_formal_type: ET_DYNAMIC_TYPE
		do
			if call_operands.count /= 2 then
					-- Internal error: this should already have been reported in ET_FEATURE_FLATTENER.
				set_fatal_error
				error_handler.report_giaaa_error_cl ("__CLASS__", "__LINE__")
			elseif a_feature.result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error_cl ("__CLASS__", "__LINE__")
			else
				l_target := call_operands.first
				l_argument := call_operands.item (2)
				print_type_cast (a_feature.result_type_set.static_type, current_file)
				current_file.put_character ('(')
				current_file.put_character ('(')
				if a_target_type.is_basic then
					print_unboxed_expression (l_target, a_target_type, a_check_void_target)
				else
-- TODO: use feature `item'.
					set_fatal_error
					error_handler.report_giaaa_error_cl ("__CLASS__", "__LINE__")
				end
				current_file.put_character (')')
				current_file.put_character ('|')
				current_file.put_character ('|')
				current_file.put_character ('(')
				l_actual_type_set := dynamic_type_set (l_argument)
				l_formal_type := argument_type_set_in_feature (1, a_feature).static_type
				print_attachment_expression (l_argument, l_actual_type_set, l_formal_type)
				current_file.put_character (')')
				current_file.put_character (')')
			end
		end

	print_builtin_boolean_set_item_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'BOOLEAN_REF.set_item'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_target: ET_EXPRESSION
			l_argument: ET_EXPRESSION
			l_actual_type_set: ET_DYNAMIC_TYPE_SET
			l_formal_type: ET_DYNAMIC_TYPE
			l_queries: ET_DYNAMIC_FEATURE_LIST
			l_query: ET_DYNAMIC_FEATURE
			l_item_attribute: ET_DYNAMIC_FEATURE
			i, nb: INTEGER
			l_builtin_item_code: INTEGER
		do
			if call_operands.count /= 2 then
					-- Internal error: this should already have been reported in ET_FEATURE_FLATTENER.
				set_fatal_error
				error_handler.report_giaaa_error_cl ("__CLASS__", "__LINE__")
			else
				l_target := call_operands.first
				l_argument := call_operands.item (2)
				l_actual_type_set := dynamic_type_set (l_argument)
				l_formal_type := argument_type_set_in_feature (1, a_feature).static_type
				if a_target_type.is_basic then
					print_indentation
					print_unboxed_expression (l_target, a_target_type, a_check_void_target)
					current_file.put_character (' ')
					current_file.put_character ('=')
					current_file.put_character (' ')
					current_file.put_character ('(')
					print_attachment_expression (l_argument, l_actual_type_set, l_formal_type)
					current_file.put_character (')')
					current_file.put_character (';')
					current_file.put_new_line
				else
					l_builtin_item_code := builtin_boolean_feature (builtin_boolean_item)
					l_queries := a_target_type.queries
					nb := a_target_type.attribute_count
					from i := 1 until i > nb loop
						l_query := l_queries.item (i)
						if l_query.builtin_code = l_builtin_item_code then
							l_item_attribute := l_query
							i := nb + 1
						else
							i := i + 1
						end
					end
					if l_item_attribute /= Void then
							-- Set the built-in attribute 'item'.
						print_indentation
						print_attribute_access (l_item_attribute, l_target, a_target_type, a_check_void_target)
						current_file.put_character (' ')
						current_file.put_character ('=')
						current_file.put_character (' ')
						current_file.put_character ('(')
						print_attachment_expression (l_argument, l_actual_type_set, l_formal_type)
						current_file.put_character (')')
						current_file.put_character (';')
						current_file.put_new_line
					else
						-- If `l_item_attribute' is Void, it means that it is never used,
						-- therefore there is no need to set it.
					end
				end
			end
		end

	print_builtin_boolean_xor_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'BOOLEAN.infix "xor"'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_target: ET_EXPRESSION
			l_argument: ET_EXPRESSION
			l_actual_type_set: ET_DYNAMIC_TYPE_SET
			l_formal_type: ET_DYNAMIC_TYPE
		do
			if call_operands.count /= 2 then
					-- Internal error: this should already have been reported in ET_FEATURE_FLATTENER.
				set_fatal_error
				error_handler.report_giaaa_error_cl ("__CLASS__", "__LINE__")
			elseif a_feature.result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error_cl ("__CLASS__", "__LINE__")
			else
				l_target := call_operands.first
				l_argument := call_operands.item (2)
				print_type_cast (a_feature.result_type_set.static_type, current_file)
				current_file.put_character ('(')
				current_file.put_character ('(')
				if a_target_type.is_basic then
					print_unboxed_expression (l_target, a_target_type, a_check_void_target)
				else
-- TODO: use feature `item'.
					set_fatal_error
					error_handler.report_giaaa_error_cl ("__CLASS__", "__LINE__")
				end
				current_file.put_character (')')
				current_file.put_character ('^')
				current_file.put_character ('(')
				l_actual_type_set := dynamic_type_set (l_argument)
				l_formal_type := argument_type_set_in_feature (1, a_feature).static_type
				print_attachment_expression (l_argument, l_actual_type_set, l_formal_type)
				current_file.put_character (')')
				current_file.put_character (')')
			end
		end

	print_builtin_function_item_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_feature' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'FUNCTION.item'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		do
			print_builtin_routine_call_call (a_feature, a_target_type, a_check_void_target)
		end

	print_builtin_identified_eif_id_object_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'IDENTIFIED.eif_id_object'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_argument: ET_EXPRESSION
			l_actual_type_set: ET_DYNAMIC_TYPE_SET
			l_formal_type: ET_DYNAMIC_TYPE
		do
			if call_operands.count /= 2 then
					-- Internal error: this should already have been reported in ET_FEATURE_FLATTENER.
				set_fatal_error
				error_handler.report_giaaa_error_cl ("__CLASS__", "__LINE__")
			else
				l_argument := call_operands.item (2)
				l_actual_type_set := dynamic_type_set (l_argument)
				l_formal_type := argument_type_set_in_feature (1, a_feature).static_type
				include_runtime_header_file ("ge_identified.h", False, header_file)
				current_file.put_string (c_ge_id_object)
				current_file.put_character ('(')
				print_attachment_expression (l_argument, l_actual_type_set, l_formal_type)
				current_file.put_character (')')
			end
		end

	print_builtin_identified_eif_object_id_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'IDENTIFIED.eif_object_id'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_argument: ET_EXPRESSION
			l_actual_type_set: ET_DYNAMIC_TYPE_SET
			l_formal_type: ET_DYNAMIC_TYPE
		do
			if call_operands.count /= 2 then
					-- Internal error: this should already have been reported in ET_FEATURE_FLATTENER.
				set_fatal_error
				error_handler.report_giaaa_error_cl ("__CLASS__", "__LINE__")
			else
				l_argument := call_operands.item (2)
				l_actual_type_set := dynamic_type_set (l_argument)
				l_formal_type := argument_type_set_in_feature (1, a_feature).static_type
				include_runtime_header_file ("ge_identified.h", False, header_file)
				current_file.put_string (c_ge_object_id)
				current_file.put_character ('(')
				print_attachment_expression (l_argument, l_actual_type_set, l_formal_type)
				current_file.put_character (')')
			end
		end

	print_builtin_identified_eif_object_id_free_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'IDENTIFIED.eif_object_id_free'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_argument: ET_EXPRESSION
			l_actual_type_set: ET_DYNAMIC_TYPE_SET
			l_formal_type: ET_DYNAMIC_TYPE
		do
			if call_operands.count /= 2 then
					-- Internal error: this should already have been reported in ET_FEATURE_FLATTENER.
				set_fatal_error
				error_handler.report_giaaa_error_cl ("__CLASS__", "__LINE__")
			else
				l_argument := call_operands.item (2)
				l_actual_type_set := dynamic_type_set (l_argument)
				l_formal_type := argument_type_set_in_feature (1, a_feature).static_type
				include_runtime_header_file ("ge_identified.h", False, header_file)
				print_indentation
				current_file.put_string (c_ge_object_id_free)
				current_file.put_character ('(')
				print_attachment_expression (l_argument, l_actual_type_set, l_formal_type)
				current_file.put_character (')')
				current_file.put_character (';')
			end
		end

	print_builtin_internal_type_of_type_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' the body of `a_feature' corresponding
			-- to built-in feature 'INTERNAL.type_of_type'.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		local
			l_arguments: ET_FORMAL_ARGUMENT_LIST
			l_result_type_set: ET_DYNAMIC_TYPE_SET
		do
			l_result_type_set := current_feature.result_type_set
			l_arguments := a_feature.arguments
			if l_arguments = Void or else l_arguments.count /= 1 then
					-- Internal error: this error should have been reported by the parser.
				set_fatal_error
				error_handler.report_giaaa_error_cl ("__CLASS__", "__LINE__")
			elseif l_result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error_cl ("__CLASS__", "__LINE__")
			else
				print_indentation
				print_result_name (current_file)
				current_file.put_character (' ')
				current_file.put_character ('=')
				current_file.put_character (' ')
				current_file.put_character ('&')
				current_file.put_character ('(')
				current_file.put_string (c_ge_types)
				current_file.put_character ('[')
				print_argument_name (l_arguments.formal_argument (1).name, current_file)
				current_file.put_character (']')
				current_file.put_character (')')
				current_file.put_character (';')
				current_file.put_new_line
				print_indentation
				current_file.put_string (c_if)
				current_file.put_character (' ')
				current_file.put_character ('(')
				print_result_name (current_file)
				current_file.put_string (c_arrow)
				print_attribute_type_id_name (l_result_type_set.static_type, current_file)
				current_file.put_character (' ')
				current_file.put_character ('=')
				current_file.put_character ('=')
				current_file.put_character (' ')
				current_file.put_character ('0')
				current_file.put_character (')')
				current_file.put_character (' ')
				current_file.put_character ('{')
				current_file.put_new_line
				indent
				print_indentation
				print_result_name (current_file)
				current_file.put_character (' ')
				current_file.put_character ('=')
				current_file.put_character (' ')
				current_file.put_string (c_eif_void)
				current_file.put_character (';')
				current_file.put_new_line
				dedent
				print_indentation
				current_file.put_character ('}')
				current_file.put_new_line
			end
		end

	print_builtin_internal_max_type_id_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'INTERNAL.max_type_id'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_result_type_set: ET_DYNAMIC_TYPE_SET
		do
			l_result_type_set := a_feature.result_type_set
			if l_result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error_cl ("__CLASS__", "__LINE__")
			else
				print_type_cast (l_result_type_set.static_type, current_file)
				current_file.put_character ('(')
				current_file.put_integer (current_dynamic_system.dynamic_types.count)
				current_file.put_character (')')
			end
		end

	print_builtin_memory_free_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'MEMORY.free'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_argument: ET_EXPRESSION
			l_actual_type_set: ET_DYNAMIC_TYPE_SET
			l_formal_type: ET_DYNAMIC_TYPE
		do
			if call_operands.count /= 2 then
					-- Internal error: this should already have been reported in ET_FEATURE_FLATTENER.
				set_fatal_error
				error_handler.report_giaaa_error_cl ("__CLASS__", "__LINE__")
			else
				include_runtime_header_file ("eif_memory.h", False, header_file)
				print_indentation
				current_file.put_string (c_eif_mem_free)
				current_file.put_character ('(')
				l_argument := call_operands.item (2)
				l_actual_type_set := dynamic_type_set (l_argument)
				l_formal_type := argument_type_set_in_feature (1, a_feature).static_type
				print_attachment_expression (l_argument, l_actual_type_set, l_formal_type)
				current_file.put_character (')')
				current_file.put_character (';')
				current_file.put_new_line
			end
		end

	print_builtin_memory_find_referers_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'MEMORY.find_referers'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_result_type_set: ET_DYNAMIC_TYPE_SET
			l_argument: ET_EXPRESSION
			l_actual_type_set: ET_DYNAMIC_TYPE_SET
			l_formal_type: ET_DYNAMIC_TYPE
		do
			l_result_type_set := a_feature.result_type_set
			if call_operands.count /= 3 then
					-- Internal error: this should already have been reported in ET_FEATURE_FLATTENER.
				set_fatal_error
				error_handler.report_giaaa_error_cl ("__CLASS__", "__LINE__")
			elseif l_result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error_cl ("__CLASS__", "__LINE__")
			else
				include_runtime_header_file ("eif_traverse.h", False, header_file)
				print_type_cast (l_result_type_set.static_type, current_file)
				current_file.put_string (c_find_referers)
				current_file.put_character ('(')
				l_argument := call_operands.item (2)
				l_actual_type_set := dynamic_type_set (l_argument)
				l_formal_type := argument_type_set_in_feature (1, a_feature).static_type
				print_attachment_expression (l_argument, l_actual_type_set, l_formal_type)
				current_file.put_character (',')
				current_file.put_character (' ')
				l_argument := call_operands.item (3)
				l_actual_type_set := dynamic_type_set (l_argument)
				l_formal_type := argument_type_set_in_feature (2, a_feature).static_type
				print_attachment_expression (l_argument, l_actual_type_set, l_formal_type)
				current_file.put_character (')')
			end
		end

	print_builtin_platform_boolean_bytes_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'PLATFORM.boolean_bytes'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		do
			if a_feature.result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error_cl ("__CLASS__", "__LINE__")
			else
				print_type_cast (a_feature.result_type_set.static_type, current_file)
				current_file.put_character ('(')
				current_file.put_string (c_sizeof)
				current_file.put_character ('(')
				current_file.put_string (c_eif_boolean)
				current_file.put_character (')')
				current_file.put_character (')')
			end
		end

	print_builtin_platform_character_bytes_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'PLATFORM.character_bytes'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		do
			if a_feature.result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error_cl ("__CLASS__", "__LINE__")
			else
				print_type_cast (a_feature.result_type_set.static_type, current_file)
				current_file.put_character ('(')
				current_file.put_string (c_sizeof)
				current_file.put_character ('(')
				current_file.put_string (c_eif_character_8)
				current_file.put_character (')')
				current_file.put_character (')')
			end
		end

	print_builtin_platform_double_bytes_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'PLATFORM.double_bytes'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		do
			if a_feature.result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error_cl ("__CLASS__", "__LINE__")
			else
				print_type_cast (a_feature.result_type_set.static_type, current_file)
				current_file.put_character ('(')
				current_file.put_string (c_sizeof)
				current_file.put_character ('(')
				current_file.put_string (c_eif_real_64)
				current_file.put_character (')')
				current_file.put_character (')')
			end
		end

	print_builtin_platform_integer_bytes_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'PLATFORM.integer_bytes'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		do
			if a_feature.result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error_cl ("__CLASS__", "__LINE__")
			else
				print_type_cast (a_feature.result_type_set.static_type, current_file)
				current_file.put_character ('(')
				current_file.put_string (c_sizeof)
				current_file.put_character ('(')
				current_file.put_string (c_eif_integer_32)
				current_file.put_character (')')
				current_file.put_character (')')
			end
		end

	print_builtin_platform_is_dotnet_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'PLATFORM.is_dotnet'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		do
			current_file.put_string (c_eif_false)
		end

	print_builtin_platform_is_mac_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'PLATFORM.is_mac'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		do
			current_file.put_string (c_eif_is_mac)
		end

	print_builtin_platform_is_thread_capable_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'PLATFORM.is_thread_capable'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		do
			current_file.put_string (c_eif_false)
		end

	print_builtin_platform_is_unix_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'PLATFORM.is_unix'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		do
			current_file.put_string (c_eif_is_unix)
		end

	print_builtin_platform_is_vms_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'PLATFORM.is_vms'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		do
			current_file.put_string (c_eif_is_vms)
		end

	print_builtin_platform_is_vxworks_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'PLATFORM.is_vxworks'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		do
			current_file.put_string (c_eif_is_vxworks)
		end

	print_builtin_platform_is_windows_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'PLATFORM.is_windows'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		do
			current_file.put_string (c_eif_is_windows)
		end

	print_builtin_platform_pointer_bytes_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'PLATFORM.pointer_bytes'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		do
			if a_feature.result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error_cl ("__CLASS__", "__LINE__")
			else
				print_type_cast (a_feature.result_type_set.static_type, current_file)
				current_file.put_character ('(')
				current_file.put_string (c_sizeof)
				current_file.put_character ('(')
				current_file.put_string (c_eif_pointer)
				current_file.put_character (')')
				current_file.put_character (')')
			end
		end

	print_builtin_platform_real_bytes_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'PLATFORM.real_bytes'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		do
			if a_feature.result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error_cl ("__CLASS__", "__LINE__")
			else
				print_type_cast (a_feature.result_type_set.static_type, current_file)
				current_file.put_character ('(')
				current_file.put_string (c_sizeof)
				current_file.put_character ('(')
				current_file.put_string (c_eif_real_32)
				current_file.put_character (')')
				current_file.put_character (')')
			end
		end

	print_builtin_platform_wide_character_bytes_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'PLATFORM.wide_character_bytes'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		do
			if a_feature.result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error_cl ("__CLASS__", "__LINE__")
			else
				print_type_cast (a_feature.result_type_set.static_type, current_file)
				current_file.put_character ('(')
				current_file.put_string (c_sizeof)
				current_file.put_character ('(')
				current_file.put_string (c_eif_character_32)
				current_file.put_character (')')
				current_file.put_character (')')
			end
		end

	print_builtin_pointer_hash_code_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'POINTER.hash_code'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_target: ET_EXPRESSION
			l_integer_type: ET_DYNAMIC_TYPE
		do
			if a_feature.result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error_cl ("__CLASS__", "__LINE__")
			else
				l_target := call_operands.first
				l_integer_type := a_feature.result_type_set.static_type
				print_type_cast (l_integer_type, current_file)
				current_file.put_character ('(')
				print_type_cast (l_integer_type, current_file)
				current_file.put_character ('(')
				if a_target_type.is_basic then
					print_unboxed_expression (l_target, a_target_type, a_check_void_target)
				else
-- TODO: use feature `item'.
					set_fatal_error
					error_handler.report_giaaa_error_cl ("__CLASS__", "__LINE__")
				end
				current_file.put_character (')')
					-- Clear the sign bit to ensure that the hash-code is positive.
				current_file.put_character ('&')
				print_type_cast (l_integer_type, current_file)
				current_file.put_character ('(')
				if l_integer_type = current_dynamic_system.integer_8_type then
					current_file.put_string ("0x7F")
				elseif l_integer_type = current_dynamic_system.integer_16_type then
					current_file.put_string ("0x7FFF")
				elseif l_integer_type = current_dynamic_system.integer_64_type then
					current_file.put_string ("0x7FFFFFFFFFFFFFFF")
				else
					current_file.put_string ("0x7FFFFFFF")
				end
				current_file.put_character (')')
				current_file.put_character (')')
			end
		end

	print_builtin_pointer_item_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'POINTER_REF.item'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_target: ET_EXPRESSION
		do
			l_target := call_operands.first
			if a_target_type.is_basic then
				print_unboxed_expression (l_target, a_target_type, a_check_void_target)
			else
					-- Internal attribute.
				print_attribute_access (a_feature, l_target, a_target_type, a_check_void_target)
			end
		end

	print_builtin_pointer_out_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' the body of `a_feature' corresponding
			-- to built-in feature 'POINTER.out'.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		local
			l_result_type_set: ET_DYNAMIC_TYPE_SET
		do
			l_result_type_set := current_feature.result_type_set
			if l_result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error_cl ("__CLASS__", "__LINE__")
			else
-- TODO: make sure that it works with descendants of POINTER.
-- Use 'item' for that.
				print_indentation
				current_file.put_string (c_char)
				current_file.put_character (' ')
				current_file.put_character ('s')
				current_file.put_character ('[')
				current_file.put_character ('2')
				current_file.put_character ('0')
				current_file.put_character (']')
				current_file.put_character (';')
				current_file.put_new_line
				print_indentation
				if current_type.is_basic then
					current_file.put_string ("int l = snprintf(s,20,%"0x%%lX%",(unsigned long)*C);")
				else
-- TODO: use feature `item'.
					set_fatal_error
					error_handler.report_giaaa_error_cl ("__CLASS__", "__LINE__")
				end
				current_file.put_new_line
				print_indentation
				print_result_name (current_file)
				current_file.put_character (' ')
				current_file.put_character ('=')
				current_file.put_character (' ')
				if l_result_type_set.static_type = current_dynamic_system.string_32_type then
					current_file.put_string (c_ge_ms32)
				else
					current_file.put_string (c_ge_ms8)
				end
				current_file.put_string ("(s,l)")
				current_file.put_character (';')
				current_file.put_new_line
			end
		end

	print_builtin_pointer_plus_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'POINTER.infix "+"'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_target: ET_EXPRESSION
			l_argument: ET_EXPRESSION
			l_actual_type_set: ET_DYNAMIC_TYPE_SET
			l_formal_type: ET_DYNAMIC_TYPE
		do
			if call_operands.count /= 2 then
					-- Internal error: this should already have been reported in ET_FEATURE_FLATTENER.
				set_fatal_error
				error_handler.report_giaaa_error_cl ("__CLASS__", "__LINE__")
			elseif a_feature.result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				l_target := call_operands.first
				l_argument := call_operands.item (2)
				l_actual_type_set := dynamic_type_set (l_argument)
				l_formal_type := argument_type_set_in_feature (1, a_feature).static_type
				print_type_cast (a_feature.result_type_set.static_type, current_file)
				current_file.put_character ('(')
				current_file.put_character ('(')
				current_file.put_character ('(')
				current_file.put_string (c_char)
				current_file.put_character ('*')
				current_file.put_character (')')
				current_file.put_character ('(')
				if a_target_type.is_basic then
					print_unboxed_expression (l_target, a_target_type, a_check_void_target)
				else
-- TODO: use feature `item'.
					set_fatal_error
					error_handler.report_giaaa_error
				end
				current_file.put_character (')')
				current_file.put_character (')')
				current_file.put_character ('+')
				current_file.put_character ('(')
				print_attachment_expression (l_argument, l_actual_type_set, l_formal_type)
				current_file.put_character (')')
				current_file.put_character (')')
			end
		end

	print_builtin_pointer_set_item_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'POINTER_REF.set_item'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_target: ET_EXPRESSION
			l_argument: ET_EXPRESSION
			l_actual_type_set: ET_DYNAMIC_TYPE_SET
			l_formal_type: ET_DYNAMIC_TYPE
			l_queries: ET_DYNAMIC_FEATURE_LIST
			l_query: ET_DYNAMIC_FEATURE
			l_item_attribute: ET_DYNAMIC_FEATURE
			i, nb: INTEGER
			l_builtin_item_code: INTEGER
		do
			if call_operands.count /= 2 then
					-- Internal error: this should already have been reported in ET_FEATURE_FLATTENER.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				l_target := call_operands.first
				l_argument := call_operands.item (2)
				l_actual_type_set := dynamic_type_set (l_argument)
				l_formal_type := argument_type_set_in_feature (1, a_feature).static_type
				if a_target_type.is_basic then
					print_indentation
					print_unboxed_expression (l_target, a_target_type, a_check_void_target)
					current_file.put_character (' ')
					current_file.put_character ('=')
					current_file.put_character (' ')
					current_file.put_character ('(')
					print_attachment_expression (l_argument, l_actual_type_set, l_formal_type)
					current_file.put_character (')')
					current_file.put_character (';')
					current_file.put_new_line
				else
					l_builtin_item_code := builtin_pointer_feature (builtin_pointer_item)
					l_queries := a_target_type.queries
					nb := a_target_type.attribute_count
					from i := 1 until i > nb loop
						l_query := l_queries.item (i)
						if l_query.builtin_code = l_builtin_item_code then
							l_item_attribute := l_query
							i := nb + 1
						else
							i := i + 1
						end
					end
					if l_item_attribute /= Void then
							-- Set the built-in attribute 'item'.
						print_indentation
						print_attribute_access (l_item_attribute, l_target, a_target_type, a_check_void_target)
						current_file.put_character (' ')
						current_file.put_character ('=')
						current_file.put_character (' ')
						current_file.put_character ('(')
						print_attachment_expression (l_argument, l_actual_type_set, l_formal_type)
						current_file.put_character (')')
						current_file.put_character (';')
						current_file.put_new_line
					else
						-- If `l_item_attribute' is Void, it means that it is never used,
						-- therefore there is no need to set it.
					end
				end
			end
		end

	print_builtin_pointer_to_integer_32_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'POINTER.to_integer_32'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_target: ET_EXPRESSION
		do
			if a_feature.result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				l_target := call_operands.first
				print_type_cast (a_feature.result_type_set.static_type, current_file)
				current_file.put_character ('(')
				if a_target_type.is_basic then
					print_unboxed_expression (l_target, a_target_type, a_check_void_target)
				else
-- TODO: use feature `item'.
					set_fatal_error
					error_handler.report_giaaa_error
				end
				current_file.put_character (')')
			end
		end

	print_builtin_procedure_call_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'PROCEDURE.call'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		do
			print_builtin_routine_call_call (a_feature, a_target_type, a_check_void_target)
		end

	print_builtin_routine_call_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'FUNCTION.item' or 'PROCEDURE.call'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_routine_type: ET_DYNAMIC_ROUTINE_TYPE
			l_open_operand_type_sets: ET_DYNAMIC_TYPE_SET_LIST
			l_routine_object: ET_EXPRESSION
			l_tuple: ET_EXPRESSION
			l_manifest_tuple: ET_MANIFEST_TUPLE
			l_tuple_target_type: ET_DYNAMIC_TUPLE_TYPE
			l_tuple_target_type_set: ET_DYNAMIC_TYPE_SET
			l_tuple_source_type_set: ET_DYNAMIC_TYPE_SET
			l_tuple_conforming_type_set: ET_DYNAMIC_TYPE_SET
			l_dynamic_type: ET_DYNAMIC_TYPE
			l_conforming_types: ET_DYNAMIC_TYPE_HASH_LIST
			l_has_non_conforming_types: BOOLEAN
			i, nb: INTEGER
			old_tuple_index: INTEGER
			l_tuple_item_expression: ET_CALL_EXPRESSION
			old_target: ET_EXPRESSION
			l_query_call: ET_DYNAMIC_QUALIFIED_QUERY_CALL
			l_query_target_type_set: ET_DYNAMIC_STANDALONE_TYPE_SET
			l_operand: ET_EXPRESSION
			l_operand_type_set: ET_DYNAMIC_TYPE_SET
		do
			l_tuple_target_type_set := argument_type_set_in_feature (1, a_feature)
			l_routine_type ?= a_target_type
			if l_routine_type = Void then
					-- Internal error: this should already have been reported in ET_FEATURE_FLATTENER.
					-- This built-in feature can only be in class PROCEDURE (and
					-- its descendants) or class FUNCTION (and its descendants).
				set_fatal_error
				error_handler.report_giaaa_error
			elseif call_operands.count /= 2 then
					-- Internal error: this should already have been reported in ET_FEATURE_FLATTENER.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				l_routine_object := call_operands.first
				l_tuple := call_operands.item (2)
				l_tuple_source_type_set := dynamic_type_set (l_tuple)
				if current_system.is_ise then
						-- ISE Eiffel does not type-check the tuple operand of Agent calls even at
						-- execution time. It only checks whether the tuple has enough items and
						-- these items are of the expected types, regardless of the type of the tuple
						-- itself. For example it is OK to pass a "TUPLE [ANY]" to an Agent which expects
						-- a "TUPLE [STRING]" provided that the dynamic type of the item of this tuple
				 		-- conforms to type STRING.
					nb := l_routine_type.open_operand_type_sets.count
					l_tuple_target_type ?= l_tuple_source_type_set.static_type
					if l_tuple_target_type = Void or else l_tuple_target_type.item_type_sets.count < nb then
							-- There is not enough items in the tuple. Keep the real tuple target
							-- type so that a proper CAT-call error is emitted.
						l_tuple_target_type ?= l_tuple_target_type_set.static_type
					end
				else
					l_tuple_target_type ?= l_tuple_target_type_set.static_type
				end
				if l_tuple_target_type = Void then
						-- Internal error: The formal argument of this built-in
						-- routine should be a Tuple type.
					set_fatal_error
					error_handler.report_giaaa_error
				end
			end
			if a_feature.is_procedure then
				print_indentation
			end
			l_manifest_tuple ?= l_tuple
			if l_tuple_target_type = Void then
				-- Error already reported.
			elseif l_tuple_source_type_set = Void then
				-- Error already reported.
			elseif l_manifest_tuple /= Void then
				l_open_operand_type_sets := l_routine_type.open_operand_type_sets
				nb := l_open_operand_type_sets.count
				if l_manifest_tuple.count < nb then
						-- CAT-call: we don't have enough operands to pass to the routine.
					current_file.put_character ('(')
					print_attachment_expression (l_manifest_tuple, l_tuple_source_type_set, l_tuple_target_type)
					current_file.put_character (')')
				else
						-- We have enough operands to pass to the routine.
					current_file.put_character ('(')
					current_file.put_character ('(')
					print_type_cast (a_target_type, current_file)
					current_file.put_character ('(')
-- TODO: we need to check whether the target is from an expanded descendant of FUNCTION or PROCEDURE.
-- In that case we need to use its address.
					print_expression (l_routine_object)
					current_file.put_character (')')
					current_file.put_character (')')
					current_file.put_string (c_arrow)
					print_attribute_routine_function_name (l_routine_type, current_file)
					current_file.put_character (')')
					current_file.put_character ('(')
					if exception_trace_mode then
						current_file.put_string (current_call_info)
						current_file.put_character (',')
						current_file.put_character (' ')
					end
					if l_routine_type.attribute_count < 1 then
							-- Internal error: the Agent type should have at least
							-- the attribute 'closed_operands' as first feature.
						set_fatal_error
						error_handler.report_giaaa_error
					else
							-- Print attribute 'closed_operands'.
						print_attribute_access (l_routine_type.queries.first, l_routine_object, l_routine_type, False)
					end
					from i := 1 until i > nb loop
						current_file.put_character (',')
						current_file.put_character (' ')
						l_operand := l_manifest_tuple.expression (i)
						l_operand_type_set := dynamic_type_set (l_operand)
						print_attachment_expression (l_operand, l_operand_type_set, l_open_operand_type_sets.item (i).static_type)
						i := i + 1
					end
					current_file.put_character (')')
				end
			else
					-- Try to find out whether there are some potential CAT-calls,
					-- e.g. there are some Tuple types that don't conform to the
					-- expected type. Here is an example where this can occur:
					--
					--   p: PROCEDURE [ANY, TUPLE [ANY]]
					--   f (a: ANY; i: INTEGER) do ... end
					--   p := agent f
					--   p.call (["gobo"])
					--
					-- The dynamic type of 'p' is PROCEDURE [ANY, TUPLE [ANY, INTEGER]].
					-- So the expected argument type is 'TUPLE [ANY, INTEGER]'. But what
					-- is passed is of type 'TUPLE [STRING]'. We are missing the integer
					-- field to pass to feature 'f'.
				l_conforming_types := conforming_types
				if l_tuple_source_type_set.static_type.conforms_to_type (l_tuple_target_type) then
						-- All Tuple types conform to the expected one.
						-- Therefore we know for sure that there will be
						-- no CAT-call.
					if not l_tuple_source_type_set.is_never_void or else not l_tuple_source_type_set.is_empty then
						l_tuple_conforming_type_set := l_tuple_source_type_set
					else
							-- Make sure that `is_never_void' is not set when the type set is empty.
						l_conforming_types.append_last (l_tuple_source_type_set)
						conforming_type_set.reset_with_types (l_tuple_target_type, l_conforming_types)
						l_tuple_conforming_type_set := conforming_type_set
					end
				else
						-- Make sure that CAT-call errors will be reported at run-time.
					nb := l_tuple_source_type_set.count
					l_conforming_types.resize (nb)
					from i := 1 until i > nb loop
						l_dynamic_type := l_tuple_source_type_set.dynamic_type (i)
						if l_dynamic_type.conforms_to_type (l_tuple_target_type) then
							l_conforming_types.put_last (l_dynamic_type)
						else
							l_has_non_conforming_types := True
						end
						i := i + 1
					end
					conforming_type_set.reset_with_types (l_tuple_target_type, l_conforming_types)
					l_tuple_conforming_type_set := conforming_type_set
					if l_tuple_source_type_set.is_never_void and not l_tuple_source_type_set.is_empty then
						l_tuple_conforming_type_set.set_never_void
					end
				end
				if l_has_non_conforming_types then
					current_file.put_character ('(')
					print_attachment_expression (l_tuple, l_tuple_source_type_set, l_tuple_target_type)
					current_file.put_character (',')
				end
				current_file.put_character ('(')
				current_file.put_character ('(')
				print_type_cast (a_target_type, current_file)
				current_file.put_character ('(')
-- TODO: we need to check whether the target is from an expanded descendant of FUNCTION or PROCEDURE.
-- In that case we need to use its address.
				print_expression (l_routine_object)
				current_file.put_character (')')
				current_file.put_character (')')
				current_file.put_string (c_arrow)
				print_attribute_routine_function_name (l_routine_type, current_file)
				current_file.put_character (')')
				current_file.put_character ('(')
				if exception_trace_mode then
					current_file.put_string (current_call_info)
					current_file.put_character (',')
					current_file.put_character (' ')
				end
				if l_routine_type.attribute_count < 1 then
						-- Internal error: the Agent type should have at least
						-- the attribute 'closed_operands' as first feature.
					set_fatal_error
					error_handler.report_giaaa_error
				else
						-- Print attribute 'closed_operands'.
					print_attribute_access (l_routine_type.queries.first, l_routine_object, l_routine_type, False)
				end
				l_open_operand_type_sets := l_routine_type.open_operand_type_sets
				nb := l_open_operand_type_sets.count
				if nb > 0 then
						-- Prepare dynamic type sets.
						-- Temporarily change the dynamic type set of the
						-- tuple so that it is only made up of conforming
						-- type, without any remaining CAT-call problems.
					extra_dynamic_type_sets.force_last (l_tuple_conforming_type_set)
					old_tuple_index := l_tuple.index
					l_tuple.set_index (current_dynamic_type_sets.count + extra_dynamic_type_sets.count)
						-- Mark the temporary variable representing the tuple and the
						-- routine object as frozen so that they are not reused in any
						-- way when printing the tuple item extract expressions.
					mark_call_operands_frozen
						-- When printing the tuple item extract expressions, it is likely that
						-- `call_operands' will be used and then wiped out (see
						-- `print_qualified_call_expression' which will be called indirectly from
						-- `print_attachment_expression'). Put `call_operands' in a clean state
						-- beforehand to avoid any problem.
					call_operands.wipe_out
						-- Extract the items of the tuple and pass them as argument
						-- of the function to fill in the open operands of the agent.
					from i := 1 until i > nb loop
						current_file.put_character (',')
						current_file.put_character (' ')
							-- Prepare the expression to extract the tuple item.
						extra_dynamic_type_sets.force_last (l_open_operand_type_sets.item (i))
						l_tuple_item_expression := new_agent_tuple_item_expression (i)
						old_target := l_tuple_item_expression.target
						l_tuple_item_expression.set_target (l_tuple)
						l_tuple_item_expression.set_index (current_dynamic_type_sets.count + extra_dynamic_type_sets.count)
							-- Register the call to extract the tuple item so that
							-- it is handled correctly in case of polymorphism.
							-- The special treatment for polymorphism only occurs
							-- when the target has more than 2 possible dynamic types.
						if l_tuple_conforming_type_set.count > 2 then
							create l_query_target_type_set.make (l_tuple_target_type)
							if l_tuple_conforming_type_set.is_never_void then
								l_query_target_type_set.set_never_void
							end
							l_query_target_type_set.put_types (l_tuple_conforming_type_set)
							create l_query_call.make (l_tuple_item_expression, l_query_target_type_set, l_open_operand_type_sets.item (i), current_feature, current_type)
							l_tuple_conforming_type_set.static_type.put_query_call (l_query_call)
						end
							-- Print the actual call to extract the tuple item.
						print_attachment_expression (l_tuple_item_expression, l_open_operand_type_sets.item (i), l_open_operand_type_sets.item (i).static_type)
							-- Clean up.
						l_tuple_item_expression.set_target (old_target)
						extra_dynamic_type_sets.remove_last
							-- No need to check for the void-ness of the tuple when accessing
							-- each of its items. The first time is enough.
						l_tuple_conforming_type_set.set_never_void
						i := i + 1
					end
						-- Clean up.
					l_tuple.set_index (old_tuple_index)
					extra_dynamic_type_sets.remove_last
						-- Put back the operands of current call onto `call_operands'.
					call_operands.put_last (l_routine_object)
					call_operands.put_last (l_tuple)
						-- Unfreeze the temporary variables corresponding to the tuple
						-- and routine objects.
					mark_call_operands_unfrozen
				end
				current_file.put_character (')')
				if l_has_non_conforming_types then
					current_file.put_character (')')
				end
					-- Clean up.
				conforming_type_set.reset_with_types (current_dynamic_system.unknown_type, Void)
				l_conforming_types.wipe_out
			end
			if a_feature.is_procedure then
				current_file.put_character (';')
				current_file.put_new_line
			end
		end

	print_builtin_sized_character_code_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'CHARACTER_xx.code'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_target: ET_EXPRESSION
		do
			if a_feature.result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				l_target := call_operands.first
				print_type_cast (a_feature.result_type_set.static_type, current_file)
				current_file.put_character ('(')
				if a_target_type.is_basic then
					print_unboxed_expression (l_target, a_target_type, a_check_void_target)
				else
-- TODO: use feature `item'.
					set_fatal_error
					error_handler.report_giaaa_error
				end
				current_file.put_character (')')
			end
		end

	print_builtin_sized_character_item_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'CHARACTER_xx_REF.item'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_target: ET_EXPRESSION
		do
			l_target := call_operands.first
			if a_target_type.is_basic then
				print_unboxed_expression (l_target, a_target_type, a_check_void_target)
			else
					-- Internal attribute.
				print_attribute_access (a_feature, l_target, a_target_type, a_check_void_target)
			end
		end

	print_builtin_sized_character_natural_32_code_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'CHARACTER_xx.natural_32_code'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_target: ET_EXPRESSION
		do
			if a_feature.result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				l_target := call_operands.first
				print_type_cast (a_feature.result_type_set.static_type, current_file)
				current_file.put_character ('(')
				if a_target_type.is_basic then
					print_unboxed_expression (l_target, a_target_type, a_check_void_target)
				else
-- TODO: use feature `item'.
					set_fatal_error
					error_handler.report_giaaa_error
				end
				current_file.put_character (')')
			end
		end

	print_builtin_sized_character_set_item_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'CHARACTER_xx_REF.set_item'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_target: ET_EXPRESSION
			l_argument: ET_EXPRESSION
			l_argument_type_set: ET_DYNAMIC_TYPE_SET
			l_formal_type: ET_DYNAMIC_TYPE
			l_queries: ET_DYNAMIC_FEATURE_LIST
			l_query: ET_DYNAMIC_FEATURE
			l_item_attribute: ET_DYNAMIC_FEATURE
			i, nb: INTEGER
			l_builtin_item_code: INTEGER
		do
			if call_operands.count /= 2 then
					-- Internal error: this should already have been reported in ET_FEATURE_FLATTENER.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				l_target := call_operands.first
				l_argument := call_operands.item (2)
				l_argument_type_set := dynamic_type_set (l_argument)
				l_formal_type := argument_type_set_in_feature (1, a_feature).static_type
				if a_target_type.is_basic then
					print_indentation
					print_unboxed_expression (l_target, a_target_type, a_check_void_target)
					current_file.put_character (' ')
					current_file.put_character ('=')
					current_file.put_character (' ')
					current_file.put_character ('(')
					print_attachment_expression (l_argument, l_argument_type_set, l_formal_type)
					current_file.put_character (')')
					current_file.put_character (';')
					current_file.put_new_line
				else
					l_builtin_item_code := builtin_feature (a_feature.builtin_code // builtin_capacity, builtin_character_item)
					l_queries := a_target_type.queries
					nb := a_target_type.attribute_count
					from i := 1 until i > nb loop
						l_query := l_queries.item (i)
						if l_query.builtin_code = l_builtin_item_code then
							l_item_attribute := l_query
							i := nb + 1
						else
							i := i + 1
						end
					end
					if l_item_attribute /= Void then
							-- Set the built-in attribute 'item'.
						print_indentation
						print_attribute_access (l_item_attribute, l_target, a_target_type, a_check_void_target)
						current_file.put_character (' ')
						current_file.put_character ('=')
						current_file.put_character (' ')
						current_file.put_character ('(')
						print_attachment_expression (l_argument, l_argument_type_set, l_formal_type)
						current_file.put_character (')')
						current_file.put_character (';')
						current_file.put_new_line
					else
						-- If `l_item_attribute' is Void, it means that it is never used,
						-- therefore there is no need to set it.
					end
				end
			end
		end

	print_builtin_sized_character_to_character_8_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'CHARACTER_xx.to_character_8'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_target: ET_EXPRESSION
		do
			if a_feature.result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				l_target := call_operands.first
				print_type_cast (a_feature.result_type_set.static_type, current_file)
				current_file.put_character ('(')
				if a_target_type.is_basic then
					print_unboxed_expression (l_target, a_target_type, a_check_void_target)
				else
-- TODO: use feature `item'.
					set_fatal_error
					error_handler.report_giaaa_error
				end
				current_file.put_character (')')
			end
		end

	print_builtin_sized_character_to_character_32_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'CHARACTER_xx.to_character_32'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_target: ET_EXPRESSION
		do
			if a_feature.result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				l_target := call_operands.first
				print_type_cast (a_feature.result_type_set.static_type, current_file)
				current_file.put_character ('(')
				if a_target_type.is_basic then
					print_unboxed_expression (l_target, a_target_type, a_check_void_target)
				else
-- TODO: use feature `item'.
					set_fatal_error
					error_handler.report_giaaa_error
				end
				current_file.put_character (')')
			end
		end

	print_builtin_sized_integer_as_integer_8_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'INTEGER_xx.as_integer_8'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_target: ET_EXPRESSION
		do
			if a_feature.result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				l_target := call_operands.first
				print_type_cast (a_feature.result_type_set.static_type, current_file)
				current_file.put_character ('(')
				if a_target_type.is_basic then
					print_unboxed_expression (l_target, a_target_type, a_check_void_target)
				else
-- TODO: use feature `item'.
					set_fatal_error
					error_handler.report_giaaa_error
				end
				current_file.put_character (')')
			end
		end

	print_builtin_sized_integer_as_integer_16_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'INTEGER_xx.as_integer_16'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_target: ET_EXPRESSION
		do
			if a_feature.result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				l_target := call_operands.first
				print_type_cast (a_feature.result_type_set.static_type, current_file)
				current_file.put_character ('(')
				if a_target_type.is_basic then
					print_unboxed_expression (l_target, a_target_type, a_check_void_target)
				else
-- TODO: use feature `item'.
					set_fatal_error
					error_handler.report_giaaa_error
				end
				current_file.put_character (')')
			end
		end

	print_builtin_sized_integer_as_integer_32_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'INTEGER_xx.as_integer_32'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_target: ET_EXPRESSION
		do
			if a_feature.result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				l_target := call_operands.first
				print_type_cast (a_feature.result_type_set.static_type, current_file)
				current_file.put_character ('(')
				if a_target_type.is_basic then
					print_unboxed_expression (l_target, a_target_type, a_check_void_target)
				else
-- TODO: use feature `item'.
					set_fatal_error
					error_handler.report_giaaa_error
				end
				current_file.put_character (')')
			end
		end

	print_builtin_sized_integer_as_integer_64_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'INTEGER_xx.as_integer_64'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_target: ET_EXPRESSION
		do
			if a_feature.result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				l_target := call_operands.first
				print_type_cast (a_feature.result_type_set.static_type, current_file)
				current_file.put_character ('(')
				if a_target_type.is_basic then
					print_unboxed_expression (l_target, a_target_type, a_check_void_target)
				else
-- TODO: use feature `item'.
					set_fatal_error
					error_handler.report_giaaa_error
				end
				current_file.put_character (')')
			end
		end

	print_builtin_sized_integer_as_natural_8_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'INTEGER_xx.as_natural_8'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_target: ET_EXPRESSION
		do
			if a_feature.result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				l_target := call_operands.first
				print_type_cast (a_feature.result_type_set.static_type, current_file)
				current_file.put_character ('(')
				if a_target_type.is_basic then
					print_unboxed_expression (l_target, a_target_type, a_check_void_target)
				else
-- TODO: use feature `item'.
					set_fatal_error
					error_handler.report_giaaa_error
				end
				current_file.put_character (')')
			end
		end

	print_builtin_sized_integer_as_natural_16_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'INTEGER_xx.as_natural_16'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_target: ET_EXPRESSION
		do
			if a_feature.result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				l_target := call_operands.first
				print_type_cast (a_feature.result_type_set.static_type, current_file)
				current_file.put_character ('(')
				if a_target_type.is_basic then
					print_unboxed_expression (l_target, a_target_type, a_check_void_target)
				else
-- TODO: use feature `item'.
					set_fatal_error
					error_handler.report_giaaa_error
				end
				current_file.put_character (')')
			end
		end

	print_builtin_sized_integer_as_natural_32_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'INTEGER_xx.as_natural_32'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_target: ET_EXPRESSION
		do
			if a_feature.result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				l_target := call_operands.first
				print_type_cast (a_feature.result_type_set.static_type, current_file)
				current_file.put_character ('(')
				if a_target_type.is_basic then
					print_unboxed_expression (l_target, a_target_type, a_check_void_target)
				else
-- TODO: use feature `item'.
					set_fatal_error
					error_handler.report_giaaa_error
				end
				current_file.put_character (')')
			end
		end

	print_builtin_sized_integer_as_natural_64_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'INTEGER_xx.as_natural_64'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_target: ET_EXPRESSION
		do
			if a_feature.result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				l_target := call_operands.first
				print_type_cast (a_feature.result_type_set.static_type, current_file)
				current_file.put_character ('(')
				if a_target_type.is_basic then
					print_unboxed_expression (l_target, a_target_type, a_check_void_target)
				else
-- TODO: use feature `item'.
					set_fatal_error
					error_handler.report_giaaa_error
				end
				current_file.put_character (')')
			end
		end

	print_builtin_sized_integer_bit_and_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'INTEGER_xx.bit_and'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_target: ET_EXPRESSION
			l_argument: ET_EXPRESSION
			l_actual_type_set: ET_DYNAMIC_TYPE_SET
			l_formal_type: ET_DYNAMIC_TYPE
		do
			if call_operands.count /= 2 then
					-- Internal error: this should already have been reported in ET_FEATURE_FLATTENER.
				set_fatal_error
				error_handler.report_giaaa_error
			elseif a_feature.result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				l_target := call_operands.first
				l_argument := call_operands.item (2)
				print_type_cast (a_feature.result_type_set.static_type, current_file)
				current_file.put_character ('(')
				current_file.put_character ('(')
				if a_target_type.is_basic then
					print_unboxed_expression (l_target, a_target_type, a_check_void_target)
				else
-- TODO: use feature `item'.
					set_fatal_error
					error_handler.report_giaaa_error
				end
				current_file.put_character (')')
				current_file.put_character ('&')
				current_file.put_character ('(')
				l_actual_type_set := dynamic_type_set (l_argument)
				l_formal_type := argument_type_set_in_feature (1, a_feature).static_type
				print_attachment_expression (l_argument, l_actual_type_set, l_formal_type)
				current_file.put_character (')')
				current_file.put_character (')')
			end
		end

	print_builtin_sized_integer_bit_not_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'INTEGER_xx.bit_not'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_target: ET_EXPRESSION
		do
			if a_feature.result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				l_target := call_operands.first
				print_type_cast (a_feature.result_type_set.static_type, current_file)
				current_file.put_character ('(')
				current_file.put_character ('~')
				current_file.put_character ('(')
				if a_target_type.is_basic then
					print_unboxed_expression (l_target, a_target_type, a_check_void_target)
				else
-- TODO: use feature `item'.
					set_fatal_error
					error_handler.report_giaaa_error
				end
				current_file.put_character (')')
				current_file.put_character (')')
			end
		end

	print_builtin_sized_integer_bit_or_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'INTEGER_xx.bit_or'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_target: ET_EXPRESSION
			l_argument: ET_EXPRESSION
			l_actual_type_set: ET_DYNAMIC_TYPE_SET
			l_formal_type: ET_DYNAMIC_TYPE
		do
			if call_operands.count /= 2 then
					-- Internal error: this should already have been reported in ET_FEATURE_FLATTENER.
				set_fatal_error
				error_handler.report_giaaa_error
			elseif a_feature.result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				l_target := call_operands.first
				l_argument := call_operands.item (2)
				print_type_cast (a_feature.result_type_set.static_type, current_file)
				current_file.put_character ('(')
				current_file.put_character ('(')
				if a_target_type.is_basic then
					print_unboxed_expression (l_target, a_target_type, a_check_void_target)
				else
-- TODO: use feature `item'.
					set_fatal_error
					error_handler.report_giaaa_error
				end
				current_file.put_character (')')
				current_file.put_character ('|')
				current_file.put_character ('(')
				l_actual_type_set := dynamic_type_set (l_argument)
				l_formal_type := argument_type_set_in_feature (1, a_feature).static_type
				print_attachment_expression (l_argument, l_actual_type_set, l_formal_type)
				current_file.put_character (')')
				current_file.put_character (')')
			end
		end

	print_builtin_sized_integer_bit_shift_left_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'INTEGER_xx.bit_shift_left'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_target: ET_EXPRESSION
			l_argument: ET_EXPRESSION
			l_actual_type_set: ET_DYNAMIC_TYPE_SET
			l_formal_type: ET_DYNAMIC_TYPE
		do
			if call_operands.count /= 2 then
					-- Internal error: this should already have been reported in ET_FEATURE_FLATTENER.
				set_fatal_error
				error_handler.report_giaaa_error
			elseif a_feature.result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				l_target := call_operands.first
				l_argument := call_operands.item (2)
				print_type_cast (a_feature.result_type_set.static_type, current_file)
				current_file.put_character ('(')
				current_file.put_character ('(')
				if a_target_type.is_basic then
					print_unboxed_expression (l_target, a_target_type, a_check_void_target)
				else
-- TODO: use feature `item'.
					set_fatal_error
					error_handler.report_giaaa_error
				end
				current_file.put_character (')')
				current_file.put_character ('<')
				current_file.put_character ('<')
				current_file.put_character ('(')
				l_actual_type_set := dynamic_type_set (l_argument)
				l_formal_type := argument_type_set_in_feature (1, a_feature).static_type
				print_attachment_expression (l_argument, l_actual_type_set, l_formal_type)
				current_file.put_character (')')
				current_file.put_character (')')
			end
		end

	print_builtin_sized_integer_bit_shift_right_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'INTEGER_xx.bit_shift_right'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_target: ET_EXPRESSION
			l_argument: ET_EXPRESSION
			l_actual_type_set: ET_DYNAMIC_TYPE_SET
			l_formal_type: ET_DYNAMIC_TYPE
		do
			if call_operands.count /= 2 then
					-- Internal error: this should already have been reported in ET_FEATURE_FLATTENER.
				set_fatal_error
				error_handler.report_giaaa_error
			elseif a_feature.result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				l_target := call_operands.first
				l_argument := call_operands.item (2)
				print_type_cast (a_feature.result_type_set.static_type, current_file)
				current_file.put_character ('(')
				current_file.put_character ('(')
				if a_target_type.is_basic then
					print_unboxed_expression (l_target, a_target_type, a_check_void_target)
				else
-- TODO: use feature `item'.
					set_fatal_error
					error_handler.report_giaaa_error
				end
				current_file.put_character (')')
				current_file.put_character ('>')
				current_file.put_character ('>')
				current_file.put_character ('(')
				l_actual_type_set := dynamic_type_set (l_argument)
				l_formal_type := argument_type_set_in_feature (1, a_feature).static_type
				print_attachment_expression (l_argument, l_actual_type_set, l_formal_type)
				current_file.put_character (')')
				current_file.put_character (')')
			end
		end

	print_builtin_sized_integer_bit_xor_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'INTEGER_xx.bit_xor'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_target: ET_EXPRESSION
			l_argument: ET_EXPRESSION
			l_actual_type_set: ET_DYNAMIC_TYPE_SET
			l_formal_type: ET_DYNAMIC_TYPE
		do
			if call_operands.count /= 2 then
					-- Internal error: this should already have been reported in ET_FEATURE_FLATTENER.
				set_fatal_error
				error_handler.report_giaaa_error
			elseif a_feature.result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				l_target := call_operands.first
				l_argument := call_operands.item (2)
				print_type_cast (a_feature.result_type_set.static_type, current_file)
				current_file.put_character ('(')
				current_file.put_character ('(')
				if a_target_type.is_basic then
					print_unboxed_expression (l_target, a_target_type, a_check_void_target)
				else
-- TODO: use feature `item'.
					set_fatal_error
					error_handler.report_giaaa_error
				end
				current_file.put_character (')')
				current_file.put_character ('^')
				current_file.put_character ('(')
				l_actual_type_set := dynamic_type_set (l_argument)
				l_formal_type := argument_type_set_in_feature (1, a_feature).static_type
				print_attachment_expression (l_argument, l_actual_type_set, l_formal_type)
				current_file.put_character (')')
				current_file.put_character (')')
			end
		end

	print_builtin_sized_integer_div_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'INTEGER_xx.infix "//"'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_target: ET_EXPRESSION
			l_argument: ET_EXPRESSION
			l_actual_type_set: ET_DYNAMIC_TYPE_SET
			l_formal_type: ET_DYNAMIC_TYPE
		do
			if call_operands.count /= 2 then
					-- Internal error: this should already have been reported in ET_FEATURE_FLATTENER.
				set_fatal_error
				error_handler.report_giaaa_error
			elseif a_feature.result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				l_target := call_operands.first
				l_argument := call_operands.item (2)
				print_type_cast (a_feature.result_type_set.static_type, current_file)
				current_file.put_character ('(')
				current_file.put_character ('(')
				if a_target_type.is_basic then
					print_unboxed_expression (l_target, a_target_type, a_check_void_target)
				else
-- TODO: use feature `item'.
					set_fatal_error
					error_handler.report_giaaa_error
				end
				current_file.put_character (')')
				current_file.put_character ('/')
				current_file.put_character ('(')
				l_actual_type_set := dynamic_type_set (l_argument)
				l_formal_type := argument_type_set_in_feature (1, a_feature).static_type
				print_attachment_expression (l_argument, l_actual_type_set, l_formal_type)
				current_file.put_character (')')
				current_file.put_character (')')
			end
		end

	print_builtin_sized_integer_divide_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'INTEGER_xx.infix "/"'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_target: ET_EXPRESSION
			l_argument: ET_EXPRESSION
			l_actual_type_set: ET_DYNAMIC_TYPE_SET
			l_formal_type: ET_DYNAMIC_TYPE
		do
			if call_operands.count /= 2 then
					-- Internal error: this should already have been reported in ET_FEATURE_FLATTENER.
				set_fatal_error
				error_handler.report_giaaa_error
			elseif a_feature.result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				l_target := call_operands.first
				l_argument := call_operands.item (2)
				print_type_cast (a_feature.result_type_set.static_type, current_file)
				current_file.put_character ('(')
				current_file.put_character ('(')
				current_file.put_string (c_double)
				current_file.put_character (')')
				current_file.put_character ('(')
				if a_target_type.is_basic then
					print_unboxed_expression (l_target, a_target_type, a_check_void_target)
				else
-- TODO: use feature `item'.
					set_fatal_error
					error_handler.report_giaaa_error
				end
				current_file.put_character (')')
				current_file.put_character ('/')
				current_file.put_character ('(')
				current_file.put_string (c_double)
				current_file.put_character (')')
				current_file.put_character ('(')
				l_actual_type_set := dynamic_type_set (l_argument)
				l_formal_type := argument_type_set_in_feature (1, a_feature).static_type
				print_attachment_expression (l_argument, l_actual_type_set, l_formal_type)
				current_file.put_character (')')
				current_file.put_character (')')
			end
		end

	print_builtin_sized_integer_identity_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'INTEGER_xx.prefix "+"'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_target: ET_EXPRESSION
		do
			if a_feature.result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				l_target := call_operands.first
				print_type_cast (a_feature.result_type_set.static_type, current_file)
				current_file.put_character ('(')
				if a_target_type.is_basic then
					print_unboxed_expression (l_target, a_target_type, a_check_void_target)
				else
-- TODO: use feature `item'.
					set_fatal_error
					error_handler.report_giaaa_error
				end
				current_file.put_character (')')
			end
		end

	print_builtin_sized_integer_item_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'INTEGER_xx_REF.item'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_target: ET_EXPRESSION
		do
			l_target := call_operands.first
			if a_target_type.is_basic then
				print_unboxed_expression (l_target, a_target_type, a_check_void_target)
			else
					-- Internal attribute.
				print_attribute_access (a_feature, l_target, a_target_type, a_check_void_target)
			end
		end

	print_builtin_sized_integer_lt_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'INTEGER_xx.infix "<"'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_target: ET_EXPRESSION
			l_argument: ET_EXPRESSION
			l_actual_type_set: ET_DYNAMIC_TYPE_SET
			l_formal_type: ET_DYNAMIC_TYPE
		do
			if call_operands.count /= 2 then
					-- Internal error: this should already have been reported in ET_FEATURE_FLATTENER.
				set_fatal_error
				error_handler.report_giaaa_error
			elseif a_feature.result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				l_target := call_operands.first
				l_argument := call_operands.item (2)
				print_type_cast (a_feature.result_type_set.static_type, current_file)
				current_file.put_character ('(')
				current_file.put_character ('(')
				if a_target_type.is_basic then
					print_unboxed_expression (l_target, a_target_type, a_check_void_target)
				else
-- TODO: use feature `item'.
					set_fatal_error
					error_handler.report_giaaa_error
				end
				current_file.put_character (')')
				current_file.put_character ('<')
				current_file.put_character ('(')
				l_actual_type_set := dynamic_type_set (l_argument)
				l_formal_type := argument_type_set_in_feature (1, a_feature).static_type
				print_attachment_expression (l_argument, l_actual_type_set, l_formal_type)
				current_file.put_character (')')
				current_file.put_character (')')
			end
		end

	print_builtin_sized_integer_minus_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'INTEGER_xx.infix "-"'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_target: ET_EXPRESSION
			l_argument: ET_EXPRESSION
			l_actual_type_set: ET_DYNAMIC_TYPE_SET
			l_formal_type: ET_DYNAMIC_TYPE
		do
			if call_operands.count /= 2 then
					-- Internal error: this should already have been reported in ET_FEATURE_FLATTENER.
				set_fatal_error
				error_handler.report_giaaa_error
			elseif a_feature.result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				l_target := call_operands.first
				l_argument := call_operands.item (2)
				print_type_cast (a_feature.result_type_set.static_type, current_file)
				current_file.put_character ('(')
				current_file.put_character ('(')
				if a_target_type.is_basic then
					print_unboxed_expression (l_target, a_target_type, a_check_void_target)
				else
-- TODO: use feature `item'.
					set_fatal_error
					error_handler.report_giaaa_error
				end
				current_file.put_character (')')
				current_file.put_character ('-')
				current_file.put_character ('(')
				l_actual_type_set := dynamic_type_set (l_argument)
				l_formal_type := argument_type_set_in_feature (1, a_feature).static_type
				print_attachment_expression (l_argument, l_actual_type_set, l_formal_type)
				current_file.put_character (')')
				current_file.put_character (')')
			end
		end

	print_builtin_sized_integer_mod_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'INTEGER_xx.infix "\\"'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_target: ET_EXPRESSION
			l_argument: ET_EXPRESSION
			l_actual_type_set: ET_DYNAMIC_TYPE_SET
			l_formal_type: ET_DYNAMIC_TYPE
		do
			if call_operands.count /= 2 then
					-- Internal error: this should already have been reported in ET_FEATURE_FLATTENER.
				set_fatal_error
				error_handler.report_giaaa_error
			elseif a_feature.result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				l_target := call_operands.first
				l_argument := call_operands.item (2)
				print_type_cast (a_feature.result_type_set.static_type, current_file)
				current_file.put_character ('(')
				current_file.put_character ('(')
				if a_target_type.is_basic then
					print_unboxed_expression (l_target, a_target_type, a_check_void_target)
				else
-- TODO: use feature `item'.
					set_fatal_error
					error_handler.report_giaaa_error
				end
				current_file.put_character (')')
				current_file.put_character ('%%')
				current_file.put_character ('(')
				l_actual_type_set := dynamic_type_set (l_argument)
				l_formal_type := argument_type_set_in_feature (1, a_feature).static_type
				print_attachment_expression (l_argument, l_actual_type_set, l_formal_type)
				current_file.put_character (')')
				current_file.put_character (')')
			end
		end

	print_builtin_sized_integer_opposite_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'INTEGER_xx.prefix "-"'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_target: ET_EXPRESSION
		do
			if a_feature.result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				l_target := call_operands.first
				print_type_cast (a_feature.result_type_set.static_type, current_file)
				current_file.put_character ('(')
				current_file.put_character ('-')
				current_file.put_character ('(')
				if a_target_type.is_basic then
					print_unboxed_expression (l_target, a_target_type, a_check_void_target)
				else
-- TODO: use feature `item'.
					set_fatal_error
					error_handler.report_giaaa_error
				end
				current_file.put_character (')')
				current_file.put_character (')')
			end
		end

	print_builtin_sized_integer_plus_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'INTEGER_xx.infix "+"'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_target: ET_EXPRESSION
			l_argument: ET_EXPRESSION
			l_actual_type_set: ET_DYNAMIC_TYPE_SET
			l_formal_type: ET_DYNAMIC_TYPE
		do
			if call_operands.count /= 2 then
					-- Internal error: this should already have been reported in ET_FEATURE_FLATTENER.
				set_fatal_error
				error_handler.report_giaaa_error
			elseif a_feature.result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				l_target := call_operands.first
				l_argument := call_operands.item (2)
				print_type_cast (a_feature.result_type_set.static_type, current_file)
				current_file.put_character ('(')
				current_file.put_character ('(')
				if a_target_type.is_basic then
					print_unboxed_expression (l_target, a_target_type, a_check_void_target)
				else
-- TODO: use feature `item'.
					set_fatal_error
					error_handler.report_giaaa_error
				end
				current_file.put_character (')')
				current_file.put_character ('+')
				current_file.put_character ('(')
				l_actual_type_set := dynamic_type_set (l_argument)
				l_formal_type := argument_type_set_in_feature (1, a_feature).static_type
				print_attachment_expression (l_argument, l_actual_type_set, l_formal_type)
				current_file.put_character (')')
				current_file.put_character (')')
			end
		end

	print_builtin_sized_integer_power_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'INTEGER_xx.infix "^"'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_target: ET_EXPRESSION
			l_argument: ET_EXPRESSION
			l_actual_type_set: ET_DYNAMIC_TYPE_SET
			l_formal_type: ET_DYNAMIC_TYPE
		do
			if call_operands.count /= 2 then
					-- Internal error: this should already have been reported in ET_FEATURE_FLATTENER.
				set_fatal_error
				error_handler.report_giaaa_error
			elseif a_feature.result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				l_target := call_operands.first
				l_argument := call_operands.item (2)
				include_runtime_header_file ("ge_integer.h", False, header_file)
				print_type_cast (a_feature.result_type_set.static_type, current_file)
				current_file.put_string (c_ge_power)
				current_file.put_character ('(')
				current_file.put_character ('(')
				current_file.put_string (c_double)
				current_file.put_character (')')
				current_file.put_character ('(')
				if a_target_type.is_basic then
					print_unboxed_expression (l_target, a_target_type, a_check_void_target)
				else
-- TODO: use feature `item'.
					set_fatal_error
					error_handler.report_giaaa_error
				end
				current_file.put_character (')')
				current_file.put_character (',')
				current_file.put_character (' ')
				current_file.put_character ('(')
				current_file.put_string (c_double)
				current_file.put_character (')')
				current_file.put_character ('(')
				l_actual_type_set := dynamic_type_set (l_argument)
				l_formal_type := argument_type_set_in_feature (1, a_feature).static_type
				print_attachment_expression (l_argument, l_actual_type_set, l_formal_type)
				current_file.put_character (')')
				current_file.put_character (')')
			end
		end

	print_builtin_sized_integer_set_item_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static file) to `a_feature'
			-- corresponding to built-in feature 'INTEGER_REF.set_item'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_target: ET_EXPRESSION
			l_argument: ET_EXPRESSION
			l_argument_type_set: ET_DYNAMIC_TYPE_SET
			l_formal_type: ET_DYNAMIC_TYPE
			l_queries: ET_DYNAMIC_FEATURE_LIST
			l_query: ET_DYNAMIC_FEATURE
			l_item_attribute: ET_DYNAMIC_FEATURE
			i, nb: INTEGER
			l_builtin_item_code: INTEGER
		do
			if call_operands.count /= 2 then
					-- Internal error: this should already have been reported in ET_FEATURE_FLATTENER.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				l_target := call_operands.first
				l_argument := call_operands.item (2)
				l_argument_type_set := dynamic_type_set (l_argument)
				l_formal_type := argument_type_set_in_feature (1, a_feature).static_type
				if a_target_type.is_basic then
					print_indentation
					print_unboxed_expression (l_target, a_target_type, a_check_void_target)
					current_file.put_character (' ')
					current_file.put_character ('=')
					current_file.put_character (' ')
					current_file.put_character ('(')
					print_attachment_expression (l_argument, l_argument_type_set, l_formal_type)
					current_file.put_character (')')
					current_file.put_character (';')
					current_file.put_new_line
				else
					l_builtin_item_code := builtin_feature (a_feature.builtin_code // builtin_capacity, builtin_integer_item)
					l_queries := a_target_type.queries
					nb := a_target_type.attribute_count
					from i := 1 until i > nb loop
						l_query := l_queries.item (i)
						if l_query.builtin_code = l_builtin_item_code then
							l_item_attribute := l_query
							i := nb + 1
						else
							i := i + 1
						end
					end
					if l_item_attribute /= Void then
							-- Set the built-in attribute 'item'.
						print_indentation
						print_attribute_access (l_item_attribute, l_target, a_target_type, a_check_void_target)
						current_file.put_character (' ')
						current_file.put_character ('=')
						current_file.put_character (' ')
						current_file.put_character ('(')
						print_attachment_expression (l_argument, l_argument_type_set, l_formal_type)
						current_file.put_character (')')
						current_file.put_character (';')
						current_file.put_new_line
					else
						-- If `l_item_attribute' is Void, it means that it is never used,
						-- therefore there is no need to set it.
					end
				end
			end
		end

	print_builtin_sized_integer_times_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'INTEGER_xx.infix "*"'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_target: ET_EXPRESSION
			l_argument: ET_EXPRESSION
			l_actual_type_set: ET_DYNAMIC_TYPE_SET
			l_formal_type: ET_DYNAMIC_TYPE
		do
			if call_operands.count /= 2 then
					-- Internal error: this should already have been reported in ET_FEATURE_FLATTENER.
				set_fatal_error
				error_handler.report_giaaa_error
			elseif a_feature.result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				l_target := call_operands.first
				l_argument := call_operands.item (2)
				print_type_cast (a_feature.result_type_set.static_type, current_file)
				current_file.put_character ('(')
				current_file.put_character ('(')
				if a_target_type.is_basic then
					print_unboxed_expression (l_target, a_target_type, a_check_void_target)
				else
-- TODO: use feature `item'.
					set_fatal_error
					error_handler.report_giaaa_error
				end
				current_file.put_character (')')
				current_file.put_character ('*')
				current_file.put_character ('(')
				l_actual_type_set := dynamic_type_set (l_argument)
				l_formal_type := argument_type_set_in_feature (1, a_feature).static_type
				print_attachment_expression (l_argument, l_actual_type_set, l_formal_type)
				current_file.put_character (')')
				current_file.put_character (')')
			end
		end

	print_builtin_sized_integer_to_character_8_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'INTEGER_xx.to_character_8'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_target: ET_EXPRESSION
		do
			if a_feature.result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				l_target := call_operands.first
				print_type_cast (a_feature.result_type_set.static_type, current_file)
				current_file.put_character ('(')
				if a_target_type.is_basic then
					print_unboxed_expression (l_target, a_target_type, a_check_void_target)
				else
-- TODO: use feature `item'.
					set_fatal_error
					error_handler.report_giaaa_error
				end
				current_file.put_character (')')
			end
		end

	print_builtin_sized_integer_to_character_32_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'INTEGER_xx.to_character_32'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_target: ET_EXPRESSION
		do
			if a_feature.result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				l_target := call_operands.first
				print_type_cast (a_feature.result_type_set.static_type, current_file)
				current_file.put_character ('(')
				if a_target_type.is_basic then
					print_unboxed_expression (l_target, a_target_type, a_check_void_target)
				else
-- TODO: use feature `item'.
					set_fatal_error
					error_handler.report_giaaa_error
				end
				current_file.put_character (')')
			end
		end

	print_builtin_sized_integer_to_double_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'INTEGER_xx.to_double'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_target: ET_EXPRESSION
		do
			if a_feature.result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				l_target := call_operands.first
				print_type_cast (a_feature.result_type_set.static_type, current_file)
				current_file.put_character ('(')
				if a_target_type.is_basic then
					print_unboxed_expression (l_target, a_target_type, a_check_void_target)
				else
-- TODO: use feature `item'.
					set_fatal_error
					error_handler.report_giaaa_error
				end
				current_file.put_character (')')
			end
		end

	print_builtin_sized_integer_to_real_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'INTEGER_xx.to_real'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_target: ET_EXPRESSION
		do
			if a_feature.result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				l_target := call_operands.first
				print_type_cast (a_feature.result_type_set.static_type, current_file)
				current_file.put_character ('(')
				if a_target_type.is_basic then
					print_unboxed_expression (l_target, a_target_type, a_check_void_target)
				else
-- TODO: use feature `item'.
					set_fatal_error
					error_handler.report_giaaa_error
				end
				current_file.put_character (')')
			end
		end

	print_builtin_sized_integer_to_real_32_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'INTEGER_xx.to_real_32'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_target: ET_EXPRESSION
		do
			if a_feature.result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				l_target := call_operands.first
				print_type_cast (a_feature.result_type_set.static_type, current_file)
				current_file.put_character ('(')
				if a_target_type.is_basic then
					print_unboxed_expression (l_target, a_target_type, a_check_void_target)
				else
-- TODO: use feature `item'.
					set_fatal_error
					error_handler.report_giaaa_error
				end
				current_file.put_character (')')
			end
		end

	print_builtin_sized_integer_to_real_64_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'INTEGER_xx.to_real_64'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_target: ET_EXPRESSION
		do
			if a_feature.result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				l_target := call_operands.first
				print_type_cast (a_feature.result_type_set.static_type, current_file)
				current_file.put_character ('(')
				if a_target_type.is_basic then
					print_unboxed_expression (l_target, a_target_type, a_check_void_target)
				else
-- TODO: use feature `item'.
					set_fatal_error
					error_handler.report_giaaa_error
				end
				current_file.put_character (')')
			end
		end

	print_builtin_sized_real_ceiling_real_32_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'REAL_xx.ceiling_real_32'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_target: ET_EXPRESSION
		do
			if a_feature.result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				l_target := call_operands.first
				include_runtime_header_file ("ge_real.h", False, header_file)
				print_type_cast (a_feature.result_type_set.static_type, current_file)
				current_file.put_string (c_ge_ceiling)
				current_file.put_character ('(')
				current_file.put_character ('(')
				current_file.put_string (c_double)
				current_file.put_character (')')
				current_file.put_character ('(')
				if a_target_type.is_basic then
					print_unboxed_expression (l_target, a_target_type, a_check_void_target)
				else
-- TODO: use feature `item'.
					set_fatal_error
					error_handler.report_giaaa_error
				end
				current_file.put_character (')')
				current_file.put_character (')')
			end
		end

	print_builtin_sized_real_ceiling_real_64_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'REAL_xx.ceiling_real_64'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_target: ET_EXPRESSION
		do
			if a_feature.result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				l_target := call_operands.first
				include_runtime_header_file ("ge_real.h", False, header_file)
				print_type_cast (a_feature.result_type_set.static_type, current_file)
				current_file.put_string (c_ge_ceiling)
				current_file.put_character ('(')
				current_file.put_character ('(')
				current_file.put_string (c_double)
				current_file.put_character (')')
				current_file.put_character ('(')
				if a_target_type.is_basic then
					print_unboxed_expression (l_target, a_target_type, a_check_void_target)
				else
-- TODO: use feature `item'.
					set_fatal_error
					error_handler.report_giaaa_error
				end
				current_file.put_character (')')
				current_file.put_character (')')
			end
		end

	print_builtin_sized_real_divide_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'REAL_xx.infix "/"'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_target: ET_EXPRESSION
			l_argument: ET_EXPRESSION
			l_actual_type_set: ET_DYNAMIC_TYPE_SET
			l_formal_type: ET_DYNAMIC_TYPE
		do
			if call_operands.count /= 2 then
					-- Internal error: this should already have been reported in ET_FEATURE_FLATTENER.
				set_fatal_error
				error_handler.report_giaaa_error
			elseif a_feature.result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				l_target := call_operands.first
				l_argument := call_operands.item (2)
				print_type_cast (a_feature.result_type_set.static_type, current_file)
				current_file.put_character ('(')
				current_file.put_character ('(')
				if a_target_type.is_basic then
					print_unboxed_expression (l_target, a_target_type, a_check_void_target)
				else
-- TODO: use feature `item'.
					set_fatal_error
					error_handler.report_giaaa_error
				end
				current_file.put_character (')')
				current_file.put_character ('/')
				current_file.put_character ('(')
				l_actual_type_set := dynamic_type_set (l_argument)
				l_formal_type := argument_type_set_in_feature (1, a_feature).static_type
				print_attachment_expression (l_argument, l_actual_type_set, l_formal_type)
				current_file.put_character (')')
				current_file.put_character (')')
			end
		end

	print_builtin_sized_real_floor_real_32_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'REAL_xx.floor_real_32'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_target: ET_EXPRESSION
		do
			if a_feature.result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				l_target := call_operands.first
				include_runtime_header_file ("ge_real.h", False, header_file)
				print_type_cast (a_feature.result_type_set.static_type, current_file)
				current_file.put_string (c_ge_floor)
				current_file.put_character ('(')
				current_file.put_character ('(')
				current_file.put_string (c_double)
				current_file.put_character (')')
				current_file.put_character ('(')
				if a_target_type.is_basic then
					print_unboxed_expression (l_target, a_target_type, a_check_void_target)
				else
-- TODO: use feature `item'.
					set_fatal_error
					error_handler.report_giaaa_error
				end
				current_file.put_character (')')
				current_file.put_character (')')
			end
		end

	print_builtin_sized_real_floor_real_64_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'REAL_xx.floor_real_64'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_target: ET_EXPRESSION
		do
			if a_feature.result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				l_target := call_operands.first
				include_runtime_header_file ("ge_real.h", False, header_file)
				print_type_cast (a_feature.result_type_set.static_type, current_file)
				current_file.put_string (c_ge_floor)
				current_file.put_character ('(')
				current_file.put_character ('(')
				current_file.put_string (c_double)
				current_file.put_character (')')
				current_file.put_character ('(')
				if a_target_type.is_basic then
					print_unboxed_expression (l_target, a_target_type, a_check_void_target)
				else
-- TODO: use feature `item'.
					set_fatal_error
					error_handler.report_giaaa_error
				end
				current_file.put_character (')')
				current_file.put_character (')')
			end
		end

	print_builtin_sized_real_identity_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'REAL_xx.prefix "+"'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_target: ET_EXPRESSION
		do
			if a_feature.result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				l_target := call_operands.first
				print_type_cast (a_feature.result_type_set.static_type, current_file)
				current_file.put_character ('(')
				if a_target_type.is_basic then
					print_unboxed_expression (l_target, a_target_type, a_check_void_target)
				else
-- TODO: use feature `item'.
					set_fatal_error
					error_handler.report_giaaa_error
				end
				current_file.put_character (')')
			end
		end

	print_builtin_sized_real_item_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'REAL_xx_REF.item'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_target: ET_EXPRESSION
		do
			l_target := call_operands.first
			if a_target_type.is_basic then
				print_unboxed_expression (l_target, a_target_type, a_check_void_target)
			else
					-- Internal attribute.
				print_attribute_access (a_feature, l_target, a_target_type, a_check_void_target)
			end
		end

	print_builtin_sized_real_lt_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'REAL_xx.infix "<"'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_target: ET_EXPRESSION
			l_argument: ET_EXPRESSION
			l_actual_type_set: ET_DYNAMIC_TYPE_SET
			l_formal_type: ET_DYNAMIC_TYPE
		do
			if call_operands.count /= 2 then
					-- Internal error: this should already have been reported in ET_FEATURE_FLATTENER.
				set_fatal_error
				error_handler.report_giaaa_error
			elseif a_feature.result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				l_target := call_operands.first
				l_argument := call_operands.item (2)
				print_type_cast (a_feature.result_type_set.static_type, current_file)
				current_file.put_character ('(')
				current_file.put_character ('(')
				if a_target_type.is_basic then
					print_unboxed_expression (l_target, a_target_type, a_check_void_target)
				else
-- TODO: use feature `item'.
					set_fatal_error
					error_handler.report_giaaa_error
				end
				current_file.put_character (')')
				current_file.put_character ('<')
				current_file.put_character ('(')
				l_actual_type_set := dynamic_type_set (l_argument)
				l_formal_type := argument_type_set_in_feature (1, a_feature).static_type
				print_attachment_expression (l_argument, l_actual_type_set, l_formal_type)
				current_file.put_character (')')
				current_file.put_character (')')
			end
		end

	print_builtin_sized_real_minus_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'REAL_xx.infix "-"'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_target: ET_EXPRESSION
			l_argument: ET_EXPRESSION
			l_actual_type_set: ET_DYNAMIC_TYPE_SET
			l_formal_type: ET_DYNAMIC_TYPE
		do
			if call_operands.count /= 2 then
					-- Internal error: this should already have been reported in ET_FEATURE_FLATTENER.
				set_fatal_error
				error_handler.report_giaaa_error
			elseif a_feature.result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				l_target := call_operands.first
				l_argument := call_operands.item (2)
				print_type_cast (a_feature.result_type_set.static_type, current_file)
				current_file.put_character ('(')
				current_file.put_character ('(')
				if a_target_type.is_basic then
					print_unboxed_expression (l_target, a_target_type, a_check_void_target)
				else
-- TODO: use feature `item'.
					set_fatal_error
					error_handler.report_giaaa_error
				end
				current_file.put_character (')')
				current_file.put_character ('-')
				current_file.put_character ('(')
				l_actual_type_set := dynamic_type_set (l_argument)
				l_formal_type := argument_type_set_in_feature (1, a_feature).static_type
				print_attachment_expression (l_argument, l_actual_type_set, l_formal_type)
				current_file.put_character (')')
				current_file.put_character (')')
			end
		end

	print_builtin_sized_real_opposite_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'REAL_xx.prefix "-"'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_target: ET_EXPRESSION
		do
			if a_feature.result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				l_target := call_operands.first
				print_type_cast (a_feature.result_type_set.static_type, current_file)
				current_file.put_character ('(')
				current_file.put_character ('-')
				current_file.put_character ('(')
				if a_target_type.is_basic then
					print_unboxed_expression (l_target, a_target_type, a_check_void_target)
				else
-- TODO: use feature `item'.
					set_fatal_error
					error_handler.report_giaaa_error
				end
				current_file.put_character (')')
				current_file.put_character (')')
			end
		end

	print_builtin_sized_real_out_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' the body of `a_feature' corresponding
			-- to built-in feature 'REAL_xx.out' from a sized real type.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		local
			l_result_type_set: ET_DYNAMIC_TYPE_SET
		do
			l_result_type_set := current_feature.result_type_set
			if l_result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				print_indentation
				current_file.put_string (c_char)
				current_file.put_character (' ')
				current_file.put_character ('s')
				current_file.put_character ('[')
				current_file.put_character ('4')
				current_file.put_character ('0')
				current_file.put_character (']')
				current_file.put_character (';')
				current_file.put_new_line
				print_indentation
				if current_type.is_basic then
					if current_system.real_32_type.same_named_type (current_type.base_type, current_type.base_class, current_type.base_class) then
						current_file.put_string ("int l = snprintf(s,40,%"%%g%",*C);")
					else
						current_file.put_string ("int l = snprintf(s,40,%"%%.17g%",*C);")
					end
				else
-- TODO: use feature `item'.
					set_fatal_error
					error_handler.report_giaaa_error
				end
				current_file.put_new_line
				print_indentation
				print_result_name (current_file)
				current_file.put_character (' ')
				current_file.put_character ('=')
				current_file.put_character (' ')
				if l_result_type_set.static_type = current_dynamic_system.string_32_type then
					current_file.put_string (c_ge_ms32)
				else
					current_file.put_string (c_ge_ms8)
				end
				current_file.put_string ("(s,l)")
				current_file.put_character (';')
				current_file.put_new_line
			end
		end

	print_builtin_sized_real_plus_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'REAL_xx.infix "+"'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_target: ET_EXPRESSION
			l_argument: ET_EXPRESSION
			l_actual_type_set: ET_DYNAMIC_TYPE_SET
			l_formal_type: ET_DYNAMIC_TYPE
		do
			if call_operands.count /= 2 then
					-- Internal error: this should already have been reported in ET_FEATURE_FLATTENER.
				set_fatal_error
				error_handler.report_giaaa_error
			elseif a_feature.result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				l_target := call_operands.first
				l_argument := call_operands.item (2)
				print_type_cast (a_feature.result_type_set.static_type, current_file)
				current_file.put_character ('(')
				current_file.put_character ('(')
				if a_target_type.is_basic then
					print_unboxed_expression (l_target, a_target_type, a_check_void_target)
				else
-- TODO: use feature `item'.
					set_fatal_error
					error_handler.report_giaaa_error
				end
				current_file.put_character (')')
				current_file.put_character ('+')
				current_file.put_character ('(')
				l_actual_type_set := dynamic_type_set (l_argument)
				l_formal_type := argument_type_set_in_feature (1, a_feature).static_type
				print_attachment_expression (l_argument, l_actual_type_set, l_formal_type)
				current_file.put_character (')')
				current_file.put_character (')')
			end
		end

	print_builtin_sized_real_power_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'REAL_xx.infix "^"'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_target: ET_EXPRESSION
			l_argument: ET_EXPRESSION
			l_actual_type_set: ET_DYNAMIC_TYPE_SET
			l_formal_type: ET_DYNAMIC_TYPE
		do
			if call_operands.count /= 2 then
					-- Internal error: this should already have been reported in ET_FEATURE_FLATTENER.
				set_fatal_error
				error_handler.report_giaaa_error
			elseif a_feature.result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				l_target := call_operands.first
				l_argument := call_operands.item (2)
				include_runtime_header_file ("ge_real.h", False, header_file)
				print_type_cast (a_feature.result_type_set.static_type, current_file)
				current_file.put_string (c_ge_power)
				current_file.put_character ('(')
				current_file.put_character ('(')
				current_file.put_string (c_double)
				current_file.put_character (')')
				current_file.put_character ('(')
				if a_target_type.is_basic then
					print_unboxed_expression (l_target, a_target_type, a_check_void_target)
				else
-- TODO: use feature `item'.
					set_fatal_error
					error_handler.report_giaaa_error
				end
				current_file.put_character (')')
				current_file.put_character (',')
				current_file.put_character (' ')
				current_file.put_character ('(')
				current_file.put_string (c_double)
				current_file.put_character (')')
				current_file.put_character ('(')
				l_actual_type_set := dynamic_type_set (l_argument)
				l_formal_type := argument_type_set_in_feature (1, a_feature).static_type
				print_attachment_expression (l_argument, l_actual_type_set, l_formal_type)
				current_file.put_character (')')
				current_file.put_character (')')
			end
		end

	print_builtin_sized_real_set_item_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'REAL_xx_REF.set_item'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_target: ET_EXPRESSION
			l_argument: ET_EXPRESSION
			l_argument_type_set: ET_DYNAMIC_TYPE_SET
			l_formal_type: ET_DYNAMIC_TYPE
			l_queries: ET_DYNAMIC_FEATURE_LIST
			l_query: ET_DYNAMIC_FEATURE
			l_item_attribute: ET_DYNAMIC_FEATURE
			i, nb: INTEGER
			l_builtin_item_code: INTEGER
		do
			if call_operands.count /= 2 then
					-- Internal error: this should already have been reported in ET_FEATURE_FLATTENER.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				l_target := call_operands.first
				l_argument := call_operands.item (2)
				l_argument_type_set := dynamic_type_set (l_argument)
				l_formal_type := argument_type_set_in_feature (1, a_feature).static_type
				if a_target_type.is_basic then
					print_indentation
					print_unboxed_expression (l_target, a_target_type, a_check_void_target)
					current_file.put_character (' ')
					current_file.put_character ('=')
					current_file.put_character (' ')
					current_file.put_character ('(')
					print_attachment_expression (l_argument, l_argument_type_set, l_formal_type)
					current_file.put_character (')')
					current_file.put_character (';')
					current_file.put_new_line
				else
					l_builtin_item_code := builtin_feature (a_feature.builtin_code // builtin_capacity, builtin_real_item)
					l_queries := a_target_type.queries
					nb := a_target_type.attribute_count
					from i := 1 until i > nb loop
						l_query := l_queries.item (i)
						if l_query.builtin_code = l_builtin_item_code then
							l_item_attribute := l_query
							i := nb + 1
						else
							i := i + 1
						end
					end
					if l_item_attribute /= Void then
							-- Set the built-in attribute 'item'.
						print_indentation
						print_attribute_access (l_item_attribute, l_target, a_target_type, a_check_void_target)
						current_file.put_character (' ')
						current_file.put_character ('=')
						current_file.put_character (' ')
						current_file.put_character ('(')
						print_attachment_expression (l_argument, l_argument_type_set, l_formal_type)
						current_file.put_character (')')
						current_file.put_character (';')
						current_file.put_new_line
					else
						-- If `l_item_attribute' is Void, it means that it is never used,
						-- therefore there is no need to set it.
					end
				end
			end
		end

	print_builtin_sized_real_times_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'REAL_xx.infix "*"'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_target: ET_EXPRESSION
			l_argument: ET_EXPRESSION
			l_actual_type_set: ET_DYNAMIC_TYPE_SET
			l_formal_type: ET_DYNAMIC_TYPE
		do
			if call_operands.count /= 2 then
					-- Internal error: this should already have been reported in ET_FEATURE_FLATTENER.
				set_fatal_error
				error_handler.report_giaaa_error
			elseif a_feature.result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				l_target := call_operands.first
				l_argument := call_operands.item (2)
				print_type_cast (a_feature.result_type_set.static_type, current_file)
				current_file.put_character ('(')
				current_file.put_character ('(')
				if a_target_type.is_basic then
					print_unboxed_expression (l_target, a_target_type, a_check_void_target)
				else
-- TODO: use feature `item'.
					set_fatal_error
					error_handler.report_giaaa_error
				end
				current_file.put_character (')')
				current_file.put_character ('*')
				current_file.put_character ('(')
				l_actual_type_set := dynamic_type_set (l_argument)
				l_formal_type := argument_type_set_in_feature (1, a_feature).static_type
				print_attachment_expression (l_argument, l_actual_type_set, l_formal_type)
				current_file.put_character (')')
				current_file.put_character (')')
			end
		end

	print_builtin_sized_real_to_double_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'REAL_xx.to_double'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_target: ET_EXPRESSION
		do
			if a_feature.result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				l_target := call_operands.first
				print_type_cast (a_feature.result_type_set.static_type, current_file)
				current_file.put_character ('(')
				if a_target_type.is_basic then
					print_unboxed_expression (l_target, a_target_type, a_check_void_target)
				else
-- TODO: use feature `item'.
					set_fatal_error
					error_handler.report_giaaa_error
				end
				current_file.put_character (')')
			end
		end

	print_builtin_sized_real_truncated_to_integer_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'REAL_xx.truncated_to_integer'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_target: ET_EXPRESSION
		do
			if a_feature.result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				l_target := call_operands.first
				print_type_cast (a_feature.result_type_set.static_type, current_file)
				current_file.put_character ('(')
				if a_target_type.is_basic then
					print_unboxed_expression (l_target, a_target_type, a_check_void_target)
				else
-- TODO: use feature `item'.
					set_fatal_error
					error_handler.report_giaaa_error
				end
				current_file.put_character (')')
			end
		end

	print_builtin_sized_real_truncated_to_integer_64_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'REAL_xx.truncated_to_integer_64'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_target: ET_EXPRESSION
		do
			if a_feature.result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				l_target := call_operands.first
				print_type_cast (a_feature.result_type_set.static_type, current_file)
				current_file.put_character ('(')
				if a_target_type.is_basic then
					print_unboxed_expression (l_target, a_target_type, a_check_void_target)
				else
-- TODO: use feature `item'.
					set_fatal_error
					error_handler.report_giaaa_error
				end
				current_file.put_character (')')
			end
		end

	print_builtin_sized_real_truncated_to_real_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'REAL_xx.truncated_to_real'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_target: ET_EXPRESSION
		do
			if a_feature.result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				l_target := call_operands.first
				print_type_cast (a_feature.result_type_set.static_type, current_file)
				current_file.put_character ('(')
				if a_target_type.is_basic then
					print_unboxed_expression (l_target, a_target_type, a_check_void_target)
				else
-- TODO: use feature `item'.
					set_fatal_error
					error_handler.report_giaaa_error
				end
				current_file.put_character (')')
			end
		end

	print_builtin_special_aliased_resized_area_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' the body of `a_feature' corresponding
			-- to built-in feature 'SPECIAL.aliased_resized_area'.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		local
			l_arguments: ET_FORMAL_ARGUMENT_LIST
			l_argument_name: ET_IDENTIFIER
			l_special_type: ET_DYNAMIC_SPECIAL_TYPE
			l_item_type: ET_DYNAMIC_TYPE
			l_temp: ET_IDENTIFIER
			l_dynamic_type_set: ET_DYNAMIC_TYPE_SET
			l_count_type: ET_DYNAMIC_TYPE
		do
			l_arguments := a_feature.arguments
			l_special_type ?= current_type
			if l_special_type = Void then
					-- Internal error: this should already have been reported in ET_FEATURE_FLATTENER.
					-- This built-in can only be in class SPECIAL (and its descendants).
				set_fatal_error
				error_handler.report_giaaa_error
			elseif l_arguments = Void or else l_arguments.count /= 1 then
					-- Internal error: this error should have been reported by the parse.
				set_fatal_error
				error_handler.report_giaaa_error
			elseif l_special_type.attribute_count < 1 then
					-- Internal error: class "SPECIAL" should have at least the
					-- feature 'count' as first feature.
					-- Already reported in ET_DYNAMIC_SYSTEM.compile_kernel.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				l_dynamic_type_set := result_type_set_in_feature (l_special_type.queries.first)
				l_count_type := l_dynamic_type_set.static_type
				l_item_type := l_special_type.item_type_set.static_type
				l_temp := new_temp_variable (l_count_type)
				print_indentation
				print_temp_name (l_temp, current_file)
				current_file.put_character (' ')
				current_file.put_character ('=')
				current_file.put_character (' ')
				print_attribute_special_count_access (tokens.current_keyword, l_special_type, False)
				current_file.put_character (';')
				current_file.put_new_line
				print_indentation
				current_file.put_string (c_if)
				current_file.put_character (' ')
				current_file.put_character ('(')
				l_argument_name := l_arguments.formal_argument (1).name
				print_argument_name (l_argument_name, current_file)
				current_file.put_character ('>')
				print_temp_name (l_temp, current_file)
				current_file.put_character (')')
				current_file.put_character (' ')
				current_file.put_character ('{')
				current_file.put_new_line
				indent
					-- Need to allocate a new object.
				print_indentation
				print_result_name (current_file)
				current_file.put_character (' ')
				current_file.put_character ('=')
				current_file.put_character (' ')
				current_file.put_string (c_ge_new)
				current_file.put_integer (l_special_type.id)
				current_file.put_character ('(')
				print_argument_name (l_argument_name, current_file)
				current_file.put_character (',')
				current_file.put_character (' ')
				current_file.put_string (c_eif_false)
				current_file.put_character (')')
				current_file.put_character (';')
				current_file.put_new_line
				print_indentation
				if not l_special_type.is_expanded then
					current_file.put_character ('*')
				end
				print_type_cast (l_special_type, current_file)
				current_file.put_character ('(')
				print_result_name (current_file)
				current_file.put_character (')')
				current_file.put_character (' ')
				current_file.put_character ('=')
				current_file.put_character (' ')
				if not l_special_type.is_expanded then
					current_file.put_character ('*')
				end
				print_type_cast (l_special_type, current_file)
				current_file.put_character ('(')
				print_current_name (current_file)
				current_file.put_character (')')
				current_file.put_character (';')
				current_file.put_new_line
					-- Copy old items.
				print_indentation
				current_file.put_string (c_memcpy)
				current_file.put_character ('(')
				print_attribute_special_item_access (tokens.result_keyword, l_special_type, False)
				current_file.put_character (',')
				print_attribute_special_item_access (tokens.current_keyword, l_special_type, False)
				current_file.put_character (',')
				print_temp_name (l_temp, current_file)
				current_file.put_character ('*')
				current_file.put_string (c_sizeof)
				current_file.put_character ('(')
				print_type_declaration (l_item_type, current_file)
				current_file.put_character (')')
				current_file.put_character (')')
				current_file.put_character (';')
				current_file.put_new_line
					-- Initialize new items if needed.
				if l_item_type.is_expanded and then (l_item_type.is_generic or else l_item_type.has_generic_expanded_attributes) then
					print_indentation
					current_file.put_string (c_for)
					current_file.put_character (' ')
					current_file.put_character ('(')
					current_file.put_character (';')
					current_file.put_character (' ')
					print_temp_name (l_temp, current_file)
					current_file.put_character (' ')
					current_file.put_character ('<')
					current_file.put_character (' ')
					print_argument_name (l_argument_name, current_file)
					current_file.put_character (';')
					current_file.put_character (' ')
					print_temp_name (l_temp, current_file)
					current_file.put_character ('+')
					current_file.put_character ('+')
					current_file.put_character (')')
					current_file.put_character (' ')
					current_file.put_character ('{')
					current_file.put_new_line
					indent
					print_indentation
					print_attribute_special_item_access (tokens.result_keyword, l_special_type, False)
					current_file.put_character ('[')
					print_temp_name (l_temp, current_file)
					current_file.put_character (']')
					current_file.put_character (' ')
					current_file.put_character ('=')
					current_file.put_character (' ')
					print_default_name (l_item_type, current_file)
					current_file.put_character (';')
					current_file.put_new_line
					dedent
					print_indentation
					current_file.put_character ('}')
					current_file.put_new_line
				else
					current_file.put_string (c_ifndef)
					current_file.put_character (' ')
					if l_special_type.has_nested_reference_attributes then
						current_file.put_line (c_ge_alloc_cleared)
					else
						current_file.put_line (c_ge_alloc_atomic_cleared)
					end
					print_indentation
					current_file.put_string (c_memset)
					current_file.put_character ('(')
					print_attribute_special_item_access (tokens.result_keyword, l_special_type, False)
					current_file.put_character ('+')
					print_temp_name (l_temp, current_file)
					current_file.put_character (',')
					current_file.put_character ('0')
					current_file.put_character (',')
					current_file.put_character ('(')
					print_argument_name (l_argument_name, current_file)
					current_file.put_character ('-')
					print_temp_name (l_temp, current_file)
					current_file.put_character (')')
					current_file.put_character ('*')
					current_file.put_string (c_sizeof)
					current_file.put_character ('(')
					print_type_declaration (l_item_type, current_file)
					current_file.put_character (')')
					current_file.put_character (')')
					current_file.put_character (';')
					current_file.put_new_line
					current_file.put_line (c_endif)
				end
				dedent
				print_indentation
				current_file.put_character ('}')
				current_file.put_character (' ')
				current_file.put_string (c_else)
				current_file.put_character (' ')
				current_file.put_character ('{')
				current_file.put_new_line
				indent
				print_indentation
				print_result_name (current_file)
				current_file.put_character (' ')
				current_file.put_character ('=')
				current_file.put_character (' ')
				print_current_name (current_file)
				current_file.put_character (';')
				current_file.put_new_line
				dedent
				print_indentation
				current_file.put_character ('}')
				current_file.put_new_line
					-- Set new count.
				print_indentation
				print_attribute_special_count_access (tokens.result_keyword, l_special_type, False)
				current_file.put_character (' ')
				current_file.put_character ('=')
				current_file.put_character (' ')
				print_argument_name (l_argument_name, current_file)
				current_file.put_character (';')
				current_file.put_new_line
			end
		end

	print_builtin_special_base_address_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'SPECIAL.base_address'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		do
			if a_feature.result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				print_type_cast (a_feature.result_type_set.static_type, current_file)
				current_file.put_character ('(')
				print_attribute_special_item_access (call_operands.first, a_target_type, a_check_void_target)
				current_file.put_character (')')
			end
		end

	print_builtin_special_capacity_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'SPECIAL.capacity'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		do
			print_attribute_special_capacity_access (call_operands.first, a_target_type, a_check_void_target)
		end

	print_builtin_special_count_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'SPECIAL.count'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		do
			print_attribute_special_count_access (call_operands.first, a_target_type, a_check_void_target)
		end

	print_builtin_special_element_size_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'SPECIAL.element_size'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_special_type: ET_DYNAMIC_SPECIAL_TYPE
		do
			l_special_type ?= a_target_type
			if l_special_type = Void then
					-- Internal error: this should already have been reported in ET_FEATURE_FLATTENER.
					-- This built-in can only be in class SPECIAL (and its descendants).
				set_fatal_error
				error_handler.report_giaaa_error
			else
				current_file.put_string (c_sizeof)
				current_file.put_character ('(')
				print_type_declaration (l_special_type.item_type_set.static_type, current_file)
				current_file.put_character (')')
			end
		end

	print_builtin_special_item_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'SPECIAL.item'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_argument: ET_EXPRESSION
			l_actual_type_set: ET_DYNAMIC_TYPE_SET
			l_formal_type: ET_DYNAMIC_TYPE
		do
			if call_operands.count /= 2 then
					-- Internal error: this should already have been reported in ET_FEATURE_FLATTENER.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				l_argument := call_operands.item (2)
				l_actual_type_set := dynamic_type_set (l_argument)
				l_formal_type := argument_type_set_in_feature (1, a_feature).static_type
				print_attribute_special_item_access (call_operands.first, a_target_type, a_check_void_target)
				current_file.put_character ('[')
				print_attachment_expression (l_argument, l_actual_type_set, l_formal_type)
				current_file.put_character (']')
			end
		end

	print_builtin_special_put_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'SPECIAL.put'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_argument: ET_EXPRESSION
			l_actual_type_set: ET_DYNAMIC_TYPE_SET
			l_formal_type: ET_DYNAMIC_TYPE
		do
			if call_operands.count /= 3 then
					-- Internal error: this should already have been reported in ET_FEATURE_FLATTENER.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				print_indentation
				print_attribute_special_item_access (call_operands.first, a_target_type, a_check_void_target)
				current_file.put_character ('[')
				l_argument := call_operands.item (3)
				l_actual_type_set := dynamic_type_set (l_argument)
				l_formal_type := argument_type_set_in_feature (2, a_feature).static_type
				print_attachment_expression (l_argument, l_actual_type_set, l_formal_type)
				current_file.put_character (']')
				current_file.put_character (' ')
				current_file.put_character ('=')
				current_file.put_character (' ')
				current_file.put_character ('(')
				l_argument := call_operands.item (2)
				l_actual_type_set := dynamic_type_set (l_argument)
				l_formal_type := argument_type_set_in_feature (1, a_feature).static_type
				print_attachment_expression (l_argument, l_actual_type_set, l_formal_type)
				current_file.put_character (')')
				current_file.put_character (';')
				current_file.put_new_line
			end
		end

	print_builtin_special_put_default_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'SPECIAL.put_default'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_argument: ET_EXPRESSION
			l_actual_type_set: ET_DYNAMIC_TYPE_SET
			l_formal_type: ET_DYNAMIC_TYPE
			l_special_type: ET_DYNAMIC_SPECIAL_TYPE
			l_item_type: ET_DYNAMIC_TYPE
		do
			l_special_type ?= a_target_type
			if l_special_type = Void then
					-- Internal error: this should already have been reported in ET_FEATURE_FLATTENER.
					-- This built-in can only be in class SPECIAL (and its descendants).
				set_fatal_error
				error_handler.report_giaaa_error
			elseif call_operands.count /= 2 then
					-- Internal error: this should already have been reported in ET_FEATURE_FLATTENER.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				print_indentation
				print_attribute_special_item_access (call_operands.first, a_target_type, a_check_void_target)
				current_file.put_character ('[')
				l_argument := call_operands.item (2)
				l_actual_type_set := dynamic_type_set (l_argument)
				l_formal_type := argument_type_set_in_feature (1, a_feature).static_type
				print_attachment_expression (l_argument, l_actual_type_set, l_formal_type)
				current_file.put_character (']')
				current_file.put_character (' ')
				current_file.put_character ('=')
				current_file.put_character (' ')
				l_item_type := l_special_type.item_type_set.static_type
				print_default_entity_value (l_item_type, current_file)
				current_file.put_character (';')
				current_file.put_new_line
			end
		end

	print_builtin_tuple_basic_expanded_item_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' the body of `a_feature' corresponding
			-- to a built-in feature of class "TUPLE" that returns the items
			-- of basic expanded types.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		local
			l_tuple_type: ET_DYNAMIC_TUPLE_TYPE
			l_item_type_sets: ET_DYNAMIC_TYPE_SET_LIST
			l_arguments: ET_FORMAL_ARGUMENT_LIST
			l_result_type: ET_DYNAMIC_TYPE
			i, nb: INTEGER
		do
			l_arguments := a_feature.arguments
			l_tuple_type ?= current_type
			if l_tuple_type = Void then
					-- Internal error: this should already have been reported in ET_FEATURE_FLATTENER.
					-- This built-in feature can only be in class TUPLE (and
					-- its descendants).
				set_fatal_error
				error_handler.report_giaaa_error
			elseif l_arguments = Void or else l_arguments.count /= 1 then
					-- Internal error: this error should have been reported by the parser.
				set_fatal_error
				error_handler.report_giaaa_error
			elseif current_feature.result_type_set = Void then
					-- Internal error: `current_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				l_result_type := current_feature.result_type_set.static_type
				print_indentation
				current_file.put_string (c_switch)
				current_file.put_character (' ')
				current_file.put_character ('(')
				print_argument_name (l_arguments.formal_argument (1).name, current_file)
				current_file.put_character (')')
				current_file.put_character (' ')
				current_file.put_character ('{')
				current_file.put_new_line
				l_item_type_sets := l_tuple_type.item_type_sets
				nb := l_item_type_sets.count
				from i := 1 until i > nb loop
					if l_item_type_sets.item (i).static_type = l_result_type then
						print_indentation
						current_file.put_string (c_case)
						current_file.put_character (' ')
						current_file.put_integer (i)
						current_file.put_character (':')
						current_file.put_new_line
						indent
						print_indentation
						print_result_name (current_file)
						current_file.put_character (' ')
						current_file.put_character ('=')
						current_file.put_character (' ')
						print_attribute_tuple_item_access (i, tokens.current_keyword, l_tuple_type, False)
						current_file.put_character (';')
						current_file.put_new_line
						print_indentation
						current_file.put_string (c_break)
						current_file.put_character (';')
						current_file.put_new_line
						dedent
					end
					i := i + 1
				end
				print_indentation
				current_file.put_character ('}')
				current_file.put_new_line
			end
		end

	print_builtin_tuple_boolean_item_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' the body of `a_feature' corresponding
			-- to built-in feature 'TUPLE.boolean_item'.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		do
			print_builtin_tuple_basic_expanded_item_body (a_feature)
		end

	print_builtin_tuple_character_8_item_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' the body of `a_feature' corresponding
			-- to built-in feature 'TUPLE.character_8_item'.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		do
			print_builtin_tuple_basic_expanded_item_body (a_feature)
		end

	print_builtin_tuple_character_32_item_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' the body of `a_feature' corresponding
			-- to built-in feature 'TUPLE.character_32_item'.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		do
			print_builtin_tuple_basic_expanded_item_body (a_feature)
		end

	print_builtin_tuple_count_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'TUPLE.count'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_tuple_type: ET_DYNAMIC_TUPLE_TYPE
		do
			l_tuple_type ?= a_target_type
			if l_tuple_type = Void then
					-- Internal error: this should already have been reported in ET_FEATURE_FLATTENER.
					-- This built-in feature can only be in class TUPLE (and
					-- its descendants).
				set_fatal_error
				error_handler.report_giaaa_error
			elseif a_feature.result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				print_type_cast (a_feature.result_type_set.static_type, current_file)
				current_file.put_character ('(')
				current_file.put_integer (l_tuple_type.item_type_sets.count)
				current_file.put_character (')')
			end
		end

	print_builtin_tuple_integer_8_item_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' the body of `a_feature' corresponding
			-- to built-in feature 'TUPLE.integer_8_item'.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		do
			print_builtin_tuple_basic_expanded_item_body (a_feature)
		end

	print_builtin_tuple_integer_16_item_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' the body of `a_feature' corresponding
			-- to built-in feature 'TUPLE.integer_16_item'.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		do
			print_builtin_tuple_basic_expanded_item_body (a_feature)
		end

	print_builtin_tuple_integer_32_item_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' the body of `a_feature' corresponding
			-- to built-in feature 'TUPLE.integer_32_item'.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		do
			print_builtin_tuple_basic_expanded_item_body (a_feature)
		end

	print_builtin_tuple_integer_64_item_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' the body of `a_feature' corresponding
			-- to built-in feature 'TUPLE.integer_64_item'.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		do
			print_builtin_tuple_basic_expanded_item_body (a_feature)
		end

	print_builtin_tuple_item_code_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' the body of `a_feature' corresponding
			-- to built-in feature 'TUPLE.item_code'.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		local
			l_tuple_type: ET_DYNAMIC_TUPLE_TYPE
			l_item_type_sets: ET_DYNAMIC_TYPE_SET_LIST
			l_item_type: ET_DYNAMIC_TYPE
			l_arguments: ET_FORMAL_ARGUMENT_LIST
			l_result_type: ET_DYNAMIC_TYPE
			i, nb: INTEGER
		do
			l_arguments := a_feature.arguments
			l_tuple_type ?= current_type
			if l_tuple_type = Void then
					-- Internal error: this should already have been reported in ET_FEATURE_FLATTENER.
					-- This built-in feature can only be in class TUPLE (and
					-- its descendants).
				set_fatal_error
				error_handler.report_giaaa_error
			elseif l_arguments = Void or else l_arguments.count /= 1 then
					-- Internal error: this error should have been reported by the parser.
				set_fatal_error
				error_handler.report_giaaa_error
			elseif current_feature.result_type_set = Void then
					-- Internal error: `current_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				print_indentation
				current_file.put_string (c_switch)
				current_file.put_character (' ')
				current_file.put_character ('(')
				print_argument_name (l_arguments.formal_argument (1).name, current_file)
				current_file.put_character (')')
				current_file.put_character (' ')
				current_file.put_character ('{')
				current_file.put_new_line
				l_item_type_sets := l_tuple_type.item_type_sets
				l_result_type := current_feature.result_type_set.static_type
				nb := l_item_type_sets.count
				from i := 1 until i > nb loop
					print_indentation
					current_file.put_string (c_case)
					current_file.put_character (' ')
					current_file.put_integer (i)
					current_file.put_character (':')
					current_file.put_new_line
					indent
					print_indentation
					print_result_name (current_file)
					current_file.put_character (' ')
					current_file.put_character ('=')
					current_file.put_character (' ')
					print_type_cast (l_result_type, current_file)
					l_item_type := l_item_type_sets.item (i).static_type
					if current_universe_impl.boolean_type.same_named_type (l_item_type.base_type, current_type.base_type, current_type.base_type) then
						current_file.put_integer (0x01)
					elseif current_universe_impl.character_8_type.same_named_type (l_item_type.base_type, current_type.base_type, current_type.base_type) then
						current_file.put_integer (0x02)
					elseif current_universe_impl.character_32_type.same_named_type (l_item_type.base_type, current_type.base_type, current_type.base_type) then
						current_file.put_integer (0x0E)
					elseif current_universe_impl.integer_8_type.same_named_type (l_item_type.base_type, current_type.base_type, current_type.base_type) then
						current_file.put_integer (0x06)
					elseif current_universe_impl.integer_16_type.same_named_type (l_item_type.base_type, current_type.base_type, current_type.base_type) then
						current_file.put_integer (0x07)
					elseif current_universe_impl.integer_32_type.same_named_type (l_item_type.base_type, current_type.base_type, current_type.base_type) then
						current_file.put_integer (0x08)
					elseif current_universe_impl.integer_64_type.same_named_type (l_item_type.base_type, current_type.base_type, current_type.base_type) then
						current_file.put_integer (0x09)
					elseif current_universe_impl.natural_8_type.same_named_type (l_item_type.base_type, current_type.base_type, current_type.base_type) then
						current_file.put_integer (0x0A)
					elseif current_universe_impl.natural_16_type.same_named_type (l_item_type.base_type, current_type.base_type, current_type.base_type) then
						current_file.put_integer (0x0B)
					elseif current_universe_impl.natural_32_type.same_named_type (l_item_type.base_type, current_type.base_type, current_type.base_type) then
						current_file.put_integer (0x0C)
					elseif current_universe_impl.natural_64_type.same_named_type (l_item_type.base_type, current_type.base_type, current_type.base_type) then
						current_file.put_integer (0x0D)
					elseif current_universe_impl.pointer_type.same_named_type (l_item_type.base_type, current_type.base_type, current_type.base_type) then
						current_file.put_integer (0x05)
					elseif current_universe_impl.real_32_type.same_named_type (l_item_type.base_type, current_type.base_type, current_type.base_type) then
						current_file.put_integer (0x04)
					elseif current_universe_impl.real_64_type.same_named_type (l_item_type.base_type, current_type.base_type, current_type.base_type) then
						current_file.put_integer (0x03)
					else
						current_file.put_integer (0x00)
					end
					current_file.put_character (';')
					current_file.put_new_line
					print_indentation
					current_file.put_string (c_break)
					current_file.put_character (';')
					current_file.put_new_line
					dedent
					i := i + 1
				end
				print_indentation
				current_file.put_character ('}')
				current_file.put_new_line
			end
		end

	print_builtin_tuple_natural_8_item_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' the body of `a_feature' corresponding
			-- to built-in feature 'TUPLE.natural_8_item'.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		do
			print_builtin_tuple_basic_expanded_item_body (a_feature)
		end

	print_builtin_tuple_natural_16_item_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' the body of `a_feature' corresponding
			-- to built-in feature 'TUPLE.natural_16_item'.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		do
			print_builtin_tuple_basic_expanded_item_body (a_feature)
		end

	print_builtin_tuple_natural_32_item_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' the body of `a_feature' corresponding
			-- to built-in feature 'TUPLE.natural_32_item'.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		do
			print_builtin_tuple_basic_expanded_item_body (a_feature)
		end

	print_builtin_tuple_natural_64_item_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' the body of `a_feature' corresponding
			-- to built-in feature 'TUPLE.natural_64_item'.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		do
			print_builtin_tuple_basic_expanded_item_body (a_feature)
		end

	print_builtin_tuple_object_comparison_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'TUPLE.object_comparison'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		do
				-- Internal attribute.
			print_attribute_access (a_feature, call_operands.first, a_target_type, a_check_void_target)
		end

	print_builtin_tuple_pointer_item_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' the body of `a_feature' corresponding
			-- to built-in feature 'TUPLE.pointer_item'.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		do
			print_builtin_tuple_basic_expanded_item_body (a_feature)
		end

	print_builtin_tuple_put_basic_expanded_item_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' the body of `a_feature' corresponding
			-- to a built-in feature of class "TUPLE" that sets the items
			-- of basic expanded types.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		local
			l_tuple_type: ET_DYNAMIC_TUPLE_TYPE
			l_item_type_sets: ET_DYNAMIC_TYPE_SET_LIST
			l_arguments: ET_FORMAL_ARGUMENT_LIST
			l_argument_type: ET_DYNAMIC_TYPE
			i, nb: INTEGER
		do
			l_arguments := a_feature.arguments
			l_tuple_type ?= current_type
			if l_tuple_type = Void then
					-- Internal error: this should already have been reported in ET_FEATURE_FLATTENER.
					-- This built-in feature can only be in class TUPLE (and
					-- its descendants).
				set_fatal_error
				error_handler.report_giaaa_error
			elseif l_arguments = Void or else l_arguments.count /= 2 then
					-- Internal error: this error should have been reported by the parser.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				l_argument_type := argument_type_set (1).static_type
				print_indentation
				current_file.put_string (c_switch)
				current_file.put_character (' ')
				current_file.put_character ('(')
				print_argument_name (l_arguments.formal_argument (2).name, current_file)
				current_file.put_character (')')
				current_file.put_character (' ')
				current_file.put_character ('{')
				current_file.put_new_line
				l_item_type_sets := l_tuple_type.item_type_sets
				nb := l_item_type_sets.count
				from i := 1 until i > nb loop
					if l_item_type_sets.item (i).static_type = l_argument_type then
						print_indentation
						current_file.put_string (c_case)
						current_file.put_character (' ')
						current_file.put_integer (i)
						current_file.put_character (':')
						current_file.put_new_line
						indent
						print_indentation
						print_attribute_tuple_item_access (i, tokens.current_keyword, l_tuple_type, False)
						current_file.put_character (' ')
						current_file.put_character ('=')
						current_file.put_character (' ')
						print_argument_name (l_arguments.formal_argument (1).name, current_file)
						current_file.put_character (';')
						current_file.put_new_line
						print_indentation
						current_file.put_string (c_break)
						current_file.put_character (';')
						current_file.put_new_line
						dedent
					end
					i := i + 1
				end
				print_indentation
				current_file.put_character ('}')
				current_file.put_new_line
			end
		end

	print_builtin_tuple_put_boolean_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' the body of `a_feature' corresponding
			-- to built-in feature 'TUPLE.put_boolean'.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		do
			print_builtin_tuple_put_basic_expanded_item_body (a_feature)
		end

	print_builtin_tuple_put_character_8_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' the body of `a_feature' corresponding
			-- to built-in feature 'TUPLE.put_character_8'.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		do
			print_builtin_tuple_put_basic_expanded_item_body (a_feature)
		end

	print_builtin_tuple_put_character_32_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' the body of `a_feature' corresponding
			-- to built-in feature 'TUPLE.put_character_32'.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		do
			print_builtin_tuple_put_basic_expanded_item_body (a_feature)
		end

	print_builtin_tuple_put_integer_8_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' the body of `a_feature' corresponding
			-- to built-in feature 'TUPLE.put_integer_8'.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		do
			print_builtin_tuple_put_basic_expanded_item_body (a_feature)
		end

	print_builtin_tuple_put_integer_16_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' the body of `a_feature' corresponding
			-- to built-in feature 'TUPLE.put_integer_16'.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		do
			print_builtin_tuple_put_basic_expanded_item_body (a_feature)
		end

	print_builtin_tuple_put_integer_32_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' the body of `a_feature' corresponding
			-- to built-in feature 'TUPLE.put_integer_32'.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		do
			print_builtin_tuple_put_basic_expanded_item_body (a_feature)
		end

	print_builtin_tuple_put_integer_64_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' the body of `a_feature' corresponding
			-- to built-in feature 'TUPLE.put_integer_64'.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		do
			print_builtin_tuple_put_basic_expanded_item_body (a_feature)
		end

	print_builtin_tuple_put_natural_8_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' the body of `a_feature' corresponding
			-- to built-in feature 'TUPLE.put_natural_8'.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		do
			print_builtin_tuple_put_basic_expanded_item_body (a_feature)
		end

	print_builtin_tuple_put_natural_16_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' the body of `a_feature' corresponding
			-- to built-in feature 'TUPLE.put_natural_16'.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		do
			print_builtin_tuple_put_basic_expanded_item_body (a_feature)
		end

	print_builtin_tuple_put_natural_32_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' the body of `a_feature' corresponding
			-- to built-in feature 'TUPLE.put_natural_32'.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		do
			print_builtin_tuple_put_basic_expanded_item_body (a_feature)
		end

	print_builtin_tuple_put_natural_64_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' the body of `a_feature' corresponding
			-- to built-in feature 'TUPLE.put_natural_64'.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		do
			print_builtin_tuple_put_basic_expanded_item_body (a_feature)
		end

	print_builtin_tuple_put_pointer_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' the body of `a_feature' corresponding
			-- to built-in feature 'TUPLE.put_pointer'.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		do
			print_builtin_tuple_put_basic_expanded_item_body (a_feature)
		end

	print_builtin_tuple_put_real_32_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' the body of `a_feature' corresponding
			-- to built-in feature 'TUPLE.put_real_32'.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		do
			print_builtin_tuple_put_basic_expanded_item_body (a_feature)
		end

	print_builtin_tuple_put_real_64_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' the body of `a_feature' corresponding
			-- to built-in feature 'TUPLE.put_real_64'.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		do
			print_builtin_tuple_put_basic_expanded_item_body (a_feature)
		end

	print_builtin_tuple_put_reference_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' the body of `a_feature' corresponding
			-- to built-in feature 'TUPLE.put_reference'.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		local
			l_tuple_type: ET_DYNAMIC_TUPLE_TYPE
			l_item_type_sets: ET_DYNAMIC_TYPE_SET_LIST
			l_item_type: ET_DYNAMIC_TYPE
			l_argument_type_set: ET_DYNAMIC_TYPE_SET
			l_arguments: ET_FORMAL_ARGUMENT_LIST
			l_argument: ET_IDENTIFIER
			i, nb: INTEGER
		do
			l_arguments := a_feature.arguments
			l_tuple_type ?= current_type
			if l_tuple_type = Void then
					-- Internal error: this should already have been reported in ET_FEATURE_FLATTENER.
					-- This built-in feature can only be in class TUPLE (and
					-- its descendants).
				set_fatal_error
				error_handler.report_giaaa_error
			elseif l_arguments = Void or else l_arguments.count /= 2 then
					-- Internal error: this error should have been reported by the parser.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				l_argument := l_arguments.formal_argument (1).name
				l_argument_type_set := argument_type_set (1)
				print_indentation
				current_file.put_string (c_switch)
				current_file.put_character (' ')
				current_file.put_character ('(')
				print_argument_name (l_arguments.formal_argument (2).name, current_file)
				current_file.put_character (')')
				current_file.put_character (' ')
				current_file.put_character ('{')
				current_file.put_new_line
				l_item_type_sets := l_tuple_type.item_type_sets
				nb := l_item_type_sets.count
				from i := 1 until i > nb loop
					l_item_type := l_item_type_sets.item (i).static_type
					if not l_item_type.is_expanded or else not l_item_type.is_basic then
						print_indentation
						current_file.put_string (c_case)
						current_file.put_character (' ')
						current_file.put_integer (i)
						current_file.put_character (':')
						current_file.put_new_line
						indent
						print_indentation
						print_attribute_tuple_item_access (i, tokens.current_keyword, l_tuple_type, False)
						current_file.put_character (' ')
						current_file.put_character ('=')
						current_file.put_character (' ')
-- TODO: Using `print_attachment_expression' may trigger a call to 'copy'. We should avoid that.
-- Use `print_attachment_expression' anyway here so that there is no object of the wrong type
-- assigned to the Tuple item (this is forbidden by the preconditions, but we should not let them
-- go through when preconditions are turn off for example).
						print_attachment_expression (l_argument, l_argument_type_set, l_item_type)
						current_file.put_character (';')
						current_file.put_new_line
						print_indentation
						current_file.put_string (c_break)
						current_file.put_character (';')
						current_file.put_new_line
						dedent
					end
					i := i + 1
				end
				print_indentation
				current_file.put_character ('}')
				current_file.put_new_line
			end
		end

	print_builtin_tuple_real_32_item_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' the body of `a_feature' corresponding
			-- to built-in feature 'TUPLE.real_32_item'.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		do
			print_builtin_tuple_basic_expanded_item_body (a_feature)
		end

	print_builtin_tuple_real_64_item_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' the body of `a_feature' corresponding
			-- to built-in feature 'TUPLE.real_64_item'.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		do
			print_builtin_tuple_basic_expanded_item_body (a_feature)
		end

	print_builtin_tuple_reference_item_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' the body of `a_feature' corresponding
			-- to built-in feature 'TUPLE.reference_item'.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		local
			l_tuple_type: ET_DYNAMIC_TUPLE_TYPE
			l_item_type_sets: ET_DYNAMIC_TYPE_SET_LIST
			l_item_type_set: ET_DYNAMIC_TYPE_SET
			l_item_type: ET_DYNAMIC_TYPE
			l_arguments: ET_FORMAL_ARGUMENT_LIST
			i, nb: INTEGER
		do
			l_arguments := a_feature.arguments
			l_tuple_type ?= current_type
			if l_tuple_type = Void then
					-- Internal error: this should already have been reported in ET_FEATURE_FLATTENER.
					-- This built-in feature can only be in class TUPLE (and
					-- its descendants).
				set_fatal_error
				error_handler.report_giaaa_error
			elseif l_arguments = Void or else l_arguments.count /= 1 then
					-- Internal error: this error should have been reported by the parser.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				print_indentation
				current_file.put_string (c_switch)
				current_file.put_character (' ')
				current_file.put_character ('(')
				print_argument_name (l_arguments.formal_argument (1).name, current_file)
				current_file.put_character (')')
				current_file.put_character (' ')
				current_file.put_character ('{')
				current_file.put_new_line
				l_item_type_sets := l_tuple_type.item_type_sets
				nb := l_item_type_sets.count
				from i := 1 until i > nb loop
					l_item_type_set := l_item_type_sets.item (i)
					l_item_type := l_item_type_set.static_type
					if not l_item_type.is_expanded or else not l_item_type.is_basic then
						print_indentation
						current_file.put_string (c_case)
						current_file.put_character (' ')
						current_file.put_integer (i)
						current_file.put_character (':')
						current_file.put_new_line
						indent
						print_indentation
						print_result_name (current_file)
						current_file.put_character (' ')
						current_file.put_character ('=')
						current_file.put_character (' ')
						print_adapted_expression (agent print_attribute_tuple_item_access (i, tokens.current_keyword, l_tuple_type, False), l_item_type_set, current_dynamic_system.any_type)
						current_file.put_character (';')
						current_file.put_new_line
						print_indentation
						current_file.put_string (c_break)
						current_file.put_character (';')
						current_file.put_new_line
						dedent
					end
					i := i + 1
				end
				print_indentation
				current_file.put_character ('}')
				current_file.put_new_line
			end
		end

	print_builtin_tuple_set_object_comparison_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'TUPLE.set_object_comparison'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_target: ET_EXPRESSION
			l_argument: ET_EXPRESSION
			l_actual_type_set: ET_DYNAMIC_TYPE_SET
			l_formal_type: ET_DYNAMIC_TYPE
			l_queries: ET_DYNAMIC_FEATURE_LIST
			l_query: ET_DYNAMIC_FEATURE
			l_object_comparison_attribute: ET_DYNAMIC_FEATURE
			i, nb: INTEGER
			l_builtin_object_comparison_code: INTEGER
		do
			if call_operands.count /= 2 then
					-- Internal error: this should already have been reported in ET_FEATURE_FLATTENER.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				l_target := call_operands.first
				l_argument := call_operands.item (2)
				l_actual_type_set := dynamic_type_set (l_argument)
				l_formal_type := argument_type_set_in_feature (1, a_feature).static_type
				l_builtin_object_comparison_code := builtin_tuple_feature (builtin_tuple_object_comparison)
				l_queries := a_target_type.queries
				nb := a_target_type.attribute_count
				from i := 1 until i > nb loop
					l_query := l_queries.item (i)
					if l_query.builtin_code = l_builtin_object_comparison_code then
						l_object_comparison_attribute := l_query
						i := nb + 1
					else
						i := i + 1
					end
				end
				if l_object_comparison_attribute /= Void then
						-- Set the built-in attribute 'object_comparison'.
					print_indentation
					print_attribute_access (l_object_comparison_attribute, l_target, a_target_type, a_check_void_target)
					current_file.put_character (' ')
					current_file.put_character ('=')
					current_file.put_character (' ')
					current_file.put_character ('(')
					print_attachment_expression (l_argument, l_actual_type_set, l_formal_type)
					current_file.put_character (')')
					current_file.put_character (';')
					current_file.put_new_line
				else
					-- If `l_object_comparison_attribute' is Void, it means that it is never used,
					-- therefore there is no need to set it.
				end
			end
		end

	print_builtin_type_base_class_name_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'TYPE.base_class_name'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_parameters: ET_ACTUAL_PARAMETER_LIST
			l_string: STRING
			l_result_type_set: ET_DYNAMIC_TYPE_SET
		do
			l_result_type_set := a_feature.result_type_set
			l_parameters := a_target_type.base_type.actual_parameters
			if l_parameters = Void or else l_parameters.count < 1 then
					-- Internal error: we should have already checked by now
					-- that class TYPE has a generic parameter.
				set_fatal_error
				error_handler.report_giaaa_error
			elseif l_result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				l_string := l_parameters.type (1).base_class (a_target_type.base_type).upper_name
				if l_result_type_set.static_type = current_dynamic_system.string_32_type then
					current_file.put_string (c_ge_ms32)
				else
					current_file.put_string (c_ge_ms8)
				end
				current_file.put_character ('(')
				print_escaped_string (l_string)
				current_file.put_character (',')
				current_file.put_character (' ')
				current_file.put_integer (l_string.count)
				current_file.put_character (')')
			end
		end

	print_builtin_type_basic_expanded_field_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' the body of `a_feature' corresponding
			-- to a built-in feature of class "TYPE" that returns the fields
			-- of basic expanded types.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		local
			l_result_type_set: ET_DYNAMIC_TYPE_SET
			l_result_type: ET_DYNAMIC_TYPE
			l_parameters: ET_ACTUAL_PARAMETER_LIST
			l_arguments: ET_FORMAL_ARGUMENT_LIST
			l_dynamic_type: ET_DYNAMIC_TYPE
			l_queries: ET_DYNAMIC_FEATURE_LIST
			l_attribute: ET_DYNAMIC_FEATURE
			i, nb: INTEGER
		do
			l_result_type_set := current_feature.result_type_set
			l_arguments := a_feature.arguments
			l_parameters := current_type.base_type.actual_parameters
			if l_parameters = Void or else l_parameters.count < 1 then
					-- Internal error: we should have already checked by now
					-- that class TYPE has a generic parameter.
				set_fatal_error
				error_handler.report_giaaa_error
			elseif l_arguments = Void or else l_arguments.count /= 2 then
					-- Internal error: this error should have been reported by the parser.
				set_fatal_error
				error_handler.report_giaaa_error
			elseif l_result_type_set = Void then
					-- Internal error: `current_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				l_result_type := l_result_type_set.static_type
				l_dynamic_type := current_dynamic_system.dynamic_type (l_parameters.type (1), current_type.base_type)
				l_queries := l_dynamic_type.queries
				nb := l_dynamic_type.attribute_count
				print_indentation
				current_file.put_string (c_switch)
				current_file.put_character (' ')
				current_file.put_character ('(')
				print_argument_name (l_arguments.formal_argument (1).name, current_file)
				current_file.put_character (')')
				current_file.put_character (' ')
				current_file.put_character ('{')
				current_file.put_new_line
				from i := 1 until i > nb loop
					l_attribute := l_queries.item (i)
					if result_type_set_in_feature (l_attribute).static_type = l_result_type then
						print_indentation
						current_file.put_string (c_case)
						current_file.put_character (' ')
						current_file.put_integer (i)
						current_file.put_character (':')
						current_file.put_new_line
						indent
						print_indentation
						print_result_name (current_file)
						current_file.put_character (' ')
						current_file.put_character ('=')
						current_file.put_character (' ')
						print_attribute_access (l_attribute, l_arguments.formal_argument (2).name, l_dynamic_type, True)
						current_file.put_character (';')
						current_file.put_new_line
						print_indentation
						current_file.put_string (c_break)
						current_file.put_character (';')
						current_file.put_new_line
						dedent
					end
					i := i + 1
				end
				print_indentation
				current_file.put_character ('}')
				current_file.put_new_line
			end
		end

	print_builtin_type_boolean_field_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' the body of `a_feature' corresponding
			-- to built-in feature 'TYPE.boolean_field'.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		do
			print_builtin_type_basic_expanded_field_body (a_feature)
		end

	print_builtin_type_character_8_field_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' the body of `a_feature' corresponding
			-- to built-in feature 'TYPE.character_8_field'.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		do
			print_builtin_type_basic_expanded_field_body (a_feature)
		end

	print_builtin_type_character_32_field_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' the body of `a_feature' corresponding
			-- to built-in feature 'TYPE.character_32_field'.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		do
			print_builtin_type_basic_expanded_field_body (a_feature)
		end

	print_builtin_type_field_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' the body of `a_feature' corresponding
			-- to built-in feature 'TYPE.field'.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		local
			l_attribute_type_set: ET_DYNAMIC_TYPE_SET
			l_parameters: ET_ACTUAL_PARAMETER_LIST
			l_arguments: ET_FORMAL_ARGUMENT_LIST
			l_dynamic_type: ET_DYNAMIC_TYPE
			l_queries: ET_DYNAMIC_FEATURE_LIST
			l_attribute: ET_DYNAMIC_FEATURE
			i, nb: INTEGER
		do
			l_arguments := a_feature.arguments
			l_parameters := current_type.base_type.actual_parameters
			if l_parameters = Void or else l_parameters.count < 1 then
					-- Internal error: we should have already checked by now
					-- that class TYPE has a generic parameter.
				set_fatal_error
				error_handler.report_giaaa_error
			elseif l_arguments = Void or else l_arguments.count /= 2 then
					-- Internal error: this error should have been reported by the parser.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				l_dynamic_type := current_dynamic_system.dynamic_type (l_parameters.type (1), current_type.base_type)
				l_queries := l_dynamic_type.queries
				nb := l_dynamic_type.attribute_count
				print_indentation
				current_file.put_string (c_switch)
				current_file.put_character (' ')
				current_file.put_character ('(')
				print_argument_name (l_arguments.formal_argument (1).name, current_file)
				current_file.put_character (')')
				current_file.put_character (' ')
				current_file.put_character ('{')
				current_file.put_new_line
				from i := 1 until i > nb loop
					l_attribute := l_queries.item (i)
					l_attribute_type_set := result_type_set_in_feature (l_attribute)
					print_indentation
					current_file.put_string (c_case)
					current_file.put_character (' ')
					current_file.put_integer (i)
					current_file.put_character (':')
					current_file.put_new_line
					indent
					print_indentation
					print_result_name (current_file)
					current_file.put_character (' ')
					current_file.put_character ('=')
					current_file.put_character (' ')
					print_adapted_expression (agent print_attribute_access (l_attribute, l_arguments.formal_argument (2).name, l_dynamic_type, True), l_attribute_type_set, current_dynamic_system.any_type)
					current_file.put_character (';')
					current_file.put_new_line
					print_indentation
					current_file.put_string (c_break)
					current_file.put_character (';')
					current_file.put_new_line
					dedent
					i := i + 1
				end
				print_indentation
				current_file.put_character ('}')
				current_file.put_new_line
			end
		end

	print_builtin_type_field_count_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'TYPE.field_count'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_parameters: ET_ACTUAL_PARAMETER_LIST
			l_result_type_set: ET_DYNAMIC_TYPE_SET
			l_dynamic_type: ET_DYNAMIC_TYPE
		do
			l_result_type_set := a_feature.result_type_set
			l_parameters := a_target_type.base_type.actual_parameters
			if l_parameters = Void or else l_parameters.count < 1 then
					-- Internal error: we should have already checked by now
					-- that class TYPE has a generic parameter.
				set_fatal_error
				error_handler.report_giaaa_error
			elseif l_result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				print_type_cast (l_result_type_set.static_type, current_file)
				current_file.put_character ('(')
				l_dynamic_type := current_dynamic_system.dynamic_type (l_parameters.type (1), a_target_type.base_type)
				current_file.put_integer (l_dynamic_type.attribute_count)
				current_file.put_character (')')
			end
		end

	print_builtin_type_field_name_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' the body of `a_feature' corresponding
			-- to built-in feature 'TYPE.field_name'.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		local
			l_result_type_set: ET_DYNAMIC_TYPE_SET
			l_parameters: ET_ACTUAL_PARAMETER_LIST
			l_arguments: ET_FORMAL_ARGUMENT_LIST
			l_dynamic_type: ET_DYNAMIC_TYPE
			l_queries: ET_DYNAMIC_FEATURE_LIST
			l_string: STRING
			i, nb: INTEGER
		do
			l_result_type_set := current_feature.result_type_set
			l_arguments := a_feature.arguments
			l_parameters := current_type.base_type.actual_parameters
			if l_parameters = Void or else l_parameters.count < 1 then
					-- Internal error: we should have already checked by now
					-- that class TYPE has a generic parameter.
				set_fatal_error
				error_handler.report_giaaa_error
			elseif l_arguments = Void or else l_arguments.count /= 1 then
					-- Internal error: this error should have been reported by the parser.
				set_fatal_error
				error_handler.report_giaaa_error
			elseif l_result_type_set = Void then
					-- Internal error: `current_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				l_dynamic_type := current_dynamic_system.dynamic_type (l_parameters.type (1), current_type.base_type)
				l_queries := l_dynamic_type.queries
				nb := l_dynamic_type.attribute_count
				print_indentation
				current_file.put_string (c_switch)
				current_file.put_character (' ')
				current_file.put_character ('(')
				print_argument_name (l_arguments.formal_argument (1).name, current_file)
				current_file.put_character (')')
				current_file.put_character (' ')
				current_file.put_character ('{')
				current_file.put_new_line
				from i := 1 until i > nb loop
					print_indentation
					current_file.put_string (c_case)
					current_file.put_character (' ')
					current_file.put_integer (i)
					current_file.put_character (':')
					current_file.put_new_line
					indent
					print_indentation
					print_result_name (current_file)
					current_file.put_character (' ')
					current_file.put_character ('=')
					current_file.put_character (' ')
					l_string := l_queries.item (i).static_feature.lower_name
					if l_result_type_set.static_type = current_dynamic_system.string_32_type then
						current_file.put_string (c_ge_ms32)
					else
						current_file.put_string (c_ge_ms8)
					end
					current_file.put_character ('(')
					print_escaped_string (l_string)
					current_file.put_character (',')
					current_file.put_character (' ')
					current_file.put_integer (l_string.count)
					current_file.put_character (')')
					current_file.put_character (';')
					current_file.put_new_line
					print_indentation
					current_file.put_string (c_break)
					current_file.put_character (';')
					current_file.put_new_line
					dedent
					i := i + 1
				end
				print_indentation
				current_file.put_string (c_default)
				current_file.put_character (':')
				current_file.put_new_line
				indent
				print_indentation
				current_file.put_string ("GE_raise(24);")
				current_file.put_new_line
				dedent
				print_indentation
				current_file.put_character ('}')
				current_file.put_new_line
			end
		end

	print_builtin_type_field_static_type_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' the body of `a_feature' corresponding
			-- to built-in feature 'TYPE.field_static_type'.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		local
			l_parameters: ET_ACTUAL_PARAMETER_LIST
			l_arguments: ET_FORMAL_ARGUMENT_LIST
			l_dynamic_type: ET_DYNAMIC_TYPE
			l_queries: ET_DYNAMIC_FEATURE_LIST
			l_attribute_type: ET_DYNAMIC_TYPE
			l_meta_type: ET_DYNAMIC_TYPE
			i, nb: INTEGER
		do
			l_arguments := a_feature.arguments
			l_parameters := current_type.base_type.actual_parameters
			if l_parameters = Void or else l_parameters.count < 1 then
					-- Internal error: we should have already checked by now
					-- that class TYPE has a generic parameter.
				set_fatal_error
				error_handler.report_giaaa_error
			elseif l_arguments = Void or else l_arguments.count /= 1 then
					-- Internal error: this error should have been reported by the parser.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				l_dynamic_type := current_dynamic_system.dynamic_type (l_parameters.type (1), current_type.base_type)
				l_queries := l_dynamic_type.queries
				nb := l_dynamic_type.attribute_count
				print_indentation
				current_file.put_string (c_switch)
				current_file.put_character (' ')
				current_file.put_character ('(')
				print_argument_name (l_arguments.formal_argument (1).name, current_file)
				current_file.put_character (')')
				current_file.put_character (' ')
				current_file.put_character ('{')
				current_file.put_new_line
				from i := 1 until i > nb loop
					print_indentation
					current_file.put_string (c_case)
					current_file.put_character (' ')
					current_file.put_integer (i)
					current_file.put_character (':')
					current_file.put_new_line
					indent
					l_attribute_type := result_type_set_in_feature (l_queries.item (i)).static_type
					l_meta_type := l_attribute_type.meta_type
					if l_meta_type = Void then
							-- Internal error: the meta type of the types of the attributes should
							-- have been computed when analyzing the dynamic type sets of
							-- `a_feature'.
						set_fatal_error
						error_handler.report_giaaa_error
					else
						print_indentation
						print_result_name (current_file)
						current_file.put_character (' ')
						current_file.put_character ('=')
						current_file.put_character (' ')
						current_file.put_character ('(')
						print_type_declaration (l_meta_type, current_file)
						current_file.put_character (')')
						current_file.put_character ('&')
						current_file.put_character ('(')
						current_file.put_string (c_ge_types)
						current_file.put_character ('[')
						current_file.put_integer (l_attribute_type.id)
						current_file.put_character (']')
						current_file.put_character (')')
						current_file.put_character (';')
						current_file.put_new_line
					end
					print_indentation
					current_file.put_string (c_break)
					current_file.put_character (';')
					current_file.put_new_line
					dedent
					i := i + 1
				end
				print_indentation
				current_file.put_character ('}')
				current_file.put_new_line
			end
		end

	print_builtin_type_field_type_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' the body of `a_feature' corresponding
			-- to built-in feature 'TYPE.field_type'.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		local
			l_parameters: ET_ACTUAL_PARAMETER_LIST
			l_arguments: ET_FORMAL_ARGUMENT_LIST
			l_dynamic_type: ET_DYNAMIC_TYPE
			l_queries: ET_DYNAMIC_FEATURE_LIST
			l_result_type: ET_DYNAMIC_TYPE
			i, nb: INTEGER
		do
			l_arguments := a_feature.arguments
			l_parameters := current_type.base_type.actual_parameters
			if l_parameters = Void or else l_parameters.count < 1 then
					-- Internal error: we should have already checked by now
					-- that class TYPE has a generic parameter.
				set_fatal_error
				error_handler.report_giaaa_error
			elseif l_arguments = Void or else l_arguments.count /= 1 then
					-- Internal error: this error should have been reported by the parser.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				l_dynamic_type := current_dynamic_system.dynamic_type (l_parameters.type (1), current_type.base_type)
				l_queries := l_dynamic_type.queries
				nb := l_dynamic_type.attribute_count
				print_indentation
				current_file.put_string (c_switch)
				current_file.put_character (' ')
				current_file.put_character ('(')
				print_argument_name (l_arguments.formal_argument (1).name, current_file)
				current_file.put_character (')')
				current_file.put_character (' ')
				current_file.put_character ('{')
				current_file.put_new_line
				from i := 1 until i > nb loop
					print_indentation
					current_file.put_string (c_case)
					current_file.put_character (' ')
					current_file.put_integer (i)
					current_file.put_character (':')
					current_file.put_new_line
					indent
					print_indentation
					print_result_name (current_file)
					current_file.put_character (' ')
					current_file.put_character ('=')
					current_file.put_character (' ')
					l_result_type := result_type_set_in_feature (l_queries.item (i)).static_type
					if current_universe_impl.boolean_type.same_named_type (l_result_type.base_type, current_type.base_type, current_type.base_type) then
						current_file.put_integer ({INTERNAL}.boolean_type)
					elseif current_universe_impl.character_8_type.same_named_type (l_result_type.base_type, current_type.base_type, current_type.base_type) then
						current_file.put_integer ({INTERNAL}.character_8_type)
					elseif current_universe_impl.character_32_type.same_named_type (l_result_type.base_type, current_type.base_type, current_type.base_type) then
						current_file.put_integer ({INTERNAL}.character_32_type)
					elseif current_universe_impl.integer_8_type.same_named_type (l_result_type.base_type, current_type.base_type, current_type.base_type) then
						current_file.put_integer ({INTERNAL}.integer_8_type)
					elseif current_universe_impl.integer_16_type.same_named_type (l_result_type.base_type, current_type.base_type, current_type.base_type) then
						current_file.put_integer ({INTERNAL}.integer_16_type)
					elseif current_universe_impl.integer_32_type.same_named_type (l_result_type.base_type, current_type.base_type, current_type.base_type) then
						current_file.put_integer ({INTERNAL}.integer_32_type)
					elseif current_universe_impl.integer_64_type.same_named_type (l_result_type.base_type, current_type.base_type, current_type.base_type) then
						current_file.put_integer ({INTERNAL}.integer_64_type)
					elseif current_universe_impl.natural_8_type.same_named_type (l_result_type.base_type, current_type.base_type, current_type.base_type) then
						current_file.put_integer ({INTERNAL}.natural_8_type)
					elseif current_universe_impl.natural_16_type.same_named_type (l_result_type.base_type, current_type.base_type, current_type.base_type) then
						current_file.put_integer ({INTERNAL}.natural_16_type)
					elseif current_universe_impl.natural_32_type.same_named_type (l_result_type.base_type, current_type.base_type, current_type.base_type) then
						current_file.put_integer ({INTERNAL}.natural_32_type)
					elseif current_universe_impl.natural_64_type.same_named_type (l_result_type.base_type, current_type.base_type, current_type.base_type) then
						current_file.put_integer ({INTERNAL}.natural_64_type)
					elseif current_universe_impl.pointer_type.same_named_type (l_result_type.base_type, current_type.base_type, current_type.base_type) then
						current_file.put_integer ({INTERNAL}.pointer_type)
					elseif current_universe_impl.real_32_type.same_named_type (l_result_type.base_type, current_type.base_type, current_type.base_type) then
						current_file.put_integer ({INTERNAL}.real_32_type)
					elseif current_universe_impl.real_64_type.same_named_type (l_result_type.base_type, current_type.base_type, current_type.base_type) then
						current_file.put_integer ({INTERNAL}.real_64_type)
					elseif current_universe_impl.none_type.same_named_type (l_result_type.base_type, current_type.base_type, current_type.base_type) then
						current_file.put_integer ({INTERNAL}.none_type)
					elseif l_result_type.is_expanded then
						current_file.put_integer ({INTERNAL}.expanded_type)
					else
						current_file.put_integer ({INTERNAL}.reference_type)
					end
					current_file.put_character (';')
					current_file.put_new_line
					print_indentation
					current_file.put_string (c_break)
					current_file.put_character (';')
					current_file.put_new_line
					dedent
					i := i + 1
				end
				print_indentation
				current_file.put_character ('}')
				current_file.put_new_line
			end
		end

	print_builtin_type_generating_type_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' then body of `a_feature' corresponding
			-- to built-in feature 'TYPE.generating_type'.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		do
-- TODO: what to do to avoid having a infinite number of types?
			print_indentation
			current_file.put_string ("GE_raise(24);")
			current_file.put_new_line
		end

	print_builtin_type_generic_parameter_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' the body of `a_feature' corresponding
			-- to built-in feature 'TYPE.generic_parameter'.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		local
			l_parameters: ET_ACTUAL_PARAMETER_LIST
			l_arguments: ET_FORMAL_ARGUMENT_LIST
			l_base_type: ET_BASE_TYPE
			l_type: ET_TYPE
			l_dynamic_type: ET_DYNAMIC_TYPE
			l_meta_type: ET_DYNAMIC_TYPE
			i, nb: INTEGER
		do
			l_arguments := a_feature.arguments
			l_parameters := current_type.base_type.actual_parameters
			if l_parameters = Void or else l_parameters.count < 1 then
					-- Internal error: we should have already checked by now
					-- that class TYPE has a generic parameter.
				set_fatal_error
				error_handler.report_giaaa_error
			elseif l_arguments = Void or else l_arguments.count /= 1 then
					-- Internal error: this error should have been reported by the parser.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				l_base_type := l_parameters.type (1).shallow_base_type (current_type.base_type)
				l_parameters := l_base_type.actual_parameters
				if l_parameters = Void or else l_parameters.is_empty then
					-- Do nothing.
				elseif l_parameters.count = 1 then
					l_type := l_parameters.type (1)
					l_dynamic_type := current_dynamic_system.dynamic_type (l_type, current_type.base_type)
					l_meta_type := l_dynamic_type.meta_type
					if l_meta_type = Void then
							-- Internal error: the meta type of the generic parameter should
							-- have been computed when analyzing the dynamic type sets of
							-- `a_feature'.
						set_fatal_error
						error_handler.report_giaaa_error
					else
						print_indentation
						print_result_name (current_file)
						current_file.put_character (' ')
						current_file.put_character ('=')
						current_file.put_character (' ')
						current_file.put_character ('(')
						print_type_declaration (l_meta_type, current_file)
						current_file.put_character (')')
						current_file.put_character ('&')
						current_file.put_character ('(')
						current_file.put_string (c_ge_types)
						current_file.put_character ('[')
						current_file.put_integer (l_dynamic_type.id)
						current_file.put_character (']')
						current_file.put_character (')')
						current_file.put_character (';')
						current_file.put_new_line
					end
				else
					print_indentation
					current_file.put_string (c_switch)
					current_file.put_character (' ')
					current_file.put_character ('(')
					print_argument_name (l_arguments.formal_argument (1).name, current_file)
					current_file.put_character (')')
					current_file.put_character (' ')
					current_file.put_character ('{')
					current_file.put_new_line
					nb := l_parameters.count
					from i := 1 until i > nb loop
						l_type := l_parameters.type (i)
						l_dynamic_type := current_dynamic_system.dynamic_type (l_type, current_type.base_type)
						l_meta_type := l_dynamic_type.meta_type
						if l_meta_type = Void then
								-- Internal error: the meta type of the generic parameter should
								-- have been computed when analyzing the dynamic type sets of
								-- `a_feature'.
							set_fatal_error
							error_handler.report_giaaa_error
						else
							print_indentation
							current_file.put_string (c_case)
							current_file.put_character (' ')
							current_file.put_integer (i)
							current_file.put_character (':')
							current_file.put_new_line
							indent
							print_indentation
							print_result_name (current_file)
							current_file.put_character (' ')
							current_file.put_character ('=')
							current_file.put_character (' ')
							current_file.put_character ('(')
							print_type_declaration (l_meta_type, current_file)
							current_file.put_character (')')
							current_file.put_character ('&')
							current_file.put_character ('(')
							current_file.put_string (c_ge_types)
							current_file.put_character ('[')
							current_file.put_integer (l_dynamic_type.id)
							current_file.put_character (']')
							current_file.put_character (')')
							current_file.put_character (';')
							current_file.put_new_line
							print_indentation
							current_file.put_string (c_break)
							current_file.put_character (';')
							current_file.put_new_line
							dedent
						end
						i := i + 1
					end
					print_indentation
					current_file.put_string (c_default)
					current_file.put_character (':')
					current_file.put_new_line
					indent
					print_indentation
					current_file.put_string ("GE_raise(24);")
					current_file.put_new_line
					dedent
					print_indentation
					current_file.put_character ('}')
					current_file.put_new_line
				end
			end
		end

	print_builtin_type_generic_parameter_count_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'TYPE.generic_parameter_count'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_base_type: ET_BASE_TYPE
			l_parameters: ET_ACTUAL_PARAMETER_LIST
		do
			l_base_type := a_target_type.base_type
			l_parameters := l_base_type.actual_parameters
			if l_parameters = Void or else l_parameters.count < 1 then
					-- Internal error: we should have already checked by now
					-- that class TYPE has a generic parameter.
				set_fatal_error
				error_handler.report_giaaa_error
			elseif a_feature.result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				print_type_cast (a_feature.result_type_set.static_type, current_file)
				current_file.put_character ('(')
				current_file.put_integer (l_parameters.type (1).base_type_actual_count (l_base_type))
				current_file.put_character (')')
			end
		end

	print_builtin_type_integer_8_field_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' the body of `a_feature' corresponding
			-- to built-in feature 'TYPE.integer_8_field'.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		do
			print_builtin_type_basic_expanded_field_body (a_feature)
		end

	print_builtin_type_integer_16_field_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' the body of `a_feature' corresponding
			-- to built-in feature 'TYPE.integer_16_field'.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		do
			print_builtin_type_basic_expanded_field_body (a_feature)
		end

	print_builtin_type_integer_32_field_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' the body of `a_feature' corresponding
			-- to built-in feature 'TYPE.integer_32_field'.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		do
			print_builtin_type_basic_expanded_field_body (a_feature)
		end

	print_builtin_type_integer_64_field_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' the body of `a_feature' corresponding
			-- to built-in feature 'TYPE.integer_64_field'.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		do
			print_builtin_type_basic_expanded_field_body (a_feature)
		end

	print_builtin_type_is_expanded_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'TYPE.is_expanded'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_parameters: ET_ACTUAL_PARAMETER_LIST
		do
			l_parameters := a_target_type.base_type.actual_parameters
			if l_parameters = Void or else l_parameters.count < 1 then
					-- Internal error: we should have already checked by now
					-- that class TYPE has a generic parameter.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				if l_parameters.type (1).is_type_expanded (a_target_type.base_type) then
					current_file.put_string (c_eif_true)
				else
					current_file.put_string (c_eif_false)
				end
			end
		end

	print_builtin_type_name_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'TYPE.name'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_parameters: ET_ACTUAL_PARAMETER_LIST
			l_string: STRING
			l_result_type_set: ET_DYNAMIC_TYPE_SET
		do
			l_result_type_set := a_feature.result_type_set
			l_parameters := a_target_type.base_type.actual_parameters
			if l_parameters = Void or else l_parameters.count < 1 then
					-- Internal error: we should have already checked by now
					-- that class TYPE has a generic parameter.
				set_fatal_error
				error_handler.report_giaaa_error
			elseif l_result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				l_string := l_parameters.type (1).unaliased_to_text
				if l_result_type_set.static_type = current_dynamic_system.string_32_type then
					current_file.put_string (c_ge_ms32)
				else
					current_file.put_string (c_ge_ms8)
				end
				current_file.put_character ('(')
				print_escaped_string (l_string)
				current_file.put_character (',')
				current_file.put_character (' ')
				current_file.put_integer (l_string.count)
				current_file.put_character (')')
			end
		end

	print_builtin_type_natural_8_field_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' the body of `a_feature' corresponding
			-- to built-in feature 'TYPE.natural_8_field'.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		do
			print_builtin_type_basic_expanded_field_body (a_feature)
		end

	print_builtin_type_natural_16_field_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' the body of `a_feature' corresponding
			-- to built-in feature 'TYPE.natural_16_field'.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		do
			print_builtin_type_basic_expanded_field_body (a_feature)
		end

	print_builtin_type_natural_32_field_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' the body of `a_feature' corresponding
			-- to built-in feature 'TYPE.natural_32_field'.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		do
			print_builtin_type_basic_expanded_field_body (a_feature)
		end

	print_builtin_type_natural_64_field_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' the body of `a_feature' corresponding
			-- to built-in feature 'TYPE.natural_64_field'.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		do
			print_builtin_type_basic_expanded_field_body (a_feature)
		end

	print_builtin_type_pointer_field_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' the body of `a_feature' corresponding
			-- to built-in feature 'TYPE.pointer_field'.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		do
			print_builtin_type_basic_expanded_field_body (a_feature)
		end

	print_builtin_type_real_32_field_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' the body of `a_feature' corresponding
			-- to built-in feature 'TYPE.real_32_field'.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		do
			print_builtin_type_basic_expanded_field_body (a_feature)
		end

	print_builtin_type_real_64_field_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' the body of `a_feature' corresponding
			-- to built-in feature 'TYPE.real_64_field'.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		do
			print_builtin_type_basic_expanded_field_body (a_feature)
		end

	print_builtin_type_runtime_name_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'TYPE.runtime_name'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		local
			l_parameters: ET_ACTUAL_PARAMETER_LIST
			l_string: STRING
			l_result_type_set: ET_DYNAMIC_TYPE_SET
		do
			l_result_type_set := a_feature.result_type_set
			l_parameters := a_target_type.base_type.actual_parameters
			if l_parameters = Void or else l_parameters.count < 1 then
					-- Internal error: we should have already checked by now
					-- that class TYPE has a generic parameter.
				set_fatal_error
				error_handler.report_giaaa_error
			elseif l_result_type_set = Void then
					-- Internal error: `a_feature' is a query.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				l_string := l_parameters.type (1).unaliased_to_text
				if l_result_type_set.static_type = current_dynamic_system.string_32_type then
					current_file.put_string (c_ge_ms32)
				else
					current_file.put_string (c_ge_ms8)
				end
				current_file.put_character ('(')
				print_escaped_string (l_string)
				current_file.put_character (',')
				current_file.put_character (' ')
				current_file.put_integer (l_string.count)
				current_file.put_character (')')
			end
		end

	print_builtin_type_set_basic_expanded_field_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' the body of `a_feature' corresponding
			-- to a built-in feature of class "TYPE" that sets the fields
			-- of basic expanded types.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		local
			l_argument_type: ET_DYNAMIC_TYPE
			l_parameters: ET_ACTUAL_PARAMETER_LIST
			l_arguments: ET_FORMAL_ARGUMENT_LIST
			l_dynamic_type: ET_DYNAMIC_TYPE
			l_queries: ET_DYNAMIC_FEATURE_LIST
			l_attribute: ET_DYNAMIC_FEATURE
			i, nb: INTEGER
		do
			l_arguments := a_feature.arguments
			l_parameters := current_type.base_type.actual_parameters
			if l_parameters = Void or else l_parameters.count < 1 then
					-- Internal error: we should have already checked by now
					-- that class TYPE has a generic parameter.
				set_fatal_error
				error_handler.report_giaaa_error
			elseif l_arguments = Void or else l_arguments.count /= 3 then
					-- Internal error: this error should have been reported by the parser.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				l_argument_type := argument_type_set (3).static_type
				l_dynamic_type := current_dynamic_system.dynamic_type (l_parameters.type (1), current_type.base_type)
				l_queries := l_dynamic_type.queries
				nb := l_dynamic_type.attribute_count
				print_indentation
				current_file.put_string (c_switch)
				current_file.put_character (' ')
				current_file.put_character ('(')
				print_argument_name (l_arguments.formal_argument (1).name, current_file)
				current_file.put_character (')')
				current_file.put_character (' ')
				current_file.put_character ('{')
				current_file.put_new_line
				from i := 1 until i > nb loop
					l_attribute := l_queries.item (i)
					if result_type_set_in_feature (l_attribute).static_type = l_argument_type then
						print_indentation
						current_file.put_string (c_case)
						current_file.put_character (' ')
						current_file.put_integer (i)
						current_file.put_character (':')
						current_file.put_new_line
						indent
						print_indentation
						print_attribute_access (l_attribute, l_arguments.formal_argument (2).name, l_dynamic_type, True)
						current_file.put_character (' ')
						current_file.put_character ('=')
						current_file.put_character (' ')
						print_argument_name (l_arguments.formal_argument (3).name, current_file)
						current_file.put_character (';')
						current_file.put_new_line
						current_file.put_string (c_break)
						current_file.put_character (';')
						current_file.put_new_line
						dedent
					end
					i := i + 1
				end
				print_indentation
				current_file.put_character ('}')
				current_file.put_new_line
			end
		end

	print_builtin_type_set_boolean_field_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' the body of `a_feature' corresponding
			-- to built-in feature 'TYPE.set_boolean_field'.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		do
			print_builtin_type_set_basic_expanded_field_body (a_feature)
		end

	print_builtin_type_set_character_8_field_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' the body of `a_feature' corresponding
			-- to built-in feature 'TYPE.set_character_8_field'.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		do
			print_builtin_type_set_basic_expanded_field_body (a_feature)
		end

	print_builtin_type_set_character_32_field_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' the body of `a_feature' corresponding
			-- to built-in feature 'TYPE.set_character_32_field'.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		do
			print_builtin_type_set_basic_expanded_field_body (a_feature)
		end

	print_builtin_type_set_integer_8_field_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' the body of `a_feature' corresponding
			-- to built-in feature 'TYPE.set_integer_8_field'.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		do
			print_builtin_type_set_basic_expanded_field_body (a_feature)
		end

	print_builtin_type_set_integer_16_field_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' the body of `a_feature' corresponding
			-- to built-in feature 'TYPE.set_integer_16_field'.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		do
			print_builtin_type_set_basic_expanded_field_body (a_feature)
		end

	print_builtin_type_set_integer_32_field_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' the body of `a_feature' corresponding
			-- to built-in feature 'TYPE.set_integer_32_field'.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		do
			print_builtin_type_set_basic_expanded_field_body (a_feature)
		end

	print_builtin_type_set_integer_64_field_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' the body of `a_feature' corresponding
			-- to built-in feature 'TYPE.set_integer_64_field'.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		do
			print_builtin_type_set_basic_expanded_field_body (a_feature)
		end

	print_builtin_type_set_natural_8_field_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' the body of `a_feature' corresponding
			-- to built-in feature 'TYPE.set_natural_8_field'.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		do
			print_builtin_type_set_basic_expanded_field_body (a_feature)
		end

	print_builtin_type_set_natural_16_field_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' the body of `a_feature' corresponding
			-- to built-in feature 'TYPE.set_natural_16_field'.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		do
			print_builtin_type_set_basic_expanded_field_body (a_feature)
		end

	print_builtin_type_set_natural_32_field_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' the body of `a_feature' corresponding
			-- to built-in feature 'TYPE.set_natural_32_field'.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		do
			print_builtin_type_set_basic_expanded_field_body (a_feature)
		end

	print_builtin_type_set_natural_64_field_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' the body of `a_feature' corresponding
			-- to built-in feature 'TYPE.set_natural_64_field'.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		do
			print_builtin_type_set_basic_expanded_field_body (a_feature)
		end

	print_builtin_type_set_pointer_field_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' the body of `a_feature' corresponding
			-- to built-in feature 'TYPE.set_pointer_field'.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		do
			print_builtin_type_set_basic_expanded_field_body (a_feature)
		end

	print_builtin_type_set_real_32_field_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' the body of `a_feature' corresponding
			-- to built-in feature 'TYPE.set_real_32_field'.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		do
			print_builtin_type_set_basic_expanded_field_body (a_feature)
		end

	print_builtin_type_set_real_64_field_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' the body of `a_feature' corresponding
			-- to built-in feature 'TYPE.set_real_64_field'.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		do
			print_builtin_type_set_basic_expanded_field_body (a_feature)
		end

	print_builtin_type_set_reference_field_body (a_feature: ET_EXTERNAL_ROUTINE)
			-- Print to `current_file' the body of `a_feature' corresponding
			-- to built-in feature 'TYPE.set_reference_field'.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
		local
			l_attribute_type_set: ET_DYNAMIC_TYPE_SET
			l_attribute_type: ET_DYNAMIC_TYPE
			l_argument_type_set: ET_DYNAMIC_TYPE_SET
			l_parameters: ET_ACTUAL_PARAMETER_LIST
			l_arguments: ET_FORMAL_ARGUMENT_LIST
			l_dynamic_type: ET_DYNAMIC_TYPE
			l_queries: ET_DYNAMIC_FEATURE_LIST
			l_attribute: ET_DYNAMIC_FEATURE
			l_argument: ET_IDENTIFIER
			i, nb: INTEGER
		do
			l_arguments := a_feature.arguments
			l_parameters := current_type.base_type.actual_parameters
			if l_parameters = Void or else l_parameters.count < 1 then
					-- Internal error: we should have already checked by now
					-- that class TYPE has a generic parameter.
				set_fatal_error
				error_handler.report_giaaa_error
			elseif l_arguments = Void or else l_arguments.count /= 3 then
					-- Internal error: this error should have been reported by the parser.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				l_argument := l_arguments.formal_argument (3).name
				l_argument_type_set := argument_type_set (3)
				l_dynamic_type := current_dynamic_system.dynamic_type (l_parameters.type (1), current_type.base_type)
				l_queries := l_dynamic_type.queries
				nb := l_dynamic_type.attribute_count
				print_indentation
				current_file.put_string (c_switch)
				current_file.put_character (' ')
				current_file.put_character ('(')
				print_argument_name (l_arguments.formal_argument (1).name, current_file)
				current_file.put_character (')')
				current_file.put_character (' ')
				current_file.put_character ('{')
				current_file.put_new_line
				from i := 1 until i > nb loop
					l_attribute := l_queries.item (i)
					l_attribute_type_set := result_type_set_in_feature (l_attribute)
					l_attribute_type := l_attribute_type_set.static_type
					if not l_attribute_type.is_expanded or else not l_attribute_type.is_basic then
						print_indentation
						current_file.put_string (c_case)
						current_file.put_character (' ')
						current_file.put_integer (i)
						current_file.put_character (':')
						current_file.put_new_line
						indent
						print_indentation
						print_attribute_access (l_attribute, l_arguments.formal_argument (2).name, l_dynamic_type, True)
						current_file.put_character (' ')
						current_file.put_character ('=')
						current_file.put_character (' ')
-- TODO: Using `print_attachment_expression' may trigger a call to 'copy'. We should avoid that.
-- Use `print_attachment_expression' anyway here so that there is no object of the wrong type
-- assigned to the attribute (this is forbidden by the preconditions, but we should not let them
-- go through when preconditions are turn off for example).
						print_attachment_expression (l_argument, l_argument_type_set, l_attribute_type)
						current_file.put_character (';')
						current_file.put_new_line
						current_file.put_new_line
						current_file.put_string (c_break)
						current_file.put_character (';')
						current_file.put_new_line
						dedent
					end
					i := i + 1
				end
				print_indentation
				current_file.put_character ('}')
				current_file.put_new_line
			end
		end

	print_builtin_type_type_id_call (a_feature: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_check_void_target: BOOLEAN)
			-- Print to `current_file' a call (static binding) to `a_feature'
			-- corresponding to built-in feature 'TYPE.type_id'.
			-- `a_target_type' is the dynamic type of the target.
			-- `a_check_void_target' means that we need to check whether the target is Void or not.
			-- Operands can be found in `call_operands'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_type_not_void: a_target_type /= Void
			call_operands_not_empty: not call_operands.is_empty
		do
			current_file.put_character ('(')
			current_file.put_character ('(')
			current_file.put_string (c_eif_type)
			current_file.put_character ('*')
			current_file.put_character (')')
			current_file.put_character ('(')
			print_expression (call_operands.first)
			current_file.put_character (')')
			current_file.put_character (')')
			current_file.put_string (c_arrow)
			current_file.put_string (c_type_id)
		end

feature {NONE} -- C function generation

	print_main_function
			-- Print 'main' function to `current_file'.
		local
			l_root_type: ET_DYNAMIC_TYPE
			l_root_creation_procedure: ET_DYNAMIC_FEATURE
			l_root_creation: ET_CREATE_EXPRESSION
			l_root_call: ET_QUALIFIED_CALL
			l_temp: ET_IDENTIFIER
			old_call_info: STRING
		do
			old_call_info := current_call_info
			current_file.put_line ("int main(int argc, char** argv)")
			current_file.put_character ('{')
			current_file.put_new_line
			l_root_type := current_dynamic_system.root_type
			l_root_creation_procedure := current_dynamic_system.root_creation_procedure
			if l_root_type /= Void and l_root_creation_procedure /= Void then
				indent
				if exception_trace_mode then
						-- There is no caller for the root creation procedure.
						-- Hence a null pointer.
					current_call_info := "0"
				end
				print_indentation
				print_type_declaration (l_root_type, current_file)
				current_file.put_character (' ')
				l_temp := temp_variable
				print_temp_name (l_temp, current_file)
				current_file.put_character (';')
				current_file.put_new_line
-- EDP GC Mods vvv
				if use_edp_gc then
					print_indentation
					current_file.put_line ("void *stack_base;")
					print_indentation
					current_file.put_line ("stack_bottom = &stack_base;")
				end
-- EDP GC Mods ^^^
				print_indentation
				current_file.put_line ("GE_argc = argc;")
				print_indentation
				current_file.put_line ("GE_argv = argv;")
				print_indentation
				current_file.put_line ("GE_set_rescue(NULL);")	-- EDP
				print_indentation
				current_file.put_line ("GE_init_gc();")
				print_indentation
				current_file.put_line ("GE_init_identified();")
				print_indentation
				current_file.put_line ("GE_const_init();")
					-- Initialize variable used in WEL.
				include_runtime_header_file ("eif_main.h", False, header_file)
				current_file.put_string (c_ifdef)
				current_file.put_character (' ')
				current_file.put_line (c_eif_windows)
				print_indentation
				current_file.put_line ("eif_hInstance = GetModuleHandle(NULL);")
				current_file.put_line (c_endif)
				if trace_mode then
						-- We need to make sure that a DOS console is available (for
						-- Windows application) when in trace mode, because information
						-- will be displayed to the console.
					current_file.put_string (c_ifdef)
					current_file.put_character (' ')
					current_file.put_line (c_eif_trace)
					print_show_console_call
					current_file.put_line (c_endif)
				end
-- EDP GC Mods vvv
				if use_edp_gc then
						-- The GC recorded root object is the 'first' created,
						-- except that the 'constant' objects are created
						-- in GE_const_init() before the root object ...
					print_indentation
					current_file.put_line ("gc__root_object = NULL;")
				end
-- EDP GC Mods ^^^
					-- Create root object.
				print_indentation
				print_temp_name (l_temp, current_file)
				current_file.put_character (' ')
				current_file.put_character ('=')
				current_file.put_character (' ')
				create l_root_call.make (l_root_creation_procedure.static_feature.name, Void)
				l_root_call.name.set_seed (l_root_creation_procedure.static_feature.first_seed)
				create l_root_creation.make (l_root_type.base_type, l_root_call)
					-- Prepare dynamic type sets of the root creation expression.
				extra_dynamic_type_sets.force_last (l_root_type)
				l_root_creation.set_index (current_dynamic_type_sets.count + extra_dynamic_type_sets.count)
				print_creation_expression (l_root_creation)
					-- Clean up.
				extra_dynamic_type_sets.remove_last
				current_file.put_character (';')
				current_file.put_new_line
				print_indentation
				current_file.put_string (c_return)
				current_file.put_character (' ')
				current_file.put_character ('0')
				current_file.put_character (';')
				current_file.put_new_line
				dedent
			end
			current_file.put_character ('}')
			current_file.put_new_line
			current_call_info := old_call_info
		end

	print_manifest_string_8_function
			-- Print 'GE_ms8' function to `current_file' and its signature to `header_file'.
			-- 'GE_ms8' is used to create manifest strings of type "STRING_8".
		local
			l_string_type: ET_DYNAMIC_TYPE
			l_area_type: ET_DYNAMIC_TYPE
			l_count_type: ET_DYNAMIC_TYPE
			l_temp: ET_IDENTIFIER
			l_queries: ET_DYNAMIC_FEATURE_LIST
			old_file: KI_TEXT_OUTPUT_STREAM
			l_dynamic_type_set: ET_DYNAMIC_TYPE_SET
		do
			l_string_type := current_dynamic_system.string_8_type
			l_area_type := current_dynamic_system.special_character_8_type
			if l_string_type.attribute_count < 2 then
					-- Internal error: class "STRING" should have at least the
					-- features 'area' and 'count' as first features.
					-- Already reported in ET_DYNAMIC_SYSTEM.compile_kernel.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				l_dynamic_type_set := l_string_type.queries.item (2).result_type_set
				if l_dynamic_type_set = Void then
						-- Error in feature 'count', already reported in ET_DYNAMIC_SYSTEM.compile_kernel.
					set_fatal_error
					error_handler.report_giaaa_error
					l_count_type := current_dynamic_system.integer_32_type
				else
					l_count_type := l_dynamic_type_set.static_type
				end
			end
				-- Print signature to `header_file' and `current_file'.
			old_file := current_file
			current_file := current_function_header_buffer
			header_file.put_string (c_extern)
			header_file.put_character (' ')
			print_type_declaration (l_string_type, header_file)
			print_type_declaration (l_string_type, current_file)
			header_file.put_character (' ')
			current_file.put_character (' ')
			header_file.put_string (c_ge_ms8)
			current_file.put_string (c_ge_ms8)
			header_file.put_string ("(char* s, ")
			current_file.put_string ("(char* s, ")
			print_type_declaration (l_count_type, header_file)
			print_type_declaration (l_count_type, current_file)
			header_file.put_character (' ')
			current_file.put_character (' ')
			header_file.put_character ('c')
			current_file.put_character ('c')
			header_file.put_character (')')
			current_file.put_character (')')
			header_file.put_character (';')
			header_file.put_new_line
			current_file.put_new_line
				-- Print body to `current_file'.
			current_file.put_character ('{')
			current_file.put_new_line
			indent
			print_indentation
			print_type_declaration (l_string_type, current_file)
			current_file.put_character (' ')
			print_result_name (current_file)
			current_file.put_character (';')
			current_file.put_new_line
			current_file := current_function_body_buffer
			if l_string_type.is_alive then
				l_temp := new_temp_variable (l_area_type)
					-- Create 'area'.
				print_indentation
				print_temp_name (l_temp, current_file)
				current_file.put_character (' ')
				current_file.put_character ('=')
				current_file.put_character (' ')
				current_file.put_string (c_ge_new)
				current_file.put_integer (l_area_type.id)
				current_file.put_character ('(')
				current_file.put_character ('c')
				current_file.put_character ('+')
				current_file.put_character ('1')
				current_file.put_character (',')
				current_file.put_character (' ')
				current_file.put_string (c_eif_false)
				current_file.put_character (')')
				current_file.put_character (';')
				current_file.put_new_line
					-- Default initialization of header part of 'area'.
				print_indentation
				current_file.put_character ('*')
				print_type_cast (l_area_type, current_file)
				print_temp_name (l_temp, current_file)
				current_file.put_character (' ')
				current_file.put_character ('=')
				current_file.put_character (' ')
				print_default_name (l_area_type, current_file)
				current_file.put_character (';')
				current_file.put_new_line
					-- Set 'count' of 'area'.
				print_indentation
				print_attribute_special_count_access (l_temp, l_area_type, False)
				current_file.put_character (' ')
				current_file.put_character ('=')
				current_file.put_character (' ')
				current_file.put_character ('(')
				current_file.put_character ('c')
				current_file.put_character ('+')
				current_file.put_character ('1')
				current_file.put_character (')')
				current_file.put_character (';')
				current_file.put_new_line
					-- Copy characters to 'area'.
				print_indentation
				current_file.put_string (c_memcpy)
				current_file.put_character ('(')
				print_attribute_special_item_access (l_temp, l_area_type, False)
				current_file.put_line (", s, c);")
					-- Don't forget terminating null character.
				current_file.put_string (c_ifndef)
				current_file.put_character (' ')
				current_file.put_line (c_ge_alloc_atomic_cleared)
				print_indentation
				print_attribute_special_item_access (l_temp, l_area_type, False)
				current_file.put_character ('[')
				current_file.put_character ('c')
				current_file.put_character (']')
				current_file.put_character (' ')
				current_file.put_character ('=')
				current_file.put_character (' ')
				current_file.put_character ('%'')
				current_file.put_character ('\')
				current_file.put_character ('0')
				current_file.put_character ('%'')
				current_file.put_character (';')
				current_file.put_new_line
				current_file.put_line (c_endif)
					-- Create string object.
				print_indentation
				print_result_name (current_file)
				current_file.put_character (' ')
				current_file.put_character ('=')
				current_file.put_character (' ')
				current_file.put_string (c_ge_new)
				current_file.put_integer (l_string_type.id)
				current_file.put_character ('(')
				current_file.put_string (c_eif_true)
				current_file.put_character (')')
				current_file.put_character (';')
				current_file.put_new_line
				if l_string_type.attribute_count < 2 then
						-- Internal error: the "STRING_8" type should have at least
						-- the attributes 'area' and 'count' as first features.
					set_fatal_error
					error_handler.report_giaaa_error
				else
					l_queries := l_string_type.queries
						-- Set 'area'.
					print_indentation
					print_attribute_access (l_queries.first, tokens.result_keyword, l_string_type, False)
					current_file.put_character (' ')
					current_file.put_character ('=')
					current_file.put_character (' ')
					print_temp_name (l_temp, current_file)
					current_file.put_character (';')
					current_file.put_new_line
						-- Set 'count'.
					print_indentation
					print_attribute_access (l_queries.item (2), tokens.result_keyword, l_string_type, False)
					current_file.put_character (' ')
					current_file.put_character ('=')
					current_file.put_character (' ')
					print_type_cast (l_count_type, current_file)
					current_file.put_character ('c')
					current_file.put_character (';')
					current_file.put_new_line
				end
				mark_temp_variable_free (l_temp)
			else
				print_indentation
				print_result_name (current_file)
				current_file.put_character (' ')
				current_file.put_character ('=')
				current_file.put_character (' ')
				current_file.put_string (c_eif_void)
				current_file.put_character (';')
				current_file.put_new_line
			end
				-- Return the string.
			print_indentation
			current_file.put_string (c_return)
			current_file.put_character (' ')
			print_result_name (current_file)
			current_file.put_character (';')
			current_file.put_new_line
			dedent
			current_file.put_character ('}')
			current_file.put_new_line
			current_file := old_file
			reset_temp_variables
		end

	print_manifest_string_32_function
			-- Print 'GE_ms32' function to `current_file' and its signature to `header_file'.
			-- 'GE_ms32' is used to create manifest strings of type "STRING_32".
		local
			l_string_type: ET_DYNAMIC_TYPE
			l_area_type: ET_DYNAMIC_TYPE
			l_count_type: ET_DYNAMIC_TYPE
			l_temp: ET_IDENTIFIER
			l_index: ET_IDENTIFIER
			l_queries: ET_DYNAMIC_FEATURE_LIST
			l_character_type: ET_DYNAMIC_TYPE
			old_file: KI_TEXT_OUTPUT_STREAM
			l_dynamic_type_set: ET_DYNAMIC_TYPE_SET
		do
			l_string_type := current_dynamic_system.string_32_type
			l_area_type := current_dynamic_system.special_character_32_type
			l_character_type := current_dynamic_system.character_32_type
			if l_string_type.attribute_count < 2 then
					-- Internal error: class "STRING" should have at least the
					-- features 'area' and 'count' as first features.
					-- Already reported in ET_DYNAMIC_SYSTEM.compile_kernel.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				l_dynamic_type_set := l_string_type.queries.item (2).result_type_set
				if l_dynamic_type_set = Void then
						-- Error in feature 'count', already reported in ET_DYNAMIC_SYSTEM.compile_kernel.
					set_fatal_error
					error_handler.report_giaaa_error
					l_count_type := current_dynamic_system.integer_32_type
				else
					l_count_type := l_dynamic_type_set.static_type
				end
			end
				-- Print signature to `header_file' and `current_file'.
			old_file := current_file
			current_file := current_function_header_buffer
			header_file.put_string (c_extern)
			header_file.put_character (' ')
			print_type_declaration (l_string_type, header_file)
			print_type_declaration (l_string_type, current_file)
			header_file.put_character (' ')
			current_file.put_character (' ')
			header_file.put_string (c_ge_ms32)
			current_file.put_string (c_ge_ms32)
			header_file.put_string ("(char* s, ")
			current_file.put_string ("(char* s, ")
			print_type_declaration (l_count_type, header_file)
			print_type_declaration (l_count_type, current_file)
			header_file.put_character (' ')
			current_file.put_character (' ')
			header_file.put_character ('c')
			current_file.put_character ('c')
			header_file.put_character (')')
			current_file.put_character (')')
			header_file.put_character (';')
			header_file.put_new_line
			current_file.put_new_line
				-- Print body to `current_file'.
			current_file.put_character ('{')
			current_file.put_new_line
			indent
			print_indentation
			print_type_declaration (l_string_type, current_file)
			current_file.put_character (' ')
			print_result_name (current_file)
			current_file.put_character (';')
			current_file.put_new_line
			current_file := current_function_body_buffer
			if l_string_type.is_alive then
				l_temp := new_temp_variable (l_area_type)
					-- Create 'area'.
				print_indentation
				print_temp_name (l_temp, current_file)
				current_file.put_character (' ')
				current_file.put_character ('=')
				current_file.put_character (' ')
				current_file.put_string (c_ge_new)
				current_file.put_integer (l_area_type.id)
				current_file.put_character ('(')
				current_file.put_character ('c')
				current_file.put_character ('+')
				current_file.put_character ('1')
				current_file.put_character (',')
				current_file.put_character (' ')
				current_file.put_string (c_eif_false)
				current_file.put_character (')')
				current_file.put_character (';')
				current_file.put_new_line
					-- Default initialization of header part of 'area'.
				print_indentation
				current_file.put_character ('*')
				print_type_cast (l_area_type, current_file)
				print_temp_name (l_temp, current_file)
				current_file.put_character (' ')
				current_file.put_character ('=')
				current_file.put_character (' ')
				print_default_name (l_area_type, current_file)
				current_file.put_character (';')
				current_file.put_new_line
					-- Set 'count' of 'area'.
				print_indentation
				print_attribute_special_count_access (l_temp, l_area_type, False)
				current_file.put_character (' ')
				current_file.put_character ('=')
				current_file.put_character (' ')
				current_file.put_character ('(')
				current_file.put_character ('c')
				current_file.put_character ('+')
				current_file.put_character ('1')
				current_file.put_character (')')
				current_file.put_character (';')
				current_file.put_new_line
					-- Copy characters to 'area'.
				l_index := new_temp_variable (l_count_type)
				print_indentation
				current_file.put_string (c_for)
				current_file.put_character (' ')
				current_file.put_character ('(')
				print_temp_name (l_index, current_file)
				current_file.put_character (' ')
				current_file.put_character ('=')
				current_file.put_character (' ')
				current_file.put_character ('0')
				current_file.put_character (';')
				current_file.put_character (' ')
				print_temp_name (l_index, current_file)
				current_file.put_character (' ')
				current_file.put_character ('<')
				current_file.put_character (' ')
				current_file.put_character ('c')
				current_file.put_character (';')
				current_file.put_character (' ')
				print_temp_name (l_index, current_file)
				current_file.put_character ('+')
				current_file.put_character ('+')
				current_file.put_character (')')
				current_file.put_character (' ')
				current_file.put_character ('{')
				current_file.put_new_line
				indent
				print_indentation
				print_attribute_special_item_access (l_temp, l_area_type, False)
				current_file.put_character ('[')
				print_temp_name (l_index, current_file)
				current_file.put_character (']')
				current_file.put_character (' ')
				current_file.put_character ('=')
				current_file.put_character (' ')
				print_type_cast (l_character_type, current_file)
				current_file.put_character ('(')
				current_file.put_character ('s')
				current_file.put_character ('[')
				print_temp_name (l_index, current_file)
				current_file.put_character (']')
				current_file.put_character (')')
				current_file.put_character (';')
				current_file.put_new_line
				dedent
				print_indentation
				current_file.put_character ('}')
				current_file.put_new_line
				mark_temp_variable_free (l_index)
					-- Don't forget terminating null character.
				current_file.put_string (c_ifndef)
				current_file.put_character (' ')
				current_file.put_line (c_ge_alloc_atomic_cleared)
				print_indentation
				print_attribute_special_item_access (l_temp, l_area_type, False)
				current_file.put_character ('[')
				current_file.put_character ('c')
				current_file.put_character (']')
				current_file.put_character (' ')
				current_file.put_character ('=')
				current_file.put_character (' ')
				print_type_cast (l_character_type, current_file)
				current_file.put_character ('%'')
				current_file.put_character ('\')
				current_file.put_character ('0')
				current_file.put_character ('%'')
				current_file.put_character (';')
				current_file.put_new_line
				current_file.put_line (c_endif)
					-- Create string object.
				print_indentation
				print_result_name (current_file)
				current_file.put_character (' ')
				current_file.put_character ('=')
				current_file.put_character (' ')
				current_file.put_string (c_ge_new)
				current_file.put_integer (l_string_type.id)
				current_file.put_character ('(')
				current_file.put_string (c_eif_true)
				current_file.put_character (')')
				current_file.put_character (';')
				current_file.put_new_line
				if l_string_type.attribute_count < 2 then
						-- Internal error: the "STRING_32" type should have at least
						-- the attributes 'area' and 'count' as first features.
					set_fatal_error
					error_handler.report_giaaa_error
				else
					l_queries := l_string_type.queries
						-- Set 'area'.
					print_indentation
					print_attribute_access (l_queries.first, tokens.result_keyword, l_string_type, False)
					current_file.put_character (' ')
					current_file.put_character ('=')
					current_file.put_character (' ')
					print_temp_name (l_temp, current_file)
					current_file.put_character (';')
					current_file.put_new_line
						-- Set 'count'.
					print_indentation
					print_attribute_access (l_queries.item (2), tokens.result_keyword, l_string_type, False)
					current_file.put_character (' ')
					current_file.put_character ('=')
					current_file.put_character (' ')
					print_type_cast (l_count_type, current_file)
					current_file.put_character ('c')
					current_file.put_character (';')
					current_file.put_new_line
				end
				mark_temp_variable_free (l_temp)
			else
				print_indentation
				print_result_name (current_file)
				current_file.put_character (' ')
				current_file.put_character ('=')
				current_file.put_character (' ')
				current_file.put_string (c_eif_void)
				current_file.put_character (';')
				current_file.put_new_line
			end
				-- Return the string.
			print_indentation
			current_file.put_string (c_return)
			current_file.put_character (' ')
			print_result_name (current_file)
			current_file.put_character (';')
			current_file.put_new_line
			dedent
			current_file.put_character ('}')
			current_file.put_new_line
			current_file := old_file
			reset_temp_variables
		end

-- GC TODO: Manifest Array routines; Make gc markable ...

	print_manifest_array_function (an_array_type: ET_DYNAMIC_TYPE)
			-- Print 'GE_ma' function to `current_file' and its signature to `header_file'.
			-- 'GE_ma<type-id>' is used to create manifest arrays of type 'type-id'.
		require
			an_array_type_not_void: an_array_type /= Void
		local
			l_queries: ET_DYNAMIC_FEATURE_LIST
			l_dynamic_type_set: ET_DYNAMIC_TYPE_SET
			l_special_type: ET_DYNAMIC_SPECIAL_TYPE
			l_integer_type: ET_DYNAMIC_TYPE
			l_item_type: ET_DYNAMIC_TYPE
			l_temp: ET_IDENTIFIER
		do
			l_queries := an_array_type.queries
			if an_array_type.attribute_count < 3 then
					-- Internal error: class "ARRAY" should have at least the
					-- features 'area', 'lower' and 'upper' as first features.
					-- Already reported in ET_DYNAMIC_SYSTEM.compile_kernel.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				l_dynamic_type_set := l_queries.first.result_type_set
				if l_dynamic_type_set = Void then
						-- Error in feature 'area', already reported in ET_DYNAMIC_SYSTEM.compile_kernel.
					set_fatal_error
					error_handler.report_giaaa_error
				else
					l_special_type ?= l_dynamic_type_set.static_type
					if l_special_type = Void then
							-- Internal error: it has already been checked in ET_DYNAMIC_SYSTEM.compile_kernel
							-- that the attribute `area' is of SPECIAL type.
						set_fatal_error
						error_handler.report_giaaa_error
					end
				end
				l_dynamic_type_set := l_queries.item (3).result_type_set
				if l_dynamic_type_set = Void then
						-- Error in feature 'upper', already reported in ET_DYNAMIC_SYSTEM.compile_kernel.
					set_fatal_error
					error_handler.report_giaaa_error
					l_special_type := Void
				else
					l_integer_type := l_dynamic_type_set.static_type
				end
			end
			if l_special_type /= Void then
				l_item_type := l_special_type.item_type_set.static_type
					-- Print signature to `header_file' and `current_file'.
				header_file.put_string (c_extern)
				header_file.put_character (' ')
				print_type_declaration (an_array_type, header_file)
				print_type_declaration (an_array_type, current_file)
				header_file.put_character (' ')
				current_file.put_character (' ')
				header_file.put_string (c_ge_ma)
				current_file.put_string (c_ge_ma)
				header_file.put_integer (an_array_type.id)
				current_file.put_integer (an_array_type.id)
					-- Use varargs rather than inlining the code, this
					-- makes the C compilation with the -O2 faster and
					-- the resulting application is not slower.
				header_file.put_character ('(')
				print_type_declaration (l_integer_type, header_file)
				header_file.put_string (" c, ")
				print_type_declaration (l_integer_type, header_file)
				header_file.put_string (" n, ...)")
				current_file.put_character ('(')
				print_type_declaration (l_integer_type, current_file)
				current_file.put_string (" c, ")
				print_type_declaration (l_integer_type, current_file)
				current_file.put_string (" n, ...)")
				header_file.put_character (';')
				header_file.put_new_line
				current_file.put_new_line
					-- Print body to `current_file'.
				current_file.put_character ('{')
				current_file.put_new_line
				indent
				print_indentation
				print_type_declaration (an_array_type, current_file)
				current_file.put_character (' ')
				print_result_name (current_file)
				current_file.put_character (';')
				current_file.put_new_line
				l_temp := temp_variable
				print_indentation
				print_type_declaration (l_special_type, current_file)
				current_file.put_character (' ')
				print_temp_name (l_temp, current_file)
				current_file.put_character (';')
				current_file.put_new_line
					-- Create 'area'.
				print_indentation
				print_temp_name (l_temp, current_file)
				current_file.put_character (' ')
				current_file.put_character ('=')
				current_file.put_character (' ')
				current_file.put_string (c_ge_new)
				current_file.put_integer (l_special_type.id)
				current_file.put_character ('(')
				current_file.put_character ('c')
				current_file.put_character (',')
				current_file.put_character (' ')
				current_file.put_string (c_eif_false)
				current_file.put_character (')')
				current_file.put_character (';')
				current_file.put_new_line
					-- Default initialization of header part of 'area'.
				print_indentation
				current_file.put_character ('*')
				print_type_cast (l_special_type, current_file)
				print_temp_name (l_temp, current_file)
				current_file.put_character (' ')
				current_file.put_character ('=')
				current_file.put_character (' ')
				print_default_name (l_special_type, current_file)
				current_file.put_character (';')
				current_file.put_new_line
					-- Set 'count' of 'area'.
				print_indentation
				print_attribute_special_count_access (l_temp, l_special_type, False)
				current_file.put_character (' ')
				current_file.put_character ('=')
				current_file.put_character (' ')
				current_file.put_character ('c')
				current_file.put_character (';')
				current_file.put_new_line
					-- Copy items to 'area'.
				print_indentation
				current_file.put_line ("if (n!=0) {")
				indent
				print_indentation
				current_file.put_line ("va_list v;")
				print_indentation
				print_type_declaration (l_integer_type, current_file)
				current_file.put_line (" j = n;")
				print_indentation
				print_type_declaration (l_item_type, current_file)
				current_file.put_character (' ')
				current_file.put_character ('*')
				current_file.put_character ('i')
				current_file.put_character (' ')
				current_file.put_character ('=')
				current_file.put_character (' ')
				print_attribute_special_item_access (l_temp, l_special_type, False)
				current_file.put_character (';')
				current_file.put_new_line
				print_indentation
				current_file.put_line ("va_start(v, n);")
				print_indentation
				current_file.put_line ("while (j--) {")
				indent
				print_indentation
				if
					l_item_type = current_dynamic_system.boolean_type or
					l_item_type = current_dynamic_system.character_8_type or
					l_item_type = current_dynamic_system.integer_8_type or
					l_item_type = current_dynamic_system.natural_8_type or
					l_item_type = current_dynamic_system.integer_16_type or
					l_item_type = current_dynamic_system.natural_16_type
				then
						-- ISO C 99 says that through "..." the types are promoted to
						-- 'int', and that promotion to 'int' leaves the type unchanged
						-- if all values cannot be represented with an 'int' or
						-- 'unsigned int'.
					current_file.put_string ("*(i++) = ")
					print_type_cast (l_item_type, current_file)
					current_file.put_string ("va_arg(v, int")
				elseif
					l_item_type = current_dynamic_system.real_32_type
				then
						-- ISO C 99 says that 'float' is promoted to 'double' when
						-- passed as argument of a function.
					current_file.put_string ("*(i++) = ")
					print_type_cast (l_item_type, current_file)
					current_file.put_string ("va_arg(v, double")
				else
					current_file.put_string ("*(i++) = va_arg(v, ")
					print_type_declaration (l_item_type, current_file)
				end
				current_file.put_character (')')
				current_file.put_character (';')
				current_file.put_new_line
				dedent
				print_indentation
				current_file.put_character ('}')
				current_file.put_new_line
				print_indentation
				current_file.put_line ("va_end(v);")
				dedent
				print_indentation
				current_file.put_character ('}')
				current_file.put_new_line
					-- Create array object.
				print_indentation
				print_result_name (current_file)
				current_file.put_character (' ')
				current_file.put_character ('=')
				current_file.put_character (' ')
				current_file.put_string (c_ge_new)
				current_file.put_integer (an_array_type.id)
				current_file.put_character ('(')
				current_file.put_string (c_eif_true)
				current_file.put_character (')')
				current_file.put_character (';')
				current_file.put_new_line
					-- Set 'area'.
				print_indentation
				print_attribute_access (l_queries.first, tokens.result_keyword, an_array_type, False)
				current_file.put_character (' ')
				current_file.put_character ('=')
				current_file.put_character (' ')
				print_temp_name (l_temp, current_file)
				current_file.put_character (';')
				current_file.put_new_line
					-- Set 'lower'.
				print_indentation
				print_attribute_access (l_queries.item (2), tokens.result_keyword, an_array_type, False)
				current_file.put_character (' ')
				current_file.put_character ('=')
				current_file.put_character (' ')
				current_file.put_character ('1')
				current_file.put_character (';')
				current_file.put_new_line
					-- Set 'upper'.
				print_indentation
				print_attribute_access (l_queries.item (3), tokens.result_keyword, an_array_type, False)
				current_file.put_character (' ')
				current_file.put_character ('=')
				current_file.put_character (' ')
				current_file.put_character ('c')
				current_file.put_character (';')
				current_file.put_new_line
					-- Return the array.
				print_indentation
				current_file.put_string (c_return)
				current_file.put_character (' ')
				print_result_name (current_file)
				current_file.put_character (';')
				current_file.put_new_line
				dedent
				current_file.put_character ('}')
				current_file.put_new_line
			end
		end

-- GC TODO: Manifest Array routines; Make gc markable ...

	print_big_manifest_array_function (an_array_type: ET_DYNAMIC_TYPE)
			-- Print 'GE_bma' function to `current_file' and its signature to `header_file'.
			-- 'GE_bma<type-id>' is used to create big manifest arrays of type 'type-id'.
			-- "Big" means more elements than the number of function arguments that the
			-- underlying C compiler can support.
		require
			an_array_type_not_void: an_array_type /= Void
		local
			l_queries: ET_DYNAMIC_FEATURE_LIST
			l_dynamic_type_set: ET_DYNAMIC_TYPE_SET
			l_special_type: ET_DYNAMIC_SPECIAL_TYPE
			l_integer_type: ET_DYNAMIC_TYPE
			l_item_type: ET_DYNAMIC_TYPE
			l_temp: ET_IDENTIFIER
		do
			l_queries := an_array_type.queries
			if an_array_type.attribute_count < 3 then
					-- Internal error: class "ARRAY" should have at least the
					-- features 'area', 'lower' and 'upper' as first features.
					-- Already reported in ET_DYNAMIC_SYSTEM.compile_kernel.
				set_fatal_error
				error_handler.report_giaaa_error
			else
				l_dynamic_type_set := l_queries.first.result_type_set
				if l_dynamic_type_set = Void then
						-- Error in feature 'area', already reported in ET_DYNAMIC_SYSTEM.compile_kernel.
					set_fatal_error
					error_handler.report_giaaa_error
				else
					l_special_type ?= l_dynamic_type_set.static_type
					if l_special_type = Void then
							-- Internal error: it has already been checked in ET_DYNAMIC_SYSTEM.compile_kernel
							-- that the attribute `area' is of SPECIAL type.
						set_fatal_error
						error_handler.report_giaaa_error
					end
				end
				l_dynamic_type_set := l_queries.item (3).result_type_set
				if l_dynamic_type_set = Void then
						-- Error in feature 'upper', already reported in ET_DYNAMIC_SYSTEM.compile_kernel.
					set_fatal_error
					error_handler.report_giaaa_error
					l_special_type := Void
				else
					l_integer_type := l_dynamic_type_set.static_type
				end
			end
			if l_special_type /= Void then
				l_item_type := l_special_type.item_type_set.static_type
					-- Print signature to `header_file' and `current_file'.
				header_file.put_string (c_extern)
				header_file.put_character (' ')
				header_file.put_string (c_void)
				current_file.put_string (c_void)
				header_file.put_character (' ')
				current_file.put_character (' ')
				header_file.put_string (c_ge_bma)
				current_file.put_string (c_ge_bma)
				header_file.put_integer (an_array_type.id)
				current_file.put_integer (an_array_type.id)
					-- Use varargs rather than inlining the code, this
					-- makes the C compilation with the -O2 faster and
					-- the resulting application is not slower.
				header_file.put_character ('(')
				print_type_declaration (an_array_type, header_file)
				header_file.put_string (" C, ")
				print_type_declaration (l_integer_type, header_file)
				header_file.put_string (" s, ")
				print_type_declaration (l_integer_type, header_file)
				header_file.put_string (" n, ...)")
				current_file.put_character ('(')
				print_type_declaration (an_array_type, current_file)
				current_file.put_string (" C, ")
				print_type_declaration (l_integer_type, current_file)
				current_file.put_string (" s, ")
				print_type_declaration (l_integer_type, current_file)
				current_file.put_string (" n, ...)")
				header_file.put_character (';')
				header_file.put_new_line
				current_file.put_new_line
					-- Print body to `current_file'.
				current_file.put_character ('{')
				current_file.put_new_line
				indent
					-- Copy items to 'area'.
				print_indentation
				current_file.put_line ("if (n!=0) {")
				indent
				print_indentation
				current_file.put_line ("va_list v;")
				print_indentation
				print_type_declaration (l_integer_type, current_file)
				current_file.put_line (" j = n;")
				l_temp := temp_variable
				print_indentation
				print_type_declaration (l_special_type, current_file)
				current_file.put_character (' ')
				print_temp_name (l_temp, current_file)
				current_file.put_character (' ')
				current_file.put_character ('=')
				current_file.put_character (' ')
				print_attribute_access (l_queries.first, tokens.current_keyword, an_array_type, False)
				current_file.put_character (';')
				current_file.put_new_line
				print_indentation
				print_type_declaration (l_item_type, current_file)
				current_file.put_character (' ')
				current_file.put_character ('*')
				current_file.put_character ('i')
				current_file.put_character (' ')
				current_file.put_character ('=')
				current_file.put_character (' ')
				print_attribute_special_item_access (l_temp, l_special_type, False)
				current_file.put_character (' ')
				current_file.put_character ('+')
				current_file.put_character (' ')
				current_file.put_character ('s')
				current_file.put_character (';')
				current_file.put_new_line
				print_indentation
				current_file.put_line ("va_start(v, n);")
				print_indentation
				current_file.put_line ("while (j--) {")
				indent
				print_indentation
				if
					l_item_type = current_dynamic_system.boolean_type or
					l_item_type = current_dynamic_system.character_8_type or
					l_item_type = current_dynamic_system.integer_8_type or
					l_item_type = current_dynamic_system.natural_8_type or
					l_item_type = current_dynamic_system.integer_16_type or
					l_item_type = current_dynamic_system.natural_16_type
				then
						-- ISO C 99 says that through "..." the types are promoted to
						-- 'int', and that promotion to 'int' leaves the type unchanged
						-- if all values cannot be represented with an 'int' or
						-- 'unsigned int'.
					current_file.put_string ("*(i++) = ")
					print_type_cast (l_item_type, current_file)
					current_file.put_string ("va_arg(v, int")
				elseif
					l_item_type = current_dynamic_system.real_32_type
				then
						-- ISO C 99 says that 'float' is promoted to 'double' when
						-- passed as argument of a function.
					current_file.put_string ("*(i++) = ")
					print_type_cast (l_item_type, current_file)
					current_file.put_string ("va_arg(v, double")
				else
					current_file.put_string ("*(i++) = va_arg(v, ")
					print_type_declaration (l_item_type, current_file)
				end
				current_file.put_character (')')
				current_file.put_character (';')
				current_file.put_new_line
				dedent
				print_indentation
				current_file.put_character ('}')
				current_file.put_new_line
				print_indentation
				current_file.put_line ("va_end(v);")
				dedent
				print_indentation
				current_file.put_character ('}')
				current_file.put_new_line
				dedent
				current_file.put_character ('}')
				current_file.put_new_line
			end
		end

-- GC TODO: Manifest Array routines; Make gc markable ...

	print_manifest_tuple_function (a_tuple_type: ET_DYNAMIC_TUPLE_TYPE)
			-- Print 'GE_mt' function to `current_file' and its signature to `header_file'.
			-- 'GE_mt<type-id>' is used to create manifest tuples of type 'type-id'.
		require
			a_tuple_type_not_void: a_tuple_type /= Void
		local
			l_item_type_sets: ET_DYNAMIC_TYPE_SET_LIST
			l_item_type: ET_DYNAMIC_TYPE
			i, nb: INTEGER
		do
			l_item_type_sets := a_tuple_type.item_type_sets
				-- Print signature to `header_file' and `current_file'.
			header_file.put_string (c_extern)
			header_file.put_character (' ')
			print_type_declaration (a_tuple_type, header_file)
			print_type_declaration (a_tuple_type, current_file)
			header_file.put_character (' ')
			current_file.put_character (' ')
			header_file.put_string (c_ge_mt)
			current_file.put_string (c_ge_mt)
			header_file.put_integer (a_tuple_type.id)
			current_file.put_integer (a_tuple_type.id)
			header_file.put_character ('(')
			current_file.put_character ('(')
			nb := l_item_type_sets.count
			from i := 1 until i > nb loop
				if i /= 1 then
					header_file.put_character (',')
					header_file.put_character (' ')
					current_file.put_character (',')
					current_file.put_character (' ')
				end
				l_item_type := l_item_type_sets.item (i).static_type
				print_type_declaration (l_item_type, header_file)
				print_type_declaration (l_item_type, current_file)
				header_file.put_character (' ')
				header_file.put_character ('a')
				header_file.put_integer (i)
				current_file.put_character (' ')
				current_file.put_character ('a')
				current_file.put_integer (i)
				i := i + 1
			end
			header_file.put_character (')')
			current_file.put_character (')')
			header_file.put_character (';')
			header_file.put_new_line
			current_file.put_new_line
				-- Print body to `current_file'.
			current_file.put_character ('{')
			current_file.put_new_line
			indent
			print_indentation
			print_type_declaration (a_tuple_type, current_file)
			current_file.put_character (' ')
			print_result_name (current_file)
			current_file.put_character (';')
			current_file.put_new_line
				-- Create tuple object.
			print_indentation
			print_result_name (current_file)
			current_file.put_character (' ')
			current_file.put_character ('=')
			current_file.put_character (' ')
			current_file.put_string (c_ge_new)
			current_file.put_integer (a_tuple_type.id)
			current_file.put_character ('(')
			current_file.put_string (c_eif_true)
			current_file.put_character (')')
			current_file.put_character (';')
			current_file.put_new_line
				-- Set fields.
			from i := 1 until i > nb loop
				print_indentation
				print_attribute_tuple_item_access (i, tokens.result_keyword, a_tuple_type, False)
				current_file.put_character (' ')
				current_file.put_character ('=')
				current_file.put_character (' ')
				current_file.put_character ('a')
				current_file.put_integer (i)
				current_file.put_character (';')
				current_file.put_new_line
				i := i + 1
			end
				-- Return the tuple.
			print_indentation
			current_file.put_string (c_return)
			current_file.put_character (' ')
			print_result_name (current_file)
			current_file.put_character (';')
			current_file.put_new_line
			dedent
			current_file.put_character ('}')
			current_file.put_new_line
		end

-- GC TODO: Boxed function routine; Make gc markable ...

	print_boxed_function (a_type: ET_DYNAMIC_TYPE)
			-- Print 'GE_boxed' function to `current_file' and its signature to `header_file'.
			-- 'GE_boxed<type-id>' is used to create boxed objects of type `a_type' (with id <type_id>).
			-- (The boxed version of a type makes sure that each object
			-- of that type contains its type-id. It can be the type itself
			-- if it already contains its type-id, or a wrapper otherwise.)
		require
			a_type_not_void: a_type /= Void
			a_type_expanded: a_type.is_expanded
		do
				-- Print signature to `header_file' and `current_file'.
			header_file.put_string (c_extern)
			header_file.put_character (' ')
			print_boxed_type_declaration (a_type, header_file)
			print_boxed_type_declaration (a_type, current_file)
			header_file.put_character (' ')
			current_file.put_character (' ')
			header_file.put_string (c_ge_boxed)
			current_file.put_string (c_ge_boxed)
			header_file.put_integer (a_type.id)
			current_file.put_integer (a_type.id)
			header_file.put_character ('(')
			current_file.put_character ('(')
			print_type_declaration (a_type, header_file)
			print_type_declaration (a_type, current_file)
			header_file.put_character (' ')
			header_file.put_character ('a')
			header_file.put_character ('1')
			current_file.put_character (' ')
			current_file.put_character ('a')
			current_file.put_character ('1')
			header_file.put_character (')')
			current_file.put_character (')')
			header_file.put_character (';')
			header_file.put_new_line
			current_file.put_new_line
				-- Print body to `current_file'.
			current_file.put_character ('{')
			current_file.put_new_line
			indent
			print_indentation
			print_boxed_type_declaration (a_type, current_file)
			current_file.put_character (' ')
			print_result_name (current_file)
			current_file.put_character (';')
			current_file.put_new_line
				-- Create boxed object.
			print_indentation
			print_result_name (current_file)
			current_file.put_character (' ')
			current_file.put_character ('=')
			current_file.put_character (' ')
			current_file.put_character ('(')
			print_boxed_type_declaration (a_type, current_file)
			current_file.put_character (')')
			if a_type.has_nested_reference_attributes then
				current_file.put_string (c_ge_alloc)
			else
				current_file.put_string (c_ge_alloc_atomic)
			end
			current_file.put_character ('(')
			current_file.put_string (c_sizeof)
			current_file.put_character ('(')
			print_boxed_type_name (a_type, current_file)
			current_file.put_character (')')
			current_file.put_character (')')
			current_file.put_character (';')
			current_file.put_new_line
				-- Set type id.
			print_indentation
			print_boxed_attribute_type_id_access (tokens.result_keyword, a_type, False)
			current_file.put_character (' ')
			current_file.put_character ('=')
			current_file.put_character (' ')
			current_file.put_integer (a_type.id)
			current_file.put_character (';')
			current_file.put_new_line
				-- Set item.
			print_indentation
			print_boxed_attribute_item_access (tokens.result_keyword, a_type, False)
			current_file.put_character (' ')
			current_file.put_character ('=')
			current_file.put_character (' ')
			current_file.put_character ('a')
			current_file.put_character ('1')
			current_file.put_character (';')
			current_file.put_new_line
				-- Return the boxed object.
			print_indentation
			current_file.put_string (c_return)
			current_file.put_character (' ')
			print_result_name (current_file)
			current_file.put_character (';')
			current_file.put_new_line
			dedent
			current_file.put_character ('}')
			current_file.put_new_line
			current_file.put_new_line
		end

	print_const_init_function
			-- Print 'GE_const_init' function to `current_file', and its signature to `header_file'.
			-- 'GE_const_init' is called to initialize the value of the non-expanded constant attributes
			-- and inline constants (such as once manifest strings).
		local
			l_feature: ET_FEATURE
			l_constant: ET_INLINE_CONSTANT
			l_manifest_constant: ET_CONSTANT
			l_constant_type: ET_DYNAMIC_TYPE
			old_constant_index: INTEGER
			l_type: ET_TYPE
			l_context: ET_TYPE_CONTEXT
		do
			header_file.put_string (c_extern)
			header_file.put_character (' ')
			header_file.put_string (c_void)
			current_file.put_string (c_void)
			header_file.put_character (' ')
			current_file.put_character (' ')
			header_file.put_string (c_ge_const_init)
			current_file.put_string (c_ge_const_init)
			header_file.put_character ('(')
			current_file.put_character ('(')
			header_file.put_string (c_void)
			header_file.put_character (')')
			current_file.put_character (')')
			header_file.put_character (';')
			header_file.put_new_line
			current_file.put_new_line
			current_file.put_character ('{')
			current_file.put_new_line
			indent
			from constant_features.start until constant_features.after loop
				l_feature := constant_features.key_for_iteration
				if once_features.has (l_feature) then
					print_indentation
					print_once_status_name (l_feature, current_file)
					current_file.put_character (' ')
					current_file.put_character ('=')
					current_file.put_character (' ')
					current_file.put_character ('%'')
					current_file.put_character ('\')
					current_file.put_character ('1')
					current_file.put_character ('%'')
					current_file.put_character (';')
					current_file.put_new_line
				end
				print_indentation
				print_once_value_name (l_feature, current_file)
				current_file.put_character (' ')
				current_file.put_character ('=')
				current_file.put_character (' ')
				current_file.put_character ('(')
				l_type := l_feature.type
				if l_type = Void then
						-- Internal feature: a constant attribute has a type.
					set_fatal_error
					error_handler.report_giaaa_error
				else
						-- The deanchored form of the type of the constant feature
						-- should not contain any formal generic parameter (in fact
						-- it should be one of BOOLEAN, CHARACTER possibly sized,
						-- INTEGER possibly sized, NATURAL possible sized, REAL possibly
						-- sized, STRING possibly sized, or 'TYPE [X]' where X is a
						-- stand-alone type), therefore it is OK to use the class where
						-- this feature has been written as context.
					l_context := l_feature.implementation_class
					l_constant_type := current_dynamic_system.dynamic_type (l_type, l_context)
					l_manifest_constant := constant_features.item_for_iteration
					extra_dynamic_type_sets.force_last (l_constant_type)
					old_constant_index := l_manifest_constant.index
					l_manifest_constant.set_index (current_dynamic_type_sets.count + extra_dynamic_type_sets.count)
					l_manifest_constant.process (Current)
					l_manifest_constant.set_index (old_constant_index)
					extra_dynamic_type_sets.remove_last
				end
				current_file.put_character (')')
				current_file.put_character (';')
				current_file.put_new_line
				constant_features.forth
			end
			from inline_constants.start until inline_constants.after loop
				l_constant := inline_constants.key_for_iteration
				print_indentation
				print_inline_constant_name (l_constant, current_file)
				current_file.put_character (' ')
				current_file.put_character ('=')
				current_file.put_character (' ')
				current_file.put_character ('(')
				l_manifest_constant := l_constant.constant
				l_constant_type := inline_constants.item_for_iteration
				extra_dynamic_type_sets.force_last (l_constant_type)
				old_constant_index := l_manifest_constant.index
				l_manifest_constant.set_index (current_dynamic_type_sets.count + extra_dynamic_type_sets.count)
				l_manifest_constant.process (Current)
				l_manifest_constant.set_index (old_constant_index)
				extra_dynamic_type_sets.remove_last
				current_file.put_character (')')
				current_file.put_character (';')
				current_file.put_new_line
				inline_constants.forth
			end
			dedent
			current_file.put_character ('}')
			current_file.put_new_line
		end

	print_dynamic_type_id_set_constants
			-- Print 'GE_dtsN' constants to `current_file', and their signature to `header_file'.
			-- 'GE_dtsN' are dymamic type id sets whose ids are sorted in increasing order.
		local
			l_dts_name: STRING
			l_dts_ids: STRING
			l_size: INTEGER
		do
			if not dynamic_type_id_set_names.is_empty then
				from dynamic_type_id_set_names.start until dynamic_type_id_set_names.after loop
					l_dts_name := dynamic_type_id_set_names.item_for_iteration
					l_dts_ids := dynamic_type_id_set_names.key_for_iteration
					l_size := l_dts_ids.occurrences (',') + 1
					header_file.put_string (c_extern)
					header_file.put_character (' ')
					header_file.put_string (c_int)
					header_file.put_character (' ')
					header_file.put_string (l_dts_name)
					header_file.put_character ('[')
					header_file.put_integer (l_size)
					header_file.put_character (']')
					header_file.put_character (';')
					header_file.put_new_line
					current_file.put_string (c_int)
					current_file.put_character (' ')
					current_file.put_string (l_dts_name)
					current_file.put_character ('[')
					current_file.put_integer (l_size)
					current_file.put_character (']')
					current_file.put_character (' ')
					current_file.put_character ('=')
					current_file.put_character (' ')
					current_file.put_character ('{')
					current_file.put_string (l_dts_ids)
					current_file.put_character ('}')
					current_file.put_character (';')
					current_file.put_new_line
					dynamic_type_id_set_names.forth
				end
				header_file.put_new_line
				current_file.put_new_line
			end
		end

feature {NONE} -- Memory allocation

	print_malloc_current (a_feature: ET_FEATURE)
			-- Print memory allocation of 'Current' with `a_feature' as creation procedure.
			-- Do not call the creation procedure.
		require
			a_feature_not_void: a_feature /= Void
		local
			l_special_type: ET_DYNAMIC_SPECIAL_TYPE
			l_temp: ET_IDENTIFIER
			l_arguments: ET_FORMAL_ARGUMENT_LIST
			l_argument_name: ET_IDENTIFIER
			old_file: KI_TEXT_OUTPUT_STREAM
		do
			if current_type.is_expanded then
					-- Variable declarations.
					-- They go to the beginning of the generated C function.
				old_file := current_file
				current_file := current_function_header_buffer
				l_temp := new_temp_variable (current_type)
				print_indentation
				print_type_declaration (current_type, current_file)
				current_file.put_character ('*')
				current_file.put_character (' ')
				print_current_name (current_file)
				current_file.put_character (' ')
				current_file.put_character ('=')
				current_file.put_character (' ')
				current_file.put_character ('&')
				print_temp_name (l_temp, current_file)
				current_file.put_character (';')
				current_file.put_new_line
					-- Instructions.
					-- They go to the current location in the generated C function.
				current_file := old_file
				print_indentation
				print_temp_name (l_temp, current_file)
				current_file.put_character (' ')
				current_file.put_character ('=')
				current_file.put_character (' ')
				print_default_name (current_type, current_file)
				current_file.put_character (';')
				current_file.put_new_line
			else
					-- Variable declarations.
					-- They go to the beginning of the generated C function.
				old_file := current_file
				current_file := current_function_header_buffer
				print_indentation
				print_type_declaration (current_type, current_file)
				current_file.put_character (' ')
				print_current_name (current_file)
				current_file.put_character (';')
				current_file.put_new_line
					-- Instructions.
					-- They go to the current location in the generated C function.
				current_file := old_file
				print_indentation
				print_current_name (current_file)
				current_file.put_character (' ')
				current_file.put_character ('=')
				current_file.put_character (' ')
				current_file.put_string (c_ge_new)
				current_file.put_integer (current_type.id)
				current_file.put_character ('(')
				l_special_type ?= current_type
				if l_special_type /= Void then
					l_arguments := a_feature.arguments
					if l_arguments = Void or else l_arguments.is_empty then
						current_file.put_character ('0')
					elseif not l_arguments.formal_argument (l_arguments.count).type.same_syntactical_type (current_universe.integer_type, current_type.base_type, current_type.base_type) then
						current_file.put_character ('0')
					else
						l_argument_name := l_arguments.formal_argument (l_arguments.count).name
						print_argument_name (l_argument_name, current_file)
					end
					current_file.put_character (',')
					current_file.put_character (' ')
				end
				current_file.put_string (c_eif_true)
				current_file.put_character (')')
				current_file.put_character (';')
				current_file.put_new_line
			end
		end

	print_object_allocation_functions
			-- For each non-expanded type that is alive (e.g. that can have instances at runtime),
			-- print 'GE_new<type-id>' functions to `current_file', and its signature to `header_file'.
			-- 'GE_new<type-id>' creates a new instance of type type-id, with possible default
			-- initialization depending on its argument. It also registers the 'dispose' feature
			-- for that object to the GC if such feature exists.
		local
			l_dynamic_types: DS_ARRAYED_LIST [ET_DYNAMIC_TYPE]
			l_type: ET_DYNAMIC_TYPE
			i, nb: INTEGER
		do
			l_dynamic_types := current_dynamic_system.dynamic_types
			nb := l_dynamic_types.count
			from i := 1 until i > nb loop
				l_type := l_dynamic_types.item (i)
				if l_type.is_alive and then not l_type.is_expanded then
					if not l_type.base_class.is_type_class then
						print_object_allocation_function (l_type)
						flush_to_c_file
					end
				end
				i := i + 1
			end
		end

	print_object_allocation_function (a_type: ET_DYNAMIC_TYPE)
			-- Print 'GE_new<type-id>' function to `current_file', and its signature to `header_file'.
			-- 'GE_new<type-id>' creates a new instance of type `a_type', with possible default
			-- initialization depending on its argument. It also registers the 'dispose' feature
			-- for that object to the GC if such feature exists.
		require
			a_type_not_void: a_type /= Void
			a_type_reference: not a_type.is_expanded
		local
			l_special_type: ET_DYNAMIC_SPECIAL_TYPE
			l_item_type: ET_DYNAMIC_TYPE
			l_temp: ET_IDENTIFIER
			l_has_nested_reference_attributes: BOOLEAN
			l_has_generic_expanded_attributes: BOOLEAN
			l_dynamic_type_set: ET_DYNAMIC_TYPE_SET
			l_integer_type: ET_DYNAMIC_TYPE
		do
			l_special_type ?= a_type
				-- Print signature to `header_file' and `current_file'.
			header_file.put_string ("/* New instance of type ")
			header_file.put_string (a_type.base_type.unaliased_to_text)
			header_file.put_line (" */")
			current_file.put_string ("/* New instance of type ")
			current_file.put_string (a_type.base_type.unaliased_to_text)
			current_file.put_line (" */")
			header_file.put_string (c_extern)
			header_file.put_character (' ')
			print_type_declaration (a_type, header_file)
			print_type_declaration (a_type, current_file)
			header_file.put_character (' ')
			current_file.put_character (' ')
			header_file.put_string (c_ge_new)
			current_file.put_string (c_ge_new)
			header_file.put_integer (a_type.id)
			current_file.put_integer (a_type.id)
			header_file.put_character ('(')
			current_file.put_character ('(')
			if l_special_type /= Void then
				if l_special_type.attribute_count < 1 then
						-- Internal error: class "SPECIAL" should have at least the
						-- feature 'count' as first feature.
						-- Already reported in ET_DYNAMIC_SYSTEM.compile_kernel.
					set_fatal_error
					error_handler.report_giaaa_error
				else
					l_dynamic_type_set := result_type_set_in_feature (l_special_type.queries.first)
					l_integer_type := l_dynamic_type_set.static_type
					print_type_declaration (l_integer_type, header_file)
					print_type_declaration (l_integer_type, current_file)
					header_file.put_character (' ')
					header_file.put_character ('a')
					header_file.put_character ('1')
					header_file.put_character (',')
					header_file.put_character (' ')
					current_file.put_character (' ')
					current_file.put_character ('a')
					current_file.put_character ('1')
					current_file.put_character (',')
					current_file.put_character (' ')
				end
			end
			print_type_declaration (current_dynamic_system.boolean_type, header_file)
			print_type_declaration (current_dynamic_system.boolean_type, current_file)
			header_file.put_character (' ')
			header_file.put_string (c_initialize)
			current_file.put_character (' ')
			current_file.put_string (c_initialize)
			header_file.put_character (')')
			current_file.put_character (')')
			header_file.put_character (';')
			header_file.put_new_line
			current_file.put_new_line
				-- Print body to `current_file'.
			current_file.put_character ('{')
			current_file.put_new_line
			indent
			print_indentation
			print_type_declaration (a_type, current_file)
			current_file.put_character (' ')
			print_result_name (current_file)
			current_file.put_character (';')
			current_file.put_new_line
			print_indentation
			print_result_name (current_file)
			current_file.put_character (' ')
			current_file.put_character ('=')
			current_file.put_character (' ')
			current_file.put_character ('(')
			print_type_declaration (a_type, current_file)
			current_file.put_character (')')
			if a_type.has_nested_reference_attributes then
				l_has_nested_reference_attributes := True
				current_file.put_string (c_ge_alloc)
			else
				current_file.put_string (c_ge_alloc_atomic)
			end
			current_file.put_character ('(')
			current_file.put_string (c_sizeof)
			current_file.put_character ('(')
			print_type_name (a_type, current_file)
			current_file.put_character (')')
			if l_special_type /= Void then
				l_item_type := l_special_type.item_type_set.static_type
				current_file.put_character ('+')
				current_file.put_character ('(')
				current_file.put_character ('a')
				current_file.put_character ('1')
				current_file.put_character ('>')
				current_file.put_character ('1')
				current_file.put_character ('?')
				current_file.put_character ('(')
				current_file.put_character ('a')
				current_file.put_character ('1')
				current_file.put_character ('-')
				current_file.put_character ('1')
				current_file.put_character (')')
				current_file.put_character (':')
				current_file.put_character ('0')
				current_file.put_character (')')
				current_file.put_character ('*')
				current_file.put_string (c_sizeof)
				current_file.put_character ('(')
				print_type_declaration (l_item_type, current_file)
				current_file.put_character (')')
			end
			current_file.put_character (')')
			current_file.put_character (';')
			current_file.put_new_line
				-- Dispose routine.
			print_dispose_registration (tokens.result_keyword, a_type)
				-- Default initialization.
			print_indentation
			current_file.put_string (c_if)
			current_file.put_character (' ')
			current_file.put_character ('(')
			current_file.put_string (c_initialize)
			current_file.put_character (')')
			current_file.put_character (' ')
			current_file.put_character ('{')
			current_file.put_new_line
			indent
			if l_special_type /= Void then
				if l_item_type.is_expanded and then (l_item_type.is_generic or else l_item_type.has_generic_expanded_attributes) then
					l_has_generic_expanded_attributes := True
					l_temp := temp_variable
					print_indentation
					print_type_declaration (l_integer_type, current_file)
					current_file.put_character (' ')
					print_temp_name (l_temp, current_file)
					current_file.put_character (';')
					current_file.put_new_line
				end
			end
			print_indentation
			current_file.put_character ('*')
			print_type_cast (a_type, current_file)
			print_result_name (current_file)
			current_file.put_character (' ')
			current_file.put_character ('=')
			current_file.put_character (' ')
			print_default_name (a_type, current_file)
			current_file.put_character (';')
			current_file.put_new_line
			if l_special_type /= Void then
					-- Set 'count'.
				print_indentation
				print_attribute_special_count_access (tokens.result_keyword, l_special_type, False)
				current_file.put_character (' ')
				current_file.put_character ('=')
				current_file.put_character (' ')
				current_file.put_character ('a')
				current_file.put_character ('1')
				current_file.put_character (';')
				current_file.put_new_line
					-- Initialize items if needed.
				if l_has_generic_expanded_attributes then
					print_indentation
					current_file.put_string (c_for)
					current_file.put_character (' ')
					current_file.put_character ('(')
					print_temp_name (l_temp, current_file)
					current_file.put_character (' ')
					current_file.put_character ('=')
					current_file.put_character (' ')
					current_file.put_character ('a')
					current_file.put_character ('1')
					current_file.put_character (' ')
					current_file.put_character ('-')
					current_file.put_character (' ')
					current_file.put_character ('1')
					current_file.put_character (';')
					current_file.put_character (' ')
					print_temp_name (l_temp, current_file)
					current_file.put_character (' ')
					current_file.put_character ('>')
					current_file.put_character ('=')
					current_file.put_character (' ')
					current_file.put_character ('0')
					current_file.put_character (';')
					current_file.put_character (' ')
					print_temp_name (l_temp, current_file)
					current_file.put_character ('-')
					current_file.put_character ('-')
					current_file.put_character (')')
					current_file.put_character (' ')
					current_file.put_character ('{')
					current_file.put_new_line
					indent
					print_indentation
					print_attribute_special_item_access (tokens.result_keyword, l_special_type, False)
					current_file.put_character ('[')
					print_temp_name (l_temp, current_file)
					current_file.put_character (']')
					current_file.put_character (' ')
					current_file.put_character ('=')
					current_file.put_character (' ')
					print_default_name (l_item_type, current_file)
					current_file.put_character (';')
					current_file.put_new_line
					dedent
					print_indentation
					current_file.put_character ('}')
					current_file.put_new_line
				else
					current_file.put_string (c_ifndef)
					current_file.put_character (' ')
					if l_has_nested_reference_attributes then
						current_file.put_line (c_ge_alloc_cleared)
					else
						current_file.put_line (c_ge_alloc_atomic_cleared)
					end
					print_indentation
					current_file.put_string (c_memset)
					current_file.put_character ('(')
					print_attribute_special_item_access (tokens.result_keyword, l_special_type, False)
					current_file.put_character (',')
					current_file.put_character ('0')
					current_file.put_character (',')
					current_file.put_character ('a')
					current_file.put_character ('1')
					current_file.put_character ('*')
					current_file.put_string (c_sizeof)
					current_file.put_character ('(')
					print_type_declaration (l_item_type, current_file)
					current_file.put_character (')')
					current_file.put_character (')')
					current_file.put_character (';')
					current_file.put_new_line
					current_file.put_line (c_endif)
				end
			end
			dedent
			print_indentation
			current_file.put_character ('}')
			current_file.put_new_line
				-- Return the new object.
			print_indentation
			current_file.put_string (c_return)
			current_file.put_character (' ')
			print_result_name (current_file)
			current_file.put_character (';')
			current_file.put_new_line
			dedent
			current_file.put_character ('}')
			current_file.put_new_line
			current_file.put_new_line
		end

	print_dispose_registration (an_object: ET_EXPRESSION; a_type: ET_DYNAMIC_TYPE)
			-- Print to `current_file' the registration to the GC of the
			-- 'dispose' feature, if it exists, to be called when the
			-- object `an_object' of type `a_type' will be reclaimed.
			-- Note that no 'dispose' routine will be registered if `a_type'
			-- is expanded (according to ECMA Eiffel, expanded classes should
			-- not inherit from class DISPOSABLE), or if the routine has an
			-- empty compound (optimization).
		require
			an_object_not_void: an_object /= Void
			a_type_not_void: a_type /= Void
		local
			l_dispose_seed: INTEGER
			l_dispose_procedure: ET_DYNAMIC_FEATURE
			l_procedure: ET_DYNAMIC_FEATURE
			l_internal_procedure: ET_INTERNAL_PROCEDURE
			l_compound: ET_COMPOUND
		do
			if not a_type.is_expanded then
				dispose_procedures.search (a_type)
				if dispose_procedures.found then
					l_dispose_procedure := dispose_procedures.found_item
				else
					l_dispose_seed := current_system.dispose_seed
					if l_dispose_seed > 0 then
						l_procedure := a_type.seeded_dynamic_procedure (l_dispose_seed, current_dynamic_system)
						if l_procedure /= Void then
								-- There is a feature 'dispose' available.
							l_internal_procedure ?= l_procedure.static_feature
							if l_internal_procedure /= Void then
								l_compound := l_internal_procedure.compound
								if l_compound /= Void and then not l_compound.is_empty then
										-- The feature 'dispose' is not empty.
										-- Register it to the GC.
									l_dispose_procedure := l_procedure
								end
							end
						end
					end
					dispose_procedures.force_last_new (l_dispose_procedure, a_type)
				end
				if l_dispose_procedure /= Void then
					print_indentation
					current_file.put_string (c_ge_register_dispose)
					current_file.put_character ('(')
					print_expression (an_object)
					current_file.put_character (',')
					current_file.put_character ('&')
					print_routine_name (l_dispose_procedure, a_type, current_file)
					current_file.put_character (')')
					current_file.put_character (';')
					current_file.put_new_line
					if not l_dispose_procedure.is_generated then
						l_dispose_procedure.set_generated (True)
						called_features.force_last (l_dispose_procedure)
					end
				end
			end
		end

	dispose_procedures: DS_HASH_TABLE [ET_DYNAMIC_FEATURE, ET_DYNAMIC_TYPE]
			-- 'dispose' procedures indexed by types, or Void if we figured out
			-- that there was no 'dispose' procedure for the given type

feature {NONE} -- Trace generation

	print_feature_trace_message_call (in: BOOLEAN)
			-- Print to `current_file' a call that will display to 'stderr' information
			-- about the fact that we just entered (if `in' is True) or just exited
			-- (if `in' is False) the current feature.
		local
			l_result_type: ET_DYNAMIC_TYPE
		do
			if trace_mode then
				current_file.put_string (c_ifdef)
				current_file.put_character (' ')
				current_file.put_line (c_eif_trace)
				if in then
						-- Instruction to print the trace message.
					print_indentation
					print_unindented_feature_info_message_call ("->")
					current_file.put_new_line
						-- This is a trick to make sure that the exit trace
						-- message will be displayed, even when there is a
						-- call to return before the end of the feature
						-- (this can happen in external inline C functions
						-- for example).
					current_file.put_string (c_define)
					current_file.put_character (' ')
					current_file.put_string (c_return)
					current_file.put_character (' ')
					print_unindented_feature_info_message_call ("<-")
					current_file.put_character (' ')
					current_file.put_line (c_return)
						-- Put the body of the feature in a block so that there
						-- is no C compilation error if some variables are
						-- declared after the instruction to print the trace message.
					print_indentation
					current_file.put_character ('{')
					current_file.put_new_line
				else
						-- Close the block containing the body of the feature.
					print_indentation
					current_file.put_character ('}')
					current_file.put_new_line
						-- 'return' will be preceded by the instruction
						-- to print the trace message thanks to the #define
						-- clause (see the description of the trick in the
						-- 'in' section above).
					print_indentation
					current_file.put_string (c_return)
					if current_feature.is_query then
						current_file.put_character (' ')
						l_result_type := current_feature.result_type_set.static_type
						current_file.put_character ('(')
						print_type_declaration (l_result_type, current_file)
						current_file.put_character (')')
						current_file.put_character ('(')
						print_default_entity_value (l_result_type, current_file)
						current_file.put_character (')')
					end
					current_file.put_character (';')
					current_file.put_new_line
						-- Undefine 'return' (see the description of
						-- the trick in the 'in' section above).
					current_file.put_string (c_undef)
					current_file.put_character (' ')
					current_file.put_line (c_return)
				end
				current_file.put_line (c_endif)
			end
		end

	print_agent_trace_message_call (an_agent: ET_AGENT; in: BOOLEAN)
			-- Print to `current_file' a call that will display to 'stderr' information
			-- about the fact that we just entered (if `in' is True) or just exited
			-- (if `in' is False) the agent `an_agent' appearing in current feature.
		require
			an_agent_not_void: an_agent /= Void
		local
			l_agent_message: STRING
			l_result: ET_RESULT
			l_result_type_set: ET_DYNAMIC_TYPE_SET
			l_result_type: ET_DYNAMIC_TYPE
		do
			if trace_mode then
				if an_agent.is_inline_agent then
					l_agent_message := " inline agent at line " + an_agent.position.line.out + " in"
				else
					l_agent_message := " agent at line " + an_agent.position.line.out + " in"
				end
				current_file.put_string (c_ifdef)
				current_file.put_character (' ')
				current_file.put_line (c_eif_trace)
				if in then
						-- Instruction to print the trace message.
					print_indentation
					print_unindented_feature_info_message_call ("->" + l_agent_message)
					current_file.put_new_line
						-- This is a trick to make sure that the exit trace
						-- message will be displayed, even when there is a
						-- call to return before the end of the feature
						-- (this can happen in external inline C functions
						-- for example).
					current_file.put_string (c_define)
					current_file.put_character (' ')
					current_file.put_string (c_return)
					current_file.put_character (' ')
					print_unindented_feature_info_message_call ("<-" + l_agent_message)
					current_file.put_character (' ')
					current_file.put_line (c_return)
						-- Put the body of the feature in a block so that there
						-- is no C compilation error if some variables are
						-- declared after the instruction to print the trace message.
					print_indentation
					current_file.put_character ('{')
					current_file.put_new_line
				else
						-- Close the block containing the body of the feature.
					print_indentation
					current_file.put_character ('}')
					current_file.put_new_line
						-- 'return' will be preceded by the instruction
						-- to print the trace message thanks to the #define
						-- clause (see the description of the trick in the
						-- 'in' section above).
					print_indentation
					current_file.put_string (c_return)
					if not an_agent.is_procedure then
						l_result := an_agent.implicit_result
						l_result_type_set := dynamic_type_set (l_result)
						l_result_type := l_result_type_set.static_type
						current_file.put_character (' ')
						current_file.put_character ('(')
						print_type_declaration (l_result_type, current_file)
						current_file.put_character (')')
						current_file.put_character ('(')
						print_default_entity_value (l_result_type, current_file)
						current_file.put_character (')')
					end
					current_file.put_character (';')
					current_file.put_new_line
						-- Undefine 'return' (see the description of
						-- the trick in the 'in' section above).
					current_file.put_string (c_undef)
					current_file.put_character (' ')
					current_file.put_line (c_return)
				end
				current_file.put_line (c_endif)
			end
		end

	print_feature_info_message_call (a_message: STRING)
			-- Print to `current_file' a call that will display to 'stderr' information
			-- about the current feature of form: `a_message' TYPE.feature
		require
			a_message_not_void: a_message /= Void
		do
			print_show_console_call
			print_indentation
			print_unindented_feature_info_message_call (a_message)
			current_file.put_new_line
		end

	print_unindented_feature_info_message_call (a_message: STRING)
			-- Print to `current_file' a call that will display to 'stderr' information
			-- about the current feature of form: `a_message' TYPE.feature
			-- This call is not indented nor finished by a new-line.
			-- Useful to define a macro.
		require
			a_message_not_void: a_message /= Void
		do
			current_file.put_string (c_fprintf)
			current_file.put_character ('(')
			current_file.put_string (c_stderr)
			current_file.put_character (',')
			current_file.put_character (' ')
			current_file.put_string ("%"%%s %%s.%%s\n%"")
			current_file.put_character (',')
			current_file.put_character (' ')
			print_escaped_string (a_message)
			current_file.put_character (',')
			current_file.put_character (' ')
			print_escaped_string (current_type.base_type.unaliased_to_text)
			current_file.put_character (',')
			current_file.put_character (' ')
			print_escaped_string (current_feature.static_feature.lower_name)
			current_file.put_character (')')
			current_file.put_character (';')
		end

	print_info_message_call (a_message: STRING)
			-- Print to `current_file' a call that will display to 'stderr'
			-- information form: `a_message'
		require
			a_message_not_void: a_message /= Void
		do
			print_show_console_call
			print_indentation
			current_file.put_string (c_fprintf)
			current_file.put_character ('(')
			current_file.put_string (c_stderr)
			current_file.put_character (',')
			current_file.put_character (' ')
			current_file.put_string ("%"%%s\n%"")
			current_file.put_character (',')
			current_file.put_character (' ')
			print_escaped_string (a_message)
			current_file.put_character (')')
			current_file.put_character (';')
			current_file.put_new_line
		end

	print_show_console_call
			-- Print to `current_file' a call to 'GE_show_console' to make sure
			-- that a DOS console is available for Windows applications.
		do
			current_file.put_string (c_ifdef)
			current_file.put_character (' ')
			current_file.put_line (c_eif_windows)
			print_indentation
			current_file.put_string (c_ge_show_console)
			current_file.put_character ('(')
			current_file.put_character (')')
			current_file.put_character (';')
			current_file.put_new_line
			current_file.put_line (c_endif)
		end

feature {NONE} -- Type generation

	print_types (a_file: KI_TEXT_OUTPUT_STREAM)
			-- Print declarations of types of `current_dynamic_system' to `a_file'.
		require
			a_file_not_void: a_file /= Void
			a_file_open_write: a_file.is_open_write
		local
			l_dynamic_types: DS_ARRAYED_LIST [ET_DYNAMIC_TYPE]
			l_type: ET_DYNAMIC_TYPE
			i, nb: INTEGER
			l_queries: ET_DYNAMIC_FEATURE_LIST
			l_query: ET_DYNAMIC_FEATURE
			l_attribute_type: ET_DYNAMIC_TYPE
			j, nb2: INTEGER
			l_expanded_sorter: DS_HASH_TOPOLOGICAL_SORTER [ET_DYNAMIC_TYPE]
			l_expanded_types: DS_ARRAYED_LIST [ET_DYNAMIC_TYPE]
		do
				-- Type with just the type_id attribute 'id'.
			a_file.put_string (c_define)
			a_file.put_character (' ')
			print_eif_any_type_name (a_file)
			a_file.put_character (' ')
			a_file.put_line (c_eif_any)
			a_file.put_new_line
				-- Aliased basic types, as specified in `current_system'.
			print_aliased_character_type_definition (current_system, a_file)
			print_aliased_wide_character_type_definition (current_system, a_file)
			print_aliased_integer_type_definition (current_system, a_file)
			print_aliased_natural_type_definition (current_system, a_file)
			print_aliased_real_type_definition (current_system, a_file)
			print_aliased_double_type_definition (current_system, a_file)
				-- Alive types.
			create l_expanded_sorter.make_default
			l_dynamic_types := current_dynamic_system.dynamic_types
			nb := l_dynamic_types.count
			from i := 1 until i > nb loop
				l_type := l_dynamic_types.item (i)
				if l_type.is_alive then
					a_file.put_character ('/')
					a_file.put_character ('*')
					a_file.put_character (' ')
					a_file.put_string (l_type.static_type.base_type.unaliased_to_text)
					a_file.put_character (' ')
					a_file.put_character ('*')
					a_file.put_character ('/')
					a_file.put_new_line
					if l_type.is_expanded then
							-- Keep track of expanded types.
						if not l_expanded_sorter.has (l_type) then
							l_expanded_sorter.force (l_type)
						end
						if not l_type.is_generic then
								-- For expanded types with no generics, there is no type
								-- other than themselves that conform to them. Therefore
								-- we do not keep the type-id in each object for those types
								-- because if it is used as static type of an entity there
								-- will be no polymorphic call. A boxed version (containing
								-- the type-id) is nevertheless generated when those objects
								-- are attached to entities of reference types (which might
								-- be polymorphic).
							if l_type = current_dynamic_system.boolean_type then
								print_boolean_type_definition (l_type, a_file)
							elseif l_type = current_dynamic_system.character_8_type then
								print_character_8_type_definition (l_type, a_file)
							elseif l_type = current_dynamic_system.character_32_type then
								print_character_32_type_definition (l_type, a_file)
							elseif l_type = current_dynamic_system.integer_8_type then
								print_integer_8_type_definition (l_type, a_file)
							elseif l_type = current_dynamic_system.integer_16_type then
								print_integer_16_type_definition (l_type, a_file)
							elseif l_type = current_dynamic_system.integer_32_type then
								print_integer_32_type_definition (l_type, a_file)
							elseif l_type = current_dynamic_system.integer_64_type then
								print_integer_64_type_definition (l_type, a_file)
							elseif l_type = current_dynamic_system.natural_8_type then
								print_natural_8_type_definition (l_type, a_file)
							elseif l_type = current_dynamic_system.natural_16_type then
								print_natural_16_type_definition (l_type, a_file)
							elseif l_type = current_dynamic_system.natural_32_type then
								print_natural_32_type_definition (l_type, a_file)
							elseif l_type = current_dynamic_system.natural_64_type then
								print_natural_64_type_definition (l_type, a_file)
							elseif l_type = current_dynamic_system.real_32_type then
								print_real_32_type_definition (l_type, a_file)
							elseif l_type = current_dynamic_system.real_64_type then
								print_real_64_type_definition (l_type, a_file)
							elseif l_type = current_dynamic_system.pointer_type then
								print_pointer_type_definition (l_type, a_file)
							else
								print_type_definition (l_type, a_file)
									-- Keep track of dependencies between expanded types.
								l_queries := l_type.queries
								nb2 := l_type.attribute_count
								from j := 1 until j > nb2 loop
									l_query := l_queries.item (j)
									l_attribute_type := l_query.result_type_set.static_type
									if l_attribute_type.is_expanded then
										l_expanded_sorter.force_relation (l_attribute_type, l_type)
									end
									j := j + 1
								end
							end
							print_boxed_function (l_type)
						end
					end
					if l_type.base_class.is_type_class then
						print_type_type_definition (l_type, a_file)
					else
						print_boxed_type_definition (l_type, a_file)
					end
					a_file.put_new_line
				end
				i := i + 1
			end
			l_expanded_sorter.sort
			if l_expanded_sorter.has_cycle then
					-- Internal error: this should already have been taken care of, either by
					-- Eiffel validity rule (see VLEC in ETL2), or by proper handling if ECMA
					-- relaxed this rule (through the introduction of attached types).
				set_fatal_error
				error_handler.report_giaaa_error
			end
				-- Struct for each expanded type.
			l_expanded_types := l_expanded_sorter.sorted_items
			nb := l_expanded_types.count
			from i := 1 until i > nb loop
				l_type := l_expanded_types.item (i)
				print_type_struct (l_type, a_file)
				print_boxed_type_struct (l_type, a_file)
				i := i + 1
			end
				-- Struct for each non-expanded type.
			nb := l_dynamic_types.count
			from i := 1 until i > nb loop
				l_type := l_dynamic_types.item (i)
				if l_type.is_alive and not l_type.is_expanded then
					print_type_struct (l_type, a_file)
				end
				i := i + 1
			end
				-- Type EIF_TYPE representing Eiffel types.
			print_eif_type_struct (a_file)
		end

	print_aliased_character_type_definition (a_universe: ET_UNIVERSE; a_file: KI_TEXT_OUTPUT_STREAM)
			-- Print to `a_file' the definition of aliased type "CHARACTER"
			-- as specified in `a_universe'.
		require
			a_universe_not_void: a_universe /= Void
			a_file_not_void: a_file /= Void
			a_file_open_write: a_file.is_open_write
		local
			l_class_type: ET_CLASS_TYPE
			l_any_type: ET_CLASS_TYPE
		do
			l_any_type := a_universe.any_type
			l_class_type := a_universe.character_type
			if l_class_type.same_named_type (a_universe.character_8_type, l_any_type, l_any_type) then
				a_file.put_character ('/')
				a_file.put_character ('*')
				a_file.put_character (' ')
				a_file.put_string (tokens.character_class_name.upper_name)
				a_file.put_character (' ')
				a_file.put_character ('*')
				a_file.put_character ('/')
				a_file.put_new_line
				a_file.put_string (c_define)
				a_file.put_character (' ')
				a_file.put_string (c_eif_character)
				a_file.put_character (' ')
				a_file.put_line (c_eif_character_8)
				a_file.put_new_line
			elseif l_class_type.same_named_type (a_universe.character_32_type, l_any_type, l_any_type) then
				a_file.put_character ('/')
				a_file.put_character ('*')
				a_file.put_character (' ')
				a_file.put_string (tokens.character_class_name.upper_name)
				a_file.put_character (' ')
				a_file.put_character ('*')
				a_file.put_character ('/')
				a_file.put_new_line
				a_file.put_string (c_define)
				a_file.put_character (' ')
				a_file.put_string (c_eif_character)
				a_file.put_character (' ')
				a_file.put_line (c_eif_character_32)
				a_file.put_new_line
			end
		end

	print_aliased_wide_character_type_definition (a_universe: ET_UNIVERSE; a_file: KI_TEXT_OUTPUT_STREAM)
			-- Print to `a_file' the definition of aliased type "WIDE_CHARACTER"
			-- as specified in `a_universe'.
		require
			a_universe_not_void: a_universe /= Void
			a_file_not_void: a_file /= Void
			a_file_open_write: a_file.is_open_write
		local
			l_class_type: ET_CLASS_TYPE
			l_any_type: ET_CLASS_TYPE
		do
			l_any_type := a_universe.any_type
			l_class_type := a_universe.wide_character_type
			if l_class_type.same_named_type (a_universe.character_8_type, l_any_type, l_any_type) then
				a_file.put_character ('/')
				a_file.put_character ('*')
				a_file.put_character (' ')
				a_file.put_string (tokens.wide_character_class_name.upper_name)
				a_file.put_character (' ')
				a_file.put_character ('*')
				a_file.put_character ('/')
				a_file.put_new_line
				a_file.put_string (c_define)
				a_file.put_character (' ')
				a_file.put_string (c_eif_wide_char)
				a_file.put_character (' ')
				a_file.put_line (c_eif_character_8)
				a_file.put_new_line
			elseif l_class_type.same_named_type (a_universe.character_32_type, l_any_type, l_any_type) then
				a_file.put_character ('/')
				a_file.put_character ('*')
				a_file.put_character (' ')
				a_file.put_string (tokens.wide_character_class_name.upper_name)
				a_file.put_character (' ')
				a_file.put_character ('*')
				a_file.put_character ('/')
				a_file.put_new_line
				a_file.put_string (c_define)
				a_file.put_character (' ')
				a_file.put_string (c_eif_wide_char)
				a_file.put_character (' ')
				a_file.put_line (c_eif_character_32)
				a_file.put_new_line
			end
		end

	print_aliased_integer_type_definition (a_universe: ET_UNIVERSE; a_file: KI_TEXT_OUTPUT_STREAM)
			-- Print to `a_file' the definition of aliased type "INTEGER"
			-- as specified in `a_universe'.
		require
			a_universe_not_void: a_universe /= Void
			a_file_not_void: a_file /= Void
			a_file_open_write: a_file.is_open_write
		local
			l_class_type: ET_CLASS_TYPE
			l_any_type: ET_CLASS_TYPE
		do
			l_any_type := a_universe.any_type
			l_class_type := a_universe.integer_type
			if l_class_type.same_named_type (a_universe.integer_8_type, l_any_type, l_any_type) then
				a_file.put_character ('/')
				a_file.put_character ('*')
				a_file.put_character (' ')
				a_file.put_string (tokens.integer_class_name.upper_name)
				a_file.put_character (' ')
				a_file.put_character ('*')
				a_file.put_character ('/')
				a_file.put_new_line
				a_file.put_string (c_define)
				a_file.put_character (' ')
				a_file.put_string (c_eif_integer)
				a_file.put_character (' ')
				a_file.put_line (c_eif_integer_8)
				a_file.put_new_line
			elseif l_class_type.same_named_type (a_universe.integer_16_type, l_any_type, l_any_type) then
				a_file.put_character ('/')
				a_file.put_character ('*')
				a_file.put_character (' ')
				a_file.put_string (tokens.integer_class_name.upper_name)
				a_file.put_character (' ')
				a_file.put_character ('*')
				a_file.put_character ('/')
				a_file.put_new_line
				a_file.put_string (c_define)
				a_file.put_character (' ')
				a_file.put_string (c_eif_integer)
				a_file.put_character (' ')
				a_file.put_line (c_eif_integer_16)
				a_file.put_new_line
			elseif l_class_type.same_named_type (a_universe.integer_32_type, l_any_type, l_any_type) then
				a_file.put_character ('/')
				a_file.put_character ('*')
				a_file.put_character (' ')
				a_file.put_string (tokens.integer_class_name.upper_name)
				a_file.put_character (' ')
				a_file.put_character ('*')
				a_file.put_character ('/')
				a_file.put_new_line
				a_file.put_string (c_define)
				a_file.put_character (' ')
				a_file.put_string (c_eif_integer)
				a_file.put_character (' ')
				a_file.put_line (c_eif_integer_32)
				a_file.put_new_line
			elseif l_class_type.same_named_type (a_universe.integer_64_type, l_any_type, l_any_type) then
				a_file.put_character ('/')
				a_file.put_character ('*')
				a_file.put_character (' ')
				a_file.put_string (tokens.integer_class_name.upper_name)
				a_file.put_character (' ')
				a_file.put_character ('*')
				a_file.put_character ('/')
				a_file.put_new_line
				a_file.put_string (c_define)
				a_file.put_character (' ')
				a_file.put_string (c_eif_integer)
				a_file.put_character (' ')
				a_file.put_line (c_eif_integer_64)
				a_file.put_new_line
			end
		end

	print_aliased_natural_type_definition (a_universe: ET_UNIVERSE; a_file: KI_TEXT_OUTPUT_STREAM)
			-- Print to `a_file' the definition of aliased type "NATURAL"
			-- as specified in `a_universe'.
		require
			a_universe_not_void: a_universe /= Void
			a_file_not_void: a_file /= Void
			a_file_open_write: a_file.is_open_write
		local
			l_class_type: ET_CLASS_TYPE
			l_any_type: ET_CLASS_TYPE
		do
			l_any_type := a_universe.any_type
			l_class_type := a_universe.natural_type
			if l_class_type.same_named_type (a_universe.natural_8_type, l_any_type, l_any_type) then
				a_file.put_character ('/')
				a_file.put_character ('*')
				a_file.put_character (' ')
				a_file.put_string (tokens.natural_class_name.upper_name)
				a_file.put_character (' ')
				a_file.put_character ('*')
				a_file.put_character ('/')
				a_file.put_new_line
				a_file.put_string (c_define)
				a_file.put_character (' ')
				a_file.put_string (c_eif_natural)
				a_file.put_character (' ')
				a_file.put_line (c_eif_natural_8)
				a_file.put_new_line
			elseif l_class_type.same_named_type (a_universe.natural_16_type, l_any_type, l_any_type) then
				a_file.put_character ('/')
				a_file.put_character ('*')
				a_file.put_character (' ')
				a_file.put_string (tokens.natural_class_name.upper_name)
				a_file.put_character (' ')
				a_file.put_character ('*')
				a_file.put_character ('/')
				a_file.put_new_line
				a_file.put_string (c_define)
				a_file.put_character (' ')
				a_file.put_string (c_eif_natural)
				a_file.put_character (' ')
				a_file.put_line (c_eif_natural_16)
				a_file.put_new_line
			elseif l_class_type.same_named_type (a_universe.natural_32_type, l_any_type, l_any_type) then
				a_file.put_character ('/')
				a_file.put_character ('*')
				a_file.put_character (' ')
				a_file.put_string (tokens.natural_class_name.upper_name)
				a_file.put_character (' ')
				a_file.put_character ('*')
				a_file.put_character ('/')
				a_file.put_new_line
				a_file.put_string (c_define)
				a_file.put_character (' ')
				a_file.put_string (c_eif_natural)
				a_file.put_character (' ')
				a_file.put_line (c_eif_natural_32)
				a_file.put_new_line
			elseif l_class_type.same_named_type (a_universe.natural_64_type, l_any_type, l_any_type) then
				a_file.put_character ('/')
				a_file.put_character ('*')
				a_file.put_character (' ')
				a_file.put_string (tokens.natural_class_name.upper_name)
				a_file.put_character (' ')
				a_file.put_character ('*')
				a_file.put_character ('/')
				a_file.put_new_line
				a_file.put_string (c_define)
				a_file.put_character (' ')
				a_file.put_string (c_eif_natural)
				a_file.put_character (' ')
				a_file.put_line (c_eif_natural_64)
				a_file.put_new_line
			end
		end

	print_aliased_real_type_definition (a_universe: ET_UNIVERSE; a_file: KI_TEXT_OUTPUT_STREAM)
			-- Print to `a_file' the definition of aliased type "REAL"
			-- as specified in `a_universe'.
		require
			a_universe_not_void: a_universe /= Void
			a_file_not_void: a_file /= Void
			a_file_open_write: a_file.is_open_write
		local
			l_class_type: ET_CLASS_TYPE
			l_any_type: ET_CLASS_TYPE
		do
			l_any_type := a_universe.any_type
			l_class_type := a_universe.real_type
			if l_class_type.same_named_type (a_universe.real_32_type, l_any_type, l_any_type) then
				a_file.put_character ('/')
				a_file.put_character ('*')
				a_file.put_character (' ')
				a_file.put_string (tokens.real_class_name.upper_name)
				a_file.put_character (' ')
				a_file.put_character ('*')
				a_file.put_character ('/')
				a_file.put_new_line
				a_file.put_string (c_define)
				a_file.put_character (' ')
				a_file.put_string (c_eif_real)
				a_file.put_character (' ')
				a_file.put_line (c_eif_real_32)
				a_file.put_new_line
			elseif l_class_type.same_named_type (a_universe.real_64_type, l_any_type, l_any_type) then
				a_file.put_character ('/')
				a_file.put_character ('*')
				a_file.put_character (' ')
				a_file.put_string (tokens.real_class_name.upper_name)
				a_file.put_character (' ')
				a_file.put_character ('*')
				a_file.put_character ('/')
				a_file.put_new_line
				a_file.put_string (c_define)
				a_file.put_character (' ')
				a_file.put_string (c_eif_real)
				a_file.put_character (' ')
				a_file.put_line (c_eif_real_64)
				a_file.put_new_line
			end
		end

	print_aliased_double_type_definition (a_universe: ET_UNIVERSE; a_file: KI_TEXT_OUTPUT_STREAM)
			-- Print to `a_file' the definition of aliased type "DOUBLE"
			-- as specified in `a_universe'.
		require
			a_universe_not_void: a_universe /= Void
			a_file_not_void: a_file /= Void
			a_file_open_write: a_file.is_open_write
		local
			l_class_type: ET_CLASS_TYPE
			l_any_type: ET_CLASS_TYPE
		do
			l_any_type := a_universe.any_type
			l_class_type := a_universe.double_type
			if l_class_type.same_named_type (a_universe.real_32_type, l_any_type, l_any_type) then
				a_file.put_character ('/')
				a_file.put_character ('*')
				a_file.put_character (' ')
				a_file.put_string (tokens.double_class_name.upper_name)
				a_file.put_character (' ')
				a_file.put_character ('*')
				a_file.put_character ('/')
				a_file.put_new_line
				a_file.put_string (c_define)
				a_file.put_character (' ')
				a_file.put_string (c_eif_double)
				a_file.put_character (' ')
				a_file.put_line (c_eif_real_32)
				a_file.put_new_line
			elseif l_class_type.same_named_type (a_universe.real_64_type, l_any_type, l_any_type) then
				a_file.put_character ('/')
				a_file.put_character ('*')
				a_file.put_character (' ')
				a_file.put_string (tokens.double_class_name.upper_name)
				a_file.put_character (' ')
				a_file.put_character ('*')
				a_file.put_character ('/')
				a_file.put_new_line
				a_file.put_string (c_define)
				a_file.put_character (' ')
				a_file.put_string (c_eif_double)
				a_file.put_character (' ')
				a_file.put_line (c_eif_real_64)
				a_file.put_new_line
			end
		end

	print_boolean_type_definition (a_type: ET_DYNAMIC_TYPE; a_file: KI_TEXT_OUTPUT_STREAM)
			-- Print to `a_file' the definition of type "BOOLEAN".
		require
			a_type_not_void: a_type /= Void
			a_file_not_void: a_file /= Void
			a_file_open_write: a_file.is_open_write
		do
			a_file.put_string (c_define)
			a_file.put_character (' ')
			print_type_name (a_type, a_file)
			a_file.put_character (' ')
			a_file.put_line (c_eif_boolean)
		end

	print_character_8_type_definition (a_type: ET_DYNAMIC_TYPE; a_file: KI_TEXT_OUTPUT_STREAM)
			-- Print to `a_file' the definition of type "CHARACTER_8".
		require
			a_type_not_void: a_type /= Void
			a_file_not_void: a_file /= Void
			a_file_open_write: a_file.is_open_write
		do
			a_file.put_string (c_define)
			a_file.put_character (' ')
			print_type_name (a_type, a_file)
			a_file.put_character (' ')
			a_file.put_line (c_eif_character_8)
		end

	print_character_32_type_definition (a_type: ET_DYNAMIC_TYPE; a_file: KI_TEXT_OUTPUT_STREAM)
			-- Print to `a_file' the definition of type "CHARACTER_32".
		require
			a_type_not_void: a_type /= Void
			a_file_not_void: a_file /= Void
			a_file_open_write: a_file.is_open_write
		do
			a_file.put_string (c_define)
			a_file.put_character (' ')
			print_type_name (a_type, a_file)
			a_file.put_character (' ')
			a_file.put_line (c_eif_character_32)
		end

	print_integer_8_type_definition (a_type: ET_DYNAMIC_TYPE; a_file: KI_TEXT_OUTPUT_STREAM)
			-- Print to `a_file' the definition of type "INTEGER_8".
		require
			a_type_not_void: a_type /= Void
			a_file_not_void: a_file /= Void
			a_file_open_write: a_file.is_open_write
		do
			a_file.put_string (c_define)
			a_file.put_character (' ')
			print_type_name (a_type, a_file)
			a_file.put_character (' ')
			a_file.put_line (c_eif_integer_8)
		end

	print_integer_16_type_definition (a_type: ET_DYNAMIC_TYPE; a_file: KI_TEXT_OUTPUT_STREAM)
			-- Print to `a_file' the definition of type "INTEGER_16".
		require
			a_type_not_void: a_type /= Void
			a_file_not_void: a_file /= Void
			a_file_open_write: a_file.is_open_write
		do
			a_file.put_string (c_define)
			a_file.put_character (' ')
			print_type_name (a_type, a_file)
			a_file.put_character (' ')
			a_file.put_line (c_eif_integer_16)
		end

	print_integer_32_type_definition (a_type: ET_DYNAMIC_TYPE; a_file: KI_TEXT_OUTPUT_STREAM)
			-- Print to `a_file' the definition of type "INTEGER_32".
		require
			a_type_not_void: a_type /= Void
			a_file_not_void: a_file /= Void
			a_file_open_write: a_file.is_open_write
		do
			a_file.put_string (c_define)
			a_file.put_character (' ')
			print_type_name (a_type, a_file)
			a_file.put_character (' ')
			a_file.put_line (c_eif_integer_32)
		end

	print_integer_64_type_definition (a_type: ET_DYNAMIC_TYPE; a_file: KI_TEXT_OUTPUT_STREAM)
			-- Print to `a_file' the definition of type "INTEGER_64".
		require
			a_type_not_void: a_type /= Void
			a_file_not_void: a_file /= Void
			a_file_open_write: a_file.is_open_write
		do
			a_file.put_string (c_define)
			a_file.put_character (' ')
			print_type_name (a_type, a_file)
			a_file.put_character (' ')
			a_file.put_line (c_eif_integer_64)
		end

	print_natural_8_type_definition (a_type: ET_DYNAMIC_TYPE; a_file: KI_TEXT_OUTPUT_STREAM)
			-- Print to `a_file' the definition of type "NATURAL_8".
		require
			a_type_not_void: a_type /= Void
			a_file_not_void: a_file /= Void
			a_file_open_write: a_file.is_open_write
		do
			a_file.put_string (c_define)
			a_file.put_character (' ')
			print_type_name (a_type, a_file)
			a_file.put_character (' ')
			a_file.put_line (c_eif_natural_8)
		end

	print_natural_16_type_definition (a_type: ET_DYNAMIC_TYPE; a_file: KI_TEXT_OUTPUT_STREAM)
			-- Print to `a_file' the definition of type "NATURAL_16".
		require
			a_type_not_void: a_type /= Void
			a_file_not_void: a_file /= Void
			a_file_open_write: a_file.is_open_write
		do
			a_file.put_string (c_define)
			a_file.put_character (' ')
			print_type_name (a_type, a_file)
			a_file.put_character (' ')
			a_file.put_line (c_eif_natural_16)
		end

	print_natural_32_type_definition (a_type: ET_DYNAMIC_TYPE; a_file: KI_TEXT_OUTPUT_STREAM)
			-- Print to `a_file' the definition of type "NATURAL_32".
		require
			a_type_not_void: a_type /= Void
			a_file_not_void: a_file /= Void
			a_file_open_write: a_file.is_open_write
		do
			a_file.put_string (c_define)
			a_file.put_character (' ')
			print_type_name (a_type, a_file)
			a_file.put_character (' ')
			a_file.put_line (c_eif_natural_32)
		end

	print_natural_64_type_definition (a_type: ET_DYNAMIC_TYPE; a_file: KI_TEXT_OUTPUT_STREAM)
			-- Print to `a_file' the definition of type "NATURAL_64".
		require
			a_type_not_void: a_type /= Void
			a_file_not_void: a_file /= Void
			a_file_open_write: a_file.is_open_write
		do
			a_file.put_string (c_define)
			a_file.put_character (' ')
			print_type_name (a_type, a_file)
			a_file.put_character (' ')
			a_file.put_line (c_eif_natural_64)
		end

	print_real_32_type_definition (a_type: ET_DYNAMIC_TYPE; a_file: KI_TEXT_OUTPUT_STREAM)
			-- Print to `a_file' the definition of type "REAL_32".
		require
			a_type_not_void: a_type /= Void
			a_file_not_void: a_file /= Void
			a_file_open_write: a_file.is_open_write
		do
			a_file.put_string (c_define)
			a_file.put_character (' ')
			print_type_name (a_type, a_file)
			a_file.put_character (' ')
			a_file.put_line (c_eif_real_32)
		end

	print_real_64_type_definition (a_type: ET_DYNAMIC_TYPE; a_file: KI_TEXT_OUTPUT_STREAM)
			-- Print to `a_file' the definition of type "REAL_64".
		require
			a_type_not_void: a_type /= Void
			a_file_not_void: a_file /= Void
			a_file_open_write: a_file.is_open_write
		do
			a_file.put_string (c_define)
			a_file.put_character (' ')
			print_type_name (a_type, a_file)
			a_file.put_character (' ')
			a_file.put_line (c_eif_real_64)
		end

	print_pointer_type_definition (a_type: ET_DYNAMIC_TYPE; a_file: KI_TEXT_OUTPUT_STREAM)
			-- Print to `a_file' the definition of type "POINTER".
		require
			a_type_not_void: a_type /= Void
			a_file_not_void: a_file /= Void
			a_file_open_write: a_file.is_open_write
		do
			a_file.put_string (c_define)
			a_file.put_character (' ')
			print_type_name (a_type, a_file)
			a_file.put_character (' ')
			a_file.put_line (c_eif_pointer)
		end

	print_type_type_definition (a_type: ET_DYNAMIC_TYPE; a_file: KI_TEXT_OUTPUT_STREAM)
			-- Print to `a_file' the definition of type "TYPE [X]".
		require
			a_type_not_void: a_type /= Void
			a_file_not_void: a_file /= Void
			a_file_open_write: a_file.is_open_write
		do
			a_file.put_string (c_define)
			a_file.put_character (' ')
			print_type_name (a_type, a_file)
			a_file.put_character (' ')
			a_file.put_line (c_eif_type)
		end

	print_type_definition (a_type: ET_DYNAMIC_TYPE; a_file: KI_TEXT_OUTPUT_STREAM)
			-- Print to `a_file' the definition of type `a_type'.
		require
			a_type_not_void: a_type /= Void
			a_file_not_void: a_file /= Void
			a_file_open_write: a_file.is_open_write
		do
			a_file.put_string (c_typedef)
			a_file.put_character (' ')
			a_file.put_string (c_struct)
			a_file.put_character (' ')
			print_struct_name (a_type, a_file)
			a_file.put_character (' ')
			print_type_name (a_type, a_file)
			a_file.put_character (';')
			a_file.put_new_line
		end

	print_boxed_type_definition (a_type: ET_DYNAMIC_TYPE; a_file: KI_TEXT_OUTPUT_STREAM)
			-- Print to `a_file' the type definition of the boxed version of `a_type'.
			-- (The boxed version of a type makes sure that each object
			-- of that type contains its type-id. It can be the type itself
			-- if it already contains its type-id, or a wrapper otherwise.)
		require
			a_type_not_void: a_type /= Void
			a_file_not_void: a_file /= Void
			a_file_open_write: a_file.is_open_write
		do
			a_file.put_string (c_typedef)
			a_file.put_character (' ')
			a_file.put_string (c_struct)
			a_file.put_character (' ')
			print_boxed_struct_name (a_type, a_file)
			a_file.put_character (' ')
			print_boxed_type_name (a_type, a_file)
			a_file.put_character (';')
			a_file.put_new_line
		end

-- GC Mods

	print_type_struct (a_type: ET_DYNAMIC_TYPE; a_file: KI_TEXT_OUTPUT_STREAM)
			-- Print to `a_file' declaration of C struct corresponding to `a_type', if_any.
		require
			a_type_not_void: a_type /= Void
			a_file_not_void: a_file /= Void
			a_file_open_write: a_file.is_open_write
		local
			l_special_type: ET_DYNAMIC_SPECIAL_TYPE
			l_tuple_type: ET_DYNAMIC_TUPLE_TYPE
			l_function_type: ET_DYNAMIC_FUNCTION_TYPE
			l_procedure_type: ET_DYNAMIC_PROCEDURE_TYPE
			l_open_operand_type_sets: ET_DYNAMIC_TYPE_SET_LIST
			l_item_type_set: ET_DYNAMIC_TYPE_SET
			l_item_type_sets: ET_DYNAMIC_TYPE_SET_LIST
			l_queries: ET_DYNAMIC_FEATURE_LIST
			l_query: ET_DYNAMIC_FEATURE
			i, nb: INTEGER
			l_empty_struct: BOOLEAN
			l_dynamic_type_set: ET_DYNAMIC_TYPE_SET
		do
			if
				not a_type.base_class.is_type_class and
				(not a_type.is_expanded or else not a_type.is_basic)
			then
				l_empty_struct := True
				a_file.put_character ('/')
				a_file.put_character ('*')
				a_file.put_character (' ')
				a_file.put_string ("Struct for type ")
				a_file.put_string (a_type.static_type.base_type.unaliased_to_text)
				a_file.put_character (' ')
				a_file.put_character ('*')
				a_file.put_character ('/')
				a_file.put_new_line
				a_file.put_string (c_struct)
				a_file.put_character (' ')
				print_struct_name (a_type, a_file)
				a_file.put_character (' ')
				a_file.put_character ('{')
				a_file.put_new_line
				if not a_type.is_expanded or else a_type.is_generic then
					a_file.put_character ('%T')
					a_file.put_string (c_int16_t)					-- GC
					a_file.put_character (' ')
					print_attribute_type_id_name (a_type, a_file)
					a_file.put_character (';')
					a_file.put_new_line
					l_empty_struct := False
				end
				if use_edp_gc and then not a_type.is_expanded then	-- GC
			--	if not a_type.is_expanded then						-- GC
					a_file.put_character ('%T')						-- GC
					a_file.put_string (c_int16_t)					-- GC
					a_file.put_character (' ')						-- GC
					a_file.put_string (once "gc_flags")				-- GC
					a_file.put_character (';')						-- GC
					a_file.put_new_line								-- GC
					l_empty_struct := False							-- GC
				end													-- GC
				l_queries := a_type.queries
				nb := a_type.attribute_count
				from i := 1 until i > nb loop
					l_query := l_queries.item (i)
					a_file.put_character ('%T')
					print_type_declaration (l_query.result_type_set.static_type, a_file)
					a_file.put_character (' ')
					print_attribute_name (l_query, a_type, a_file)
					a_file.put_character (';')
					a_file.put_character (' ')
					a_file.put_character ('/')
					a_file.put_character ('*')
					a_file.put_character (' ')
					a_file.put_string (l_query.static_feature.name.name)
					a_file.put_character (' ')
					a_file.put_character ('*')
					a_file.put_character ('/')
					a_file.put_new_line
					l_empty_struct := False
					i := i + 1
				end
				l_special_type ?= a_type
				if l_special_type /= Void then
						-- We use the "struct hack" to represent SPECIAL
						-- object header. The last member of the struct
						-- is an array of size 1, but we malloc the needed
						-- space when creating the SPECIAL object. We use
						-- an array of size 1 because some compilers don't
						-- like having an array of size 0 here. Note that
						-- the "struct hack" is superseded by the concept
						-- of "flexible array member" in ISO C 99.
					if l_special_type.attribute_count < 1 then
							-- Internal error: class "SPECIAL" should have at least the
							-- feature 'count' as first feature.
							-- Already reported in ET_DYNAMIC_SYSTEM.compile_kernel.
						set_fatal_error
						error_handler.report_giaaa_error
					else
						l_dynamic_type_set := result_type_set_in_feature (l_special_type.queries.first)
						a_file.put_character ('%T')
						l_item_type_set := l_special_type.item_type_set
						print_type_declaration (l_item_type_set.static_type, a_file)
						a_file.put_character (' ')
						print_attribute_special_item_name (l_special_type, a_file)
						a_file.put_character ('[')
						a_file.put_character ('1')
						a_file.put_character (']')
						a_file.put_character (';')
						a_file.put_character (' ')
						a_file.put_character ('/')
						a_file.put_character ('*')
						a_file.put_character (' ')
						a_file.put_character ('i')
						a_file.put_character ('t')
						a_file.put_character ('e')
						a_file.put_character ('m')
						a_file.put_character (' ')
						a_file.put_character ('*')
						a_file.put_character ('/')
						a_file.put_new_line
						l_empty_struct := False
					end
				else
					l_tuple_type ?= a_type
					if l_tuple_type /= Void then
						l_item_type_sets := l_tuple_type.item_type_sets
						nb := l_item_type_sets.count
						from i := 1 until i > nb loop
							a_file.put_character ('%T')
							print_type_declaration (l_item_type_sets.item (i).static_type, a_file)
							a_file.put_character (' ')
							print_attribute_tuple_item_name (i, l_tuple_type, a_file)
							a_file.put_character (';')
							a_file.put_new_line
							l_empty_struct := False
							i := i + 1
						end
					else
						l_function_type ?= a_type
						if l_function_type /= Void then
								-- Function pointer.
							a_file.put_character ('%T')
							print_type_declaration (l_function_type.result_type_set.static_type, a_file)
							a_file.put_character (' ')
							a_file.put_character ('(')
							a_file.put_character ('*')
							print_attribute_routine_function_name (l_function_type, a_file)
							a_file.put_character (')')
							a_file.put_character ('(')
							if exception_trace_mode then
								a_file.put_string (c_ge_call)
								a_file.put_character ('*')
								a_file.put_character (',')
								a_file.put_character (' ')
							end
							print_type_declaration (a_type, a_file)
							l_open_operand_type_sets := l_function_type.open_operand_type_sets
							nb := l_open_operand_type_sets.count
							from i := 1 until i > nb loop
								a_file.put_character (',')
								a_file.put_character (' ')
								print_type_declaration (l_open_operand_type_sets.item (i).static_type, a_file)
								i := i + 1
							end
							a_file.put_character (')')
							a_file.put_character (';')
							a_file.put_new_line
							l_empty_struct := False
						else
							l_procedure_type ?= a_type
							if l_procedure_type /= Void then
									-- Function pointer.
								a_file.put_character ('%T')
								a_file.put_string (c_void)
								a_file.put_character (' ')
								a_file.put_character ('(')
								a_file.put_character ('*')
								print_attribute_routine_function_name (l_procedure_type, a_file)
								a_file.put_character (')')
								a_file.put_character ('(')
								if exception_trace_mode then
									a_file.put_string (c_ge_call)
									a_file.put_character ('*')
									a_file.put_character (',')
									a_file.put_character (' ')
								end
								print_type_declaration (a_type, a_file)
								l_open_operand_type_sets := l_procedure_type.open_operand_type_sets
								nb := l_open_operand_type_sets.count
								from i := 1 until i > nb loop
									a_file.put_character (',')
									a_file.put_character (' ')
									print_type_declaration (l_open_operand_type_sets.item (i).static_type, a_file)
									i := i + 1
								end
								a_file.put_character (')')
								a_file.put_character (';')
								a_file.put_new_line
								l_empty_struct := False
							end
						end
					end
				end
				if l_empty_struct then
						-- Add a dummy field so that the struct is not empty (not allowed in C99).
					a_file.put_character ('%T')
					a_file.put_string (c_char)
					a_file.put_character (' ')
					a_file.put_string ("dummy")
					a_file.put_character (';')
					a_file.put_new_line
				end
				a_file.put_character ('}')
				a_file.put_character (';')
				a_file.put_new_line
				a_file.put_new_line
			end
		end

	print_boxed_type_struct (a_type: ET_DYNAMIC_TYPE; a_file: KI_TEXT_OUTPUT_STREAM)
			-- Print to `a_file' declaration of C struct corresponding to boxed version of `a_type', if_any.
			-- (The boxed version of a type makes sure that each object
			-- of that type contains its type-id. It can be the type itself
			-- if it already contains its type-id, or a wrapper otherwise.)
		require
			a_type_not_void: a_type /= Void
			a_file_not_void: a_file /= Void
			a_file_open_write: a_file.is_open_write
		do
			if a_type.is_expanded and not a_type.is_generic then
				a_file.put_character ('/')
				a_file.put_character ('*')
				a_file.put_character (' ')
				a_file.put_string ("Struct for boxed version of type ")
				a_file.put_string (a_type.static_type.base_type.unaliased_to_text)
				a_file.put_character (' ')
				a_file.put_character ('*')
				a_file.put_character ('/')
				a_file.put_new_line
				a_file.put_string (c_struct)
				a_file.put_character (' ')
				print_boxed_struct_name (a_type, a_file)
				a_file.put_character (' ')
				a_file.put_character ('{')
				a_file.put_new_line
				a_file.put_character ('%T')
				a_file.put_string (c_int16_t)					-- GC
				a_file.put_character (' ')
				print_attribute_type_id_name (a_type, a_file)
				a_file.put_character (';')
				a_file.put_new_line
-- TODO_GC Add GC flags field
				a_file.put_character ('%T')						-- GC
				a_file.put_string (c_int16_t)					-- GC
				a_file.put_character (' ')						-- GC
				a_file.put_string (once "gc_flags")				-- GC
				a_file.put_character (';')						-- GC
				a_file.put_new_line								-- GC
				a_file.put_character ('%T')
				print_type_declaration (a_type, a_file)
				a_file.put_character (' ')
				print_boxed_attribute_item_name (a_type, a_file)
				a_file.put_character (';')
				a_file.put_character (' ')
				a_file.put_character ('/')
				a_file.put_character ('*')
				a_file.put_character (' ')
				a_file.put_character ('i')
				a_file.put_character ('t')
				a_file.put_character ('e')
				a_file.put_character ('m')
				a_file.put_character (' ')
				a_file.put_character ('*')
				a_file.put_character ('/')
				a_file.put_new_line
				a_file.put_character ('}')
				a_file.put_character (';')
				a_file.put_new_line
				a_file.put_new_line
			end
		end
		
-- GC Mods

	print_eif_type_struct (a_file: KI_TEXT_OUTPUT_STREAM)
			-- Print to `a_file' declaration of C struct corresponding to 'EIF_TYPE', if_any.
			-- Type EIF_TYPE represents Eiffel types.
		require
			a_file_not_void: a_file /= Void
			a_file_open_write: a_file.is_open_write
		do
			a_file.put_string (c_typedef)
			a_file.put_character (' ')
			a_file.put_string (c_struct)
			a_file.put_character (' ')
			a_file.put_character ('{')
			a_file.put_new_line
			if use_edp_gc then
				a_file.put_character ('%T')
				a_file.put_string (c_int16_t)
				a_file.put_character (' ')
				print_attribute_type_id_name (current_dynamic_system.any_type, a_file)
				a_file.put_character (';')
				a_file.put_new_line
				a_file.put_character ('%T')
				a_file.put_string (c_int16_t)
				a_file.put_character (' ')
				a_file.put_string (once "gc_flags")
				a_file.put_character (';')
				a_file.put_new_line
			else
				a_file.put_character ('%T')
				a_file.put_string (c_int)
				a_file.put_character (' ')
				print_attribute_type_id_name (current_dynamic_system.any_type, a_file)
				a_file.put_character (';')
				a_file.put_new_line
			end
			a_file.put_character ('%T')
			a_file.put_string (c_eif_integer)
			a_file.put_character (' ')
			a_file.put_string (c_type_id)
			a_file.put_character (';')
			a_file.put_new_line
			a_file.put_character ('%T')
			a_file.put_string (c_eif_boolean)
			a_file.put_character (' ')
			a_file.put_string (c_is_special)
			a_file.put_character (';')
			a_file.put_new_line
			a_file.put_character ('%T')
			a_file.put_string ("void (*dispose) (")
			if exception_trace_mode then
				a_file.put_string (c_ge_call)
				a_file.put_character ('*')
				a_file.put_character (',')
				a_file.put_character (' ')
			end
			a_file.put_string ("EIF_REFERENCE)")
			a_file.put_character (';')
			a_file.put_new_line
			if use_edp_gc then											-- GC
				a_file.put_character ('%T')								-- GC
				a_file.put_string ("void (*gc_mark)(EIF_REFERENCE);")	-- GC
				a_file.put_new_line										-- GC
			end															-- GC
				-- Attribute `runtime_name'.
			a_file.put_character ('%T')
			a_file.put_string ("T0*")
			a_file.put_character (' ')
			a_file.put_string ("a1")
			a_file.put_character (';')
			a_file.put_new_line
			a_file.put_character ('}')
			a_file.put_character (' ')
			a_file.put_string (c_eif_type)
			a_file.put_character (';')
			a_file.put_new_line
			a_file.put_new_line
		end

	print_types_array
			-- Print 'GE_types' array to `current_file' and its declaration to `header_file'.
		local
			l_dynamic_types: DS_ARRAYED_LIST [ET_DYNAMIC_TYPE]
			l_type: ET_DYNAMIC_TYPE
			l_meta_type: ET_DYNAMIC_TYPE
			i, nb: INTEGER
			l_dispose_procedure: ET_DYNAMIC_FEATURE
		do
			l_dynamic_types := current_dynamic_system.dynamic_types
			nb := l_dynamic_types.count
				-- Print declaration of 'GE_types' in `header_file'.
			header_file.put_string (c_extern)
			header_file.put_character (' ')
			header_file.put_string (c_eif_type)
			header_file.put_character (' ')
			header_file.put_string (c_ge_types)
			header_file.put_character ('[')
			header_file.put_character (']')
			header_file.put_character (';')
			header_file.put_new_line
			current_file.put_string (c_eif_type)
			current_file.put_character (' ')
			current_file.put_string (c_ge_types)
			current_file.put_character ('[')
			current_file.put_integer (nb + 1)
			current_file.put_character (']')
			current_file.put_character (' ')
			current_file.put_character ('=')
			current_file.put_character (' ')
			current_file.put_character ('{')
			current_file.put_new_line
				-- Dummy type at index 0.
			current_file.put_character ('{')
			current_file.put_integer (0)
			current_file.put_character (',')
			current_file.put_character (' ')
				-- gc_flags							-- GC
			if use_edp_gc then						-- GC
				current_file.put_integer (0)		-- GC
				current_file.put_character (',')	-- GC
				current_file.put_character (' ')	-- GC
			end										-- GC
			current_file.put_integer (0)
			current_file.put_character (',')
			current_file.put_character (' ')
			current_file.put_string (c_eif_false)
			current_file.put_character (',')
			current_file.put_character (' ')
			current_file.put_integer (0)
			current_file.put_character ('}')
			current_file.put_character (',')
			current_file.put_new_line
-- TODO: here we might include types that are used in our system!
			from i := 1 until i > nb loop
				l_type := l_dynamic_types.item (i)
				current_file.put_character ('{')
					-- id.
				l_meta_type := l_type.meta_type
				if l_meta_type /= Void then
					current_file.put_integer (l_meta_type.id)
				else
					current_file.put_integer (0)
				end
				current_file.put_character (',')
				current_file.put_character (' ')
					-- gc_flags							-- GC
				if use_edp_gc then						-- GC
					current_file.put_integer (0)		-- GC
					current_file.put_character (',')	-- GC
					current_file.put_character (' ')	-- GC
				end										-- GC
					-- type_id.
				current_file.put_integer (l_type.id)
				current_file.put_character (',')
				current_file.put_character (' ')
					-- is_special.
				if l_type.is_special then
					current_file.put_string (c_eif_true)
				else
					current_file.put_string (c_eif_false)
				end
				current_file.put_character (',')
				current_file.put_character (' ')
					-- dispose.
				l_dispose_procedure := Void
				dispose_procedures.search (l_type)
				if dispose_procedures.found then
					l_dispose_procedure := dispose_procedures.found_item
				end
				if l_dispose_procedure /= Void then
					current_file.put_character ('&')
					print_routine_name (l_dispose_procedure, l_type, current_file)
				else
					current_file.put_integer (0)
				end
				if use_edp_gc then												-- GC
					current_file.put_character (',')							-- GC
					current_file.put_character (' ')							-- GC
					if l_type.has_gc_mark_routine then							-- GC
						current_file.put_string ("(void (*)(EIF_REFERENCE))(&")	-- GC
						current_file.put_string (c_gc_mark)						-- GC
						current_file.put_integer (l_type.id)					-- GC
						current_file.put_character (')')						-- GC
					else 														-- GC
						current_file.put_integer (0)							-- GC
					end															-- GC
				end																-- GC
					-- Attribute `runtime_name'.
				current_file.put_character (',')
				current_file.put_character (' ')
				current_file.put_character ('"')
				current_file.put_string (l_type.base_type.unaliased_to_text)
				current_file.put_character ('"')
					-- end of item
				current_file.put_character ('}')
				if i /= nb then
					current_file.put_character (',')
				end
				current_file.put_new_line
				i := i + 1
			end
			current_file.put_character ('}')
			current_file.put_character (';')
			current_file.put_new_line
		end

	print_type_name (a_type: ET_DYNAMIC_TYPE; a_file: KI_TEXT_OUTPUT_STREAM)
			-- Print name of `a_type' to `a_file'.
		require
			a_type_not_void: a_type /= Void
			a_file_not_void: a_file /= Void
			a_file_open_write: a_file.is_open_write
		do
			if short_names then
				a_file.put_character ('T')
				a_file.put_integer (a_type.id)
			else
-- TODO: long names
				short_names := True
				print_type_name (a_type, a_file)
				short_names := False
			end
		end

	print_boxed_type_name (a_type: ET_DYNAMIC_TYPE; a_file: KI_TEXT_OUTPUT_STREAM)
			-- Print name of boxed version of `a_type' to `a_file'.
			-- (The boxed version of a type makes sure that each object
			-- of that type contains its type-id. It can be the type itself
			-- if it already contains its type-id, or a wrapper otherwise.)
		require
			a_type_not_void: a_type /= Void
			a_file_not_void: a_file /= Void
			a_file_open_write: a_file.is_open_write
		do
			if short_names then
				a_file.put_character ('T')
				if a_type.is_expanded and then not a_type.is_generic then
					a_file.put_character ('b')
				end
				a_file.put_integer (a_type.id)
			else
-- TODO: long names
				short_names := True
				print_boxed_type_name (a_type, a_file)
				short_names := False
			end
		end

	print_struct_name (a_type: ET_DYNAMIC_TYPE; a_file: KI_TEXT_OUTPUT_STREAM)
			-- Print name of C struct corresponding to `a_type' to `a_file'.
		require
			a_type_not_void: a_type /= Void
			a_file_not_void: a_file /= Void
			a_file_open_write: a_file.is_open_write
		do
			if short_names then
				a_file.put_character ('S')
				a_file.put_integer (a_type.id)
			else
-- TODO: long names
				short_names := True
				print_struct_name (a_type, a_file)
				short_names := False
			end
		end

	print_boxed_struct_name (a_type: ET_DYNAMIC_TYPE; a_file: KI_TEXT_OUTPUT_STREAM)
			-- Print name of C struct corresponding to the boxed version of `a_type' to `a_file'.
			-- (The boxed version of a type makes sure that each object
			-- of that type contains its type-id. It can be the type itself
			-- if it already contains its type-id, or a wrapper otherwise.)
		require
			a_type_not_void: a_type /= Void
			a_file_not_void: a_file /= Void
			a_file_open_write: a_file.is_open_write
		do
			if short_names then
				a_file.put_character ('S')
				if a_type.is_expanded and then not a_type.is_generic then
					a_file.put_character ('b')
				end
				a_file.put_integer (a_type.id)
			else
-- TODO: long names
				short_names := True
				print_boxed_struct_name (a_type, a_file)
				short_names := False
			end
		end

	print_eif_any_type_name (a_file: KI_TEXT_OUTPUT_STREAM)
			-- Print name of type 'EIF_ANY' to `a_file'.
		require
			a_file_not_void: a_file /= Void
			a_file_open_write: a_file.is_open_write
		do
			if short_names then
				a_file.put_character ('T')
				a_file.put_character ('0')
			else
-- TODO: long names
				short_names := True
				print_eif_any_type_name (a_file)
				short_names := False
			end
		end

	print_type_declaration (a_type: ET_DYNAMIC_TYPE; a_file: KI_TEXT_OUTPUT_STREAM)
			-- Print declaration of `a_type' to `a_file'.
		require
			a_type_not_void: a_type /= Void
			a_file_not_void: a_file /= Void
			a_file_open_write: a_file.is_open_write
		do
			if a_type.is_expanded then
				print_type_name (a_type, a_file)
			else
				print_eif_any_type_name (a_file)
				a_file.put_character ('*')
			end
		end

	print_boxed_type_declaration (a_type: ET_DYNAMIC_TYPE; a_file: KI_TEXT_OUTPUT_STREAM)
			-- Print declaration of boxed version of `a_type' to `a_file'.
			-- (The boxed version of a type makes sure that each object
			-- of that type contains its type-id. It can be the type itself
			-- if it already contains its type-id, or a wrapper otherwise.)
		require
			a_type_not_void: a_type /= Void
			a_file_not_void: a_file /= Void
			a_file_open_write: a_file.is_open_write
		do
			print_eif_any_type_name (a_file)
			a_file.put_character ('*')
		end

	print_type_cast (a_type: ET_DYNAMIC_TYPE; a_file: KI_TEXT_OUTPUT_STREAM)
			-- Print type cast of `a_type' to `a_file'.
		require
			a_type_not_void: a_type /= Void
			a_file_not_void: a_file /= Void
			a_file_open_write: a_file.is_open_write
		do
			a_file.put_character ('(')
			print_type_name (a_type, a_file)
			if not a_type.is_expanded then
				a_file.put_character ('*')
			end
			a_file.put_character (')')
		end

	print_boxed_type_cast (a_type: ET_DYNAMIC_TYPE; a_file: KI_TEXT_OUTPUT_STREAM)
			-- Print type cast of boxed version of `a_type' to `a_file'.
			-- (The boxed version of a type makes sure that each object
			-- of that type contains its type-id. It can be the type itself
			-- if it already contains its type-id, or a wrapper otherwise.)
		require
			a_type_not_void: a_type /= Void
			a_file_not_void: a_file /= Void
			a_file_open_write: a_file.is_open_write
		do
			a_file.put_character ('(')
			print_boxed_type_name (a_type, a_file)
			a_file.put_character ('*')
			a_file.put_character (')')
		end

feature {NONE} -- Default initialization values generation

	print_default_declarations
			-- Print default initialization declaration of each type
			-- to `current_file' and their signature to `header_file'.
		local
			l_dynamic_types: DS_ARRAYED_LIST [ET_DYNAMIC_TYPE]
			l_type: ET_DYNAMIC_TYPE
			i, nb: INTEGER
		do
			l_dynamic_types := current_dynamic_system.dynamic_types
			nb := l_dynamic_types.count
			from i := 1 until i > nb loop
				l_type := l_dynamic_types.item (i)
				if l_type.is_alive then
					if not l_type.base_class.is_type_class then
						print_default_declaration (l_type)
					end
				end
				i := i + 1
			end
		end

	print_default_declaration (a_type: ET_DYNAMIC_TYPE)
			-- Print default initialization declaration of `a_type'
			-- to `current_file' and their signature to `header_file'.
		require
			a_type_not_void: a_type /= Void
		do
			header_file.put_string (c_extern)
			header_file.put_character (' ')
			print_type_name (a_type, header_file)
			print_type_name (a_type, current_file)
			header_file.put_character (' ')
			current_file.put_character (' ')
			print_default_name (a_type, header_file)
			print_default_name (a_type, current_file)
			current_file.put_character (' ')
			current_file.put_character ('=')
			current_file.put_character (' ')
			print_default_object_value (a_type, current_file)
			header_file.put_character (';')
			current_file.put_character (';')
			header_file.put_new_line
			current_file.put_new_line
		end

	print_default_name (a_type: ET_DYNAMIC_TYPE; a_file: KI_TEXT_OUTPUT_STREAM)
			-- Print to `a_file' name of default initialization for object of type `a_type'.
			-- (In case of expanded types being involved, this default initialization
			-- does not take into account possible calls to 'default_create' which need
			-- to be applied subsequently.)
		require
			a_type_not_void: a_type /= Void
			a_file_not_void: a_file /= Void
			a_file_open_write: a_file.is_open_write
		do
			if short_names then
				a_file.put_string (c_ge_default)
				a_file.put_integer (a_type.id)
			else
-- TODO: long names
				short_names := True
				print_default_name (a_type, a_file)
				short_names := False
			end
		end

	print_default_object_value (a_type: ET_DYNAMIC_TYPE; a_file: KI_TEXT_OUTPUT_STREAM)
			-- Print to `a_file' default initialization value for objects of type `a_type'.
			-- (In case of expanded types being involved, this default initialization
			-- does not take into account possible calls to 'default_create' which need
			-- to be applied subsequently.)
		require
			a_type_not_void: a_type /= Void
			a_file_not_void: a_file /= Void
			a_file_open_write: a_file.is_open_write
		local
			i, nb: INTEGER
			l_special_type: ET_DYNAMIC_SPECIAL_TYPE
			l_tuple_type: ET_DYNAMIC_TUPLE_TYPE
			l_function_type: ET_DYNAMIC_FUNCTION_TYPE
			l_procedure_type: ET_DYNAMIC_PROCEDURE_TYPE
			l_item_type_sets: ET_DYNAMIC_TYPE_SET_LIST
			l_queries: ET_DYNAMIC_FEATURE_LIST
			l_query: ET_DYNAMIC_FEATURE
			l_empty_struct: BOOLEAN
		do
			if not a_type.is_expanded or else not a_type.is_basic then
				l_empty_struct := True
				a_file.put_character ('{')
				if not a_type.is_expanded or else a_type.is_generic then
						-- Type id.
					a_file.put_integer (a_type.id)
					l_empty_struct := False
				end
				if use_edp_gc and then not a_type.is_expanded then			-- GC
						-- gc_flags											-- GC
					if not l_empty_struct then								-- GC
						a_file.put_character (',')							-- GC
					end														-- GC
					a_file.put_string (once "ITEM_IS_ALLOCATED")			-- GC
					l_empty_struct := False									-- GC
				end															-- GC
					-- Attributes.
				l_queries := a_type.queries
				nb := a_type.attribute_count
				from i := 1 until i > nb loop
					l_query := l_queries.item (i)
					if not l_empty_struct then
						a_file.put_character (',')
					end
					print_default_attribute_value (l_query.result_type_set.static_type, a_file)
					l_empty_struct := False
					i := i + 1
				end
				l_special_type ?= a_type
				if l_special_type /= Void then
						-- Items.
					if not l_empty_struct then
						a_file.put_character (',')
					end
					a_file.put_character ('{')
					print_default_attribute_value (l_special_type.item_type_set.static_type, a_file)
					a_file.put_character ('}')
					l_empty_struct := False
				else
					l_tuple_type ?= a_type
					if l_tuple_type /= Void then
						l_item_type_sets := l_tuple_type.item_type_sets
						nb := l_item_type_sets.count
						from i := 1 until i > nb loop
							if not l_empty_struct then
								a_file.put_character (',')
							end
							print_default_attribute_value (l_item_type_sets.item (i).static_type, a_file)
							l_empty_struct := False
							i := i + 1
						end
					else
						l_function_type ?= a_type
						if l_function_type /= Void then
								-- Function pointer.
							if not l_empty_struct then
								a_file.put_character (',')
							end
							a_file.put_character ('0')
							l_empty_struct := False
						else
							l_procedure_type ?= a_type
							if l_procedure_type /= Void then
									-- Function pointer.
								if not l_empty_struct then
									a_file.put_character (',')
								end
								a_file.put_character ('0')
								l_empty_struct := False
							end
						end
					end
				end
				if l_empty_struct then
						-- Add a dummy field so that the struct is not empty (not allowed in C99).
					a_file.put_character ('0')
				end
				a_file.put_character ('}')
			else
				a_file.put_character ('0')
			end
		end

	print_default_entity_value (a_type: ET_DYNAMIC_TYPE; a_file: KI_TEXT_OUTPUT_STREAM)
			-- Print to `a_file' default initialization value for entities declared of type `a_type'.
			-- Note that an entity can be a reference to an object, and in that case
			-- its default initialization value is 'Void', and not a default initialized
			-- object of the corresponding type.
			-- This routine is mainly useful when declaring entities of non-basic expanded types.
			-- (In case of expanded types being involved, this default initialization
			-- does not take into account possible calls to 'default_create' which need
			-- to be applied subsequently.)
		require
			a_type_not_void: a_type /= Void
			a_file_not_void: a_file /= Void
			a_file_open_write: a_file.is_open_write
		do
			if not a_type.is_expanded or else a_type.is_basic then
				a_file.put_character ('0')
			else
				print_default_name (a_type, a_file)
			end
		end

	print_default_attribute_value (a_type: ET_DYNAMIC_TYPE; a_file: KI_TEXT_OUTPUT_STREAM)
			-- Print to `a_file' default initialization value for attributes declared of type `a_type'.
			-- Note that an attribute is a special kind of entity, and therefore
			-- it can be a reference to an object, and in that case its default initialization
			-- value is 'Void', and not a default initialized object of the corresponding type.
			-- This routine is mainly useful for attributes of non-basic expanded types
			-- when determining the default initialization value of their enclosing objects.
			-- (In case of expanded types being involved, this default initialization
			-- does not take into account possible calls to 'default_create' which need
			-- to be applied subsequently.)
		require
			a_type_not_void: a_type /= Void
			a_file_not_void: a_file /= Void
			a_file_open_write: a_file.is_open_write
		do
			if not a_type.is_expanded or else a_type.is_basic then
				a_file.put_character ('0')
			else
				print_default_object_value (a_type, a_file)
			end
		end

feature {NONE} -- Feature name generation

	print_routine_name (a_routine: ET_DYNAMIC_FEATURE; a_type: ET_DYNAMIC_TYPE; a_file: KI_TEXT_OUTPUT_STREAM)
			-- Print name of `a_routine' from `a_type' to `a_file'.
		require
			a_routine_not_void: a_routine /= Void
			a_type_not_void: a_type /= Void
			a_file_not_void: a_file /= Void
			a_file_open_write: a_file.is_open_write
		local
			l_precursor: ET_DYNAMIC_PRECURSOR
		do
			if short_names then
				print_type_name (a_type, a_file)
				a_file.put_character ('f')
				l_precursor ?= a_routine
				if l_precursor /= Void then
					a_file.put_integer (l_precursor.current_feature.id)
					a_file.put_character ('p')
				end
				a_file.put_integer (a_routine.id)
			else
-- TODO: long names
				short_names := True
				print_routine_name (a_routine, a_type, a_file)
				short_names := False
			end
		end

	print_static_routine_name (a_routine: ET_DYNAMIC_FEATURE; a_type: ET_DYNAMIC_TYPE; a_file: KI_TEXT_OUTPUT_STREAM)
			-- Print name of static feature `a_feature' to `a_file'.
		require
			a_routine_not_void: a_routine /= Void
			a_routine_static: a_routine.is_static
			a_type_not_void: a_type /= Void
			a_file_not_void: a_file /= Void
			a_file_open_write: a_file.is_open_write
		local
			l_precursor: ET_DYNAMIC_PRECURSOR
		do
			if short_names then
				print_type_name (a_type, a_file)
				a_file.put_character ('s')
				l_precursor ?= a_routine
				if l_precursor /= Void then
					a_file.put_integer (l_precursor.current_feature.id)
					a_file.put_character ('p')
				end
				a_file.put_integer (a_routine.id)
			else
-- TODO: long names
				short_names := True
				print_static_routine_name (a_routine, a_type, a_file)
				short_names := False
			end
		end

	print_creation_procedure_name (a_procedure: ET_DYNAMIC_FEATURE; a_type: ET_DYNAMIC_TYPE; a_file: KI_TEXT_OUTPUT_STREAM)
			-- Print name of creation procedure `a_procedure' to `a_file'.
		require
			a_procedure_not_void: a_procedure /= Void
			a_procedure_creation: a_procedure.is_creation
			a_type_not_void: a_type /= Void
			a_file_not_void: a_file /= Void
			a_file_open_write: a_file.is_open_write
		do
			if short_names then
				print_type_name (a_type, a_file)
				a_file.put_character ('c')
				a_file.put_integer (a_procedure.id)
			else
-- TODO: long names
				short_names := True
				print_creation_procedure_name (a_procedure, a_type, a_file)
				short_names := False
			end
		end

	print_attribute_name (an_attribute: ET_DYNAMIC_FEATURE; a_type: ET_DYNAMIC_TYPE; a_file: KI_TEXT_OUTPUT_STREAM)
			-- Print to `a_file' the name of `an_attribute' for objects of type `a_type'.
		require
			an_attribute_not_void: an_attribute /= Void
			a_type_not_void: a_type /= Void
			a_file_not_void: a_file /= Void
			a_file_open_write: a_file.is_open_write
		do
			if short_names then
				a_file.put_character ('a')
				a_file.put_integer (an_attribute.id)
			else
-- TODO: long names
				short_names := True
				print_attribute_name (an_attribute, a_type, a_file)
				short_names := False
			end
		end

	print_attribute_type_id_name (a_type: ET_DYNAMIC_TYPE; a_file: KI_TEXT_OUTPUT_STREAM)
			-- Print to `a_file' the name of the 'type_id' pseudo attribute for objects of type `a_type'
		require
			a_type_not_void: a_type /= Void
			a_file_not_void: a_file /= Void
			a_file_open_write: a_file.is_open_write
		do
			if short_names then
				a_file.put_string (c_id)
			else
-- TODO: long names
				short_names := True
				print_attribute_type_id_name (a_type, a_file)
				short_names := False
			end
		end

	print_attribute_special_item_name (a_type: ET_DYNAMIC_TYPE; a_file: KI_TEXT_OUTPUT_STREAM)
			-- Print to `a_file' the name of the 'item' pseudo attribute for 'SPECIAL' objects of type `a_type'.
		require
			a_type_not_void: a_type /= Void
			a_file_not_void: a_file /= Void
			a_file_open_write: a_file.is_open_write
		do
			if short_names then
				a_file.put_character ('z')
				a_file.put_character ('2')
			else
-- TODO: long names
				short_names := True
				print_attribute_special_item_name (a_type, a_file)
				short_names := False
			end
		end

	print_attribute_special_capacity_name (a_type: ET_DYNAMIC_TYPE; a_file: KI_TEXT_OUTPUT_STREAM)
			-- Print to `a_file' the name of the 'capacity' pseudo attribute for 'SPECIAL' objects of type `a_type'.
		require
			a_type_not_void: a_type /= Void
			a_file_not_void: a_file /= Void
			a_file_open_write: a_file.is_open_write
		do
			if short_names then
				if a_type.attribute_count < 1 then
						-- Internal error: class "SPECIAL" should have at least the
						-- feature 'count' as first feature.
						-- Already reported in ET_DYNAMIC_SYSTEM.compile_kernel.
					set_fatal_error
					error_handler.report_giaaa_error
				else
					print_attribute_name (a_type.queries.first, a_type, a_file)
				end
			else
-- TODO: long names
				short_names := True
				print_attribute_special_capacity_name (a_type, a_file)
				short_names := False
			end
		end

	print_attribute_special_count_name (a_type: ET_DYNAMIC_TYPE; a_file: KI_TEXT_OUTPUT_STREAM)
			-- Print to `a_file' the name of the 'count' pseudo attribute for 'SPECIAL' objects of type `a_type'.
		require
			a_type_not_void: a_type /= Void
			a_file_not_void: a_file /= Void
			a_file_open_write: a_file.is_open_write
		do
			if short_names then
				if a_type.attribute_count < 1 then
						-- Internal error: class "SPECIAL" should have at least the
						-- feature 'count' as first feature.
						-- Already reported in ET_DYNAMIC_SYSTEM.compile_kernel.
					set_fatal_error
					error_handler.report_giaaa_error
				else
					print_attribute_name (a_type.queries.first, a_type, a_file)
				end
			else
-- TODO: long names
				short_names := True
				print_attribute_special_count_name (a_type, a_file)
				short_names := False
			end
		end

	print_attribute_tuple_item_name (i: INTEGER; a_type: ET_DYNAMIC_TYPE; a_file: KI_TEXT_OUTPUT_STREAM)
			-- Print to `a_file' then name of the `i'-th 'item' pseudo attribute for 'TUPLE' objects of type `a_type'.
		require
			a_type_not_void: a_type /= Void
			a_file_not_void: a_file /= Void
			a_file_open_write: a_file.is_open_write
		do
			if short_names then
				a_file.put_character ('z')
				a_file.put_integer (i)
			else
-- TODO: long names
				short_names := True
				print_attribute_tuple_item_name (i, a_type, a_file)
				short_names := False
			end
		end

	print_attribute_routine_function_name (a_type: ET_DYNAMIC_TYPE; a_file: KI_TEXT_OUTPUT_STREAM)
			-- Print to `a_file' the name of the function pointer pseudo attribute for 'ROUTINE' objects of type `a_type'.
		require
			a_type_not_void: a_type /= Void
			a_file_not_void: a_file /= Void
			a_file_open_write: a_file.is_open_write
		do
			if short_names then
				a_file.put_character ('f')
			else
-- TODO: long names
				short_names := True
				print_attribute_routine_function_name (a_type, a_file)
				short_names := False
			end
		end

	print_boxed_attribute_item_name (a_type: ET_DYNAMIC_TYPE; a_file: KI_TEXT_OUTPUT_STREAM)
			-- Print to `a_file' then name of the 'item' pseudo attribute of boxed version of `a_type'.
			-- (The boxed version of a type makes sure that each object
			-- of that type contains its type-id. It can be the type itself
			-- if it already contains its type-id, or a wrapper otherwise.)
		require
			a_type_not_void: a_type /= Void
			a_file_not_void: a_file /= Void
			a_file_open_write: a_file.is_open_write
		do
			if short_names then
				a_file.put_character ('z')
				a_file.put_character ('1')
			else
-- TODO: long names
				short_names := True
				print_boxed_attribute_item_name (a_type, a_file)
				short_names := False
			end
		end

	print_call_name (a_call: ET_CALL_COMPONENT; a_caller: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_file: KI_TEXT_OUTPUT_STREAM)
			-- Print name of `a_call' appearing in `a_caller' with `a_target_type' as target static type to `a_file'.
		require
			a_call_not_void: a_call /= Void
			a_caller_not_void: a_caller /= Void
			a_target_type_not_void: a_target_type /= Void
			a_file_not_void: a_file /= Void
			a_file_open_write: a_file.is_open_write
		local
			l_arguments: ET_ARGUMENT_OPERANDS
			l_argument_type_set: ET_DYNAMIC_TYPE_SET
			l_argument_type: ET_DYNAMIC_TYPE
			l_manifest_tuple: ET_MANIFEST_TUPLE
			l_seed: INTEGER
			i, nb: INTEGER
		do
			if short_names then
				l_seed := a_call.name.seed
				l_arguments := a_call.arguments
				print_type_name (a_target_type, a_file)
				a_file.put_character ('x')
				if a_call.is_tuple_label then
					a_file.put_character ('t')
				elseif (l_seed = current_system.routine_call_seed or l_seed = current_system.function_item_seed) and then not a_call.is_call_agent then
					if l_arguments /= Void and then l_arguments.count = 1 then
						l_manifest_tuple ?= l_arguments.actual_argument (1)
						if l_manifest_tuple /= Void then
							a_file.put_character ('m')
							a_file.put_character ('t')
						end
					end
				end
				a_file.put_integer (l_seed)
				if l_manifest_tuple /= Void then
					l_argument_type_set := dynamic_type_set_in_feature (l_manifest_tuple, a_caller)
					print_type_name (l_argument_type_set.static_type, a_file)
				elseif l_arguments /= Void then
					nb := l_arguments.count
					from i := 1 until i > nb loop
						l_argument_type_set := dynamic_type_set_in_feature (l_arguments.actual_argument (i), a_caller)
						l_argument_type := l_argument_type_set.static_type
						if l_argument_type.is_expanded then
							print_type_name (l_argument_type, a_file)
						else
							print_eif_any_type_name (a_file)
						end
						i := i + 1
					end
				end
			else
-- TODO: long names
				short_names := True
				print_call_name (a_call, a_caller, a_target_type, a_file)
				short_names := False
			end
		end

	print_argument_name (a_name: ET_IDENTIFIER; a_file: KI_TEXT_OUTPUT_STREAM)
			-- Print name of argument `a_name' to `a_file'.
		require
			a_name_not_void: a_name /= Void
			a_name_argument: a_name.is_argument
			a_file_not_void: a_file /= Void
			a_file_open_write: a_file.is_open_write
		do
			if short_names then
				a_file.put_character ('a')
				a_file.put_integer (a_name.seed)
			else
-- TODO: long names
				short_names := True
				print_argument_name (a_name, a_file)
				short_names := False
			end
		end

-- GC mods

	print_local_name (a_name: ET_IDENTIFIER; a_file: KI_TEXT_OUTPUT_STREAM)
			-- Print name of local variable `a_name' to `a_file'.
		require
			a_name_not_void: a_name /= Void
			a_name_local: a_name.is_local
			a_file_not_void: a_file /= Void
			a_file_open_write: a_file.is_open_write
		do
			if enable_locals_as_struct and in_internal_routine and not in_locals_declaration then	-- GC
				a_file.put_character ('l')															-- GC
				a_file.put_character ('o')															-- GC
				a_file.put_character ('c')
				a_file.put_character ('a')
				a_file.put_character ('l')
				a_file.put_character ('s')
				a_file.put_character ('.')
			end																						-- GC end
			if short_names then
				a_file.put_character ('l')
				a_file.put_integer (a_name.seed)
			else
-- TODO: long names
				short_names := True
				print_local_name (a_name, a_file)
				short_names := False
			end
		end

	print_object_test_local_name (a_name: ET_IDENTIFIER; a_file: KI_TEXT_OUTPUT_STREAM)
			-- Print name of object-test local `a_name' to `a_file'.
		require
			a_name_not_void: a_name /= Void
			a_name_object_test_local: a_name.is_object_test_local
			a_file_not_void: a_file /= Void
			a_file_open_write: a_file.is_open_write
		do
			if short_names then
				a_file.put_character ('m')
				a_file.put_integer (a_name.seed)
			else
-- TODO: long names
				short_names := True
				print_object_test_local_name (a_name, a_file)
				short_names := False
			end
		end

	print_object_test_function_name (i: INTEGER; a_routine: ET_DYNAMIC_FEATURE; a_type: ET_DYNAMIC_TYPE; a_file: KI_TEXT_OUTPUT_STREAM)
			-- Print name of `i'-th object-test function appearing in `a_routine' from `a_type' to `a_file'.
		require
			a_routine_not_void: a_routine /= Void
			a_type_not_void: a_type /= Void
			a_file_not_void: a_file /= Void
			a_file_open_write: a_file.is_open_write
		do
			print_routine_name (a_routine, a_type, a_file)
			a_file.put_character ('o')
			a_file.put_character ('t')
			a_file.put_integer (i)
		end

	print_equality_function_name (i: INTEGER; a_routine: ET_DYNAMIC_FEATURE; a_type: ET_DYNAMIC_TYPE; a_file: KI_TEXT_OUTPUT_STREAM)
			-- Print name of `i'-th equality ('=' or '/=') function appearing in `a_routine' from `a_type' to `a_file'.
			-- We need a function for equality when the dynamic type set of operands
			-- contains expanded types.
		require
			a_routine_not_void: a_routine /= Void
			a_type_not_void: a_type /= Void
			a_file_not_void: a_file /= Void
			a_file_open_write: a_file.is_open_write
		do
			print_routine_name (a_routine, a_type, a_file)
			a_file.put_character ('e')
			a_file.put_integer (i)
		end

	print_object_equality_function_name (i: INTEGER; a_routine: ET_DYNAMIC_FEATURE; a_type: ET_DYNAMIC_TYPE; a_file: KI_TEXT_OUTPUT_STREAM)
			-- Print name of `i'-th object-equality ('~' or '/~') function appearing in `a_routine' from `a_type' to `a_file'.
		require
			a_routine_not_void: a_routine /= Void
			a_type_not_void: a_type /= Void
			a_file_not_void: a_file /= Void
			a_file_open_write: a_file.is_open_write
		do
			print_routine_name (a_routine, a_type, a_file)
			a_file.put_character ('o')
			a_file.put_character ('e')
			a_file.put_integer (i)
		end

	print_temp_name (a_name: ET_IDENTIFIER; a_file: KI_TEXT_OUTPUT_STREAM)
			-- Print name of temporary variable `a_name' to `a_file'.
		require
			a_name_not_void: a_name /= Void
			a_name_temp: a_name.is_temporary
			a_file_not_void: a_file /= Void
			a_file_open_write: a_file.is_open_write
		do
			if short_names then
				a_file.put_character ('t')
				a_file.put_integer (a_name.seed)
			else
-- TODO: long names
				short_names := True
				print_temp_name (a_name, a_file)
				short_names := False
			end
		end

	print_current_name (a_file: KI_TEXT_OUTPUT_STREAM)
			-- Print name of 'Current' to `a_file'.
		require
			a_file_not_void: a_file /= Void
			a_file_open_write: a_file.is_open_write
		do
			if short_names then
				a_file.put_character ('C')
			else
-- TODO: long names
				short_names := True
				print_current_name (a_file)
				short_names := False
			end
		end

-- GC Mods ...

	print_result_name (a_file: KI_TEXT_OUTPUT_STREAM)
			-- Print name of 'Result' to `a_file'.
		require
			a_file_not_void: a_file /= Void
			a_file_open_write: a_file.is_open_write
		do
			if enable_locals_as_struct and in_internal_routine and not in_locals_declaration then	-- GC
				a_file.put_character ('l')
				a_file.put_character ('o')
				a_file.put_character ('c')
				a_file.put_character ('a')
				a_file.put_character ('l')
				a_file.put_character ('s')
				a_file.put_character ('.')
			end																						-- GC end
			if short_names then
				a_file.put_character ('R')
			else
-- TODO: long names
				short_names := True
				print_result_name (a_file)
				short_names := False
			end
		end

	print_once_status_name (a_feature: ET_FEATURE; a_file: KI_TEXT_OUTPUT_STREAM)
			-- Print name of variable holding the status of execution
			-- of the once-feature `a_feature' to `a_file'.
		require
			a_feature_not_void: a_feature /= Void
			implementation_feature: a_feature = a_feature.implementation_feature
			a_file_not_void: a_file /= Void
			a_file_open_write: a_file.is_open_write
		do
			a_file.put_character ('g')
			a_file.put_character ('e')
			a_file.put_integer (a_feature.implementation_class.id)
			a_file.put_character ('o')
			a_file.put_character ('s')
			a_file.put_integer (a_feature.first_seed)
		end

	print_once_value_name (a_feature: ET_FEATURE; a_file: KI_TEXT_OUTPUT_STREAM)
			-- Print name of variable holding the value of first
			-- execution of the once-feature `a_feature' to `a_file'.
		require
			a_feature_not_void: a_feature /= Void
			implementation_feature: a_feature = a_feature.implementation_feature
			a_file_not_void: a_file /= Void
			a_file_open_write: a_file.is_open_write
		do
			a_file.put_character ('g')
			a_file.put_character ('e')
			a_file.put_integer (a_feature.implementation_class.id)
			a_file.put_character ('o')
			a_file.put_character ('v')
			a_file.put_integer (a_feature.first_seed)
		end

	print_agent_creation_name (i: INTEGER; a_routine: ET_DYNAMIC_FEATURE; a_type: ET_DYNAMIC_TYPE; a_file: KI_TEXT_OUTPUT_STREAM)
			-- Print name of creation function of `i'-th agent appearing in `a_routine' from `a_type' to `a_file'.
		require
			a_routine_not_void: a_routine /= Void
			a_type_not_void: a_type /= Void
			a_file_not_void: a_file /= Void
			a_file_open_write: a_file.is_open_write
		do
			print_routine_name (a_routine, a_type, a_file)
			a_file.put_character ('a')
			a_file.put_character ('c')
			a_file.put_integer (i)
		end

	print_agent_function_name (i: INTEGER; a_routine: ET_DYNAMIC_FEATURE; a_type: ET_DYNAMIC_TYPE; a_file: KI_TEXT_OUTPUT_STREAM)
			-- Print name of function associated with `i'-th agent appearing in `a_routine' from `a_type' to `a_file'.
		require
			a_routine_not_void: a_routine /= Void
			a_type_not_void: a_type /= Void
			a_file_not_void: a_file /= Void
			a_file_open_write: a_file.is_open_write
		do
			print_routine_name (a_routine, a_type, a_file)
			a_file.put_character ('a')
			a_file.put_character ('f')
			a_file.put_integer (i)
		end

	print_inline_constant_name (a_constant: ET_INLINE_CONSTANT; a_file: KI_TEXT_OUTPUT_STREAM)
			-- Print name of variable holding the value of inline constant
			-- `a_constant' (such as a once manifest string) to `a_file'.
		require
			a_constant_not_void: a_constant /= Void
			a_file_not_void: a_file /= Void
			a_file_open_write: a_file.is_open_write
		do
			a_file.put_character ('g')
			a_file.put_character ('e')
			a_file.put_character ('i')
			a_file.put_character ('c')
			a_file.put_integer (a_constant.id)
		end

	print_feature_name_comment (a_feature: ET_FEATURE; a_type: ET_DYNAMIC_TYPE; a_file: KI_TEXT_OUTPUT_STREAM)
			-- Print name of `a_feature' from `a_type' as a C comment to `a_file'.
		require
			a_feature_not_void: a_feature /= Void
			a_type_not_void: a_type /= Void
			a_file_not_void: a_file /= Void
			a_file_open_write: a_file.is_open_write
		do
			a_file.put_character ('/')
			a_file.put_character ('*')
			a_file.put_character (' ')
			a_file.put_string (a_type.base_type.unaliased_to_text)
			a_file.put_character ('.')
			a_file.put_string (STRING_.replaced_all_substrings (a_feature.lower_name, "*/", "star/"))
			a_file.put_character (' ')
			a_file.put_character ('*')
			a_file.put_character ('/')
			a_file.put_new_line
		end

	print_call_name_comment (a_call: ET_CALL_COMPONENT; a_caller: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE; a_file: KI_TEXT_OUTPUT_STREAM)
			-- Print name of `a_call', appearing in `a_caller' with `a_type' as target static type, as a C comment to `a_file'.
		require
			a_call_not_void: a_call /= Void
			a_caller_not_void: a_caller /= Void
			a_target_type_not_void: a_target_type /= Void
			a_file_not_void: a_file /= Void
			a_file_open_write: a_file.is_open_write
		local
			l_arguments: ET_ARGUMENT_OPERANDS
			l_argument_type_set: ET_DYNAMIC_TYPE_SET
			l_manifest_tuple: ET_MANIFEST_TUPLE
			l_seed: INTEGER
		do
			a_file.put_character ('/')
			a_file.put_character ('*')
			a_file.put_character (' ')
			a_file.put_character ('C')
			a_file.put_character ('a')
			a_file.put_character ('l')
			a_file.put_character ('l')
			a_file.put_character (' ')
			a_file.put_character ('t')
			a_file.put_character ('o')
			a_file.put_character (' ')
			a_file.put_string (a_target_type.base_type.unaliased_to_text)
			a_file.put_character ('.')
			a_file.put_string (STRING_.replaced_all_substrings (a_call.name.lower_name, "*/", "star/"))
			l_seed := a_call.name.seed
			if a_call.is_tuple_label then
				a_file.put_string (once " (label on item #")
				a_file.put_integer (l_seed)
				a_file.put_character (')')
			elseif (l_seed = current_system.routine_call_seed or l_seed = current_system.function_item_seed) and then not a_call.is_call_agent then
				l_arguments := a_call.arguments
				if l_arguments /= Void and then l_arguments.count = 1 then
					l_manifest_tuple ?= l_arguments.actual_argument (1)
					if l_manifest_tuple /= Void then
						a_file.put_string (once " with a manifest tuple argument")
						l_argument_type_set := dynamic_type_set_in_feature (l_manifest_tuple, a_caller)
						a_file.put_string (once " of type ")
						a_file.put_string (l_argument_type_set.static_type.base_type.unaliased_to_text)
					end
				end
			end
			a_file.put_character (' ')
			a_file.put_character ('*')
			a_file.put_character ('/')
			a_file.put_new_line
		end

feature {NONE} -- String generation

	print_escaped_string (a_string: STRING)
			-- Print escaped version of `a_string'.
		require
			a_string_not_void: a_string /= Void
		local
			i, nb: INTEGER
			c: CHARACTER
			l_code: INTEGER
			l_splitted: BOOLEAN
			l_split_size: INTEGER
		do
			l_split_size := 512
			current_file.put_character ('%"')
			nb := a_string.count
			from i := 1 until i > nb loop
				if (i \\ l_split_size) = 1 and i /= 1 then
						-- Some C compilers don't accept too big strings.
						-- Split them in several smaller ones.
					current_file.put_character ('%"')
					if not l_splitted then
						l_splitted := True
						indent
					end
					current_file.put_new_line
					print_indentation
					current_file.put_character ('%"')
				end
				c := a_string.item (i)
				inspect c
				when ' ', '!', '#', '$', '&', '('..'>', '@'..'[', ']'..'~' then
					current_file.put_character (c)
				when '%N' then
					current_file.put_character ('\')
					current_file.put_character ('n')
				when '%R' then
					current_file.put_character ('\')
					current_file.put_character ('r')
				when '%T' then
					current_file.put_character ('\')
					current_file.put_character ('t')
				when '%U' then
					current_file.put_character ('\')
					current_file.put_character ('0')
					current_file.put_character ('0')
					current_file.put_character ('0')
				when '\' then
					current_file.put_character ('\')
					current_file.put_character ('\')
				when '%'' then
					current_file.put_character ('\')
					current_file.put_character ('%'')
				when '%"' then
					current_file.put_character ('\')
					current_file.put_character ('%"')
				when '?' then
						-- Make sure that ? is not recognized as
						-- part of a trigraph sequence.
					current_file.put_character ('\')
					current_file.put_character ('?')
				else
					current_file.put_character ('\')
					l_code := c.code
					if l_code < 8 then
						current_file.put_character ('0')
						current_file.put_character ('0')
					elseif l_code < 64 then
						current_file.put_character ('0')
					end
					INTEGER_FORMATTER_.put_octal_integer (current_file, l_code)
				end
				i := i + 1
			end
			current_file.put_character ('%"')
			if l_splitted then
				dedent
			end
		end

	print_escaped_character (c: CHARACTER)
			-- Print escaped version of `c'.
		local
			l_code: INTEGER
		do
			current_file.put_character ('%'')
			inspect c
			when ' ', '!', '#', '$', '&', '('..'[', ']'..'~' then
				current_file.put_character (c)
			when '%N' then
				current_file.put_character ('\')
				current_file.put_character ('n')
			when '%R' then
				current_file.put_character ('\')
				current_file.put_character ('r')
			when '%T' then
				current_file.put_character ('\')
				current_file.put_character ('t')
			when '%U' then
				current_file.put_character ('\')
				current_file.put_character ('0')
				current_file.put_character ('0')
				current_file.put_character ('0')
			when '\' then
				current_file.put_character ('\')
				current_file.put_character ('\')
			when '%'' then
				current_file.put_character ('\')
				current_file.put_character ('%'')
			when '%"' then
				current_file.put_character ('\')
				current_file.put_character ('%"')
			else
				current_file.put_character ('\')
				l_code := c.code
				if l_code < 8 then
					current_file.put_character ('0')
					current_file.put_character ('0')
				elseif l_code < 64 then
					current_file.put_character ('0')
				end
				INTEGER_FORMATTER_.put_octal_integer (current_file, l_code)
			end
			current_file.put_character ('%'')
		end

feature {NONE} -- Indentation

	indentation: INTEGER
			-- Indentation in `current_file'

	indent
			-- Increment indentation.
		do
			indentation := indentation + 1
		end

	dedent
			-- Decrement indentation.
		do
			indentation := indentation - 1
		end

	print_indentation
			-- Print indentation to `current_file'.
		local
			i, nb: INTEGER
		do
			nb := indentation
			from i := 1 until i > nb loop
				current_file.put_character ('%T')
				i := i + 1
			end
		end

feature {NONE} -- Convenience

	print_indentation_assign_to_result
			-- Print indentation followed by 'R = ' to `current_file'.
		do
			print_indentation
			print_result_name (current_file)
			current_file.put_character (' ')
			current_file.put_character ('=')
			current_file.put_character (' ')
		end

	print_semicolon_newline
			-- Print a semicolon followed by a newline to `current_file'.
		do
			current_file.put_character (';')
			current_file.put_new_line
		end

	print_start_extern_c (a_file: KI_TEXT_OUTPUT_STREAM)
			-- Print to `a_file' the beginning of 'extern "C"' section.
		require
			a_file_not_void: a_file /= Void
			a_file_open_write: a_file.is_open_write
		do
			a_file.put_line ("#ifdef __cplusplus")
			a_file.put_line ("extern %"C%" {")
			a_file.put_line ("#endif")
			a_file.put_new_line
		end

	print_end_extern_c (a_file: KI_TEXT_OUTPUT_STREAM)
			-- Print to `a_file' the end of 'extern "C"' section.
		require
			a_file_not_void: a_file /= Void
			a_file_open_write: a_file.is_open_write
		do
			a_file.put_new_line
			a_file.put_line ("#ifdef __cplusplus")
			a_file.put_line ("}")
			a_file.put_line ("#endif")
		end

feature -- EDP GC Mark routines

	print_edp_gc_mark_routines is
			-- Print routines to mark objects reachable from each object type
			-- Boxed items may contain references ...
			-- SPECIAL [ EXPANDED_TYPE_CONTAINING_REFERENCES ]
		require
			edp_gc_enabled: use_edp_gc
		local
			l_dynamic_types: DS_ARRAYED_LIST [ET_DYNAMIC_TYPE]
			l_type: ET_DYNAMIC_TYPE
			l_tuple_item_type: ET_DYNAMIC_TYPE
			l_meta_type: ET_DYNAMIC_TYPE
			l_queries: ET_DYNAMIC_FEATURE_LIST
			l_query: ET_DYNAMIC_FEATURE
			l_special_type: ET_DYNAMIC_SPECIAL_TYPE
			l_tuple_type: ET_DYNAMIC_TUPLE_TYPE
			l_function_type: ET_DYNAMIC_FUNCTION_TYPE
			l_procedure_type: ET_DYNAMIC_PROCEDURE_TYPE
			l_open_operand_type_sets: ET_DYNAMIC_TYPE_SET_LIST
			l_item_type_set: ET_DYNAMIC_TYPE_SET
			l_item_type_sets: ET_DYNAMIC_TYPE_SET_LIST
			i, nb: INTEGER
			j, nb2: INTEGER
			l_omitted: STRING
			l_has_nested_references: BOOLEAN
			l_special_universe: ET_UNIVERSE
			l_attribute: ET_DYNAMIC_FEATURE
			l_attribute_type_set: ET_DYNAMIC_TYPE_SET
			l_attribute_type: ET_DYNAMIC_TYPE
			l_temp: ET_IDENTIFIER
		do
			l_dynamic_types := current_dynamic_system.dynamic_types
			nb := l_dynamic_types.count
			from i := 1 until i > nb loop
				l_type := l_dynamic_types.item (i)
				current_file.put_string (once "/* GC Mark routine for: ")
				current_file.put_string (l_type.base_type.unaliased_to_text)
				current_file.put_string (once " */")
				current_file.put_new_line
				current_file.put_new_line
				if l_type.is_used then
					l_has_nested_references := l_type.has_nested_reference_attributes
					if l_has_nested_references then
							-- Emit a routine to GC mark an object of this type
-- TODO set_has_gc_mark_routine
						l_type.set_gc_mark_type (3)
							-- declare routine
						header_file.put_string (c_void)
						header_file.put_character (' ')
						header_file.put_string (c_gc_mark)
						header_file.put_integer (l_type.id)
						header_file.put_character ('(')
						print_type_name (l_type, header_file)
						header_file.put_character (' ')
						header_file.put_character ('*')
						header_file.put_character (')')
						header_file.put_character (';')
						header_file.put_new_line
							-- define routine
						current_file.put_string (c_void)
						current_file.put_character (' ')
						current_file.put_string (c_gc_mark)
						current_file.put_integer (l_type.id)
						current_file.put_character ('(')
						print_type_name (l_type, current_file)
						current_file.put_character (' ')
						current_file.put_character ('*')
						current_file.put_character ('C')
						current_file.put_character (')')
						current_file.put_new_line
						current_file.put_character ('{')
						current_file.put_new_line
						indent						
						l_special_type ?= l_type
						if l_special_type /= Void then
								-- Mark items.
-- TODO: Fix local variable declarations ...
-- See print_set_deep_twined_attribute
							current_file.put_string (once "int t1;")
							current_file.put_new_line
							l_attribute_type_set := l_special_type.item_type_set
							l_attribute_type := l_attribute_type_set.static_type
							l_special_universe := current_system.special_any_type.base_class.universe
							if l_special_universe = Void then
									-- Internal error: class "SPECIAL" should be known at this stage!
								set_fatal_error
								error_handler.report_giaaa_error_cl ("__CLASS__", "__LINE__")
							elseif l_attribute_type_set.is_empty then
									-- If the dynamic type set of the items is empty,
									-- then the items is always Void. No need to twin
									-- it in that case.
							elseif l_attribute_type.is_expanded then
									-- If the items are expanded we need to mark them only if
									-- they themselves contain (recursively) reference attributes.
								if l_attribute_type.has_nested_reference_attributes then
									l_temp := new_temp_variable (current_dynamic_system.integer_32_type)
									print_indentation
									current_file.put_string (c_for)
									current_file.put_character (' ')
									current_file.put_character ('(')
									print_temp_name (l_temp, current_file)
									current_file.put_character (' ')
									current_file.put_character ('=')
									current_file.put_character (' ')
									print_attribute_special_count_access (tokens.current_keyword, l_special_type, False)
									current_file.put_character (' ')
									current_file.put_character ('-')
									current_file.put_character (' ')
									current_file.put_character ('1')
									current_file.put_character (';')
									current_file.put_character (' ')
									print_temp_name (l_temp, current_file)
									current_file.put_character (' ')
									current_file.put_character ('>')
									current_file.put_character ('=')
									current_file.put_character (' ')
									current_file.put_character ('0')
									current_file.put_character (';')
									current_file.put_character (' ')
									print_temp_name (l_temp, current_file)
									current_file.put_character ('-')
									current_file.put_character ('-')
									current_file.put_character (')')
									current_file.put_character (' ')
									current_file.put_character ('{')
									current_file.put_new_line
									indent
-- TODO: Recursive expanded attributes ...
print (once "GC mark Routine for a SPECIAL [Expanded_type]%N")
									print_gc_mark_attribute (l_attribute_type_set, agent print_attribute_special_indexed_item_access (l_temp,  tokens.current_keyword, l_type, False))
									dedent
									print_indentation
									current_file.put_character ('}')
									current_file.put_new_line
									mark_temp_variable_free (l_temp)
								end
							else
									-- We are in the case of reference items in a SPECIAL type
								l_temp := new_temp_variable (current_dynamic_system.integer_32_type)
								print_indentation
								current_file.put_string (c_for)
								current_file.put_character (' ')
								current_file.put_character ('(')
								print_temp_name (l_temp, current_file)
								current_file.put_character (' ')
								current_file.put_character ('=')
								current_file.put_character (' ')
								print_attribute_special_count_access (tokens.current_keyword, l_special_type, False)
								current_file.put_character (' ')
								current_file.put_character ('-')
								current_file.put_character (' ')
								current_file.put_character ('1')
								current_file.put_character (';')
								current_file.put_character (' ')
								print_temp_name (l_temp, current_file)
								current_file.put_character (' ')
								current_file.put_character ('>')
								current_file.put_character ('=')
								current_file.put_character (' ')
								current_file.put_character ('0')
								current_file.put_character (';')
								current_file.put_character (' ')
								print_temp_name (l_temp, current_file)
								current_file.put_character ('-')
								current_file.put_character ('-')
								current_file.put_character (')')
								current_file.put_character (' ')
								current_file.put_character ('{')
								current_file.put_new_line
								indent
								print_gc_mark_attribute (l_attribute_type_set, agent print_attribute_special_indexed_item_access (l_temp,  tokens.current_keyword, l_type, False))
								dedent
								print_indentation
								current_file.put_character ('}')
								current_file.put_new_line
								mark_temp_variable_free (l_temp)
							end
						else
							l_queries := l_type.queries
							nb2 := l_type.attribute_count
							from j := 1 until j > nb2 loop
								l_attribute := l_queries.item (j)
								l_attribute_type_set := l_attribute.result_type_set
								l_attribute_type := l_attribute_type_set.static_type
								if l_attribute_type_set.is_empty then
										-- If the dynamic type set of the attribute is empty,
										-- then this attribute is always Void. No need to mark
										-- it in that case.
								elseif l_attribute_type.is_expanded then
										-- If the attribute is expanded, then we need to mark it only if
										-- it itself contains (recursively) reference attributes.
									if l_attribute_type.has_nested_reference_attributes then
-- TODO: Recursive expanded attributes ...
print (once "GC mark Routine for an attribute of and Expanded_type%N")
										print_gc_mark_attribute (l_attribute_type_set, agent print_attribute_access (l_attribute, tokens.current_keyword, l_type, False))
									end
								else
									print_gc_mark_attribute (l_attribute_type_set, agent print_attribute_access (l_attribute, tokens.current_keyword, l_type, False))
								end
								j := j + 1
							end
							l_tuple_type ?= l_type
							if l_tuple_type /= Void then
								l_item_type_sets := l_tuple_type.item_type_sets
								nb2 := l_item_type_sets.count
								from j := 1 until j > nb2 loop
									l_attribute_type_set := l_item_type_sets.item (j)
									l_attribute_type := l_attribute_type_set.static_type
									if l_attribute_type_set.is_empty then
											-- If the dynamic type set of the item is empty,
											-- then this item is always Void. No need to mark
											-- it in that case.
									elseif l_attribute_type.is_expanded then
											-- If the item is expanded, then we need to mark it only if
											-- it itself contains (recursively) reference attributes.
										if l_attribute_type.has_nested_reference_attributes then
-- TODO: Recursive expanded attributes ...
print (once "GC mark Routine for a tuple with item(s) of an Expanded_type%N")
											print_gc_mark_attribute (l_attribute_type_set, agent print_attribute_tuple_item_access (j, tokens.current_keyword, l_type, False))
										end
									else
										print_gc_mark_attribute (l_attribute_type_set, agent print_attribute_tuple_item_access (j, tokens.current_keyword, l_type, False))
									end
									j := j + 1
								end
							end
						end
						dedent
						current_file.put_character ('}')
						current_file.put_new_line
					end -- has_nested_references ?
				end -- is_used ?
				if l_omitted /= Void then
					current_file.put_line (once "/* Omitted: ")
					current_file.put_string (l_omitted)
					current_file.put_string (" */")
					current_file.put_new_line
				end
				i := i + 1
			end -- loop
			current_file.put_new_line
			current_file.put_new_line
		end

	print_gc_mark_attribute (an_attribute_type_set: ET_DYNAMIC_TYPE_SET; a_print_attribute_access: PROCEDURE [ANY, TUPLE]) is
			-- Print to `current_file' the instructions needed to mark an attribute
			-- of `current_type' whose dynamic type set is `an_attribute_type_set'.
			-- `a_print_attribute_access' is used to print to `current_file'
			-- the code to access this attribute. Indeed, it can be a "regular"
			-- attribute, but it can also be items of a SPECIAL object, fields
			-- of a TUPLE object, closed operands of an Agent object, ...
		require
			an_attribute_type_set_not_void: an_attribute_type_set /= Void
			an_attribute_type_set_not_empty: not an_attribute_type_set.is_empty
			a_print_attribute_access_not_void: a_print_attribute_access /= Void
		do
			print_indentation
			current_file.put_string (once "item__mark ((gc_item_t *)")
			a_print_attribute_access.call ([])
			current_file.put_string (once ");")
			current_file.put_new_line
		end

	print_gc_mark_once_values_and_inline_constants is
			-- Print routine to GC mark all constant and
			-- once-value references
		local
			l_feature: ET_FEATURE
			l_once_feature: ET_DYNAMIC_FEATURE
			l_constant: ET_INLINE_CONSTANT
			l_type_set: ET_DYNAMIC_TYPE_SET
			l_type: ET_DYNAMIC_TYPE
		do
			current_file.put_string (once "gc_mark_constants() {")
			current_file.put_new_line
			indent
			print_indentation
			current_file.put_string (once "gc_item_t *p;")
			current_file.put_new_line
			current_file.put_new_line
--			from constant_features.start until constant_features.after loop
--				l_feature := constant_features.key_for_iteration
--				print_indentation
--				current_file.put_string (once "p = (gc_item_t *) ")
--				print_once_value_name (l_feature, current_file)
--				current_file.put_character (';')
--				current_file.put_new_line
--				print_indentation
--				current_file.put_string (once "if (p != NULL) item__mark(p);")
--				current_file.put_new_line
--				constant_features.forth
--			end

-- GC TODO: Mark once references created at runtime ...
-- This will subsume the generation from constant_features above

			from once_gc_references.start until once_gc_references.after loop
				l_feature := once_gc_references.item_for_iteration
				print_indentation
				current_file.put_string (once "p = (gc_item_t *) ")
				print_once_value_name (l_feature, current_file)
				current_file.put_character (';')
				current_file.put_new_line
				print_indentation
				current_file.put_string (once "if (p != NULL) item__mark(p);")
				current_file.put_new_line
				once_gc_references.forth
			end

			from inline_constants.start until inline_constants.after loop
				l_constant := inline_constants.key_for_iteration
				print_indentation
				current_file.put_string (once "p = (gc_item_t *) ")
				print_inline_constant_name (l_constant, current_file)
				current_file.put_character (';')
				current_file.put_new_line
				print_indentation
				current_file.put_string (once "if (p != NULL) item__mark(p);")
				current_file.put_new_line
				inline_constants.forth
			end
			dedent
			current_file.put_character ('}')
			current_file.put_new_line
			current_file.put_new_line
			
		end

	print_stack_descriptor_name (a_feature: ET_DYNAMIC_FEATURE; a_type: ET_DYNAMIC_TYPE; a_static, a_creation: BOOLEAN; a_file: KI_TEXT_OUTPUT_STREAM) is
			-- Print the name of the global pointer, once allocated, for
			-- the stack layout descriptor for this routine
		do
			a_file.put_character ('G')
			a_file.put_character ('E')
			a_file.put_character ('_')
			a_file.put_character ('s')
			a_file.put_character ('d')
			a_file.put_character ('_')
			if a_static then
				print_static_routine_name (a_feature, a_type, a_file)
			elseif a_creation then
				print_creation_procedure_name (a_feature, a_type, a_file)
			else
				print_routine_name (a_feature, a_type, a_file)
			end
		end

feature {NONE} -- Include files

	include_file (a_filename: STRING; a_file: KI_TEXT_OUTPUT_STREAM)
			-- Include content of file `a_filename' to `a_file'.
		require
			a_filename_not_void: a_filename /= Void
			a_file_not_void: a_file /= Void
			a_file_open_write: a_file.is_open_write
		local
			l_other_file: KL_TEXT_INPUT_FILE
		do
			create l_other_file.make (a_filename)
			l_other_file.open_read
			if l_other_file.is_open_read then
				a_file.append (l_other_file)
				l_other_file.close
			else
-- TODO: report error.
				set_fatal_error
			end
		end

	include_runtime_c_file (a_filename: STRING; a_file: KI_TEXT_OUTPUT_STREAM)
			-- Include content of runtime C file `a_filename' to `a_file'.
		require
			a_filename_not_void: a_filename /= Void
			a_file_not_void: a_file /= Void
			a_file_open_write: a_file.is_open_write
		local
			l_full_pathname: STRING
		do
			l_full_pathname := file_system.nested_pathname ("${GOBO}", <<"tool", "gec", "runtime", "c", a_filename>>)
			l_full_pathname := Execution_environment.interpreted_string (l_full_pathname)
			include_file (l_full_pathname, a_file)
		end

	include_header_filename (a_filename: STRING; a_file: KI_TEXT_OUTPUT_STREAM)
			-- Include header filename `a_filename' to `a_file'.
		require
			a_filename_not_void: a_filename /= Void
			a_file_not_void: a_file /= Void
			a_file_open_write: a_file.is_open_write
		do
			if not included_header_filenames.has (a_filename) then
				if a_filename.same_string ("%"eif_cecil.h%"") then
					include_runtime_header_file ("eif_cecil.h", False, a_file)
				elseif a_filename.same_string ("%"eif_console.h%"") then
					include_runtime_header_file ("eif_console.h", False, a_file)
				elseif a_filename.same_string ("%"eif_constants.h%"") then
					include_runtime_header_file ("eif_constants.h", False, a_file)
				elseif a_filename.same_string ("%"eif_dir.h%"") then
					include_runtime_header_file ("eif_dir.h", False, a_file)
				elseif a_filename.same_string ("%"eif_eiffel.h%"") then
					include_runtime_header_file ("eif_eiffel.h", False, a_file)
				elseif a_filename.same_string ("%"eif_except.h%"") then
					include_runtime_header_file ("eif_except.h", False, a_file)
				elseif a_filename.same_string ("%"eif_file.h%"") then
					include_runtime_header_file ("eif_file.h", False, a_file)
				elseif a_filename.same_string ("%"eif_globals.h%"") then
					include_runtime_header_file ("eif_globals.h", False, a_file)
				elseif a_filename.same_string ("%"eif_hector.h%"") then
					include_runtime_header_file ("eif_hector.h", False, a_file)
				elseif a_filename.same_string ("%"eif_lmalloc.h%"") then
					include_runtime_header_file ("eif_lmalloc.h", False, a_file)
				elseif a_filename.same_string ("%"eif_main.h%"") then
					include_runtime_header_file ("eif_main.h", False, a_file)
				elseif a_filename.same_string ("%"eif_memory.h%"") then
					include_runtime_header_file ("eif_memory.h", False, a_file)
				elseif a_filename.same_string ("%"eif_misc.h%"") then
					include_runtime_header_file ("eif_misc.h", False, a_file)
				elseif a_filename.same_string ("%"eif_path_name.h%"") then
					include_runtime_header_file ("eif_path_name.h", False, a_file)
				elseif a_filename.same_string ("%"eif_plug.h%"") then
					include_runtime_header_file ("eif_plug.h", False, a_file)
				elseif a_filename.same_string ("%"eif_portable.h%"") then
					include_runtime_header_file ("eif_portable.h", False, a_file)
				elseif a_filename.same_string ("%"eif_retrieve.h%"") then
					include_runtime_header_file ("eif_retrieve.h", False, a_file)
				elseif a_filename.same_string ("%"eif_sig.h%"") then
					include_runtime_header_file ("eif_sig.h", False, a_file)
				elseif a_filename.same_string ("%"eif_store.h%"") then
					include_runtime_header_file ("eif_store.h", False, a_file)
				elseif a_filename.same_string ("%"eif_threads.h%"") then
					include_runtime_header_file ("eif_threads.h", False, a_file)
				elseif a_filename.same_string ("%"eif_traverse.h%"") then
					include_runtime_header_file ("eif_traverse.h", False, a_file)
				elseif a_filename.same_string ("%"eif_types.h%"") then
					include_runtime_header_file ("eif_types.h", False, a_file)
				elseif a_filename.same_string ("%"ge_time.h%"") then
					include_runtime_header_file ("ge_time.h", False, a_file)
				else
					included_header_filenames.force (a_filename)
				end
			end
		end

	include_runtime_header_file (a_filename: STRING; a_force: BOOLEAN; a_file: KI_TEXT_OUTPUT_STREAM)
			-- Include runtime header file `a_filename' to `a_file'.
			-- `a_force' means that the file should be included now.
		require
			a_filename_not_void: a_filename /= Void
			a_file_not_void: a_file /= Void
			a_file_open_write: a_file.is_open_write
		do
			if not included_runtime_header_files.has (a_filename) then
				if a_filename.same_string ("ge_arguments.h") then
					included_runtime_c_files.force ("ge_arguments.c")
				elseif a_filename.same_string ("ge_console.h") then
					included_runtime_c_files.force ("ge_console.c")
				elseif a_filename.same_string ("ge_dll.h") then
					included_runtime_c_files.force ("ge_dll.c")
				elseif a_filename.same_string ("ge_exception.h") then
					included_runtime_c_files.force ("ge_exception.c")
				elseif a_filename.same_string ("ge_deep.h") then
					included_runtime_c_files.force ("ge_deep.c")
				elseif a_filename.same_string ("ge_gc.h") then
					included_runtime_c_files.force ("ge_gc.c")
				elseif a_filename.same_string ("ge_identified.h") then
					included_runtime_c_files.force ("ge_identified.c")
				elseif a_filename.same_string ("ge_main.h") then
					included_runtime_c_files.force ("ge_main.c")
				elseif a_filename.same_string ("eif_cecil.h") then
					included_runtime_c_files.force ("eif_cecil.c")
				elseif a_filename.same_string ("eif_console.h") then
					include_runtime_header_file ("ge_console.h", False, a_file)
					include_runtime_header_file ("eif_file.h", False, a_file)
					included_runtime_c_files.force ("eif_console.c")
				elseif a_filename.same_string ("eif_dir.h") then
					include_runtime_header_file ("eif_except.h", False, a_file)
					included_runtime_c_files.force ("eif_dir.c")
				elseif a_filename.same_string ("eif_except.h") then
					include_runtime_header_file ("ge_exception.h", False, a_file)
					included_runtime_c_files.force ("eif_except.c")
				elseif a_filename.same_string ("eif_file.h") then
					include_runtime_header_file ("eif_except.h", False, a_file)
					included_runtime_c_files.force ("eif_file.c")
				elseif a_filename.same_string ("eif_main.h") then
					included_runtime_c_files.force ("eif_main.c")
				elseif a_filename.same_string ("eif_memory.h") then
					included_runtime_c_files.force ("eif_memory.c")
				elseif a_filename.same_string ("eif_misc.h") then
					include_runtime_header_file ("ge_dll.h", False, a_file)
					included_runtime_c_files.force ("eif_misc.c")
				elseif a_filename.same_string ("eif_path_name.h") then
					included_runtime_c_files.force ("eif_path_name.c")
				elseif a_filename.same_string ("eif_plug.h") then
					included_runtime_c_files.force ("eif_plug.c")
				elseif a_filename.same_string ("eif_retrieve.h") then
					included_runtime_c_files.force ("eif_retrieve.c")
				elseif a_filename.same_string ("eif_sig.h") then
					included_runtime_c_files.force ("eif_sig.c")
				elseif a_filename.same_string ("eif_store.h") then
					included_runtime_c_files.force ("eif_store.c")
				elseif a_filename.same_string ("eif_traverse.h") then
					included_runtime_c_files.force ("eif_traverse.c")
				end
				if a_force then
					include_runtime_c_file (a_filename, a_file)
					included_runtime_header_files.force (True, a_filename)
				else
					included_runtime_header_files.force (False, a_filename)
				end
			elseif a_force and then not included_runtime_header_files.item (a_filename) then
				include_runtime_c_file (a_filename, a_file)
				included_runtime_header_files.replace (True, a_filename)
			end
		end

	included_header_filenames: DS_HASH_SET [STRING]
			-- Name of header filenames already included

	included_runtime_header_files: DS_HASH_TABLE [BOOLEAN, STRING]
			-- Name of runtime header files already included;
			-- True means that it has already been printed

	included_runtime_c_files: DS_HASH_SET [STRING]
			-- Name of runtime C files already included

feature {NONE} -- Output files/buffers

	header_file: KI_TEXT_OUTPUT_STREAM
			-- Header file

	c_file: KL_TEXT_OUTPUT_FILE
			-- C file
			-- (May be Void if not open yet.)

	c_file_size: INTEGER
			-- Number of bytes already written to `c_file'

	c_filenames: DS_HASH_TABLE [STRING, STRING]
			-- List of C (or C++) filenames generated;
			-- The key is the filename without the extension,
			-- the item is the file extension

	llvm_filenames: DS_HASH_TABLE [STRING, STRING]
			-- List of LLVM filenames generated;
			-- The key is the filename without the extension,
			-- the item is the file extension

	open_c_file
			-- Open C file if necessary.
		do
		end

	flush_to_c_file
			-- Open C file if not already done, and then
			-- flush to C file the code written in buffers.
			-- Take into account where we are in `split_mode' or not.
		local
			l_buffer: STRING
			l_filename: STRING
			l_header_filename: STRING
		do
			if c_file = Void then
				c_file_size := 0
				l_header_filename := system_name + h_file_extension
				l_filename := system_name + (c_filenames.count + 1).out
				c_filenames.force_last (c_file_extension, l_filename)
				create c_file.make (l_filename + c_file_extension)
				c_file.open_write
			elseif not c_file.is_open_write then
				c_file.open_append
			end
			if not c_file.is_open_write then
				set_fatal_error
				report_cannot_write_error (c_file.name)
				c_file := Void
			else
				if l_header_filename /= Void then
					c_file.put_string ("#include %"")
					c_file.put_string (l_header_filename)
					c_file.put_character ('%"')
					c_file.put_new_line
					c_file.put_new_line
					c_file_size := c_file_size + l_header_filename.count + 13
					print_start_extern_c (c_file)
					c_file_size := c_file_size + 40
				end
				l_buffer := current_function_stack_descriptor_buffer.string
				c_file.put_string (l_buffer)
				c_file_size := c_file_size + l_buffer.count
				STRING_.wipe_out (l_buffer)
				l_buffer := current_function_header_buffer.string
				c_file.put_string (l_buffer)
				c_file_size := c_file_size + l_buffer.count
				STRING_.wipe_out (l_buffer)
				l_buffer := current_function_body_buffer.string
				c_file.put_string (l_buffer)
				c_file_size := c_file_size + l_buffer.count
				STRING_.wipe_out (l_buffer)
				if split_mode and then c_file_size >= split_threshold then
					close_c_file
				end
			end
		ensure
			flushed1: not has_fatal_error implies current_function_header_buffer.string.is_empty
			flushed2: not has_fatal_error implies current_function_body_buffer.string.is_empty
		end

	close_c_file
			-- Close C file if not already done.
		do
			if c_file /= Void and then not c_file.is_closed then
				print_end_extern_c (c_file)
				c_file.close
			end
			c_file := Void
			c_file_size := 0
		ensure
			c_file_reset: c_file = Void
			c_file_size_reset: c_file_size = 0
		end

	cpp_file: KL_TEXT_OUTPUT_FILE
			-- C++ file
			-- (May be Void if not open yet.)

	cpp_file_size: INTEGER
			-- Number of bytes already written to `cpp_file'

	open_cpp_file
			-- Open C++ file if necessary.
		do
		end

	flush_to_cpp_file
			-- Open C++ file if not already done, and then
			-- flush to C++ file the code written in buffers.
			-- Take into account where we are in `split_mode' or not.
		local
			l_buffer: STRING
			l_filename: STRING
			l_header_filename: STRING
		do
			if cpp_file = Void then
				cpp_file_size := 0
				l_header_filename := system_name + h_file_extension
				l_filename := system_name + (c_filenames.count + 1).out
				c_filenames.force_last (cpp_file_extension, l_filename)
				create cpp_file.make (l_filename + cpp_file_extension)
				cpp_file.open_write
			elseif not cpp_file.is_open_write then
				cpp_file.open_append
			end
			if not cpp_file.is_open_write then
				set_fatal_error
				report_cannot_write_error (cpp_file.name)
				cpp_file := Void
			else
				if l_header_filename /= Void then
					cpp_file.put_string ("#include %"")
					cpp_file.put_string (l_header_filename)
					cpp_file.put_character ('%"')
					cpp_file.put_new_line
					cpp_file.put_new_line
					cpp_file_size := cpp_file_size + l_header_filename.count + 13
					print_start_extern_c (cpp_file)
					cpp_file_size := cpp_file_size + 40
				end
				l_buffer := current_function_header_buffer.string
				cpp_file.put_string (l_buffer)
				cpp_file_size := cpp_file_size + l_buffer.count
				STRING_.wipe_out (l_buffer)
				l_buffer := current_function_body_buffer.string
				cpp_file.put_string (l_buffer)
				cpp_file_size := cpp_file_size + l_buffer.count
				STRING_.wipe_out (l_buffer)
				if split_mode and then cpp_file_size >= split_threshold then
					close_cpp_file
				end
			end
		ensure
			flushed1: not has_fatal_error implies current_function_header_buffer.string.is_empty
			flushed2: not has_fatal_error implies current_function_body_buffer.string.is_empty
		end

	close_cpp_file
			-- Close C++ file if not already done.
		do
			if cpp_file /= Void and then not cpp_file.is_closed then
				print_end_extern_c (cpp_file)
				cpp_file.close
			end
			cpp_file := Void
			cpp_file_size := 0
		ensure
			cpp_file_reset: cpp_file = Void
			cpp_file_size_reset: cpp_file_size = 0
		end

	current_file: KI_TEXT_OUTPUT_STREAM
			-- Output file;
			-- In fact, it's not a file but a buffer (either `current_function_header_buffer'
			-- or `current_function_body_buffer'), which is then flushed to either a C or
			-- C++ file.

	current_function_header_buffer: KL_STRING_OUTPUT_STREAM
			-- Buffer to write the C header of the current function;
			-- This is useful when we need to declare local variables
			-- on the fly while generating the code for the body of
			-- the C function.

	current_function_body_buffer: KL_STRING_OUTPUT_STREAM
			-- Buffer to write the C body of the current function

	current_function_stack_descriptor_buffer: KL_STRING_OUTPUT_STREAM
			-- Buffer to write the C data structure describing the stack layout
			-- of the currently generating routine.
			-- Emitted after the routine into the text stream

feature {ET_AST_NODE} -- Processing

	process_assigner_instruction (an_instruction: ET_ASSIGNER_INSTRUCTION)
			-- Process `an_instruction'.
		do
			print_assigner_instruction (an_instruction)
		end

	process_assignment (an_instruction: ET_ASSIGNMENT)
			-- Process `an_instruction'.
		do
			print_assignment (an_instruction)
		end

	process_assignment_attempt (an_instruction: ET_ASSIGNMENT_ATTEMPT)
			-- Process `an_instruction'.
		do
			print_assignment_attempt (an_instruction)
		end

	process_attribute (a_feature: ET_ATTRIBUTE)
			-- Process `a_feature'.
		do
			print_attribute (a_feature)
		end

	process_bang_instruction (an_instruction: ET_BANG_INSTRUCTION)
			-- Process `an_instruction'.
		do
			print_bang_instruction (an_instruction)
		end

	process_binary_integer_constant (a_constant: ET_BINARY_INTEGER_CONSTANT)
			-- Process `a_constant'.
		do
			print_binary_integer_constant (a_constant)
		end

	process_bit_constant (a_constant: ET_BIT_CONSTANT)
			-- Process `a_constant'.
		do
			print_bit_constant (a_constant)
		end

	process_bracket_expression (an_expression: ET_BRACKET_EXPRESSION)
			-- Process `an_expression'.
		do
			print_bracket_expression (an_expression)
		end

	process_c1_character_constant (a_constant: ET_C1_CHARACTER_CONSTANT)
			-- Process `a_constant'.
		do
			print_character_constant (a_constant)
		end

	process_c2_character_constant (a_constant: ET_C2_CHARACTER_CONSTANT)
			-- Process `a_constant'.
		do
			print_character_constant (a_constant)
		end

	process_c3_character_constant (a_constant: ET_C3_CHARACTER_CONSTANT)
			-- Process `a_constant'.
		do
			print_character_constant (a_constant)
		end

	process_call_agent (an_expression: ET_CALL_AGENT)
			-- Process `an_expression'.
		do
			if an_expression = current_agent then
				print_call_agent_body_declaration (an_expression)
			else
				print_call_agent (an_expression)
			end
		end

	process_call_expression (an_expression: ET_CALL_EXPRESSION)
			-- Process `an_expression'.
		do
			print_call_expression (an_expression)
		end

	process_call_instruction (an_instruction: ET_CALL_INSTRUCTION)
			-- Process `an_instruction'.
		do
			print_call_instruction (an_instruction)
		end

	process_check_instruction (an_instruction: ET_CHECK_INSTRUCTION)
			-- Process `an_instruction'.
		do
			print_check_instruction (an_instruction)
		end

	process_constant_attribute (a_feature: ET_CONSTANT_ATTRIBUTE)
			-- Process `a_feature'.
		do
			print_constant_attribute (a_feature)
		end

	process_convert_builtin_expression (an_expression: ET_CONVERT_BUILTIN_EXPRESSION)
			-- Process `an_expression'.
		do
			print_convert_builtin_expression (an_expression)
		end

	process_convert_from_expression (an_expression: ET_CONVERT_FROM_EXPRESSION)
			-- Process `an_expression'.
		do
			print_convert_from_expression (an_expression)
		end

	process_convert_to_expression (an_expression: ET_CONVERT_TO_EXPRESSION)
			-- Process `an_expression'.
		do
			print_convert_to_expression (an_expression)
		end

	process_create_expression (an_expression: ET_CREATE_EXPRESSION)
			-- Process `an_expression'.
		do
			print_create_expression (an_expression)
		end

	process_create_instruction (an_instruction: ET_CREATE_INSTRUCTION)
			-- Process `an_instruction'.
		do
			print_create_instruction (an_instruction)
		end

	process_current (an_expression: ET_CURRENT)
			-- Process `an_expression'.
		do
			print_current (an_expression)
		end

	process_current_address (an_expression: ET_CURRENT_ADDRESS)
			-- Process `an_expression'.
		do
			print_current_address (an_expression)
		end

	process_debug_instruction (an_instruction: ET_DEBUG_INSTRUCTION)
			-- Process `an_instruction'.
		do
			print_debug_instruction (an_instruction)
		end

	process_deferred_function (a_feature: ET_DEFERRED_FUNCTION)
			-- Process `a_feature'.
		do
			print_deferred_function (a_feature)
		end

	process_deferred_procedure (a_feature: ET_DEFERRED_PROCEDURE)
			-- Process `a_feature'.
		do
			print_deferred_procedure (a_feature)
		end

	process_do_function (a_feature: ET_DO_FUNCTION)
			-- Process `a_feature'.
		do
			print_do_function (a_feature)
		end

	process_do_function_inline_agent (an_agent: ET_DO_FUNCTION_INLINE_AGENT)
			-- Process `an_agent'.
		do
			if an_agent = current_agent then
				print_do_function_inline_agent_body_declaration (an_agent)
			else
				print_do_function_inline_agent (an_agent)
			end
		end

	process_do_procedure (a_feature: ET_DO_PROCEDURE)
			-- Process `a_feature'.
		do
			print_do_procedure (a_feature)
		end

	process_do_procedure_inline_agent (an_agent: ET_DO_PROCEDURE_INLINE_AGENT)
			-- Process `an_agent'.
		do
			if an_agent = current_agent then
				print_do_procedure_inline_agent_body_declaration (an_agent)
			else
				print_do_procedure_inline_agent (an_agent)
			end
		end

	process_equality_expression (an_expression: ET_EQUALITY_EXPRESSION)
			-- Process `an_expression'.
		do
			print_equality_expression (an_expression)
		end

	process_expression_address (an_expression: ET_EXPRESSION_ADDRESS)
			-- Process `an_expression'.
		do
			print_expression_address (an_expression)
		end

	process_extended_attribute (a_feature: ET_EXTENDED_ATTRIBUTE)
			-- Process `a_feature'.
		do
			print_extended_attribute (a_feature)
		end

	process_external_function (a_feature: ET_EXTERNAL_FUNCTION)
			-- Process `a_feature'.
		do
			print_external_function (a_feature)
		end

	process_external_function_inline_agent (an_agent: ET_EXTERNAL_FUNCTION_INLINE_AGENT)
			-- Process `an_agent'.
		do
			if an_agent = current_agent then
				print_external_function_inline_agent_body_declaration (an_agent)
			else
				print_external_function_inline_agent (an_agent)
			end
		end

	process_external_procedure (a_feature: ET_EXTERNAL_PROCEDURE)
			-- Process `a_feature'.
		do
			print_external_procedure (a_feature)
		end

	process_external_procedure_inline_agent (an_agent: ET_EXTERNAL_PROCEDURE_INLINE_AGENT)
			-- Process `an_agent'.
		do
			if an_agent = current_agent then
				print_external_procedure_inline_agent_body_declaration (an_agent)
			else
				print_external_procedure_inline_agent (an_agent)
			end
		end

	process_false_constant (a_constant: ET_FALSE_CONSTANT)
			-- Process `a_constant'.
		do
			print_false_constant (a_constant)
		end

	process_feature_address (an_expression: ET_FEATURE_ADDRESS)
			-- Process `an_expression'.
		do
			print_feature_address (an_expression)
		end

	process_hexadecimal_integer_constant (a_constant: ET_HEXADECIMAL_INTEGER_CONSTANT)
			-- Process `a_constant'.
		do
			print_hexadecimal_integer_constant (a_constant)
		end

	process_identifier (an_identifier: ET_IDENTIFIER)
			-- Process `an_identifier'.
		do
			if an_identifier.is_argument then
				print_formal_argument (an_identifier)
			elseif an_identifier.is_temporary then
				print_temporary_variable (an_identifier)
			elseif an_identifier.is_local then
				print_local_variable (an_identifier)
			elseif an_identifier.is_object_test_local then
				print_object_test_local (an_identifier)
			elseif an_identifier.is_agent_open_operand then
				print_agent_open_operand (an_identifier)
			elseif an_identifier.is_agent_closed_operand then
				print_agent_closed_operand (an_identifier)
			elseif an_identifier.is_instruction then
				print_unqualified_identifier_call_instruction (an_identifier)
			else
				print_unqualified_identifier_call_expression (an_identifier)
			end
		end

	process_if_instruction (an_instruction: ET_IF_INSTRUCTION)
			-- Process `an_instruction'.
		do
			print_if_instruction (an_instruction)
		end

	process_infix_cast_expression (an_expression: ET_INFIX_CAST_EXPRESSION)
			-- Process `an_expression'.
		do
			print_infix_cast_expression (an_expression)
		end

	process_infix_expression (an_expression: ET_INFIX_EXPRESSION)
			-- Process `an_expression'.
		do
			print_infix_expression (an_expression)
		end

	process_inspect_instruction (an_instruction: ET_INSPECT_INSTRUCTION)
			-- Process `an_instruction'.
		do
			print_inspect_instruction (an_instruction)
		end

	process_loop_instruction (an_instruction: ET_LOOP_INSTRUCTION)
			-- Process `an_instruction'.
		do
			print_loop_instruction (an_instruction)
		end

	process_manifest_array (an_expression: ET_MANIFEST_ARRAY)
			-- Process `an_expression'.
		do
			print_manifest_array (an_expression)
		end

	process_manifest_tuple (an_expression: ET_MANIFEST_TUPLE)
			-- Process `an_expression'.
		do
			print_manifest_tuple (an_expression)
		end

	process_manifest_type (an_expression: ET_MANIFEST_TYPE)
			-- Process `an_expression'.
		do
			print_manifest_type (an_expression)
		end

	process_named_object_test (an_expression: ET_NAMED_OBJECT_TEST)
			-- Process `an_expression'.
		do
			print_object_test (an_expression)
		end

	process_object_equality_expression (an_expression: ET_OBJECT_EQUALITY_EXPRESSION)
			-- Process `an_expression'.
		do
			print_object_equality_expression (an_expression)
		end

	process_object_test (an_expression: ET_OBJECT_TEST)
			-- Process `an_expression'.
		do
			print_object_test (an_expression)
		end

	process_octal_integer_constant (a_constant: ET_OCTAL_INTEGER_CONSTANT)
			-- Process `a_constant'.
		do
			print_octal_integer_constant (a_constant)
		end

	process_old_expression (an_expression: ET_OLD_EXPRESSION)
			-- Process `an_expression'.
		do
			print_old_expression (an_expression)
		end

	process_old_object_test (an_expression: ET_OLD_OBJECT_TEST)
			-- Process `an_expression'.
		do
			print_object_test (an_expression)
		end

	process_once_function (a_feature: ET_ONCE_FUNCTION)
			-- Process `a_feature'.
		do
			print_once_function (a_feature)
		end

	process_once_function_inline_agent (an_agent: ET_ONCE_FUNCTION_INLINE_AGENT)
			-- Process `an_agent'.
		do
			if an_agent = current_agent then
				print_once_function_inline_agent_body_declaration (an_agent)
			else
				print_once_function_inline_agent (an_agent)
			end
		end

	process_once_manifest_string (an_expression: ET_ONCE_MANIFEST_STRING)
			-- Process `an_expression'.
		do
			print_once_manifest_string (an_expression)
		end

	process_once_procedure (a_feature: ET_ONCE_PROCEDURE)
			-- Process `a_feature'.
		do
			print_once_procedure (a_feature)
		end

	process_once_procedure_inline_agent (an_agent: ET_ONCE_PROCEDURE_INLINE_AGENT)
			-- Process `an_agent'.
		do
			if an_agent = current_agent then
				print_once_procedure_inline_agent_body_declaration (an_agent)
			else
				print_once_procedure_inline_agent (an_agent)
			end
		end

	process_parenthesized_expression (an_expression: ET_PARENTHESIZED_EXPRESSION)
			-- Process `an_expression'.
		do
			print_parenthesized_expression (an_expression)
		end

	process_precursor_expression (an_expression: ET_PRECURSOR_EXPRESSION)
			-- Process `an_expression'.
		do
			print_precursor_expression (an_expression)
		end

	process_precursor_instruction (an_instruction: ET_PRECURSOR_INSTRUCTION)
			-- Process `an_instruction'.
		do
			print_precursor_instruction (an_instruction)
		end

	process_prefix_expression (an_expression: ET_PREFIX_EXPRESSION)
			-- Process `an_expression'.
		do
			print_prefix_expression (an_expression)
		end

	process_regular_integer_constant (a_constant: ET_REGULAR_INTEGER_CONSTANT)
			-- Process `a_constant'.
		do
			print_regular_integer_constant (a_constant)
		end

	process_regular_manifest_string (a_string: ET_REGULAR_MANIFEST_STRING)
			-- Process `a_string'.
		do
			print_regular_manifest_string (a_string)
		end

	process_regular_real_constant (a_constant: ET_REGULAR_REAL_CONSTANT)
			-- Process `a_constant'.
		do
			print_regular_real_constant (a_constant)
		end

	process_result (an_expression: ET_RESULT)
			-- Process `an_expression'.
		do
			print_result (an_expression)
		end

	process_result_address (an_expression: ET_RESULT_ADDRESS)
			-- Process `an_expression'.
		do
			print_result_address (an_expression)
		end

	process_retry_instruction (an_instruction: ET_RETRY_INSTRUCTION)
			-- Process `an_instruction'.
		do
			print_retry_instruction (an_instruction)
		end

	process_semicolon_symbol (a_symbol: ET_SEMICOLON_SYMBOL)
			-- Process `a_symbol'.
		do
			-- Do nothing.
		end

	process_special_manifest_string (a_string: ET_SPECIAL_MANIFEST_STRING)
			-- Process `a_string'.
		do
			print_special_manifest_string (a_string)
		end

	process_static_call_expression (an_expression: ET_STATIC_CALL_EXPRESSION)
			-- Process `an_expression'.
		do
			print_static_call_expression (an_expression)
		end

	process_static_call_instruction (an_instruction: ET_STATIC_CALL_INSTRUCTION)
			-- Process `an_instruction'.
		do
			print_static_call_instruction (an_instruction)
		end

	process_strip_expression (an_expression: ET_STRIP_EXPRESSION)
			-- Process `an_expression'.
		do
			print_strip_expression (an_expression)
		end

	process_true_constant (a_constant: ET_TRUE_CONSTANT)
			-- Process `a_constant'.
		do
			print_true_constant (a_constant)
		end

	process_underscored_integer_constant (a_constant: ET_UNDERSCORED_INTEGER_CONSTANT)
			-- Process `a_constant'.
		do
			print_underscored_integer_constant (a_constant)
		end

	process_underscored_real_constant (a_constant: ET_UNDERSCORED_REAL_CONSTANT)
			-- Process `a_constant'.
		do
			print_underscored_real_constant (a_constant)
		end

	process_unique_attribute (a_feature: ET_UNIQUE_ATTRIBUTE)
			-- Process `a_feature'.
		do
			print_unique_attribute (a_feature)
		end

	process_verbatim_string (a_string: ET_VERBATIM_STRING)
			-- Process `a_string'.
		do
			print_verbatim_string (a_string)
		end

	process_void (an_expression: ET_VOID)
			-- Process `an_expression'.
		do
			print_void (an_expression)
		end

feature {NONE} -- Error handling

	set_fatal_error
			-- Report a fatal error.
		do
			has_fatal_error := True
		ensure
			has_fatal_error: has_fatal_error
		end

	report_cannot_read_error (a_filename: STRING)
			-- Report that `a_filename' cannot be
			-- opened in read mode.
		require
			a_filename_not_void: a_filename /= Void
		local
			an_error: UT_CANNOT_READ_FILE_ERROR
		do
			create an_error.make (a_filename)
			error_handler.report_error (an_error)
		end

	report_cannot_write_error (a_filename: STRING)
			-- Report that `a_filename' cannot be
			-- opened in write mode.
		require
			a_filename_not_void: a_filename /= Void
		local
			an_error: UT_CANNOT_WRITE_TO_FILE_ERROR
		do
			create an_error.make (a_filename)
			error_handler.report_error (an_error)
		end

feature {NONE} -- Access

	system_name: STRING
			-- Name of the system being compiled

	current_feature: ET_DYNAMIC_FEATURE
			-- Feature being processed

	current_type: ET_DYNAMIC_TYPE
			-- Type where `current_feature' belongs

	current_universe: ET_UNIVERSE
			-- Universe where the base class of `current_type' is declared
		do
			Result := current_type.base_class.universe
		ensure
			current_universe_not_void: Result /= Void
		end

	current_universe_impl: ET_UNIVERSE
			-- Universe where the class in which `current_feature' is written is declared
		do
			Result := current_feature.static_feature.implementation_class.universe
		ensure
			current_universe_impl_not_void: Result /= Void
		end

	current_agent: ET_AGENT
			-- Agent being processed if any, Void otherwise

	current_agents: DS_ARRAYED_LIST [ET_AGENT]
			-- Agents already processed in `current_feature'

	current_object_tests: DS_ARRAYED_LIST [ET_OBJECT_TEST]
			-- Object-tests appearing in `current_feature' for which
			-- a function needs to be generated

	current_object_equalities: DS_ARRAYED_LIST [ET_OBJECT_EQUALITY_EXPRESSION]
			-- Object-equalities ('~' or '/~') appearing in `current_feature' for which
			-- a function needs to be generated

	current_equalities: DS_ARRAYED_LIST [ET_EQUALITY_EXPRESSION]
			-- Equalities ('=' or '/=') appearing in `current_feature' for which
			-- a function needs to be generated

	current_call_info: STRING
			-- Textual representation of a pointer to a 'GE_call'
			-- C struct corresponding to the current call

	called_features: DS_ARRAYED_LIST [ET_DYNAMIC_FEATURE]
			-- Features being called

	manifest_array_types: DS_HASH_SET [ET_DYNAMIC_TYPE]
			-- Types of manifest arrays

	big_manifest_array_types: DS_HASH_SET [ET_DYNAMIC_TYPE]
			-- Types of big manifest arrays

	manifest_tuple_types: DS_HASH_SET [ET_DYNAMIC_TUPLE_TYPE]
			-- Types of manifest tuples

	once_features: DS_HASH_SET [ET_FEATURE]
			-- Once features already generated

	constant_features: DS_HASH_TABLE [ET_CONSTANT, ET_FEATURE]
			-- Features returning a constant

	inline_constants: DS_HASH_TABLE [ET_DYNAMIC_TYPE, ET_INLINE_CONSTANT]
			-- Inline constants (such as once manifest strings), with their types

	dynamic_type_id_set_names: DS_HASH_TABLE [STRING, STRING]
			-- Names of C arrays made up of dynamic type ids, indexed by those dynamic type ids;
			-- Those dynamic type ids which are used as keys are of the form
			-- "<type-id1>,<type-id2>,...,<type-idN>" and are sorted in increasing order.

feature {NONE} -- Dynamic type sets

	dynamic_type_set (an_operand: ET_OPERAND): ET_DYNAMIC_TYPE_SET
			-- Dynamic type set associated with `an_operand' in feature being printed;
			-- Report a fatal error if not known
		require
			an_operand_not_void: an_operand /= Void
		local
			i, j: INTEGER
		do
			if an_operand = tokens.current_keyword then
				Result := current_type
			else
				i := an_operand.index
				if current_dynamic_type_sets.valid_index (i) then
					Result := current_dynamic_type_sets.item (i)
				else
					j := i - current_dynamic_type_sets.count
					if extra_dynamic_type_sets.valid_index (j) then
						Result := extra_dynamic_type_sets.item (j)
					else
							-- Internal error: dynamic type set not known.
						set_fatal_error
						error_handler.report_giaaa_error
						Result := current_dynamic_system.unknown_type
					end
				end
			end
		ensure
			dynamic_type_set_not_void: Result /= Void
		end

	dynamic_type_set_in_feature (an_operand: ET_OPERAND; a_feature: ET_DYNAMIC_FEATURE): ET_DYNAMIC_TYPE_SET
			-- Dynamic type set associated with `an_operand' in `a_feature';
			-- Report a fatal error if not known
		require
			an_operand_not_void: an_operand /= Void
			a_feature_not_void: a_feature /= Void
		do
			if an_operand = tokens.current_keyword then
				Result := a_feature.target_type
			else
				Result := a_feature.dynamic_type_set (an_operand)
				if Result = Void then
						-- Internal error: dynamic type set not known.
					set_fatal_error
					error_handler.report_giaaa_error
					Result := current_dynamic_system.unknown_type
				end
			end
		ensure
			dynamic_type_set_not_void: Result /= Void
		end

	argument_type_set (i: INTEGER): ET_DYNAMIC_TYPE_SET
			-- Dynamic type set of `i'-th argument of feature being printed;
			-- Report a fatal error if not known
		local
			j: INTEGER
		do
			if current_dynamic_type_sets.valid_index (i) then
				Result := current_dynamic_type_sets.item (i)
			else
				j := i - current_dynamic_type_sets.count
				if extra_dynamic_type_sets.valid_index (j) then
					Result := extra_dynamic_type_sets.item (j)
				else
						-- Internal error: dynamic type set not known.
					set_fatal_error
					error_handler.report_giaaa_error
					Result := current_dynamic_system.unknown_type
				end
			end
		ensure
			argument_type_set_not_void: Result /= Void
		end

	argument_type_set_in_feature (i: INTEGER; a_feature: ET_DYNAMIC_FEATURE): ET_DYNAMIC_TYPE_SET
			-- Dynamic type set of `i'-th argument of `a_feature';
			-- Report a fatal error if not known
		require
			a_feature_not_void: a_feature /= Void
		do
			Result := a_feature.argument_type_set (i)
			if Result = Void then
					-- Internal error: dynamic type set not known.
				set_fatal_error
				error_handler.report_giaaa_error
				Result := current_dynamic_system.unknown_type
			end
		ensure
			argument_type_set_not_void: Result /= Void
		end

	result_type_set_in_feature (a_feature: ET_DYNAMIC_FEATURE): ET_DYNAMIC_TYPE_SET
			-- Dynamic type set of result of `a_feature';
			-- Report a fatal error if not known
		require
			a_feature_not_void: a_feature /= Void
		do
			Result := a_feature.result_type_set
			if Result = Void then
					-- Internal error: dynamic type set not known.
				set_fatal_error
				error_handler.report_giaaa_error
				Result := current_dynamic_system.unknown_type
			end
		ensure
			result_type_set_not_void: Result /= Void
		end

	current_dynamic_type_sets: ET_DYNAMIC_TYPE_SET_LIST
			-- Dynamic type sets of expressions within feature being printed

	extra_dynamic_type_sets: ET_DYNAMIC_TYPE_SET_LIST
			-- Extra dynamic type sets used internally when needed

	conforming_type_set: ET_DYNAMIC_STANDALONE_TYPE_SET
			-- Set of types conforming to the target of the current assignment attempt or
			-- types to which the target of the current call to 'ANY.conforms_to' conform;
			-- Also used for object-tests.

	conforming_types: ET_DYNAMIC_TYPE_HASH_LIST
			-- Types conforming to the target of the current assignment attempt or
			-- types to which the target of the current call to 'ANY.conforms_to' conform;
			-- Also used for the arguments of PROCEDURE.call and FUNCTION.item to
			-- detect CAT-calls

	non_conforming_types: ET_DYNAMIC_TYPE_HASH_LIST
			-- Types non-conforming to the target of the current assignment attempt or
			-- types to which the target of the current call to 'ANY.conforms_to' do not conform

	attachment_dynamic_type_ids: DS_ARRAYED_LIST [INTEGER]
			-- List of dynamic type ids of the source of an attachment

	target_dynamic_type_ids: DS_ARRAYED_LIST [INTEGER]
			-- List of dynamic type ids of the target of a  call

	target_dynamic_types: DS_HASH_TABLE [ET_DYNAMIC_TYPE, INTEGER]
			-- Dynamic types of the target of a call indexed by type ids

	equality_type_set: ET_DYNAMIC_STANDALONE_TYPE_SET
			-- Dynamic type set of argument of feature 'is_equal' when invoked
			-- as part of an object-equality ('~' or '/~') or of an equality
			-- ('=' or '/=') with expanded operands

	equality_common_types: ET_DYNAMIC_TYPE_HASH_LIST
			-- List of types that are part of the dynamic type set of both
			-- operands in an equality expression ('=', '/=', '~' or '/~')

	dynamic_type_id_sorter: DS_QUICK_SORTER [INTEGER]
			-- Dynamic type id sorter
		local
			l_comparator: KL_COMPARABLE_COMPARATOR [INTEGER]
		once
			create l_comparator.make
			create Result.make (l_comparator)
		ensure
			sorter_not_void: Result /= Void
		end

	standalone_type_sets: ET_DYNAMIC_STANDALONE_TYPE_SET_LIST
			-- Standalone type sets to be used as argument type sets when processing
			-- polymorphic calls, or as target type sets when attributes are deep twined

feature {NONE} -- Temporary variables

-- GC Mods

	new_temp_variable (a_type: ET_DYNAMIC_TYPE): ET_IDENTIFIER
			-- New temporary variable of type `a_type'
		local
			i, nb: INTEGER
			l_type: ET_DYNAMIC_TYPE
		do
			nb := free_temp_variables.count
			from i := 1 until i > nb loop
				if frozen_temp_variables.item (i) = 0 then
					l_type := free_temp_variables.item (i)
					if l_type /= Void and then same_declaration_types (a_type, l_type) then
						used_temp_variables.replace (a_type, i)
						free_temp_variables.replace (Void, i)
						Result := temp_variables.item (i)
						i := nb + 1
					end
				end
				i := i + 1
			end
			if Result = Void then
				nb := nb + 1
				if nb <= temp_variables.count then
					Result := temp_variables.item (nb)
				elseif short_names then
					create Result.make ("t" + nb.out)
					Result.set_temporary (True)
					Result.set_seed (nb)
					temp_variables.force_last (Result)
				else
-- TODO: long names
					create Result.make ("t" + nb.out)
					Result.set_temporary (True)
					Result.set_seed (nb)
					temp_variables.force_last (Result)
				end
				free_temp_variables.force_last (Void)
				used_temp_variables.force_last (a_type)
				frozen_temp_variables.force_last (0)
				current_function_header_buffer.put_character ('%T')
				print_type_declaration (a_type, current_function_header_buffer)
				current_function_header_buffer.put_character (' ')
				print_temp_name (Result, current_function_header_buffer)
				if use_edp_gc and then not a_type.is_expanded then				-- GC
					current_function_header_buffer.put_string (once " = NULL")	-- GC
				end																-- GC
				current_function_header_buffer.put_character (';')
				current_function_header_buffer.put_new_line
			end
		ensure
			variable_not_void: Result /= Void
			known_variable: is_temp_variable_known (Result)
			used_variable: is_temp_variable_used (Result)
			not_free_variable: not is_temp_variable_free (Result)
			not_frozen_variable: not is_temp_variable_frozen (Result)
		end

	is_temp_variable_known (a_temp: ET_IDENTIFIER): BOOLEAN
			-- Is temporary variable `a_temp' under management?
		require
			a_temp_not_void: a_temp /= Void
		local
			l_seed: INTEGER
		do
			l_seed := a_temp.seed
			Result := (l_seed >= 1 and l_seed <= used_temp_variables.count)
		end

	is_temp_variable_used (a_temp: ET_IDENTIFIER): BOOLEAN
			-- Is temporary variable `a_temp' currently used?
		require
			a_temp_not_void: a_temp /= Void
			a_temp_known: is_temp_variable_known (a_temp)
		do
			Result := used_temp_variables.item (a_temp.seed) /= Void
		ensure
			definition: Result = (used_temp_variables.item (a_temp.seed) /= Void)
		end

	is_temp_variable_free (a_temp: ET_IDENTIFIER): BOOLEAN
			-- Is temporary variable `a_temp' currently free?
		require
			a_temp_not_void: a_temp /= Void
			a_temp_known: is_temp_variable_known (a_temp)
		do
			Result := free_temp_variables.item (a_temp.seed) /= Void
		ensure
			definition: Result = (free_temp_variables.item (a_temp.seed) /= Void)
		end

	is_temp_variable_frozen (a_temp: ET_IDENTIFIER): BOOLEAN
			-- Is temporary variable `a_temp' currently frozen?
		require
			a_temp_not_void: a_temp /= Void
			a_temp_known: is_temp_variable_known (a_temp)
		do
			Result := frozen_temp_variables.item (a_temp.seed) /= 0
		ensure
			definition: Result = (frozen_temp_variables.item (a_temp.seed) /= 0)
		end

	mark_temp_variable_used (a_temp: ET_IDENTIFIER)
			-- Mark temporary variable `a_temp' as used.
		require
			a_temp_not_void: a_temp /= Void
			a_temp_known: is_temp_variable_known (a_temp)
			a_temp_free: is_temp_variable_free (a_temp)
			a_temp_not_frozen: not is_temp_variable_frozen (a_temp)
		local
			l_seed: INTEGER
		do
			l_seed := a_temp.seed
			used_temp_variables.replace (free_temp_variables.item (l_seed), l_seed)
			free_temp_variables.replace (Void, l_seed)
		ensure
			a_temp_used: is_temp_variable_used (a_temp)
		end

	mark_temp_variable_free (a_temp: ET_IDENTIFIER)
			-- Mark temporary variable `a_temp' as free.
		require
			a_temp_not_void: a_temp /= Void
			a_temp_known: is_temp_variable_known (a_temp)
			a_temp_used: is_temp_variable_used (a_temp)
			a_temp_not_frozen: not is_temp_variable_frozen (a_temp)
		local
			l_seed: INTEGER
		do
			l_seed := a_temp.seed
			free_temp_variables.replace (used_temp_variables.item (l_seed), l_seed)
			used_temp_variables.replace (Void, l_seed)
		ensure
			a_temp_free: is_temp_variable_free (a_temp)
		end

	mark_temp_variable_frozen (a_temp: ET_IDENTIFIER)
			-- Mark temporary variable `a_temp' as frozen.
		require
			a_temp_not_void: a_temp /= Void
			a_temp_known: is_temp_variable_known (a_temp)
		local
			l_seed: INTEGER
		do
			l_seed := a_temp.seed
			frozen_temp_variables.replace (frozen_temp_variables.item (l_seed) + 1, l_seed)
		ensure
			a_temp_frozen: is_temp_variable_frozen (a_temp)
			a_temp_frozen_by_one_level: frozen_temp_variables.item (a_temp.seed) = old frozen_temp_variables.item (a_temp.seed) + 1
		end

	mark_temp_variable_unfrozen (a_temp: ET_IDENTIFIER)
			-- Mark temporary variable `a_temp' as not frozen.
		require
			a_temp_not_void: a_temp /= Void
			a_temp_known: is_temp_variable_known (a_temp)
			a_temp_frozen: is_temp_variable_frozen (a_temp)
		local
			l_seed: INTEGER
		do
			l_seed := a_temp.seed
			frozen_temp_variables.replace (frozen_temp_variables.item (l_seed) - 1, l_seed)
		ensure
			a_temp_unfrozen_by_one_level: frozen_temp_variables.item (a_temp.seed) = old frozen_temp_variables.item (a_temp.seed) - 1
		end

	mark_call_operands_frozen
			-- Mark temporary variables in `call_operands' as frozen.
		local
			i, nb: INTEGER
			l_temp: ET_IDENTIFIER
		do
			nb := call_operands.count
			from i := 1 until i > nb loop
				l_temp ?= call_operands.item (i)
				if l_temp /= Void and then l_temp.is_temporary then
					mark_temp_variable_frozen (l_temp)
				end
				i := i + 1
			end
		end

	mark_call_operands_unfrozen
			-- Mark temporary variables in `call_operands' as unfrozen.
		local
			i, nb: INTEGER
			l_temp: ET_IDENTIFIER
		do
			nb := call_operands.count
			from i := 1 until i > nb loop
				l_temp ?= call_operands.item (i)
				if l_temp /= Void and then l_temp.is_temporary and then is_temp_variable_frozen (l_temp) then
					mark_temp_variable_unfrozen (l_temp)
				end
				i := i + 1
			end
		end

	mark_expressions_frozen (a_expressions: ET_EXPRESSIONS)
			-- Mark temporary variables in `a_expressions' as frozen.
		require
			a_expressions_not_void: a_expressions /= Void
		local
			i, nb: INTEGER
			l_temp: ET_IDENTIFIER
		do
			nb := a_expressions.count
			from i := 1 until i > nb loop
				l_temp ?= a_expressions.expression (i)
				if l_temp /= Void and then l_temp.is_temporary then
					mark_temp_variable_frozen (l_temp)
				end
				i := i + 1
			end
		end

	mark_expressions_unfrozen (a_expressions: ET_EXPRESSIONS)
			-- Mark temporary variables in `a_expressions' as unfrozen.
		require
			a_expressions_not_void: a_expressions /= Void
		local
			i, nb: INTEGER
			l_temp: ET_IDENTIFIER
		do
			nb := a_expressions.count
			from i := 1 until i > nb loop
				l_temp ?= a_expressions.expression (i)
				if l_temp /= Void and then l_temp.is_temporary and then is_temp_variable_frozen (l_temp) then
					mark_temp_variable_unfrozen (l_temp)
				end
				i := i + 1
			end
		end

	reset_temp_variables
			-- Reset temporary variables so that they can be used again in another function.
		do
			used_temp_variables.wipe_out
			free_temp_variables.wipe_out
			frozen_temp_variables.wipe_out
		end

feature {NONE} -- Temporary variables (Implementation)

	temp_variables: DS_ARRAYED_LIST [ET_IDENTIFIER]
			-- Names of temporary variables generated so far

	used_temp_variables: DS_ARRAYED_LIST [ET_DYNAMIC_TYPE]
			-- Temporary variables currently in used by the current feature

	free_temp_variables: DS_ARRAYED_LIST [ET_DYNAMIC_TYPE]
			-- Temporary variables declared for the current feature but
			-- not currently used

	frozen_temp_variables: DS_ARRAYED_LIST [INTEGER]
			-- Temporary variables currently marked as frozen (which means
			-- that we need to keep them in their current used/free state);
			-- 0 means not frozen, N means that it was been frozen N times.

	temp_variable: ET_IDENTIFIER
			-- Shared temporary variable, to be used in non-Eiffel features
			-- such as 'GE_ms', 'GE_ma*' or 'main'.
		once
			if short_names then
				create Result.make ("t1")
			else
-- TODO: long names
				create Result.make ("t1")
			end
			Result.set_temporary (True)
			Result.set_seed (1)
		ensure
			temp_variable_not_void: Result /= Void
		end

feature {NONE} -- Formal arguments

	formal_argument (i: INTEGER): ET_IDENTIFIER
			-- Formal argument at index `i'
			-- Note: to be used only in functions that are not the direct
			-- translation of an Eiffel feature. Otherwise we should use
			-- the corresponding formal argument in that Eiffel feature
			-- (e.g. 'a_feature.arguments.formal_argument (i).name').
		require
			i_large_enough: i >= 1
		local
			nb: INTEGER
			l_arg: ET_IDENTIFIER
		do
			nb := formal_arguments.count
			if i > nb then
				if i > formal_arguments.capacity then
					formal_arguments.resize (i)
				end
				from until nb = i loop
					nb := nb + 1
					create l_arg.make ("a" + nb.out)
					l_arg.set_argument (True)
					l_arg.set_seed (nb)
					l_arg.set_index (nb)
					formal_arguments.put_last (l_arg)
				end
			end
			Result := formal_arguments.item (i)
		ensure
			formal_argument_not_void: Result /= Void
		end

feature {NONE} -- Formal arguments (Implementation)

	formal_arguments: DS_ARRAYED_LIST [ET_IDENTIFIER]
			-- Formal arguments indexed by argument position

feature {NONE} -- Operand stack

	operand_stack: DS_ARRAYED_STACK [ET_EXPRESSION]
			-- Operand stack

	call_operands: DS_ARRAYED_LIST [ET_EXPRESSION]
			-- Operands of call being processed

	fill_call_operands (nb: INTEGER)
			-- Fill `call_operands' with nb operands found in `operand_stack'.
		require
			nb_not_negative: nb >= 0
		local
			i, j: INTEGER
			l_operand: ET_EXPRESSION
			l_temp: ET_IDENTIFIER
		do
			call_operands.wipe_out
			if call_operands.capacity < nb then
				call_operands.resize (nb)
			end
			if nb > operand_stack.count then
					-- Internal error.
				set_fatal_error
				error_handler.report_giaaa_error
					-- Put some dummy operands to preserve the postcondition.
				from i := 1 until i > nb loop
					call_operands.put_last (tokens.current_keyword)
					i := i + 1
				end
			else
				j := operand_stack.count - nb + 1
				from i := 1 until i > nb loop
					l_operand := operand_stack.i_th (j)
					l_temp ?= l_operand
					if l_temp /= Void and then l_temp.is_temporary then
						if not is_temp_variable_frozen (l_temp) then
							mark_temp_variable_free (l_temp)
						end
					end
					call_operands.put_last (l_operand)
					j := j + 1
					i := i + 1
				end
				operand_stack.prune (nb)
			end
		ensure
			filled: call_operands.count = nb
		end

	fill_call_formal_arguments (a_feature: ET_FEATURE)
			-- Fill `call_operands' with 'Current' followed by the formal arguments of `a_feature'.
		require
			a_feature_not_void: a_feature /= Void
		local
			i, nb: INTEGER
			l_arguments: ET_FORMAL_ARGUMENT_LIST
			l_name: ET_IDENTIFIER
		do
			l_arguments := a_feature.arguments
			if l_arguments /= Void then
				nb := l_arguments.count
			end
			call_operands.wipe_out
			if call_operands.capacity < nb + 1 then
				call_operands.resize (nb + 1)
			end
			call_operands.put_last (tokens.current_keyword)
			from i := 1 until i > nb loop
				l_name := l_arguments.formal_argument (i).name
				l_name.set_index (i)
				call_operands.force_last (l_name)
				i := i + 1
			end
		ensure
			filled: call_operands.count = a_feature.arguments_count + 1
		end

feature {NONE} -- Tuple arguments in agent routines

	new_agent_tuple_item_expression (i: INTEGER): ET_CALL_EXPRESSION
			-- Expression to extract the `i'-th item of the tuple argument of an agent
		require
			i_large_enough: i >= 1
		local
			l_label: ET_IDENTIFIER
			nb: INTEGER
		do
			nb := agent_tuple_item_expressions.count
			if i > nb then
				if i > agent_tuple_item_expressions.capacity then
					agent_tuple_item_expressions.resize (i)
				end
				from until nb = i loop
					agent_tuple_item_expressions.put_last (Void)
					nb := nb + 1
				end
			end
			Result := agent_tuple_item_expressions.item (i)
			if Result = Void then
				create l_label.make ("l")
				l_label.set_tuple_label (True)
				l_label.set_seed (i)
				create Result.make (tokens.current_keyword, l_label, Void)
				agent_tuple_item_expressions.replace (Result, i)
			end
		ensure
			expresssion_not_void: Result /= Void
		end

	agent_manifest_tuple: ET_MANIFEST_TUPLE
			-- Manifest tuple used when calling an agent

feature {NONE} -- Tuple arguments in agent routines (Implementation)

	agent_tuple_item_expressions: DS_ARRAYED_LIST [ET_CALL_EXPRESSION]
			-- Expressions to extract items of the tuple argument of an agent,
			-- indexed by item index

feature {NONE} -- Rescue clauses

	has_rescue: BOOLEAN
			-- Does current feature or inline agent have a rescue clause?

	has_retry: BOOLEAN
			-- Is 'retry' being called in the rescue clause of current feature or inline agent?

	locals_written: DS_HASH_SET [ET_IDENTIFIER]
			-- Local variables which are written in the code of current feature
			-- or inline agent being processed
			-- (Can be either in the body or the rescue clause of the
			-- current feature or inline agent.)

	locals_written_in_body: DS_HASH_SET [ET_IDENTIFIER]
			-- Local variables which are written in the body of
			-- current feature or inline agent

	locals_written_in_rescue: DS_HASH_SET [ET_IDENTIFIER]
			-- Local variables which are written in the rescue clause of
			-- current feature or inline agent

	locals_read: DS_HASH_SET [ET_IDENTIFIER]
			-- Local variables which are read in the code of current feature
			-- or inline agent being processed
			-- (Can be either in the body or the rescue clause of the
			-- current feature or inline agent.)

	locals_read_in_body: DS_HASH_SET [ET_IDENTIFIER]
			-- Local variables which are read in the body of current feature or inline agent

	locals_read_in_rescue: DS_HASH_SET [ET_IDENTIFIER]
			-- Local variables which are read in the rescue clause of
			-- current feature or inline agent

	result_written: BOOLEAN
			-- Is the Result entity written in the code of current feature
			-- or inline agent being processed?
			-- (Can be either in the body or the rescue clause of the
			-- current feature or inline agent.)

	result_read: BOOLEAN
			-- Is the Result entity read in the code of current feature
			-- or inline agent being processed?
			-- (Can be either in the body or the rescue clause of the
			-- current feature or inline agent.)

	make_rescue_data
			-- Create data to determine the 'volatile' status of local variables
			-- in features or inline agents with a rescue clause.
		do
			create locals_written_in_body.make (50)
			locals_written_in_body.set_equality_tester (identifier_tester)
			create locals_written_in_rescue.make (50)
			locals_written_in_rescue.set_equality_tester (identifier_tester)
			locals_written := locals_written_in_body
			create locals_read_in_body.make (50)
			locals_read_in_body.set_equality_tester (identifier_tester)
			create locals_read_in_rescue.make (50)
			locals_read_in_rescue.set_equality_tester (identifier_tester)
			locals_read := locals_read_in_body
		end

	reset_rescue_data
			-- Reset data to determine the 'volatile' status of local variables
			-- in features or inline agents with a rescue clause.
		do
			locals_written_in_body.wipe_out
			locals_read_in_body.wipe_out
			locals_written_in_rescue.wipe_out
			locals_read_in_rescue.wipe_out
			result_written := False
			result_read := False
			has_retry := False
			has_rescue := False
		end

feature {NONE} -- Implementation

	in_operand: BOOLEAN
			-- Is an operand being processed?

	in_target: BOOLEAN
			-- Is the target of a call being processed?
		do
			Result := (call_target_type /= Void)
		ensure
			definition: Result = (call_target_type /= Void)
		end

	call_target_type: ET_DYNAMIC_TYPE
			-- Dynamic type of the target of the call being processed, if any
			-- (The dynamic type is the type of the object, not its declared
			-- type, also called static type.)

	call_target_check_void: BOOLEAN
			-- Do we need to check whether the target is Void or not
			-- when both `in_target' and not `in_operand' mode?

	assignment_target: ET_WRITABLE
			-- Target of expression currently being processed, if any

	same_declaration_types (a_type1, a_type2: ET_DYNAMIC_TYPE): BOOLEAN
			-- Do `a_type1' and `a_type2' have the same declaration type?
		require
			a_type1_not_void: a_type1 /= Void
			a_type2_not_void: a_type2 /= Void
		do
			if a_type1 = a_type2 then
				Result := True
			else
				Result := (not a_type1.is_expanded and not a_type2.is_expanded)
			end
		end

	dummy_feature: ET_DYNAMIC_FEATURE
			-- Dummy feature
		local
			l_name: ET_FEATURE_NAME
			l_feature: ET_FEATURE
		once
			create {ET_IDENTIFIER} l_name.make ("**dummy**")
			create {ET_DO_PROCEDURE} l_feature.make (l_name, Void, current_type.base_class)
			create Result.make (l_feature, current_type, current_dynamic_system)
		ensure
			dummy_feature_not_void: Result /= Void
		end

feature {NONE} -- LLVM Implementation attributes

	current_block: LLVM_BASIC_BLOCK
			-- The current Basic Block for appending LLVM Instructions

feature {NONE} -- LLVM name generation

	once_name_string: STRING is
		once
			create Result
		end

	routine_name_as_string (a_routine: ET_DYNAMIC_FEATURE; a_type: ET_DYNAMIC_TYPE): STRING is
			-- Print name of `a_routine' from `a_type' to `a_file'.
		require
			a_routine_not_void: a_routine /= Void
			a_type_not_void: a_type /= Void
		local
			l_name_string: STRING
		do
			l_name_string := once_name_string
			l_name_string.wipe_out
			print_routine_name (a_routine, a_type, l_name_string)
			create Result.make_from_string (l_name_string)
		end

	static_routine_name_as_string (a_routine: ET_DYNAMIC_FEATURE; a_type: ET_DYNAMIC_TYPE): STRING is
			-- Print name of static feature `a_feature' to `a_file'.
		require
			a_routine_not_void: a_routine /= Void
			a_routine_static: a_routine.is_static
			a_type_not_void: a_type /= Void
		local
			l_name_string: STRING
		do
			l_name_string := once_name_string
			l_name_string.wipe_out
			print_static_routine_name (a_routine, a_type, l_name_string)
			create Result.make_from_string (l_name_string)
		end

	creation_procedure_name_as_string (a_procedure: ET_DYNAMIC_FEATURE; a_type: ET_DYNAMIC_TYPE): STRING is
			-- Print name of creation procedure `a_procedure' to `a_file'.
		require
			a_procedure_not_void: a_procedure /= Void
			a_procedure_creation: a_procedure.is_creation
			a_type_not_void: a_type /= Void
		local
			l_name_string: STRING
		do
			l_name_string := once_name_string
			l_name_string.wipe_out
			print_creation_procedure_name (a_procedure, a_type, l_name_string)
			create Result.make_from_string (l_name_string)
		end

	attribute_name_as_string (an_attribute: ET_DYNAMIC_FEATURE; a_type: ET_DYNAMIC_TYPE): STRING is
			-- Print to `a_file' the name of `an_attribute' for objects of type `a_type'.
		require
			an_attribute_not_void: an_attribute /= Void
			a_type_not_void: a_type /= Void
		local
			l_name_string: STRING
		do
			l_name_string := once_name_string
			l_name_string.wipe_out
			print_attribute_name (an_attribute, a_type, l_name_string)
			create Result.make_from_string (l_name_string)
		end

	attribute_type_id_name_as_string (a_type: ET_DYNAMIC_TYPE): STRING is
			-- Print to `a_file' the name of the 'type_id' pseudo attribute for objects of type `a_type'
		require
			a_type_not_void: a_type /= Void
		local
			l_name_string: STRING
		do
			l_name_string := once_name_string
			l_name_string.wipe_out
			print_attribute_type_id_name (a_type, l_name_string)
			create Result.make_from_string (l_name_string)
		end

	attribute_special_item_name_as_string (a_type: ET_DYNAMIC_TYPE): STRING is
			-- Print to `a_file' the name of the 'item' pseudo attribute for 'SPECIAL' objects of type `a_type'.
		require
			a_type_not_void: a_type /= Void
		local
			l_name_string: STRING
		do
			l_name_string := once_name_string
			l_name_string.wipe_out
			print_attribute_special_item_name (a_type, l_name_string)
			create Result.make_from_string (l_name_string)
		end

	attribute_special_count_name_as_string (a_type: ET_DYNAMIC_TYPE): STRING is
			-- Print to `a_file' the name of the 'count' pseudo attribute for 'SPECIAL' objects of type `a_type'.
		require
			a_type_not_void: a_type /= Void
		local
			l_name_string: STRING
		do
			l_name_string := once_name_string
			l_name_string.wipe_out
			print_attribute_special_count_name (a_type, l_name_string)
			create Result.make_from_string (l_name_string)
		end

	attribute_tuple_item_name_as_string (i: INTEGER; a_type: ET_DYNAMIC_TYPE): STRING is
			-- Print to `a_file' then name of the `i'-th 'item' pseudo attribute for 'TUPLE' objects of type `a_type'.
		require
			a_type_not_void: a_type /= Void
		local
			l_name_string: STRING
		do
			l_name_string := once_name_string
			l_name_string.wipe_out
			print_attribute_tuple_item_name (i, a_type, l_name_string)
			create Result.make_from_string (l_name_string)
		end

	attribute_routine_function_name_as_string (a_type: ET_DYNAMIC_TYPE): STRING is
			-- Print to `a_file' the name of the function pointer pseudo attribute for 'ROUTINE' objects of type `a_type'.
		require
			a_type_not_void: a_type /= Void
		local
			l_name_string: STRING
		do
			l_name_string := once_name_string
			l_name_string.wipe_out
			print_attribute_routine_function_name (a_type, l_name_string)
			create Result.make_from_string (l_name_string)
		end

	boxed_attribute_item_name_as_string (a_type: ET_DYNAMIC_TYPE): STRING is
			-- Print to `a_file' then name of the 'item' pseudo attribute of boxed version of `a_type'.
			-- (The boxed version of a type makes sure that each object
			-- of that type contains its type-id. It can be the type itself
			-- if it already contains its type-id, or a wrapper otherwise.)
		require
			a_type_not_void: a_type /= Void
		local
			l_name_string: STRING
		do
			l_name_string := once_name_string
			l_name_string.wipe_out
			print_boxed_attribute_item_name (a_type, l_name_string)
			create Result.make_from_string (l_name_string)
		end

	call_name_as_string (a_call: ET_CALL_COMPONENT; a_caller: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE): STRING is
			-- Print name of `a_call' appearing in `a_caller' with `a_target_type' as target static type to `a_file'.
		require
			a_call_not_void: a_call /= Void
			a_caller_not_void: a_caller /= Void
			a_target_type_not_void: a_target_type /= Void
		local
			l_name_string: STRING
		do
			l_name_string := once_name_string
			l_name_string.wipe_out
			print_call_name (a_call, a_caller, a_target_type, l_name_string)
			create Result.make_from_string (l_name_string)
		end

	argument_name_as_string (a_name: ET_IDENTIFIER): STRING is
			-- Print name of argument `a_name' to `a_file'.
		require
			a_name_not_void: a_name /= Void
			a_name_argument: a_name.is_argument
		local
			l_name_string: STRING
		do
			l_name_string := once_name_string
			l_name_string.wipe_out
			print_argument_name (a_name, l_name_string)
			create Result.make_from_string (l_name_string)
		end

	local_name_as_string (a_name: ET_IDENTIFIER): STRING is
			-- Print name of local variable `a_name' to `a_file'.
		require
			a_name_not_void: a_name /= Void
			a_name_local: a_name.is_local
		local
			l_name_string: STRING
		do
			l_name_string := once_name_string
			l_name_string.wipe_out
			print_local_name (a_name, l_name_string)
			create Result.make_from_string (l_name_string)
		end

	object_test_local_name_as_string (a_name: ET_IDENTIFIER): STRING is
			-- Print name of object-test local `a_name' to `a_file'.
		require
			a_name_not_void: a_name /= Void
			a_name_object_test_local: a_name.is_object_test_local
		local
			l_name_string: STRING
		do
			l_name_string := once_name_string
			l_name_string.wipe_out
			print_object_test_local_name (a_name, l_name_string)
			create Result.make_from_string (l_name_string)
		end

	object_test_function_name_as_string (i: INTEGER; a_routine: ET_DYNAMIC_FEATURE; a_type: ET_DYNAMIC_TYPE): STRING is
			-- Print name of `i'-th object-test function appearing in `a_routine' from `a_type' to `a_file'.
		require
			a_routine_not_void: a_routine /= Void
			a_type_not_void: a_type /= Void
		local
			l_name_string: STRING
		do
			l_name_string := once_name_string
			l_name_string.wipe_out
			print_object_test_function_name (i, a_routine, a_type, l_name_string)
			create Result.make_from_string (l_name_string)
		end

	temp_name_as_string (a_name: ET_IDENTIFIER): STRING is
			-- Print name of temporary variable `a_name' to `a_file'.
		require
			a_name_not_void: a_name /= Void
			a_name_temp: a_name.is_temporary
			a_file_not_void: a_file /= Void
			a_file_open_write: a_file.is_open_write
		local
			l_name_string: STRING
		do
			l_name_string := once_name_string
			l_name_string.wipe_out
			print_temp_name (a_name, l_name_string)
			create Result.make_from_string (l_name_string)
		end

	current_name_as_string: STRING is
			-- Print name of 'Current' to `a_file'.
		local
			l_name_string: STRING
		do
			l_name_string := once_name_string
			l_name_string.wipe_out
			print_current_name (l_name_string)
			create Result.make_from_string (l_name_string)
		end

	result_name_as_string: STRING is
			-- Print name of 'Result' to `a_file'.
		local
			l_name_string: STRING
		do
			l_name_string := once_name_string
			l_name_string.wipe_out
			print_result_name (l_name_string)
			create Result.make_from_string (l_name_string)
		end

	once_status_name_as_string (a_feature: ET_FEATURE): STRING is
			-- Print name of variable holding the status of execution
			-- of the once-feature `a_feature' to `a_file'.
		require
			a_feature_not_void: a_feature /= Void
			implementation_feature: a_feature = a_feature.implementation_feature
		local
			l_name_string: STRING
		do
			l_name_string := once_name_string
			l_name_string.wipe_out
			print_once_status_name (a_feature, l_name_string)
			create Result.make_from_string (l_name_string)
		end

	once_value_name_as_string (a_feature: ET_FEATURE): STRING is
			-- Print name of variable holding the value of first
			-- execution of the once-feature `a_feature' to `a_file'.
		require
			a_feature_not_void: a_feature /= Void
			implementation_feature: a_feature = a_feature.implementation_feature
		local
			l_name_string: STRING
		do
			l_name_string := once_name_string
			l_name_string.wipe_out
			print_once_value_name (a_feature, l_name_string)
			create Result.make_from_string (l_name_string)
		end

	agent_creation_name_as_string (i: INTEGER; a_routine: ET_DYNAMIC_FEATURE; a_type: ET_DYNAMIC_TYPE): STRING is
			-- Print name of creation function of `i'-th agent appearing in `a_routine' from `a_type' to `a_file'.
		require
			a_routine_not_void: a_routine /= Void
			a_type_not_void: a_type /= Void
		local
			l_name_string: STRING
		do
			l_name_string := once_name_string
			l_name_string.wipe_out
			print_agent_creation_name (i, a_routine, a_type, l_name_string)
			create Result.make_from_string (l_name_string)
		end

	agent_function_name_as_string (i: INTEGER; a_routine: ET_DYNAMIC_FEATURE; a_type: ET_DYNAMIC_TYPE): STRING is
			-- Print name of function associated with `i'-th agent appearing in `a_routine' from `a_type' to `a_file'.
		require
			a_routine_not_void: a_routine /= Void
			a_type_not_void: a_type /= Void
		local
			l_name_string: STRING
		do
			l_name_string := once_name_string
			l_name_string.wipe_out
			print_agent_function_name (i, a_routine, a_type, l_name_string)
			create Result.make_from_string (l_name_string)
		end

	inline_constant_name_as_string (a_constant: ET_INLINE_CONSTANT): STRING is
			-- Print name of variable holding the value of inline constant
			-- `a_constant' (such as a once manifest string) to `a_file'.
		require
			a_constant_not_void: a_constant /= Void
		local
			l_name_string: STRING
		do
			l_name_string := once_name_string
			l_name_string.wipe_out
			print_inline_constant_name (a_constant, l_name_string)
			create Result.make_from_string (l_name_string)
		end

------------------------------------------------------------------------------------------------

	feature_name_comment_as_string (a_feature: ET_FEATURE; a_type: ET_DYNAMIC_TYPE): STRING is
			-- Print name of `a_feature' from `a_type' as a C comment to `a_file'.
		require
			a_feature_not_void: a_feature /= Void
			a_type_not_void: a_type /= Void
		local
			l_name_string: STRING
		do
			l_name_string := once_name_string
			l_name_string.wipe_out
			print_feature_name_comment (a_feature, a_type, l_name_string)
			create Result.make_from_string (l_name_string)
		end

	call_name_comment_as_string (a_call: ET_CALL_COMPONENT; a_caller: ET_DYNAMIC_FEATURE; a_target_type: ET_DYNAMIC_TYPE): STRING is
			-- Print name of `a_call', appearing in `a_caller' with `a_type' as target static type, as a C comment to `a_file'.
		require
			a_call_not_void: a_call /= Void
			a_caller_not_void: a_caller /= Void
			a_target_type_not_void: a_target_type /= Void
		local
			l_name_string: STRING
		do
			l_name_string := once_name_string
			l_name_string.wipe_out
			print_call_name_comment (a_call, a_caller, a_target_type, l_name_string)
			create Result.make_from_string (l_name_string)
		end

feature {NONE} -- External regexp

	external_c_regexp: RX_PCRE_REGULAR_EXPRESSION
			-- Regexp: C [blocking] [signature ["(" {<type> "," ...}* ")"] [":" <type>]] [use {<include> "," ...}+]
			-- \5: has signature arguments
			-- \6: signature arguments
			-- \11: signature result
			-- \18: include files

	external_c_macro_regexp: RX_PCRE_REGULAR_EXPRESSION
			-- Regexp: C [blocking] macro [signature ["(" {<type> "," ...}* ")"] [":" <type>]] use {<include> "," ...}+
			-- \4: has signature arguments
			-- \5: signature arguments
			-- \10: signature result
			-- \17: include files

	external_c_struct_regexp: RX_PCRE_REGULAR_EXPRESSION
			-- Regexp: C struct <struct-type> (access|get) <field-name> [type <field-type>] use {<include> "," ...}+
			-- \1: struct type
			-- \6: field name
			-- \9: field type
			-- \16: include files

	external_c_inline_regexp: RX_PCRE_REGULAR_EXPRESSION
			-- Regexp: C [blocking] inline [use {<include> "," ...}+]
			-- \3: include files

	old_external_c_regexp: RX_PCRE_REGULAR_EXPRESSION
			-- Regexp: C ["(" {<type> "," ...}* ")" [":" <type>]] ["|" {<include> "," ...}+]
			-- \1: has signature
			-- \2: signature arguments
			-- \4: signature result
			-- \6: include files

	old_external_c_macro_regexp: RX_PCRE_REGULAR_EXPRESSION
			-- Regexp: C "[" macro <include> "]" ["(" {<type> "," ...}* ")"] [":" <type>]
			-- \1: include file
			-- \2: has signature arguments
			-- \3: signature arguments
			-- \5: signature result

	old_external_c_struct_regexp: RX_PCRE_REGULAR_EXPRESSION
			-- Regexp: C "[" struct <include> "]" "(" {<type> "," ...}+ ")" [":" <type>]
			-- \1: include file
			-- \2: signature arguments
			-- \4: signature result

	external_cpp_regexp: RX_PCRE_REGULAR_EXPRESSION
			-- Regexp: C [blocking] <class_type> [signature ["(" {<type> "," ...}* ")"] [":" <type>]] [use {<include> "," ...}+]
			-- \2: class type
			-- \5: has signature arguments
			-- \6: signature arguments
			-- \11: signature result
			-- \18: include files

	external_cpp_inline_regexp: RX_PCRE_REGULAR_EXPRESSION
			-- Regexp: C++ [blocking] inline [use {<include> "," ...}+]
			-- \3: include files

	external_dllwin_regexp: RX_PCRE_REGULAR_EXPRESSION
			-- Regexp: [blocking] dllwin <dll_file> [signature ["(" {<type> "," ...}* ")"] [":" <type>]] [use {<include> "," ...}+]
			-- \2: dll file
			-- \5: has signature arguments
			-- \6: signature arguments
			-- \11: signature result
			-- \18: include files

	old_external_dllwin32_regexp: RX_PCRE_REGULAR_EXPRESSION
			-- Regexp: C "[" dllwin32 <dll_file> "]" ["(" {<type> "," ...}* ")"] [":" <type>]
			-- \1: dll file
			-- \2: has signature arguments
			-- \3: signature arguments
			-- \5: signature result

	make_external_regexps
			-- Create external regular expressions.
		do
				-- Regexp: C [blocking] [signature ["(" {<type> "," ...}* ")"] [":" <type>]] [use {<include> "," ...}+]
			create external_c_regexp.make
			external_c_regexp.compile ("[ \t\r\n]*[Cc]([ \t\r\n]+|$)(blocking([ \t\r\n]+|$))?(signature[ \t\r\n]*(\((([ \t\r\n]*[^ \t\r\n,)])+([ \t\r\n]*,([ \t\r\n]*[^ \t\r\n,)])+)*)?[ \t\r\n]*\))[ \t\r\n]*(:[ \t\r\n]*((u|us|use[^ \t\r\n<%"]+|[^u \t\r\n][^ \t\r\n]*|u[^s \t\r\n][^ \t\r\n]*|us[^e \t\r\n][^ \t\r\n]*)([ \t\r\n]+|$)((u|us|use[^ \t\r\n<%"]+|[^u \t\r\n][^ \t\r\n]*|u[^s \t\r\n][^ \t\r\n]*|us[^e \t\r\n][^ \t\r\n]*)([ \t\r\n]+|$))*))?)?(use[ \t\r\n]*((.|\n)+))?")
				-- Regexp: C [blocking] macro [signature ["(" {<type> "," ...}* ")"] [":" <type>]] use {<include> "," ...}+
			create external_c_macro_regexp.make
			external_c_macro_regexp.compile ("[ \t\r\n]*[Cc][ \t\r\n]+(blocking[ \t\r\n]+)?macro([ \t\r\n]+|$)(signature[ \t\r\n]*(\((([ \t\r\n]*[^ \t\r\n,)])+([ \t\r\n]*,([ \t\r\n]*[^ \t\r\n,)])+)*)?[ \t\r\n]*\))[ \t\r\n]*(:[ \t\r\n]*((u|us|use[^ \t\r\n<%"]+|[^u \t\r\n][^ \t\r\n]*|u[^s \t\r\n][^ \t\r\n]*|us[^e \t\r\n][^ \t\r\n]*)([ \t\r\n]+|$)((u|us|use[^ \t\r\n<%"]+|[^u \t\r\n][^ \t\r\n]*|u[^s \t\r\n][^ \t\r\n]*|us[^e \t\r\n][^ \t\r\n]*)([ \t\r\n]+|$))*))?)?(use[ \t\r\n]*((.|\n)+))")
				-- Regexp: C struct <struct-type> (access|get) <field-name> [type <field-type>] use {<include> "," ...}+
			create external_c_struct_regexp.make
			external_c_struct_regexp.compile ("[ \t\r\n]*[Cc][ \t\r\n]+struct[ \t\r\n]+((a|ac|acc|acce|acces|g|ge|[^ag \t\r\n][^ \t\r\n]*|g[^e \t\r\n][^ \t\r\n]*|ge[^t \t\r\n][^ \t\r\n]*|get[^ \t\r\n]+|a[^c \t\r\n][^ \t\r\n]*|ac[^c \t\r\n][^ \t\r\n]*|acc[^e \t\r\n][^ \t\r\n]*|acce[^s \t\r\n][^ \t\r\n]*|acces[^s \t\r\n][^ \t\r\n]*|access[^ \t\r\n]+)[ \t\r\n]+((a|ac|acc|acce|acces|g|ge|[^ag \t\r\n][^ \t\r\n]*|g[^e \t\r\n][^ \t\r\n]*|ge[^t \t\r\n][^ \t\r\n]*|get[^ \t\r\n]+|a[^c \t\r\n][^ \t\r\n]*|ac[^c \t\r\n][^ \t\r\n]*|acc[^e \t\r\n][^ \t\r\n]*|acce[^s \t\r\n][^ \t\r\n]*|acces[^s \t\r\n][^ \t\r\n]*|access[^ \t\r\n]+)[ \t\r\n]+)*)(access|get)[ \t\r\n]+([^ \t\r\n]+)([ \t\r\n]+|$)(type[ \t\r\n]+((u|us|use[^ \t\r\n<%"]+|[^u \t\r\n][^ \t\r\n]*|u[^s \t\r\n][^ \t\r\n]*|us[^e \t\r\n][^ \t\r\n]*)([ \t\r\n]+|$)((u|us|use[^ \t\r\n<%"]+|[^u \t\r\n][^ \t\r\n]*|u[^s \t\r\n][^ \t\r\n]*|us[^e \t\r\n][^ \t\r\n]*)([ \t\r\n]+|$))*))?(use[ \t\r\n]*((.|\n)+))")
				-- Regexp: C [blocking] inline [use {<include> "," ...}+]
			create external_c_inline_regexp.make
			external_c_inline_regexp.compile ("[ \t\r\n]*[Cc][ \t\r\n]+(blocking[ \t\r\n]+)?inline([ \t\r\n]+use[ \t\r\n]*((.|\n)+))?")
				-- Regexp: C ["(" {<type> "," ...}* ")" [":" <type>]] ["|" {<include> "," ...}+]
			create old_external_c_regexp.make
			old_external_c_regexp.compile ("[ \t\r\n]*[Cc][ \t\r\n]*(\(([^)]*)\)[ \t\r\n]*(:[ \t\r\n]*([^|]+))?)?[ \t\r\n]*(\|[ \t\r\n]*((.|\n)+))?")
				-- Regexp: C "[" macro <include> "]" ["(" {<type> "," ...}* ")"] [":" <type>]
			create old_external_c_macro_regexp.make
			old_external_c_macro_regexp.compile ("[ \t\r\n]*[Cc][ \t\r\n]*\[[ \t\r\n]*macro[ \t\r\n]*([^]]+)\][ \t\r\n]*(\(([^)]*)\))?[ \t\r\n]*(:[ \t\r\n]*((.|\n)+))?")
				-- Regexp: C "[" struct <include> "]" "(" {<type> "," ...}+ ")" [":" <type>]
			create old_external_c_struct_regexp.make
			old_external_c_struct_regexp.compile ("[ \t\r\n]*[Cc][ \t\r\n]*\[[ \t\r\n]*struct[ \t\r\n]*([^]]+)\][ \t\r\n]*\(([^)]+)\)[ \t\r\n]*(:[ \t\r\n]*((.|\n)+))?")
				-- Regexp: C++ [blocking] <class_type> [signature ["(" {<type> "," ...}* ")"] [":" <type>]] [use {<include> "," ...}+]
			create external_cpp_regexp.make
			external_cpp_regexp.compile ("[ \t\r\n]*[Cc]\+\+[ \t\r\n]+(blocking[ \t\r\n]+)?([^ \t\r\n]+)([ \t\r\n]+|$)(signature[ \t\r\n]*(\((([ \t\r\n]*[^ \t\r\n,)])+([ \t\r\n]*,([ \t\r\n]*[^ \t\r\n,)])+)*)?[ \t\r\n]*\))[ \t\r\n]*(:[ \t\r\n]*((u|us|use[^ \t\r\n<%"]+|[^u \t\r\n][^ \t\r\n]*|u[^s \t\r\n][^ \t\r\n]*|us[^e \t\r\n][^ \t\r\n]*)([ \t\r\n]+|$)((u|us|use[^ \t\r\n<%"]+|[^u \t\r\n][^ \t\r\n]*|u[^s \t\r\n][^ \t\r\n]*|us[^e \t\r\n][^ \t\r\n]*)([ \t\r\n]+|$))*))?)?(use[ \t\r\n]*((.|\n)+))?")
				-- Regexp: C++ [blocking] inline [use {<include> "," ...}+]
			create external_cpp_inline_regexp.make
			external_cpp_inline_regexp.compile ("[ \t\r\n]*[Cc]\+\+[ \t\r\n]+(blocking[ \t\r\n]+)?inline([ \t\r\n]+use[ \t\r\n]*((.|\n)+))?")
				-- Regexp: [blocking] dllwin <dll_file> [signature ["(" {<type> "," ...}* ")"] [":" <type>]] [use {<include> "," ...}+]
			create external_dllwin_regexp.make
			external_dllwin_regexp.compile ("[ \t\r\n]*(blocking[ \t\r\n]+)?[Dd][Ll][Ll][Ww][Ii][Nn][ \t\r\n]+([^ \t\r\n]+)([ \t\r\n]+|$)(signature[ \t\r\n]*(\((([ \t\r\n]*[^ \t\r\n,)])+([ \t\r\n]*,([ \t\r\n]*[^ \t\r\n,)])+)*)?[ \t\r\n]*\))[ \t\r\n]*(:[ \t\r\n]*((u|us|use[^ \t\r\n<%"]+|[^u \t\r\n][^ \t\r\n]*|u[^s \t\r\n][^ \t\r\n]*|us[^e \t\r\n][^ \t\r\n]*)([ \t\r\n]+|$)((u|us|use[^ \t\r\n<%"]+|[^u \t\r\n][^ \t\r\n]*|u[^s \t\r\n][^ \t\r\n]*|us[^e \t\r\n][^ \t\r\n]*)([ \t\r\n]+|$))*))?)?(use[ \t\r\n]*((.|\n)+))?")
				-- Regexp: C "[" dllwin32 <dll_file> "]" ["(" {<type> "," ...}* ")"] [":" <type>]
			create old_external_dllwin32_regexp.make
			old_external_dllwin32_regexp.compile ("[ \t\r\n]*[Cc][ \t\r\n]*\[[ \t\r\n]*dllwin32[ \t\r\n]*([^]]+)\][ \t\r\n]*(\(([^)]*)\))?[ \t\r\n]*(:[ \t\r\n]*((.|\n)+))?")
		ensure
			external_c_regexp_not_void: external_c_regexp /= Void
			external_c_regexp_compiled: external_c_regexp.is_compiled
			external_c_macro_regexp_not_void: external_c_macro_regexp /= Void
			external_c_macro_regexp_compiled: external_c_macro_regexp.is_compiled
			external_c_struct_regexp_not_void: external_c_struct_regexp /= Void
			external_c_struct_regexp_compiled: external_c_struct_regexp.is_compiled
			external_c_inline_regexp_not_void: external_c_inline_regexp /= Void
			external_c_inline_regexp_compiled: external_c_inline_regexp.is_compiled
			old_external_c_regexp_not_void: old_external_c_regexp /= Void
			old_external_c_regexp_compiled: old_external_c_regexp.is_compiled
			old_external_c_macro_regexp_not_void: old_external_c_macro_regexp /= Void
			old_external_c_macro_regexp_compiled: old_external_c_macro_regexp.is_compiled
			old_external_c_struct_regexp_not_void: old_external_c_struct_regexp /= Void
			old_external_c_struct_regexp_compiled: old_external_c_struct_regexp.is_compiled
			external_cpp_regexp_not_void: external_cpp_regexp /= Void
			external_cpp_regexp_compiled: external_cpp_regexp.is_compiled
			external_cpp_inline_regexp_not_void: external_cpp_inline_regexp /= Void
			external_cpp_inline_regexp_compiled: external_cpp_inline_regexp.is_compiled
			external_dllwin_regexp_not_void: external_dllwin_regexp /= Void
			external_dllwin_regexp_compiled: external_dllwin_regexp.is_compiled
			old_external_dllwin32_regexp_not_void: old_external_dllwin32_regexp /= Void
			old_external_dllwin32_regexp_compiled: old_external_dllwin32_regexp.is_compiled
		end

feature {NONE} -- Constants

	c_ac: STRING = "ac"
	c_and_then: STRING = "&&"
	c_arrow: STRING = "->"
	c_break: STRING = "break"
	c_case: STRING = "case"
	c_char: STRING = "char"
	c_default: STRING = "default"
	c_define: STRING = "#define"
	c_double: STRING = "double"
	c_eif_any: STRING = "EIF_ANY"
	c_eif_boolean: STRING = "EIF_BOOLEAN"
	c_eif_boehm_gc: STRING = "EIF_BOEHM_GC"
	c_eif_character: STRING = "EIF_CHARACTER"
	c_eif_character_8: STRING = "EIF_CHARACTER_8"
	c_eif_character_32: STRING = "EIF_CHARACTER_32"
	c_eif_double: STRING = "EIF_DOUBLE"
	c_eif_exception_trace: STRING = "EIF_EXCEPTION_TRACE"
	c_eif_false: STRING = "EIF_FALSE"
	c_eif_integer: STRING = "EIF_INTEGER"
	c_eif_integer_8: STRING = "EIF_INTEGER_8"
	c_eif_integer_16: STRING = "EIF_INTEGER_16"
	c_eif_integer_32: STRING = "EIF_INTEGER_32"
	c_eif_integer_64: STRING = "EIF_INTEGER_64"
	c_eif_is_mac: STRING = "EIF_IS_MAC"
	c_eif_is_unix: STRING = "EIF_IS_UNIX"
	c_eif_is_vms: STRING = "EIF_IS_VMS"
	c_eif_is_vxworks: STRING = "EIF_IS_VXWORKS"
	c_eif_is_windows: STRING = "EIF_IS_WINDOWS"
	c_eif_mem_free: STRING = "eif_mem_free"
	c_eif_natural: STRING = "EIF_NATURAL"
	c_eif_natural_8: STRING = "EIF_NATURAL_8"
	c_eif_natural_16: STRING = "EIF_NATURAL_16"
	c_eif_natural_32: STRING = "EIF_NATURAL_32"
	c_eif_natural_64: STRING = "EIF_NATURAL_64"
	c_eif_object: STRING = "EIF_OBJECT"
	c_eif_pointer: STRING = "EIF_POINTER"
	c_eif_real: STRING = "EIF_REAL"
	c_eif_real_32: STRING = "EIF_REAL_32"
	c_eif_real_64: STRING = "EIF_REAL_64"
	c_eif_reference: STRING = "EIF_REFERENCE"
	c_eif_test: STRING = "EIF_TEST"
	c_eif_trace: STRING = "EIF_TRACE"
	c_eif_true: STRING = "EIF_TRUE"
	c_eif_type: STRING = "EIF_TYPE"
	c_eif_void: STRING = "EIF_VOID"
	c_eif_wide_char: STRING = "EIF_WIDE_CHAR"
	c_eif_windows: STRING = "EIF_WINDOWS"
	c_else: STRING = "else"
	c_endif: STRING = "#endif"
	c_equal: STRING = "=="
	c_extern: STRING = "extern"
	c_find_referers: STRING = "find_referers"
	c_float: STRING = "float"
	c_for: STRING = "for"
	c_fprintf: STRING = "fprintf"
	c_ge_alloc: STRING = "GE_alloc"
	c_ge_alloc_atomic: STRING = "GE_alloc_atomic"
	c_ge_alloc_cleared: STRING = "GE_alloc_cleared"
	c_ge_alloc_atomic_cleared: STRING = "GE_alloc_atomic_cleared"
	c_ge_argc: STRING = "GE_argc"
	c_ge_argv: STRING = "GE_argv"
	c_ge_bma: STRING = "GE_bma"
	c_ge_boxed: STRING = "GE_boxed"
	c_ge_call: STRING = "GE_call"
	c_ge_catcall: STRING = "GE_catcall"
	c_ge_ceiling: STRING = "GE_ceiling"
	c_ge_const_init: STRING = "GE_const_init"
	c_ge_deep: STRING = "GE_deep"
	c_ge_deep_twin: STRING = "GE_deep_twin"
	c_ge_default: STRING = "GE_default"
	c_ge_dts: STRING = "GE_dts"
	c_ge_floor: STRING = "GE_floor"
	c_ge_id_object: STRING = "GE_id_object"
	c_ge_int8: STRING = "GE_int8"
	c_ge_int16: STRING = "GE_int16"
	c_ge_int32: STRING = "GE_int32"
	c_ge_int64: STRING = "GE_int64"
	c_ge_ma: STRING = "GE_ma"
	c_ge_ms8: STRING = "GE_ms8"
	c_ge_ms32: STRING = "GE_ms32"
	c_ge_mt: STRING = "GE_mt"
	c_ge_nat8: STRING = "GE_nat8"
	c_ge_nat16: STRING = "GE_nat16"
	c_ge_nat32: STRING = "GE_nat32"
	c_ge_nat64: STRING = "GE_nat64"
	c_ge_new: STRING = "GE_new"
	c_ge_object_id: STRING = "GE_object_id"
	c_ge_object_id_free: STRING = "GE_object_id_free"
	c_ge_power: STRING = "GE_power"
	c_ge_raise: STRING = "GE_raise"
	c_ge_register_dispose: STRING = "GE_register_dispose"
	c_ge_rescue: STRING = "GE_rescue"
	c_ge_retry: STRING = "GE_retry"
	c_ge_setjmp: STRING = "GE_setjmp"
	c_ge_show_console: STRING = "GE_show_console"
	c_ge_types: STRING = "GE_types"
	c_ge_void: STRING = "GE_void"
	c_goto: STRING = "goto"
	c_id: STRING = "id"
	c_if: STRING = "if"
	c_ifdef: STRING = "#ifdef"
	c_ifndef: STRING = "#ifndef"
	c_include: STRING = "#include"
	c_initialize: STRING = "initialize"
	c_int: STRING = "int"
	c_int8_t: STRING = "int8_t"
	c_int16_t: STRING = "int16_t"
	c_int32_t: STRING = "int32_t"
	c_int64_t: STRING = "int64_t"
	c_is_special: STRING = "is_special"
	c_memcmp: STRING = "memcmp"
	c_memcpy: STRING = "memcpy"
	c_memset: STRING = "memset"
	c_not: STRING = "!"
	c_not_equal: STRING = "!="
	c_not_not: STRING = ""
	c_or_else: STRING = "||"
	c_return: STRING = "return"
	c_sizeof: STRING = "sizeof"
	c_stderr: STRING = "stderr"
	c_struct: STRING = "struct"
	c_switch: STRING = "switch"
	c_tc: STRING = "tc"
	c_tc_address: STRING = "&tc"
	c_type_id: STRING = "type_id"
	c_typedef: STRING = "typedef"
	c_undef: STRING = "#undef"
	c_unsigned: STRING = "unsigned"
	c_void: STRING = "void"
	c_volatile: STRING = "volatile"
	c_while: STRING = "while"
			-- String constants

	default_split_threshold: INTEGER = 1000000
			-- Default value for `split_threshold'

	bat_file_extension: STRING = ".bat"
	c_file_extension: STRING = ".c"
	cfg_file_extension: STRING = ".cfg"
	cpp_file_extension: STRING = ".cpp"
	h_file_extension: STRING = ".h"
	res_file_extension: STRING = ".res"
	rc_file_extension: STRING = ".rc"
	sh_file_extension: STRING = ".sh"
			-- File extensions

invariant

	current_dynamic_system_not_void: current_dynamic_system /= Void
	current_file_not_void: current_file /= Void
	current_file_open_write: current_file.is_open_write
	header_file_not_void: header_file /= Void
	header_file_open_write: header_file.is_open_write
	current_function_header_buffer_not_void: current_function_header_buffer /= Void
	current_function_body_buffer_not_void: current_function_body_buffer /= Void
	current_feature_not_void: current_feature /= Void
	current_type_not_void: current_type /= Void
	operand_stack_not_void: operand_stack /= Void
	no_void_operand: not operand_stack.has_void
	call_operands_not_void: call_operands /= Void
	no_void_call_operand: not call_operands.has_void
	conforming_type_set_not_void: conforming_type_set /= Void
	conforming_types_not_void: conforming_types /= Void
	non_conforming_types_not_void: non_conforming_types /= Void
	attachment_dynamic_type_ids_not_void: attachment_dynamic_type_ids /= Void
	target_dynamic_type_ids_not_void: target_dynamic_type_ids /= Void
	target_dynamic_types_not_void: target_dynamic_types /= Void
	no_void_target_dynamic_type: not target_dynamic_types.has_void_item
	equality_type_set_not_void: equality_type_set /= Void
	equality_common_types_not_void: equality_common_types /= Void
	standalone_type_sets_not_void: standalone_type_sets /= Void
	deep_twin_types_not_void: deep_twin_types /= Void
	no_void_deep_twin_type: not deep_twin_types.has_void
	deep_equal_types_not_void: deep_equal_types /= Void
	no_void_deep_equal_type: not deep_equal_types.has_void
	deep_feature_target_type_sets_not_void: deep_feature_target_type_sets /= Void
	no_void_deep_feature_target_type_set: not deep_feature_target_type_sets.has_void_item
	no_void_deep_feature_static_target_type: not deep_feature_target_type_sets.has_void
	current_agents_not_void: current_agents /= Void
	no_void_agent: not current_agents.has_void
	agent_instruction_not_void: agent_instruction /= Void
	agent_expression_not_void: agent_expression /= Void
	agent_target_not_void: agent_target /= Void
	agent_arguments_not_void: agent_arguments /= Void
	agent_open_operands_not_void: agent_open_operands /= Void
	no_void_agent_open_operand: not agent_open_operands.has_void
	agent_closed_operands_not_void: agent_closed_operands /= Void
	no_void_agent_closed_operand: not agent_closed_operands.has_void
	agent_closed_operands_type_not_void: agent_closed_operands_type /= Void
	wrapper_expression_not_void: wrapper_expression /= Void
	manifest_array_types_not_void: manifest_array_types /= Void
	no_void_manifest_array_type: not manifest_array_types.has_void
	big_manifest_array_types_not_void: big_manifest_array_types /= Void
	no_void_big_manifest_array_type: not big_manifest_array_types.has_void
	manifest_tuple_types_not_void: manifest_tuple_types /= Void
	no_void_manifest_tuple_type: not manifest_tuple_types.has_void
	current_object_tests_not_void: current_object_tests /= Void
	no_void_current_object_test: not current_object_tests.has_void
	current_object_equalities_not_void: current_object_equalities /= Void
	no_void_current_object_equality: not current_object_equalities.has_void
	current_equalities_not_void: current_equalities /= Void
	no_void_current_equality: not current_equalities.has_void
	called_features_not_void: called_features /= Void
	no_void_called_feature: not called_features.has_void
	once_features_not_void: once_features /= Void
	no_void_once_feature: not once_features.has_void
	-- once_feature_constraint: forall f in once_features, f = f.implementation_feature
	constant_features_not_void: constant_features /= Void
	no_void_constant_feature: not constant_features.has_void
	-- constant_feature_constraint: forall f in constant_features, f = f.implementation_feature
	inline_constants_not_void: inline_constants /= Void
	no_void_inline_constant: not inline_constants.has_void
	no_void_inline_constant_type: not inline_constants.has_void_item
	dispose_procedures_not_void: dispose_procedures /= Void
		-- Temporary variables.
	temp_variables_not_void: temp_variables /= Void
	no_void_temp_variable: not temp_variables.has_void
	used_temp_variables_not_void: used_temp_variables /= Void
	used_temp_variables_count: used_temp_variables.count <= temp_variables.count
	free_temp_variables_not_void: free_temp_variables /= Void
	free_temp_variables_count: free_temp_variables.count = used_temp_variables.count
	frozen_temp_variables_not_void: frozen_temp_variables /= Void
	frozen_temp_variables_count: frozen_temp_variables.count = used_temp_variables.count
		--
	included_header_filenames_not_void: included_header_filenames /= Void
	no_void_included_header_filename: not included_header_filenames.has_void
	included_runtime_header_files_not_void: included_runtime_header_files /= Void
	no_void_included_runtime_header_file: not included_runtime_header_files.has_void
	included_runtime_c_files_not_void: included_runtime_c_files /= Void
	no_void_included_runtime_c_file: not included_runtime_c_files.has_void
	c_filenames_not_void: c_filenames /= Void
	no_void_c_filename: not c_filenames.has_void
	no_void_c_file_extension: not c_filenames.has_void_item
		-- Rescue clauses.
	locals_written_not_void: locals_written /= Void
	no_void_local_written: not locals_written.has_void
	locals_written_in_body_not_void: locals_written_in_body /= Void
	no_void_local_written_in_body: not locals_written_in_body.has_void
	locals_written_in_rescue_not_void: locals_written_in_rescue /= Void
	no_void_local_written_in_rescue: not locals_written_in_rescue.has_void
	locals_read_not_void: locals_read /= Void
	no_void_local_read: not locals_read.has_void
	locals_read_in_body_not_void: locals_read_in_body /= Void
	no_void_local_read_in_body: not locals_read_in_body.has_void
	locals_read_in_rescue_not_void: locals_read_in_rescue /= Void
	no_void_local_read_in_rescue: not locals_read_in_rescue.has_void
		-- Regular expressions for external features.
	external_c_regexp_not_void: external_c_regexp /= Void
	external_c_regexp_compiled: external_c_regexp.is_compiled
	external_c_macro_regexp_not_void: external_c_macro_regexp /= Void
	external_c_macro_regexp_compiled: external_c_macro_regexp.is_compiled
	external_c_struct_regexp_not_void: external_c_struct_regexp /= Void
	external_c_struct_regexp_compiled: external_c_struct_regexp.is_compiled
	external_c_inline_regexp_not_void: external_c_inline_regexp /= Void
	external_c_inline_regexp_compiled: external_c_inline_regexp.is_compiled
	old_external_c_regexp_not_void: old_external_c_regexp /= Void
	old_external_c_regexp_compiled: old_external_c_regexp.is_compiled
	old_external_c_macro_regexp_not_void: old_external_c_macro_regexp /= Void
	old_external_c_macro_regexp_compiled: old_external_c_macro_regexp.is_compiled
	old_external_c_struct_regexp_not_void: old_external_c_struct_regexp /= Void
	old_external_c_struct_regexp_compiled: old_external_c_struct_regexp.is_compiled
	external_cpp_regexp_not_void: external_cpp_regexp /= Void
	external_cpp_regexp_compiled: external_cpp_regexp.is_compiled
	external_cpp_inline_regexp_not_void: external_cpp_inline_regexp /= Void
	external_cpp_inline_regexp_compiled: external_cpp_inline_regexp.is_compiled
	external_dllwin_regexp_not_void: external_dllwin_regexp /= Void
	external_dllwin_regexp_compiled: external_dllwin_regexp.is_compiled
	old_external_dllwin32_regexp_not_void: old_external_dllwin32_regexp /= Void
	old_external_dllwin32_regexp_compiled: old_external_dllwin32_regexp.is_compiled
		--
	split_threshold_positive: split_threshold > 0
	system_name_not_void: system_name /= Void
	dynamic_type_id_set_names_not_void: dynamic_type_id_set_names /= Void
	no_void_dynamic_type_id_set_name: not dynamic_type_id_set_names.has_void_item
	no_void_dynamic_type_id_set: not dynamic_type_id_set_names.has_void
	current_dynamic_type_sets_not_void: current_dynamic_type_sets /= Void
	extra_dynamic_type_sets_not_void: extra_dynamic_type_sets /= Void
	agent_tuple_item_expressions_not_void: agent_tuple_item_expressions /= Void
	agent_manifest_tuple_not_void: agent_manifest_tuple /= Void
	formal_arguments_not_void: formal_arguments /= Void
	no_void_formal_argument: not formal_arguments.has_void
	current_call_info_not_void: current_call_info /= Void

end
