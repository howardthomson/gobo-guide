class X_CIRCULATE_EVENT
  -- Interface to Xlib's XCirculateEvent structure.

inherit 

	X_ANY_EVENT
    	rename
      		window     as event,
      		set_window as set_event,
      		c_window	as c_event,
      		c_set_window as c_set_event
    	end  

create {NONE}

	make

create {X_EVENT}

	from_x_struct

feature -- Access

	window	: INTEGER    do      result := c_window (to_external)    end
	place	: INTEGER    do      result := c_place (to_external)    end

feature -- Modification

	set_window	(v : INTEGER)	do	c_set_window(to_external, v)    ensure      window = v    end
	set_place	(v : INTEGER)	do	c_set_place	(to_external, v)    ensure      place = v    end  

feature { NONE } -- External routines

  c_window		(p : POINTER) : INTEGER    external "C struct XCirculateEvent access window use <X11/Xlib.h>"    end
  c_place		(p : POINTER) : INTEGER    external "C struct XCirculateEvent access place use <X11/Xlib.h>"    end

  c_set_window	(p : POINTER; v : INTEGER)    external "C struct XCirculateEvent access window type Window use <X11/Xlib.h>"    end
  c_set_place	(p : POINTER; v : INTEGER)    external "C struct XCirculateEvent access place type int use <X11/Xlib.h>"    end

end 
