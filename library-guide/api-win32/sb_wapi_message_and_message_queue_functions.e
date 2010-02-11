expanded class SB_WAPI_MESSAGE_AND_MESSAGE_QUEUE_FUNCTIONS

feature -- Access

   DefWindowProc (hWnd: POINTER; uMsg, wParam, lParam : INTEGER) : INTEGER is





      external "C use <windows.h>"
      alias "DefWindowProcA"





      end

   DispatchMessage (lpmsg: POINTER) : INTEGER is





      external "C use <windows.h>"
      alias "DispatchMessageA"





      end

   GetMessage (lpmsg : POINTER; hWnd, uMsgFilterMin, uMsgFilterMax : INTEGER) : INTEGER is





      external "C use <windows.h>"
      alias "GetMessageA"





      end

   PeekMessage (lpMsg, hWnd: POINTER;wMsgFilterMin,wMsgFilterMax: INTEGER; wRemoveMsg: INTEGER_32): INTEGER is





      external "C use <windows.h>"
      alias "PeekMessageA"





      end

   WaitMessage: INTEGER is





      external "C use <windows.h>"
      alias "WaitMessage"





      end

   PostQuitMessage (exitCode : INTEGER) is





      external "C use <windows.h>"
      alias "PostQuitMessage"





      end

   SendMessage (hWnd: POINTER; uMsg, wParam, lParam: INTEGER): INTEGER is





      external "C use <windows.h>"
      alias "SendMessageA"





      end

   TranslateMessage (lpmsg: POINTER): INTEGER is





      external "C use <windows.h>"
      alias "TranslateMessage"





      end

   GetMessageTime: INTEGER is





      external "C use <windows.h>"
      alias "GetMessageTime"





      end

   GetMessagePos: INTEGER is





      external "C use <windows.h>"
      alias "GetMessagePos"





      end

   RegisterWindowMessage (lpsz : POINTER) : INTEGER is





      external "C use <windows.h>"
      alias "RegisterWindowMessageA"





      end

   PostMessage (hWnd: POINTER; uMsg, wParam, lParam: INTEGER): INTEGER is





      external "C use <windows.h>"
      alias "PostMessageA"





      end

end
