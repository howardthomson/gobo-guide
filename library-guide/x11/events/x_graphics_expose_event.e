class X_GRAPHICS_EXPOSE_EVENT
  -- Interface to Xlib's XGraphicsExposeEvent structure.

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

  x			: INTEGER    do      Result := c_x 			(to_external)    end
  y			: INTEGER    do      Result := c_y 			(to_external)    end
  width		: INTEGER    do      Result := c_width 		(to_external)    end
  height	: INTEGER    do      Result := c_height 		(to_external)    end
  count		: INTEGER    do      Result := c_count 		(to_external)    end
  major_code: INTEGER    do      Result := c_major_code 	(to_external)    end
  minor_code: INTEGER    do      Result := c_minor_code 	(to_external)    end

feature -- Modification

  set_x			(v : INTEGER)    do  c_set_x			(to_external, v)    ensure      x = v    end
  set_y			(v : INTEGER)    do  c_set_y			(to_external, v)    ensure      y = v    end
  set_width		(v : INTEGER)    do  c_set_width		(to_external, v)    ensure      width = v    end
  set_height	(v : INTEGER)    do	c_set_height	(to_external, v)    ensure      height = v    end
  set_count		(v : INTEGER)    do  c_set_count		(to_external, v)    ensure      count = v    end
  set_major_code(v : INTEGER)    do  c_set_major_code(to_external, v)    ensure      major_code = v    end
  set_minor_code(v : INTEGER)    do  c_set_minor_code(to_external, v)    ensure      minor_code = v    end

feature { NONE } -- External functions

	c_x				(p: POINTER): INTEGER	external "C struct XGraphicsExposeEvent access x use <X11/Xlib.h>"     			end
	c_y				(p: POINTER): INTEGER	external "C struct XGraphicsExposeEvent access y use <X11/Xlib.h>"     			end
	c_width			(p: POINTER): INTEGER	external "C struct XGraphicsExposeEvent access width use <X11/Xlib.h>"     		end
	c_height		(p: POINTER): INTEGER	external "C struct XGraphicsExposeEvent access height use <X11/Xlib.h>"     	end
	c_count			(p: POINTER): INTEGER	external "C struct XGraphicsExposeEvent access count use <X11/Xlib.h>"     		end
	c_major_code	(p: POINTER): INTEGER	external "C struct XGraphicsExposeEvent access major_code use <X11/Xlib.h>"    	end
	c_minor_code	(p: POINTER): INTEGER	external "C struct XGraphicsExposeEvent access minor_code use <X11/Xlib.h>"    	end
	
	c_set_x			(p: POINTER; i: INTEGER)    external "C struct XGraphicsExposeEvent access x type int use <X11/Xlib.h>"    		end
	c_set_y			(p: POINTER; i: INTEGER)    external "C struct XGraphicsExposeEvent access y type int use <X11/Xlib.h>"    		end
	c_set_width		(p: POINTER; i: INTEGER)    external "C struct XGraphicsExposeEvent access width type int use <X11/Xlib.h>"    	end
	c_set_height	(p: POINTER; i: INTEGER)    external "C struct XGraphicsExposeEvent access height type int use <X11/Xlib.h>"    	end
	c_set_count		(p: POINTER; i: INTEGER)    external "C struct XGraphicsExposeEvent access count type int use <X11/Xlib.h>"    	end
	c_set_major_code(p: POINTER; i: INTEGER)    external "C struct XGraphicsExposeEvent access major_code type int use <X11/Xlib.h>"  end
	c_set_minor_code(p: POINTER; i: INTEGER)    external "C struct XGraphicsExposeEvent access minor_code type int use <X11/Xlib.h>"  end

end 
