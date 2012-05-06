note
   description: "SB_FONT constants"
   author: "Eugene Melekhov <eugene_melekhov@mail.ru>"
   copyright: "Copyright (c) 2002, Eugene Melekhov and others"
   license: "Eiffel Forum Freeware License v2 (see forum.txt)"
   status: "mostly complete"

class SB_FONT_CONSTANTS

feature

   -- Font style hints which influence the matcher

	FONTPITCH_DEFAULT    : INTEGER = 0 				-- 0B;         		-- Default pitch
	FONTPITCH_FIXED      : INTEGER = 0x00000001 	-- 1B;         		-- Fixed pitch; mono-spaced
	FONTPITCH_VARIABLE   : INTEGER = 0x00000002 	-- 10B;         	-- Variable pitch; proportional spacing
	FONTHINT_DONTCARE    : INTEGER = 0 				-- 0B;         		-- Don't care which font
	FONTHINT_DECORATIVE  : INTEGER = 0x00000004 	-- 100B;         	-- Fancy fonts
	FONTHINT_MODERN      : INTEGER = 0x00000008 	-- 1000B;         	-- Monospace typewriter font
	FONTHINT_ROMAN       : INTEGER = 0x00000010 	-- 10000B;        	-- Variable width times-like font; serif
	FONTHINT_SCRIPT      : INTEGER = 0x00000020 	-- 100000B;        	-- Script or cursive
	FONTHINT_SWISS       : INTEGER = 0x00000040 	-- 1000000B;        -- Helvetica/swiss type font; sans-serif
	FONTHINT_SYSTEM      : INTEGER = 0x00000080 	-- 10000000B;       -- System font
	FONTHINT_X11         : INTEGER = 0x00000100 	-- 100000000B;      -- X11 Font string
	FONTHINT_SCALABLE    : INTEGER = 0x00000200 	-- 1000000000B;     -- Scalable fonts
	FONTHINT_POLYMORPHIC : INTEGER = 0x00000800 	-- 10000000000B;	-- Polymorphic fonts

   -- Font slant
   FONTSLANT_DONTCARE        : INTEGER =  0;    -- Don't care about slant
   FONTSLANT_REGULAR         : INTEGER =  1;    -- Regular straight up
   FONTSLANT_ITALIC          : INTEGER =  2;    -- Italics
   FONTSLANT_OBLIQUE         : INTEGER =  3;    -- Oblique slant
   FONTSLANT_REVERSE_ITALIC  : INTEGER =  4;    -- Reversed italic
   FONTSLANT_REVERSE_OBLIQUE : INTEGER =  5     -- Reversed oblique


   -- Font character set encoding

   FONTENCODING_DEFAULT     : INTEGER =  0;                         -- Don't care character encoding
   FONTENCODING_ISO_8859_1  : INTEGER =  1;
   FONTENCODING_ISO_8859_2  : INTEGER =  2;
   FONTENCODING_ISO_8859_3  : INTEGER =  3;
   FONTENCODING_ISO_8859_4  : INTEGER =  4;
   FONTENCODING_ISO_8859_5  : INTEGER =  5;
   FONTENCODING_ISO_8859_6  : INTEGER =  6;
   FONTENCODING_ISO_8859_7  : INTEGER =  7;
   FONTENCODING_ISO_8859_8  : INTEGER =  8;
   FONTENCODING_ISO_8859_9  : INTEGER =  9;
   FONTENCODING_ISO_8859_10 : INTEGER =  10;
   FONTENCODING_ISO_8859_11 : INTEGER =  11;
   FONTENCODING_ISO_8859_15 : INTEGER =  15;
   FONTENCODING_KOI_8       : INTEGER =  16;
   FONTENCODING_USASCII     : INTEGER  once Result := FONTENCODING_ISO_8859_1 end;   -- Latin 1
   FONTENCODING_EASTEUROPE  : INTEGER  once Result := FONTENCODING_ISO_8859_2 end;   -- East European
   FONTENCODING_TURKISH     : INTEGER  once Result := FONTENCODING_ISO_8859_3 end;   -- Turkish
   FONTENCODING_BALTIC      : INTEGER  once Result := FONTENCODING_ISO_8859_4 end;   -- Baltic
   FONTENCODING_RUSSIAN     : INTEGER  once Result := FONTENCODING_ISO_8859_5 end;   -- Cyrillic
   FONTENCODING_ARABIC      : INTEGER  once Result := FONTENCODING_ISO_8859_6 end;   -- Arabic
   FONTENCODING_GREEK       : INTEGER  once Result := FONTENCODING_ISO_8859_7 end;   -- Greek
   FONTENCODING_HEBREW      : INTEGER  once Result := FONTENCODING_ISO_8859_8 end;   -- Hebrew
   FONTENCODING_THAI        : INTEGER  once Result := FONTENCODING_ISO_8859_11 end   -- Thai


   -- Font weight

   FONTWEIGHT_DONTCARE   : INTEGER =  0;        -- Don't care about weight
   FONTWEIGHT_THIN       : INTEGER =  100;      -- Thin
   FONTWEIGHT_EXTRALIGHT : INTEGER =  200;      -- Extra light
   FONTWEIGHT_LIGHT      : INTEGER =  300;      -- Light
   FONTWEIGHT_NORMAL     : INTEGER =  400;      -- Normal or regular weight
   FONTWEIGHT_REGULAR    : INTEGER =  400;      -- Normal or regular weight
   FONTWEIGHT_MEDIUM     : INTEGER =  500;      -- Medium bold face
   FONTWEIGHT_DEMIBOLD   : INTEGER =  600;      -- Demi bold face
   FONTWEIGHT_BOLD       : INTEGER =  700;      -- Bold face
   FONTWEIGHT_EXTRABOLD  : INTEGER =  800;      -- Extra
   FONTWEIGHT_HEAVY      : INTEGER =  900;      -- Heavy
   FONTWEIGHT_BLACK      : INTEGER =  900       -- Black

   -- Font relative setwidth

   FONTSETWIDTH_DONTCARE       : INTEGER =  0;    -- Don't care about set width
   FONTSETWIDTH_ULTRACONDENSED : INTEGER =  10;   -- Ultra condensed printing
   FONTSETWIDTH_EXTRACONDENSED : INTEGER =  20;   -- Extra condensed
   FONTSETWIDTH_CONDENSED      : INTEGER =  30;   -- Condensed
   FONTSETWIDTH_NARROW         : INTEGER =  30;   -- Narrow
   FONTSETWIDTH_COMPRESSED     : INTEGER =  30;   -- Compressed
   FONTSETWIDTH_SEMICONDENSED  : INTEGER =  40;   -- Semi-condensed
   FONTSETWIDTH_MEDIUM         : INTEGER =  50;   -- Medium printing
   FONTSETWIDTH_NORMAL         : INTEGER =  50;   -- Normal printing
   FONTSETWIDTH_REGULAR        : INTEGER =  50;   -- Regulat printing
   FONTSETWIDTH_SEMIEXPANDED   : INTEGER =  60;   -- Semi expanded
   FONTSETWIDTH_EXPANDED       : INTEGER =  70;   -- Expanded
   FONTSETWIDTH_WIDE           : INTEGER =  80;   -- Wide
   FONTSETWIDTH_EXTRAEXPANDED  : INTEGER =  80;   -- Extra expanded
   FONTSETWIDTH_ULTRAEXPANDED  : INTEGER =  90;   -- Ultra expanded
end