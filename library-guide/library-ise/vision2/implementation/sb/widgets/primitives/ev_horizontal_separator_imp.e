note
	description:
		"EiffelVision horizontal separator, gtk implementation"
	legal: "See notice at end of class.";
	status: "See notice at end of class."
	date: "$Date: 2006-01-22 18:25:44 -0800 (Sun, 22 Jan 2006) $";
	revision: "$Revision: 56675 $"

class
	EV_HORIZONTAL_SEPARATOR_IMP

inherit
	EV_HORIZONTAL_SEPARATOR_I
		redefine
			interface
		end

	EV_SEPARATOR_IMP
		redefine
			make,
			interface
		end

create
	make

feature {NONE} -- Initialization

	make
		do
			make_window_ev
			set_options ({SB_CONSTANTS}.Layout_fill_x)
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_HORIZONTAL_SEPARATOR;

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

end -- class EV_HORIZONTAL_SEPARATOR_IMP

