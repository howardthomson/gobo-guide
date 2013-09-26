note
	description:"widely used constants"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"mostly complete"

	todo: "[
		Split into X and Win32 implementations and
		SB_DEFS_DEF common deferred class
	]"

class SB_DEFS_DEF

inherit

	SB_MODIFIER_MASKS

	SB_SEL_TYPE

	SB_ZERO

feature -- Truth values

	SB_TRUE : INTEGER = 1
	SB_FALSE: INTEGER = 0
	SB_MAYBE: INTEGER = 2

feature -- Mouse buttons

	LEFTBUTTON       : INTEGER = 1
	MIDDLEBUTTON     : INTEGER = 2
	RIGHTBUTTON      : INTEGER = 3

feature -- window crossing modes

	CROSSINGNORMAL: INTEGER = 0	     -- Normal crossing event
	CROSSINGGRAB  : INTEGER = 1	     -- Crossing due to mouse grab
	CROSSINGUNGRAB: INTEGER = 2	     -- Crossing due to mouse ungrab



feature -- window visibility modes

	VISIBILITYTOTAL  : INTEGER = 0
	VISIBILITYPARTIAL: INTEGER = 1
	VISIBILITYNONE   : INTEGER = 2


--feature -- Options for filematch

--	FILEMATCH_FILE_NAME	 : INTEGER = 1	-- No wildcard can ever match `/'
--	FILEMATCH_NOESCAPE	 : INTEGER = 2	-- Backslashes don't quote special chars
--	FILEMATCH_PERIOD	 : INTEGER = 4	-- Leading `.' is matched only explicitly
--	FILEMATCH_LEADING_DIR: INTEGER = 8	-- Ignore `/...' after a match
--	FILEMATCH_CASEFOLD	 : INTEGER = 16	-- Compare without regard to case

feature -- Drag and drop actions

	DRAG_REJECT  : INTEGER = 0                 -- Reject all drop actions
	DRAG_ACCEPT  : INTEGER = 1                 -- Accept any drop action
	DRAG_COPY    : INTEGER = 2                 -- Copy
	DRAG_MOVE    : INTEGER = 3                 -- Move
	DRAG_LINK    : INTEGER = 4                 -- Link
	DRAG_PRIVATE : INTEGER = 5                  -- Private

feature -- Origin of data

	FROM_SELECTION  : INTEGER = 0              -- Primary selection
	FROM_CLIPBOARD  : INTEGER = 1              -- Clipboard
	FROM_DRAGNDROP  : INTEGER = 2              -- Drag and drop source

feature -- Search modes for search/replace dialogs

	SEARCH_FORWARD		: INTEGER = 0	-- Search forward (default)
	SEARCH_BACKWARD		: INTEGER = 1	-- Search backward
	SEARCH_NOWRAP		: INTEGER = 0	-- Don't wrap (default)
	SEARCH_WRAP			: INTEGER = 2	-- Wrap around to start
	SEARCH_EXACT		: INTEGER = 0	-- Exact match (default)
	SEARCH_IGNORECASE	: INTEGER = 4	-- Ignore case
	SEARCH_REGEX		: INTEGER = 8	-- Regular expression match
	SEARCH_PREFIX		: INTEGER = 16	-- Prefix of subject string
	SEARCH_REV_PREFIX	: INTEGER = 32	-- Subject string is prefix of search

end
