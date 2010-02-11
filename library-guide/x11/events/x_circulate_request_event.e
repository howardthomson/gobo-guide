class X_CIRCULATE_REQUEST_EVENT
  -- Interface to Xlib's XCirculateRequestEvent structure.

inherit 

	X_ANY_EVENT
    	rename
      		window     as parent,
      		c_window	as c_parent,
      		set_window as set_parent,
      		c_set_window as c_set_parent
    	end  

creation

--	make

creation { X_EVENT }

	from_x_struct

feature -- Access

	window	: INTEGER is    do      Result := c_window (to_external)    end
	place	: INTEGER is    do      Result := c_place (to_external)    end

feature -- Place's values

--	Place_on_top : INTEGER is
--	Place_on_bottom : INTEGER is

feature -- Modification

	set_window	(v : INTEGER) is    do	c_set_window(to_external, v)    ensure      window = v    end
	set_place	(v : INTEGER) is    do	c_set_place	(to_external, v)    ensure      place = v    end  

feature { NONE } -- External functions

	c_window(p: POINTER): INTEGER is do end
	c_place(p: POINTER): INTEGER is do end
	
	c_set_window(p: POINTER; i: INTEGER) is do end
	c_set_place(p: POINTER; i: INTEGER) is do end
end 
