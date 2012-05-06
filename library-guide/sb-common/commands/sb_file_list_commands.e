note
	description:"SB_FILE_LIST commands"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"mostly complete"

expanded class SB_FILE_LIST_COMMANDS

inherit

	SB_ICON_LIST_COMMANDS
      	rename
         	Id_last as ICON_LIST_ID_LAST
      	end

feature

	ID_SORT_BY_NAME	: INTEGER once Result := ICON_LIST_ID_LAST + 0 end
	ID_SORT_BY_TYPE	: INTEGER once Result := ICON_LIST_ID_LAST + 1 end
	ID_SORT_BY_SIZE	: INTEGER once Result := ICON_LIST_ID_LAST + 2 end
	ID_SORT_BY_TIME	: INTEGER once Result := ICON_LIST_ID_LAST + 3 end
	ID_SORT_BY_USER	: INTEGER once Result := ICON_LIST_ID_LAST + 4 end
	ID_SORT_BY_GROUP: INTEGER once Result := ICON_LIST_ID_LAST + 5 end
	ID_SORT_REVERSE	: INTEGER once Result := ICON_LIST_ID_LAST + 6 end
	ID_DIRECTORY_UP	: INTEGER once Result := ICON_LIST_ID_LAST + 7 end
	ID_SET_PATTERN	: INTEGER once Result := ICON_LIST_ID_LAST + 8 end
	ID_SET_DIRECTORY: INTEGER once Result := ICON_LIST_ID_LAST + 9 end
	ID_SHOW_HIDDEN	: INTEGER once Result := ICON_LIST_ID_LAST + 10 end
	ID_HIDE_HIDDEN	: INTEGER once Result := ICON_LIST_ID_LAST + 11 end
	ID_TOGGLE_HIDDEN: INTEGER once Result := ICON_LIST_ID_LAST + 12 end
	ID_REFRESHTIMER	: INTEGER once Result := ICON_LIST_ID_LAST + 13 end
	ID_OPENTIMER	: INTEGER once Result := ICON_LIST_ID_LAST + 14 end
	Id_last			: INTEGER once Result := ICON_LIST_ID_LAST + 15 end

end
