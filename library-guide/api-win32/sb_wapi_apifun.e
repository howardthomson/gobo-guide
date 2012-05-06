expanded class SB_WAPI_APIFUN

feature

   MessageBeep (soundType: INTEGER_32): INTEGER
      external "C use <windows.h>"
      alias "MessageBeep"
      end

end
