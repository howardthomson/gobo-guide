class X_EVENT_QUEUE
  -- Collection of event handling procedures.
  --
  --| Stephane Hillion
  --| 1998/01/27

inherit

	X_GLOBAL
	X11_EXTERNAL_ROUTINES

create

	make

feature {NONE} -- Creation

  	make (disp: X_DISPLAY)
    	require
      		disp /= Void
    	do
      		display := disp
    	ensure
      		display = disp
    	end

feature 

  	display: X_DISPLAY	-- The display where the events occures

  	next_event (ev: X_EVENT)
      		-- Fill `ev' with the first event from the event queue
    	require
      		ev /= Void
    	do
      		x_next_event (display.to_external, ev.to_external)
    	end

  	peek_event (ev: X_EVENT)
      		-- Fill `ev' with the first event from the event queue, but it does 
      		-- not remove the event from the queue
    	require
      		ev /= Void
    	do
      		x_peek_event (display.to_external, ev.to_external)
    	end

  	check_window_event (win: X_WINDOW; mask: INTEGER; ev: X_EVENT): BOOLEAN
      		-- searches the events available on the server connection for 
      		-- the first event that matches the specified window and event mask.
      		-- Returns False if no event is available.
    	require
      		win /= Void
      		display.is_equal (win.display)
      		ev /= Void
    	do
      		Result :=  x_check_window_event (display.to_external, win.id, 
				       (mask), ev.to_external) /= 0
    	end

  	check_typed_window_event (win: X_WINDOW; type: INTEGER; ev: X_EVENT): BOOLEAN
      		-- searches any events available on the server connection for 
      		-- the first event that matches the specified type and window.
      		-- Returns False if no event is available.
    	require
      		win /= Void
      		display.is_equal (win.display)
      		ev /= Void
    	do
      		Result :=  x_check_typed_window_event (display.to_external, win.id,
					     type, ev.to_external) /= 0 
    	end

  	check_mask_event (mask: INTEGER; ev: X_EVENT): BOOLEAN
      		-- searches any events available on the server connection for 
      		-- the first event that matches the specified mask
    	require
      		ev /= Void
    	do
      		Result := x_check_mask_event (display.to_external, 
				    (mask),
				    ev.to_external) /= 0 
    	end

  	check_typed_event (type: INTEGER; ev: X_EVENT): BOOLEAN
      		-- searches any events available on the server connection for 
      		-- the first event that matches the specified type.
    	do
      		Result := x_check_typed_event (display.to_external, type, ev.to_external) /= 0 
    	end

  	window_event (win: X_WINDOW; mask: INTEGER; ev: X_EVENT)
      		-- searches the event queue for an event that matches both the
      		-- specified window and event mask.
    	require
      		win /= Void
      		display.is_equal (win.display)
      		ev /= Void
    	do
      		x_window_event (display.to_external, win.id, (mask), ev.to_external)
    	end

  	mask_event (mask: INTEGER; ev: X_EVENT)
      		-- searches the event queue for an event that matches both the
      		-- specified window and event mask.
    	require
      		ev /= Void
    	do
      		x_mask_event (display.to_external, (mask), ev.to_external)
    	end

  	put_back_event (ev: X_EVENT)
      		-- pushes an event back onto the head of the display's event queue
      		-- by copying the event into the queue.
    	require
      		ev /= Void
    	do
      		x_put_back_event (display.to_external, ev.to_external)
    	end

	send_event(win   : X_WINDOW; 
              propag : BOOLEAN; 
              mask   : INTEGER; 
              ev     : X_EVENT): BOOLEAN
      		-- identifies the destination window, determines which clients
      		-- should receive the specified events, and ignores any active grabs
    	require
      		win /= Void
      		ev  /= Void
      		display.is_equal (win.display)
    	do
      		Result := x_send_event (display.to_external, win.id, 
                              propag, (mask), ev.to_external)
    	end

feature -- special windows used by `send_event'

  	pointer_window: X_WINDOW
    	once
      		create Result.make_special (ptr_window)
    	end

  	input_focus: X_WINDOW
    	once
      		create Result.make_special (inp_focus)
    	end

feature

  	allow_events (type, time: INTEGER)
      		-- releases some queued events if the client has caused a
      		-- device to freeze.
    	do
      		x_allow_events (display.to_external, type, time)
    	end

  	events_queued (mode: INTEGER): INTEGER
      		-- returns the number of event in the event queue
    	do
      		Result := x_events_queued (display.to_external, mode)
    	end

feature -- events_queued mode value

	Queued_already		: INTEGER =	0
	Queued_after_flush	: INTEGER =	1
	Queued_after_reading: INTEGER =	2

feature {NONE} -- External functions

  	ptr_window: INTEGER
    	external "C macro use <X11/Xlib.h>"
    	alias "PointerWindow"
    	end

  	inp_focus: INTEGER
    	external "C macro use <X11/Xlib.h>"
    	alias "InputFocus"
    	end

end 
