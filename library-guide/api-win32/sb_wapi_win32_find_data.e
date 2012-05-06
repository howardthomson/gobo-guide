class SB_WAPI_WIN32_FIND_DATA

inherit
   SB_WAPI_STRUCT
      redefine
         external_size
      end

create
   make

feature

   external_size: INTEGER 
      do
         c_inline_c ("R = sizeof(WIN32_FIND_DATA);%N")
      end

feature -- Data

   file_attributes: INTEGER
      require
         pointer_not_null: ptr.is_not_null
      local
         ptr_: POINTER
      do
         ptr_ := ptr
         c_inline_c ("R=(EIF_INTEGER)((WIN32_FIND_DATA*)_ptr_)->dwFileAttributes;%N")
      end

   creation_time_low: INTEGER
      require
         pointer_not_null: ptr.is_not_null
      local
         ptr_: POINTER
      do
         ptr_ := ptr
         c_inline_c ("R=(EIF_INTEGER)(((WIN32_FIND_DATA*)_ptr_)->ftCreationTime.dwLowDateTime);%N")
      end

   creation_time_hi: INTEGER
      require
         pointer_not_null: ptr.is_not_null
      local
         ptr_: POINTER
      do
         ptr_ := ptr
         c_inline_c ("R=(EIF_INTEGER)(((WIN32_FIND_DATA*)_ptr_)->ftCreationTime.dwHighDateTime);%N")
      end

   last_access_time_low: INTEGER
      require
         pointer_not_null: ptr.is_not_null
      local
         ptr_: POINTER
      do
         ptr_ := ptr
         c_inline_c ("R=(EIF_INTEGER)(((WIN32_FIND_DATA*)_ptr_)->ftLastAccessTime.dwLowDateTime);%N")
      end

   last_access_time_hi: INTEGER
      require
         pointer_not_null: ptr.is_not_null
      local
         ptr_: POINTER
      do
         ptr_ := ptr
         c_inline_c ("R=(EIF_INTEGER)(((WIN32_FIND_DATA*)_ptr_)->ftLastWriteTime.dwHighDateTime);%N")
      end

   last_write_time_low: INTEGER
      require
         pointer_not_null: ptr.is_not_null
      local
         ptr_: POINTER
      do
         ptr_ := ptr
         c_inline_c ("R=(EIF_INTEGER)(((WIN32_FIND_DATA*)_ptr_)->ftLastWriteTime.dwLowDateTime);%N")
      end

   last_write_time_hi: INTEGER
      require
         pointer_not_null: ptr.is_not_null
      local
         ptr_: POINTER
      do
         ptr_ := ptr
         c_inline_c ("R=(EIF_INTEGER)(((WIN32_FIND_DATA*)_ptr_)->ftLastAccessTime.dwHighDateTime);%N")
      end

   file_size_high: INTEGER
      require
         pointer_not_null: ptr.is_not_null
      local
         ptr_: POINTER
      do
         ptr_ := ptr
         c_inline_c ("R=(EIF_INTEGER)((WIN32_FIND_DATA*)_ptr_)->nFileSizeHigh;%N")
      end

   file_size_low: INTEGER
      require
         pointer_not_null: ptr.is_not_null
      local
         ptr_: POINTER
      do
         ptr_ := ptr
         c_inline_c ("R=(EIF_INTEGER)((WIN32_FIND_DATA*)_ptr_)->nFileSizeLow;%N")
      end

   file_name: STRING
      require
         pointer_not_null: ptr.is_not_null
      local
         res: POINTER
         ptr_: POINTER
      do
         ptr_ := ptr
         c_inline_c ("_res=(EIF_POINTER)((WIN32_FIND_DATA*)_ptr_)->cFileName;%N")
         create Result.from_external_copy(res);
      end

   alternate_file_name: STRING
      require
         pointer_not_null: ptr.is_not_null
      local
         res: POINTER
         ptr_: POINTER
      do
         ptr_ := ptr
         c_inline_c ("_res=(EIF_POINTER)((WIN32_FIND_DATA*)_ptr_)->cAlternateFileName;%N")
         create Result.from_external_copy(res);
      end
end

