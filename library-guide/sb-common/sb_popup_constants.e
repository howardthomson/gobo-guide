indexing
	description:"Popup window constants"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

class SB_POPUP_CONSTANTS

feature -- Popup internal orientation

	Popup_vertical	: INTEGER is 0           -- Vertical orientation
	Popup_horizontal: INTEGER is 0x00020000 	-- Horizontal orientation
	Popup_shrinkwrap: INTEGER is 0x00040000	-- Shrinkwrap to content

end
