indexing

	description:

		"Code generators"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 2004-2009, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2009-04-22 14:37:59 +0100 (Wed, 22 Apr 2009) $"
	revision: "$Revision: 6626 $"

	edp_mods: "[
		once_manifest_strings
		report_giaaa_error_cl ("__CLASS__", "__LINE__")
		...
	]"

deferred class ET_CODE_GENERATOR

inherit

	ET_AST_NULL_PROCESSOR
		rename
			make as make_null
		end

	ET_TOKEN_CODES
		export {NONE} all end

	UT_SHARED_TEMPLATE_EXPANDER
		export {NONE} all end

	ET_SHARED_TOKEN_CONSTANTS
		export {NONE} all end

	ET_SHARED_IDENTIFIER_TESTER
		export {NONE} all end

	KL_SHARED_STREAMS
		export {NONE} all end

	KL_SHARED_FILE_SYSTEM
		export {NONE} all end

	KL_SHARED_EXECUTION_ENVIRONMENT
		export {NONE} all end

	KL_SHARED_STRING_EQUALITY_TESTER
		export {NONE} all end

	KL_IMPORTED_CHARACTER_ROUTINES
		export {NONE} all end

	KL_IMPORTED_INTEGER_ROUTINES
		export {NONE} all end

	KL_IMPORTED_STRING_ROUTINES
		export {NONE} all end

	UT_IMPORTED_FORMATTERS
		export {NONE} all end

feature -- Access

	current_system: ET_SYSTEM is
			-- Surrounding Eiffel system
			-- (Note: there is a frozen feature called `system' in
			-- class GENERAL of SmartEiffel 1.0)
		do
			Result := current_dynamic_system.current_system
		ensure
			current_system_not_void: Result /= Void
		end

	current_dynamic_system: ET_DYNAMIC_SYSTEM
			-- Surrounding Eiffel dynamic system

feature -- Error handling

	error_handler: ET_ERROR_HANDLER is
			-- Error handler
		do
			Result := current_system.error_handler
		ensure
			error_handler_not_void: Result /= Void
		end

feature {NONE} -- Error handling

	set_fatal_error is
			-- Report a fatal error.
		do
			has_fatal_error := True
		ensure
			has_fatal_error: has_fatal_error
		end

	report_cannot_read_error (a_filename: STRING) is
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

	report_cannot_write_error (a_filename: STRING) is
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

feature -- Status report

	short_names: BOOLEAN
			-- Should short names be generated for type and feature names?

	has_fatal_error: BOOLEAN
			-- Has a fatal error occurred when generating `current_dynamic_system'?

feature -- Measurement

	never_void_target_count: INTEGER
			-- Number of calls whose target is guaranteed to be non-Void at compilation time

	can_be_void_target_count: INTEGER
			-- Number of calls for which it was not possible to guarantee at compilation
			-- time whether its target would never be Void

feature -- Compilation options

	console_application_mode: BOOLEAN is
			-- Should the generated application be a console application
			-- (or a Windows GUI application)?
		do
			Result := current_system.console_application_mode
		end

	exception_trace_mode: BOOLEAN is
			-- Should the generated application be able to provide an exception trace?
			-- An exception trace is the execution path from the root creation procedure
			-- to the feature where an exception occurred.
		do
			Result := current_system.exception_trace_mode
		end

	instruction_location_mode: BOOLEAN is
			-- Should the generated code be able to provide instruction location info
			-- for each routine stack frame, in the form class.feature / line_number ?
		do
			Result := False
		end

	finalize_mode: BOOLEAN
			-- Compilation with optimizations turned on?

	split_mode: BOOLEAN
			-- Should generated C code be split over several C files
			-- instead of being held in a single possibly large C file?
			-- When in split mode, the next C construct will be generated
			-- in a new C file if the current C file is already larger
			-- than `split_threshold' bytes.

	split_threshold: INTEGER
			-- When in split mode, the next C construct will be generated
			-- in a new C file if the current C file is already larger
			-- than `split_threshold' bytes.

	trace_mode: BOOLEAN is
			-- Should the generated application be compiled with trace turned on?
			-- The trace is displayed each time the execution enters or exits
			-- from a feature.
		do
			Result := current_system.trace_mode
		end

	use_boehm_gc: BOOLEAN
			-- Should the application be compiled with the Boehm GC?

	use_edp_gc: BOOLEAN
			-- Should the application be compiled with EDP's GC?

feature -- Compilation options setting

	set_finalize_mode (b: BOOLEAN) is
			-- Set `finalize_mode' to `b'.
		do
			finalize_mode := b
		ensure
			finalize_mode_set: finalize_mode = b
		end

	set_split_mode (b: BOOLEAN) is
			-- Set `split_mode' to `b'.
		do
			split_mode := b
		ensure
			split_mode_set: split_mode = b
		end

	set_split_threshold (v: INTEGER) is
			-- Set `split_threshold' to `v'.
		require
			v_positive: v > 0
		do
			split_threshold := v
		ensure
			split_threshold_set: split_threshold = v
		end

	set_use_boehm_gc (b: BOOLEAN) is
			-- Set `use_boehm_gc' to `b'.
		do
			use_boehm_gc := b
		ensure
			use_boehm_gc_set: use_boehm_gc = b
		end

	set_use_edp_gc (b: BOOLEAN) is
			-- Set `use_edp_gc' to `b'
		do
			use_edp_gc := b
		ensure
			use_edp_gc_set: use_edp_gc = b
		end

feature -- Generation

	generate (a_system_name: STRING) is
			-- Generate C code and C compilation script file for `current_dynamic_system'.
			-- Set `has_fatal_error' if a fatal error occurred.
		require
			a_system_name_not_void: a_system_name /= Void
		deferred
		end

	generate_ids is
			-- Generate types and feature ids.
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

feature {NONE} -- Feature generation

	print_features (a_type: ET_DYNAMIC_TYPE) is
			-- Print features of `a_type' to `current_file' and its signature to `header_file'.
		require
			a_type_not_void: a_type /= Void
		local
			old_type: ET_DYNAMIC_TYPE
			l_features: ET_DYNAMIC_FEATURE_LIST
			i, nb: INTEGER
		do
			old_type := current_type
			current_type := a_type
			l_features := a_type.queries
			nb := l_features.count
			from i := 1 until i > nb loop
				print_feature (l_features.item (i))
				i := i + 1
			end
			l_features := a_type.procedures
			nb := l_features.count
			from i := 1 until i > nb loop
				print_feature (l_features.item (i))
				i := i + 1
			end
			current_type := old_type
		end

	print_feature (a_feature: ET_DYNAMIC_FEATURE) is
			-- Print `a_feature' to `current_file' and its signature to `header_file'.
			-- Also print the precursors used in its body (calls to 'precursor').
		require
			a_feature_not_void: a_feature /= Void
		local
			old_type: ET_DYNAMIC_TYPE
			old_feature: ET_DYNAMIC_FEATURE
			old_dynamic_type_sets: ET_DYNAMIC_TYPE_SET_LIST
			i, nb: INTEGER
		do
			if not a_feature.is_semistrict (current_dynamic_system) then
				old_type := current_type
				current_type := a_feature.target_type
				old_feature := current_feature
				current_feature := a_feature
				old_dynamic_type_sets := current_dynamic_type_sets
				current_dynamic_type_sets := current_feature.dynamic_type_sets
				a_feature.static_feature.process (Current)
					-- Print declaration of agents used in `a_feature'.
					-- Note that we compute `current_agents.count' at each iteration
					-- because inline agents may contain other inline agents
					-- which will be added to `agents' on the fly.
				from i := 1 until i > current_agents.count loop
					print_agent_declaration (i, current_agents.item (i))
					i := i + 1
				end
				current_agents.wipe_out
					-- Print object-test functions.
				nb := current_object_tests.count
				from i := 1 until i > nb loop
					print_object_test_function (i, current_object_tests.item (i))
					i := i + 1
				end
				current_object_tests.wipe_out
					-- Print object-equality functions.
				nb := current_object_equalities.count
				from i := 1 until i > nb loop
					print_object_equality_function (i, current_object_equalities.item (i))
					i := i + 1
				end
				current_object_equalities.wipe_out
					-- Print equality functions.
				nb := current_equalities.count
				from i := 1 until i > nb loop
					print_equality_function (i, current_equalities.item (i))
					i := i + 1
				end
				current_equalities.wipe_out
				current_dynamic_type_sets := old_dynamic_type_sets
				current_feature := old_feature
				current_type := old_type
			end
		end

	print_agent_declaration (i: INTEGER; an_agent: ET_AGENT) is
			-- Print declaration of `i'-th agent `an_agent'.
		require
			an_agent_not_void: an_agent /= Void
		deferred
		end

	print_object_test_function (i: INTEGER; a_object_test: ET_OBJECT_TEST) is
			-- Print function corresponding to `i'-th object-test `a_object_test'
			-- to `current_file' and its signature to `header_file'.
			-- This function will return True or False depending if it's
			-- successful or not, and when successful it will attach
			-- the value of the expression passed as second argument
			-- to the object-test local whose address is passed as first
			-- argument.
		require
			a_object_test_not_void: a_object_test /= Void
		deferred
		end

	print_deferred_function (a_feature: ET_DEFERRED_FUNCTION) is
			-- Print `a_feature' to `current_file' and its signature to `header_file'.
		require
			a_feature_not_void: a_feature /= Void
		do
				-- Internal error: deferred features cannot be executed at run-time.
			set_fatal_error
			error_handler.report_giaaa_error_cl ("__CLASS__", "__LINE__")
		end

	print_deferred_procedure (a_feature: ET_DEFERRED_PROCEDURE) is
			-- Print `a_feature' to `current_file' and its signature to `header_file'.
		require
			a_feature_not_void: a_feature /= Void
		do
				-- Internal error: deferred features cannot be executed at run-time.
			set_fatal_error
			error_handler.report_giaaa_error_cl ("__CLASS__", "__LINE__")
		end

	print_do_function (a_feature: ET_DO_FUNCTION) is
			-- Print `a_feature' to `current_file' and its signature to `header_file'.
		require
			a_feature_not_void: a_feature /= Void
		do
			print_internal_function (a_feature)
		end

	print_do_procedure (a_feature: ET_DO_PROCEDURE) is
			-- Print `a_feature' to `current_file' and its signature to `header_file'.
		require
			a_feature_not_void: a_feature /= Void
		do
			print_internal_procedure (a_feature)
		end

	print_external_function (a_feature: ET_EXTERNAL_FUNCTION) is
			-- Print `a_feature' to `current_file' and its signature to `header_file'.
		require
			a_feature_not_void: a_feature /= Void
		do
			if current_feature.static_feature /= a_feature then
					-- Internal error: inconsistent `current_feature'.
				set_fatal_error
				error_handler.report_giaaa_error_cl ("__CLASS__", "__LINE__")
			else
				if current_feature.is_regular then
					print_external_routine (a_feature, False, False)
				end
				if current_feature.is_static then
					print_external_routine (a_feature, True, False)
				end
			end
		end

	print_external_procedure (a_feature: ET_EXTERNAL_PROCEDURE) is
			-- Print `a_feature' to `current_file' and its signature to `header_file'.
		require
			a_feature_not_void: a_feature /= Void
		do
			if current_feature.static_feature /= a_feature then
					-- Internal error: inconsistent `current_feature'.
				set_fatal_error
				error_handler.report_giaaa_error_cl ("__CLASS__", "__LINE__")
			else
				if current_feature.is_regular then
					print_external_routine (a_feature, False, False)
				end
				if current_feature.is_creation then
					print_external_routine (a_feature, False, True)
				end
				if current_feature.is_static then
					print_external_routine (a_feature, True, False)
				end
			end
		end


feature -- External routine bodies ...

	print_external_routine (a_feature: ET_EXTERNAL_ROUTINE; a_static: BOOLEAN; a_creation: BOOLEAN) is
			-- Print `a_feature' to `current_file' and its signature to `header_file'.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
			is_static: a_static implies current_feature.is_static
			is_creation: a_creation implies current_feature.is_creation
		deferred
		end

feature -- Internal routines

	print_internal_function (a_feature: ET_INTERNAL_FUNCTION) is
			-- Print `a_feature' to `current_file' and its signature to `header_file'.
		require
			a_feature_not_void: a_feature /= Void
		do
			if current_feature.static_feature /= a_feature then
					-- Internal error: inconsistent `current_feature'.
				set_fatal_error
				error_handler.report_giaaa_error_cl ("__CLASS__", "__LINE__")
			else
				if current_feature.is_regular then
					print_internal_routine (a_feature, False, False)
				end
				if current_feature.is_static then
					print_internal_routine (a_feature, True, False)
				end
			end
		end

	print_internal_procedure (a_feature: ET_INTERNAL_PROCEDURE) is
			-- Print `a_feature' to `current_file' and its signature to `header_file'.
		require
			a_feature_not_void: a_feature /= Void
		do
			if current_feature.static_feature /= a_feature then
					-- Internal error: inconsistent `current_feature'.
				set_fatal_error
				error_handler.report_giaaa_error_cl ("__CLASS__", "__LINE__")
			else
				if current_feature.is_regular then
					print_internal_routine (a_feature, False, False)
				end
				if current_feature.is_creation then
					print_internal_routine (a_feature, False, True)
				end
				if current_feature.is_static then
					print_internal_routine (a_feature, True, False)
				end
			end
		end

	print_once_function (a_feature: ET_ONCE_FUNCTION) is
			-- Print `a_feature' to `current_file' and its signature to `header_file'.
		require
			a_feature_not_void: a_feature /= Void
		do
			print_internal_function (a_feature)
		end

	print_once_procedure (a_feature: ET_ONCE_PROCEDURE) is
			-- Print `a_feature' to `current_file' and its signature to `header_file'.
		require
			a_feature_not_void: a_feature /= Void
		do
			print_internal_procedure (a_feature)
		end

	print_internal_routine (a_feature: ET_INTERNAL_ROUTINE; a_static: BOOLEAN; a_creation: BOOLEAN) is
			-- Print `a_feature' to `current_file' and its signature to `header_file'.
		require
			a_feature_not_void: a_feature /= Void
			valid_feature: current_feature.static_feature = a_feature
			is_static: a_static implies current_feature.is_static
			is_creation: a_creation implies current_feature.is_creation
		deferred
		end

feature {NONE} -- Equality generation

	print_equality_function (i: INTEGER; an_expression: ET_EQUALITY_EXPRESSION) is
			-- Print function corresponding to `i'-th equality ('=' or '/=')
			-- `an_expression' to `current_file' and its signature to `header_file'.
			-- We need a function for equality when the dynamic type set of operands
			-- contains expanded types.
		require
			an_expression_not_void: an_expression /= Void
		deferred
		end

	print_object_equality_function (i: INTEGER; an_expression: ET_OBJECT_EQUALITY_EXPRESSION) is
			-- Print function corresponding to `i'-th object equality ('~' or '/~')
			-- `an_expression' to `current_file' and its signature to `header_file'.
		require
			an_expression_not_void: an_expression /= Void
		deferred
		end

feature {NONE} -- Access

	system_name: STRING
			-- Name of the system being compiled

	current_feature: ET_DYNAMIC_FEATURE
			-- Feature being processed

	current_type: ET_DYNAMIC_TYPE
			-- Type where `current_feature' belongs

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

	dynamic_type_set (an_operand: ET_OPERAND): ET_DYNAMIC_TYPE_SET is
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
						error_handler.report_giaaa_error_cl ("__CLASS__", "__LINE__")
						Result := current_dynamic_system.unknown_type
					end
				end
			end
		ensure
			dynamic_type_set_not_void: Result /= Void
		end

	dynamic_type_set_in_feature (an_operand: ET_OPERAND; a_feature: ET_DYNAMIC_FEATURE): ET_DYNAMIC_TYPE_SET is
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
					error_handler.report_giaaa_error_cl ("__CLASS__", "__LINE__")
					Result := current_dynamic_system.unknown_type
				end
			end
		ensure
			dynamic_type_set_not_void: Result /= Void
		end

	argument_type_set (i: INTEGER): ET_DYNAMIC_TYPE_SET is
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
					error_handler.report_giaaa_error_cl ("__CLASS__", "__LINE__")
					Result := current_dynamic_system.unknown_type
				end
			end
		ensure
			argument_type_set_not_void: Result /= Void
		end

	argument_type_set_in_feature (i: INTEGER; a_feature: ET_DYNAMIC_FEATURE): ET_DYNAMIC_TYPE_SET is
			-- Dynamic type set of `i'-th argument of `a_feature';
			-- Report a fatal error if not known
		require
			a_feature_not_void: a_feature /= Void
		do
			Result := a_feature.argument_type_set (i)
			if Result = Void then
					-- Internal error: dynamic type set not known.
				set_fatal_error
				error_handler.report_giaaa_error_cl ("__CLASS__", "__LINE__")
				Result := current_dynamic_system.unknown_type
			end
		ensure
			argument_type_set_not_void: Result /= Void
		end

	result_type_set_in_feature (a_feature: ET_DYNAMIC_FEATURE): ET_DYNAMIC_TYPE_SET is
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

	conforming_types: ET_DYNAMIC_TYPE_LIST
			-- Types conforming to the target of the current assignment attempt or
			-- types to which the target of the current call to 'ANY.conforms_to' conform;
			-- Also used for the arguments of PROCEDURE.call and FUNCTION.item to
			-- detect CAT-calls

	non_conforming_types: ET_DYNAMIC_TYPE_LIST
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

	equality_common_types: ET_DYNAMIC_TYPE_LIST
			-- List of types that are part of the dynamic type set of both
			-- operands in an equality expression ('=', '/=', '~' or '/~')

	dynamic_type_id_sorter: DS_QUICK_SORTER [INTEGER] is
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

end