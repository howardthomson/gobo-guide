indexing
	description:"SB System Defined Selector Types"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

class SB_SEL_TYPE

feature

--	SEL_NONE 				: INTEGER is 1;
	SEL_KEYPRESS 			: INTEGER is 2;	-- Key
	SEL_KEYRELEASE 			: INTEGER is 3;
	SEL_LEFTBUTTONPRESS 	: INTEGER is 4;	-- Buttons
	SEL_LEFTBUTTONRELEASE 	: INTEGER is 5;
	SEL_MIDDLEBUTTONPRESS 	: INTEGER is 6;
	SEL_MIDDLEBUTTONRELEASE : INTEGER is 7;
	Sel_rightbuttonpress 	: INTEGER is 8;
	Sel_rightbuttonrelease 	: INTEGER is 9;
	SEL_MOTION 				: INTEGER is 10;	-- Mouse motion
	SEL_ENTER 				: INTEGER is 11;
	SEL_LEAVE 				: INTEGER is 12;
	SEL_FOCUSIN 			: INTEGER is 13;
	SEL_FOCUSOUT 			: INTEGER is 14;
	SEL_KEYMAP 				: INTEGER is 15;
	SEL_UNGRABBED 			: INTEGER is 16;	-- Lost the grab (Windows)
	SEL_PAINT 				: INTEGER is 17;	-- Must repaint window
	SEL_CREATE 				: INTEGER is 18;
	SEL_DESTROY 			: INTEGER is 19;
	SEL_UNMAP 				: INTEGER is 20;
	SEL_MAP 				: INTEGER is 21;
	SEL_CONFIGURE 			: INTEGER is 22;	-- Resize
	SEL_SELECTION_LOST 		: INTEGER is 23;	-- Widget lost selection
	SEL_SELECTION_GAINED 	: INTEGER is 24;	-- Widget gained selection
	SEL_SELECTION_REQUEST 	: INTEGER is 25;	-- Inquire selection data
	SEL_RAISED 				: INTEGER is 26;
	SEL_LOWERED 			: INTEGER is 27;
	SEL_CLOSE 				: INTEGER is 28;	-- Close window
	SEL_CLOSEALL 			: INTEGER is 29;	-- Close all windows
	SEL_DELETE 				: INTEGER is 30;	-- Delete window
	SEL_MINIMIZE 			: INTEGER is 31;	-- Iconified
	SEL_RESTORE 			: INTEGER is 32;	-- No longer iconified or maximized
	SEL_MAXIMIZE 			: INTEGER is 33;	-- Maximized
	SEL_UPDATE 				: INTEGER is 34;	-- GUI update
	SEL_COMMAND 			: INTEGER is 35;	-- GUI command
	SEL_CLICKED 			: INTEGER is 36;	-- Clicked
	SEL_DOUBLECLICKED 		: INTEGER is 37;	-- Double-clicked
	SEL_TRIPLECLICKED 		: INTEGER is 38;	-- Triple-clicked
	SEL_MOUSEWHEEL			: INTEGER is 39;	-- GUI will change
	SEL_CHANGED 			: INTEGER is 40;	-- GUI has changed
	SEL_VERIFY 				: INTEGER is 41;	-- Verify change
	SEL_DESELECTED 			: INTEGER is 42;	-- Deselected
	SEL_SELECTED 			: INTEGER is 43;	-- Selected
	SEL_INSERTED 			: INTEGER is 44;	-- Inserted
	SEL_REPLACED			: INTEGER is 45;	-- Replaced
	SEL_DELETED 			: INTEGER is 46;	-- Deleted
	SEL_OPENED 				: INTEGER is 47;	-- Opened
	SEL_CLOSED 				: INTEGER is 48;	-- Closed
	SEL_EXPANDED 			: INTEGER is 49;	-- Expanded
	SEL_COLLAPSED 			: INTEGER is 50;	-- Collapsed
	SEL_BEGINDRAG 			: INTEGER is 51;	-- Start a drag
	SEL_ENDDRAG 			: INTEGER is 52;	-- End a drag
	SEL_DRAGGED 			: INTEGER is 53;	-- Dragged
	SEL_LASSOED 			: INTEGER is 54;	-- Lassoed
	Sel_timeout 			: INTEGER is 55;	-- Timeout occurred
	SEL_SIGNAL 				: INTEGER is 56;	-- Signal received
	SEL_CLIPBOARD_LOST		: INTEGER is 57;	-- Widget lost clipboard
	SEL_CLIPBOARD_GAINED	: INTEGER is 58;	-- Widget gained clipboard
	SEL_CLIPBOARD_REQUEST 	: INTEGER is 59;	-- Inquire clipboard data
	SEL_CHORE				: INTEGER is 60;	-- Background chore
	SEL_FOCUS_SELF 			: INTEGER is 61;	-- Focus on widget itself
	SEL_FOCUS_RIGHT 		: INTEGER is 62;	-- Focus movements
	SEL_FOCUS_LEFT 			: INTEGER is 63;
	SEL_FOCUS_DOWN 			: INTEGER is 64;
	SEL_FOCUS_UP 			: INTEGER is 65;
	SEL_FOCUS_HOME 			: INTEGER is 66;
	SEL_FOCUS_END 			: INTEGER is 67;
	SEL_FOCUS_NEXT 			: INTEGER is 68;
	SEL_FOCUS_PREV 			: INTEGER is 69;
	SEL_DND_ENTER 			: INTEGER is 70;	-- Drag action entering potential drop target
	SEL_DND_LEAVE 			: INTEGER is 71;	-- Drag action leaving potential drop target
	SEL_DND_DROP 			: INTEGER is 72;	-- Drop on drop target
	SEL_DND_MOTION 			: INTEGER is 73;	-- Drag position changed over potential drop target
	SEL_DND_REQUEST 		: INTEGER is 74;	-- Inquire drag and drop data
	SEL_ACTIVATE 			: INTEGER is 75;	-- Activate through mouse or keyboard
	SEL_DEACTIVATE 			: INTEGER is 76;	-- Deactivate through mouse or keyboard
	SEL_UNCHECK_OTHER 		: INTEGER is 77;	-- Sent by child to parent to uncheck other children
	SEL_UNCHECK_RADIO 		: INTEGER is 78;	-- Sent by parent to uncheck radio children
	SEL_IO_READ 			: INTEGER is 79;	-- Read activity on a pipe
	SEL_IO_WRITE 			: INTEGER is 80;	-- Write activity on a pipe
	SEL_IO_EXCEPT 			: INTEGER is 81;	-- Except activity on a pipe
	SEL_PICKED 				: INTEGER is 82;	-- Picked some location
--	SEL_LAST 				: INTEGER is 83;	-- Last message

end
