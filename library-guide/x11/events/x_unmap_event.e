class X_UNMAP_EVENT
  -- Interface to Xlib's XUnmapEvent structure.
  --
  --| Stephane Hillion
  --| 1998/02/01
  --|


inherit 

	X_ANY_EVENT
		rename
			window     as event,
			set_window as set_event
		end

creation 

	make

creation { X_EVENT }

	from_x_struct

feature -- Consultation

	window : INTEGER is
		do
	--		Result := x_unmap_event_window (to_external)
		end

	from_configure : BOOLEAN is
		do
	--		Result := x_unmap_event_from_configure (to_external)
		end  

feature -- Modification

	set_window (v : INTEGER) is
    	do
    --		c_set_window (to_external, v)
    	end

  	set_from_configure (v : BOOLEAN) is
    	do
    --		c_set_from_configure (to_external, v)
    	end

feature { NONE } -- External functions

invariant
	implemented: false
end 
