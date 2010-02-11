indexing
	description: "List Widget"

	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002,  Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"
	todo: "[
		Review Timer events and on_auto_scroll w.r.t. Event(data) value
	]"

class SB_LIST

inherit

	SB_BASE_LIST [ SB_LIST_ITEM ]
    	rename
        	make as scroll_area_make, 
        	make_opts as scroll_area_make_opts
      	redefine
         	default_height,
         	can_focus,
         	content_height,
         	content_width,
         	create_resource,
         	detach_resource,
         	handle_2,
         	on_key_press,
         	on_left_btn_press,
         	on_left_btn_release,
         	on_right_btn_press,
         	on_motion,
         	on_paint,
         	on_auto_scroll,
         	layout,
         	class_name
      	end

   	SB_LIST_CONSTANTS

   	SB_LIST_COMMANDS

   	SB_KEYS
      	export {NONE} all
      	end

creation

   make, make_opts

feature -- Attributes

	visible_rows: INTEGER;	-- Number of rows high

feature -- class name

	class_name: STRING is
		once
			Result := "SB_LIST"
		end

feature -- Creation

   make(p: SB_COMPOSITE; nvis: INTEGER; opts: INTEGER) is
         -- Construct a list with nvis visible items; the list is initially is_empty
      do
         make_opts(p, nvis, Void,  0,  opts,  0,  0,  0,  0)
      end

   make_opts(p: SB_COMPOSITE; nvis: INTEGER; tgt: SB_MESSAGE_HANDLER; sel: INTEGER; opts: INTEGER;
             x,  y,  w,  h: INTEGER) is
         -- Construct a list with nvis visible items; the list is initially is_empty
      do
         scroll_area_make_opts (p, opts, x, y, w, h)
         flags := flags | Flag_enabled
         message_target := tgt
         message := sel
         create items.make (1, 0)
         anchor_item := 0
         current_item := 0
         extent_item := 0
         cursor_item := 0
         font := application.normal_font
         text_color := application.fore_color
         sel_back_color := application.sel_back_color
         sel_text_color := application.sel_fore_color
         list_width := 0
         list_height := 0
         visible_rows := nvis.max (0)
         grab_x := 0
         grab_y := 0
         timer := Void
         lookup_timer := Void
         create lookup_string.make_empty
         state := False
      end

feature -- Queries

   default_height: INTEGER is
         -- Return default height
      do
         if visible_rows /= 0 then
            Result := visible_rows * (LINE_SPACING + font.get_font_height)
         else
            Result := Precursor
         end
      end

   content_width: INTEGER is
         -- Compute and return content width
      do
         if (flags & Flag_recalc) /= 0 then
            recompute
         end
         Result := list_width
      end

   content_height: INTEGER is
         -- Return content height
      do
         if (flags & Flag_recalc) /= 0 then
            recompute
         end
         Result := list_height
      end

   can_focus: BOOLEAN is
         -- List widget can receive focus
      once
         Result := True
      end

   get_list_style: INTEGER is
         -- Return list style
      do
         Result := (options & LIST_MASK)
      end

feature -- Item access

   item_at (x_,  y_: INTEGER): INTEGER is
         -- Return index of item at x, y,  if any
      local
         index: INTEGER
         nitems: INTEGER
         y: INTEGER
      do
         y := y_ - pos_y
         from            
            index := 1
            nitems := items_count
         until
            index > nitems or else Result /= 0
         loop
            if items.item(index).y < y and then  y < items.item(index).y + items.item(index).height(Current) then
               Result := index
            end
            index := index + 1
         end
      end

   item_width (index: INTEGER): INTEGER is
         -- Return item width
      require
         index > 0 and then index <= items_count
      do
         Result := items.item (index).width (Current)
      end

   item_height (index: INTEGER): INTEGER is
         -- Return item height
      require
         index > 0 and then index <= items_count
      do
         Result := items.item(index).height(Current)
      end

   item_hit (index,  x_,  y_: INTEGER): INTEGER is
         -- Return item hit code:
         --		0: no hit
         --		1: hit the icon
         --		2: hit the text
      local
         x, y, ix, iy: INTEGER
      do
         if 0 < index and then index <= items_count then
            x := x_ - pos_x
            y := y_ - pos_y
            ix := items.item(index).x
            iy := items.item(index).y
            Result := items.item(index).item_hit(Current, x-ix, y-iy)
         end
      end

feature -- Actions

   set_visible_rows (nvis_: INTEGER) is
         -- Change the number of visible items
      local
         nvis: INTEGER;
      do         
         if nvis_ < 0 then
            nvis := 0
         else
            nvis := nvis_
         end
         if visible_rows /= nvis then
            visible_rows := nvis
            recalc
         end
      end

   set_list_style(style: INTEGER) is
         -- Change list style
      do
         options := new_options (style, LIST_MASK)
      end

feature -- Item actions

   replace_item_with_new (index: INTEGER; text: STRING; icon: SB_ICON; data: ANY; notify: BOOLEAN) is
         -- Replace items text,  icon,  and user-data pointer
      do
         replace_item (index, create_item (text, icon, data), notify)
      end

   insert_new_item (index: INTEGER; text: STRING; icon: SB_ICON; data: ANY; notify: BOOLEAN) is
         -- Insert item at index with given text,  icon,  and user-data pointer
      do
         insert_item (index, create_item (text, icon, data), notify);
      end

	append_new_item (text: STRING; icon: SB_ICON; data: ANY; notify: BOOLEAN) is
			-- Append new item with given text and optional icon,  and user-data pointer
		do
			check
				items_not_void: items /= Void
			end
--	print(once "Entered append_new_item%N")
			insert_item (items.count + 1, create_item (text, icon, data), notify)
--	print(once "Exit append_new_item%N")
		end

   prepend_new_item (text: STRING; icon: SB_ICON; data: ANY; notify: BOOLEAN) is
         -- Prepend new item with given text and optional icon,  and user-data pointer
      do
         insert_item (1, create_item (text, icon, data), notify)
      end

   make_item_visible (index: INTEGER) is
         -- Scroll to bring item into view
      local
         y, h: INTEGER
      do
         if is_attached then
            if 1 <= index and then index <= items.count then
               y := pos_y
               h := items.item (index).height (Current)
               if viewport_h <= y + items.item (index).y + h then
               		y := viewport_h - items.item (index).y - h
               end
               if y + items.item (index).y <= 0 then
               		y := -items.item (index).y
               end
               set_scroll_position (pos_x, y)
            end
         end
      end

	update_item(index: INTEGER) is
         	-- Repaint item
      	do
         	update_rectangle (0, pos_y + items.item (index).y, viewport_w, items.item (index).height (Current))
      	end

feature -- Message processing

	handle_2 (sender: SB_MESSAGE_HANDLER; type, selector: INTEGER; data: ANY): BOOLEAN is
    	do
         	if		match_function_2 (Sel_timeout, 		ID_TIPTIMER,	type, selector) then Result := on_tip_timer 		(sender, selector, data)
         	elseif  match_function_2 (Sel_timeout, 		ID_LOOKUPTIMER, type, selector) then Result := on_lookup_timer 	 	(sender, selector, data)
         	elseif  match_function_2 (SEL_CLICKED, 		0, 				type, selector) then Result := on_clicked 		 	(sender, selector, data)
         	elseif  match_function_2 (SEL_DOUBLECLICKED,0, 				type, selector) then Result := on_double_clicked 	(sender, selector, data)
         	elseif  match_function_2 (SEL_TRIPLECLICKED,0, 				type, selector) then Result := on_triple_clicked 	(sender, selector, data)
         	elseif  match_function_2 (SEL_COMMAND,		0, 				type, selector) then Result := on_command			(sender, selector, data)
         	elseif  match_function_2 (SEL_UPDATE, 		Id_query_tip, 	type, selector) then Result := on_query_tip		 	(sender, selector, data)
         	elseif  match_function_2 (SEL_UPDATE, 		Id_query_help, 	type, selector) then Result := on_query_help		(sender, selector, data)
         	elseif  match_function_2 (SEL_COMMAND, 		Id_setvalue, 	type, selector) then Result := on_cmd_set_value 	(sender, selector, data)
         	elseif  match_function_2 (SEL_COMMAND, 		Id_setintvalue, type, selector) then Result := on_cmd_set_int_value	(sender, selector, data)
         	elseif  match_function_2 (SEL_COMMAND, 		Id_getintvalue, type, selector) then Result := on_cmd_get_int_value	(sender, selector, data)
         	else Result := Precursor (sender, type, selector, data)
         	end
      end

   on_paint (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      local
         event: SB_EVENT
         dc: SB_DC_WINDOW
         i, nitems, y, h: INTEGER
      do
         event ?= data
         check
            event /= Void
         end
         dc := paint_dc
         dc.make_event (Current, event)
         	-- Paint items
         y := pos_y
         from
            i := 1
            nitems := items.count
         until
            i > nitems
         loop
            h := items.item (i).height (Current)
            if event.rect_y <= y+h and then y < event.rect_y + event.rect_h then
               items.item (i).draw (Current, dc, pos_x, y, content_w, h)
            end
            y := y + h
            i := i + 1
         end

         	-- Paint blank area below items
         if y < event.rect_y + event.rect_h then
            dc.set_foreground (back_color)
            dc.fill_rectangle (event.rect_x, y, event.rect_w, event.rect_y+event.rect_h - y)
         end
         dc.stop
         Result := True
      end

   on_key_press(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      local
         event: SB_EVENT
         index: INTEGER
         t: INTEGER
      do
         event ?= data
         check
            event /= Void
         end
         index := current_item
         unset_flags (Flag_tip)
         if is_enabled then
            Result := True;
            if message_target = Void
               or else not message_target.handle_2 (Current, SEL_KEYPRESS, message, data)
             then
               if index < 1 then index := 1 end
               inspect event.code
               when key_control_l,  key_control_r,  key_shift_l,  key_shift_r,  key_alt_l, key_alt_r then
                  if (flags & Flag_dodrag) /= Zero then do_handle_2 (Current, SEL_DRAGGED, 0, data) end
               when key_page_up,  key_kp_page_up then
                  create lookup_string.make_empty
                  set_scroll_position(pos_x, pos_y+v_scroll_bar.page_size)
               when key_page_down,  key_kp_page_down then
                  create lookup_string.make_empty
                  set_scroll_position(pos_x, pos_y-v_scroll_bar.page_size)
               when key_up, key_kp_up then
                  index := index - 1;
                  do_hop(event, index)
               when key_down,  key_kp_down then
                  index := index + 1
                  do_hop(event, index);
               when key_home, key_kp_home then
                  index := 1
                  do_hop(event, index)
               when key_end,  key_kp_end then
                  index := items_count-1
                  do_hop(event, index)
               when key_space, key_kp_space then
                  create lookup_string.make_empty
                  if 1 <= current_item and then items.item(current_item).is_enabled then
                     t := options & SELECT_MASK
                     if t = LIST_EXTENDEDSELECT then
                        if (event.state & SHIFTMASK) /= Zero then
                           if 1 <= anchor_item then
                              do_select_item(anchor_item, True)
                              do_extend_selection(current_item, True)
                           else
                              do_select_item(current_item, True)
                           end
                        elseif (event.state & CONTROLMASK) /= Zero then
                           do_toggle_item(current_item, True)
                        else
                           do_kill_selection(True)
                           do_select_item(current_item, True)
                        end
                     elseif t = LIST_MULTIPLESELECT or else t = LIST_SINGLESELECT then
                        do_toggle_item(current_item, True)
                     end
                     set_anchor_item(current_item)
                  end
                  do_handle_2 (Current, SEL_CLICKED, 0, ref_integer(current_item))
                  if 1 <= current_item and then items.item(current_item).is_enabled then
                     do_handle_2 (Current, SEL_COMMAND, 0, ref_integer(current_item))
                  end
               when key_return, key_kp_enter then
                  create lookup_string.make_empty
                  do_handle_2 (Current, SEL_DOUBLECLICKED, 0, ref_integer(current_item))
                  if 1 <= current_item and then items.item(current_item).is_enabled then
                     do_handle_2 (Current, SEL_COMMAND, 0, ref_integer(current_item))
                  end
               else
                  if (event.state & (CONTROLMASK | ALTMASK)) /= Zero
                     or else event.text.is_empty or else event.text.item(1).code < 32
                   then
                     Result := False
                  else
                     lookup_string.append_string(event.text)
                     if lookup_timer /= Void then application.remove_timeout(lookup_timer); lookup_timer := Void end
                     lookup_timer := application.add_timeout(application.typing_speed,  Current,  ID_LOOKUPTIMER)
                     index := find_item_by_name_opts(lookup_string,  current_item,  SEARCH_FORWARD | SEARCH_WRAP | SEARCH_PREFIX)
                     if 1 <= index then
                        set_current_item(index, True)
                        make_item_visible(index)
                        if (options & SELECT_MASK) = LIST_EXTENDEDSELECT then
                           if items.item(index).is_enabled then
                              do_kill_selection(True)
                              do_select_item(index,  True)
                           end
                        end
                        set_anchor_item(index)
                     end
                     do_handle_2 (Current, SEL_CLICKED, 0, ref_integer(current_item))
                     if 1 <= current_item and then items.item(current_item).is_enabled then
                        do_handle_2 (Current, SEL_COMMAND, 0, ref_integer(current_item))
                     end
                  end
               end
            end
         end
      end

   on_left_btn_press(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      local
         event: SB_EVENT;
         index, code: INTEGER;
         t: INTEGER;
      do
         event ?= data; check event /= Void end
         unset_flags (Flag_tip);
         do_handle_2 (Current, SEL_FOCUS_SELF, 0, data);
         if is_enabled then
            Result := True
            grab_mouse
            unset_flags (Flag_update)

            if message_target = Void
               or else not message_target.handle_2 (Current, SEL_LEFTBUTTONPRESS, message, data)
               or else (options & LIST_AUTOSELECT) = Zero
             then
               -- Locate item
               index := item_at(event.win_x,  event.win_y);
               
               if index > 0 then
                  -- Find out where hit
                  code := item_hit(index,  event.win_x,  event.win_y);

                  -- Change current_item item
                  set_current_item(index,  True);

                  -- Change item selection
                  state := items.item(index).is_selected;
                  t := options & SELECT_MASK
                  if t = LIST_EXTENDEDSELECT then
                     if (event.state & SHIFTMASK) /= Zero then
                        if 1 <= anchor_item then
                           if items.item(anchor_item).is_enabled then do_select_item(anchor_item,  True) end
                           do_extend_selection(index,  True);
                        else
                           if items.item(index).is_enabled then do_select_item(index, True) end
                           set_anchor_item(index);
                        end
                     elseif (event.state & CONTROLMASK) /= Zero then
                        if items.item(index).is_enabled and then not state then do_select_item(index, True) end
                        set_anchor_item(index);
                     else
                        if items.item(index).is_enabled and then not state then 
                           do_kill_selection(True); do_select_item(index, True);
                        end
                        set_anchor_item(index);
                     end
                  elseif t = LIST_MULTIPLESELECT or else t = LIST_SINGLESELECT then
                     if items.item(index).is_enabled and then not state then do_select_item(index, True) end
                  end

                  -- Start drag if actually pressed text or icon only
                  if code /= 0 and then items.item(index).is_selected 
                     and then items.item(index).is_draggable
                   then
                     flags := flags | Flag_trydrag
                  end
                  flags := flags | Flag_pressed
               end
            end
         end
      end

   on_left_btn_release(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      local
         event: SB_EVENT
         flg: INTEGER
         t: INTEGER
      do
         event ?= data
         check
            event /= Void
         end
         flg := flags
         if is_enabled then
            release_mouse
            stop_auto_scroll
            flags := flags | Flag_update
            unset_flags (Flag_pressed | Flag_trydrag | Flag_dodrag)

            if (message_target /= Void
                and then message_target.handle_2 (Current, SEL_LEFTBUTTONRELEASE, message, data))
               or else ((flg & Flag_pressed) = Zero and then (options & LIST_AUTOSELECT) = Zero)
             then
               Result := True
            elseif (flg & Flag_dodrag) /= Zero then
               do_handle_2 (Current, SEL_ENDDRAG, 0, data)
               Result := True
            else
               -- Selection change
               t := options & SELECT_MASK
               if t = LIST_EXTENDEDSELECT then
                  if 1 <= current_item and then items.item(current_item).is_enabled then
                     if (event.state & CONTROLMASK) /= Zero then
                        if state then do_deselect_item(current_item, True) end
                     elseif (event.state & SHIFTMASK) = Zero then
                        if state then do_kill_selection(True); do_select_item(current_item, True) end
                     end
                  end
               elseif t = LIST_MULTIPLESELECT or else t =  LIST_SINGLESELECT then
                  if 1 <= current_item and then items.item(current_item).is_enabled then
                     if state then do_deselect_item(current_item, True) end
                  end
               end

               make_item_visible(current_item)
               set_anchor_item(current_item)

               -- Generate clicked callbacks
               if event.click_count = 1 then
                  do_handle_2 (Current, SEL_CLICKED, 0, ref_integer(current_item))
               elseif event.click_count = 2 then
                  do_handle_2 (Current, SEL_DOUBLECLICKED, 0, ref_integer(current_item))
               elseif event.click_count = 3 then
                  do_handle_2 (Current, SEL_TRIPLECLICKED, 0, ref_integer(current_item))
               end

               -- Command callback only when clicked on item
               if 1 <= current_item and then items.item(current_item).is_enabled then
                  do_handle_2 (Current, SEL_COMMAND, 0, ref_integer(current_item))
               end
               Result := True;
            end
         end
      end

   on_right_btn_press(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      local
         event: SB_EVENT
         flg: INTEGER
      do
         event ?= data
         check
            event /= Void
         end
         unset_flags (Flag_tip)
         do_handle_2 (Current, SEL_FOCUS_SELF, 0, data)
         if is_enabled then
            Result := True
            grab_mouse;
            unset_flags (Flag_update)
            if message_target = Void
               or else not message_target.handle_2 (Current, Sel_rightbuttonpress, message, data)
             then
               flags := flags | Flag_scrolling
               grab_x := event.win_x-pos_x
               grab_y := event.win_y-pos_y
            end
         end
      end


   on_motion(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      local
         event: SB_EVENT
         flg: INTEGER
         oldcursor: INTEGER
         index: INTEGER
      do
         event ?= data
         check
            event /= Void
         end
         flg := flags
         oldcursor := cursor_item

         -- Kill the tip
         unset_flags (Flag_tip)
         -- Kill the tip timer
         if timer /= Void then application.remove_timeout(timer); timer := Void end

         if (flags & Flag_scrolling) /= Zero then
            -- Right mouse scrolling
            set_scroll_position(event.win_x-grab_x, event.win_y-grab_y)
            Result := True;
         elseif (flags & Flag_dodrag) /= Zero then
            -- Drag and drop mode
            if not start_auto_scroll(event.win_x, event.win_y, True) then
               do_handle_2 (Current, SEL_DRAGGED, 0, data)
            end
            Result := True;
         elseif (flags & Flag_trydrag) /= Zero and then event.moved then
            -- Tentative drag and drop
            unset_flags (Flag_trydrag)
            if handle_2 (Current, SEL_BEGINDRAG, 0, data) then
               flags := flags | Flag_dodrag
            end
            Result := True;
         else
            -- Normal operation
            if (flags & Flag_pressed) /= Zero or else (options & LIST_AUTOSELECT) /= Zero then
               -- Start auto scrolling?
               if start_auto_scroll(event.win_x,  event.win_y,  False) then
                  Result := True
               else
                  -- Find item
                  index := item_at(event.win_x, event.win_y)
                  -- Got an item different from before
                  if 1 <= index and then index /= current_item then
                     -- Make it the current_item item
                     set_current_item(index, True)
                     -- Extend the selection
                     if (options & SELECT_MASK) = LIST_EXTENDEDSELECT then
                        state := False
                        do_extend_selection(index, True)
                     end
                     Result := True
                  end
               end
            end
            if not Result then
               -- Reset tip timer if nothing's going on
               timer := application.add_timeout(application.menu_pause, Current, ID_TIPTIMER)
               -- Get item we're over
               cursor_item := item_at(event.win_x, event.win_y)
               -- Force GUI update only when needed
               if cursor_item /= oldcursor or else (flg & Flag_tip) /= Zero then
                  Result := True
               end
            end
         end
      end

   on_auto_scroll(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      local
         event: SB_EVENT
         index: INTEGER
         xx, yy: INTEGER
      do
         event ?= data
         Result := Precursor (sender, selector, data);
         -- Drag and drop mode
         if(flags & Flag_dodrag) /= Zero then
            do_handle_2 (Current, SEL_DRAGGED, 0, data)
            Result := True;
         elseif event /= Void and then ((flags & Flag_pressed) /= Zero or else (options & LIST_AUTOSELECT) /= Zero) then

--## What should happen if event = Void ???
--## Should this be called from a Timer event ???

    	     check
    	        event /= Void	-- event = Void if called from Precursor handle, from a Timeout
    	     end
            -- In autoselect mode,  stop scrolling when mouse outside window

            -- Validated position
            xx := event.win_x; if xx<0 then xx := 0 elseif xx >= viewport_w then xx := viewport_w-1 end
            yy := event.win_y; if yy<0 then yy := 0 elseif yy >= viewport_h then yy := viewport_h-1 end

            -- Find item
            index := item_at(xx, yy)

            if 1 <= index and then index /= current_item then
               -- Got item and different from last time

               -- Make it the current_item item
               set_current_item(index, True)

               -- Extend the selection
               if (options & SELECT_MASK) = LIST_EXTENDEDSELECT then
                  state := False;
                  do_extend_selection(index,  True)
               end
            end
            Result := True
         else
            Result := False
         end
      end

   on_query_tip(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      local
         string: STRING;
      do
         if (flags & Flag_tip) /= Zero and then (options & LIST_AUTOSELECT) = Zero then
            -- No tip when autoselect!
            if 1 <= cursor_item then
               sender.do_handle_2 (Current, SEL_COMMAND, Id_setstringvalue, items.item(cursor_item).label)
               Result := True
            end
         end
      end

feature -- Sorting


feature -- Resource management

   create_resource is
         -- Create server-side resources
      local
         i: INTEGER
         nitems: INTEGER
      do
         Precursor;
         from
            i := 1
            nitems := items_count
         until
            i > nitems
         loop
            items.item(i).create_resource
            i := i + 1
         end
         font.create_resource;
      end

   detach_resource is
      -- Detach server-side resources
      local
         i: INTEGER
         nitems: INTEGER
      do
         Precursor
         from
            i := 1
            nitems := items_count
         until
            i > nitems
         loop
            items.item(i).detach_resource
            i := i + 1
         end
         font.create_resource
      end

feature {NONE} -- Implementation

--   ITEM_TYPE: SB_LIST_ITEM is do end

   list_width: INTEGER
         -- List width
         
   list_height: INTEGER
         -- List height
         
   grab_x: INTEGER
         -- Grab point x
         
   grab_y: INTEGER
         -- Grab point y
         
   state: BOOLEAN
         -- State of item

   do_hop(event: SB_EVENT; index: INTEGER) is
      do
         create lookup_string.make_empty
         if 1 <= index and then index <= items_count then
            set_current_item(index, True)
            make_item_visible(index)
            if items.item(index).is_enabled then
               if (options & SELECT_MASK) = LIST_EXTENDEDSELECT then
                  if (event.state & SHIFTMASK) /= 0 then
                     if 1 <= anchor_item then
                        do_select_item(anchor_item, True)
                        do_extend_selection(index, True)
                     else
                        do_select_item(index, True)
                        set_anchor_item(index)
                     end
                  elseif (event.state & CONTROLMASK) = Zero then
                     do_kill_selection(True)
                     do_select_item(index, True)
                     set_anchor_item(index)
                  end
               end
            end
         end
         do_handle_2 (Current, SEL_CLICKED, 0, ref_integer(current_item))
         if 1 <= current_item and then items.item(current_item).is_enabled then
            do_handle_2 (Current, SEL_COMMAND, 0, ref_integer(current_item))
         end
      end

   layout is
      do
         -- Calculate contents
         Precursor
         -- Determine line size for scroll bars
         if 0 < items_count then
            v_scroll_bar.set_line_size(items.item(1).height(Current))
            h_scroll_bar.set_line_size(items.item(1).width(Current)//10)
         end
         update
         -- No more dirty
         unset_flags (Flag_dirty)
      end

   recompute is
      local
         x, y, w, h, i: INTEGER
         nitems: INTEGER
      do
         x := 0
         y := 0
         list_width := 0
         list_height := 0

         from
            i := 1
            nitems := items.count
         until
            i > nitems
         loop
            items.item(i).set_x(x)
            items.item(i).set_y(y)
            w := items.item(i).width(Current)
            h := items.item(i).height(Current)
            if w > list_width then list_width := w end
            y := y + h
            i := i + 1
         end
         list_height := y
         unset_flags (Flag_recalc)
      end

   create_item (text: STRING; icon: SB_ICON; data: ANY): SB_LIST_ITEM is
      do
         create Result.make (text, icon, data)
      end

   ICON_SPACING: INTEGER is 4;
         -- Spacing between icon and label
         
   SIDE_SPACING: INTEGER is 6;
         -- Left or right spacing between items
         
   LINE_SPACING: INTEGER is 4
         -- Line spacing between items

   LIST_MASK: INTEGER is once Result := (SELECT_MASK | LIST_AUTOSELECT) end

end
