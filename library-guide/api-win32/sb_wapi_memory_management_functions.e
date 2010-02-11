indexing

	todo: "[
		Fix C compilation errors for:
			GlobalLock()
			GlobalUnlock()
			GlobalSize()
	]"
			
expanded class SB_WAPI_MEMORY_MANAGEMENT_FUNCTIONS

feature -- Access

   VirtualAlloc (p: POINTER; size: INTEGER; alloc_type, protect: INTEGER_32): POINTER is
      external "C use <windows.h>"
      alias "VirtualAlloc"
      end
	-------------------------------
	
   VirtualFree (p: POINTER; size: INTEGER; free_type: INTEGER_32) is
      external "C use <windows.h>"
      alias "VirtualFree"
      end
	-------------------------------

   VirtualQuery (lpAddress: POINTER; lpBuffer : POINTER; dwLength: INTEGER): INTEGER is
      external "C use <windows.h>"
      alias "VirtualQuery"
      end
	-------------------------------

   GlobalAlloc (uFlags: INTEGER_32; dwBytes: INTEGER): POINTER is
      external "C use <windows.h>"
      alias "GlobalAlloc"
      end
	-------------------------------

   GlobalFlags (hMem: INTEGER): INTEGER_32 is
      external "C use <windows.h>"
      alias "GlobalFlags"
      end

   GlobalFree (hMem: INTEGER): INTEGER is
      external "C use <windows.h>"
      alias "GlobalFree"
      end

   GlobalHandle (pMem: POINTER): INTEGER is
      external "C use <windows.h>"
      alias "GlobalHandle"
      end
	-------------------------------

   GlobalLock (hMem: POINTER): POINTER is	-- hMem: POINTER ?
      external "C use <windows.h>"
      alias "GlobalLock"
      end
	-------------------------------

   GlobalReAlloc (hMem: POINTER; dwBytes: INTEGER; uFlags: INTEGER_32): POINTER is
      external "C use <windows.h>"
      alias "GlobalReAlloc"
      end
	-------------------------------

   GlobalSize (hMem: POINTER): INTEGER is	-- hMem: POINTER ?
      external "C use <windows.h>"
      alias "GlobalSize"
      end
	-------------------------------

   GlobalUnlock (hMem: POINTER): INTEGER is	-- hMem: POINTER ?
      external "C use <windows.h>"
      alias "GlobalUnlock"
      end
	-------------------------------

   LocalAlloc (fuFlags: INTEGER_32; cbBytes: INTEGER): INTEGER is
      external "C use <windows.h>"
      alias "LocalAlloc"
      end
	-------------------------------

   LocalFree (hlocMem: INTEGER): INTEGER is
      external "C use <windows.h>"
      alias "LocalFree"
      end
	-------------------------------

   LocalLock (hlocMem: INTEGER): POINTER is
      external "C use <windows.h>"
      alias "LocalLock"
      end
	-------------------------------

   LocalUnlock (hlocMem: INTEGER): INTEGER is
      external "C use <windows.h>"
      alias "LocalUnlock"
      end

end
