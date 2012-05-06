note
	description: "[
		A menu button posts a popup menu when clicked. There
		are many ways to control the placement where the popup will appear;
		first,the popup may be placed on either of the four sides relative
		to the menu button; this is controlled by the flags MENUBUTTON_DOWN,
		etc. Next, there are several attachment modes; the popup's left/
		bottom edge may attach to the menu button's left/top edge, or the popup's
		right/top edge may attach to the menu button's right/bottom edge, or
		both. Also, the popup may apear centered relative to the menu 
		button. Finally, a small offset may be specified to displace the location
		of the popup by a few pixels so as to account for borders and so on. Normally,
		the menu button shows an arrow pointing to the direction where the popup is
		set to appear; this can be turned off by passing the option MENUBUTTON_NOARROWS.
	]"

	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"mostly complete"

class SB_MENU_BUTTON

inherit

   SB_LABEL
      rename
         make as label_make,
         make_opts as label_make_opts
      redefine
         default_width,
         default_height,
         can_focus,
         contains,
         kill_focus,
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
         on_motion,
         on_update,
         create_resource,
         detach_resource,
         destruct,
         class_name
      end

   SB_MENU_BUTTON_CONSTANTS

create

   make,
   make_opts

feature -- class name

	class_name: STRING
		once
			Result := "SB_MENU_BUTTON"
		end

feature -- Creation

	make (p: SB_COMPOSITE; text: STRING; ic: SB_ICON; pup: SB_POPUP; opts: INTEGER)
    		-- Make a menu button
      	local
         	o: INTEGER
      	do
         	if opts = 0 then
            	o := JUSTIFY_NORMAL | ICON_BEFORE_TEXT | MENUBUTTON_DOWN;
         	else
            	o := opts
         	end
         	make_opts(p, text, ic, pup, o,
				0,0,0,0, DEFAULT_PAD, DEFAULT_PAD, DEFAULT_PAD, DEFAULT_PAD);
      	end

	make_opts (p: SB_COMPOSITE; text: STRING; ic: SB_ICON; pup: SB_POPUP; opts: INTEGER;
    			x,y,w,h, pl,pr,pt,pb: INTEGER)
			-- Make a menu button
      	do
         	label_make_opts(p,text,ic,opts,x,y,w,h,pl,pr,pt,pb);
         	menu := pup;
         	offset_x := 0;
         	offset_y := 0;
         	state := False;
      	end

feature -- Data

   menu: SB_POPUP;
         -- Pane to pop up

   offset_x: INTEGER;
         -- Shift attachment point x

   offset_y: INTEGER;
      -- Shift attachment point y

   state: BOOLEAN;
         -- True if the menu was popped

feature -- Queries

   default_width : INTEGER
         -- Return default width
      local
         tw,iw,s,pw: INTEGER;
      do
         if not label.is_empty then
            tw := label_width(label);
            s := 4;
         end
         if (options & MENUBUTTON_NOARROWS) = 0 then
            if (options & MENUBUTTON_LEFT) /= 0 then
               iw := MENUBUTTONARROW_HEIGHT;
            else
               iw := MENUBUTTONARROW_WIDTH;
            end
         end
         if icon /= Void then
            iw := icon.width;
         end
         if (options & (ICON_AFTER_TEXT | ICON_BEFORE_TEXT)) = 0 then
            Result := tw.max(iw);
         else
            Result := tw+iw+s;
         end
         Result := pad_left+pad_right+border*2+Result;
         if (options & MENUBUTTON_LEFT) = 0 and then 
            (options & MENUBUTTON_ATTACH_RIGHT) /= 0 
               and then (options & MENUBUTTON_ATTACH_CENTER) /= 0
          then
            if menu /= Void then
               pw := menu.default_width;
               Result := Result.max(pw);
            end
         end
      end

   default_height : INTEGER
         -- Return default height
      local
         th,ih,ph: INTEGER;
      do
         if not label.is_empty then
            th := label_height(label);
         end
         if (options & MENUBUTTON_NOARROWS) = 0 then
            if (options & MENUBUTTON_LEFT) /= 0 then
               ih := MENUBUTTONARROW_WIDTH;
            else
               ih := MENUBUTTONARROW_HEIGHT;
            end
         end
         if icon /= Void then
            ih := icon.height;
         end
         if (options & (ICON_ABOVE_TEXT | ICON_BELOW_TEXT)) = 0 then
            Result := th.max(ih);
         else
            Result := th+ih;
         end

         Result := pad_top+pad_bottom+border*2+Result;
         if (options & MENUBUTTON_LEFT) /= 0 
            and then (options & MENUBUTTON_ATTACH_BOTTOM) /= 0
            and then (options & MENUBUTTON_ATTACH_CENTER) /= 0
          then
            if menu /= Void then
               ph := menu.default_height;
               Result := Result.max(ph);
            end
         end
      end

   can_focus: BOOLEAN
         -- Returns true because a menu button can receive focus
      once
         Result := True;
      end

   contains (parentx,parenty: INTEGER): BOOLEAN
         -- Return true if window logically contains the given point
      do
         Result := menu /= Void and then  menu.is_shown 
            and then menu.contains(parentx,parenty);
      end

   get_button_style: INTEGER
         -- Get menu button style
      do
         Result := (options & MENUBUTTON_MASK)
      end

   get_popup_style: INTEGER
         -- Get popup style
      do
         Result := (options & POPUP_MASK)
      end

   get_attachment: INTEGER
         -- Get attachment
      do
         Result := (options & ATTACH_MASK)
      end

feature -- Actions

   kill_focus
         -- Remove the focus from this window
      do
         Precursor;
         do_handle_2 (Current, SEL_COMMAND, Id_unpost, Void)
      end


   set_menu (a_popup: SB_POPUP)
         -- Change the popup menu
      do
         menu := a_popup
      end

   set_offset_x (offx: INTEGER)
         -- Set X offset where menu pops up relative to button
      do
         offset_x := offx
      end

   set_offset_y (offy: INTEGER)
         -- Set Y offset where menu pops up relative to button
      do
         offset_y := offy
      end

   set_button_style (style: INTEGER)
         -- Change menu button style
      local
         opts: INTEGER
      do
         opts := new_options (style, MENUBUTTON_MASK)
         if options /= opts then
            options := opts
            update
         end
      end

   set_popup_style (style: INTEGER)
         -- Change popup style
      local
         opts: INTEGER;
      do
         opts := new_options (style, POPUP_MASK)
         if options /= opts then
            options := opts
            update
         end
      end

   set_attachment (att: INTEGER)
         -- Change attachment
      local
         opts: INTEGER
      do
         opts := new_options (att, ATTACH_MASK)
         if options /= opts then
            options := opts
            update
         end
      end

feature -- Message processing

	handle_2 (sender: SB_MESSAGE_HANDLER; type, key: INTEGER; data: ANY): BOOLEAN
      	do
         	if 		match_function_2 (SEL_COMMAND,Id_post,   type, key) then Result := on_cmd_post (sender, key, data)
         	elseif  match_function_2 (SEL_COMMAND,Id_unpost, type, key) then Result := on_cmd_unpost (sender, key, data)
         	else Result := Precursor (sender, type, key, data)
         	end
      	end

   on_paint (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         tw,th,iw,ih,tx,ty,ix,iy: INTEGER
         ev: SB_EVENT
         points: ARRAY[SB_POINT]
         dc: SB_DC_WINDOW
         pt: SB_POINT
      do
         ev ?= data
         check
            ev /= Void
         end
         dc := paint_dc
         dc.make_event (Current, ev)

         if (options & (Frame_raised | Frame_sunken)) /= 0 then
            -- Got a border at all?
            if (options & MENUBUTTON_TOOLBAR) /= 0 then
               -- Toolbar style
               if is_enabled and then is_under_cursor and then not state then
                  -- Enabled and cursor inside, and not popped up
                  dc.set_foreground(back_color);
                  dc.fill_rectangle(border,border,width-border*2,height-border*2);
                  if (options & Frame_thick) /= 0 then
                     draw_double_raised_rectangle(dc,0,0,width,height);
                  else
                     draw_raised_rectangle(dc,0,0,width,height);
                  end
               elseif is_enabled and then state then
                  -- Enabled and popped up
                  dc.set_foreground(hilite_color);
                  dc.fill_rectangle(border,border,width-border*2,height-border*2);
                  if (options & Frame_thick) /= 0 then
                     draw_double_sunken_rectangle(dc,0,0,width,height);
                  else 
                     draw_sunken_rectangle(dc,0,0,width,height);
                  end
               else
                  -- Disabled or unchecked or not under cursor
                  dc.set_foreground(back_color);
                  dc.fill_rectangle(0,0,width,height);
               end
            else
               -- Normal style
               if not is_enabled  or  not state then
                  -- Draw in up state if disabled or up
                  dc.set_foreground(back_color);
                  dc.fill_rectangle(border,border,width-border*2,height-border*2);
                  if (options & Frame_thick) /= 0 then
                     draw_double_raised_rectangle(dc,0,0,width,height);
                  else
                     draw_raised_rectangle(dc,0,0,width,height);
                  end
               else
                  -- Draw sunken if enabled and either checked or pressed
                  dc.set_foreground(hilite_color);
                  dc.fill_rectangle(border,border,width-border*2,height-border*2);
                  if (options & Frame_thick) /= 0 then
                     draw_double_sunken_rectangle(dc,0,0,width,height);
                  else
                     draw_sunken_rectangle(dc,0,0,width,height);
                  end
               end
            end
         else
            -- No borders
            if is_enabled and then state then
               dc.set_foreground(hilite_color);
               dc.fill_rectangle(0,0,width,height);
            else
               dc.set_foreground(back_color);
               dc.fill_rectangle(0,0,width,height);
            end
         end

         -- Position text & icon
         if not label.is_empty then
            tw := label_width(label);
            th := label_height(label);
         end

         if icon /= Void then
            -- Icon?
            iw := icon.width;
            ih := icon.height;
         elseif (options & MENUBUTTON_NOARROWS) = 0 then
            -- Arrows?
            if (options & MENUBUTTON_LEFT) /= 0 then
               ih := MENUBUTTONARROW_WIDTH;
               iw := MENUBUTTONARROW_HEIGHT;
            else
               iw := MENUBUTTONARROW_WIDTH;
               ih := MENUBUTTONARROW_HEIGHT;
            end
         end

         -- Keep some room for the arrow!
         pt := just_x(tw,iw);ix := pt.x; tx := pt.y;
         pt := just_y(th,ih);iy := pt.x; ty := pt.y;

         -- Move a bit when pressed
         if state then 
            tx := tx + 1;
            ty := ty + 1;
            ix := ix + 1;
            iy := iy + 1;
         end

         if icon /= Void then
            -- Draw icon
            if is_enabled then
               dc.draw_icon(icon,ix,iy);
            else
               dc.draw_icon_sunken(icon,ix,iy);
            end
         elseif (options & MENUBUTTON_NOARROWS) = 0 then
            -- Draw arrows
            if (options & MENUBUTTON_RIGHT) = MENUBUTTON_RIGHT then
               -- Right arrow
               if is_enabled then
                  dc.set_foreground(text_color);
               else
                  dc.set_foreground(shadow_color);
               end
               create points.make(0,2);
               create pt.make(ix,iy);
               points.put(pt,0);
               create pt.make(ix,iy+MENUBUTTONARROW_WIDTH-1);
               points.put(pt,1);
               create pt.make(ix+MENUBUTTONARROW_HEIGHT,iy+MENUBUTTONARROW_WIDTH//2);
               points.put(pt,2);
               dc.fill_polygon(points);
            elseif (options & MENUBUTTON_LEFT) /= 0 then
               -- Left arrow
               if is_enabled then
                  dc.set_foreground(text_color);
               else
                  dc.set_foreground(shadow_color);
               end
               create points.make(0, 2);
               create pt.make(ix + MENUBUTTONARROW_HEIGHT, iy);
               points.put(pt, 0);
               create pt.make(ix + MENUBUTTONARROW_HEIGHT, iy + MENUBUTTONARROW_WIDTH-1);
               points.put(pt,1);
               create pt.make(ix, iy+MENUBUTTONARROW_WIDTH // 2);
               points.put(pt, 2);
               dc.fill_polygon(points);
            elseif (options & MENUBUTTON_UP) /= 0 then
               -- Up arrow
               if is_enabled then
                  dc.set_foreground(text_color);
               else
                  dc.set_foreground(shadow_color);
               end
               create points.make(0, 2);
               create pt.make(ix + MENUBUTTONARROW_WIDTH // 2, iy - 1);
               points.put(pt, 0);
               create pt.make(ix, iy + MENUBUTTONARROW_HEIGHT);
               points.put(pt, 1);
               create pt.make(ix + MENUBUTTONARROW_WIDTH, iy + MENUBUTTONARROW_HEIGHT);
               points.put(pt, 2);
               dc.fill_polygon(points);
            else
               -- Down arrow
               if is_enabled then
                  dc.set_foreground(text_color);
               else
                  dc.set_foreground(shadow_color);
               end
               create points.make(0, 2);
               create pt.make(ix + 1, iy)
               points.put(pt, 0);
               create pt.make(ix + MENUBUTTONARROW_WIDTH - 1, iy)
               points.put(pt, 2);
               create pt.make(ix + MENUBUTTONARROW_WIDTH // 2, iy + MENUBUTTONARROW_HEIGHT);
               points.put(pt, 1)
               dc.fill_polygon(points);
            end
         end

         if not label.is_empty then
            -- Draw text
            dc.set_font(font);
            if is_enabled then
               dc.set_foreground(text_color);
               draw_label(dc,label,hot_off,tx,ty,tw,th);
               if has_focus then
                  dc.draw_focus_rectangle(border+1,border+1,width-2*border-2,height-2*border-2);
               end
            else
               dc.set_foreground(hilite_color);
               draw_label(dc,label,hot_off,tx+1,ty+1,tw,th);
               dc.set_foreground(shadow_color);
               draw_label(dc,label,hot_off,tx,ty,tw,th);
            end
         end
         dc.stop;
         Result := True;
      end

   on_update (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         if Precursor(sender,selector,data) then
            if (options & MENUBUTTON_AUTOHIDE) /= 0 then
               if is_shown then
                  hide;
                  recalc;
               end
            end
            if (options & MENUBUTTON_AUTOGRAY) /= 0 then
               disable;
            end
         end
         Result := True;
      end

   on_enter (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         Result := Precursor (sender,selector,data)
         if is_enabled then
            if (options & MENUBUTTON_TOOLBAR) /= 0 then
               update
            end
         end
         Result := True
      end

   on_leave (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         Result := Precursor (sender, selector, data)
         if is_enabled then
            if (options & MENUBUTTON_TOOLBAR) /= 0 then
               update
            end
         end
         Result := True
      end

   on_focus_in (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         Result := Precursor (sender, selector, data)
         update_rectangle (border, border, width-(border*2), height-(border*2))
         Result := True
      end

   on_focus_out (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         Result := Precursor(sender,selector,data);
         update_rectangle(border,border,width-(border*2),height-(border*2));
         Result := True;
      end

   on_ungrabbed (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         Result := Precursor (sender, selector, data)
         do_handle_2 (Current, SEL_COMMAND, Id_unpost, Void)
         unset_flags (Flag_pressed)
         set_flags (Flag_update)
         Result := True
      end

   on_motion (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         ev: SB_EVENT
      do
         ev ?= data
         check
            ev /= Void
         end
         if state then
            if menu /= Void then
               if menu.contains (ev.root_x, ev.root_y) then
                  if is_mouse_grabbed then
                     release_mouse
                  end
               else
                  if not is_mouse_grabbed then
                     grab_mouse
                  end
               end
               Result := True
            end
         end
      end

   on_left_btn_press (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         unset_flags (Flag_tip);
         do_handle_2 (Current, SEL_FOCUS_SELF, 0, data);
         if is_enabled then
            if message_target = Void  or else not message_target.handle_2 (Current, SEL_LEFTBUTTONPRESS, message, data)
             then
               if state then
                  do_handle_2 (Current, SEL_COMMAND, Id_unpost, Void);
               else
                  do_handle_2 (Current, SEL_COMMAND, Id_post, Void);
               end
               set_flags (Flag_pressed);
               unset_flags (Flag_update);
            end
            Result := True;
         end
      end

   on_left_btn_release (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         ev: SB_EVENT
      do
         ev ?= data;
         check
            ev /= Void
         end
         if is_enabled then
            set_flags (Flag_update)
            unset_flags (Flag_pressed)
            if message_target = Void or else not message_target.handle_2 (Current, SEL_LEFTBUTTONRELEASE, message, data)
             then
               if ev.moved then
                  do_handle_2 (Current, SEL_COMMAND, Id_unpost, Void)
               end
            end
            Result := True
         end
      end

   on_key_press (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         event: SB_EVENT;
      do
         event ?= data;
         check
            event /= Void
         end
         unset_flags (Flag_tip)
         if menu /= Void and then menu.is_shown and then menu.handle_2 (menu, SEL_KEYPRESS, selector, data)
          then
            Result := True
         elseif is_enabled then
            if message_target = Void or else not message_target.handle_2 (Current, SEL_KEYPRESS, message, data)
             then
               if event.code = sbk.key_space or else event.code = sbk.key_kp_space then
                  if state then
                     do_handle_2 (Current, SEL_COMMAND, Id_unpost, Void)
                  else
                     do_handle_2 (Current, SEL_COMMAND, Id_post, Void)
                  end
                  Result := True
               end
            end
         end
      end

   on_key_release (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         event: SB_EVENT
      do
         event ?= data;
         check
            event /= Void
         end
         if menu /= Void and then menu.is_shown and then menu.handle_2 (menu, SEL_KEYRELEASE, selector, data)
          then 
            Result := True;
         elseif is_enabled then
            if (message_target /= Void and then message_target.handle_2 (Current, SEL_KEYRELEASE, message, data))
               or else (event.code = sbk.key_space or else event.code = sbk.key_kp_space)
             then
               Result := True;
            end
         end
      end

   on_hot_key_press (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         unset_flags (Flag_tip)
         do_handle_2 (Current, SEL_FOCUS_SELF, 0, data)
         if is_enabled then
            if state then
               do_handle_2 (Current, SEL_COMMAND, Id_unpost, Void)
            else
               do_handle_2 (Current, SEL_COMMAND, Id_post, Void)
            end
         end
         Result := True
      end

	on_hot_key_release (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
		do
			Result := True
		end

	on_cmd_post (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
		local
			x,y, w,h: INTEGER
			pt: SB_POINT
		do
			if not state then
				if menu /= Void then
					pt := translate_coordinates_to (get_root,0,0)
					x := pt.x; y := pt.y
					if menu.shrink_wrap then
						w := menu.default_width
						h := menu.default_height
					else 
						w := menu.width
						h := menu.height
					end
               		if (options & MENUBUTTON_LEFT) /= 0 and then (options & MENUBUTTON_UP) /= 0 then
                  			-- Right
                  		if 		 (options & MENUBUTTON_ATTACH_BOTTOM) /= 0
                     	and then (options & MENUBUTTON_ATTACH_CENTER) /= 0 then
                    		h := height;
                  		elseif (options & MENUBUTTON_ATTACH_CENTER) /= 0 then
                     		y := y + (height - h) // 2
                  		elseif (options & MENUBUTTON_ATTACH_BOTTOM) /= 0 then
                     		y := y + height - h
                  		end
						x := x + offset_x + width
						y := y + offset_y
               		elseif (options & MENUBUTTON_LEFT) /= 0 then
                  			-- Left
                  		if 		 (options & MENUBUTTON_ATTACH_BOTTOM) /= 0 
                     	and then (options & MENUBUTTON_ATTACH_CENTER) /= 0 then
                     		h := height;
                  		elseif (options & MENUBUTTON_ATTACH_CENTER) /= 0  then
                     		y := y+(height-h)//2;
                  		elseif (options & MENUBUTTON_ATTACH_BOTTOM) /= 0 then
                     		y := y+height-h;
                  		end
                  		x := x-offset_x-menu.width;
                  		y := y+offset_y;
               		elseif (options & MENUBUTTON_UP) /= 0 then
                  			-- Up
                  		if 		 (options & MENUBUTTON_ATTACH_RIGHT) /= 0
                     	and then (options & MENUBUTTON_ATTACH_CENTER) /= 0 then
                     		w := width;
                  		elseif (options & MENUBUTTON_ATTACH_CENTER) /= 0 then
                     		x := x+(width-w)//2;
                  		elseif (options & MENUBUTTON_ATTACH_RIGHT) /= 0 then
                     		x := x+width-w;
                  		end
                  		x := x + offset_x
                  		y := y - offset_y - menu.height
               		else
                  			-- Down
                  		if 		 (options & MENUBUTTON_ATTACH_RIGHT) /= 0 
                     	and then (options & MENUBUTTON_ATTACH_CENTER) /= 0 then
                     		w := width
                  		elseif (options & MENUBUTTON_ATTACH_CENTER) /= 0 then
                     		x := x + (width - w) // 2
                  		elseif (options & MENUBUTTON_ATTACH_RIGHT) /= 0 then
                     		x := x + width - w
                  		end
                  		x := x + offset_x
                  		y := y + offset_y + height
               		end
               		menu.pop_up (Current, x,y, w,h)
               		if  not is_mouse_grabbed then
                  		grab_mouse
               		end
            	end
            	state := True
				update
			end
			Result := True
		end

   on_cmd_unpost (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         if state then
            if menu /= Void then
               menu.pop_down
               if is_mouse_grabbed then
                  release_mouse
               end
            end
            state := False
            update
         end
         Result := True
      end

feature -- Destruction

   destruct
      do
         menu := Void
         Precursor;
      end


feature -- Resource management

   create_resource
         -- Create server-side resources
      do
         Precursor;
         if menu /= Void then
            menu.create_resource
         end
      end

   detach_resource
         -- Detach server-side resources
      do
         Precursor;
         if menu /= Void then
            menu.detach_resource
         end
      end

feature {NONE} -- Implementation

   MENUBUTTONARROW_WIDTH: INTEGER = 11
   
   MENUBUTTONARROW_HEIGHT: INTEGER = 5
   
   MENUBUTTON_MASK: INTEGER
      once
         Result := (MENUBUTTON_AUTOGRAY | MENUBUTTON_AUTOHIDE | MENUBUTTON_TOOLBAR | MENUBUTTON_NOARROWS)
      end

   POPUP_MASK: INTEGER
      once
         Result := (MENUBUTTON_UP | MENUBUTTON_LEFT)
      end

   ATTACH_MASK: INTEGER
      once
         Result := (MENUBUTTON_ATTACH_RIGHT | MENUBUTTON_ATTACH_CENTER)
      end

end
