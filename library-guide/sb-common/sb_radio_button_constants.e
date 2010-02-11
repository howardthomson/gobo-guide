indexing
	description: "SB_RADIO_BUTTON constants"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"mostly complete"

class SB_RADIO_BUTTON_CONSTANTS

inherit

	SB_LABEL_CONSTANTS

feature -- RadioButton flags

	RADIOBUTTON_AUTOGRAY: INTEGER is 0x00800000	-- 1000 0000 0000 0000 0000 0000B; 		-- Automatically gray out when not updated
	RADIOBUTTON_AUTOHIDE: INTEGER is 0x01000000	-- 1 0000 0000 0000 0000 0000 0000B;		-- Automatically hide when not updated

	RADIOBUTTON_NORMAL: INTEGER is
		once
			Result := JUSTIFY_NORMAL | ICON_BEFORE_TEXT
		end

feature -- BIT Version

--	RADIOBUTTON_AUTOGRAY: BIT 32 is  1000 0000 0000 0000 0000 0000B; 		-- Automatically gray out when not updated
--	RADIOBUTTON_AUTOHIDE: BIT 32 is  1 0000 0000 0000 0000 0000 0000B;		-- Automatically hide when not updated

--	RADIOBUTTON_NORMAL: BIT 32 is
--		once
--			Result := JUSTIFY_NORMAL or ICON_BEFORE_TEXT
--		end

end
