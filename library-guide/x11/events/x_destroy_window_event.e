class X_DESTROY_WINDOW_EVENT
  -- Interface to Xlib's XDestroyWindowEvent structure.

inherit 

	X_ANY_EVENT
    	rename
      		window     as event,
      		c_window	as c_event,
      		set_window as set_event,
      		c_set_window as c_set_event
    	end

create 

	make

create { X_EVENT }

	from_x_struct

feature -- Access

  window : INTEGER    do      result := c_window (to_external)    end
  
feature -- Modification

  set_window (v : INTEGER)    do      c_set_window (to_external, v)    ensure      window = v    end
  
feature { NONE } -- External functions

	c_window			(p: POINTER): INTEGER	external "C struct XDestroyWindowEvent access window use <X11/Xlib.h>"     		end
	
	c_set_window			(p: POINTER; i: INTEGER)    external "C struct XDestroyWindowEvent access window type Window use <X11/Xlib.h>"    	end

end 
