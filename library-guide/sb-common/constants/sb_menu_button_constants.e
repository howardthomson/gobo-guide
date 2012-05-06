note
	description:"Menu button constants"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"mostly complete"

class SB_MENU_BUTTON_CONSTANTS

feature -- Menu button options

	MENUBUTTON_AUTOGRAY      : INTEGER = 0x00800000	-- 1000 0000 0000 0000 0000 0000B;
		-- Automatically gray out when no target

	MENUBUTTON_AUTOHIDE      : INTEGER = 0x01000000	-- 1 0000 0000 0000 0000 0000 0000B;
         -- Automatically hide when no target

	MENUBUTTON_TOOLBAR       : INTEGER = 0x02000000	-- 10 0000 0000 0000 0000 0000 0000B;
         -- Toolbar style

	MENUBUTTON_DOWN          : INTEGER = 0	-- 0B;
         -- Popup window appears below menu button

	MENUBUTTON_UP            : INTEGER = 0x04000000	-- 100 0000 0000 0000 0000 0000 0000B;
         -- Popup window appears above menu button

	MENUBUTTON_LEFT          : INTEGER = 0x08000000	-- 1000 0000 0000 0000 0000 0000 0000B;
         -- Popup window to the left of the menu button

	MENUBUTTON_RIGHT         : INTEGER
         -- Popup window to the right of the menu button
      once
         Result := MENUBUTTON_LEFT | MENUBUTTON_UP;
      end

	MENUBUTTON_NOARROWS      : INTEGER = 0x10000000	-- 1 0000 0000 0000 0000 0000 0000 0000B
         -- Do not show arrows

	MENUBUTTON_ATTACH_LEFT   : INTEGER = 0	-- 0B;
         -- Popup attaches to the left side of the menu button

	MENUBUTTON_ATTACH_TOP    : INTEGER
			-- Popup attaches to the top of the menu button
		once
			Result := MENUBUTTON_ATTACH_LEFT;
		end

	MENUBUTTON_ATTACH_RIGHT  : INTEGER = 0x20000000	-- 10 0000 0000 0000 0000 0000 0000 0000B;
			-- Popup attaches to the right side of the menu button

	MENUBUTTON_ATTACH_BOTTOM : INTEGER
			-- Popup attaches to the bottom of the menu button
		once
			Result := MENUBUTTON_ATTACH_RIGHT;
		end

	MENUBUTTON_ATTACH_CENTER : INTEGER = 0x40000000	-- 100 0000 0000 0000 0000 0000 0000 0000B;
			-- Popup attaches to the center of the menu button

	MENUBUTTON_ATTACH_BOTH   : INTEGER
			-- Popup attaches to both sides of the menu button
		once
			Result := MENUBUTTON_ATTACH_CENTER | MENUBUTTON_ATTACH_RIGHT;
		end

end
