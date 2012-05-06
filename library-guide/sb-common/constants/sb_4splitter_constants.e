note
	description:"SB_4SPLITTER constants"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"mostly complete"

class SB_4SPLITTER_CONSTANTS

feature -- INTEGER version

	FOURSPLITTER_NORMAL		: INTEGER = 0

	FOURSPLITTER_TRACKING	: INTEGER = 0x00008000	-- (1B << 15)
		-- Track continuously during split

	FOURSPLITTER_MASK		: INTEGER = 0x00008000	-- (1B << 15)

feature -- Conflict checking

--	Conflict_mask: BIT 32 is
--		do
--			Result := FOURSPLITTER_MASK
--		end
end
