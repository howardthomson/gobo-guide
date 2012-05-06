note
   description: "SB_HEADER commands"
   author: "Eugene Melekhov <eugene_melekhov@mail.ru>"
   copyright: "Copyright (c) 2002, Eugene Melekhov and others"
   license: "Eiffel Forum Freeware License v1 (see forum.txt)"
   status: "mostly complete"

expanded class SB_HEADER_COMMANDS

inherit

   SB_FRAME_COMMANDS
      rename
         Id_last as FRAME_ID_LAST
      end

feature

   ID_TIPTIMER: INTEGER
      once
         Result := FRAME_ID_LAST
      end

   Id_last: INTEGER
      once
         Result := FRAME_ID_LAST + 1;
      end

end
