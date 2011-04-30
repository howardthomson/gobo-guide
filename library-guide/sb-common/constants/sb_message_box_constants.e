indexing
	description:"SB_MESSAGE_BOX constants"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"mostly complete"

class SB_MESSAGE_BOX_CONSTANTS

inherit

	SB_TOP_WINDOW_CONSTANTS

feature -- Message box buttons

	MBOX_OK					: INTEGER is 0x10000000	--   1 0000 0000 0000 0000 0000 0000 0000B;	-- Message box has a only an OK button
	MBOX_OK_CANCEL			: INTEGER is 0x20000000	--  10 0000 0000 0000 0000 0000 0000 0000B;	-- Message box has OK and CANCEL buttons
	MBOX_YES_NO				: INTEGER is 0x30000000	--  11 0000 0000 0000 0000 0000 0000 0000B;	-- Message box has YES and NO buttons
	MBOX_YES_NO_CANCEL		: INTEGER is 0x40000000	-- 100 0000 0000 0000 0000 0000 0000 0000B;	-- Message box has YES; NO; and CANCEL buttons
	MBOX_QUIT_CANCEL		: INTEGER is 0x50000000	-- 101 0000 0000 0000 0000 0000 0000 0000B;	-- Message box has QUIT and CANCEL buttons
	MBOX_QUIT_SAVE_CANCEL	: INTEGER is 0x60000000	-- 110 0000 0000 0000 0000 0000 0000 0000B;	-- Message box has QUIT; SAVE; and CANCEL buttons
	MBOX_SKIP_SKIPALL_CANCEL: INTEGER is 0x70000000	-- 111 0000 0000 0000 0000 0000 0000 0000B;	-- Message box has SKIP, SKIP ALL, and CANCEL buttons    


feature -- Return values

	MBOX_CLICKED_YES	: INTEGER is 1;		-- The YES button was clicked
	MBOX_CLICKED_NO		: INTEGER is 2;		-- The NO button was clicked
	MBOX_CLICKED_OK		: INTEGER is 3;		-- The OK button was clicked
	MBOX_CLICKED_CANCEL	: INTEGER is 4;		-- The CANCEL button was clicked
	MBOX_CLICKED_QUIT	: INTEGER is 5;		-- The QUIT button was clicked
	MBOX_CLICKED_SAVE	: INTEGER is 6;		-- The SAVE button was clicked
	MBOX_CLICKED_SKIP	: INTEGER is 7;		-- The SKIP button was clicked
	MBOX_CLICKED_SKIPALL: INTEGER is 8;		-- The SKIP ALL button was clicked

end
