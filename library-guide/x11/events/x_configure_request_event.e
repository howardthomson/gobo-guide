class X_CONFIGURE_REQUEST_EVENT
  -- Interface to Xlib's XConfigureRequestEvent structure.

inherit 

	X_ANY_EVENT
    	rename
      		window     as parent,
      		c_window as c_parent,
      		set_window as set_parent,
      		c_set_window as c_set_parent
    	end

create {NONE}

	make

create { X_EVENT }

	from_x_struct

feature -- Consultation

	window		: INTEGER   	do      Result := c_window		(to_external)    end
	x			: INTEGER   	do      Result := c_x			(to_external)    end
	y			: INTEGER   	do      Result := c_y			(to_external)    end
	width		: INTEGER   	do      Result := c_width		(to_external)    end
	height		: INTEGER   	do      Result := c_height		(to_external)    end
	border_width: INTEGER   	do      Result := c_border_width(to_external)    end
	above		: INTEGER   	do      Result := c_above		(to_external)    end
	detail		: INTEGER   	do      Result := c_detail		(to_external)    end
	value_mask	: INTEGER	do      Result := c_value_mask	(to_external)    end

feature -- detail's values

--	Detail_above		: INTEGER is
--	Detail_below		: INTEGER is
--	Detail_top_if		: INTEGER is
--	Detail_bottom_if	: INTEGER is
--	Detail_opposite	: INTEGER is
  

feature -- Modification

	set_window 		(v : INTEGER)    do  c_set_window 		(to_external, v)   	ensure      window = v    			end
	set_x 			(v : INTEGER)    do  c_set_x 			(to_external, v)   	ensure      x = v    				end
	set_y 			(v : INTEGER)    do  c_set_y 			(to_external, v)   	ensure      y = v    				end
	set_width 		(v : INTEGER)    do	c_set_width 		(to_external, v)   	ensure      width = v    			end
	set_height 		(v : INTEGER)    do  c_set_height 		(to_external, v)   	ensure      height = v    			end
	set_border_width(v : INTEGER)    do  c_set_border_width	(to_external, v)   	ensure      width = v    			end
	set_above 		(v : INTEGER)    do  c_set_above 		(to_external, v)   	ensure      above = v    			end
	set_detail		(v : INTEGER)    do  c_set_detail 		(to_external, v)   	ensure      detail = v    			end
	set_value_mask	(v : INTEGER)	do  c_set_detail 		(to_external, v) 	ensure      value_mask.is_equal (v)	end

feature { NONE } -- External functions
  
	c_window		(p: POINTER): INTEGER	external "C struct XConfigureRequestEvent access window use <X11/Xlib.h>"     	end
	c_x				(p: POINTER): INTEGER	external "C struct XConfigureRequestEvent access x use <X11/Xlib.h>"     		end
	c_y				(p: POINTER): INTEGER	external "C struct XConfigureRequestEvent access y use <X11/Xlib.h>"     		end
	c_width			(p: POINTER): INTEGER	external "C struct XConfigureRequestEvent access width use <X11/Xlib.h>"     	end
	c_height		(p: POINTER): INTEGER	external "C struct XConfigureRequestEvent access height use <X11/Xlib.h>"     	end
	c_border_width	(p: POINTER): INTEGER	external "C struct XConfigureRequestEvent access border_width use <X11/Xlib.h>" end
	c_above			(p: POINTER): INTEGER	external "C struct XConfigureRequestEvent access above use <X11/Xlib.h>"     	end
	c_detail		(p: POINTER): INTEGER	external "C struct XConfigureRequestEvent access detail use <X11/Xlib.h>"     	end
	c_value_mask	(p: POINTER): INTEGER	external "C struct XConfigureRequestEvent access value_mask use <X11/Xlib.h>"	end

	c_set_window		(p: POINTER; i: INTEGER)    external "C struct XConfigureRequestEvent access window       type Window use <X11/Xlib.h>"    		end
	c_set_x				(p: POINTER; i: INTEGER)    external "C struct XConfigureRequestEvent access x            type int use <X11/Xlib.h>"    			end
	c_set_y				(p: POINTER; i: INTEGER)    external "C struct XConfigureRequestEvent access y            type int use <X11/Xlib.h>"    			end
	c_set_width			(p: POINTER; i: INTEGER)    external "C struct XConfigureRequestEvent access width        type int use <X11/Xlib.h>"    			end
	c_set_height		(p: POINTER; i: INTEGER)    external "C struct XConfigureRequestEvent access height       type int use <X11/Xlib.h>"    			end
	c_set_border_width	(p: POINTER; i: INTEGER)    external "C struct XConfigureRequestEvent access border_width type int use <X11/Xlib.h>"  			end
	c_set_above			(p: POINTER; i: INTEGER)    external "C struct XConfigureRequestEvent access above        type Window use <X11/Xlib.h>"    		end
	c_set_detail		(p: POINTER; i: INTEGER)    external "C struct XConfigureRequestEvent access detail       type int use <X11/Xlib.h>"    			end
	c_set_value_mask	(p: POINTER; i: INTEGER)    external "C struct XConfigureRequestEvent access value_mask   type unsigned long use <X11/Xlib.h>"   end

end 
