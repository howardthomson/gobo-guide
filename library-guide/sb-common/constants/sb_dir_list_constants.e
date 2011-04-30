indexing
	description:"SB_DIR_LIST constants"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

class SB_DIR_LIST_CONSTANTS

inherit

	SB_TREE_LIST_CONSTANTS

feature -- File list options

	DIRLIST_SHOWFILES	: INTEGER is 0x08000000	-- 1000 0000 0000 0000 0000 0000 0000B
		-- Show files as well as directories
	DIRLIST_SHOWHIDDEN	: INTEGER is 0x10000000	-- 1 0000 0000 0000 0000 0000 0000 0000B
		-- Show hidden files or directories
	DIRLIST_NO_OWN_ASSOC: INTEGER is 0x20000000	-- 10 0000 0000 0000 0000 0000 0000 0000B
		-- Do not create_resource associations for files
end
