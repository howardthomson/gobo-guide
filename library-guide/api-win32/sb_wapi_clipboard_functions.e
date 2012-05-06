note

	todo: "[
		Fix C compilation errors for:
			SetClipboardData()
	]"

expanded class SB_WAPI_CLIPBOARD_FUNCTIONS

feature -- Access

   GetClipboardFormatName (format: INTEGER; lpszFormatName: POINTER; 
                           cchMaxCount: INTEGER): INTEGER
      external "C use <windows.h>"
      alias "GetClipboardFormatNameA"
      end
	---------------------------------------
   GetClipboardOwner: POINTER
      external "C use <windows.h>"
      alias "GetClipboardOwner"
      end
	---------------------------------------

   CountClipboardFormats: INTEGER
      external "C use <windows.h>"
      alias "CountClipboardFormats"
      end
	---------------------------------------

   EnumClipboardFormats(format: INTEGER): INTEGER
      external "C use <windows.h>"
      alias "EnumClipboardFormats"
      end
	---------------------------------------

   ChangeClipboardChain (hWndRemove, hWndNext: POINTER): INTEGER
      external "C use <windows.h>"
      alias "ChangeClipboardChain"
      end
	---------------------------------------

   CloseClipboard: INTEGER
      external "C use <windows.h>"
      alias "CloseClipboard"
      end
	---------------------------------------

   EmptyClipboard: INTEGER
      external "C use <windows.h>"
      alias "EmptyClipboard"
      end
	---------------------------------------

   GetClipboardData (uFormat: INTEGER): POINTER
      external "C use <windows.h>"
      alias "GetClipboardData"
      end
	---------------------------------------

   IsClipboardFormatAvailable (uFormat: INTEGER): INTEGER
      external "C use <windows.h>"
      alias "IsClipboardFormatAvailable"
      end
	---------------------------------------

	OpenClipboard (hWnd: POINTER): INTEGER
      	external "C use <windows.h>"
      	alias "OpenClipboard"
      	end
	---------------------------------------

	RegisterClipboardFormat (lpszFormat: POINTER): INTEGER
      	external "C use <windows.h>"
      	alias "RegisterClipboardFormatA"
      	end
	---------------------------------------

-- Fox routines suggest that hData is an INTEGER for SetClipboardData

	SetClipboardData (uFormat: INTEGER; hData: POINTER): POINTER
--	SetClipboardData (uFormat: INTEGER; hData: INTEGER): INTEGER is
    	external "C use <windows.h>"
      	alias "SetClipboardData"
      	end
	---------------------------------------

	SetClipboardViewer (hWnd: POINTER): POINTER
      	external "C use <windows.h>"
      	alias "SetClipboardViewer"
      	end
	---------------------------------------

end
