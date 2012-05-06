note
   description: "SB_TREE_LIST_BOX commands"
   author: "Eugene Melekhov <eugene_melekhov@mail.ru>"
   copyright: "Copyright (c) 2002, Eugene Melekhov and others"
   license: "Eiffel Forum Freeware License v1 (see forum.txt)"
   status: "mostly complete"

expanded class SB_TREE_LIST_BOX_COMMANDS

inherit

   SB_PACKER_COMMANDS
      rename
         Id_last as PACKER_ID_LAST
      end

feature

   ID_TREE: INTEGER
      once
         Result := PACKER_ID_LAST
      end

   ID_FIELD: INTEGER
      once
         Result := PACKER_ID_LAST + 1;
      end

   Id_last: INTEGER
      once
         Result := PACKER_ID_LAST + 2;
      end

end
