indexing
	description:"Keyboard/Button states"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

expanded class SB_MODIFIER_MASKS

feature -- Keyboard and Button states

   SHIFTMASK        : INTEGER is 0x00000001	-- Shift key is down
   CAPSLOCKMASK     : INTEGER is 0x00000002	-- Caps Lock key is down
   CONTROLMASK      : INTEGER is 0x00000004	-- Ctrl key is down
   ALTMASK          : INTEGER is 0x00000008	-- Alt key is down
   NUMLOCKMASK      : INTEGER is 0x00000010	-- Num Lock key is down
   SCROLLLOCKMASK   : INTEGER is 0x000000e0	-- Scroll Lock key is down (seems to vary)
   LEFTBUTTONMASK   : INTEGER is 0x00000100	-- Left mouse button is down
   MIDDLEBUTTONMASK : INTEGER is 0x00000200	-- Middle mouse button is down
   RIGHTBUTTONMASK  : INTEGER is 0x00000400	-- Right mouse button is down

end
