note
	description:"SB System Defined Selector Types"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

class SB_SEL_TYPE

feature

--	SEL_NONE 				: INTEGER is 1;
	SEL_KEYPRESS 			: INTEGER = 2;	-- Key
	SEL_KEYRELEASE 			: INTEGER = 3;
	SEL_LEFTBUTTONPRESS 	: INTEGER = 4;	-- Buttons
	SEL_LEFTBUTTONRELEASE 	: INTEGER = 5;
	SEL_MIDDLEBUTTONPRESS 	: INTEGER = 6;
	SEL_MIDDLEBUTTONRELEASE : INTEGER = 7;
	Sel_rightbuttonpress 	: INTEGER = 8;
	Sel_rightbuttonrelease 	: INTEGER = 9;
	SEL_MOTION 				: INTEGER = 10;	-- Mouse motion
	SEL_ENTER 				: INTEGER = 11;
	SEL_LEAVE 				: INTEGER = 12;
	SEL_FOCUSIN 			: INTEGER = 13;
	SEL_FOCUSOUT 			: INTEGER = 14;
	SEL_KEYMAP 				: INTEGER = 15;
	SEL_UNGRABBED 			: INTEGER = 16;	-- Lost the grab (Windows)
	SEL_PAINT 				: INTEGER = 17;	-- Must repaint window
	SEL_CREATE 				: INTEGER = 18;
	SEL_DESTROY 			: INTEGER = 19;
	SEL_UNMAP 				: INTEGER = 20;
	SEL_MAP 				: INTEGER = 21;
	SEL_CONFIGURE 			: INTEGER = 22;	-- Resize
	SEL_SELECTION_LOST 		: INTEGER = 23;	-- Widget lost selection
	SEL_SELECTION_GAINED 	: INTEGER = 24;	-- Widget gained selection
	SEL_SELECTION_REQUEST 	: INTEGER = 25;	-- Inquire selection data
	SEL_RAISED 				: INTEGER = 26;
	SEL_LOWERED 			: INTEGER = 27;
	SEL_CLOSE 				: INTEGER = 28;	-- Close window
	SEL_CLOSEALL 			: INTEGER = 29;	-- Close all windows
	SEL_DELETE 				: INTEGER = 30;	-- Delete window
	SEL_MINIMIZE 			: INTEGER = 31;	-- Iconified
	SEL_RESTORE 			: INTEGER = 32;	-- No longer iconified or maximized
	SEL_MAXIMIZE 			: INTEGER = 33;	-- Maximized
	SEL_UPDATE 				: INTEGER = 34;	-- GUI update
	SEL_COMMAND 			: INTEGER = 35;	-- GUI command
	SEL_CLICKED 			: INTEGER = 36;	-- Clicked
	SEL_DOUBLECLICKED 		: INTEGER = 37;	-- Double-clicked
	SEL_TRIPLECLICKED 		: INTEGER = 38;	-- Triple-clicked
	SEL_MOUSEWHEEL			: INTEGER = 39;	-- GUI will change
	SEL_CHANGED 			: INTEGER = 40;	-- GUI has changed
	SEL_VERIFY 				: INTEGER = 41;	-- Verify change
	SEL_DESELECTED 			: INTEGER = 42;	-- Deselected
	SEL_SELECTED 			: INTEGER = 43;	-- Selected
	SEL_INSERTED 			: INTEGER = 44;	-- Inserted
	SEL_REPLACED			: INTEGER = 45;	-- Replaced
	SEL_DELETED 			: INTEGER = 46;	-- Deleted
	SEL_OPENED 				: INTEGER = 47;	-- Opened
	SEL_CLOSED 				: INTEGER = 48;	-- Closed
	SEL_EXPANDED 			: INTEGER = 49;	-- Expanded
	SEL_COLLAPSED 			: INTEGER = 50;	-- Collapsed
	SEL_BEGINDRAG 			: INTEGER = 51;	-- Start a drag
	SEL_ENDDRAG 			: INTEGER = 52;	-- End a drag
	SEL_DRAGGED 			: INTEGER = 53;	-- Dragged
	SEL_LASSOED 			: INTEGER = 54;	-- Lassoed
	Sel_timeout 			: INTEGER = 55;	-- Timeout occurred
	SEL_SIGNAL 				: INTEGER = 56;	-- Signal received
	SEL_CLIPBOARD_LOST		: INTEGER = 57;	-- Widget lost clipboard
	SEL_CLIPBOARD_GAINED	: INTEGER = 58;	-- Widget gained clipboard
	SEL_CLIPBOARD_REQUEST 	: INTEGER = 59;	-- Inquire clipboard data
	SEL_CHORE				: INTEGER = 60;	-- Background chore
	SEL_FOCUS_SELF 			: INTEGER = 61;	-- Focus on widget itself
	SEL_FOCUS_RIGHT 		: INTEGER = 62;	-- Focus movements
	SEL_FOCUS_LEFT 			: INTEGER = 63;
	SEL_FOCUS_DOWN 			: INTEGER = 64;
	SEL_FOCUS_UP 			: INTEGER = 65;
	SEL_FOCUS_HOME 			: INTEGER = 66;
	SEL_FOCUS_END 			: INTEGER = 67;
	SEL_FOCUS_NEXT 			: INTEGER = 68;
	SEL_FOCUS_PREV 			: INTEGER = 69;
	SEL_DND_ENTER 			: INTEGER = 70;	-- Drag action entering potential drop target
	SEL_DND_LEAVE 			: INTEGER = 71;	-- Drag action leaving potential drop target
	SEL_DND_DROP 			: INTEGER = 72;	-- Drop on drop target
	SEL_DND_MOTION 			: INTEGER = 73;	-- Drag position changed over potential drop target
	SEL_DND_REQUEST 		: INTEGER = 74;	-- Inquire drag and drop data
	SEL_ACTIVATE 			: INTEGER = 75;	-- Activate through mouse or keyboard
	SEL_DEACTIVATE 			: INTEGER = 76;	-- Deactivate through mouse or keyboard
	SEL_UNCHECK_OTHER 		: INTEGER = 77;	-- Sent by child to parent to uncheck other children
	SEL_UNCHECK_RADIO 		: INTEGER = 78;	-- Sent by parent to uncheck radio children
	SEL_IO_READ 			: INTEGER = 79;	-- Read activity on a pipe
	SEL_IO_WRITE 			: INTEGER = 80;	-- Write activity on a pipe
	SEL_IO_EXCEPT 			: INTEGER = 81;	-- Except activity on a pipe
	SEL_PICKED 				: INTEGER = 82;	-- Picked some location
--	SEL_LAST 				: INTEGER is 83;	-- Last message

end
