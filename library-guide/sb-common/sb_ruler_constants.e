indexing
	description: "SB_RULER constants"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"mostly complete"

class SB_RULER_CONSTANTS

inherit

   SB_FRAME_CONSTANTS

feature -- Ruler options

	RULER_NORMAL		: INTEGER is 0x00000000	-- 0B;								-- Default appearance (default)
	RULER_HORIZONTAL	: INTEGER is 0x00000000	-- 0000 0000 0000 0000B;			-- Ruler is horizontal (default)
	RULER_VERTICAL		: INTEGER is 0x00008000	-- 1000 0000 0000 0000B;      		-- Ruler is vertical
	RULER_TICKS_OFF		: INTEGER is 0x00000000	-- 0B;								-- Tick marks off (default)
	RULER_TICKS_TOP		: INTEGER is 0x00010000	-- 1 0000 0000 0000 0000B;			-- Ticks on the top  (if horizontal)
	RULER_TICKS_LEFT	: INTEGER is 0x00010000	-- 1 0000 0000 0000 0000B;			-- Ticks on the left (if vertical)
	RULER_TICKS_BOTTOM	: INTEGER is 0x00020000	-- 10 0000 0000 0000 0000B;			-- Ticks on the bottom (if horizontal)
	RULER_TICKS_RIGHT	: INTEGER is 0x00020000	-- 10 0000 0000 0000 0000B;			-- Ticks on the right (if vertical)
	RULER_TICKS_CENTER	: INTEGER is 0x00030000	-- 11 0000 0000 0000 0000B;			-- Ticks on the right (if vertical)

	RULER_NUMBERS		: INTEGER is 0x00040000	-- 100 0000 0000 0000 0000B;		-- Show numbers
	RULER_ARROW			: INTEGER is 0x00080000	-- 1000 0000 0000 0000 0000B;		-- Draw small arrow for cursor position
	RULER_MARKERS		: INTEGER is 0x00100000	-- 1 0000 0000 0000 0000 0000B;		-- Draw markers for indentation settings
	RULER_METRIC		: INTEGER is 0x00000000	-- 0B;								-- Metric subdivision (default)
	RULER_ENGLISH		: INTEGER is 0x00200000	-- 10 0000 0000 0000 0000 0000B;	-- English subdivision

end
