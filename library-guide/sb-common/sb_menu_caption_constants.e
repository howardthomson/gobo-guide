indexing
	description:"Menu Caption constants"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"mostly complete"

class SB_MENU_CAPTION_CONSTANTS

feature -- Menu Caption options

	MENU_AUTOGRAY: INTEGER is 0x00008000
			-- Automatically gray out when not updated
	MENU_AUTOHIDE: INTEGER is 0x00010000
			-- Automatically hide button when not updated

feature -- Menu Caption options, BIT Version

--	MENU_AUTOGRAY: BIT 32 is 1000000000000000B;
			-- Automatically gray out when not updated
--	MENU_AUTOHIDE: BIT 32 is 10000000000000000B;
			-- Automatically hide button when not updated

end
