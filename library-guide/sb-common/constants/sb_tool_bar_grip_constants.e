note
	description:"SB_TOOL_BAR_GRIP constants"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"mostly complete"

class SB_TOOL_BAR_GRIP_CONSTANTS

inherit

   SB_WINDOW_CONSTANTS

feature -- Tool Bar Grip styles

   TOOLBARGRIP_SINGLE	: INTEGER = 0			-- Single bar mode for movable toolbars
   TOOLBARGRIP_DOUBLE	: INTEGER = 0x00008000	-- Double bar mode for dockable toolbars
   TOOLBARGRIP_SEPARATOR: INTEGER = 0x00010000	-- Separator mode

end
