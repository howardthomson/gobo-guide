class X_MOTION_EVENT
  -- Interface to Xlib's XMotionEvent structure.

inherit

	X_INPUT_EVENT

create

	make

create { X_EVENT }

	from_x_struct

feature -- Access

	root		: INTEGER    do      Result := c_root		(to_external)    end
	subwindow	: INTEGER    do      Result := c_subwindow	(to_external)    end
	x			: INTEGER    do      Result := c_x			(to_external)    end
	y			: INTEGER    do      Result := c_y			(to_external)    end
	x_root		: INTEGER    do      Result := c_x_root		(to_external)    end
	y_root		: INTEGER    do      Result := c_y_root		(to_external)    end
	time		: INTEGER    do      Result := c_time		(to_external)    end
	state		: INTEGER	do      Result := c_state		(to_external)    end
	is_hint		: INTEGER    do      Result := c_is_hint		(to_external)    end

	same_screen	: BOOLEAN
		do
			Result := c_same_screen	(to_external) /= 0
		end

feature -- is_hint values

--	Notify_normal : INTEGER is
--	Notify_hint : INTEGER is

feature -- Modification

	set_root		(v : INTEGER)    do  c_set_root			(to_external, v)    ensure then root = v    	end
	set_subwindow	(v : INTEGER)    do  c_set_subwindow		(to_external, v)    ensure then	subwindow = v   end
	set_x			(v : INTEGER)    do  c_set_x				(to_external, v)    ensure then x = v    		end
	set_y			(v : INTEGER)    do  c_set_y				(to_external, v)    ensure then y = v    		end
	set_x_root		(v : INTEGER)    do  c_set_x_root		(to_external, v)    ensure then x_root = v    	end
	set_y_root		(v : INTEGER)    do  c_set_y_root		(to_external, v)    ensure then y_root = v    	end
	set_time		(v : INTEGER)    do  c_set_time			(to_external, v)    ensure then time = v    	end
	set_state		(v : INTEGER)	do	c_set_state			(to_external, v) 	ensure then state = v 		end
	set_is_hint		(v : INTEGER)    do  c_set_is_hint 		(to_external, v)    ensure      is_hint = v 	end

	set_same_screen	(v : BOOLEAN)
		local
			i: INTEGER
		do
			if v then i := 1 else i := 0 end
			c_set_same_screen (to_external, i)
		ensure then
			same_screen = v
		end

feature {NONE} -- External functions

	c_root			(p: POINTER): INTEGER	external "C struct XMotionEvent access root use <X11/Xlib.h>"     		end
	c_subwindow		(p: POINTER): INTEGER	external "C struct XMotionEvent access subwindow use <X11/Xlib.h>"     	end
	c_x				(p: POINTER): INTEGER	external "C struct XMotionEvent access x use <X11/Xlib.h>"     			end
	c_y				(p: POINTER): INTEGER	external "C struct XMotionEvent access y use <X11/Xlib.h>"     			end
	c_x_root		(p: POINTER): INTEGER	external "C struct XMotionEvent access x_root use <X11/Xlib.h>"     	end
	c_y_root		(p: POINTER): INTEGER	external "C struct XMotionEvent access y_root use <X11/Xlib.h>"     	end
	c_time			(p: POINTER): INTEGER	external "C struct XMotionEvent access time use <X11/Xlib.h>"     		end
	c_state			(p: POINTER): INTEGER	external "C struct XMotionEvent access state use <X11/Xlib.h>"     		end
	c_is_hint		(p: POINTER): INTEGER	external "C struct XMotionEvent access is_hint use <X11/Xlib.h>"     	end
	c_same_screen	(p: POINTER): INTEGER	external "C struct XMotionEvent access same_screen use <X11/Xlib.h>"    end

	c_set_root			(p: POINTER; i: INTEGER)    external "C struct XMotionEvent access root        type Window use <X11/Xlib.h>"    	end
	c_set_subwindow		(p: POINTER; i: INTEGER)    external "C struct XMotionEvent access subwindow   type Window use <X11/Xlib.h>"   	end
	c_set_x				(p: POINTER; i: INTEGER)    external "C struct XMotionEvent access x           type int use <X11/Xlib.h>"    	end
	c_set_y				(p: POINTER; i: INTEGER)    external "C struct XMotionEvent access y           type int use <X11/Xlib.h>"    	end
	c_set_x_root		(p: POINTER; i: INTEGER)    external "C struct XMotionEvent access x_root      type int use <X11/Xlib.h>"    	end
	c_set_y_root		(p: POINTER; i: INTEGER)    external "C struct XMotionEvent access y_root      type int use <X11/Xlib.h>"    	end
	c_set_time			(p: POINTER; i: INTEGER)    external "C struct XMotionEvent access time        type Time use <X11/Xlib.h>"    	end
	c_set_state			(p: POINTER; i: INTEGER)    external "C struct XMotionEvent access state       type unsigned int use <X11/Xlib.h>" end
	c_set_is_hint		(p: POINTER; i: INTEGER)    external "C struct XMotionEvent access is_hint     type char use <X11/Xlib.h>"    	end
	c_set_same_screen	(p: POINTER; i: INTEGER)    external "C struct XMotionEvent access same_screen type Bool use <X11/Xlib.h>"    	end

end
