indexing
   description: "SB_TOGGLE_BUTTON constants"
   author: "Eugene Melekhov <eugene_melekhov@mail.ru>"
   copyright: "Copyright (c) 2002, Eugene Melekhov and others"
   license: "Eiffel Forum Freeware License v2 (see forum.txt)"
   status: "mostly complete"

class SB_TOGGLE_BUTTON_CONSTANTS

inherit

   SB_LABEL_CONSTANTS

feature -- Toggle button flags

   TOGGLEBUTTON_AUTOGRAY: INTEGER is 0x00800000	-- Automatically gray out when not updated
   TOGGLEBUTTON_AUTOHIDE: INTEGER is 0x01000000	-- Automatically hide toggle button when not updated
   TOGGLEBUTTON_TOOLBAR : INTEGER is 0x02000000	-- Toolbar style toggle button [flat look]

   TOGGLEBUTTON_NORMAL: INTEGER is
      once
         Result := (Frame_raised | Frame_thick | JUSTIFY_NORMAL | ICON_BEFORE_TEXT);
      end
  
   TOGGLEBUTTON_MASK: INTEGER is
      once
         Result := (TOGGLEBUTTON_AUTOGRAY | TOGGLEBUTTON_AUTOHIDE | TOGGLEBUTTON_TOOLBAR);
      end

feature -- Toggle button flags, BIT Version

--	   TOGGLEBUTTON_AUTOGRAY: BIT 32 is 100000000000000000000000B;		-- Automatically gray out when not updated
--	   TOGGLEBUTTON_AUTOHIDE: BIT 32 is 1000000000000000000000000B;     -- Automatically hide toggle button when not updated
--	   TOGGLEBUTTON_TOOLBAR : BIT 32 is 10000000000000000000000000B;    -- Toolbar style toggle button [flat look]

--	   TOGGLEBUTTON_NORMAL: BIT 32 is
--	      once
--	         Result := (Frame_raised or Frame_thick or JUSTIFY_NORMAL or ICON_BEFORE_TEXT);
--	      end
  
--	   TOGGLEBUTTON_MASK: BIT 32 is
--	      once
--	         Result := (TOGGLEBUTTON_AUTOGRAY or TOGGLEBUTTON_AUTOHIDE or TOGGLEBUTTON_TOOLBAR);
--	      end

end
