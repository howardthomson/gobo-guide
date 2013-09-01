note

	description:
		"EiffelVision label, Slyboots implementation."
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
			make,
			is_tabable_to,
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

	make
		do
			Precursor {EV_PRIMITIVE_IMP}
			textable_imp_initialize
			initialize_tab_behavior
--			create {SB_LABEL} sb_widget.make_ev
			align_text_center
		end

feature -- Access

	angle: REAL
		-- Amount text is rotated counter-clockwise from horizontal plane in radians.

	set_angle (a_angle: REAL)
			--
		do
			-- TODO
			angle := a_angle
		end

feature -- Status Setting

	align_text_top
			-- Set vertical text alignment of current label to top.
		do
		end

	align_text_vertical_center
			-- Set text alignment of current label to be in the center vertically.
		do
		end

	align_text_bottom
			-- Set vertical text alignment of current label to bottom.
		do
		end

feature

	is_tabable_to: BOOLEAN
		do
			Result := True
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_LABEL;

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




end --class LABEL_IMP

