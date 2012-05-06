class SB_WAPI_RECT

inherit 

	SB_WAPI_STRUCT

create

   make, from_external

feature

	external_size: INTEGER 
		do
			Result := c_external_size
		end -- external_size

feature -- Setters

	set_left (a_var: INTEGER)
		do
      		c_set_left (ptr, a_var)
		ensure
			value_set: left = a_var
		end -- set_left

	set_top (a_var : INTEGER)
		do
			c_set_top (ptr, a_var)
		ensure
			value_set: top = a_var
		end -- set_top

	set_right (a_var : INTEGER)
		do
			c_set_right (ptr, a_var)
		ensure
			value_set: right = a_var
		end -- set_right

	set_bottom (a_var : INTEGER)
		do
			c_set_bottom (ptr, a_var)
		ensure
			value_set: bottom = a_var
      end -- set_bottom

	set (a_left, a_top, a_right, a_bottom: INTEGER)
		do
        	set_left (a_left)
        	set_top (a_top)
        	set_right (a_right)
        	set_bottom (a_bottom)
		end

feature -- Getters

	left: INTEGER
		do
			Result := c_left (ptr)
		end -- left

   top: INTEGER
		do
			Result := c_top (ptr)
      	end -- top

   right: INTEGER
		do
			Result := c_right (ptr)
      	end -- right

   bottom: INTEGER
		do
			Result := c_bottom (ptr)
      	end -- bottom

feature -- Implementation

	c_external_size: INTEGER    external "C macro use <windows.h>"    alias "sizeof(RECT)"    end

	c_left				(p: POINTER): INTEGER    external "C struct RECT access left use <windows.h>"			end
	c_right				(p: POINTER): INTEGER    external "C struct RECT access right use <windows.h>"			end
	c_top				(p: POINTER): INTEGER    external "C struct RECT access top use <windows.h>"				end
	c_bottom			(p: POINTER): INTEGER    external "C struct RECT access bottom use <windows.h>"			end

	c_set_left			(p: POINTER; i: INTEGER)	external "C struct RECT access left		type int use <windows.h>"			end
	c_set_right			(p: POINTER; i: INTEGER)	external "C struct RECT access right	type int use <windows.h>"			end
	c_set_top			(p: POINTER; i: INTEGER)	external "C struct RECT access top		type int use <windows.h>"			end
	c_set_bottom		(p: POINTER; i: INTEGER)	external "C struct RECT access bottom	type int use <windows.h>"			end

end

