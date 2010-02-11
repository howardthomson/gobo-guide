indexing
	description: "[
		Custom ANY class for EDP: the Eiffel Developers Project
		Version customized for GEC compatibility.
	]"
	library: "Free implementation of ELKS library"
	copyright: "Copyright (c) 1986-2004, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date: 2006/03/03 10:18:46 $"
	revision: "$Revision: 1.3 $"

	copyright: "Copyright (c) 2006 Howard Thomson"

	todo: "[
		Adapt to GOBO compilation requirements
	]"

class ANY


--######################################################
-- Customization for EDP
--######################################################

feature {NONE}

	int_abs (i: INTEGER): INTEGER is
			-- Replacement for faulty INTEGER_32.abs
			-- Faulty as of 2007-08-13
		do
			if i < 0 then
				Result := -i
			else
				Result := i
			end
		end

	die_with_code (i: INTEGER) is
			-- SE routine to exit (horribly!)
			-- with specified exit code
		do
			-- TODO
		end

	print_run_time_stack is
		external "C"
		alias "GE_print_stack"
		end

	not_yet_implemented is
		do
			-- TODO
		end

feature {ANY}

	trace_flag: BOOLEAN is True

	fx_trace (n: INTEGER; sa: ARRAY [STRING]) is
    	local
        	i: INTEGER
         	s: STRING
      	do
      		if trace_flag then
         		from
            		i := 1
         		until
            		i > sa.count
         		loop
            		s := sa @ i
            		if s /= Void then
            	   		io.put_string (s)
            		end
            		i := i + 1
         		end
         		io.put_string ("%N")
        	end
      	end

	fx_trace2 (s: STRING) is
		do
			if trace_flag then
				io.put_string (s)
				io.put_string ("%N")
			end
		end

	edp_trace: EDP_TRACE is
		once
			create Result
		end

	rq_trace (sa: ARRAY [ STRING ]): BOOLEAN is
			-- Used to trace redefined routines by using the
			-- require clause
		do
			fx_trace (0, sa)
			Result := True
		end

	out_or_void (o: ANY): STRING is
		do
			if o = Void then
				Result := once "Void"
			else
				Result := o.out
			end
		end

	trace_s (s: STRING) is
		do
			io.put_string (s)
		end

	trace_nl is
		do
			trace_s (once "%N")
		end

   trace_sa(sa: ARRAY[STRING]) is
   	do
   		fx_trace (0, sa)
   	end

	fxerror (s: STRING): BOOLEAN is
		do
			io.put_string (s)
			io.put_new_line
			die_with_code (1)
		end

	once_stack_trace is
		once
		--	print_run_time_stack
		end

	get_app: SB_APPLICATION is
    	do
        	Result := shared_app.value
      	end

	shared_app: SB_APP_SHARED is
    	once
        	create Result
      	end

	todo (s: STRING) is
			-- Notify incomplete routine
			--| extend to report each instance only once ??
			--| use dictonary of hashed values of generated report strings
      	do
      		if trace_flag then
	      		io.put_string ("TODO ==> ")
	         	io.put_string (s)
	         	io.put_string ("%N")
	         end
      	end

	S_alpha:	INTEGER is 1
	S_beta:		INTEGER is 2
	S_gamma:	INTEGER is 3

	implementation_status: INTEGER is
		do
			Result := S_alpha
		end

feature -- Tracing implementation

	tracing: BOOLEAN is True

	report_trace: BOOLEAN is
		do
			io.put_string ("Trace PC: ")
			io.put_string (program_counter.out)
			io.put_string ("%N")

			Result := True
		end

	program_counter: INTEGER is
		do
--		external "C"
--		alias "pc"
		end

	ggg: EDP_GLOBAL is
		once
			create Result
		end

	discard_result is
			-- discard Result
			-- Avoid the need to assign result to a
			-- redundantly declared 'variable'
		do
		end


	stop_on_unimplemented: BOOLEAN is True

	implemented (ok: BOOLEAN): BOOLEAN is
		do
			if (not ok) and then stop_on_unimplemented then
				not_yet_implemented
			end
		end

--######################################################
-- GOBO Free_elks Library ANY
--######################################################

feature -- Access

	generator: STRING is
			-- Name of current object's generating class
			-- (base class of the type of which it is a direct instance)
		external
			"built_in"
		end

 	generating_type: STRING is
			-- Name of current object's generating type
			-- (type of which it is a direct instance)
		external
			"built_in"
 		end

feature -- Status report

	conforms_to (other: ANY): BOOLEAN is
			-- Does type of current object conform to type
			-- of `other' (as per Eiffel: The Language, chapter 13)?
		require
			other_not_void: other /= Void
		external
			"built_in"
		end

	same_type (other: ANY): BOOLEAN is
			-- Is type of current object identical to type of `other'?
		require
			other_not_void: other /= Void
		external
			"built_in"
		ensure
			definition: Result = (conforms_to (other) and
										other.conforms_to (Current))
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object considered
			-- equal to current object?
		require
			other_not_void: other /= Void
		do
			Result := standard_is_equal (other)
		ensure
			symmetric: Result implies other.is_equal (Current)
			consistent: standard_is_equal (other) implies Result
		end

	frozen standard_is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object of the same type
			-- as current object, and field-by-field identical to it?
		require
			other_not_void: other /= Void
		external
			"built_in"
		ensure
			same_type: Result implies same_type (other)
			symmetric: Result implies other.standard_is_equal (Current)
		end

	frozen equal (some: ANY; other: like some): BOOLEAN is
			-- Are `some' and `other' either both void or attached
			-- to objects considered equal?
		do
			if some = Void then
				Result := other = Void
			else
				Result := other /= Void and then
							some.is_equal (other)
			end
		ensure
			definition: Result = (some = Void and other = Void) or else
						((some /= Void and other /= Void) and then
						some.is_equal (other))
		end

	frozen standard_equal (some: ANY; other: like some): BOOLEAN is
			-- Are `some' and `other' either both void or attached to
			-- field-by-field identical objects of the same type?
			-- Always uses default object comparison criterion.
		do
			if some = Void then
				Result := other = Void
			else
				Result := other /= Void and then
							some.standard_is_equal (other)
			end
		ensure
			definition: Result = (some = Void and other = Void) or else
						((some /= Void and other /= Void) and then
						some.standard_is_equal (other))
		end

	frozen is_deep_equal (other: like Current): BOOLEAN is
			-- Are `Current' and `other' attached to isomorphic object structures?
		require
			other_not_void: other /= Void
		external
			"built_in"
		ensure
			shallow_implies_deep: standard_is_equal (other) implies Result
			same_type: Result implies same_type (other)
			symmetric: Result implies other.is_deep_equal (Current)
		end

	frozen deep_equal (some: ANY; other: like some): BOOLEAN is
			-- Are `some' and `other' either both void
			-- or attached to isomorphic object structures?
		do
			if some = Void then
				Result := other = Void
			else
				Result := other /= Void and then some.is_deep_equal (other)
			end
		ensure
			shallow_implies_deep: standard_equal (some, other) implies Result
			both_or_none_void: (some = Void) implies (Result = (other = Void))
			same_type: (Result and (some /= Void)) implies some.same_type (other)
			symmetric: Result implies deep_equal (other, some)
		end

feature -- Duplication

	frozen twin: like Current is
			-- New object equal to `Current'
			-- `twin' calls `copy'; to change copying/twining semantics, redefine `copy'.
		external
			"built_in"
		ensure
			twin_not_void: Result /= Void
			is_equal: Result.is_equal (Current)
		end
		
	copy (other: like Current) is
			-- Update current object using fields of object attached
			-- to `other', so as to yield equal objects.
		require
			other_not_void: other /= Void
			type_identity: same_type (other)
		do
			standard_copy (other)
		ensure
			is_equal: is_equal (other)
		end

	frozen standard_copy (other: like Current) is
			-- Copy every field of `other' onto corresponding field
			-- of current object.
		require
			other_not_void: other /= Void
			type_identity: same_type (other)
		external
			"built_in"
		ensure
			is_standard_equal: standard_is_equal (other)
		end

	frozen clone (other: ANY): like other is
			-- Void if `other' is void; otherwise new object
			-- equal to `other'
			--
			-- For non-void `other', `clone' calls `copy';
		 	-- to change copying/cloning semantics, redefine `copy'.
		obsolete
			"Use `twin' instead."
		do
			if other /= Void then
				Result := other.twin
			end
		ensure
			equal: equal (Result, other)
		end

	frozen standard_clone (other: ANY): like other is
			-- Void if `other' is void; otherwise new object
			-- field-by-field identical to `other'.
			-- Always uses default copying semantics.
		obsolete
			"Use `standard_twin' instead."
		do
			if other /= Void then
				Result := other.standard_twin
			end
		ensure
			equal: standard_equal (Result, other)
		end

	frozen standard_twin: like Current is
			-- New object field-by-field identical to `other'.
			-- Always uses default copying semantics.
		external
			"built_in"
		ensure
			standard_twin_not_void: Result /= Void
			equal: standard_equal (Result, Current)
		end
		
	frozen deep_twin: like Current is
			-- New object structure recursively duplicated from Current.
		external
			"built_in"
		ensure
			deep_equal: deep_equal (Current, Result)
		end

	frozen deep_clone (other: ANY): like other is
			-- Void if `other' is void: otherwise, new object structure
			-- recursively duplicated from the one attached to `other'
		obsolete
			"Use `deep_twin' instead."
		do
			if other /= Void then
				Result := other.deep_twin
			end
		ensure
			deep_equal: deep_equal (other, Result)
		end

	frozen deep_copy (other: like Current) is
			-- Effect equivalent to that of:
			--		`copy' (`other' . `deep_twin')
		require
			other_not_void: other /= Void
		do
			copy (other.deep_twin)
		ensure
			deep_equal: deep_equal (Current, other)
		end

feature {NONE} -- Retrieval

	frozen internal_correct_mismatch is
			-- Called from runtime to perform a proper dynamic dispatch on `correct_mismatch'
			-- from MISMATCH_CORRECTOR.
		local
			l_corrector: MISMATCH_CORRECTOR
			l_msg: STRING
			l_exc: EXCEPTIONS
		do
			l_corrector ?= Current
			if l_corrector /= Void then
				l_corrector.correct_mismatch
			else
				create l_msg.make_from_string ("Mismatch: ")
				create l_exc
				l_msg.append (generating_type)
				l_exc.raise_retrieval_exception (l_msg)
			end
		end

feature -- Output

	io: STD_FILES is
			-- Handle to standard file setup
		once
			create Result
			Result.set_output_default
		end

	out: STRING is
			-- New string containing terse printable representation
			-- of current object
		do
			Result := tagged_out
		end

	frozen tagged_out: STRING is
			-- New string containing terse printable representation
			-- of current object
		external
			"built_in"
		end

	print (some: ANY) is
			-- Write terse external representation of `some'
			-- on standard output.
		do
			if some /= Void then
				io.put_string (some.out)
			end
		end

feature -- Platform

	Operating_environment: OPERATING_ENVIRONMENT is
			-- Objects available from the operating system
		once
			create Result
		end

feature {NONE} -- Initialization

	default_create is
			-- Process instances of classes with no creation clause.
			-- (Default: do nothing.)
		do
		end

feature -- Basic operations

	default_rescue is
			-- Process exception for routines with no Rescue clause.
			-- (Default: do nothing.)
		do
		end

	frozen do_nothing is
			-- Execute a null action.
		do
		end

	frozen default: like Current is
			-- Default value of object's type
		do
		end

	frozen default_pointer: POINTER is
			-- Default value of type `POINTER'
			-- (Avoid the need to write `p'.`default' for
			-- some `p' of type `POINTER'.)
		do
		ensure
			-- Result = Result.default
		end

invariant

--	From GOBO Free_elks ANY invariant:

	reflexive_equality: standard_is_equal (Current)
	reflexive_conformance: conforms_to (Current)

end -- class ANY
