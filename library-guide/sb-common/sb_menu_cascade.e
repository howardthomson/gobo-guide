note
	description: "[
		The cascade menu widget is used to bring up a sub
		menu from a pull down menu.
	]"

	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

class SB_MENU_CASCADE

inherit

	SB_MENU_CAPTION
      	rename
         	Id_last as MENU_CAPTION_ID_LAST,
         	make as caption_make,
         	make_opts as caption_make_opts
      	redefine
         	can_focus,
         	contains,
         	create_resource,
         	detach_resource,
         	destroy_resource,
         	destruct,
         	set_focus,
         	kill_focus,
         	handle_2,
         	on_paint,
         	on_enter,
         	on_leave,
         	on_key_press,
         	on_key_release,
         	class_name
      	end

   	SB_MENU_CASCADE_COMMANDS

   	SB_BUTTON_CONSTANTS

create

	make,
	make_opts

feature -- class name

	class_name: STRING
		once
			Result := "SB_MENU_CASCADE"
		end

feature -- Creation

	make (p: SB_COMPOSITE; text: STRING; pup: SB_POPUP)
         	-- Construct a menu cascade responsible for the given popup 
         	-- menu
		do
         	make_opts(p, text, Void, pup, Zero);
    	end

	make_opts (p: SB_COMPOSITE; text: STRING; ic: SB_ICON; pup: SB_POPUP; opts: INTEGER)
    		-- Construct a menu cascade responsible for the given popup menu
		do
         	caption_make_opts(p, text, ic, opts);
         	default_cursor := application.default_cursor(Def_rarrow_cursor);
         	flags := flags | Flag_enabled;
         	menu := pup;
         	timer := Void;
		end

feature -- Data

	menu: SB_POPUP

feature -- Queries

	can_focus: BOOLEAN
    		-- Yes it can receive the focus
		once
         	Result := True;
      	end

   contains (parentx, parenty: INTEGER): BOOLEAN
         -- Return true if window logically contains the given point
      local
         pt: SB_POINT;
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
      do
         Precursor;
         flags := flags | Flag_active;
         unset_flags (Flag_update);
         update;
      end

   kill_focus
         -- Remove the focus from this window
      do
         Precursor;
         do_handle_2 (Current, SEL_COMMAND, Id_unpost, Void);
         unset_flags (Flag_active);
         flags := flags | Flag_update;
         update;
      end

   set_menu (pup: SB_POPUP)
         -- Change the popup menu
      do
         menu := pup;
      end

feature -- Message processing

	handle_2 (sender: SB_MESSAGE_HANDLER; type, key: INTEGER; data: ANY): BOOLEAN
    	do
        	if		match_function_2 (Sel_timeout,				ID_MENUTIMER, 	type, key) then Result := on_timeout 		(sender, key, data)
         	elseif  match_function_2 (SEL_LEFTBUTTONPRESS,		0, 				type, key) then Result := on_button_press 	(sender, key, data)
         	elseif  match_function_2 (SEL_LEFTBUTTONRELEASE,	0, 				type, key) then Result := on_button_release (sender, key, data)
         	elseif  match_function_2 (SEL_MIDDLEBUTTONPRESS,	0, 				type, key) then Result := on_button_press 	(sender, key, data)
         	elseif  match_function_2 (SEL_MIDDLEBUTTONRELEASE,	0, 				type, key) then Result := on_button_release (sender, key, data)
         	elseif  match_function_2 (Sel_rightbuttonpress,		0, 				type, key) then Result := on_button_press 	(sender, key, data)
         	elseif  match_function_2 (Sel_rightbuttonrelease,	0, 				type, key) then Result := on_button_release (sender, key, data)
         	elseif  match_function_2 (SEL_KEYPRESS,				Id_hotkey, 		type, key) then Result := on_hot_key_press 	(sender, key, data)
         	elseif  match_function_2 (SEL_KEYRELEASE,			Id_hotkey, 		type, key) then Result := on_hot_key_release(sender, key, data)
         	elseif  match_function_2 (SEL_COMMAND,				Id_post, 		type, key) then Result := on_cmd_post 		(sender, key, data)
         	elseif  match_function_2 (SEL_COMMAND,				Id_unpost, 		type, key) then Result := on_cmd_unpost 	(sender, key, data)
         	else Result := Precursor (sender, type, key, data)
         	end;
		end

	on_paint (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
    	local
        	event: SB_EVENT
        	dc: SB_DC_WINDOW
        	xx, yy: INTEGER
      	do
         	event ?= data;
         	check
            	event /= Void
         	end
			dc := paint_dc
         	dc.make_event (Current, event)

         	xx := LEADSPACE

         	if  not is_enabled then
            	-- Grayed out
            	dc.set_foreground(back_color)
            	dc.fill_rectangle(0,0, width,height)
            	if icon /= Void then
               		dc.draw_icon_sunken(icon, 3, (height-icon.height) // 2)
               		if icon.width+5 > xx then
                  		xx := icon.width + 5
               		end
            	end
            	if  not label.is_empty then
               		yy := font.get_font_ascent+(height-font.get_font_height)//2
               		dc.set_font(font)
               		dc.set_foreground(hilite_color)
               		dc.draw_text(xx+1,yy+1,label)
               		dc.set_foreground(shadow_color)
               		dc.draw_text(xx,yy,label)
               		if 1 <= hot_off then
                  		dc.fill_rectangle(xx+1+font.get_text_width_offset(label,1,hot_off-1),
                                    yy+1,font.get_text_width_offset(label,hot_off,1),1)
               		end
            	end
            	yy := (height - 8) // 2
            	dc.set_foreground(shadow_color)
            	draw_triangle(dc,width-TRAILSPACE+4,yy,width-TRAILSPACE+4+6,yy+8)
         	elseif is_active then
            	-- Active
            	dc.set_foreground(sel_back_color)
            	dc.fill_rectangle(1,1,width-2,height-2)
            	if icon /= Void then
               		dc.draw_icon(icon,3,(height-icon.height) // 2)
               		if icon.width+5>xx then
                  		xx := icon.width+5
               		end
            	end
            	if not label.is_empty then
               		yy := font.get_font_ascent + (height - font.get_font_height) // 2
               		dc.set_font(font)
               		if is_enabled then
                  		dc.set_foreground (sel_text_color)
               		else
                  		dc.set_foreground (shadow_color)
               		end
               		dc.draw_text (xx, yy, label)
               		if 1 <= hot_off then
                  		dc.fill_rectangle (xx + 1 + font.get_text_width_offset (label, 1, hot_off - 1),
                                    yy + 1, font.get_text_width_offset (label, hot_off, 1), 1)
               		end
            	end
            	yy := (height-8)//2
            	dc.set_foreground(sel_text_color)
            	draw_triangle(dc,width-TRAILSPACE+4,yy,width-TRAILSPACE+4+6,yy+8)
         	else
            	-- Normal
            	dc.set_foreground(back_color);
            	dc.fill_rectangle(0,0,width,height)
            	if icon /= Void then
               		dc.draw_icon(icon,3,(height-icon.height)//2)
               		if icon.width+5>xx then
                  		xx := icon.width+5
               		end
            	end
            	if  not label.is_empty then
               		yy := font.get_font_ascent+(height-font.get_font_height)//2;
               		dc.set_font(font)
               		dc.set_foreground(text_color)
               		dc.draw_text(xx,yy,label)
               		if 1 <= hot_off then
                  		dc.fill_rectangle(xx+1+font.get_text_width_offset(label,1,hot_off-1),
                                    yy+1,font.get_text_width_offset(label,hot_off,1),1);
               		end
            	end
            	yy := (height-8)//2
            	dc.set_foreground(text_color)
            	draw_triangle(dc, width - TRAILSPACE + 4, yy, width - TRAILSPACE + 4 + 6, yy + 8);
         	end
         	dc.stop
         	Result := True
		end

   on_enter (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         Result := Precursor (sender,selector,data);
         if is_enabled and then can_focus then
            if  timer = Void then
               timer := application.add_timeout(application.menu_pause, Current, ID_MENUTIMER);
            end
            set_focus
         end
         Result := True
      end

   on_leave (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         Result := Precursor (sender, selector, data)
         if timer /= Void then
            application.remove_timeout(timer)
            timer := Void
         end
         Result := True
      end

   on_timeout (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         timer := Void
         do_handle_2 (Current, SEL_COMMAND, Id_post, data)
         Result := True
      end

   on_button_press (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         if  is_enabled then
            do_handle_2 (Current, SEL_COMMAND, Id_post,data)
            Result := True
         end
      end

   on_button_release (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         event: SB_EVENT
      do
         event ?= data
         check
            event /= Void
         end
         if is_enabled then
            if event.moved then
               parent.do_handle_2 (Current, SEL_COMMAND, Id_unpost, data)
            end
            Result := True
         end
      end

   on_key_press (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         event: SB_EVENT
         pt: SB_POINT
      do
         event ?= data
         check
            event /= Void
         end
         if is_enabled then
            Result := True
            if menu = Void or else not menu.is_shown 
               or else not menu.handle_2 (menu, SEL_KEYPRESS, selector, data)
             then
               if event.code = sbk.key_right then
                  if menu /= Void and then not menu.is_shown then
                     if timer /= Void then
                        application.remove_timeout(timer)
                        timer := Void
                     end
                     pt := translate_coordinates_to(get_root,width,0)
                     menu.pop_up(get_grab_owner(parent),pt.x,pt.y,0,0)
                  end
               elseif event.code = sbk.key_left then
                  if menu /= Void and then menu.is_shown then
                     if timer /= Void then
                        application.remove_timeout(timer)
                        timer := Void
                     end
                     menu.pop_down;
                  end
               elseif event.code = sbk.key_kp_enter
                  or else event.code = sbk.key_return
                  or else event.code = sbk.key_space
                  or else event.code =  sbk.key_kp_space then
                  do_handle_2 (Current, SEL_COMMAND, Id_post, data)
               else
                  Result := False                 
               end
            end
         end
      end

   on_key_release (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         event: SB_EVENT;
         pt: SB_POINT;
     --    sbk: expanded SB_KEYS;
      do
         event ?= data;
         check
            event /= Void
         end
         if is_enabled then
            Result := True;
            if menu = Void or else not menu.is_shown
               or else not menu.handle_2 (menu, SEL_KEYRELEASE, selector, data)
             then
               if event.code = sbk.key_right
                  or else event.code = sbk.key_left
                  or else event.code = sbk.key_kp_enter
                  or else event.code = sbk.key_return
                  or else event.code = sbk.key_space
                  or else event.code = sbk.key_kp_space
                then
               else
                  Result := False
               end
            end
         end
      end

   on_hot_key_press (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         do_handle_2 (Current, SEL_FOCUS_SELF, 0, data)
         if is_enabled then
            do_handle_2 (Current, SEL_COMMAND, Id_post, data)
         end
         Result := True
      end

   on_hot_key_release (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         Result := True
      end

   on_cmd_post (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         pt: SB_POINT
      do
         if timer /= Void then
            application.remove_timeout(timer)
            timer := Void
         end
         if menu /= Void  and then not menu.is_shown then
            pt := translate_coordinates_to(get_root,width,0)
            menu.pop_up(get_grab_owner(parent),pt.x,pt.y,0,0)
         end
         Result := True
      end

	on_cmd_unpost (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
		do
			if timer /= Void then
				application.remove_timeout(timer)
            	timer := Void
			end
			if menu /= Void then
				menu.pop_down
			end
		end

feature -- Resource management

   create_resource
         -- Create server-side resources
      do
         Precursor;
         if menu /= Void then
            menu.create_resource;
         end
      end

   detach_resource
         -- Detach server-side resources
      do
         if timer /= Void then
			application.remove_timeout(timer)
            timer := Void
         end
         Precursor;
         if menu /= Void then
            menu.detach_resource
         end
      end

   destroy_resource
         -- Destroy server-side resources
      do
         if timer /= Void then
			application.remove_timeout(timer)
            timer := Void
         end
         Precursor;
      end

feature -- Destruction

   destruct
      do
         if timer /= Void then
			application.remove_timeout(timer)
            timer := Void
         end
         menu := Void
         Precursor;
      end


feature {NONE} -- Implementation

   timer: SB_TIMER;

   draw_triangle(dc: SB_DC_WINDOW; l, t, r, b: INTEGER)
      local
         points: ARRAY[SB_POINT]
         m: INTEGER
         pt: SB_POINT
      do
         create points.make(0, 2)
         m := (t + b) // 2
         create pt.make(l, t)
         points.put(pt, 0)
         create pt.make(l, b)
         points.put(pt, 1)
         create pt.make(l + (b - t) // 2, m)
         points.put(pt, 2)
         dc.fill_polygon(points)
      end

   get_grab_owner(p: SB_WINDOW): SB_WINDOW
      require
         p /= Void
      local
         mp: SB_MENU_PANE
      do
         mp ?= p;
         check
            mp /= Void
         end
         Result := mp.get_grab_owner
      end
end
