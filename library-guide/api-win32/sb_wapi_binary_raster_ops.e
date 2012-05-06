expanded class SB_WAPI_BINARY_RASTER_OPS

feature -- Class data

   R2_BLACK       : INTEGER =  1 -- 0
   R2_NOTMERGEPEN : INTEGER =  2 -- DPon
   R2_MASKNOTPEN  : INTEGER =  3 -- DPna
   R2_NOTCOPYPEN  : INTEGER =  4 -- PN
   R2_MASKPENNOT  : INTEGER =  5 -- PDna
   R2_NOT         : INTEGER =  6 -- Dn
   R2_XORPEN      : INTEGER =  7 -- DPx
   R2_NOTMASKPEN  : INTEGER =  8 -- DPan
   R2_MASKPEN     : INTEGER =  9 -- DPa
   R2_NOTXORPEN   : INTEGER = 10 -- DPxn
   R2_NOP         : INTEGER = 11 -- D
   R2_MERGENOTPEN : INTEGER = 12 -- DPno
   R2_COPYPEN     : INTEGER = 13 -- P
   R2_MERGEPENNOT : INTEGER = 14 -- PDno
   R2_MERGEPEN    : INTEGER = 15 -- DPo
   R2_WHITE,
   R2_LAST        : INTEGER = 16 -- 1

end
