note
	description:"SB_LIST constants"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

class SB_BASE_LIST_CONSTANTS

feature -- List styles

	LIST_EXTENDEDSELECT	: INTEGER = 0x00000000 -- 00 0000 0000 0000 0000 0000B;
		-- Extended selection mode allows for drag-selection of ranges of items
	LIST_SINGLESELECT	: INTEGER = 0x00100000-- 01 0000 0000 0000 0000 0000B;
		-- Single selection mode allows up to one item to be selected
	LIST_BROWSESELECT	: INTEGER = 0x00200000 -- 10 0000 0000 0000 0000 0000B;
		-- Browse selection mode enforces one single item to be selected at all times
	LIST_MULTIPLESELECT	: INTEGER = 0x00300000 -- 11 0000 0000 0000 0000 0000B;
         -- Multiple selection mode is used for selection of individual items
end
