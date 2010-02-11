class EDP_TRACE

feature

	string_buffer: STRING is
		once
			create Result.make_empty
		end

	simple (flags: INTEGER; s: STRING) is
		do
			start (flags, s).done
		end

	st (s: STRING): EDP_TRACE is
		do
			Result := start (0, s)
		end

	start (flags: INTEGER; s: STRING): EDP_TRACE is
		do
			string_buffer.wipe_out
			string_buffer.append (s)
			Result := Current
		end

	n, next, infix "+" (s: STRING): EDP_TRACE is
		do
			string_buffer.append (s)
			Result := Current
		end

	r, result_true: BOOLEAN is
		do
			done
		end

	d, done is
		do
			string_buffer.append (once "%N")
			io.put_string (string_buffer)
		end
end