expanded class SB_WAPI_FILE_FUNCTIONS

feature

   CreateFile (lpszName: POINTER; fdwAccess: INTEGER_32; fdwShareMode: INTEGER_32;
               lpsa: POINTER; fdwCreate: INTEGER; fdwAttrsAndFlags: INTEGER_32; hTemplateFile: POINTER): POINTER is




      external "C use <windows.h>"
      alias "CreateFileA"

      end

   CreateDirectory (lpPathName: POINTER; lpSecurityAttributes: POINTER): INTEGER is




      external "C use <windows.h>"
      alias "CreateDirectoryA"

      end

   MoveFile(lpExistingFileName: POINTER; lpNewFileName: POINTER): INTEGER is




      external "C use <windows.h>"
      alias "MoveFileA"

      end

   CopyFile(lpExistingFileName,lpNewFileName: POINTER; bFailIfExists: INTEGER): INTEGER is




      external "C use <windows.h>"
      alias "CopyFileA"

      end

   DeleteFile (lpFileName: POINTER): INTEGER is




      external "C use <windows.h>"
      alias "DeleteFileA"

      end

   RemoveDirectory (lpPathName: POINTER): INTEGER is




      external "C use <windows.h>"
      alias "RemoveDirectoryA"

      end

   GetCurrentDirectory (nBufferLength: INTEGER;lpBuffer: POINTER): INTEGER is




      external "C use <windows.h>"
      alias "GetCurrentDirectoryA"

      end

   SetCurrentDirectory(lpPathName: POINTER): INTEGER is




      external "C use <windows.h>"
      alias "SetCurrentDirectoryA"

      end

   GetFullPathName (lpFileName: POINTER; nBufferLength: INTEGER; lpBuffer: POINTER;
                    lpFilePart: POINTER ): INTEGER is




      external "C use <windows.h>"
      alias "GetFullPathNameA"

      end

   FindFirstFile (lpFileName: POINTER; lpFindFileData: POINTER): POINTER is




      external "C use <windows.h>"
      alias "FindFirstFileA"

      end

   FindNextFile (hFindFile: POINTER;lpFindFileData: POINTER): INTEGER is




      external "C use <windows.h>"
      alias "FindNextFileA"

      end

   FindClose (hFindFile: POINTER): INTEGER is




      external "C use <windows.h>"
      alias "FindClose"

      end

   GetFileAttributes(lpFileName: POINTER): INTEGER_32 is




      external "C use <windows.h>"
      alias "GetFileAttributesA"

      end

   GetFileSize (hFile: POINTER; lpFileSizeHigh: POINTER): INTEGER is




      external "C use <windows.h>"
      alias "GetFileSize"

      end

   GetFileType (hFile: POINTER): INTEGER is




      external "C use <windows.h>"
      alias "GetFileType"

      end

   GetTempFileName (lpPathName,lpPrefixString: POINTER; uUnique: INTEGER;lpTempFileName: POINTER): INTEGER is




      external "C use <windows.h>"
      alias "GetTempFileNameA"

      end

   GetTempPath (nBufferLength: INTEGER; lpBuffer: POINTER): INTEGER is




      external "C use <windows.h>"
      alias "GetTempPathA"

      end

   ReadFile(hFile,lpBuffer: POINTER; nNumberOfBytesToRead: INTEGER;
            lpNumberOfBytesRead, lpOverlapped: POINTER): INTEGER is




      external "C use <windows.h>"
      alias "ReadFile"

      end

   SetEndOfFile (hFile: POINTER): INTEGER is




      external "C use <windows.h>"
      alias "SetEndOfFile"

      end

   SetFilePointer (hFile: POINTER; lDistanceToMove: INTEGER;
                   lpDistanceToMoveHigh: POINTER; dwMoveMethod: INTEGER): INTEGER is




      external "C use <windows.h>"
      alias "SetFilePointer"

      end

   WriteFile (hFile,lpBuffer: POINTER; nNumberOfBytesToWrite : INTEGER;
              lpNumberOfBytesWritten,lpOverlapped: POINTER): INTEGER is




      external "C use <windows.h>"
      alias "WriteFile"

      end

   GetFileInformationByHandle (hFile,lpFileInformation: POINTER): INTEGER is




      external "C use <windows.h>"
      alias "GetFileInformationByHandle"

      end

   GetDriveType (lpRootPathName: POINTER): INTEGER is




      external "C use <windows.h>"
      alias "GetDriveTypeA"

      end

   GetVolumeInformation(lpRootPathName,lpVolumeNameBuffer: POINTER;
                        nVolumeNameSize: INTEGER;
                        lpVolumeSerialNumber,lpMaximumComponentLength,
                        lpFileSystemFlags,lpFileSystemNameBuffer: POINTER;
                        nFileSystemNameSize: INTEGER): INTEGER is




      external "C use <windows.h>"
      alias "GetVolumeInformationA"

      end

   GetLogicalDrives: INTEGER_32 is




      external "C use <windows.h>"
      alias "GetLogicalDrives"

      end

end
