expanded class SB_WAPI_STOCK_LOGICAL_OBJECTS

feature -- Class data

   WHITE_BRUSH          : INTEGER is  0;
   LTGRAY_BRUSH         : INTEGER is  1;
   GRAY_BRUSH           : INTEGER is  2;
   DKGRAY_BRUSH         : INTEGER is  3;
   BLACK_BRUSH          : INTEGER is  4;
   HOLLOW_BRUSH,
   NULL_BRUSH           : INTEGER is  5;

   WHITE_PEN            : INTEGER is  6;
   BLACK_PEN            : INTEGER is  7;
   NULL_PEN             : INTEGER is  8;

   OEM_FIXED_FONT       : INTEGER is 10;
   ANSI_FIXED_FONT      : INTEGER is 11;
   ANSI_VAR_FONT        : INTEGER is 12;
   SYSTEM_FONT          : INTEGER is 13;
   DEVICE_DEFAULT_FONT  : INTEGER is 14;
   DEFAULT_PALETTE      : INTEGER is 15;
   SYSTEM_FIXED_FONT,
   STOCK_LAST           : INTEGER is 16;

   CLR_INVALID          : INTEGER is -1;

end
