note

		description: "Default stock cursor constants"

	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"mostly complete"

class SB_DEFAULT_CURSORS

feature

   Def_arrow_cursor		: INTEGER = 1	-- Arrow cursor
   Def_rarrow_cursor	: INTEGER = 2  -- Reverse arrow cursor
   Def_text_cursor		: INTEGER = 3  -- Text cursor
   Def_hsplit_cursor	: INTEGER = 4  -- Horizontal split cursor
   Def_vsplit_cursor	: INTEGER = 5  --Vertical split cursor
   Def_xsplit_cursor	: INTEGER = 6  -- Cross split cursor
   Def_swatch_cursor	: INTEGER = 7  -- Color swatch drag cursor
   Def_move_cursor		: INTEGER = 8  -- Move cursor
   Def_dragh_cursor		: INTEGER = 9  -- Resize horizontal edge
   Def_dragv_cursor		: INTEGER = 10 -- Resize vertical edge
   Def_dragtl_cursor	: INTEGER = 11 -- Resize upper-leftcorner
   Def_dragbr_cursor	: INTEGER = 11 -- Resize bottom-right corner
   Def_dragtr_cursor	: INTEGER = 12 -- Resize upper-right corner
   Def_dragbl_cursor	: INTEGER = 12 -- Resize bottom-left corner
   Def_dndstop_cursor	: INTEGER = 13 -- Drag and drop stop
   Def_dndcopy_cursor	: INTEGER = 14 -- Drag and drop copy
   Def_dndmove_cursor	: INTEGER = 15 -- Drag and drop move
   Def_dndlink_cursor	: INTEGER = 16 -- Drag and drop link
   Def_crosshair_cursor	: INTEGER = 17 -- Cross hair cursor
   Def_cornerne_cursor	: INTEGER = 18 -- North-east cursor
   Def_cornernw_cursor	: INTEGER = 19 -- North-west cursor
   Def_cornerse_cursor	: INTEGER = 20 -- South-east cursor
   Def_cornersw_cursor	: INTEGER = 21 -- South-west cursor
   Def_rotate_cursor	: INTEGER = 22 -- Rotate cursor
end
