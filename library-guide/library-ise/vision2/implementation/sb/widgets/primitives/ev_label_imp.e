indexing

	description:
		"EiffelVision label, gtk implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	id: "$Id: ev_label_imp.e 66063 2007-01-20 01:25:46Z king $"
	date: "$Date: 2007-01-19 17:25:46 -0800 (Fri, 19 Jan 2007) $"
	revision: "$Revision: 66063 $"

class
	EV_LABEL_IMP

inherit
	EV_LABEL_I
		redefine
			interface
		end

	EV_PRIMITIVE_IMP
		redefine
			interface,
			sb_widget
		end

	EV_TEXTABLE_IMP
		redefine
			interface
		end

	EV_FONTABLE_IMP
		redefine
			interface
		end

create
	make

feature {NONE} -- Attributes

	sb_widget: SB_LABEL

feature {NONE} -- Initialization

	old_make (an_interface: like interface) is
			-- Create a gtk label.
		local
			int_value: INTEGER
		do
			base_make (an_interface)
			textable_imp_initialize
			create {SB_LABEL} sb_widget.make_ev
			align_text_center
		end

	make
		do
		end

feature -- Access

	angle: REAL
		-- Amount text is rotated counter-clockwise from horizontal plane in radians.

	set_angle (a_angle: REAL) is
			--
		do
			-- TODO
			angle := a_angle
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_LABEL;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end --class LABEL_IMP
