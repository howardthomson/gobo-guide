-- X Window System Implementation

class SB_BITMAP

inherit
	SB_BITMAP_DEF
		redefine
		--	make
		--	create_resource
		end

create
	make

feature -- Attributes

	xid: INTEGER

	create_resource
		do
		end

	destroy_resource
		do
		end

end