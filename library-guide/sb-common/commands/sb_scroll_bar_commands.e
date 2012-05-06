note
   description: "SB_SROLL_BAR commands"
   author: "Eugene Melekhov <eugene_melekhov@mail.ru>"
   copyright: "Copyright (c) 2002, Eugene Melekhov and others"
   license: "Eiffel Forum Freeware License v1 (see forum.txt)"
   status: "mostly complete"

expanded class SB_SCROLL_BAR_COMMANDS

inherit

   SB_WINDOW_COMMANDS
      rename
         Id_last as WINDOW_ID_LAST
      end

feature

   ID_TIMEWHEEL: INTEGER
      once
         Result := WINDOW_ID_LAST;
      end
   ID_AUTOINC_LINE: INTEGER
      once
         Result := WINDOW_ID_LAST+1;
      end

   ID_AUTODEC_LINE: INTEGER
      once
         Result := WINDOW_ID_LAST+2;
      end

   ID_AUTOINC_PAGE: INTEGER
      once
         Result := WINDOW_ID_LAST+3;
      end

   ID_AUTODEC_PAGE: INTEGER
      once
         Result := WINDOW_ID_LAST+4;
      end

   ID_AUTOINC_PIX: INTEGER
      once
         Result := WINDOW_ID_LAST+5;
      end
   ID_AUTODEC_PIX: INTEGER
      once
         Result := WINDOW_ID_LAST+6;
      end
   
   Id_last: INTEGER
      once
         Result := WINDOW_ID_LAST+7;
      end
end
