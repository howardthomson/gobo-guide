indexing
	description: "[
		Class to contain replacements for declarations of the form:
			xx: expanded YY
		required by the removal of explicit expanded in SE 2.1
	]"

class SB_EXPANDED

feature

	sbk: SB_KEYS

	ff: SB_FILE is
		once
			create Result
		end

	u, utils: SB_UTILS is
		once
			create Result
		end

	sm: SB_MODIFIER_MASKS

	cm: SB_COMMON_MACROS;

	mem: MEMORY

	sbd: SB_DEFS

	math: SB_MATH

	bmp_io: SB_BMP_IO is
		once
			create Result
		end

	sb_exceptions: EXCEPTIONS is
		once
			create Result
		end
end
