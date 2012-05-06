note
	description:"SB_TREE_LIST constants"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

class SB_TREE_LIST_CONSTANTS

feature -- Tree list styles

	TREELIST_EXTENDEDSELECT	: INTEGER = 0x00000000	-- Extended selection mode allows for drag-selection of ranges of items
	TREELIST_SINGLESELECT	: INTEGER = 0x00100000	-- Single selection mode allows up to one item to be selected
	TREELIST_BROWSESELECT	: INTEGER = 0x00200000	-- Browse selection mode enforces one single item to be selected at all times
	TREELIST_MULTIPLESELECT	: INTEGER = 0x00300000	-- Multiple selection mode is used for selection of individual items

	TREELIST_AUTOSELECT		: INTEGER = 0x00400000	-- Automatically select under cursor_item
	Treelist_shows_lines	: INTEGER = 0x00800000	-- Lines is_shown

	Treelist_shows_boxes	: INTEGER = 0x01000000	-- Boxes to expand is_shown
	Treelist_root_boxes		: INTEGER = 0x02000000	-- Display root boxes also
	Treelist_boxes_item_opt	: INTEGER = 0x04000000	-- Box display controlled by item flag
         
	Treelist_normal: INTEGER once Result := TREELIST_EXTENDEDSELECT end

end
