expanded class SB_WAPI_PATH_FUNCTIONS

feature

   AbortPath(hdc: POINTER): INTEGER is





      external "C use <windows.h>"
      alias "AbortPath"





      end

   BeginPath(hdc: POINTER): INTEGER is





      external "C use <windows.h>"
      alias "BeginPath"





      end

   CloseFigure(hdc: POINTER): INTEGER is





      external "C use <windows.h>"
      alias "CloseFigure"





      end

   EndPath(hdc: POINTER): INTEGER is





      external "C use <windows.h>"
      alias "EndPath"





      end

   FillPath(hdc: POINTER): INTEGER is





      external "C use <windows.h>"
      alias "FillPath"





      end

   FlattenPath(hdc: POINTER): INTEGER is





      external "C use <windows.h>"
      alias "FlattenPath"





      end

   GetMiterLimit(hdc: POINTER; peLimit: POINTER): INTEGER is





      external "C use <windows.h>"
      alias "GetMiterLimit"





      end

   GetPath(hdc: POINTER; lpPoints,lpTypes: POINTER; nSize: INTEGER): INTEGER is





      external "C use <windows.h>"
      alias "GetPath"





      end

   PathToRegion(hdc: POINTER): INTEGER is





      external "C use <windows.h>"
      alias "PathToRegion"





      end

--   SetMiterLimit(hdc: POINTER;eNewLimit: DOUBLE; peOldLimit: POINTER): INTEGER is
--#ifdef VEC
--      external "WINAPI"
--      alias "SetMiterLimit"
--#endif
--#ifdef SE
--      external "C use <windows.h>"
--      alias "SetMiterLimit"
--#endif
--#ifdef ISE
--      ISE_EXTERNAL
--      ISE_ALIAS "SetMiterLimit"
--#endif
--      end

   StrokeAndFillPath(hdc: POINTER): INTEGER is





      external "C use <windows.h>"
      alias "StrokeAndFillPath"





      end

   StrokePath(hdc: POINTER): INTEGER is





      external "C use <windows.h>"
      alias "StrokePath"





      end

   WidenPath(hdc: POINTER): INTEGER is





      external "C use <windows.h>"
      alias "WidenPath"





      end

end
