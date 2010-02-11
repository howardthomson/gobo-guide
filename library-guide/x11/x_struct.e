indexing

		description: "X11 C Structure"

	author: "Howard Thomson"
	copyright: "Copyright (c) 2006, Howard Thomson"
	license: "Eiffel Forum License v2 (see forum.txt)"

	todo:
		"[
			Move features of ELJ_MEM_ACCESS into this class
			Use features from TYPED_POINTER etc instead
		]"

deferred class X_STRUCT

inherit
		
	ELJ_MEM_ACCESS
		rename
			pointer as to_external
		end

	DISPOSABLE

feature {NONE} -- Initialization

	make is
			-- allocate a new object
		do
			create mp.make (size)
		end

feature {SB_RAW_EVENT}

	from_x_struct (other: X_STRUCT) is
			-- Initialize `Current'
		require
			other_not_void: other /= Void
		do
			mp := other.mp
		end

feature {X_VISUAL, X_WM_HINTS, X_ANY_EVENT, X_FONT_STRUCT, X_CLASS_HINT}

	from_external (p: POINTER) is
		do
			create mp.make_from_pointer (p, size)
		end

feature -- Consultation

	mp: MANAGED_POINTER
			-- Keep reference to the MANAGED_POINTER object

	to_external: POINTER
			-- Pointer to the C object
		do
			Result := mp.item
		end

--	size: INTEGER is
--			-- Return the size in bytes of the external object
--		deferred
--		end

feature {NONE} -- Debug, GC collection tracing

	enable_dispose_reporting: BOOLEAN is False
	
	dispose is
		do
			if enable_dispose_reporting then
				print (once "Disposing instance of: ")
				print (generator)
				print (once "%N")
			end
		end

invariant

	managed_pointer_not_void: mp /= Void
	
--	to_external /= default_pointer

end