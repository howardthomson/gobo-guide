note

	description: "Interface to Xlib's Drawable resource"

	author: "Stephane Hillion"
	copyright: "Copyright (c) 1998-2006, Stephane Hillion and Howard Thomson"
	license: "GNU Public License (see COPYING)"

	todo: "[
		Fix C_VECTOR etc
	]"

class X_DRAWABLE

inherit 

	X_RESOURCE

	X_PORTABILITY_ROUTINES
	
feature {NONE} -- Initialization

	init(disp: X_DISPLAY; scr: INTEGER)
    	require
      		disp /= Void
      		scr  <  disp.screen_count
    	do
      		gc := disp.default_gc (scr)
    	end

feature -- Attributes

  	gc: X_GC	-- Graphic context to use on graphic operations.

  	set_gc (new_gc: X_GC)
      		-- Graphic context modification
    	require
      		new_gc /= Void
    	do
      		gc := new_gc
    	ensure
      		gc = new_gc
    	end

feature -- drawing

	draw_point (x, y: INTEGER)
      		-- uses the foreground pixel and function components of the GC
      		-- to draw a single point into the drawable.
    	do
      		x_draw_point (display.to_external, id, gc.to_external, x, y)
    	end

--	draw_points is	-- ###(tab: C_VECTOR [X_POINT]; coord_mode: INTEGER) is
--      		-- draws the points in the order listed in the array
--    	require
--      		tab /= Void
--    	do
--      		x_draw_points (display.to_external, id, gc.to_external, tab.to_external, 
--		     	tab.count, coord_mode)
--    	end

  	draw_line (x1, y1, x2, y2: INTEGER)
      		-- uses the components of the GC to draw a line 
      		-- between the specified set of points (x1, y1) and (x2, y2)
    	do
      		x_draw_line (display.to_external, id, gc.to_external, x1, y1, x2, y2)
    	end

--  	draw_lines is	--###(tab: C_VECTOR [X_POINT]; coord_mode: INTEGER) is
--      		-- uses the components of the GC to draw tab.count-1 lines 
--      		-- between each pair of points (tab@i, tab@(i+1)) in the array
--      		-- of X_POINT objects.
--    	require
--      		tab /= Void
--    	do
--      		x_draw_lines (display.to_external, id, gc.to_external, tab.to_external, 
--		    	tab.count, coord_mode)
--    	end

--	draw_segments is	--###(tab: C_VECTOR [X_SEGMENT]) is
--      		-- draws multiple, unconnected lines
--    	require
--      		tab /= Void
--    	do
--      		x_draw_segments (display.to_external, id, gc.to_external, 
--                       tab.to_external, tab.count)
--    	end

  	draw_arc (x, y, w, h, a1, a2: INTEGER)
      		-- draws a circular or elliptical arc
    	require
      		w > 0
      		h > 0
    	do
      		x_draw_arc (display.to_external, id, gc.to_external, x, y, w, h, a1, a2)
    	end

--  	draw_arcs is	--###(tab: C_VECTOR [X_ARC]) is
--      		-- draws multiple circular or elliptical arcs
--    	require
--      		tab /= Void
--    	do
--      		x_draw_arcs (display.to_external, id, gc.to_external, 
--                   tab.to_external, tab.count)
--   	 	end

  	fill_arc (x, y, w, h, a1, a2: INTEGER)
      		-- fills the region closed by the infinitely thin path described
      		-- by the specified arc and, depending on the arc-mode specified
      		-- in the GC, one or two line segments
    	require
      		w > 0
      		h > 0
    	do
      		x_fill_arc (display.to_external, id, gc.to_external, x, y, w, h, a1, a2)
    	end

--	fill_arcs is	--###(tab: C_VECTOR [X_ARC]) is
--      		-- fills multiple arcs
--    	require
--      		tab /= Void
--    	do
--      		x_fill_arcs (display.to_external, id, gc.to_external, 
--                   tab.to_external, tab.count)
--    	end

  	draw_rectangle (x, y, w, h: INTEGER)
      		--  draw the outlines of the specified rectangle
    	require
      		w > 0 and then h > 0
    	do
      		x_draw_rectangle (display.to_external, id, gc.to_external, x, y, w, h)
    	end

--  	draw_rectangles is	--###(tab: C_VECTOR [X_RECTANGLE]) is
--      		--  draw the outlines of the specified rectangles
--    	require
--      		tab /= Void
--    	do
--      		x_draw_rectangles (display.to_external, id, gc.to_external, 
--                         tab.to_external, tab.count)
--    	end

  	fill_rectangle (x, y, w, h: INTEGER)
      		-- fill the specified rectangle
    	require
      		w > 0
      		h > 0
    	do
      		x_fill_rectangle (display.to_external, id, gc.to_external, x, y, w, h)
    	end

--  	fill_rectangles is	--##(tab: C_VECTOR [X_RECTANGLE]) is
--      		-- fill the specified rectangles
--    	require
--      		tab /= Void
--    	do
--      		x_fill_rectangles (display.to_external, id, gc.to_external, 
--                         tab.to_external, tab.count)
--    	end

--  	fill_polygon is	--##(tab: C_VECTOR [X_POINT];
--			fill_mode: INTEGER; 
--			coord_mode: INTEGER) is
--      -- fills the region closed by the specified path.
--      -- The path is closed automatically if the last point in the 
--      -- list does not coincide with the first point.
--    	require
--      		tab /= Void
--    	do
--      		x_fill_polygon (display.to_external, id, gc.to_external,
--		      	tab.to_external, tab.count, fill_mode, coord_mode)
--    	end

  	draw_string (x, y: INTEGER; text: STRING)
      		-- Each character image, as defined by the font in the GC, is 
      		-- treated as an additional mask for a fill operation on the drawable
    	require
      		text /= Void
    	do
      		x_draw_string (display.to_external, id, gc.to_external, x, y, 
                     string_to_external(text), text.count)
    	end

  	draw_image_string (x, y: INTEGER; text: STRING)
      		-- fills a destination rectangle with the background pixel defined 
      		-- in the GC and then paints the text with the foreground pixel
    	require
      		text /= Void
    	do
      		x_draw_image_string (display.to_external, id, gc.to_external, x, y, 
                           string_to_external(text), text.count)
    	end

-- 	draw_text is	--##(x, y: INTEGER; tab: C_VECTOR [X_TEXT_ITEM]) is
--			-- allows complex spacing and font shifts between counted strings
--		require
--			tab /= Void
--		do
--			x_draw_text(display.to_external, id, gc.to_external, 
--				x, y, tab.to_external, tab.count)
--		end

feature -- copying

	copy_area (x, y: INTEGER; other: X_DRAWABLE; ox, oy, ow, oh: INTEGER)
      		-- combines the specified rectangle of `other' with
      		-- the specified rectangle of Current
    	require
      		ow > 0 and then oh > 0
    	do
      		x_copy_area (display.to_external, other.id, id, gc.to_external, 
                   ox, oy, ow, oh, x, y)
    	end

	copy_plane (x, y: INTEGER; other: X_DRAWABLE;
              ox, oy, ow, oh, plane_mask: INTEGER)
      		-- uses a single bit plane of the specified source rectangle 
      		-- combined with the specified GC to modify the specified 
      		-- rectangle of Current
    	require
      		ow > 0 and then oh > 0
    	do
      		x_copy_plane (display.to_external, other.id, id, gc.to_external, 
                    ox, oy, ow, oh, x, y, plane_mask)
    	end

  	put_image (x, y: INTEGER; im: X_IMAGE; ox, oy, ow, oh: INTEGER)
      		-- combines an image with a rectangle of the drawable
    	require
      		im /= Void
      		ow > 0 and then oh > 0
    	do
      		x_put_image (display.to_external, id, gc.to_external, im.to_external,
		   		ox, oy, x, y, ow, oh)
    	end

  	put_image_gc (x, y: INTEGER; im: X_IMAGE; a_gc: X_GC; ox, oy, ow, oh: INTEGER)
      		-- combines an image with a rectangle of the drawable
      		-- using a specified GC
    	require
      		im /= Void
      		ow > 0 and then oh > 0
    	do
      		x_put_image (display.to_external, id, a_gc.to_external, im.to_external,
		   		ox, oy, x, y, ow, oh)
    	end

end 
