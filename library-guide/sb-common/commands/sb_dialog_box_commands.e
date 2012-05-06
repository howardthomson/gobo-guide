note
	description:"SB_DIALOG_BOX commands"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v1 (see forum.txt)"
	status:		"mostly complete"

expanded class SB_DIALOG_BOX_COMMANDS

inherit

	SB_TOP_WINDOW_COMMANDS
		rename
			Id_last as TOP_WINDOW_ID_LAST
		end

feature

	ID_CANCEL: INTEGER once Result := TOP_WINDOW_ID_LAST + 0 end
		-- Closes the dialog, cancel the entry
	ID_ACCEPT: INTEGER once Result := TOP_WINDOW_ID_LAST + 1 end
		-- Closes the dialog, accept the entry
	Id_last  : INTEGER once Result := TOP_WINDOW_ID_LAST + 3 end

end
