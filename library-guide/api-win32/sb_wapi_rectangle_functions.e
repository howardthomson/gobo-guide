expanded class SB_WAPI_RECTANGLE_FUNCTIONS

feature -- Access

   PtInRect (lprc: POINTER; ptX, ptY: INTEGER): INTEGER
      external "C use <windows.h>"
      alias "PtInRect"
      end

   InflateRect (lprc: POINTER; dx, dy: INTEGER): INTEGER
      external "C use <windows.h>"
      alias "InflateRect"
      end

   OffsetRect (lprc: POINTER; dx, dy: INTEGER): INTEGER
      external "C use <windows.h>"
      alias "OffsetRect"
      end

   SetRect (lprc: POINTER; nLeft, nTop, nRight, nBottom: INTEGER): INTEGER
      external "C use <windows.h>"
      alias "SetRect"
      end

   SetRectEmpty (lprc: POINTER): INTEGER
      external "C use <windows.h>"
      alias "SetRectEmpty"
      end

   IntersectRect (lprcDst,lprcSrc1,lprcSrc2: POINTER): INTEGER
      external "C use <windows.h>"
      alias "IntersectRect"
      end

   EqualRect (lprc1,lprc2: POINTER): INTEGER
      external "C use <windows.h>"
      alias "EqualRect"
      end

   UnionRect (lprcDst,lprcSrc1,lprcSrc2: POINTER): INTEGER
      external "C use <windows.h>"
      alias "UnionRect"
      end

end
