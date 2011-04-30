indexing
	description:"SB_GROUP_BOX constants"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"mostly complete"

class SB_GROUP_BOX_CONSTANTS

feature -- INTEGER Version

	GROUPBOX_TITLE_LEFT: INTEGER is 0	-- 0B;
		-- Title is left-justified

	GROUPBOX_TITLE_CENTER: INTEGER is 0x00020000	-- 10 0000 0000 0000 0000B;
		-- Title is centered

	GROUPBOX_TITLE_RIGHT: INTEGER is 0x00040000	-- 100 0000 0000 0000 0000B;
		-- Title is right-justified

	GROUPBOX_NORMAL: INTEGER is 0	-- 0B;

	GROUPBOX_TITLE_MASK: INTEGER is
		once
			Result := GROUPBOX_TITLE_LEFT | GROUPBOX_TITLE_CENTER
			| GROUPBOX_TITLE_RIGHT;
		end

end
