expanded class SB_WAPI_BRUSH_FUNCTIONS

feature -- Access

   SetBrushOrgEx(hdc: POINTER; nXOrg, nYOrg: INTEGER; lppt: POINTER): INTEGER





      external "C use <windows.h>"
      alias "SetBrushOrgEx"





      end
	---------------------------------------
	
   CreateBrushIndirect (lplb: POINTER): POINTER





      external "C use <windows.h>"
      alias "CreateBrushIndirect"





      end
	---------------------------------------

   CreatePatternBrush (hbmp: POINTER): POINTER





      external "C use <windows.h>"
      alias "CreatePatternBrush"





      end
	---------------------------------------

   CreateSolidBrush (crColor: INTEGER): POINTER





      external "C use <windows.h>"
      alias "CreateSolidBrush"





      end
	---------------------------------------

end
