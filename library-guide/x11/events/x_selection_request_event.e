class X_SELECTION_REQUEST_EVENT
  -- Interface to Xlib's XSelectionRequestEvent structure.

inherit 

	X_ANY_EVENT
    	rename
      		window     as owner,
      		set_window as set_owner
    	end

create 

	make

create { X_EVENT }

	from_x_struct

feature -- Access

  requestor : INTEGER    do      Result := 							c_requestor (to_external)	end
  selection : X_ATOM    do       create Result.make_predefined (display,	c_selection (to_external))	end  
  target	: X_ATOM    do       create Result.make_predefined (display,	c_target	(to_external))	end  
  property	: X_ATOM    do       create Result.make_predefined (display,	c_property	(to_external))	end  
  time		: INTEGER    do      Result := 							c_time		(to_external)	end  

feature -- Modification

  set_requestor (v : INTEGER)	do	c_set_requestor (to_external, v)    ensure      requestor = v    		end
  set_selection (v : X_ATOM)	do	c_set_selection (to_external, v.id)	ensure      selection.id = v.id    	end
  set_target	(v : X_ATOM)	do	c_set_target	(to_external, v.id) ensure      selection.id = v.id    	end
  set_property	(v : X_ATOM)	do	c_set_property	(to_external, v.id) ensure      selection.id = v.id    	end
  set_time		(v : INTEGER)	do	c_set_time		(to_external, v)    ensure      time = v    			end  

feature { NONE } -- External functions

	c_requestor		(p: POINTER): INTEGER	external "C struct XSelectionRequestEvent access requestor use <X11/Xlib.h>"     		end
	c_selection		(p: POINTER): INTEGER	external "C struct XSelectionRequestEvent access selection use <X11/Xlib.h>"     		end
	c_target		(p: POINTER): INTEGER	external "C struct XSelectionRequestEvent access target use <X11/Xlib.h>"     		end
	c_property		(p: POINTER): INTEGER	external "C struct XSelectionRequestEvent access property use <X11/Xlib.h>"     		end
	c_time		(p: POINTER): INTEGER	external "C struct XSelectionRequestEvent access time use <X11/Xlib.h>"     		end
	
	c_set_requestor	(p: POINTER; i: INTEGER)    external "C struct XSelectionRequestEvent access requestor type Window use <X11/Xlib.h>"    	end
	c_set_selection	(p: POINTER; i: INTEGER)    external "C struct XSelectionRequestEvent access selection type Atom use <X11/Xlib.h>"    	end
	c_set_target	(p: POINTER; i: INTEGER)    external "C struct XSelectionRequestEvent access target type Atom use <X11/Xlib.h>"    	end
	c_set_property	(p: POINTER; i: INTEGER)    external "C struct XSelectionRequestEvent access property type Atom use <X11/Xlib.h>"    	end
	c_set_time	(p: POINTER; i: INTEGER)    external "C struct XSelectionRequestEvent access time type Time use <X11/Xlib.h>"    	end


end 
