indexing
	description:
		"Eiffel Vision cell, Slyboots implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_CELL_IMP

inherit
	EV_CELL_I
		undefine
			propagate_foreground_color,
			propagate_background_color
		redefine
			interface
		end

	EV_CONTAINER_IMP
		rename
			make_ev as make_window_ev
		undefine
			make_sb_window,
			make_window_ev,
			class_name,
			on_paint,
			default_width_sb,
			default_height_sb
		redefine
			make,
			interface,
			replace
		end

	EV_DOCKABLE_TARGET_IMP
		redefine
			interface
		end

	SB_FRAME
		rename
			make as make_frame,
			make_window as make_sb_window,
			show as show_sb,
			hide as hide_sb,
			set_focus as set_focus_sb,
			width as width_sb,
			height as height_sb,
			set_width as set_width_sb,
			set_height as set_height_sb,
			minimum_width as minimum_width_sb,
			minimum_height as minimum_height_sb,
			set_minimum_width as set_minimum_width_sb,
			set_minimum_height as set_minimum_height_sb,
			has_focus as has_focus_sb,
			parent as parent_sb,
			move as move_sb,
			drag_cursor as drag_cursor_sb,
			raise as raise_sb,
			lower as lower_sb,
			x_offset as x_offset_sb,
			y_offset as y_offset_sb,
			flush as flush_sb,
			selected as selected_sb,
			has_selection as has_selection_sb,
			default_width as default_width_sb,
			default_height as default_height_sb,
		undefine
			
		end
	
create
	make

feature -- initialization

	make
			-- Connect interface and initialize `c_object'.
		do
--			create {SB_FRAME} sb_widget.make_ev
			make_ev
		end

feature -- Access

	has (v: like item): BOOLEAN
			-- Does `Current' include `v'?
		do
			Result := not is_destroyed and (v /= Void and then item = v)
		end

	count: INTEGER_32
			-- Number of elements in `Current'.
		do
			if item /= Void then
				Result := 1
			end
		end

	item: EV_WIDGET
			-- Current item.

feature -- Element change

	replace (v: like item)
			-- Replace `item' with `v'.
		local
			v_imp: EV_WIDGET_IMP
			l_composite: SB_COMPOSITE
		do
			Precursor {EV_CONTAINER_IMP} (v)
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_CELL;
			-- Provides a common user interface to possibly dependent
			-- functionality implemented by `Current'.

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

end -- class EV_CELL_IMP

