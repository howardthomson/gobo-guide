class X_FOCUS_CHANGE_EVENT
  -- Interface to Xlib's XFocusChangeEvent structure.

inherit 

	X_ANY_EVENT

creation 

	make,
	from_x_struct

feature -- Access

	mode  : INTEGER is	do	Result := c_mode (to_external)    end
	detail: INTEGER is	do	Result := c_detail (to_external)    end
  
feature -- Modification

	set_mode	(v: INTEGER) is	do	c_set_mode	(to_external, v)	ensure	mode   = v    end
	set_detail	(v: INTEGER) is	do	c_set_detail(to_external, v)	ensure	detail = v    end

feature -- mode values

--	Notify_normal : INTEGER is
--	Notify_grab : INTEGER is
--	Notify_ungrab : INTEGER is

feature -- detail values
	
--	Notify_ancestor : INTEGER is
--	Notify_virtual : INTEGER is
--	Notify_inferior : INTEGER is
--	Notify_nonlinear : INTEGER is
--	Notify_nonlinear_virtual : INTEGER is
--	Notify_pointer : INTEGER is
--	Notify_pointer_root : INTEGER is
--	Notify_detail_none : INTEGER is

feature { NONE } -- External functions

	c_mode			(p: POINTER): INTEGER is	external "C struct XFocusChangeEvent access mode use <X11/Xlib.h>"     		end
	c_detail		(p: POINTER): INTEGER is	external "C struct XFocusChangeEvent access detail use <X11/Xlib.h>"     	end

	c_set_mode		(p: POINTER; i: INTEGER) is    external "C struct XFocusChangeEvent access mode type int use <X11/Xlib.h>"    	end
	c_set_detail	(p: POINTER; i: INTEGER) is    external "C struct XFocusChangeEvent access detail type int use <X11/Xlib.h>"    	end

end 
