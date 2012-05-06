note
	description:"SB_DC constants"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"mostly complete"

class SB_DC_CONSTANTS

feature -- Drawing (BITBLT) functions

   Blt_clr					: INTEGER = 0		-- D := 0
   Blt_src_and_dst			: INTEGER = 1		-- D := S & D
   Blt_src_and_not_dst		: INTEGER = 2		-- D := S & ~D
   Blt_src					: INTEGER = 3		-- D := S
   Blt_not_src_and_dst		: INTEGER = 4		-- D := ~S & D
   Blt_dst					: INTEGER = 5		-- D := D
   Blt_src_xor_dst			: INTEGER = 6		-- D := S ^ D
   Blt_src_or_dst			: INTEGER = 8		-- D := S | D
   Blt_not_src_and_not_dst	: INTEGER = 9 		-- D := ~S & ~D  ==  D := ~(S | D)
   Blt_not_src_xor_dst		: INTEGER = 10		-- D := ~S ^ D
   Blt_not_dst				: INTEGER = 11		-- D := ~D
   Blt_src_or_not_dst		: INTEGER = 12		-- D := S | ~D
   Blt_not_src				: INTEGER = 13		-- D := ~S
   Blt_not_src_or_dst		: INTEGER = 14		-- D := ~S | D
   Blt_not_src_or_not_dst	: INTEGER = 15		-- D := ~S | ~D  ==  ~(S & D)
   Blt_set					: INTEGER = 16		-- D := 1


feature -- Line Styles

	Line_solid		: INTEGER = 0			-- Solid lines
	Line_onoff_dash	: INTEGER = 1			-- On-off dashed lines
	Line_double_dash: INTEGER = 2			-- Double dashed lines


feature -- Line Cap Styles

   Cap_not_last		: INTEGER = 0			-- Don't include last end cap
   Cap_butt			: INTEGER = 1			-- Butting line end caps
   Cap_round		: INTEGER = 2			-- Round line end caps
   Cap_projecting	: INTEGER = 3			-- Projecting line end caps

feature -- Line Join Styles

   Join_miter		: INTEGER = 0			-- Mitered or pointy joints
   Join_round		: INTEGER = 1			-- Round line joints
   Join_bevel		: INTEGER = 2			-- Beveled or flat joints

feature -- Fill Styles

   Fill_solid			: INTEGER = 1      -- Fill with solid color
   Fill_tiled			: INTEGER = 2      -- Fill with tiled bitmap
   Fill_stippled		: INTEGER = 3		-- Fill where stipple mask is 1
   Fill_opaque_stippled	: INTEGER = 4		-- Fill with foreground where mask is 1, background otherwise

feature -- Fill Rules

   Rule_even_odd: INTEGER = 0                 -- Even odd polygon filling
   Rule_winding: INTEGER = 1                  -- Winding rule polygon filling

feature -- Stipple/dither patterns

   Stipple_0         : INTEGER = 0;
   Stipple_none      : INTEGER = 0;
   Stipple_black     : INTEGER = 0;            -- All ones
   Stipple_1         : INTEGER = 1;
   Stipple_2         : INTEGER = 2;
   Stipple_3         : INTEGER = 3;
   Stipple_4         : INTEGER = 4;
   Stipple_5         : INTEGER = 5;
   Stipple_6         : INTEGER = 6;
   Stipple_7         : INTEGER = 7;
   Stipple_8         : INTEGER = 8;
   Stipple_gray      : INTEGER = 8;            -- 50% gray
   Stipple_9         : INTEGER = 9;
   Stipple_10        : INTEGER = 10;
   Stipple_11        : INTEGER = 11;
   Stipple_12        : INTEGER = 12;
   Stipple_13        : INTEGER = 13;
   Stipple_14        : INTEGER = 14;
   Stipple_15        : INTEGER = 15;
   Stipple_16        : INTEGER = 16;
   Stipple_white     : INTEGER = 16;           -- All zeroes
   
   Stipple_horz      : INTEGER = 17;           -- Horizontal hatch pattern
   Stipple_vert      : INTEGER = 18;           -- Vertical hatch pattern
   Stipple_cross     : INTEGER = 19;           -- Cross-hatch pattern
   
   Stipple_diag      : INTEGER = 20;           -- Diagonal // hatch pattern
   Stipple_revdiag   : INTEGER = 21;           -- Reverse diagonal \\ hatch pattern
   Stipple_crossdiag : INTEGER = 22;           -- Cross-diagonal hatch pattern

end