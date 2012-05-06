note
	description:"SB_LIST commands"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"mostly complete"

expanded class SB_BASE_LIST_COMMANDS

inherit

	SB_SCROLL_AREA_COMMANDS
      	rename
         	Id_last as SCROLL_AREA_ID_LAST
      	end

feature

	ID_TIPTIMER		: INTEGER once Result := SCROLL_AREA_ID_LAST + 0 end
	ID_LOOKUPTIMER	: INTEGER once Result := SCROLL_AREA_ID_LAST + 1 end
	Id_last			: INTEGER once Result := SCROLL_AREA_ID_LAST + 2 end

end
