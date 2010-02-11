indexing

	todo: "[
		Fix C compilation errors for:
			SetClipboardData()
	]"

expanded class SB_WAPI_CLIPBOARD_FUNCTIONS

feature -- Access

   GetClipboardFormatName (format: INTEGER; lpszFormatName: POINTER; 
                           cchMaxCount: INTEGER): INTEGER is
      external "C use <windows.h>"
      alias "GetClipboardFormatNameA"
      end
	---------------------------------------
   GetClipboardOwner: POINTER is
      external "C use <windows.h>"
      alias "GetClipboardOwner"
      end
	---------------------------------------

   CountClipboardFormats: INTEGER is
      external "C use <windows.h>"
      alias "CountClipboardFormats"
      end
	---------------------------------------

   EnumClipboardFormats(format: INTEGER): INTEGER is
      external "C use <windows.h>"
      alias "EnumClipboardFormats"
      end
	---------------------------------------

   ChangeClipboardChain (hWndRemove, hWndNext: POINTER): INTEGER is
      external "C use <windows.h>"
      alias "ChangeClipboardChain"
      end
	---------------------------------------

   CloseClipboard: INTEGER is
      external "C use <windows.h>"
      alias "CloseClipboard"
      end
	---------------------------------------

   EmptyClipboard: INTEGER is
      external "C use <windows.h>"
      alias "EmptyClipboard"
      end
	---------------------------------------

   GetClipboardData (uFormat: INTEGER): POINTER is
      external "C use <windows.h>"
      alias "GetClipboardData"
      end
	---------------------------------------

   IsClipboardFormatAvailable (uFormat: INTEGER): INTEGER is
      external "C use <windows.h>"
      alias "IsClipboardFormatAvailable"
      end
	---------------------------------------

	OpenClipboard (hWnd: POINTER): INTEGER is
      	external "C use <windows.h>"
      	alias "OpenClipboard"
      	end
	---------------------------------------

	RegisterClipboardFormat (lpszFormat: POINTER): INTEGER is
      	external "C use <windows.h>"
      	alias "RegisterClipboardFormatA"
      	end
	---------------------------------------

-- Fox routines suggest that hData is an INTEGER for SetClipboardData

	SetClipboardData (uFormat: INTEGER; hData: POINTER): POINTER is
--	SetClipboardData (uFormat: INTEGER; hData: INTEGER): INTEGER is
    	external "C use <windows.h>"
      	alias "SetClipboardData"
      	end
	---------------------------------------

	SetClipboardViewer (hWnd: POINTER): POINTER is
      	external "C use <windows.h>"
      	alias "SetClipboardViewer"
      	end
	---------------------------------------

end
