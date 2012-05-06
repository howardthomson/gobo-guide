class X_EXPOSE_EVENT
	-- Interface to Xlib's XExposeEvent structure

inherit

	X_ANY_EVENT

create

	make,
	from_x_struct

feature -- Access

  x			: INTEGER    do      result := c_x		(to_external)    end
  y 		: INTEGER    do      result := c_y		(to_external)    end
  width	 	: INTEGER    do      result := c_width	(to_external)    end
  height 	: INTEGER    do      result := c_height	(to_external)    end
  count 	: INTEGER    do      result := c_count	(to_external)    end

feature -- Modification

  set_x 	(i : INTEGER)	do	c_set_x		(to_external, i)    ensure      x = i		end
  set_y 	(i : INTEGER)	do	c_set_y		(to_external, i)    ensure      y = i		end
  set_width (i : INTEGER)	do	c_set_width	(to_external, i)    ensure      width = i	end
  set_height(i : INTEGER)	do	c_set_height(to_external, i)    ensure      height = i	end
  set_count (i : INTEGER)	do	c_set_count	(to_external, i)    ensure      count = i	end

feature {NONE} -- external functions

	c_x			(p: POINTER): INTEGER	external "C struct XExposeEvent access x 	  use <X11/Xlib.h>"     end
	c_y			(p: POINTER): INTEGER	external "C struct XExposeEvent access y 	  use <X11/Xlib.h>"     end
	c_width		(p: POINTER): INTEGER	external "C struct XExposeEvent access width  use <X11/Xlib.h>"     end
	c_height	(p: POINTER): INTEGER	external "C struct XExposeEvent access height use <X11/Xlib.h>"     end
	c_count		(p: POINTER): INTEGER	external "C struct XExposeEvent access count  use <X11/Xlib.h>"     end

	c_set_x		(p: POINTER; i: INTEGER)    external "C struct XExposeEvent access x 	 type int use <X11/Xlib.h>"  end
	c_set_y		(p: POINTER; i: INTEGER)    external "C struct XExposeEvent access y 	 type int use <X11/Xlib.h>"  end
	c_set_width	(p: POINTER; i: INTEGER)    external "C struct XExposeEvent access width  type int use <X11/Xlib.h>"  end
	c_set_height(p: POINTER; i: INTEGER)    external "C struct XExposeEvent access height type int use <X11/Xlib.h>"  end
	c_set_count	(p: POINTER; i: INTEGER)    external "C struct XExposeEvent access count  type int use <X11/Xlib.h>"  end

end
