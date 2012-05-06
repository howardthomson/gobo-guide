class SB_WAPI_LOGBRUSH

inherit

   SB_WAPI_STRUCT

create

   make

feature
   
	external_size: INTEGER 
		external
			"C macro use <windows.h>"	-- TODO header file ?
		alias
			"sizeof(LOGBRUSH)"
		end

feature {ANY} -- setters

   set_style (a_style: INTEGER)
		do
			c_set_style (ptr, a_style)
		ensure
			value_set: style = a_style
		end

	set_color (a_color: INTEGER)
		do
			c_set_color (ptr, a_color)
		ensure
			value_set: color = a_color
		end

   set_hatch (a_hatch: INTEGER)
		do
			c_set_hatch (ptr, a_hatch)
		ensure
			value_set: hatch = a_hatch
		end

   set_hatch_pointer (a_hatch: POINTER)
		do
			c_set_hatch_pointer (ptr, a_hatch)
		ensure
			value_set: hatch = a_hatch
		end

feature {ANY} -- getters

	style: INTEGER
		do
			Result := c_style (ptr)
		end

	color: INTEGER
		do
			Result := c_color (ptr)
		end

   hatch: INTEGER
		do
			Result := c_hatch (ptr)
		end

feature {NONE} -- Implementation

	c_style		(p: POINTER): INTEGER    external "C struct LOGBRUSH access lbStyle use <wingdi.h>" end
	c_color		(p: POINTER): INTEGER    external "C struct LOGBRUSH access lbColor use <wingdi.h>" end
	c_hatch		(p: POINTER): INTEGER    external "C struct LOGBRUSH access lbHatch use <wingdi.h>" end

	c_set_style	(p: POINTER; i: INTEGER)    external "C struct LOGBRUSH access lbStyle type int use <wingdi.h>" end
	c_set_color	(p: POINTER; i: INTEGER)    external "C struct LOGBRUSH access lbColor type int use <wingdi.h>" end
	c_set_hatch	(p: POINTER; i: INTEGER)    external "C struct LOGBRUSH access lbHatch type int use <wingdi.h>" end
	
	c_set_hatch_pointer	(p: POINTER; i: POINTER)    external "C struct LOGBRUSH access lbHatch type int use <wingdi.h>" end


invariant

	ptr /= default_pointer

end

