expanded class SB_WAPI_TEXT_ALIGNMENT_OPTIONS

feature -- Class data

   TA_NOUPDATECP     : INTEGER =  0;
   TA_UPDATECP       : INTEGER =  1;

   TA_LEFT,
   VTA_TOP           : INTEGER =  0;
   TA_RIGHT,
   VTA_BOTTOM        : INTEGER =  2;
   TA_CENTER,
   VTA_CENTER        : INTEGER =  6;

   TA_TOP,
   VTA_RIGHT         : INTEGER =  0;
   TA_BOTTOM,
   VTA_LEFT          : INTEGER =  8;
   TA_BASELINE,
   VTA_BASELINE      : INTEGER = 24;

   TA_MASK : INTEGER
   once
      Result := TA_BASELINE + TA_CENTER + TA_UPDATECP; -- 31
   end; -- TA_MASK

   ETO_GRAYED  : INTEGER_32 = 1	--   1B
   ETO_OPAQUE  : INTEGER_32 = 2 	--  10B
   ETO_CLIPPED : INTEGER_32 = 4	-- 100B

   ASPECT_FILTERING : INTEGER = 1;

end
