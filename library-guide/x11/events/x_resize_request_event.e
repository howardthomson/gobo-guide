class X_RESIZE_REQUEST_EVENT
  -- Interface to Xlib's XResizeRequestEvent structure

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

creation {X_EVENT}

	from_x_struct

feature -- Access

	window	: INTEGER is    do      result := c_window (to_external)    end
	width	: INTEGER is    do      result := c_width (to_external)    end
	height	: INTEGER is    do      result := c_height (to_external)    end

feature -- Modification

	set_window	(v : INTEGER) is	do	c_set_window(to_external, v)	ensure	window	= v    end
	set_width	(v : INTEGER) is	do	c_set_width	(to_external, v)	ensure	width	= v    end
	set_height	(v : INTEGER) is	do	c_set_height(to_external, v)	ensure	height	= v    end

feature { NONE } -- External functions

	c_window		(p: POINTER): INTEGER is	external "C struct XResizeRequestEvent access window use <X11/Xlib.h>"     		end
	c_width			(p: POINTER): INTEGER is	external "C struct XResizeRequestEvent access width use <X11/Xlib.h>"     		end
	c_height		(p: POINTER): INTEGER is	external "C struct XResizeRequestEvent access height use <X11/Xlib.h>"     		end

	c_set_window	(p: POINTER; i: INTEGER) is    external "C struct XResizeRequestEvent access window type Window use <X11/Xlib.h>"    	end
	c_set_width		(p: POINTER; i: INTEGER) is    external "C struct XResizeRequestEvent access width  type int use <X11/Xlib.h>"    	end
	c_set_height	(p: POINTER; i: INTEGER) is    external "C struct XResizeRequestEvent access height type int use <X11/Xlib.h>"    	end

end 
