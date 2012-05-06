class X_EVENT
  -- Interface to Xlib's XEvent union.
  --
  --| Stephane Hillion
  --| 1998/01/27

inherit 

	X_ANY_EVENT

create 

	make,
	from_x_struct	-- FIXGC

feature -- Casting

	to_x_key_event: X_KEY_EVENT
		require
			type = Key_press or else type = Key_release
		do
			create Result.from_x_struct (Current)
		end

	to_x_button_event: X_BUTTON_EVENT
		require
			type = Button_press or else type = Button_release
		do
			create Result.from_x_struct (Current)
		end

	to_x_motion_event: X_MOTION_EVENT
    	require
      		type = Motion_notify
    	do
    		create Result.from_x_struct (Current)
    	end

  	to_x_crossing_event: X_CROSSING_EVENT
    	require
      		type = Enter_notify or else type = Leave_notify
    	do
      		create Result.from_x_struct (Current)
    	end

  	to_x_focus_change_event: X_FOCUS_CHANGE_EVENT
    	require
      		type = Focus_in or else type = Focus_out
    	do
      		create Result.from_x_struct (Current)
    	end

  	to_x_keymap_event: X_KEYMAP_EVENT
    	require
      		type = Keymap_notify
    	do
      		create Result.from_x_struct (Current)
    	end

  	to_x_expose_event: X_EXPOSE_EVENT
    	require
      		type = Expose
    	do
      		create Result.from_x_struct (Current)
    	end

	to_x_graphics_expose_event: X_GRAPHICS_EXPOSE_EVENT
    	require
      		type = Graphics_expose
    	do
      		create Result.from_x_struct (Current)
    	end

  	to_x_no_expose_event: X_NO_EXPOSE_EVENT
    	require
      		type = No_expose
    	do
      		create Result.from_x_struct (Current)
    	end

  	to_x_visibility_event: X_VISIBILITY_EVENT
    	require
      		type = Visibility_notify
    	do
      		create Result.from_x_struct (Current)
    	end

  	to_x_create_window_event: X_CREATE_WINDOW_EVENT
    	require
      		type = Create_notify
    	do
      		create Result.from_x_struct (Current)
    	end

  	to_x_destroy_window_event: X_DESTROY_WINDOW_EVENT
    	require
      		type = Destroy_notify
    	do
      		create Result.from_x_struct (Current)
    	end

  	to_x_unmap_event: X_UNMAP_EVENT
    	require
      		type = Unmap_notify
    	do
      		create Result.from_x_struct (Current)
    	end

 	to_x_map_event : X_MAP_EVENT
    	require
      		type = Map_notify
    	do
      		create Result.from_x_struct (Current)
    	end

  	to_x_map_request_event : X_MAP_REQUEST_EVENT
    	require
      		type = Map_request
    	do
      		create Result.from_x_struct (Current)
    	end

  	to_x_reparent_event : X_REPARENT_EVENT
    	require
      		type = Reparent_notify
    	do
      		create Result.from_x_struct (Current)
    	end

  	to_x_configure_event: X_CONFIGURE_EVENT
    	require
      		type = Configure_notify
    	do
      		create Result.from_x_struct (Current)
    	end

  	to_x_gravity_event: X_GRAVITY_EVENT
    	require
      		type = Gravity_notify
    	do
      		create Result.from_x_struct (Current)
    	end

  	to_x_resize_request_event: X_RESIZE_REQUEST_EVENT
    	require
      		type = Resize_request
    	do
      		create Result.from_x_struct (Current)
    	end

  	to_x_configure_request_event: X_CONFIGURE_REQUEST_EVENT
    	require
      		type = Configure_request
    	do
      		create Result.from_x_struct (Current)
    	end

  	to_x_circulate_event: X_CIRCULATE_EVENT
    	require
      		type = Circulate_notify
    	do
      		create Result.from_x_struct (Current)
    	end

  	to_x_circulate_request_event: X_CIRCULATE_REQUEST_EVENT
    	require
      		type = Circulate_request
    	do
      		create Result.from_x_struct (Current)
    	end

  	to_x_property_event: X_PROPERTY_EVENT
    	require
      		type = Property_notify
    	do
      		create Result.from_x_struct (Current)
    	end

  	to_x_selection_clear_event: X_SELECTION_CLEAR_EVENT
    	require
      		type = Selection_clear
    	do
      		create Result.from_x_struct (Current)
    	end

  	to_x_selection_request_event: X_SELECTION_REQUEST_EVENT
    	require
      		type = Selection_request
    	do
      		create Result.from_x_struct (Current)
    	end

  	to_x_selection_event: X_SELECTION_EVENT
    	require
      		type = Selection_notify
    	do
      		create Result.from_x_struct (Current)
    	end

end 
