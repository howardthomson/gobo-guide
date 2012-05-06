class X_NO_EXPOSE_EVENT
  -- Interface to Xlib's XNoExposeEvent structure.

inherit 

	X_ANY_EVENT
    	rename
      		window     as drawable,
      		set_window as set_drawable
    	end

create 

	make

create { X_EVENT }

	from_x_struct

feature -- Access

	major_code : INTEGER
    	do
      		Result := c_major_code (to_external)
    	end

	minor_code : INTEGER
    	do
      		Result := c_minor_code (to_external)
    	end

feature -- Modification

	set_major_code (v : INTEGER)
    	do
      		c_set_major_code (to_external, v)
    	ensure
      		major_code = v
    	end

  	set_minor_code (v : INTEGER)
    	do
      		c_set_minor_code (to_external, v)
    	ensure
      		minor_code = v
    	end

feature { NONE } -- External functions

	c_major_code			(p: POINTER): INTEGER	external "C struct XNoExposeEvent access major_code use <X11/Xlib.h>"     		end
	c_minor_code			(p: POINTER): INTEGER	external "C struct XNoExposeEvent access minor_code use <X11/Xlib.h>"     		end

	c_set_major_code		(p: POINTER; i: INTEGER)    external "C struct XNoExposeEvent access major_code type int use <X11/Xlib.h>"    	end
	c_set_minor_code		(p: POINTER; i: INTEGER)    external "C struct XNoExposeEvent access minor_code type int use <X11/Xlib.h>"    	end

end 
