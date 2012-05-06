note

	description: "[
		Utility class for type conversion, needed because of the
		lack of standardisation of the kernel classes in Eiffel.
	]"
	author:		"Howard Thomson"
	Date:		"01--4-2004"

class SB_COMMON_CONVERSIONS

feature

	int_to_double (i: INTEGER): REAL
			-- Convert INTEGER to REAL
		do
			Result := i
		end

	pow (b, p: REAL): REAL
		do
			Result := b ^ p
		end

	int_to_int8 (arg: INTEGER): INTEGER_8
		local
			i: INTEGER
		do
			i := arg
			if (i & 0x00000080) /= 0 then
				i := i | 0xffffff00
			end
--			check
--				i.fit_integer_8
--			end
			Result := i.to_integer_8
		end

end
			