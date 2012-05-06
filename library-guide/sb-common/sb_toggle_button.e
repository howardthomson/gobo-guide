note
	description: "[
		The toggle button provides a two-state button, which toggles
		between the on and the off state each time it is pressed. For each state,
		the toggle button has a unique icon and text label. When pressed, the
		button widget sends a SEL_COMMAND to its target, with the message data
		set to the current state of the toggle button, of the type BOOLEAN.
		]"
   
	author: "Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright: "Copyright (c) 2002, Eugene Melekhov and others"
	license: "Eiffel Forum Freeware License v2 (see forum.txt)"
	status: "Mostly complete"

class SB_TOGGLE_BUTTON

inherit

   SB_LABEL
      rename
         make as label_make,
         make_opts as label_make_opts
      redefine
         can_focus,
         default_height,
         default_width,
         destruct,
         handle_2,
         on_paint,
         on_enter,
         on_leave,
         on_focus_in,
         on_focus_out,
         on_key_press,
         on_key_release,
         on_hot_key_press,
         on_hot_key_release,
         on_left_btn_press,
         on_left_btn_release,
         on_ungrabbed,
         on_update,
         on_query_tip,
         on_query_help,
         create_resource,
         detach_resource,
         class_name
      end

   SB_TOGGLE_BUTTON_CONSTANTS

create

   make,
   make_opts

feature -- class name

	class_name: STRING
		once
			Result := "SB_TOGGLE_BUTTON"
		end

feature -- Creation

   make (p: SB_COMPOSITE; text1,text2: STRING)
         -- Construct toggle button with two text labels one for each state
      do
         make_opts (p, text1, text2, Void, Void, Void, 0, TOGGLEBUTTON_NORMAL, 0, 0, 0, 0,
                   DEFAULT_PAD, DEFAULT_PAD,DEFAULT_PAD, DEFAULT_PAD);
      end

   make_opts (p: SB_COMPOSITE; text1,text2: STRING; icon1,icon2: SB_ICON;tgt: SB_MESSAGE_HANDLER;
             sel: INTEGER; opts: INTEGER; x, y, w, h, pl, pr,pt, pb: INTEGER)
         -- Construct toggle button with two text labels, and two icons, one for each 
         -- state
      do
         label_make_opts(p,text1,icon1,opts,x,y,w,h,pl,pr,pt,pb)
         message_target := tgt
         message := sel
         alt_label := u.extract_string_esc(text2,0,'%T','&')
         alt_tip := u.extract_string(text2,1,'%T')
         alt_help := u.extract_string(text2,2,'%T')
         alt_hot_key := u.parse_hot_key(text2)
         alt_hot_off := u.find_hot_key_offset(text2)
         add_hot_key(alt_hot_key)
         state := False
         down := False
      end

feature -- Data

	alt_label	: STRING
	alt_icon	: SB_ICON
	alt_tip		: STRING
	alt_help	: STRING

	state		: BOOLEAN

feature --Queries

   can_focus: BOOLEAN
         -- Returns true because a toggle button can receive focus
      once
         Result := True;
      end

   default_width: INTEGER
         -- Get default width
      local
         tw, iw, s, w1, w2: INTEGER
      do
         if not label.is_empty then
            tw := label_width (label)
         end
         if icon /= Void then
            iw := icon.width
         end
         if iw /= 0 and then tw /= 0 then
            s := 4
         end
         if (options & (ICON_AFTER_TEXT | ICON_BEFORE_TEXT)) = 0 then
            w1 := tw.max (iw)
         else
            w1 := tw+iw+s
         end

         if not alt_label.is_empty then
            tw := label_width (alt_label)
         elseif not label.is_empty then
            tw := label_width (label)
         end
         if alt_icon /= Void then
            iw := alt_icon.width
         elseif icon /= Void then
            iw := icon.width
         end
         if iw /= 0 and then tw /= 0 then
            s := 4
         end
         if (options & (ICON_AFTER_TEXT | ICON_BEFORE_TEXT)) = 0 then
            w2 := tw.max (iw)
         else
            w2 := tw+iw+s
         end

         Result := w1.max(w2) + pad_left+pad_right+(border*2)
      end

   default_height: INTEGER
         -- Get default width
      local
         th, ih, h1, h2: INTEGER
      do
         if not label.is_empty then
            th := label_height (label)
         end
         if icon /= Void then
            ih := icon.height
         end
         if (options & (ICON_ABOVE_TEXT | ICON_BELOW_TEXT)) = 0 then
            h1 := th.max (ih)
         else 
            h1 := th+ih
         end
         if not alt_label.is_empty then
            th := label_height (alt_label)
         elseif not label.is_empty then
            th := label_height (label)
         end
         if alt_icon /= Void then
            ih := alt_icon.height
         elseif icon /= Void then
            ih := icon.height
         end
         if (options & (ICON_ABOVE_TEXT | ICON_BELOW_TEXT)) = 0 then
            h2 := th.max(ih)
         else 
            h2 := th+ih
         end
         Result := h1.max(h2) + pad_top+pad_bottom+(border*2)
      end

   get_toggle_button_style: INTEGER
         -- Return current check button style
      do
         Result := (options & TOGGLEBUTTON_MASK)
      end

feature -- Actions

   set_alt_text (text: STRING)
         -- Change alternate text shown when toggled
      do
         if not alt_label.is_equal (text) then
            alt_label := text
            hot_off := -1
            recalc
            update
         end
      end

   set_alt_icon (ic: SB_ICON)
         -- Change alternate icon shown when toggled
      do
         if alt_icon /= ic then
            alt_icon := ic
            recalc
            update
         end
      end

   set_state (s: BOOLEAN)
         -- Change toggled state
      do
         if state /= s then
            state := s
            update
         end
      end

   set_alt_help_text (text: STRING)
         -- Change alternate help text shown when toggled
      do
         alt_help := text
      end

   set_alt_tip_text(text: STRING)
         -- Change alternate tip text shown when toggled
      do
         alt_tip := text
      end

   set_toggle_button_style(style: INTEGER)
         -- Set the toggle button style flags
      do
      end

feature -- Resource management

   create_resource
      do
         Precursor;
         if alt_icon /= Void then
            alt_icon.create_resource
         end
      end

   detach_resource
         -- Detach server-side resources
      do
         Precursor;
         if alt_icon /= Void then
            alt_icon.detach_resource
         end
      end

feature -- Message processing

   handle_2 (sender: SB_MESSAGE_HANDLER; type, key: INTEGER; data: ANY): BOOLEAN
      do
         if		match_function_2 (SEL_COMMAND,Id_check,			type, key) then Result := on_check				(sender, key, data)
         elseif match_function_2 (SEL_COMMAND,Id_uncheck,		type, key) then Result := on_uncheck			(sender, key, data)
         elseif match_function_2 (SEL_COMMAND,Id_setvalue,		type, key) then Result := on_cmd_set_value 		(sender, key, data)
         elseif match_function_2 (SEL_COMMAND,Id_setintvalue,	type, key) then Result := on_cmd_set_int_value	(sender, key, data)
         elseif match_function_2 (SEL_COMMAND,Id_getintvalue,	type, key) then Result := on_cmd_get_int_value	(sender, key, data)
         else Result := Precursor(sender, type, key, data)
         end
      end

--	XXon_paint (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
--		do
--			Result := True
--		end

   on_paint (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         event: SB_EVENT
         dc: SB_DC_WINDOW
         tw,th,iw,ih,tx,ty,ix,iy: INTEGER
         pt: SB_POINT;
      do
         event ?= data
         check
            event /= Void
         end
         dc := paint_dc
         dc.make_event (Current, event)
         if (options & (Frame_raised | Frame_sunken)) /= 0 then
            -- Got a border at all?
            if (options & TOGGLEBUTTON_TOOLBAR) /= 0 then
               -- Toolbar style
               if down then
                  -- Enabled and cursor inside and down
                  dc.set_foreground (hilite_color)
                  dc.fill_rectangle (border, border, width-border*2, height-border*2)
                  if (options & Frame_thick) /= 0 then
                     draw_double_sunken_rectangle (dc, 0, 0, width, height)
                  else
                     draw_sunken_rectangle (dc, 0, 0, width, height)
                  end
               elseif is_enabled and then is_under_cursor then
                  -- Enabled and cursor inside, and up
                  dc.set_foreground (back_color)
                  dc.fill_rectangle (border, border, width-border*2, height-border*2)
                  if (options & Frame_thick) /= 0 then
                     draw_double_raised_rectangle (dc, 0, 0, width, height)
                  else
                     draw_raised_rectangle (dc, 0, 0, width, height)
                  end
               else
                  -- Disabled or unchecked or not under cursor
                  dc.set_foreground(back_color)
                  dc.fill_rectangle (0, 0, width, height)
               end
            else
               -- Normal style
               if down then
                  -- Draw sunken if pressed
                  dc.set_foreground (hilite_color)
                  dc.fill_rectangle (border, border, width-border*2, height-border*2);
                  if (options & Frame_thick) /= 0 then
                     draw_double_sunken_rectangle (dc, 0, 0, width, height)
                  else
                     draw_sunken_rectangle (dc, 0, 0, width, height)
                  end
               else
                  -- Draw raised if not currently pressed down
                  dc.set_foreground (back_color)
                  dc.fill_rectangle (border, border, width-border*2, height-border*2)
                  if (options & Frame_thick) /= 0 then
                     draw_double_raised_rectangle (dc, 0, 0, width, height)
                  else
                     draw_raised_rectangle (dc, 0, 0, width, height)
                  end
               end
            end
         else
            -- No borders
            dc.set_foreground (back_color)
            dc.fill_rectangle (0, 0, width, height)
         end

         -- Place text & icon
         if state and then not alt_label.is_empty then
            tw := label_width (alt_label)
            th := label_height (alt_label)
         elseif not label.is_empty then
            tw := label_width (label)
            th := label_height (label)
         end
         if state and then alt_icon /= Void then
            iw := alt_icon.width
            ih := alt_icon.height
         elseif icon /= Void then
            iw := icon.width
            ih := icon.height
         end

         pt := just_x (tw,iw); ix := pt.x; tx := pt.y;
         pt := just_y (th,ih); iy := pt.x; ty := pt.y;

         -- Shift a bit when pressed
         if down and then (options & (Frame_raised | Frame_sunken)) /= 0 then
            tx := tx + 1
            ty := ty + 1
            ix := ix + 1
            iy := iy + 1
         end

         if is_enabled then
            -- Draw enabled state
            if state and then alt_icon /= Void then
               dc.draw_icon (alt_icon, ix,iy)
            elseif icon /= Void then
               dc.draw_icon (icon, ix,iy)
            end
            if state and then not alt_label.is_empty then
               dc.set_font (font)
               dc.set_foreground (text_color)
               draw_label (dc, alt_label, alt_hot_off, tx,ty, tw,th)
               if has_focus then
                  dc.draw_focus_rectangle (border+2, border+2, width-2*border-4, height-2*border-4)
               end
            elseif not label.is_empty then
               dc.set_font (font)
               dc.set_foreground (text_color)
               draw_label (dc, label, hot_off, tx,ty, tw,th)
               if has_focus then
                  dc.draw_focus_rectangle (border+2, border+2, width-2*border-4, height-2*border-4)
               end
            end
         else
            -- Draw grayed-out state
            if state and then alt_icon /= Void then
               dc.draw_icon_sunken (alt_icon, ix,iy)
            elseif icon /= Void then
               dc.draw_icon_sunken (icon, ix,iy)
            end
            if state and then not alt_label.is_empty then
               dc.set_font (font)
               dc.set_foreground (hilite_color)
               draw_label (dc, alt_label, alt_hot_off, tx+1,ty+1, tw,th)
               dc.set_foreground (shadow_color)
               draw_label (dc, alt_label, alt_hot_off, tx,ty, tw,th)
            elseif not label.is_empty then
               dc.set_font (font)
               dc.set_foreground (hilite_color)
               draw_label (dc, label, hot_off, tx+1,ty+1, tw,th)
               dc.set_foreground (shadow_color)
               draw_label (dc, label, hot_off, tx,ty, tw,th)
            end
         end
         dc.stop
         Result := True
      end

   on_update (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         if not Precursor(sender, selector, data) then
            if (options & TOGGLEBUTTON_AUTOHIDE) /= 0 then
               if is_shown then
                  hide;
                  recalc
               end
            end
            if (options & TOGGLEBUTTON_AUTOGRAY) /= 0 then
               disable
            end
         end
         Result := True;
      end

   on_enter (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         Result := Precursor (sender,selector,data);
         if is_enabled then
            if (flags & Flag_pressed) /= 0 then
               press(True);
            end
            if (options & TOGGLEBUTTON_TOOLBAR) /= 0 then
               update;
            end
         end
         Result := True
      end

   on_leave (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         Result := Precursor (sender,selector,data);
         if is_enabled then
            if (flags & Flag_pressed) /= 0 then
               press(False);
            end
            if (options & TOGGLEBUTTON_TOOLBAR) /= 0 then
               update;
            end
         end
         Result := True
      end

   on_focus_in (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         Result := Precursor(sender,selector,data);
         update_rectangle(border,border,width-border*2,height-border*2);
         Result := True;
      end

   on_focus_out (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         Result := Precursor(sender,selector,data);
         update_rectangle(border,border,width-border*2,height-border*2);
         Result := True;
      end

   on_ungrabbed (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         Result := Precursor(sender,selector,data);
         press(False);
         unset_flags (Flag_pressed);
         flags := flags | Flag_update;
         Result := True;
      end

   on_left_btn_press (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         do_handle_2 (Current, SEL_FOCUS_SELF, 0, data);
         unset_flags (Flag_tip);
         if is_enabled and then (flags & Flag_pressed) = 0 then
            grab_mouse;
            if message_target /= Void and then 
               message_target.handle_2 (Current, SEL_LEFTBUTTONPRESS, message, data) then
            else
               press(True);
               flags := flags | Flag_pressed;
               unset_flags (Flag_update);
            end
            Result := True;
         end
      end

   on_left_btn_release (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         click: BOOLEAN;
      do
         if is_enabled and then (flags & Flag_pressed) /= 0 then
            click := down;
            release_mouse;
            if message_target/= Void and then 
               message_target.handle_2 (Current, SEL_LEFTBUTTONRELEASE, message, data) then
            else
               press(False);
               flags := flags | Flag_update;
               unset_flags (Flag_pressed);
               if click then
                  set_state(not state);
                  if message_target /= Void then
            --         message_target.do_handle_2 (Current, SEL_COMMAND, message, state);
                  end
               end
            end
            Result := True;
         end
      end

   on_key_press (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
      --   sbk: expanded SB_KEYS;
         event: SB_EVENT;
      do
         event ?= data;
         check
            event /= Void;
         end
         unset_flags (Flag_tip);
         if is_enabled and then (flags & Flag_pressed) = 0 then
            if message_target /= Void and then message_target.handle_2 (Current, SEL_KEYPRESS, message, data)
             then
               Result := True;
            elseif event.code = sbk.key_space or event.code = sbk.key_kp_space then
               press(True);
               flags := flags | Flag_pressed;
               unset_flags (Flag_update);
               Result := True;
            end
         end
      end

   on_key_release (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
       --  sbk: expanded SB_KEYS;
         event: SB_EVENT;
         click: BOOLEAN;
      do
         event ?= data;
         check
            event /= Void;
         end
         if is_enabled and then (flags & Flag_pressed) /= 0 then
            if message_target /= Void 
               and then message_target.handle_2 (Current, SEL_KEYRELEASE, message, data) then
               Result := True;
            elseif event.code = sbk.key_space or event.code = sbk.key_kp_space then
               press(False);
               set_state(not state);
               flags := flags | Flag_update;
               unset_flags (Flag_pressed);
               if message_target /= Void then
          --		message_target.do_handle_2 (Current, SEL_COMMAND, message, state);
               end
               Result := True;
            end
         end
      end

   on_hot_key_press (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         do_handle_2 (Current, SEL_FOCUS_SELF, 0, data);
         unset_flags (Flag_tip);
         if is_enabled and (flags & Flag_pressed) = 0 then
            press(True);
            flags := flags | Flag_pressed;
            unset_flags (Flag_update);
         end
         Result := True;
      end

   on_hot_key_release (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         if is_enabled  and (flags & Flag_pressed) /= 0 then
            flags := flags | Flag_update;
            unset_flags (Flag_pressed);
            press(False);
            set_state(not state);
            if message_target /= Void then
         --		message_target.do_handle_2 (Current, SEL_COMMAND, message, state);
            end
         end
         Result := True;
      end

   on_check (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         set_state(True);
         Result := True;
      end

   on_uncheck (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         set_state(False);
         Result := True;
      end

   on_query_help (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         if (flags & Flag_help) /= 0 then
            if state then
               if not alt_help.is_empty then
                  sender.do_handle_2 (Current, SEL_COMMAND, Id_setstringvalue, alt_help);
                  Result := True;
               end
            end
            if not Result then
               if not help.is_empty then
                  sender.do_handle_2 (Current, SEL_COMMAND, Id_setstringvalue, help);
                  Result := True;
               end
            end
         end
      end

   on_query_tip (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         if (flags & Flag_tip) /= 0 then
            if state then
               if not alt_tip.is_empty then
                  sender.do_handle_2 (Current, SEL_COMMAND, Id_setstringvalue, alt_tip);
                  Result := True;
               end
            end
            if not Result then
               if not tip.is_empty then
                  sender.do_handle_2 (Current, SEL_COMMAND, Id_setstringvalue, tip);
                  Result := True;
               end
            end
         end
      end

   on_cmd_set_value,on_cmd_set_int_value (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
         -- TODO - clear the semantic and usage of this function.
      local
         s: BOOLEAN_REF;
      do
         s ?= data;
         if s /= Void then
            set_state(s.item);
         end
      end

   on_cmd_get_int_value (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
         -- TODO - clear the semantic and usage of this function.
      local
         s: BOOLEAN_REF;
      do
         s ?= data;
         if s /= Void then
            s.set_item(state);
         end
      end

feature -- Destruction

   destruct
      do
         remove_hot_key(alt_hot_key);
         alt_icon := Void
         Precursor;
      end


feature {NONE} -- Implementation

   alt_hot_off: INTEGER;

   alt_hot_key: INTEGER;

   down: BOOLEAN;

   press(dn: BOOLEAN)
      do
         if down /= dn then
            down := dn;
            update;
         end
      end
end
