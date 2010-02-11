expanded class SB_WAPI_TEXT_ALIGNMENT_OPTIONS

feature -- Class data

   TA_NOUPDATECP     : INTEGER is  0;
   TA_UPDATECP       : INTEGER is  1;

   TA_LEFT,
   VTA_TOP           : INTEGER is  0;
   TA_RIGHT,
   VTA_BOTTOM        : INTEGER is  2;
   TA_CENTER,
   VTA_CENTER        : INTEGER is  6;

   TA_TOP,
   VTA_RIGHT         : INTEGER is  0;
   TA_BOTTOM,
   VTA_LEFT          : INTEGER is  8;
   TA_BASELINE,
   VTA_BASELINE      : INTEGER is 24;

   TA_MASK : INTEGER is
   once
      Result := TA_BASELINE + TA_CENTER + TA_UPDATECP; -- 31
   end; -- TA_MASK

   ETO_GRAYED  : INTEGER_32 is 1	--   1B
   ETO_OPAQUE  : INTEGER_32 is 2 	--  10B
   ETO_CLIPPED : INTEGER_32 is 4	-- 100B

   ASPECT_FILTERING : INTEGER is 1;

end
