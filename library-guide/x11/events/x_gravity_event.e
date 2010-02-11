class X_GRAVITY_EVENT
  -- Interface to Xlib's XGravityEvent structure

inherit 

	X_ANY_EVENT
    	rename
      		window     as event,
      		c_window	as c_event,
      		set_window as set_event,
      		c_set_window as c_set_event
    	end

creation

	make

creation { X_EVENT }

	from_x_struct

feature -- Access

  window: INTEGER is    do      Result := c_window 	(to_external)    end      -- child window that was moved
  x 	: INTEGER is    do      Result := c_x 		(to_external)    end      -- x position of the window relative to parent window's origin
  y 	: INTEGER is    do      Result := c_y 		(to_external)    end      -- x position of the window relative to parent window's origin


feature -- Modification

  set_window(v : INTEGER) is    do      c_set_window(to_external, v)    ensure      window = v    end
  set_x 	(v : INTEGER) is    do      c_set_x 	(to_external, v)    ensure      x = v    end
  set_y 	(v : INTEGER) is    do      c_set_y 	(to_external, v)    ensure      y = v    end

feature {NONE} -- External functions

	c_window	(p: POINTER): INTEGER is	external "C struct XGravityEvent access window 	use <X11/Xlib.h>"     		end
	c_x 		(p: POINTER): INTEGER is	external "C struct XGravityEvent access x 	 	use <X11/Xlib.h>"     		end
	c_y			(p: POINTER): INTEGER is	external "C struct XGravityEvent access y 		use <X11/Xlib.h>"     		end

	c_set_window(p: POINTER; i: INTEGER) is    external "C struct XGravityEvent access window type Window use <X11/Xlib.h>"    	end
	c_set_x 	(p: POINTER; i: INTEGER) is    external "C struct XGravityEvent access x 	  type int use <X11/Xlib.h>"    	end
	c_set_y		(p: POINTER; i: INTEGER) is    external "C struct XGravityEvent access y 	  type int use <X11/Xlib.h>"    	end

end 
