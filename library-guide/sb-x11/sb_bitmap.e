-- X Window System Implementation

class SB_BITMAP

inherit
	SB_BITMAP_DEF
		redefine
		--	make
		--	create_resource
		end

creation
	make

feature -- Attributes

	xid: INTEGER

	create_resource is
		do
		end

	destroy_resource is
		do
		end

end