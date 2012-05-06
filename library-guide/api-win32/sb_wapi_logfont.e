class SB_WAPI_LOGFONT

inherit

   SB_WAPI_STRUCT

create

   make, from_external

feature

	external_size: INTEGER 
		external
			"C macro use <tchar.h>"
		alias
			"sizeof(LOGFONT)"
		end
   
feature {ANY} -- Setters

	lfHeight: INTEGER
		do
			Result := c_height (ptr)
		end

	lfWidth: INTEGER
		do
			Result := c_width (ptr)
		end

	lfEscapement: INTEGER
		do
			Result := c_escapement (ptr)
		end

	lfOrientation: INTEGER
		do
			Result := c_orientation (ptr)
		end

	lfWeight: INTEGER
		do
			Result := c_weight (ptr)
		end

	lfItalic: BOOLEAN
		do
			Result := c_italic (ptr) /= 0
		end

	lfUnderline: BOOLEAN
		do
			Result := c_underline (ptr) /= 0
		end

	lfStrikeOut: BOOLEAN
		do
			Result := c_strike_out (ptr) /= 0
		end

	lfCharSet: INTEGER
		do
			Result := c_char_set (ptr)
		end

	lfOutPrecision: INTEGER
		do
			Result := c_out_precision (ptr)
      end

	lfClipPrecision: INTEGER
		do
			Result := c_clip_precision (ptr)
		end

	lfQuality: INTEGER
		do
			Result := c_quality (ptr)
		end

	lfPitchAndFamily: INTEGER
		do
			Result := c_pitch_and_family (ptr)
		end

	lfFaceName: STRING
		local
			src: POINTER
		do
			src := c_facename_address (ptr)
			create Result.from_external_copy (src)
		end

feature {ANY}

	set_lfHeight (a_var: INTEGER)
		do
			c_set_height (ptr, a_var)
		ensure
			value_set: lfHeight = a_var
		end

   set_lfWidth (a_var: INTEGER)
		do
			c_set_width (ptr, a_var)
		ensure
			value_set: lfWidth = a_var
		end

	set_lfEscapement (a_var: INTEGER)
		do
			c_set_escapement (ptr, a_var)
		ensure
			value_set: lfEscapement = a_var
		end

	set_lfOrientation (a_var: INTEGER)
		do
			c_set_orientation (ptr, a_var)
		ensure
			value_set: lfOrientation = a_var
		end

	set_lfWeight (a_var: INTEGER)
		do
			c_set_weight (ptr, a_var)
		ensure
			value_set: lfWeight = a_var
		end

	set_lfItalic (a_var: BOOLEAN)
		local
			i: INTEGER
		do
			if a_var then i := 1 end
			c_set_italic (ptr, i)
		ensure
			value_set: lfItalic = a_var
		end

	set_lfUnderline (a_var: BOOLEAN)
		local
			i: INTEGER
		do
			if a_var then i := 1 end
			c_set_underline (ptr, i)
		ensure
			value_set: lfUnderline = a_var
		end

	set_lfStrikeOut (a_var: BOOLEAN)
		local
			i: INTEGER
		do
			if a_var then i := 1 end
			c_set_strike_out (ptr, i)
		ensure
			value_set: lfStrikeOut = a_var
		end

	set_lfCharSet (a_var: INTEGER)
		do
			c_set_char_set (ptr, a_var)
		ensure
			value_set: lfCharSet = a_var
		end

	set_lfOutPrecision (a_var: INTEGER)
		do
			c_set_out_precision (ptr, a_var)
		ensure
			value_set: lfOutPrecision = a_var
		end

	set_lfClipPrecision (a_var: INTEGER)
		do
			c_set_clip_precision (ptr, a_var)
		ensure
			value_set: lfClipPrecision = a_var
		end

	set_lfQuality (a_var: INTEGER)
		do
			c_set_quality (ptr, a_var)
		ensure
			value_set: lfQuality = a_var
		end

	set_lfPitchAndFamily (a_var: INTEGER)
		do
			c_set_pitch_and_family (ptr, a_var)
		ensure
			value_set: lfPitchAndFamily = a_var
		end

	set_lfFaceName (a_facename: STRING)
		require
			facename_not_void: a_facename /= Void
		local
			p: POINTER
		do
			p := a_facename.area.base_address
			c_copy_facename (p, c_facename_address (ptr))
--			c_inline_c ("_tcsncpy ((TCHAR*)((LOGFONT*) _ptr_)->lfFaceName, (TCHAR*)_val, LF_FACESIZE);%N")
		end

feature {NONE} -- Implementation

	c_height				(p: POINTER): INTEGER    external "C struct LOGFONT access lfHeight       		use <tchar.h>" end
	c_width					(p: POINTER): INTEGER    external "C struct LOGFONT access lfWidth       		use <tchar.h>" end
	c_escapement			(p: POINTER): INTEGER    external "C struct LOGFONT access lfEscapement       	use <tchar.h>" end
	c_orientation			(p: POINTER): INTEGER    external "C struct LOGFONT access lfOrientation       	use <tchar.h>" end
	c_weight				(p: POINTER): INTEGER    external "C struct LOGFONT access lfWeight       		use <tchar.h>" end
	c_italic				(p: POINTER): INTEGER    external "C struct LOGFONT access lfItalic       		use <tchar.h>" end
	c_underline				(p: POINTER): INTEGER    external "C struct LOGFONT access lfUnderline       	use <tchar.h>" end
	c_strike_out			(p: POINTER): INTEGER    external "C struct LOGFONT access lfStrikeOut       	use <tchar.h>" end
	c_char_set				(p: POINTER): INTEGER    external "C struct LOGFONT access lfCharSet       		use <tchar.h>" end
	c_out_precision			(p: POINTER): INTEGER    external "C struct LOGFONT access lfOutPrecision      	use <tchar.h>" end
	c_clip_precision		(p: POINTER): INTEGER    external "C struct LOGFONT access lfClipPrecision     	use <tchar.h>" end
	c_quality				(p: POINTER): INTEGER    external "C struct LOGFONT access lfQuality           	use <tchar.h>" end
	c_pitch_and_family		(p: POINTER): INTEGER    external "C struct LOGFONT access lfPitchAndFamily    	use <tchar.h>" end

	c_set_height			(p: POINTER; i: INTEGER)    external "C struct LOGFONT access lfHeight			type int	use <tchar.h>" end
	c_set_width				(p: POINTER; i: INTEGER)    external "C struct LOGFONT access lfWidth       		type int	use <tchar.h>" end
	c_set_escapement		(p: POINTER; i: INTEGER)    external "C struct LOGFONT access lfEscapement     	type int  	use <tchar.h>" end
	c_set_orientation		(p: POINTER; i: INTEGER)    external "C struct LOGFONT access lfOrientation    	type int  	use <tchar.h>" end
	c_set_weight			(p: POINTER; i: INTEGER)    external "C struct LOGFONT access lfWeight       	type int	use <tchar.h>" end
	c_set_italic			(p: POINTER; i: INTEGER)    external "C struct LOGFONT access lfItalic       	type int	use <tchar.h>" end
	c_set_underline			(p: POINTER; i: INTEGER)    external "C struct LOGFONT access lfUnderline      	type int 	use <tchar.h>" end
	c_set_strike_out		(p: POINTER; i: INTEGER)    external "C struct LOGFONT access lfStrikeOut      	type int 	use <tchar.h>" end
	c_set_char_set			(p: POINTER; i: INTEGER)    external "C struct LOGFONT access lfCharSet       	type int	use <tchar.h>" end
	c_set_out_precision		(p: POINTER; i: INTEGER)    external "C struct LOGFONT access lfOutPrecision   	type int  	use <tchar.h>" end
	c_set_clip_precision	(p: POINTER; i: INTEGER)    external "C struct LOGFONT access lfClipPrecision  	type int  	use <tchar.h>" end
	c_set_quality			(p: POINTER; i: INTEGER)    external "C struct LOGFONT access lfQuality       	type int	use <tchar.h>" end
	c_set_pitch_and_family	(p: POINTER; i: INTEGER)    external "C struct LOGFONT access lfPitchAndFamily 	type int  	use <tchar.h>" end

	c_facename_address (p: POINTER): POINTER
		external "C inline"
		alias "((EIF_POINTER)((LOGFONT*)$p)->lfFaceName)"
		end

	c_copy_facename (p_from, p_to: POINTER)
		external "C inline"
		alias "_tcsncpy ((TCHAR*)$p_to, (TCHAR*)$p_from, LF_FACESIZE)"
		end

--	c_FaceName				(p: POINTER): POINTER is    external "C struct LOGFONT access lfFaceName    use <tchar.h>" end
--	c_inline_c ("_src=(EIF_POINTER)((LOGFONT*)_ptr_)->lfFaceName;%N")
--	c_set_FaceName		 (p: POINTER; i: INTEGER) is    external "C struct LOGFONT access lfFaceName       use <tchar.h>" end
	
invariant

	ptr_not_void: ptr /= Void

end

