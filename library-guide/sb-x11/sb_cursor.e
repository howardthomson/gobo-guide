-- X Window System Implementation

class SB_CURSOR

inherit
	SB_CURSOR_DEF
		rename
			resource_id as xid
		redefine
			xid
		end

	X_CURSOR_DEFINES

	X_H

create
	make_from_stock,
	make_from_bits,
	make_from_bitmap

feature

	xid: X_CURSOR

	stock: ARRAY [ INTEGER ]
		once
			create Result.make (1, 7)
			Result.put (XC_top_left_arrow,	  1)
			Result.put (XC_arrow,			  2)
			Result.put (XC_xterm,			  3)
			Result.put (XC_watch,			  4)
			Result.put (XC_crosshair,		  5)
			Result.put (XC_sb_h_double_arrow, 6)
			Result.put (XC_sb_v_double_arrow, 7)
			--	XC_fleur
		end

	create_resource
			-- Create cursor
		require else
			application.initialized or else fxerror("" + "SB_CURSOR" + "::create: trying to create cursor before opening display.%N")
		--	(glyph = 0 implies (source /= Void and then source.count /= 0) and (mask /= Void and then mask.count /= 0))
		--		or else fxerror("" + class_name + "::create_resources: source or mask bad")
		local
			srcpix,
			mskpix: X_PIXMAP
			color_0,
			color_1: X_COLOR	-- expanded classes
			display: X_DISPLAY
		do

			check -- should be part of require !! TODO: modify export status as needed
				(glyph = 0 implies (source /= Void and then source.count /= 0) and (mask /= Void and then mask.count /= 0))
				or else fxerror("" + class_name + "::create_resources: source or mask bad")
			end

			if xid = Void then

				if glyph = 0 then
					-- Building custom cursor

					-- Should have both source and mask

					display := application.display
					create color_0.make
					create color_1.make
					color_0.set_pixel (display.black_pixel(display.default_screen));
					color_1.set_pixel (display.white_pixel(display.default_screen));

					color_0.set_flags ( color_0.Do_red | color_0.Do_green | color_0.Do_blue);
					color_1.set_flags ( color_1.Do_red | color_1.Do_green | color_1.Do_blue);

					color_0.query_default_color(display)
					color_1.query_default_color(display)

					-- Create pixmaps for source and mask
				--	create srcpix.from_bits (display.default_root_window, array_to_external (source), width, height)
				--	create mskpix.from_bits (display.default_root_window, array_to_external (mask),   width, height)
					create srcpix.from_bits (display.default_root_window, source.area.item_address (0), width, height)
					create mskpix.from_bits (display.default_root_window, mask.area.item_address (0),   width, height)

					-- Create cursor
					create xid.from_pixmap (display, srcpix, mskpix, color_0, color_1, hot_x, hot_y)
				--#	if not xid then fx_error (<<class_name, "::create: unable to create cursor.%N"); end

					-- No longer needed
					srcpix.destroy	-- XFreePixmap
					mskpix.destroy	-- XFreePixmap

				else
					-- Building stock cursor
					check glyph <= stock.count
						or else fxerror ("" + class_name + "::create_resources -- Attempting to create unimplemented stock cursor") end
					create xid.make (application.display, stock @ glyph)
				end
			end
		end

	destroy_resource
		do
			xid.free
		end
end
