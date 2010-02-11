expanded class SB_WAPI_WINDOW_MESSAGES

feature -- Class data

   WM_NULL              : INTEGER is    0; -- 0x0000
   WM_CREATE            : INTEGER is    1; -- 0x0001
   WM_DESTROY           : INTEGER is    2; -- 0x0002
   WM_MOVE              : INTEGER is    3; -- 0x0003
   WM_SIZE              : INTEGER is    5; -- 0x0005
   WM_ACTIVATE          : INTEGER is    6; -- 0x0006

         -- WM_ACTIVATE state values
   WA_INACTIVE          : INTEGER is    0; -- 0x0000
   WA_ACTIVE            : INTEGER is    1; -- 0x0001
   WA_CLICKACTIVE       : INTEGER is    2; -- 0x0002

   WM_SETFOCUS          : INTEGER is    7; -- 0x0007
   WM_KILLFOCUS         : INTEGER is    8; -- 0x0008
   WM_ENABLE            : INTEGER is   10; -- 0x000A
   WM_SETREDRAW         : INTEGER is   11; -- 0x000B
   WM_SETTEXT           : INTEGER is   12; -- 0x000C
   WM_GETTEXT           : INTEGER is   13; -- 0x000D
   WM_GETTEXTLENGTH     : INTEGER is   14; -- 0x000E
   WM_PAINT             : INTEGER is   15; -- 0x000F
   WM_CLOSE             : INTEGER is   16; -- 0x0010
   WM_QUERYENDSESSION   : INTEGER is   17; -- 0x0011
   WM_QUIT              : INTEGER is   18; -- 0x0012
   WM_QUERYOPEN         : INTEGER is   19; -- 0x0013
   WM_ERASEBKGND        : INTEGER is   20; -- 0x0014
   WM_SYSCOLORCHANGE    : INTEGER is   21; -- 0x0015
   WM_ENDSESSION        : INTEGER is   22; -- 0x0016
   WM_SHOWWINDOW        : INTEGER is   24; -- 0x0018
   WM_WININICHANGE      : INTEGER is   26; -- 0x001A

   WM_DEVMODECHANGE     : INTEGER is   27; -- 0x001B
   WM_ACTIVATEAPP       : INTEGER is   28; -- 0x001C
   WM_FONTCHANGE        : INTEGER is   29; -- 0x001D
   WM_TIMECHANGE        : INTEGER is   30; -- 0x001E
   WM_CANCELMODE        : INTEGER is   31; -- 0x001F
   WM_SETCURSOR         : INTEGER is   32; -- 0x0020
   WM_MOUSEACTIVATE     : INTEGER is   33; -- 0x0021
   WM_CHILDACTIVATE     : INTEGER is   34; -- 0x0022
   WM_QUEUESYNC         : INTEGER is   35; -- 0x0023

   WM_GETMINMAXINFO     : INTEGER is   36; -- 0x0024

   WM_PAINTICON         : INTEGER is   38; -- 0x0026
   WM_ICONERASEBKGND    : INTEGER is   39; -- 0x0027
   WM_NEXTDLGCTL        : INTEGER is   40; -- 0x0028
   WM_SPOOLERSTATUS     : INTEGER is   42; -- 0x002A
   WM_DRAWITEM          : INTEGER is   43; -- 0x002B
   WM_MEASUREITEM       : INTEGER is   44; -- 0x002C
   WM_DELETEITEM        : INTEGER is   45; -- 0x002D
   WM_VKEYTOITEM        : INTEGER is   46; -- 0x002E
   WM_CHARTOITEM        : INTEGER is   47; -- 0x002F
   WM_SETFONT           : INTEGER is   48; -- 0x0030
   WM_GETFONT           : INTEGER is   49; -- 0x0031
   WM_SETHOTKEY         : INTEGER is   50; -- 0x0032
   WM_GETHOTKEY         : INTEGER is   51; -- 0x0033
   WM_QUERYDRAGICON     : INTEGER is   55; -- 0x0037
   WM_COMPAREITEM       : INTEGER is   57; -- 0x0039

   WM_COMPACTING        : INTEGER is   65; -- 0x0041
   WM_COMMNOTIFY        : INTEGER is   68; -- 0x0044 No longer suported
   WM_WINDOWPOSCHANGING : INTEGER is   70; -- 0x0046
   WM_WINDOWPOSCHANGED  : INTEGER is   71; -- 0x0047

   WM_POWER             : INTEGER is   72; -- 0x0048

   WM_COPYDATA          : INTEGER is   74; -- 0x004A
   WM_CANCELJOURNAL     : INTEGER is   75; -- 0x004B

   WM_NOTIFY            : INTEGER is   78; -- 0x004E
   WM_INPUTLANGCHANGEREQUEST : INTEGER is 80; -- 0x0050
   WM_INPUTLANGCHANGE   : INTEGER is   81; -- 0x0051
   WM_TCARD             : INTEGER is   82; -- 0x0052
   WM_HELP              : INTEGER is   83; -- 0x0053
   WM_USERCHANGED       : INTEGER is   84; -- 0x0054
   WM_NOTIFYFORMAT      : INTEGER is   85; -- 0x0055

   WM_CONTEXTMENU       : INTEGER is  123; -- 0x007B
   WM_STYLECHANGING     : INTEGER is  124; -- 0x007C
   WM_STYLECHANGED      : INTEGER is  125; -- 0x007D
   WM_DISPLAYCHANGE     : INTEGER is  126; -- 0x007E
   WM_GETICON           : INTEGER is  127; -- 0x007F
   WM_SETICON           : INTEGER is  128; -- 0x0080

   WM_NCCREATE          : INTEGER is  129; -- 0x0081
   WM_NCDESTROY         : INTEGER is  130; -- 0x0082
   WM_NCCALCSIZE        : INTEGER is  131; -- 0x0083
   WM_NCHITTEST         : INTEGER is  132; -- 0x0084
   WM_NCPAINT           : INTEGER is  133; -- 0x0085
   WM_NCACTIVATE        : INTEGER is  134; -- 0x0086
   WM_GETDLGCODE        : INTEGER is  135; -- 0x0087

   WM_NCMOUSEMOVE       : INTEGER is  160; -- 0x00A0
   WM_NCLBUTTONDOWN     : INTEGER is  161; -- 0x00A1
   WM_NCLBUTTONUP       : INTEGER is  162; -- 0x00A2
   WM_NCLBUTTONDBLCLK   : INTEGER is  163; -- 0x00A3
   WM_NCRBUTTONDOWN     : INTEGER is  164; -- 0x00A4
   WM_NCRBUTTONUP       : INTEGER is  165; -- 0x00A5
   WM_NCRBUTTONDBLCLK   : INTEGER is  166; -- 0x00A6
   WM_NCMBUTTONDOWN     : INTEGER is  167; -- 0x00A7
   WM_NCMBUTTONUP       : INTEGER is  168; -- 0x00A8
   WM_NCMBUTTONDBLCLK   : INTEGER is  169; -- 0x00A9

   WM_KEYFIRST,
   WM_KEYDOWN           : INTEGER is  256; -- 0x0100
   WM_KEYUP             : INTEGER is  257; -- 0x0101
   WM_CHAR              : INTEGER is  258; -- 0x0102
   WM_DEADCHAR          : INTEGER is  259; -- 0x0103
   WM_SYSKEYDOWN        : INTEGER is  260; -- 0x0104
   WM_SYSKEYUP          : INTEGER is  261; -- 0x0105
   WM_SYSCHAR           : INTEGER is  262; -- 0x0106
   WM_SYSDEADCHAR       : INTEGER is  263; -- 0x0107
   WM_KEYLAST           : INTEGER is  264; -- 0x0108

   WM_INITDIALOG        : INTEGER is  272; -- 0x0110
   WM_COMMAND           : INTEGER is  273; -- 0x0111
   WM_SYSCOMMAND        : INTEGER is  274; -- 0x0112
   WM_TIMER             : INTEGER is  275; -- 0x0113
   WM_HSCROLL           : INTEGER is  276; -- 0x0114
   WM_VSCROLL           : INTEGER is  277; -- 0x0115
   WM_INITMENU          : INTEGER is  278; -- 0x0116
   WM_INITMENUPOPUP     : INTEGER is  279; -- 0x0117
   WM_MENUSELECT        : INTEGER is  287; -- 0x011F
   WM_MENUCHAR          : INTEGER is  288; -- 0x0120
   WM_ENTERIDLE         : INTEGER is  289; -- 0x0121

   WM_CTLCOLORMSGBOX    : INTEGER is  306; -- 0x0132
   WM_CTLCOLOREDIT      : INTEGER is  307; -- 0x0133
   WM_CTLCOLORLISTBOX   : INTEGER is  308; -- 0x0134
   WM_CTLCOLORBTN       : INTEGER is  309; -- 0x0135
   WM_CTLCOLORDLG       : INTEGER is  310; -- 0x0136
   WM_CTLCOLORSCROLLBAR : INTEGER is  311; -- 0x0137
   WM_CTLCOLORSTATIC    : INTEGER is  312; -- 0x0138

   WM_MOUSEFIRST        : INTEGER is  512; -- 0x0200
   WM_MOUSEMOVE         : INTEGER is  512; -- 0x0200
   WM_LBUTTONDOWN       : INTEGER is  513; -- 0x0201
   WM_LBUTTONUP         : INTEGER is  514; -- 0x0202
   WM_LBUTTONDBLCLK     : INTEGER is  515; -- 0x0203
   WM_RBUTTONDOWN       : INTEGER is  516; -- 0x0204
   WM_RBUTTONUP         : INTEGER is  517; -- 0x0205
   WM_RBUTTONDBLCLK     : INTEGER is  518; -- 0x0206
   WM_MBUTTONDOWN       : INTEGER is  519; -- 0x0207
   WM_MBUTTONUP         : INTEGER is  520; -- 0x0208
   WM_MBUTTONDBLCLK     : INTEGER is  521; -- 0x0209

   WM_MOUSEWHEEL        : INTEGER is  522; -- 0x020A
         -- WM_MOUSELAST         : INTEGER is 522; -- 0x020A
         --WM_MOUSELAST         : INTEGER is  521; -- 0x0209

   WM_PARENTNOTIFY      : INTEGER is  528; -- 0x0210
   WM_ENTERMENULOOP     : INTEGER is  529; -- 0x0211
   WM_EXITMENULOOP      : INTEGER is  530; -- 0x0212
   WM_SIZING            : INTEGER is  532; -- 0x0214
   WM_CAPTURECHANGED    : INTEGER is  533; -- 0x0215
   WM_MOVING            : INTEGER is  534; -- 0x0216
   WM_POWERBROADCAST    : INTEGER is  536; -- 0x0218

   WM_MDICREATE         : INTEGER is  544; -- 0x0220
   WM_MDIDESTROY        : INTEGER is  545; -- 0x0221
   WM_MDIACTIVATE       : INTEGER is  546; -- 0x0222
   WM_MDIRESTORE        : INTEGER is  547; -- 0x0223
   WM_MDINEXT           : INTEGER is  548; -- 0x0224
   WM_MDIMAXIMIZE       : INTEGER is  549; -- 0x0225
   WM_MDITILE           : INTEGER is  550; -- 0x0226
   WM_MDICASCADE        : INTEGER is  551; -- 0x0227
   WM_MDIICONARRANGE    : INTEGER is  552; -- 0x0228
   WM_MDIGETACTIVE      : INTEGER is  553; -- 0x0229

   WM_MDISETMENU        : INTEGER is  560; -- 0x0230
   WM_DROPFILES         : INTEGER is  563; -- 0x0233
   WM_MDIREFRESHMENU    : INTEGER is  564; -- 0x0234

   WM_IME_SETCONTEXT    : INTEGER is  641; --0x0281
   WM_IME_NOTIFY        : INTEGER is  642; -- 0x0282
   WM_IME_CONTROL       : INTEGER is  643; -- 0x0283
   WM_IME_COMPOSITIONFULL: INTEGER is 644; -- 0x0284
   WM_IME_SELECT        : INTEGER is  645; -- 0x0285
   WM_IME_CHAR          : INTEGER is  646; -- 0x0286
   WM_IME_REQUEST       : INTEGER is  648; -- 0x0288
   WM_IME_KEYDOWN       : INTEGER is  656; -- 0x0290
   WM_IME_KEYUP         : INTEGER is  657; -- 0x0291

   WM_MOUSEHOVER        : INTEGER is  673; -- 0x02A1
   WM_MOUSELEAVE        : INTEGER is  675; -- 0x02A3

   WM_CUT               : INTEGER is  768; -- 0x0300
   WM_COPY              : INTEGER is  769; -- 0x0301
   WM_PASTE             : INTEGER is  770; -- 0x0302
   WM_CLEAR             : INTEGER is  771; -- 0x0303
   WM_UNDO              : INTEGER is  772; -- 0x0304
   WM_RENDERFORMAT      : INTEGER is  773; -- 0x0305
   WM_RENDERALLFORMATS  : INTEGER is  774; -- 0x0306
   WM_DESTROYCLIPBOARD  : INTEGER is  775; -- 0x0307
   WM_DRAWCLIPBOARD     : INTEGER is  776; -- 0x0308
   WM_PAINTCLIPBOARD    : INTEGER is  777; -- 0x0309
   WM_VSCROLLCLIPBOARD  : INTEGER is  778; -- 0x030A
   WM_SIZECLIPBOARD     : INTEGER is  779; -- 0x030B
   WM_ASKCBFORMATNAME   : INTEGER is  780; -- 0x030C
   WM_CHANGECBCHAIN     : INTEGER is  781; -- 0x030D
   WM_HSCROLLCLIPBOARD  : INTEGER is  782; -- 0x030E
   WM_QUERYNEWPALETTE   : INTEGER is  783; -- 0x030F
   WM_PALETTEISCHANGING : INTEGER is  784; -- 0x0310
   WM_PALETTECHANGED    : INTEGER is  785; -- 0x0311
   WM_HOTKEY            : INTEGER is  786; -- 0x0312

   WM_PENWINFIRST       : INTEGER is  896; -- 0x0380
   WM_PENWINLAST        : INTEGER is  911; -- 0x038F

   WM_USER              : INTEGER is 1024; -- 0x0400

   BM_GETCHECK          : INTEGER is  240; -- 0x00F0
   BM_SETCHECK          : INTEGER is  241; -- 0x00F1
   BM_GETSTATE          : INTEGER is  242; -- 0x00F2
   BM_SETSTATE          : INTEGER is  243; -- 0x00F3
   BM_SETSTYLE          : INTEGER is  244; -- 0x00F4
   BM_CLICK             : INTEGER is  245; -- 0x00F5
   BM_GETIMAGE          : INTEGER is  246; -- 0x00F6
   BM_SETIMAGE          : INTEGER is  247; -- 0x00F7

   LB_ADDSTRING         : INTEGER is  384; -- 0x0180
   LB_INSERTSTRING      : INTEGER is  385; -- 0x0181
   LB_DELETESTRING      : INTEGER is  386; -- 0x0182
   LB_SELITEMRANGEEX    : INTEGER is  387; -- 0x0183
   LB_RESETCONTENT      : INTEGER is  388; -- 0x0184
   LB_SETSEL            : INTEGER is  389; -- 0x0185
   LB_SETCURSEL         : INTEGER is  390; -- 0x0186
   LB_GETSEL            : INTEGER is  391; -- 0x0187
   LB_GETCURSEL         : INTEGER is  392; -- 0x0188
   LB_GETTEXT           : INTEGER is  393; -- 0x0189
   LB_GETTEXTLEN        : INTEGER is  394; -- 0x018A
   LB_GETCOUNT          : INTEGER is  395; -- 0x018B
   LB_SELECTSTRING      : INTEGER is  396; -- 0x018C
   LB_DIR               : INTEGER is  397; -- 0x018D
   LB_GETTOPINDEX       : INTEGER is  398; -- 0x018E

   WM_APP               : INTEGER is 2048; -- 0x8000

         -- WM_NCHITTEST and MOUSEHOOKSTRUCT Mouse Position Codes

   HTERROR             : INTEGER is  -2
   HTTRANSPARENT       : INTEGER is  -1
   HTNOWHERE           : INTEGER is  0
   HTCLIENT            : INTEGER is  1
   HTCAPTION           : INTEGER is  2
   HTSYSMENU           : INTEGER is  3
   HTGROWBOX           : INTEGER is  4
   HTSIZE              : INTEGER is  4
   HTMENU              : INTEGER is  5
   HTHSCROLL           : INTEGER is  6
   HTVSCROLL           : INTEGER is  7
   HTMINBUTTON         : INTEGER is  8
   HTMAXBUTTON         : INTEGER is  9
   HTLEFT              : INTEGER is  10
   HTRIGHT             : INTEGER is  11
   HTTOP               : INTEGER is  12
   HTTOPLEFT           : INTEGER is  13
   HTTOPRIGHT          : INTEGER is  14
   HTBOTTOM            : INTEGER is  15
   HTBOTTOMLEFT        : INTEGER is  16
   HTBOTTOMRIGHT       : INTEGER is  17
   HTBORDER            : INTEGER is  18
   HTREDUCE            : INTEGER is  8  -- HTMINBUTTON
   HTZOOM              : INTEGER is  9  -- HTMAXBUTTON
   HTSIZEFIRST         : INTEGER is  10 -- HTLEFT
   HTSIZELAST          : INTEGER is  17 -- HTBOTTOMRIGHT
   HTOBJECT            : INTEGER is  19
   HTCLOSE             : INTEGER is  20
   HTHELP              : INTEGER is  21

end
