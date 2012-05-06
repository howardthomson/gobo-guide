expanded class SB_WAPI_CURSOR_FUNCTIONS

feature -- Access

   GetCursor: POINTER
         -- The 'GetCursor' function retrieves the handle of the current cursor.





      external "C use <windows.h>"
      alias "GetCursor"





      end

   SetCursor (hcur: POINTER): POINTER
         -- The 'SetCursor' function establishes the cursor shape.





      external "C use <windows.h>"
      alias "SetCursor"





      end

   ShowCursor (bShow: INTEGER): INTEGER
         -- The 'ShowCursor' function displays or hides the cursor.





      external "C use <windows.h>"
      alias "ShowCursor"





      end

   DestroyCursor (hCursor: POINTER): INTEGER





      external "C use <windows.h>"
      alias "DestroyCursor"





      end

   GetCursorPos (lpPoint: POINTER): INTEGER





      external "C use <windows.h>"
      alias "GetCursorPos"





      end

   LoadCursor (hInst: POINTER; lpszCursor: POINTER): POINTER





      external "C use <windows.h>"
      alias "LoadCursorA"





      end

   SetCursorPos (X, Y: INTEGER) : INTEGER





      external "C use <windows.h>"
      alias "SetCursorPos"





      end

end
