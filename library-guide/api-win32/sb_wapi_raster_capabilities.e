expanded class SB_WAPI_RASTER_CAPABILITIES

feature -- Class data

	RC_NONE         : INTEGER_32 = 0x00000000	--	               0B; --
	RC_BITBLT       : INTEGER_32 = 0x00000001	--	               1B; --      1 Can do standard BLT
	RC_BANDING      : INTEGER_32 = 0x00000002	--	              10B; --      2 Device requires banding support
	RC_SCALING      : INTEGER_32 = 0x00000004	--	             100B; --      4 Device requires scaling support
	RC_BITMAP64     : INTEGER_32 = 0x00000008	--	            1000B; --      8 Device can support > 64K bitmap
	RC_GDI20_OUTPUT : INTEGER_32 = 0x00000010	--	           10000B; -- 0x0010 Has 2.0 output calls
	RC_GDI20_STATE  : INTEGER_32 = 0x00000020	--	          100000B; -- 0x0020
	RC_SAVEBITMAP   : INTEGER_32 = 0x00000040	--	         1000000B; -- 0x0040
	RC_DI_BITMAP    : INTEGER_32 = 0x00000080	--	        10000000B; -- 0x0080 Supports DIB to memory
	RC_PALETTE      : INTEGER_32 = 0x00000100	--	       100000000B; -- 0x0100 Supports a palette
	RC_DIBTODEV     : INTEGER_32 = 0x00000200	--	      1000000000B; -- 0x0200 Supports DIBitsToDevice
	RC_BIGFONT      : INTEGER_32 = 0x00000400	--	     10000000000B; -- 0x0400 Supports > 64K fonts
	RC_STRETCHBLT   : INTEGER_32 = 0x00000800	--	    100000000000B; -- 0x0800 Supports StretchBlt
	RC_FLOODFILL    : INTEGER_32 = 0x00001000	--	   1000000000000B; -- 0x1000 Supports FloodFill
	RC_STRETCHDIB   : INTEGER_32 = 0x00002000	--	  10000000000000B; -- 0x2000 Supports StretchDIBits
	RC_OP_DX_OUTPUT : INTEGER_32 = 0x00004000	--	 100000000000000B; -- 0x4000
	RC_DEVBITS      : INTEGER_32 = 0x00008000	--	1000000000000000B; -- 0x8000

end
