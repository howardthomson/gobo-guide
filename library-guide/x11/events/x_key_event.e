class X_KEY_EVENT
  -- Interface to Xlib's XKeyEvent structure.
  --
  --| Stephane Hillion
  --| 1998/01/31

inherit

	X_INPUT_EVENT

	X11_EXTERNAL_ROUTINES

create

	make

creation {X_EVENT}

	from_x_struct

feature -- Consultation

	root:		INTEGER is  do      Result := c_root		(to_external)	end
	subwindow:	INTEGER is  do      Result := c_subwindow	(to_external)	end
	time:		INTEGER is  do      Result := c_time		(to_external)	end
	x:			INTEGER is  do      Result := c_x			(to_external)	end
	y:			INTEGER is  do      Result := c_y			(to_external)	end
	x_root:		INTEGER is  do      Result := c_x_root		(to_external)	end
	y_root:		INTEGER is  do      Result := c_y_root		(to_external)	end
	state:		INTEGER is	do      Result := c_state		(to_external)	end
	same_screen:BOOLEAN is	do      Result := c_same_screen	(to_external)	end
	keycode:	INTEGER is	do      Result := c_keycode		(to_external)	end

feature -- Modification

  	set_root 		(v : INTEGER) 	is do c_set_root 		(to_external, v)    end
  	set_subwindow 	(v : INTEGER) 	is do c_set_subwindow 	(to_external, v)    end
  	set_time 		(v : INTEGER) 	is do c_set_time 		(to_external, v)    end
  	set_x 			(v : INTEGER) 	is do c_set_x 			(to_external, v)    end
  	set_y 			(v : INTEGER) 	is do c_set_y 			(to_external, v)    end
  	set_x_root 		(v : INTEGER) 	is do c_set_x_root 		(to_external, v)    end
  	set_y_root 		(v : INTEGER) 	is do c_set_y_root 		(to_external, v)    end
  	set_state 		(v : INTEGER) 	is do c_set_state 		(to_external, v) 	end
	set_same_screen	(v : BOOLEAN) 	is do c_set_same_screen	(to_external, v)    end
	set_keycode		(v : INTEGER) 	is do c_set_keycode		(to_external, v)    end

feature

	lookup_string: STRING is
		local
			i: INTEGER
			is64bit: BOOLEAN
		do
			is64bit := {PLATFORM}.integer_bytes = 8
			if is64bit then
				i := XLookupString (to_external,
					buffer.area.item_address (0),
				    buffer.count,
				    $last_key_symbol_64,
				    default_pointer)
				    last_key_symbol := last_key_symbol_64.as_integer_32
			else
				i := XLookupString (to_external,
					buffer.area.item_address (0),
				    buffer.count,
				    $last_key_symbol,
				    default_pointer)
			end
    		if i >= 1 then
				Result := buffer.substring (1, i)
      		end
		ensure
    		Result /= Void implies result.count >= 1
		end

	last_key_symbol: INTEGER
			-- KeySym for a Key_event, for the 32-bit platform

	last_key_symbol_64: INTEGER_64
			-- KeySym for a Key_event, for the 64-bit platform

feature {NONE}

	buffer: STRING is
		once
			create Result.make_filled(' ', 256)
		end

feature {NONE} -- External functions

-- Access macros

	c_root			(p: POINTER): INTEGER is	external "C struct XKeyEvent access root 		use <X11/Xlib.h>"   end
	c_subwindow    	(p: POINTER): INTEGER is	external "C struct XKeyEvent access subwindow 	use <X11/Xlib.h>"   end
	c_time         	(p: POINTER): INTEGER is	external "C struct XKeyEvent access time 		use <X11/Xlib.h>"   end
	c_x            	(p: POINTER): INTEGER is	external "C struct XKeyEvent access x 			use <X11/Xlib.h>"   end
	c_y            	(p: POINTER): INTEGER is	external "C struct XKeyEvent access y 			use <X11/Xlib.h>"   end
	c_x_root       	(p: POINTER): INTEGER is	external "C struct XKeyEvent access x_root 		use <X11/Xlib.h>"   end
	c_y_root       	(p: POINTER): INTEGER is	external "C struct XKeyEvent access y_root 		use <X11/Xlib.h>"   end
	c_state			(p: POINTER): INTEGER  is	external "C struct XKeyEvent access state 		use <X11/Xlib.h>"	end
	c_keycode		(p: POINTER): INTEGER is	external "C struct XKeyEvent access keycode 	use <X11/Xlib.h>"	end
	c_same_screen	(p: POINTER): BOOLEAN is	external "C struct XKeyEvent access same_screen use <X11/Xlib.h>"	end

-- Set macros

	c_set_root			(p: POINTER; i: INTEGER) is external "C struct XKeyEvent access root        type Window 	  use <X11/Xlib.h>" end
	c_set_subwindow		(p: POINTER; i: INTEGER) is external "C struct XKeyEvent access subwindow   type Window 	  use <X11/Xlib.h>"	end
	c_set_time			(p: POINTER; i: INTEGER) is	external "C struct XKeyEvent access time        type Time   	  use <X11/Xlib.h>" end
	c_set_x				(p: POINTER; i: INTEGER) is external "C struct XKeyEvent access x           type int 		  use <X11/Xlib.h>" end
	c_set_y				(p: POINTER; i: INTEGER) is external "C struct XKeyEvent access y           type int 		  use <X11/Xlib.h>" end
	c_set_x_root		(p: POINTER; i: INTEGER) is	external "C struct XKeyEvent access x_root      type int 		  use <X11/Xlib.h>" end
	c_set_y_root		(p: POINTER; i: INTEGER) is	external "C struct XKeyEvent access y_root      type int 		  use <X11/Xlib.h>" end
	c_set_state			(p: POINTER; i: INTEGER) is external "C struct XKeyEvent access state       type unsigned int use <X11/Xlib.h>"	end
	c_set_keycode		(p: POINTER; i: INTEGER) is external "C struct XKeyEvent access keycode     type unsigned int use <X11/Xlib.h>"	end
	c_set_same_screen	(p: POINTER; i: BOOLEAN) is external "C struct XKeyEvent access same_screen type Bool         use <X11/Xlib.h>"	end

end
