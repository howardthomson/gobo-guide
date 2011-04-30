indexing
	description:"SB_TOP_WINDOW constants"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"mostly complete"

class SB_TOP_WINDOW_CONSTANTS

inherit

	SB_WINDOW_CONSTANTS

feature -- Title and border decorations

	Decor_none			: INTEGER is 0			-- Borderless window
	Decor_title	 		: INTEGER is 0x00020000	-- Window title
	Decor_minimize		: INTEGER is 0x00040000	-- Minimize button
	Decor_maximize		: INTEGER is 0x00080000	-- Maximize button
	Decor_close	 		: INTEGER is 0x00100000	-- Close button
	Decor_border	 	: INTEGER is 0x00200000	-- Border
	Decor_shrinkable	: INTEGER is 0x00400000	-- Window can become smaller
	Decor_stretchable	: INTEGER is 0x00800000	-- Window can become larger
	Decor_resize	 	: INTEGER is 0x00C00000	-- Resize handles
	Decor_menu	 		: INTEGER is 0x01000000	-- Window menu

	Decor_all	 		: INTEGER is
		once
			Result := (Decor_title | Decor_minimize | Decor_maximize | 
					Decor_close | Decor_border | Decor_resize | Decor_menu);
		end

feature	-- Initial window placement  
	PLACEMENT_DEFAULT	: INTEGER is 0;		-- Place it at the default size and location
	PLACEMENT_VISIBLE	: INTEGER is 1;     -- Place window to be fully visible
	PLACEMENT_CURSOR	: INTEGER is 2;     -- Place it under the cursor position
	PLACEMENT_OWNER		: INTEGER is 3;     -- Place it centered on its owner
	PLACEMENT_SCREEN	: INTEGER is 4;     -- Place it centered on the screen
	PLACEMENT_MAXIMIZED	: INTEGER is 5;     -- Place it maximized to the screen size
end
