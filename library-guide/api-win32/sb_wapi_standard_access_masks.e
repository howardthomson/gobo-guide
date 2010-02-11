expanded class SB_WAPI_STANDARD_ACCESS_MASKS

feature

   DELETE                   : INTEGER_32 is 0x00010000	--         10000000000000000B
   STANDARD_RIGHTS_EXECUTE,
   STANDARD_RIGHTS_READ,
   STANDARD_RIGHTS_WRITE,
   READ_CONTROL             : INTEGER_32 is 0x00020000	--        100000000000000000B
   WRITE_DAC                : INTEGER_32 is 0x00040000	--       1000000000000000000B
   WRITE_OWNER              : INTEGER_32 is 0x00080000	--      10000000000000000000B
   SYNCHRONIZE              : INTEGER_32 is 0x00100000	--     100000000000000000000B

   STANDARD_RIGHTS_REQUIRED : INTEGER_32 is 0x000F0000	--	    11110000000000000000B

   STANDARD_RIGHTS_ALL      : INTEGER_32 is 0x001F0000	--	   111110000000000000000B

   SPECIFIC_RIGHTS_ALL      : INTEGER_32 is 0x0000FFFF	--	        1111111111111111B


   ACCESS_SYSTEM_SECURITY   : INTEGER_32 is 0x01000000	--	  1000000000000000000000000B


   MAXIMUM_ALLOWED          : INTEGER_32 is 0x02000000	--	 10000000000000000000000000B

   Generic_read    : INTEGER_32 is 0x80000000	--	   10000000000000000000000000000000B
   GENERIC_WRITE   : INTEGER_32 is 0x40000000	--	    1000000000000000000000000000000B
   GENERIC_EXECUTE : INTEGER_32 is 0x20000000 	--	     100000000000000000000000000000B
   GENERIC_ALL     : INTEGER_32 is 0x10000000 	--	      10000000000000000000000000000B

end
