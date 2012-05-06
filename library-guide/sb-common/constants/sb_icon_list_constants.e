note
	description:"SB_ICON_LIST constants"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"mostly complete"

	todo: "[
		Check ICONLIST_DETAILED = 0B for appropriate value
	]"

class SB_ICON_LIST_CONSTANTS

inherit

	SB_SCROLL_AREA_CONSTANTS

feature -- Icon list styles

	ICONLIST_EXTENDEDSELECT	: INTEGER = 0x00000000	-- 00 0000 0000 0000 0000 0000B;		-- Extended selection mode
	ICONLIST_SINGLESELECT	: INTEGER = 0x00100000	-- 01 0000 0000 0000 0000 0000B;		-- At most one selected item
	ICONLIST_BROWSESELECT	: INTEGER = 0x00200000	-- 10 0000 0000 0000 0000 0000B;		-- Always exactly one selected item
	ICONLIST_MULTIPLESELECT	: INTEGER = 0x00300000	-- 11 0000 0000 0000 0000 0000B;		-- Multiple selection mode

	ICONLIST_AUTOSIZE		: INTEGER = 0x00400000	--     100 0000 0000 0000 0000 0000B;		-- Automatically size item spacing
	ICONLIST_DETAILED		: INTEGER = 0x00000000	--     000 0000 0000 0000 0000 0000B;		-- List mode
	ICONLIST_MINI_ICONS		: INTEGER = 0x00800000	--    1000 0000 0000 0000 0000 0000B;		-- Mini Icon mode
	ICONLIST_BIG_ICONS		: INTEGER = 0x01000000	--  1 0000 0000 0000 0000 0000 0000B;		-- Big Icon mode
	ICONLIST_ROWS			: INTEGER = 0x00000000	-- 00 0000 0000 0000 0000 0000 0000B;	-- Row-wise mode
	ICONLIST_COLUMNS		: INTEGER = 0x02000000	-- 10 0000 0000 0000 0000 0000 0000B;	-- Column-wise mode

	ICONLIST_NORMAL			: INTEGER = 0	-- 0B;	-- ICONLIST_EXTENDEDSELECT

end
