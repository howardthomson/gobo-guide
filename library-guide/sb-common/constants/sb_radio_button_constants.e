note
	description: "SB_RADIO_BUTTON constants"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"mostly complete"

class SB_RADIO_BUTTON_CONSTANTS

inherit

	SB_LABEL_CONSTANTS

feature -- RadioButton flags

	RADIOBUTTON_AUTOGRAY: INTEGER = 0x00800000	-- 1000 0000 0000 0000 0000 0000B; 		-- Automatically gray out when not updated
	RADIOBUTTON_AUTOHIDE: INTEGER = 0x01000000	-- 1 0000 0000 0000 0000 0000 0000B;		-- Automatically hide when not updated

	RADIOBUTTON_NORMAL: INTEGER
		once
			Result := JUSTIFY_NORMAL | ICON_BEFORE_TEXT
		end

end
