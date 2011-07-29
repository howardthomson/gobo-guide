note
	description: "[
		A menu title is a child of a menu bar which is
		responsible for popping up a pulldown menu.
	]"

class SB_MENU_TITLE

inherit

	SB_MENU_CAPTION
		rename
			make as caption_make,
			make_opts as caption_make_opts
		redefine
			default_width,
			default_height,
			can_focus,
			contains,
			set_focus,
			kill_focus,
			handle_2,
			on_paint,
			on_enter,
			on_leave,
			on_focus_in,
			on_focus_out,
			on_key_press,
			on_key_release,
			on_left_btn_press,
			on_left_btn_release,
		--	on_cmd_post,
			create_resource,
			detach_resource,
			destruct,
			class_name
      end

creation

	make_sb,
	make_opts

feature -- class name

	class_name: STRING
		once
			Result := "SB_MENU_TITLE"
		end

feature -- Creation

   make_sb (p: SB_COMPOSITE; text: STRING; pup: SB_POPUP; opts: INTEGER)
      do
         make_opts(p, text, Void, pup, opts)
      end

   make_opts (p: SB_COMPOSITE; text: STRING; ic: SB_ICON; pup: SB_POPUP; opts: INTEGER)
      do
         caption_make_opts (p, text, ic, opts)
         flags := flags | Flag_enabled
         text_color := application.fore_color
         sel_text_color := application.fore_color
         sel_back_color := application.base_color
         menu := pup
      end

feature -- Data

   menu: SB_POPUP

feature -- Queries

   default_width: INTEGER
         -- Return default width
      local
         tw,iw: INTEGER
      do
         if  not label.is_empty then
            tw := font.get_text_width (label)
         end
         if icon /= Void then
            iw := icon.width + 5
         end
         if iw /= 0 and then tw /= 0 then
            iw := iw + 5
         end
         Result := tw + iw + 12
      end

   default_height: INTEGER
         -- Return default height
      local
         th,ih: INTEGER;
      do
         if not label.is_empty then th := font.get_font_height end
         if icon /= Void then ih := icon.height end
         Result := th.max(ih) + 4
      end

   can_focus: BOOLEAN
         -- Yes it can receive the focus
      once
         Result := True
      end

   contains (parentx,parenty: INTEGER): BOOLEAN
         -- Return true if window logically contains the given point
      local
         pt: SB_POINT
      do
         if Precursor(parentx,parenty) then
            Result := True;
         else
            if menu /= Void and then menu.is_shown then
               pt := parent.translate_coordinates_to(get_root, parentx, parenty);
               Result := menu.contains(pt.x, pt.y)
            end
         end
      end

feature -- Actions

   set_focus
         -- Move the focus to this window
      local
         menuitem: SB_WINDOW
         active: BOOLEAN
      do
         menuitem := parent.focus_child
         active := menuitem /= Void and then menuitem.is_active
         Precursor
         if active then
            do_handle_2 (Current, SEL_COMMAND, Id_post, Void)
         end
      end

   kill_focus
         -- Remove the focus from this window
      do
         Precursor;
         do_handle_2 (Current, SEL_COMMAND, Id_unpost, Void)
      end

   set_menu (pup: SB_POPUP)
         -- Change the popup menu
      do
         menu := pup
      end

feature -- Message processing

   handle_2 (sender: SB_MESSAGE_HANDLER; type, key: INTEGER; data: ANY): BOOLEAN
      do
         if		match_function_2 (SEL_MIDDLEBUTTONPRESS,	0,			type, key) then Result := on_default		(sender, key, data)
         elseif match_function_2 (SEL_MIDDLEBUTTONRELEASE,	0,			type, key) then Result := on_default		(sender, key, data)
         elseif match_function_2 (Sel_rightbuttonpress,		0,			type, key) then Result := on_default		(sender, key, data)
         elseif match_function_2 (Sel_rightbuttonrelease,	0,			type, key) then Result := on_default		(sender, key, data)
         elseif match_function_2 (SEL_KEYPRESS,				Id_hotkey,	type, key) then Result := on_hot_key_press	(sender, key, data)
         elseif match_function_2 (SEL_KEYRELEASE,			Id_hotkey,	type, key) then Result := on_hot_key_release(sender, key, data)
         elseif match_function_2 (SEL_FOCUS_UP,				0,			type, key) then Result := on_focus_up		(sender, key, data)
         elseif match_function_2 (SEL_FOCUS_DOWN,			0,			type, key) then Result := on_focus_down		(sender, key, data)
         elseif match_function_2 (SEL_COMMAND,				Id_post,	type, key) then Result := on_cmd_post		(sender, key, data)
         elseif match_function_2 (SEL_COMMAND,				Id_unpost,	type, key) then Result := on_cmd_unpost		(sender, key, data)
         else Result := Precursor (sender, type, key, data)
         end;
      end

   on_paint (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         event: SB_EVENT
         dc: SB_DC_WINDOW
         xx,yy: INTEGER
      do
         event ?= data
         check
            event /= Void
         end
         -- Start drawing
         dc := paint_dc
         dc.make_event (Current, event)
         dc.set_font (font)
         xx := 6
         yy := 0
         if is_enabled then
            if is_active then
               dc.set_foreground (sel_back_color)
               dc.fill_rectangle (1, 1, width - 2, height - 2)

               dc.set_foreground (shadow_color)
               dc.fill_rectangle (0, 0, width, 1)
               dc.fill_rectangle (0, 0, 1, height)
               dc.set_foreground (hilite_color)
               dc.fill_rectangle (0, height - 1, width, 1)
               dc.fill_rectangle (width - 1, 0, 1, height)
               xx := xx + 1
               yy := yy + 1
            elseif is_under_cursor then
               dc.set_foreground (back_color)
               dc.fill_rectangle (1, 1, width - 2, height - 2)
               dc.set_foreground (shadow_color)
               dc.fill_rectangle (0, height - 1, width, 1)
               dc.fill_rectangle (width - 1, 0, 1, height)
               dc.set_foreground (hilite_color)
               dc.fill_rectangle (0, 0, width, 1)
               dc.fill_rectangle (0, 0, 1, height)
            else
               dc.set_foreground (back_color)
               dc.fill_rectangle (0, 0, width, height)
            end
            if icon /= Void then
               dc.draw_icon(icon,xx,yy+(height-icon.height)//2)
               xx := xx + 5 + icon.width
            end
            if  not label.is_empty then
               yy := yy + font.get_font_ascent+(height-font.get_font_height)//2
               if is_active then
                  dc.set_foreground(sel_text_color)
               else
                  dc.set_foreground(text_color)
               end
               dc.draw_text(xx,yy,label)
               if 1 <= hot_off then
                  dc.fill_rectangle(xx+font.get_text_width_offset(label,1,hot_off-1),yy+1,
                                    font.get_text_width_offset(label,hot_off,1),1)
               end
            end
         else
            dc.set_foreground(back_color)
            dc.fill_rectangle(0,0,width,height)
            if icon /= Void then
               dc.draw_icon_sunken(icon,xx,yy+(height-icon.height)//2)
               xx := xx + 5+icon.width
            end
            if  not label.is_empty then
               yy := yy + font.get_font_ascent+(height-font.get_font_height)//2
               dc.set_foreground(hilite_color)
               dc.draw_text(xx+1,yy+1,label)
               if 1 <= hot_off then
                  dc.fill_rectangle(xx+font.get_text_width_offset(label,1,hot_off-1),yy+1,
                                    font.get_text_width_offset(label,hot_off,1),1)
               end
               dc.set_foreground(shadow_color)
               dc.draw_text(xx,yy,label)
               if 1 <= hot_off then
                  dc.fill_rectangle(xx+font.get_text_width_offset(label,1,hot_off-1),yy+1,
                                    font.get_text_width_offset(label,hot_off,1),1)
               end
            end
         end
         dc.stop
         Result := True
      end

   on_enter (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         Result := Precursor (sender, selector, data)
         if is_enabled then
            if can_focus and then parent.focus_child /= Void then
               set_focus
            end
            update
         end
         Result := True
      end

   on_leave (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         Result := Precursor(sender,selector,data);
         if is_enabled then
            update;
         end
         Result := True;
      end

   on_left_btn_press (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         do_handle_2 (Current, SEL_FOCUS_SELF, 0, data)
         if is_enabled then
            if message_target = Void 
               or else not message_target.handle_2 (Current, SEL_LEFTBUTTONPRESS, message, data)
             then
               if (flags & Flag_active) /= 0 then
                  do_handle_2 (Current, SEL_COMMAND, Id_unpost, Void)
               else
                  do_handle_2 (Current, SEL_COMMAND, Id_post, Void)
               end
            end
            Result := True
         end
      end

   on_left_btn_release (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         event: SB_EVENT
      do
         event ?= data
         check
            event /= Void
         end
         if is_enabled then
            if message_target = Void
               or else not message_target.handle_2 (Current, SEL_LEFTBUTTONRELEASE, message, data)
             then
               if event.moved then
                  do_handle_2 (Current, SEL_COMMAND, Id_unpost, data)
               end
            end
            Result := True
         end
      end

   on_key_press (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         event: SB_EVENT
      do
         event ?= data
         check
            event /= Void
         end
         if is_enabled then
            if (message_target /= Void
                and then message_target.handle_2 (Current, SEL_KEYPRESS, message, data))
               or else (menu /= Void and then menu.is_shown 
                        and then menu.handle_2 (menu, SEL_KEYPRESS, selector, data))
             then
               Result := True
            end
         end
      end

   on_key_release (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         event: SB_EVENT
      do
         event ?= data
         check
            event /= Void
         end
         if is_enabled then
            if (message_target /= Void
                and then message_target.handle_2 (Current, SEL_KEYRELEASE, message, data))
               or else (menu /= Void and then menu.is_shown 
                        and then menu.handle_2 (menu, SEL_KEYRELEASE, selector, data))
             then
               Result := True
            end
         end
      end

   on_hot_key_press (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         do_handle_2 (Current, SEL_FOCUS_SELF, 0, data)
         Result := True
      end

   on_hot_key_release (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         if is_enabled then
            if (flags & Flag_active) /= 0 then
               do_handle_2 (Current, SEL_COMMAND, Id_unpost, Void)
            else
               do_handle_2 (Current, SEL_COMMAND, Id_post, Void)
            end
         end
         Result := True
      end

   on_focus_up (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         if menu /= Void and then menu.is_shown then
            do_handle_2 (Current, SEL_COMMAND, Id_unpost, Void)
            Result := True
         end
      end

   on_focus_down (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         if menu /= Void and then not menu.is_shown then
            do_handle_2 (Current, SEL_COMMAND, Id_post, Void)
            Result := True
         end
      end

   on_focus_in (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         Result := Precursor (sender, selector, data)
         update
         Result := True
      end

   on_focus_out (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         Result := Precursor (sender, selector, data)
         update
         Result := True
      end

	on_cmd_post (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
    	local
        	pt: SB_POINT
      	do
    	-- 	fx_trace(0, <<"SB_MENU_TITLE::on_cmd_post" >> )
        	if menu /= Void and then not menu.is_shown then
            	pt := translate_coordinates_to (get_root, 0,0)

		--		fx_trace(0, <<"SB_MENU_TITLE::on_cmd_post -- ", pt.x.out, " ", pt.y.out>> )
            
            	menu.pop_up (parent, (-1) + pt.x, height + pt.y, 0,0)
            	if not parent.is_mouse_grabbed then
               		parent.grab_mouse
            	end
         	end
         	flags := flags | Flag_active
         	update
         	Result := True
      	end

   on_cmd_unpost (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         if menu /= Void and then menu.is_shown then
            menu.pop_down
            if parent.is_mouse_grabbed then
               parent.release_mouse
            end
         end
         unset_flags (Flag_active)
         update
         Result := True
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

feature -- Destruction

   destruct
      do
         menu := Void
         Precursor
      end

end
