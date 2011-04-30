indexing
	description:"SB_APPLICATION commands"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"mostly complete"

expanded class SB_APPLICATION_COMMANDS

inherit

	SB_MESSAGE_HANDLER_COMMANDS
      	rename
      		Id_last as MESSAGE_HANDLER_ID_LAST
      	end

feature

   	ID_QUIT				: INTEGER is once Result := MESSAGE_HANDLER_ID_LAST	end
   	ID_DUMP				: INTEGER is once Result := ID_QUIT + 1;			end
   	ID_OPEN_WINDOW_TREE	: INTEGER is once Result := ID_QUIT + 2;			end
   	Id_last				: INTEGER is once Result := ID_DUMP + 2;			end

end
