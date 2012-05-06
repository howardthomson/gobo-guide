note
	description:"SB_SCROLL_AREA_CONSTANTS"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"mostly complete"

class SB_SCROLL_AREA_CONSTANTS

feature -- Scrollbar options

   SCROLLERS_NORMAL	: INTEGER = 0         	-- Show the scrollbars when needed
   HSCROLLER_ALWAYS	: INTEGER = 0x00008000	-- Always show horizontal scrollers
   HSCROLLER_NEVER	: INTEGER = 0x00010000	-- Never show horizontal scrollers
   VSCROLLER_ALWAYS	: INTEGER = 0x00020000	-- Always show vertical scrollers
   VSCROLLER_NEVER	: INTEGER = 0x00040000	-- Never show vertical scrollers
   HSCROLLING_ON	: INTEGER = 0         	-- Horizontal scrolling turned on (default)
   VSCROLLING_ON	: INTEGER = 0         	-- Vertical scrolling turned on (default)

   HSCROLLING_OFF: INTEGER
         -- Horizontal scrolling turned off
      once
         Result := (HSCROLLER_NEVER | HSCROLLER_ALWAYS)
      end

   VSCROLLING_OFF: INTEGER
         -- Vertical scrolling turned off
      once
         Result := (VSCROLLER_NEVER | VSCROLLER_ALWAYS);
      end

   SCROLLERS_TRACK		: INTEGER = 0			-- Scrollers track continuously for smooth scrolling
   SCROLLERS_DONT_TRACK	: INTEGER = 0x00080000	-- Scrollers don't track continuously

end
