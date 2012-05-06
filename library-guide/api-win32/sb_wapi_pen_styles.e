expanded class SB_WAPI_PEN_STYLES

feature -- Class data

	PS_SOLID             : INTEGER_32 = 0	--	                   0B; -- 0
	PS_DASH              : INTEGER_32 = 1	--	                   1B; -- 1 -------
	PS_DOT               : INTEGER_32 = 2	--	                  10B; -- 2 .......
	PS_DASHDOT           : INTEGER_32 = 3	--	                  11B; -- 3 _._._._
	PS_DASHDOTDOT        : INTEGER_32 = 4	--	                 100B; -- 4 _.._.._
	PS_NULL              : INTEGER_32 = 5	--	                 101B; -- 5
	PS_INSIDEFRAME       : INTEGER_32 = 6	--	                 110B; -- 6
	PS_USERSTYLE         : INTEGER_32 = 7	--	                 111B; -- 7
	PS_ALTERNATE         : INTEGER_32 = 8	--	                1000B; -- 8
	PS_STYLE_MASK        : INTEGER_32 = 15	--	                1111B; -- 0x0000000F

	PS_ENDCAP_ROUND      : INTEGER_32 = 0x00000000	--	                   0B; -- 0x00000000
	PS_ENDCAP_SQUARE     : INTEGER_32 = 0x00000100	--	           100000000B; -- 0x00000100
	PS_ENDCAP_FLAT       : INTEGER_32 = 0x00000200	--	          1000000000B; -- 0x00000200
	PS_ENDCAP_MASK       : INTEGER_32 = 0x00000F00	--	        111100000000B; -- 0x00000F00

	PS_JOIN_ROUND        : INTEGER_32 = 0x00000000	--	                   0B; -- 0x00000000
	PS_JOIN_BEVEL        : INTEGER_32 = 0x00001000	--	       1000000000000B; -- 0x00001000
	PS_JOIN_MITER        : INTEGER_32 = 0x00002000	--	      10000000000000B; -- 0x00002000
	PS_JOIN_MASK         : INTEGER_32 = 0x0000F000	--	    1111000000000000B; -- 0x0000F000

	PS_COSMETIC          : INTEGER_32 = 0x00000000	--	                   0B; -- 0x00000000
	PS_GEOMETRIC         : INTEGER_32 = 0x00010000	--	   10000000000000000B; -- 0x00010000
	PS_TYPE_MASK         : INTEGER_32 = 0x000F0000	--	11110000000000000000B; -- 0x000F0000

	AD_COUNTERCLOCKWISE  : INTEGER_32 = 1	--	                   1B; -- 1
	AD_CLOCKWISE         : INTEGER_32 = 2	--	                  10B; -- 2

end
