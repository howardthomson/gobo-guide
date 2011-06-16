note
	description: "Eiffel Vision vertical range. GTK+ implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2009-06-10 22:52:23 -0700 (Wed, 10 Jun 2009) $"
	revision: "$Revision: 79207 $"

class
	EV_VERTICAL_RANGE_IMP

inherit
	EV_VERTICAL_RANGE_I
		redefine
			interface
		end

	EV_RANGE_IMP
		redefine
			interface,
			old_make,
			make
		end

create
	make

feature {NONE} -- Initialization

	old_make (an_interface: like interface)
			-- Create the vertical range.
		do
			Precursor {EV_RANGE_IMP} (an_interface)
		end

	make
			-- Create and initialize `Current'.
		do
			set_c_object ({EV_GTK_EXTERNALS}.gtk_vscale_new (adjustment))
			Precursor
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_VERTICAL_RANGE note option: stable attribute end;

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

end -- class EV_VERTICAL_RANGE_IMP
