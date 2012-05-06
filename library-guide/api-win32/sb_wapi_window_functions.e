expanded class SB_WAPI_WINDOW_FUNCTIONS

feature -- Access

   EnableWindow (hWnd: POINTER; fEnable: INTEGER): INTEGER
      external "C use <windows.h>"
      alias "EnableWindow"
      end
	-----------------------------------
	
   GetWindowLong (hWnd: POINTER; nIndex: INTEGER): INTEGER
      external "C use <windows.h>"
      alias "GetWindowLongA"
      end
	-----------------------------------

   GetWindowText (hWnd: POINTER; lpsz: POINTER; cch: INTEGER): INTEGER
      external "C use <windows.h>"
      alias "GetWindowTextA"
      end
	-----------------------------------

   IsWindow (hWnd: POINTER) : INTEGER
      external "C use <windows.h>"
      alias "IsWindow"
      end
	-----------------------------------

   IsChild (hWndParent, hWnd: POINTER): INTEGER
      external "C use <windows.h>"
      alias "IsChild"
      end
	-----------------------------------

   IsWindowEnabled (hWnd: POINTER): INTEGER
      external "C use <windows.h>"
      alias "IsWindowEnabled"
      end
	-----------------------------------

   IsWindowVisible (hWnd: POINTER): INTEGER
      external "C use <windows.h>"
      alias "IsWindowVisible"
      end
	-----------------------------------

   ShowWindow (hWnd: POINTER; nCmdShow : INTEGER) : INTEGER
      external "C use <windows.h>"
      alias "ShowWindow"
      end
	-----------------------------------

   GetParent (hWnd: POINTER): INTEGER
      external "C use <windows.h>"
      alias "GetParent"
      end
   	-----------------------------------

	WindowFromPoint(x, y: INTEGER): POINTER
		external "C inline"
--		alias "((void*(__stdcall*)(int,int))WindowFromPoint)($x,$y)"
--		alias "((void *()(int, int))(WindowFromPoint))($x,$y)"
		alias "[
			{	POINT ___p;

				___p.x = $x;
				___p.y = $y;
				return WindowFromPoint(___p);
			}
		]"
		end

	-----------------------------------

   BringWindowToTop (hWnd: POINTER): INTEGER
      external "C use <windows.h>"
      alias "BringWindowToTop"
      end
	-----------------------------------

   CreateWindowEx (
                   dwExStyle      : INTEGER_32;
                   lpszClassName  : POINTER;
                   lpszWindowName : POINTER;
                   dwStyle        : INTEGER_32;
                   x, y,
                   nWidth,
                   nHeight        : INTEGER;
                   hWndParent     : POINTER;
                   hMenu          : POINTER;
                   hInst          : POINTER;
                   lpvParam       : POINTER
                   ) : POINTER
      external "C use <windows.h>"
      alias "CreateWindowExA"
      end
	-----------------------------------

   DestroyWindow (hWnd: POINTER) : INTEGER
      external "C use <windows.h>"
      alias "DestroyWindow"
      end
	-----------------------------------

   GetClientRect (hWnd: POINTER; lprc: POINTER): INTEGER
      external "C use <windows.h>"
      alias "GetClientRect"
      end
	-----------------------------------

   GetWindowRect (hWnd: POINTER; lprc: POINTER) : INTEGER
      external "C use <windows.h>"
      alias "GetWindowRect"
      end
	-----------------------------------

   IsIconic (hWnd: POINTER): INTEGER
      external "C use <windows.h>"
      alias "IsIconic"
      end
	-----------------------------------

   IsZoomed (hWnd: POINTER): INTEGER
      external "C use <windows.h>"
      alias "IsZoomed"
      end
	-----------------------------------

   MoveWindow (hWnd: POINTER; x, y, cx, cy, fRepaint: INTEGER): INTEGER
      external "C use <windows.h>"
      alias "MoveWindow"
      end
	-----------------------------------

   SetParent (hWndChild, hWndNewParent: POINTER): POINTER
      external "C use <windows.h>"
      alias "SetParent"
      end
	-----------------------------------

   SetWindowLong (hWnd: POINTER; nIndex, lNewLong: INTEGER): INTEGER
      external "C use <windows.h>"
      alias "SetWindowLongA"
      end
	-----------------------------------

   SetWindowPos (hWnd, hWndInsertAfter: POINTER; x, y, cx, cy: INTEGER; fuFlags: INTEGER_32): INTEGER
      external "C use <windows.h>"
      alias "SetWindowPos"
      end
	-----------------------------------

   SetWindowText (hWnd: POINTER; lpsz: POINTER): INTEGER
      external "C use <windows.h>"
      alias "SetWindowTextA"
      end
	-----------------------------------

   SetWindowRgn (hWnd, hRgn: POINTER; bRedraw: INTEGER): INTEGER
      external "C use <windows.h>"
      alias "SetWindowRgn"
      end
	-----------------------------------

   GetDesktopWindow: POINTER
      external "C use <windows.h>"
      alias "GetDesktopWindow"
      end
	-----------------------------------

   AdjustWindowRectEx(lpRect: POINTER; dwStyle, bMenu, dwExStyle: INTEGER): INTEGER
      external "C use <windows.h>"
      alias "AdjustWindowRectEx"
      end
	-----------------------------------

   GetWindowThreadProcessId(hWnd: POINTER; lpdwProcessId: POINTER): INTEGER
      external "C use <windows.h>"
      alias "GetWindowThreadProcessId"
      end

	GetLastError: INTEGER
    	external "C use <windows.h>"
    	alias "GetLastError"
		end		

end
