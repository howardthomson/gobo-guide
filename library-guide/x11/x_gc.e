indexing

	description: "Interface to Xlib's GC"

	author: "Stephane Hillion"
	copyright: "Copyright (c) 1998-2006, Stephane Hillion and Howard Thomson"
	license: "GNU Public License (see COPYING)"

	todo: "[
		Remove BOOLEAN from set_graphics_exposures
	]"

class X_GC

inherit

	X_GLOBAL

	X_GC_CONSTANTS

create

	make,
--	make_drawable,
	from_pixmap,
	from_external

feature { NONE } -- Creation

	make (owner: X_DRAWABLE_WINDOW; mask: INTEGER; values: X_GC_VALUES) is
    		-- Creates a graphics context.
    	require
      		owner  /= Void
      		values /= Void
    	do
      		display     := owner.display
      		screen      := owner.screen
      		to_external := x_create_gc (display.to_external,
							    		   owner.id, mask, values.to_external)
    end

	from_pixmap (owner: X_PIXMAP; scr: INTEGER; mask: INTEGER; values: X_GC_VALUES) is
			-- Creates a graphics context.
    	require
      		owner_not_void: owner /= Void
      		gc_values_not_void: values /= Void
    	do
      		display := owner.display
      		screen := scr
      		to_external := x_create_gc (display.to_external, owner.id, mask, values.to_external)
    	end

  	from_external (disp: X_DISPLAY; scr: INTEGER; xgc: POINTER) is
      		-- Encapsulate an external GC in an X_GC instance.
    	require
      		disp /= Void
      		xgc  /= default_pointer
    	do
      		display     := disp
      		screen      := scr
      		to_external := xgc	-- FIXGC
    	end

feature -- destruction

  	free is
      		-- destroys the specified GC as well as all the associated storage
    	require
      		to_external /= default_pointer
    	do
      		x_free_gc (display.to_external, to_external)
      		to_external := default_pointer
    	end

feature

  	display: X_DISPLAY
      	-- The display

  	to_external: POINTER
      	-- The external representation of the GC

  	screen: INTEGER
      	-- The screen number

    gcv_private: X_GC_VALUES

  	get_values (mask: INTEGER): X_GC_VALUES is
      		-- returns the components specified by valuemask for the GC
    	require
      		to_external /= default_pointer
    	do
      		create Result.make
      		x_get_gc_values (display.to_external, to_external, 
		       mask, Result.to_external)
    	end

	change (values: X_GC_VALUES) is
			-- changes the components specified by valuemask for the GC
		require
			to_external /= default_pointer
			values      /= Void
		do
			values.trace
			x_change_gc (display.to_external, to_external,
		   		values.flags, values.to_external)
		end

  	set_font (f: X_FONT) is
      		-- sets the current font in the GC
    	require
      		to_external /= default_pointer
      		f      /= Void
      		f.display.is_equal (display)
    	do
      		x_set_font (display.to_external, to_external, f.id)
    	end

  	set_background (pix: INTEGER) is
      		-- sets the current background pixel in the GC
    	require
      		to_external /= default_pointer
    	do
			x_set_background (display.to_external, to_external, pix)
	end

	set_foreground (pix: INTEGER) is
			-- sets the current foreground pixel in the GC
		require
			to_external /= default_pointer
		do
			x_set_foreground (display.to_external, to_external, pix)
		end

	set_function (f: INTEGER) is
			-- sets a specified drawing function value in the GC
		require
			to_external /= default_pointer
		do
			x_set_function (display.to_external, to_external, f)
		end

	set_line_attributes (width, line, cap, joint: INTEGER) is
			-- sets the line drawing components in the GC
		require
			to_external /= default_pointer
		do
			x_set_line_attributes (display.to_external, to_external,
			     width, line, cap, joint)
		end

  	set_arc_mode (mode: INTEGER) is
      		-- sets the arc mode value in the GC
    	require
      		to_external /= default_pointer
    	do
      		x_set_arc_mode (display.to_external, to_external, mode)
    	end

  	set_fill_rule (rule: INTEGER) is
      		-- sets the fill rule value in the GC
    	require
      		to_external /= default_pointer
    	do
      		x_set_fill_rule (display.to_external, to_external, rule)
    	end

  	set_fill_style (style: INTEGER) is
      		-- sets the fill style value in the GC
    	require
      		to_external /= default_pointer
    	do
      		x_set_fill_style (display.to_external, to_external, style)
    	end

	set_dashes (origin: INTEGER; tab: ARRAY [ INTEGER_8 ]) is
			-- sets the dash-offset and dash-list attributes for dashed line
			-- styles in the GC
    	require
			to_external /= default_pointer
			tab /= Void
    	do
			x_set_dashes (display.to_external, to_external, 
				origin, array_to_external (tab), tab.count)
		end

  	set_stipple (pix: X_PIXMAP) is
      		-- sets the stipple in the GC
    	require
      		to_external /= default_pointer
      		pix /= Void
    	do
      		x_set_stipple (display.to_external, to_external, pix.id)
    	end

  	set_tile (pix: X_PIXMAP) is
      		-- sets the fill tile in the GC
    	require
      		to_external /= default_pointer
      		pix /= Void
    	do
      		x_set_tile (display.to_external, to_external, pix.id)
    	end

  	set_ts_origin (x, y: INTEGER) is
      		-- sets the tile/stipple origin in the GC
    	do
      		x_set_ts_origin (display.to_external, to_external, x, y)
    	end

  	set_clip_mask (pix: X_PIXMAP) is
      		-- sets the clip mask in the GC
    	require
      		to_external /= default_pointer
      		pix /= Void
    	do
      		x_set_clip_mask (display.to_external, to_external, pix.id)
    	end

  	set_clip_origin (x, y: INTEGER) is
      		-- sets the clip origin in the GC
    	do
      		x_set_clip_origin (display.to_external, to_external, x, y)
    	end

--	set_clip_rectangle (x, y: INTEGER; c_ptr: POINTER) is
--			-- changes the clip-mask in the GC to the specified
--			-- rectangle and sets the clip origin
--		require
--			ptr_not_null: c_ptr /= default_pointer
--		do
--			x_set_clip_rectangles (display.to_external, to_external, 
--				x, y, c_ptr, 1, Unsorted)
--		end

	p_xywh_once: ARRAY [ INTEGER_16 ] is
		once
			create Result.make (1, 4)
		end

	p_xywh (a_x, a_y, a_w, a_h: INTEGER): POINTER is
			-- Return the address of a set of contiguous
			-- INTEGER_16s with the sequence x,y,w,h
		local
			pa: ARRAY [ INTEGER_16 ]
		do
			pa := p_xywh_once
			pa.put (a_x.to_integer_16, 1)
			pa.put (a_y.to_integer_16, 2)
			pa.put (a_w.to_integer_16, 3)
			pa.put (a_h.to_integer_16, 4)
			Result := pa.area.base_address
		end
			
	set_clip_rectangle (x, y: INTEGER; cx, cy, cw, ch: INTEGER) is
			-- changes the clip-mask in the GC to the specified
			-- rectangle and sets the clip origin
		local
			p: POINTER
		do
			p := p_xywh (cx, cy, cw, ch)
			x_set_clip_rectangles (display.to_external, to_external, x, y, p, 1, Unsorted)
		end

  	set_subwindow_mode (mode: INTEGER) is
      		-- sets the subwindow mode in the GC
    	do
      		x_set_subwindow_mode(display.to_external, to_external, mode)
    	end

  	set_graphics_exposures (set: BOOLEAN) is
      		-- sets the graphics-exposures flag in the GC 
    	do
      		x_set_graphics_exposures (display.to_external, to_external, set)
    	end

end 
