expanded class SB_WAPI_STOCK_LOGICAL_OBJECTS

feature -- Class data

   WHITE_BRUSH          : INTEGER =  0;
   LTGRAY_BRUSH         : INTEGER =  1;
   GRAY_BRUSH           : INTEGER =  2;
   DKGRAY_BRUSH         : INTEGER =  3;
   BLACK_BRUSH          : INTEGER =  4;
   HOLLOW_BRUSH,
   NULL_BRUSH           : INTEGER =  5;

   WHITE_PEN            : INTEGER =  6;
   BLACK_PEN            : INTEGER =  7;
   NULL_PEN             : INTEGER =  8;

   OEM_FIXED_FONT       : INTEGER = 10;
   ANSI_FIXED_FONT      : INTEGER = 11;
   ANSI_VAR_FONT        : INTEGER = 12;
   SYSTEM_FONT          : INTEGER = 13;
   DEVICE_DEFAULT_FONT  : INTEGER = 14;
   DEFAULT_PALETTE      : INTEGER = 15;
   SYSTEM_FIXED_FONT,
   STOCK_LAST           : INTEGER = 16;

   CLR_INVALID          : INTEGER = -1;

end
