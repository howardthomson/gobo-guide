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

feature -- BIT Version

--	   TABBOOK_TOPTABS: BIT 32 is 0B;
         -- Tabs on top (default)

--	   TABBOOK_BOTTOMTABS: BIT 32 is 100000000000000000B;
         -- Tabs on bottom

--	   TABBOOK_SIDEWAYS: BIT 32 is 1000000000000000000B;
         -- Tabs on left

--	   TABBOOK_LEFTTABS: BIT 32 is
         -- Tabs on left
--	      once
--	         Result := TABBOOK_SIDEWAYS or TABBOOK_TOPTABS;
--	      end

--	   TABBOOK_RIGHTTABS: BIT 32 is
         -- Tabs on right
--	      once
--	         Result := TABBOOK_SIDEWAYS or TABBOOK_BOTTOMTABS;
--	      end

--	   TABBOOK_NORMAL: BIT 32 is 0B;

--	   TABBOOK_MASK: BIT 32 is
--	      once
--	         Result := TABBOOK_SIDEWAYS or TABBOOK_BOTTOMTABS
--	      end
end
