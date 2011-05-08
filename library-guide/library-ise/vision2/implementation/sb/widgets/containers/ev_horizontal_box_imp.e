note
		description: "EiffelVision horizontal box. Slyboots implementation."

	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "container, horizontal. box"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_HORIZONTAL_BOX_IMP
	
inherit
	EV_HORIZONTAL_BOX_I
		undefine
			propagate_foreground_color,
			propagate_background_color
		redefine
			interface
		end
		
	EV_BOX_IMP
		redefine
			make,
			interface
		end

create
	make

feature {NONE} -- Initialization
	
	make
			-- Create a horizontal box.
		do	
--			base_make (an_interface)
			create {SB_HORIZONTAL_FRAME} sb_widget.make_ev
			Precursor {EV_BOX_IMP}
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_HORIZONTAL_BOX;

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EV_HORIZONTAL_BOX_IMP

