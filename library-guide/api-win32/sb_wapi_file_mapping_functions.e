expanded class SB_WAPI_FILE_MAPPING_FUNCTIONS

feature

   CreateFileMapping(hFile: POINTER; lpFileMappingAttributes: POINTER;
                     flProtect: INTEGER_32; dwMaximumSizeHigh,dwMaximumSizeLow: INTEGER; lpName: POINTER): POINTER is





      external "C use <windows.h>"
      alias "CreateFileMappingA"





      end


   FlushViewOfFile (lpBaseAddress: POINTER; dwNumberOfBytesToFlush: INTEGER): INTEGER is





      external "C use <windows.h>"
      alias "FlushViewOfFile"





      end

   MapViewOfFile (hFileMappingObject: POINTER; dwDesiredAccess: INTEGER_32;
                  dwFileOffsetHigh, dwFileOffsetLow,dwNumberOfBytesToMap : INTEGER): POINTER is





      external "C use <windows.h>"
      alias "MapViewOfFile"





      end

   MapViewOfFileEx (hFileMappingObject: POINTER; dwDesiredAccess: INTEGER_32; 
                    dwFileOffsetHigh, dwFileOffsetLow, dwNumberOfBytesToMap: INTEGER;
                    lpBaseAddress: POINTER) : POINTER is





      external "C use <windows.h>"
      alias "MapViewOfFileEx"





      end

   OpenFileMapping(dwDesiredAccess: INTEGER_32; bInheritHandle: INTEGER; lpName: POINTER): POINTER is





      external "C use <windows.h>"
      alias "OpenFileMappingA"





      end

   UnmapViewOfFile(lpBaseAddress: POINTER): INTEGER is





      external "C use <windows.h>"
      alias "UnmapViewOfFile"





      end

end
