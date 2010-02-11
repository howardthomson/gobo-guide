deferred class SB_WAPI_STRUCT

feature

	make is
		do
			create mem.make(external_size)
			ptr := mem.item_address (0)
		ensure
			pointer_valid: ptr /= default_pointer
		end

	from_external (pointer: POINTER) is
		do
			ptr := pointer
		end

	from_external_copy (p: POINTER) is
		do
			create mem.make(external_size)
			ptr := mem.item_address (0)
			ptr.memory_copy (p, external_size)			
		end

feature -- Access

	ptr: POINTER

	external_size: INTEGER is
    		-- size 'external_size' bytes of the memory area occupied
    		-- by the structure.
    	deferred
    	end

feature {NONE}

	mem: SPECIAL [ CHARACTER ]

end
