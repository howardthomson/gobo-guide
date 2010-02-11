expanded class SB_WAPI_REGION_FUNCTIONS

feature

   NULLREGION: INTEGER is 1;
         -- Region is empty.
   SIMPLEREGION: INTEGER is 2;
         -- Region is a single rectangle.
   COMPLEXREGION: INTEGER is 3;
         -- Region is more than one rectangle.

feature -- Access

   CombineRgn (hRgnDest, hRgnSrc1, hRgnSrc2: POINTER; fnCombineMode: INTEGER): INTEGER is





      external "C use <windows.h>"
      alias "CombineRgn"





      end

   CreateEllipticRgn (nLeftRect, nTopRect, nRightRect, nBottomRect: INTEGER): POINTER is





      external "C use <windows.h>"
      alias "CreateEllipticRgn"





      end

   CreateRectRgn (nLeftRect, nTopRect, nRightRect, nBottomRect: INTEGER): POINTER is





      external "C use <windows.h>"
      alias "CreateRectRgn"





      end

   FillRgn (hDC, hRgn, hBr: POINTER): INTEGER is





      external "C use <windows.h>"
      alias "FillRgn"





      end

   GetPolyFillMode (hDC: POINTER): INTEGER is





      external "C use <windows.h>"
      alias "GetPolyFillMode"





      end

   SetPolyFillMode (hDC: POINTER; iPolyFillMode: INTEGER): INTEGER is





      external "C use <windows.h>"
      alias "SetPolyFillMode"





      end

   CreateRectRgnIndirect (lprc1: POINTER): POINTER is





      external "C use <windows.h>"
      alias "CreateRectRgnIndirect"





      end

   CreatePolygonRgn (lppt: POINTER; cPoints: INTEGER; fnPolyFillMode: INTEGER): POINTER is





      external "C use <windows.h>"
      alias "CreatePolygonRgn"





      end

   PtInRegion (hrgn: POINTER; X: INTEGER; Y: INTEGER): INTEGER is





      external "C use <windows.h>"
      alias "PtInRegion"





      end

   OffsetRgn (hrgn: POINTER; nXOffset, nYOffset: INTEGER): INTEGER is





      external "C use <windows.h>"
      alias "OffsetRgn"





      end

   RectInRegion (hrgn: POINTER; lprc: POINTER): INTEGER is





      external "C use <windows.h>"
      alias "RectInRegion"





      end

   GetRgnBox (hrgn: POINTER; lprc: POINTER): INTEGER is





      external "C use <windows.h>"
      alias "GetRgnBox"





      end

   EqualRgn (hSrcRgn1, hSrcRgn2: POINTER): INTEGER is





      external "C use <windows.h>"
      alias "EqualRgn"





      end

end
