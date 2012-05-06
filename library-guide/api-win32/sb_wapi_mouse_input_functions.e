expanded class SB_WAPI_MOUSE_INPUT_FUNCTIONS

feature -- Access

   GetCapture: POINTER





      external "C use <windows.h>"
      alias "GetCapture"





      end

   SetCapture (hWnd: POINTER): POINTER





      external "C use <windows.h>"
      alias "SetCapture"





      end

   ReleaseCapture: INTEGER





      external "C use <windows.h>"
      alias "ReleaseCapture"





      end

end
