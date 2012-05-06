note
	description:"SB_FILE_LIST constants"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

class SB_FILE_LIST_CONSTANTS

inherit

	SB_ICON_LIST_CONSTANTS

feature -- File list options

   	FILELIST_SHOWHIDDEN	 : INTEGER = 0x04000000	-- 100 0000 0000 0000 0000 0000 0000B;		(1 << 26)
    		-- Show hidden files or directories
   	FILELIST_SHOWDIRS	 : INTEGER = 0x08000000	-- 1000 0000 0000 0000 0000 0000 0000B;		(1 << 27)
         	-- Show only directories
   	FILELIST_NO_OWN_ASSOC: INTEGER = 0x10000000	-- 1 0000 0000 0000 0000 0000 0000 0000B	(1 << 28)
         	-- Do not create_resource associations for files

end
