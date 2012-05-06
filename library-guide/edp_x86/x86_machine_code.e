class X86_MACHINE_CODE

feature

	mode: INTEGER
			-- Default mode for which to generate instructions
			-- 16/32/64-bit etc

	Mode_long_64,
	Mode_compat_32,
	Mode_compat_16,
	Mode_legacy_32,
	Mode_legacy_16
		: INTEGER = Unique
			-- values for mode

	Max_instruction_length: INTEGER = 15

	length: INTEGER
		do
			Result := prefix_count
					+ rex_count
					+ opcode_count
					+ sib_count
					+ displacement_count
					+ immediate_count
		end

	is_valid: BOOLEAN
			-- check instruction is valid for current mode
		do
			Result := length <= Max_instruction_length
			-- and then ... TODO
		end

invariant
	-- Check that mode is one of the hardware mode
	-- execution environments
	mode_is_valid:	mode = Mode_long_64			-- x86-64
					or mode = Mode_compat_32	-- Intel 32-bit paged/protected
					or mode = Mode_compat_16	-- Intel 16-bit paged-protected
					or mode = Mode_legacy_32	-- ??
					or mode = Mode_legacy_16	-- ??
end