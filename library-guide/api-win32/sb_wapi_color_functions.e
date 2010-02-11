expanded class SB_WAPI_COLOR_FUNCTIONS

feature -- Access


   RealizePalette(hdc: POINTER): INTEGER is





      external "C use <windows.h>"
      alias "RealizePalette"





      end
	----------------------------------
	
   CreateHalftonePalette (hDC: POINTER): POINTER is





      external "C use <windows.h>"
      alias "CreateHalftonePalette"





      end
	----------------------------------

   CreatePalette (lplgpl: POINTER): POINTER is





      external "C use <windows.h>"
      alias "CreatePalette"





      end
	----------------------------------

   SelectPalette (hDC, hpal: POINTER; bForceBackground: INTEGER): POINTER is





      external "C use <windows.h>"
      alias "SelectPalette"





      end
	----------------------------------

   SetPaletteEntries (hpal: POINTER; iStart, cEntries: INTEGER; lppe: POINTER): INTEGER is





      external "C use <windows.h>"
      alias "SetPaletteEntries"





      end
	----------------------------------

end
