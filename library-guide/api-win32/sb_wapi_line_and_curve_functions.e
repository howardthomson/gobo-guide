expanded class SB_WAPI_LINE_AND_CURVE_FUNCTIONS

feature -- Access

   Arc (hDC: POINTER; nLeftRect, nTopRect, nRightRect, nBottomRect,
        nXStartArc, nYStartArc, nXEndArc, nYEndArc: INTEGER): INTEGER





      external "C use <windows.h>"
      alias "Arc"





      end

   LineTo (hDC: POINTER; nXEnd, nYEnd: INTEGER): INTEGER





      external "C use <windows.h>"
      alias "LineTo"





      end

   MoveToEx (hDC: POINTER; X, Y: INTEGER; lpPoint: POINTER): INTEGER





      external "C use <windows.h>"
      alias "MoveToEx"





      end

   PolyBezier (hDC: POINTER; lppt: POINTER; cPoints: INTEGER): INTEGER





      external "C use <windows.h>"
      alias "PolyBezier"





      end

   PolyDraw (hDC: POINTER; lppt, lpbTypes: POINTER; cCount: INTEGER): INTEGER





      external "C use <windows.h>"
      alias "PolyDraw"





      end

   Polyline (hDC: POINTER; lppt: POINTER; cPoints: INTEGER): INTEGER





      external "C use <windows.h>"
      alias "Polyline"





      end

end
