note
	description:"SB_FILE constants"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

class SB_FILE_CONSTANTS

feature -- Options for listing files


	LIST_MATCHING_FILES	: INTEGER = 0x00000000	-- 0B;         -- Matching files
	LIST_MATCHING_DIRS	: INTEGER = 0x00000000	-- 0B;         -- Matching directories
	LIST_NO_FILES		: INTEGER = 0x00000001	-- 1B;         -- Don't list any files
	LIST_NO_DIRS		: INTEGER = 0x00000002	-- 10B;        -- Don't list any directories
	LIST_ALL_FILES		: INTEGER = 0x00000004	-- 100B;       -- List all files
	LIST_ALL_DIRS		: INTEGER = 0x00000008	-- 1000B;      -- List all directories
	LIST_HIDDEN_FILES	: INTEGER = 0x00000010	-- 1 0000B;     -- List hidden files also
	LIST_HIDDEN_DIRS	: INTEGER = 0x00000020	-- 10 0000B;    -- List hidden directories also
	LIST_NO_PARENT		: INTEGER = 0x00000040	-- 100 0000B;   -- Don't include '..' in the listing
	LIST_CASEFOLD		: INTEGER = 0x00000080	-- 1000 0000B;  -- Matching is case-insensitive
end
