note
   description: "Base class for separator"
   author: "Eugene Melekhov <eugene_melekhov@mail.ru>"
   copyright: "Copyright (c) 2002, Eugene Melekhov and others"
   license: "Eiffel Forum Freeware License v2 (see forum.txt)"
   status: "Mostly complete"

class SB_SEPARATOR

inherit

	SB_FRAME
		redefine
			make,
			make_sb,
			default_width,
			default_height,
			on_paint
		end

	SB_SEPARATOR_CONSTANTS

create

	make,
	make_opts,
	make_ev

feature -- Creation

	make (p: SB_COMPOSITE)
		do
			make_sb (p, 0)
		end

	make_sb (p: SB_COMPOSITE; opts: INTEGER)
		local
			o: INTEGER
		do
			if opts = ZERO then
				o := SEPARATOR_GROOVE | LAYOUT_FILL_X
			else
				o := opts
			end
			make_opts (p, o, 0, 0, 0, 0, 0, 0, 0, 0)
		end

feature -- Queries


	default_width: INTEGER
			-- Get default width
		local
			w: INTEGER
		do
			if (options & (SEPARATOR_GROOVE | SEPARATOR_RIDGE)) /= ZERO then
				w := 2
			else
				w := 1
			end
			Result := w + pad_left + pad_right + border*2
		end

	default_height: INTEGER
			-- Get default height
		local
			h: INTEGER
		do
			if (options & (SEPARATOR_GROOVE | SEPARATOR_RIDGE)) /= ZERO then
				h := 2
			else
				h := 1
			end
			Result :=  h + pad_top + pad_bottom + border * 2
		end

	get_separator_style: INTEGER
			-- Get separator style
		do
			Result := (options & SEPARATOR_MASK)
		end

feature -- Actions

	set_separator_style (style: INTEGER)
			-- Change separator style
		local
			opts: INTEGER
		do
			opts := (options & (SEPARATOR_MASK).bit_not) | (style & SEPARATOR_MASK)
			if options /= opts then
				options := opts
				recalc
				update
			end
		end


feature -- Message processing

	on_paint (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
		local
			ev: SB_EVENT
			dc: SB_DC_WINDOW
			kk, ll: INTEGER
		do
			ev ?= data
			check ev /= Void end
			dc := paint_dc
			dc.make_event (Current, ev)

				-- Draw background
			dc.set_foreground (back_color)
			dc.fill_rectangle (ev.rect_x, ev.rect_y, ev.rect_w, ev.rect_h)

				-- Draw frame
			draw_frame (dc, 0, 0, width, height)

			if (height - pad_bottom - pad_top) < (width - pad_left - pad_right) then
					-- Horizonal orientation
				if (options & (SEPARATOR_GROOVE | SEPARATOR_RIDGE)) /= ZERO then
					kk := 2
				else
					kk := 1
				end
				ll := border + pad_top + (height - pad_bottom - pad_top - border * 2 - kk) // 2
				if (options & SEPARATOR_GROOVE) /= ZERO then
					dc.set_foreground (shadow_color)
					dc.draw_line (border + pad_left, ll, width - pad_right - pad_left - border*2, ll)
					dc.set_foreground (hilite_color)
					dc.draw_line (border + pad_left, ll + 1, width - pad_right - pad_left - border*2, ll + 1)
				elseif (options & SEPARATOR_RIDGE) /= ZERO then
					dc.set_foreground (hilite_color)
					dc.draw_line (border + pad_left, ll, width - pad_right - pad_left - border*2, ll)
					dc.set_foreground (shadow_color)
					dc.draw_line (border + pad_left, ll + 1, width - pad_right - pad_left - border*2, ll + 1)
				elseif (options & SEPARATOR_LINE) /= ZERO then
					dc.set_foreground (border_color)
					dc.draw_line (border + pad_left, ll, width - pad_right - pad_left - border*2, ll)
				end
			else
					-- Vertical orientation
				if (options & (SEPARATOR_GROOVE | SEPARATOR_RIDGE)) /= ZERO then
					kk := 2
				else
					kk := 1
				end
				ll := border + pad_left + (width - pad_left - pad_right - border*2 - kk) // 2
				if (options & SEPARATOR_GROOVE) /= ZERO then
					dc.set_foreground (shadow_color)
					dc.draw_line (ll, pad_top + border, ll, height - pad_top - pad_bottom - border*2)
					dc.set_foreground (hilite_color)
					dc.draw_line (ll + 1, pad_top + border, ll + 1, height - pad_top - pad_bottom - border*2)
				elseif (options & SEPARATOR_RIDGE) /= ZERO then
					dc.set_foreground (hilite_color)
					dc.draw_line (ll, pad_top + border, ll, height - pad_top - pad_bottom - border*2)
					dc.set_foreground (shadow_color)
					dc.draw_line (ll + 1, pad_top + border, ll + 1, height - pad_top - pad_bottom - border*2)
				elseif (options & SEPARATOR_LINE) /= ZERO then
					dc.set_foreground (border_color)
					dc.draw_line (ll, pad_top + border, ll, height - pad_top - pad_bottom - border*2)
				end
			end
			dc.stop
			Result := True
		end

end
