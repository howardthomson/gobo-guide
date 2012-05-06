expanded class SB_WAPI_SYSTEM_INFORMATION_FUNCTIONS

feature -- Access

   ExpandEnvironmentStrings (lpSrc, lpDst: POINTER; nSize: INTEGER): INTEGER





      external "C use <windows.h>"
      alias "ExpandEnvironmentStringsA"





      end

   GetSysColor (nIndex: INTEGER): INTEGER





      external "C use <windows.h>"
      alias "GetSysColor"





      end

   GetSystemDirectory (lpBuffer: POINTER; uSize: INTEGER): INTEGER





      external "C use <windows.h>"
      alias "GetSystemDirectoryA"





      end

   GetSystemMetrics (nIndex: INTEGER): INTEGER





      external "C use <windows.h>"
      alias "GetSystemMetrics"





      end

   GetWindowsDirectory (lpBuffer: POINTER; uSize: INTEGER): INTEGER





      external "C use <windows.h>"
      alias "GetWindowsDirectoryA"





      end

   SystemParametersInfo(uiAction, uiParam: INTEGER; pvParam: POINTER; fWinIni: INTEGER): INTEGER





      external "C use <windows.h>"
      alias "SystemParametersInfoA"





      end

   GetVersionEx (lpVersionInformation: POINTER): INTEGER





      external "C use <windows.h>"
      alias "GetVersionExA"





      end

end
