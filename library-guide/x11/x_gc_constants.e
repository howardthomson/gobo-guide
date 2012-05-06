note

	description: "X11 Graphics Context constants"

	author: "Howard Thomson"
	copyright: "Copyright (c) 2006, Howard Thomson"
	license: "Eiffel Forum License v2 (see forum.txt)"

class X_GC_CONSTANTS

feature -- GC's function values

	Gx_clear : 			INTEGER =  0
	Gx_and : 			INTEGER =  1
	Gx_and_reverse: 	INTEGER =  2
	Gx_copy : 			INTEGER =	3
	Gx_and_inverted : 	INTEGER =	4
	Gx_noop : 			INTEGER =	5
	Gx_xor : 			INTEGER =	6
	Gx_or : 			INTEGER =	7
	Gx_nor : 			INTEGER =	8
	Gx_equiv : 			INTEGER =	9
	Gx_invert : 		INTEGER =	10
	Gx_or_reverse : 	INTEGER =	11
	Gx_copy_inverted :	INTEGER =	12
	Gx_or_inverted : 	INTEGER =	13
	Gx_nand : 			INTEGER =	14
	Gx_set : 			INTEGER =	15

feature	-- GC Flags
	
	Gc_function				: INTEGER = 0x00000001	-- 0	 GCFunction         (1L<<0)
	Gc_plane_mask			: INTEGER = 0x00000002	-- 1	 GCPlaneMask        (1L<<1)
	Gc_foreground			: INTEGER = 0x00000004	-- 2	 GCForeground       (1L<<2)
	Gc_background			: INTEGER = 0x00000008	-- 3	 GCBackground       (1L<<3)
	Gc_line_width			: INTEGER = 0x00000010	-- 4	 GCLineWidth        (1L<<4)
	Gc_line_style			: INTEGER = 0x00000020	-- 5	 GCLineStyle        (1L<<5)
	Gc_cap_style			: INTEGER = 0x00000040	-- 6	 GCCapStyle         (1L<<6)
	Gc_join_style			: INTEGER = 0x00000080	-- 7	 GCJoinStyle		(1L<<7)
	Gc_fill_style			: INTEGER = 0x00000100	-- 8	 GCFillStyle		(1L<<8)
	Gc_fill_rule			: INTEGER = 0x00000200	-- 9	 GCFillRule			(1L<<9) 
	Gc_tile					: INTEGER = 0x00000400	-- 10	 GCTile				(1L<<10)
	Gc_stipple				: INTEGER = 0x00000800	-- 11	 GCStipple			(1L<<11)
	Gc_tile_stip_x_origin	: INTEGER = 0x00001000	-- 12	 GCTileStipXOrigin	(1L<<12)
	Gc_tile_stip_y_origin	: INTEGER = 0x00002000	-- 13	 GCTileStipYOrigin	(1L<<13)
	Gc_font					: INTEGER = 0x00004000	-- 14	 GCFont 			(1L<<14)
	Gc_subwindow_mode		: INTEGER = 0x00008000	-- 15	 GCSubwindowMode	(1L<<15)
	Gc_graphics_exposures	: INTEGER = 0x00010000	-- 16	 GCGraphicsExposures(1L<<16)
	Gc_clip_x_origin		: INTEGER = 0x00020000	-- 17	 GCClipXOrigin		(1L<<17)
	Gc_clip_y_origin		: INTEGER = 0x00040000	-- 18	 GCClipYOrigin		(1L<<18)
	Gc_clip_mask			: INTEGER = 0x00080000	-- 19	 GCClipMask			(1L<<19)
	Gc_dash_offset			: INTEGER = 0x00100000	-- 20	 GCDashOffset		(1L<<20)
	Gc_dash_list			: INTEGER = 0x00200000	-- 21	 GCDashList			(1L<<21)
	Gc_arc_mode				: INTEGER = 0x00400000	-- 22	 GCArcMode			(1L<<22)
	
feature -- line values

	Line_solid		:	INTEGER = 0
	Line_on_off_dash:	INTEGER = 1
	Line_double_dash:	INTEGER = 2

feature -- cap values

	Cap_not_last	:	INTEGER =	0
	Cap_butt		:	INTEGER =	1
	Cap_round		:	INTEGER =	2
	Cap_projecting	:	INTEGER =	3

feature -- join values

	Join_miter : 		INTEGER =	0
	Join_round : 		INTEGER =	1
	Join_bevel : 		INTEGER =	2

feature -- arc mode values

	Arc_chord:			INTEGER =	0
	Arc_pie_slice:		INTEGER =	1

feature -- fill rule values

	Even_odd_rule:		INTEGER =	0
	Winding_rule:		INTEGER =	1

feature -- fill style values

	Fill_solid:			INTEGER =	0
	Fill_tiled:			INTEGER =	1
	Fill_stippled:		INTEGER =	2
	Fill_opaque_stippled:INTEGER =	3

feature -- subwindow mode values

	Clip_by_children:	INTEGER =	0
	Include_inferiors:	INTEGER =	1

feature -- clip rectangles ordering

	Unsorted		: INTEGER =	0
	YSorted			: INTEGER =	1
	YXSorted		: INTEGER =	2
	YXBanded		: INTEGER =	3

end 
