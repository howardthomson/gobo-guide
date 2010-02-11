indexing
	description:"SB_SCROLL_BAR constants"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"mostly complete"

class SB_SCROLL_BAR_CONSTANTS

feature -- ScrollBar styles

	SCROLLBAR_HORIZONTAL: INTEGER is 0x00020000	-- Horizontally oriented
	SCROLLBAR_VERTICAL	: INTEGER is 0			-- Vertically oriented

feature -- ScrollBar styles, BIT Version

--	SCROLLBAR_HORIZONTAL: BIT 32 is 10 0000 0000 0000 0000B; -- Horizontally oriented
--	SCROLLBAR_VERTICAL	: BIT 32 is 0B;						 -- Vertically oriented
end
