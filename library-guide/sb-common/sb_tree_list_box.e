indexing
	description:"[
		TreeListBox
		Combo drop down box with tree_list selector panel
	]"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

class SB_TREE_LIST_BOX

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

   SB_TREE_LIST_BOX_CONSTANTS

   SB_TREE_LIST_BOX_COMMANDS

   SB_LABEL_CONSTANTS

   SB_MENU_BUTTON_CONSTANTS

   SB_TREE_LIST_CONSTANTS

   SB_SCROLL_AREA_CONSTANTS

creation

	make, make_opts

feature -- class name

	class_name: STRING is
		once
			Result := "SB_TREE_LIST_BOX"
		end

feature -- Creation

   make (p: SB_COMPOSITE; nvis: INTEGER; opts: INTEGER) is
         -- Construct tree list box
      local
         o: INTEGER;
      do
         if opts = Zero then
            o := Frame_sunken | Frame_thick | TREELISTBOX_NORMAL
         else
            o := opts;
         end
         make_opts(p,nvis, Void,0, o, 0,0,0,0,
         			DEFAULT_PAD, DEFAULT_PAD, DEFAULT_PAD, DEFAULT_PAD);
      end

   make_opts (p: SB_COMPOSITE; nvis: INTEGER; tgt: SB_MESSAGE_HANDLER; sel: INTEGER;opts: INTEGER;
              x, y, w, h, pl, pr, pt, pb: INTEGER) is
         -- Construct tree list box
      do
         packer_make_opts(p, opts, x,y,w,h, 0,0,0,0, 0,0);
         flags := flags | Flag_enabled;
         message_target := tgt;
         message := sel;
         create field.make_opts(Current," ",Void,Current,ID_FIELD,ICON_BEFORE_TEXT | JUSTIFY_LEFT, 0,0,0,0, pl,pr,pt,pb);
         field.set_back_color(application.back_color);
         create pane.make(Current,Frame_line);
         create tree.make(pane,nvis,Current,ID_TREE,TREELIST_BROWSESELECT | TREELIST_AUTOSELECT 
                     | Layout_fill_x | Layout_fill_y | SCROLLERS_TRACK | HSCROLLING_OFF);
         tree.set_indent(0);
         create button.make_opts(Current,Void,Void,pane,Frame_raised | Frame_thick | MENUBUTTON_DOWN 
                            | MENUBUTTON_ATTACH_RIGHT, 0,0,0,0, 0,0,0,0);
         button.set_offset_x(border);
         button.set_offset_y(border);
         unset_flags (Flag_update);  -- Never GUI update
      end

feature -- Data

   field: SB_BUTTON;
   button: SB_MENU_BUTTON;
   tree: SB_TREE_LIST;
   pane: SB_POPUP;

feature -- Queries

   default_width: INTEGER is
         -- Return default with
      local
         ww,pw: INTEGER;
      do
         ww := field.default_width+button.default_width+(border*2);
         pw := pane.default_width;
         Result := ww.max(pw);
      end

   default_height: INTEGER is
         -- Return default height
      local
         th,bh: INTEGER;
      do
         th := field.default_height;
         bh := button.default_height;
         Result := th.max(bh)+(border*2);
      end

   item_count: INTEGER is
         -- Return number of items
      do
         Result := tree.item_count;
      end

   visible_rows: INTEGER is
         -- Return number of visible items
      do
         Result := tree.visible_rows;
      end

   is_pane_shown: BOOLEAN is
         -- Is the pane is_shown
      do
         Result := pane.is_shown;
      end

   get_list_style: INTEGER is
         -- Return list style
      do
         Result := options & TREELISTBOX_MASK;
      end

   help_text: STRING is
         -- Return help text
      do
         Result := field.help;
      end

   tip_text: STRING is
         -- Return tip text
      do
         Result := field.tip;
      end

   font: SB_FONT is
         -- Return font
      do
         Result := field.font;
      end

feature -- Item queries

   first_item: SB_TREE_LIST_ITEM is
         -- Return first top-level item
      do
         Result := tree.first_item;
      end

   last_item: SB_TREE_LIST_ITEM is
         -- Return last top-level item
      do
         Result := tree.last_item;
      end

   current_item: SB_TREE_LIST_ITEM is
         -- Return current item
      do
         Result := tree.current_item;
      end

   find_item_by_name(text: STRING): SB_TREE_LIST_ITEM is
         -- Search items for item by name, starting from first item case insensitive.
      do
         Result := tree.find_item_by_name(text);
      end

   find_item_by_name_opts(text: STRING; start: SB_TREE_LIST_ITEM; flgs: INTEGER): SB_TREE_LIST_ITEM is
         -- Search items for item by name, starting from start item; the
         -- flags argument controls the search direction, and case 
         -- sensitivity.
      do
         Result := tree.find_item_by_name_opts(text,start,flgs);
      end

   is_item_current(item: SB_TREE_LIST_ITEM): BOOLEAN is
         -- Return True if item is the current item
      do
         Result := tree.is_item_current(item);
      end

   item_comparator: SB_COMPARATOR[SB_TREE_LIST_ITEM] is
         -- Return item sort function
      do
         Result := tree.item_comparator
      end

feature -- Actions

   set_visible_rows(nvis: INTEGER) is
         -- Set number of visible items to determine default height
      do
         tree.set_visible_rows(nvis);
      end

   enable is
         -- Enable widget
      do
         if (flags & Flag_enabled) = Zero then
            Precursor;
            field.set_back_color(application.back_color);
            field.enable;
            button.enable;
         end
      end

   disable is
         -- Disable widget
      do
         if (flags & Flag_enabled) /= Zero then
            Precursor;
            field.set_back_color(application.base_color);
            field.disable;
            button.disable;
         end
      end

   set_font(fnt: SB_FONT) is
         -- Change font
      require
         fnt /= Void
      do
         field.set_font(fnt);
         tree.set_font(fnt);
         recalc;
      end

   set_list_style(style: INTEGER) is
         -- Change list style
      local
         opts: INTEGER
      do
         opts := new_options (style, TREELISTBOX_MASK)
         if opts /= options then
            options := opts;
            recalc;
         end
      end

   set_help_text(txt: STRING) is
         -- Change help text
      do
         field.set_help_text(txt);
      end

   set_tip_text(txt: STRING) is
         -- Change tip text
      do
         field.set_tip_text(txt);
      end

feature -- Item actions

   add_item_first(p,item: SB_TREE_LIST_ITEM) is
         -- Add item as first child of parent p
      do
         recalc;
         tree.add_item_first(p,item,False);
      end

   add_item_last(p,item: SB_TREE_LIST_ITEM) is
         -- Add item as last child after parent p
      do
         recalc;
         tree.add_item_last(p,item,False);
      end

   add_item_after(other,item: SB_TREE_LIST_ITEM) is
         -- Add item after other item
      do
         recalc;
         tree.add_item_after(other,item,False);
      end

   add_item_before(other,item: SB_TREE_LIST_ITEM) is
         -- Add item before other item
      do
         recalc;
         tree.add_item_before(other,item,False);
      end

   create_item_first(p: SB_TREE_LIST_ITEM; text: STRING; oi,ci: SB_ICON; data: ANY): SB_TREE_LIST_ITEM is
         -- Add new item with given text, icons and user-data as first child of p
      do
         Result := tree.create_item_first(p,text,oi,ci,data,False);
         recalc;
      end

   create_item_last(p: SB_TREE_LIST_ITEM; text: STRING; oi,ci: SB_ICON; data: ANY): SB_TREE_LIST_ITEM is
         -- Add new item with given text, icons and user-data as the last child of p
      do
         Result := tree.create_item_last(p,text,oi,ci,data,False);
         recalc;
      end

   create_item_after(other: SB_TREE_LIST_ITEM; text: STRING; oi,ci: SB_ICON; data: ANY): SB_TREE_LIST_ITEM is
         -- Add new item with given text, icons and user-data after other other
      do
         Result := tree.create_item_after(other,text,oi,ci,data,False);
         recalc;
      end

   create_item_before(other: SB_TREE_LIST_ITEM; text: STRING; oi,ci: SB_ICON; data: ANY): SB_TREE_LIST_ITEM is
         -- Add new item with given text, icons and user-data before other other
      do
         Result := tree.create_item_before(other,text,oi,ci,data,False);
         recalc;
      end

   remove_item(item: SB_TREE_LIST_ITEM) is
         -- Remove item
      do
         tree.remove_item(item)
         recalc;
      end

   remove_items(fm,to: SB_TREE_LIST_ITEM) is
         -- Remove all items in range [fm...to]
      do
         tree.remove_items (fm, to, False)
         recalc
      end

   clear_items is
         -- Remove all items from list
      do
         tree.clear_items
         recalc
      end

   sort_child_items(item: SB_TREE_LIST_ITEM) is
         -- Sort child items of item
      do
         tree.sort_child_items(item)
      end

   sort_root_items is
         -- Sort the toplevel items with the sort function
      do
         tree.sort_root_items
      end

   set_current_item(item: SB_TREE_LIST_ITEM; notify: BOOLEAN) is
         -- Change current item
      do
         tree.set_current_item(item,notify)
         if item /= Void then
            field.set_icon(item.closed_icon)
            field.set_text(item.label)
         else
            field.set_icon(Void)
            field.set_text(Void)
         end
      end

   set_item_text(item: SB_TREE_LIST_ITEM; text: STRING) is
         -- Change item label
      require
         item /= Void
      do
         if is_item_current(item) then field.set_text(text) end
         tree.set_item_text(item,text)
         recalc;
      end

   set_item_open_icon(item: SB_TREE_LIST_ITEM; icon: SB_ICON) is
         -- Change item's open icon
      require
         item /= Void
      do
         tree.set_item_open_icon(item,icon)
      end

   set_item_closed_icon(item: SB_TREE_LIST_ITEM; icon: SB_ICON) is
         -- Change item's closed icon
      require
         item /= Void
      do
         tree.set_item_closed_icon(item,icon)
      end

   set_item_data(item: SB_TREE_LIST_ITEM; data: ANY) is
         -- Change item's user data
      require
         item /= Void
      do
         tree.set_item_data(item,data)
      end
   
   set_item_comparator(comp: SB_COMPARATOR[SB_TREE_LIST_ITEM]) is
         -- Change item sort function
      do
         tree.set_item_comparator(comp)
      end

feature -- Message processing

	handle_2 (sender: SB_MESSAGE_HANDLER; type, key: INTEGER; data: ANY): BOOLEAN is
    	do
        	if		match_function_2 (SEL_FOCUS_UP,			0,			type, key) then Result := on_focus_up 	(sender, key, data)
         	elseif  match_function_2 (SEL_FOCUS_DOWN,		0,			type, key) then Result := on_focus_down 	(sender, key, data)
         	elseif  match_function_2 (SEL_FOCUS_SELF,		0,			type, key) then Result := on_focus_self 	(sender, key, data)
         	elseif  match_function_2 (SEL_CHANGED,			0,			type, key) then Result := on_changed 		(sender, key, data)
         	elseif  match_function_2 (SEL_COMMAND,			0,			type, key) then Result := on_command 		(sender, key, data)
         	elseif  match_function_2 (SEL_UPDATE,			ID_TREE,	type, key) then Result := on_upd_fm_tree 	(sender, key, data)
         	elseif  match_function_2 (SEL_CHANGED,			ID_TREE,	type, key) then Result := on_tree_changed	(sender, key, data)
         	elseif  match_function_2 (SEL_CLICKED,			ID_TREE,	type, key) then Result := on_tree_clicked	(sender, key, data)
         	elseif  match_function_2 (SEL_LEFTBUTTONPRESS,	ID_FIELD,	type, key) then Result := on_field_button	(sender, key, data)
         	else Result := Precursor (sender, type, key, data)
         	end
      	end

   on_focus_up(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      local
         item: SB_TREE_LIST_ITEM
      do
         item := current_item
         if item = Void then
            from
               item := last_item
            until
               item = Void or else item.last_child = Void
            loop
               item := item.last_child
            end
         elseif item.above_item /= Void then
            item := item.above_item
         end
         if item /= Void then
            set_current_item (item, False)
            do_handle_2 (Current, SEL_COMMAND, 0, item)
         end
         Result := True;
      end

   on_focus_down(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      local
         item: SB_TREE_LIST_ITEM
      do
         item := current_item
         if item = Void then
            item := first_item
         elseif item.below_item /= Void then
            item := item.below_item
         end
         if item /= Void then
            set_current_item (item, False)
            do_handle_2 (Current, SEL_COMMAND, 0, item)
         end
         Result := True
      end

   on_focus_self(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         Result := field.handle_2 (sender, SEL_FOCUS_SELF, 0, data)
      end

   on_changed(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         if message_target /= Void then
            message_target.do_handle_2 (Current, SEL_CHANGED, message, data)
         end
         Result := True
      end

   on_command(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         if message_target /= Void then
            message_target.do_handle_2 (Current, SEL_COMMAND, message, data)
         end
         Result := True
      end

   on_field_button(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         button.do_handle_2 (Current, SEL_COMMAND, Id_post, Void)      -- Post the list
         Result := True
      end

   on_tree_changed(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         do_handle_2 (Current, SEL_CHANGED, 0, data)
         Result := True
      end

   on_tree_clicked(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      local
         item: SB_TREE_LIST_ITEM
      do
         item ?= data
         button.do_handle_2 (Current, SEL_COMMAND, Id_unpost, Void)    -- Unpost the list
         if item /= Void then
            field.set_text(item.label)
            field.set_icon(item.closed_icon)
            do_handle_2 (Current, SEL_COMMAND, 0, item)
         end
         Result := True
      end

   	on_upd_fm_tree(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
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

   	TREELISTBOX_MASK: INTEGER is 0

	layout is
      	local
         	button_width,field_width,item_height: INTEGER;
      	do
         	item_height := height - (border*2)
         	button_width := button.default_width
         	field_width := width - button_width - (border*2)
         	field.position(border, border, field_width, item_height)
         	button.position(border + field_width, border, button_width, item_height)
         	pane.resize(width, pane.default_height)
         	unset_flags (Flag_dirty)
      	end
end
