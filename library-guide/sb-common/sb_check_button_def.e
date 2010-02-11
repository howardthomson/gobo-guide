indexing
	description: "[
		A check button is a tri-state button. Normally, it is either
		True or False, and toggles  between TRUE or FALSE whenever it is
		pressed. A third state MAYBE may be set to indicate that no
		selection has been made yet by the user, or that the state is ambiguous.
		When pressed, the check button sends a SEL_COMMAND to its target,
		and the message data represents the state of the check button.
			]"
	author:	"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

deferred class SB_CHECK_BUTTON_DEF

inherit

   SB_LABEL
      rename
         make as label_make,
         make_opts as label_make_opts
      redefine
         can_focus,
         default_height,
         default_width,
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
         class_name
      end

   SB_CHECK_BUTTON_CONSTANTS

--creation

--   make, make_opts

feature -- class name

	class_name: STRING is
		once
			Result := "SB_CHECK_BUTTON"
		end

feature -- Creation

	make(p: SB_COMPOSITE; text: STRING;
			tgt: SB_MESSAGE_HANDLER; sel: INTEGER;
			opts: INTEGER) is
			-- Construct check button label with given text
		local
			o: INTEGER;
		do
			if opts = Zero then
				o := CHECKBUTTON_NORMAL;
			else
				o := opts
			end
			make_opts(p, text, tgt,sel, o, 0,0,0,0,
				DEFAULT_PAD, DEFAULT_PAD, DEFAULT_PAD, DEFAULT_PAD);
		end

	make_opts(p: SB_COMPOSITE; text: STRING;
  				tgt: SB_MESSAGE_HANDLER; sel: INTEGER;
  				opts: INTEGER;
        	    x,y,w,h,
        	    pl,pr,pt,pb: INTEGER) is
         -- Construct a check button
      do
         label_make_opts(p, text, Void, opts, x,y,w,h, pl,pr,pt,pb);
         message_target := tgt;
         message := sel;
         state := 0;
         old_state := 0;
         box_color := application.back_color;
      end

feature -- Data

      state: INTEGER;
      old_state: INTEGER;
      box_color: INTEGER;

feature -- Queries

   can_focus: BOOLEAN is
         -- Returns true because a check button can receive focus
      once
         Result := True;
      end

   default_width: INTEGER is
         -- Get default width
      local
         tw, s, w: INTEGER;
      do
         if not label.is_empty then
            tw := label_width(label);
            s := 4;
         end
         if (options & (ICON_AFTER_TEXT | ICON_BEFORE_TEXT)) = Zero then
            w := tw.max(13);
         else
            w := tw+13+s;
         end
         Result := pad_left+pad_right+w+(border*2);
      end

   default_height: INTEGER is
         -- Get default width
      local
         th, h: INTEGER;
      do
         if not label.is_empty then
            th := label_height(label);
         end
         if (options & (ICON_ABOVE_TEXT | ICON_BELOW_TEXT)) = Zero then
            h := th.max(13);
         else
            h := th+13;
         end
         Result := pad_top+pad_bottom+h+(border*2);
      end

   get_check_button_style: INTEGER is
         -- Return current check button style
      do
         Result := options & CHECKBUTTON_MASK
      end

feature -- Actions

   set_state (s: INTEGER) is
         -- Set check button state (TRUE, FALSE or MAYBE)
      do
         if state /= s then
            state := s;
            update;
         end
      end

   set_check_button_style (style: INTEGER) is
         -- Change check button style
      local
         opts: INTEGER;
      do
         opts := new_options (style, CHECKBUTTON_MASK)
         if options /= opts then
            options := opts
            update
         end
      end

   set_box_color (clr: INTEGER) is
         -- Set the box background color
      do
         if clr /= box_color then
            box_color := clr
            update
         end
      end

feature -- Message processing

	handle_2 (sender: SB_MESSAGE_HANDLER; type, key: INTEGER; data: ANY): BOOLEAN is
		do
        	if		match_function_2 (SEL_COMMAND, Id_check, 		type, key) then Result := on_check				(sender, key, data);
        	elseif  match_function_2 (SEL_COMMAND, Id_uncheck, 		type, key) then Result := on_uncheck			(sender, key, data);
        	elseif  match_function_2 (SEL_COMMAND, Id_unknown, 		type, key) then Result := on_unknown			(sender, key, data);
        	elseif  match_function_2 (SEL_COMMAND, Id_setvalue,		type, key) then Result := on_cmd_set_value		(sender, key, data);
        	elseif  match_function_2 (SEL_COMMAND, Id_setintvalue,	type, key) then Result := on_cmd_set_int_value	(sender, key, data);
        	elseif  match_function_2 (SEL_COMMAND, Id_getintvalue,	type, key) then Result := on_cmd_get_int_value	(sender, key, data);
        	else Result := Precursor(sender, type, key, data)
        	end
      	end

	seg_make(ix, iy: INTEGER): ARRAY [SB_SEGMENT] is
		deferred
		end

   on_paint (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      local
         event: SB_EVENT;
         dc: SB_DC_WINDOW;
         tw,th,tx,ty,ix,iy: INTEGER
         px, py: SB_POINT;
         seg: ARRAY [SB_SEGMENT];
         s: SB_SEGMENT;
      do
         event ?= data;
         if event /= Void then
         	dc := paint_dc
            dc.make_event(Current,event);
            dc.set_foreground(back_color);
            dc.fill_rectangle(event.rect_x,event.rect_y,event.rect_w,event.rect_h);

            if not label.is_empty then
               tw := label_width(label);
               th := label_height(label);
            end
            px := just_x(tw,13);
            py := just_y(th,13);

            ix := px.x;
            iy := py.x;
            tx := px.y;
            ty := py.y;

            dc.set_foreground(shadow_color);
            dc.fill_rectangle(ix,iy,12,1);
            dc.fill_rectangle(ix,iy,1,12);

            dc.set_foreground(border_color);
            dc.fill_rectangle(ix+1,iy+1,10,1);
            dc.fill_rectangle(ix+1,iy+1,1,10);

            dc.set_foreground(hilite_color);
            dc.fill_rectangle(ix,iy+12,13,1);
            dc.fill_rectangle(ix+12,iy,1,13);

            dc.set_foreground(base_color);
            dc.fill_rectangle(ix+1,iy+11,11,1);
            dc.fill_rectangle(ix+11,iy+1,1,11);

            if state = SB_MAYBE or else not is_enabled then
               dc.set_foreground(base_color);
            else
               dc.set_foreground(box_color);
            end
            dc.fill_rectangle(ix+2,iy+2,9,9);

            if state /= SB_FALSE then

				seg := seg_make(ix, iy)
               if is_enabled then
                  if state = SB_MAYBE then
                     dc.set_foreground(shadow_color);
                  else
                     dc.set_foreground(text_color);
                  end
               else
                  dc.set_foreground(shadow_color);
               end
               dc.draw_line_segments(seg);
            end

            if not label.is_empty then
               dc.set_font(font);
               if is_enabled then
                  dc.set_foreground(text_color);
                  draw_label(dc,label,hot_off,tx,ty,tw,th);
                  if has_focus then
                     dc.draw_focus_rectangle(tx-1,ty-1,tw+2,th+2);
                  end
               else
                  dc.set_foreground(hilite_color);
                  draw_label(dc,label,hot_off,tx+1,ty+1,tw,th);
                  dc.set_foreground(shadow_color);
                  draw_label(dc,label,hot_off,tx,ty,tw,th);
               end
            end

            draw_frame(dc,0,0,width,height);
            dc.stop;
            Result := True
         end
      end

   on_update (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         if not Precursor(sender,selector,data) then
            if (options & CHECKBUTTON_AUTOHIDE) /= Zero then
               if is_shown then
                  hide;
                  recalc
               end
            end
            if (options & CHECKBUTTON_AUTOGRAY) /= Zero then
               disable
            end
         end
         Result := True
      end

   on_enter (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         Result := Precursor (sender,selector,data);
         if is_enabled and then (flags & Flag_pressed) /= Zero then
            if old_state = SB_FALSE then
               set_state(SB_TRUE);
            else
               set_state(SB_FALSE);
            end
         end
         Result := True
      end

   on_leave (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         Result := Precursor (sender,selector,data);
         if is_enabled and then (flags & Flag_pressed) /= Zero then
               set_state(old_state);
         end
         Result := True
      end

   on_focus_in (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         Result := Precursor(sender,selector,data);
         update_rectangle(border,border,width-border*2,height-border*2);
         Result := True
      end

   on_focus_out (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         Result := Precursor(sender,selector,data);
         update_rectangle(border,border,width-border*2,height-border*2);
         Result := True
      end

   on_ungrabbed (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         Result := Precursor(sender,selector,data);
         set_state(old_state);
         unset_flags (Flag_pressed);
         flags := flags | Flag_update;
         Result := True
      end

   on_left_btn_press (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         do_handle_2 (Current, SEL_FOCUS_SELF, 0, data);
         unset_flags (Flag_tip);
         if is_enabled and then (flags & Flag_pressed) = Zero then
            grab_mouse;
            if message_target /= Void and then
               message_target.handle_2 (Current, SEL_LEFTBUTTONPRESS, message, data) then
            else
               old_state := state;
               if old_state = SB_FALSE then
                  set_state(SB_TRUE);
               else
                  set_state(SB_FALSE);
               end
               flags := flags | Flag_pressed;
               unset_flags (Flag_update);
            end
            Result := True
         end
      end

   on_left_btn_release (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      local
         click: BOOLEAN;
      do
         if is_enabled and then (flags & Flag_pressed) /= Zero then
            release_mouse;
            if message_target/= Void and then
               message_target.handle_2 (Current, SEL_LEFTBUTTONRELEASE, message, data) then
            else
               flags := flags | Flag_update;
               unset_flags (Flag_pressed);
               if state /= old_state and then message_target /= Void then
                  message_target.do_handle_2 (Current, SEL_COMMAND, message, ref_integer(state));
               end
            end
            Result := True
         end
      end

   on_key_press (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      local
      --   sbk: expanded SB_KEYS;
         event: SB_EVENT;
      do
         event ?= data;
         unset_flags (Flag_tip);
         if is_enabled and then (flags & Flag_pressed) = Zero then
            if message_target /= Void and then message_target.handle_2 (Current, SEL_KEYPRESS, message, data)
             then
               Result := True
            elseif event /= Void and then (event.code = sbk.key_space or event.code = sbk.key_kp_space)
             then
               old_state := state;
               if old_state = SB_FALSE then
                  set_state(SB_TRUE);
               else
                  set_state(SB_FALSE);
               end
               flags := flags | Flag_pressed;
               unset_flags (Flag_update);
               Result := True
            end
         end
      end

   on_key_release (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      local
      --   sbk: expanded SB_KEYS;
         event: SB_EVENT;
         click: BOOLEAN;
      do
         event ?= data;
         if is_enabled and then (flags & Flag_pressed) /= Zero then
            if message_target /= Void
               and then message_target.handle_2 (Current, SEL_KEYRELEASE, message, data) then
               Result := True
            elseif event /= Void and then (event.code = sbk.key_space or event.code = sbk.key_kp_space)
             then
               flags := flags | Flag_update;
               unset_flags (Flag_pressed);
               if state /= old_state and then message_target /= Void then
                  message_target.do_handle_2 (Current, SEL_COMMAND, message, ref_integer(state));
               end
               Result := True
            end
         end
      end

   on_hot_key_press (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         unset_flags (Flag_tip);
         do_handle_2 (Current, SEL_FOCUS_SELF, 0, data);
         if is_enabled and (flags & Flag_pressed) = Zero then
            old_state := state;
            if old_state = SB_FALSE then
               set_state(SB_TRUE);
            else
               set_state(SB_FALSE);
            end
            flags := flags | Flag_pressed;
            unset_flags (Flag_update);
         end
         Result := True
      end

   on_hot_key_release (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         if is_enabled  and (flags & Flag_pressed) /= Zero then
            flags := flags | Flag_update;
            unset_flags (Flag_pressed);
            if state /= old_state and then message_target /= Void then
               message_target.do_handle_2 (Current, SEL_COMMAND, message, ref_integer(state));
            end
         end
         Result := True
      end

   on_check (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         set_state(SB_TRUE);
         Result := True
      end

   on_uncheck (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         set_state(SB_FALSE);
         Result := True;
      end

   on_unknown (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         set_state(SB_MAYBE);
         Result := True;
      end

   on_cmd_set_value, on_cmd_set_int_value (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
         -- TODO - clear the semantic and usage of this function.
      local
         s: INTEGER_REF;
      do
         s ?= data;
         if s /= Void then
            set_state(s.item);
         end
      end

   on_cmd_get_int_value (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
         -- TODO - clear the semantic and usage of this function.
      local
         s: INTEGER_REF;
      do
         s ?= data;
         if s /= Void then
            s.set_item(state);
         end
      end
end
