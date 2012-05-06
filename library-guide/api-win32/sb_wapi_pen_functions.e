expanded class SB_WAPI_PEN_FUNCTIONS

feature -- Access

   ExtCreatePen (dwPenStyle: INTEGER_32; dwWidth: INTEGER; lplb: POINTER; 
                 dwStyleCount: INTEGER; lpStyle: POINTER): POINTER





      external "C use <windows.h>"
      alias "ExtCreatePen"





      end

   CreatePen (fnPenStyle, nWidth, crColor: INTEGER): POINTER





      external "C use <windows.h>"
      alias "CreatePen"





   end

   CreatePenIndirect (lplgpn: POINTER): POINTER





      external "C use <windows.h>"
      alias "CreatePenIndirect"





   end

end
