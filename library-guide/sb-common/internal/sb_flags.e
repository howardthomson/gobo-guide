class SB_FLAGS

feature {SB_WINDOW_DEF}

	flags: INTEGER

	reset_flags
		do
			flags := 0
		end

	set_flags (bits: INTEGER)
		do
			flags := flags | bits
		end

	unset_flags (bits: INTEGER)
		do
			flags := flags.bit_and (bits.bit_not)
		end

	test_flags (bits: INTEGER): BOOLEAN
		do
			Result := (flags & bits) /= 0
		end

	default_flags: BOOLEAN
		do
			Result := flags = 0
		end
end
