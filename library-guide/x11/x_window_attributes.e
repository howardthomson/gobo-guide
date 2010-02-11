class X_WINDOW_ATTRIBUTES
  -- Interface to Xlib's XWindowAttributes
  --
  --| Stephane Hillion
  --| 1998/01/28
  --|

inherit 

	X_STRUCT
	X_WINDOW_CONSTANTS

creation { X_WINDOW }

	make

feature -- Access

	x			: INTEGER is do Result := c_x			(to_external) end
	y			: INTEGER is do Result := c_y			(to_external) end
	width		: INTEGER is do Result := c_width		(to_external) end
	height		: INTEGER is do Result := c_height		(to_external) end
	border_width: INTEGER is do Result := c_border_width(to_external) end
	depth		: INTEGER is do Result := c_depth		(to_external) end

	visual : X_VISUAL is
		do
      		create Result.from_external (c_visual (to_external))
		end

	root					: INTEGER is do Result := c_root					(to_external) end
	window_class			: INTEGER is do Result := c_window_class			(to_external) end
	bit_gravity 			: INTEGER is do Result := c_bit_gravity				(to_external) end
	win_gravity 			: INTEGER is do Result := c_win_gravity				(to_external) end
	backing_store			: INTEGER is do Result := c_backing_store 			(to_external) end
	backing_planes			: INTEGER is do Result := c_backing_planes			(to_external) end
	backing_pixel			: INTEGER is do Result := c_backing_pixel 			(to_external) end
	save_under				: BOOLEAN is do Result := c_save_under				(to_external) end
	colormap				: INTEGER is do Result := c_colormap				(to_external) end
	map_installed			: BOOLEAN is do Result := c_map_installed 			(to_external) end
	map_state				: INTEGER is do Result := c_map_state				(to_external) end
	all_event_masks 		: INTEGER is do Result := c_all_event_masks			(to_external) end
	your_event_mask 		: INTEGER is do Result := c_your_event_mask			(to_external) end
	do_not_propagate_mask	: INTEGER is do Result := c_do_not_propagate_mask 	(to_external) end
	override_redirect		: BOOLEAN is do Result := c_override_redirect 		(to_external) end
--	screen					: POINTER is do Result := c_screen					(to_external) end

feature

	size: INTEGER is
		external
			"C macro use <X11/Xlib.h>"
		alias
			"sizeof (XWindowAttributes)"
		end

feature { NONE } -- Implementation

	c_x						(p: POINTER): INTEGER is do end
	c_y						(p: POINTER): INTEGER is do end
	c_width					(p: POINTER): INTEGER is do end
	c_height				(p: POINTER): INTEGER is do end
	c_border_width			(p: POINTER): INTEGER is do end
	c_depth					(p: POINTER): INTEGER is do end
	c_visual				(p: POINTER): POINTER is do end
	c_root					(p: POINTER): INTEGER is do end
	c_window_class			(p: POINTER): INTEGER is do end
	c_bit_gravity			(p: POINTER): INTEGER is do end
	c_win_gravity			(p: POINTER): INTEGER is do end
	c_backing_store			(p: POINTER): INTEGER is do end
	c_backing_planes		(p: POINTER): INTEGER is do end
	c_backing_pixel			(p: POINTER): INTEGER is do end
	c_save_under			(p: POINTER): BOOLEAN is do end
	c_colormap				(p: POINTER): INTEGER is do end
	c_map_installed			(p: POINTER): BOOLEAN is do end
	c_map_state				(p: POINTER): INTEGER is do end
	c_all_event_masks		(p: POINTER): INTEGER  is do end
	c_your_event_mask		(p: POINTER): INTEGER  is do end
	c_do_not_propagate_mask	(p: POINTER): INTEGER  is do end
	c_override_redirect		(p: POINTER): BOOLEAN is do end
	c_screen				(p: POINTER): POINTER is do end
end 
