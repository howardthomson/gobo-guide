expanded class SB_WAPI_BINARY_RASTER_OPS

feature -- Class data

   R2_BLACK       : INTEGER is  1 -- 0
   R2_NOTMERGEPEN : INTEGER is  2 -- DPon
   R2_MASKNOTPEN  : INTEGER is  3 -- DPna
   R2_NOTCOPYPEN  : INTEGER is  4 -- PN
   R2_MASKPENNOT  : INTEGER is  5 -- PDna
   R2_NOT         : INTEGER is  6 -- Dn
   R2_XORPEN      : INTEGER is  7 -- DPx
   R2_NOTMASKPEN  : INTEGER is  8 -- DPan
   R2_MASKPEN     : INTEGER is  9 -- DPa
   R2_NOTXORPEN   : INTEGER is 10 -- DPxn
   R2_NOP         : INTEGER is 11 -- D
   R2_MERGENOTPEN : INTEGER is 12 -- DPno
   R2_COPYPEN     : INTEGER is 13 -- P
   R2_MERGEPENNOT : INTEGER is 14 -- PDno
   R2_MERGEPEN    : INTEGER is 15 -- DPo
   R2_WHITE,
   R2_LAST        : INTEGER is 16 -- 1

end
