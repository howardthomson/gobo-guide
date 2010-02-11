expanded class SB_WAPI_FONT_CLIPPING_PRECISION

feature -- Class data

	CLIP_DEFAULT_PRECIS     : INTEGER_8 is 0x00	--       0B; -- 0
	CLIP_CHARACTER_PRECIS   : INTEGER_8 is 0x01	--       1B; -- 1
	CLIP_STROKE_PRECIS      : INTEGER_8 is 0x02	--      10B; -- 2
	CLIP_MASK               : INTEGER_8 is 0x0f	--    1111B; -- 0xF

	CLIP_LH_ANGLES          : INTEGER_8 is 0x10	--     10000B; -- 1 << 4
	CLIP_TT_ALWAYS          : INTEGER_8 is 0x20	--	  100000B; -- 2 << 4
	CLIP_EMBEDDED           : INTEGER_8 is 0x80	--	10000000B; -- 8 << 4

end
