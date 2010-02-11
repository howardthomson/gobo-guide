expanded class SB_WAPI_FONT_AND_TEXT_FUNCTIONS

feature -- Access

   CreateFont ( nHeight, nWidth, nEscapement, nOrientation, fnWeight, fdwItalic,
                fdwUnderline, fdwStrikeOut, fdwCharSet, fdwOutputPrecision: INTEGER;
                fdwClipPrecision: INTEGER_32; fdwQuality: INTEGER;
                fdwPitchAndFamily : INTEGER_32; lpszFace: POINTER): POINTER is





      external "C use <windows.h>"
      alias "CreateFontA"





      end
	----------------------------------------

   GetTextColor (hDC: POINTER): INTEGER is





      external "C use <windows.h>"
      alias "GetTextColor"





      end
	----------------------------------------

   CreateFontIndirect (lplf: POINTER): POINTER is





      external "C use <windows.h>"
      alias "CreateFontIndirectA"





      end
	----------------------------------------

   ExtTextOut (hDC: POINTER; X, Y: INTEGER; fuOptions: INTEGER_32;
               lprc,lpString: POINTER; cbCount: INTEGER;
               lpDx: POINTER): INTEGER is





      external "C use <windows.h>"
      alias "ExtTextOutA"





      end
	----------------------------------------

   GetTextExtentPoint32 (
                         hDC : POINTER;
                         lpString : POINTER;
                         cbString : INTEGER;
                         lpSize : POINTER
                         ) : INTEGER is





      external "C use <windows.h>"
      alias "GetTextExtentPoint32A"





      end
	----------------------------------------

   GetTextMetrics (hDC: POINTER; lptm: POINTER): INTEGER is





      external "C use <windows.h>"
      alias "GetTextMetricsA"





      end
	----------------------------------------

   SetTextAlign (hDC: POINTER; fMode: INTEGER): INTEGER is





      external "C use <windows.h>"
      alias "SetTextAlign"





      end
	----------------------------------------

   SetTextColor (hDC: POINTER; crColor: INTEGER): INTEGER is





      external "C use <windows.h>"
      alias "SetTextColor"





      end
	----------------------------------------

   TextOut (hDC: POINTER; nXStart, nYStart: INTEGER; lpString: POINTER;
            cbString: INTEGER): INTEGER is





      external "C use <windows.h>"
      alias "TextOutA"





      end

end
