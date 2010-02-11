indexing
	description:"SB_BUTTON constants"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

class SB_BUTTON_CONSTANTS

inherit

	SB_LABEL_CONSTANTS

feature

	-- Button state bits

	STATE_UP		: INTEGER is 0;         -- Button is up
	STATE_DOWN		: INTEGER is 1;         -- Button is down
	STATE_ENGAGED	: INTEGER is 2;         -- Button is engaged

	STATE_UNCHECKED	: INTEGER is 0;         -- Same as STATE_UP		 (used for check buttons or radio buttons)
	STATE_CHECKED	: INTEGER is 2;         -- Same as STATE_ENGAGED (used for check buttons or radio buttons)


feature -- Flags: INTEGER version

	-- Button flags
	BUTTON_AUTOGRAY: INTEGER is 0x00800000	-- (1B << 23)
		-- Automatically gray out when not updated

	BUTTON_AUTOHIDE: INTEGER is 0x01000000 	-- (1B << 24)
		-- Automatically hide button when not updated
  
	BUTTON_TOOLBAR: INTEGER is 0x02000000 	-- (1B << 25)
		-- Toolbar style button [flat look]

	BUTTON_DEFAULT: INTEGER is 0x04000000 	--  (1B << 26)
		-- May become default button when receiving focus

	BUTTON_INITIAL: INTEGER is 0x08000000 	--  (1B << 27)
		-- This button is the initial default button

	BUTTON_NORMAL: INTEGER is
		once
			Result := (Frame_raised | Frame_thick | JUSTIFY_NORMAL | ICON_BEFORE_TEXT);
		end

	BUTTON_MASK: INTEGER is
		once
			Result := (BUTTON_AUTOGRAY | BUTTON_AUTOHIDE | BUTTON_TOOLBAR | BUTTON_DEFAULT);
		end

end
