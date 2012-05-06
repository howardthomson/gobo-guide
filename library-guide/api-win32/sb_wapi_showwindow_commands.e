expanded class SB_WAPI_SHOWWINDOW_COMMANDS

feature -- Class data

   -- ShowWindow () Commands
   SW_HIDE              : INTEGER =  0;
   SW_SHOWNORMAL        : INTEGER =  1;
   SW_NORMAL            : INTEGER =  1;
   SW_SHOWMINIMIZED     : INTEGER =  2;
   SW_SHOWMAXIMIZED     : INTEGER =  3;
   SW_MAXIMIZE          : INTEGER =  3;
   SW_SHOWNOACTIVATE    : INTEGER =  4;
   SW_SHOW              : INTEGER =  5;
   SW_MINIMIZE          : INTEGER =  6;
   SW_SHOWMINNOACTIVE   : INTEGER =  7;
   SW_SHOWNA            : INTEGER =  8;
   SW_RESTORE           : INTEGER =  9;
   SW_SHOWDEFAULT       : INTEGER = 10;
   SW_MAX               : INTEGER = 10;

   -- Old ShowWindow () Commands
   HIDE_WINDOW          : INTEGER =  0;
   SHOW_OPENWINDOW      : INTEGER =  1;
   SHOW_ICONWINDOW      : INTEGER =  2;
   SHOW_FULLSCREEN      : INTEGER =  3;
   SHOW_OPENNOACTIVATE  : INTEGER =  4;

   -- Identifiers for the WM_SHOWWINDOW message
   SW_PARENTCLOSING     : INTEGER =  1;
   SW_OTHERZOOM         : INTEGER =  2;
   SW_PARENTOPENING     : INTEGER =  3;
   SW_OTHERUNZOOM       : INTEGER =  4;

   -- ScrollWindowEx () Commands
   SW_SCROLLCHILDREN: INTEGER = 1;
   SW_INVALIDATE: INTEGER = 2;
   SW_ERASE: INTEGER = 4;
   SW_SMOOTHSCROLL: INTEGER = 16;


end
