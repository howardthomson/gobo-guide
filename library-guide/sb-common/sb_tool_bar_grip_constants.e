indexing
	description:"SB_TOOL_BAR_GRIP constants"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"mostly complete"

class SB_TOOL_BAR_GRIP_CONSTANTS

inherit

   SB_WINDOW_CONSTANTS

feature -- Tool Bar Grip styles

   TOOLBARGRIP_SINGLE	: INTEGER is 0			-- Single bar mode for movable toolbars
   TOOLBARGRIP_DOUBLE	: INTEGER is 0x00008000	-- Double bar mode for dockable toolbars
   TOOLBARGRIP_SEPARATOR: INTEGER is 0x00010000	-- Separator mode

feature -- Tool Bar Grip styles, BIT Version

--	TOOLBARGRIP_SINGLE	: BIT 32 is 0B;
         -- Single bar mode for movable toolbars
--	TOOLBARGRIP_DOUBLE	: BIT 32 is 1000000000000000B;
	         -- Double bar mode for dockable toolbars
--	TOOLBARGRIP_SEPARATOR: BIT 32 is 10000000000000000B;
         -- Separator mode
end
