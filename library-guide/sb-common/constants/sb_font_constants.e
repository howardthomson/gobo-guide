indexing
   description: "SB_FONT constants"
   author: "Eugene Melekhov <eugene_melekhov@mail.ru>"
   copyright: "Copyright (c) 2002, Eugene Melekhov and others"
   license: "Eiffel Forum Freeware License v2 (see forum.txt)"
   status: "mostly complete"

class SB_FONT_CONSTANTS

feature

   -- Font style hints which influence the matcher

	FONTPITCH_DEFAULT    : INTEGER is 0 				-- 0B;         		-- Default pitch
	FONTPITCH_FIXED      : INTEGER is 0x00000001 	-- 1B;         		-- Fixed pitch; mono-spaced
	FONTPITCH_VARIABLE   : INTEGER is 0x00000002 	-- 10B;         	-- Variable pitch; proportional spacing
	FONTHINT_DONTCARE    : INTEGER is 0 				-- 0B;         		-- Don't care which font
	FONTHINT_DECORATIVE  : INTEGER is 0x00000004 	-- 100B;         	-- Fancy fonts
	FONTHINT_MODERN      : INTEGER is 0x00000008 	-- 1000B;         	-- Monospace typewriter font
	FONTHINT_ROMAN       : INTEGER is 0x00000010 	-- 10000B;        	-- Variable width times-like font; serif
	FONTHINT_SCRIPT      : INTEGER is 0x00000020 	-- 100000B;        	-- Script or cursive
	FONTHINT_SWISS       : INTEGER is 0x00000040 	-- 1000000B;        -- Helvetica/swiss type font; sans-serif
	FONTHINT_SYSTEM      : INTEGER is 0x00000080 	-- 10000000B;       -- System font
	FONTHINT_X11         : INTEGER is 0x00000100 	-- 100000000B;      -- X11 Font string
	FONTHINT_SCALABLE    : INTEGER is 0x00000200 	-- 1000000000B;     -- Scalable fonts
	FONTHINT_POLYMORPHIC : INTEGER is 0x00000800 	-- 10000000000B;	-- Polymorphic fonts

   -- Font slant
   FONTSLANT_DONTCARE        : INTEGER is  0;    -- Don't care about slant
   FONTSLANT_REGULAR         : INTEGER is  1;    -- Regular straight up
   FONTSLANT_ITALIC          : INTEGER is  2;    -- Italics
   FONTSLANT_OBLIQUE         : INTEGER is  3;    -- Oblique slant
   FONTSLANT_REVERSE_ITALIC  : INTEGER is  4;    -- Reversed italic
   FONTSLANT_REVERSE_OBLIQUE : INTEGER is  5     -- Reversed oblique


   -- Font character set encoding

   FONTENCODING_DEFAULT     : INTEGER is  0;                         -- Don't care character encoding
   FONTENCODING_ISO_8859_1  : INTEGER is  1;
   FONTENCODING_ISO_8859_2  : INTEGER is  2;
   FONTENCODING_ISO_8859_3  : INTEGER is  3;
   FONTENCODING_ISO_8859_4  : INTEGER is  4;
   FONTENCODING_ISO_8859_5  : INTEGER is  5;
   FONTENCODING_ISO_8859_6  : INTEGER is  6;
   FONTENCODING_ISO_8859_7  : INTEGER is  7;
   FONTENCODING_ISO_8859_8  : INTEGER is  8;
   FONTENCODING_ISO_8859_9  : INTEGER is  9;
   FONTENCODING_ISO_8859_10 : INTEGER is  10;
   FONTENCODING_ISO_8859_11 : INTEGER is  11;
   FONTENCODING_ISO_8859_15 : INTEGER is  15;
   FONTENCODING_KOI_8       : INTEGER is  16;
   FONTENCODING_USASCII     : INTEGER is  once Result := FONTENCODING_ISO_8859_1 end;   -- Latin 1
   FONTENCODING_EASTEUROPE  : INTEGER is  once Result := FONTENCODING_ISO_8859_2 end;   -- East European
   FONTENCODING_TURKISH     : INTEGER is  once Result := FONTENCODING_ISO_8859_3 end;   -- Turkish
   FONTENCODING_BALTIC      : INTEGER is  once Result := FONTENCODING_ISO_8859_4 end;   -- Baltic
   FONTENCODING_RUSSIAN     : INTEGER is  once Result := FONTENCODING_ISO_8859_5 end;   -- Cyrillic
   FONTENCODING_ARABIC      : INTEGER is  once Result := FONTENCODING_ISO_8859_6 end;   -- Arabic
   FONTENCODING_GREEK       : INTEGER is  once Result := FONTENCODING_ISO_8859_7 end;   -- Greek
   FONTENCODING_HEBREW      : INTEGER is  once Result := FONTENCODING_ISO_8859_8 end;   -- Hebrew
   FONTENCODING_THAI        : INTEGER is  once Result := FONTENCODING_ISO_8859_11 end   -- Thai


   -- Font weight

   FONTWEIGHT_DONTCARE   : INTEGER is  0;        -- Don't care about weight
   FONTWEIGHT_THIN       : INTEGER is  100;      -- Thin
   FONTWEIGHT_EXTRALIGHT : INTEGER is  200;      -- Extra light
   FONTWEIGHT_LIGHT      : INTEGER is  300;      -- Light
   FONTWEIGHT_NORMAL     : INTEGER is  400;      -- Normal or regular weight
   FONTWEIGHT_REGULAR    : INTEGER is  400;      -- Normal or regular weight
   FONTWEIGHT_MEDIUM     : INTEGER is  500;      -- Medium bold face
   FONTWEIGHT_DEMIBOLD   : INTEGER is  600;      -- Demi bold face
   FONTWEIGHT_BOLD       : INTEGER is  700;      -- Bold face
   FONTWEIGHT_EXTRABOLD  : INTEGER is  800;      -- Extra
   FONTWEIGHT_HEAVY      : INTEGER is  900;      -- Heavy
   FONTWEIGHT_BLACK      : INTEGER is  900       -- Black

   -- Font relative setwidth

   FONTSETWIDTH_DONTCARE       : INTEGER is  0;    -- Don't care about set width
   FONTSETWIDTH_ULTRACONDENSED : INTEGER is  10;   -- Ultra condensed printing
   FONTSETWIDTH_EXTRACONDENSED : INTEGER is  20;   -- Extra condensed
   FONTSETWIDTH_CONDENSED      : INTEGER is  30;   -- Condensed
   FONTSETWIDTH_NARROW         : INTEGER is  30;   -- Narrow
   FONTSETWIDTH_COMPRESSED     : INTEGER is  30;   -- Compressed
   FONTSETWIDTH_SEMICONDENSED  : INTEGER is  40;   -- Semi-condensed
   FONTSETWIDTH_MEDIUM         : INTEGER is  50;   -- Medium printing
   FONTSETWIDTH_NORMAL         : INTEGER is  50;   -- Normal printing
   FONTSETWIDTH_REGULAR        : INTEGER is  50;   -- Regulat printing
   FONTSETWIDTH_SEMIEXPANDED   : INTEGER is  60;   -- Semi expanded
   FONTSETWIDTH_EXPANDED       : INTEGER is  70;   -- Expanded
   FONTSETWIDTH_WIDE           : INTEGER is  80;   -- Wide
   FONTSETWIDTH_EXTRAEXPANDED  : INTEGER is  80;   -- Extra expanded
   FONTSETWIDTH_ULTRAEXPANDED  : INTEGER is  90;   -- Ultra expanded
end