indexing
	description: "ComboBox control"

	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

	todo: "[
		default width should be related to width of maximum sized element, rather
		than the currently displayed element ??
	]"

class SB_COMBO_BOX

inherit
	SB_PACKER
    	rename
        	Id_last as PACKER_ID_LAST,
        	make as packer_make,
        	make_sb as packer_make_sb,
			make_opts as packer_make_opts,
			back_color as window_back_color         
      	redefine
         	default_width,
         	default_height,
         	set_back_color,
         	enable,
         	disable,
         	handle_2,
         	on_focus_self,
         	on_focus_up,
         	on_focus_down,
         	create_resource,
         	detach_resource,
         	destroy_resource,
         	layout,
         	class_name
      	end

   	SB_COMBO_BOX_CONSTANTS

   	SB_COMBO_BOX_COMMANDS

   	SB_TEXT_FIELD_CONSTANTS

   	SB_LIST_CONSTANTS

   	SB_MENU_BUTTON_CONSTANTS

   	SB_SCROLL_AREA_CONSTANTS

creation

   	make, make_sb, make_opts

feature -- Attributes

	text_field	: SB_TEXT_FIELD
	button		: SB_MENU_BUTTON
	list		: SB_LIST
	pane		: SB_POPUP

feature -- class name

	class_name: STRING is
		once
			Result := "SB_COMBO_BOX"
		end

feature -- Creation

	make(p: SB_COMPOSITE) is
		do
			make_sb(p, 10, 10, Zero)
		end

   	make_sb(p: SB_COMPOSITE; cols, nvis: INTEGER; opts: INTEGER) is
         	-- Construct a combo box
      	do
         	make_opts(p, cols, nvis, Void, 0, opts, 0,0,0,0, DEFAULT_PAD, DEFAULT_PAD, DEFAULT_PAD, DEFAULT_PAD)
      	end

   	make_opts(p: SB_COMPOSITE; cols, nvis: INTEGER; tgt: SB_MESSAGE_HANDLER; sel: INTEGER; opts: INTEGER;
					x,y,w,h, pl,pr,pt,pb: INTEGER) is
         		-- Construct a combo box
      	do
         	packer_make_opts(p, opts, x,y,w,h, 0,0,0,0, 0,0)
         	flags := flags | Flag_enabled
         	message_target := tgt
         	message := sel
         	create text_field.make_opts (Current, cols, Current, ID_TEXT,Zero, 0,0,0,0, pl,pr,pt,pb)
         	if (options & COMBOBOX_STATIC) /= Zero then text_field.set_editable (False) end
         	create pane.make (Current, Frame_line)
         	create list.make_opts (pane, nvis, Current, ID_LIST, LIST_BROWSESELECT | LIST_AUTOSELECT | Layout_fill_x 
                     | Layout_fill_y | SCROLLERS_TRACK | HSCROLLER_NEVER, 0,0,0,0)
         	if (options & COMBOBOX_STATIC) /= Zero then list.set_scroll_style (SCROLLERS_TRACK | HSCROLLING_OFF) end
         	create button.make (Current, Void, Void, pane, Frame_raised | Frame_thick | MENUBUTTON_DOWN 
                       | MENUBUTTON_ATTACH_RIGHT)
         	button.set_offset_x (border)
         	button.set_offset_y (border)
         	unset_flags (Flag_update)  -- Never GUI update
      	end

feature -- Queries

	default_width: INTEGER is
			-- Return default width
		do

		-- The existing code results in varying width depending on the selected item in the pane
		--	Result :=   (text_field.default_width
		--		+ button.default_width + (border * 2)).max(pane.default_width)
		
			Result := button.default_width + (border * 2)
					+ (text_field.default_width.max(pane.default_width))
		end

	default_height: INTEGER is
			-- Return default height
		do
			Result := (text_field.default_height).max (button.default_height) + (border * 2)
		end

	is_editable: BOOLEAN is
			-- Return true if combobox is editable
		do
			Result := text_field.is_editable
		end

	columns_count: INTEGER is
			-- Get the number of columns
		do
			Result := text_field.columns_count
		end

	items_count: INTEGER is
    		-- Return the number of items in the list
		do
			Result := list.items_count
		end

   	visible_rows: INTEGER is
    		-- Return the number of visible items
      	do
         	Result := list.visible_rows
      	end

	is_item_current(index: INTEGER): BOOLEAN is
    		-- Return true if current item
      	do
         	Result := list.is_item_current(index)
      	end
  
	is_pane_shown: BOOLEAN is
    		-- Is the pane shown
      	do
         	Result := pane.is_shown
      	end

   get_combo_style: INTEGER is
         -- Get the combobox style.
      do
         Result := (options & COMBOBOX_MASK)
      end

   text_font: SB_FONT is
         -- Get text font
      do
         Result := text_field.text_font
      end

   text_color: INTEGER is
         -- Return text color
      do
         Result := text_field.text_color
      end

   back_color: INTEGER is
         -- Get background color
      do
         Result := text_field.sel_back_color
      end

   sel_text_color: INTEGER is
         -- Return selected text color
      do
         Result := text_field.sel_text_color
      end

   sel_back_color: INTEGER is
         -- Return selected background color
      do
         Result := text_field.sel_back_color
      end

   item_comparator: SB_COMPARATOR[SB_LIST_ITEM] is
         -- Item sort function
      do
--#         Result := list.item_comparator
      end

   help_text: STRING is
         -- Get the combobox help text
      do
         Result := text_field.help_text
      end

   tip_text: STRING is
         -- Get the tool tip message for Current combobox
      do
         Result := text_field.tip_text
      end

   text: STRING is
         -- Get the text
      do
         Result := text_field.contents
      end

   	current_item: INTEGER is
         	-- Get the current item's index
      	do
         	Result := list.current_item
      	end

	find_item(txt: STRING): INTEGER is
         	-- Search items for item by name, starting from first item case insensitiv.
      	do
         	Result := list.find_item_by_name (txt)
      	end

   	find_item_opt(txt: STRING; start: INTEGER; flgs: INTEGER): INTEGER is
         	-- Search items for item by name, starting from start item; the
         	-- flags argument controls the search direction, and case sensitivity.
      	do
         	Result := list.find_item_by_name_opts (txt, start, flgs)
      	end

   	item (index: INTEGER): STRING is
         	-- Return the item at the given index
      	require
         	index > 0 and then index <= items_count
      	do
         	Result := list.item (index).label
      	end

   	item_text (index: INTEGER): STRING is
         	-- Get text for specified item
      	require
         	index > 0 and then index <= items_count
      	do
         	Result := list.item (index).label
		end

	item_data (index: INTEGER): ANY is
			-- Get data pointer for specified item
      	require
         	index > 0 and then index < items_count
      	do
         	Result := list.item (index).data
      	end

feature -- Actions

   enable is
         -- Enable combo box
      do
         if (flags & Flag_enabled) = Zero then
            Precursor
            text_field.enable
            button.enable
         end
      end

   disable is
         -- Disable combo box
      do
         if (flags & Flag_enabled) /= Zero then
            Precursor
            text_field.disable
            button.disable
         end
      end

   set_editable (edit: BOOLEAN) is
         -- Set editable state
      do
         text_field.set_editable (edit)
      end

   set_text (txt: STRING) is
         -- Set the text
      do
         text_field.set_text (txt)
      end

   set_columns_count (cols: INTEGER) is
         -- Set the number of columns
      do
         text_field.set_columns_count (cols)
      end

   set_visible_rows (nvis: INTEGER) is
         -- Set the number of visible items
      do
         list.set_visible_rows (nvis)
      end

   set_current_item (index: INTEGER) is
         -- Set the current item (index is Zero-based)
      do
         list.set_current_item (index, False)
         if 1 <= index then
            set_text(list.item (index).label)
         else
            set_text ("")
         end
      end

   replace_item (index: INTEGER; txt: STRING; data: ANY) is
         -- Replace the item at index
      do
         list.replace_item_with_new (index, txt, Void, data, False)
         if is_item_current (index) then
            text_field.set_text (txt)
         end
         recalc
      end

   insert_item (index: INTEGER; txt: STRING; data: ANY) is
         -- Insert a new item at index
      do
         list.insert_new_item (index, txt, Void, data, False)
         if is_item_current (index) then
            text_field.set_text (txt)
         end
         recalc
      end

   append_item (txt: STRING;data: ANY) is
         -- Append an item to the list
      do
         list.append_new_item (txt, Void, data, False)
         if is_item_current (items_count) then
            text_field.set_text (txt)
         end
         recalc
      end

   prepend_item (txt: STRING; data: ANY) is
         -- Prepend an item to the list
      do
         list.prepend_new_item (txt, Void, data, False)
         if is_item_current (1) then
            text_field.set_text (txt)
         end
         recalc
      end

   move_item (newindex,oldindex: INTEGER) is
         -- Move item from oldindex to newindex
      local
         cur: INTEGER
      do
         cur := list.current_item
         list.move_item (newindex, oldindex)
         if cur /= list.current_item then
            cur := list.current_item
            if 0 <= cur then
               text_field.set_text (list.item (cur).label)
            else
               text_field.set_text (" ")
            end
         end
         recalc
      end

   remove_item (index: INTEGER) is
         -- Remove this item from the list
      local
         cur: INTEGER
      do
         cur := list.current_item
         list.remove_item (index)
         if index = cur then
            cur := list.current_item
            if 1 <= cur then
               text_field.set_text (list.item (index).label)
            else
               text_field.set_text ("")
            end
         end
         recalc
      end

   clear_items is
         -- Remove all items from the list
      do
         text_field.set_text ("")
         list.clear_items
         recalc
      end


   set_item_text(index: INTEGER; txt: STRING) is
         -- Set text for specified item
      do
         if is_item_current (index) then set_text (txt) end
         list.set_item_text (index, txt)
         recalc
      end

   set_item_data(index: INTEGER; data: ANY) is
         -- Set data pointer for specified item
      do
         list.set_item_data (index, data)
      end

   sort_items is
         -- Sort items using current sort function
      do
         list.sort_items
      end

   set_text_font(fnt: SB_FONT) is
         -- Set text font
      require
         fnt /= Void
      do
         text_field.set_font (fnt)
         list.set_font (fnt)
         recalc
      end

   set_combo_style (mode: INTEGER) is
         -- Set the combobox style.
      local
         opts: INTEGER
      do
         opts := new_options (mode, COMBOBOX_MASK)
         if opts /= options then
            options := opts
            if (options & COMBOBOX_STATIC) /= Zero then
               text_field.set_editable (False)                            -- Non-editable
               list.set_scroll_style (SCROLLERS_TRACK | HSCROLLING_OFF)  -- No scrolling
            else
               text_field.set_editable (True)                             -- Editable
               list.set_scroll_style (SCROLLERS_TRACK | HSCROLLER_NEVER) -- Scrollable, but no scrollbar
            end
            recalc
         end
      end

   set_back_color (clr: INTEGER) is
         -- Set window background color
      do
         text_field.set_back_color (clr)
         list.set_back_color (clr)
      end

   set_text_color (clr: INTEGER) is
         -- Change text color
      do
         text_field.set_text_color (clr)
         list.set_text_color (clr)
      end

   set_sel_back_color (clr: INTEGER) is
         -- Change selected background color
      do
         text_field.set_sel_back_color (clr)
         list.set_sel_back_color (clr)
      end

   set_sel_text_color (clr: INTEGER) is
         -- Change selected text color
      do
         text_field.set_sel_text_color (clr)
         list.set_sel_text_color (clr)
      end

   set_item_comparator (comp: like item_comparator) is
         -- Change sort function
      do
--#         list.set_item_comparator (comp)
      end

   set_help_text (txt: STRING) is
         -- Set the combobox help text
      do
         text_field.set_help_text (txt)
      end

   set_tip_text (txt: STRING) is
         -- Set the tool tip message for this combobox
      do
         text_field.set_tip_text (txt)
      end

feature -- Message processing

	handle_2 (sender: SB_MESSAGE_HANDLER; type, key: INTEGER; data: ANY): BOOLEAN is
    	do
        	if		match_function_2 (SEL_UPDATE,			ID_TEXT,			type, key) then Result := on_upd_fm_text  (sender, key, data)
        	elseif  match_function_2 (SEL_CLICKED,			ID_LIST,			type, key) then Result := on_list_clicked (sender, key, data)
        	elseif  match_function_2 (SEL_LEFTBUTTONPRESS,	ID_TEXT,			type, key) then Result := on_text_button  (sender, key, data)
        	elseif  match_function_2 (SEL_CHANGED,			ID_TEXT,			type, key) then Result := on_text_changed (sender, key, data)
        	elseif  match_function_2 (SEL_COMMAND,			ID_TEXT,			type, key) then Result := on_text_command (sender, key, data)
        	elseif  match_function_2 (SEL_COMMAND,			Id_setvalue,		type, key) then Result := on_fwd_to_text  (sender, key, data)
        	elseif  match_function_2 (SEL_COMMAND,			Id_setintvalue,		type, key) then Result := on_fwd_to_text  (sender, key, data)
        	elseif  match_function_2 (SEL_COMMAND,			Id_setrealvalue,	type, key) then Result := on_fwd_to_text  (sender, key, data)
        	elseif  match_function_2 (SEL_COMMAND,			Id_setstringvalue,	type, key) then Result := on_fwd_to_text  (sender, key, data)
        	elseif  match_function_2 (SEL_COMMAND,			Id_getintvalue,		type, key) then Result := on_fwd_to_text  (sender, key, data)
        	elseif  match_function_2 (SEL_COMMAND,			Id_getrealvalue,	type, key) then Result := on_fwd_to_text  (sender, key, data)
        	elseif  match_function_2 (SEL_COMMAND,			Id_getstringvalue,	type, key) then Result := on_fwd_to_text  (sender, key, data)
        	else Result := Precursor (sender, type, key, data)
        	end
      end

   on_focus_self (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         Result := text_field.handle_2 (sender, SEL_FOCUS_SELF, 0, data)
      end

   on_focus_up (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      local
         index: INTEGER
      do
         index := current_item
         if index < 1 then
         	index := items_count
         elseif 1 < index then
         	index := index - 1
         end
         if 1 <= index and then index <= items_count then
            set_current_item(index)
            if message_target /= Void then
               message_target.do_handle_2 (Current, SEL_COMMAND, message, text)
            end
         end
         Result := True
      end

   on_focus_down (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      local
         index: INTEGER
      do
         index := current_item
         if index < 1 then index := 1
         elseif index < items_count then index := index + 1 end
         if 1 <= index and then index <= items_count then
            set_current_item(index)
            if message_target /= Void then
               message_target.do_handle_2 (Current, SEL_COMMAND, message, text)
            end
         end
         Result := True
      end

   on_text_button (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         if (options & COMBOBOX_STATIC) /= Zero then
            button.do_handle_2 (Current, SEL_COMMAND, Id_post, Void)    -- Post the list
            Result := True
         end
      end

   on_text_changed (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         if message_target /= Void
            and then message_target.handle_2 (Current, SEL_CHANGED, message, data)
          then
            Result := True
         end
      end

   on_text_command (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      local
         index: INTEGER
         t: INTEGER
         str: STRING
      do
         str ?= data
         check
            str /= Void
         end
         index := list.current_item

         if (options & COMBOBOX_STATIC) = Zero then
            t := (options & COMBOBOX_INS_MASK)
            if t = COMBOBOX_REPLACE then
               if 1 <= index then replace_item (index, str, item_data (index)) end
            elseif t = COMBOBOX_INSERT_BEFORE then
               if 1 <= index then insert_item (index, str, Void) end
            elseif t = COMBOBOX_INSERT_AFTER then
               if 1 <= index then insert_item (index + 1, str, Void) end
            elseif t = COMBOBOX_INSERT_FIRST then
               insert_item (1, str, Void)
            elseif t = COMBOBOX_INSERT_LAST then
               append_item(str,Void)
            end
         end
         if message_target /= Void
            and then message_target.handle_2 (Current, SEL_COMMAND, message, data)
          then
            Result := True
         end
      end

   on_list_clicked(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      local
      --   i: INTEGER_REF
      	i: SE_REFERENCE [ INTEGER ]
      do
         i ?= data
         check
            i /= Void
         end
         button.do_handle_2 (Current, SEL_COMMAND, Id_unpost, Void)    -- Unpost the list
         if 1 <= i.item then
            text_field.set_text (list.item (i.item).label)
            do_send (SEL_COMMAND, text)
         end
         Result := True
      end

   on_fwd_to_text(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         Result := text_field.handle_2 (sender, SEL_COMMAND, selector,data)
      end

   on_upd_fm_text(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         if message_target /= Void and then not is_pane_shown
            and then message_target.handle_2 (Current, SEL_UPDATE, message, Void)
          then
            Result := True
         end
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
         	Precursor
         	pane.detach_resource
      	end

   	destroy_resource is
         	-- Destroy server-side resources
      	do
         	pane.destroy_resource
         	Precursor
      	end

feature { NONE } -- Implementation

   	COMBOBOX_INS_MASK: INTEGER is 
      	once
         	Result := (COMBOBOX_REPLACE | COMBOBOX_INSERT_BEFORE | COMBOBOX_INSERT_AFTER 
                    | COMBOBOX_INSERT_FIRST | COMBOBOX_INSERT_LAST)
      	end

	COMBOBOX_MASK: INTEGER is 
    	once
        	Result := (COMBOBOX_STATIC | COMBOBOX_INS_MASK)
      	end

	layout is
    	local
         	buttonWidth, textWidth, itemHeight: INTEGER
      	do
         	itemHeight := height - (border*2)
         	buttonWidth := button.default_width
         	textWidth := width - buttonWidth - (border*2)
         	text_field.position(border, border, textWidth, itemHeight)
         	button.position(border + textWidth, border, buttonWidth, itemHeight)
         	pane.resize(width, pane.default_height)
         	unset_flags (Flag_dirty)
      	end

end
