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
		rename
			make_sb_window as make_composite
--			default_spacing as default_spacing_sb
		undefine
			layout,
			create_resource,
			detach_resource,
			destroy_resource,
			class_name,
			destruct,
			handle_2,
			on_key_press,
			on_key_release,
			on_cmd_update,
			on_paint,
			is_composite,
			make_ev,
			make_composite,
			default_width_sb,
			default_height_sb
		redefine
			make,
			interface
		end

	SB_HORIZONTAL_FRAME
		rename
			make as make_composite_sb,
			show as show_sb,
			hide as hide_sb,
			set_focus as set_focus_sb,
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
			default_spacing as default_spacing_sb
		undefine
			set_minimum_width,
			set_minimum_height
		end

create
	make

feature {NONE} -- Initialization
	
	make
			-- Create a horizontal box.
		do	
--			base_make (an_interface)

			make_ev

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

