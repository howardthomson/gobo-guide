class X_PROPERTY_EVENT
  -- Interface to Xlib's XPropertyEvent structure.

inherit 

	X_ANY_EVENT

creation 

	make

creation {X_EVENT}

  from_x_struct

feature -- Consultation

	atom : X_ATOM is
    	do
      		create Result.make_predefined (display, c_atom (to_external))
    	end  

  	time : INTEGER is
    	do
      		result := c_time (to_external)
    	end  

  	state : INTEGER is
    	do
      		result := c_state (to_external)
    	end  

feature -- State's values

--	New_value : INTEGER is
--	Deleted : INTEGER is

feature -- Modification

  	set_atom (v : X_ATOM) is
    	do
      		c_set_atom (to_external, v.id)
    	ensure
      		atom.id = v.id
    	end

  	set_time (v : INTEGER) is
    	do
      		c_set_time (to_external, v)
    	ensure
      		time = v
    	end  

  	set_state (v : INTEGER) is
    	do
      		c_set_state (to_external, v)
    	ensure
      		state = v
    	end  

feature {NONE} -- External functions

	c_atom			(p: POINTER): INTEGER is	external "C struct XPropertyEvent access atom use <X11/Xlib.h>"     		end
	c_time			(p: POINTER): INTEGER is	external "C struct XPropertyEvent access time use <X11/Xlib.h>"     		end
	c_state			(p: POINTER): INTEGER is	external "C struct XPropertyEvent access state use <X11/Xlib.h>"     		end

	c_set_atom		(p: POINTER; i: INTEGER) is    external "C struct XPropertyEvent access atom  type Atom use <X11/Xlib.h>"    	end
	c_set_time		(p: POINTER; i: INTEGER) is    external "C struct XPropertyEvent access time  type Time use <X11/Xlib.h>"    	end
	c_set_state		(p: POINTER; i: INTEGER) is    external "C struct XPropertyEvent access state type int  use <X11/Xlib.h>"    	end

end 
