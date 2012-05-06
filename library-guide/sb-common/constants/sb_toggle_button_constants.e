note
   description: "SB_TOGGLE_BUTTON constants"
   author: "Eugene Melekhov <eugene_melekhov@mail.ru>"
   copyright: "Copyright (c) 2002, Eugene Melekhov and others"
   license: "Eiffel Forum Freeware License v2 (see forum.txt)"
   status: "mostly complete"

class SB_TOGGLE_BUTTON_CONSTANTS

inherit

   SB_LABEL_CONSTANTS

feature -- Toggle button flags

   TOGGLEBUTTON_AUTOGRAY: INTEGER = 0x00800000	-- Automatically gray out when not updated
   TOGGLEBUTTON_AUTOHIDE: INTEGER = 0x01000000	-- Automatically hide toggle button when not updated
   TOGGLEBUTTON_TOOLBAR : INTEGER = 0x02000000	-- Toolbar style toggle button [flat look]

   TOGGLEBUTTON_NORMAL: INTEGER
      once
         Result := (Frame_raised | Frame_thick | JUSTIFY_NORMAL | ICON_BEFORE_TEXT);
      end

   TOGGLEBUTTON_MASK: INTEGER
      once
         Result := (TOGGLEBUTTON_AUTOGRAY | TOGGLEBUTTON_AUTOHIDE | TOGGLEBUTTON_TOOLBAR);
      end

end
