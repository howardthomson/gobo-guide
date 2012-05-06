note
	description:"SB_WINDOW constants"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"mostly complete"

class SB_WINDOW_CONSTANTS

inherit
	SB_PV_LAYOUT_SIDE_VALUES
		rename
			Side_normal as Layout_normal,
			Side_top	as Layout_side_top,
			Side_bottom as Layout_side_bottom,
			Side_left	as Layout_side_left,
			Side_right	as Layout_side_right
		end

feature

	-- Window state flags

	Flag_shown        : INTEGER = 0x00000001	-- Window is shown
	Flag_enabled      : INTEGER = 0x00000002	-- Window has focus
	Flag_update       : INTEGER = 0x00000004	-- Window is subject to GUI update
	Flag_droptarget   : INTEGER = 0x00000008	-- Button has been pressed
	Flag_focused      : INTEGER = 0x00000010	-- Keyboard key pressed
	Flag_dirty        : INTEGER = 0x00000020	-- Window is dirty, needs redraw
	Flag_recalc       : INTEGER = 0x00000040	-- Window able to receive input
	Flag_tip          : INTEGER = 0x00000080	-- Window needs layout
	Flag_help         : INTEGER = 0x00000100	-- Window needs recalculation
	Flag_default      : INTEGER = 0x00000200	-- Window is drop target
	Flag_initial      : INTEGER = 0x00000400	-- Caret is on
	Flag_shell        : INTEGER = 0x00000800	-- Window data changed
	Flag_active       : INTEGER = 0x00001000	-- Show tip
	Flag_pressed      : INTEGER = 0x00002000	-- Show help
	Flag_key          : INTEGER = 0x00004000	-- Lasso mode
	Flag_caret        : INTEGER = 0x00008000	-- Tentative drag mode
	Flag_changed      : INTEGER = 0x00010000	-- Doing drag mode
	Flag_lasso        : INTEGER = 0x00020000	-- Scroll only when inside
	Flag_trydrag      : INTEGER = 0x00040000	-- Right mouse scrolling
	Flag_dodrag       : INTEGER = 0x00080000	-- Right mouse scrolling
	Flag_scrollinside : INTEGER = 0x00100000	-- Right mouse scrolling
	Flag_scrolling    : INTEGER = 0x00200000	-- Right mouse scrolling
	Flag_owned		  : INTEGER = 0x00400000	-- Resource is owned by window

	-- Option fields and values

	Layout_fill_column : INTEGER =  0x00000001	-- Matrix column is stretchable
	Layout_fill_row    : INTEGER =  0x00000002  -- Matrix row is stretchable

	Layout_left        : INTEGER =  0x00000000	-- Stick on left (default)
	Layout_right       : INTEGER =  0x00000004	-- Stick on right
	Layout_center_x    : INTEGER =  0x00000008	-- Center horizontally
	Layout_fix_x       : INTEGER =	0x0000000C	-- X fixed

   	Layout_top         : INTEGER =  0x00000000	-- Stick on top (default)
   	Layout_bottom      : INTEGER =  0x00000010	-- Stick on bottom
   	Layout_center_y    : INTEGER =  0x00000020	-- Center vertically
   	Layout_fix_y       : INTEGER =  0x00000030	-- Y fixed

   	Layout_reserved_1  : INTEGER =  0x00000040
   	Layout_reserved_2  : INTEGER =  0x00000080	
   	Layout_min_width   : INTEGER =  0x00000000	-- Minimum width is the default
   	Layout_fix_width   : INTEGER =  0x00000100	-- Width fixed
   	Layout_min_height  : INTEGER =  0x00000000	-- Minimum height is the default
   	Layout_fix_height  : INTEGER =  0x00000200	-- Height fixed
	Layout_fill_x      : INTEGER =  0x00000400	-- Stretch or shrink horizontally
	Layout_fill_y      : INTEGER =  0x00000800	-- Stretch or shrink vertically

	Layout_explicit    : INTEGER =  0x0000033C	-- Explicit placement
												--	=  Layout_fix_x or Layout_fix_y
												--	or Layout_fix_width or Layout_fix_height

   	Frame_none   : INTEGER = 0 				-- Default is no frame
   	Frame_sunken : INTEGER = 0x00001000 	-- Sunken border
   	Frame_raised : INTEGER = 0x00002000 	-- Raised border
   	Frame_line   : INTEGER = 0x00003000 	-- Simple line border
											--		= Frame_raised or Frame_sunken
   	Frame_thick  : INTEGER = 0x00004000 	-- Thick border
   	Frame_groove : INTEGER = 0x00004000 	-- A groove or etched-in border
     										--		= Frame_thick
   	Frame_normal : INTEGER = 0x00005000	-- Regular raised/thick border 
 											--		= Frame_sunken or Frame_thick               
	Frame_xxx	 : INTEGER = 0x00006000	-- Unused combination
   	Frame_ridge  : INTEGER = 0x00007000	-- A ridge or embossed border
											--		= Frame_thick or Frame_raised or Frame_sunken
	Frame_mask	 : INTEGER = 0x00007000	-- Mask for bit field

	--  Packing style (for packers)
	Pack_normal         : INTEGER =  0				-- Default is each its own size
	Pack_uniform_height : INTEGER =  0x00008000	-- Uniform height
	Pack_uniform_width  : INTEGER =  0x00010000	-- Uniform width

end -- class SB_WINDOW_CONSTANTS
