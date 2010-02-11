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

feature -- Popup internal orientation, BIT Version

--	POPUP_VERTICAL	: BIT 32 is                       0B;	-- Vertical orientation
--	POPUP_HORIZONTAL: BIT 32 is  10 0000 0000 0000 0000B;	-- Horizontal orientation
--	Popup_shrinkwrap: BIT 32 is 100 0000 0000 0000 0000B;	-- Shrinkwrap to content
end
