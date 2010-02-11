expanded class SB_WAPI_TERNARY_RASTER_OPERATIONS

feature -- Class data

   SRCCOPY     : INTEGER is 13369376; -- 0x00CC0020 dest = source
   SRCPAINT    : INTEGER is 15597702; -- 0x00EE0086 dest = source OR dest
   SRCAND      : INTEGER is  8913094; -- 0x008800C6 dest = source AND dest
   SRCINVERT   : INTEGER is  6684742; -- 0x00660046 dest = source XOR dest
   SRCERASE    : INTEGER is  4457256; -- 0x00440328 dest = source AND (NOT dest)
   NOTSRCCOPY  : INTEGER is  3342344; -- 0x00330008 dest = (NOT source)
   NOTSRCERASE : INTEGER is  1114278; -- 0x001100A6 dest = (NOT src) AND (NOT dest)
   MERGECOPY   : INTEGER is 12583114; -- 0x00C000CA dest = (source AND pattern)
   MERGEPAINT  : INTEGER is 12255782; -- 0x00BB0226 dest = (NOT source) OR dest
   PATCOPY     : INTEGER is 15728673; -- 0x00F00021 dest = pattern
   PATPAINT    : INTEGER is 16452105; -- 0x00FB0A09 dest = DPSnoo
   PATINVERT   : INTEGER is  5898313; -- 0x005A0049 dest = pattern XOR dest
   DSTINVERT   : INTEGER is  5570569; -- 0x00550009 dest = (NOT dest)
   BLACKNESS   : INTEGER is       66; -- 0x00000042 dest = BLACK
   WHITENESS   : INTEGER is 16711778; -- 0x00FF0062 dest = WHITE

end
