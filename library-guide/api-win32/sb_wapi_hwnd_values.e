expanded class SB_WAPI_HWND_VALUES

feature -- Class data










   HWND_BROADCAST : POINTER is
      external "C inline"
      alias "((void*)65535)"
      end
   HWND_DESKTOP   : POINTER;
   HWND_TOP       : POINTER;
   HWND_BOTTOM    : POINTER is
      external "C inline"
      alias "((void*)1)"
      end
   HWND_TOPMOST   : POINTER is
      external "C inline"
      alias "((void*)-1)"
      end
   HWND_NOTOPMOST : POINTER is
      external "C inline"
      alias "((void*)-2)"
      end


end
