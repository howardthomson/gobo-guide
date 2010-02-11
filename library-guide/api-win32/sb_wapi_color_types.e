expanded class SB_WAPI_COLOR_TYPES

feature -- Class data

   CTLCOLOR_MSGBOX               : INTEGER is  0;
   CTLCOLOR_EDIT                 : INTEGER is  1;
   CTLCOLOR_LISTBOX              : INTEGER is  2;
   CTLCOLOR_BTN                  : INTEGER is  3;
   CTLCOLOR_DLG                  : INTEGER is  4;
   CTLCOLOR_SCROLLBAR            : INTEGER is  5;
   CTLCOLOR_STATIC               : INTEGER is  6;
   CTLCOLOR_MAX                  : INTEGER is  7;

   COLOR_SCROLLBAR               : INTEGER is  0;
   COLOR_BACKGROUND              : INTEGER is  1;
   COLOR_ACTIVECAPTION           : INTEGER is  2;
   COLOR_INACTIVECAPTION         : INTEGER is  3;
   COLOR_MENU                    : INTEGER is  4;
   COLOR_WINDOW                  : INTEGER is  5;
   COLOR_WINDOWFRAME             : INTEGER is  6;
   COLOR_MENUTEXT                : INTEGER is  7;
   COLOR_WINDOWTEXT              : INTEGER is  8;
   COLOR_CAPTIONTEXT             : INTEGER is  9;
   COLOR_ACTIVEBORDER            : INTEGER is 10;
   COLOR_INACTIVEBORDER          : INTEGER is 11;
   COLOR_APPWORKSPACE            : INTEGER is 12;
   COLOR_HIGHLIGHT               : INTEGER is 13;
   COLOR_HIGHLIGHTTEXT           : INTEGER is 14;
   COLOR_BTNFACE                 : INTEGER is 15;
   COLOR_BTNSHADOW               : INTEGER is 16;
   COLOR_GRAYTEXT                : INTEGER is 17;
   COLOR_BTNTEXT                 : INTEGER is 18;
   COLOR_INACTIVECAPTIONTEXT     : INTEGER is 19;
   COLOR_BTNHIGHLIGHT            : INTEGER is 20;

         -- #if(WINVER >= 0x0400)
   COLOR_3DDKSHADOW              : INTEGER is 21;
   COLOR_3DLIGHT                 : INTEGER is 22;
   COLOR_INFOTEXT                : INTEGER is 23;
   COLOR_INFOBK                  : INTEGER is 24;

         -- #if(WINVER >= 0x0500)
   COLOR_HOTLIGHT                : INTEGER is 26;
   COLOR_GRADIENTACTIVECAPTION   : INTEGER is 27;
   COLOR_GRADIENTINACTIVECAPTION : INTEGER is 28;

         -- #if(WINVER >= 0x0400)
   COLOR_DESKTOP                 : INTEGER is 1;  -- COLOR_BACKGROUND
   COLOR_3DFACE                  : INTEGER is 15; -- COLOR_BTNFACE
   COLOR_3DSHADOW                : INTEGER is 16; -- COLOR_BTNSHADOW
   COLOR_3DHIGHLIGHT             : INTEGER is 20; -- COLOR_BTNHIGHLIGHT
   COLOR_3DHILIGHT               : INTEGER is 20; -- COLOR_BTNHIGHLIGHT
   COLOR_BTNHILIGHT              : INTEGER is 20; -- COLOR_BTNHIGHLIGHT

end
