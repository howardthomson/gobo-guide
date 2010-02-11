indexing
	description:"SB_POPUP commands"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v1 (see forum.txt)"
	status:		"mostly complete"

expanded class SB_POPUP_COMMANDS

inherit

	SB_SHELL_COMMANDS
		rename Id_last as SHELL_ID_LAST
		end

feature

	ID_CHOICE: INTEGER is once Result := SHELL_ID_LAST +0 end
	Id_last	 : INTEGER is once Result := SHELL_ID_LAST +1 end

end
