class SB_WAPI_POINT

inherit

   SB_WAPI_STRUCT

create

   make

feature
   
	external_size: INTEGER 
		external
			"C macro use <windows.h>"	-- TODO header file ?
		alias
			"sizeof(POINT)"
		end
   
feature -- Setters

   set (a_x, a_y : INTEGER)
      do
         set_x (a_x)
         set_y (a_y)
      end

   set_x (a_x: INTEGER)
		do
			c_set_x (ptr, a_x)
		ensure
			value_set: x = a_x
		end

   set_y (a_y: INTEGER)
		do
			c_set_y (ptr, a_y)
		ensure
			value_set: y = a_y
		end

feature -- Getters

   x: INTEGER
		do
			Result := c_x (ptr)
		end

   y: INTEGER
		do
			Result := c_y (ptr)
		end

feature {NONE} -- Implementation

	c_x		(p: POINTER): INTEGER    external "C struct POINT access x use <windows.h>" end
	c_y		(p: POINTER): INTEGER    external "C struct POINT access y use <windows.h>" end
	
	c_set_x	(p: POINTER; i: INTEGER) external "C struct POINT access x type int use <windows.h>" end
	c_set_y	(p: POINTER; i: INTEGER) external "C struct POINT access y type int use <windows.h>" end

end

