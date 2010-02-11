class SB_WAPI_POINT

inherit

   SB_WAPI_STRUCT

creation

   make

feature
   
	external_size: INTEGER is 
		external
			"C macro use <windows.h>"	-- TODO header file ?
		alias
			"sizeof(POINT)"
		end
   
feature -- Setters

   set (a_x, a_y : INTEGER) is
      do
         set_x (a_x)
         set_y (a_y)
      end

   set_x (a_x: INTEGER) is
		do
			c_set_x (ptr, a_x)
		ensure
			value_set: x = a_x
		end

   set_y (a_y: INTEGER) is
		do
			c_set_y (ptr, a_y)
		ensure
			value_set: y = a_y
		end

feature -- Getters

   x: INTEGER is
		do
			Result := c_x (ptr)
		end

   y: INTEGER is
		do
			Result := c_y (ptr)
		end

feature {NONE} -- Implementation

	c_x		(p: POINTER): INTEGER is    external "C struct POINT access x use <windows.h>" end
	c_y		(p: POINTER): INTEGER is    external "C struct POINT access y use <windows.h>" end
	
	c_set_x	(p: POINTER; i: INTEGER) is external "C struct POINT access x type int use <windows.h>" end
	c_set_y	(p: POINTER; i: INTEGER) is external "C struct POINT access y type int use <windows.h>" end

end

