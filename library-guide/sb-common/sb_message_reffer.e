indexing
	description: "[
		Facilities for wrapping kernel expanded values in SE_REFERENCE objects,
		for argument passing in reference form.
	]"

class SB_MESSAGE_REFFER

feature -- make reference

	ref_boolean(i: BOOLEAN): SE_REFERENCE [ BOOLEAN ] is
		do
	--		create Result
	--		Result.set_item(i)
	
			create Result.set_item(i)
		end

	ref_integer(i: INTEGER): SE_REFERENCE [ INTEGER ] is
		do
	--		create Result
	--		Result.set_item(i)

			create Result.set_item(i)
		end

	ref_real(i: REAL): SE_REFERENCE [ REAL ] is
		do
	--		create Result
	--		Result.set_item(i)
			
			create Result.set_item(i)
		end

feature -- make constant reference

--	ref_true: SE_REFERENCE [ BOOLEAN ] is
--		do
--			Result := ref_boolean(True)
--		end

--	ref_false: SE_REFERENCE [ BOOLEAN ] is	
--		do
--			Result := ref_boolean(False)
--		end

feature -- dereference

	deref_boolean(p: ANY): BOOLEAN is
		local
			r: SE_REFERENCE [ BOOLEAN ]
		do
			r ?= p
				check r /= Void end
			Result := r.item
		end

	deref_integer(p: ANY): INTEGER is
		local
			r: SE_REFERENCE [ INTEGER ]
		do
			r ?= p
				check r /= Void end
			Result := r.item
		end

	deref_real(p: ANY): REAL is
		local
			r: SE_REFERENCE [ REAL ]
		do
			r ?= p
				check r /= Void end
			Result := r.item
		end

end