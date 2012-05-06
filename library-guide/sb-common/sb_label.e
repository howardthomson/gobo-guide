note
	description: "[
		A label widget can be used to place a text and/or icon
		for explanation purposes. The text label may have an
		optional tooltip and/or help string.
   	]"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

class SB_LABEL

inherit

	SB_FRAME
    	rename
         	make as frame_make,
         	make_sb as frame_make_sb,
         	make_opts as frame_make_opts,
         	make_opts_ev as frame_make_opts_ev
      	redefine
      		make_ev,
         	create_resource, detach_resource, enable, disable,
         	default_height, default_width,
         	handle_2,
         	on_paint,
         	destruct,
         	class_name
      	end

	SB_LABEL_CONSTANTS
	SB_EXPANDED

create

   make, make_sb, make_opts, make_ev

feature

	label		: STRING
	icon		: SB_ICON
	font		: SB_FONT
	hot_key		: INTEGER
	hot_off		: INTEGER
	text_color	: INTEGER
	tip			: STRING
	help		: STRING

feature -- class name

	class_name: STRING
		once
			Result := "SB_LABEL"
		end

feature -- Creation

	make_ev
		do
			make_opts_ev (once "TEST", Void, LABEL_NORMAL, 0,0,0,0, DEFAULT_PAD,DEFAULT_PAD,DEFAULT_PAD,DEFAULT_PAD)
		end

	make_opts_ev (text: STRING; ic: SB_ICON; opts: INTEGER; x, y, w, h, pl, pr,pt, pb: INTEGER)
    		-- Construct label with given text and icon
      	do
         	frame_make_opts_ev (opts, x,y, w,h, pl,pr, pt,pb)
         	flags := (flags | Flag_enabled)
         	label := u.extract_string_esc (text, 0,'%T', '&')
         	tip   := u.extract_string (text, 1, '%T')
         	help  := u.extract_string (text, 2, '%T')
         	icon := ic
         	font := application.normal_font
         	text_color := application.fore_color
         	hot_key := u.parse_hot_key (text)
         	hot_off := u.find_hot_key_offset (text)
         	if hot_key /= 0 then
	         	add_hot_key (hot_key)
			end
		end

	make (p: SB_COMPOSITE; text: STRING)
    		-- Construct label with given text
      	do
         	make_opts (p, text, Void, LABEL_NORMAL, 0,0,0,0, DEFAULT_PAD,DEFAULT_PAD,DEFAULT_PAD,DEFAULT_PAD);
      	end

	make_sb (p: SB_COMPOSITE; text: STRING; opts: INTEGER)
		do
			make_opts (p, text, Void, opts, 0,0,0,0, 0,0,0,0)
		end

	make_opts (p: SB_COMPOSITE; text: STRING; ic: SB_ICON; opts: INTEGER; x, y, w, h, pl, pr,pt, pb: INTEGER)
			-- Construct label with given text and icon
		do
			frame_make_opts (p, opts, x,y, w,h, pl,pr, pt,pb)
			flags := (flags | Flag_enabled)
			label := u.extract_string_esc (text, 0, '%T', '&')
			tip   := u.extract_string (text, 1, '%T')
			help  := u.extract_string (text, 2, '%T')
			icon := ic
			font := application.normal_font
			text_color := application.fore_color
	--		hot_key := u.parse_hot_key (text)
	--		hot_off := u.find_hot_key_offset (text)
	--		add_hot_key (hot_key)
		end

feature {NONE} -- Implementation

  label_height (text: STRING): INTEGER
      local
         l_start, l_end, l: INTEGER
      do
         from
            l_start := 1
            l_end := 1
            l := text.count
         until
            l_end > l
         loop
            l_end := l_start
            from
            until
               l_end > l or else text.item (l_end) = '%N'
            loop
               l_end := l_end + 1
            end
            Result := Result + font.get_font_height
            l_start := l_end + 1
         end
      end

  label_width (text: STRING): INTEGER
  		-- width of widest line of (potentially) multi-line content
      local
         l_start, l_end, w, l: INTEGER
      do
         from
            l_start := 1
            l_end := 1
            l := text.count
         until
            l_end > l
         loop
            l_end := l_start
            from
            until
               l_end > l or else text.item (l_end) = '%N'
            loop
               l_end := l_end + 1
            end
            w := font.get_text_width_offset (text, l_start, l_end - l_start)
            if w > Result then
               Result := w
            end
            l_start := l_end+1
         end
      end

  draw_label (dc: SB_DC_WINDOW; text: STRING; hot, tx, ty, tw, th: INTEGER)
      local
         l_start, l_end, xx, yy, l: INTEGER
      do
         yy := ty + font.get_font_ascent
         from
            l_start := 1
            l_end := 1
            l := text.count
         until
            l_end > l
         loop
            l_end := l_start
            from
            until
               l_end > l or else text.item (l_end) = '%N'
            loop
               l_end := l_end + 1
            end
            if (options & JUSTIFY_LEFT) /= 0 then
               xx := tx
            elseif (options & JUSTIFY_RIGHT) /= 0 then
               xx := tx + tw - font.get_text_width_offset (text, l_start, l_end - l_start)
            else
               xx := tx + (tw - font.get_text_width_offset (text, l_start, l_end - l_start )) // 2
            end
            dc.draw_text_offset (xx, yy, text, l_start, l_end - l_start)
            if l_start <= hot and then hot < l_end then
               dc.fill_rectangle (xx + font.get_text_width_offset (text, l_start, hot - l_start), yy + 1,
                                 font.get_text_width_offset (text, hot, 1), 1)
            end
            yy := yy + font.get_font_height
            l_start := l_end + 1
         end
      end

   just_x (tw, iw: INTEGER): SB_POINT
         -- Justify stuff in x-direction
      local
         s: INTEGER
         ix,tx: INTEGER
      do
         if iw /= 0 and then tw /= 0 then
            s := 4
         end
         if (options & JUSTIFY_LEFT) /= 0  and then  (options & JUSTIFY_RIGHT) /= 0 then
            if (options & ICON_BEFORE_TEXT) /= 0 then
               ix := pad_left+border;
               tx := width-pad_right-border-tw
            elseif (options & ICON_AFTER_TEXT) /= 0 then
               tx := pad_left+border;
               ix := width-pad_right-border-iw
            else
               ix := border+pad_left
               tx := border+pad_left
            end
         elseif (options & JUSTIFY_LEFT) /= 0 then
            if (options & ICON_BEFORE_TEXT) /= 0 then
               ix := pad_left+border
               tx := ix+iw+s
            elseif (options & ICON_AFTER_TEXT) /= 0 then
               tx := pad_left+border;
               ix := tx+tw+s
            else 
               ix := border+pad_left
               tx := border+pad_left
            end
         elseif (options & JUSTIFY_RIGHT) /= 0 then
            if (options & ICON_BEFORE_TEXT) /= 0 then
               tx := width-pad_right-border-tw
               ix := tx-iw-s;
            elseif (options & ICON_AFTER_TEXT) /= 0 then
               ix := width-pad_right-border-iw
               tx := ix-tw-s;
            else
               ix := width-pad_right-border-iw
               tx := width-pad_right-border-tw
            end
         else
            if (options & ICON_BEFORE_TEXT) /= 0 then
               ix := border+pad_left+(width-pad_left-pad_right-(border*2)-tw-iw-s) // 2
               tx := ix+iw+s
            elseif (options & ICON_AFTER_TEXT) /= 0 then
               tx := border+pad_left+(width-pad_left-pad_right-(border*2)-tw-iw-s) // 2
               ix := tx+tw+s
            else
               ix := border+pad_left+(width-pad_left-pad_right-(border*2)-iw) // 2
               tx := border+pad_left+(width-pad_left-pad_right-(border*2)-tw) // 2
            end
         end
         create Result.make(ix,tx)
      end

  just_y (th, ih: INTEGER): SB_POINT
         -- Justify stuff in y-direction
      local
         iy, ty: INTEGER
      do
         if (options & JUSTIFY_TOP) /= 0 and then (options & JUSTIFY_BOTTOM) /= 0 then
            if (options & ICON_ABOVE_TEXT) /= 0 then
               iy :=pad_top+border
               ty := height-pad_bottom-border-th
            elseif (options & ICON_BELOW_TEXT) /= 0 then
               ty := pad_top+border
               iy := height-pad_bottom-border-ih
            else
               iy := border+pad_top
               ty := border+pad_top
            end
         elseif (options & JUSTIFY_TOP) /= 0 then
            if (options & ICON_ABOVE_TEXT) /= 0 then
               iy := pad_top+border
               ty := iy+ih
            elseif (options & ICON_BELOW_TEXT) /= 0 then
               ty := pad_top+border
               iy := ty+th
            else
               iy := border+pad_top
               ty := border+pad_top
            end
         elseif (options & JUSTIFY_BOTTOM) /= 0 then
            if (options & ICON_ABOVE_TEXT) /= 0 then 
               ty := height-pad_bottom-border-th
               iy := ty-ih
            elseif (options & ICON_BELOW_TEXT) /= 0 then
               iy := height-pad_bottom-border-ih
               ty := iy-th
            else
               iy := height-pad_bottom-border-ih
               ty := height-pad_bottom-border-th
            end
         else
            if (options & ICON_ABOVE_TEXT) /= 0 then
               iy := border+pad_top+(height-pad_bottom-pad_top-(border*2)-th-ih)//2
               ty := iy+ih
            elseif (options & ICON_BELOW_TEXT) /= 0 then
               ty := border+pad_top+(height-pad_bottom-pad_top-(border*2)-th-ih)//2
               iy := ty+th
            else
               iy := border+pad_top+(height-pad_bottom-pad_top-(border*2)-ih)//2
               ty := border+pad_top+(height-pad_bottom-pad_top-(border*2)-th)//2
            end
         end
         create Result.make(iy,ty);         
      end

feature -- Message processing

   handle_2 (sender: SB_MESSAGE_HANDLER; type, key: INTEGER; data: ANY): BOOLEAN
      do
         if		match_function_2 (SEL_COMMAND,		Id_setstringvalue,	type, key) then Result := on_cmd_set_string_value	(sender, key, data);
         elseif match_function_2 (SEL_COMMAND,		Id_getstringvalue,	type, key) then Result := on_cmd_get_string_value	(sender, key, data);
         elseif match_function_2 (SEL_UPDATE,		Id_query_tip,		type, key) then Result := on_query_tip				(sender, key, data);
         elseif match_function_2 (SEL_UPDATE,		Id_query_help,		type, key) then Result := on_query_help				(sender, key, data);
         elseif match_function_2 (SEL_KEYPRESS,		Id_hotkey,			type, key) then Result := on_hot_key_press			(sender, key, data);
         elseif match_function_2 (SEL_KEYRELEASE,	Id_hotkey,			type, key) then Result := on_hot_key_release		(sender, key, data);
         else Result := Precursor(sender, type, key, data); end
      end

   on_paint (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         event: SB_EVENT;
         dc: SB_DC_WINDOW;
         tw, th, iw, ih, tx, ty, ix, iy: INTEGER;
         px, py: SB_POINT;
      do
         event ?= data
         check
            event /= Void
         end
         dc := paint_dc
         dc.make_event (Current, event)
         dc.set_foreground (back_color)
         dc.fill_rectangle (event.rect_x, event.rect_y, event.rect_w, event.rect_h)
         if not label.is_empty then
            tw := label_width (label)
            th := label_height (label)
         end
         if icon /= Void then
            iw := icon.width
            ih := icon.height
         end
         px := just_x (tw, iw)
         py := just_y (th, ih)
         if icon /= Void then
            if is_enabled then
               dc.draw_icon (icon, px.x, py.x)
            else
               dc.draw_icon_sunken (icon, px.x, py.x)
            end
         end
         if not label.is_empty then
            dc.set_font (font)
            if is_enabled then
               dc.set_foreground (text_color)
               draw_label (dc, label, hot_off, px.y, py.y, tw, th)
            else
               dc.set_foreground (hilite_color)
               draw_label (dc, label, hot_off, px.y+1, py.y+1, tw, th)
               dc.set_foreground (shadow_color)
               draw_label (dc, label, hot_off, px.y, py.y, tw, th)
            end
         end
         draw_frame (dc, 0, 0, width, height)
         dc.stop
         Result := True
      end

   on_hot_key_press (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         window: SB_WINDOW
      do
         from
            window := next
         until
            window = Void or Result
         loop
            if window.is_shown then
               if window.is_enabled and then window.can_focus then
                  window.do_handle_2 (Current, SEL_FOCUS_SELF, 0, data)
                  Result := True;
               elseif window.is_composite and then window.handle_2 (Current, SEL_FOCUS_NEXT, 0, data)
                then
                  Result := True
               end
            else
               window := window.next
            end
         end
         Result := True
      end

   on_hot_key_release (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
         --  Nothing much happens here...
      do
         Result := True
      end

   on_cmd_get_string_value (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         str: STRING;
      do
         str ?= data;
         check
            str /= Void
         end
         str.make_from_string (label)
         Result := True
      end


   on_cmd_set_string_value (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         str: STRING;
      do
         str ?= data
         set_text (str)
         Result := True
      end

   on_query_help (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         if not help.is_empty and then (flags & Flag_help) /= 0 then
            sender.do_handle_2 (Current, SEL_COMMAND, Id_setstringvalue, help)
            Result := True
         end
      end

   on_query_tip (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         if not tip.is_empty and then (flags & Flag_tip) /= 0 then
            sender.do_handle_2 (Current, SEL_COMMAND, Id_setstringvalue, tip)
            Result := True
         end
      end

   create_resource
         -- Create server-side resources
      do
         Precursor
         font.create_resource
         if icon /= Void then
            icon.create_resource
         end
      end

  detach_resource
         -- Detach server-side resources
      do
         Precursor
         font.detach_resource
         if icon /= Void then
            icon.detach_resource
         end
      end

   enable
         -- Enable the window
      do
         if (flags & Flag_enabled) = 0 then
            Precursor
            update;
         end
      end

   disable
         -- Disable the window
      do
         if (flags & Flag_enabled) /= 0 then
            Precursor
            update;
         end
      end

   default_width: INTEGER
         -- Return default width
      local
         tw,iw,s,w: INTEGER
      do
         if not label.is_empty then
            tw := label_width (label)
         end
         if icon /= Void then
            iw := icon.width
         end
         if (iw /=0 and then tw /= 0 ) then
            s := 4;
         end
         if (options & (ICON_AFTER_TEXT | ICON_BEFORE_TEXT)) = 0 then
            w := tw.max(iw)
         else
            w := tw+iw+s
         end
         Result := w + pad_left + pad_right + (border*2)
      end

  default_height: INTEGER
         -- Return default height
      local
         th, ih, h: INTEGER;
      do
         if not label.is_empty then
            th := label_height (label)
         end

         if icon /= Void then
            ih := icon.height
         end

         if (options & (ICON_ABOVE_TEXT | ICON_BELOW_TEXT)) = 0 then
            h := th.max (ih)
         else
            h := th + ih
         end
         Result := h + pad_top + pad_bottom + (border * 2)
      end

   set_text (text: STRING)
         -- Set the text for this label
      local
         str: STRING
      do
         str := u.extract_string_esc (text, 0, '%T', '&')
         if not label.is_equal (str) then
            remove_hot_key (hot_key)
            hot_key := u.parse_hot_key (text)
            hot_off := u.find_hot_key_offset (text)
            add_hot_key (hot_key)
            label := str
            recalc
            update
         end
      end

   set_icon (ic: SB_ICON)
         -- Set the icon for this label
      do
         if icon /= ic then
            icon := ic
            recalc
            update
         end
      end

   set_font (fnt: SB_FONT)
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

   set_text_color (clr: INTEGER)
         -- Set the current text color
      do
         if clr /= text_color then
            text_color := clr
            update
         end
      end

   set_justify (mode: INTEGER)
         -- Set the current text-justification mode.
      local
         opts: INTEGER
      do
         opts := new_options (mode, JUSTIFY_MASK)
         if options /= opts then
            options := opts
            update
         end
      end

   get_justify: INTEGER
         -- Get the current text-justification mode.
      do
         Result := (options & JUSTIFY_MASK)
      end

   set_icon_position (mode: INTEGER)
         -- Set the current icon position
      local
         opts: INTEGER;
      do
         opts := new_options (mode, ICON_TEXT_MASK)
         if options /= opts then
            options := opts
            recalc
            update
         end
      end

   get_icon_position: INTEGER
         -- Get the current icon position
      do
         Result := (options & ICON_TEXT_MASK)
      end

   set_help_text (text: STRING)
         -- Set the status line help text for this label
      do
         help := text
      end

   set_tip_text (text: STRING)
         -- Set the tool tip message for this label
      do
         tip := text
      end

feature -- Destruction

   destruct
      do
         remove_hot_key (hot_key)
         icon := Void
         font := Void
         Precursor
      end

end
