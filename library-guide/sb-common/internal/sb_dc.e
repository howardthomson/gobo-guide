note
	description: "[
		Abstract Device Context A Device Context is used to maintain
		the state of the graphics drawing system. Defining your drawing code in terms
		of the Abstract Device Context allows the drawing commands to be rendered
		on different types of surfaces, such as windows and images (SB_DC_WINDOW),
		or on paper (SB_DC_PRINT).
	]"

	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

deferred class SB_DC

inherit

	SB_DC_CONSTANTS
		rename
			Fill_tiled			as SB_fill_tiled,
			Fill_solid			as SB_fill_solid,
			Fill_stippled		as SB_fill_stippled,
			Fill_opaque_stippled as SB_fill_opaquestippled,
			Line_solid			as SB_line_solid,
			Line_double_dash 	as SB_line_double_dash,
			Join_miter			as SB_join_miter,
			Cap_butt			as SB_cap_butt,
			Cap_not_last		as SB_cap_not_last,
			Cap_round			as SB_cap_round,
			Cap_projecting		as SB_cap_projecting,
			Join_round			as SB_join_round,
			Join_bevel			as SB_join_bevel
		end

-- This is X specific !!
--	X_GC_CONSTANTS

feature -- deferred

	Fill_solid	: INTEGER deferred end
	Line_solid	: INTEGER deferred end
	Join_miter	: INTEGER deferred end
	Cap_butt	: INTEGER deferred end
	Fill_opaque_stippled	: INTEGER deferred end

feature -- Data

	app		: EV_APPLICATION_IMP	-- Application
	font	: SB_FONT			-- Drawing font
	pattern	: INTEGER			-- Stipple pattern
	stipple	: SB_BITMAP			-- Stipple bitmap
	tile	: SB_IMAGE			-- Tile image
	mask	: SB_BITMAP			-- Mask bitmap

--	clip	: SB_RECTANGLE		-- Clip rectangle
	clip_x,
	clip_y,
	clip_w,
	clip_h	: INTEGER

	fg		: INTEGER			-- Foreground color
	bg		: INTEGER			-- Background color
	width	: INTEGER	      	-- Line width
	cap		: INTEGER			-- Line cap style
	join	: INTEGER			-- Line join style
	style	: INTEGER			-- Line style
	fill	: INTEGER			-- Fill style
	rule	: INTEGER			-- Fill rule
	rop		: INTEGER			-- RasterOp
	dashpat	: ARRAY [ INTEGER ]	-- Line dash pattern data
	dashlen	: INTEGER			-- Line dash pattern length
	dashoff	: INTEGER			-- Line dash pattern offset
	tx		: INTEGER			-- Tile dx
	ty		: INTEGER			-- Tile dy
	cx		: INTEGER			-- Clip x
	cy		: INTEGER			-- Clip y

feature -- Creation

	make (an_app: EV_APPLICATION_IMP)
			-- Construct dummy DC
		do
			app := an_app
         	create dashpat.make (0, 31)
         	reset
      	end

	reset
		do
			pattern := Stipple_none
         	clip_x := 0
         	clip_y := 0
         	clip_w := 32767
         	clip_h := 32767
         	fg := 0
         	bg := 1
         	width := 0
         	cap := Cap_butt
         	join := Join_miter
         	style := Line_solid
         	fill := Fill_solid
         	rule := Rule_even_odd
         	rop := Blt_src
         	dashpat.put (4, 0)
         	dashpat.put (4, 1)
         	dashlen := 2
		end

feature

	read_pixel (x, y: INTEGER): INTEGER
    		-- Read back pixel
      	do
      	end

	trace_dc_calls: BOOLEAN = False


feature -- Validity for drawing

	ok_to_draw: BOOLEAN
		do
			Result := True
		end

feature -- Draw points

	draw_point (x, y : INTEGER)
		require
		--	trace_dc_calls implies rq_trace(<<"SB_DC::draw_point: ", Current.out>>)
			valid_to_draw: ok_to_draw
		do
		end

	draw_points (points: ARRAY [ SB_POINT ])
		require
		--	trace_dc_calls implies rq_trace(<<"SB_DC::draw_points: ", Current.out>>)
			valid_to_draw: ok_to_draw
		do
		end

	draw_points_rel (points: ARRAY [ SB_POINT ])
		require
		--	trace_dc_calls implies rq_trace(<<"SB_DC::draw_points_rel: ", Current.out>>)
			valid_to_draw: ok_to_draw
		do
		end

feature -- Draw lines

	draw_line (x1, y1, x2, y2: INTEGER)
		require
		--	trace_dc_calls implies rq_trace(<<"SB_DC::draw_line: ", Current.out>>)
			valid_to_draw: ok_to_draw
		do
		end

	draw_lines (points: ARRAY [ SB_POINT ])
		require
		--	trace_dc_calls implies rq_trace(<<"SB_DC::draw_lines: ", Current.out>>)
			valid_to_draw: ok_to_draw
		do
		end

	draw_lines_rel (points: ARRAY [ SB_POINT ])
		require
		--	trace_dc_calls implies rq_trace(<<"SB_DC::draw_lines_rel: ", Current.out>>)
			valid_to_draw: ok_to_draw
		do
		end

	draw_line_segments (segments: ARRAY [ SB_SEGMENT ])
		require
		--	trace_dc_calls implies rq_trace(<<"SB_DC::draw_line_segments: ", Current.out>>)
			valid_to_draw: ok_to_draw
		do
		end

feature -- Draw rectangles

	draw_rectangle (x, y, w, h: INTEGER)
		require
		--	trace_dc_calls implies rq_trace(<<"SB_DC::draw_line_segments: ", Current.out>>)
			valid_to_draw: ok_to_draw
		do
		end

	draw_rectangles (rectangles: ARRAY [ SB_RECTANGLE ])
		require
		--	trace_dc_calls implies rq_trace(<<"SB_DC::draw_line_segments: ", Current.out>>)
			valid_to_draw: ok_to_draw
		do
		end

feature -- Draw arcs.

   -- The argument ang1 specifies the start of the arc relative to the
   -- three-o'clock position from the center, in units of degrees*64.
   -- The argument ang2 specifies the path and extent of the arc relative
   -- to the start of the arc, in units of degrees*64.
   -- The arguments x,y,w,h specify the bounding rectangle.

   draw_arc (x, y, w, h, ang1, ang2: INTEGER)
		require
		--	trace_dc_calls implies rq_trace(<<"SB_DC::draw_arc: ", Current.out>>)
			valid_to_draw: ok_to_draw
		do
		end

   draw_arcs (arcs: ARRAY [ SB_ARC ])
		require
		--	trace_dc_calls implies rq_trace(<<"SB_DC::draw_arcs: ", Current.out>>)
			valid_to_draw: ok_to_draw
		do
		end


feature -- Filled rectangles

   fill_rectangle (x, y, w, h: INTEGER)
		require
		--	trace_dc_calls implies rq_trace(<<"SB_DC::fill_rectangle: ", Current.out, " x/y/w/h: ",
		--		x.out,"/",y.out,"/",w.out,"/",h.out>>)
--			good_width: w >= 0
--			good_height: h >= 0
			valid_to_draw: ok_to_draw
		do
		end

   fill_rectangles (rectangles: ARRAY [ SB_RECTANGLE ])
		require
		--	trace_dc_calls implies rq_trace(<<"SB_DC::fill_rectangles: ", Current.out>>)
			valid_to_draw: ok_to_draw
		do
		end

feature -- Filled arcs

   fill_arc (x, y, w, h, ang1, ang2: INTEGER)
		require
		--	trace_dc_calls implies rq_trace(<<"SB_DC::fill_arc: ", Current.out>>)
			valid_to_draw: ok_to_draw
		do
		end

   fill_arcs (arcs: ARRAY [ SB_ARC ])
		require
		--	trace_dc_calls implies rq_trace(<<"SB_DC::fill_arcs: ", Current.out>>)
			valid_to_draw: ok_to_draw
		do
		end

feature -- Filled polygon

   fill_polygon (points: ARRAY [ SB_POINT ])
		require
		--	trace_dc_calls implies rq_trace(<<"SB_DC::fill_polygon: ", Current.out>>)
			valid_to_draw: ok_to_draw
		do
		end

   fill_concave_polygon (points: ARRAY [ SB_POINT ])
		require
		--	trace_dc_calls implies rq_trace(<<"SB_DC::fill_concave_polygon: ", Current.out>>)
			valid_to_draw: ok_to_draw
		do
		end

   fill_complex_polygon (points: ARRAY [ SB_POINT ])
		require
		--	trace_dc_calls implies rq_trace(<<"SB_DC::fill_complex_polygon: ", Current.out>>)
			valid_to_draw: ok_to_draw
		do
		end


feature  -- Filled polygon with relative points

   fill_polygon_rel (points: ARRAY [ SB_POINT ] )
		require
		--	trace_dc_calls implies rq_trace(<<"SB_DC::fill_polygon_rel: ", Current.out>>)
			valid_to_draw: ok_to_draw
		do
		end

   fill_concave_polygon_rel (points: ARRAY [ SB_POINT ])
		require
		--	trace_dc_calls implies rq_trace(<<"SB_DC::fill_concave_polygon_rel: ", Current.out>>)
			valid_to_draw: ok_to_draw
		do
		end

   fill_complex_polygon_rel (points: ARRAY [ SB_POINT ])
		require
		--	trace_dc_calls implies rq_trace(<<"SB_DC::fill_complex_polygon_rel: ", Current.out>>)
			valid_to_draw: ok_to_draw
		do
		end

feature

   draw_hash_box (x, y, w, h,b: INTEGER)
         -- Draw hashed box
		require
		--	trace_dc_calls implies rq_trace(<<"SB_DC::draw_hash_box: ", Current.out>>)
			valid_to_draw: ok_to_draw
		do
		end

   draw_focus_rectangle ( x, y, w, h: INTEGER)
         -- Draw focus rectangle
		require
		--	trace_dc_calls implies rq_trace(<<"SB_DC::draw_focus_rectangle: ", Current.out>>)
			valid_to_draw: ok_to_draw
		do
		end

   draw_area (source: SB_DRAWABLE; sx, sy, sw, sh, dx, dy: INTEGER)
         -- Draw area from source
		require
		--	trace_dc_calls implies rq_trace(<<"SB_DC::draw_area: ", Current.out>>)
			valid_to_draw: ok_to_draw
		do
		end

   draw_image (image: SB_IMAGE; dx, dy: INTEGER)
         -- Draw image
		require
		--	trace_dc_calls implies rq_trace(<<"SB_DC::draw_image: ", Current.out>>)
			valid_to_draw: ok_to_draw
		do
		end

   draw_bitmap (bitmap: SB_BITMAP; dx, dy: INTEGER)
         -- Draw bitmap
		require
		--	trace_dc_calls implies rq_trace(<<"SB_DC::draw_bitmap: ", Current.out>>)
			valid_to_draw: ok_to_draw
		do
		end

feature -- Draw icon

   draw_icon (icon: SB_ICON; dx, dy: INTEGER)
		require
		--	trace_dc_calls implies rq_trace(<<"SB_DC::draw_icon: ", Current.out>>)
			valid_to_draw: ok_to_draw
		do
		end

   draw_icon_shaded (icon: SB_ICON; dx, dy: INTEGER)
		require
		--	trace_dc_calls implies rq_trace(<<"SB_DC::draw_icon_shaded: ", Current.out>>)
			valid_to_draw: ok_to_draw
		do
		end

   draw_icon_sunken (icon: SB_ICON; dx, dy: INTEGER)
		require
		--	trace_dc_calls implies rq_trace(<<"SB_DC::draw_icon_sunken: ", Current.out>>)
			valid_to_draw: ok_to_draw
		do
		end

feature -- Draw text

   draw_text (x, y: INTEGER; string: STRING)
         -- Draw text
		require
		--	trace_dc_calls implies rq_trace(<<"SB_DC::draw_text: ", Current.out>>)
			valid_to_draw: ok_to_draw
      do
         draw_text_offset (x,y,string, 1, string.count);
      end

   draw_text_len (x, y: INTEGER; string: STRING; length: INTEGER)
         -- Draw text
		require
		--	trace_dc_calls implies rq_trace (<<"SB_DC::draw_text_len: ", Current.out>>)
			valid_to_draw: ok_to_draw
      do
         draw_text_offset (x,y,string, 1, length);
      end

   draw_text_offset (x, y: INTEGER; string: STRING; strt,length: INTEGER)
         -- Draw text
      require
         string /= Void
         strt > 0
         strt+length <= string.count + 1;
		--	trace_dc_calls implies rq_trace (<<"SB_DC::draw_text_offset: ", Current.out>>)
      do
      end

   draw_image_text (x, y: INTEGER; string: STRING)
		require
		--	trace_dc_calls implies rq_trace(<<"SB_DC::draw_image_text: ", Current.out>>)
			valid_to_draw: ok_to_draw
      do
         draw_image_text_offset (x, y, string, 1, string.count);
      end

   draw_image_text_len(x, y: INTEGER; string: STRING; length: INTEGER)
		require
		--	trace_dc_calls implies rq_trace(<<"SB_DC::draw_image_text_len: ", Current.out>>)
			valid_to_draw: ok_to_draw
      do
         draw_image_text_offset(x,y,string, 1, length);
      end

   draw_image_text_offset (x, y: INTEGER; string: STRING; strt, length: INTEGER)
		require
		--	trace_dc_calls implies rq_trace(<<"SB_DC::draw_image_text_offset: ", Current.out>>)
			valid_to_draw: ok_to_draw
      do
      end

feature

   set_foreground (clr: INTEGER)
         -- Set foreground drawing color
		require
		--	trace_dc_calls implies rq_trace(<<"SB_DC::set_foreground: ", Current.out, " color: ", clr.out>>)
      do
         fg := clr;
      end

   set_background (clr: INTEGER)
         -- Set background drawing color
		require
		--	trace_dc_calls implies rq_trace(<<"SB_DC::set_background: ", Current.out>>)
      do
         bg := clr;
      end


   set_dashes (dashoffset: INTEGER; dashpattern: ARRAY[INTEGER])
         -- Set dash pattern and dash offset.
         -- A dash pattern of [1 2 3 4] is a repeating pattern of 1 foreground pixel,
         -- 2 background pixels, 3 foreground pixels, and 4 background pixels.
         -- The offset is where in the pattern the system will start counting.
         -- The maximum length of the dash pattern is 32.
      require
         dashpattern /= Void and then dashpattern.count <= 32
		--	trace_dc_calls implies rq_trace(<<"SB_DC::draw_image: ", Current.out>>)
      local
         i, j, e, len: INTEGER;
      do
         from
            len := 0;
            i := dashpattern.lower;
            e := dashpattern.upper;
            j := 0;
         until
            i > e
         loop
            dashpat.put(dashpattern.item(i), j);
            len := len + dashpattern.item(i);
            i := i + 1;
            j := j + 1;
         end
         dashlen := dashpattern.count;
         dashoff := dashoffset \\ len;
      end

   set_line_width (line_width: INTEGER)
         -- Set line width:- 0 means thinnest/fastest possible
		require
		--	trace_dc_calls implies rq_trace(<<"SB_DC::set_line_width: ", Current.out>>)
      do
         width := line_width
      end

   set_line_cap (cap_style: INTEGER)
         -- Set line cap style
		require
		--	trace_dc_calls implies rq_trace(<<"SB_DC::set_line_cap: ", Current.out>>)
      do
         cap := cap_style
      end

   set_line_join (join_style: INTEGER)
         -- Set line join style
		require
		--	trace_dc_calls implies rq_trace(<<"SB_DC::set_line_join: ", Current.out>>)
      do
         join := join_style
      end

   set_line_style (line_style: INTEGER)
         -- Set line style
		require
	--		trace_dc_calls implies rq_trace(<<"SB_DC::set_line_style: ", Current.out>>)
      do
         style := line_style
      end

   set_fill_style (fillstyle: INTEGER)
         -- Set fill style
		require
		--	trace_dc_calls implies rq_trace(<<"SB_DC::set_fill_style: ", Current.out>>)
      do
         fill := fillstyle
      end

   set_fill_rule (fillrule: INTEGER)
         -- Set fill rule
		require
		--	trace_dc_calls implies rq_trace(<<"SB_DC::set_fill_rule: ", Current.out>>)
      do
         rule := fillrule
      end

   set_function (func: INTEGER)
         -- Set rasterop function
		require
		--	trace_dc_calls implies rq_trace(<<"SB_DC::set_function: ", Current.out>>)
      do
         rop := func
      end

   set_tile (a_tile: SB_IMAGE; dx, dy: INTEGER)
         -- Set the tile image
		require
		--	trace_dc_calls implies rq_trace(<<"SB_DC::set_tile: ", Current.out>>)
      do
         tile := a_tile
         tx := dx
         ty := dy
      end

   set_stipple_bitmap (a_stipple: SB_BITMAP; dx, dy: INTEGER)
         -- Set the stipple bitmap
		require
		--	trace_dc_calls implies rq_trace(<<"SB_DC::set_stipple_bitmap: ", Current.out>>)
      do
         stipple := a_stipple
         pattern := Stipple_none
         tx := dx
         ty := dy
      end

   set_stipple_pattern (a_pattern: INTEGER; dx, dy: INTEGER)
         -- Set the stipple pattern
		require
		--	trace_dc_calls implies rq_trace(<<"SB_DC::set_stipple_pattern: ", Current.out>>)
      do
         pattern := a_pattern
         stipple := Void
         tx := dx
         ty := dy
      end

   set_clip_region (region: SB_REGION)
         -- Set clip region
		require
		--	trace_dc_calls implies rq_trace(<<"SB_DC::set_clip_region: ", Current.out>>)
      do
      end

   set_clip_rectangle_coords (x, y, w, h: INTEGER)
         -- Set clip rectangle
		require
		--	trace_dc_calls implies rq_trace(<<"SB_DC::set_clip_rectangle_coords: ", Current.out>>)
      do
         clip_x := x
         clip_y := y
         clip_w := w
         clip_h := h
      end

   set_clip_rectangle (rectangle: SB_RECTANGLE)
         -- Set clip rectangle
		require
		--	trace_dc_calls implies rq_trace(<<"SB_DC::set_clip_rectangle: ", Current.out>>)
      do
         clip_x := rectangle.x
         clip_y := rectangle.y
         clip_w := rectangle.w
         clip_h := rectangle.h
      end

   clear_clip_rectangle
         -- Clear clipping
		require
		--	trace_dc_calls implies rq_trace(<<"SB_DC::clear_clip_rectangle: ", Current.out>>)
      do
         clip_x := 0
         clip_y := 0
         clip_w := 32767
         clip_h := 32767
      end

	set_clip_mask (a_mask: SB_BITMAP; dx, dy: INTEGER)
			-- Set clip mask
		require
		--	trace_dc_calls implies rq_trace(<<"SB_DC::set_clip_mask: ", Current.out>>)
		do
        	mask := a_mask
         	cx := dx
         	cy := dy
      	end

	clear_clip_mask
    		-- Clear clip mask
		require
		--	trace_dc_calls implies rq_trace(<<"SB_DC::clear_clip_mask: ", Current.out>>)
		do
			mask := Void
			cx := 0
			cy := 0
		end

	set_font (a_font: SB_FONT)
			-- Set font for drawing text
		require
		--	trace_dc_calls implies rq_trace(<<"SB_DC::set_font: ", Current.out>>)
		do
			font := a_font
		end

	clip_children (yes: BOOLEAN)
			-- Clip against child windows
		require
		--	trace_dc_calls implies rq_trace(<<"SB_DC::clip_children: ", Current.out>>)
		do
		end

end
