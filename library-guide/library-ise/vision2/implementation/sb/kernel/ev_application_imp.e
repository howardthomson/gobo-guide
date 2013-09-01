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
		redefine
			focused_widget, make
		end

	EV_APPLICATION_ACTION_SEQUENCES_IMP

	SB_APPLICATION
		rename
			make as make_sb,
			class_name as class_name_sb,
			sleep as sleep_sb,
			launch as launch_sb
		end

create
	make

feature -- TODO

	is_display_remote: BOOLEAN
		do
			Result := False
			todo ("is_display_remote")
		end

	create_system_color_change_actions: EV_NOTIFY_ACTION_SEQUENCE
		do
			create Result
		end

feature {NONE} -- Initialization

	make
			-- Set up the callback marshal and initialize GTK+.
		local
			locale_str: STRING
		do
			make_sb ("", "")
			Precursor

--			put ("localhost:0", "DISPLAY")
				-- This line may be uncommented to allow for display
				-- redirection to another machine for debugging purposes
			if slyboots_is_launchable then
				-- ....
			else
				-- We are unable to launch the Slyboots toolkit, probably due to a DISPLAY issue.
				print ("EiffelVision application could not launch, check DISPLAY environment variable%N")
				die (0)
			end
		end

feature {NONE} -- Event loop

	 launch
			-- Display the first window, set up the post_launch_actions,
			-- and start the event loop.
		do
			if slyboots_is_launchable then
				launch_sb
				call_post_launch_actions
			end
		end

	slyboots_is_launchable: BOOLEAN
		do
			Result := True
		end

feature {NONE} -- Implementation

	process_underlying_toolkit_event_queue
			-- Process event queue from underlying toolkit.
			-- `events_process_from_toolkit
		local
			x: BOOLEAN
		do
		--	check false end
			x := run_while_events (Void)
		end

feature -- Basic operation

	process_graphical_events
			-- Process any pending paint events.
			-- Pass control to the GUI toolkit so that it can
			-- handle any paint events that may be in its queue.
		do
			check false end
		end

	sleep (msec: INTEGER)
			-- Wait for `msec' milliseconds and return.
		do
		--	check false end
		end

	tooltip_delay: INTEGER
			-- Time in milliseconds before tooltips pop up.
		do
		--	Result := sb_application.tooltip_pause
			Result := tooltip_pause
		end

	wait_for_input (msec: INTEGER)
			-- Wait for at most `msec' milliseconds for an input.
		do
		--	check false end
--			sb_application.wait_for_input (msec)
		end

	destroy
			-- End the application.
		do
			if not is_destroyed then

				exit (0) -- FIXME: exit or stop ?

				set_is_destroyed (True)
					-- This will exit our main loop
				destroy_actions.call (Void)
			end
		end

feature -- Status setting

	set_tooltip_delay (a_delay: INTEGER)
			-- Set `tooltip_delay' to `a_delay'.
		do
			set_tooltip_pause (a_delay)
		end

feature -- Locking

	lock
			-- Lock the Mutex.
		do
			check false end
		end

	try_lock: BOOLEAN
			-- Try to see if we can lock, False means no lock could be attained
		do
			check false end
		end

	unlock
			-- Unlock the Mutex.
		do
			check false end
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
						check false end
						--todo_class_line ("__EV_APPLICATION_IMP__", "__LINE__29")
					else
						Result := current_window
					end
				end
				current_windows.forth
			end
		end

feature -- Access

	ctrl_pressed: BOOLEAN
			-- Is ctrl key currently pressed?
		do
			check false end
		end

	alt_pressed: BOOLEAN
			-- Is alt key currently pressed?
		do
			check false end
		end

	shift_pressed: BOOLEAN
			-- Is shift key currently pressed?
		do
			check false end		end

	caps_lock_on: BOOLEAN
			-- Is the Caps or Shift Lock key currently on?
		do
			check false end
		end

	windows: LINEAR [EV_WINDOW]
			-- Global list of windows.
		do
			check false end
		end

feature -- Implementation

	pick_and_drop_source: EV_PICK_AND_DROPABLE_IMP
			-- Source of pick and drop if any.
		do
			check false end

--			Result := internal_pick_and_drop_source
		end

invariant
--	window_oids_not_void: is_usable implies window_oids /= void
--	tooltips_not_void: tooltips /= default_pointer

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

