expanded class SB_WAPI_MESSAGE_BOX_FLAGS

feature -- Class data

   MB_OK                   : INTEGER_32 is 0x00000000	--                    0B; -- 0x00
   MB_OKCANCEL             : INTEGER_32 is 0x00000001	--                    1B; -- 0x01
   MB_ABORTRETRYIGNORE     : INTEGER_32 is 0x00000002	--                   10B; -- 0x02
   MB_YESNOCANCEL          : INTEGER_32 is 0x00000003	--	                 11B; -- 0x03
   MB_YESNO                : INTEGER_32 is 0x00000004	--	                100B; -- 0x04
   MB_RETRYCANCEL          : INTEGER_32 is 0x00000005	--	                101B; -- 0x05

   MB_ICONSTOP,
   MB_ICONHAND             : INTEGER_32 is 0x00000010	--	              10000B; -- 0x10
   MB_ICONQUESTION         : INTEGER_32 is 0x00000020	--	             100000B; -- 0x20
   MB_ICONEXCLAMATION      : INTEGER_32 is 0x00000030	--	             110000B; -- 0x30
   MB_ICONASTERISK,
   MB_ICONINFORMATION      : INTEGER_32 is 0x00000040	--	            1000000B; -- 0x40

   MB_DEFBUTTON1           : INTEGER_32 is 0x00000000	--	                  0B; -- 0x00
   MB_DEFBUTTON2           : INTEGER_32 is 0x00000100	--	          100000000B; -- 0x0100
   MB_DEFBUTTON3           : INTEGER_32 is 0x00000200	--	         1000000000B; -- 0x0200

   MB_APPLMODAL            : INTEGER_32 is 0x00000000	--	                  0B; -- 0x00
   MB_SYSTEMMODAL          : INTEGER_32 is 0x00001000	--	      1000000000000B; -- 0x1000
   MB_TASKMODAL            : INTEGER_32 is 0x00002000	--	     10000000000000B; -- 0x2000

   MB_NOFOCUS              : INTEGER_32 is 0x00008000	--	   1000000000000000B; -- 0x8000
   MB_SETFOREGROUND        : INTEGER_32 is 0x00010000	--	  10000000000000000B; -- 0x010000
   MB_DEFAULT_DESKTOP_ONLY : INTEGER_32 is 0x00020000	--	 100000000000000000B; -- 0x020000
   MB_SERVICE_NOTIFICATION : INTEGER_32 is 0x00040000	--	1000000000000000000B; -- 0x040000

   MB_TYPEMASK             : INTEGER_32 is 0x0000000F	--	               1111B; -- 0x0F
   MB_ICONMASK             : INTEGER_32 is 0x000000F0	--	           11110000B; -- 0xF0
   MB_DEFMASK              : INTEGER_32 is 0x00000F00	--	       111100000000B; -- 0x0F00
   MB_MODEMASK             : INTEGER_32 is 0x00003000	--	     11000000000000B; -- 0x3000
   MB_MISCMASK             : INTEGER_32 is 0x0000C000	--	   1100000000000000B; -- 0xC000

end
