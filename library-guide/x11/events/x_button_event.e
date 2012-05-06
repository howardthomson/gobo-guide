class X_BUTTON_EVENT
  -- Interface to Xlib's XButtonEvent structure.
  --
  --| Stephane Hillion
  --| 1998/01/31

inherit

  X_INPUT_EVENT

create

  make

create {X_EVENT}

  from_x_struct

feature -- Consultation

	root		: INTEGER do Result := c_root			(to_external)   end -- id of the root window that the event occurred on
	subwindow	: INTEGER do Result := c_subwindow		(to_external)   end -- child window
	x			: INTEGER do Result := c_x				(to_external)   end -- pointer x coordinate in event window
	y			: INTEGER do Result := c_y				(to_external)   end -- pointer y coordinate in event window
	x_root		: INTEGER do Result := c_x_root		(to_external)   end -- coordinate relative to root
	y_root		: INTEGER do Result := c_y_root		(to_external)   end -- coordinate relative to root
	button		: INTEGER do Result := c_button		(to_external)   end	-- The button : 1, 2, 3, ...
  	time		: INTEGER do Result := c_time			(to_external)   end	-- Time in milliseconds
  	state		: INTEGER do Result := c_state			(to_external) 	end
	same_screen	: BOOLEAN do Result := c_same_screen	(to_external)   end

feature -- Modification

	set_root		(v : INTEGER) do c_set_root		(to_external, v)					end
	set_subwindow	(v : INTEGER) do c_set_subwindow	(to_external, v)					end
	set_x			(v : INTEGER) do c_set_x			(to_external, v)					end
	set_y			(v : INTEGER) do c_set_y			(to_external, v)					end
	set_x_root		(v : INTEGER) do c_set_x_root		(to_external, v)    				end
	set_y_root		(v : INTEGER) do c_set_y_root		(to_external, v)    				end
	set_button		(v : INTEGER) do c_set_button		(to_external, v) ensure button = v	end
	set_time		(v : INTEGER) do c_set_time		(to_external, v)					end
	set_state		(v : INTEGER) do c_set_state		(to_external, v)    				end
	set_same_screen	(v : BOOLEAN) do c_set_same_screen	(to_external, v)					end

feature {NONE} -- External functions

	c_root			(p: POINTER): INTEGER	external "C struct XButtonEvent access root use <X11/Xlib.h>"     		end
	c_subwindow    	(p: POINTER): INTEGER	external "C struct XButtonEvent access subwindow use <X11/Xlib.h>"     	end
	c_time         	(p: POINTER): INTEGER	external "C struct XButtonEvent access time use <X11/Xlib.h>"     		end
	c_x            	(p: POINTER): INTEGER	external "C struct XButtonEvent access x use <X11/Xlib.h>"     			end
	c_y            	(p: POINTER): INTEGER	external "C struct XButtonEvent access y use <X11/Xlib.h>"     			end
	c_x_root       	(p: POINTER): INTEGER	external "C struct XButtonEvent access x_root use <X11/Xlib.h>"     	end
	c_y_root       	(p: POINTER): INTEGER	external "C struct XButtonEvent access y_root use <X11/Xlib.h>"     	end
	c_state			(p: POINTER): INTEGER	external "C struct XButtonEvent access state use <X11/Xlib.h>"			end
	c_button       	(p: POINTER): INTEGER	external "C struct XButtonEvent access button use <X11/Xlib.h>"     	end
	c_same_screen	(p: POINTER): BOOLEAN	external "C struct XButtonEvent access same_screen use <X11/Xlib.h>"	end


	c_set_root			(p: POINTER; i: INTEGER)    external "C struct XButtonEvent access root type Window use <X11/Xlib.h>"    	end
	c_set_subwindow		(p: POINTER; i: INTEGER)    external "C struct XButtonEvent access subwindow type Window use <X11/Xlib.h>"   end
	c_set_time			(p: POINTER; i: INTEGER)    external "C struct XButtonEvent access time type Time use <X11/Xlib.h>"    		end
	c_set_x				(p: POINTER; i: INTEGER)    external "C struct XButtonEvent access x type int use <X11/Xlib.h>"    			end
	c_set_y				(p: POINTER; i: INTEGER)    external "C struct XButtonEvent access y type int use <X11/Xlib.h>"    			end
	c_set_x_root		(p: POINTER; i: INTEGER)    external "C struct XButtonEvent access x_root type int use <X11/Xlib.h>"    		end
	c_set_y_root		(p: POINTER; i: INTEGER)    external "C struct XButtonEvent access y_root type int use <X11/Xlib.h>"    		end
	c_set_state			(p: POINTER; i: INTEGER)    external "C struct XButtonEvent access state type unsigned int use <X11/Xlib.h>"	end
	c_set_button		(p: POINTER; i: INTEGER)    external "C struct XButtonEvent access button type unsigned int use <X11/Xlib.h>"end
	c_set_same_screen	(p: POINTER; i: BOOLEAN)    external "C struct XButtonEvent access same_screen type Bool use <X11/Xlib.h>"	end

end
