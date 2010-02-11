indexing
	description:"Generic Icon List Widget"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

	bugs: "[
		Inheritance problems, type of ITEM_TYPE
	
		on_auto_scroll -- called from SB_APPLICATION::process_timers with Void data,
		and retrieved by routine as assumed non-Void event
	]"

deferred class SB_GENERIC_ICON_LIST [ reference G -> SB_ICON_LIST_ITEM ]

inherit

	SB_BASE_LIST [ G ]
    	rename
        	Id_last as BASE_LIST_ID_LAST,
        	make as scroll_area_make,
        	make_opts as scroll_area_make_opts
      	redefine
         	content_height,
         	content_width,
         	viewport_height,
         	can_focus,
         	move_contents,
         	resize,
         	position,
         	handle_2,
         	on_paint,
         	on_key_press,
         	on_key_release,
         	on_left_btn_press,
         	on_left_btn_release,
         	on_right_btn_press,
         	on_right_btn_release,
         	on_motion,
         	on_auto_scroll,
         	create_resource,
         	detach_resource,
         	layout,
         	destruct,
         	class_name
		end


	SB_ICON_LIST_CONSTANTS

	SB_ICON_LIST_COMMANDS

	SB_HEADER_CONSTANTS

	SB_EXPANDED

feature -- class name

	class_name: STRING is
		once
			Result := "SB_ICON_LIST"
		end

feature -- Creation

	make(p: SB_COMPOSITE; opts: INTEGER) is
			-- Construct icon list
		local
			o: INTEGER
		do
			if opts = Zero then
				o := ICONLIST_NORMAL
			else
				o := opts
			end
			make_opts(p, Void, 0, o, 0,0,0,0)
		end

	make_opts(p: SB_COMPOSITE; tgt: SB_MESSAGE_HANDLER; selector: INTEGER; opts: INTEGER; x,y,w,h: INTEGER) is
		do
			scroll_area_make_opts(p, opts, x,y, w,h)
			set_flags (Flag_enabled);

			create header.make(Current, Current, ID_HEADER_CHANGE,
				HEADER_TRACKING | 
				HEADER_BUTTON | Frame_raised | Frame_thick)

			message_target := tgt
         	message := selector
         	create items.make (1, 0)
         
         	rows_count := 1
         	columns_count := 1
         
         	font := application.normal_font
         
         	text_color		:= application.fore_color
         	sel_back_color := application.sel_back_color
         	sel_text_color := application.sel_fore_color
         
         	item_space := ITEM_SPACE_
         
         	item_width := 1
         	item_height := 1
         
         	create help_text.make_empty
         	create lookup_string.make_empty
         	--sortfunc := Void
      	end

feature -- Data

	header: SB_HEADER		-- Header control
   
   	rows_count: INTEGER		-- Number of rows
   	columns_count: INTEGER	-- Number of columns
   
   	item_width: INTEGER		-- Item width
   	item_height: INTEGER	-- Item height
   
   	item_space: INTEGER		-- Space for item label
   
   	anchor_x: INTEGER		-- Rectangular selection
   	anchor_y: INTEGER
   
   	current_x: INTEGER
   	current_y: INTEGER
   
   	grab_x: INTEGER			-- Grab point x
   	grab_y: INTEGER			-- Grab point y
   
   	state: BOOLEAN			-- State of item

feature -- Queries

   	content_width: INTEGER is
    		--  Return content width
      	do
         	if (flags & Flag_recalc) /= Zero then
            	recompute
         	end
         	if (options & (ICONLIST_MINI_ICONS | ICONLIST_BIG_ICONS)) /= Zero then
            	Result := columns_count * item_space
         	else
            	Result := header.default_width
         	end
      	end

   	content_height: INTEGER is
         	-- Return content height
      	do
         	if (flags & Flag_recalc) /= Zero then
            	recompute
         	end
         	Result := rows_count * item_height
      	end

   	can_focus: BOOLEAN is
         	-- Icon list can receive focus
      	once
         	Result := True
      	end

   	viewport_height: INTEGER is
         	-- Return viewport size
      	do
         	if (options & (ICONLIST_MINI_ICONS | ICONLIST_BIG_ICONS)) /= Zero then
            	Result := height
         	else
            	Result := height - header.default_height
         	end
      	end

   	ascending(a, b: SB_ICON_LIST_ITEM): INTEGER is
         	-- Compare items in ascending order
      	local
         	s1,s2: STRING
         	i,e1,e2: INTEGER
         	done: BOOLEAN
      	do
         	s1 := a.label
         	s2 := b.label;        
         	from
            	i := 1
            	e1 := s1.count
            	e2 := s2.count
         	until
            	(i > s1.count and then i > s2.count) or else done
         	loop
            	if i > s1.count then
               		Result := -1
               		done := True
            	elseif i > s2.count then
               		Result := 1
               		done := True
            	elseif s1.item(i).code > s2.item(i).code then
               		Result := 1
               		done := True
            	elseif s1.item(i).code < s2.item(i).code then
               		Result := -1
               		done := True
            	elseif s1.item(i) = '%T' then
               		done := True
            	else
               		i := i+1
            	end
         	end
      	end

   	descending(a, b: SB_ICON_LIST_ITEM): INTEGER is
      	do
         	Result := ascending(b, a)
      	end

   	get_list_style: INTEGER is
         	-- Get the current icon list style
      	do
         	Result := (options & ICONLIST_MASK)
      	end

feature -- Header queries

	headers_count: INTEGER is
    		-- Return number of headers
    	do
        	Result := header.items_count
      	end

	header_text(index: INTEGER): STRING is
    		-- Return text of header at index
    	require
        	index > 0 and then index <= headers_count
      	do
         	Result := header.item(index).label
      	end

	header_icon(index: INTEGER): SB_ICON is
    		-- Return icon of header at index
    	require
        	index > 0 and then index <= headers_count
      	do
         	Result := header.item(index).icon
      	end

	header_size(index: INTEGER): INTEGER is
    		-- Return width of header at index
    	require
        	index > 0 and then index <= headers_count
      	do
         	Result := header.item(index).size
      	end

feature -- Item access

	item_at(x_, y_: INTEGER): INTEGER is
    		-- Return index of item at x,y, or 0 if none
    	local
        	x,y, ix,iy, r,c,index: INTEGER
      	do
         	y := y_ - pos_y
         	x := x_ - pos_x
         	if (options & (ICONLIST_BIG_ICONS | ICONLIST_MINI_ICONS)) /= Zero then
            	c := x // item_space
            	r := y // item_height
            	if(c >= 0 and then c < columns_count and then r >= 0 and then r < rows_count) then
               		if (options & ICONLIST_COLUMNS) /= Zero then
                  		index := columns_count * r + c + 1
               		else 
                  		index := rows_count * c + r + 1
               		end
               		if (index > 0 and then index <= items_count) then
                  		ix := item_space * c
                  		iy := item_height * r
                  		if items.item(index).item_hit(Current, x - ix, y - iy, 1, 1) /= 0 then
                     		Result := index
                  		end
               		end
            	end
         	else
            	y := y - header.default_height
            	index := y // item_height
            	if(index >= 0 and then index < items_count) then
               		Result := index + 1
            	end
         	end
      	end

   item_big_icon(index: INTEGER): SB_ICON is
         -- Return big icon of item at index
      require
         index > 0 and then index <= items_count
      do
         Result := items.item(index).big_icon
      end

   is_item_visible(index: INTEGER): BOOLEAN is
         -- Return True if item at index is (partially) visible
      require
         index > 0 and then index <= items_count
      local
         x,y,hh: INTEGER;
      do
         if (options & (ICONLIST_BIG_ICONS | ICONLIST_MINI_ICONS)) /= Zero then
            if (options & ICONLIST_COLUMNS) /= Zero then
               check
                  columns_count > 0
               end
               x := pos_x + item_space  * ((index - 1) \\ columns_count)
               y := pos_y + item_height * ((index - 1) // columns_count)
            else
               check
                  rows_count > 0
               end
               x := pos_x + item_space  * ((index - 1) // rows_count)
               y := pos_y + item_height * ((index - 1) \\ rows_count)
            end
            if 0 < x + item_space and then x < viewport_w 
               and then 0 < y + item_height and then y < viewport_h then
               Result := True
            end
         else
            hh := header.default_height
            y := pos_y + hh + index * item_height
            if hh < y + item_height and then y < viewport_h then
               Result := True
            end
         end
      end

   item_hit(index, x_, y_, ww, hh: INTEGER): INTEGER is
         -- Return item hit code: 0 outside, 1 icon, 2 text
      require
         index > 0 and then index <= items_count
      local
         ix,iy,w,h,r,c,x,y: INTEGER
      do
         x := x_ - pos_x
         y := y_ - pos_y
         if (options & (ICONLIST_BIG_ICONS | ICONLIST_MINI_ICONS)) = Zero then
            y := y - header.default_height
         end
         w := items.item(index).width(Current)
         h := items.item(index).height(Current)
         if (options & (ICONLIST_BIG_ICONS | ICONLIST_MINI_ICONS)) /= Zero then
            if (options & ICONLIST_COLUMNS) /= Zero then
               r := (index - 1) // columns_count
               c := (index - 1) \\ columns_count
            else
               c := (index - 1) // rows_count
               r := (index - 1) \\ rows_count
            end
         else
            r := index - 1
            c := 0
         end
         ix := item_space * c
         iy := item_height * r
         Result := items.item(index).item_hit(Current, x - ix, y - iy, ww, hh)
      end

feature -- Actions

   move_contents(x,y: INTEGER) is
         -- Move contents to the specified position
      local
         dx,dy,top: INTEGER;
      do
         dx := x - pos_x
         dy := y - pos_y
         pos_x := x
         pos_y := y
         if (options & (ICONLIST_MINI_ICONS | ICONLIST_BIG_ICONS)) = Zero then
            top := header.default_height
            header.move(x,0)
         end
         scroll(0, top, viewport_w, viewport_h, dx, dy)
      end

   resize(w,h: INTEGER) is
         -- Resize this window to the specified width and height
      local
         nr,nc: INTEGER
         sbp: SB_POINT
      do
         nr := rows_count
         nc := columns_count
         if w /= width or else h /= height then
            sbp := getrowscols(w,h)
            rows_count := sbp.x
            columns_count := sbp.y
            if nr /= rows_count or else nc /= columns_count then
               update
            end
         end
         Precursor(w,h)
      end

   position(x,y,w,h: INTEGER) is
         -- Move and resize this window in the parent's coordinates
      local
         nr,nc: INTEGER
         sbp: SB_POINT
      do
         -- Changed size and/or pos:- this is a bit tricky, because
         -- we don't want to re-measure the items, but the content
         -- size has changed because the number of rows/columns has...
         nr := rows_count
         nc := columns_count
         if(w /= width or else h /= height) then
            sbp := getrowscols(w,h)
            rows_count := sbp.x
            columns_count := sbp.y
            if nr /= rows_count or else nc /= columns_count then
               update;
            end
         end
         Precursor(x,y,w,h)
      end

   set_item_space(s_: INTEGER) is
         -- Change maximum item space for each item
      local
         s: INTEGER
      do
         if s < 1 then s := 1 end
         if item_space /= s then
            item_space := s
            recalc
         end
      end

   set_list_style (style: INTEGER) is
         -- Set the current icon list style.
      local
         opts: INTEGER
      do
         opts := (options & (ICONLIST_MASK).bit_not) | (style & ICONLIST_MASK)
         if options /= opts then
            options := opts
            recalc
         end
      end

feature -- Header actions

   append_header (text: STRING; icon: SB_ICON; size: INTEGER) is
         -- Append header with given text and optional icon
      do
         header.append_new_item (text, icon, size, Void, False)
      end

   remove_header(index: INTEGER) is
         -- Remove header at index
      require
         index > 0 and then index <= headers_count
      do
         header.remove_item (index)
      end

   set_header_text (index: INTEGER; txt: STRING) is
         -- Change text of header at index
      require
         index > 0 and then index <= headers_count
      do
         header.set_item_text (index, txt)
      end

   set_header_icon (index: INTEGER; icon: SB_ICON) is
         -- Change icon of header at index
      require
         index > 0 and then index <= headers_count
      do
         header.set_item_icon (index, icon)
      end

   set_header_size (index, size: INTEGER) is
         -- Change size of header at index
      require
         index > 0 and then index <= headers_count
      do
         header.set_item_size (index, size)
      end

feature -- Item actions

   replace_item_with_new (index: INTEGER; txt: STRING;big,mini: SB_ICON; 
                         data: ANY; notify: BOOLEAN) is
         -- Replace items text, icons, and user-data pointer
      require
         index > 0 and then index <= items_count
      do
         replace_item(index, create_item(txt, big, mini, data), notify)
      end

   insert_new_item (index: INTEGER; txt: STRING; big,mini: SB_ICON;
                   data: ANY; notify: BOOLEAN) is
         -- Insert item at index with given text, icons, and user-data 
         -- pointer
      require
         index > 0 and then index <= items_count+1
      do
         insert_item (index, create_item (txt, big, mini, data), notify);
      end

   append_new_item(txt: STRING; big,mini: SB_ICON; data: ANY; notify: BOOLEAN) is
         -- Append new item with given text and optional icons, and user-data 
         -- pointer
      do
         insert_item (items_count+1, create_item (txt, big, mini, data), notify);
      end

   prepend_new_item (txt: STRING; big,mini: SB_ICON; data: ANY; notify: BOOLEAN) is
         -- Prepend new item with given text and optional icons, and user-data 
         -- pointer
      do
         insert_item (1, create_item (txt, big, mini, data), notify)
      end

   make_item_visible(index: INTEGER) is
         -- Scroll to make item at index visible
      local
         x,y,hh,px,py: INTEGER;
      do
         if is_attached then
            -- FIXME maybe force layout first???
            if 0 < index and then index <= items_count then
               px := pos_x
               py := pos_y
               if (options & (ICONLIST_BIG_ICONS | ICONLIST_MINI_ICONS)) /= Zero then
                  if (options & ICONLIST_COLUMNS) /= Zero then
                     check columns_count > 0 end
                     x := item_space  * ((index - 1) \\ columns_count);
                     y := item_height * ((index - 1) // columns_count);
                  else
                     check rows_count > 0 end
                     x := item_space  * ((index - 1) // rows_count)
                     y := item_height * ((index - 1) \\ rows_count)
                  end
                  if px+x+item_space  >=  viewport_w then px := viewport_w-x-item_space end
                  if px+x  <=  0 then px := -x end
                  if py+y+item_height  >=  viewport_h then py := viewport_h-y-item_height end
                  if py+y  <=  0 then py := -y end
               else
                  hh := header.default_height
                  y := hh + (index - 1) * item_height
                  if py + y + item_height  >=  viewport_h + hh then py := hh + viewport_h - y - item_height end
                  if py + y  <=  hh then py := hh-y end
               end
               set_scroll_position (px, py)
            end
         end
      end

   set_item_big_icon (index: INTEGER; icon: SB_ICON) is
         -- Change item big icon
      require
         index > 0 and then index <= items_count
      do
         items.item(index).set_big_icon(icon)
         recalc
      end

   update_item (index: INTEGER) is
         -- Repaint item at index
      do
         if is_attached and then 0 < index and then index <= items_count then
            if (options & (ICONLIST_BIG_ICONS | ICONLIST_MINI_ICONS)) /= Zero then
               if (options & ICONLIST_COLUMNS) /= Zero then
                  check columns_count > 0 end
                  update_rectangle(pos_x + item_space  * ((index - 1) \\ columns_count),
                                   pos_y + item_height * ((index - 1) // columns_count), item_space, item_height);
               else
                  check rows_count > 0 end
                  update_rectangle(pos_x + item_space  * ((index - 1) // rows_count),
                                   pos_y + item_height * ((index - 1) \\ rows_count), item_space, item_height);
               end
            else
               update_rectangle(pos_x, pos_y + header.default_height + (index - 1) * item_height, content_w, item_height);
            end
         end
      end

   select_in_rectangle(x,y,w,h: INTEGER; notify: BOOLEAN) is
         -- Select items in rectangle
      local
         r,c,index: INTEGER;
         changed: BOOLEAN;
      do
         if (options & (ICONLIST_BIG_ICONS | ICONLIST_MINI_ICONS)) /= Zero then
            from
               r := 0;
            until
               r >= rows_count
            loop
               from
                  c := 0
               until
                  c >= columns_count
               loop
                  if (options & ICONLIST_COLUMNS) /= Zero then
                     index := columns_count*r+c+1
                  else
                     index := rows_count*c+r+1;
                  end
                  if index <= items_count then
                     if item_hit(index,x,y,w,h) /= 0 then
                        changed := changed or select_item(index,notify);
                     end
                  end
                  c := c+1;
               end
               r := r+1;
            end
         else
            from
               index := 1
            until
               index > items_count
            loop
               if item_hit(index,x,y,w,h) /= 0 then
                  changed := changed or select_item(index,notify);
               end
               index := index+1;
            end
         end
         --Result := changed;
      end

feature -- Message processing

	handle_2 (sender: SB_MESSAGE_HANDLER; type, key: INTEGER; data: ANY): BOOLEAN is
    	do
        	if		match_function_2 (SEL_PAINT,				0,					type, key) then Result := on_paint						(sender, key, data);
        	elseif  match_function_2 (SEL_MOTION,				0,					type, key) then Result := on_motion						(sender, key, data);
        	elseif  match_function_2 (SEL_LEFTBUTTONPRESS,		0,					type, key) then Result := on_left_btn_press				(sender, key, data);
        	elseif  match_function_2 (SEL_LEFTBUTTONRELEASE,	0,					type, key) then Result := on_left_btn_release			(sender, key, data);
        	elseif  match_function_2 (Sel_rightbuttonpress,		0,					type, key) then Result := on_right_btn_press 			(sender, key, data);
        	elseif  match_function_2 (Sel_rightbuttonrelease,	0,					type, key) then Result := on_right_btn_release			(sender, key, data);
        	elseif  match_function_2 (Sel_timeout,				Id_autoscroll,		type, key) then Result := on_auto_scroll				(sender, key, data);
        	elseif  match_function_2 (Sel_timeout,				ID_TIPTIMER,		type, key) then Result := on_tip_timer					(sender, key, data);
        	elseif  match_function_2 (Sel_timeout,				ID_LOOKUPTIMER,		type, key) then Result := on_lookup_timer				(sender, key, data);
        	elseif  match_function_2 (SEL_UNGRABBED,			0,					type, key) then Result := on_ungrabbed					(sender, key, data);
        	elseif  match_function_2 (SEL_KEYPRESS,				0,					type, key) then Result := on_key_press					(sender, key, data);
        	elseif  match_function_2 (SEL_KEYRELEASE,			0,					type, key) then Result := on_key_release				(sender, key, data);
        	elseif  match_function_2 (SEL_ENTER,				0,					type, key) then Result := on_enter						(sender, key, data);
        	elseif  match_function_2 (SEL_LEAVE,				0,					type, key) then Result := on_leave						(sender, key, data);
        	elseif  match_function_2 (SEL_FOCUSIN,				0,					type, key) then Result := on_focus_in					(sender, key, data);
         	elseif  match_function_2 (SEL_FOCUSOUT,				0,					type, key) then Result := on_focus_out					(sender, key, data);
         	elseif  match_function_2 (SEL_CLICKED,				0,					type, key) then Result := on_clicked					(sender, key, data);
         	elseif  match_function_2 (SEL_DOUBLECLICKED,		0,					type, key) then Result := on_double_clicked				(sender, key, data);
         	elseif  match_function_2 (SEL_TRIPLECLICKED,		0,					type, key) then Result := on_triple_clicked				(sender, key, data);
         	elseif  match_function_2 (SEL_COMMAND,				0,					type, key) then Result := on_command					(sender, key, data);
         	elseif  match_function_2 (SEL_CHANGED,				ID_HEADER_CHANGE,	type, key) then Result := on_header_changed				(sender, key, data);
         	elseif  match_function_2 (SEL_CLICKED,				ID_HEADER_CHANGE,	type, key) then Result := on_header_resize				(sender, key, data);
         	elseif  match_function_2 (SEL_UPDATE,				ID_SHOW_DETAILS,	type, key) then Result := on_upd_show_details			(sender, key, data);
         	elseif  match_function_2 (SEL_UPDATE,				ID_SHOW_MINI_ICONS,	type, key) then Result := on_upd_show_mini_icons 		(sender, key, data);
         	elseif  match_function_2 (SEL_UPDATE,				ID_SHOW_BIG_ICONS,	type, key) then Result := on_upd_show_big_icons			(sender, key, data);
         	elseif  match_function_2 (SEL_UPDATE,				ID_ARRANGE_BY_ROWS,	type, key) then Result := on_upd_arrange_by_rows 		(sender, key, data);
        	elseif  match_function_2 (SEL_UPDATE,				ID_ARRANGE_BY_COLUMNS,type, key) then Result := on_upd_arrange_by_columns	(sender, key, data);
         	elseif  match_function_2 (SEL_UPDATE,				Id_query_tip,		type, key) then Result := on_query_tip					(sender, key, data);
         	elseif  match_function_2 (SEL_UPDATE,				Id_query_help,		type, key) then Result := on_query_help					(sender, key, data);
         	elseif  match_function_2 (SEL_COMMAND,				ID_SHOW_DETAILS,	type, key) then Result := on_cmd_show_details			(sender, key, data);
         	elseif  match_function_2 (SEL_COMMAND,				ID_SHOW_MINI_ICONS,	type, key) then Result := on_cmd_show_mini_icons		(sender, key, data);
         	elseif  match_function_2 (SEL_COMMAND,				ID_SHOW_BIG_ICONS,	type, key) then Result := on_cmd_show_big_icons			(sender, key, data);
         	elseif  match_function_2 (SEL_COMMAND,				ID_ARRANGE_BY_ROWS,	type, key) then Result := on_cmd_arrange_by_rows 		(sender, key, data);
         	elseif  match_function_2 (SEL_COMMAND,				ID_ARRANGE_BY_COLUMNS,type, key) then Result := on_cmd_arrange_by_columns	(sender, key, data);
         	elseif  match_function_2 (SEL_COMMAND,				ID_SELECT_ALL,		type, key) then Result := on_cmd_select_all				(sender, key, data);
         	elseif  match_function_2 (SEL_COMMAND,				ID_DESELECT_ALL,	type, key) then Result := on_cmd_deselect_all			(sender, key, data);
         	elseif  match_function_2 (SEL_COMMAND,				ID_SELECT_INVERSE,	type, key) then Result := on_cmd_select_inverse			(sender, key, data);
         	elseif  match_function_2 (SEL_COMMAND,				Id_setvalue,		type, key) then Result := on_cmd_set_value				(sender, key, data);
         	elseif  match_function_2 (SEL_COMMAND,				Id_setintvalue,		type, key) then Result := on_cmd_set_int_value			(sender, key, data);
         	elseif  match_function_2 (SEL_COMMAND,				Id_getintvalue,		type, key) then Result := on_cmd_get_int_value			(sender, key, data);
         	else Result := Precursor (sender, type, key, data)
         	end
      end

   on_paint (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      local
         rlo,rhi,clo,chi,yy,xx: INTEGER;
         x,y,r,c,index: INTEGER;
         event: SB_EVENT;
         dc: SB_DC_WINDOW;
      do
         event ?= data check event /= Void end
         dc := paint_dc
         dc.make_event (Current, event)
         dc.set_font (font)

         if (options & (ICONLIST_BIG_ICONS | ICONLIST_MINI_ICONS)) /= Zero then
            -- Icon mode

            -- Exposed rows
            rlo := (event.rect_y - pos_y) // item_height
            rhi := (event.rect_y + event.rect_h - pos_y) // item_height
            if rlo < 0 then rlo := 0 end
            if rhi >= rows_count then rhi := rows_count-1 end

            -- Exposed columns
            clo := (event.rect_x - pos_x) // item_space
            chi := (event.rect_x + event.rect_w - pos_x) // item_space
            if clo<0 then clo := 0 end
            if chi >= columns_count then chi := columns_count-1 end

            if (options & ICONLIST_BIG_ICONS) /= Zero then
               -- Big Icons
               from
                  r := rlo
               until
                  r > rhi
               loop
                  y := pos_y + r * item_height
                  from
                     c := clo
                  until
                     c > chi
                  loop
                     x := pos_x + c * item_space
                     if (options & ICONLIST_COLUMNS) /= Zero then
                        index := columns_count * r + c + 1
                     else
                        index := rows_count * c + r + 1
                     end
                     dc.set_foreground (back_color)
                     dc.fill_rectangle (x, y, item_space, item_height)
                     if index <= items_count then
                        items.item (index).draw (Current, dc, x, y, item_space, item_height)
                     end
                     c := c + 1
                  end
                  r := r + 1
               end
            else
               		-- Mini icons
               from
                  r := rlo
               until
                  r > rhi
               loop
                  y := pos_y + r * item_height
                  from
                     c := clo
                  until
                     c > chi
                  loop
                     x := pos_x + c * item_space
                     if (options & ICONLIST_COLUMNS) /= Zero then 
                        index := columns_count * r + c + 1
                     else
                        index := rows_count * c + r + 1
                     end
                     dc.set_foreground (back_color);
                     dc.fill_rectangle (x, y, item_space, item_height)
                     if index <= items_count then
                        items.item (index).draw (Current, dc, x, y, item_space, item_height)
                     end
                     c := c + 1
                  end
                  r := r + 1
               end
            end
            -- Repaint left-over background
            yy := (rhi + 1) * item_height
            if yy < event.rect_y + event.rect_h then
               dc.set_foreground (back_color)
               dc.fill_rectangle (event.rect_x, yy, event.rect_w, event.rect_y + event.rect_h - yy)
            end
            xx := (chi + 1) * item_space
            if xx < event.rect_x + event.rect_w then
               dc.set_foreground (back_color)
               dc.fill_rectangle (xx, event.rect_y, event.rect_x + event.rect_w - xx, event.rect_h)
            end
         else
            -- Detail mode

            -- Exposed rows
            rlo := (event.rect_y - pos_y - header.default_height) // item_height
            rhi := (event.rect_y + event.rect_h - pos_y - header.default_height) // item_height
            if rlo < 0 then rlo := 0 end
            if rhi >= items_count then rhi := items_count - 1 end

            	-- Repaint the items
            y := pos_y + rlo * item_height + header.default_height
            from
               index := rlo
            until
               index > rhi
            loop
               dc.set_foreground (back_color)
               dc.fill_rectangle (pos_x, y, content_w, item_height)
               items.item (index + 1).draw (Current, dc, pos_x, y, content_w, item_height)
               index := index + 1; y := y + item_height
            end

            -- Repaint left-over background
            if y < event.rect_y + event.rect_h then
               dc.set_foreground (back_color)
               dc.fill_rectangle (event.rect_x, y, event.rect_w, event.rect_y + event.rect_h - y)
            end
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
         event ?= data check event /= Void end
         index := current_item;
         unset_flags (Flag_tip)
         if is_enabled then
            Result := True;
            if message_target = Void
               or else not message_target.handle_2 (Current, SEL_KEYPRESS, message, data)
             then
               if index < 1 then index := 1 end
               inspect event.code
               when key_control_l, key_control_r, key_shift_l, key_shift_r, key_alt_l,key_alt_r then
                  if (flags & Flag_dodrag) /= Zero then do_handle_2 (Current, SEL_DRAGGED, 0, data) end
               when key_page_up, key_kp_page_up then
                  create lookup_string.make_empty
                  set_scroll_position(pos_x, pos_y + v_scroll_bar.page_size)
               when key_page_down, key_kp_page_down then
                  create lookup_string.make_empty;
                  set_scroll_position(pos_x, pos_y - v_scroll_bar.page_size)
               when key_right, key_kp_right then
                  if (options & (ICONLIST_BIG_ICONS | ICONLIST_MINI_ICONS)) = Zero then
                     set_scroll_position(pos_x - 10, pos_y)
                  else
                     if (options & ICONLIST_COLUMNS) /= Zero then index := index + 1 else index := index + rows_count end
                     do_hop(event, index)
                  end
               when key_left, key_kp_left then
                  if (options & (ICONLIST_BIG_ICONS | ICONLIST_MINI_ICONS)) = Zero then
                     set_scroll_position(pos_x + 10, pos_y)
                  else
                     if (options & ICONLIST_COLUMNS) /= Zero then index:= index - 1 else index := index - rows_count end
                     do_hop(event, index);
                  end
               when key_up, key_kp_up then
                  if (options & ICONLIST_COLUMNS) /= Zero then index:= index - columns_count else index := index-1 end
                  do_hop(event,index);
               when key_down, key_kp_down then
                  if (options & ICONLIST_COLUMNS) /= Zero then index := index + columns_count else index := index+1 end
                  do_hop (event, index);

               when key_home,key_kp_home then
                  index := 1
                  do_hop (event, index);
               when key_end, key_kp_end then
                  index := items_count
                  do_hop (event, index)
               when key_space,key_kp_space then
                  create lookup_string.make_empty;
                  if 1 <= current_item and then items.item(current_item).is_enabled then
                     t := options & SELECT_MASK;
                     if t = ICONLIST_EXTENDEDSELECT then
                        if (event.state & SHIFTMASK) /= Zero then
                           if 1 <= anchor_item then
                              do_select_item (anchor_item, True)
                              do_extend_selection (current_item, True);
                           else
                              do_select_item (current_item, True)
                           end
                        elseif (event.state & CONTROLMASK) /= Zero then
                           do_toggle_item (current_item, True)
                        else
                           do_kill_selection (True)
                           do_select_item (current_item, True)
                        end
                     elseif t = ICONLIST_MULTIPLESELECT or else t = ICONLIST_SINGLESELECT then
                        do_toggle_item (current_item, True)
                     end
                     set_anchor_item(current_item);
                  end
                  do_handle_2 (Current, SEL_CLICKED, 0, ref_integer(current_item));
                  if 1 <= current_item and then items.item(current_item).is_enabled then
                     do_handle_2 (Current, SEL_COMMAND, 0, ref_integer(current_item));
                  end
               when key_return, key_kp_enter then
                  create lookup_string.make_empty;
                  do_handle_2 (Current, SEL_DOUBLECLICKED, 0, ref_integer(current_item));
                  if 1 <= current_item and then items.item(current_item).is_enabled then
                     do_handle_2 (Current, SEL_COMMAND, 0, ref_integer(current_item))
                  end
               else
                  if (event.state & (CONTROLMASK | ALTMASK)) /= Zero
                     or else event.text.is_empty or else event.text.item(1).code < 32
                   then
                     Result := False;
                  else
                     lookup_string.append_string(event.text)
                     if lookup_timer /= Void then application.remove_timeout(lookup_timer) end
                     lookup_timer := application.add_timeout(application.typing_speed, Current, ID_LOOKUPTIMER);
                     index := find_item_by_name_opts(lookup_string, current_item, SEARCH_FORWARD | SEARCH_WRAP | SEARCH_PREFIX)
                     if 1 <= index then
                        set_current_item (index, True)
                        make_item_visible (index)
                        if (options & SELECT_MASK) = ICONLIST_EXTENDEDSELECT then
                           if items.item(index).is_enabled then
                              do_kill_selection (True)
                              do_select_item (index, True)
                           end
                        end
                        set_anchor_item(index);
                     end
                     do_handle_2 (Current, SEL_CLICKED, 0, ref_integer (current_item))
                     if 1 <= current_item and then items.item(current_item).is_enabled then
                        do_handle_2 (Current, SEL_COMMAND, 0, ref_integer (current_item))
                     end
                  end
               end
            end
         end
      end

   on_key_release (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      local
         event: SB_EVENT
      do
         event ?= data check event /= Void end
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
                     do_handle_2 (Current, SEL_DRAGGED, 0, data)
                  end
               else
                  Result := False
               end
            end
         end
      end

   on_left_btn_press(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      local
         event: SB_EVENT
         index,code: INTEGER
         opts: INTEGER
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
             then

               -- Locate item
               index := item_at (event.win_x, event.win_y)

               if index<=0 then
                  -- No item
                  -- Start lasso
                  if (options & SELECT_MASK) = ICONLIST_EXTENDEDSELECT then
                     -- Kill selection
                     if (event.state & (SHIFTMASK | CONTROLMASK)) = Zero then
                        do_kill_selection (True)
                     end
                     current_x := event.win_x - pos_x
                     anchor_x := current_x
                     current_y := event.win_y - pos_y
                     anchor_y := current_y
                     draw_lasso (anchor_x, anchor_y, current_x, current_y)
                     set_flags (Flag_lasso)
                  end
               else
                  -- Find out where hit
                  code := item_hit (index, event.win_x, event.win_y, 1,1)

                  -- Change current_item item
                  set_current_item(index,True);

                  -- Change item selection
                  state := items.item(index).is_selected;
                  opts := options & SELECT_MASK;
                  if opts = ICONLIST_EXTENDEDSELECT then
                     if (event.state & SHIFTMASK) /= Zero then
                        if 0 < anchor_item then
                           if items.item(anchor_item).is_enabled then do_select_item (anchor_item, True) end
                           do_extend_selection (index, True)
                        else
                           if items.item(index).is_enabled then do_select_item (index, True) end
                           set_anchor_item(index)
                        end
                     elseif (event.state & CONTROLMASK) /= Zero then
                        if items.item(index).is_enabled and then not state then do_select_item(index, True) end
                        set_anchor_item(index)
                     else
                        if items.item(index).is_enabled and then not state then
                           do_kill_selection (True)
                           do_select_item (index, True)
                        end
                        set_anchor_item(index)
                     end
                  elseif opts = ICONLIST_MULTIPLESELECT or else opts = ICONLIST_SINGLESELECT then
                     if items.item(index).is_enabled and then not state then do_select_item (index, True) end
                  end

                  -- Are we dragging?
                  if code /= 0 and then items.item (index).is_selected and then items.item (index).is_draggable then
                     set_flags (Flag_trydrag)
                  end
                  set_flags (Flag_pressed)
               end
            end
         end
      end

   on_left_btn_release (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      local
         event: SB_EVENT
         opt,flg: INTEGER
      do
         event ?= data check event /= Void end
         flg := flags
         if is_enabled then
            Result := True
            release_mouse
            stop_auto_scroll
            set_flags (Flag_update);
            unset_flags (Flag_pressed | Flag_trydrag | Flag_lasso | Flag_dodrag)

            if message_target = Void 
               or else not message_target.handle_2 (Current, SEL_LEFTBUTTONRELEASE, message, data)
             then
               if (flg & Flag_lasso) /= Zero then
                  -- Was lassoing
                  draw_lasso (anchor_x, anchor_y, current_x, current_y);
               elseif (flg & Flag_dodrag) /= Zero then
                  -- Was dragging
                  do_handle_2 (Current, SEL_ENDDRAG, 0, data);
               elseif (flg & Flag_pressed) /= Zero then
                  -- Must have pressed

                  -- Selection change
                  opt := options & SELECT_MASK
                  if opt = ICONLIST_EXTENDEDSELECT then
                     if 0 < current_item and then items.item(current_item).is_enabled then
                        if (event.state & CONTROLMASK) /= Zero then
                           if state then do_deselect_item (current_item, True) end
                        elseif (event.state & SHIFTMASK) = Zero then
                           if state then
                              do_kill_selection (True)
                              do_select_item (current_item, True)
                           end
                        end
                     end
                  elseif opt = ICONLIST_MULTIPLESELECT or else opt = ICONLIST_SINGLESELECT then
                     if 0 < current_item and then items.item(current_item).is_enabled then
                        if state then do_deselect_item (current_item, True) end
                     end
                  end

                  -- Scroll to make item visibke
                  make_item_visible(current_item)

                  -- Update anchor_item
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
                  if 0 < current_item and then items.item(current_item).is_enabled then
                     do_handle_2 (Current, SEL_COMMAND, 0, ref_integer(current_item))
                  end
               end
            end
         end
      end

   on_right_btn_press(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
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
               or else not message_target.handle_2 (Current, Sel_rightbuttonpress, message,data)
             then
               set_flags (Flag_scrolling)
               grab_x := event.win_x-pos_x
               grab_y := event.win_y-pos_y
            end
         end
      end

   on_right_btn_release(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         if is_enabled then
            Result := True
            release_mouse
            unset_flags (Flag_scrolling)
            set_flags (Flag_update)
            if message_target /= Void then
               message_target.do_handle_2 (Current, Sel_rightbuttonrelease, message, data)
            end
         end
      end

   on_motion(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      local
         olx,orx,oty,oby,nlx,nrx,nty,nby: INTEGER
         event: SB_EVENT
         oldcursor: INTEGER
         flg: INTEGER
      do
         event ?= data check event /= Void end
         oldcursor := cursor_item
         flg := flags;

         -- Kill the tip
         unset_flags (Flag_tip)

         -- Kill the tip timer
         if timer /= Void then application.remove_timeout(timer); timer := Void end

         if (flags & Flag_scrolling) /= Zero then
            -- Right mouse scrolling
            set_scroll_position (event.win_x - grab_x, event.win_y - grab_y)
            Result := True
         elseif (flags & Flag_lasso) /= Zero then
            -- Lasso selection mode
            if not start_auto_scroll (event.win_x, event.win_y, False) then
               -- Hide lasso
               draw_lasso (anchor_x, anchor_y, current_x, current_y)

               -- Select items in lasso
               olx := anchor_x.min(current_x); orx := anchor_x.max(current_x)
               oty := anchor_y.min(current_y); oby := anchor_y.max(current_y)
               current_x := event.win_x - pos_x
               current_y := event.win_y - pos_y
               nlx := anchor_x.min(current_x); nrx := anchor_x.max(current_x)
               nty := anchor_y.min(current_y); nby := anchor_y.max(current_y)
               lasso_changed(pos_x+olx,pos_y+oty,orx-olx+1,oby-oty+1,pos_x+nlx,pos_y+nty,nrx-nlx+1,nby-nty+1,True)

               -- Force repaint on this window
               repaint

               -- Show lasso again
               draw_lasso(anchor_x, anchor_y, current_x, current_y)
            end
            Result := True
         elseif (flags & Flag_dodrag) /= Zero then
            -- Drag and drop mode
            if not start_auto_scroll (event.win_x, event.win_y, True) then
               do_handle_2 (Current, SEL_DRAGGED, 0, data)
            end
            Result := True
         elseif (flags & Flag_trydrag) /= Zero then
            -- Tentative drag and drop
            if event.moved then
               unset_flags (Flag_trydrag)
               if handle_2 (Current, SEL_BEGINDRAG, 0, data) then
                  set_flags (Flag_dodrag)
               end
            end
            Result := True
         else
            -- Reset tip timer if nothing's going on
            timer := application.add_timeout(application.menu_pause,Current,ID_TIPTIMER);

            -- Get item we're over
            cursor_item := item_at(event.win_x,event.win_y)

            -- Force GUI update only when needed
            if (cursor_item /= oldcursor) or else (flg & Flag_tip) /= Zero then
               Result := True
            end
         end
      end

   on_query_tip(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      local
      --   u: expanded SB_UTILS;
      do
         if (flags & Flag_tip) /= Zero then
            if 0 < cursor_item then               
               sender.do_handle_2 (Current, SEL_COMMAND, Id_setstringvalue,
                                u.section(items.item(cursor_item).label,'%T',0,1))
               Result := True
            end
         end
      end

   on_cmd_select_all(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      local
         i,e: INTEGER
      do
         from
            i := items.lower
            e := items.upper
         until
            i > e
         loop
            do_select_item(i,True)
            i := i+1
         end
         Result := True
      end

   on_cmd_deselect_all(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      local
         i,e: INTEGER
      do
         from
            i := items.lower
            e := items.upper
         until
            i > e
         loop
            do_deselect_item(i,True)
            i := i+1
         end
         Result := True
      end

   on_cmd_select_inverse(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      local
         i,e: INTEGER
      do
         from
            i := items.lower
            e := items.upper
         until
            i > e
         loop
            do_toggle_item(i,True)
            i := i+1
         end
         Result := True
      end

   on_cmd_arrange_by_rows (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         unset_options (ICONLIST_COLUMNS)
         recalc
         Result := True
      end

   on_upd_arrange_by_rows (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         if (options & ICONLIST_COLUMNS) /= Zero then
            sender.do_handle_2 (Current, SEL_COMMAND, Id_uncheck, Void)
         else
            sender.do_handle_2 (Current, SEL_COMMAND, Id_check, Void)
         end
         Result := True
      end

   on_cmd_arrange_by_columns(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         options := options | ICONLIST_COLUMNS
         recalc
         Result := True
      end

   on_upd_arrange_by_columns(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         if (options & ICONLIST_COLUMNS) /= Zero then
            sender.do_handle_2 (Current, SEL_COMMAND, Id_check, Void)
         else
            sender.do_handle_2 (Current, SEL_COMMAND, Id_uncheck, Void)
         end
         Result := True
      end

   on_cmd_show_details (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         unset_options (ICONLIST_MINI_ICONS)
         unset_options (ICONLIST_BIG_ICONS)
         recalc
         Result := True
      end

   on_upd_show_details (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         if (options & (ICONLIST_MINI_ICONS | ICONLIST_BIG_ICONS)) /= Zero then
            sender.do_handle_2 (Current, SEL_COMMAND, Id_uncheck, Void)
         else
            sender.do_handle_2 (Current, SEL_COMMAND, Id_check, Void)
         end
         Result := True
      end

   on_cmd_show_big_icons (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         unset_options (ICONLIST_MINI_ICONS)
         options := options | ICONLIST_BIG_ICONS
         recalc
         Result := True
      end

   on_upd_show_big_icons (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         if (options & ICONLIST_BIG_ICONS) /= Zero then
            sender.do_handle_2 (Current, SEL_COMMAND, Id_check, Void)
         else
            sender.do_handle_2 (Current, SEL_COMMAND, Id_uncheck, Void)
         end
         Result := True
      end

   on_cmd_show_mini_icons (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         options := options | ICONLIST_MINI_ICONS
         unset_options (ICONLIST_BIG_ICONS)
         recalc
         Result := True
      end

   on_upd_show_mini_icons (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         if (options & ICONLIST_MINI_ICONS) /= Zero then
            sender.do_handle_2 (Current, SEL_COMMAND, Id_check, Void)
         else
            sender.do_handle_2 (Current, SEL_COMMAND, Id_uncheck, Void)
         end
         Result := True
      end

   on_header_changed(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         unset_flags (Flag_recalc)
         Result := True
      end

   on_header_resize(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
         -- Header subdivision resize has been requested;
         -- we want to set the width of the header column
         -- to that of the widest item.
      local
         tlen,i,e,c,hi,ti: INTEGER
         hi_: SE_REFERENCE [ INTEGER ]
         iw,tw,w,nw: INTEGER
         text: STRING
      do
         hi_ ?= data check hi_ /= Void end
         hi := hi_.item
         -- For detailed icon list
         if (options & (ICONLIST_MINI_ICONS | ICONLIST_BIG_ICONS)) = Zero then
            from
               i := items.lower
               e := items.upper
            until
               i > e
            loop
               text := items.item(i).label
               w := 0
               -- The first header item may have an icon
               if hi = 1 then
                  if items.item(i).mini_icon /= Void then
                     iw := items.item(i).mini_icon.width
                     w := w+iw+items.item(i).DETAIL_TEXT_SPACING+items.item(i).SIDE_SPACING // 2
                  end
               end
               if text /= Void then
                  -- Locate text for the header index
                  from
                     ti := 1
                     c := 1
                  until
                     ti > text.count or else c >= hi
                  loop
                     if text.item(ti) = '%T' then c := c+1 end
                     ti := ti+1
                  end
                  tlen := items.item(i).count(text,ti)
                  if tlen > 0 then
                     tw := font.get_text_width_offset(text,ti,tlen)
                     w := w+tw+items.item(i).SIDE_SPACING+2
                  end
               end
               if w>nw then nw := w end
               i := i+1
            end
            -- Set new header width
            if nw > 0 and then nw /= header.item(hi).size then
               header.set_item_size(hi,nw)
               unset_flags (Flag_recalc)
            end
         end
         Result := True
      end


   on_auto_scroll(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      local
         event: SB_EVENT;
         olx,orx,oty,oby,nlx,nrx,nty,nby: INTEGER;
      do
         if (flags & Flag_lasso) /= Zero then
            -- Lasso mode

			event ?= data

            -- Hide the lasso before scrolling
            draw_lasso(anchor_x, anchor_y, current_x, current_y)

            -- Scroll the content
            Result := Precursor(sender, selector, data)
            -- Select items in lasso
            olx := anchor_x.min(current_x); orx := anchor_x.max(current_x)
            oty := anchor_y.min(current_y); oby := anchor_y.max(current_y)
            current_x := event.win_x - pos_x
            current_y := event.win_y - pos_y
            nlx := anchor_x.min(current_x); nrx := anchor_x.max(current_x)
            nty := anchor_y.min(current_y); nby := anchor_y.max(current_y)
            lasso_changed(pos_x+olx, pos_y+oty, orx-olx+1, oby-oty+1, pos_x+nlx, pos_y+nty, nrx-nlx+1, nby-nty+1, True)

            -- Force repaint on Current window
            repaint;

            -- Show lasso again
            draw_lasso(anchor_x, anchor_y, current_x, current_y)
            Result := True
         else

            -- Scroll the content
            Result := Precursor(sender,selector,data);

            -- Content scrolled, so perhaps something else under cursor_item
            if (flags & Flag_dodrag) /= Zero then
               do_handle_2 (Current, SEL_DRAGGED, 0, data)
               Result := True
            end
         end
      end

feature -- Resource management

   create_resource is
         -- Create server-side resources
      local
         i,e: INTEGER
      do
         Precursor
         from
            i := items.lower
            e := items.upper
         until
            i > e
         loop
            items.item(i).create_resource
            i := i+1
         end
         font.create_resource
      end

   detach_resource is
         -- Detach server-side resources
      local
         i,e: INTEGER
      do
         Precursor
         from
            i := items.lower
            e := items.upper
         until
            i > e
         loop
            items.item(i).detach_resource
            i := i+1
         end
         font.detach_resource
      end

feature -- Destruction

   destruct is
      do
         if timer /= Void then application.remove_timeout(timer); timer := Void end
         if lookup_timer /= Void then application.remove_timeout(lookup_timer); lookup_timer := Void end
         clear_items
         Precursor
      end


feature {NONE} -- Implementation

   ITEM_TYPE: SB_ICON_LIST_ITEM is do end

   ITEM_SPACE_: INTEGER is 128;
         -- Default space for item

   ICONLIST_MASK: INTEGER is
      once
         Result := SELECT_MASK | ICONLIST_MINI_ICONS | ICONLIST_BIG_ICONS 
            | ICONLIST_COLUMNS | ICONLIST_AUTOSIZE
      end

	draw_lasso(a_x0, a_y0, a_x1, a_y1: INTEGER) is
    	local
        	dc: SB_DC_WINDOW
        	x0, y0, x1, y1: INTEGER
      	do
		 	dc := paint_dc
         	dc.set_function(dc.Blt_not_dst)
         	x0 := a_x0 + pos_x
         	x1 := a_x1 + pos_x
         	y0 := a_y0 + pos_y
         	y1 := a_y1 + pos_y
         	dc.draw_line(x0, y0, x1, y0)
         	dc.draw_line(x1, y0, x1, y1)
         	dc.draw_line(x1, y1, x0, y1)
         	dc.draw_line(x0, y1, x0, y0)
         	dc.stop
      	end

   layout is
      local
         ww: INTEGER
      do
         -- Update scroll bars
         Precursor

         if (options & (ICONLIST_MINI_ICONS | ICONLIST_BIG_ICONS)) = Zero then
            -- In detail mode
            ww := header.default_width
            if ww < viewport_w then ww := viewport_w end
            header.position(pos_x, 0, ww, header.default_height)
            header.show
         else
            header.hide
         end

         -- Set line size
         v_scroll_bar.set_line_size(item_height)
         h_scroll_bar.set_line_size(item_space)

         -- Force repaint
         update;
         unset_flags (Flag_dirty)
      end

   recompute is
      local
         w,h,i,e: INTEGER
         sbp: SB_POINT
      do
         item_width := 1
         item_height := 1

         -- Measure the items
         from
            i := items.lower
            e := items.upper
         until
            i > e
         loop               
            w := items.item(i).width(Current)
            h := items.item(i).height(Current)
            if w > item_width then item_width := w end
            if h > item_height then item_height := h end
            i := i+1
         end

         -- Automatically size item spacing
         if (options & ICONLIST_AUTOSIZE) /= Zero then 
            item_space := item_width.max(1)
         end

         -- Adjust for detail mode
         if (options & (ICONLIST_MINI_ICONS | ICONLIST_BIG_ICONS)) = Zero then
            item_width := header.default_width
         end

         -- Get number of rows or columns
         sbp := getrowscols(width, height)
         rows_count := sbp.x
         columns_count := sbp.y
         -- Done
         unset_flags (Flag_recalc)
      end

   getrowscols(w,h: INTEGER): SB_POINT is
      local
         nr,nc: INTEGER
      do
         if (options & (ICONLIST_BIG_ICONS | ICONLIST_MINI_ICONS)) /= Zero then
            if (options & ICONLIST_COLUMNS) /= Zero then
               nc := w // item_space
               if nc < 1 then nc := 1 end
               nr := (items_count+nc-1) // nc
               if nr * item_height > h then
                  nc := (w - v_scroll_bar.default_width) // item_space
                  if nc < 1 then nc := 1 end
                  nr := (items_count + nc - 1) // nc
               end
               if nr < 1 then nr := 1 end
            else
               nr := h // item_height;
               if nr < 1 then nr := 1 end
               nc := (items_count + nr - 1) // nr
               if nc * item_space > w then
                  nr := (h - h_scroll_bar.default_height) // item_height;
                  if nr < 1 then nr := 1 end
                  nc := (items_count + nr - 1) // nr
               end
               if nc < 1 then nc := 1 end
            end
         else
            nr := items_count
            nc := 1
         end
         create Result.make (nr, nc)
      end

	create_item(txt: STRING; big,mini: SB_ICON; data: ANY): G is
		deferred
		end

   lasso_changed(ox,oy,ow,oh,nx,ny,nw,nh: INTEGER; notify: BOOLEAN) is
      local
         r,c: INTEGER;
         ohit,nhit,index,e: INTEGER;
      do
         if (options & (ICONLIST_BIG_ICONS | ICONLIST_MINI_ICONS)) /= Zero then
            from
               r := 0;
            until
               r >= rows_count
            loop
               from
                  c := 0
               until
                  c >= columns_count
               loop
                  if (options & ICONLIST_COLUMNS) /= Zero then
                     index := columns_count*r+c+1;
                  else 
                     index := rows_count*c+r+1;
                  end
                  if index <= items_count then
                     ohit := item_hit(index,ox,oy,ow,oh);
                     nhit := item_hit(index,nx,ny,nw,nh);
                     if ohit /= 0 and then nhit = 0 then
                        -- In old rectangle and not in new rectangle
                        do_deselect_item(index,notify);
                     elseif ohit = 0 and then nhit /= 0 then
                        -- Not in old rectangle and in new rectangle
                        do_select_item(index,notify);
                     end
                  end
                  c := c+1;
               end
               r := r+1;
            end
         else
            from
               index := items.lower
               e := items.upper
            until
               index > e
            loop 
               ohit := item_hit(index,ox,oy,ow,oh);
               nhit := item_hit(index,nx,ny,nw,nh);
               if ohit /= 0 and then nhit = 0 then
                  -- Was in old, not in new
                  do_deselect_item(index,notify);
               elseif ohit = 0 and then nhit /= 0 then
                  -- Not in old, but in new
                  do_select_item(index,notify);
               end
               index := index+1
            end
         end
      end

   do_hop(event: SB_EVENT; index: INTEGER) is
      do
         create lookup_string.make_empty;
         if 1 <= index and then index <= items_count then
            set_current_item(index, True);
            make_item_visible(index);
            if items.item(index).is_enabled then
               if (options & SELECT_MASK) = ICONLIST_EXTENDEDSELECT then
                  if (event.state & SHIFTMASK) /= Zero then
                     if 1 <= anchor_item then
                        do_select_item(anchor_item, True);
                        do_extend_selection(index, True);
                     else
                        do_select_item(index,True);
                     end
                  elseif (event.state & CONTROLMASK) = Zero then
                     do_kill_selection(True);
                     do_select_item(index,True);
                     set_anchor_item(index);
                  end
               end
            end
         end
         do_handle_2 (Current, SEL_CLICKED, 0, ref_integer(current_item));
         if 1 <= current_item and then items.item(current_item).is_enabled then
            do_handle_2 (Current, SEL_COMMAND, 0, ref_integer(current_item));
         end
      end

end
