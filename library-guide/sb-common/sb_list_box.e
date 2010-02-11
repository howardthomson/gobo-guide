indexing
	description: "ListBox"

	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

class SB_LIST_BOX

inherit
	SB_PACKER
      	rename
         	Id_last as PACKER_ID_LAST,
         	make as packer_make,
         	make_opts as packer_make_opts
      	redefine
         	default_width,
         	default_height,
         	enable,
         	disable,
         	handle_2,
         	on_focus_up,
         	on_focus_down,
         	on_focus_self,
         	create_resource,
         	detach_resource,
         	destroy_resource,
         	layout,
         	class_name
      	end

	SB_LIST_BOX_COMMANDS

	SB_LIST_BOX_CONSTANTS
--	SB_LABEL_CONSTANTS
--	SB_MENU_BUTTON_CONSTANTS
--	SB_LIST_CONSTANTS
--	SB_SCROLL_AREA_CONSTANTS

	SB_CONSTANTS
	
creation

   make, make_opts

feature -- Attributes

	field	: SB_BUTTON
	button	: SB_MENU_BUTTON
	list	: SB_LIST
	pane	: SB_POPUP

feature -- class name

	class_name: STRING is
		once
			Result := "SB_LIST_BOX"
		end

feature -- Creation

   make (p: SB_COMPOSITE; nvis: INTEGER; opts: INTEGER) is
         -- Construct tree list box
      local
         o: INTEGER;
      do
         if opts = Zero then
            o := Frame_sunken | Frame_thick | LISTBOX_NORMAL
         else
            o := opts;
         end
         make_opts(p, nvis, Void, 0, o, 0,0,0,0, DEFAULT_PAD, DEFAULT_PAD, DEFAULT_PAD, DEFAULT_PAD);
      end

   make_opts (p: SB_COMPOSITE; nvis: INTEGER; tgt: SB_MESSAGE_HANDLER; sel: INTEGER; opts: INTEGER;
              x,y, w,h, pl,pr, pt,pb: INTEGER) is
         -- Construct tree list box
      do
         packer_make_opts(p, opts, x,y,w,h, 0,0,0,0, 0,0)
         flags := flags | Flag_enabled
         message_target := tgt
         message := sel
         create field.make_opts(Current, " ", Void, Current, ID_FIELD, ICON_BEFORE_TEXT | JUSTIFY_LEFT, 0,0,0,0, pl,pr,pt,pb);
         field.set_back_color(application.back_color)
         create pane.make(Current, Frame_line)
         create list.make_opts(pane, nvis, Current, ID_LIST,
         	LIST_BROWSESELECT | LIST_AUTOSELECT 
            | Layout_fill_x | Layout_fill_y | SCROLLERS_TRACK | HSCROLLER_NEVER
         -- | Popup_shrinkwrap
            , 0,0,0,0)
         create button.make_opts(Current, Void, Void, pane, Frame_raised | Frame_thick | MENUBUTTON_DOWN 
                            | MENUBUTTON_ATTACH_RIGHT, 0,0,0,0, 0,0,0,0)
         button.set_offset_x(border)
         button.set_offset_y(border)
         unset_flags (Flag_update)  -- Never GUI update
      end

feature -- Queries

	default_width: INTEGER is
			-- Return default with
		local
			ww, pw: INTEGER;
		do
			ww := field.default_width + button.default_width + (border * 2)
			pw := pane.default_width
			Result := ww.max(pw)
		end

	default_height: INTEGER is
			-- Return default height
		local
			th, bh: INTEGER;
		do
			th := field.default_height;
			bh := button.default_height;
			Result := th.max(bh) + (border * 2);
		end

   items_count: INTEGER is
         -- Return number of items
      do
         Result := list.items_count
      end

   visible_rows: INTEGER is
         -- Return number of visible items
      do
         Result := list.visible_rows
      end

   is_pane_shown: BOOLEAN is
         -- Is the pane is_shown
      do
         Result := pane.is_shown
      end

   help_text: STRING is
         -- Return help text
      do
         Result := field.help
      end

   tip_text: STRING is
         -- Return tip text
      do
         Result := field.tip
      end

   font: SB_FONT is
         -- Return font
      do
         Result := field.font
      end

feature -- Item queries

   current_item: INTEGER is
         -- Return current item
      do
         Result := list.current_item
      end

   find_item_by_name(text: STRING): INTEGER is
         -- Search items for item by name, starting from first item case insensitive.
      do
         Result := list.find_item_by_name(text)
      end

   find_item_by_name_opts(text: STRING; start: INTEGER; flgs: INTEGER): INTEGER is
         -- Search items for item by name, starting from start item; the
         -- flags argument controls the search direction, and case 
         -- sensitivity.
      do
         Result := list.find_item_by_name_opts(text, start, flgs)
      end

   is_item_current(item: INTEGER): BOOLEAN is
         -- Return True if item is the current item
      do
         Result := list.is_item_current(item)
      end

feature -- Actions

   set_visible_rows(nvis: INTEGER) is
         -- Set number of visible items to determine default height
      do
         list.set_visible_rows(nvis)
      end

   enable is
         -- Enable widget
      do
         if (flags & Flag_enabled) = Zero then
            Precursor
            field.set_back_color(application.back_color)
            field.enable
            button.enable
         end
      end

   disable is
         -- Disable widget
      do
         if (flags & Flag_enabled) /= Zero then
            Precursor
            field.set_back_color(application.base_color)
            field.disable
            button.disable
         end
      end

   set_font(fnt: SB_FONT) is
         -- Change font
      require
         fnt /= Void
      do
         field.set_font(fnt)
         list.set_font(fnt)
         recalc
      end

   set_help_text(txt: STRING) is
         -- Change help text
      do
         field.set_help_text(txt)
      end

   set_tip_text(txt: STRING) is
         -- Change tip text
      do
         field.set_tip_text(txt)
      end

feature -- Item actions


   replace_item_with_new(index: INTEGER; text: STRING; icon: SB_ICON; data: ANY) is
      do
         list.replace_item_with_new(index, text, icon, data, False)
         if is_item_current(index) then
            field.set_icon(icon)
            field.set_text(text)
         end
         recalc
      end

   insert_item(index: INTEGER; text: STRING; icon: SB_ICON; data: ANY) is
         -- Insert item at index
      do
         list.insert_new_item(index, text, icon, data, False)
         if is_item_current(index) then
            field.set_icon(icon)
            field.set_text(text)
         end
         recalc
      end


   append_item(text: STRING; icon: SB_ICON; data: ANY) is
         -- Append item
      do
         list.append_new_item(text, icon, data, False)
         if is_item_current(items_count) then
            field.set_icon(icon)
            field.set_text(text)
         end
         recalc
      end


   prepend_item(text: STRING; icon: SB_ICON; data: ANY) is
         -- Prepend item
      do
         list.prepend_new_item(text, icon, data, False)
         if is_item_current(1) then
            field.set_icon(icon)
            field.set_text(text)
         end
         recalc
      end

   move_item(newindex, oldindex: INTEGER) is
         -- Move item from oldindex to newindex
      local
         cur: INTEGER;
      do
         cur := list.current_item
         list.move_item(newindex, oldindex)
         if cur /= list.current_item then
            cur := list.current_item
            if 0 <= cur then
               field.set_text(list.item(cur).label)
               field.set_icon(list.item(cur).icon)
            else
               field.set_text(" ")
               field.set_icon(Void)
            end
         end
         recalc;
      end

   remove_item(index: INTEGER) is
         -- Remove given item
      local
         c: INTEGER
      do
         c := list.current_item
         list.remove_item(index)
         if index = c then
            c := list.current_item
            if 0 < c then
               field.set_icon(list.item(c).icon)
               field.set_text(list.item(c).label)
            else
               field.set_icon(Void)
               field.set_text(" ")
            end
         end
         recalc
      end

   clear_items is
         -- Remove all items from list
      do
         list.clear_items
         field.set_icon(Void)
         field.set_text(" ")
         recalc
      end

   sort_items is
         -- Sort the toplevel items with the sort function
      do
         list.sort_items
      end

   set_current_item(index: INTEGER) is
         -- Change current item
      do
         list.set_current_item(index, False)
         if 0 < index then
            field.set_icon(list.item(index).icon)
            field.set_text(list.item(index).label)
         else
            field.set_icon(Void)
            field.set_text(" ")
         end
      end

   set_item_text(index: INTEGER; text: STRING) is
         -- Change item label
      do
         if is_item_current(index) then field.set_text(text) end
         list.set_item_text(index, text)
         recalc
      end

   set_item_icon(index: INTEGER; icon: SB_ICON) is
         -- Change item's icon
      do
         if is_item_current(index) then field.set_icon(icon) end
         list.set_item_icon(index, icon)
         recalc;
      end

   set_item_data(index: INTEGER; data: ANY) is
         -- Change item's user data
      do
         list.set_item_data(index, data)
      end

feature -- Message processing

	handle_2 (sender: SB_MESSAGE_HANDLER; type, selector: INTEGER; data: ANY): BOOLEAN is
    	do
        	if		match_function_2 (SEL_FOCUS_SELF,		0,				type, selector) then Result := on_focus_self 		(sender, selector, data)
         	elseif  match_function_2 (SEL_FOCUS_UP,			0,				type, selector) then Result := on_focus_up 			(sender, selector, data)
         	elseif  match_function_2 (SEL_FOCUS_DOWN,		0,				type, selector) then Result := on_focus_down 		(sender, selector, data)
         	elseif  match_function_2 (SEL_UPDATE,			ID_LIST,		type, selector) then Result := on_list_update 		(sender, selector, data)
         	elseif  match_function_2 (SEL_CHANGED,			ID_LIST,		type, selector) then Result := on_list_changed 		(sender, selector, data)
         	elseif  match_function_2 (SEL_CLICKED,			ID_LIST,		type, selector) then Result := on_list_clicked 		(sender, selector, data)
         	elseif  match_function_2 (SEL_LEFTBUTTONPRESS,	ID_FIELD,		type, selector) then Result := on_field_button 		(sender, selector, data)
         	elseif  match_function_2 (SEL_COMMAND,			Id_setvalue,	type, selector) then Result := on_cmd_set_value 	(sender, selector, data)
         	elseif  match_function_2 (SEL_COMMAND,			Id_setintvalue,	type, selector) then Result := on_cmd_set_int_value	(sender, selector, data)
         	elseif  match_function_2 (SEL_COMMAND,			Id_getintvalue,	type, selector) then Result := on_cmd_get_int_value	(sender, selector, data)
         	else Result := Precursor (sender, type, selector, data)
         	end
      end

	on_focus_self(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
		do
			Result := field.handle_2 (sender, SEL_FOCUS_SELF, 0, data)
		end

	index_ref(i: INTEGER): SE_REFERENCE [ INTEGER ] is	-- SE 2.1
		do
			create Result.set_item(i)
		end

	on_focus_up(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
		local
			index: INTEGER;
		do
			index := current_item
			if index < 1 then
				index := items_count
			elseif 1 < index then
				index := index - 1
			end
			if 0 < index and then index <= items_count then
				set_current_item(index)
				do_send (SEL_COMMAND, index_ref (index))
			end
			Result := True
		end

   on_focus_down(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      local
         index: INTEGER;
      do
         index := current_item;
         if index < 1 then index := 1
         elseif index < items_count then index := index + 1 end
         if 0 < index and then index <= items_count then
            set_current_item(index);
            do_send (SEL_COMMAND, index_ref (index))
         end
         Result := True
      end

   on_list_update(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      local
      do
         if not is_pane_shown and then message_target /= Void 
            and then message_target.handle_2 (Current, SEL_UPDATE, message, Void)
          then
            Result := True
         end
      end

	on_list_changed(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
    	local
        	index: INTEGER_REF
      	do
         	if send_att (SEL_CHANGED, data) then
            	Result := True
         	end
      	end

   on_field_button(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         button.do_handle_2 (Current, SEL_COMMAND, Id_post, Void)      -- Post the list
         Result := True
      end

   on_list_clicked(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      local
		 i: INTEGER
      do
      	 i := deref_integer(data)
         button.do_handle_2 (Current, SEL_COMMAND, Id_unpost, Void);    -- Unpost the list
         if 0 < i then
            field.set_text(list.item(i).label)
            field.set_icon(list.item(i).icon)
            do_send (SEL_COMMAND, data)
         end
         Result := True
      end

   on_cmd_set_value, on_cmd_set_int_value(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      local
		i: INTEGER
      do
      	 i := deref_integer(data)
         set_current_item(i);
         Result := True
      end

   on_cmd_get_int_value(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      local
         index: INTEGER_REF
      do
         index ?= data check index /= Void end
         index.set_item(current_item)
         Result := True
      end

feature -- Resource management

   create_resource is
         -- Create server-side resources
      do
         Precursor
         pane.create_resource
      end

   detach_resource is
         -- Detach server-side resources
      do
         pane.detach_resource
         Precursor
      end

   destroy_resource is
         -- Destroy server-side resources
      do
         pane.destroy_resource
         Precursor
      end

feature {NONE} -- Implementation

	layout is
		local
			button_width, field_width, item_height: INTEGER;
		do
			item_height := height - (border*2)
			button_width := button.default_width
			field_width := width - button_width - (border*2)
			field.position(border, border, field_width, item_height)
			button.position(border + field_width, border, button_width, item_height)
			pane.resize(width, pane.default_height)
			unset_flags (Flag_dirty);
		end
end
