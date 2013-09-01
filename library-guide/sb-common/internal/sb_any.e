note

	description: "Features shared by all [most] Slyboots classes"

class SB_ANY

inherit

	KL_SHARED_EXCEPTIONS

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

	fxerror (s: STRING): BOOLEAN
		do
			io.put_string (s)
			io.put_new_line
			Exceptions.die (1)
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

end
