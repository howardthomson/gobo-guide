note
	description: "SB_ICON_LIST commands"
	author: "Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright: "Copyright (c) 2002, Eugene Melekhov and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)"
	status: "mostly complete"

expanded class SB_ICON_LIST_COMMANDS

inherit
	SB_BASE_LIST_COMMANDS
		rename
			Id_last as BASE_LIST_ID_LAST
		end

feature

	ID_SHOW_DETAILS		 : INTEGER once Result := BASE_LIST_ID_LAST + 0 end
	ID_SHOW_MINI_ICONS	 : INTEGER once Result := BASE_LIST_ID_LAST + 1 end
	ID_SHOW_BIG_ICONS	 : INTEGER once Result := BASE_LIST_ID_LAST + 2 end
	ID_ARRANGE_BY_ROWS	 : INTEGER once Result := BASE_LIST_ID_LAST + 3 end
	ID_ARRANGE_BY_COLUMNS: INTEGER once Result := BASE_LIST_ID_LAST + 4 end
	ID_HEADER_CHANGE	 : INTEGER once Result := BASE_LIST_ID_LAST + 5 end
	ID_SELECT_ALL		 : INTEGER once Result := BASE_LIST_ID_LAST + 6 end
	ID_DESELECT_ALL		 : INTEGER once Result := BASE_LIST_ID_LAST + 7 end
	ID_SELECT_INVERSE	 : INTEGER once Result := BASE_LIST_ID_LAST + 8 end
	Id_last				 : INTEGER once Result := BASE_LIST_ID_LAST + 9 end

end
