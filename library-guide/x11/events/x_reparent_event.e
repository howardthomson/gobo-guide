class X_REPARENT_EVENT
  -- Interface to Xlib's XReparentEvent structure.

inherit 

	X_ANY_EVENT
    	rename
      		window     as event,	 c_window	  as c_event,
      		set_window as set_event, c_set_window as c_set_event
    	end

creation 

	make

creation { X_EVENT }

	from_x_struct

feature --  Access

	window 				: INTEGER is    do      Result := c_window 				(to_external)    	end
	parent 				: INTEGER is    do      Result := c_parent 				(to_external)    	end 
	x 					: INTEGER is    do      Result := c_x 					(to_external)    	end
	y 					: INTEGER is    do      Result := c_y 					(to_external)    	end
	override_redirect 	: BOOLEAN is    do      Result := c_override_redirect 	(to_external) /= 0  end

feature --  Modification

	set_window 				(v : INTEGER) is    do	c_set_window 			(to_external, v)    ensure      window = v    end
	set_parent 				(v : INTEGER) is    do  c_set_parent 			(to_external, v)    ensure      parent = v    end  
	set_x 					(v : INTEGER) is    do  c_set_x 				(to_external, v)    ensure      x = v    end
	set_y 					(v : INTEGER) is    do  c_set_y 				(to_external, v)    ensure      y = v    end

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

	c_window				(p: POINTER): INTEGER is	external "C struct XReparentEvent access window use <X11/Xlib.h>"     		end
	c_parent				(p: POINTER): INTEGER is	external "C struct XReparentEvent access parent use <X11/Xlib.h>"     		end
	c_x						(p: POINTER): INTEGER is	external "C struct XReparentEvent access x use <X11/Xlib.h>"     		end
	c_y						(p: POINTER): INTEGER is	external "C struct XReparentEvent access y use <X11/Xlib.h>"     		end
	c_override_redirect		(p: POINTER): INTEGER is	external "C struct XReparentEvent access override_redirect use <X11/Xlib.h>"     		end
	
	c_set_window			(p: POINTER; i: INTEGER) is    external "C struct XReparentEvent access window type Window use <X11/Xlib.h>"    	end
	c_set_parent			(p: POINTER; i: INTEGER) is    external "C struct XReparentEvent access parent type Window use <X11/Xlib.h>"    	end
	c_set_x					(p: POINTER; i: INTEGER) is    external "C struct XReparentEvent access x                 type int use <X11/Xlib.h>"    	end
	c_set_y					(p: POINTER; i: INTEGER) is    external "C struct XReparentEvent access y                 type int use <X11/Xlib.h>"    	end
	c_set_override_redirect	(p: POINTER; i: INTEGER) is    external "C struct XReparentEvent access override_redirect type Bool use <X11/Xlib.h>"    	end

end 
