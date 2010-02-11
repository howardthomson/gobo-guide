expanded class SB_WAPI_PAINTING_AND_DRAWING_FUNCTIONS

feature -- Access

   BeginPaint (hWnd : POINTER; lpps : POINTER) : POINTER is
      external "C use <windows.h>"
      alias "BeginPaint"
      end
	---------------------------------------------
	
   EndPaint(hWnd : POINTER; lpPaint : POINTER) is
      external "C use <windows.h>"
      alias "EndPaint"
      end
	---------------------------------------------

   GdiFlush: INTEGER is
      external "C use <windows.h>"
      alias "GdiFlush"
      end
	---------------------------------------------

   GrayString (hDC,hBrush : POINTER; lpOutputFunc : POINTER; lpData : POINTER;
               nCount, X, Y, nWidth, nHeight: INTEGER): INTEGER is
      external "C use <windows.h>"
      alias "GrayStringA"
      end
	---------------------------------------------


   RedrawWindow (hWnd, lprcUpdate, hrgnUpdate: POINTER; flags: INTEGER_32): INTEGER is
      external "C use <windows.h>"
      alias "RedrawWindow"
      end
	---------------------------------------------

   LockWindowUpdate(hWnd: POINTER): INTEGER is
      external "C use <windows.h>"
      alias "LockWindowUpdate"
      end

   DrawEdge (hdc: POINTER; qrc: POINTER; edge, grfFlags: INTEGER_32): INTEGER is
      external "C use <windows.h>"
      alias "DrawEdge"
      end

   DrawFocusRect (hDC: POINTER; lprc: POINTER): INTEGER is
      external "C use <windows.h>"
      alias "DrawFocusRect"
      end

   DrawText (hDC : POINTER;lpszStr: POINTER; cchStr: INTEGER;
             lprc: POINTER; wFormat: INTEGER_32): INTEGER is
      external "C use <windows.h>"
      alias "DrawTextA"
      end
	---------------------------------------------

   GetBkColor (hDC: POINTER): INTEGER is
      external "C use <windows.h>"
      alias "GetBkColor"
      end
	---------------------------------------------

   GetBkMode (hDC: POINTER): INTEGER is
      external "C use <windows.h>"
      alias "GetBkMode"
      end
	---------------------------------------------

   GetROP2 (hDC: POINTER): INTEGER is
      external "C use <windows.h>"
      alias "GetROP2"
      end
	---------------------------------------------

   GetUpdateRect (hWnd: POINTER; lpRect: POINTER; fErase: INTEGER): INTEGER is
      external "C use <windows.h>"
      alias "GetUpdateRect"
      end
	---------------------------------------------

   InvalidateRect (hWnd: POINTER; lprc: POINTER; fErase: INTEGER): INTEGER is
      external "C use <windows.h>"
      alias "InvalidateRect"
      end
	---------------------------------------------

   SetBkColor (hDC: POINTER; crColor: INTEGER): INTEGER is
      external "C use <windows.h>"
      alias "SetBkColor"
      end
	---------------------------------------------

   SetBkMode (hDC: POINTER; iBkMode: INTEGER): INTEGER is
      external "C use <windows.h>"
      alias "SetBkMode"
      end
	---------------------------------------------

   SetROP2 (hDC: POINTER; fnDrawMode: INTEGER): INTEGER is
      external "C use <windows.h>"
      alias "SetROP2"
      end
	---------------------------------------------

   UpdateWindow (hWnd: POINTER) : INTEGER is
      external "C use <windows.h>"
      alias "UpdateWindow"
      end
	---------------------------------------------

end
