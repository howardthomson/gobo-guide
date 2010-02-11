expanded class SB_WAPI_HANDLE_AND_OBJECT_FUNCTIONS

feature -- Access

   CloseHandle (hObject: POINTER): INTEGER is





      external "C use <windows.h>"
      alias "CloseHandle"





      end

   DuplicateHandle (hSourceProcessHandle, hSourceHandle, hTargetProcessHandle: POINTER;
                    lpTargetHandle: POINTER; dwDesiredAccess: INTEGER; bInheritHandle: INTEGER;
                    dwOptions: INTEGER): INTEGER is





      external "C use <windows.h>"
      alias "DuplicateHandle"





      end

end
