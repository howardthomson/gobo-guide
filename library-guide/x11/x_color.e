note

	description: "C Structure -- Xlib XColor"

	author: "Stephane Hillion"
	copyright: "Copyright (c) 1998-2006, Stephane Hillion and Howard Thomson"
	license: "GNU Public License (see COPYING)"

	C_structure: "[
		typedef struct {
			unsigned long pixel;
			unsigned short red, green, blue;
			char flags;
			char pad;
		} XColor;
	]"

	todo: "[
		Fix flags/set_flags for SE/ISE
	]"

class X_COLOR

inherit 

	X11_EXTERNAL_ROUTINES
	
create

	make

feature -- Attributes

--	area: SPECIAL [ CHARACTER ]

	area: MANAGED_POINTER

	to_external: POINTER

feature -- Creation

	make
		do
			create area.make(12)
--			to_external := area.base_address
			to_external := area.item
		end

feature -- Access

	pixel	: INTEGER do Result := c_pixel	(to_external) end
	red		: INTEGER do Result := c_red		(to_external) end
	green	: INTEGER do Result := c_green	(to_external) end
	blue	: INTEGER do Result := c_blue	(to_external) end
	flags	: INTEGER do	Result := c_flags	(to_external) end

feature -- flags

  	Do_red	: INTEGER_8 =	1	-- (1 << 0)
  	Do_green: INTEGER_8 = 	2	-- (1 << 1)
  	Do_blue	: INTEGER_8 = 	4	-- (1 << 2)

feature -- Modification

	set_pixel(pix: INTEGER) do c_put_pixel	(to_external, pix) end
	set_red	 (r: INTEGER) do c_put_red		(to_external, r) end
	set_green(g: INTEGER) do c_put_green	(to_external, g) end
	set_blue (b: INTEGER) do c_put_flags	(to_external, b) end
	set_flags(f: INTEGER_8) do c_put_flags	(to_external, f) end

feature -- X routine calls

	query_default_color(d: X_DISPLAY)
		do
--			report_not_implemented
			XQueryColors(d.to_external, d.default_colormap(0).id, to_external, 1)
		end

	report_not_implemented
		once
			fx_trace(0, <<"X_COLOR::query_default_color - not implemented ?">>)
		end

feature -- C struct accesses

--	c_pixel	(p: POINTER): INTEGER is external "C struct XColor get pixel use <X11/Xlib.h>" end
--	c_red	(p: POINTER): INTEGER is external "C struct XColor get red	 use <X11/Xlib.h>" end
--	c_green	(p: POINTER): INTEGER is external "C struct XColor get green use <X11/Xlib.h>" end
--	c_blue	(p: POINTER): INTEGER is external "C struct XColor get blue	 use <X11/Xlib.h>" end
--	c_flags	(p: POINTER): INTEGER is external "C struct XColor get flags use <X11/Xlib.h>" end

--	c_put_pixel	(p: POINTER; i: INTEGER) is external "C struct XColor set pixel use <X11/Xlib.h>" end
--	c_put_red	(p: POINTER; i: INTEGER) is external "C struct XColor set red	use <X11/Xlib.h>" end
--	c_put_green	(p: POINTER; i: INTEGER) is external "C struct XColor set green use <X11/Xlib.h>" end
--	c_put_blue	(p: POINTER; i: INTEGER) is external "C struct XColor set blue	use <X11/Xlib.h>" end
--	c_put_flags	(p: POINTER; i: INTEGER) is external "C struct XColor set flags use <X11/Xlib.h>" end
	
feature -- C struct accesses

	c_pixel	(p: POINTER): INTEGER external "C struct XColor access pixel  use <X11/Xlib.h>" end
	c_red	(p: POINTER): INTEGER external "C struct XColor access red	 use <X11/Xlib.h>" end
	c_green	(p: POINTER): INTEGER external "C struct XColor access green  use <X11/Xlib.h>" end
	c_blue	(p: POINTER): INTEGER external "C struct XColor access blue	 use <X11/Xlib.h>" end
	c_flags	(p: POINTER): INTEGER external "C struct XColor access flags  use <X11/Xlib.h>" end

	c_put_pixel	(p: POINTER; i: INTEGER) external "C struct XColor access pixel  use <X11/Xlib.h>" end
	c_put_red	(p: POINTER; i: INTEGER) external "C struct XColor access red	use <X11/Xlib.h>" end
	c_put_green	(p: POINTER; i: INTEGER) external "C struct XColor access green  use <X11/Xlib.h>" end
	c_put_blue	(p: POINTER; i: INTEGER) external "C struct XColor access blue	use <X11/Xlib.h>" end
	c_put_flags	(p: POINTER; i: INTEGER) external "C struct XColor access flags  use <X11/Xlib.h>" end
	
	XQueryColors(d: POINTER; c: INTEGER; t: POINTER; n: INTEGER)
		external "C use <X11/Xlib.h>"
		alias "XQueryColors"
		end
end 
