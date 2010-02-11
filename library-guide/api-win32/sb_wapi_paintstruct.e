class SB_WAPI_PAINTSTRUCT

inherit

   SB_WAPI_STRUCT

creation

   make

feature
   
	external_size: INTEGER is 
		external
			"C macro use <winuser.h>"	-- Use ??
		alias
			"sizeof(PAINTSTRUCT)"
		end
   
feature {ANY} -- Access

	hdc: POINTER is
		do
			Result := c_hdc (ptr)
		end

	flag_erase: BOOLEAN is
		do
			Result := c_flag_erase (ptr) /= 0
		end

	paint_rect: SB_WAPI_RECT is
		local
			p: POINTER
		do
			p := c_paint_rect_address (ptr)
			create Result.from_external_copy (p)
		end

feature {ANY} -- Update

	set_hdc (an_hdc: POINTER) is
		do
			c_set_hdc (ptr, an_hdc)
		ensure
			value_set: hdc = an_hdc
		end

	set_flag_erase (a_flag: BOOLEAN) is
		local
			i: INTEGER
		do
			if a_flag then i := 1 end
			c_set_flag_erase (ptr, i)
		ensure
			value_set: flag_erase = a_flag
		end

	set_paint_rect (a_rect: SB_WAPI_RECT) is
		local
			p: POINTER
		do
			p := c_paint_rect_address (ptr)
			p.memory_copy (a_rect.ptr, external_size)
		end

feature {NONE} -- Implementation

	c_hdc				(p: POINTER): INTEGER is    external "C struct PAINTSTRUCT access hdc use <winuser.h>" end
	c_flag_erase		(p: POINTER): INTEGER is    external "C struct PAINTSTRUCT access fErase use <winuser.h>" end

	c_set_hdc			(p: POINTER; i: INTEGER) is    external "C struct PAINTSTRUCT access hdc	type int use <winuser.h>" end
	c_set_flag_erase	(p: POINTER; i: INTEGER) is    external "C struct PAINTSTRUCT access fErase	type int use <winuser.h>" end

	c_paint_rect_address (p: POINTER): POINTER is
		external
			"C inline"
		alias
			"(EIF_POINTER)(&((PAINTSTRUCT *)($p))->rcPaint)"
		end

invariant

	valid_ptr: ptr /= default_pointer

end

