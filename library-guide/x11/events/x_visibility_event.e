class X_VISIBILITY_EVENT
  -- Interface to XVisiblityEvent

inherit 

	X_ANY_EVENT

create 

	make,
	from_x_struct

feature -- Access

	state : INTEGER
		do
      		Result := c_state (to_external)
    	end

feature -- Modification

	set_state (v : INTEGER)
		do
			c_set_state (to_external, v)
		end

feature -- State values

--	Visibility_unobscured : INTEGER is
--	Visibility_partially_obscured : INTEGER is
--	Visibility_fully_obscured : INTEGER is

feature { NONE } -- External functions

	c_state			(p: POINTER): INTEGER	external "C struct XVisibilityEvent access state use <X11/Xlib.h>"     		end

	c_set_state		(p: POINTER; i: INTEGER)    external "C struct XVisibilityEvent access state type int use <X11/Xlib.h>"    	end

end 
