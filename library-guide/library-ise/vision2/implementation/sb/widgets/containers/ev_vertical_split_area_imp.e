note
	description:
		"Eiffel Vision Split Area, GTK+ implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2006-01-22 18:25:44 -0800 (Sun, 22 Jan 2006) $"
	revision: "$Revision: 56675 $"

class
	EV_VERTICAL_SPLIT_AREA_IMP

inherit
	EV_VERTICAL_SPLIT_AREA_I
		undefine
			propagate_foreground_color,
			propagate_background_color
		redefine
			interface
		end

	EV_SPLIT_AREA_IMP
--		rename
--			make_sb_window as make_composite
--		undefine
--			class_name,
--			on_left_btn_press,
--			on_left_btn_release,
--			on_key_press,
--			on_key_release,
--			handle_2,
--			is_composite,
--			default_width_sb,
--			default_height_sb,
--			destruct,
--			layout,
--			create_resource,
--			detach_resource,
--			destroy_resource,
--			on_motion,
--			on_cmd_update
		redefine
			make,
			interface
		end

--	SB_SPLITTER
--		rename
--			make 			as make_sb_window,
--			show 			as show_sb,
--			hide 			as hide_sb,
--			set_focus 		as set_focus_sb,
--			default_width 	as default_width_sb,
--			default_height 	as default_height_sb,
--			has_focus 		as has_focus_sb,
--			parent 			as parent_sb,
--			move 			as move_sb,
--			drag_cursor 	as drag_cursor_sb,
--			raise 			as raise_sb,
--			lower 			as lower_sb,
--			x_offset 		as x_offset_sb,
--			y_offset 		as y_offset_sb,
--			flush 			as flush_sb,
--			selected 		as selected_sb,
--			has_selection 	as has_selection_sb
--		undefine
--			set_minimum_width,
--			set_minimum_height
--		end

create
	make

feature -- initialization

	make
		do
--			make_sb_window (Void)
--			set_options (Frame_line)	-- TEMP
--			show_sb
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_VERTICAL_SPLIT_AREA;
			-- Provides a common user interface to possibly dependent
			-- functionality implemented by `Current'.

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




end -- class EV_VERTICAL_SPLIT_AREA_IMP

