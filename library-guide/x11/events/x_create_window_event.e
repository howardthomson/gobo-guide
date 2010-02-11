class X_CREATE_WINDOW_EVENT
  -- Interface to Xlib's XCreateWindowEvent.

inherit 

	X_ANY_EVENT
    	rename
      		window     as parent,
      		c_window as c_parent,
      		set_window as set_parent,
      		c_set_window as c_set_parent
    	end

creation 

	make

creation { X_EVENT }

	from_x_struct

feature -- Consultation

	window				: INTEGER is	do      Result := c_window				(to_external)    end
	x					: INTEGER is    do      Result := c_x					(to_external)    end
	y					: INTEGER is    do      Result := c_y					(to_external)    end
	width				: INTEGER is    do      Result := c_width				(to_external)    end
	height				: INTEGER is    do      Result := c_height				(to_external)    end
	border_width		: INTEGER is    do      Result := c_border_width		(to_external)    end
	override_redirect	: BOOLEAN is    do      Result := c_override_redirect	(to_external) /= 0 end

feature -- Modification

	set_window				(v : INTEGER) is    do      c_set_window			(to_external, v)    ensure	window = v    			end
	set_x					(v : INTEGER) is    do      c_set_x					(to_external, v)    ensure  x = v    				end
	set_y					(v : INTEGER) is    do      c_set_y					(to_external, v)    ensure  y = v    				end
	set_width				(v : INTEGER) is    do      c_set_width				(to_external, v)    ensure  width = v    			end
	set_height				(v : INTEGER) is    do      c_set_height			(to_external, v)    ensure  height = v    			end
	set_border_width		(v : INTEGER) is    do      c_set_border_width		(to_external, v)    ensure  border_width = v    	end

	set_override_redirect (v : BOOLEAN) is
		local
			i: INTEGER
	    do
			if v then i := 1 else i := 0 end
	    	c_set_override_redirect	(to_external, i)
	    ensure
	    	override_redirect = v
	    end

feature { NONE } -- External functions
	c_window				(p: POINTER): INTEGER is	external "C struct XCreateWindowEvent access window use <X11/Xlib.h>"     			end
	c_x						(p: POINTER): INTEGER is	external "C struct XCreateWindowEvent access x use <X11/Xlib.h>"     				end
	c_y						(p: POINTER): INTEGER is	external "C struct XCreateWindowEvent access y use <X11/Xlib.h>"     				end
	c_width					(p: POINTER): INTEGER is	external "C struct XCreateWindowEvent access width use <X11/Xlib.h>"     			end
	c_height				(p: POINTER): INTEGER is	external "C struct XCreateWindowEvent access height use <X11/Xlib.h>"     			end
	c_border_width			(p: POINTER): INTEGER is	external "C struct XCreateWindowEvent access border_width use <X11/Xlib.h>"     	end
	c_override_redirect		(p: POINTER): INTEGER is	external "C struct XCreateWindowEvent access override_redirect use <X11/Xlib.h>"    end
	
	c_set_window			(p: POINTER; i: INTEGER) is    external "C struct XCreateWindowEvent access window            type Window use <X11/Xlib.h>"    		end
	c_set_x					(p: POINTER; i: INTEGER) is    external "C struct XCreateWindowEvent access x                 type int use <X11/Xlib.h>"    				end
	c_set_y					(p: POINTER; i: INTEGER) is    external "C struct XCreateWindowEvent access y                 type int use <X11/Xlib.h>"    				end
	c_set_width				(p: POINTER; i: INTEGER) is    external "C struct XCreateWindowEvent access width             type int use <X11/Xlib.h>"    			end
	c_set_height			(p: POINTER; i: INTEGER) is    external "C struct XCreateWindowEvent access height            type int use <X11/Xlib.h>"    		end
	c_set_border_width		(p: POINTER; i: INTEGER) is    external "C struct XCreateWindowEvent access border_width      type int use <X11/Xlib.h>"    	end
	c_set_override_redirect	(p: POINTER; i: INTEGER) is    external "C struct XCreateWindowEvent access override_redirect type Bool use <X11/Xlib.h>" end

end 
