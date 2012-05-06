note
   description: "SB_FILE_SELECTOR commands"
   author: "Eugene Melekhov <eugene_melekhov@mail.ru>"
   copyright: "Copyright (c) 2002, Eugene Melekhov and others"
   license: "Eiffel Forum Freeware License v1 (see forum.txt)"
   status: "mostly complete"

expanded class SB_FILE_SELECTOR_COMMANDS

inherit

   SB_PACKER_COMMANDS
      rename
         Id_last as PACKER_ID_LAST,
         Id_delete as PACKER_ID_DELETE
      end

feature

   ID_LIST: INTEGER once Result := PACKER_ID_LAST end
   ID_FILEFILTER: INTEGER once Result := PACKER_ID_LAST+2 end
   ID_ACCEPT: INTEGER once Result := PACKER_ID_LAST+3 end
   ID_FILELIST: INTEGER once Result := PACKER_ID_LAST+4 end
   ID_DIRECTORY_UP: INTEGER once Result := PACKER_ID_LAST+5 end
   ID_DIRTREE: INTEGER once Result := PACKER_ID_LAST+6 end
   ID_HOME: INTEGER once Result := PACKER_ID_LAST+7 end
   ID_WORK: INTEGER once Result := PACKER_ID_LAST+8 end
   ID_BOOKMARK: INTEGER once Result := PACKER_ID_LAST+9 end
   ID_VISIT: INTEGER once Result := PACKER_ID_LAST+10 end
   ID_NEW: INTEGER once Result := PACKER_ID_LAST+11 end
   Id_delete: INTEGER once Result := PACKER_ID_LAST+12 end
   ID_MOVE: INTEGER once Result := PACKER_ID_LAST+13 end
   ID_COPY: INTEGER once Result := PACKER_ID_LAST+14 end
   ID_LINK: INTEGER once Result := PACKER_ID_LAST+15 end
   Id_last: INTEGER once Result := PACKER_ID_LAST + 16 end

end
