expanded class SB_WAPI_KEYBOARD_INPUT_FUNCTIONS

feature -- Access

   GetFocus: POINTER





      external "C use <windows.h>"
      alias "GetFocus"





      end
	--------------------------------

   GetKeyState (nVirtKey: INTEGER): INTEGER_16





      external "C use <windows.h>"
      alias "GetKeyState"





      end
	--------------------------------

   GetKeyboardState (lpKeyState: POINTER): INTEGER





      external "C use <windows.h>"
      alias "GetKeyboardState"





      end
	--------------------------------

   GetKeyNameText, GetKeyNameTextA(lParam: INTEGER; lpString: POINTER; nSize: INTEGER): INTEGER





      external "C use <windows.h>"
      alias "GetKeyNameTextA"





      end
	--------------------------------

   SetActiveWindow(hWnd: POINTER): POINTER





      external "C use <windows.h>"
      alias "SetActiveWindow"





      end
	--------------------------------

   SetFocus (hWnd: POINTER): POINTER





      external "C use <windows.h>"
      alias "SetFocus"





      end
	--------------------------------

   ToAscii(uVirtKey, uScanCode: INTEGER; lpKeyState, lpChar: POINTER; uFlags: INTEGER_32): INTEGER





      external "C use <windows.h>"
      alias "ToAscii"





      end
	--------------------------------

end
