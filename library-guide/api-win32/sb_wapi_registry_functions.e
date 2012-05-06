note

	todo: "[
		Fix C compilation errors for:
			RegOpenKeyExA()
	]"

expanded class SB_WAPI_REGISTRY_FUNCTIONS

feature

   RegCloseKey (hKey: POINTER): INTEGER
      external "C use <windows.h>"
      alias "RegCloseKey"
      end

   RegConnectRegistry (lpszComputerName, hKey, phkResult: POINTER): INTEGER
      external "C use <windows.h>"
      alias "RegConnectRegistryA"

      end

   RegCreateKey (hKey, lpszSubKey, phkResult: POINTER): INTEGER
      external "C use <windows.h>"
      alias "RegCreateKeyA"
      end

   RegCreateKeyEx (hKey,lpszSubKey: POINTER; dwReserved: INTEGER;
                   lpszClass: POINTER; fdwOptions, samDesired: INTEGER_32;
                   lpSecurityAttributes, phkResult, lpdwDisposition: POINTER): INTEGER
      external "C use <windows.h>"
      alias "RegCreateKeyExA"
      end

   RegDeleteKey (hKey, lpszSubKey: POINTER): INTEGER
      external "C use <windows.h>"
      alias "RegDeleteKeyA"
      end

   RegDeleteValue (hKey, lpszValue: POINTER): INTEGER
      external "C use <windows.h>"
      alias "RegDeleteValueA"
      end

   RegEnumKey (hKey: POINTER; iSubKey: INTEGER; lpszName: POINTER; cchName: INTEGER): INTEGER
      external "C use <windows.h>"
      alias "RegEnumKeyA"
      end

   RegEnumKeyEx (hKey: POINTER; iSubKey: INTEGER; lpszName, lpcchName, lpdwReserved,
                 lpszClass, lpcchClass, lpftLastWrite : POINTER): INTEGER
      external "C use <windows.h>"
      alias "RegEnumKeyExA"
      end

   RegEnumValue (hKey: POINTER; dwIndex: INTEGER; lpValueName, lpcValueName,
                 lpReserved, lpType, lpbData, lpcbData: POINTER): INTEGER
      external "C use <windows.h>"
      alias "RegEnumValueA"
      end

   RegFlushKey (hKey: POINTER): INTEGER
      external "C use <windows.h>"
      alias "RegFlushKey"
      end

   RegGetKeySecurity (hKey: POINTER; Secinf: INTEGER_32;
                      pSecDesc, lpcbSecDesc : POINTER): INTEGER
      external "C use <windows.h>"
      alias "RegGetKeySecurity"
      end

   RegLoadKey (hKey, lpszSubKey, lpszFile: POINTER): INTEGER
      external "C use <windows.h>"
      alias "RegLoadKeyA"
      end

   RegNotifyChangeKeyValue (hKey: POINTER; fWatchSubTree: INTEGER;
                            fdwNotifyFilter: INTEGER_32; hEvent: POINTER;
                            fAsync: INTEGER): INTEGER
      external "C use <windows.h>"
      alias "RegNotifyChangeKeyValue"
      end

   RegOpenKey (hKey, lpszSubKey, phkResult: POINTER): INTEGER
      external "C use <windows.h>"
      alias "RegOpenKeyA"
      end

   RegOpenKeyEx (hKey: POINTER; lpszSubKey: POINTER; dwReserved: INTEGER;
                 samDesired: INTEGER_32; phkResult: POINTER): INTEGER
      external "C use <windows.h>"
      alias "RegOpenKeyExA"
      end

   RegQueryInfoKey (hKey, lpszClass, lpcchClass, lpdwReserved, lpcSubKeys, lpcchMaxSubkey,
                    lpcchMaxClass, lpcValues, lpcchMaxValueName, lpcbMaxValueData,
                    lpcbSecurityDescriptor, lpftLastWriteTime: POINTER): INTEGER
      external "C use <windows.h>"
      alias "RegQueryInfoKeyA"
      end

   RegQueryValue (hKey, lpszSubKey, lpszValue, pcbValue: POINTER): INTEGER
      external "C use <windows.h>"
      alias "RegQueryValueA"
      end

   RegQueryValueEx (hKey, lpszValueName, lpdwReserved, lpdwType, lpbData, lpcbData: POINTER): INTEGER
      external "C use <windows.h>"
      alias "RegQueryValueExA"
      end

   RegReplaceKey (hKey, lpSubKey, lpNewFile, lpOldFile: POINTER): INTEGER
      external "C use <windows.h>"
      alias "RegReplaceKeyA"
      end

   RegRestoreKey (hKey, lpszFile: POINTER; fdw: INTEGER): INTEGER
      external "C use <windows.h>"
      alias "RegRestoreKeyA"
      end

   RegSaveKey (hKey, lpszFile, lpsa: POINTER): INTEGER
      external "C use <windows.h>"
      alias "RegSaveKeyA"
      end

   RegSetKeySecurity (hKey: POINTER; si: INTEGER_32; psd: POINTER): INTEGER
      external "C use <windows.h>"
      alias "RegSetKeySecurity"
      end

   RegSetValue (hKey,lpSubKey: POINTER; dwType: INTEGER; lpData: POINTER; cbData: INTEGER): INTEGER
      external "C use <windows.h>"
      alias "RegSetValueA"
      end

   RegSetValueEx (hKey, lpValueName: POINTER; Reserved, dwType: INTEGER;
                  lpData: POINTER; cbData: INTEGER): INTEGER
      external "C use <windows.h>"
      alias "RegSetValueExA"
      end

   RegUnLoadKey (hKey, lpszSubKey: POINTER): INTEGER
      external "C use <windows.h>"
      alias "RegUnLoadKeyA"
      end

   RegQueryMultipleValues (hKey,val_list: POINTER; num_vals: INTEGER;
                           lpValueBuf, ldwTotsize: POINTER): INTEGER
      external "C use <windows.h>"
      alias "RegQueryMultipleValuesA"
      end

end
