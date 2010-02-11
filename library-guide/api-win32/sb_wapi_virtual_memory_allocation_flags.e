expanded class SB_WAPI_VIRTUAL_MEMORY_ALLOCATION_FLAGS

feature

   PAGE_NOACCESS           :  INTEGER_32 is 0x00000001	--	                            1B; -- 0x01
   Page_readonly           :  INTEGER_32 is 0x00000002	--	                           10B; -- 0x02
   PAGE_READWRITE          :  INTEGER_32 is 0x00000004	--	                          100B; -- 0x04
   PAGE_WRITECOPY          :  INTEGER_32 is 0x00000008	--	                         1000B; -- 0x08
   PAGE_EXECUTE            :  INTEGER_32 is 0x00000010	--	                        10000B; -- 0x10
   PAGE_EXECUTE_READ       :  INTEGER_32 is 0x00000020	--	                       100000B; -- 0x20
   PAGE_EXECUTE_READWRITE  :  INTEGER_32 is 0x00000040	--	                      1000000B; -- 0x40
   PAGE_EXECUTE_WRITECOPY  :  INTEGER_32 is 0x00000080	--	                     10000000B; -- 0x80
   PAGE_GUARD              :  INTEGER_32 is 0x00000100 	--	                    100000000B; -- 0x100
   PAGE_NOCACHE            :  INTEGER_32 is 0x00000200	--	                   1000000000B; -- 0x200

   MEM_COMMIT              :  INTEGER_32 is 0x00001000	--	                1000000000000B; -- 0x1000
   MEM_RESERVE             :  INTEGER_32 is 0x00002000	--	               10000000000000B; -- 0x2000
   MEM_DECOMMIT            :  INTEGER_32 is 0x00004000	--	              100000000000000B; -- 0x4000
   MEM_RELEASE             :  INTEGER_32 is 0x00008000	--	             1000000000000000B; -- 0x8000
   MEM_FREE                :  INTEGER_32 is 0x00010000	--	            10000000000000000B; -- 0x10000
   MEM_PRIVATE             :  INTEGER_32 is 0x00020000	--	           100000000000000000B; -- 0x20000
   MEM_MAPPED              :  INTEGER_32 is 0x00040000	--	          1000000000000000000B; -- 0x40000
   MEM_RESET               :  INTEGER_32 is 0x00080000	--	         10000000000000000000B; -- 0x80000
   MEM_TOP_DOWN            :  INTEGER_32 is 0x00100000	--	        100000000000000000000B; -- 0x100000
   SEC_FILE                :  INTEGER_32 is 0x00800000	--	     100000000000000000000000B; -- 0x800000
   MEM_IMAGE,
   SEC_IMAGE               :  INTEGER_32 is 0x01000000	--	    1000000000000000000000000B; -- 0x1000000
   SEC_RESERVE             :  INTEGER_32 is 0x04000000	--	  100000000000000000000000000B; -- 0x4000000
   SEC_COMMIT              :  INTEGER_32 is 0x08000000	--	 1000000000000000000000000000B; -- 0x8000000
   SEC_NOCACHE             :  INTEGER_32 is 0x10000000	--	10000000000000000000000000000B; -- 0x10000000

end
