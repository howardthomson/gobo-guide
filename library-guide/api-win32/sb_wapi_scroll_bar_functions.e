expanded class SB_WAPI_SCROLL_BAR_FUNCTIONS

feature -- Access

   GetScrollPos (hWnd: POINTER; nBar: INTEGER): INTEGER





      external "C use <windows.h>"
      alias "GetScrollPos"





      end

   SetScrollPos (hWnd: POINTER; fnBar, nPos, fRedraw: INTEGER): INTEGER





      external "C use <windows.h>"
      alias "SetScrollPos"





      end

   SetScrollRange (hWnd: POINTER; fnBar, nMinPos, nMaxPos, fRedraw: INTEGER): INTEGER





      external "C use <windows.h>"
      alias "SetScrollRange"





      end

   ScrollWindow (hWnd: POINTER; dx, dy: INTEGER; lprcScroll, lprcClip: POINTER): INTEGER





      external "C use <windows.h>"
      alias "ScrollWindow"





      end

   ScrollWindowEx (hWnd: POINTER dx, dy: INTEGER; prcScroll, prcClip, hrgnUpdate,
                   prcUpdate: POINTER; flags: INTEGER): INTEGER





      external "C use <windows.h>"
      alias "ScrollWindowEx"





      end

   ShowScrollBar (hWnd: POINTER; wBar, bShow: INTEGER): INTEGER





      external "C use <windows.h>"
      alias "ShowScrollBar"





      end

end
