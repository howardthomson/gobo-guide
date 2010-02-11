indexing
	description:"SB_FRAME constants"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"mostly complete"

class SB_FRAME_CONSTANTS

inherit
	SB_WINDOW_CONSTANTS

feature -- Justification modes
   
	JUSTIFY_NORMAL	: INTEGER is 0;    		-- 			 Default justification is centered text
	JUSTIFY_CENTER_X: INTEGER is 0;			-- 			 Text is centered horizontally
	JUSTIFY_LEFT	: INTEGER is 0x00008000	-- (1 << 15) Text is left-justified
   	JUSTIFY_RIGHT	: INTEGER is 0x00010000	-- (1 << 16) Text is right-justified

   	JUSTIFY_HZ_APART: INTEGER is
    		-- Combination of JUSTIFY_LEFT & JUSTIFY_RIGHT
      	once     
         	Result := JUSTIFY_LEFT | JUSTIFY_RIGHT;
      	end

   	JUSTIFY_CENTER_Y: INTEGER is 0;         	--			 Text is centered vertically
   	JUSTIFY_TOP		: INTEGER is 0x00020000	-- (1 << 17) Text is aligned with label top
   	JUSTIFY_BOTTOM	: INTEGER is 0x00040000	-- (1 << 18) Text is aligned with label bottom

   	JUSTIFY_VT_APART: INTEGER is
         	-- Combination of JUSTIFY_TOP & JUSTIFY_BOTTOM
      	once
         	Result := JUSTIFY_TOP | JUSTIFY_BOTTOM;
      	end

   	JUSTIFY_MASK: INTEGER is
      	once
         	Result := JUSTIFY_HZ_APART | JUSTIFY_VT_APART;
      	end

end
