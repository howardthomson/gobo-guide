indexing
	description:"ToolTip constants"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

class SB_TOOL_TIP_CONSTANTS

feature -- Tooltip styles

	TOOLTIP_PERMANENT: INTEGER is 0x00020000		-- Tooltip stays up indefinitely
	TOOLTIP_VARIABLE : INTEGER is 0x00040000		-- Tooltip stays up variable time, depending on the length of the string
	TOOLTIP_NORMAL	 : INTEGER is 0				-- Normal tooltip

feature -- Tooltip styles, BIT Version

--	TOOLTIP_PERMANENT: BIT 32 is 100000000000000000B;
         -- Tooltip stays up indefinitely

--	TOOLTIP_VARIABLE: BIT 32 is 1000000000000000000B;
         -- Tooltip stays up variable time, depending on the length of the string

--	TOOLTIP_NORMAL: BIT 32 is 0B;
         -- Normal tooltip

end
