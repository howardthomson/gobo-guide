class SB_WAPI_TEXTMETRIC

inherit 

   SB_WAPI_STRUCT

create

   make, from_external

feature
   
	external_size: INTEGER 
		external
			"C macro use <windows.h>"	-- use ??
		alias
			"sizeof(TEXTMETRIC)"
		end

feature -- Access

	tmHeight: INTEGER
		do
			Result := c_Height (ptr)
		end

	tmAscent: INTEGER
		do
			Result := c_Ascent (ptr)
		end

	tmDescent: INTEGER
		do
			Result := c_Descent (ptr)
		end -- tmDescent

	tmInternalLeading: INTEGER
		do
			Result := c_InternalLeading (ptr)
		end

	tmExternalLeading: INTEGER
		do
			Result := c_ExternalLeading (ptr)
		end

	tmAveCharWidth: INTEGER
		do
			Result := c_AveCharWidth (ptr)
		end

	tmMaxCharWidth: INTEGER
		do
			Result := c_MaxCharWidth (ptr)
		end

	tmWeight: INTEGER
		do
			Result := c_Weight (ptr)
		end

	tmOverhang: INTEGER
		do
			Result := c_Overhang (ptr)
		end

	tmDigitizedAspectX: INTEGER
		do
			Result := c_DigitizedAspectX (ptr)
		end

	tmDigitizedAspectY: INTEGER
		do
			Result := c_DigitizedAspectY (ptr)
		end

	tmFirstChar: CHARACTER
		do
			Result := c_FirstChar (ptr)
		end

	tmLastChar: CHARACTER
		do
			Result := c_LastChar (ptr)
		end

	tmDefaultChar: CHARACTER
		do
			Result := c_DefaultChar (ptr)
		end

	tmBreakChar: CHARACTER
		do
			Result := c_BreakChar (ptr)
		end

	tmItalic: INTEGER
		do
			Result := c_Italic (ptr)
		end

	tmUnderlined: INTEGER
		do
			Result := c_Underlined (ptr)
		end

	tmStruckOut: INTEGER
		do
			Result := c_StruckOut (ptr)
		end

	tmPitchAndFamily: INTEGER
		do
			Result := c_PitchAndFamily (ptr)
		end

	tmCharSet: INTEGER
		do
			Result := c_CharSet (ptr)
		end

feature -- Update

	set_tmHeight (a_height: INTEGER)
		do
			c_set_Height (ptr, a_height)
		ensure
			value_set: tmHeight = a_height
		end -- set_tmHeight

	set_tmAscent (an_ascent: INTEGER)
		do
			c_set_Ascent (ptr, XXX)
		ensure
			value_set: tmAscent = a_var
		end -- set_tmAscent

	set_tmDescent (a_descent: INTEGER)
		do
			c_set_Descent (ptr, a_descent)
		ensure
			value_set: tmDescent = a_descent
		end -- set_tmDescent

	set_tmInternalLeading (an_internal_leading: INTEGER)
		do
			c_set_InternalLeading (ptr, an_internal_leading)
		ensure
			value_set: tmInternalLeading = an_internal_leading
		end -- set_tmInternalLeading

	set_tmExternalLeading (an_external_leading: INTEGER)
		do
			c_set_ExternalLeading (ptr, an_external_leading)
		ensure
			value_set: tmExternalLeading = an_external_leading
		end -- set_tmExternalLeading

	set_tmAveCharWidth (an_ave_char_width: INTEGER)
		do
			c_set_AveCharWidth (ptr, an_ave_char_width)
		ensure
			value_set: tmAveCharWidth = an_ave_char_width
		end -- set_tmAveCharWidth

	set_tmMaxCharWidth (a_max_char_width: INTEGER)
		do
			c_set_MaxCharWidth (ptr, a_max_char_width)
		ensure
			value_set: tmMaxCharWidth = a_max_char_width
		end -- set_tmMaxCharWidth

	set_tmWeight (a_weight: INTEGER)
		do
			c_set_Weight (ptr, a_weight)
		ensure
			value_set: tmWeight = a_weight
		end -- set_tmWeight

	set_tmOverhang (an_overhang: INTEGER)
		do
			c_set_Overhang (ptr, an_overhang)
		ensure
			value_set: tmOverhang = an_overhang
		end -- set_tmOverhang

	set_tmDigitizedAspectX (a_digitized_aspect_x: INTEGER)
		do
			c_set_DigitizedAspectX (ptr, a_digitized_aspect_x)
		ensure
			value_set: tmDigitizedAspectX = a_digitized_aspect_x
		end -- set_tmDigitizedAspectX

	set_tmDigitizedAspectY (a_digitized_aspect_y: INTEGER)
		do
			c_set_DigitizedAspectY (ptr, a_digitized_aspect_y)
		ensure
			value_set: tmDigitizedAspectY = a_digitized_aspect_y
		end -- set_tmDigitizedAspectY

	set_tmFirstChar (a_first_char: CHARACTER)
		do
			c_set_FirstChar (ptr, a_first_char)
		ensure
			value_set: tmFirstChar = a_first_char
		end -- set_tmFirstChar

	set_tmLastChar (a_last_char: CHARACTER)
		do
			c_set_LastChar (ptr, a_last_char)
		ensure
			value_set: tmLastChar = a_last_char
		end -- set_tmLastChar

	set_tmDefaultChar (a_default_char: CHARACTER)
		do
			c_set_DefaultChar (ptr, a_default_char)
		ensure
			value_set: tmDefaultChar = a_default_char
		end -- set_tmDefaultChar

	set_tmBreakChar (a_break_char: CHARACTER)
		do
			c_set_BreakChar (ptr, a_break_char)
		ensure
			value_set: tmBreakChar = a_break_char
		end -- set_tmBreakChar

	set_tmItalic (a_italic: INTEGER)
		do
			c_set_Italic (ptr, a_italic)
		ensure
			value_set: tmItalic = a_italic
		end -- set_tmItalic

	set_tmUnderlined (a_underlined: INTEGER)
		do
			c_set_Underlined (ptr, a_underlined)
		ensure
			value_set: tmUnderlined = a_underlined
		end -- set_tmUnderlined

	set_tmStruckOut (a_struck_out: INTEGER)
		do
			c_set_StruckOut (ptr, a_struck_out)
		ensure
			value_set: tmStruckOut = a_struck_out
		end -- set_tmStruckOut

	set_tmPitchAndFamily (a_pitch_and_family: INTEGER)
		do
			c_set_PitchAndFamily (ptr, a_pitch_and_family)
		ensure
			value_set: tmPitchAndFamily = a_pitch_and_family
		end -- set_tmPitchAndFamily

	set_tmCharSet (a_char_set: INTEGER)
		do
			c_set_CharSet (ptr, a_char_set)
		ensure
			value_set: tmCharSet = a_char_set
		end -- set_tmCharSet

feature {NONE} -- Implementation

	c_Height				(p: POINTER): INTEGER    external "C struct TEXTMETRIC access tmHeight       		use <windows.h>" end
	c_Ascent				(p: POINTER): INTEGER    external "C struct TEXTMETRIC access tmAscent       		use <windows.h>" end
	c_Descent				(p: POINTER): INTEGER    external "C struct TEXTMETRIC access tmDescent       		use <windows.h>" end
	c_InternalLeading		(p: POINTER): INTEGER    external "C struct TEXTMETRIC access tmInternalLeading      use <windows.h>" end
	c_ExternalLeading		(p: POINTER): INTEGER    external "C struct TEXTMETRIC access tmExternalLeading      use <windows.h>" end
	c_AveCharWidth			(p: POINTER): INTEGER    external "C struct TEXTMETRIC access tmAveCharWidth       	use <windows.h>" end
	c_MaxCharWidth			(p: POINTER): INTEGER    external "C struct TEXTMETRIC access tmMaxCharWidth       	use <windows.h>" end
	c_Weight				(p: POINTER): INTEGER    external "C struct TEXTMETRIC access tmWeight       		use <windows.h>" end
	c_Overhang				(p: POINTER): INTEGER    external "C struct TEXTMETRIC access tmOverhang       		use <windows.h>" end
	c_DigitizedAspectX		(p: POINTER): INTEGER    external "C struct TEXTMETRIC access tmDigitizedAspectX     use <windows.h>" end
	c_DigitizedAspectY		(p: POINTER): INTEGER    external "C struct TEXTMETRIC access tmDigitizedAspectY     use <windows.h>" end
	c_FirstChar				(p: POINTER): INTEGER    external "C struct TEXTMETRIC access tmFirstChar       		use <windows.h>" end
	c_LastChar				(p: POINTER): INTEGER    external "C struct TEXTMETRIC access tmLastChar       		use <windows.h>" end
	c_DefaultChar			(p: POINTER): INTEGER    external "C struct TEXTMETRIC access tmDefaultChar       	use <windows.h>" end
	c_BreakChar				(p: POINTER): INTEGER    external "C struct TEXTMETRIC access tmBreakChar       		use <windows.h>" end
	c_Italic				(p: POINTER): INTEGER    external "C struct TEXTMETRIC access tmItalic       		use <windows.h>" end
	c_Underlined			(p: POINTER): INTEGER    external "C struct TEXTMETRIC access tmUnderlined       	use <windows.h>" end
	c_StruckOut				(p: POINTER): INTEGER    external "C struct TEXTMETRIC access tmStruckOut       		use <windows.h>" end
	c_PitchAndFamily		(p: POINTER): INTEGER    external "C struct TEXTMETRIC access tmPitchAndFamily       use <windows.h>" end
	c_CharSet				(p: POINTER): INTEGER    external "C struct TEXTMETRIC access tmCharSet       		use <windows.h>" end

	c_set_Height			(p: POINTER; i: INTEGER)    external "C struct TEXTMETRIC access tmHeight			type int	use <windows.h>" end
	c_set_Ascent			(p: POINTER; i: INTEGER)    external "C struct TEXTMETRIC access tmAscent			type int	use <windows.h>" end
	c_set_Descent			(p: POINTER; i: INTEGER)    external "C struct TEXTMETRIC access tmDescent			type int	use <windows.h>" end
	c_set_InternalLeading	(p: POINTER; i: INTEGER)    external "C struct TEXTMETRIC access tmInternalLeading	type int	use <windows.h>" end
	c_set_ExternalLeading	(p: POINTER; i: INTEGER)    external "C struct TEXTMETRIC access tmExternalLeading	type int	use <windows.h>" end
	c_set_AveCharWidth		(p: POINTER; i: INTEGER)    external "C struct TEXTMETRIC access tmAveCharWidth		type int	use <windows.h>" end
	c_set_MaxCharWidth		(p: POINTER; i: INTEGER)    external "C struct TEXTMETRIC access tmMaxCharWidth		type int	use <windows.h>" end
	c_set_Weight			(p: POINTER; i: INTEGER)    external "C struct TEXTMETRIC access tmWeight			type int	use <windows.h>" end
	c_set_Overhang			(p: POINTER; i: INTEGER)    external "C struct TEXTMETRIC access tmOverhang			type int	use <windows.h>" end
	c_set_DigitizedAspectX	(p: POINTER; i: INTEGER)    external "C struct TEXTMETRIC access tmDigitizedAspectX	type int	use <windows.h>" end
	c_set_DigitizedAspectY	(p: POINTER; i: INTEGER)    external "C struct TEXTMETRIC access tmDigitizedAspectY	type int	use <windows.h>" end
	c_set_FirstChar			(p: POINTER; i: INTEGER)    external "C struct TEXTMETRIC access tmFirstChar			type int	use <windows.h>" end
	c_set_LastChar			(p: POINTER; i: INTEGER)    external "C struct TEXTMETRIC access tmLastChar			type int	use <windows.h>" end
	c_set_DefaultChar		(p: POINTER; i: INTEGER)    external "C struct TEXTMETRIC access tmDefaultChar		type int	use <windows.h>" end
	c_set_BreakChar			(p: POINTER; i: INTEGER)    external "C struct TEXTMETRIC access tmBreakChar			type int	use <windows.h>" end
	c_set_Italic			(p: POINTER; i: INTEGER)    external "C struct TEXTMETRIC access tmItalic			type int	use <windows.h>" end
	c_set_Underlined		(p: POINTER; i: INTEGER)    external "C struct TEXTMETRIC access tmUnderlined		type int	use <windows.h>" end
	c_set_StruckOut			(p: POINTER; i: INTEGER)    external "C struct TEXTMETRIC access tmStruckOut			type int	use <windows.h>" end
	c_set_PitchAndFamily	(p: POINTER; i: INTEGER)    external "C struct TEXTMETRIC access tmPitchAndFamily	type int	use <windows.h>" end
	c_set_CharSet			(p: POINTER; i: INTEGER)    external "C struct TEXTMETRIC access tmCharSet			type int	use <windows.h>" end

end

