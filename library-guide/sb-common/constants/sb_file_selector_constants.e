note
	description:"SB_FILE_SELECTOR constants"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"mostly complete"

	todo: "[
		Split into multiple boolean fields ?
			require_existing
			permit_multiple
			sel_file
			sel_directory
			sel_link
	]"

class SB_FILE_SELECTOR_CONSTANTS

inherit

   	SB_PACKER_CONSTANTS

feature -- File selection modes

   	SELECTFILE_ANY			: INTEGER = 1	-- A single file: INTEGER is existing or not (to save to)
   	SELECTFILE_EXISTING		: INTEGER = 2  -- An existing file (to load)
   	SELECTFILE_MULTIPLE		: INTEGER = 3	-- Multiple existing files
   	SELECTFILE_MULTIPLE_ALL	: INTEGER = 4	-- Multiple existing files or directories
   	SELECTFILE_DIRECTORY	: INTEGER = 5	-- Existing directory

end
