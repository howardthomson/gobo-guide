note
   description: "Progress bar widget"
   author: "Eugene Melekhov <eugene_melekhov@mail.ru>"
   copyright: "Copyright (c) 2002, Eugene Melekhov and others"
   license: "Eiffel Forum Freeware License v2 (see forum.txt)"
   status: "Mostly complete"

class SB_PROGRESS_BAR

inherit

   SB_FRAME
      rename
         make as frame_make,
         make_opts as frame_make_opts
      redefine
         default_width,
         default_height,
         handle_2,
         on_paint,
         create_resource,
         detach_resource
      end

   SB_PROGRESS_BAR_CONSTANTS

create

	make,
	make_opts,
	make_ev

feature -- Creation

   make (p: SB_COMPOSITE; opts: INTEGER)
         -- Construct progress bar
      local
         o: INTEGER
      do
         if opts = ZERO then
            o := PROGRESSBAR_NORMAL
         else
            o := opts
         end
         make_opts (p, Void, 0, o, 0, 0, 0, 0,
                   DEFAULT_PAD, DEFAULT_PAD, DEFAULT_PAD, DEFAULT_PAD);
      end

   make_opts (p: SB_COMPOSITE;tgt: SB_MESSAGE_HANDLER; selector: INTEGER; opts: INTEGER;
             x, y, w, h, pl, pr, pt, pb: INTEGER)
         -- Construct progress bar
      do
         frame_make_opts (p, opts, x, y, w, h, pl, pr, pt, pb)
         message_target := tgt
         message := selector
         progress := 0
         total := 100
         if (opts & PROGRESSBAR_DIAL) /= ZERO then
            bar_bg_color := application.back_color
            text_color := SBRGB (0, 0, 255)
            bar_size := 60
         else
            bar_bg_color := application.back_color
            text_color := SBRGB (0, 0, 255)
            bar_size := 5
         end

         font := application.normal_font
         bar_color := SBRGB (0, 0, 255)
         text_alt_color := SBRGB (255, 255, 255)
         back_color := bar_bg_color
      end

feature -- data

   progress: INTEGER
         -- Integer percentage number

   total: INTEGER
         -- Amount for completion

   bar_size: INTEGER;
         -- Bar size

   font: SB_FONT

   bar_bg_color: INTEGER;

   bar_color: INTEGER;

   text_color: INTEGER;

   text_alt_color: INTEGER

feature -- Queries

	default_width: INTEGER
			-- Return default width
		local
			w, t: INTEGER
		do
			w := 1
			if (options & PROGRESSBAR_VERTICAL) /= ZERO or else (options & PROGRESSBAR_DIAL) /= ZERO then
				w := bar_size
				if(options & PROGRESSBAR_PERCENTAGE) /= ZERO then
					t := font.get_text_width ("100%%")
					if w < t then w := t end
				end
			end
			Result := w + pad_left + pad_right + (border * 2)
		end

	default_height: INTEGER
			-- Return default height
		local
			h, t: INTEGER
		do
			h := 1
			if (options & PROGRESSBAR_VERTICAL) = ZERO or else (options & PROGRESSBAR_DIAL) = ZERO then
				h := bar_size
				if (options & PROGRESSBAR_PERCENTAGE) /= ZERO then
					t := font.get_font_height
					if h < t then h := t end
				end
			end
			Result := h + pad_top + pad_bottom + (border * 2)
		end

	get_bar_style: INTEGER
			-- Return current progress bar style
		do
			Result := (options and PROGRESSBAR_MASK)
		end

feature -- Actions

	set_vertical
		do
			set_bar_style (options | PROGRESSBAR_VERTICAL)
		end

	set_horizontal
		do
			set_bar_style (options & (PROGRESSBAR_VERTICAL).bit_not)
		end
	
	set_progress (value_: INTEGER)
			-- Change the amount of progress
		local
			value: INTEGER
			dc: SB_DC_WINDOW
		do
			if value_>total then value := total else value := value_ end
			if value /= progress then
				progress := value
				if is_attached then
					dc := paint_dc
					dc.make (Current)
					draw_interior (dc)
					dc.stop
				end
				application.flush
			end
		end

   set_total (value: INTEGER)
         -- Set total amount of progress
      local
         dc: SB_DC_WINDOW
      do
         if value /= total then
            total := value
            if is_attached then
            	dc := paint_dc
               dc.make (Current)
               draw_interior (dc)
               dc.stop
            end
            application.flush
         end
      end

   increment (value: INTEGER)
         -- Increment progress by given amount
      do
         set_progress (progress + value)
      end

   hide_number
         -- Hide progress percentage
      do
         if (options & PROGRESSBAR_PERCENTAGE) /= ZERO then
            options := options & (PROGRESSBAR_PERCENTAGE).bit_not
            recalc
            update
         end
      end

   show_number
         -- Show progress percentage
      do
         if (options & PROGRESSBAR_PERCENTAGE) = ZERO then
            options := options or PROGRESSBAR_PERCENTAGE;
            recalc
            update
         end
      end

   set_bar_size (size: INTEGER)
         -- Change progress bar width
      require
         size > 0
      do
         if bar_size /= size then
            bar_size := size
            recalc
            update
         end
      end


  set_bar_bg_color (clr: INTEGER)
         -- Change background color
      do
         if bar_bg_color /= clr then
            bar_bg_color := clr
            update_rectangle (border, border, width - (border * 2), height - (border * 2))
         end
      end

   set_bar_color (clr: INTEGER)
         -- Change bar color
      do
         if bar_color /= clr then
            bar_color := clr
            update_rectangle (border, border, width - (border * 2), height - (border * 2))
         end
      end

	set_text_color (clr: INTEGER)
			-- Change text color
		do
			if text_color /= clr then
				text_color := clr
				update
			end
		end

	set_text_alt_color (clr: INTEGER)
			-- Change alternate text color is_shown when bar under text
		do
			if text_alt_color /= clr then
				text_alt_color := clr
				update
			end
		end

	set_font(fnt: SB_FONT)
			-- Set the text font
		require
			fnt /= Void
		do
			if font /= fnt then
				font := fnt
				recalc
				update
			end
		end

	set_bar_style (style: INTEGER)
			-- Change progress bar style
		local
			opts: INTEGER
		do
			opts := (options & (PROGRESSBAR_MASK).bit_not) | (style & PROGRESSBAR_MASK)
			if options /= opts then
				options := opts
				recalc
			end
		end

feature -- Message processing

	handle_2 (sender: SB_MESSAGE_HANDLER; type, key: INTEGER; data: ANY): BOOLEAN
		do
			if		match_function_2 (SEL_COMMAND, ID_SETVALUE,		type, key) then Result := on_cmd_set_value 		(sender, key, data)
			elseif	match_function_2 (SEL_COMMAND, ID_SETINTVALUE,	type, key) then Result := on_cmd_set_int_value 	(sender, key, data)
			elseif	match_function_2 (SEL_COMMAND, ID_GETINTVALUE,	type, key) then Result := on_cmd_get_int_value 	(sender, key, data)
			else Result :=  Precursor (sender, type, key, data)
			end
		end

   on_paint (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         event: SB_EVENT
         dc: SB_DC_WINDOW
         percent, barlength, barfilled, tx, ty, tw, th, n, d: INTEGER
         numtext: STRING
      do
         event ?= data
         check
            event /= Void
         end
         dc := paint_dc
         dc.make_event (Current, event)

         	-- Draw borders if any
         draw_frame (dc, 0, 0, width, height)

         	-- Background
         dc.set_foreground (base_color)
         dc.fill_rectangle (border, border, width - (border * 2), height - (border * 2))

         	-- Interior
         draw_interior (dc)
         dc.stop
         Result := True
      end

   on_cmd_set_value,on_cmd_set_int_value(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         v: INTEGER_REF
      do
         v ?= data
         check
            v /= Void
         end
         set_progress (v.item)
         Result := True
      end

   on_cmd_get_int_value (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         v: INTEGER_REF
      do
         v ?= data
         check
            v /= Void
         end
         v.set_item (progress)
         Result := True
      end

feature -- Resource management

   create_resource
         -- Create server-side resources
      do
         Precursor
         font.create_resource
      end


   detach_resource
         -- Detach server-side resources
      do
         Precursor
         font.detach_resource
      end

feature {NONE} -- Implementation

	draw_interior (dc: SB_DC_WINDOW)
		local
			percent, barlength, barfilled, tx, ty, tw, th, n, d: INTEGER
			numtext: STRING
		do
			if (options and PROGRESSBAR_DIAL) /= ZERO then
					-- If total is 0, it's 100%
				barfilled := 23040
				percent := 100
				if total /= 0 then
					barfilled := ((progress * 23040) / total).rounded
					percent := ((progress * 100) / total).rounded
				end

				tw := width - (border * 2) - pad_left - pad_right
				th := height - (border * 2) - pad_top - pad_bottom
				d := tw.min (th) - 1

				tx := border + pad_left + ((tw - d) // 2)
				ty := border + pad_top + ((th - d) // 2)

				if barfilled /= 23040 then
					dc.set_foreground (bar_bg_color)
					dc.fill_arc (tx, ty, d, d, 5760, 23040 - barfilled)
				end
				if  barfilled /= 0 then
					dc.set_foreground (bar_color)
					dc.fill_arc (tx, ty, d, d, 5760,- barfilled)
				end

				dc.set_foreground (border_color)
				dc.draw_arc (tx + 1, ty, d, d, 90 * 64, 45 * 64)
				dc.draw_arc (tx, ty + 1, d, d, 135 * 64, 45 * 64)
				dc.set_foreground (base_color)
				dc.draw_arc (tx - 1, ty, d, d, 270 * 64, 45 * 64)
				dc.draw_arc (tx,ty - 1, d, d, 315 * 64, 45 * 64)

				dc.set_foreground (shadow_color)
				dc.draw_arc (tx, ty, d, d, 45 * 64, 180 * 64)
				dc.set_foreground (hilite_color)
				dc.draw_arc (tx, ty, d, d, 225 * 64, 180 * 64)

					-- Draw text
				if (options and PROGRESSBAR_PERCENTAGE) /= ZERO then
					tw := font.get_text_width ("100%%")
					if tw <= (10 * d) // 16 then
						th := font.get_font_height
						if th <= d // 2 then
							numtext := percent.out + "%%"
							n := numtext.count
							tw := font.get_text_width (numtext)
							th := font.get_font_height
							tx := tx + d // 2 - tw // 2
							ty := ty + d // 2 + font.get_font_ascent + 5
							dc.set_foreground (SBRGB (255, 255, 255))
							dc.set_function (dc.BLT_SRC_XOR_DST)      -- FIXME
							dc.draw_text_len (tx, ty, numtext, n)
						end
					end
				end

			elseif (options and PROGRESSBAR_VERTICAL) /= ZERO then
					-- Vertical bar
					-- If total is 0, it's 100%
				barlength := height - border - border;
				barfilled := barlength
				percent := 100;
				if total /= 0 then
					barfilled := ((progress * barlength) / total).rounded;
					percent := ((progress * 100) / total).rounded;
				end

					-- Draw completed bar
				if 0 < barfilled then
					dc.set_foreground (bar_color);
					dc.fill_rectangle (border, height - border - barfilled, width - (border * 2), barfilled)
				end

					-- Draw uncompleted bar
				if barfilled < barlength then
					dc.set_foreground ( bar_bg_color)
					dc.fill_rectangle (border, border, width - (border * 2), barlength - barfilled)
				end

					-- Draw text
				if (options and PROGRESSBAR_PERCENTAGE) /= ZERO then
					numtext := percent.out + "%%"
					n := numtext.count
					tw := font.get_text_width (numtext)
					th := font.get_font_height;
					ty := (height - th) // 2 + font.get_font_ascent
					tx := (width - tw) // 2
					if height - border - barfilled > ty then
							-- In upper side
						dc.set_foreground (text_color)
						dc.set_clip_rectangle_coords (border, border, width - (border * 2), height - (border * 2))
						dc.draw_text (tx, ty, numtext)
					elseif ty - th > height - border - barfilled then
							-- In lower side
						dc.set_foreground (text_alt_color)
						dc.set_clip_rectangle_coords (border, border, width - (border * 2), height - (border * 2))
						dc.draw_text (tx, ty, numtext)
					else
							-- In between!
						dc.set_foreground (text_alt_color) 
						dc.set_clip_rectangle_coords (border, height - border - barfilled, width - (border * 2), barfilled)
						dc.draw_text (tx, ty, numtext)
						dc.set_foreground (text_color)
						dc.set_clip_rectangle_coords (border, border, width - (border * 2), barlength - barfilled)
						dc.draw_text (tx, ty, numtext);
						dc.clear_clip_rectangle
					end
				end
			else
					-- Horizontal bar
					-- If total is 0, it's 100%
				barlength := width-border-border;
				barfilled := barlength;
				percent := 100;
				if total /= 0 then
					barfilled := ((progress * barlength) / total).rounded;
					percent := ((progress * 100) / total).rounded;
				end

					-- Draw completed bar
				if 0 < barfilled then
					dc.set_foreground (bar_color)
					dc.fill_rectangle (border, border, barfilled, height - (border * 2))
				end

					-- Draw uncompleted bar
				if barfilled < barlength then
					dc.set_foreground (bar_bg_color)
					dc.fill_rectangle (border + barfilled, border, barlength - barfilled, height - (border * 2))
				end

					-- Draw text
				if (options and PROGRESSBAR_PERCENTAGE) /= ZERO then
					numtext := percent.out + "%%"
					n := numtext.count
					tw := font.get_text_width (numtext)
					th := font.get_font_height
					ty := (height - th) // 2 + font.get_font_ascent
					tx := (width - tw) // 2
					if border + barfilled <= tx then
							-- In right side
						dc.set_foreground (text_color)
						dc.set_clip_rectangle_coords (border, border, width - (border * 2), height - (border * 2))
						dc.draw_text (tx, ty, numtext)
					elseif tx + tw <= border + barfilled then
							-- In left side
						dc.set_foreground (text_alt_color)
						dc.set_clip_rectangle_coords (border, border, width - (border * 2), height - (border * 2))
						dc.draw_text (tx, ty, numtext)
					else
							-- In between!
						dc.set_foreground (text_alt_color)
						dc.set_clip_rectangle_coords (border, border, barfilled, height)
						dc.draw_text (tx, ty, numtext)
						dc.set_foreground (text_color)
						dc.set_clip_rectangle_coords (border + barfilled, border, barlength - barfilled, height)
						dc.draw_text (tx, ty, numtext)
						dc.clear_clip_rectangle
					end
				end
			end
			dc.stop
		end

   PROGRESSBAR_MASK: INTEGER
      once
         Result := (PROGRESSBAR_PERCENTAGE | PROGRESSBAR_VERTICAL | PROGRESSBAR_DIAL)
      end

end
