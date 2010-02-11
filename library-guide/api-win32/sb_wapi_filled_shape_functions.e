expanded class SB_WAPI_FILLED_SHAPE_FUNCTIONS

feature -- Access

   Chord (hDC: POINTER; nLeftRect, nTopRect, nRightRect, nBottomRect,
          nXRadial1, nYRadial1, nXRadial2, nYRadial2: INTEGER): INTEGER is





      external "C use <windows.h>"
      alias "Chord"





   end

   Ellipse (hDC: POINTER; nLeftRect, nTopRect, nRightRect, nBottomRect: INTEGER): INTEGER is





      external "C use <windows.h>"
      alias "Ellipse"





   end

   FillRect (hDC: POINTER; lprc: POINTER; hBr: INTEGER): INTEGER is





      external "C use <windows.h>"
      alias "FillRect"





   end

   InvertRect (hDC: POINTER; lprc: POINTER): INTEGER is





      external "C use <windows.h>"
      alias "InvertRect"





   end

   Pie (hDC: POINTER; nLeftRect, nTopRect, nRightRect, nBottomRect,
         nXRadial1, nYRadial1, nXRadial2, nYRadial2: INTEGER): INTEGER is





      external "C use <windows.h>"
      alias "Pie"





   end

   Rectangle (hDC: POINTER; nLeftRect, nTopRect, nRightRect, nBottomRect: INTEGER): INTEGER is





      external "C use <windows.h>"
      alias "Rectangle"





   end

   RoundRect (hDC: POINTER; nLeftRect, nTopRect, nRightRect, nBottomRect, nWidth, nHeight: INTEGER): INTEGER is





      external "C use <windows.h>"
      alias "RoundRect"





   end

   Polygon (hdc: POINTER; lpPoints: POINTER; nCount: INTEGER): INTEGER is





      external "C use <windows.h>"
      alias "Polygon"





   end

end
