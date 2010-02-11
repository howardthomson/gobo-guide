class X_SELECTION_CLEAR_EVENT
  -- Interface to Xlib's XSelectionClearEvent structure.

inherit 

	X_ANY_EVENT

creation 

	make

creation { X_EVENT }

	from_x_struct

feature -- Access

	selection : X_ATOM is
    	do
      		!!result.make_predefined (display, c_selection (to_external))
    	end

	time : INTEGER is
    	do
			Result := c_time (to_external)
		end

feature -- Modification

	set_selection (v : X_ATOM) is
		do
			c_set_selection (to_external, v.id)
    	ensure
			selection.id = v.id
    	end

	set_time (v : INTEGER) is
    	do
    		c_set_time (to_external, v)
    	ensure
      		time = v
    	end  

feature { NONE } -- External functions

	c_selection		(p: POINTER): INTEGER is	external "C struct XSelectionClearEvent access selection use <X11/Xlib.h>"     		end
	c_time			(p: POINTER): INTEGER is	external "C struct XSelectionClearEvent access time      use <X11/Xlib.h>"     		end

	c_set_selection	(p: POINTER; i: INTEGER) is    external "C struct XSelectionClearEvent access selection type Atom use <X11/Xlib.h>"    	end
	c_set_time		(p: POINTER; i: INTEGER) is    external "C struct XSelectionClearEvent access time      type Time use <X11/Xlib.h>"    	end

end 
