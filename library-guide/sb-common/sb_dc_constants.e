indexing
	description:"SB_DC constants"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"mostly complete"

class SB_DC_CONSTANTS

feature -- Drawing (BITBLT) functions

   Blt_clr					: INTEGER is 0		-- D := 0
   Blt_src_and_dst			: INTEGER is 1		-- D := S & D
   Blt_src_and_not_dst		: INTEGER is 2		-- D := S & ~D
   Blt_src					: INTEGER is 3		-- D := S
   Blt_not_src_and_dst		: INTEGER is 4		-- D := ~S & D
   Blt_dst					: INTEGER is 5		-- D := D
   Blt_src_xor_dst			: INTEGER is 6		-- D := S ^ D
   Blt_src_or_dst			: INTEGER is 8		-- D := S | D
   Blt_not_src_and_not_dst	: INTEGER is 9 		-- D := ~S & ~D  ==  D := ~(S | D)
   Blt_not_src_xor_dst		: INTEGER is 10		-- D := ~S ^ D
   Blt_not_dst				: INTEGER is 11		-- D := ~D
   Blt_src_or_not_dst		: INTEGER is 12		-- D := S | ~D
   Blt_not_src				: INTEGER is 13		-- D := ~S
   Blt_not_src_or_dst		: INTEGER is 14		-- D := ~S | D
   Blt_not_src_or_not_dst	: INTEGER is 15		-- D := ~S | ~D  ==  ~(S & D)
   Blt_set					: INTEGER is 16		-- D := 1


feature -- Line Styles

	Line_solid		: INTEGER is 0			-- Solid lines
	Line_onoff_dash	: INTEGER is 1			-- On-off dashed lines
	Line_double_dash: INTEGER is 2			-- Double dashed lines


feature -- Line Cap Styles

   Cap_not_last		: INTEGER is 0			-- Don't include last end cap
   Cap_butt			: INTEGER is 1			-- Butting line end caps
   Cap_round		: INTEGER is 2			-- Round line end caps
   Cap_projecting	: INTEGER is 3			-- Projecting line end caps

feature -- Line Join Styles

   Join_miter		: INTEGER is 0			-- Mitered or pointy joints
   Join_round		: INTEGER is 1			-- Round line joints
   Join_bevel		: INTEGER is 2			-- Beveled or flat joints

feature -- Fill Styles

   Fill_solid			: INTEGER is 1      -- Fill with solid color
   Fill_tiled			: INTEGER is 2      -- Fill with tiled bitmap
   Fill_stippled		: INTEGER is 3		-- Fill where stipple mask is 1
   Fill_opaque_stippled	: INTEGER is 4		-- Fill with foreground where mask is 1, background otherwise

feature -- Fill Rules

   Rule_even_odd: INTEGER is 0                 -- Even odd polygon filling
   Rule_winding: INTEGER is 1                  -- Winding rule polygon filling

feature -- Stipple/dither patterns

   Stipple_0         : INTEGER is 0;
   Stipple_none      : INTEGER is 0;
   Stipple_black     : INTEGER is 0;            -- All ones
   Stipple_1         : INTEGER is 1;
   Stipple_2         : INTEGER is 2;
   Stipple_3         : INTEGER is 3;
   Stipple_4         : INTEGER is 4;
   Stipple_5         : INTEGER is 5;
   Stipple_6         : INTEGER is 6;
   Stipple_7         : INTEGER is 7;
   Stipple_8         : INTEGER is 8;
   Stipple_gray      : INTEGER is 8;            -- 50% gray
   Stipple_9         : INTEGER is 9;
   Stipple_10        : INTEGER is 10;
   Stipple_11        : INTEGER is 11;
   Stipple_12        : INTEGER is 12;
   Stipple_13        : INTEGER is 13;
   Stipple_14        : INTEGER is 14;
   Stipple_15        : INTEGER is 15;
   Stipple_16        : INTEGER is 16;
   Stipple_white     : INTEGER is 16;           -- All zeroes
   
   Stipple_horz      : INTEGER is 17;           -- Horizontal hatch pattern
   Stipple_vert      : INTEGER is 18;           -- Vertical hatch pattern
   Stipple_cross     : INTEGER is 19;           -- Cross-hatch pattern
   
   Stipple_diag      : INTEGER is 20;           -- Diagonal // hatch pattern
   Stipple_revdiag   : INTEGER is 21;           -- Reverse diagonal \\ hatch pattern
   Stipple_crossdiag : INTEGER is 22;           -- Cross-diagonal hatch pattern

end