-- Mode Flags

class X86_EXECUTION_MODES

feature

	Xmode_legacy_16:
	Xmode_legacy_32
	Xmode_compat_16
	Xmode_compat_32
	Xmode_amd_64:	INTEGER is 


	Xm_all: INTEGER is
		do
			Result :=
				Xmode_legacy_16
				| Xmode_legacy_32
				| Xmode_compat_16
				| Xmode_compat_32
				| Xmode_amd_64
		end

	Xm_3264: INTEGER is
		do
			Result := Xmode_compat_32
					| Xmode_amd_64
		end

	Xm_64: INTEGER is
		do
			Result := Xmode_amd_64
		end

end