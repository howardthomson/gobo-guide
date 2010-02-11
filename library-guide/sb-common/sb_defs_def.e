indexing
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

	SB_TRUE : INTEGER is 1;
	SB_FALSE: INTEGER is 0;
	SB_MAYBE: INTEGER is 2;

feature -- Mouse buttons

	LEFTBUTTON       : INTEGER is 1;
	MIDDLEBUTTON     : INTEGER is 2;
	RIGHTBUTTON      : INTEGER is 3;

feature -- window crossing modes

	CROSSINGNORMAL: INTEGER is 0;	     -- Normal crossing event
	CROSSINGGRAB  : INTEGER is 1;	     -- Crossing due to mouse grab
	CROSSINGUNGRAB: INTEGER is 2;	     -- Crossing due to mouse ungrab



feature -- window visibility modes

	VISIBILITYTOTAL  : INTEGER is 0;
	VISIBILITYPARTIAL: INTEGER is 1;
	VISIBILITYNONE   : INTEGER is 2;


feature -- Options for filematch

	FILEMATCH_FILE_NAME	 : INTEGER is 1	-- No wildcard can ever match `/'
	FILEMATCH_NOESCAPE	 : INTEGER is 2	-- Backslashes don't quote special chars
	FILEMATCH_PERIOD	 : INTEGER is 4	-- Leading `.' is matched only explicitly
	FILEMATCH_LEADING_DIR: INTEGER is 8	-- Ignore `/...' after a match
	FILEMATCH_CASEFOLD	 : INTEGER is 16	-- Compare without regard to case

feature -- Drag and drop actions

	DRAG_REJECT  : INTEGER is 0;                 -- Reject all drop actions
	DRAG_ACCEPT  : INTEGER is 1;                 -- Accept any drop action
	DRAG_COPY    : INTEGER is 2;                 -- Copy
	DRAG_MOVE    : INTEGER is 3;                 -- Move
	DRAG_LINK    : INTEGER is 4;                 -- Link
	DRAG_PRIVATE : INTEGER is 5                  -- Private

feature -- Origin of data

	FROM_SELECTION  : INTEGER is 0;              -- Primary selection
	FROM_CLIPBOARD  : INTEGER is 1;              -- Clipboard
	FROM_DRAGNDROP  : INTEGER is 2               -- Drag and drop source

feature -- Search modes for search/replace dialogs

	SEARCH_FORWARD		: INTEGER is 0	-- Search forward (default)
	SEARCH_BACKWARD		: INTEGER is 1	-- Search backward
	SEARCH_NOWRAP		: INTEGER is 0	-- Don't wrap (default)
	SEARCH_WRAP			: INTEGER is 2	-- Wrap around to start
	SEARCH_EXACT		: INTEGER is 0	-- Exact match (default)
	SEARCH_IGNORECASE	: INTEGER is 4	-- Ignore case
	SEARCH_REGEX		: INTEGER is 8	-- Regular expression match
	SEARCH_PREFIX		: INTEGER is 16	-- Prefix of subject string
	SEARCH_REV_PREFIX	: INTEGER is 32	-- Subject string is prefix of search

end
