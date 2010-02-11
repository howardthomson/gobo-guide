class SB_FLAGS

inherit
--	SB_ZERO
	
feature {SB_WINDOW_DEF}

	flags: INTEGER

	reset_flags is
		do
			flags := 0
		end

	set_flags (bits: INTEGER) is
		do
			flags := flags | bits
		end

	unset_flags (bits: INTEGER) is
		do
			flags := flags.bit_and (bits.bit_not)
		end

	test_flags (bits: INTEGER): BOOLEAN is
		do
			Result := (flags & bits) /= 0
		end

	default_flags: BOOLEAN is
		do
			Result := flags = 0
		end
end