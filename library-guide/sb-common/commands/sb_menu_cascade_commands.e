indexing
	description:"SB_MENU_CASCADE commands"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v1 (see forum.txt)"
	status:		"mostly complete"

expanded class SB_MENU_CASCADE_COMMANDS

inherit

	SB_MENU_CAPTION_COMMANDS
		rename
			Id_last as MENU_CAPTION_ID_LAST
		end

feature

	ID_MENUTIMER: INTEGER is once Result := MENU_CAPTION_ID_LAST + 0 end
	Id_last		: INTEGER is once Result := MENU_CAPTION_ID_LAST + 1 end

end
