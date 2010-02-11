indexing

	description: "X11 Graphics Context constants"

	author: "Howard Thomson"
	copyright: "Copyright (c) 2006, Howard Thomson"
	license: "Eiffel Forum License v2 (see forum.txt)"

class X_H

feature

--	X_PROTOCOL			: INTEGER is	11	-- current protocol version
--	X_PROTOCOL_REVISION	: INTEGER is	 0	-- current minor version

--	typedef unsigned long XID;
--	typedef unsigned long Mask;
--	typedef unsigned long Atom;		/* Also in Xdefs.h */
--	typedef unsigned long VisualID;
--	typedef unsigned long Time;

--	typedef XID Window;
--	typedef XID Drawable;
--	typedef XID Font;
--	typedef XID Pixmap;
--	typedef XID Cursor;
--	typedef XID Colormap;
--	typedef XID GContext;
--	typedef XID KeySym;

--	typedef unsigned char KeyCode;

-- *****************************************************************
-- * RESERVED RESOURCE AND CONSTANT DEFINITIONS
-- *****************************************************************

	 None           : INTEGER is      0		-- universal null resource or null atom

	 ParentRelative : INTEGER is       1	-- background pixmap in CreateWindow
											-- and ChangeWindowAttributes

	 CopyFromParent : INTEGER is       0	-- border pixmap in CreateWindow
											-- and ChangeWindowAttributes
											-- special VisualID and special window
											-- class passed to CreateWindow

	 PointerWindow	: INTEGER is 	0	-- destination window in SendEvent
	 InputFocus		: INTEGER is 	1	-- destination window in SendEvent

	 PointerRoot	: INTEGER is 	1	-- focus window in SetInputFocus

	 AnyPropertyType: INTEGER is 	0	-- special Atom, passed to GetProperty

	 AnyKey		    : INTEGER is  	0	-- special Key Code, passed to GrabKey

	 AnyButton		: INTEGER is 	0	-- special Button Code, passed to GrabButton

	 AllTemporary	: INTEGER is 	0	-- special Resource ID passed to KillClient

	 CurrentTime	: INTEGER is 	0	-- special Time

	 NoSymbol		: INTEGER is 	0	-- special KeySym

-- **************************************************************** 
-- * EVENT DEFINITIONS 
-- ****************************************************************

feature -- Input Event Masks.
	-- Used as event-mask window attribute and as arguments
	-- to Grab requests.  Not to be confused with event names.

	 NoEventMask			: INTEGER is 0x00000000		
	 KeyPressMask			: INTEGER is 0x00000001	--	(1L<<0)  
	 KeyReleaseMask			: INTEGER is 0x00000002	--	(1L<<1)  
	 ButtonPressMask		: INTEGER is 0x00000004	--	(1L<<2)  
	 ButtonReleaseMask		: INTEGER is 0x00000008	--	(1L<<3)  
	 EnterWindowMask		: INTEGER is 0x00000010	--	(1L<<4)  
	 LeaveWindowMask		: INTEGER is 0x00000020	--	(1L<<5)  
	 PointerMotionMask		: INTEGER is 0x00000040	--	(1L<<6)  
	 PointerMotionHintMask	: INTEGER is 0x00000080	--	(1L<<7)  
	 Button1MotionMask		: INTEGER is 0x00000100	--	(1L<<8)  
	 Button2MotionMask		: INTEGER is 0x00000200	--	(1L<<9)  
	 Button3MotionMask		: INTEGER is 0x00000400	--	(1L<<10) 
	 Button4MotionMask		: INTEGER is 0x00000800	--	(1L<<11) 
	 Button5MotionMask		: INTEGER is 0x00001000	--	(1L<<12) 
	 ButtonMotionMask		: INTEGER is 0x00002000	--	(1L<<13) 
	 KeymapStateMask		: INTEGER is 0x00004000	--	(1L<<14)
	 ExposureMask			: INTEGER is 0x00008000	--	(1L<<15) 
	 VisibilityChangeMask	: INTEGER is 0x00010000	--	(1L<<16) 
	 StructureNotifyMask	: INTEGER is 0x00020000	--	(1L<<17) 
	 ResizeRedirectMask		: INTEGER is 0x00040000	--	(1L<<18) 
	 SubstructureNotifyMask	: INTEGER is 0x00080000	--	(1L<<19) 
	 SubstructureRedirectMask:INTEGER is 0x00100000	--	(1L<<20) 
	 FocusChangeMask		: INTEGER is 0x00200000	--	(1L<<21) 
	 PropertyChangeMask		: INTEGER is 0x00400000	--	(1L<<22) 
	 ColormapChangeMask		: INTEGER is 0x00800000	--	(1L<<23) 
	 OwnerGrabButtonMask	: INTEGER is 0x01000000	--	(1L<<24) 

feature -- Event names.

	-- Used in "type" field in XEvent structures.  Not to be
	-- confused with event masks above.  They start from 2 because 0 and 1
	-- are reserved in the protocol for errors and replies.

	 KeyPress			: INTEGER is 	2
	 KeyRelease			: INTEGER is 	3
	 ButtonPress		: INTEGER is 	4
	 ButtonRelease		: INTEGER is 	5
	 MotionNotify		: INTEGER is 	6
	 EnterNotify		: INTEGER is 	7
	 LeaveNotify		: INTEGER is 	8
	 FocusIn			: INTEGER is 	9
	 FocusOut			: INTEGER is 	10
	 KeymapNotify		: INTEGER is 	11
--	 Expose				: INTEGER is 	12
	 GraphicsExpose		: INTEGER is 	13
	 NoExpose			: INTEGER is 	14
	 VisibilityNotify	: INTEGER is 	15
	 CreateNotify		: INTEGER is 	16
	 DestroyNotify		: INTEGER is 	17
	 UnmapNotify		: INTEGER is 	18
	 MapNotify			: INTEGER is 	19
	 MapRequest			: INTEGER is 	20
	 ReparentNotify		: INTEGER is 	21
	 ConfigureNotify	: INTEGER is 	22
	 ConfigureRequest	: INTEGER is 	23
	 GravityNotify		: INTEGER is 	24
	 ResizeRequest		: INTEGER is 	25
	 CirculateNotify	: INTEGER is 	26
	 CirculateRequest	: INTEGER is 	27
	 PropertyNotify		: INTEGER is 	28
	 SelectionClear		: INTEGER is 	29
	 SelectionRequest	: INTEGER is 	30
	 SelectionNotify	: INTEGER is 	31
	 ColormapNotify		: INTEGER is 	32
	 ClientMessage		: INTEGER is 	33
	 MappingNotify		: INTEGER is 	34
	 --LASTEvent		35 must be bigger than any event #


feature --	Key masks.

	-- Used as modifiers to GrabButton and GrabKey, results of QueryPointer,
	-- state in various key-, mouse-, and button-related events.

--	ShiftMask	: INTEGER is 0x00000001	--	(1<<0)
	LockMask	: INTEGER is 0x00000002	--	(1<<1)
--	ControlMask	: INTEGER is 0x00000004	--	(1<<2)
	Mod1Mask	: INTEGER is 0x00000008	--	(1<<3)
	Mod2Mask	: INTEGER is 0x00000010	--	(1<<4)
	Mod3Mask	: INTEGER is 0x00000020	--	(1<<5)
	Mod4Mask	: INTEGER is 0x00000040	--	(1<<6)
	Mod5Mask	: INTEGER is 0x00000080	--	(1<<7)

feature -- modifier names

	-- Used to build a SetModifierMapping request or
	-- to read a GetModifierMapping request.  These correspond to the
	-- masks defined above.
	 ShiftMapIndex			: INTEGER is 		0
	 LockMapIndex			: INTEGER is 		1
	 ControlMapIndex		: INTEGER is 		2
	 Mod1MapIndex			: INTEGER is 		3
	 Mod2MapIndex			: INTEGER is 		4
	 Mod3MapIndex			: INTEGER is 		5
	 Mod4MapIndex			: INTEGER is 		6
	 Mod5MapIndex			: INTEGER is 		7


feature -- button masks.

	-- Used in same manner as Key masks above. Not to be confused
	-- with button names below.

	 Button1Mask : INTEGER is 0x00000100	--	(1<<8)
	 Button2Mask : INTEGER is 0x00000200	--	(1<<9)
	 Button3Mask : INTEGER is 0x00000400	--	(1<<10)
	 Button4Mask : INTEGER is 0x00000800	--	(1<<11)
	 Button5Mask : INTEGER is 0x00001000	--	(1<<12)

	 AnyModifier : INTEGER is 0x00008000	--  (1<<15) used in GrabButton, GrabKey


feature -- button names.

	-- Used as arguments to GrabButton and as detail in ButtonPress
	--   and ButtonRelease events.  Not to be confused with button masks above.
	--   Note that 0 is already defined above as "AnyButton".

	 Button1			: INTEGER is 	1
	 Button2			: INTEGER is 	2
	 Button3			: INTEGER is 	3
	 Button4			: INTEGER is 	4
	 Button5			: INTEGER is 	5

-- Notify modes

	 NotifyNormal		: INTEGER is 	0
	 NotifyGrab			: INTEGER is 	1
	 NotifyUngrab		: INTEGER is 	2
	 NotifyWhileGrabbed	: INTEGER is 	3

	 NotifyHint			: INTEGER is 		1	-- for MotionNotify events
		       
feature -- Notify detail

	 NotifyAncestor			: INTEGER is 	0
	 NotifyVirtual			: INTEGER is 	1
	 NotifyInferior			: INTEGER is 	2
	 NotifyNonlinear		: INTEGER is 	3
	 NotifyNonlinearVirtual	: INTEGER is 	4
	 NotifyPointer			: INTEGER is 	5
	 NotifyPointerRoot		: INTEGER is 	6
	 NotifyDetailNone		: INTEGER is 	7

feature --  Visibility notify

	 VisibilityUnobscured			: INTEGER is 		0
	 VisibilityPartiallyObscured	: INTEGER is 		1
	 VisibilityFullyObscured		: INTEGER is 		2

feature -- Circulation request

	 PlaceOnTop			: INTEGER is 		0
	 PlaceOnBottom		: INTEGER is 		1

feature -- protocol families

	 FamilyInternet		: INTEGER is 		0
	 FamilyDECnet		: INTEGER is 		1
	 FamilyChaos		: INTEGER is 		2

feature -- Property notification

	 PropertyNewValue		: INTEGER is 	0
	 PropertyDelete			: INTEGER is 	1

feature -- Color Map notification

	 ColormapUninstalled	: INTEGER is 	0
	 ColormapInstalled		: INTEGER is 	1

feature -- GrabPointer, GrabButton, GrabKeyboard, GrabKey Modes

	 GrabModeSync			: INTEGER is 		0
	 GrabModeAsync			: INTEGER is 		1

feature -- GrabPointer, GrabKeyboard reply status

	 GrabSuccess	: INTEGER is 		0
	 AlreadyGrabbed	: INTEGER is 		1
	 GrabInvalidTime: INTEGER is 		2
	 GrabNotViewable: INTEGER is 		3
	 GrabFrozen		: INTEGER is 		4

feature -- AllowEvents modes

	 AsyncPointer		: INTEGER is 		0
	 SyncPointer		: INTEGER is 		1
	 ReplayPointer		: INTEGER is 		2
	 AsyncKeyboard		: INTEGER is 		3
	 SyncKeyboard		: INTEGER is 		4
	 ReplayKeyboard		: INTEGER is 		5
	 AsyncBoth			: INTEGER is 		6
	 SyncBoth			: INTEGER is 		7

feature -- Used in SetInputFocus, GetInputFocus */

	 RevertToNone			: INTEGER is 	0
	 RevertToPointerRoot	: INTEGER is 	1
	 RevertToParent			: INTEGER is 	2

--****************************************************************
feature -- ERROR CODES 
--****************************************************************

	 Success			: INTEGER is 0	-- everything's okay
	 BadRequest			: INTEGER is 1	-- bad request code
	 BadValue			: INTEGER is 2	-- int parameter out of range
	 BadWindow			: INTEGER is 3	-- parameter not a Window
	 BadPixmap			: INTEGER is 4	-- parameter not a Pixmap
	 BadAtom			: INTEGER is 5	-- parameter not an Atom
	 BadCursor			: INTEGER is 6	-- parameter not a Cursor
	 BadFont			: INTEGER is 7	-- parameter not a Font
	 BadMatch			: INTEGER is 8	-- parameter mismatch
	 BadDrawable		: INTEGER is 9	-- parameter not a Pixmap or Window
	 BadAccess			: INTEGER is 10	-- depending on context:
										-- key/button already grabbed
				 						-- attempt to free an illegal 
										--		cmap entry 
										-- attempt to store into a read-only 
										--		color map entry.
 										-- attempt to modify the access control
										--		list from other than the local host.
	 BadAlloc			: INTEGER is 11	-- insufficient resources
	 BadColor			: INTEGER is 12	-- no such colormap
	 BadGC				: INTEGER is 13	-- parameter not a GC
	 BadIDChoice		: INTEGER is 14	-- choice not in range or already used
	 BadName			: INTEGER is 15	-- font or color name doesn't exist
	 BadLength			: INTEGER is 16	-- Request length incorrect
	 BadImplementation	: INTEGER is 17	-- server is defective

	 FirstExtensionError: INTEGER is 	128
	 LastExtensionError	: INTEGER is 	255

-- *****************************************************************
feature --  * WINDOW DEFINITIONS 
-- *****************************************************************

	-- Window classes used by CreateWindow
	-- Note that CopyFromParent is already defined as 0 above

	 InputOutput: INTEGER is		1
	 InputOnly: INTEGER is			2

feature -- Window attributes for CreateWindow and ChangeWindowAttributes

	 Cw_back_pixmap			: INTEGER is	0x00000001	--	(1L<<0)
	 Cw_back_pixel			: INTEGER is	0x00000002	--	(1L<<1)
	 Cw_border_pixmap		: INTEGER is	0x00000004	--	(1L<<2)
	 Cw_border_pixel		: INTEGER is	0x00000008	--	(1L<<3)
	 Cw_bit_gravity			: INTEGER is	0x00000010	--	(1L<<4)
	 Cw_win_gravity			: INTEGER is	0x00000020	--	(1L<<5)
	 Cw_backing_store 		: INTEGER is	0x00000040	--	(1L<<6)
	 Cw_backing_planes		: INTEGER is	0x00000080	--	(1L<<7)
	 Cw_backing_pixel		: INTEGER is	0x00000100	--	(1L<<8)
	 Cw_override_redirect	: INTEGER is	0x00000200	--	(1L<<9)
	 Cw_save_under			: INTEGER is	0x00000400	--	(1L<<10)
	 Cw_event_mask			: INTEGER is	0x00000800	--	(1L<<11)
	 Cw_do_not_propagate	: INTEGER is	0x00001000	--	(1L<<12)
	 Cw_colormap			: INTEGER is	0x00002000	--	(1L<<13)
	 Cw_cursor				: INTEGER is	0x00004000	--	(1L<<14)

feature -- ConfigureWindow structure

	 Cw_x			: INTEGER is	0x00000001	--	(1<<0)
	 Cw_y			: INTEGER is	0x00000002	--	(1<<1)
	 Cw_width		: INTEGER is	0x00000004	--	(1<<2)
	 Cw_height		: INTEGER is	0x00000008	--	(1<<3)
	 Cw_border_width: INTEGER is	0x00000010	--	(1<<4)
	 Cw_sibling		: INTEGER is	0x00000020	--	(1<<5)
	 Cw_stack_mode	: INTEGER is	0x00000040	--	(1<<6)


feature -- Bit Gravity

	 ForgetGravity			: INTEGER is 	0
	 NorthWestGravity		: INTEGER is 	1
	 NorthGravity			: INTEGER is 	2
	 NorthEastGravity		: INTEGER is 	3
	 WestGravity			: INTEGER is 	4
	 CenterGravity			: INTEGER is 	5
	 EastGravity			: INTEGER is 	6
	 SouthWestGravity		: INTEGER is 	7
	 SouthGravity			: INTEGER is 	8
	 SouthEastGravity		: INTEGER is 	9
	 StaticGravity			: INTEGER is 	10

feature -- Window gravity + bit gravity above

	 UnmapGravity			: INTEGER is 		0

feature -- Used in CreateWindow for backing-store hint

--	 NotUseful		: INTEGER is		0
--	 WhenMapped		: INTEGER is		1
--	 Always			: INTEGER is		2

feature -- Used in GetWindowAttributes reply

	 IsUnmapped			: INTEGER is 		0
	 IsUnviewable		: INTEGER is 		1
	 IsViewable			: INTEGER is 		2

feature -- Used in ChangeSaveSet

	 SetModeInsert			: INTEGER is            0
	 SetModeDelete			: INTEGER is            1

feature --  Used in ChangeCloseDownMode

	 DestroyAll			: INTEGER is               0
	 RetainPermanent	: INTEGER is          1
	 RetainTemporary	: INTEGER is          2

feature -- Window stacking method (in configureWindow)

	 Above			: INTEGER is	0
	 Below			: INTEGER is	1
	 TopIf			: INTEGER is	2
	 BottomIf		: INTEGER is	3
	 Opposite		: INTEGER is	4

feature -- Circulation direction

	 RaiseLowest			: INTEGER is	0
	 LowerHighest			: INTEGER is	 1

feature -- Property modes

	 PropModeReplace		: INTEGER is	 0
	 PropModePrepend		: INTEGER is	1
	 PropModeAppend			: INTEGER is	2

-- *****************************************************************
feature --  * GRAPHICS DEFINITIONS
-- *****************************************************************

-- graphics functions, as in GC.alu

	GXclear			: INTEGER is 0		-- 0
	GXand			: INTEGER is 1		-- src AND dst
	GXandReverse	: INTEGER is 2		-- src AND NOT dst
	GXcopy			: INTEGER is 3		-- src
	GXandInverted	: INTEGER is 4		-- NOT src AND dst
	GXnoop			: INTEGER is 5		-- dst
	GXxor			: INTEGER is 6		-- src XOR dst
	GXor			: INTEGER is 7		-- src OR dst
	GXnor			: INTEGER is 8		-- NOT src AND NOT dst
	GXequiv			: INTEGER is 9		-- NOT src XOR dst
	GXinvert		: INTEGER is 10		-- NOT dst
	GXorReverse		: INTEGER is 11		-- src OR NOT dst
	GXcopyInverted	: INTEGER is 12		-- NOT src
	GXorInverted	: INTEGER is 13		-- NOT src OR dst
	GXnand			: INTEGER is 14		-- NOT src OR NOT dst
	GXset			: INTEGER is 15		-- 1

feature -- SetClipRectangles ordering

	-- Moved to X_GC_CONSTANTS

--	 Unsorted			: INTEGER is 	0
--	 YSorted			: INTEGER is 	1
--	 YXSorted			: INTEGER is 	2
--	 YXBanded			: INTEGER is 	3

feature -- CoordinateMode for drawing routines

	 CoordModeOrigin	: INTEGER is 	0	-- relative to the origin
	 CoordModePrevious	: INTEGER is    1	-- relative to previous point

feature -- Polygon shapes

	 Complex		: INTEGER is 		0	-- paths may intersect
	 Nonconvex		: INTEGER is 		1	-- no paths intersect, but not convex
	 Convex			: INTEGER is 		2	-- wholly convex

feature -- Arc modes for PolyFillArc

	 ArcChord		: INTEGER is 		0	-- join endpoints of arc
	 ArcPieSlice	: INTEGER is 		1	-- join endpoints to center of arc

feature -- GC Masks
	-- GC components: masks used in CreateGC, CopyGC, ChangeGC, OR'ed into
   	-- GC.stateChanges


-- *****************************************************************
feature --  * FONTS 
-- *****************************************************************

-- used in QueryFont -- draw direction

	 FontLeftToRight	: INTEGER is 		0
	 FontRightToLeft	: INTEGER is 		1

	 FontChange			: INTEGER is 		255

-- *****************************************************************
feature --  *  IMAGING 
-- *****************************************************************

-- ImageFormat -- PutImage, GetImage

	 XYBitmap	: INTEGER is 		0	-- depth 1, XYFormat
	 XYPixmap	: INTEGER is 		1	-- depth == drawable depth
	 ZPixmap	: INTEGER is 		2	-- depth == drawable depth

-- *****************************************************************
feature --  *  COLOR MAP STUFF 
-- *****************************************************************

-- For CreateColormap

	 AllocNone	: INTEGER is 		0	-- create map with no entries
	 AllocAll	: INTEGER is 		1	-- allocate entire map writeable


-- Flags used in StoreNamedColor, StoreColors

	DoRed		: INTEGER is	1	--	(1<<0)
	DoGreen		: INTEGER is	2	--	(1<<1)
	DoBlue		: INTEGER is	4	--	(1<<2)

-- *****************************************************************
feature --  * CURSOR STUFF
-- *****************************************************************

-- QueryBestSize Class 

	 CursorShape		: INTEGER is 		0	-- largest size that can be displayed
	 TileShape			: INTEGER is 		1	-- size tiled fastest
	 StippleShape		: INTEGER is 		2	-- size stippled fastest

-- ***************************************************************** 
feature --  * KEYBOARD/POINTER STUFF
-- *****************************************************************

	 AutoRepeatModeOff		: INTEGER is 	0
	 AutoRepeatModeOn		: INTEGER is 	1
	 AutoRepeatModeDefault	: INTEGER is 	2

	 LedModeOff	: INTEGER is 		0
	 LedModeOn	: INTEGER is 		1

-- masks for ChangeKeyboardControl

	 KBKeyClickPercent	: INTEGER is 0x00000001	-- (1L<<0)
	 KBBellPercent		: INTEGER is 0x00000002	-- (1L<<1)
	 KBBellPitch		: INTEGER is 0x00000004	-- (1L<<2)
	 KBBellDuration		: INTEGER is 0x00000008	-- (1L<<3)
	 KBLed				: INTEGER is 0x00000010	-- (1L<<4)
	 KBLedMode			: INTEGER is 0x00000020	-- (1L<<5)
	 KBKey				: INTEGER is 0x00000040	-- (1L<<6)
	 KBAutoRepeatMode	: INTEGER is 0x00000080	-- (1L<<7)

	 MappingSuccess			: INTEGER is	0
	 MappingBusy			: INTEGER is	1
	 MappingFailed			: INTEGER is	2

	 MappingModifier		: INTEGER is	0
	 MappingKeyboard		: INTEGER is 	1
	 MappingPointer			: INTEGER is 	2

-- *****************************************************************
feature --  * SCREEN SAVER STUFF 
-- *****************************************************************

	 DontPreferBlanking		: INTEGER is	0
	 PreferBlanking			: INTEGER is	1
	 DefaultBlanking		: INTEGER is	2

	 DisableScreenSaver		: INTEGER is 	0
	 DisableScreenInterval	: INTEGER is 	0

	 DontAllowExposures		: INTEGER is 	0
	 AllowExposures			: INTEGER is 	1
	 DefaultExposures		: INTEGER is 	2

-- ForceScreenSaver

	 ScreenSaverReset		: INTEGER is  0
	 ScreenSaverActive		: INTEGER is  1

-- *****************************************************************
feature --  * HOSTS AND CONNECTIONS
-- *****************************************************************

-- for ChangeHosts

	 HostInsert		: INTEGER is 		0
	 HostDelete		: INTEGER is 		1

-- for ChangeAccessControl

	EnableAccess	: INTEGER is 		1      
	DisableAccess	: INTEGER is 		0

-- Display classes  used in opening the connection
-- Note that the statically allocated ones are even numbered and the
-- dynamically changeable ones are odd numbered

	 StaticGray		: INTEGER is 		0
	 GrayScale		: INTEGER is 		1
	 StaticColor	: INTEGER is 		2
	 PseudoColor	: INTEGER is 		3
	 TrueColor		: INTEGER is 		4
	 DirectColor	: INTEGER is 		5


-- Byte order  used in imageByteOrder and bitmapBitOrder

	 LSBFirst		: INTEGER is 		0
	 MSBFirst		: INTEGER is 		1

end
