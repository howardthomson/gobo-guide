note

	description:

		"LLVM (Low Level Virtual Machine) code generator"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 2004-2010, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

	code_base: "ET_C_GENERATOR Git Commit: 742f7d99f9cb2717e38a34e5f27b57650626c6cd"

	edp_mods: "[
		report_giaaa_error_cl ("__CLASS__", "__LINE__")
		...
	]"

	to_redo: "[
		trace entry/exit
		Fix failure to report: "unable to read/include XXX.h file"
	]"

	todo: "[
		Code generation for locals:
			Instead of all references to locals and Current [C] being in the struct{}locals , declare both C locals and
			struct{}locals and store into struct{}locals prior to any call to another routine ...

		Note tcc 0.9.25 compiles C very fast, but does not correctly compile the runtime in GE_setup_signal_handling ...
		For tcc and varargs, need to include $TCC/lib/x86_64/libtcc1.o in object files
		
		Fix TYPE.name generating ->a1 references and assignments [Done]

		Implement __CLASS__ as the class name in which the source text resides, rather than the (current) type
		for which code is being generated. Currently, for Precursor calls __CLASS__ becomes the descendant class
		from which the Precursor call comes ... which is confusing!
	
		Generate timing code per routine, for selected classes, to report min,max,std_dev etc execution times
		for a specific execution of a routine, to look for opportunities for parallelism ...

		Find all the class types that are reachable from the ET_C_GENERATOR and the ET_DYNAMIC_TYPEs, most
		of which will need to be re-created when loading a previously generated .so library.
		It should not be necessary (!) to recreate all of the accessible AST objects from the originating
		parsing process, or the tokens of the syntax pass !
		
		Distinguish between finalized and development code, varying C routine naming, to prevent linking
			between incompatible compiled code, re stack layout in particular.
		check order of generated code for exceptions:
			gesetjmp, set_gerescue etc
		report unable to access compiler included files, such as ge_eiffel.h !
		expanded class code generation ordering re C structs
		routine descriptors, for stack trace
		class descriptors for debug inspection, general introspection
		routine inlining

		Does the current code use memory allocated by the GC aware infrastructure during the
		deep_twin process, and does that affect the way EDP's GC routines work ?
		
		Re-work print_polymorphic_*_calls to generate a routine address registration routine, and
		modify call generation to use data-structure routine lookup. Similarly for attribute access.

		Polymorphic call evaluation needs to accumulate GC reachability, so as to be able to suppress
		generation of GC description on the stack when unnecessary. Also need to detect inline-ability
		by reporting non-polymorphic calls, allowing for the possibility of dynamic class loading.

		Consider how to overload dynamic types at run-time, by de-activating registratable routines &c,
		to make possible the partial recompilation of an executable system.

		Consider how to mix C generated code and LLVM generated code, depending on things like floating-point
		support in LLVM and external calls etc.

		GC:
			Change marking routines to pass address of reference, to permit moving collector adaptation,
			and to check for NULL reference, needed now ...
			
			Mark once function results
			Mark once strings
			Mark manifest strings
			Mark stack structs
			Mark inline constants [geic*]
			Mark manifest arrays ... ??

			Implement ability to deal with expanded attribute(s) that contain references attributes
			
			Consider how to polymorphically call a routine to mark a C struct
			Either use the unique id field
			or store a routine pointer in the struct

			Establish whether it is sufficient to use a C struct on the stack to force reference attributes
			to be addressable by the GC. Does the absence of an address-of operator permit the C compiler to
			retain (cache) a reference in a register accross a call boundary (sequence-point) ?

			Adapt push_operand et al to assign reference arguments to local reference variables to ensure that
			the GC stack marking code has access to all intermediate reference routine arguments.

			Suppress GC tracking in routines for which the GC cannot be called ...
				No creation calls, and no routines calls that could invoke the GC indirectly
		
		Write code to establish the set of dynamic types that are referenced during the code generation phase.
		Establish whether and to what extent assertions will fail for these types when they are dynamically
		recreated from previously generated code libraries.

		LLVM implementation needed for:
		
			print_external_builtin_arguments_function_body
			print_external_builtin_boolean_function_body
			print_external_builtin_function_function_body
			print_external_builtin_identified_function_body
			print_external_builtin_platform_function_body
			print_external_builtin_pointer_function_body
			print_external_builtin_sized_character_function_body
			print_external_builtin_sized_integer_function_body
			print_external_builtin_sized_real_function_body
			print_external_builtin_special_function_body
			print_external_builtin_tuple_function_body
			print_external_builtin_type_function_body
			print_external_builtin_any_procedure_body
			print_external_builtin_ .....
			print_internal_routine
			print_attribute_wrapper
			print_assignment
			print_assignment_attempt
			print_creation_instruction
			print_if_instruction
			print_inspect_instruction
			print_instruction
			print_assign_code_position
			print_loop_instruction
			print_precursor_instruction
			print_qualified_call_instruction
			print_retry_instruction
			print_static_call_instruction
			print_unqualified_call_instruction
			print_tuple_label_setter_call
			print_non_inlined_procedure_call
			print_expression_address
			print_false_constant
			print_feature_address
			print_formal_argument
			print_hexadecimal_integer_constant
			print_integer_constant
			print_local_variable
			print_manifest_array
			print_manifest_string
			print_manifest_tuple
			print_manifest_type
			print_non_void_expression
			print_object_test
			print_object_test_local
			print_once_manifest_string
			print_precursor_expression
			print_qualified_call_expression
			print_regular_integer_constant
			print_regular_real_constant
			print_result
			print_result_address
			print_static_call_expression
			print_strip_expression
			print_target_expression
			print_temporary_variable
			print_true_constant
			print_unboxed_expression
			print_underscored_integer_constant
			print_underscored_real_constant
			print_unqualified_call_expression
			print_unqualified_identifier_call_expression
			print_void
			print_writable
			print_object_test_function
			print_adapted_named_query_call
			print_query_call
			print_non_inlined_query_call

			Check for duplication of inline constants [strings]
			]"

	done: "[
		gealloc_id -- for GC mods later
		expansion of "__CLASS__" and "__LINE__" strings
		locals as struct -- for GC and Debug
		External C, incorrect casts for generated C code, for SELECT_API.c_select
			(char *) whereas previous ET_C_GENERATOR did not emit a cast
		once_manifest_strings (Eric now done ?)
		print_types modified, to check for l_expanded_sorter.has( a-previously-added-expanded-type )
	]"

class ET_LLVM_C_GENERATOR

inherit

	ET_C_GENERATOR
		redefine
			generate_ids
		end

create

	make

feature -- Generation

	generate_ids
		do
			Precursor
		end


end
