indexing
	description:"SB_COMBO_BOX constants"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"mostly complete"

	todo: "[
		Check value of COMBOBOX_INSERT_LAST, and potential conflict of the lowest
		bit used: 0x00001000; This is a lower bit than the first used in COMBOBOX_REPLACE
	]"

class SB_COMBO_BOX_CONSTANTS

inherit

	SB_PACKER_CONSTANTS

feature -- ComboBox styles

	COMBOBOX_NO_REPLACE		: INTEGER is 0x00000000	-- 0 0000 0000 0000 0000 0000B;		-- Leave the list the same
	COMBOBOX_REPLACE		: INTEGER is 0x00020000	-- 0 0010 0000 0000 0000 0000B;		-- Replace current item with typed text
	COMBOBOX_INSERT_BEFORE	: INTEGER is 0x00040000	-- 0 0100 0000 0000 0000 0000B;		-- Typed text inserted before current
	COMBOBOX_INSERT_AFTER	: INTEGER is 0x00060000	-- 0 0110 0000 0000 0000 0000B;		-- Typed text inserted after current
	COMBOBOX_INSERT_FIRST	: INTEGER is 0x00080000	-- 0 1000 0000 0000 0000 0000B;		-- Typed text inserted at begin of list
	COMBOBOX_INSERT_LAST	: INTEGER is 0x00090000	-- 0 1001 0000 0000 0000 0000B;		-- Typed text inserted at end of list
	COMBOBOX_STATIC			: INTEGER is 0x00100000	-- 1 0000 0000 0000 0000 0000B;		-- Unchangable text box
	COMBOBOX_NORMAL			: INTEGER is 0x00000000	-- 0 0000 0000 0000 0000 0000B;		-- Can type text but list is not changed

end
