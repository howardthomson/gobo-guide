expanded class SB_WAPI_REGISTRY_KEY_CONSTANTS

inherit

   SB_WAPI_STANDARD_ACCESS_MASKS

feature

	KEY_QUERY_VALUE			: INTEGER_32 is 1	--	1B;
	KEY_SET_VALUE			: INTEGER_32 is 2	--	10B;
	KEY_CREATE_SUB_KEY		: INTEGER_32 is 4	--	100B;
	KEY_ENUMERATE_SUB_KEYS	: INTEGER_32 is 8	--	1000B;
	KEY_NOTIFY				: INTEGER_32 is 16	--	10000B;
	KEY_CREATE_LINK			: INTEGER_32 is 32	--	100000B;

   KEY_READ: INTEGER_32 is
      once
         Result := (STANDARD_RIGHTS_READ | KEY_QUERY_VALUE |
                    KEY_ENUMERATE_SUB_KEYS | KEY_NOTIFY) 
            & (SYNCHRONIZE).bit_not
      end


   KEY_WRITE: INTEGER_32 is
      once
         Result := (STANDARD_RIGHTS_WRITE | KEY_SET_VALUE |
                    KEY_CREATE_SUB_KEY) & (SYNCHRONIZE).bit_not
      end

   KEY_EXECUTE: INTEGER_32 is
      once
         Result := KEY_READ & (SYNCHRONIZE).bit_not
      end

   KEY_ALL_ACCESS: INTEGER_32 is
      once
         Result := (STANDARD_RIGHTS_ALL | KEY_QUERY_VALUE |
                    KEY_SET_VALUE | KEY_CREATE_SUB_KEY |
                    KEY_ENUMERATE_SUB_KEYS | KEY_NOTIFY | KEY_CREATE_LINK)
            & (SYNCHRONIZE).bit_not

      end

   HKEY_CLASSES_ROOT: POINTER is
      external "C inline"
      alias "(void *)(0x80000000)"
      end
      
   HKEY_CURRENT_USER: POINTER is
      external "C inline"
      alias "(void *)(0x80000001)"
      end
      
   HKEY_LOCAL_MACHINE: POINTER is
      external "C inline"
      alias "(void *)(0x80000002)"
      end
      
   HKEY_USERS: POINTER is
      external "C inline"
      alias "(void *)(0x80000003)"
      end
      
   HKEY_PERFORMANCE_DATA: POINTER is
      external "C inline"
      alias "(void *)(0x80000004)"
      end
      
   HKEY_CURRENT_CONFIG: POINTER is
      external "C inline"
      alias "(void *)(0x80000005)"
      end
      
   HKEY_DYN_DATA: POINTER is
      external "C inline"
      alias "(void *)(0x80000006)"
      end

end
