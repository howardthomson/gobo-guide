note
	description: "[
		The menu command widget is used to invoke a command in
		the application from a menu. Menu commands may reflect the state of
		the application by graying out or becoming hidden.
	]"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

class SB_MENU_COMMAND

inherit

   	SB_MENU_CAPTION
      	rename
         	make as caption_make,
         	make_opts as caption_make_opts
      	redefine
         	can_focus,
         	set_focus,
         	kill_focus,
         	on_enter,
         	on_leave,
         	default_height,
         	default_width,
         	destruct,
         	handle_2,
         	on_key_press,
         	on_key_release,
         	on_paint,
         	class_name
      	end

	SB_MENU_COMMAND_CONSTANTS
	SB_REFERENCE_BOOLEAN

create

   	make,
   	make_sb,
   	make_opts

feature -- class name

	class_name: STRING
		once
			Result := "SB_MENU_COMMAND"
		end

feature -- Creation

	make (p: SB_COMPOSITE; text: STRING)
		do
			make_sb (p, text, Void, 0)
		end

   	make_sb (p: SB_COMPOSITE; text: STRING; tgt: SB_MESSAGE_HANDLER; selector: INTEGER)
    		-- Construct a menu command
      	do
         	make_opts (p, text, Void, tgt, selector, 0)
      	end

   	make_opts (p: SB_COMPOSITE; text: STRING; ic: SB_ICON; tgt: SB_MESSAGE_HANDLER; selector: INTEGER; opts: INTEGER)
         	-- Construct a menu command
      	local
         	table: SB_ACCEL_TABLE
         	ownr: SB_WINDOW
      	do
         	caption_make_opts (p,text,ic,opts)
         	flags := flags | Flag_enabled
         	default_cursor := application.default_cursor (Def_rarrow_cursor)
         	message_target := tgt
         	message := selector
         	accel := u.section (text,'%T',1,1)
         	acckey := u.parse_accel (accel)
--         	if acckey /= 0 then
--            	ownr := get_shell.owner
--            	if ownr /= Void then
--               		table := ownr.accel_table
--               		if table /= Void then
--                  		table.add_accel (acckey, Current, mksel (SEL_COMMAND, Id_accel), 0)
--               		end
--            	end
--         	end
		ensure
			width > 0
      	end


feature -- Data

   	accel: STRING
    	-- Accelerator string

feature -- Queries

	default_width: INTEGER
			-- Return default width
		local
        	tw,aw,iw: INTEGER
      	do
         	if  not label.is_empty then
            	tw := font.get_text_width(label)
         	end
         	if not accel.is_empty then
            	aw := font.get_text_width(accel)
         	end
         	if aw /= 0 and then tw /= 0 then
            	aw := aw + 5
         	end
         	if icon /= Void then
            	iw := icon.width + 5
         	end
         	Result := iw.max(LEADSPACE) + tw + aw + TRAILSPACE
      	end

	default_height: INTEGER
			-- Return default height
		local
			th,ih,h: INTEGER
		do
			if not label.is_empty or else not accel.is_empty then
				th := font.get_font_height+5
			end
			if icon /= Void then
				ih := icon.height+5
			end
			Result := th.max(ih)
		end

	can_focus: BOOLEAN
    		-- Yes it can receive the focus
		once
			Result := True
		end

feature -- Actions

   set_focus
         -- Move the focus to this window
      do
         Precursor
         flags := flags | Flag_active
         unset_flags (Flag_update)
         update
      end

   kill_focus
         -- Remove the focus from this window
      do
         Precursor
         unset_flags (Flag_active)
         flags := flags | Flag_update
         update
      end

   set_accel_text(text: STRING)
  		-- Set accelerator text
      do
         if not accel.is_equal(text) then
            accel := text
            recalc
            update
         end
      end

feature -- Message processing

   handle_2 (sender: SB_MESSAGE_HANDLER; type, key: INTEGER; data: ANY): BOOLEAN
      do
         if		match_function_2 (SEL_LEFTBUTTONPRESS,		0, 			type, key) then Result := on_button_press 	(sender, key, data);
         elseif match_function_2 (SEL_LEFTBUTTONRELEASE,	0, 			type, key) then Result := on_button_release (sender, key, data);
         elseif match_function_2 (SEL_MIDDLEBUTTONPRESS,	0, 			type, key) then Result := on_button_press	(sender, key, data);
         elseif match_function_2 (SEL_MIDDLEBUTTONRELEASE,	0, 			type, key) then Result := on_button_release (sender, key, data);
         elseif match_function_2 (Sel_rightbuttonpress,		0,			type, key) then Result := on_button_press 	(sender, key, data);
         elseif match_function_2 (Sel_rightbuttonrelease,	0, 			type, key) then Result := on_button_release (sender, key, data);
         elseif match_function_2 (SEL_KEYPRESS,				Id_hotkey, 	type, key) then Result := on_hot_key_press 	(sender, key, data);
         elseif match_function_2 (SEL_KEYRELEASE,			Id_hotkey, 	type, key) then Result := on_hot_key_release(sender, key, data);
         elseif match_function_2 (SEL_COMMAND,				Id_accel, 	type, key) then Result := on_cmd_accel 		(sender, key, data);
         else Result := Precursor(sender, type, key, data)
         end
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

         xx := LEADSPACE

         if not is_enabled then
            -- Grayed out
            dc.set_foreground(back_color)
            dc.fill_rectangle(0,0,width,height)
            if icon /= Void then
               dc.draw_icon_sunken(icon,3,(height-icon.height)//2)
               if icon.width+5>xx then
                  xx := icon.width+5
               end
            end
            if not label.is_empty then
               yy := font.get_font_ascent+(height-font.get_font_height)//2;
               dc.set_font(font)
               dc.set_foreground(hilite_color)
               dc.draw_text(xx+1,yy+1,label)
               dc.set_foreground(shadow_color)
               dc.draw_text(xx,yy,label)
               if not accel.is_empty then
                  dc.draw_text(width-TRAILSPACE-font.get_text_width(accel),yy,accel);
               end
               if 1 <= hot_off then
                  dc.fill_rectangle(xx+font.get_text_width_offset(label,1,hot_off-1),yy+1,
                                    font.get_text_width_offset(label,hot_off,1),1)
               end
            end
         elseif is_active then
            -- Active
            dc.set_foreground(sel_back_color)
            dc.fill_rectangle(0,0,width,height)
            if icon /= Void then
               dc.draw_icon(icon,3,(height-icon.height)//2)
               if icon.width+5>xx then
                  xx := icon.width+5
               end
            end
            if  not label.is_empty then
               yy := font.get_font_ascent+(height-font.get_font_height)//2
               dc.set_font(font)
               if is_enabled then
                  dc.set_foreground(sel_text_color)
               else
                  dc.set_foreground(shadow_color)
               end
               dc.draw_text(xx,yy,label)
               if  not accel.is_empty then
                  dc.draw_text(width-TRAILSPACE-font.get_text_width(accel),yy,accel)
                  if 1 <= hot_off then
                     dc.fill_rectangle(xx+font.get_text_width_offset(label,1,hot_off-1),
                                       yy+1,font.get_text_width_offset(label,hot_off,1),1)
                  end
               end
            end
         else
            -- Normal
            dc.set_foreground(back_color)
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
               if not accel.is_empty then
                  dc.draw_text(width-TRAILSPACE-font.get_text_width(accel),yy,accel)
               end
               if 1 <= hot_off then
                  dc.fill_rectangle(xx+font.get_text_width_offset(label,1,hot_off-1),
                                    yy+1,font.get_text_width_offset(label,hot_off,1),1)
               end
            end
         end
         dc.stop
         Result := True
      end

   on_enter (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         Result := Precursor (sender, selector, data);
         if is_enabled and then can_focus then
            set_focus
         end
         Result := True
      end

   on_leave (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         Result := Precursor (sender, selector, data);
         if is_enabled and then can_focus then
            kill_focus
         end
         Result := True
      end

   on_button_press (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         if is_enabled then
            Result := True
         end
      end

   on_button_release (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         active: BOOLEAN
      do
         active := is_active
         if is_enabled then
            parent.do_handle_2 (Current, SEL_COMMAND, Id_unpost, Void)
            if active and then message_target /= Void then
               message_target.do_handle_2 (Current, SEL_COMMAND, message, ref_true)
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
            if event.code = sbk.key_kp_enter
               or else event.code = sbk.key_return
               or else event.code = sbk.key_space
               or else event.code = sbk.key_kp_space
             then
               Result := True
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
         if is_enabled then
            if event.code = sbk.key_kp_enter
               or else event.code = sbk.key_return
               or else event.code = sbk.key_space
               or else event.code = sbk.key_kp_space
             then
               parent.do_handle_2 (Current, SEL_COMMAND, Id_unpost, Void)
               if message_target /= Void
                then message_target.do_handle_2 (Current, SEL_COMMAND, message, ref_true)
               end
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
            parent.do_handle_2 (Current, SEL_COMMAND, Id_unpost, Void)
            if message_target /= Void then
               message_target.do_handle_2 (Current, SEL_COMMAND, message, ref_true)
            end
         end
         Result := True
      end

   on_cmd_accel (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         if is_enabled then
            if message_target /= Void then
               message_target.do_handle_2 (Current, SEL_COMMAND, message, ref_true)
               Result := True
            end
         end
      end

feature -- Destruction

   destruct
      local
         table: SB_ACCEL_TABLE
         ownr: SB_WINDOW
      do
         if acckey /= 0 then
--            ownr := get_shell.owner
--            if owner /= Void then
--               table := ownr.accel_table
--               if table /= Void then
--                  table.remove_accel (acckey)
--               end
--            end
         end
         Precursor
      end


feature {NONE} -- Implementation

   acckey: INTEGER;
         -- Accelerator key
end
