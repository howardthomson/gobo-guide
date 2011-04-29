indexing
	description: "[
		The scroll bar is used when a document has a larger content than may be made
		visible.  The range is the total size of the document, the page is the part
		of the document which is visible.  The size of the scrollbar thumb is adjusted
		to give feedback of the relative sizes of each.
		The scroll bar may be manipulated by the left mouse (normal scrolling), right
		mouse (vernier or fine-scrolling), or middle mouse (same as the left mouse only
		the scroll position can hop to the place where the click is made).
		Finally, if the mouse sports a wheel, the scroll bar can be manipulated by means
		of the mouse wheel as well.  Holding down the Control-key during wheel motion
		will cause the scrolling to go faster than normal.
		While moving the scroll bar, a message of type SEL_CHANGED will be sent to the
		message_target, and the message data will reflect the current position of type FXint.
		At the end of the interaction, the scroll bar will send a message of type
		SEL_COMMAND to notify the message_target of the final position.
	]"

	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

	todo: "[
		Adapt to permit the top of the content to be below the upper limit, to permit
		the click point of a contracting content to stay put, instead of the content shifting
		upward (or leftward) when (and only when) the extent ceases to exceed the range...
		It really BUGS me!!
	]"

class SB_SCROLL_BAR

inherit

	SB_WINDOW
      	rename
         	Id_last as WINDOW_ID_LAST,
         	make as window_make
      	redefine
         	default_height,
         	default_width,
         	destruct,
         	layout,
         	handle_2,
         	on_left_btn_press,
         	on_left_btn_release,
         	on_middle_btn_press,
         	on_middle_btn_release,
         	on_right_btn_press,
         	on_right_btn_release,
         	on_motion,
         	on_mouse_wheel,
         	on_paint,
         	on_ungrabbed,
         	class_name
      	end
   
   	SB_SCROLL_BAR_CONSTANTS

   	SB_SCROLL_BAR_COMMANDS

creation

   make, make_opts

feature -- class name

	class_name: STRING
		once
			Result := "SB_SCROLL_BAR"
		end

feature -- Attributes

	range: INTEGER
			-- Scrollable range
			
	page_size: INTEGER
			-- Page size

	line_size: INTEGER
			-- Line size
			
	scroll_position: INTEGER
			-- Position

	hilite_color: INTEGER
			-- Hightlight color

	shadow_color: INTEGER
			-- Shadow color

	border_color: INTEGER
			-- Border color

	arrow_color: INTEGER
			-- Arrow color

feature -- Creation

   make (p: SB_COMPOSITE; tgt: SB_MESSAGE_HANDLER; selector: INTEGER; opts: INTEGER)
         -- Construct scroll bar
      local
         o: INTEGER
      do
         if opts = 0 then
            o := SCROLLBAR_VERTICAL
         else
            o := opts
         end
         make_opts (p, tgt,selector, o, 0,0,0,0)
      end

	make_opts (p: SB_COMPOSITE; tgt: SB_MESSAGE_HANDLER; selector: INTEGER; opts: INTEGER; x,y,w,h: INTEGER)
			-- Construct scroll bar
		do
         	window_make (p, opts, x,y, w,h)
         	flags := flags | Flag_enabled | Flag_shown
         	back_color := application.base_color
         	hilite_color := application.hilite_color
         	shadow_color := application.shadow_color
         	border_color := application.border_color
         	arrow_color := application.fore_color
         	thumb_position := BAR_SIZE
         	thumb_size := THUMB_MINIMUM
         	message_target := tgt
         	message := selector
         	timer := Void
         	drag_point := 0
         	drag_jump := 0
         	range := 100
         	page_size := 1
         	line_size := 1
         	scroll_position := 0
         	pressed := 0
      	end

feature -- Queries

	default_width: INTEGER
			-- Get default width
		do
			if (options & SCROLLBAR_HORIZONTAL) /= 0 then
				Result := BAR_SIZE + BAR_SIZE + THUMB_MINIMUM
			else 
				Result := BAR_SIZE
			end
		end

   default_height: INTEGER
      do
         -- Get default height
         if (options & SCROLLBAR_HORIZONTAL) /= 0 then
            Result := BAR_SIZE
         else 
            Result := BAR_SIZE + BAR_SIZE + THUMB_MINIMUM
         end
      end

   get_scrollbar_style: INTEGER is
         -- Return the scrollbar style
      do
         Result := (options & SCROLLBAR_MASK)
      end

feature -- Actions

	set_range (r: INTEGER)
    		-- Set content size range
    	local
         	rr: INTEGER
      	do
         	rr := r
         	if rr < 1 then rr := 1 end
         	if range /= rr then
            	range := rr
            	set_page_size (page_size)
         	end
		ensure
			range >= 1
      	end

	set_page_size (p: INTEGER)
    		-- Set viewport page_size size
      	local
        	pp: INTEGER
      	do
        	pp := p
        	if pp < 1 then pp := 1 end
        	if pp > range then  pp := range end
        	if page_size /= pp then
            	page_size := pp
            	set_scroll_position (scroll_position)
         	end
      	end

	set_line_size (l: INTEGER)
         -- Set scoll increment for line
      do
         if l < 1 then
            line_size := 1
         else
            line_size := l
         end
      end

	set_scroll_position (p: INTEGER)
    		-- Change current scroll position
      	local
        	total, travel, lo, hi, l, h: INTEGER
      	do
        	scroll_position := p
        	if scroll_position < 0 then scroll_position := 0 end
        	if scroll_position > (range-page_size) then scroll_position := range-page_size end
     -- 	if scroll_position > (range - 1) then scroll_position := range - 1 end
         	lo := thumb_position
         	hi := thumb_position + thumb_size
         	if (options & SCROLLBAR_HORIZONTAL) /= 0 then
            	total := width - height - height
            	thumb_size := (total * page_size) // range
            	if thumb_size < THUMB_MINIMUM then thumb_size := THUMB_MINIMUM end
            	travel := total - thumb_size
            	if range > page_size then
               		thumb_position := height + ((scroll_position * travel) / (range - page_size)).truncated_to_integer
            	else
               		thumb_position := height
            	end
            	l := thumb_position
            	h := thumb_position + thumb_size
            	if l /= lo or else h /= hi then
               		update_rectangle (l.min (lo), 0, h.max (hi) - l.min (lo), height)
            	end    
         	else
            	total := height - width - width
            	thumb_size := (total * page_size) // range
            	if thumb_size < THUMB_MINIMUM then thumb_size := THUMB_MINIMUM end
            	travel := total - thumb_size
            	if range > page_size then
               		thumb_position := width + ((scroll_position * travel) / (range - page_size)).truncated_to_integer
            	else
               		thumb_position := width
            	end
            	l := thumb_position
            	h := thumb_position + thumb_size
            	if l /= lo or else h /= hi then
               		update_rectangle (0, l.min (lo), width, h.max (hi) - l.min (lo))
            	end
         	end
      	end

  set_hilite_color (clr: INTEGER)
         -- Change highlight color
      do
         if hilite_color /= clr then
           hilite_color := clr
           update
         end
      end

   set_shadow_color (clr: INTEGER)
         -- Change shadow color
      do
         if shadow_color /= clr then
            shadow_color := clr
            update
         end
      end

  set_border_color (clr: INTEGER)
         -- Change border color
      do
         if border_color /= clr then
            border_color := clr
            update
         end
      end

  set_arrow_color (clr: INTEGER)
         -- Change arrow color
      do
         if arrow_color /= clr then
           arrow_color := clr
           update
         end
      end
   
   set_scrollbar_style (style: INTEGER)
         -- Set the scrollbar style
      local
         opts: INTEGER
      do
         opts := new_options (style, SCROLLBAR_MASK)
         if options /= opts then
            options := opts
            recalc
            update
         end
      end

feature -- Message processing

	handle_2 (sender: SB_MESSAGE_HANDLER; type, key: INTEGER; data: ANY): BOOLEAN
    	do
        	if		match_function_2 (Sel_timeout,ID_TIMEWHEEL, 	type, key) then Result := on_time_wheel 		(sender, key, data)
        	elseif	match_function_2 (Sel_timeout,ID_AUTOINC_PIX,  	type, key) then Result := on_time_inc_pix 		(sender, key, data)
        	elseif	match_function_2 (Sel_timeout,ID_AUTOINC_LINE, 	type, key) then Result := on_time_inc_line 		(sender, key, data)
        	elseif	match_function_2 (Sel_timeout,ID_AUTOINC_PAGE, 	type, key) then Result := on_time_inc_page 		(sender, key, data)
        	elseif	match_function_2 (Sel_timeout,ID_AUTODEC_PIX,  	type, key) then Result := on_time_dec_pix 		(sender, key, data)
        	elseif	match_function_2 (Sel_timeout,ID_AUTODEC_LINE, 	type, key) then Result := on_time_dec_line 		(sender, key, data)
        	elseif	match_function_2 (Sel_timeout,ID_AUTODEC_PAGE, 	type, key) then Result := on_time_dec_page 		(sender, key, data)
        	elseif	match_function_2 (SEL_COMMAND,Id_setvalue, 	 	type, key) then Result := on_cmd_set_value		(sender, key, data)
        	elseif	match_function_2 (SEL_COMMAND,Id_setintvalue,  	type, key) then Result := on_cmd_set_int_value 	(sender, key, data)
        	elseif	match_function_2 (SEL_COMMAND,Id_getintvalue,  	type, key) then Result := on_cmd_get_int_value 	(sender, key, data)
        	elseif	match_function_2 (SEL_COMMAND,Id_setintrange,  	type, key) then Result := on_cmd_set_int_range 	(sender, key, data)
        	elseif	match_function_2 (SEL_COMMAND,Id_getintrange,  	type, key) then Result := on_cmd_get_int_range 	(sender, key, data)
        	else Result := Precursor (sender, type, key, data)
        	end
      	end

	on_paint (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
    	local
        	total: INTEGER
        	ev: SB_EVENT
        	dc: SB_DC_WINDOW
      	do
         	ev ?= data;
         	check
            	ev /= Void
         	end
         	dc := paint_dc
         	dc.make_event (Current, ev)
         	if (options & SCROLLBAR_HORIZONTAL) /= 0 then
         			-- Horizontal
            	total := width - height - height
            	if thumb_size < total then
               			-- Scrollable
               		draw_button (dc, thumb_position, 0, thumb_size, height, False)
               		dc.set_stipple_pattern (dc.Stipple_gray,0,0)
               		dc.set_fill_style (dc.Fill_opaque_stippled)
               		if (pressed & PRESSED_PAGEDEC) /= 0 then
                  		dc.set_foreground (back_color)
                  		dc.set_background (shadow_color)
               		else
                  		dc.set_foreground (hilite_color)
                  		dc.set_background (back_color)
               		end
               		dc.fill_rectangle (height, 0, thumb_position - height, height);
               		if (pressed & PRESSED_PAGEINC) /= 0 then
                  		dc.set_foreground (back_color)
                  		dc.set_background (shadow_color)
               		else
                  		dc.set_foreground (hilite_color)
                  		dc.set_background (back_color)
               		end
               		dc.fill_rectangle (thumb_position + thumb_size, 0,
                                 width - height - thumb_position - thumb_size, height)
            	else
               			-- Non-scrollable
               		dc.set_stipple_pattern (dc.Stipple_gray, 0, 0)
               		dc.set_fill_style (dc.Fill_opaque_stippled)
               		dc.set_foreground (hilite_color)
               		dc.set_background (back_color)
               		dc.fill_rectangle (height, 0, total, height)
            	end
            	dc.set_fill_style(dc.Fill_solid);
            	draw_button		(dc, width - height, 0, height, height, (pressed & PRESSED_INC) /= 0);
            	draw_right_arrow(dc, width - height, 0, height, height, (pressed & PRESSED_INC) /= 0);
            	draw_button		(dc, 0, 			 0, height, height, (pressed & PRESSED_DEC) /= 0);
            	draw_left_arrow	(dc, 0, 			 0, height, height, (pressed & PRESSED_DEC) /= 0);
         	else
         			-- Vertical
            	total := height - width - width;
            	if thumb_size < total then
               			-- Scrollable
               		draw_button (dc, 0, thumb_position, width, thumb_size, False)
               		dc.set_stipple_pattern (dc.Stipple_gray, 0, 0)
               		dc.set_fill_style (dc.Fill_opaque_stippled)
               		if (pressed & PRESSED_PAGEDEC) /= 0 then
                  		dc.set_foreground (back_color)
                  		dc.set_background (shadow_color)
               		else
                  		dc.set_foreground (hilite_color)
                  		dc.set_background (back_color)
               		end
               		dc.fill_rectangle (0, width, width, thumb_position - width);
               		if (pressed & PRESSED_PAGEINC) /= 0 then
                  		dc.set_foreground (back_color)
                  		dc.set_background (shadow_color)
               		else
                  		dc.set_foreground (hilite_color)
                  		dc.set_background (back_color)
               		end
               		dc.fill_rectangle (0, thumb_position + thumb_size,
                                 width, height - width - thumb_position - thumb_size)
            	else
               			-- Non-scrollable
               		dc.set_stipple_pattern (dc.Stipple_gray, 0, 0)
               		dc.set_fill_style (dc.Fill_opaque_stippled)
               		dc.set_foreground (hilite_color)
               		dc.set_background (back_color)
               		dc.fill_rectangle (0, width, width, total)
            	end
            	dc.set_fill_style (dc.Fill_solid)
            	draw_button		(dc, 0, height - width, width, width, (pressed & PRESSED_INC) /= 0)
            	draw_down_arrow	(dc, 0, height - width, width, width, (pressed & PRESSED_INC) /= 0)
            	draw_button		(dc, 0, 0, 				width, width, (pressed & PRESSED_DEC) /= 0)
            	draw_up_arrow	(dc, 0, 0, 				width, width, (pressed & PRESSED_DEC) /= 0)
         	end
         	dc.stop
         	Result := True
      	end

   on_motion (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         event: SB_EVENT;
         travel,hi,lo,t,p: INTEGER;
      do
         event ?= data;
         check
            event /= Void
         end
         if is_enabled then
            if (flags & Flag_pressed) /= 0 then
               p := 0;
               if (event.state & (CONTROLMASK | SHIFTMASK | ALTMASK)) /= 0 then
                  pressed := PRESSED_FINETHUMB;
               end
               if pressed = PRESSED_THUMB then
                  -- Coarse movements
                  if (options & SCROLLBAR_HORIZONTAL) /= 0 then
                     travel := width - height - height - thumb_size;
                     t := event.win_x - drag_point;
                     if t<height then t := height end
                     if t>(width - height - thumb_size) then t := width - height - thumb_size end
                     if t /= thumb_position then
                        lo := t.min(thumb_position); hi := t.max(thumb_position);
                        update_rectangle(lo, 0, hi + thumb_size - lo, height);
                        thumb_position := t;
                     end
                     if travel > 0 then
                        p := ((((thumb_position - height) * (range - page_size)).to_double + (travel / 2)) / travel).truncated_to_integer;
                     end
                  else
                     travel := height - width - width - thumb_size;
                     t := event.win_y - drag_point;
                     if t < width then t := width end
                     if t > (height - width - thumb_size) then t := height - width - thumb_size end
                     if t /= thumb_position then
                        lo := t.min(thumb_position); hi := t.max(thumb_position);
                        update_rectangle(0, lo, width, hi + thumb_size - lo);
                        thumb_position := t;
                     end
                     if travel > 0 then
                        p := ((((thumb_position - width) * (range - page_size)).to_double + (travel / 2)) / travel).truncated_to_integer
                     end
                  end
               elseif (pressed = PRESSED_FINETHUMB) then
                  -- Fine movements
                  if (options & SCROLLBAR_HORIZONTAL) /= 0 then
                     travel := width - height - height - thumb_size;
                     p := scroll_position + event.win_x - event.last_x;
                     if p < 0 then p := 0 end
                     if p > (range - page_size) then p := range - page_size end
                     if range>page_size then
                        t := height + ((scroll_position * travel) / (range - page_size)).truncated_to_integer;
                     else
                        t := height;
                     end
                     if t /= thumb_position then
                        lo := t.min(thumb_position); hi := t.max(thumb_position);
                        update_rectangle(lo, 0, hi + thumb_size - lo, height);
                        thumb_position := t;
                     end
                  else
                     travel := height - width - width - thumb_size;
                     p := scroll_position + event.win_y - event.last_y;
                     if p < 0 then p := 0 end
                     if p > (range - page_size) then p := range - page_size end
                     if range > page_size then
                        t := width+ ((scroll_position*travel)/(range-page_size)).truncated_to_integer;
                     else
                        t := width;
                     end
                     if t /= thumb_position then
                        lo := t.min(thumb_position); hi := t.max(thumb_position);
                        update_rectangle(0, lo, width, hi + thumb_size - lo);
                        thumb_position := t;
                     end
                  end
               end
               if p < 0 then p := 0 end
               if p > (range - page_size) then  p := range - page_size end
               if scroll_position /= p then
                  scroll_position := p;
                  if message_target /= Void then
                     message_target.do_handle_2 (Current, SEL_CHANGED, message, ref_integer(scroll_position));
                  end
                  flags := flags | Flag_changed;
                  Result := True;
               end
            end
         end
      end

	on_mouse_wheel (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
    	local
        	ev: SB_EVENT;
        	jump: INTEGER;
      	do
        	ev ?= data;
        	check
            	ev /= Void
         	end
         	if is_enabled then
            	if timer /= Void then
            		application.remove_timeout(timer)
					timer := Void
            	end
            	if (ev.state & (LEFTBUTTONMASK | MIDDLEBUTTONMASK | RIGHTBUTTONMASK)) = 0 then
               		if (ev.state & ALTMASK) /= 0 then
               			jump := line_size  -- Fine scrolling
               		elseif (ev.state & CONTROLMASK) /= 0 then
               			jump := page_size   -- Coarse scrolling
               		else
               			jump := page_size.min(application.wheel_lines * line_size)
               		end -- Normal scrolling
               		if drag_point = 0 then drag_point := scroll_position end  -- Were not scrolling already?
               		drag_point := drag_point - ev.code * jump // 120    -- Move scroll position
               		if drag_point < 0 then drag_point := 0 end
               		if drag_point > (range - page_size) then drag_point := range - page_size end
               		if drag_point /= scroll_position then
                  		drag_jump := (drag_point - scroll_position);
                  		if drag_jump.abs > 16 then drag_jump := drag_jump // 16 end
                  		timer := application.add_timeout(5, Current, ID_TIMEWHEEL);
               		end
               		Result := True;
            	end
         	end
		end

   on_left_btn_press (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         event: SB_EVENT;
         p: INTEGER;
      do
         event ?= data;
         check
            event /= Void
         end
         p := scroll_position;
         if is_enabled then
            grab_mouse;
            if timer /= Void then
            	application.remove_timeout(timer)
            	timer := Void
            end
            if message_target /= Void
               and then message_target.handle_2 (Current, SEL_LEFTBUTTONPRESS, message, data)
            then
               Result := True;
            else
               unset_flags (Flag_update);
               if (options & SCROLLBAR_HORIZONTAL) /= 0 then
                  -- Horizontal scrollbar
                  if event.win_x < height then
                     -- Left arrow
                     pressed := PRESSED_DEC;
                     timer := application.add_timeout(application.scroll_delay, Current, ID_AUTODEC_LINE);
                     p := scroll_position-line_size;
                     update;
                  elseif width-height <= event.win_x then
                     -- Right arrow
                     pressed := PRESSED_INC;
                     timer := application.add_timeout(application.scroll_delay, Current, ID_AUTOINC_LINE);
                     p := scroll_position+line_size;
                     update;
                  elseif event.win_x < thumb_position then
                     -- Page left
                     pressed := PRESSED_PAGEDEC;
                     timer := application.add_timeout(application.scroll_delay, Current, ID_AUTODEC_PAGE);
                     p := scroll_position-page_size;
                     update;
                  elseif thumb_position+thumb_size <= event.win_x then
                     -- Page right
                     pressed := PRESSED_PAGEINC;
                     timer := application.add_timeout(application.scroll_delay, Current, ID_AUTOINC_PAGE);
                     p := scroll_position+page_size;
                     update;
                  else
                     -- Grabbed the puck
                     pressed := PRESSED_THUMB;
                     drag_point := event.win_x-thumb_position;
                     flags := flags | Flag_pressed;
                  end
               else
                  -- Vertical scrollbar
                  if event.win_y < width then
                     -- Up arrow
                     pressed := PRESSED_DEC;
                     timer := application.add_timeout(application.scroll_delay, Current, ID_AUTODEC_LINE);
                     p := scroll_position - line_size;
                     update;
                  elseif height - width <= event.win_y then
                     -- Down arrow
                     pressed := PRESSED_INC;
                     timer := application.add_timeout(application.scroll_delay, Current, ID_AUTOINC_LINE);
                     p := scroll_position + line_size;
                     update;
                  elseif event.win_y < thumb_position then
                     -- Page up
                     pressed := PRESSED_PAGEDEC;
                     timer := application.add_timeout(application.scroll_delay, Current, ID_AUTODEC_PAGE);
                     p := scroll_position - page_size;
                     update;
                  elseif thumb_position + thumb_size <= event.win_y then
                     -- Page down
                     pressed := PRESSED_PAGEINC;
                     timer := application.add_timeout(application.scroll_delay, Current, ID_AUTOINC_PAGE);
                     p := scroll_position + page_size;
                     update;
                  else
                     -- Grabbed the puck
                     pressed := PRESSED_THUMB;
                     if (event.state & (CONTROLMASK | SHIFTMASK | ALTMASK)) /= 0 then
                        pressed := PRESSED_FINETHUMB;
                     end
                     drag_point := event.win_y - thumb_position;
                     flags := flags | Flag_pressed;
                  end
               end
               if p < 0 then p := 0 end
               if p > (range - page_size) then p := range - page_size end
               if p /= scroll_position then
                  set_scroll_position(p)
                  if message_target /= Void then
                     message_target.do_handle_2 (Current, SEL_CHANGED, message, ref_integer(scroll_position))
                  end
                  flags := flags | Flag_changed
               end
               Result := True
            end
         end
      end

   on_left_btn_release (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         flgs: INTEGER
      do
         flgs := flags
         if is_enabled then
            release_mouse
            unset_flags (Flag_pressed)
            unset_flags (Flag_changed)
            flags := flags | Flag_update
            drag_point := 0
            pressed := 0
            set_scroll_position(scroll_position)
            update
            if timer /= Void then
            	application.remove_timeout(timer)
            	timer := Void
            end
            if message_target /= Void
               and then message_target.handle_2 (Current, SEL_LEFTBUTTONRELEASE, message, data)
             then 
               Result := True
            else
               if (flgs & Flag_changed) /= 0 then
                  if message_target /= Void then
                     message_target.do_handle_2 (Current, SEL_COMMAND, message, ref_integer(scroll_position))
                  end
               end
               Result := True
            end
         end
      end

   on_middle_btn_press (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         event: SB_EVENT;
         p: INTEGER;
         travel,lo,hi,t: INTEGER;
      do
         event ?= data;
         check
            event /= Void
         end
         p := scroll_position;
         if is_enabled then
            grab_mouse;
            if timer /= Void then
            	application.remove_timeout(timer)
				timer := Void
            end
            if message_target /= Void 
               and then message_target.handle_2 (Current, SEL_MIDDLEBUTTONPRESS, message, data)
             then
               Result := True;
            else
               pressed := PRESSED_THUMB;
               flags := flags | Flag_pressed;
               unset_flags (Flag_update);
               drag_point := thumb_size // 2;
               if (options & SCROLLBAR_HORIZONTAL) /= 0 then
                  travel := width - height - height - thumb_size;
                  t := event.win_x - drag_point;
                  if t < height then  t := height end
                  if t > (width - height - thumb_size) then t := width - height - thumb_size end
                  if t /= thumb_position then
                     lo := t.min (thumb_position); hi := t.max (thumb_position);
                     update_rectangle (lo, 0, hi+thumb_size-lo, height);
                     thumb_position := t;
                  end
                  if travel > 0 then 
                     p := ((thumb_position - height) * (range - page_size) / travel).truncated_to_integer;
                  else
                     p := 0;
                  end
               else
                  travel := height - width - width - thumb_size;
                  t := event.win_y - drag_point;
                  if t < width then t := width end
                  if t > (height - width - thumb_size) then t := height - width - thumb_size end
                  if t /= thumb_position then
                     lo := t.min (thumb_position); hi := t.max (thumb_position);
                     update_rectangle(0, lo, width, hi + thumb_size - lo);
                     thumb_position := t;
                  end
                  if travel > 0 then
                     p := (((thumb_position - width) * (range - page_size)) / travel).truncated_to_integer;
                  else
                     p := 0;
                  end
               end
               if p < 0 then p := 0 end
               if p > (range - page_size) then p := range - page_size end
               if scroll_position /= p then
                  scroll_position := p;
                  if message_target /= Void then
                     message_target.do_handle_2 (Current, SEL_CHANGED, message, ref_integer(scroll_position));
                  end
                  flags := flags | Flag_changed;
               end
               Result := True;
            end
         end
      end

   on_middle_btn_release (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         flgs: INTEGER;
      do
         flgs := flags;
         if is_enabled then
            release_mouse;
            unset_flags (Flag_pressed);
            unset_flags (Flag_changed);
            flags := flags | Flag_update;
            drag_point := 0;
            pressed := 0;
            set_scroll_position(scroll_position);
            update;
            if timer /= Void then
            	application.remove_timeout(timer)
            	timer := Void
            end
            if message_target /= Void
               and then message_target.handle_2 (Current, SEL_MIDDLEBUTTONRELEASE, message, data)
             then 
               Result := True;
            else
               if (flgs & Flag_changed) /= 0 then
                  if message_target /= Void then
                     message_target.do_handle_2 (Current, SEL_COMMAND, message, ref_integer (scroll_position))
                  end
               end
               Result := True;
            end
         end
      end

   on_right_btn_press (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         event: SB_EVENT;
         p: INTEGER;
      do
         event ?= data;
         check
            event /= Void
         end
         p := scroll_position;
         if is_enabled then
            grab_mouse;
            if timer /= Void then
            	application.remove_timeout(timer)
            	timer := Void
               if message_target /= Void 
                  and then message_target.handle_2 (Current, Sel_rightbuttonpress, message, data)
                then
                  Result := True;
               else
                  unset_flags (Flag_update);
                  if (options & SCROLLBAR_HORIZONTAL) /= 0 then
                     -- Horizontal scrollbar
                     if event.win_x<height then
                        -- Left arrow
                        pressed := PRESSED_DEC;
                        timer := application.add_timeout(application.scroll_delay, Current, ID_AUTODEC_PIX);
                        p := scroll_position-1;
                        update;
                     elseif width-height <= event.win_x then
                        -- Right arrow
                        pressed := PRESSED_INC;
                        timer := application.add_timeout(application.scroll_delay, Current, ID_AUTOINC_PIX);
                        p := scroll_position+1;
                        update;
                     elseif event.win_x<thumb_position then 
                        -- Page left
                        pressed := PRESSED_PAGEDEC;
                        timer := application.add_timeout(application.scroll_delay, Current, ID_AUTODEC_LINE);
                        p := scroll_position-line_size;
                        update;
                     elseif thumb_position+thumb_size <= event.win_x then
                        -- Page right
                        pressed := PRESSED_PAGEINC;
                        timer := application.add_timeout(application.scroll_delay, Current, ID_AUTOINC_LINE);
                        p := scroll_position+line_size;
                        update;
                     else
                        -- Grabbed the puck
                        pressed := PRESSED_FINETHUMB;
                        drag_point := event.win_x;
                        flags := flags | Flag_pressed;
                     end
                  else
                     -- Vertical scrollbar
                     if event.win_y < width then
                        -- Up arrow
                        pressed := PRESSED_DEC;
                        timer := application.add_timeout(application.scroll_delay, Current, ID_AUTODEC_PIX);
                        p := scroll_position - 1;
                        update;
                     elseif height - width <= event.win_y then
                        -- Down arrow
                        pressed := PRESSED_INC;
                        timer := application.add_timeout(application.scroll_delay, Current, ID_AUTOINC_PIX);
                        p := scroll_position + 1;
                        update;
                     elseif event.win_y < thumb_position then
                        -- Page up
                        pressed := PRESSED_PAGEDEC;
                        timer := application.add_timeout(application.scroll_delay, Current, ID_AUTODEC_LINE);
                        p := scroll_position - line_size;
                        update;
                     elseif thumb_position + thumb_size <= event.win_y then
                        -- Page down
                        pressed := PRESSED_PAGEINC;
                        timer := application.add_timeout(application.scroll_delay, Current, ID_AUTOINC_LINE);
                        p := scroll_position + line_size;
                        update;
                     else
                        -- Grabbed the puck
                        pressed := PRESSED_FINETHUMB;
                        flags := flags | Flag_pressed;
                     end
                  end
                  if p < 0 then p := 0 end
                  if p > (range - page_size) then p := range - page_size end
                  if p /= scroll_position then
                     set_scroll_position(p);
                     if message_target /= Void then
                        message_target.do_handle_2 (Current, SEL_CHANGED, message, ref_integer(scroll_position));
                     end
                     flags := flags | Flag_changed;
                  end
                  Result := True;
               end
            end
         end
      end

   on_right_btn_release (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         flgs: INTEGER
      do
         flgs := flags;
         if is_enabled then
            release_mouse;
            unset_flags (Flag_pressed)
            unset_flags (Flag_changed)
            flags := flags | Flag_update
            drag_point := 0
            pressed := 0
            set_scroll_position (scroll_position)
            update
            if timer /= Void then
            	application.remove_timeout (timer)
            	timer := Void
            end
            if message_target /= Void
               and then message_target.handle_2 (Current, Sel_rightbuttonrelease, message, data) then
               Result := True
            else
               if (flgs & Flag_changed) /= 0 then
                  if message_target /= Void
                   then message_target.do_handle_2 (Current, SEL_COMMAND, message, ref_integer (scroll_position))
                  end
               end
               Result := True
            end
         end
      end

   on_ungrabbed (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         Result := Precursor(sender, selector, data);
         if timer /= Void then
         	application.remove_timeout(timer)
         	timer := Void
         end
         unset_flags (Flag_pressed);
         unset_flags (Flag_changed);
         flags := flags | Flag_update;
         drag_point := 0;
         pressed := 0;
         Result := True;
      end

   on_time_inc_pix (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         p: INTEGER;
      do
         p := scroll_position + 1;
         if p >= (range - page_size) then
            p := range - page_size;
            timer := Void;
         else
            timer := application.add_timeout(application.scroll_speed, Current, ID_AUTOINC_PIX);
         end
         if p /= scroll_position then
            set_scroll_position(p);
            if message_target /= Void then
               message_target.do_handle_2 (Current, SEL_CHANGED, message, ref_integer(scroll_position));
            end
            flags := flags | Flag_changed;
            Result := True;
         end
      end

   on_time_inc_line (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         p: INTEGER;
      do
         p := scroll_position + line_size;
         if p >= (range - page_size) then
            p := range - page_size;
            timer := Void;
         else
            timer := application.add_timeout(application.scroll_speed, Current, ID_AUTOINC_LINE);
         end
         if p /= scroll_position then
            set_scroll_position(p);
            if message_target /= Void then
               message_target.do_handle_2 (Current, SEL_CHANGED, message, ref_integer(scroll_position));
            end
            flags := flags | Flag_changed;
            Result := True;
         end
      end

   on_time_inc_page (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         p: INTEGER;
      do
         p := scroll_position + page_size;
         if p >= (range - page_size) then
            p := range - page_size;
            timer := Void;
         else
            timer := application.add_timeout(application.scroll_speed, Current, ID_AUTOINC_PAGE);
         end
         if p /= scroll_position then
            set_scroll_position(p);
            if message_target /= Void then
               message_target.do_handle_2 (Current, SEL_CHANGED, message, ref_integer(scroll_position));
            end
            flags := flags | Flag_changed;
            Result := True;
         end
      end

   on_time_dec_pix (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         p: INTEGER;
      do
         p := scroll_position - 1;
         if p <= 0 then
            p := 0;
            timer := Void;
         else
            timer := application.add_timeout(application.scroll_speed, Current, ID_AUTODEC_PIX);
         end
         if p /= scroll_position then
            set_scroll_position(p);
            if message_target /= Void then
               message_target.do_handle_2 (Current, SEL_CHANGED, message, ref_integer(scroll_position));
            end
            flags := flags | Flag_changed;
            Result := True;
         end
      end

   on_time_dec_line (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         p: INTEGER;
      do
         p := scroll_position - line_size;
         if p <= 0 then
            p := 0;
            timer := Void;
         else
            timer := application.add_timeout(application.scroll_speed, Current, ID_AUTODEC_LINE);
         end
         if p /= scroll_position then
            set_scroll_position(p);
            if message_target /= Void then
               message_target.do_handle_2 (Current, SEL_CHANGED, message, ref_integer(scroll_position));
            end
            flags := flags | Flag_changed;
            Result := True;
         end
      end

   on_time_dec_page (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         p: INTEGER;
      do
         p := scroll_position - page_size;
         if p <= 0 then
            p := 0;
            timer := Void;
         else
            timer := application.add_timeout(application.scroll_speed, Current, ID_AUTODEC_PAGE);
         end
         if p /= scroll_position then
            set_scroll_position(p);
            if message_target /= Void then
               message_target.do_handle_2 (Current, SEL_CHANGED, message, ref_integer(scroll_position));
            end
            flags := flags | Flag_changed;
            Result := True;
         end
      end

   on_time_wheel (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         p: INTEGER
      do
         timer := Void;
         if drag_point < scroll_position then
            p := scroll_position + drag_jump
            if p <= drag_point then
               set_scroll_position (drag_point)
               if message_target /= Void then
                  message_target.do_handle_2 (Current, SEL_COMMAND, message, ref_integer (scroll_position))
               end
               drag_point := 0
            else
               set_scroll_position (p)
               if message_target /= Void then
                  message_target.do_handle_2 (Current, SEL_CHANGED, message, ref_integer (scroll_position))
               end
               timer := application.add_timeout (5, Current, ID_TIMEWHEEL)
            end
         else
            p := scroll_position + drag_jump
            if p >= drag_point then
               set_scroll_position (drag_point)
               if message_target /= Void then
                  message_target.do_handle_2 (Current, SEL_COMMAND, message, ref_integer(scroll_position))
               end
               drag_point := 0
            else
               set_scroll_position (p)
               if message_target /= Void then
                  message_target.do_handle_2 (Current, SEL_CHANGED, message, ref_integer(scroll_position));
               end
               timer := application.add_timeout (5, Current, ID_TIMEWHEEL)
            end
         end
         Result := True
      end

   on_cmd_set_value, on_cmd_set_int_value (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         p: INTEGER_REF
      do
         p ?= data
         check
            p /= Void
         end
         set_scroll_position (p.item)
         Result := True
      end

   on_cmd_get_int_value (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         p: INTEGER_REF
      do
         p ?= data
         check
            p /= Void
         end
         p.set_item (scroll_position)
         Result := True
      end

   on_cmd_set_int_range (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         p: SB_POINT
      do
         p ?= data
         check
            p /= Void
         end
         set_scroll_position (p.y)
         Result := True;
      end

   on_cmd_get_int_range (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         p: SB_POINT
      do
         p ?= data
         check
            p /= Void
         end
         p.set_x (0)
         p.set_y (scroll_position)
         Result := True
      end

feature -- Destruction

   destruct
      do
         if timer /= Void then
            application.remove_timeout (timer)
            timer := Void
         end
         Precursor
      end


feature {NONE} -- Implementation

   THUMB_MINIMUM: INTEGER = 8
   BAR_SIZE: INTEGER = 15
   
   PRESSED_INC		: INTEGER_8 = 1
   PRESSED_DEC		: INTEGER_8 = 2
   PRESSED_PAGEINC	: INTEGER_8 = 4
   PRESSED_PAGEDEC	: INTEGER_8 = 8
   PRESSED_THUMB	: INTEGER_8 = 16
   PRESSED_FINETHUMB: INTEGER_8 = 32

   SCROLLBAR_MASK: INTEGER
      once
         Result := SCROLLBAR_HORIZONTAL
      end

   thumb_size		: INTEGER	-- Thumb size
   thumb_position	: INTEGER	-- Thumb scroll_position
   
   timer			: SB_TIMER	-- Autoscroll timer
   
   drag_point		: INTEGER  -- Point where is_mouse_grabbed
   drag_jump		: INTEGER  -- Jump Current much
   
   pressed			: INTEGER_8	-- Action being undertaken

   draw_button (dc: SB_DC_WINDOW; x,y, w,h: INTEGER; down: BOOLEAN)
      do
         dc.set_foreground (back_color)
         dc.fill_rectangle (x+2, y+2, w-4, h-4)
         if not down then
            dc.set_foreground (back_color)
            dc.fill_rectangle (x, y, w-1, 1)
            dc.fill_rectangle (x, y, 1, h-1)
            dc.set_foreground (hilite_color)
            dc.fill_rectangle (x+1, y+1, w-2, 1)
            dc.fill_rectangle (x+1, y+1, 1, h-2)
            dc.set_foreground (shadow_color)
            dc.fill_rectangle (x+1, y+h-2, w-2, 1)
            dc.fill_rectangle (x+w-2, y+1, 1, h-2)
            dc.set_foreground (border_color)
            dc.fill_rectangle (x, y+h-1, w, 1)
            dc.fill_rectangle (x+w-1, y, 1, h)
         else
            dc.set_foreground (border_color)
            dc.fill_rectangle (x, y, w-2, 1)
            dc.fill_rectangle (x, y, 1, h-2)
            dc.set_foreground (shadow_color)
            dc.fill_rectangle (x+1, y+1, w-3, 1)
            dc.fill_rectangle (x+1, y+1, 1, h-3)
            dc.set_foreground (hilite_color)
            dc.fill_rectangle (x, y+h-1, w-1, 1)
            dc.fill_rectangle (x+w-1, y+1, 1, h-1)
            dc.set_foreground (back_color)
            dc.fill_rectangle (x+1, y+h-2, w-1, 1)
            dc.fill_rectangle (x+w-2, y+2, 1, h-2)
         end
      end

   draw_left_arrow (dc: SB_DC_WINDOW; x_, y_, w, h: INTEGER; down: BOOLEAN)
      local
         points: ARRAY [ SB_POINT ]
         ah,ab: INTEGER
         pt: SB_POINT
         x,y: INTEGER
      do
         x := x_; y := y_
         create points.make (0, 2)
         ab := (h-7) | 1
         ah := ab // 2
         x := x+((w-ah) // 2)
         y := y+((h-ab) // 2)
         if down then x := x + 1; y := y + 1 end
         create pt.make (x+ah, y)
         points.put (pt, 0)
         create pt.make (x+ah, y+ab-1)
         points.put (pt, 1)
         create pt.make (x, y+(ab//2))
         points.put (pt, 2)
         dc.set_foreground (arrow_color)
         dc.fill_polygon (points)
      end

   draw_right_arrow (dc: SB_DC_WINDOW; x_, y_, w, h: INTEGER; down: BOOLEAN)
      local
         points: ARRAY [ SB_POINT ]
         ah,ab: INTEGER
         pt: SB_POINT
         x,y: INTEGER
      do
         x := x_; y := y_
         create points.make (0, 2)
         ab := (h-7) | 1
         ah := ab // 2
         x := x+((w-ah) // 2)
         y := y+((h-ab) // 2)
         if down then x := x + 1; y := y + 1 end
         create pt.make (x,y)
         points.put (pt, 0)
         create pt.make (x, y+ab-1)
         points.put (pt, 1)
         create pt.make (x+ah, y+(ab // 2))
         points.put (pt, 2)
         dc.set_foreground (arrow_color)
         dc.fill_polygon (points)
      end

   draw_up_arrow (dc: SB_DC_WINDOW; x_, y_, w, h: INTEGER; down: BOOLEAN)
      local
         points: ARRAY [ SB_POINT ]
         ah,ab: INTEGER
         pt: SB_POINT
         x,y: INTEGER
      do
         x := x_; y := y_
         create points.make(0, 2)
         ab := (w - 7) | 1
         ah := ab // 2
         x := x + ((w-ab) // 2)
         y := y + ((h-ah) // 2)
         if down then x := x + 1; y := y + 1 end
         create pt.make (x + (ab // 2), y-1)
         points.put (pt, 0);
         create pt.make (x, y+ah)
         points.put (pt, 1)
         create pt.make (x+ab, y+ah)
         points.put (pt, 2)
         dc.set_foreground (arrow_color)
         dc.fill_polygon (points)
      end

   draw_down_arrow (dc: SB_DC_WINDOW; x_, y_, w, h: INTEGER; down: BOOLEAN)
      local
         points: ARRAY [ SB_POINT ]
         ah,ab: INTEGER
         pt: SB_POINT
         x,y: INTEGER
      do
         x := x_; y := y_
         create points.make (0, 2)
         ab := (w - 7) | 1
         ah := ab // 2
         x := x + ((w - ab) // 2)
         y := y + ((h - ah) // 2)
         if down then x := x + 1; y := y + 1 end
         create pt.make (x + 1, y)
         points.put (pt, 0)
         create pt.make (x + ab - 1, y)
         points.put (pt, 1);
         create pt.make (x + ab // 2, y + ah)
         points.put (pt, 2)
         dc.set_foreground (arrow_color)
         dc.fill_polygon (points)
      end

   layout is
      do
         set_scroll_position (scroll_position)
         unset_flags (Flag_dirty)
      end

end
