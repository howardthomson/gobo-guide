expanded class SB_WAPI_DEVICE_CONTEXT_FUNCTIONS

feature -- Access

   DeleteObject (hObject: POINTER): INTEGER is





      external "C use <windows.h>"
      alias "DeleteObject"





      end
	------------------------------------------
	
   GetDeviceCaps (hDC: POINTER; nIndex : INTEGER) : INTEGER is





      external "C use <windows.h>"
      alias "GetDeviceCaps"





      end
	------------------------------------------
	

   GetObject (hgdiobj: POINTER; cbBuffer : INTEGER; lpvObject : POINTER) : INTEGER is





      external "C use <windows.h>"
      alias "GetObjectA"





      end
	------------------------------------------
	

   ReleaseDC (hWnd, hDC : POINTER): INTEGER is





      external "C use <windows.h>"
      alias "ReleaseDC"





      end
	------------------------------------------
	

   CreateCompatibleDC (hDC: POINTER) : POINTER is





      external "C use <windows.h>"
      alias "CreateCompatibleDC"





      end
	------------------------------------------
	

   DeleteDC (hDC : POINTER) : INTEGER is





      external "C use <windows.h>"
      alias "DeleteDC"





      end
	------------------------------------------
	

   GetDC (hWnd: POINTER): POINTER is





      external "C use <windows.h>"
      alias "GetDC"





      end
	------------------------------------------
	

   GetDCEx (hWnd, hRgnClip: POINTER; flags: INTEGER_32): POINTER is





      external "C use <windows.h>"
      alias "GetDCEx"





      end
	------------------------------------------
	

   GetStockObject (fnObject: INTEGER): POINTER is





      external "C use <windows.h>"
      alias "GetStockObject"





      end
	------------------------------------------
	

   SelectObject (hDC, hgdiobj: POINTER): POINTER is





      external "C use <windows.h>"
      alias "SelectObject"





      end
	------------------------------------------
	

   CreateDC (lpszDriver,lpszDevice,lpszOutput, lpInitData: POINTER): POINTER is





      external "C use <windows.h>"





      end
	------------------------------------------
	

   CreateDCW (lpszDriver,lpszDevice,lpszOutput,lpInitData: POINTER): POINTER is





      external "C use <windows.h>"





      end
	------------------------------------------
	

   SaveDC (hdc: POINTER): INTEGER is





      external "C use <windows.h>"





      end
	------------------------------------------
	

   RestoreDC (hdc: POINTER; nSavedDC: INTEGER): INTEGER is





      external "C use <windows.h>"





      end
	------------------------------------------
	

   CreateMetaFile (lpszFile: POINTER): POINTER is





      external "C use <windows.h>"





      end
	------------------------------------------
	

   CloseMetaFile (hdc: POINTER): POINTER is





      external "C use <windows.h>"





      end
	------------------------------------------

   DeleteMetaFile (hmf: POINTER): INTEGER is





      external "C use <windows.h>"





      end

end
