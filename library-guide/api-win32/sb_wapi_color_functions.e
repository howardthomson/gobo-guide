expanded class SB_WAPI_COLOR_FUNCTIONS

feature -- Access


   RealizePalette(hdc: POINTER): INTEGER





      external "C use <windows.h>"
      alias "RealizePalette"





      end
	----------------------------------
	
   CreateHalftonePalette (hDC: POINTER): POINTER





      external "C use <windows.h>"
      alias "CreateHalftonePalette"





      end
	----------------------------------

   CreatePalette (lplgpl: POINTER): POINTER





      external "C use <windows.h>"
      alias "CreatePalette"





      end
	----------------------------------

   SelectPalette (hDC, hpal: POINTER; bForceBackground: INTEGER): POINTER





      external "C use <windows.h>"
      alias "SelectPalette"





      end
	----------------------------------

   SetPaletteEntries (hpal: POINTER; iStart, cEntries: INTEGER; lppe: POINTER): INTEGER





      external "C use <windows.h>"
      alias "SetPaletteEntries"





      end
	----------------------------------

end
