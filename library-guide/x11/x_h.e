note

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

	 None           : INTEGER =      0		-- universal null resource or null atom

	 ParentRelative : INTEGER =       1	-- background pixmap in CreateWindow
											-- and ChangeWindowAttributes

	 CopyFromParent : INTEGER =       0	-- border pixmap in CreateWindow
											-- and ChangeWindowAttributes
											-- special VisualID and special window
											-- class passed to CreateWindow

	 PointerWindow	: INTEGER = 	0	-- destination window in SendEvent
	 InputFocus		: INTEGER = 	1	-- destination window in SendEvent

	 PointerRoot	: INTEGER = 	1	-- focus window in SetInputFocus

	 AnyPropertyType: INTEGER = 	0	-- special Atom, passed to GetProperty

	 AnyKey		    : INTEGER =  	0	-- special Key Code, passed to GrabKey

	 AnyButton		: INTEGER = 	0	-- special Button Code, passed to GrabButton

	 AllTemporary	: INTEGER = 	0	-- special Resource ID passed to KillClient

	 CurrentTime	: INTEGER = 	0	-- special Time

	 NoSymbol		: INTEGER = 	0	-- special KeySym

-- **************************************************************** 
-- * EVENT DEFINITIONS 
-- ****************************************************************

feature -- Input Event Masks.
	-- Used as event-mask window attribute and as arguments
	-- to Grab requests.  Not to be confused with event names.

	 NoEventMask			: INTEGER = 0x00000000		
	 KeyPressMask			: INTEGER = 0x00000001	--	(1L<<0)  
	 KeyReleaseMask			: INTEGER = 0x00000002	--	(1L<<1)  
	 ButtonPressMask		: INTEGER = 0x00000004	--	(1L<<2)  
	 ButtonReleaseMask		: INTEGER = 0x00000008	--	(1L<<3)  
	 EnterWindowMask		: INTEGER = 0x00000010	--	(1L<<4)  
	 LeaveWindowMask		: INTEGER = 0x00000020	--	(1L<<5)  
	 PointerMotionMask		: INTEGER = 0x00000040	--	(1L<<6)  
	 PointerMotionHintMask	: INTEGER = 0x00000080	--	(1L<<7)  
	 Button1MotionMask		: INTEGER = 0x00000100	--	(1L<<8)  
	 Button2MotionMask		: INTEGER = 0x00000200	--	(1L<<9)  
	 Button3MotionMask		: INTEGER = 0x00000400	--	(1L<<10) 
	 Button4MotionMask		: INTEGER = 0x00000800	--	(1L<<11) 
	 Button5MotionMask		: INTEGER = 0x00001000	--	(1L<<12) 
	 ButtonMotionMask		: INTEGER = 0x00002000	--	(1L<<13) 
	 KeymapStateMask		: INTEGER = 0x00004000	--	(1L<<14)
	 ExposureMask			: INTEGER = 0x00008000	--	(1L<<15) 
	 VisibilityChangeMask	: INTEGER = 0x00010000	--	(1L<<16) 
	 StructureNotifyMask	: INTEGER = 0x00020000	--	(1L<<17) 
	 ResizeRedirectMask		: INTEGER = 0x00040000	--	(1L<<18) 
	 SubstructureNotifyMask	: INTEGER = 0x00080000	--	(1L<<19) 
	 SubstructureRedirectMask:INTEGER = 0x00100000	--	(1L<<20) 
	 FocusChangeMask		: INTEGER = 0x00200000	--	(1L<<21) 
	 PropertyChangeMask		: INTEGER = 0x00400000	--	(1L<<22) 
	 ColormapChangeMask		: INTEGER = 0x00800000	--	(1L<<23) 
	 OwnerGrabButtonMask	: INTEGER = 0x01000000	--	(1L<<24) 

feature -- Event names.

	-- Used in "type" field in XEvent structures.  Not to be
	-- confused with event masks above.  They start from 2 because 0 and 1
	-- are reserved in the protocol for errors and replies.

	 KeyPress			: INTEGER = 	2
	 KeyRelease			: INTEGER = 	3
	 ButtonPress		: INTEGER = 	4
	 ButtonRelease		: INTEGER = 	5
	 MotionNotify		: INTEGER = 	6
	 EnterNotify		: INTEGER = 	7
	 LeaveNotify		: INTEGER = 	8
	 FocusIn			: INTEGER = 	9
	 FocusOut			: INTEGER = 	10
	 KeymapNotify		: INTEGER = 	11
--	 Expose				: INTEGER is 	12
	 GraphicsExpose		: INTEGER = 	13
	 NoExpose			: INTEGER = 	14
	 VisibilityNotify	: INTEGER = 	15
	 CreateNotify		: INTEGER = 	16
	 DestroyNotify		: INTEGER = 	17
	 UnmapNotify		: INTEGER = 	18
	 MapNotify			: INTEGER = 	19
	 MapRequest			: INTEGER = 	20
	 ReparentNotify		: INTEGER = 	21
	 ConfigureNotify	: INTEGER = 	22
	 ConfigureRequest	: INTEGER = 	23
	 GravityNotify		: INTEGER = 	24
	 ResizeRequest		: INTEGER = 	25
	 CirculateNotify	: INTEGER = 	26
	 CirculateRequest	: INTEGER = 	27
	 PropertyNotify		: INTEGER = 	28
	 SelectionClear		: INTEGER = 	29
	 SelectionRequest	: INTEGER = 	30
	 SelectionNotify	: INTEGER = 	31
	 ColormapNotify		: INTEGER = 	32
	 ClientMessage		: INTEGER = 	33
	 MappingNotify		: INTEGER = 	34
	 --LASTEvent		35 must be bigger than any event #


feature --	Key masks.

	-- Used as modifiers to GrabButton and GrabKey, results of QueryPointer,
	-- state in various key-, mouse-, and button-related events.

--	ShiftMask	: INTEGER is 0x00000001	--	(1<<0)
	LockMask	: INTEGER = 0x00000002	--	(1<<1)
--	ControlMask	: INTEGER is 0x00000004	--	(1<<2)
	Mod1Mask	: INTEGER = 0x00000008	--	(1<<3)
	Mod2Mask	: INTEGER = 0x00000010	--	(1<<4)
	Mod3Mask	: INTEGER = 0x00000020	--	(1<<5)
	Mod4Mask	: INTEGER = 0x00000040	--	(1<<6)
	Mod5Mask	: INTEGER = 0x00000080	--	(1<<7)

feature -- modifier names

	-- Used to build a SetModifierMapping request or
	-- to read a GetModifierMapping request.  These correspond to the
	-- masks defined above.
	 ShiftMapIndex			: INTEGER = 		0
	 LockMapIndex			: INTEGER = 		1
	 ControlMapIndex		: INTEGER = 		2
	 Mod1MapIndex			: INTEGER = 		3
	 Mod2MapIndex			: INTEGER = 		4
	 Mod3MapIndex			: INTEGER = 		5
	 Mod4MapIndex			: INTEGER = 		6
	 Mod5MapIndex			: INTEGER = 		7


feature -- button masks.

	-- Used in same manner as Key masks above. Not to be confused
	-- with button names below.

	 Button1Mask : INTEGER = 0x00000100	--	(1<<8)
	 Button2Mask : INTEGER = 0x00000200	--	(1<<9)
	 Button3Mask : INTEGER = 0x00000400	--	(1<<10)
	 Button4Mask : INTEGER = 0x00000800	--	(1<<11)
	 Button5Mask : INTEGER = 0x00001000	--	(1<<12)

	 AnyModifier : INTEGER = 0x00008000	--  (1<<15) used in GrabButton, GrabKey


feature -- button names.

	-- Used as arguments to GrabButton and as detail in ButtonPress
	--   and ButtonRelease events.  Not to be confused with button masks above.
	--   Note that 0 is already defined above as "AnyButton".

	 Button1			: INTEGER = 	1
	 Button2			: INTEGER = 	2
	 Button3			: INTEGER = 	3
	 Button4			: INTEGER = 	4
	 Button5			: INTEGER = 	5

-- Notify modes

	 NotifyNormal		: INTEGER = 	0
	 NotifyGrab			: INTEGER = 	1
	 NotifyUngrab		: INTEGER = 	2
	 NotifyWhileGrabbed	: INTEGER = 	3

	 NotifyHint			: INTEGER = 		1	-- for MotionNotify events
		       
feature -- Notify detail

	 NotifyAncestor			: INTEGER = 	0
	 NotifyVirtual			: INTEGER = 	1
	 NotifyInferior			: INTEGER = 	2
	 NotifyNonlinear		: INTEGER = 	3
	 NotifyNonlinearVirtual	: INTEGER = 	4
	 NotifyPointer			: INTEGER = 	5
	 NotifyPointerRoot		: INTEGER = 	6
	 NotifyDetailNone		: INTEGER = 	7

feature --  Visibility notify

	 VisibilityUnobscured			: INTEGER = 		0
	 VisibilityPartiallyObscured	: INTEGER = 		1
	 VisibilityFullyObscured		: INTEGER = 		2

feature -- Circulation request

	 PlaceOnTop			: INTEGER = 		0
	 PlaceOnBottom		: INTEGER = 		1

feature -- protocol families

	 FamilyInternet		: INTEGER = 		0
	 FamilyDECnet		: INTEGER = 		1
	 FamilyChaos		: INTEGER = 		2

feature -- Property notification

	 PropertyNewValue		: INTEGER = 	0
	 PropertyDelete			: INTEGER = 	1

feature -- Color Map notification

	 ColormapUninstalled	: INTEGER = 	0
	 ColormapInstalled		: INTEGER = 	1

feature -- GrabPointer, GrabButton, GrabKeyboard, GrabKey Modes

	 GrabModeSync			: INTEGER = 		0
	 GrabModeAsync			: INTEGER = 		1

feature -- GrabPointer, GrabKeyboard reply status

	 GrabSuccess	: INTEGER = 		0
	 AlreadyGrabbed	: INTEGER = 		1
	 GrabInvalidTime: INTEGER = 		2
	 GrabNotViewable: INTEGER = 		3
	 GrabFrozen		: INTEGER = 		4

feature -- AllowEvents modes

	 AsyncPointer		: INTEGER = 		0
	 SyncPointer		: INTEGER = 		1
	 ReplayPointer		: INTEGER = 		2
	 AsyncKeyboard		: INTEGER = 		3
	 SyncKeyboard		: INTEGER = 		4
	 ReplayKeyboard		: INTEGER = 		5
	 AsyncBoth			: INTEGER = 		6
	 SyncBoth			: INTEGER = 		7

feature -- Used in SetInputFocus, GetInputFocus */

	 RevertToNone			: INTEGER = 	0
	 RevertToPointerRoot	: INTEGER = 	1
	 RevertToParent			: INTEGER = 	2

--****************************************************************
feature -- ERROR CODES 
--****************************************************************

	 Success			: INTEGER = 0	-- everything's okay
	 BadRequest			: INTEGER = 1	-- bad request code
	 BadValue			: INTEGER = 2	-- int parameter out of range
	 BadWindow			: INTEGER = 3	-- parameter not a Window
	 BadPixmap			: INTEGER = 4	-- parameter not a Pixmap
	 BadAtom			: INTEGER = 5	-- parameter not an Atom
	 BadCursor			: INTEGER = 6	-- parameter not a Cursor
	 BadFont			: INTEGER = 7	-- parameter not a Font
	 BadMatch			: INTEGER = 8	-- parameter mismatch
	 BadDrawable		: INTEGER = 9	-- parameter not a Pixmap or Window
	 BadAccess			: INTEGER = 10	-- depending on context:
										-- key/button already grabbed
				 						-- attempt to free an illegal 
										--		cmap entry 
										-- attempt to store into a read-only 
										--		color map entry.
 										-- attempt to modify the access control
										--		list from other than the local host.
	 BadAlloc			: INTEGER = 11	-- insufficient resources
	 BadColor			: INTEGER = 12	-- no such colormap
	 BadGC				: INTEGER = 13	-- parameter not a GC
	 BadIDChoice		: INTEGER = 14	-- choice not in range or already used
	 BadName			: INTEGER = 15	-- font or color name doesn't exist
	 BadLength			: INTEGER = 16	-- Request length incorrect
	 BadImplementation	: INTEGER = 17	-- server is defective

	 FirstExtensionError: INTEGER = 	128
	 LastExtensionError	: INTEGER = 	255

-- *****************************************************************
feature --  * WINDOW DEFINITIONS 
-- *****************************************************************

	-- Window classes used by CreateWindow
	-- Note that CopyFromParent is already defined as 0 above

	 InputOutput: INTEGER =		1
	 InputOnly: INTEGER =			2

feature -- Window attributes for CreateWindow and ChangeWindowAttributes

	 Cw_back_pixmap			: INTEGER =	0x00000001	--	(1L<<0)
	 Cw_back_pixel			: INTEGER =	0x00000002	--	(1L<<1)
	 Cw_border_pixmap		: INTEGER =	0x00000004	--	(1L<<2)
	 Cw_border_pixel		: INTEGER =	0x00000008	--	(1L<<3)
	 Cw_bit_gravity			: INTEGER =	0x00000010	--	(1L<<4)
	 Cw_win_gravity			: INTEGER =	0x00000020	--	(1L<<5)
	 Cw_backing_store 		: INTEGER =	0x00000040	--	(1L<<6)
	 Cw_backing_planes		: INTEGER =	0x00000080	--	(1L<<7)
	 Cw_backing_pixel		: INTEGER =	0x00000100	--	(1L<<8)
	 Cw_override_redirect	: INTEGER =	0x00000200	--	(1L<<9)
	 Cw_save_under			: INTEGER =	0x00000400	--	(1L<<10)
	 Cw_event_mask			: INTEGER =	0x00000800	--	(1L<<11)
	 Cw_do_not_propagate	: INTEGER =	0x00001000	--	(1L<<12)
	 Cw_colormap			: INTEGER =	0x00002000	--	(1L<<13)
	 Cw_cursor				: INTEGER =	0x00004000	--	(1L<<14)

feature -- ConfigureWindow structure

	 Cw_x			: INTEGER =	0x00000001	--	(1<<0)
	 Cw_y			: INTEGER =	0x00000002	--	(1<<1)
	 Cw_width		: INTEGER =	0x00000004	--	(1<<2)
	 Cw_height		: INTEGER =	0x00000008	--	(1<<3)
	 Cw_border_width: INTEGER =	0x00000010	--	(1<<4)
	 Cw_sibling		: INTEGER =	0x00000020	--	(1<<5)
	 Cw_stack_mode	: INTEGER =	0x00000040	--	(1<<6)


feature -- Bit Gravity

	 ForgetGravity			: INTEGER = 	0
	 NorthWestGravity		: INTEGER = 	1
	 NorthGravity			: INTEGER = 	2
	 NorthEastGravity		: INTEGER = 	3
	 WestGravity			: INTEGER = 	4
	 CenterGravity			: INTEGER = 	5
	 EastGravity			: INTEGER = 	6
	 SouthWestGravity		: INTEGER = 	7
	 SouthGravity			: INTEGER = 	8
	 SouthEastGravity		: INTEGER = 	9
	 StaticGravity			: INTEGER = 	10

feature -- Window gravity + bit gravity above

	 UnmapGravity			: INTEGER = 		0

feature -- Used in CreateWindow for backing-store hint

--	 NotUseful		: INTEGER is		0
--	 WhenMapped		: INTEGER is		1
--	 Always			: INTEGER is		2

feature -- Used in GetWindowAttributes reply

	 IsUnmapped			: INTEGER = 		0
	 IsUnviewable		: INTEGER = 		1
	 IsViewable			: INTEGER = 		2

feature -- Used in ChangeSaveSet

	 SetModeInsert			: INTEGER =            0
	 SetModeDelete			: INTEGER =            1

feature --  Used in ChangeCloseDownMode

	 DestroyAll			: INTEGER =               0
	 RetainPermanent	: INTEGER =          1
	 RetainTemporary	: INTEGER =          2

feature -- Window stacking method (in configureWindow)

	 Above			: INTEGER =	0
	 Below			: INTEGER =	1
	 TopIf			: INTEGER =	2
	 BottomIf		: INTEGER =	3
	 Opposite		: INTEGER =	4

feature -- Circulation direction

	 RaiseLowest			: INTEGER =	0
	 LowerHighest			: INTEGER =	 1

feature -- Property modes

	 PropModeReplace		: INTEGER =	 0
	 PropModePrepend		: INTEGER =	1
	 PropModeAppend			: INTEGER =	2

-- *****************************************************************
feature --  * GRAPHICS DEFINITIONS
-- *****************************************************************

-- graphics functions, as in GC.alu

	GXclear			: INTEGER = 0		-- 0
	GXand			: INTEGER = 1		-- src AND dst
	GXandReverse	: INTEGER = 2		-- src AND NOT dst
	GXcopy			: INTEGER = 3		-- src
	GXandInverted	: INTEGER = 4		-- NOT src AND dst
	GXnoop			: INTEGER = 5		-- dst
	GXxor			: INTEGER = 6		-- src XOR dst
	GXor			: INTEGER = 7		-- src OR dst
	GXnor			: INTEGER = 8		-- NOT src AND NOT dst
	GXequiv			: INTEGER = 9		-- NOT src XOR dst
	GXinvert		: INTEGER = 10		-- NOT dst
	GXorReverse		: INTEGER = 11		-- src OR NOT dst
	GXcopyInverted	: INTEGER = 12		-- NOT src
	GXorInverted	: INTEGER = 13		-- NOT src OR dst
	GXnand			: INTEGER = 14		-- NOT src OR NOT dst
	GXset			: INTEGER = 15		-- 1

feature -- SetClipRectangles ordering

	-- Moved to X_GC_CONSTANTS

--	 Unsorted			: INTEGER is 	0
--	 YSorted			: INTEGER is 	1
--	 YXSorted			: INTEGER is 	2
--	 YXBanded			: INTEGER is 	3

feature -- CoordinateMode for drawing routines

	 CoordModeOrigin	: INTEGER = 	0	-- relative to the origin
	 CoordModePrevious	: INTEGER =    1	-- relative to previous point

feature -- Polygon shapes

	 Complex		: INTEGER = 		0	-- paths may intersect
	 Nonconvex		: INTEGER = 		1	-- no paths intersect, but not convex
	 Convex			: INTEGER = 		2	-- wholly convex

feature -- Arc modes for PolyFillArc

	 ArcChord		: INTEGER = 		0	-- join endpoints of arc
	 ArcPieSlice	: INTEGER = 		1	-- join endpoints to center of arc

feature -- GC Masks
	-- GC components: masks used in CreateGC, CopyGC, ChangeGC, OR'ed into
   	-- GC.stateChanges


-- *****************************************************************
feature --  * FONTS 
-- *****************************************************************

-- used in QueryFont -- draw direction

	 FontLeftToRight	: INTEGER = 		0
	 FontRightToLeft	: INTEGER = 		1

	 FontChange			: INTEGER = 		255

-- *****************************************************************
feature --  *  IMAGING 
-- *****************************************************************

-- ImageFormat -- PutImage, GetImage

	 XYBitmap	: INTEGER = 		0	-- depth 1, XYFormat
	 XYPixmap	: INTEGER = 		1	-- depth == drawable depth
	 ZPixmap	: INTEGER = 		2	-- depth == drawable depth

-- *****************************************************************
feature --  *  COLOR MAP STUFF 
-- *****************************************************************

-- For CreateColormap

	 AllocNone	: INTEGER = 		0	-- create map with no entries
	 AllocAll	: INTEGER = 		1	-- allocate entire map writeable


-- Flags used in StoreNamedColor, StoreColors

	DoRed		: INTEGER =	1	--	(1<<0)
	DoGreen		: INTEGER =	2	--	(1<<1)
	DoBlue		: INTEGER =	4	--	(1<<2)

-- *****************************************************************
feature --  * CURSOR STUFF
-- *****************************************************************

-- QueryBestSize Class 

	 CursorShape		: INTEGER = 		0	-- largest size that can be displayed
	 TileShape			: INTEGER = 		1	-- size tiled fastest
	 StippleShape		: INTEGER = 		2	-- size stippled fastest

-- ***************************************************************** 
feature --  * KEYBOARD/POINTER STUFF
-- *****************************************************************

	 AutoRepeatModeOff		: INTEGER = 	0
	 AutoRepeatModeOn		: INTEGER = 	1
	 AutoRepeatModeDefault	: INTEGER = 	2

	 LedModeOff	: INTEGER = 		0
	 LedModeOn	: INTEGER = 		1

-- masks for ChangeKeyboardControl

	 KBKeyClickPercent	: INTEGER = 0x00000001	-- (1L<<0)
	 KBBellPercent		: INTEGER = 0x00000002	-- (1L<<1)
	 KBBellPitch		: INTEGER = 0x00000004	-- (1L<<2)
	 KBBellDuration		: INTEGER = 0x00000008	-- (1L<<3)
	 KBLed				: INTEGER = 0x00000010	-- (1L<<4)
	 KBLedMode			: INTEGER = 0x00000020	-- (1L<<5)
	 KBKey				: INTEGER = 0x00000040	-- (1L<<6)
	 KBAutoRepeatMode	: INTEGER = 0x00000080	-- (1L<<7)

	 MappingSuccess			: INTEGER =	0
	 MappingBusy			: INTEGER =	1
	 MappingFailed			: INTEGER =	2

	 MappingModifier		: INTEGER =	0
	 MappingKeyboard		: INTEGER = 	1
	 MappingPointer			: INTEGER = 	2

-- *****************************************************************
feature --  * SCREEN SAVER STUFF 
-- *****************************************************************

	 DontPreferBlanking		: INTEGER =	0
	 PreferBlanking			: INTEGER =	1
	 DefaultBlanking		: INTEGER =	2

	 DisableScreenSaver		: INTEGER = 	0
	 DisableScreenInterval	: INTEGER = 	0

	 DontAllowExposures		: INTEGER = 	0
	 AllowExposures			: INTEGER = 	1
	 DefaultExposures		: INTEGER = 	2

-- ForceScreenSaver

	 ScreenSaverReset		: INTEGER =  0
	 ScreenSaverActive		: INTEGER =  1

-- *****************************************************************
feature --  * HOSTS AND CONNECTIONS
-- *****************************************************************

-- for ChangeHosts

	 HostInsert		: INTEGER = 		0
	 HostDelete		: INTEGER = 		1

-- for ChangeAccessControl

	EnableAccess	: INTEGER = 		1      
	DisableAccess	: INTEGER = 		0

-- Display classes  used in opening the connection
-- Note that the statically allocated ones are even numbered and the
-- dynamically changeable ones are odd numbered

	 StaticGray		: INTEGER = 		0
	 GrayScale		: INTEGER = 		1
	 StaticColor	: INTEGER = 		2
	 PseudoColor	: INTEGER = 		3
	 TrueColor		: INTEGER = 		4
	 DirectColor	: INTEGER = 		5


-- Byte order  used in imageByteOrder and bitmapBitOrder

	 LSBFirst		: INTEGER = 		0
	 MSBFirst		: INTEGER = 		1

end
