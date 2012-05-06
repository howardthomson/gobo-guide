expanded class SB_WAPI_COLOR_TYPES

feature -- Class data

   CTLCOLOR_MSGBOX               : INTEGER =  0;
   CTLCOLOR_EDIT                 : INTEGER =  1;
   CTLCOLOR_LISTBOX              : INTEGER =  2;
   CTLCOLOR_BTN                  : INTEGER =  3;
   CTLCOLOR_DLG                  : INTEGER =  4;
   CTLCOLOR_SCROLLBAR            : INTEGER =  5;
   CTLCOLOR_STATIC               : INTEGER =  6;
   CTLCOLOR_MAX                  : INTEGER =  7;

   COLOR_SCROLLBAR               : INTEGER =  0;
   COLOR_BACKGROUND              : INTEGER =  1;
   COLOR_ACTIVECAPTION           : INTEGER =  2;
   COLOR_INACTIVECAPTION         : INTEGER =  3;
   COLOR_MENU                    : INTEGER =  4;
   COLOR_WINDOW                  : INTEGER =  5;
   COLOR_WINDOWFRAME             : INTEGER =  6;
   COLOR_MENUTEXT                : INTEGER =  7;
   COLOR_WINDOWTEXT              : INTEGER =  8;
   COLOR_CAPTIONTEXT             : INTEGER =  9;
   COLOR_ACTIVEBORDER            : INTEGER = 10;
   COLOR_INACTIVEBORDER          : INTEGER = 11;
   COLOR_APPWORKSPACE            : INTEGER = 12;
   COLOR_HIGHLIGHT               : INTEGER = 13;
   COLOR_HIGHLIGHTTEXT           : INTEGER = 14;
   COLOR_BTNFACE                 : INTEGER = 15;
   COLOR_BTNSHADOW               : INTEGER = 16;
   COLOR_GRAYTEXT                : INTEGER = 17;
   COLOR_BTNTEXT                 : INTEGER = 18;
   COLOR_INACTIVECAPTIONTEXT     : INTEGER = 19;
   COLOR_BTNHIGHLIGHT            : INTEGER = 20;

         -- #if(WINVER >= 0x0400)
   COLOR_3DDKSHADOW              : INTEGER = 21;
   COLOR_3DLIGHT                 : INTEGER = 22;
   COLOR_INFOTEXT                : INTEGER = 23;
   COLOR_INFOBK                  : INTEGER = 24;

         -- #if(WINVER >= 0x0500)
   COLOR_HOTLIGHT                : INTEGER = 26;
   COLOR_GRADIENTACTIVECAPTION   : INTEGER = 27;
   COLOR_GRADIENTINACTIVECAPTION : INTEGER = 28;

         -- #if(WINVER >= 0x0400)
   COLOR_DESKTOP                 : INTEGER = 1;  -- COLOR_BACKGROUND
   COLOR_3DFACE                  : INTEGER = 15; -- COLOR_BTNFACE
   COLOR_3DSHADOW                : INTEGER = 16; -- COLOR_BTNSHADOW
   COLOR_3DHIGHLIGHT             : INTEGER = 20; -- COLOR_BTNHIGHLIGHT
   COLOR_3DHILIGHT               : INTEGER = 20; -- COLOR_BTNHIGHLIGHT
   COLOR_BTNHILIGHT              : INTEGER = 20; -- COLOR_BTNHIGHLIGHT

end
