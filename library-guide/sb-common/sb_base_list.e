note
	description:"Base list"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

deferred class SB_BASE_LIST [ G -> SB_ITEM ]

inherit

	SB_SCROLL_AREA
      	rename
        	Id_last as SCROLL_AREA_ID_LAST
      	redefine
        	set_focus,
        	kill_focus,
        	on_enter,
        	on_leave,
        	on_focus_in,
        	on_focus_out,
        	on_ungrabbed,
        	on_key_release,
        	on_right_btn_release,
        	recalc,
        	class_name
      	end

 	SB_ABSTRACT_LIST [ INTEGER, G ]

	SB_ARRAYED_ITEM_CONTAINER [ G ]
    	redefine
			insert_item,
			remove_item_notify,
			clear_items_notify,
			move_item_notify
      	end

	SB_BASE_LIST_CONSTANTS

	SB_BASE_LIST_COMMANDS

	SB_EXPANDED

	SB_ARRAY_HELPER [ G ]

feature -- class name

	class_name: STRING
		once
			Result := "SB_BASE_LIST"
		end

feature -- Item access

   find_item_by_name_opts (text: STRING; start_: INTEGER; flgs: INTEGER): INTEGER
         -- Search items for item by name, starting from start item; the
         -- flags argument controls the search direction, and case 
         -- sensitivity.
      local
         comp: SB_STRING_COMPARATOR;
         start, index, nitems, len: INTEGER;         
      do
         if 0 < items_count then
            start := start_
            if (flgs & SEARCH_IGNORECASE) /= 0 then
               comp := compare
            else 
               comp := comparecase
            end
            if (flgs & SEARCH_PREFIX) /= 0 then
               len := text.count
            else
               len := 2147483647
            end
            nitems := items_count;
            if (flgs & SEARCH_BACKWARD) = 0 then
               if start < 1 then start := 1 end
               from
                  index := start
               until
                  index > nitems or else Result /= 0
               loop
                  if comp.compare(items.item(index).label, text, len) = 0 then
                     Result := index
                  end
                  index := index + 1
               end
               if Result = 0 and (flgs & SEARCH_WRAP) /= 0 then
                  from
                     index := 1
                  until
                     index >= start or else Result /= 0
                  loop
                     if comp.compare(items.item(index).label, text, len) = 0 then
                        Result := index;
                     end
                     index := index + 1
                  end
               else
                  if start < 1 then  start := nitems end
                  from
                     index := start;
                  until
                     index  <= 0 or else Result /= 0
                  loop
                     if comp.compare(items.item(index).label, text, len) = 0 then
                        Result := index
                     end
                     index := index - 1
                  end
                  if Result = 0 and (flgs & SEARCH_WRAP) /= 0 then
                     from
                        index := nitems
                     until
                        index  <= start or else Result /= 0
                     loop
                        if comp.compare(items.item(index).label, text, len) = 0 then
                           Result := index
                        end
                        index := index - 1
                     end
                  end
               end
            end
         end
      end

feature -- Sorting

	sort_items
			-- Sort items using current comparator object
		local
			c: G;
			i, nitems: INTEGER
			exch: BOOLEAN
		do
			if items_sorter /= Void and then item_comparator /= Void then
				if 0 < current_item then
					c := items.item(current_item)
				end
				exch := items_sorter.array_sort(items, item_comparator)
				if exch and then c /= Void then
					from
						i := 1
						nitems := items.count
					until 
						i > nitems
					loop
						if items.item (i) = c then
							current_item := i
							i := nitems
		    			end
		    			i := i + 1
		    		end
		    	end
				if exch then
					recalc
				end
			end
		end

feature -- Item actions

	insert_item (index: INTEGER; new_item: G; notify: BOOLEAN)
			-- Insert a new [possibly subclassed] item at the given index
		local
			old_current: INTEGER
--			ah: SB_ARRAY_HELPER [ G ]
		do 
			old_current := current_item

				-- Add item to list
			array_insert (items, new_item, index)
				-- Adjust indices
			if anchor_item >= index then anchor_item := anchor_item + 1 end
			if extent_item >= index then extent_item := extent_item + 1 end
			if current_item >= index then current_item := current_item + 1 end
			if current_item = 0 and then items_count = 1 then current_item := 1 end

				-- Notify item has been inserted
			if notify and then message_target /= Void then
				message_target.do_handle_2 (Current, SEL_INSERTED, message, ref_integer (index))
			end

				-- Current item may have changed
			if old_current /= current_item then
				if notify and then message_target /= Void then
					message_target.do_handle_2 (Current, SEL_CHANGED, message, ref_integer (current_item))
				end
			end
				-- Redo layout
			recalc
		end

   remove_item_notify (index: INTEGER; notify: BOOLEAN)
         -- Remove item from list
      local
--       ah: SB_ARRAY_HELPER [ G ]
         old_current: INTEGER
      do
         old_current := current_item;

         -- Notify item will be deleted
         if notify and then message_target /= Void then
            message_target.do_handle_2 (Current, SEL_DELETED, message, ref_integer (index))
         end

         -- Remove item from list
         array_remove (items, index)

         -- Adjust indices
         if anchor_item > index or else anchor_item > items.count then anchor_item := anchor_item - 1 end
         if extent_item > index or else extent_item > items.count then extent_item := extent_item - 1 end
         if current_item > index or else current_item > items.count then current_item := current_item - 1 end

         -- Current item has changed
         if index <= old_current then
            if notify and then message_target /= Void then
               message_target.do_handle_2 (Current, SEL_CHANGED, message, ref_integer (current_item))
            end
         end

         -- Deleted current_item item
         if 1 <= current_item and then index = old_current then
            if has_focus then
               items.item (current_item).set_focus (True)
            end
            if (options & SELECT_MASK) = LIST_BROWSESELECT
               and then items.item (current_item).is_enabled
             then
               do_select_item (current_item, notify)
            end
         end

         -- Redo layout
         recalc
      end

   move_item_notify (new_index, old_index: INTEGER; notify: BOOLEAN)
         -- Move item from old_index to new_index
      local
         old_current: INTEGER
         old_item: G
         ix: INTEGER
      do
         -- Did it change?
         if old_index /= new_index then
            old_current := current_item
            old_item := items.item (old_index)
            if new_index < old_index then
               from
                  ix := old_index
               until
                  ix <= new_index
               loop                  
                  items.put(items.item (ix - 1), ix)
                  ix := ix - 1
               end
            else
               from
                  ix := new_index
               until
                  ix <= old_index
               loop
                  items.put(items.item (ix), ix - 1)
                  ix := ix - 1
               end
            end
            -- Put it back
            items.put (old_item,new_index)
            -- Adjust if it was equal
            if anchor_item = old_index then anchor_item := new_index end
            if extent_item = old_index then extent_item := new_index end
            if current_item = old_index then current_item := new_index end

            -- Current item may have changed
            if old_current /= current_item and then notify and then message_target /= Void then
               message_target.do_handle_2 (Current, SEL_CHANGED, message, ref_integer(current_item))
            end
            -- Redo layout
            recalc
         end
      end

	clear_items_notify(notify: BOOLEAN)
			-- Remove all items from list
		local
			old_current: INTEGER
			index: INTEGER
		do
			old_current := current_item
				-- Delete items
			from index := items.count until index <= 0 loop
				if notify and then message_target /= Void then
					message_target.do_handle_2 (Current, SEL_DELETED, message, ref_integer (index))
				end            
				index := index - 1
			end
				-- Free array
			create items.make (1, 0)
				-- Adjust indices
			current_item := 0
			anchor_item := 0
			extent_item := 0
				-- Current item has changed
			if old_current /= current_item then
				if notify and then message_target /= Void then
					message_target.do_handle_2 (Current, SEL_CHANGED, message, ref_integer (0))
				end
			end
				-- Redo layout
			recalc
		end

   select_item (index: INTEGER; notify: BOOLEAN): BOOLEAN
         -- Select item
      local
         t: INTEGER
      do
         if not items.item (index).is_selected then
            t := options & SELECT_MASK
            if t = LIST_SINGLESELECT 
               or else t = LIST_BROWSESELECT
             then
               do_kill_selection (notify)
            end
            if t = LIST_EXTENDEDSELECT
               or else t = LIST_MULTIPLESELECT
               or else t = LIST_SINGLESELECT 
               or else t = LIST_BROWSESELECT
             then
               items.item(index).set_selected (True)
               update_item (index)
               if notify and then message_target /= Void then
                  message_target.do_handle_2 (Current, SEL_SELECTED, message, ref_integer (index))
               end
            end
            Result := True
         end
      end

   deselect_item (index: INTEGER; notify: BOOLEAN): BOOLEAN
         -- Deselect item
      local
         t: INTEGER
      do
         if items.item(index).is_selected then
            t:= options & SELECT_MASK;
            if t = LIST_SINGLESELECT 
               or else t = LIST_EXTENDEDSELECT
               or else t = LIST_MULTIPLESELECT
             then
               items.item(index).set_selected (False)
               update_item (index)
               if notify and then message_target /= Void then
                  message_target.do_handle_2 (Current, SEL_DESELECTED, message, ref_integer (index))
               end
            end
            Result := True
         end
      end

   toggle_item (index: INTEGER; notify: BOOLEAN): BOOLEAN
         -- Toggle item selection state
      local
         t: INTEGER
      do
         t := options & SELECT_MASK
         if t =  LIST_BROWSESELECT then
            if not items.item(index).is_selected then
               do_kill_selection (notify)
               items.item(index).set_selected (True)
               update_item(index);
               if notify and then message_target /= Void then
                  message_target.do_handle_2 (Current, SEL_SELECTED, message, ref_integer (index))
               end
            end
         elseif t = LIST_SINGLESELECT then
            if not items.item(index).is_selected then
               do_kill_selection(notify);
               items.item(index).set_selected(True);
               update_item(index);
               if notify and then message_target /= Void then
                  message_target.do_handle_2 (Current, SEL_SELECTED, message, ref_integer(index));
               end
            else
               items.item (index).set_selected(False)
               update_item (index)
               if notify and then message_target /= Void then
                  message_target.do_handle_2 (Current, SEL_DESELECTED, message, ref_integer (index))
               end
            end
         elseif t = LIST_EXTENDEDSELECT or else t = LIST_MULTIPLESELECT then
            if not items.item(index).is_selected then
               items.item (index).set_selected (True)
               update_item (index)
               if notify and then message_target /= Void then
                  message_target.do_handle_2 (Current, SEL_SELECTED, message, ref_integer (index));
               end
            else
               items.item(index).set_selected (False)
               update_item (index)
               if notify and then message_target /= Void then
                  message_target.do_handle_2 (Current, SEL_DESELECTED, message, ref_integer (index))
               end
            end
         end
         Result := True
      end

   set_current_item (index: INTEGER; notify: BOOLEAN)
         -- Change current item
      do
         if index /= current_item then
            -- Deactivate old item
            if 1 <= current_item then
               -- No visible_rows change if it doen't have the focus
               if has_focus then
                  items.item(current_item).set_focus(False);
                  update_item(current_item);
               end
            end

            current_item := index

            -- Activate new item
            if 0 <= current_item then
               -- No visible_rows change if it doen't have the focus
               if has_focus then
                  items.item (current_item).set_focus (True)
                  update_item (current_item)
               end
            end

            -- Notify item change
            if notify and then message_target /= Void then
               message_target.do_handle_2 (Current, SEL_CHANGED, message, ref_integer (current_item))
            end
         end

         -- In browse select mode, select this item
         if (options & SELECT_MASK) = LIST_BROWSESELECT 
            and then 1 <= current_item
            and then items.item (current_item).is_enabled
          then
            do_select_item (current_item, notify)
         end
      end

   extend_selection (index: INTEGER; notify: BOOLEAN): BOOLEAN
         -- Extend selection from anchor item to index
      local
         i1,i2,i3,i: INTEGER
      do
         if 1 <= index and then 1 <= anchor_item and then 1 <= extent_item then
            -- Find segments
            i1 := index;
            if anchor_item<i1 then i2 := i1; i1 := anchor_item
            else i2 := anchor_item end
            if extent_item<i1 then i3 := i2;i2 := i1;i1 := extent_item
            elseif extent_item < i2 then i3 := i2; i2 := extent_item
            else i3 := extent_item end

            -- First segment
            from
               i := i1
            until
               i >= i2
            loop
               if i1 = index then
                  if not items.item(i).is_selected then
                     items.item (i).set_selected (True)
                     update_item(i);
                     Result := True;
                     if notify and then message_target /= Void then
                        message_target.do_handle_2 (Current, SEL_SELECTED, message, ref_integer (i))
                     end
                  end
               elseif i1 = extent_item then
                  if items.item (i).is_selected then
                     items.item (i).set_selected (False)
                     update_item (i)
                     Result := True
                     if notify and then message_target /= Void then
                        message_target.do_handle_2 (Current, SEL_DESELECTED, message, ref_integer (i))
                     end
                  end
               end
               i := i + 1
            end

            -- Second segment
            from
               i := i2+1
            until
               i > i3
            loop
               if i3 = index then
                  if not items.item(i).is_selected then
                     items.item(i).set_selected(True);
                     update_item(i);
                     Result := True;
                     if notify and then message_target /= Void then
                        message_target.do_handle_2 (Current, SEL_SELECTED, message, ref_integer(i));
                     end
                  end
               elseif i3 = extent_item then
                  if items.item(i).is_selected then
                     items.item(i).set_selected(False);
                     update_item(i);
                     Result := True;
                     if notify and then message_target /= Void then
                        message_target.do_handle_2 (Current, SEL_DESELECTED, message, ref_integer(i));
                     end
                  end
               end
               i := i + 1
            end
            extent_item := index;
         end
      end

   kill_selection(notify: BOOLEAN): BOOLEAN
         -- Deselect all items
      local
         i: INTEGER;
         nitems: INTEGER;
      do
         from
            i := 1;
            nitems := items.count;
         until
            i > nitems
         loop
            if items.item(i).is_selected then
               items.item(i).set_selected(False);
               update_item(i);
               Result := True;
               if notify and then message_target /= Void then
                message_target.do_handle_2 (Current, SEL_DESELECTED, message, ref_integer(i));
               end
            end
            i := i + 1
         end
      end

feature -- Actions

	recalc
    		-- Recalculate layout
    	do
         	Precursor;
         	flags := flags | Flag_recalc;
   			cursor_item := 0;
      	end

	set_focus
         	-- Move the focus to this window
      	do
         	Precursor;
         	set_default(SB_TRUE);
      	end

   	kill_focus
         	-- Remove the focus from this window
      	do
         	Precursor;
         	set_default(SB_MAYBE);
      	end

feature -- Message processing

   	on_enter (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      	do
         	Result := Precursor(sender, selector, data);
         	if timer = Void then timer := application.add_timeout(application.menu_pause, Current, ID_TIPTIMER) end
			cursor_item := 0;
         	Result := True;
      	end

	on_leave (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
    	do
         	Result := Precursor (sender,selector,data);
         	if timer /= Void then application.remove_timeout(timer); timer := Void end
			cursor_item := 0;
         	Result := True;
      	end

   on_ungrabbed (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         Result := Precursor (sender, selector, data)
         unset_flags (Flag_dodrag | Flag_trydrag | Flag_pressed | Flag_changed | Flag_scrolling)
         flags := flags | Flag_update
         stop_auto_scroll
         Result := True
      end

   on_key_release (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         event: SB_EVENT
      do
         event ?= data; check event /= Void end
         if is_enabled then
            Result := True
            if message_target = Void
               or else not message_target.handle_2 (Current, SEL_KEYRELEASE, message, data)
             then
               inspect event.code
               when key_shift_l, key_shift_r, key_control_l,
                  key_control_r, key_alt_l, key_alt_r
                then
                  if (flags & Flag_dodrag) /= 0 then
                     do_handle_2 (Current, SEL_DRAGGED, 0, data);
                  end
               else
                  Result := False;
               end
            end
         end
      end

   on_right_btn_release (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         if is_enabled then
            release_mouse
            unset_flags (Flag_scrolling)
            flags := flags | Flag_update
            do_send (Sel_rightbuttonrelease, data)
            Result := True
         end
      end

   on_tip_timer (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         timer := Void
         flags := flags | Flag_tip
         Result := True
      end

   on_lookup_timer (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         create lookup_string.make_empty
         lookup_timer := Void
         Result := True
      end

   on_cmd_set_value, on_cmd_set_int_value (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         i: INTEGER_REF;
      do
         i ?= data check i /= Void end
         set_current_item (i.item, False)
         Result := True
      end

   on_cmd_get_int_value (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         i: INTEGER_REF;
      do
         i ?= data check i /= Void end
         i.set_item(current_item)
         Result := True
      end

   on_focus_in(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         Result := Precursor(sender, selector, data)
         if 0 < current_item then
            check current_item <= items_count end
            items.item(current_item).set_focus(True)
            update_item(current_item)
         end
         Result := True
      end

   on_focus_out(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         Result := Precursor(sender, selector, data)
         if 0 < current_item then
            check current_item <= items_count end
            items.item(current_item).set_focus(False)
            update_item(current_item)
         end
         Result := True
      end

feature {NONE} -- Implementation


   SELECT_MASK: INTEGER once Result := (LIST_SINGLESELECT | LIST_BROWSESELECT) end

   lookup_string: STRING		-- Lookup string
   timer		: SB_TIMER		-- Tip hover timer
   lookup_timer	: SB_TIMER		-- Lookup timer

	compare: SB_STRING_COMPARATOR
		once
			create {SB_NOCASE_STRING_COMPARATOR} Result
		end

	comparecase: SB_STRING_COMPARATOR
    	once
			create {SB_CASE_STRING_COMPARATOR} Result
      	end

end
