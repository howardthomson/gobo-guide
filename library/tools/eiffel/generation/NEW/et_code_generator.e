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

	once_gc_references: DS_HASH_SET [ET_FEATURE]
			-- Once features with reference values
			-- For GC mark routine generation

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

feature -- EDP specific

	enable_locals_as_struct: BOOLEAN is True
		-- True to enable enclosing local variables in a C struct

	enable_ge_stack_trace: BOOLEAN is True
		-- True to enable traceback of the Eiffel stack

-- Note that enable_ge_stack_trace implies enable_locals_as_struct

	in_locals_declaration: BOOLEAN
		-- True when processing the C struct for declaring local variables

	in_internal_routine: BOOLEAN
		-- True when processing body of an internal routine
		-- Used to enable generation of 'locals.' prefix for
		-- references to locals declared inside a C struct.

--	in_locals_declaration: BOOLEAN
		-- True during the printing of the locals C struct in
		-- the declaration phase of an internal routine

	is_trace_class (a_feature: ET_ROUTINE): BOOLEAN is
			-- Is this routine of a class for which we wish to trace
			-- routine entry and exit ?
		local
			l_class_name: STRING
		do
			l_class_name := a_feature.implementation_class.name.name
			if      l_class_name.is_equal("CT_MAKEFILE_PARSER")
	--		or else l_class_name.is_equal("ET_DYNAMIC_QUALIFIED_QUERY_CALL")
			then
				Result := True
			end
		end

	not_whitespace (s: STRING; i: INTEGER): BOOLEAN is
			-- True if character at i (if it exists) is
			-- not a 'white-space' character
		do
			if i <= s.count then
				Result := True
				inspect s.item (i)
				when ' ', '%T', '%R', '%N' then
					Result := False
				else
				end
			end
		end

	print_routine_descriptor (a_feature: ET_ROUTINE) is
			-- Emit the static struct describing the arguments and
			-- locals, and Result, of a routine
		do
			print_indentation
			current_file.put_string(once "static struct {")
			indent
				-- print detail ...
					-- once flag, for initialisation
					-- arguments info
					-- locals info
					-- Result info
					-- Previous stack_frame info

			dedent
			print_indentation
			current_file.put_line (once "} ge_rd;")	-- Gobo Eiffel _ routine descriptor
		end

	enable_routine_entry_exit_trace: BOOLEAN is True

-- #######################################################################################


end
