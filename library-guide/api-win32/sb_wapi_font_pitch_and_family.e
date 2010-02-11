expanded class SB_WAPI_FONT_PITCH_AND_FAMILY

feature -- Class data

	DEFAULT_PITCH  : INTEGER_8 is 0x00	--	 0B;
	FIXED_PITCH    : INTEGER_8 is 0x01	--	 1B;
	VARIABLE_PITCH : INTEGER_8 is 0x02	--	10B;

	FF_DONTCARE    : INTEGER_8 is 0x00	--	  00000B;
	FF_ROMAN       : INTEGER_8 is 0x10	--	  10000B;
	FF_SWISS       : INTEGER_8 is 0x20	--	 100000B;
	FF_MODERN      : INTEGER_8 is 0x30	--	 110000B;
	FF_SCRIPT      : INTEGER_8 is 0x40	--	1000000B;
	FF_DECORATIVE  : INTEGER_8 is 0x50	--	1010000B;

end
