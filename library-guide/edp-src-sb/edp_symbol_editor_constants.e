note
	description:"SB_TEXT_FIELD constants"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v1 (see forum.txt)"
	status:		"mostly complete"

class EDP_SYMBOL_EDITOR_CONSTANTS

inherit

	SB_FRAME_CONSTANTS

	SB_LABEL_CONSTANTS

feature -- Textfield styles

	TEXTFIELD_PASSWD	: INTEGER = 0x00080000	-- Password mode
	TEXTFIELD_INTEGER	: INTEGER = 0x00100000	-- Integer mode
	TEXTFIELD_REAL		: INTEGER = 0x00200000	-- Real mode
	TEXTFIELD_READONLY	: INTEGER = 0x00400000	-- NOT editable
	TEXTFIELD_ENTER_ONLY: INTEGER = 0x00800000	-- Only callback when enter hit
	TEXTFIELD_LIMITED	: INTEGER = 0x01000000	-- Limit entry to given number of columns_count
	TEXTFIELD_OVERSTRIKE: INTEGER = 0x02000000	-- Overstrike mode
	TEXTFIELD_AUTOGRAY	: INTEGER = 0x04000000	-- Automatically gray out text field when not updated
	TEXTFIELD_AUTOHIDE	: INTEGER = 0x08000000	-- Automatically hide text field when not updated

	TEXTFIELD_NORMAL: INTEGER
		once
			Result := Frame_sunken | Frame_thick
		end

end
