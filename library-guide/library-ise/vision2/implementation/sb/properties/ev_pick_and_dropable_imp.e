indexing
	description:
		"Eiffel Vision pick and drop source, GTK implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "pick and drop, drag and drop, source, PND, DND"
	date: "$Date: 2007-04-20 14:23:22 -0700 (Fri, 20 Apr 2007) $"
	revision: "$Revision: 67944 $"

deferred class
	EV_PICK_AND_DROPABLE_IMP

inherit
	EV_SB_WIDGET_IMP
		redefine
			interface
		end

	EV_PICK_AND_DROPABLE_I
		export
			{EV_INTERMEDIARY_ROUTINES}
				execute
		redefine
			interface
		end

	EV_PICK_AND_DROPABLE_ACTION_SEQUENCES_IMP
		redefine
			create_drop_actions
		end

feature {EV_APPLICATION_IMP} -- Implementation

	on_pointer_motion (a_motion_tuple: TUPLE [INTEGER, INTEGER, DOUBLE, DOUBLE, DOUBLE, INTEGER, INTEGER]) is
			-- Handle motion event for `Current'.
		local
			l_dockable_source: EV_DOCKABLE_SOURCE_IMP
			l_call_events: BOOLEAN
			l_current: ANY
		do
			l_call_events := True
			l_current := Current
			if app_implementation.pick_and_drop_source = l_current then
				execute (
					a_motion_tuple.integer_32_item (1),
					a_motion_tuple.integer_32_item (2),
					a_motion_tuple.double_item (3),
					a_motion_tuple.double_item (4),
					a_motion_tuple.double_item (5),
					a_motion_tuple.integer_32_item (6),
					a_motion_tuple.integer_32_item (7)
				)
				l_call_events := False
			elseif is_dockable then
				l_dockable_source ?= l_current
				if l_dockable_source.awaiting_movement or else app_implementation.docking_source = l_current then
					l_dockable_source.dragable_motion (
						a_motion_tuple.integer_32_item (1),
						a_motion_tuple.integer_32_item (2),
						a_motion_tuple.double_item (3),
						a_motion_tuple.double_item (4),
						a_motion_tuple.double_item (5),
						a_motion_tuple.integer_32_item (6),
						a_motion_tuple.integer_32_item (7)
					)
				end
				if app_implementation.docking_source = l_current then
					l_call_events := False
				end
			end
			if l_call_events and then pointer_motion_actions_internal /= Void then
				pointer_motion_actions_internal.call (a_motion_tuple)
			end
		end

	pointer_motion_actions_internal: EV_POINTER_MOTION_ACTION_SEQUENCE is
		deferred
		end

feature {EV_GTK_DEPENDENT_INTERMEDIARY_ROUTINES} -- Implementation

	call_button_event_actions (
			a_type: INTEGER;
			a_x, a_y, a_button: INTEGER;
			a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
			a_screen_x, a_screen_y: INTEGER) is
		deferred
		end

feature {NONE} -- Implementation

	enable_capture is
			-- Grab all the mouse and keyboard events.
		do
		end

	disable_capture is
			-- Ungrab all the mouse and keyboard events.
			--| Used by pick and drop.
		do
		end

	has_capture: BOOLEAN is
			-- Does Current have the keyboard and mouse event capture?
		do
			Result := App_implementation.captured_widget = interface or else app_implementation.pick_and_drop_source = Current
		end

	grab_keyboard_and_mouse is
			-- Perform a global mouse and keyboard grab.
		do
		end

	release_keyboard_and_mouse is
			-- Release mouse and keyboard grab.
		do
		end

feature -- Implementation

	draw_rubber_band  is
			-- Erase previously drawn rubber band.
			-- Draw a rubber band between initial pick point and cursor.
		do
			app_implementation.draw_rubber_band
		end

	erase_rubber_band  is
			-- Erase previously drawn rubber band.
		do
			app_implementation.erase_rubber_band
		end

	enable_transport is
			-- Activate pick/drag and drop mechanism.
 		do
			is_transport_enabled := True
		end

	disable_transport is
			-- Deactivate pick/drag and drop mechanism.
		do
			is_transport_enabled := False
		ensure then
			is_transport_disabled: not is_transport_enabled
		end

	pre_pick_steps (a_x, a_y, a_screen_x, a_screen_y: INTEGER) is
			-- Steps to perform before transport initiated.
		do
				-- Force any pending graphics calls.
			{EV_GTK_EXTERNALS}.gdk_flush
			update_pointer_style (pointed_target)
			app_implementation.on_pick (Current, pebble)
			if pick_actions_internal /= Void then
				pick_actions_internal.call ([a_x, a_y])
			end
			pointer_x := a_screen_x.to_integer_16
			pointer_y := a_screen_y.to_integer_16
			if pick_x = 0 and pick_y = 0 then
				App_implementation.set_x_y_origin (a_screen_x, a_screen_y)
			else
				if pick_x > width then
					pick_x := width.to_integer_16
				end
				if pick_y > height then
					pick_y := height.to_integer_16
				end
				App_implementation.set_x_y_origin (pick_x + (a_screen_x - a_x), pick_y + (a_screen_y - a_y))
			end
			modify_widget_appearance (True)
		end

	is_dockable: BOOLEAN is
			-- Is `Current' dockable?
		deferred
		end

	set_to_drag_and_drop: BOOLEAN is
			-- Set `Current' to drag and drop mode.
		do
			Result := mode_is_drag_and_drop
		end

	able_to_transport (a_button: INTEGER): BOOLEAN is
			-- Is `Current' able to initiate transport with `a_button'.
		do
			Result := (mode_is_drag_and_drop and then a_button = 1 and then not is_dockable) or
				(mode_is_pick_and_drop and then a_button = 3 and then not mode_is_configurable_target_menu)
		end

	on_mouse_button_event (
			a_type: INTEGER;
			a_x, a_y, a_button: INTEGER;
			a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
			a_screen_x, a_screen_y: INTEGER) is
				-- Handle mouse button events.
		do
		end

	start_transport (
			a_x, a_y, a_button: INTEGER; a_press: BOOLEAN;
			a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
			a_screen_x, a_screen_y: INTEGER; a_menu_only: BOOLEAN)
		is
			-- Initialize a pick and drop transport.
		do
			check
				do_not_call: False
			end
		end

	ready_for_pnd_menu (a_button, a_type: INTEGER): BOOLEAN is
			-- Will `Current' display a menu with button `a_button'.
		do
			Result := ((mode_is_target_menu or else mode_is_configurable_target_menu) and a_button = 3)
--			and then a_type = {EV_GTK_EXTERNALS}.gdk_button_release_enum
		end

	end_transport (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- End a pick and drop transport.
		do
		end

	post_drop_steps (a_button: INTEGER)  is
			-- Steps to perform once an attempted drop has happened.
		do
			App_implementation.set_x_y_origin (0, 0)
			if pebble_function /= Void then
				pebble_function.clear_last_result
				pebble := Void
			end
		end

	real_pointed_target: EV_PICK_AND_DROPABLE is
			-- Hole at mouse position
		do
			-- TODO
		end

	create_drop_actions: EV_PND_ACTION_SEQUENCE is
			-- Create and initialize `drop_actions' for `Current'
		do
			create Result
			interface.init_drop_actions (Result)
		end

	pointer_position: EV_COORDINATE is
			-- Position of the screen pointer relative to `Current'.
		local
			x, y, s: INTEGER
			child: POINTER
		do
--			child := {EV_GTK_EXTERNALS}.gdk_window_get_pointer ({EV_GTK_EXTERNALS}.gtk_widget_struct_window (c_object), $x, $y, $s)
			create Result.set (x, y)
		end

feature {EV_ANY_I} -- Implementation

	destroy is
		do
		end

	interface: EV_PICK_AND_DROPABLE;	-- NOTE Gobo syntax error if the ';' removed here before 'indexing'

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

end -- class EV_PICK_AND_DROPABLE_IMP

