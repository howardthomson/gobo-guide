class X_SELECTION_EVENT
  -- Interface to Xlib's XSelectionRequestEvent structure.

inherit 

	X_ANY_EVENT
    	rename
      		window     as requestor,
      		set_window as set_requestor
    	end

creation 

	make

creation {X_EVENT}

  from_x_struct

feature -- Consultation

	selection	: X_ATOM  is do create Result.make_predefined (display,	c_selection (to_external))    end  
	target		: X_ATOM  is do create Result.make_predefined (display,	c_target	(to_external))    end  
	property 	: X_ATOM  is do create Result.make_predefined (display,	c_property	(to_external))    end  
	time 		: INTEGER is do Result := c_time (to_external)    end  

feature -- Modification

	set_selection(v: X_ATOM)  is do c_set_selection (to_external, v.id)	ensure selection.id = v.id  end
	set_target	 (v: X_ATOM)  is do c_set_target	(to_external, v.id)	ensure selection.id = v.id  end
	set_property (v: X_ATOM)  is do c_set_property	(to_external, v.id)	ensure selection.id = v.id  end
	set_time	 (v: INTEGER) is do c_set_time		(to_external, v)	ensure time = v				end  

feature {NONE} -- External functions

	c_selection		(p: POINTER): INTEGER is	external "C struct XSelectionEvent access selection use <X11/Xlib.h>"     	end
	c_target		(p: POINTER): INTEGER is	external "C struct XSelectionEvent access target use <X11/Xlib.h>"     		end
	c_property		(p: POINTER): INTEGER is	external "C struct XSelectionEvent access property use <X11/Xlib.h>"     	end
	c_time			(p: POINTER): INTEGER is	external "C struct XSelectionEvent access time use <X11/Xlib.h>"     		end

	c_set_selection	(p: POINTER; i: INTEGER) is    external "C struct XSelectionEvent access selection type Atom use <X11/Xlib.h>"   end
	c_set_target	(p: POINTER; i: INTEGER) is    external "C struct XSelectionEvent access target    type Atom use <X11/Xlib.h>"   end
	c_set_property	(p: POINTER; i: INTEGER) is    external "C struct XSelectionEvent access property  type Atom use <X11/Xlib.h>"   end
	c_set_time		(p: POINTER; i: INTEGER) is    external "C struct XSelectionEvent access time      type Time use <X11/Xlib.h>"   end

end 
