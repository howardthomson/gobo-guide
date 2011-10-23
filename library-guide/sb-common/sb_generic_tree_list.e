indexing
	description:"Tree List Widget"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

	todo: "[
		Avoid overflow of 16-bit X11 values for x,y width,height of X-window positioning
		and drawing operations.
		tree_height > 32767 is the primary problem, but tree_width potentially affected.

		Fix (Void) GEC assignment rejection ...
	]"

deferred class SB_GENERIC_TREE_LIST [ reference G -> SB_TREE_LIST_ITEM ]

inherit

	SB_SCROLL_AREA
		rename
        	Id_last as SCROLL_AREA_ID_LAST,
        	make		as scroll_area_make,
        	make_opts	as scroll_area_make_opts
      	redefine
      		make_ev,
         	default_height,
         	can_focus,
         	content_height,
         	content_width,
         	set_focus,
         	kill_focus,
         	create_resource,
         	detach_resource,
         	handle_2,
         	on_key_press,
         	on_key_release,
         	on_left_btn_press,
         	on_left_btn_release,
         	on_right_btn_press,
         	on_right_btn_release,
         	on_motion,
         	on_paint,
         	on_enter,
         	on_leave,
         	on_ungrabbed,
         	on_focus_in,
         	on_focus_out,
         	on_auto_scroll,
         	layout,
         	recalc,
         	class_name
      	end

	SB_ABSTRACT_LIST [ G, G ]
    	rename
        	set_item_icon	 as set_item_open_icon,
        	sort_items		 as sort_root_items,
        	move_item_notify as move_item_before_notify
      	redefine
        	on_double_clicked,
        	items_sorter,
        	remove_item
      	end

	SB_TREE_ITEM_CONTAINER [ G ]
		rename
			move_item_notify as move_item_before_notify
		redefine
			remove_item
		end

	SB_TREE_LIST_CONSTANTS

	SB_TREE_LIST_COMMANDS

	SB_KEYS
    	export {NONE} all
    	end

feature -- class name

	class_name: STRING
		once
			Result := "SB_TREE_LIST"
		end

feature -- Attributes

	line_color: INTEGER
			-- Line color
			
	visible_rows: INTEGER
			-- Number of visible_rows items
			
	indent: INTEGER
			-- Parent to child indentation

feature -- Creation

	make_ev
		do
			make (Void, 20, Void,0, Layout_fill_x | Layout_fill_y
				 | Treelist_root_boxes
				 | Treelist_shows_boxes | Treelist_shows_lines
				 | Treelist_boxes_item_opt)
		end
				 
	make (p: SB_COMPOSITE; nvis: INTEGER; tgt: SB_MESSAGE_HANDLER; sel: INTEGER; opts: INTEGER)
			-- Construct a tree list with nvis visible_rows items; the tree list is initially is_empty
		do
			make_opts (p, nvis, tgt,sel, opts, 0,0,0,0)
		end

	make_opts (p: SB_COMPOSITE; nvis: INTEGER; tgt: SB_MESSAGE_HANDLER; sel: INTEGER; opts: INTEGER; x,y, w,h: INTEGER)
         -- Construct a list with nvis visible items; the list is initially is_empty
		do
         	scroll_area_make_opts (p, opts, x,y,w,h)
         	flags := flags | Flag_enabled
         
         	message_target := tgt
         	message := sel
         
         	font := application.normal_font
         
         	text_color		:= application.fore_color
         	sel_back_color  := application.sel_back_color
         	sel_text_color  := application.sel_fore_color
         	line_color		:= application.shadow_color

			visible_rows := nvis.max (0)
         	create lookup_string.make_empty
         	indent := DEFAULT_INDENT
         	create help_text.make_empty
		end

feature -- Queries

   default_height: INTEGER
         -- Return default height
      do
         if visible_rows /= 0 then
            Result := visible_rows * (4 + font.get_font_height)
         else
            Result := Precursor
         end
      end

   content_width: INTEGER
         -- Compute and return content width
      do
         if (flags & Flag_recalc) /= 0 then
            recompute
         end
         Result := tree_width
      end

   content_height: INTEGER
         -- Return content height
      do
         if (flags & Flag_recalc) /= 0 then
            recompute
         end
         Result := tree_height
      end

   get_list_style: INTEGER
         -- Return list style
      do
         Result := (options & TREELIST_MASK);
      end

   can_focus: BOOLEAN
         -- Tree List widget can receive focus
      once
         Result := True
      end

feature -- Actions

	recalc
			-- Recalculate layout
		local
			void_g: G
		do
			Precursor
			flags := flags | Flag_recalc
			cursor_item := void_g
		end

   set_focus
         -- Move the focus to this window
      do
         Precursor
         set_default (SB_TRUE)
      end

   kill_focus
         -- Remove the focus from this window
      do
         Precursor
         set_default(SB_MAYBE)
      end

   set_visible_rows (a_nvis: INTEGER)
         -- Change number of visible_rows items
      local
         nvis: INTEGER
      do         
         if a_nvis < 0 then
            nvis := 0
         else
            nvis := a_nvis
         end
         if visible_rows /= nvis then
            visible_rows := nvis
            recalc
         end
      end

   set_indent (an_indent: INTEGER)
         -- Change parent-child indent amount
      do
         if indent /= an_indent then
            indent := an_indent
            recalc
         end
      end

   set_line_color (a_colour: INTEGER)
         -- Change line color
      do
         if a_colour /= line_color then
            line_color := a_colour
            update
         end
      end

   set_list_style (a_style: INTEGER)
         -- Change list style
      local
         opts: INTEGER
      do
         opts := new_options (a_style, TREELIST_MASK)
         if options /= opts then
            options := opts
            recalc
         end
      end

feature -- Item queries

   item_width (i: G): INTEGER
         -- Return i width
      require
         valid_accessor (i)
      do
         Result := i.width (Current)
      end

   item_height (i: G): INTEGER
         -- Return i height
      require
         valid_accessor (i)
      do
         Result := i.height (Current)
      end

   get_item_at (x, y: INTEGER): G
         -- Get i at x,y, if any
      local 
         i: G
         ix, iy, iw, ih: INTEGER
      do
         i := first_item
         ix := pos_x
         iy := pos_y
         if (options & Treelist_root_boxes) /= 0 then ix := ix + (4+indent) end
         from
         until
            i = Void or else iy > y or else Result /= Void
         loop
            iw := i.width (Current)
            ih := i.height (Current)
            if y < iy + ih then
               Result := i
            else
               iy := iy + ih
               if i.first_child /= Void 
                  and then ((options & TREELIST_AUTOSELECT) /= 0 or else i.is_expanded)
                then
                  ix := ix + (indent + ih // 2)
                  i := i.first_child
               else
                  from
                  until
                     i.next /= Void or else i.parent = Void
                  loop
                     i := i.parent
                     ix := ix - (indent + i.height (Current) // 2)
                  end
                  i := i.next
               end
            end
         end
      end

   find_item_by_name_opts (text: STRING; start: G; flgs: INTEGER): G
         -- Search items for i by name, starting from start i; the
         -- flags argument controls the search direction, and case sensitivity.
      local
         comp: SB_STRING_COMPARATOR
         i, s, f, l: G
         len: INTEGER
         suffix: BOOLEAN
         reverse_prefix: BOOLEAN
      do
         if first_item /= Void then
            if (flgs & SEARCH_IGNORECASE) /= 0 then
               comp := comparecase
            else 
               comp := compare
            end
            if (flgs & SEARCH_REV_PREFIX) /= 0 then
            	reverse_prefix := True
            end
            if (flgs & SEARCH_PREFIX) /= 0 then
               len := text.count
            else
               len := 2147483647
            end
            if (flags & SEARCH_BACKWARD) = 0 then
            	-- Search forward
               s := first_item
               f := first_item
               if start /= Void then 
                  s := start
                  if s.parent /= Void then
                     f := s.parent.first_child
                  end
               end
               from
                  i := s
               until
                  i = Void or else Result /= Void
               loop
               	  if reverse_prefix then
               	  	len := i.label.count
               	  end
                  if comp.compare (i.label, text, len) = 0 then
                     Result := i
                  else
                     i := i.next
                  end
               end
               if Result = Void and then (flags & SEARCH_WRAP) /= 0 then
                  from
                     i := f
                  until
                     i = Void or else i = s or else Result /= Void
                  loop
               	     if reverse_prefix then
               	  	    len := i.label.count
               	     end
                     if comp.compare (i.label, text, len) = 0 then
                        Result := i
                     else
                        i := i.next
                     end
                  end
               end
            else
            	-- Search backward
               s := last_item; l := last_item
               if start /= Void then
                  s := start
                  if s.parent /= Void then
                     l := s.parent.last_child
                  end
               end
               from
                  i := s
               until
                  i = Void or else Result /= Void
               loop
               	  if reverse_prefix then
               	  	len := i.label.count
               	  end
                  if comp.compare (i.label, text, len) = 0 then
                     Result := i
                  else
                     i := i.prev
                  end
               end
               if Result = Void and then (flags & SEARCH_WRAP) /= 0 then
                  from
                     i := l
                  until
                     i = Void or else i = s or else Result /= Void
                  loop
	               	  if reverse_prefix then
	               	  	len := i.label.count
	               	  end
                     if comp.compare (i.label, text, len) = 0 then
                        Result := i
                     else
                        i := i.prev
                     end
                  end
               end
            end
         end
      end

   is_item_visible (i: G): BOOLEAN
         -- Return True if i is visible_rows
      require
         valid_accessor (i)
      do
         Result := 0 < pos_y + i.y + i.height (Current)
         	and then pos_y + i.y < viewport_h
      end

   item_hit (i: G; x_, y_: INTEGER): INTEGER
         -- Return i hit code: 0 outside, 1 icon, 2 text, 3 box
      local
         x,y,ix,iy,iw,ih,xh,yh: INTEGER
      do
         x := x_; y := y_
         if i /= Void then
            x := x - pos_x
            y := y - pos_y
            ix := i.x
            iy := i.y
            iw := i.width (Current)
            ih := i.height (Current)
            if iy <= y and then y < iy+ih then
               if (options & Treelist_shows_boxes) /= 0 and then
                  (i.has_items or else i.first_child /= Void)
                then
                  xh := ix - indent + (SIDE_SPACING // 2)
                  yh := iy + ih // 2
                  if		xh-4 <= x and then x <= xh+4
                  and then  yh-4 <= y and then y <= yh+4 then
                     Result := 3
                  end
               end
               if Result /= 3 then
                  Result := i.item_hit (Current, x-ix, y-iy)
               end
            end
         end
      end

feature -- Item actions

   add_item_first (p, i: G; notify: BOOLEAN)
         -- Prepend new [possibly subclassed] i as first child of p
      require
         i /= Void
      local
         olditem: G
         void_g: G
      do
         olditem := current_item;

         	-- Add i to list
         if p /= Void then
			i.set_prev (void_g)
            i.set_next (p.first_child)
            if i.next /= Void then
               i.next.set_prev (i)
            else
               p.set_last_child (i)
            end
            p.set_first_child (i)
         else
	        i.set_prev (void_g)
            i.set_next (first_item)
            if i.next /= Void then
               i.next.set_prev (i)
            else
               last_item := i
            end
            first_item := i
         end

         i.set_parent(p)
         i.set_first_child (void_g)
         i.set_last_child (void_g)
         i.set_x (0)
         i.set_y (0)

         	-- Make current_item if just added
         if current_item = Void and then i = last_item then
            current_item := i
         end

         	-- Notify i has been inserted
         if notify then
            do_send(SEL_INSERTED, i)
         end

        	-- Current i may have changed
         if olditem /= current_item then
            if notify then
               do_send(SEL_CHANGED, current_item)
            end
         end

         	-- Was new i
         if current_item = i then
            if has_focus then
               current_item.set_focus (True)
            end
            if (options & SELECT_MASK) = TREELIST_BROWSESELECT
               and then current_item.is_enabled
             then
               do_select_item (current_item, notify)
            end
         end

         -- Redo layout
         recalc
      end

   create_item_first (p: G; text: STRING; oi, ci: SB_ICON; data: ANY; notify: BOOLEAN): G
         -- Prepend new i with given text and optional icon, and 
         -- user-data pointer as first child of p
      do
         Result := create_item (text, oi,ci, data);
         add_item_first (p, Result, notify)
      end

	add_item_last (p, i: G; notify: BOOLEAN)
    		-- Append new [possibly subclassed] i as first child of p
    	require
         	i /= Void
      	local
         	olditem: G
         	void_g: G
      	do
         	olditem := current_item;
         		-- Add i to list
         	if p /= Void then
            	i.set_prev (p.last_child)
            	i.set_next (void_g)
            	if i.prev /= Void then
               		i.prev.set_next (i)
            	else
               		p.set_first_child (i)
            	end
            	p.set_last_child (i)
         	else
            	i.set_prev (last_item)
            	i.set_next (void_g)
            	if i.prev /= Void then
               		i.prev.set_next (i)
            	else
               		first_item := i
            	end
            	last_item := i
         	end
         	i.set_parent (p)
        	i.set_first_child (void_g)
        	i.set_last_child (void_g)
         	i.set_x (0)
         	i.set_y (0)
         		-- Make current_item if just added
         	if current_item = Void and then i = first_item then
            	current_item := i
         	end
         		-- Notify i has been inserted
         	if notify then
            	do_send (SEL_INSERTED, i)
         	end
         		-- Current i may have changed
         	if olditem /= current_item then
            	if notify then
               		do_send (SEL_CHANGED, current_item)
            	end
         	end
         		-- Was new i
         	if current_item = i then
            	if has_focus then
               		current_item.set_focus (True)
            	end
            	if (options & SELECT_MASK) = TREELIST_BROWSESELECT
            	and then current_item.is_enabled then
               		do_select_item (current_item, notify)
            	end
         	end
         		-- Redo layout
         	recalc
		end

	create_item_last (p: G; text: STRING; oi, ci: SB_ICON; data: ANY; notify: BOOLEAN): G
			-- Append new i with given text and optional icon, and user-data pointer as first child of p
		do
			Result := create_item (text, oi, ci, data)
			add_item_last (p, Result, notify)
		end

	add_item_after (other, i: G; notify: BOOLEAN)
			-- Append new [possibly subclassed] i after to other i
		require         
			other_not_void: other /= Void
			item_not_void: i /= Void
		do
				-- Add i to list
			i.set_prev (other)
			i.set_next (other.next)
			other.set_next (i)
			if i.next /= Void then
				i.next.set_prev (i)
			elseif other.parent /= Void then
				other.parent.set_last_child (i)
			else 
				last_item := i
			end
			i.set_parent (other.parent)
			i.set_first_child (Void)
			i.set_last_child (Void)
			i.set_x (0)
			i.set_y (0)
				-- Notify i has been inserted
			if notify then
				do_send (SEL_INSERTED, i)
			end
				-- Redo layout
			recalc
		end

   create_item_after (other: G; text: STRING; oi, ci: SB_ICON; data: ANY; notify: BOOLEAN): G
         -- Append new i with given text and optional icon, and user-data pointer after to other 
         -- i
      do
         Result := create_item (text, oi, ci, data)
         add_item_after (other, Result, notify)
      end

	add_item_before (other, i: G; notify: BOOLEAN)
			-- Prepend new [possibly subclassed] i prior to other i
		require         
			other_not_void: other /= Void
			i_not_void: i /= Void
		implemented: false
      do
         	-- Add i to list
         i.set_next (other)
         i.set_prev (other.prev)
         other.set_prev (i)
         if i.prev /= Void then
            i.prev.set_next (i)
         elseif other.parent /= Void then
            other.parent.set_first_child (i)
         else
			first_item := i
         end
         i.set_parent (other.parent)
         i.set_first_child (Void)
         i.set_last_child (Void)
         i.set_x (0)
         i.set_y (0)
            
         	-- Notify i has been inserted
         if notify then
            do_send (SEL_INSERTED, i)
         end

         	-- Redo layout
         recalc
      end

   create_item_before (other: G; text: STRING; oi, ci: SB_ICON; data: ANY; notify: BOOLEAN): G
         -- Prepend new i with given text and optional icon, and 
         -- user-data pointer prior to other i
      do
         Result := create_item (text, oi, ci, data)
         add_item_before (other, Result, notify)
      end

   remove_item(index: G)
         -- Remove item from container
      do
         remove_item_notify (index, False)
      end

   remove_item_notify(i: G; notify: BOOLEAN)
         -- Remove i
      local
         f, l, olditem: G
      do
         olditem := current_item

         if i /= Void then
            -- First remove children
            f ?= i.first_child; l := i.last_child
            remove_items(f, l, notify)

            -- Notify i will be deleted
            if notify then
            	do_send(SEL_DELETED, i)
            end

            -- Adjust pointers
            if anchor_item = i then
               if anchor_item.next /= Void then
                  anchor_item := anchor_item.next
               elseif anchor_item.prev /= Void then
                  anchor_item := anchor_item.prev
               else
                  anchor_item := anchor_item.parent
               end
            end
            if extent_item = i then
               if extent_item.next /= Void then
                  extent_item := extent_item.next
               elseif extent_item.prev /= Void then
                  extent_item := extent_item.prev
               else
                  extent_item := extent_item.parent
               end
            end
            if current_item = i then
               if current_item.next /= Void then
                  current_item := current_item.next
               elseif current_item.prev /= Void then
                  current_item := current_item.prev
               else
                  current_item := current_item.parent
               end
            end
            
            -- Remove i from list
            if i.prev /= Void then
               i.prev.set_next(i.next)
            elseif i.parent /= Void then
               i.parent.set_first_child(i.next)
            else
               first_item := i.next
            end

            if i.next /= Void then
               i.next.set_prev(i.prev)
            elseif i.parent /= Void then
               i.parent.set_last_child(i.prev);
            else
               last_item := i.prev;
            end

            -- Hasta la vista, baby! 
            -- delete i;

            -- Current i has changed
            if olditem /= current_item then
               if notify then
                  do_send(SEL_CHANGED, current_item)
               end
            end

            -- Deleted current i
            if current_item /= Void and then i = olditem then
               if has_focus then
                  current_item.set_focus(True)
               end
               if (options & SELECT_MASK) = TREELIST_BROWSESELECT
                  and then current_item.is_enabled
                then
                  do_select_item(current_item, notify)
               end
            end

            -- Redo layout
            recalc
         end
      end

   remove_items (fm, to: G; notify: BOOLEAN)
         -- Remove items in range [fm, to] inclusively
      local
         i, fm_: G
         done: BOOLEAN
      do
         if fm /= Void and then to /= Void then
            from
               done := False
               fm_ := fm
            until
               done
            loop
               i := fm_
               fm_ := fm_.next
               remove_item_notify(i, notify)
               if i = to then
                  done := True
               end
            end
         end
      end

   clear_items_notify (notify: BOOLEAN)
         -- Remove all items from list
      do
         remove_items(first_item, last_item, notify)
      end

   move_item_after (new_index, old_index: G)
         -- Remove item from container
      require
         valid_accessor(old_index)
         valid_accessor(new_index)
      do
         move_item_after_notify (new_index, old_index, False)
      end

   move_item_after_notify (other, moved: G; notify: BOOLEAN)
         -- Move 'moved' item after other
      require
         valid_accessor (other)
         valid_accessor (moved)
      do
         -- Did it change?
         if moved /= other then
            -- Unlink from old spot
            if moved.prev /= Void then moved.prev.set_next(moved.next);
            elseif moved.parent /= Void then moved.parent.set_first_child(moved.next);
            else first_item := moved.next
            end
            if moved.next /= Void then moved.next.set_prev(moved.prev);
            elseif moved.parent /= Void then moved.parent.set_last_child(moved.prev);
            else last_item := moved.prev
            end
            -- Same parent as other
            moved.set_parent(other.parent)
            -- Link in front of new item
            moved.set_prev(other)
            moved.set_next(other.next)
            if moved.next /= Void then moved.next.set_prev(moved)
            elseif moved.parent /= Void then moved.parent.set_last_child(moved)
            else last_item := moved
            end
            moved.prev.set_next(moved)
            -- Redo layout
            recalc
         end
      end

   move_item_before_notify (other, moved: G; notify: BOOLEAN)
         -- Move 'moved' item before other
      do
         -- Did it change?
         if moved /= other then
            -- Unlink from old spot
            if moved.prev /= Void then moved.prev.set_next(moved.next)
            elseif moved.parent /= Void then moved.parent.set_first_child(moved.next)
            else first_item := moved.next
            end
            if moved.next /= Void then moved.next.set_prev(moved.prev);
            elseif moved.parent /= Void then moved.parent.set_last_child(moved.prev)
            else last_item := moved.prev
            end
            -- Same parent as newitem
            moved.set_parent(other.parent)

            -- Link in front of new item
            moved.set_next(other)
            moved.set_prev(other.prev)
            if moved.prev /= Void then moved.prev.set_next(moved)
            elseif moved.parent /= Void then moved.parent.set_first_child(moved)
            else first_item := moved
            end
            moved.next.set_prev(moved)
            -- Redo layout
            recalc
         end
      end


   make_item_visible (i: G)
         -- Scroll to make i visible_rows
      local
         par: G
         x,y,w,h: INTEGER
      do
         if i /= Void then
            -- Expand parents of Current node
            if (options & TREELIST_AUTOSELECT) = 0 then
               from
                  par := i.parent
               until
                  par = Void
               loop
                  if not par.is_expanded then
                     par.set_expanded(True)       -- FIXME use expand_tree?
                     recalc;
                  end
                  par := par.parent
               end
            end

            -- Now we adjust the scrolled position to fit everything
            if is_attached then

               -- Force layout if dirty
               if (flags & Flag_recalc) /= 0 then layout end
               x := pos_x
               y := pos_y

               w := i.width (Current)
               h := i.height (Current)

               if viewport_w <= x+i.x+w then x := viewport_w - i.x - w end
               if x+i.x <= 0 then x := - i.x end

               if viewport_h <= y+i.y+h then y := viewport_h - i.y - h end
               if y+i.y <= 0 then y := -i.y end

               -- Scroll into view
               set_scroll_position (x,y)
            end
         end
      end

   set_item_closed_icon (i: G; icon: SB_ICON)
         -- Change items's closed icon
      require
         valid_accessor (i)
      do
         i.set_closed_icon (icon)
         recalc
      end

   update_item (i: G)
         -- Repaint i
      do
         if i /= Void then
            update_rectangle(0, pos_y + i.y, content_w, i.height(Current))
         end
      end

   select_item (i: G; notify: BOOLEAN): BOOLEAN
         -- Select i
      local
         t: INTEGER
      do
         if not i.is_selected then
            Result := True
            t := options & SELECT_MASK
            if t = TREELIST_SINGLESELECT or else t = TREELIST_BROWSESELECT then
               do_kill_selection(notify)
            end
            if t = TREELIST_SINGLESELECT or else t = TREELIST_BROWSESELECT or else t = TREELIST_EXTENDEDSELECT or else t = TREELIST_MULTIPLESELECT then
               i.set_selected(True);
               update_item(i)
               if notify then do_send(SEL_SELECTED, i) end
            end
         end
      end


   deselect_item (i: G; notify: BOOLEAN): BOOLEAN
         -- Deselect i
      local
         t: INTEGER
      do
         if i.is_selected then
            Result := True
            t := options & SELECT_MASK
            if t = TREELIST_EXTENDEDSELECT or else t = TREELIST_MULTIPLESELECT
               or else t = TREELIST_SINGLESELECT
             then
               i.set_selected(False)
               update_item(i)
               if notify then do_send(SEL_DESELECTED, i) end
            end
         end
      end

   toggle_item (i: G; notify: BOOLEAN): BOOLEAN
         -- Toggle i selection
      local
         t: INTEGER
      do
         t := options & SELECT_MASK
         if t = TREELIST_BROWSESELECT then
            if not i.is_selected then
               do_kill_selection (notify)
               i.set_selected (True)
               update_item (i)
               if notify then do_send (SEL_SELECTED, i) end
            end
         elseif t = TREELIST_SINGLESELECT then
            if not i.is_selected then
               do_kill_selection (notify)
               i.set_selected (True)
               update_item (i)
               if notify then do_send (SEL_SELECTED, i) end
            else
               i.set_selected (False);
               update_item (i);
               if notify then do_send (SEL_DESELECTED, i) end
            end
         elseif t = TREELIST_EXTENDEDSELECT or else t = TREELIST_MULTIPLESELECT then
            if not i.is_selected then
               i.set_selected (True);
               update_item (i);
               if notify then do_send (SEL_SELECTED, i) end
            else
               i.set_selected (False)
               update_item (i)
               if notify then do_send (SEL_DESELECTED, i) end
            end
         end
         Result := True
      end

   open_item (i: G; notify: BOOLEAN)
         -- Open i
      require
         valid_accessor(i)
      do
         if not i.is_opened then
            i.set_opened (True)
            update_item (i)
            if notify and then message_target /= Void then
               message_target.do_handle_2 (Current, SEL_OPENED, 0, i)
            end
         end
      end

   close_item (i: G; notify: BOOLEAN)
         -- Close i
      require
         valid_accessor(i)
      do
         if i.is_opened then
            i.set_opened (False)
            update_item (i)
            if notify and then message_target /= Void then
               message_target.do_handle_2 (Current, SEL_CLOSED, 0, i)
            end
         end
      end

   do_collapse_tree (tree: G; notify: BOOLEAN)
      local
         t: BOOLEAN;
      do
         t := collapse_tree(tree, notify);
      end

   collapse_tree (tree: G; notify: BOOLEAN): BOOLEAN
         -- Collapse tree
      require
         tree /= Void
      do
         if tree.is_expanded then
            tree.set_expanded (False);
            if (options & TREELIST_AUTOSELECT) = 0 then
               -- In autoselect, already is_shown as expanded!
               if tree.first_child /= Void then
                  recalc
               else
                  update_item (tree)
               end
            end
            if notify and then message_target /= Void then
               message_target.do_handle_2 (Current, SEL_COLLAPSED, 0, tree)
            end
            Result := True
         end
      end

   do_expand_tree(tree: G; notify: BOOLEAN)
      local
         t: BOOLEAN
      do
         t := expand_tree (tree, notify)
      end

   expand_tree (tree: G; notify: BOOLEAN): BOOLEAN
         -- Expand tree
      require
         tree /= Void
      do
         if not tree.is_expanded then
            tree.set_expanded (True)
            if (options & TREELIST_AUTOSELECT) = 0 then
               -- In autoselect, already is_shown as expanded not 
               if tree.first_child /= Void then
                  recalc
               else
                  update_item (tree)
               end
            end
            if notify and then message_target /= Void then
               message_target.do_handle_2 (Current, SEL_EXPANDED, 0, tree)
            end
            Result := True
         end
      end

   reparent_item (i, p: G)
         -- Reparent i under parent p
      require
         valid_accessor (i)
      do
         if i.parent /= p then
            if i.prev /= Void then 
               i.prev.set_next (i.next)
            elseif i.parent /= Void then
               i.parent.set_first_child (i.next)
            else 
               first_item := i.next
            end
            if i.next /= Void then
               i.next.set_prev(i.prev)
            elseif i.parent /= Void then
               i.parent.set_last_child(i.prev)
            else
               last_item := i.prev
            end
            if p /= Void then
               i.set_prev(p.last_child)
               i.set_next(Void);
               if i.prev /= Void then
                  i.prev.set_next(i)
               else
                  p.set_first_child(i)
               end
               p.set_last_child(i);
            else
               i.set_prev(last_item)
               i.set_next(Void)
               if i.prev /= Void then
                  i.prev.set_next(i)
               else
                  first_item := i
               end
               last_item := i
            end
            i.set_parent(p)
            recalc
         end
      end

   set_current_item (i: G; notify: BOOLEAN)
         -- Change current i
      do
         if i /= current_item then

            -- Deactivate old i
            if current_item /= Void then
               -- No visible_rows change if it doen't have the focus
               if has_focus then
                  current_item.set_focus(False)
                  update_item(current_item)
               end
               -- Close old i
               close_item(current_item,notify)
            end

            current_item := i

            -- Activate new i
            if current_item /= Void then
               -- No visible_rows change if it doen't have the focus
               if has_focus then
                  current_item.set_focus(True)
                  update_item(current_item)
               end
               -- Open new i
               open_item(current_item,notify)
            end

            -- Notify i change
            if notify then
               do_send(SEL_CHANGED,current_item)
            end
         end
         -- Select if browse mode
         if (options & SELECT_MASK) = TREELIST_BROWSESELECT
            and then current_item /= Void and then current_item.is_enabled
          then
            do_select_item(current_item,notify)
         end
      end

   extend_selection (i: G; notify: BOOLEAN): BOOLEAN
         -- Extend selection from anchor_item i to i
      local
         it,i1,i2,i3: G
      do

         if i /= Void and then anchor_item /= Void and then extent_item /= Void then

            -- Find segments
            from
               it := first_item
            until
               it = Void
            loop
               if it = i then i1 := i2; i2 := i3; i3 := it end
               if it = anchor_item then i1 := i2; i2 := i3; i3 := it end
               if it = extent_item then i1 := i2; i2 := i3; i3 := it end
               it := it.below_item
            end

            check
               i1 /= Void and then i2 /= Void and then i3 /= Void
            end

            	-- First segment
            from
               it := i1
            until
               it = i2
            loop
               if i1 = i then
                  if not it.is_selected then
                     it.set_selected(True)
                     update_item(it)
                     Result := True
                     if notify then do_send(SEL_SELECTED,it) end
                  end
               elseif i1 = extent_item then
                  if it.is_selected then
                     it.set_selected(False)
                     update_item(it)
                     Result := True
                     if notify then do_send(SEL_DESELECTED,it) end
                  end
               end
               it := it.below_item
            end

            	-- Second segment
            from
               it := i2
            until
               it = i3
            loop
               it := it.below_item
               if i3 = i then
                  if not it.is_selected then
                     it.set_selected(True)
                     update_item(it)
                     Result := True
                     if notify then do_send(SEL_SELECTED,it) end
                  end
               elseif i3 = extent_item then
                  if it.is_selected then
                     it.set_selected(False)
                     update_item(it)
                     Result := True
                     if notify then do_send(SEL_DESELECTED,it) end
                  end
               end
            end
            extent_item := i
         end
      end

   kill_selection (notify: BOOLEAN): BOOLEAN
         -- Deselect all items
      local
         i: G
      do
         from
            i := first_item
         until
            i = Void
         loop
            if i.is_selected then
               i.set_selected(False)
               update_item(i)
               Result := True
               if notify then do_send(SEL_DESELECTED,i) end
            end
            i := i.below_item
         end
      end

feature -- Sorting

   items_sorter: SB_LIST_SORTER [ G ]

	sort_root_items
			-- Sort root items
		local
			a: ARRAY [ G ]
		do
			if items_sorter /= Void and then item_comparator /= Void then
				a := items_sorter.sort(first_item, item_comparator)
				first_item := a.item(1)
				last_item := a.item(2)
				recalc
			else
				fx_trace(0, <<"SB_TREE_LIST::sort_root_items - items_sorter = Void (", (items_sorter = Void).out,
							"( item_comparator = Void(", (item_comparator = Void).out, ")">>)
			end
		end

   sort_child_items (i: G)
         -- Sort children of i
      require
         valid_accessor(i)
      local
         a: ARRAY[G]
      do
         if items_sorter /= Void and then item_comparator /= Void then
            a := items_sorter.sort(i.first_child, item_comparator)
            i.set_first_child(a.item(1))
            i.set_last_child(a.item(2))
         end
         if i.is_expanded then recalc end -- No need to recalc if it ain't visible!
      end

	sort_recursive
			-- Sort each node of tree
		local
			i: G
		do
			sort_root_items
			from
				i := first_item
			until
				i = Void
			loop
				sort_child_items (i)
				sort_recursive_at (i)
				i := i.next
			end
		end
	
	sort_recursive_at (i: G)
		do
		end

feature -- Message processing

	handle_2 (sender: SB_MESSAGE_HANDLER; type, selector: INTEGER; data: ANY): BOOLEAN
      	do
         	if		match_function_2 (Sel_timeout,			ID_TIPTIMER,	type, selector) then Result := on_tip_timer 		(sender,selector,data)
         	elseif  match_function_2 (Sel_timeout,			ID_LOOKUPTIMER,	type, selector) then Result := on_lookup_timer 		(sender,selector,data)
         	elseif  match_function_2 (SEL_CLICKED,			0,				type, selector) then Result := on_clicked 			(sender,selector,data)
         	elseif  match_function_2 (SEL_DOUBLECLICKED,	0,				type, selector) then Result := on_double_clicked 	(sender,selector,data)
         	elseif  match_function_2 (SEL_TRIPLECLICKED,	0,				type, selector) then Result := on_triple_clicked 	(sender,selector,data)
         	elseif  match_function_2 (SEL_COMMAND,			0,				type, selector) then Result := on_command 			(sender,selector,data)
         	elseif  match_function_2 (SEL_UPDATE,			Id_query_tip,	type, selector) then Result := on_query_tip 		(sender,selector,data)
         	elseif  match_function_2 (SEL_UPDATE,			Id_query_help,	type, selector) then Result := on_query_help 		(sender,selector,data)
         	else Result := Precursor (sender, type, selector,data)
         	end
      	end

	on_paint (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      	local
         	event: SB_EVENT
         	dc: SB_DC_WINDOW
         	i, p: G
         	yh,xh, x,y,w,h, xp,hh: INTEGER
         	px,py: INTEGER
         	ev_rect_y: INTEGER
         	sl: STRING	-- DEBUG
      	do
         	event ?= data check event /= Void end
         	dc := paint_dc
         	dc.make_event (Current, event)
         	dc.set_font(font)
         	x := pos_x	-- Start at top left of visible scrolled area
         	y := pos_y
         	if (options & Treelist_root_boxes) /= 0 then  x := x + (4+indent) end
         	from
            	i := first_item
         	until
            	i = Void or else y >= event.rect_y + event.rect_h
         	loop
            	w := i.width (Current)
            	h := i.height (Current)
            	ev_rect_y := event.rect_y
            	if ev_rect_y <= y+h then
               		-- Draw i
               		dc.set_foreground (back_color)
               		dc.fill_rectangle (0, y, content_w, h)
               		i.draw (Current, dc, x,y, w,h)

               	-- This condition under construction w.r.t. item.has_expander
				-- vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
               		-- Show other paraphernalia such as dotted lines and expand-boxes
               		if true
               			and then (options & (Treelist_shows_lines | Treelist_shows_boxes)) /= 0
                  		and then (i.parent /= Void
                  				or else (options & Treelist_root_boxes) /= 0
                --#  				or else i.has_expander
                  				)
				-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                	then
                  		hh := h // 2
                  		yh := y + hh
                  		xh := x - indent + (SIDE_SPACING // 2)
                  		dc.set_foreground (line_color)
                  		dc.set_background (back_color)

                  		px := pos_x & 1
                  		py := pos_y & 1

                  		dc.set_stipple_pattern (dc.Stipple_gray, px, py)
                  		if (options & Treelist_shows_lines) /= 0 then

                  			-- Connect items with lines
                     		dc.set_fill_style (dc.Fill_opaque_stippled)	-- Fill_opaque_stippled ???
                     		from
                        		p := i.parent
                        		xp := xh
                     		until
                        		p = Void
                     		loop
                        		xp := xp - (indent + p.height(Current) // 2)
                        		if p.next /= Void then
                        			dc.fill_rectangle (xp, y, 1, h)
                        		end
                        		p := p.parent
                     		end
                     		if (options & Treelist_shows_boxes) /= 0
                        	and then (i.has_items or else i.first_child /= Void)
                      		then
                        		if i.prev /= Void or else i.parent /= Void then
                       			dc.fill_rectangle (xh, y, 1, yh - y - 4)
                        		end
                        		if i.next /= Void then
                      				dc.fill_rectangle (xh, yh + 4, 1, y + h - yh - 4)
                        		end
                     		else
                        		if i.prev /= Void or else i.parent /= Void then
                        			dc.fill_rectangle (xh, y, 1, hh)
                        		end
                        		if i.next /= Void then
                        			dc.fill_rectangle (xh, yh, 1, h)
                        		end
                        		dc.fill_rectangle (xh, yh, x + (SIDE_SPACING // 2) - 2 - xh, 1)
                     		end
                     		dc.set_fill_style (dc.Fill_solid)
                     		check dc_fill_solid_is_0: dc.Fill_solid = 0 end
                     	--	edp_trace.st("SB_GENERIC_TREE_LIST -- dc.Fill_solid = ").n((dc.Fill_solid).out).d
                  		end

               		-- This condition under construction w.r.t. item.has_expander
					-- vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
                  		-- Boxes before items for expand/collapse of i
                  		if true
                  			and then ((options & Treelist_shows_boxes) /= 0
                     		and then (i.has_items or else i.first_child /= Void)
                    --#		and then (options & Treelist_boxes_item_opt) = 0
                     		)
					--#	or else i.has_expander
					-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                   		then
                     		dc.set_fill_style (dc.Fill_opaque_stippled)	-- XXX Fill_opaque_stippled ??
                     		dc.fill_rectangle (xh + 4, yh, (SIDE_SPACING // 2) - 2, 1)
                     		dc.set_fill_style (dc.Fill_solid)
                     		dc.draw_rectangle (xh - 4, yh - 4, 8, 8)
                     		dc.set_foreground (text_color)
                     		dc.fill_rectangle (xh - 2, yh, 5, 1)
                     		if (options & TREELIST_AUTOSELECT) = 0 
                        	and then not i.is_expanded
                      		then
                        		dc.fill_rectangle (xh, yh - 2, 1, 5)
                     		end
                  		end
               		end
            	end

	            	-- Move on to the next i
            	y := y + h
            	if i.first_child /= Void
               	and then ((options & TREELIST_AUTOSELECT) /= 0 or else i.is_expanded)
             	then
               		x := x + (indent + h // 2)
               		i := i.first_child
            	else
               		from
               		until
                	  	i.next /= Void or else i.parent = Void
               		loop
                	  	i := i.parent
                	  	x := x - (indent + i.height (Current) // 2)
               		end
               		i := i.next
            	end
         	end
         		-- Fill remaining 'height' of exposed area
         	if y < event.rect_y + event.rect_h then
            	dc.set_foreground (back_color)
            	dc.fill_rectangle (event.rect_x, y, event.rect_w, event.rect_y + event.rect_h - y)
         	end
         	dc.stop
         	Result := True
		end

	on_enter (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
		local
			void_g: G
		do
			Result := Precursor (sender,selector,data)
			if timer = Void then
				timer := application.add_timeout (application.menu_pause, Current, ID_TIPTIMER)
			end
			cursor_item := void_g
			Result := True
		end

	on_leave (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
   	  	local
   	  		void_g: G
      	do
         	Result := Precursor (sender,selector,data)
         	if timer /= Void then
         		application.remove_timeout (timer)
				timer := Void
         	end
         	cursor_item := void_g
         	Result := True
      	end

   on_ungrabbed (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         Result := Precursor (sender, selector, data)
         unset_flags (Flag_dodrag | Flag_trydrag | Flag_pressed | Flag_changed | Flag_scrolling)
         flags := flags | Flag_update
         stop_auto_scroll
         Result := True
      end

	on_motion (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      	local
         	event: SB_EVENT
         	flg: INTEGER
         	oldcursoritem, i: G
         	index: INTEGER
      	do
         	event ?= data check event /= Void end

         	flg := flags
         		-- Kill the tip
         	unset_flags (Flag_tip)

         		-- Kill the tip timer
         	if timer /= Void then
         		application.remove_timeout (timer)
         		timer := Void
         	end

         	if (flags & Flag_scrolling) /= 0 then
            		-- Right mouse scrolling
            	set_scroll_position (event.win_x - grab_x, event.win_y - grab_y)
            	Result := True
         	elseif (flags & Flag_dodrag) /= 0 then
            		-- Drag and drop mode
            	if not start_auto_scroll (event.win_x, event.win_y, True) then
            		do_handle_2 (Current, SEL_DRAGGED, 0, data)
            	end
            	Result := True
         	elseif (flags & Flag_trydrag) /= 0 and then event.moved then
            		-- Tentative drag and drop
            	unset_flags (Flag_trydrag)
            	if handle_2 (Current, SEL_BEGINDRAG, 0, data) then
               		flags := flags | Flag_dodrag
            	end
            	Result := True
         	elseif (flags & Flag_pressed) /= 0 
            or else (options & TREELIST_AUTOSELECT) /= 0 then
            		-- Normal operation
            	if not start_auto_scroll (event.win_x, event.win_y, False) then
               			-- Find i
               		i := get_item_at (event.win_x,event.win_y)
               			-- Got an i different from before
               		if i /= Void and then i /= current_item then
                  			-- Make it the current_item i
                  		set_current_item (i, True)
                  			-- Extend the selection
                  		if (options & SELECT_MASK) = TREELIST_EXTENDEDSELECT then
                     		state := False
                     		do_extend_selection (i, True)
                  		end
               		end
            	end
            	Result := True
         	else
            		-- Reset tip timer if nothing's going on
            	timer := application.add_timeout (application.menu_pause, Current, ID_TIPTIMER)
            		-- Get i we're over
            	cursor_item := get_item_at (event.win_x, event.win_y)
            		-- Force GUI update only when needed
            	if cursor_item /= oldcursoritem or else (flg & Flag_tip) /= 0 then
               		Result := True
            	end
         	end
      	end

   on_key_press (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         event: SB_EVENT
         i: G
         done: BOOLEAN
         t: INTEGER
      do
         event ?= data check event /= Void end
         i := current_item
         unset_flags (Flag_tip)
         if is_enabled then
            Result := True
            if message_target = Void
               or else not message_target.handle_2 (Current, SEL_KEYPRESS, message, data)
             then
               if i = Void then i := first_item end

               inspect event.code

               when key_control_l, key_control_r,
               		key_shift_l, key_shift_r,
               		key_alt_l, key_alt_r then
                  if (flags & Flag_dodrag) /= 0 
                   then
                     do_handle_2 (Current, SEL_DRAGGED, 0, data)
                  end

               when key_page_up, key_kp_page_up then
                  create lookup_string.make_empty
                  set_scroll_position (pos_x, pos_y + v_scroll_bar.page_size)

               when key_page_down, key_kp_page_down then
                  create lookup_string.make_empty
                  set_scroll_position (pos_x, pos_y - v_scroll_bar.page_size)

               when key_up, key_kp_up then
                  if i /= Void then
                     if i.prev /= Void then
                        i := i.prev
                        from
                        until 
                           i.first_child = Void
                              or else ((options & TREELIST_AUTOSELECT) = 0
                                       and then not i.is_expanded)
                        loop
                           i := i.last_child
                        end
                     elseif i.parent /= Void then
                        i := i.parent
                     end
                  end
                  do_hop(event,i)

               when key_down, key_kp_down then
                  if i /= Void then
                     if i.first_child /= Void 
                        and then ((options & TREELIST_AUTOSELECT) /= 0 or else i.is_expanded)
                      then
                        i := i.first_child
                     else
                        from 
                        until
                           i.next /= Void or else i.parent = Void 
                        loop
                           i := i.parent
                        end
                        i := i.next
                     end
                  end
                  do_hop(event,i)

               when key_right, key_kp_right then
                  if i /= Void then
                     if (options & TREELIST_AUTOSELECT) = 0 
                        and then not i.is_expanded
                        and then (i.has_items or else i.first_child /= Void)
                      then
                        do_expand_tree(i,True)
                     elseif i.first_child /= Void then
                        i := i.first_child
                     else
                        from
                        until 
                           i.next /= Void or else i.parent /= Void
                        loop
                           i := i.parent
                        end
                        i := i.next
                     end
                  end
                  do_hop (event,i)

               when key_left, key_kp_left then
                  if i /= Void then
                     if (options & TREELIST_AUTOSELECT) = 0
                        and then i.is_expanded
                        and then (i.has_items or else i.first_child /= Void)
                      then
                        do_collapse_tree (i,True)
                     elseif i.parent /= Void then
                        i := i.parent
                     elseif i.prev /= Void then
                        i := i.prev
                     end
                  end
                  do_hop(event,i)

               when key_home, key_kp_home then
                  i := first_item
                  do_hop(event, i)

               when key_end, key_kp_end then
                  from
                     i := last_item
                  until
                     i = Void or else done
                  loop
                     if i.last_child /= Void and then ((options & TREELIST_AUTOSELECT) /= 0 or else i.is_expanded) then
                        i := i.last_child
                     elseif i.next /= Void then
                        i := i.next
                     else
                        done := True
                     end
                  end
                  do_hop (event, i)

               when key_space, key_kp_space then
                  create lookup_string.make_empty
                  if i /= Void and then i.is_enabled then
                     t := options & SELECT_MASK
                     if t = TREELIST_EXTENDEDSELECT then
                        if (event.state & SHIFTMASK) /= 0 then
                           if anchor_item /= Void then
                              do_select_item (anchor_item,True)
                              do_extend_selection (i,True)
                           else
                              do_select_item(i,True)
                           end
                        elseif (event.state & CONTROLMASK) /= 0 then
                           do_toggle_item (i,True)
                        else
                           do_kill_selection (True)
                           do_select_item (i,True)
                        end
                     elseif t = TREELIST_MULTIPLESELECT or else t = TREELIST_SINGLESELECT then
                        do_toggle_item(i,True)
                     end
                     set_anchor_item(i)
                  end
                  do_handle_2 (Current, SEL_CLICKED, 0, current_item)
                  if current_item /= Void and then current_item.is_enabled then
                     do_handle_2 (Current, SEL_COMMAND, 0, current_item)
                  end

               when key_return, key_kp_enter then
                  create lookup_string.make_empty
                  do_handle_2 (Current, SEL_DOUBLECLICKED, 0, current_item)
                  if current_item /= Void and then current_item.is_enabled then
                     do_handle_2 (Current, SEL_COMMAND, 0, current_item)
                  end
               else
                  if (event.state & (CONTROLMASK | ALTMASK)) /= 0 
                     or else event.text.is_empty or else event.text.item (1).code < 32
                   then
                     Result := False
                  else
                     lookup_string.append_string (event.text)
                     if lookup_timer /= Void then
                     	application.remove_timeout (lookup_timer)
                     	lookup_timer := Void
                     end
                     lookup_timer := application.add_timeout (application.typing_speed, Current, ID_LOOKUPTIMER);
                     i := find_item_by_name_opts (lookup_string, current_item, SEARCH_FORWARD | SEARCH_WRAP | SEARCH_PREFIX);
                     if i /= Void then
                        set_current_item (i,True)
                        make_item_visible (i)
                        if (options & SELECT_MASK) = TREELIST_EXTENDEDSELECT then
                           if i.is_enabled then
                              do_kill_selection (True)
                              do_select_item (i, True)
                           end
                        end
                        set_anchor_item (i)
                     end
                     do_handle_2 (Current, SEL_CLICKED, 0, current_item);
                     if current_item /= Void and then current_item.is_enabled then
                        do_handle_2 (Current, SEL_COMMAND, 0, current_item);
                     end
                  end
               end
            end
         end
      end

   on_key_release (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         event: SB_EVENT;
      do
         event ?= data check event /= Void end
         if is_enabled then
            if message_target /= Void 
               and then message_target.handle_2 (Current, SEL_KEYRELEASE, message, data)
             then
               Result := True
            else
               inspect event.code
               when key_shift_l, key_shift_r, key_control_l,
                  key_control_r, key_alt_l, key_alt_r
                then
                  if (flags & Flag_dodrag) /= 0 then
                     do_handle_2 (Current, SEL_DRAGGED, 0, data)
                  end
                  Result := True
               else
               end
            end
         end
      end

   on_left_btn_press (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         event: SB_EVENT
         code: INTEGER
         i: G
         t: INTEGER
         do_update: BOOLEAN
      do
         event ?= data check event /= Void end
         unset_flags (Flag_tip)
         do_handle_2 (Current, SEL_FOCUS_SELF, 0, data)
         if is_enabled then
            Result := True
            grab_mouse
            unset_flags (Flag_update)
            if message_target = Void 
               or else not message_target.handle_2 (Current, SEL_LEFTBUTTONPRESS, message, data)
               or else (options & TREELIST_AUTOSELECT) = 0
             then
               	-- Locate i
               i := get_item_at (event.win_x, event.win_y)
               if i /= Void then
                  	-- Find out where hit
                  code := item_hit (i, event.win_x, event.win_y)
                  	-- Maybe clicked on box
                  if code = 3 then
                     if i.is_expanded then
                        do_collapse_tree (i, True)
                     else
                        do_expand_tree (i, True)
                     end
                     do_update := True
                  else
                     	-- Change current_item i
                     set_current_item (i, True)
                     	-- Change i selection
                     state := i.is_selected
                     t := options & SELECT_MASK
                     if t = TREELIST_EXTENDEDSELECT then
                        if (event.state & SHIFTMASK) /= 0 then
                           if anchor_item /= Void then
                              if anchor_item.is_enabled then do_select_item (anchor_item, True) end
                              do_extend_selection (i, True)
                           else
                              if i.is_enabled then do_select_item (i, True) end
                              set_anchor_item (i)
                           end
                        elseif (event.state & CONTROLMASK) /= 0 then
                           if i.is_enabled and then not state then do_select_item (i, True) end
                           set_anchor_item (i)
                        else
                           if i.is_enabled and then not state then do_kill_selection (True); do_select_item (i, True); end
                           set_anchor_item (i)
                        end
                     elseif t = TREELIST_MULTIPLESELECT or else t = TREELIST_SINGLESELECT then
                        if i.is_enabled and then not state then do_select_item (i, True) end
                     end

                     	-- Start drag if actually pressed text or icon only
                     if code /= 0 and then i.is_selected and then i.is_draggable then
                        flags := flags | Flag_trydrag
                     end
                     flags := flags | Flag_pressed
                  end
               end
            end
            if do_update then
            	layout
            	update
            end
         end
      end

   on_left_btn_release (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         event: SB_EVENT
         code: INTEGER
         t: INTEGER
         flg: INTEGER
      do
         event ?= data check event /= Void end

         flg := flags
         if is_enabled then
            Result := True
            release_mouse
            stop_auto_scroll
            flags := flags | Flag_update
            unset_flags (Flag_pressed | Flag_trydrag | Flag_dodrag)

            	-- First chance callback
            if (message_target = Void 
               or else not message_target.handle_2 (Current, SEL_LEFTBUTTONRELEASE, message, data))
               and then ((flg & Flag_pressed) /= 0 or else (options & TREELIST_AUTOSELECT) /= 0)
             then
               	-- Was dragging
               if (flg & Flag_dodrag) /= 0 then
                  do_handle_2 (Current, SEL_ENDDRAG, 0, data)
               else
                  	-- Select only enabled i
                  t := (options & SELECT_MASK);
                  if t =  TREELIST_EXTENDEDSELECT then
                     if current_item /= Void and then current_item.is_enabled then
                        if (event.state & CONTROLMASK) /= 0 then
                           if state then do_deselect_item (current_item, True) end
                        elseif (event.state & SHIFTMASK) = 0 then
                           if state then do_kill_selection (True); do_select_item (current_item, True) end
                        end
                     end
                  elseif t = TREELIST_MULTIPLESELECT or else t = TREELIST_SINGLESELECT then
                     if current_item /= Void and then current_item.is_enabled then
                        if state then do_deselect_item (current_item, True) end
                     end
                  end

                  	-- Scroll to make i visibke
                  make_item_visible (current_item);
                  	-- Update anchor_item
                  set_anchor_item (current_item);

                  	-- Generate clicked callbacks
                  if event.click_count = 1  then
                     do_handle_2 (Current, SEL_CLICKED, 0, current_item)
                  elseif event.click_count = 2 then
                     do_handle_2 (Current, SEL_DOUBLECLICKED, 0, current_item)
                  elseif event.click_count = 3 then
                     do_handle_2 (Current, SEL_TRIPLECLICKED, 0, current_item)
                  end

                  	-- Command callback only when clicked on i
                  if current_item /= Void and then current_item.is_enabled then
                     do_handle_2 (Current, SEL_COMMAND, 0, current_item)
                  end
               end
            end
         end
      end

	on_right_btn_press (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
		local
			event: SB_EVENT
		do
			event ?= data check event /= Void end
			unset_flags (Flag_tip)
			do_handle_2 (Current, SEL_FOCUS_SELF, 0, data)
			if is_enabled then
				Result := True
				grab_mouse
				unset_flags (Flag_update)
				if message_target = Void 
				or else not message_target.handle_2 (Current, Sel_rightbuttonpress, message, data)
				then
					flags := flags | Flag_scrolling
					grab_x := event.win_x - pos_x
					grab_y := event.win_y - pos_y
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

   on_query_tip (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         x,y: INTEGER
         cp: SB_CURSOR_POSITION
         i: G
      do
         if (flags & Flag_tip) /= 0 and then (options & TREELIST_AUTOSELECT) = 0 then
            	-- No tip when autoselect!
            cp := get_cursor_position
            if cp /= Void then
               i := get_item_at (cp.x, cp.y)
            end
            if i /= Void then
               sender.do_handle_2 (Current, SEL_COMMAND, Id_setstringvalue, i.label)
               Result := True
            end
         end
      end

   on_tip_timer (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         timer := Void
         flags := flags | Flag_tip
         Result := True
      end

   on_focus_in (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         Result := Precursor (sender, selector, data)
         if current_item /= Void then
            current_item.set_focus (True)
            update_item(current_item)
         end
         Result := True
      end

   on_focus_out (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         Result := Precursor (sender, selector, data)
         if current_item /= Void then
            current_item.set_focus (False)
            update_item(current_item)
         end
         Result := True
      end

   on_auto_scroll (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         event: SB_EVENT
         i: G
         xx,yy: INTEGER
      do
         event ?= data check event /= Void end	-- TODO this may be Void in the case of a Timer call ....
         Result := Precursor (sender, selector, data)

         	-- Drag and drop mode
         if (flags & Flag_dodrag) /= 0 then
            do_handle_2 (Current, SEL_DRAGGED, 0, data)
            Result := True
         elseif event /= Void and then ((flags & Flag_pressed) /= 0 or else (options & TREELIST_AUTOSELECT) /= 0) then
            	-- In autoselect mode, stop scrolling when mouse outside window
            	-- Validated position
            xx := event.win_x; if xx < 0 then xx := 0 elseif xx >= viewport_w then xx := viewport_w - 1 end
            yy := event.win_y; if yy < 0 then yy := 0 elseif yy >= viewport_h then yy := viewport_h - 1 end

            	-- Find i
            i := get_item_at (xx, yy)
            	-- Got i and different from last time
            if i /= Void and then i /= current_item then
               	-- Make it the current_item i
               set_current_item (i, True)
               	-- Extend the selection
               if (options & SELECT_MASK) = TREELIST_EXTENDEDSELECT then
                  state := False
                  do_extend_selection (i, True)
               end
            end
            Result := True
         end
      end

	on_double_clicked (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
    		-- Double click anywhere in the widget
    	local
    		i: G
      	do
         	if message_target /= Void
            	and then message_target.handle_2 (Current, SEL_DOUBLECLICKED, message, data)
          	then
            	Result := True
         	else
            	-- Double click on an item
            	if data /= Void then
               		i ?= data
               		check
                  		i /= Void
               		end
               		if i.is_expanded then
                  		do_collapse_tree (i, True)
               		else
                  		do_expand_tree (i, True)
               		end
            	end
         	end
      	end

   on_lookup_timer (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         create lookup_string.make_empty
         lookup_timer := Void
         Result := True
      end

feature -- Resource management

   create_resource
         -- Create server-side resources
      local
         i: G
      do
         Precursor
         from
            i := first_item
         until
            i = Void
         loop
            i.create_resource
            if i.first_child /= Void then
               i := i.first_child
            else
               from
               until
                  i.next /= Void or else i.parent = Void
               loop
                  i := i.parent
               end
               i := i.next
            end
         end
         font.create_resource
      end

   detach_resource
         -- Detach server-side resources
      local
         i: G
      do
         Precursor
         from
            i := first_item
         until
            i = Void
         loop
            i.detach_resource
            if i.first_child /= Void then
               i := i.first_child
            else
               from
               until
                  i.next /= Void or else i.parent = Void
               loop
                  i := i.parent
               end
               i := i.next
            end
         end
         font.detach_resource
      end

feature {NONE} -- Implementation

   tree_width : INTEGER		-- Tree width
   tree_height: INTEGER		-- Tree height
   
   grab_x: INTEGER			-- Grab point x
   grab_y: INTEGER			-- Grab point y
   
   lookup_string: STRING	-- Lookup string
   
   timer: SB_TIMER			-- Tip timer
   lookup_timer: SB_TIMER	-- Lookup timer
   
   state: BOOLEAN         	-- State of i

   do_hop (event: SB_EVENT; i: G)
      do
         create lookup_string.make_empty
         if i /= Void then
            set_current_item (i, True)
            make_item_visible (i)
            if (options & SELECT_MASK) = TREELIST_EXTENDEDSELECT then
               if i.is_enabled then
                  if (event.state & SHIFTMASK) /= 0 then
                     if anchor_item /= Void then
                        do_select_item (anchor_item, True)
                        do_extend_selection (i, True)
                     else
                        do_select_item (i, True)
                        set_anchor_item (i)
                     end
                  elseif (event.state & CONTROLMASK) = 0 then
                     do_kill_selection (True)
                     do_select_item (i, True)
                     set_anchor_item (i)
                  end
               end
            end
         end
         do_handle_2 (Current, SEL_CLICKED, 0, current_item)
         if current_item /= Void and then current_item.is_enabled then
            do_handle_2 (Current, SEL_COMMAND, 0, current_item)
         end
      end

   layout
      do
         	-- Calculate contents
         Precursor
         	-- Set line size based on i size
         if first_item /= Void then
            v_scroll_bar.set_line_size (first_item.height (Current))
            h_scroll_bar.set_line_size (first_item.width (Current) // 10)
         end
         	-- Force repaint
         update
         	-- No more dirty
         unset_flags (Flag_dirty)
      end

	create_item (text: STRING; oi, ci: SB_ICON; data: ANY): G
		deferred
		end

	recompute
    	local
         	i: G;
         	x,y,w,h: INTEGER
      	do
         	tree_width := 0
         	tree_height := 0
         	if (options & Treelist_root_boxes) /= 0 then x := x + (4+indent) end
         	from
            	i := first_item
         	until
            	i = Void
         	loop
            	i.set_x (x)
            	i.set_y (y)
            	w := i.width (Current)
            	h := i.height (Current)
            	if x+w > tree_width then tree_width := x+w end
            	y := y + h
            	if i.first_child /= Void
               	and then ((options & TREELIST_AUTOSELECT) /= 0 or else i.is_expanded)
             	then
               		x := x + (indent + h // 2)
               		i := i.first_child
            	else
               		from
               		until
                  		i.next /= Void or else i.parent = Void
               		loop
                  		i := i.parent
                  		x := x - (indent + i.height (Current) // 2)
               		end
               		i := i.next
            	end
         	end
         	tree_height := y
         	unset_flags (Flag_recalc)
--# DEBUG
--			if tree_width > 32767 or tree_width < -32767 then
--				print(once "SB_GENERIC_TREE_LIST::recompute - tree_width out of spec: ")
--				print(tree_width.out)
--				print(once "%N")
--			end
--			if tree_height > 32767 or tree_height < -32767 then
--				print(once "SB_GENERIC_TREE_LIST::recompute - tree_height out of spec: ")
--				print(tree_height.out)
--				print(once "%N")
--			end
--# DEBUG
      	end

	Icon_spacing  : INTEGER is 4         -- Spacing between icon and label
	Side_spacing  : INTEGER is 6         -- Left or right spacing between items
	Line_spacing  : INTEGER is 4         -- Line spacing between items
	Default_indent: INTEGER is 8         -- Indent between parent and child
   
   	SELECT_MASK: INTEGER is once Result := Treelist_singleselect | Treelist_browseselect end
   
   	Treelist_mask: INTEGER
      	once
         	Result := Select_mask | Treelist_autoselect
            	| Treelist_shows_lines | Treelist_shows_boxes | Treelist_root_boxes
      	end

   	compare: SB_STRING_COMPARATOR
      	once
			create { SB_NOCASE_STRING_COMPARATOR } Result;
      	end

	comparecase: SB_STRING_COMPARATOR
    	once
        	create { SB_CASE_STRING_COMPARATOR } Result;
      	end

end
