indexing
	description:"SB_MDI_CHILD constants"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"mostly complete"

class SB_MDI_CHILD_CONSTANTS

feature -- MDI Child Window styles

	MDI_NORMAL	 : INTEGER is 0x00000000	-- 0B;					-- Normal display mode
	MDI_MAXIMIZED: INTEGER is 0x00001000	-- 1 0000 0000 0000B;	-- Window appears maximized
	MDI_MINIMIZED: INTEGER is 0x00002000	-- 10 0000 0000 0000B;	-- Window is iconified or minimized

end
