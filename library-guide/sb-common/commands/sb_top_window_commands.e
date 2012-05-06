note
	description: "SB_TOP_WINDOW commands"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v1 (see forum.txt)"
	status:		"mostly complete"

expanded class SB_TOP_WINDOW_COMMANDS

inherit

	SB_SHELL_COMMANDS
		rename
			Id_last as Shell_id_last
		end

feature


	ID_ICONIFY		: INTEGER once Result := Shell_id_last	  end	-- Iconify the window
	ID_DEICONIFY	: INTEGER once Result := Shell_id_last + 1 end	-- Deiconify the window
	ID_QUERY_DOCK	: INTEGER once Result := Shell_id_last + 2 end	--  Toolbar asks to dock
	Id_last			: INTEGER once Result := Shell_id_last + 3 end

end
