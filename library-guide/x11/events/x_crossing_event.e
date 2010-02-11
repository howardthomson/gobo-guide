class X_CROSSING_EVENT
  -- Interface to Xlib's XCrossingEvent structure.
  --
  --| Stephane Hillion
  --| 1998/01/31

inherit 

  X_INPUT_EVENT

creation 

  make

creation {X_EVENT}

  from_x_struct

feature -- Consultation

	root		: INTEGER is    do  Result := c_root		(to_external)    	end
	subwindow	: INTEGER is    do  Result := c_subwindow	(to_external)    	end
	x			: INTEGER is    do  Result := c_x			(to_external)    	end
	y			: INTEGER is    do  Result := c_y			(to_external)    	end
	x_root		: INTEGER is    do  Result := c_x_root		(to_external)    	end
	y_root		: INTEGER is    do	Result := c_y_root		(to_external)    	end
	mode		: INTEGER is    do  Result := c_mode		(to_external)    	end
	detail		: INTEGER is    do  Result := c_detail		(to_external)    	end
	focus		: BOOLEAN is    do  Result := c_focus		(to_external) /= 0 	end
	time		: INTEGER is	do  Result := c_time		(to_external)		end
	state		: INTEGER is	do  Result := c_state		(to_external) 		end
	same_screen	: BOOLEAN is	do  Result := c_same_screen	(to_external) /= 0  end

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

feature -- Modification

	set_root		(v : INTEGER) is    		do	c_set_root			(to_external, v)    		ensure then root = v    		end
	set_subwindow	(v : INTEGER) is    		do  c_set_subwindow		(to_external, v)    		ensure then subwindow = v    	end
	set_x			(v : INTEGER) is    		do  c_set_x				(to_external, v)    		ensure then x = v    			end
	set_y			(v : INTEGER) is    		do  c_set_y				(to_external, v)    		ensure then y = v    			end
	set_x_root		(v : INTEGER) is    		do  c_set_x_root		(to_external, v)    		ensure then x_root = v    		end
	set_y_root		(v : INTEGER) is    		do  c_set_y_root		(to_external, v)    		ensure then y_root = v    		end
	set_mode		(v : INTEGER) is    		do  c_set_mode			(to_external, v)    		ensure  mode = v    		end
	set_detail		(v : INTEGER) is    		do  c_set_detail		(to_external, v)    		ensure  detail = v    		end

	set_focus (v : BOOLEAN) is
		local
			i: INTEGER
		do
			if v then i := 1 else i := 0 end
			c_set_focus (to_external, i)
		ensure
			focus = v
		end

	set_time		(v : INTEGER) is    do  c_set_time			(to_external, v)    ensure then time = v 	end
	set_state		(v : INTEGER) is	do  c_set_state			(to_external, v)	ensure then state = v	end

	set_same_screen	(v : BOOLEAN) is
		local
			i: INTEGER
		do
			if v then i := 1 else i := 0 end
			c_set_same_screen (to_external, i)
		ensure then
			same_screen = v
		end

feature {NONE} -- External functions

	c_root			(p: POINTER): INTEGER is	external "C struct XButtonEvent access root			 use <X11/Xlib.h>" end
	c_subwindow		(p: POINTER): INTEGER is	external "C struct XButtonEvent access subwindow	 use <X11/Xlib.h>" end
	c_time			(p: POINTER): INTEGER is	external "C struct XCrossingEvent access time		 use <X11/Xlib.h>" end
	c_x				(p: POINTER): INTEGER is	external "C struct XCrossingEvent access x		 	 use <X11/Xlib.h>" end
	c_y				(p: POINTER): INTEGER is	external "C struct XCrossingEvent access y			 use <X11/Xlib.h>" end
	c_x_root		(p: POINTER): INTEGER is	external "C struct XCrossingEvent access x_root		 use <X11/Xlib.h>" end
	c_y_root		(p: POINTER): INTEGER is	external "C struct XCrossingEvent access y_root		 use <X11/Xlib.h>" end
	c_mode			(p: POINTER): INTEGER is	external "C struct XCrossingEvent access mode		 use <X11/Xlib.h>" end
	c_detail		(p: POINTER): INTEGER is	external "C struct XCrossingEvent access detail		 use <X11/Xlib.h>" end
	c_same_screen	(p: POINTER): INTEGER is	external "C struct XCrossingEvent access same_screen use <X11/Xlib.h>" end
	c_focus			(p: POINTER): INTEGER is	external "C struct XCrossingEvent access focus		 use <X11/Xlib.h>" end
	c_state			(p: POINTER): INTEGER is	external "C struct XCrossingEvent access state		 use <X11/Xlib.h>" end
	
	c_set_root		(p: POINTER; i: INTEGER) is    external "C struct XCrossingEvent access root		 type Window use <X11/Xlib.h>" end
	c_set_subwindow	(p: POINTER; i: INTEGER) is    external "C struct XCrossingEvent access subwindow	 type Window use <X11/Xlib.h>" end
	c_set_time		(p: POINTER; i: INTEGER) is    external "C struct XCrossingEvent access time		 type Time use <X11/Xlib.h>" end
	c_set_x			(p: POINTER; i: INTEGER) is    external "C struct XCrossingEvent access x			 type int use <X11/Xlib.h>" end
	c_set_y			(p: POINTER; i: INTEGER) is    external "C struct XCrossingEvent access y			 type int use <X11/Xlib.h>" end
	c_set_x_root	(p: POINTER; i: INTEGER) is    external "C struct XCrossingEvent access x_root		 type int use <X11/Xlib.h>" end
	c_set_y_root	(p: POINTER; i: INTEGER) is    external "C struct XCrossingEvent access y_root		 type int use <X11/Xlib.h>" end
	c_set_mode		(p: POINTER; i: INTEGER) is    external "C struct XCrossingEvent access mode		 type int use <X11/Xlib.h>" end
	c_set_detail	(p: POINTER; i: INTEGER) is    external "C struct XCrossingEvent access detail		 type int use <X11/Xlib.h>" end
	c_set_same_screen(p: POINTER; i: INTEGER) is    external "C struct XCrossingEvent access same_screen type Bool use <X11/Xlib.h>" end
	c_set_focus		(p: POINTER; i: INTEGER) is    external "C struct XCrossingEvent access focus		 type Bool use <X11/Xlib.h>" end
	c_set_state		(p: POINTER; i: INTEGER) is    external "C struct XCrossingEvent access state		 type unsigned int use <X11/Xlib.h>" end


end 
