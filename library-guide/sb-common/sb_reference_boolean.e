class SB_REFERENCE_BOOLEAN

feature

	ref_true: SE_REFERENCE [ BOOLEAN ] is	-- SE 2.1
		once
			create Result.set_item(True)
		end

	ref_false: SE_REFERENCE [ BOOLEAN ] is	-- SE 2.1
		once
			create Result.set_item(False)
		end

end