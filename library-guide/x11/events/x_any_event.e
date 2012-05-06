class X_ANY_EVENT
  -- This class is an interface to Xlib's XAnyEvent structure.
  -- It provides some features that are common to all event structures.
  --
  --| Stephane Hillion
  --| 1998/01/27

inherit

	X_STRUCT
	X_EVENT_TYPES

create

	make

create {X_EVENT}

	from_x_struct

feature -- Casting

	to_event: X_EVENT
			-- returns an X_EVENT with the same external representation
			-- as `Current'
		do
			create Result.from_x_struct (Current)
		ensure
			same_external_object: to_external = Result.to_external
		end

feature -- Consultation

	type: INTEGER
			-- returns an integer constant indicating the type of `Current'.
		do
			Result := c_type (to_external)
		end

	window: INTEGER
			-- returns the window that is most useful to toolkit dispatchers.
		do
			Result := c_window (to_external)
		end

	display: X_DISPLAY
			-- returns the display the event was read from.
		do
			create Result.from_external (c_display (to_external))
		end

	serial: INTEGER
			-- returns the sequence number of last request processed by server.
		do
			Result := c_serial (to_external)
		end

	send_event: BOOLEAN
			-- returns true if this came from a `send_event' request.
		do
			Result := c_send_event (to_external)
		end

feature -- Modification

	set_type (a_type: INTEGER)
			-- sets the type of the event.
		do
			c_set_type (to_external, a_type)
		ensure
			type = a_type
		end

	set_window (a_window: INTEGER)
			-- sets the event window.
		do
			c_set_window (to_external, a_window)
		ensure
			window = a_window
		end

	set_display (a_display: X_DISPLAY)
			-- sets the event display.
		require
			a_display /= Void
		do
			c_set_display (to_external, a_display.to_external)
		ensure
			display.is_equal (a_display)
		end

feature -- Debug / Trace

	event_type_names: ARRAY [ STRING ]
		once
			Result := <<
				"NOT AN EVENT !!",		-- 1
				"Key_press",			-- 2
				"Key_release",			-- 3
				"Button_press",			-- 4
				"Button_release",		-- 5
				"Motion_notify",		-- 6
				"Enter_notify",			-- 7
				"Leave_notify",			-- 8
				"Focus_in",				-- 9
				"Focus_out",			-- 10
				"Keymap_notify",		-- 11
				"Expose",				-- 12
				"Graphics_expose",		-- 13
				"No_expose",			-- 14
				"Visibility_notify",	-- 15
				"Create_notify",		-- 16
				"Destroy_notify",		-- 17
				"Unmap_notify",			-- 18
				"Map_notify",			-- 19
				"Map_request",			-- 20
				"Reparent_notify",		-- 21
				"Configure_notify",		-- 22
				"Configure_request",	-- 23
				"Gravity_notify",		-- 24
				"Resize_request",		-- 25
				"Circulate_notify",		-- 26
				"Circulate_request",	-- 27
				"Property_notify",		-- 28
				"Selection_clear",		-- 29
				"Selection_request",	-- 30
				"Selection_notify",		-- 31
				"Colormap_notify",		-- 32
				"Client_message",		-- 33
				"Mapping_notify"		-- 34
				>>
		end

	trace
		local
			t: INTEGER
			s: STRING
		do
			io.put_string("Event trace ==> ")
			t := type
			io.put_string("Object: "); io.put_string(out)
			io.put_string(" Type ("); io.put_string(t.out); io.put_string(") ")
			if t > 0 and then t <= 34 then
				s := event_type_names @ t
			else
				s := once "## Type OUT-OF-RANGE"
			end
			io.put_string(s)
			io.put_string(" Window "); 	io.put_string(window.out)
			io.put_string(" Serial "); 	io.put_string(serial.out)

			trace_def
			io.put_string("%N")
		end

	trace_def
		do
		end

feature { NONE }

	size: INTEGER
    	once
    		Result := c_event_size
    	end

feature {NONE} -- external functions

	c_event_size: INTEGER
		external
			"C macro use <X11/Xlib.h>"
		alias
			"sizeof(XEvent)"
		end

	c_type				(p: POINTER): INTEGER    external "C struct XAnyEvent access @type       use <X11/Xlib.h>" end
	c_serial			(p: POINTER): INTEGER    external "C struct XAnyEvent access serial		use <X11/Xlib.h>" end
	c_send_event		(p: POINTER): BOOLEAN    external "C struct XAnyEvent access send_event	use <X11/Xlib.h>" end
	c_display			(p: POINTER): POINTER    external "C struct XAnyEvent access display		use <X11/Xlib.h>" end
	c_window			(p: POINTER): INTEGER    external "C struct XAnyEvent access window		use <X11/Xlib.h>" end

--	c_set_type			(p: POINTER; i: INTEGER) is	external "C struct XAnyEvent access @type      type int      use <X11/Xlib.h>" end
	c_set_serial		(p: POINTER; i: INTEGER) external "C struct XAnyEvent access serial	   type long     use <X11/Xlib.h>" end
	c_set_send_event	(p: POINTER; b: BOOLEAN) external "C struct XAnyEvent access send_event type Bool     use <X11/Xlib.h>" end
	c_set_display		(p: POINTER; i: POINTER) external "C struct XAnyEvent access display    type Display* use <X11/Xlib.h>" end
	c_set_window		(p: POINTER; i: INTEGER) external "C struct XAnyEvent access window	   type Window	 use <X11/Xlib.h>" end

	c_set_type (p: POINTER; i: INTEGER)
		external
			"C inline use <X11/Xlib.h>"
		alias
			"((XAnyEvent *) $p)->type = $i;"
		end

end
