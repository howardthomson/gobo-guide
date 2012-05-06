note
	description:"SB_CHECK_BUTTON constants"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"mostly complete"

class SB_CHECK_BUTTON_CONSTANTS

inherit

	SB_LABEL_CONSTANTS

feature -- Check Button flags

	CHECKBUTTON_AUTOGRAY	: INTEGER = 0x00800000	-- 1000 0000 0000 0000 0000 0000B;
		-- Automatically gray out when not updated
	CHECKBUTTON_AUTOHIDE	: INTEGER = 0x01000000	-- 1 0000 0000 0000 0000 0000 0000B;
		-- Automatically hide when not updated
	CHECKBUTTON_PLUS		: INTEGER = 0x02000000	-- 10 0000 0000 0000 0000 0000 0000B;
		-- Draw a + for unchecked and - for checked

	CHECKBUTTON_NORMAL: INTEGER
		once
			Result := (JUSTIFY_NORMAL | ICON_BEFORE_TEXT)
		end

	CHECKBUTTON_MASK: INTEGER
		once
			Result := (CHECKBUTTON_AUTOGRAY | CHECKBUTTON_AUTOHIDE | CHECKBUTTON_PLUS);
		end

end
