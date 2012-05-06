note
	description:
		"EiffelVision application, Slyboots implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "application"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_APPLICATION_IMP

inherit
	EV_APPLICATION_I
		export
			{EV_INTERMEDIARY_ROUTINES}
				pointer_motion_actions_internal,
				pointer_button_press_actions_internal,
				pointer_double_press_actions_internal,
				pointer_button_release_actions_internal
			{EV_ANY_I, EV_INTERMEDIARY_ROUTINES}
				is_destroyed
		undefine
			dispose
		redefine
			launch, focused_widget
		end

create

	make

feature {NONE} -- Initialization

	make (an_interface: like interface)
			-- Set up the callback marshal and initialize GTK+.
		local
			locale_str: STRING
		do
			base_make (an_interface)

--			put ("localhost:0", "DISPLAY")
				-- This line may be uncommented to allow for display redirection to another machine for debugging purposes
			if False then
				-- ....
			else
				-- We are unable to launch the gtk toolkit, probably due to a DISPLAY issue.
				print ("EiffelVision application could not launch, check DISPLAY environment variable%N")
				die (0)
			end
		end

feature {NONE} -- Event loop

	 launch
			-- Display the first window, set up the post_launch_actions,
			-- and start the event loop.
		do
--			if gtk_is_launchable then
				Precursor
--			end
		end

feature {EV_ANY_I} -- Implementation

	focused_widget: EV_WIDGET
			-- Widget with keyboard focus
		local
			current_windows: like windows
			current_window: EV_WINDOW
			l_window_imp: EV_WINDOW_IMP
			l_widget_imp: EV_WIDGET_IMP
		do
			current_windows := windows
			from
				current_windows.start
			until
				current_windows.off or Result /= Void
			loop
				current_window := current_windows.item
				if current_window.has_focus then
					if current_window.full then
						todo_class_line ("__EV_APPLICATION_IMP__", "__LINE__") 
					else
						Result := current_window
					end
				end
				current_windows.forth
			end
		end

	display_connection_number: INTEGER
		-- Connection number of display.
		-- This is a file descriptor from which we can poll for user events.

	x11_display: POINTER
		-- Pointer to the default X11 display used by `Current'.

	init_connection_number
			-- Initialize `display_connection_number'.
		do
		end

	wait_for_input (msec: INTEGER)
			-- Wait for at most `msec' milliseconds for an event.
		local
			l_result: INTEGER
		do
		end

	process_underlying_toolkit_event_queue
			-- Process all pending XX events and then dispatch XX iteration until no more
			-- events are pending.
		do
			todo_class_line ("__EV_APPLICATION_IMP__", "__LINE__") 
		end

feature -- Access

	ctrl_pressed: BOOLEAN
			-- Is ctrl key currently pressed?
		do
			todo_class_line ("__EV_APPLICATION_IMP__", "__LINE__") 
		end

	alt_pressed: BOOLEAN
			-- Is alt key currently pressed?
		do
			todo_class_line ("__EV_APPLICATION_IMP__", "__LINE__") 
		end

	shift_pressed: BOOLEAN
			-- Is shift key currently pressed?
		do
			todo_class_line ("__EV_APPLICATION_IMP__", "__LINE__") 
		end

	caps_lock_on: BOOLEAN
			-- Is the Caps or Shift Lock key currently on?
		do
			todo_class_line ("__EV_APPLICATION_IMP__", "__LINE__") 
		end

	window_oids: LINKED_LIST [INTEGER]
			-- Global list of window object ids.

	windows: LINEAR [EV_WINDOW]
			-- Global list of windows.
		local
			cur: CURSOR
			w: EV_WINDOW_IMP
			id: IDENTIFIED
			l: LINKED_LIST [EV_WINDOW]
		do
			create id
			create l.make
			Result := l
			from
				cur := window_oids.cursor
				window_oids.start
			until
				window_oids.after
			loop
				w ?= id.id_object (window_oids.item)
				if w = Void or else w.is_destroyed then
					window_oids.prune_all (window_oids.item)
				else
					l.extend (w.interface)
					window_oids.forth
				end
			end
			window_oids.go_to (cur)
		end

	focused_popup_window: EV_POPUP_WINDOW_IMP
		-- Window that is currently focused.

	set_focused_popup_window (a_window: like focused_popup_window)
			-- Set `focused_popup_window' to `a_window'.
		require
			valid:(a_window /= Void and focused_popup_window = Void) or (a_window = Void and focused_popup_window /= Void)
		do
			focused_popup_window := a_window
		end

feature -- Basic operation

	process_graphical_events
			-- Process all pending graphical events and redraws.
		do
			{EV_GTK_EXTERNALS}.gdk_window_process_all_updates
		end

	motion_tuple: TUPLE [x: INTEGER; y: INTEGER; x_tilt: DOUBLE; y_tilt: DOUBLE; pressure: DOUBLE; screen_x: INTEGER; screen_y: INTEGER; originating_x: INTEGER; originating_y: INTEGER]
			-- Tuple optimization
		once
			create Result
		end

	app_motion_tuple: TUPLE [widget: EV_WIDGET; x: INTEGER; y: INTEGER]
			-- Tuple optimization
		once
			create Result
		end


	sleep (msec: INTEGER)
			-- Wait for `msec' milliseconds and return.
		do
			usleep (msec * 1000)
		end

	destroy
			-- End the application.
		do
			if not is_destroyed then
				todo_class_line ("__EV_APPLICATION_IMP__", "__LINE__") 
				set_is_destroyed (True)
					-- This will exit our main loop
				destroy_actions.call (Void)
			end
		end

feature {NONE} -- Implementation

	create_post_launch_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Create a post_launch action sequence.
		do
			todo_class_line ("__EV_APPLICATION_IMP__", "__LINE__") 
		end

	create_pick_actions: EV_PND_ACTION_SEQUENCE
			-- Create a pick action sequence.
		do
			todo_class_line ("__EV_APPLICATION_IMP__", "__LINE__") 
		end

	create_drop_actions: EV_PND_ACTION_SEQUENCE
			-- Create a drop action sequence.
		do
			todo_class_line ("__EV_APPLICATION_IMP__", "__LINE__") 
		end

	create_cancel_actions: EV_PND_ACTION_SEQUENCE
			-- Create a cancel action sequence.
		do
			todo_class_line ("__EV_APPLICATION_IMP__", "__LINE__") 
		end

	create_pnd_motion_actions: like pnd_motion_actions
			-- Create a pnd motion action sequence.
		do
			todo_class_line ("__EV_APPLICATION_IMP__", "__LINE__") 
		end

	create_pointer_motion_actions: EV_LITE_ACTION_SEQUENCE [TUPLE [EV_WIDGET, INTEGER, INTEGER]]
			-- Create a pointer_motion action sequence.
		do
			todo_class_line ("__EV_APPLICATION_IMP__", "__LINE__") 
		end

	create_pointer_button_press_actions: EV_LITE_ACTION_SEQUENCE [TUPLE [EV_WIDGET, INTEGER, INTEGER, INTEGER]]
			-- Create a pointer_button_press action sequence.
		do
			todo_class_line ("__EV_APPLICATION_IMP__", "__LINE__") 
		end

	create_pointer_double_press_actions: EV_LITE_ACTION_SEQUENCE [TUPLE [EV_WIDGET, INTEGER, INTEGER, INTEGER]]
			-- Create a pointer_double_press action sequence.
		do
			todo_class_line ("__EV_APPLICATION_IMP__", "__LINE__") 
		end

	create_pointer_button_release_actions: EV_LITE_ACTION_SEQUENCE [TUPLE [EV_WIDGET, INTEGER, INTEGER, INTEGER]]
			-- Create a pointer_button_release action sequence.
		do
			todo_class_line ("__EV_APPLICATION_IMP__", "__LINE__") 
		end

	create_mouse_wheel_actions: EV_LITE_ACTION_SEQUENCE [TUPLE [EV_WIDGET, INTEGER]]
			-- Create a mouse_wheel action sequence.
		do
			todo_class_line ("__EV_APPLICATION_IMP__", "__LINE__") 
		end

	create_key_press_actions: EV_LITE_ACTION_SEQUENCE [TUPLE [EV_WIDGET, EV_KEY]]
			-- Create a key_press action sequence.
		do
			todo_class_line ("__EV_APPLICATION_IMP__", "__LINE__") 
		end

	create_key_press_string_actions: EV_LITE_ACTION_SEQUENCE [TUPLE [EV_WIDGET, STRING_32]]
			-- Create a key_press_string action sequence.
		do
			todo_class_line ("__EV_APPLICATION_IMP__", "__LINE__") 
		end

	create_key_release_actions: EV_LITE_ACTION_SEQUENCE [TUPLE [EV_WIDGET, EV_KEY]]
			-- Create a key_release action sequence.
		do
			todo_class_line ("__EV_APPLICATION_IMP__", "__LINE__") 
		end

	create_focus_in_actions: EV_LITE_ACTION_SEQUENCE [TUPLE [EV_WIDGET]]
			-- Create a focus_in action sequence.
		do
			todo_class_line ("__EV_APPLICATION_IMP__", "__LINE__") 
		end

	create_idle_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Create a idle action sequence.
		do
			todo_class_line ("__EV_APPLICATION_IMP__", "__LINE__") 
		end

	create_focus_out_actions: EV_LITE_ACTION_SEQUENCE [TUPLE [EV_WIDGET]]
		do
			todo_class_line ("__EV_APPLICATION_IMP__", "__LINE__")
		end

	create_theme_changed_actions: EV_NOTIFY_ACTION_SEQUENCE
		do
			todo_class_line ("__EV_APPLICATION_IMP__", "__LINE__") 
		end

	create_destroy_actions: EV_NOTIFY_ACTION_SEQUENCE
		do
			todo_class_line ("__EV_APPLICATION_IMP__", "__LINE__") 
		end
		
feature -- Status report

	tooltip_delay: INTEGER
			-- Time in milliseconds before tooltips pop up.

feature -- Status setting

	set_tooltip_delay (a_delay: INTEGER)
			-- Set `tooltip_delay' to `a_delay'.
		do
			tooltip_delay := a_delay
			todo_class_line ("__EV_APPLICATION_IMP__", "__LINE__") 
		end

feature {EV_PICK_AND_DROPABLE_IMP} -- Pick and drop

	set_docking_source (a_source: EV_DOCKABLE_SOURCE_IMP)
			-- Set `docking_source' to `a_source'.
		do
			internal_docking_source := a_source
		end

	on_pick (a_source: EV_PICK_AND_DROPABLE_IMP; a_pebble: ANY)
			-- Called by EV_PICK_AND_DROPABLE_IMP.start_transport
		do
			internal_pick_and_drop_source := a_source
			interface.pick_actions.call ([a_pebble])
		end

	on_drop (a_pebble: ANY)
			-- Called by EV_PICK_AND_DROPABLE_IMP.end_transport
		do
			internal_pick_and_drop_source := Void
		end

feature {EV_ANY_I} -- Implementation

	tooltips: POINTER
			-- Reference to GtkTooltips object.

feature -- Implementation

	is_in_transport: BOOLEAN
			-- Is application currently in transport (either PND or docking)?
		do
			Result := pick_and_drop_source /= Void or else docking_source /= Void
		end

	pick_and_drop_source: EV_PICK_AND_DROPABLE_IMP
			-- Source of pick and drop if any.
		do
			Result := internal_pick_and_drop_source
		end

	docking_source: EV_DOCKABLE_SOURCE_IMP
			-- Source of docking if any.
		assign
			set_docking_source
		do
			Result := internal_docking_source
		end

	internal_pick_and_drop_source: like pick_and_drop_source
	internal_docking_source: like docking_source

	keyboard_modifier_mask: INTEGER
			-- Mask representing current keyboard modifiers state.
		local
			l_display_data: like retrieve_display_data
		do
			if use_stored_display_data_for_keys then
					-- If we are inside a key event then we can directly query the key data.
				l_display_data := stored_display_data
			else
				l_display_data := retrieve_display_data
			end
			Result := l_display_data.mask
		end

	retrieve_display_data: TUPLE [window: POINTER; x, y: INTEGER; mask: INTEGER; originating_x, originating_y: INTEGER]
			-- Retrieve mouse and keyboard data from the display.
		do
			if not use_stored_display_data then
					-- Update values with those from the X Server.
				update_display_data
			end
			Result := stored_display_data
		end

	use_stored_display_data: BOOLEAN
		-- Should prestored display data values be used when querying for display data.

	use_stored_display_data_for_keys: BOOLEAN
		-- Should prestored display data values be used when querying for key display data.

	stored_display_data: like retrieve_display_data
		-- Store for the previous call to 'retrieve_display_data'
		-- This is needed to avoid unnecessary roundtrips.

	enable_debugger
			-- Enable the Eiffel debugger.
		do
			if not debugger_is_disabled then
				debugger_is_disabled := True
				internal_set_debug_mode (saved_debug_mode)
			end
		end

	disable_debugger
			-- Disable the Eiffel debugger.
		do
			if debugger_is_disabled then
				debugger_is_disabled := False
				saved_debug_mode := debug_mode
				internal_set_debug_mode (0)
			end
		end

	debugger_is_disabled: BOOLEAN
		-- Is the debugger disabled?

feature {EV_ANY_I, EV_FONT_IMP, EV_STOCK_PIXMAPS_IMP, EV_INTERMEDIARY_ROUTINES} -- Implementation

	default_window: EV_WINDOW
			-- Default Window used for creation of agents and holder of clipboard widget.
		once
			create Result
		end

	default_window_imp: EV_WINDOW_IMP
			-- Default window implementation.
		once
			Result ?= default_window.implementation
		end

	default_font_height: INTEGER
			-- Default font height.
		local
			temp_style: POINTER
		do
		end

	default_font_ascent: INTEGER
			-- Default font ascent.
		local
			temp_style: POINTER
		do
		end

	default_font_descent: INTEGER
			-- Default font descent.
		local
			temp_style: POINTER
		do
		end

feature -- Thread Handling.

	initialize_threading
			-- Initialize thread support.
		do
		end

	lock
			-- Lock the Mutex.
		do
		end

	try_lock: BOOLEAN
			-- Try to see if we can lock, False means no lock could be attained
		do
		end

	unlock
			-- Unlock the Mutex.
		do
		end

feature {NONE} -- External implementation

	usleep (micro_seconds: INTEGER)
		external
			"C | <unistd.h>"
		end

feature {NONE} -- Externals

	static_mutex: POINTER
		-- Pointer to the global static mutex

feature {NONE}

	dispose
		do
			todo_class_line ("__EV_APPLICATION_IMP__", "__LINE__") 
		end

	TODO_class_line (a_class, a_line: STRING)
		do
		end

invariant
	window_oids_not_void: is_usable implies window_oids /= void
	tooltips_not_void: tooltips /= default_pointer

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




end -- class EV_APPLICATION_IMP

