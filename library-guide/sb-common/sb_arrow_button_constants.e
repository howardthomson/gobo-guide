indexing
	description:"SB_ARROW_BUTTON constants"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

class SB_ARROW_BUTTON_CONSTANTS

inherit

   SB_LABEL_CONSTANTS

feature -- Arrow styles

	ARROW_NONE		: INTEGER is 0			-- 0B;									-- No arrow
	ARROW_UP		: INTEGER is 0x00080000	--  1000 0000 0000 0000 0000B;			-- Arrow points up
	ARROW_DOWN		: INTEGER is 0x00100000	-- 1 0000 0000 0000 0000 0000B;			-- Arrow points down
	ARROW_LEFT		: INTEGER is 0x00200000	-- 10 0000 0000 0000 0000 0000B;		-- Arrow points left
	ARROW_RIGHT		: INTEGER is 0x00400000	-- 100 0000 0000 0000 0000 0000B;		-- Arrow points right

	ARROW_REPEAT	: INTEGER is 0x00800000	-- 1000 0000 0000 0000 0000 0000B;		-- Button repeats if held down
	ARROW_AUTOGRAY	: INTEGER is 0x01000000	-- 1 0000 0000 0000 0000 0000 0000B;	-- Automatically gray out when not updated
	ARROW_AUTOHIDE	: INTEGER is 0x02000000	-- 10 0000 0000 0000 0000 0000 0000B;	-- Automatically hide when not updated
	ARROW_TOOLBAR	: INTEGER is 0x04000000	-- 100 0000 0000 0000 0000 0000 0000B;	-- Button is toolbar-style

	ARROW_NORMAL	: INTEGER is 
		once
			Result :=  Frame_raised | Frame_thick | ARROW_UP
		end

end
