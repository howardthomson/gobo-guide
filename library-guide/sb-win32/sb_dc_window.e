indexing
	description: "[
		Window Device Context The Window Device Context allows drawing
		into an SB_DRAWABLE, such as an on-screen window (SB_WINDOW and derivatives)
		or an off-screen image (SB_IMAGE and its derivatives). Because certain hardware
		resources are locked down, only one SB_DC_WINDOW may be locked on a
		drawable at any one time.
	]"
	author: "Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright: "Copyright (c) 2002, Eugene Melekhov and others"
	license: "Eiffel Forum Freeware License v2 (see forum.txt)"
	status: "partly complete"

class SB_DC_WINDOW

inherit

	SB_DC_WINDOW_DEF
      rename
      --   make as dc_make
			SB_fill_tiled			as Fill_tiled,
			SB_fill_solid			as Fill_solid,
			SB_fill_stippled		as Fill_stippled,
			SB_fill_opaquestippled	as Fill_opaque_stippled,
			SB_line_solid			as Line_solid,
--			SB_line_double_dash		as Line_double_dash,
			SB_join_miter			as Join_miter,
			SB_cap_butt				as Cap_butt,
--			SB_cap_not_last			as Cap_not_last,
			SB_cap_round			as Cap_round,
			SB_cap_projecting		as Cap_projecting,
			SB_join_round			as Join_round,
--			SB_join_bevel			as Join_bevel
      redefine
      --   valid_dc,
         clear_clip_mask,
         clear_clip_rectangle,
         clip_children,
         draw_arc,
         draw_arcs,
         draw_area,
         draw_bitmap,
         draw_focus_rectangle,
         draw_hash_box,
         draw_icon,
         draw_icon_shaded,
         draw_icon_sunken,
         draw_image,
         draw_image_text_offset,
         draw_line,
         draw_line_segments,
     --    draw_lines_num,
         draw_lines_rel,
         draw_point,
         draw_points,
         draw_points_rel,
         draw_rectangle,
         draw_rectangles,
         draw_text_offset,
     --    fill_chord,
     --    fill_chords,
         fill_arc,
         fill_arcs,
         fill_complex_polygon,
         fill_complex_polygon_rel,
         fill_concave_polygon,
         fill_concave_polygon_rel,
     --	fill_polygon_num,
         fill_polygon_rel,
         fill_rectangle,
         fill_rectangles,
         read_pixel,
         set_background,
         set_clip_mask,
         set_clip_rectangle,
         set_clip_rectangle_coords,
         set_clip_region,
         set_dashes,
         set_fill_rule,
         set_fill_style,
         set_foreground,
         set_function,
         set_line_cap,
         set_line_join,
         set_line_style,
         set_line_width,
         set_stipple_pattern,
         set_stipple_bitmap,
         set_font,
         set_tile
      end

   SB_DEFS

creation

	make_once, make, make_event

feature {NONE} -- Implementation Attributes

   mem: MEMORY;

   oldpalette, oldbrush, oldpen: POINTER;

   devfg: INTEGER;
         -- Device foreground pixel value
   devbg: INTEGER;
         -- Device background pixel value

   needs_new_brush: BOOLEAN;
   needs_new_pen: BOOLEAN;
   needs_path: BOOLEAN;

   context: POINTER;	-- Context handle

feature -- Creation

	make_def is
		do
		end

	make_event_def(drawable: SB_DRAWABLE; event: SB_EVENT) is
			-- Construct for painting in response to expose;
			-- This sets the clip rectangle to the exposed rectangle
		local
			hrgn: POINTER
			t: INTEGER
			cw, ch: INTEGER_32
			xx, yy: INTEGER_32
		do
			cw := clip_w.to_integer_32
			ch := clip_h.to_integer_32
--			xx := clip_x.to_integer_32; xx := xx + cw
--			yy := clip_y.to_integer_32; yy := yy + ch
--			hrgn := wapi_rf.CreateRectRgn(clip_x, clip_y, clip_x + clip_w, clip_y + clip_h);
				-- TODO: Fix EDP's error report about argument counts for infix "+", in the above line
				-- Problem with implicit conversion from INTEGER_16 to INTEGER/INTEGER_32
			hrgn := wapi_rf.CreateRectRgn(clip_x, clip_y, xx, yy);
			t := wapi_clp.SelectClipRgn(context, hrgn);
			t := wapi_dcf.DeleteObject(hrgn);
		end


  start (drawable: SB_DRAWABLE) is
         -- Begin locks in a drawable surface
      require else
         drawable /= Void and then drawable.is_attached
      local
         t: INTEGER_32;
         lb: SB_WAPI_LOGBRUSH;
         t1: INTEGER;
      do
		 lb := once_logbrush
         surface := drawable; -- Careful:- surface->id() can be HWND or HBITMAP depending on drawable
         visual := drawable.visual
         context := drawable.get_dc
         
         rect_x := 0
         clip_x := 0
         rect_y := 0
         clip_y := 0
         rect_w := drawable.width
         rect_h := drawable.height
         clip_w := rect_w
         clip_h := rect_h
         
         --  Select and realize palette, if necessary
         if visual.hPalette /= default_pointer then
            oldpalette := wapi_clr.SelectPalette (context, visual.hPalette, 0)
            t1 := wapi_clr.RealizePalette (context)
         end
         devfg := t.bit_not	--complement of t: (~ t)
         devbg := 0

         -- Create our default pen (black, solid, one pixel wide)
         lb.set_style (wapi_bs.BS_SOLID)
         lb.set_color (wapi_wmc.PALETTERGB (0, 0, 0))
         lb.set_hatch (0)
         oldpen := wapi_dcf.SelectObject(context,
            wapi_pnf.ExtCreatePen (wapi_ps.PS_GEOMETRIC | wapi_ps.PS_SOLID | wapi_ps.PS_ENDCAP_FLAT
                            | wapi_ps.PS_JOIN_MITER, 1, lb.ptr, 0, default_pointer))

         --  Create our default brush (solid white, for fills)
         lb.set_style (wapi_bs.BS_SOLID)
         lb.set_color (wapi_wmc.PALETTERGB(255, 255, 255))
         lb.set_hatch (0)
         oldbrush := wapi_dcf.SelectObject (context, wapi_bf.CreateBrushIndirect (lb.ptr))

         --  Text alignment
         t1 := wapi_ff.SetTextAlign (context, wapi_ta.TA_BASELINE + wapi_ta.TA_LEFT)

         -- Polygon fill mode
         t1 := wapi_rf.SetPolyFillMode (context, wapi_pfm.ALTERNATE)
      end

	stop is
			-- End unlock the drawable surface
		local
			dwFlags: INTEGER_32
         	t: INTEGER
         	t1: POINTER
      	do
         	if context /= default_pointer then
            	t := wapi_dcf.DeleteObject (wapi_dcf.SelectObject(context, oldpen))
            	t := wapi_dcf.DeleteObject (wapi_dcf.SelectObject(context, oldbrush))
            	if visual.hPalette /= default_pointer then
               		t1 := wapi_clr.SelectPalette (context, oldpalette, 0)
            	end
            	t := surface.release_dc (context)

            	dwFlags := (wapi_wf.GetWindowLong (surface.resource_id, wapi_gwl.GWL_STYLE))
 
            	t := wapi_wf.SetWindowLong(surface.resource_id, wapi_gwl.GWL_STYLE, (dwFlags | wapi_ws.WS_CLIPCHILDREN))
            	context := default_pointer
         	end
         	surface := Void
      	end

   read_pixel (x, y: INTEGER): INTEGER is
         -- Read back pixel
      local
         clr: INTEGER;
      do
         if 0 <= x and then 0 <= y and then  x < surface.width
            and then y < surface.height
          then
            clr := wapi_bmp.GetPixel (context, x, y)
            Result := sbrgb (wapi_wmc.GetRValue (clr), wapi_wmc.GetGValue (clr), wapi_wmc.GetBValue (clr))
         end
      end

feature -- Draw points

   draw_point (x,y : INTEGER) is
      local
         t: INTEGER;
      do
         t := wapi_bmp.SetPixel (context, x, y, devfg)
      end

   draw_points(points: ARRAY[SB_POINT]) is
      local
         t,i,e: INTEGER;
      do
         from
            i := points.lower
            e := points.upper
         until
            i > e
         loop
            t := wapi_bmp.SetPixel(context, points.item(i).x, points.item(i).y, devfg);
            i := i + 1
         end
      end

   draw_points_rel(points: ARRAY[SB_POINT]) is
      local
         t,i,e,x,y: INTEGER
      do
         from
            i := points.lower
            e := points.upper
         until
            i > e
         loop
            x := x + points.item (i).x
            y := y + points.item (i).y
            t := wapi_bmp.SetPixel(context, x, y, devfg)
            i := i + 1
         end
      end

feature -- Draw lines

   draw_line(x1, y1, x2, y2: INTEGER) is
      local
         pts: ARRAY[INTEGER]
         t: INTEGER
      do
         if needs_new_pen then
            update_pen
         end
         if needs_path then
            t := wapi_path.BeginPath(context);
         end
         create pts.make (0, 3)
         pts.put(x1, 0)
         pts.put(y1, 1)
         pts.put(x2, 2)
         pts.put(y2, 3)
         mem.collection_off
         t := wapi_ln.Polyline (context, pts.area.base_address, 2)
         mem.collection_on
         if needs_path then
            t := wapi_path.EndPath (context)
            t := wapi_path.StrokePath (context)
         end
      end

   draw_lines_num(points: ARRAY[SB_POINT]; num: INTEGER) is
      local
         pts: ARRAY[INTEGER];
         t: INTEGER;
         i,j,e: INTEGER;
      do
         if needs_new_pen then
            update_pen;
         end
         t := wapi_ln.MoveToEx(context, points.item(points.lower).x, points.item(points.lower).y, default_pointer);
         if needs_path then
            t := wapi_path.BeginPath(context);
         end
         if num > 8192 or else num < 4 then
            from
               i := points.lower;
               e := points.lower+num-1;
            until
               i > e
            loop
               t := wapi_ln.LineTo(context, points.item(i).x, points.item(i).y);
               i := i + 1;
            end
         else
            create pts.make(0, num*2-1);
            from
               i := points.lower;
               e := points.lower+num-1;
               j := 0;
            until
               i > e
            loop
               pts.put(points.item(i).x,j);
               pts.put(points.item(i).y,j+1);
               i := i + 1;
               j := j + 2;
            end
            mem.collection_off
            t := wapi_ln.Polyline(context, pts.area.base_address, num);
            mem.collection_on

         end
         if needs_path then
            t := wapi_path.EndPath(context);
            t := wapi_path.StrokePath(context);
         end

      end

   draw_lines_rel(points: ARRAY[SB_POINT]) is
      local
         pts: ARRAY[INTEGER];
         t: INTEGER;
         x,y,i,j,e: INTEGER;
      do
         if needs_new_pen then
            update_pen;
         end
         if needs_path then
            t := wapi_path.BeginPath(context);
         end
         create pts.make(0,points.count*2-1);
         from
            i := points.lower;
            e := points.upper;
            j := 0;
         until
            i > e
         loop
            x := x + points.item(i).x;
            y := y + points.item(i).y;
            pts.put(x,j);
            pts.put(y,j+1);
            i := i + 1;
            j := j + 2;
         end
         mem.collection_off
         t := wapi_ln.Polyline(context,pts.area.base_address,points.count);
         mem.collection_on

         if needs_path then
            t := wapi_path.EndPath(context);
            t := wapi_path.StrokePath(context);
         end
      end

   draw_line_segments(segments: ARRAY[SB_SEGMENT]) is
      local
         pts: ARRAY[INTEGER];
         i,e,t: INTEGER;
      do
         create pts.make(0,3);
         if needs_new_pen then
            update_pen;
         end
         if needs_path then
            t := wapi_path.BeginPath(context);
         end
         mem.collection_off
         from
            i := segments.lower;
            e := segments.upper;
         until
            i > e
         loop
            pts.put(segments.item(i).x1,0);
            pts.put(segments.item(i).y1,1);
            pts.put(segments.item(i).x2,2);
            pts.put(segments.item(i).y2,3);
            t := wapi_ln.Polyline(context,pts.area.base_address,2);
            i := i + 1;
         end
         mem.collection_on
         if needs_path then
            t := wapi_path.EndPath(context);
            t := wapi_path.StrokePath(context);
         end
      end

feature -- Draw rectangles

   draw_rectangle(x, y, w, h: INTEGER) is
      local
         hBrush: POINTER;
         t: INTEGER;
      do
         if needs_new_pen then
            update_pen;
         end
         hBrush := wapi_dcf.SelectObject(context,wapi_dcf.GetStockObject(wapi_so.NULL_BRUSH));
         t := wapi_fsh.Rectangle(context,x,y,x+w+1,y+h+1);
         hBrush := wapi_dcf.SelectObject(context,hBrush);
      end

   draw_rectangles(rectangles: ARRAY[SB_RECTANGLE]) is
      local
         hBrush: POINTER;
         i,e,t: INTEGER;
      do
         if needs_new_pen then
            update_pen;
         end
         hBrush := wapi_dcf.SelectObject(context,wapi_dcf.GetStockObject(wapi_so.NULL_BRUSH));
         from
            i := rectangles.lower;
            e := rectangles.upper;
         until
               i > e
         loop
            t := wapi_fsh.Rectangle(context,rectangles.item(i).x,rectangles.item(i).y,
                                    rectangles.item(i).x+rectangles.item(i).w+1,
                                    rectangles.item(i).y+rectangles.item(i).h+1);
            i := i + 1;
         end
         hBrush := wapi_dcf.SelectObject(context,hBrush);
      end

feature -- Draw arcs

   draw_arc(x, y, w_, h_, ang1, ang2_: INTEGER) is
      local
         reversed: BOOLEAN;
         w, h, ang2, xStart, yStart, xEnd, yEnd, t: INTEGER;
         math: SB_MATH;
      do
         ang2 := ang2_;
         reversed := ang2 < 0;
         if ang2 /= 0 then
            if needs_new_pen then
               update_pen;
            end
            ang2 := ang2 + ang1;
            w := w_ + 1;
            h := h_ + 1;
            xStart := (0.5*w+w*math.cos(ang1*math.pi/(180.0*64.0)) + x).rounded.force_to_integer_32;
            yStart := (0.5*h-h*math.sin(ang1*math.pi/(180.0*64.0)) + y).rounded.force_to_integer_32;
            xEnd := (0.5*w+w*math.cos(ang2*math.pi/(180.0*64.0)) + x).rounded.force_to_integer_32;
            yEnd := (0.5*h-h*math.sin(ang2*math.pi/(180.0*64.0)) + y).rounded.force_to_integer_32;
            if needs_path then
               t := wapi_path.BeginPath(context);
            end
            if reversed then
               t := wapi_ln.Arc(context,x,y,x+w,y+h,xEnd,yEnd,xStart,yStart);
            else
               t := wapi_ln.Arc(context,x,y,x+w,y+h,xStart,yStart,xEnd,yEnd);
            end
            if needs_path then
               t := wapi_path.EndPath(context);
               t := wapi_path.StrokePath(context);
            end
         end
      end

   draw_arcs(arcs: ARRAY[SB_ARC]) is
      local
         i,e: INTEGER;
      do
         from
            i := arcs.lower;
            e := arcs.upper;
         until
               i > e
         loop
            draw_arc(arcs.item(i).x,arcs.item(i).y,arcs.item(i).w,
                     arcs.item(i).h,arcs.item(i).a,arcs.item(i).b);
            i := i + 1;
         end
      end

feature -- Filled chords

   fill_chord(x, y, w_, h_, ang1, ang2_: INTEGER) is
      local
         reversed: BOOLEAN;
         hPen: POINTER
         w, h, ang2, xStart, yStart, xEnd, yEnd, t: INTEGER;
         math: SB_MATH;
      do
         ang2 := ang2_;
         reversed := ang2 < 0;
         if ang2 /= 0 then
            if needs_new_brush then
               update_brush;
            end
            ang2 := ang2 + ang1;
            w := w_ + 1;
            h := h_ + 1;
            xStart := (0.5*w+w*math.cos(ang1*math.pi/(180.0*64.0)) + x).rounded.force_to_integer_32;
            yStart := (0.5*h-h*math.sin(ang1*math.pi/(180.0*64.0)) + y).rounded.force_to_integer_32;
            xEnd := (0.5*w+w*math.cos(ang2*math.pi/(180.0*64.0)) + x).rounded.force_to_integer_32;
            yEnd := (0.5*h-h*math.sin(ang2*math.pi/(180.0*64.0)) + y).rounded.force_to_integer_32;
            hPen := wapi_dcf.SelectObject(context,wapi_dcf.GetStockObject(wapi_so.NULL_PEN))
            if reversed then
               t := wapi_fsh.Chord(context,x,y,x+w,y+h,xEnd,yEnd,xStart,yStart);
            else
               t := wapi_fsh.Chord(context,x,y,x+w,y+h,xStart,yStart,xEnd,yEnd);
            end
            hPen := wapi_dcf.SelectObject(context,hPen);
         end
      end

   fill_chords(chords: ARRAY[SB_ARC]) is
      local
         i,e: INTEGER;
      do
         from
            i := chords.lower;
            e := chords.upper;
         until
               i > e
         loop
            fill_chord(chords.item(i).x,chords.item(i).y,chords.item(i).w,
                     chords.item(i).h,chords.item(i).a,chords.item(i).b);
            i := i + 1;
         end
      end


feature -- Filled rectangles

   fill_rectangle(x, y, w, h: INTEGER) is
      local
         hPen: POINTER;
         t: INTEGER;
         t1: POINTER;
      do
         if needs_new_brush then
            update_brush;
         end
         hPen := wapi_dcf.SelectObject(context,wapi_dcf.GetStockObject(wapi_so.NULL_PEN));
         t := wapi_fsh.Rectangle(context,x,y,x+w+1,y+h+1);
         t1 := wapi_dcf.SelectObject(context,hPen);
      end

   fill_rectangles(rectangles: ARRAY[SB_RECTANGLE]) is
      local
         hPen: POINTER;
         i, e, t: INTEGER;
         t1: POINTER;
      do
         if needs_new_brush then
            update_brush;
         end
         hPen := wapi_dcf.SelectObject(context,wapi_dcf.GetStockObject(wapi_so.NULL_PEN))
         from
            i := rectangles.lower;
            e := rectangles.upper;
         until
               i > e
         loop
            t := wapi_fsh.Rectangle(context,rectangles.item(i).x,rectangles.item(i).y,
                               rectangles.item(i).x+rectangles.item(i).w+1,
                               rectangles.item(i).y+rectangles.item(i).h+1);
            i := i + 1;
         end
         t1 := wapi_dcf.SelectObject(context,hPen);
      end

feature -- Filled arcs

   fill_arc(x, y, w_, h_, ang1, ang2_: INTEGER) is
      local
         reversed: BOOLEAN;
         hPen: POINTER;
         w, h, ang2, xStart, yStart, xEnd, yEnd, t: INTEGER;
         t1: POINTER;
         math: SB_MATH;
      do
         ang2 := ang2_;
         reversed := ang2 < 0;
         if ang2 /= 0 then
            if needs_new_brush then
               update_brush;
            end
            ang2 := ang2 + ang1;
            w := w_ + 1;
            h := h_ + 1;
            xStart := (0.5*w+w*math.cos(ang1*math.pi/(180.0*64.0)) + x).rounded.force_to_integer_32;
            yStart := (0.5*h-h*math.sin(ang1*math.pi/(180.0*64.0)) + y).rounded.force_to_integer_32;
            xEnd := (0.5*w+w*math.cos(ang2*math.pi/(180.0*64.0)) + x).rounded.force_to_integer_32;
            yEnd := (0.5*h-h*math.sin(ang2*math.pi/(180.0*64.0)) + y).rounded.force_to_integer_32;
            hPen := wapi_dcf.SelectObject(context,wapi_dcf.GetStockObject(wapi_so.NULL_PEN))
            if reversed then
               t := wapi_fsh.Pie(context,x,y,x+w,y+h,xEnd,yEnd,xStart,yStart);
            else
               t := wapi_fsh.Pie(context,x,y,x+w,y+h,xStart,yStart,xEnd,yEnd);
            end
            t1 := wapi_dcf.SelectObject(context,hPen);
         end
      end

   fill_arcs(arcs: ARRAY[SB_ARC]) is
      local
         i,e: INTEGER;
      do
         from
            i := arcs.lower;
            e := arcs.upper;
         until
               i > e
         loop
            fill_arc(arcs.item(i).x,arcs.item(i).y,arcs.item(i).w,
                     arcs.item(i).h,arcs.item(i).a,arcs.item(i).b);
            i := i + 1;
         end
      end

feature -- Filled polygon

   fill_polygon_num(points: ARRAY[SB_POINT]; num: INTEGER) is
      local
         pts: ARRAY[INTEGER];
         hPen: POINTER;
         t: INTEGER;
         t1: POINTER;
         i,j,e: INTEGER;
      do
         if needs_new_brush then
            update_brush;
         end
         hPen := wapi_dcf.SelectObject(context,wapi_dcf.GetStockObject(wapi_so.NULL_PEN));
         create pts.make(0,num*2-1);
         from
            i := points.lower;
            e := points.lower+num-1;
            j := 0;
         until
            i > e
         loop
            pts.put(points.item(i).x,j);
            pts.put(points.item(i).y,j+1);
            i := i + 1;
            j := j + 2;
         end
         mem.collection_off
         t := wapi_fsh.Polygon(context,pts.area.base_address,num);
         mem.collection_on
         t1 := wapi_dcf.SelectObject(context,hPen);
      end

   fill_concave_polygon(points: ARRAY[SB_POINT]) is
      local
         pts: ARRAY[INTEGER];
         hPen: POINTER;
         t: INTEGER;
         i,j,e: INTEGER;
         t1: POINTER;
      do
         if needs_new_brush then
            update_brush;
         end
         hPen := wapi_dcf.SelectObject(context,wapi_dcf.GetStockObject(wapi_so.NULL_PEN));
         create pts.make(0,points.count*2 - 1);
         from
            i := points.lower;
            e := points.upper;
            j := 0;
         until
            i > e
         loop
            pts.put(points.item(i).x,j);
            pts.put(points.item(i).y,j+1);
            i := i + 1;
            j := j + 2;
         end
         mem.collection_off
         t := wapi_fsh.Polygon(context,pts.area.base_address,points.count);
         mem.collection_on
         t1 := wapi_dcf.SelectObject(context,hPen);
      end

   fill_complex_polygon(points: ARRAY[SB_POINT]) is
      local
         pts: ARRAY[INTEGER];
         hPen: POINTER;
         t: INTEGER;
         t1: POINTER;
         i,j,e: INTEGER;
      do
         if needs_new_brush then
            update_brush;
         end
         hPen := wapi_dcf.SelectObject(context,wapi_dcf.GetStockObject(wapi_so.NULL_PEN));
         create pts.make(0,points.count*2 - 1);
         from
            i := points.lower;
            e := points.upper;
            j := 0;
         until
            i > e
         loop
            pts.put(points.item(i).x,j);
            pts.put(points.item(i).y,j+1);
            i := i + 1;
            j := j + 2;
         end
         mem.collection_off
         t := wapi_fsh.Polygon(context,pts.area.base_address,points.count);
         mem.collection_on
         t1 := wapi_dcf.SelectObject(context,hPen);
      end

   -- Filled polygon with relative points
   fill_polygon_rel(points: ARRAY[SB_POINT]) is
      local
         pts: ARRAY[INTEGER];
         hPen: POINTER;
         t: INTEGER;
         t1: POINTER;
         x, y, i, j, e: INTEGER;
      do
         if needs_new_brush then
            update_brush;
         end
         hPen := wapi_dcf.SelectObject(context,wapi_dcf.GetStockObject(wapi_so.NULL_PEN));
         create pts.make(0,points.count*2 - 1);
         from
            i := points.lower;
            e := points.upper;
            j := 0;
         until
            i > e
         loop
            x := x + points.item(i).x;
            y := y + points.item(i).y;
            pts.put(x,j);
            pts.put(y,j+1);
            i := i + 1;
            j := j + 2;
         end
         mem.collection_off
         t := wapi_fsh.Polygon(context,pts.area.base_address,points.count);
         mem.collection_on
         t1 := wapi_dcf.SelectObject(context,hPen);
      end

   fill_concave_polygon_rel(points: ARRAY[SB_POINT]) is
      local
         pts: ARRAY[INTEGER];
         hPen: POINTER;
         t: INTEGER;
         t1: POINTER;
         x, y, i, j, e: INTEGER;
      do
         if needs_new_brush then
            update_brush;
         end
         hPen := wapi_dcf.SelectObject(context,wapi_dcf.GetStockObject(wapi_so.NULL_PEN));
         create pts.make(0,points.count*2 - 1);
         from
            i := points.lower;
            e := points.upper;
            j := 0;
         until
            i > e
         loop
            x := x + points.item(i).x;
            y := y + points.item(i).y;
            pts.put(x,j);
            pts.put(y,j+1);
            i := i + 1;
            j := j + 2;
         end
         mem.collection_off
         t := wapi_fsh.Polygon(context,pts.area.base_address,points.count);
         mem.collection_on
         t1 := wapi_dcf.SelectObject(context,hPen);
      end

   fill_complex_polygon_rel (points: ARRAY[SB_POINT]) is
      local
         pts: ARRAY [ INTEGER ]
         hPen: POINTER
         t: INTEGER
         t1: POINTER
         x, y, i, j, e: INTEGER
      do
         if needs_new_brush then
            update_brush
         end
         hPen := wapi_dcf.SelectObject (context, wapi_dcf.GetStockObject (wapi_so.NULL_PEN));
         create pts.make (0, points.count * 2 - 1)
         from
            i := points.lower
            e := points.upper
            j := 0
         until
            i > e
         loop
            x := x + points.item (i).x
            y := y + points.item (i).y
            pts.put (x, j)
            pts.put (y, j+1)
            i := i + 1
            j := j + 2
         end
         mem.collection_off
         t := wapi_fsh.Polygon (context, pts.area.base_address, points.count);
         mem.collection_on
         t1 := wapi_dcf.SelectObject (context, hPen)
      end

   draw_hash_box(x, y, w, h,b: INTEGER) is
         -- Draw hashed box
      local
         hBrush: POINTER;
         crOldBack,crOldText, t: INTEGER;
      do
         hBrush := wapi_dcf.SelectObject(context,wapi_bf.CreatePatternBrush(app.stipple(Stipple_gray)));
         crOldBack := wapi_pf.SetBkColor(context,wapi_wmc.RGB(255,255,255));
         crOldText := wapi_ff.SetTextColor(context,wapi_wmc.RGB(0,0,0));
         t := wapi_bmp.PatBlt(context,x,y,w-b,b,wapi_trast.PATINVERT);
         t := wapi_bmp.PatBlt(context,x+w-b,y,b,h-b,wapi_trast.PATINVERT);
         t := wapi_bmp.PatBlt(context,x+b,y+h-b,w-b,b,wapi_trast.PATINVERT);
         t := wapi_bmp.PatBlt(context,x,y+b,b,h-b,wapi_trast.PATINVERT);
         t := wapi_dcf.DeleteObject(wapi_dcf.SelectObject(context,hBrush));
         t := wapi_pf.SetBkColor(context,crOldBack);
         t := wapi_ff.SetTextColor(context,crOldText);
      end

   draw_focus_rectangle( x, y, w, h: INTEGER) is
         -- Draw focus rectangle
      local
         hBrush: POINTER;
         crOldBack,crOldText, t: INTEGER;
      do
         hBrush := wapi_dcf.SelectObject(context,wapi_bf.CreatePatternBrush(app.stipple(Stipple_gray)));
         crOldBack := wapi_pf.SetBkColor(context,wapi_wmc.RGB(255,255,255));
         crOldText := wapi_ff.SetTextColor(context,wapi_wmc.RGB(0,0,0));
         t := wapi_bmp.PatBlt(context,x,y,w-1,1,wapi_trast.PATINVERT);
         t := wapi_bmp.PatBlt(context,x+w-1,y,1,h-1,wapi_trast.PATINVERT);
         t := wapi_bmp.PatBlt(context,x+1,y+h-1,w-1,1,wapi_trast.PATINVERT);
         t := wapi_bmp.PatBlt(context,x,y+1,1,h-1,wapi_trast.PATINVERT);
         t := wapi_dcf.DeleteObject(wapi_dcf.SelectObject(context,hBrush));
         t := wapi_pf.SetBkColor(context,crOldBack);
         t := wapi_ff.SetTextColor(context,crOldText);
      end

   draw_area(source: SB_DRAWABLE; sx, sy, sw, sh, dx, dy: INTEGER) is
         -- Draw area from source
         -- Some of these ROP codes do not have names; the full list can be found
         -- in  the MSDN docs at Platform SDK/Reference/Appendixes/Win32
         -- Appendixes/Raster Operation Codes/Ternary Raster Operations
      local
         shdc: POINTER;
         t: INTEGER;
      do
         shdc := source.get_dc;
         inspect rop
         when Blt_clr then
            -- D := 0
            t := wapi_bmp.BitBlt(context,dx,dy,sw,sh,shdc,sx,sy,wapi_trast.BLACKNESS);

         when Blt_src_and_dst then
            -- D := S & D
            t := wapi_bmp.BitBlt(context,dx,dy,sw,sh,shdc,sx,sy,wapi_trast.SRCAND);

         when Blt_src_and_not_dst then
            -- D := S & ~D
            t := wapi_bmp.BitBlt(context,dx,dy,sw,sh,shdc,sx,sy,wapi_trast.SRCERASE);

         when Blt_src then
            -- D := S
            t := wapi_bmp.BitBlt(context,dx,dy,sw,sh,shdc,sx,sy,wapi_trast.SRCCOPY);

         when Blt_not_src_and_dst then
            -- D := ~S & D
            t := wapi_bmp.BitBlt(context,dx,dy,sw,sh,shdc,sx,sy,2229030); -- 0x220326

         when Blt_dst then
            -- D := D

         when Blt_src_xor_dst then
            -- D := S ^ D
            t := wapi_bmp.BitBlt(context,dx,dy,sw,sh,shdc,sx,sy,wapi_trast.SRCINVERT);

         when Blt_src_or_dst then
            -- D := S | D
            t := wapi_bmp.BitBlt(context,dx,dy,sw,sh,shdc,sx,sy,wapi_trast.SRCPAINT);

         when Blt_not_src_and_not_dst then
            -- D := ~S & ~D  ==  D := ~(S | D)
            t := wapi_bmp.BitBlt(context,dx,dy,sw,sh,shdc,sx,sy,wapi_trast.NOTSRCERASE);

         when Blt_not_src_xor_dst then
            -- D := ~S ^ D
            t := wapi_bmp.BitBlt(context,dx,dy,sw,sh,shdc,sx,sy,10027110); -- 0x990066 Not sure about this one

         when Blt_not_dst then
            -- D := ~D
            t := wapi_bmp.BitBlt(context,dx,dy,sw,sh,shdc,sx,sy,wapi_trast.DSTINVERT);

         when Blt_src_or_not_dst then
            -- D := S | ~D
            t := wapi_bmp.BitBlt(context,dx,dy,sw,sh,shdc,sx,sy,14484008); -- 0xDD0228

         when Blt_not_src then
            -- D := ~S
            t := wapi_bmp.BitBlt(context,dx,dy,sw,sh,shdc,sx,sy,wapi_trast.NOTSRCCOPY);

         when Blt_not_src_or_dst then
            -- D := ~S | D
            t := wapi_bmp.BitBlt(context,dx,dy,sw,sh,shdc,sx,sy,wapi_trast.MERGEPAINT);

         when Blt_not_src_or_not_dst then
            -- D := ~S | ~D  ==  ~(S & D)
            t := wapi_bmp.BitBlt(context,dx,dy,sw,sh,shdc,sx,sy,7799014); -- 0x7700E6

         when Blt_set then
            -- D := 1
            t := wapi_bmp.BitBlt(context,dx,dy,sw,sh,shdc,sx,sy,wapi_trast.WHITENESS);
         end
         t := source.release_dc(shdc);
      end

   draw_image(image: SB_IMAGE; dx, dy: INTEGER) is
         -- Draw image
      local
         shdc: POINTER;
         t: INTEGER;
      do
         shdc := image.get_dc;
         inspect rop
         when Blt_clr then
            -- D := 0
            t := wapi_bmp.BitBlt(context,dx,dy,image.width,image.height,shdc,0,0,wapi_trast.BLACKNESS);

         when Blt_src_and_dst then
            -- D := S & D
            t := wapi_bmp.BitBlt(context,dx,dy,image.width,image.height,shdc,0,0,wapi_trast.SRCAND);

         when Blt_src_and_not_dst then
            -- D := S & ~D
            t := wapi_bmp.BitBlt(context,dx,dy,image.width,image.height,shdc,0,0,wapi_trast.SRCERASE);

         when Blt_src then
            -- D := S
            t := wapi_bmp.BitBlt(context,dx,dy,image.width,image.height,shdc,0,0,wapi_trast.SRCCOPY);

         when Blt_not_src_and_dst then
            -- D := ~S & D
            t := wapi_bmp.BitBlt(context,dx,dy,image.width,image.height,shdc,0,0,2229030); -- 0x220326

         when Blt_dst then
            -- D := D

         when Blt_src_xor_dst then
            -- D := S ^ D
            t := wapi_bmp.BitBlt(context,dx,dy,image.width,image.height,shdc,0,0,wapi_trast.SRCINVERT);

         when Blt_src_or_dst then
            -- D := S | D
            t := wapi_bmp.BitBlt(context,dx,dy,image.width,image.height,shdc,0,0,wapi_trast.SRCPAINT);

         when Blt_not_src_and_not_dst then
            -- D := ~S & ~D  ==  D := ~(S | D)
            t := wapi_bmp.BitBlt(context,dx,dy,image.width,image.height,shdc,0,0,wapi_trast.NOTSRCERASE);

         when Blt_not_src_xor_dst then
            -- D := ~S ^ D
            t := wapi_bmp.BitBlt(context,dx,dy,image.width,image.height,shdc,0,0,10027110); -- 0x990066 Not sure about this one

         when Blt_not_dst then
            -- D := ~D
            t := wapi_bmp.BitBlt(context,dx,dy,image.width,image.height,shdc,0,0,wapi_trast.DSTINVERT);

         when Blt_src_or_not_dst then
            -- D := S | ~D
            t := wapi_bmp.BitBlt(context,dx,dy,image.width,image.height,shdc,0,0,14484008); -- 0xDD0228

         when Blt_not_src then
            -- D := ~S
            t := wapi_bmp.BitBlt(context,dx,dy,image.width,image.height,shdc,0,0,wapi_trast.NOTSRCCOPY);

         when Blt_not_src_or_dst then
            -- D := ~S | D
            t := wapi_bmp.BitBlt(context,dx,dy,image.width,image.height,shdc,0,0,wapi_trast.MERGEPAINT);

         when Blt_not_src_or_not_dst then
            -- D := ~S | ~D  ==  ~(S & D)
            t := wapi_bmp.BitBlt(context,dx,dy,image.width,image.height,shdc,0,0,7799014); -- 0x7700E6

         when Blt_set then
            -- D := 1
            t := wapi_bmp.BitBlt(context,dx,dy,image.width,image.height,shdc,0,0,wapi_trast.WHITENESS);
         end
         t := image.release_dc(shdc);
      end

   draw_bitmap(bitmap: SB_BITMAP; dx, dy: INTEGER) is
         -- Draw bitmap
      local
         shdc: POINTER;
         t: INTEGER;
      do
         shdc := bitmap.get_dc;
         inspect rop
         when Blt_clr then
            -- D := 0
            t := wapi_bmp.BitBlt(context,dx,dy,bitmap.width,bitmap.height,shdc,0,0,wapi_trast.BLACKNESS);

         when Blt_src_and_dst then
            -- D := S & D
            t := wapi_bmp.BitBlt(context,dx,dy,bitmap.width,bitmap.height,shdc,0,0,wapi_trast.SRCAND);

         when Blt_src_and_not_dst then
            -- D := S & ~D
            t := wapi_bmp.BitBlt(context,dx,dy,bitmap.width,bitmap.height,shdc,0,0,wapi_trast.SRCERASE);

         when Blt_src then
            -- D := S
            t := wapi_bmp.BitBlt(context,dx,dy,bitmap.width,bitmap.height,shdc,0,0,wapi_trast.SRCCOPY);

         when Blt_not_src_and_dst then
            -- D := ~S & D
            t := wapi_bmp.BitBlt(context,dx,dy,bitmap.width,bitmap.height,shdc,0,0,2229030); -- 0x220326

         when Blt_dst then
            -- D := D

         when Blt_src_xor_dst then
            -- D := S ^ D
            t := wapi_bmp.BitBlt(context,dx,dy,bitmap.width,bitmap.height,shdc,0,0,wapi_trast.SRCINVERT);

         when Blt_src_or_dst then
            -- D := S | D
            t := wapi_bmp.BitBlt(context,dx,dy,bitmap.width,bitmap.height,shdc,0,0,wapi_trast.SRCPAINT);

         when Blt_not_src_and_not_dst then
            -- D := ~S & ~D  ==  D := ~(S | D)
            t := wapi_bmp.BitBlt(context,dx,dy,bitmap.width,bitmap.height,shdc,0,0,wapi_trast.NOTSRCERASE);

         when Blt_not_src_xor_dst then
            -- D := ~S ^ D
            t := wapi_bmp.BitBlt(context,dx,dy,bitmap.width,bitmap.height,shdc,0,0,10027110); -- 0x990066 Not sure about this one

         when Blt_not_dst then
            -- D := ~D
            t := wapi_bmp.BitBlt(context, dx, dy, bitmap.width, bitmap.height, shdc, 0,0, wapi_trast.DSTINVERT);

         when Blt_src_or_not_dst then
            -- D := S | ~D
            t := wapi_bmp.BitBlt(context, dx, dy, bitmap.width, bitmap.height, shdc, 0,0, 14484008); -- 0xDD0228

         when Blt_not_src then
            -- D := ~S
            t := wapi_bmp.BitBlt(context, dx, dy, bitmap.width, bitmap.height, shdc, 0,0, wapi_trast.NOTSRCCOPY);

         when Blt_not_src_or_dst then
            -- D := ~S | D
            t := wapi_bmp.BitBlt(context,dx,dy,bitmap.width,bitmap.height,shdc,0,0,wapi_trast.MERGEPAINT);

         when Blt_not_src_or_not_dst then
            -- D := ~S | ~D  ==  ~(S & D)
            t := wapi_bmp.BitBlt(context,dx,dy,bitmap.width,bitmap.height,shdc,0,0,7799014); -- 0x7700E6

         when Blt_set then
            -- D := 1
            t := wapi_bmp.BitBlt(context,dx,dy,bitmap.width,bitmap.height,shdc,0,0,wapi_trast.WHITENESS);
         end
         t := bitmap.release_dc(shdc);
      end

   draw_icon(icon: SB_ICON; dx, dy: INTEGER) is
         -- Draw icon
      local
         hdcSrc, hdcMsk, t1: POINTER;
         crOldBack, crOldText, t: INTEGER;
         ic: SB_IMAGE_CONSTANTS;
		 opt: INTEGER_32
      do
         hdcSrc := icon.get_dc;
      -- if (icon.options & ic.IMAGE_OPAQUE) /= Zero then
      -- opt := icon.options; if (opt and 10000B) /= Zero then
      	 if icon.is_opaque then
            t := wapi_bmp.BitBlt(context, dx,dy, icon.width, icon.height, hdcSrc, 0,0, wapi_trast.SRCCOPY);
         else
            hdcMsk := wapi_dcf.CreateCompatibleDC(context);
            t1 := wapi_dcf.SelectObject(hdcMsk,icon.shape);
            crOldBack := wapi_pf.SetBkColor(context,wapi_wmc.RGB(255,255,255));
            crOldText := wapi_ff.SetTextColor(context,wapi_wmc.RGB(0,0,0));
            t := wapi_bmp.BitBlt(context,dx,dy,icon.width,icon.height,hdcMsk,0,0,wapi_trast.SRCAND);
            t := wapi_bmp.BitBlt(context,dx,dy,icon.width,icon.height,hdcSrc,0,0,wapi_trast.SRCPAINT);
            t := wapi_dcf.DeleteDC(hdcMsk);
            t := wapi_pf.SetBkColor(context,crOldBack);
            t := wapi_ff.SetTextColor(context,crOldText);
         end
         t := icon.release_dc(hdcSrc);
      end

   draw_icon_shaded(icon: SB_ICON; dx, dy: INTEGER) is
      local
         hdcSrc, hdcMsk, t1: POINTER;
         selbackColor,crOldBack, crOldText, t: INTEGER;
         hBrush, hOldBrush: POINTER;
      do
         hdcSrc := icon.get_dc;
         hdcMsk := wapi_dcf.CreateCompatibleDC(context);
         selbackColor := app.sel_back_color;
         t1 := wapi_dcf.SelectObject(hdcMsk,icon.shape);
         crOldBack := wapi_pf.SetBkColor(context, wapi_wmc.RGB(255,255,255));
         crOldText := wapi_ff.SetTextColor(context, wapi_wmc.RGB(0,0,0));

         -- Paint icon
         t := wapi_bmp.BitBlt(context, dx,dy, icon.width, icon.height, hdcMsk, 0,0, wapi_trast.SRCAND);
         t := wapi_bmp.BitBlt(context, dx,dy, icon.width, icon.height, hdcSrc, 0,0, wapi_trast.SRCPAINT);

         hBrush := wapi_bf.CreatePatternBrush(app.stipple(Stipple_gray));
         hOldBrush := wapi_dcf.SelectObject(context, hBrush);
         t := wapi_bf.SetBrushOrgEx(context,dx,dy,default_pointer);

         -- Make black where pattern is 0 and shape is 0 [DPSoa]
         t := wapi_bmp.BitBlt(context, dx,dy, icon.width, icon.height, hdcMsk, 0,0, 11010985); --0x00A803A9

         t := wapi_ff.SetTextColor(context, wapi_wmc.RGB(sbredval(selbackColor), sbgreenval(selbackColor),
                                              sbblueval(selbackColor)));
         t := wapi_pf.SetBkColor(context,wapi_wmc.RGB(0,0,0));

         -- Make selbackcolor where pattern is 0 and shape is 0 [DPSoo]
         t := wapi_bmp.BitBlt(context, dx,dy, icon.width, icon.height, hdcMsk, 0,0, 16646825); -- 0x00FE02A9

         t1 := wapi_dcf.SelectObject(context,hOldBrush);
         t := wapi_dcf.DeleteObject(hBrush);
         t := wapi_dcf.DeleteDC(hdcMsk);
         t := wapi_pf.SetBkColor(context,crOldBack);
         t := wapi_ff.SetTextColor(context,crOldText);
         t := wapi_bf.SetBrushOrgEx(context,tx,ty,default_pointer);
         t := icon.release_dc(hdcSrc);
      end

   draw_icon_sunken(icon: SB_ICON; dx, dy: INTEGER) is
         -- Draw a sunken or etched-in icon.
      local
         crOldBack, crOldText,  hiliteColor, shadowColor, t: INTEGER;
         hdcSrc, hdcMono, hbrHilite, hbrShadow,  holdBrush, t1: POINTER;
      do
         hdcSrc := icon.get_dc;
         hdcMono := wapi_dcf.CreateCompatibleDC(context);
         t1 := wapi_dcf.SelectObject(hdcMono,icon.etch)

         -- Apparently, BkColor and TextColor apply to the source
         crOldBack := wapi_pf.SetBkColor(context,wapi_wmc.RGB(255,255,255));
         crOldText := wapi_ff.SetTextColor(context,wapi_wmc.RGB(0,0,0));

         -- While brush colors apply to the pattern
         hiliteColor := app.hilite_color;
         hbrHilite := wapi_bf.CreateSolidBrush(wapi_wmc.RGB(sbredval(hiliteColor),
                                                            sbgreenval(hiliteColor),
                                                            sbblueval(hiliteColor)));
         holdBrush := wapi_dcf.SelectObject(context,hbrHilite);

         -- BitBlt the black bits in the monochrome bitmap into highlight colors
         -- in the destination DC (offset a bit). This BitBlt(), and the next one,
         -- use an unnamed raster op (0xB8074a) whose effect is D := ((D ^ P) & S) ^ P.
         -- Or at least I think it is ;) The code = PSDPxax, so that's correct JVZ
         t := wapi_bmp.BitBlt(context,dx+1,dy+1,icon.width,icon.height,hdcMono,0,0,12060490);
         shadowColor := app.shadow_color;
         hbrShadow := wapi_bf.CreateSolidBrush(wapi_wmc.RGB(sbredval(shadowColor),
                                                            sbgreenval(shadowColor),
                                                            sbblueval(shadowColor)));
         t1 := wapi_dcf.SelectObject(context,hbrShadow);

         -- Now BitBlt the black bits in the monochrome bitmap into the
         -- shadow color on the destination DC.
         t := wapi_bmp.BitBlt(context, dx, dy, icon.width, icon.height, hdcMono, 0, 0, 12060490)

         t := wapi_dcf.DeleteDC (hdcMono)
         t1 := wapi_dcf.SelectObject (context, holdBrush)
         t := wapi_dcf.DeleteObject (hbrHilite)
         t := wapi_dcf.DeleteObject (hbrShadow)
         t := wapi_pf.SetBkColor (context, crOldBack)
         t := wapi_ff.SetTextColor (context, crOldText)
         t := icon.release_dc (hdcSrc)
      end

   draw_text_offset(x, y: INTEGER; string: STRING; strt,length: INTEGER) is
         -- Draw text
      local
         p: POINTER
         t: INTEGER
         iBkMode: INTEGER
      do
         iBkMode := wapi_pf.SetBkMode(context, wapi_bm.TRANSPARENT)
         mem.collection_off
         p := string.area.base_address + (strt - 1)
         t := wapi_ff.TextOut (context, x, y, p, length)
         mem.collection_on
         iBkMode := wapi_pf.SetBkMode (context, iBkMode)
      end

   draw_image_text_offset(x, y: INTEGER; string: STRING; strt, length: INTEGER) is
      local
         p: POINTER;
         t: INTEGER;
         iBkMode: INTEGER;
      do
         iBkMode := wapi_pf.SetBkMode(context,wapi_bm.OPAQUE);
         mem.collection_off
         p := string.to_external + (strt - 1);
         t := wapi_ff.TextOut(context,x,y,p,length);
         mem.collection_on
         iBkMode := wapi_pf.SetBkMode(context,iBkMode);
      end

   set_foreground(clr: INTEGER) is
         -- Set foreground drawing color
      local
         t: INTEGER;
      do
         devfg := visual.pixel(clr);
         needs_new_pen := true;
         needs_new_brush := true;
         t := wapi_ff.SetTextColor(context,devfg);
         fg := clr;
      end

   set_background(clr: INTEGER) is
         -- Set background drawing color
      local
         t: INTEGER;
      do
         devbg := visual.pixel(clr);
         t := wapi_pf.SetBkColor(context,devbg);
         bg := clr;
      end

   set_dashes(dashoffset: INTEGER; dashpattern: ARRAY[INTEGER]) is
         -- Set dash pattern
      local
         i,j,e,len: INTEGER;
      do
         Precursor(dashoffset,dashpattern)
         needs_new_pen := True;
      end

   set_line_width(linewidth: INTEGER) is
         -- Set line width
      do
         width := linewidth;
         needs_new_pen := True;
      end

   set_line_cap(capstyle: INTEGER) is
         -- Set line cap style
      do
         cap := capstyle;
         needs_new_pen := True;
      end

   set_line_join(joinstyle: INTEGER) is
         -- Set line join style
      do
         join := joinstyle;
         needs_new_pen := True;
      end

   set_line_style(linestyle: INTEGER) is
         -- Set line style
      do
         style := linestyle;
         needs_new_pen := True;
      end

   set_fill_style(fillstyle: INTEGER) is
         -- Set fill style
      do
         fill := fillstyle;
         needs_new_brush := True;
         needs_new_pen := True;
      end

   set_fill_rule(fillrule: INTEGER) is
         -- Set fill rule
      local
         t: INTEGER;
      do
         if fillrule = Rule_even_odd then
            t := wapi_rf.SetPolyFillMode(context,wapi_pfm.ALTERNATE);
         else
            t := wapi_rf.SetPolyFillMode(context,wapi_pfm.WINDING);
            rule := fillrule;
         end
      end

   set_function(func: INTEGER) is
         -- Set blit function
      local
         t: INTEGER;
      do
         rop := func;

         -- Also set ROP2 code for lines
         inspect rop
         when Blt_clr then
            -- D := 0
            t := wapi_pf.SetROP2(context, wapi_r2.R2_BLACK);
         when Blt_src_and_dst then
            -- D := S & D
            t := wapi_pf.SetROP2(context, wapi_r2.R2_MASKPEN);
         when Blt_src_and_not_dst then
            -- D := S & ~D
            t := wapi_pf.SetROP2(context, wapi_r2.R2_MASKPENNOT);
         when Blt_src then
            -- D := S
            t := wapi_pf.SetROP2(context, wapi_r2.R2_COPYPEN);
         when Blt_not_src_and_dst then
            -- D := ~S & D
            t := wapi_pf.SetROP2(context, wapi_r2.R2_MASKNOTPEN);
         when Blt_dst then
            -- D := D
         when Blt_src_xor_dst then
            -- D := S ^ D
            t := wapi_pf.SetROP2(context,wapi_r2.R2_XORPEN);
         when Blt_src_or_dst then
            -- D := S | D
            t := wapi_pf.SetROP2(context, wapi_r2.R2_MERGEPEN);
         when Blt_not_src_and_not_dst then
            -- D := ~S & ~D  ==  D := ~(S | D)
            t := wapi_pf.SetROP2(context, wapi_r2.R2_NOTMERGEPEN);
         when Blt_not_src_xor_dst then
            -- D := ~S ^ D
            t := wapi_pf.SetROP2(context, wapi_r2.R2_NOTXORPEN); -- Is this the right one?

         when Blt_not_dst then
            -- D := ~D
            t := wapi_pf.SetROP2(context, wapi_r2.R2_NOT);

         when Blt_src_or_not_dst then
            -- D := S | ~D
            t := wapi_pf.SetROP2(context, wapi_r2.R2_MERGEPENNOT);

         when Blt_not_src then
            -- D := ~S
            t := wapi_pf.SetROP2(context, wapi_r2.R2_NOTCOPYPEN);

         when Blt_not_src_or_dst then
            -- D := ~S | D
            t := wapi_pf.SetROP2(context,wapi_r2.R2_MERGENOTPEN);

         when Blt_not_src_or_not_dst then
            -- D := ~S | ~D  ==  ~(S & D)
            t := wapi_pf.SetROP2(context, wapi_r2.R2_NOTMASKPEN);

         when Blt_set then
            -- D := 1
            t := wapi_pf.SetROP2(context, wapi_r2.R2_WHITE);
         end
      end

   set_tile(tile_: SB_IMAGE; dx, dy: INTEGER) is
         -- Set the tile
      do
         tile := tile_;
         tx := dx;
         ty := dy;
      end

   set_stipple_bitmap(stipple_: SB_BITMAP; dx, dy: INTEGER) is
         -- Set the stipple bitmap
      do
         stipple := stipple_;
         pattern := Stipple_none;
         needs_new_brush := True;
         needs_new_pen := True;
         tx := dx;
         ty := dy;
      end

   set_stipple_pattern(stipple_: INTEGER; dx, dy: INTEGER) is
         -- Set the stipple pattern
      do
         stipple := Void;
         pattern := stipple_;
         needs_new_brush := True;
         needs_new_pen := True;
         tx := dx;
         ty := dy;
      end

   set_clip_region(region: SB_REGION) is
         -- Set clip region
      local
         t: INTEGER;
      do
         t := wapi_clp.SelectClipRgn(context,region.region);
      end

	set_clip_rectangle_coords(x, y, w, h: INTEGER) is
			-- Set clip rectangle
		local
			t: INTEGER
			hrgn: POINTER
		do
			clip_x := x.max (rect_x)
			clip_y := y.max (rect_y)
			clip_w := (x + w).min (rect_x + rect_w) - clip_x
			clip_h := (y + h).min (rect_y + rect_h) - clip_y

			if clip_w <= 0 then clip_w := 0 end
			if clip_h <= 0 then clip_h := 0 end

			hrgn := wapi_rf.CreateRectRgn (clip_x, clip_y, clip_x + clip_w, clip_y + clip_h)
			t := wapi_clp.SelectClipRgn (context, hrgn)
			t := wapi_dcf.DeleteObject (hrgn)
		end

	set_clip_rectangle (rectangle: SB_RECTANGLE) is
			-- Set clip rectangle
		local
			t: INTEGER
			hrgn: POINTER
      do
         clip_x := rectangle.x.max (rect_x)
         clip_y := rectangle.y.max (rect_y)
         clip_w := (rectangle.x + rectangle.w).min (rect_x + rect_w) - clip_x
         clip_h := (rectangle.y + rectangle.h).min (rect_y + rect_h) - clip_y
         if clip_w < 0 then
            clip_w := 0
         end
         if clip_h < 0 then
            clip_h := 0
         end
         hrgn := wapi_rf.CreateRectRgn (clip_x, clip_y, clip_x + clip_w, clip_y + clip_h)
         t := wapi_clp.SelectClipRgn (context, hrgn)
         t := wapi_dcf.DeleteObject (hrgn)
      end

	clear_clip_rectangle is
			-- Clear clipping
		local
			t: INTEGER
			hrgn: POINTER
		do
	  		clip_x := rect_x
      		clip_y := rect_y
      		clip_w := rect_w
      		clip_h := rect_h
			hrgn := wapi_rf.CreateRectRgn (clip_x, clip_y, clip_x + clip_w, clip_y + clip_h)
			t := wapi_clp.SelectClipRgn (context, hrgn)
			t := wapi_dcf.DeleteObject (hrgn)
		end

  set_clip_mask (mask_: SB_BITMAP; dx, dy: INTEGER) is
         -- Set clip mask
      do
         mask := mask_
         cx := dx
         cy := dy
      end

   clear_clip_mask is
         -- Clear clip mask
      do
         mask := Void
         cx := 0
         cy := 0
      end

   set_font (fnt: SB_FONT) is
         -- Set font to draw text with
      local
         t: POINTER
      do
         t := wapi_dcf.SelectObject (context, fnt.resource_id)
         font := fnt
      end

   clip_children (yes: BOOLEAN) is
         -- Clip against child windows

      local
         dwFlags: INTEGER_32
         hPen,hBrush, hFont, t1: POINTER
         textcolor, backcolor: INTEGER
         fillmode: INTEGER
         t: INTEGER
      do
         dwFlags := (wapi_wf.GetWindowLong (surface.resource_id, wapi_gwl.GWL_STYLE))

         if yes then
            if (dwFlags & wapi_ws.WS_CLIPCHILDREN) = Zero then
               hPen := wapi_dcf.SelectObject(context,wapi_dcf.GetStockObject(wapi_so.NULL_PEN));
               hBrush := wapi_dcf.SelectObject(context,wapi_dcf.GetStockObject(wapi_so.NULL_BRUSH));
               hFont := wapi_dcf.SelectObject(context,wapi_dcf.GetStockObject(wapi_so.SYSTEM_FONT));
               textcolor := wapi_ff.GetTextColor(context);
               backcolor := wapi_pf.GetBkColor(context);
               fillmode := wapi_rf.GetPolyFillMode(context);

               t := wapi_dcf.ReleaseDC(surface.resource_id,context);
               t := wapi_wf.SetWindowLong(surface.resource_id,wapi_gwl.GWL_STYLE,(dwFlags | wapi_ws.WS_CLIPCHILDREN));
               context := wapi_dcf.GetDC(surface.resource_id);

               t1 := wapi_dcf.SelectObject(context,hFont);
               t1 := wapi_dcf.SelectObject(context,hPen);
               t1 := wapi_dcf.SelectObject(context,hBrush);

               if visual.hPalette /= default_pointer then
                  t1 := wapi_clr.SelectPalette(context,visual.hPalette,0);
                  t := wapi_clr.RealizePalette(context);
               end
               t := wapi_ff.SetTextAlign (context,wapi_ta.TA_BASELINE + wapi_ta.TA_LEFT);
               t := wapi_ff.SetTextColor (context, textcolor);
               t := wapi_pf.SetBkColor (context, backcolor);
               t := wapi_rf.SetPolyFillMode (context, fillmode);
            end
         else
            if (dwFlags & wapi_ws.WS_CLIPCHILDREN) /= Zero and then surface.resource_id /= wapi_wf.GetDesktopWindow then
               hPen := wapi_dcf.SelectObject (context, wapi_dcf.GetStockObject (wapi_so.NULL_PEN))
               hBrush := wapi_dcf.SelectObject (context, wapi_dcf.GetStockObject (wapi_so.NULL_BRUSH))
               hFont := wapi_dcf.SelectObject (context, wapi_dcf.GetStockObject (wapi_so.SYSTEM_FONT))
               textcolor := wapi_ff.GetTextColor (context)
               backcolor := wapi_pf.GetBkColor (context)
               fillmode := wapi_rf.GetPolyFillMode (context)

               t := wapi_dcf.ReleaseDC(surface.resource_id,context);
               t := wapi_wf.SetWindowLong (surface.resource_id,wapi_gwl.GWL_STYLE, (dwFlags & (wapi_ws.WS_CLIPCHILDREN).bit_not));
               context := wapi_dcf.GetDC (surface.resource_id);

               t1 := wapi_dcf.SelectObject (context, hFont)
               t1 := wapi_dcf.SelectObject (context, hPen)
               t1 := wapi_dcf.SelectObject (context, hBrush)

               if visual.hPalette /= default_pointer then
                  t1 := wapi_clr.SelectPalette (context, visual.hPalette, 0)
                  t := wapi_clr.RealizePalette (context)
               end
               t := wapi_ff.SetTextAlign (context,wapi_ta.TA_BASELINE + wapi_ta.TA_LEFT)
               t := wapi_ff.SetTextColor (context, textcolor)
               t := wapi_pf.SetBkColor (context, backcolor)
               t := wapi_rf.SetPolyFillMode (context, fillmode)
            end
         end
      end


feature -- Validation

   valid_dc: BOOLEAN is
      do
         Result := surface /= Void
      end

feature {NONE} -- Implementation

	once_logbrush: SB_WAPI_LOGBRUSH is
		do
			create Result.make
		end

   update_brush is
      local
         lb: SB_WAPI_LOGBRUSH
         t: INTEGER
      do
		 lb := once_logbrush
         inspect fill
         when Fill_solid then
            lb.set_style (wapi_bs.BS_SOLID)
            lb.set_color (devfg)
            lb.set_hatch (0)

         when Fill_tiled then
            lb.set_color(devfg)

         when Fill_stippled then
            if stipple /= Void then
               lb.set_style (wapi_bs.BS_PATTERN)
               lb.set_color (devfg)
               lb.set_hatch_pointer (stipple.resource_id)     -- This should be a HBITMAP
            elseif (pattern >= Stipple_0 and pattern <= Stipple_16) then
               lb.set_style (wapi_bs.BS_PATTERN)
               lb.set_color (devfg)
               lb.set_hatch_pointer (app.stipple (pattern))
            else
               lb.set_style (wapi_bs.BS_HATCHED)
               lb.set_color (devfg)
               -- lb.set_hatch (FXStipplePattern2Hatch(pattern)); todo
            end

         when Fill_opaque_stippled then
            if stipple /= Void then
               lb.set_style (wapi_bs.BS_PATTERN)
               lb.set_color (devfg)
               lb.set_hatch_pointer (stipple.resource_id)     -- This should be a HBITMAP
            elseif pattern >= Stipple_0 and pattern <= Stipple_16 then
               lb.set_style (wapi_bs.BS_PATTERN)
               lb.set_color (devfg)
               lb.set_hatch_pointer (app.stipple (pattern))
            else
               lb.set_style(wapi_bs.BS_HATCHED)
               lb.set_color(devfg)
               -- lb.lbHatch=FXStipplePattern2Hatch(pattern); todo
            end
         end
         t := wapi_dcf.DeleteObject (wapi_dcf.SelectObject (context, wapi_bf.CreateBrushIndirect (lb.ptr)))
         if fill = Fill_stippled then
            t := wapi_pf.SetBkMode (context, wapi_bm.TRANSPARENT) -- Alas, only works for BS_HATCHED...
         else
            t := wapi_pf.SetBkMode (context, wapi_bm.OPAQUE)
         end
         if fill /= Fill_solid then
            t := wapi_bf.SetBrushOrgEx (context, tx, ty, default_pointer)
         end
         needs_new_brush := False
      end

   update_pen is
      local
         lb: SB_WAPI_LOGBRUSH
         t,i: INTEGER
         dashes: ARRAY[INTEGER]
         penstyle: INTEGER_32
      do
		 lb := once_logbrush
         create dashes.make (0, 31)

         -- Setup brush of this pen
         inspect fill
         when Fill_solid then
            lb.set_style (wapi_bs.BS_SOLID)
            lb.set_color (devfg)
            lb.set_hatch (0)
         when Fill_tiled then
            check
               False
            end
         when Fill_stippled then
            if stipple /= Void then
               lb.set_style (wapi_bs.BS_PATTERN)
               lb.set_color (devfg)
               lb.set_hatch_pointer (stipple.resource_id)    -- This should be a HBITMAP
            elseif pattern >= Stipple_0 and then pattern <= Stipple_16 then
               lb.set_style (wapi_bs.BS_PATTERN)
               lb.set_color (devfg)
               lb.set_hatch_pointer (app.stipple (pattern))
            else
               lb.set_style (wapi_bs.BS_HATCHED)
               lb.set_color (devfg)
               --lb.set_hatch (FXStipplePattern2Hatch(pattern)); todo
            end
         when Fill_opaque_stippled then
            if stipple /= Void then
               lb.set_style (wapi_bs.BS_PATTERN)
               lb.set_color (devfg)
               lb.set_hatch_pointer (stipple.resource_id)    -- This should be a HBITMAP
            elseif pattern >= Stipple_0 and then pattern <= Stipple_16 then
               lb.set_style (wapi_bs.BS_PATTERN)
               lb.set_color (devfg)
               lb.set_hatch_pointer (app.stipple (pattern))
            else
               lb.set_style (wapi_bs.BS_HATCHED)
               lb.set_color (devfg)
               --lb.set_lbHatch(FXStipplePattern2Hatch (pattern)); todo
            end
         end

         penstyle := Zero

         	-- Cap style
         if cap = Cap_round then
            penstyle := penstyle | wapi_ps.PS_JOIN_ROUND;
         elseif cap = Cap_projecting then
            penstyle := penstyle | wapi_ps.PS_ENDCAP_SQUARE
         else
            penstyle := penstyle | wapi_ps.PS_ENDCAP_FLAT
         end
         	-- Join style
         if join = Join_miter then
            penstyle := penstyle | wapi_ps.PS_JOIN_MITER
         elseif join = Join_round then
            penstyle := penstyle | wapi_ps.PS_JOIN_ROUND
         else
            penstyle := penstyle | wapi_ps.PS_JOIN_BEVEL
         end

         penstyle := penstyle | wapi_ps.PS_GEOMETRIC

         	-- Line style
         if style = Line_solid then
            penstyle := penstyle | wapi_ps.PS_SOLID;
            t := wapi_dcf.DeleteObject (wapi_dcf.SelectObject (context, wapi_pnf.ExtCreatePen (penstyle, width, lb.ptr, 0, default_pointer)))
         elseif dashoff =0 and then dashlen = 2 and then dashpat.item (0) = 1 and then dashpat.item (1) = 1 then
            penstyle := penstyle | wapi_ps.PS_DOT
            t := wapi_dcf.DeleteObject (wapi_dcf.SelectObject (context, wapi_pnf.ExtCreatePen (penstyle, width, lb.ptr, 0, default_pointer)))
         elseif dashoff = 0 and then dashlen = 2 and then dashpat.item (0) = 3 and then dashpat.item (1) = 1 then
            penstyle := penstyle | wapi_ps.PS_DASH
            t := wapi_dcf.DeleteObject (wapi_dcf.SelectObject (context, wapi_pnf.ExtCreatePen (penstyle, width, lb.ptr, 0, default_pointer)))
         elseif dashoff = 0 and then dashlen = 4 and then dashpat.item (0) = 3 and then dashpat.item (1) = 1
            and then dashpat.item(2) = 1 and then dashpat.item(3) = 1 then
            penstyle := penstyle | wapi_ps.PS_DASHDOT
            t := wapi_dcf.DeleteObject (wapi_dcf.SelectObject (context, wapi_pnf.ExtCreatePen (penstyle, width, lb.ptr, 0, default_pointer)))
         elseif dashoff = 0 and then dashlen = 6 and then dashpat.item (0) = 3 and then dashpat.item (1) = 1
            and then dashpat.item (2) = 1 and then dashpat.item (3) = 1 and then dashpat.item (5) = 1 then
            penstyle := penstyle | wapi_ps.PS_DASHDOTDOT
            t := wapi_dcf.DeleteObject (wapi_dcf.SelectObject (context, wapi_pnf.ExtCreatePen (penstyle, width, lb.ptr, 0, default_pointer)))
         else
            penstyle := penstyle | wapi_ps.PS_USERSTYLE
            from
               i := 0
            until
               i >= dashlen
            loop
               dashes.put (dashpat.item ((i+dashoff) \\ dashlen), i)
               i := i + 1
            end
            mem.collection_off
            t := wapi_dcf.DeleteObject (wapi_dcf.SelectObject (context, wapi_pnf.ExtCreatePen (penstyle, width, lb.ptr, dashlen, dashes.area.base_address)))
            mem.collection_on
         end
         if fill = Fill_stippled then
            t := wapi_pf.SetBkMode (context, wapi_bm.TRANSPARENT)         -- Alas, only works for BS_HATCHED...
         else
            t := wapi_pf.SetBkMode (context, wapi_bm.OPAQUE)
         end
         if fill /= Fill_solid then
            t := wapi_bf.SetBrushOrgEx (context, tx, ty, default_pointer)
         end
         needs_path := width > 1
         needs_new_pen := False
      end

feature {NONE} -- SB_WAPI functions

   wapi_bf		: SB_WAPI_BRUSH_FUNCTIONS
   wapi_bm		: SB_WAPI_BACKGROUND_MODES
   wapi_bs		: SB_WAPI_BRUSH_STYLES
   wapi_clr		: SB_WAPI_COLOR_FUNCTIONS
   wapi_clp		: SB_WAPI_CLIPPING_FUNCTIONS
   wapi_dcf		: SB_WAPI_DEVICE_CONTEXT_FUNCTIONS
   fsh			: SB_WAPI_FILLED_SHAPE_FUNCTIONS
   wapi_fsh		: SB_WAPI_FILLED_SHAPE_FUNCTIONS
   wapi_ff		: SB_WAPI_FONT_AND_TEXT_FUNCTIONS
   wapi_rf		: SB_WAPI_REGION_FUNCTIONS
   wapi_gwl		: SB_WAPI_GWL_OFFSETS
   wapi_pf		: SB_WAPI_PAINTING_AND_DRAWING_FUNCTIONS
   wapi_pnf		: SB_WAPI_PEN_FUNCTIONS
   wapi_pfm		: SB_WAPI_POLYGON_FILLING_MODES
   wapi_ps		: SB_WAPI_PEN_STYLES
   wapi_r2		: SB_WAPI_BINARY_RASTER_OPS
   wapi_so		: SB_WAPI_STOCK_LOGICAL_OBJECTS
   wapi_ta		: SB_WAPI_TEXT_ALIGNMENT_OPTIONS
   wapi_wf		: SB_WAPI_WINDOW_FUNCTIONS
   wapi_ws		: SB_WAPI_WINDOW_STYLES
   wapi_wmc		: SB_WAPI_MACRO
   wapi_bmp		: SB_WAPI_BITMAP_FUNCTIONS
   wapi_ln		: SB_WAPI_LINE_AND_CURVE_FUNCTIONS
   wapi_path	: SB_WAPI_PATH_FUNCTIONS
   wapi_trast	: SB_WAPI_TERNARY_RASTER_OPERATIONS

end
