expanded class SB_WAPI_CLIPBOARD_FORMATS

feature -- Predefined Clipboard Formats
	CF_TEXT              : INTEGER_32 = 0x00000001	--	         1B; -- 0x01
	CF_BITMAP            : INTEGER_32 = 0x00000002	--	        10B; -- 0x02
	CF_METAFILEPICT      : INTEGER_32 = 0x00000003	--	        11B; -- 0x03
	CF_SYLK              : INTEGER_32 = 0x00000004	--	       100B; -- 0x04
	CF_DIF               : INTEGER_32 = 0x00000005	--	       101B; -- 0x05
	CF_TIFF              : INTEGER_32 = 0x00000006	--	       110B; -- 0x06
	CF_OEMTEXT           : INTEGER_32 = 0x00000007	--	       111B; -- 0x07
	CF_DIB               : INTEGER_32 = 0x00000008	--	      1000B; -- 0x08
	CF_PALETTE           : INTEGER_32 = 0x00000009	--	      1001B; -- 0x09
	CF_PENDATA           : INTEGER_32 = 0x0000000A	--	      1010B; -- 0x0A
	CF_RIFF              : INTEGER_32 = 0x0000000B	--	      1011B; -- 0x0B
	CF_WAVE              : INTEGER_32 = 0x0000000C	--	      1100B; -- 0x0C
	CF_UNICODETEXT       : INTEGER_32 = 0x0000000D	--	      1101B; -- 0x0D
	CF_ENHMETAFILE       : INTEGER_32 = 0x0000000E	--	      1110B; -- 0x0E

	CF_OWNERDISPLAY      : INTEGER_32 = 0x00000080	--	  10000000B; -- 0x80
	CF_DSPTEXT           : INTEGER_32 = 0x00000081	--	  10000001B; -- 0x81
	CF_DSPBITMAP         : INTEGER_32 = 0x00000082	--	  10000010B; -- 0x82
	CF_DSPMETAFILEPICT   : INTEGER_32 = 0x00000083	--	  10000011B; -- 0x83
	CF_DSPENHMETAFILE    : INTEGER_32 = 0x0000008E	--	  10001110B; -- 0x8E

feature -- "Private" formats don't get GlobalFree()'d

	CF_PRIVATEFIRST      : INTEGER_32 = 0x00000200	--	1000000000B; -- 0x0200
	CF_PRIVATELAST       : INTEGER_32 = 0x000002FF	--	1011111111B; -- 0x02FF

feature -- "GDIOBJ" formats do get DeleteObject()'d

	CF_GDIOBJFIRST       : INTEGER_32 = 0x00000300	--	1100000000B; -- 0x0300
	CF_GDIOBJLAST        : INTEGER_32 = 0x000003FF	--	1111111111B; -- 0x03FF

end
