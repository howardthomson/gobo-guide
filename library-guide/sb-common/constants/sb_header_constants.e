indexing
	description:"SB_HEADER constants"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"mostly complete"

class SB_HEADER_CONSTANTS

inherit

	SB_FRAME_CONSTANTS

feature -- Header style options

	HEADER_BUTTON		: INTEGER is 0x00008000	-- 00 1000 0000 0000 0000B;         -- Button style can be clicked
	HEADER_HORIZONTAL	: INTEGER is 0x00000000	-- 00 0000 0000 0000 0000B;         -- Horizontal header control (default)
	HEADER_VERTICAL		: INTEGER is 0x00010000	-- 01 0000 0000 0000 0000B;         -- Vertical header control
	HEADER_TRACKING		: INTEGER is 0x00020000	-- 10 0000 0000 0000 0000B;         -- Tracks continuously while moving

	HEADER_NORMAL		: INTEGER is
		once
			Result := HEADER_HORIZONTAL | Frame_normal
		end

end
