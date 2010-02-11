expanded class SB_WAPI_SIZE

inherit 

--	SB_WAPI_STRUCT
	SE_EXP_8_BYTES
		rename
			pointer as ptr
		end
--creation
--	make

feature

   external_size : INTEGER is 
      local
         res: INTEGER
      do
--         c_inline_c ("_res = sizeof(SIZE);%N")
         Result := res
      end -- external_size
   
feature
      --Setters

   set_cx (a_var : INTEGER) is
      require
         ptr_not_null: ptr.is_not_null
--#         sufficient_size: size >= external_size
      local
         val: INTEGER
         ptr_: POINTER
      do
         val := a_var
         ptr_ := ptr
--         c_inline_c ("((SIZE*)_ptr_)->cx = _val;%N")
      ensure
         value_set: cx = a_var
      end -- set_cx

   set_cy (a_var : INTEGER) is
      require
         ptr_not_null: ptr.is_not_null
--#         sufficient_size: size >= external_size
      local
         val: INTEGER
         ptr_: POINTER
      do
         val := a_var
         ptr_ := ptr
--         c_inline_c ("((SIZE*)_ptr_)->cy = _val;%N")
      ensure
         value_set: cy = a_var
      end -- set_cy

   set (cx_, cy_ : INTEGER) is
      do
         set_cx (cx_);
         set_cy (cy_)
      end

feature
      -- Getters

   cx : INTEGER is
      require
         ptr_not_null: ptr.is_not_null
      local
         res: INTEGER
         ptr_: POINTER
      do
         ptr_ := ptr
--         c_inline_c ("_res=(EIF_INTEGER)((SIZE*)_ptr_)->cx;%N")
         Result := res
      end -- cx

   cy : INTEGER is
      require
         ptr_not_null: ptr.is_not_null
      local
         res: INTEGER
         ptr_: POINTER
      do
         ptr_ := ptr
--         c_inline_c ("_res=(EIF_INTEGER)((SIZE*)_ptr_)->cy;%N")
         Result := res
      end -- cy
end

