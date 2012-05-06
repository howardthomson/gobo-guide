note

	description: "X11 C struct Visual"

	author: "Howard Thomson"
	copyright: "Copyright (c) 2006, Howard Thomson"
	license: "Eiffel Forum License v2 (see forum.txt)"
	origin: "Class name from Stephane Hillion's Xlib package"

class X_VISUAL

inherit

	X_STRUCT

create { X_DISPLAY, X_WINDOW_ATTRIBUTES, XPM_ATTRIBUTES }

  from_x_struct,
  from_external

feature

	visual_id	: INTEGER do Result := c_visual_id	 (to_external) end
	visual_class: INTEGER do Result := c_visual_class (to_external) end
	red_mask	: INTEGER do Result := c_red_mask	 (to_external) end
	green_mask	: INTEGER do Result := c_green_mask	 (to_external) end
	blue_mask	: INTEGER do Result := c_blue_mask	 (to_external) end
	bits_per_rgb: INTEGER do Result := c_bits_per_rgb (to_external) end
	map_entries	: INTEGER do Result := c_map_entries	 (to_external) end

feature { NONE } -- Implementation

	c_visual_id	   (p: POINTER): INTEGER external "C struct Visual access visualid		use <X11/Xlib.h>" end
	c_visual_class (p: POINTER): INTEGER external "C struct Visual access class			use <X11/Xlib.h>" end
	c_red_mask	   (p: POINTER): INTEGER external "C struct Visual access red_mask		use <X11/Xlib.h>" end
	c_green_mask   (p: POINTER): INTEGER external "C struct Visual access green_mask	    use <X11/Xlib.h>" end
	c_blue_mask	   (p: POINTER): INTEGER external "C struct Visual access blue_mask		use <X11/Xlib.h>" end
	c_bits_per_rgb (p: POINTER): INTEGER external "C struct Visual access bits_per_rgb	use <X11/Xlib.h>" end
	c_map_entries  (p: POINTER): INTEGER external "C struct Visual access map_entries	use <X11/Xlib.h>" end

feature { NONE }

	size: INTEGER
		external
			"C inline use <X11/Xlib.h>"
		alias
			"sizeof(Visual)"
		end

end
