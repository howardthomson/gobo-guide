indexing
	description:
		"Eiffel Vision separator. GTK+ implementation"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2006-01-22 18:25:44 -0800 (Sun, 22 Jan 2006) $"
	revision: "$Revision: 56675 $"

deferred class
	EV_SEPARATOR_IMP

inherit
	EV_SEPARATOR_I
		redefine
			interface
		end

	EV_PRIMITIVE_IMP
		rename
			make_sb_window as make_window,
			make_ev as make_window_ev,
--			default_width as default_width_sb,
--			default_height as default_height_sb
		undefine
			class_name,
			on_paint,
			default_width_sb,
			default_height_sb
		redefine
			interface
		end

	SB_SEPARATOR
		rename
			make as make_separator_sb,
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
			default_height as default_height_sb
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_SEPARATOR;

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




end -- class EV_SEPARATOR_IMP

