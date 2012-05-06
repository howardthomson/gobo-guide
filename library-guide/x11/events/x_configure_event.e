class X_CONFIGURE_EVENT
  -- Interface to Xlib's XConfigureEvent structure.

inherit

	X_ANY_EVENT
    	rename
      		window as event,
      		c_window as c_event,
      		set_window as set_event,
      		c_set_window as c_set_event
		redefine
			trace_def
    	end

create {NONE}

	make

create { X_EVENT }

	from_x_struct

feature -- Access

	window				: INTEGER    do      Result := c_window 				(to_external)    	end
	x					: INTEGER    do      Result := c_x 					(to_external)    	end
	y					: INTEGER    do      Result := c_y 					(to_external)    	end
	width				: INTEGER    do      Result := c_width 				(to_external)    	end
	height				: INTEGER    do      Result := c_height 				(to_external)    	end
	border_width		: INTEGER    do      Result := c_border_width 		(to_external)    	end
	above				: INTEGER    do      Result := c_above 				(to_external)    	end
	override_redirect	: BOOLEAN    do      Result := c_override_redirect	(to_external) /= 0  end

feature -- Modification

	set_window 				(v : INTEGER)    do      c_set_window 			(to_external, v)	ensure	window = v    		end
	set_x 					(v : INTEGER)    do      c_set_x 				(to_external, v)    ensure  x = v    			end
	set_y 					(v : INTEGER)    do      c_set_y 				(to_external, v)    ensure  y = v    			end
	set_width 				(v : INTEGER)    do      c_set_width 			(to_external, v)    ensure  width = v    		end
	set_height 				(v : INTEGER)    do      c_set_height 			(to_external, v)    ensure  height = v    		end
	set_border_width 		(v : INTEGER)    do      c_set_border_width 		(to_external, v)    ensure  border_width = v   	end
	set_above 				(v : INTEGER)    do      c_set_above 			(to_external, v)    ensure  above = v    		end

	set_override_redirect (v : BOOLEAN)
		local
			i: INTEGER
	    do
	    	if v then i := 1 else i := 0 end
	    	c_set_override_redirect	(to_external, i)
	    ensure
	    	override_redirect = v
	    end

feature {NONE} -- External functions

	c_window				(p: POINTER): INTEGER	external "C struct XConfigureEvent access window use <X11/Xlib.h>"     			end
	c_x						(p: POINTER): INTEGER	external "C struct XConfigureEvent access x use <X11/Xlib.h>"     				end
	c_y						(p: POINTER): INTEGER	external "C struct XConfigureEvent access y use <X11/Xlib.h>"     				end
	c_width					(p: POINTER): INTEGER	external "C struct XConfigureEvent access width use <X11/Xlib.h>"     			end
	c_height				(p: POINTER): INTEGER	external "C struct XConfigureEvent access height use <X11/Xlib.h>"     			end
	c_border_width			(p: POINTER): INTEGER	external "C struct XConfigureEvent access border_width use <X11/Xlib.h>"     	end
	c_above					(p: POINTER): INTEGER	external "C struct XConfigureEvent access above use <X11/Xlib.h>"     			end
	c_override_redirect		(p: POINTER): INTEGER	external "C struct XConfigureEvent access override_redirect use <X11/Xlib.h>"  	end

	c_set_window			(p: POINTER; i: INTEGER)    external "C struct XConfigureEvent access window type Window use <X11/Xlib.h>"    		end
	c_set_x					(p: POINTER; i: INTEGER)    external "C struct XConfigureEvent access x type int use <X11/Xlib.h>"    				end
	c_set_y					(p: POINTER; i: INTEGER)    external "C struct XConfigureEvent access y type int use <X11/Xlib.h>"    				end
	c_set_width				(p: POINTER; i: INTEGER)    external "C struct XConfigureEvent access width type int use <X11/Xlib.h>"   			end
	c_set_height			(p: POINTER; i: INTEGER)    external "C struct XConfigureEvent access height type int use <X11/Xlib.h>"    			end
	c_set_border_width		(p: POINTER; i: INTEGER)    external "C struct XConfigureEvent access border_width type int use <X11/Xlib.h>"    	end
	c_set_above				(p: POINTER; i: INTEGER)    external "C struct XConfigureEvent access above type Window use <X11/Xlib.h>"    		end
	c_set_override_redirect	(p: POINTER; i: INTEGER)    external "C struct XConfigureEvent access override_redirect type Bool use <X11/Xlib.h>"  end

feature {NONE} -- Tracing implementation

	trace_def
		do
			io.put_string(" width: "); io.put_string(width.out)
			io.put_string(" height: "); io.put_string(height.out)
		end

end
