expanded class SB_WAPI_SHOWWINDOW_COMMANDS

feature -- Class data

   -- ShowWindow () Commands
   SW_HIDE              : INTEGER is  0;
   SW_SHOWNORMAL        : INTEGER is  1;
   SW_NORMAL            : INTEGER is  1;
   SW_SHOWMINIMIZED     : INTEGER is  2;
   SW_SHOWMAXIMIZED     : INTEGER is  3;
   SW_MAXIMIZE          : INTEGER is  3;
   SW_SHOWNOACTIVATE    : INTEGER is  4;
   SW_SHOW              : INTEGER is  5;
   SW_MINIMIZE          : INTEGER is  6;
   SW_SHOWMINNOACTIVE   : INTEGER is  7;
   SW_SHOWNA            : INTEGER is  8;
   SW_RESTORE           : INTEGER is  9;
   SW_SHOWDEFAULT       : INTEGER is 10;
   SW_MAX               : INTEGER is 10;

   -- Old ShowWindow () Commands
   HIDE_WINDOW          : INTEGER is  0;
   SHOW_OPENWINDOW      : INTEGER is  1;
   SHOW_ICONWINDOW      : INTEGER is  2;
   SHOW_FULLSCREEN      : INTEGER is  3;
   SHOW_OPENNOACTIVATE  : INTEGER is  4;

   -- Identifiers for the WM_SHOWWINDOW message
   SW_PARENTCLOSING     : INTEGER is  1;
   SW_OTHERZOOM         : INTEGER is  2;
   SW_PARENTOPENING     : INTEGER is  3;
   SW_OTHERUNZOOM       : INTEGER is  4;

   -- ScrollWindowEx () Commands
   SW_SCROLLCHILDREN: INTEGER is 1;
   SW_INVALIDATE: INTEGER is 2;
   SW_ERASE: INTEGER is 4;
   SW_SMOOTHSCROLL: INTEGER is 16;


end
