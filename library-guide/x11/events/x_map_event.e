class X_MAP_EVENT
  -- Interface to Xlib's XMapEvent structure.

inherit 

	X_ANY_EVENT
    	rename
      		window     as parent,		c_window	 as c_parent,
      		set_window as set_parent,	c_set_window as c_set_parent
    	end

create 

	make

create { X_EVENT }

	from_x_struct

feature -- Consultation

	window				: INTEGER    do      result := c_window			 (to_external)		end
	override_redirect	: BOOLEAN    do      result := c_override_redirect(to_external) /= 0 end  

feature -- Modification

	set_window				(v : INTEGER)    do	c_set_window			(to_external, v)    ensure	window				= v    end

	set_override_redirect (v : BOOLEAN)
		local
			i: INTEGER
		do
			if v then i := 1 else i := 0 end
			c_set_override_redirect (to_external, i)
		ensure
			override_redirect = v
		end

feature { NONE } -- External functions

	c_window			(p: POINTER): INTEGER	external "C struct XMapEvent access window use <X11/Xlib.h>"     		end
	c_override_redirect	(p: POINTER): INTEGER	external "C struct XMapEvent access override_redirect use <X11/Xlib.h>" end

	c_set_window			(p: POINTER; i: INTEGER)    external "C struct XMapEvent access window type Window use <X11/Xlib.h>"    			end
	c_set_override_redirect	(p: POINTER; i: INTEGER)    external "C struct XMapEvent access override_redirect type Bool use <X11/Xlib.h>"  end

end 
