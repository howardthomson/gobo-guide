expanded class SB_WAPI_HWND_VALUES

feature -- Class data










   HWND_BROADCAST : POINTER
      external "C inline"
      alias "((void*)65535)"
      end
   HWND_DESKTOP   : POINTER;
   HWND_TOP       : POINTER;
   HWND_BOTTOM    : POINTER
      external "C inline"
      alias "((void*)1)"
      end
   HWND_TOPMOST   : POINTER
      external "C inline"
      alias "((void*)-1)"
      end
   HWND_NOTOPMOST : POINTER
      external "C inline"
      alias "((void*)-2)"
      end


end
