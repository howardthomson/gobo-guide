indexing
   description: "SB_TAB_BAR constants"
   author: "Eugene Melekhov <eugene_melekhov@mail.ru>"
   copyright: "Copyright (c) 2002, Eugene Melekhov and others"
   license: "Eiffel Forum Freeware License v2 (see forum.txt)"
   status: "mostly complete"

class SB_TAB_BAR_CONSTANTS

feature

	TABBOOK_NORMAL		: INTEGER is 0	-- default

	TABBOOK_TOPTABS		: INTEGER is 0			-- Tabs on top (default)
	TABBOOK_BOTTOMTABS	: INTEGER is 0x00020000	-- Tabs on bottom
	TABBOOK_SIDEWAYS	: INTEGER is 0x00040000	-- Tabs on left
	TABBOOK_LEFTTABS	: INTEGER is 0x00040000	-- Tabs on left
	TABBOOK_RIGHTTABS	: INTEGER is 0x00060000	-- Tabs on right

	TABBOOK_MASK		: INTEGER is 0x00060000	-- Mask of used bits

end
