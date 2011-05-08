indexing
	description: "Eiffel Vision menu bar. GTK+ implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2006-12-29 15:13:47 -0800 (Fri, 29 Dec 2006) $"
	revision: "$Revision: 65780 $"

	sb_todo: "[
		implement:
			needs_event_box
	]"

class
	EV_MENU_BAR_IMP

inherit
	EV_MENU_BAR_I
		redefine
			interface
		end

	EV_MENU_ITEM_LIST_IMP
		redefine
			make,
			interface
		end

	EV_ANY_IMP
		redefine
			interface
		end

create
	make

feature {NONE} -- Implementation Attributes

	sb_widget: SB_WIDGET

feature {NONE} -- Initialization

--	old_make (an_interface: like interface) is
--		do
--			assign_interface (an_interface)
--		end

	make
		do
			create {SB_MENU_BAR} sb_widget.make_ev
		end

feature -- Measurement

	x_position: INTEGER is
			-- Horizontal offset relative to parent `x_position' in pixels.
		do
		end

	y_position: INTEGER is
			-- Vertical offset relative to parent `y_position' in pixels.
		do
		end

	screen_x: INTEGER is
			-- Horizontal offset relative to screen.
		do
		end

	screen_y: INTEGER is
			-- Vertical offset relative to screen.
		do
		end

	width: INTEGER is
			-- Horizontal size in pixels.
		do
		end

	height: INTEGER is
			-- Vertical size in pixels.
		do
		end

	minimum_width: INTEGER is
			-- Minimum horizontal size in pixels.
		do
		end

	minimum_height: INTEGER is
			-- Minimum vertical size in pixels.
		do
		end

feature {EV_WINDOW_IMP} -- Implementation

	set_parent_window_imp (a_wind: EV_WINDOW_IMP) is
			-- Set `parent_window' to `a_wind'.
		require
			a_wind_not_void: a_wind /= Void
		do
			parent_imp := a_wind
		end

	parent: EV_WINDOW is
			-- Parent window of Current.
		do
			if parent_imp /= Void then
				Result := parent_imp.interface
			end
		end

	remove_parent_window is
			-- Set `parent_window' to Void.
		do
			parent_imp := Void
		end

	parent_imp: EV_WINDOW_IMP

feature {EV_ANY_I} -- Implementation

	interface: EV_MENU_BAR;

feature {NONE} -- Implementation

	destroy is
		do
		end

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

end -- class EV_MENU_BAR_IMP

