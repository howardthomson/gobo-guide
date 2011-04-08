expanded class SB_WAPI_FILES_AND_DIRS_ACCESS_RIGHTS

inherit

   SB_WAPI_STANDARD_ACCESS_MASKS

feature -- Class data

   FILE_READ_DATA                : INTEGER_32 is 0x00000001	--	        1B; -- 0x0001 File and Pipe
   FILE_LIST_DIRECTORY           : INTEGER_32 is 0x00000001	--	        1B; -- 0x0001 Directory

   FILE_WRITE_DATA               : INTEGER_32 is 0x00000002	--	       10B; -- 0x0002 File and Pipe
   FILE_ADD_FILE                 : INTEGER_32 is 0x00000002	--	       10B; -- 0x0002 Directory

   FILE_APPEND_DATA              : INTEGER_32 is 0x00000004	--	      100B; -- 0x0004 File
   FILE_ADD_SUBDIRECTORY         : INTEGER_32 is 0x00000004	--	      100B; -- 0x0004 Directory
   FILE_CREATE_PIPE_INSTANCE     : INTEGER_32 is 0x00000004	--	      100B; -- 0x0004 Named Pipe

   FILE_READ_EA,
   FILE_READ_PROPERTIES          : INTEGER_32 is 0x00000008	--	     1000B; -- 0x0008 File and Directory

   FILE_WRITE_EA,
   FILE_WRITE_PROPERTIES         : INTEGER_32 is 0x00000010	--	    10000B; -- 0x0010 File and Directory

   FILE_EXECUTE                  : INTEGER_32 is 0x00000020	--	   100000B; -- 0x0020 File
   FILE_TRAVERSE                 : INTEGER_32 is 0x00000020	--	   100000B; -- 0x0020 Directory

   FILE_DELETE_CHILD             : INTEGER_32 is 0x00000040	--	  1000000B; -- 0x0040 Directory

   FILE_READ_ATTRIBUTES          : INTEGER_32 is 0x00000080	--	 10000000B; -- 0x0080 All

   FILE_WRITE_ATTRIBUTES         : INTEGER_32 is 0x00000100	--	100000000B; -- 0x0100 All

   FILE_ALL_ACCESS : INTEGER_32 is
      once
         Result := STANDARD_RIGHTS_REQUIRED | SYNCHRONIZE | 0x000001FF	-- 0000000111111111B
      end

	FILE_GENERIC_READ : INTEGER_32 is
		once
			Result := STANDARD_RIGHTS_READ
					| FILE_READ_DATA
					| FILE_READ_ATTRIBUTES
					| FILE_READ_EA
					| SYNCHRONIZE
		end

	FILE_GENERIC_WRITE : INTEGER_32 is
		once
			Result := STANDARD_RIGHTS_WRITE
			| FILE_WRITE_DATA
			| FILE_WRITE_ATTRIBUTES
			| FILE_WRITE_EA
			| FILE_APPEND_DATA
			| SYNCHRONIZE
      end

	FILE_GENERIC_EXECUTE : INTEGER_32 is
		once
			Result := STANDARD_RIGHTS_EXECUTE
			| FILE_READ_ATTRIBUTES
			| FILE_EXECUTE
			| SYNCHRONIZE
		end

feature -- Special values





   Invalid_handle_value: POINTER is
      external "C inline"
      alias "((void*)-1)"
      end


   INVALID_FILE_SIZE    :  INTEGER is -1; -- (DWORD)0xFFFFFFFF

feature -- File sharing modes

   FILE_SHARE_READ               : INTEGER_32 is 0x00000001   --          1B; -- 0x00000001
   FILE_SHARE_WRITE              : INTEGER_32 is 0x00000002   --         10B; -- 0x00000002
   FILE_SHARE_DELETE             : INTEGER_32 is 0x00000004   --        100B; -- 0x00000004

feature -- File attributes

   FILE_ATTRIBUTE_READONLY       : INTEGER_32 is 0x00000001	--	               1B; -- 0x00000001
   FILE_ATTRIBUTE_HIDDEN         : INTEGER_32 is 0x00000002	--	              10B; -- 0x00000002
   FILE_ATTRIBUTE_SYSTEM         : INTEGER_32 is 0x00000004	--	             100B; -- 0x00000004
   FILE_ATTRIBUTE_DIRECTORY      : INTEGER_32 is 0x00000010	--	           10000B; -- 0x00000010
   FILE_ATTRIBUTE_ARCHIVE        : INTEGER_32 is 0x00000020	--	          100000B; -- 0x00000020
   FILE_ATTRIBUTE_NORMAL         : INTEGER_32 is 0x00000080	--	        10000000B; -- 0x00000080
   FILE_ATTRIBUTE_TEMPORARY      : INTEGER_32 is 0x00000100	--	       100000000B; -- 0x00000100
   FILE_ATTRIBUTE_ATOMIC_WRITE   : INTEGER_32 is 0x00000200	--	      1000000000B; -- 0x00000200
   FILE_ATTRIBUTE_XACTION_WRITE  : INTEGER_32 is 0x00000400	--	     10000000000B; -- 0x00000400
   FILE_ATTRIBUTE_COMPRESSED     : INTEGER_32 is 0x00000800	--	    100000000000B; -- 0x00000800
   FILE_ATTRIBUTE_OFFLINE        : INTEGER_32 is 0x00001000	--	   1000000000000B; -- 0x00001000

feature -- Notify filter

   FILE_NOTIFY_CHANGE_FILE_NAME  : INTEGER_32 is 0x00000001	--	               1B; -- 0x00000001
   FILE_NOTIFY_CHANGE_DIR_NAME   : INTEGER_32 is 0x00000002	--	              10B; -- 0x00000002
   FILE_NOTIFY_CHANGE_ATTRIBUTES : INTEGER_32 is 0x00000004	--	             100B; -- 0x00000004
   FILE_NOTIFY_CHANGE_SIZE       : INTEGER_32 is 0x00000008	--	            1000B; -- 0x00000008
   FILE_NOTIFY_CHANGE_LAST_WRITE : INTEGER_32 is 0x00000010	--	           10000B; -- 0x00000010
   FILE_NOTIFY_CHANGE_SECURITY   : INTEGER_32 is 0x00000100	--	       100000000B; -- 0x00000100

feature -- Misc

   MAILSLOT_NO_MESSAGE           : INTEGER_32 is 0xffffffff	--	11111111111111111111111111111111B; -- -1
   MAILSLOT_WAIT_FOREVER         : INTEGER_32 is 0xffffffff	--	11111111111111111111111111111111B; -- -1

   FILE_CASE_SENSITIVE_SEARCH    : INTEGER_32 is 0x00000001	--	               1B; -- 0x00000001
   FILE_CASE_PRESERVED_NAMES     : INTEGER_32 is 0x00000002	--	              10B; -- 0x00000002
   FILE_UNICODE_ON_DISK          : INTEGER_32 is 0x00000004	--	             100B; -- 0x00000004
   FILE_PERSISTENT_ACLS          : INTEGER_32 is 0x00000008	--	            1000B; -- 0x00000008
   FILE_FILE_COMPRESSION         : INTEGER_32 is 0x00000010	--	           10000B; -- 0x00000010
   FILE_VOLUME_IS_COMPRESSED     : INTEGER_32 is 0x00008000	--	1000000000000000B; -- 0x00008000

   IO_COMPLETION_MODIFY_STATE    : INTEGER_32 is 0x00000002	--              10B; -- 0x0002

   IO_COMPLETION_ALL_ACCESS : INTEGER_32 is
      once
         Result := STANDARD_RIGHTS_REQUIRED | SYNCHRONIZE | 0x00000003	-- 00000011B; -- 0x3
      end

feature -- `DuplicateHandle' Flags

   DUPLICATE_CLOSE_SOURCE        : INTEGER_32 is 0x00000001	--	 1B; -- 0x00000001
   DUPLICATE_SAME_ACCESS         : INTEGER_32 is 0x00000002	--	10B; -- 0x00000002

end