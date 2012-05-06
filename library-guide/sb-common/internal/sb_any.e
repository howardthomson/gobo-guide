note

	description: "Features shared by all [most] Slyboots classes"

class SB_ANY

feature {NONE}

	int_abs (i: INTEGER): INTEGER
			-- Replacement for faulty INTEGER_32.abs
			-- Faulty as of 2007-08-13
		do
			if i < 0 then
				Result := -i
			else
				Result := i
			end
		end

	die_with_code (i: INTEGER)
			-- SE routine to exit (horribly!)
			-- with specified exit code
		do
			-- TODO
		end

	print_run_time_stack
		external "C"
		alias "GE_print_stack"
		end

	not_yet_implemented
		do
			-- TODO
		end

feature {ANY}

	trace_flag: BOOLEAN = True

	fx_trace (n: INTEGER; sa: ARRAY [STRING])
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

	fx_trace2 (s: STRING)
		do
			if trace_flag then
				io.put_string (s)
				io.put_string ("%N")
			end
		end

	edp_trace: EDP_TRACE
		once
			create Result
		end

	rq_trace (sa: ARRAY [ STRING ]): BOOLEAN
			-- Used to trace redefined routines by using the
			-- require clause
		do
			fx_trace (0, sa)
			Result := True
		end

	out_or_void (o: ANY): STRING
		do
			if o = Void then
				Result := once "Void"
			else
				Result := o.out
			end
		end

	trace_s (s: STRING)
		do
			io.put_string (s)
		end

	trace_nl
		do
			trace_s (once "%N")
		end

   trace_sa (sa: ARRAY[STRING])
   	do
   		fx_trace (0, sa)
   	end

	fxerror (s: STRING): BOOLEAN
		do
			io.put_string (s)
			io.put_new_line
			die_with_code (1)
		end

	once_stack_trace
		once
		--	print_run_time_stack
		end

	todo (s: STRING)
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

	S_alpha:	INTEGER = 1
	S_beta:		INTEGER = 2
	S_gamma:	INTEGER = 3

	implementation_status: INTEGER
		do
			Result := S_alpha
		end

feature -- Tracing implementation

	tracing: BOOLEAN = True

	report_trace: BOOLEAN
		do
			io.put_string ("Trace PC: ")
			io.put_string (program_counter.out)
			io.put_string ("%N")

			Result := True
		end

	discard_result
			-- discard Result
			-- Avoid the need to assign result to a
			-- redundantly declared 'variable'
		do
		end


	stop_on_unimplemented: BOOLEAN = True

	implemented (ok: BOOLEAN): BOOLEAN
		do
			if (not ok) and then stop_on_unimplemented then
				not_yet_implemented
			end
		end


end