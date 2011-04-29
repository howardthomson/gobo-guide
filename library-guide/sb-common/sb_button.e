-- Mods needed: Add some hysteresis to click, to ensure that a visible response occurs
indexing
	description: "[
   		A button provides a push button, with optional icon and/or text label.
   		When pressed, the button widget sends a SEL_COMMAND to its target.
	]"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

	todo: "[
				Alter button release processing to ensure time delay of press/release
				events when activated, so that the display change is visible for long
				enough to be humanly distinguished.
	]"

class SB_BUTTON

inherit

	SB_LABEL
    	rename
			make_ev as label_make_ev,
			make_sb as label_make_sb,
			make_opts as label_make_opts,
			make_opts_ev as label_make_opts_ev
      	redefine
         	make,
         	can_focus,
         	kill_focus,
         	set_focus,
         	set_default,
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
		
	SB_BUTTON_CONSTANTS
	SB_REFERENCE_BOOLEAN

create

	make_sb,
	make,
	make_opts,
	make_ev

feature -- class name

	class_name: STRING is
		once
			Result := "SB_BUTTON"
		end

feature -- Creation

	make_ev is
		do
			make_opts_ev (once "", Void, Void, 0, BUTTON_NORMAL, 0,0,0,0, DEFAULT_PAD, DEFAULT_PAD,DEFAULT_PAD, DEFAULT_PAD)
		end			

	make_opts_ev (text: STRING; ic: SB_ICON;
					tgt: SB_MESSAGE_HANDLER; sel: INTEGER; opts: INTEGER;
			x,y, w,h, pl,pr, pt,pb: INTEGER) is
			-- Construct button with text and icon
		do
         	label_make_opts_ev (text, ic, opts, x,y,w,h, pl,pr,pt,pb)
         	message_target := tgt
         	message := sel
         	state := STATE_UP
         	if (options & BUTTON_INITIAL) /= 0 then
            	set_initial (True)
            	set_default (1)
         	end
      	end

	make (p: SB_COMPOSITE; text: STRING) is
			-- Construct label with given text and icon
		do
			make_opts (p, text,Void, Void,0, BUTTON_NORMAL, 0,0,0,0, DEFAULT_PAD, DEFAULT_PAD,DEFAULT_PAD, DEFAULT_PAD);
		end

	make_sb (p: SB_COMPOSITE; text: STRING; tgt: SB_MESSAGE_HANDLER; selector: INTEGER; opts: INTEGER) is
			-- Construct label with given text
		local
			o: INTEGER
		do
			if opts = 0 then
				o := BUTTON_NORMAL
			else
				o := opts
			end
			make_opts (p, text, Void, tgt, selector, o, 0,0, 0,0,
					DEFAULT_PAD, DEFAULT_PAD, DEFAULT_PAD, DEFAULT_PAD);
		end

	make_opts (p: SB_COMPOSITE; text: STRING; ic: SB_ICON;
					tgt: SB_MESSAGE_HANDLER; sel: INTEGER; opts: INTEGER;
			x,y, w,h, pl,pr, pt,pb: INTEGER) is
			-- Construct button with text and icon
		do
         	label_make_opts (p, text,ic, opts, x,y,w,h, pl,pr,pt,pb)
         	message_target := tgt
         	message := sel
         	state := STATE_UP
         	if (options & BUTTON_INITIAL) /= 0 then
            	set_initial (True)
            	set_default (1)
         	end
      	end

feature

	state: INTEGER

feature -- Message processing

	handle_2 (sender: SB_MESSAGE_HANDLER; type, key: INTEGER; data: ANY): BOOLEAN is
    	do
         	if match_function_2		(SEL_COMMAND,Id_check, 		type, key) then Result := on_check				(sender, key, data)
         	elseif match_function_2	(SEL_COMMAND,Id_uncheck, 	type, key) then Result := on_uncheck			(sender, key, data)
         	elseif match_function_2	(SEL_COMMAND,Id_setvalue,	type, key) then Result := on_cmd_set_value		(sender, key, data)
         	elseif match_function_2	(SEL_COMMAND,Id_setintvalue,type, key) then Result := on_cmd_set_int_value	(sender, key, data)
         	elseif match_function_2	(SEL_COMMAND,Id_getintvalue,type, key) then Result := on_cmd_get_int_value	(sender, key, data)
         	else
         		Result := Precursor (sender, type, key, data)
			end
		end

	on_paint (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
		local
			event: SB_EVENT
			dc: SB_DC_WINDOW
			tw, th, iw, ih, tx, ty, ix, iy: INTEGER
			pt: SB_POINT
		do
			event ?= data
			check
				event /= Void
			end
			dc := paint_dc         
			dc.make_event (Current, event)

			if (options & (Frame_raised | Frame_sunken)) /= 0 then
					-- Got a border at all?
				if (options & BUTTON_TOOLBAR) /= 0 then
						-- Toolbar style
					if is_enabled and then is_under_cursor and then state = STATE_UP then
							-- Enabled and cursor inside, and up
						dc.set_foreground (back_color)
						dc.fill_rectangle (border, border, width-border * 2, height-border * 2)
						if (options & Frame_thick) /= 0 then
							draw_double_raised_rectangle (dc, 0,0, width, height)
						else
							draw_raised_rectangle (dc, 0, 0, width, height);
						end
					elseif is_enabled and then is_under_cursor and then state = STATE_DOWN then
							-- Enabled and cursor inside and down
						dc.set_foreground (back_color)
						dc.fill_rectangle (border, border, width - border * 2, height - border * 2)
						if (options & Frame_thick) /= 0 then
							draw_double_sunken_rectangle (dc, 0, 0, width, height)
						else
							draw_sunken_rectangle (dc, 0, 0, width, height)
						end
					elseif is_enabled and then state = STATE_ENGAGED then
							-- Enabled and checked
						dc.set_foreground (hilite_color)
						dc.fill_rectangle (border, border, width - border * 2, height - border * 2)
						if (options & Frame_thick) /= 0 then
							draw_double_sunken_rectangle (dc, 0, 0, width, height)
						else
							draw_sunken_rectangle(dc, 0, 0, width, height)
						end
					else
							-- Disabled or unchecked or not under cursor
						dc.set_foreground (back_color)
						dc.fill_rectangle (0, 0, width, height)
					end               
				else
						-- Normal style
					if default_flags then
							-- Default
						if not is_enabled or else state = STATE_UP then
								-- Draw in up state if disabled or up
							dc.set_foreground (back_color)
							dc.fill_rectangle (border + 1, border + 1, width - border * 2 - 1, height - border * 2 - 1)
							if (options & Frame_thick) /= 0 then
								draw_double_raised_rectangle (dc, 1, 1, width-1, height-1)
							else
								draw_raised_rectangle (dc, 1, 1, width-1, height-1)
							end
						else
								-- Draw sunken if enabled and either checked or pressed
							if state = STATE_ENGAGED then
								dc.set_foreground (hilite_color)
							else
								dc.set_foreground (back_color)
							end
							dc.fill_rectangle (border, border, width - border * 2 - 1, height - border * 2 - 1)
							if (options & Frame_thick) /= 0 then
								draw_double_sunken_rectangle (dc, 0, 0, width - 1, height - 1)
							else
								draw_sunken_rectangle (dc, 0, 0, width - 1, height - 1)
							end
						end
							-- Black default border
						draw_border_rectangle (dc, 0, 0, width, height)
					else
							-- Non-Default
						if not is_enabled or else state = STATE_UP then
								-- Draw in up state if disabled or up
							dc.set_foreground (back_color)
							dc.fill_rectangle (border, border, width - border * 2, height - border * 2)
							if (options & Frame_thick) /= 0 then
								draw_double_raised_rectangle (dc, 0, 0, width, height)
							else
								draw_raised_rectangle (dc, 0, 0, width, height)
							end
							-- Draw sunken if enabled and either checked or pressed
						else
							if state = STATE_ENGAGED then
								dc.set_foreground (hilite_color)
							else
								dc.set_foreground (back_color)
							end
							dc.fill_rectangle (border, border, width - border * 2, height - border * 2)
							if (options & Frame_thick) /= 0 then
								draw_double_sunken_rectangle (dc, 0, 0, width, height)
							else
								draw_sunken_rectangle (dc, 0, 0, width, height)
							end
						end
					end
				end
			else
					-- No borders
				if is_enabled and then state = STATE_ENGAGED then
					dc.set_foreground (hilite_color);
					dc.fill_rectangle (0, 0, width, height)    
				else
					dc.set_foreground (back_color)
					dc.fill_rectangle (0, 0, width, height)
				end
			end            
				-- Place text & icon
			if not label.is_empty then
				tw := label_width (label)
				th := label_height (label)
			end
			if icon /= Void then
				iw := icon.width
				ih := icon.height
			end
			pt := just_x (tw,iw); ix := pt.x; tx := pt.y
			pt := just_y (th,ih); iy := pt.x; ty := pt.y

				-- Shift a bit when pressed
			if state /= 0 and then (options & (Frame_raised | Frame_sunken)) /= 0 then
				tx := tx+1
				ty := ty+1
				ix := ix+1
				iy := iy+1
			end

				-- Draw the icon
			if icon /= Void then
				if is_enabled then
					dc.draw_icon (icon,ix,iy)
				else
					dc.draw_icon_sunken (icon,ix,iy)
				end
			end

				-- Draw the text
			if not label.is_empty then
				dc.set_font (font)
				if is_enabled then
					dc.set_foreground (text_color)
					draw_label(dc, label, hot_off, tx, ty, tw, th)
					if has_focus then
						dc.draw_focus_rectangle (border + 2, border + 2, width - 2 * border - 4, height - 2 * border - 4)
					end
				else
					dc.set_foreground (hilite_color)
					draw_label (dc, label, hot_off, tx + 1, ty + 1, tw, th)
					dc.set_foreground (shadow_color)
					draw_label (dc, label, hot_off, tx, ty, tw, th)
				end
			end
			dc.stop
			Result := True
		end

   on_update (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         if not Precursor(sender,selector,data) then
            if (options & BUTTON_AUTOHIDE) /= 0 then
               if is_shown then
                  hide
                  recalc
               end
            end
            if (options & BUTTON_AUTOGRAY) /= 0 then
               disable
            end
         end
         Result := True
      end

   on_enter (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         Result := Precursor (sender, selector, data)
         if is_enabled then
            if (flags & Flag_pressed) /= 0 and then state /= STATE_ENGAGED then
               set_state(STATE_DOWN);
            end
            if (options & BUTTON_TOOLBAR) /= 0 then
               update
            end
         end
         Result := True
      end

   on_leave (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         Result := Precursor (sender, selector, data)
         if is_enabled then
            if (flags & Flag_pressed) /= 0 and then state /= STATE_ENGAGED then
               set_state(STATE_UP)
            end
            if (options & BUTTON_TOOLBAR) /= 0 then
               update
            end
         end
         Result := True
      end

   on_focus_in (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         Result := Precursor (sender, selector, data)
         update
         Result := True
      end

   on_focus_out (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         Result := Precursor (sender, selector, data)
         update;
         Result := True
      end

   on_ungrabbed (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         Result := Precursor (sender, selector, data)
         if state /= STATE_ENGAGED then
            set_state(STATE_UP)
         end
         unset_flags (Flag_pressed)
         set_flags (Flag_update)
         Result := True
      end

   on_left_btn_press (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         do_handle_2 (Current, SEL_FOCUS_SELF, 0, data);
         unset_flags (Flag_tip)
         if is_enabled and then (flags & Flag_pressed) = 0 then
            grab_mouse
            if message_target /= Void and then 
               message_target.handle_2 (Current, SEL_LEFTBUTTONPRESS, message, data) then
            else
               if state /= STATE_ENGAGED then
                  set_state(STATE_DOWN);
               end
               set_flags (Flag_pressed)
               unset_flags (Flag_update)
            end
            Result := True
         end
      end

   on_left_btn_release (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      local
         click: BOOLEAN
      do
         click := state = STATE_DOWN
         if is_enabled and then (flags & Flag_pressed) /= 0 then
            release_mouse;
            if message_target /= Void and then 
               message_target.handle_2 (Current, SEL_LEFTBUTTONRELEASE, message, data) then
        --#		fx_trace(0, <<"SB_BUTTON::on_left_button_release -- LeftButtonRelease handled by target!">>)
            else
               set_flags (Flag_update)
               unset_flags (Flag_pressed)
               if state /= STATE_ENGAGED then
                  set_state(STATE_UP)
               end
               if click and then message_target /= Void then
         --#		fx_trace(0, <<"SB_BUTTON::on_left_button_release -- Sending message">>)
                  message_target.do_handle_2 (Current, SEL_COMMAND, message, ref_true)
               end
            end
            Result := True
         end
      end

   on_key_press (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      local
         event: SB_EVENT
      do
         event ?= data
         unset_flags (Flag_tip)
         if is_enabled and then (flags & Flag_pressed) = 0 then
            if message_target /= Void and then message_target.handle_2 (Current, SEL_KEYPRESS, message, data)
             then
               Result := True
            elseif event /= Void and then (event.code = sbk.key_space or event.code = sbk.key_kp_space)
               or ((options & BUTTON_DEFAULT) /= 0 
                   and then (event.code = sbk.key_return or event.code = sbk.key_kp_enter))
             then
               if state /= STATE_ENGAGED then
                  set_state (STATE_DOWN)
               end
               set_flags (Flag_pressed)
               unset_flags (Flag_update)
               Result := True
            end
         end
      end

   on_key_release (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      local
         event: SB_EVENT
         click: BOOLEAN
      do
         click := state = STATE_DOWN
         event ?= data
         if is_enabled and then (flags & Flag_pressed) /= 0 then
            if message_target /= Void 
               and then message_target.handle_2 (Current, SEL_KEYRELEASE, message, data) then
               Result := True;
            elseif event /= Void and then (event.code = sbk.key_space or event.code = sbk.key_kp_space)
               or ((options & BUTTON_DEFAULT) /= 0 
                   and then (event.code = sbk.key_return or event.code = sbk.key_kp_enter))
             then
               if state /= STATE_ENGAGED then
                  set_state(STATE_UP)
               end
               set_flags (Flag_update)
               unset_flags (Flag_pressed)
               if click and then message_target /= Void then
                  message_target.do_handle_2 (Current, SEL_COMMAND, message, ref_true);
               end
               Result := True
            end
         end
      end

   on_hot_key_press (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         unset_flags (Flag_tip)
         do_handle_2 (Current, SEL_FOCUS_SELF, 0, data)
         if is_enabled and (flags & Flag_pressed) = 0 then
            if state /= STATE_ENGAGED then
               set_state (STATE_DOWN)
            end
            unset_flags (Flag_update)
            set_flags (Flag_pressed)
         end
         Result := True
      end

   on_hot_key_release (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      local
         click: BOOLEAN;
      do
         click := state = STATE_DOWN;
         if is_enabled and (flags & Flag_pressed) /= 0 then
            if state /= STATE_ENGAGED then
               set_state(STATE_UP)
            end
            set_flags (Flag_update)
            unset_flags (Flag_pressed)
            if click and then message_target /= Void then
               message_target.do_handle_2 (Current, SEL_COMMAND, message, ref_true)
            end
         end
         Result := True
      end

   on_check (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         set_state (STATE_ENGAGED)
         Result := True
      end

   on_uncheck (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         set_state (STATE_UP)
         Result := True
      end

   on_cmd_set_value, on_cmd_set_int_value (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
         -- TODO - clear the semantic and usage of this function.
      local
         s: INTEGER_REF
      do
         s ?= data;
         if s /= Void then
            set_state (s.item)
         end
      end

   on_cmd_get_int_value (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
         -- TODO - clear the semantic and usage of this function.
      local
         s: INTEGER_REF
      do
         s ?= data
         if s /= Void then
            s.set_item (state)
         end
      end

feature

	can_focus: BOOLEAN is
			-- Returns true because a button can receive focus
      	once
         	Result := True
      	end
   
	set_focus is
    		-- Move the focus to this window
      	do
         	Precursor
         	if (options & BUTTON_DEFAULT) /= 0 then
            	set_default (SB_TRUE)
         	end
         	update
      	end

	kill_focus is
    		-- Remove the focus from this window
      	do
         	Precursor
         	if (options & BUTTON_DEFAULT) /= 0 then
            	set_default (SB_MAYBE)
         	end
         	update
      	end

   	set_default(enable_: INTEGER) is
         	-- Set as default button
      	do
         	Precursor(enable_)
         	update;
      	end

   	set_state(s: INTEGER) is
         	-- Set the button state
      	do
         	if state /= s then
         		--	fx_trace(0, <<"SB_BUTTON::set_state ", s.out>>)
            	state := s
            	update;
			end
      	end

   	set_button_style(style: INTEGER) is
         	-- Set the button style flags
      	local
         	opts: INTEGER
      	do
         	opts := new_options (style, BUTTON_MASK)
         	if options /= opts then
            	options := opts
            	update
         	end
      	end

	get_button_style: INTEGER is
			-- Get the button style flags
		do
			Result := (options & BUTTON_MASK)
		end
end
