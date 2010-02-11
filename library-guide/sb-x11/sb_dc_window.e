-- X Window System Implementation

indexing
	description: "[
		Window Device Context The Window Device Context allows drawing
   		into an SB_DRAWABLE, such as an on-screen window (SB_WINDOW and derivatives)
		or an off-screen image (SB_IMAGE and its derivatives). Because certain hardware
		resources are locked down, only one SB_DC_WINDOW may be locked on a
		drawable at any one time.
	]"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"partly complete"
	platform:	"Xwin"

-- Debug version for GE, selectively disable X drawing calls

	todo: "[
		Complete 'stop' processing for reverting GC to default status for next usage.
		Various drawing primitives still to do.
		Implement remaining icon routines
		....
	]"

class SB_DC_WINDOW

inherit
	SB_DC_WINDOW_DEF
		redefine
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
         	draw_lines,
         	draw_lines_rel,
         	draw_point,
         	draw_points,
         	draw_points_rel,
         	draw_rectangle,
         	draw_rectangles,
         	draw_text_offset,
		--	fill_chord,
		--	fill_chords,
         	fill_arc,
         	fill_arcs,
         	fill_complex_polygon,
         	fill_complex_polygon_rel,
         	fill_concave_polygon,
         	fill_concave_polygon_rel,
         	fill_polygon,
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
		--	set_stipple_bitmap,
			set_font,
         	set_tile
		end

	SB_FLAGS

	SB_IMAGE_CONSTANTS

	X_GC_CONSTANTS

	X_H

	X11_EXTERNAL_ROUTINES

creation

	make_once, make, make_event

feature -- Attributes

	gc: X_GC

	devfg, devbg: INTEGER	-- device specific versions of foreground and background colours

feature -- Creation

    make_def is
        do
      		reset_flags
      	end

	make_event_def (drawable: SB_DRAWABLE; event: SB_EVENT) is
			-- Construct for painting in response to expose;
			-- This sets the clip rectangle to the exposed rectangle
		require else
			drawable /= Void
			event /= Void
      	do
--			fx_trace(0, <<"SB_DC_WINDOW::make_event_def">>)
      		reset_flags
			gc.set_clip_rectangle (0, 0, clip_x, clip_y, clip_w, clip_h)	-- This is faulty, at least for test app Scribble
			set_flags (Gc_clip_mask)
      	end

	reset_clip is
		do
			clip_x := 0
			clip_y := 0
			clip_w := 32767
			clip_h := 32767
		end

  start (drawable: SB_DRAWABLE) is
         -- Begin locks in a drawable surface
      require else
         drawable /= Void and then drawable.is_attached
      do
         set_surface (drawable)
         visual := drawable.visual
         rect_x := 0
         clip_x := 0
         rect_y := 0
         clip_y := 0
         rect_w := drawable.width
         rect_h := drawable.height
         clip_w := rect_w
         clip_h := rect_h
         devfg := -1
         devbg := 0
         gc := visual.gc
			-- TODO
      end

	gcv: X_GC_VALUES is
		once
			create Result.make
		end

	stop is
			-- End unlock the drawable surface
		do
--			fx_trace(0, <<"SB_DC_WINDOW::stop">>)
			-- TEMP ### See below
		--	unset_flags(Gc_stipple)
		--	unset_flags(Gc_font)
		--	unset_flags(Gc_clip_mask)
			
			if not default_flags then
				gcv.reset
				if test_flags (Gc_function) 			then gcv.set_function (Blt_src)					
						rop := Gx_copy																	end
				if test_flags (Gc_foreground)			then
						gcv.set_foreground (XBlackPixel (display.to_external, display.default_screen))	end
				if test_flags (Gc_background)			then
						gcv.set_background (XWhitePixel (display.to_external, display.default_screen))	end
				if test_flags (Gc_line_width)			then gcv.set_line_width (0)						end
				if test_flags (Gc_cap_style)				then gcv.set_cap_style (Cap_butt)			end
				if test_flags (Gc_join_style)			then gcv.set_join_style (Join_miter)			end
				if test_flags (Gc_line_style)			then gcv.set_line_style (Line_solid)			end
				if test_flags (Gc_fill_style)			then gcv.set_fill_style (Fill_solid)
						fill := Fill_solid																end
				if test_flags (Gc_stipple)				then gcv.set_stipple (app.stipples @ Stipple_white) end
				if test_flags (Gc_fill_rule)				then gcv.set_fill_rule (Even_odd_rule) 		end
--				if test_flags (Gc_font)					then gcv.set_font (app.get_normal_font) 		end

				if test_flags (Gc_clip_mask) then
					gcv.set_clip_mask_none
				--	gcv.set_clip_mask (Clip_none)
					reset_clip
					gc.set_clip_rectangle (0, 0, clip_x, clip_y, clip_w, clip_h)	-- This is faulty, at least for test app Scribble
				end

				if test_flags (Gc_clip_x_origin) 		then gcv.set_clip_x_origin (0)					end
				if test_flags (Gc_clip_y_origin) 		then gcv.set_clip_y_origin (0)					end
				if test_flags (Gc_dash_offset)			then gcv.set_dash_offset (0)					end
				if test_flags (Gc_dash_list)			then gcv.set_dashes (4)							end
				if test_flags (Gc_tile_stip_x_origin) 	then gcv.set_ts_x_origin (0)					end
				if test_flags (Gc_tile_stip_y_origin) 	then gcv.set_ts_y_origin (0)					end
				if test_flags (Gc_graphics_exposures)	then gcv.set_graphics_exposures (True) 			end
				if test_flags (Gc_subwindow_mode)		then gcv.set_subwindow_mode (Clip_by_children) 	end
				gc.change (gcv)
				reset_flags
			end -- if
			set_surface (Void)
      end

	display: X_DISPLAY
		-- display derived from surface

	xwin: X_WINDOW

	id: INTEGER
		-- X id of surface

	set_surface (new_surface: SB_DRAWABLE) is
			-- Assign to surface, and update derived attributes
		local
			ws: SB_WINDOW
		do
			surface := new_surface
			if surface /= Void then
				ws ?= surface
				check ws /= Void end
				xwin := ws.xwin
				display := xwin.display
				id := xwin.id
			else
				xwin := Void
				display := Void
				id := 0
			end
		end
		

	read_pixel (x, y: INTEGER): INTEGER is
		-- Read back pixel
		require else
			valid_surface: surface /= Void or else fxerror("FXDCWindow::readPixel: DC not connected to drawable.%N")
		local
			color: INTEGER
			--xim: X_IMAGE
		do
			if 0 <= x and 0 <= y and x < surface.width and y < surface.height then
    			-- XImage* xim=XGetImage(DISPLAY(getApp()),surface->id(),x,y,1,1,AllPlanes,ZPixmap);
    			-- if(xim && xim->data){
      			-- color=visual->getColor(XGetPixel(xim,0,0));
      			-- XDestroyImage(xim);
			end
			Result := color;
		end

   -- Draw points

	draw_point (x, y : INTEGER) is
      		-- uses the foreground pixel and function components of the GC
      		-- to draw a single point into the drawable.
    	do
      		x_draw_point (display.to_external, id, gc.to_external, x, y)
    	end

	draw_points (points: ARRAY [ SB_POINT ]) is
   		local
   			x_points: ARRAY [ INTEGER_16 ]
    	do
			x_points := to_x_points (points)
			x_draw_points(display.to_external, id, gc.to_external, x_points.area.item_address (0), points.count, CoordModeOrigin)
      	end

	draw_points_rel(points: ARRAY [ SB_POINT ]) is
		local
   			x_points: ARRAY [ INTEGER_16 ]
      	do
			x_points := to_x_points (points)
			x_draw_points (display.to_external, id, gc.to_external, x_points.area.item_address (0), points.count, CoordModePrevious)
      	end

   	-- Draw lines

  	draw_line (x1, y1, x2, y2 : INTEGER) is
      		-- uses the components of the GC to draw a line
      		-- between the specified set of points (x1, y1) and (x2, y2)
    	do
      		x_draw_line (display.to_external, id, gc.to_external, x1, y1, x2, y2)
    	end

   	draw_lines (points: ARRAY [ SB_POINT ]) is
   		local
   			x_points: ARRAY [ INTEGER_16 ]
      	do
			x_points := to_x_points(points)
			x_draw_lines(display.to_external, id, gc.to_external, x_points.area.item_address (0), points.count, CoordModeOrigin)
		end

	draw_lines_num (points: ARRAY [ SB_POINT ]; num: INTEGER) is
   		local
   			x_points: ARRAY [ INTEGER_16 ]
      	do
			x_points := to_x_points (points)
			x_draw_lines (display.to_external, id, gc.to_external, x_points.area.item_address (0), num, CoordModeOrigin)
		end
		

   	draw_lines_rel (points: ARRAY [ SB_POINT ]) is
   		local
   			x_points: ARRAY [ INTEGER_16 ]
      	do
			x_points := to_x_points (points)
			x_draw_lines (display.to_external, id, gc.to_external, x_points.area.item_address (0), points.count, CoordModePrevious)
      	end

	draw_line_segments(segments: ARRAY [ SB_SEGMENT ]) is
      	do
  			x_draw_segments (display.to_external, id, gc.to_external, segments.area.item_address (0), segments.count);
      	end

   -- Draw rectangles

   	draw_rectangle (x, y, w, h: INTEGER) is
      	do
  			x_draw_rectangle (display.to_external, id, gc.to_external, x, y, w, h)
      	end

   	draw_rectangles (rectangles: ARRAY [ SB_RECTANGLE ]) is
      	do
			x_draw_rectangles (display.to_external, id, gc.to_external, rectangles.area.item_address (0), rectangles.count)
      	end

   	-- Draw arcs
   	draw_arc(x, y, w, h, ang1, ang2: INTEGER) is
      	do
  			x_draw_arc(display.to_external, id, gc.to_external, x, y, w, h, ang1, ang2)
		ensure then
			implemented: false
      	end

   	draw_arcs (arcs: ARRAY [ SB_ARC ]) is
      	do
  			x_draw_arcs (display.to_external, id, gc.to_external, arcs.area.item_address (0), arcs.count)
      	end

	-- Filled rectangles

	fill_rectangle (x, y, w, h: INTEGER) is
   			--   require else
			-- surface /= Void
		do
		--	fx_trace(0, <<"SB_DC_WINDOW::fill_rectangle(", x.out, ", ", y.out, ", ", w.out, ", ", h.out, ")">>)
			x_fill_rectangle (display.to_external, id, gc.to_external, x, y, w, h)
      	end

	fill_rectangles (rectangles: ARRAY [ SB_RECTANGLE ]) is
			-- fill the specified rectangle
		do
			x_fill_rectangles(display.to_external, id, gc.to_external, rectangles.area.item_address (0), rectangles.count);
		end

-- fill_chord and fill_chords ???

-- Filled arcs
	fill_arc (x, y, w, h, ang1, ang2: INTEGER) is
		do
			x_fill_arc (display.to_external, id, gc.to_external, x, y, w, h, ang1, ang2);
		end

	fill_arcs (arcs: ARRAY [ SB_ARC ]) is
		do
			x_fill_arcs (display.to_external, id, gc.to_external, arcs.area.item_address (0), arcs.count);
      end

	to_x_points (points: ARRAY [ SB_POINT ]): ARRAY [ INTEGER_16 ] is
		local
			i, j: INTEGER
		do
			from
				create Result.make(0, 2 * points.count - 1)
				i := points.lower
			until
				i > points.upper
			loop
				Result.put ((points @ i).x, j)
				Result.put ((points @ i).y, j + 1)
				i := i + 1
				j := j + 2
			end
			check Result.count = (2 * points.count) end
		end

	fill_polygon (points: ARRAY [ SB_POINT ]) is
			-- Filled polygon
   		local
   			x_points: ARRAY [ INTEGER_16 ]
		do
			x_points := to_x_points (points)
			x_fill_polygon (display.to_external, id, gc.to_external, x_points.area.item_address (0), points.count, Convex, CoordModeOrigin);
		end

	fill_polygon_num (points: ARRAY [ SB_POINT ]; num: INTEGER) is
			-- Filled polygon
   		local
   			x_points: ARRAY [ INTEGER_16 ]
		do
			x_points := to_x_points(points)
			x_fill_polygon (display.to_external, id, gc.to_external, x_points.area.item_address (0), num, Convex, CoordModeOrigin);
		end

	fill_concave_polygon (points: ARRAY [ SB_POINT ]) is
   		local
   			x_points: ARRAY [ INTEGER_16 ]
		do
			x_points := to_x_points (points)
			x_fill_polygon (display.to_external, id, gc.to_external, x_points.area.item_address (0), points.count, Nonconvex, CoordModeOrigin);
		end

   fill_complex_polygon (points: ARRAY [ SB_POINT ]) is
   		local
   			x_points: ARRAY [ INTEGER_16 ]
		do
			x_points := to_x_points (points)
			x_fill_polygon (display.to_external, id, gc.to_external, x_points.area.item_address (0), points.count, Complex, CoordModeOrigin);
		end


	fill_polygon_rel (points: ARRAY [ SB_POINT ]) is
			-- Filled polygon with relative points
   		local
   			x_points: ARRAY [ INTEGER_16 ]
		do
			x_points := to_x_points (points)
			x_fill_polygon (display.to_external, id, gc.to_external, x_points.area.item_address (0), points.count, Convex, CoordModePrevious);
		end

	fill_concave_polygon_rel (points: ARRAY [ SB_POINT ]) is
   		local
   			x_points: ARRAY [ INTEGER_16 ]
		do
			x_points := to_x_points (points)
			x_fill_polygon (display.to_external, id, gc.to_external, x_points.area.item_address (0), points.count, Nonconvex, CoordModePrevious);
		end

   fill_complex_polygon_rel (points: ARRAY [ SB_POINT ]) is
   		local
   			x_points: ARRAY [ INTEGER_16 ]
      do
			x_points := to_x_points (points)
			x_fill_polygon (display.to_external, id, gc.to_external, x_points.area.item_address (0), points.count, Complex, CoordModePrevious);
		end

	draw_hash_box (x, y, w, h,b: INTEGER) is
			-- Draw hashed box
		require else
			surface /= Void or else fxerror("FXDCWindow::drawHashBox: DC not connected to drawable.")
		do
			gcv.reset
			gcv.set_stipple(get_app.stipples @ Stipple_gray)
			gcv.set_fill_style(Fill_stippled)
			gc.change(gcv)

			x_fill_rectangle(display.to_external, id, gc.to_external, x, y, w-b, b)
			x_fill_rectangle(display.to_external, id, gc.to_external, x+w-b, y, b, h-b)
			x_fill_rectangle(display.to_external, id, gc.to_external, x+b, y+h-b, w-b, b)
			x_fill_rectangle(display.to_external, id, gc.to_external, x, y+b, b, h-b)

			gcv.reset
			gcv.set_stipple (get_app.stipples @ Stipple_white)
			gcv.set_fill_style (fill)
			gc.change (gcv)
		end

	draw_focus_rectangle (x, y, w, h: INTEGER) is
         	-- Draw focus rectangle
    	do
    		gcv.reset
			gcv.set_stipple (get_app.stipples @ Stipple_gray)
			gcv.set_fill_style (Fill_stippled)
			gcv.set_background (0)
			gcv.set_foreground (0xffffffff)
			gcv.set_function (Blt_src_xor_dst)
			gcv.set_ts_x_origin (x)
			gcv.set_ts_y_origin (y)
			gc.change (gcv)
			
			x_fill_rectangle(display.to_external, id, gc.to_external, x, y, w-1, 1);
			x_fill_rectangle(display.to_external, id, gc.to_external, x+w-1, y, 1, h-1);
			x_fill_rectangle(display.to_external, id, gc.to_external, x+1, y+h-1, w-1, 1);
			x_fill_rectangle(display.to_external, id, gc.to_external, x, y+1, 1, h-1);

			gcv.reset
			gcv.set_stipple (get_app.stipples @ Stipple_white)
			gcv.set_fill_style (fill)
			gcv.set_background (devbg)
			gcv.set_foreground (devfg)
			gcv.set_function (rop)
			gcv.set_ts_x_origin (tx)
			gcv.set_ts_y_origin (ty)
			gc.change (gcv)
      	end

   	draw_area (source: SB_DRAWABLE; sx, sy, sw, sh, dx, dy: INTEGER) is
         	-- Draw area from source
      	do
      		todo("SB_DC_WINDOW::draw_area")
  		--	x_copy_area(display.to_external, source.xwin.id, id, gc.to_external, sx, sy, sw, sh, dx, dy);
		ensure then
			implemented: false
		end

	draw_image (image: SB_IMAGE; dx, dy: INTEGER) is
         	-- Draw image
      	do
      		todo("SB_DC_WINDOW::draw_image")
  		--	XCopyArea(display.to_external, image.id, id, gc.to_external, 0,0, image.width, image.height, dx, dy);
		ensure then
			implemented: false
		end

	draw_bitmap (bitmap: SB_BITMAP; dx, dy: INTEGER) is
			-- Draw bitmap
		do
			todo("SB_DC_WINDOW::draw_bitmap")
		--	x_copy_plane (display.to_external, bitmap.id, id, gc.to_external, 0,0, bitmap.width, bitmap.height, dx, dy, 1)
		ensure then
			implemented: false
		end

		xx, yy, ww, hh: INTEGER

	intersect (px, py, pw, ph, qx, qy, qw, qh: INTEGER) is
			-- Intersection between rectangles
		do
			xx := px.max (qx)
			yy := py.max (qy)
			ww := (px + pw).min (qx + qw) - xx
			hh := (py + ph).min (qy + qh) - yy
   		end

	draw_icon (icon: SB_ICON; dx, dy: INTEGER) is
			-- Draw icon on surface
   		require else
   			valid_icon: icon /= Void
		do
			intersect (clip_x, clip_y, clip_w, clip_h, dx, dy, icon.width, icon.height)
  			if ww > 0 and then hh > 0 then
    			if icon.is_opaque then
      				x_copy_area (display.to_external, icon.resource_id.id, id, gc.to_external, xx - dx.to_integer_16, yy - dy.to_integer_16, ww, hh, xx, yy)
    			else
    				gcv.reset
    				check icon.shape.id /= 0 end
      			--	gcv.set_clip_mask (icon.shape)
      				gcv.set_clip_x_origin (dx)
      				gcv.set_clip_y_origin (dy)
					gc.change (gcv)
      				x_copy_area (display.to_external, icon.resource_id.id, id, gc.to_external, xx - dx.to_integer_16, yy - dy.to_integer_16, ww, hh, xx, yy);
					gc.set_clip_rectangle (0, 0, clip_x, clip_y, clip_w, clip_h)
      				flags := flags | Gc_clip_mask
				end
    		end
		end

	draw_icon_shaded (icon: SB_ICON; dx, dy: INTEGER) is
		require else
			surface /= Void or else fxerror("FXDCWindow::drawIconShaded: DC not connected to drawable.")
		--	(icon /= Void and then icon.id /= 0 and then icon.shape /= 0)
		--		or else fxerror("FXDCWindow::drawIconShaded: illegal icon specified.")
    	do
			intersect (clip_x, clip_y, clip_w, clip_h, dx, dy, icon.width, icon.height)
		  	if ww > 0 and then hh > 0 then
		  		gcv.reset
				gcv.set_clip_mask (icon.shape)
		    	gcv.set_clip_x_origin (dx)
		    	gcv.set_clip_y_origin (dy)
				gc.change (gcv)

				x_copy_area (display.to_external, icon.resource_id.id, id, gc.to_external, xx - dx, yy - dy, ww, hh, xx, yy)

		  		gcv.reset
		    	gcv.set_function (Blt_src)
		    	gcv.set_stipple ((app.stipples) @ Stipple_gray)
		    	gcv.set_fill_style (Fill_stippled)
		    	gcv.set_ts_x_origin (dx)
		    	gcv.set_ts_y_origin (dy)
		    	gcv.set_foreground (visual.pixel (app.sel_back_color))
				gc.change (gcv)
		    	x_fill_rectangle (display.to_external, id, gc.to_external, xx, yy, ww, hh)

		  		gcv.reset
		    	gcv.set_function (rop)
		    	gcv.set_fill_style (fill)
		    	gcv.set_ts_x_origin (tx)
		    	gcv.set_ts_y_origin (ty)
				gc.change (gcv)

				gc.set_clip_rectangle (0, 0, clip_x, clip_y, clip_w, clip_h)
		    	flags := flags | Gc_clip_mask;
			end
		end

--	draw_icon_sunken(icon: SB_ICON; dx, dy: INTEGER) is do end

	draw_icon_sunken(icon: SB_ICON; dx, dy: INTEGER) is
  		local
  			base: INTEGER	--SB_COLOR
  			clr: INTEGER	--SB_COLOR
		do
			gcv.reset
			base := app.base_color;
			clr := sbrgb((85*sbredval(base)) // 100, (85*sbgreenval(base)) // 100, (85*sbblueval(base)) // 100);

				-- Erase to black
			gcv.set_background(0);
			gcv.set_foreground(-1);
			gcv.set_function(Blt_not_src_and_dst);
			gc.change(gcv)
			x_copy_plane(display.to_external, icon.etch.id, id, gc.to_external, 0, 0, icon.width, icon.height, dx + 1, dy + 1, 1);

				-- Paint highlight part
			gcv.set_function(Blt_src_or_dst);
			gcv.set_foreground(visual.pixel(app.hilite_color));
			gc.change(gcv)
			x_copy_plane(display.to_external, icon.etch.id, id, gc.to_external, 0, 0, icon.width, icon.height, dx + 1, dy + 1, 1);

				-- Erase to black
			gcv.set_foreground(-1);
			gcv.set_function(Blt_not_src_and_dst);
			gc.change(gcv)
			x_copy_plane(display.to_external, icon.etch.id, id, gc.to_external, 0, 0, icon.width, icon.height, dx, dy, 1);

				-- Paint shadow part
			gcv.set_function(Blt_src_or_dst);
			gcv.set_foreground(visual.pixel(clr));
			gc.change(gcv)
			x_copy_plane(display.to_external, icon.etch.id, id, gc.to_external, 0, 0, icon.width, icon.height, dx, dy, 1);

				-- Restore stuff
			gcv.set_foreground (devfg)
			gcv.set_background (devbg)
			gcv.set_function (rop)
			gc.change(gcv)
		end


	-- Draw string

	draw_text_offset (x, y: INTEGER; string: STRING; strt,length: INTEGER) is
			-- Draw text, at x,y, index from strt to (strt+length-1)
		do
			x_draw_string (display.to_external, id, gc.to_external, x,y, string_to_external(string) + (strt - 1), length)
		end

   	draw_image_text_offset (x, y: INTEGER; string: STRING; strt, length: INTEGER) is
      	do
  			x_draw_image_string (display.to_external, id, gc.to_external, x,y, string_to_external(string) + (strt - 1), length)
      	end

	set_foreground (clr: INTEGER) is
    		-- Set foreground drawing color
    	do
			devfg := visual.pixel (clr)
			gc.set_foreground (devfg)
			flags := flags | Gc_foreground
			fg := clr
      	end

	set_background(clr: INTEGER) is
			-- Set background drawing color
		do
  			devbg := visual.pixel (clr)
  			gc.set_background (devbg)
  			flags := flags | Gc_background
  			bg := clr
      	end

	set_dashes (dashoffset: INTEGER; dashpattern: ARRAY [ INTEGER ]) is
			-- Set dash pattern
		local
			array_8: ARRAY [ INTEGER_8 ]
		do
			Precursor(dashoffset, dashpattern)
			array_8 := to_integer_8(dashpat)
			gc.set_dashes(dashoff, array_8)
			flags := flags | Gc_dash_list | Gc_dash_offset	
		end

	to_integer_8 (an_array: ARRAY [ INTEGER ]): ARRAY [ INTEGER_8 ] is
		require
			not_void: an_array /= Void
			nonzero_count: an_array.count > 0
		local
			i: INTEGER
			c: INTEGER
		do
			c := an_array.count
			create Result.make (1, c)
			from
				i := 1
			until
				i > c
			loop
				Result.put ((an_array.item (i)).to_integer_8, i)	-- ### Note possible overflow: use SB_COMMON_MACROS ?
				i := i + 1
			end
		end

	set_line_width (linewidth: INTEGER) is
			-- Set line width
		do
			gcv.reset
			gcv.set_line_width (linewidth)
			gc.change (gcv)
			flags := flags | Gc_line_width
			width := linewidth
		end

	set_line_cap (capstyle: INTEGER) is
			-- Set line cap style
		do
			gcv.reset
			gcv.set_cap_style (capstyle)
			gc.change (gcv)
			flags := flags |  Gc_cap_style
			cap := capstyle
		end

	set_line_join (joinstyle: INTEGER) is
			-- Set line join style
		do
			gcv.reset
			gcv.set_join_style (joinstyle)
			gc.change (gcv)
			flags := flags | Gc_join_style
			join := joinstyle
		end

	set_line_style (linestyle: INTEGER) is
			-- Set line style
		do
			todo("SB_DC_WINDOW::set_line_style")
			gcv.reset
			gcv.set_line_style (linestyle)
			gc.change (gcv)
			flags := flags | Gc_line_style
			style := linestyle
		end

	set_fill_style(fillstyle: INTEGER) is
			-- Set fill style
		do
			XSetFillStyle (display.to_external, gc.to_external, fillstyle);
			flags := flags | Gc_fill_style;
			fill := fillstyle;
		end

	set_fill_rule (fillrule: INTEGER) is
			-- Set fill rule
		do
			todo("SB_DC_WINDOW::set_fill_rule")
		end

	set_function(func: INTEGER) is
			-- Set blit function
		do
			XSetFunction (display.to_external, gc.to_external, func)
			flags := flags | Gc_function
			rop := func
		end

	set_tile(image: SB_IMAGE; dx, dy: INTEGER) is
			-- Set the tile
		do
     		todo("SB_DC_WINDOW::set_tile")

     		gcv.reset
			gcv.set_tile (image.resource_id)
			gcv.set_ts_x_origin (dx)
			gcv.set_ts_y_origin (dy)
			gc.change (gcv)

			if dx /= 0 then flags := flags | Gc_tile_stip_x_origin end
			if dy /= 0 then flags := flags | Gc_tile_stip_y_origin end
			tile := image
			tx := dx
			ty := dy
		end

	set_stipple (bitmap: SB_BITMAP; dx, dy: INTEGER) is
			-- Set the stipple pattern
		require
			surface /= Void or else fxerror("FXDCWindow::setStipple: DC not connected to drawable.")
			(bitmap /= Void and then bitmap.xid /= 0) or else fxerror("FXDCWindow::setStipple: illegal image specified.")
		do

			gcv.reset
		--	gcv.set_stipple (bitmap.xid)
			gcv.set_ts_x_origin (dx)
			gcv.set_ts_y_origin (dy)
			gc.change (gcv)
			if dx /= 0 then flags := flags | Gc_tile_stip_x_origin end
			if dy /= 0 then flags := flags | Gc_tile_stip_y_origin end
			flags := flags | Gc_stipple
			stipple := bitmap
			pattern := Stipple_none
			tx := dx
			ty := dy
		ensure f: false
		end

	set_stipple_pattern (a_pat: INTEGER; dx, dy: INTEGER) is
			-- Set the stipple pattern
		require else
			surface /= Void or else fxerror("FXDCWindow::setStipple: DC not connected to drawable.")
		local
			pat: INTEGER
		do
			pat := a_pat
			if pat > Stipple_crossdiag then
				pat := Stipple_crossdiag
			end
			check surface.application.stipples @ pat /= Void end

			gcv.reset
			gcv.set_stipple (surface.application.stipples @ pat)
			gcv.set_ts_x_origin (dx)
			gcv.set_ts_y_origin (dy)
			gc.change (gcv)
			if dx /= 0 then flags := flags | Gc_tile_stip_x_origin end
			if dy /= 0 then flags := flags | Gc_tile_stip_y_origin end
			stipple := Void
			pattern := pat
			flags := flags | Gc_stipple
			tx := dx
			ty := dy
		end

	set_clip_region (region: SB_REGION) is
    		-- Set clip region
    	require else
			surface /= Void or else fxerror("FXDCWindow::setClipRegion: DC not connected to drawable.")
      	do
      		todo("SB_DC_WINDOW::set_clip_region")

		--	XSetRegion(display.to_external, (GC)ctx, (Region)region.region);	-- Should intersect region and rect??
			flags := flags | Gc_clip_mask;
      	end

	set_clip_rectangle_coords (x, y, w, h: INTEGER) is
			-- Set clip rectangle
      	require else
			surface /= Void or else fxerror("FXDCWindow::setClipRectangle: DC not connected to drawable.")
		do
			clip_x := x.max (rect_x)
			clip_y := y.max (rect_y)
			clip_w := (x + w).min (rect_x + rect_w) - clip_x
			clip_h := (y + h).min (rect_y + rect_h) - clip_y
			
			if clip_w <= 0 then clip_w := 0 end
			if clip_h <= 0 then clip_h := 0 end
			
			gc.set_clip_rectangle (0, 0, clip_x, clip_y, clip_w, clip_h)
			flags := flags | Gc_clip_mask
      	end

	set_clip_rectangle (a_rect: SB_RECTANGLE) is
    		-- Set clip rectangle
    	do
      		gc.set_clip_rectangle (0, 0, a_rect.x, a_rect.y, a_rect.w, a_rect.h)
			flags := flags | Gc_clip_mask
		end

	clear_clip_rectangle is
         	-- Clear clipping
      	do
      		clip_x := rect_x
      		clip_y := rect_y
      		clip_w := rect_w
      		clip_h := rect_h
			gc.set_clip_rectangle (0, 0, clip_x, clip_y, clip_w, clip_h)
			flags := flags | Gc_clip_mask
      	end

	set_clip_mask(a_mask: SB_BITMAP; dx, dy: INTEGER) is
			-- Set clip mask
		do
      		todo ("SB_DC_WINDOW::set_clip_mask")
      	end

	clear_clip_mask is
    		-- Clear clip mask
    	do
      		todo ("SB_DC_WINDOW::clear_clip_mask")
    	end

	set_font (fnt: SB_FONT) is
		require else
			fnt /= Void and then fnt.is_attached
		--	surface /= Void
		do
			x_set_font (display.to_external, gc.to_external, fnt.xfont.id)
			flags := flags | Gc_font
			font := fnt
		end

	clip_children(yes: BOOLEAN) is
    		-- Clip against child windows
		require else
			surface /= Void or else fxerror("FXDCWindow::clipChildren: window has not yet been created.")
		do
  			if yes then
				gc.set_subwindow_mode (Clip_by_children)
    			unset_flags (Gc_subwindow_mode)
  			else
				gc.set_subwindow_mode (Include_inferiors)
    			flags := flags | Gc_subwindow_mode
    		end
      	end
invariant

	X_Fill_solid_is_0: Fill_solid = 0	-- TEMP to check for SE compiler bug

end
