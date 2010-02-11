indexing
	description:"SB_SWITCHER constants"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"mostly complete"

class SB_SWITCHER_CONSTANTS

inherit

	SB_PACKER_CONSTANTS

feature

	SWITCHER_HCOLLAPSE: INTEGER is 0x00020000
			-- Collapse horizontally to width of current child

	SWITCHER_VCOLLAPSE: INTEGER is 0x00040000
			-- Collapse vertically to height of current child

	SWITCHER_MASK: INTEGER is
		once
			Result := SWITCHER_HCOLLAPSE | SWITCHER_VCOLLAPSE;
		end

feature -- BIT version

--	SWITCHER_HCOLLAPSE: BIT 32 is 100000000000000000B;
			-- Collapse horizontally to width of current child

--	SWITCHER_VCOLLAPSE: BIT 32 is 1000000000000000000B;
			-- Collapse vertically to height of current child

--	SWITCHER_MASK: BIT 32 is
--		once
--			Result := SWITCHER_HCOLLAPSE or SWITCHER_VCOLLAPSE;
--		end

end
