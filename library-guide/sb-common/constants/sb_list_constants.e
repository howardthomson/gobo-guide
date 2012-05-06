note
	description:"SB_LIST constants"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"mostly complete"

class SB_LIST_CONSTANTS

inherit

	SB_BASE_LIST_CONSTANTS

feature -- List styles

	LIST_AUTOSELECT: INTEGER = 0x00400000	-- 100 0000 0000 0000 0000 0000B;
			-- Automatically select under cursor

	LIST_NORMAL: INTEGER once Result := LIST_EXTENDEDSELECT end

end
