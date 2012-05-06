note
	description: "[
		The menu caption is a widget which can be used as
		a caption above a number of menu commands in a menu.
	]"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

class SB_MENU_CAPTION

inherit

	SB_WINDOW
    	rename
    		make as window_make
      	redefine
			default_height,
			default_width,
         	enable,
         	disable,
         	handle_2,
         	on_paint,
         	on_update,
         	create_resource,
         	detach_resource,
         	destruct,
         	class_name
      	end

   SB_MENU_CAPTION_CONSTANTS

create

	make,
	make_opts

feature -- class name

	class_name: STRING
		once
			Result := "SB_MENU_CAPTION"
		end

feature -- Creation

	make (p: SB_COMPOSITE; text: STRING)
			-- Construct a menu caption
		do
			make_opts (p, text, Void, 0)
		end

	make_opts (p: SB_COMPOSITE; text: STRING; ic: SB_ICON; opts: INTEGER)
    		-- Construct a menu caption
    	local
        	string: STRING
      	do
         	window_make (p, opts, 0,0, 0,0)
         	string := u.section (text, '%T', 0, 1)
         	flags := flags | Flag_shown
         	label := u.strip_hot_key (string)
         	help_text := u.section (text, '%T', 2, 1)
         	icon := ic
			font := application.normal_font         
         	hot_key := u.parse_hot_key (string)
         	hot_off := u.find_hot_key_offset (string)
         	add_hot_key (hot_key)
         	text_color := application.fore_color
         	sel_text_color := application.sel_fore_color
         	sel_back_color := application.sel_back_color
         	hilite_color := application.hilite_color
         	shadow_color := application.shadow_color
      	end

feature -- Data

	label: STRING
   	icon: SB_ICON
   	font: SB_FONT
   	help_text: STRING

   	text_color: INTEGER
   	sel_back_color: INTEGER
   	sel_text_color: INTEGER
   	hilite_color: INTEGER
   	shadow_color: INTEGER

feature -- Queries

	default_width: INTEGER
    		-- Return default width
      	local
         	tw, iw: INTEGER
      	do
         	if not label.is_empty then
            	tw := font.get_text_width (label)
         	end
         	if icon /= Void then
            	iw := icon.width + 5
         	end
         	Result := iw.max (LEADSPACE) + tw + TRAILSPACE
		end

	default_height: INTEGER
    		-- Return default height
    	local
        	th,ih,h: INTEGER
      	do
         	if not label.is_empty then
            	th := font.get_font_height + 5
            	if icon /= Void then
               		ih := icon.height + 5
            	end
         	end
         	Result := th.max (ih)
      	end

	get_menu_style: INTEGER
      	do
         	Result := options & MENU_MASK
      	end

feature -- Actions

	enable
         -- Enable the menu
      do
         if (flags & Flag_enabled) = 0 then
            Precursor
            update
         end
      end

   disable
         -- Disable the menu
      do
         if (flags & Flag_enabled) /= 0 then
            Precursor
            update
         end
      end

   set_text (text: STRING)
         -- Set the text for Menu
      local
         string: STRING
      do
         string := u.strip_hot_key (text)
         if not label.is_equal (string) then
            remove_hot_key (hot_key)
            hot_key := u.parse_hot_key (text)
            hot_off := u.find_hot_key_offset (text)
            add_hot_key (hot_key)
            label := string
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
         -- Set the text color
      do
         if clr /= text_color then
            text_color := clr
            update
         end
      end

   set_sel_back_color (clr: INTEGER)
         -- Set the selection background color
      do
         if clr /= sel_back_color then
            sel_back_color := clr
            update
         end
      end

   set_sel_text_color (clr: INTEGER)
         -- Set the selection text color
      do
         if clr /= sel_text_color then
            sel_text_color := clr
            update
         end
      end

   set_hilite_color (clr: INTEGER)
         -- Set the highlight color
      do
         if clr /= hilite_color then
            hilite_color := clr
            update
         end
      end

   set_shadow_color (clr: INTEGER)
         -- Set the shadow color
      do
         if clr /= shadow_color then
            shadow_color := clr
            update
         end
      end

   set_help_text (text: STRING)
         -- Set the status line help text for this menu
      do
         help_text := text
      end

   set_menu_style (style: INTEGER)
      local
         opts: INTEGER
      do
         opts := new_options (style, MENU_MASK)
         if options /= opts then
            options := opts
            recalc
            update
         end
      end

feature -- Message processing

   handle_2 (sender: SB_MESSAGE_HANDLER; type, key: INTEGER; data: ANY): BOOLEAN
      do
         if		match_function_2 (SEL_COMMAND,Id_setstringvalue,	type, key) then Result := on_cmd_set_string_value	(sender, key, data)
         elseif match_function_2 (SEL_COMMAND,Id_getstringvalue,	type, key) then Result := on_cmd_get_string_value 	(sender, key, data)
         elseif match_function_2 (SEL_UPDATE,	Id_query_help,		type, key) then Result := on_query_help				(sender, key, data)
         else Result := Precursor (sender, type, key, data)
         end
      end

	on_paint (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
		local
         	event: SB_EVENT
         	dc: SB_DC_WINDOW
         	xx, yy: INTEGER
         	px, py: SB_POINT
      	do
         	event ?= data
         	check event /= Void end
         	dc := paint_dc
         	dc.make_event (Current, event)
         	dc.set_foreground (back_color)
         	dc.fill_rectangle (0,0,0,0)	-- ???? TODO
         	xx := LEADSPACE
         	if icon /= Void then
            	dc.draw_icon (icon, 3, (height - icon.height) // 2)
            	if icon.width + 5 > xx then
               		xx := icon.width + 5
            	end
         	end
         	if  not label.is_empty then
            	dc.set_font (font)
            	dc.set_foreground (text_color)
            	yy := font.get_font_ascent + (height - font.get_font_height) // 2
            	dc.draw_text (xx, yy, label)
            	if 0 < hot_off then
               		dc.fill_rectangle (xx + 1 + font.get_text_width_offset(label, 1, hot_off - 1), yy + 1,
                                 font.get_text_width_offset (label, hot_off, 1), 1)
            	end
         	end
         	dc.stop
         	Result := True
      	end

	on_query_help (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         if not help_text.is_empty and then (flags & Flag_help) /= 0 then
            sender.do_handle_2 (Current, SEL_COMMAND, Id_setvalue, help_text)
         end
         Result := True;
      end

   on_update (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         if not Precursor (sender, selector, data) then
            if (options & MENU_AUTOHIDE) /= 0 then
               if is_shown then
                  hide
                  recalc
               end
            end
            if (options & MENU_AUTOGRAY) /= 0 then
               disable
            end
         end
         Result := True
      end

   on_cmd_set_string_value (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         str: STRING
      do
         str ?= data
         set_text (str)
         Result := True
      end

   on_cmd_get_string_value (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         str: STRING
      do
         str ?= data
         check str /= Void end
         str.make_from_string (label)
         Result := True
      end

feature -- Resource management

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
			font.detach_resource
			if icon /= Void then
				icon.detach_resource
			end
			Precursor
		end

feature -- Destruction

	destruct
		do
			remove_hot_key (hot_key)
			font := Void
			icon := Void
			Precursor
		end

feature {NONE} -- Implementation

	hot_key: INTEGER
	hot_off: INTEGER

	LEADSPACE: INTEGER = 22
	TRAILSPACE: INTEGER = 16
	MENU_MASK: INTEGER once Result := MENU_AUTOGRAY | MENU_AUTOHIDE end

end
