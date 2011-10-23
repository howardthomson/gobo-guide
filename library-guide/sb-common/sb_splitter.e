note
	description: "[
		Splitter window is used to interactively repartition two or more subpanes.
		Space may be subdivided horizontally or vertically.
	]"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"


	todo: "[
		Why are some of the handle selectors commented out ???
	]"

class SB_SPLITTER

inherit

	SB_COMPOSITE
		rename
        	make as make_composite
		redefine
        	handle_2,
        	default_height,
        	default_width,
        	layout,
        	on_focus_next,
        	on_focus_prev,
        	on_left_btn_press,
        	on_left_btn_release,
        	on_motion,
        	destruct,
        	class_name
		end

	SB_SPLITTER_CONSTANTS

--	SB_PV_ORIENTATION
		-- Conflict between inherited
		--		SB_PROPERTY_VALUE [ INTEGER ]
		-- and	SB_PROPERTY_VALUE [ BOOLEAN ]

create

	make, make_sb, make_opts

feature { NONE } -- Private Attributes

	window: SB_WINDOW	-- Window being resized
	split:  INTEGER		-- Split value
	offset: INTEGER		-- Mouse offset

feature -- class name

	class_name: STRING
		once
			Result := "SB_SPLITTER"
		end

feature -- Creation

	make (p: SB_COMPOSITE)
			-- Construct new splitter widget
		do
			make_opts(p, Void, 0, SPLITTER_NORMAL, 0,0, 0,0)
		end

	make_sb(p: SB_COMPOSITE; o: INTEGER)
		do
			make_opts(p, Void,0, o, 0,0,0,0)
		end

	make_opts (p: SB_COMPOSITE; tgt: SB_MESSAGE_HANDLER; sel: INTEGER; opts: INTEGER;
				x, y, w, h: INTEGER) is
    		-- Construct new splitter widget, which will notify target about size changes
    	do
         	make_composite (p, opts, x,y, w,h)
         	flags := flags | Flag_enabled | Flag_shown
         
         	if (options & SPLITTER_VERTICAL) /= 0 then
            	default_cursor := application.get_default_cursor (Def_vsplit_cursor)
         	else
            	default_cursor := application.get_default_cursor (Def_hsplit_cursor)
         	end
         	drag_cursor := default_cursor
         	message_target := tgt
         	message := sel
         	window := Void
         	split := 0
         	offset := 0
         	bar_size := 4
      	end

feature -- Destruction

	destruct
		do
			window := Void
			Precursor
		end

feature -- Queries

	bar_size: INTEGER
		-- Size of the splitter bar

   default_width: INTEGER
         -- Get default width
      local
         child: SB_WINDOW
         w, numc: INTEGER
      do
         if (options & SPLITTER_VERTICAL) /= 0 then
            from
               child := first_child
            until
               child = Void
            loop
               if child.is_shown then
                  w := child.default_width
                  Result := Result.max(w)
               end
               child := child.next
            end
         else
            from
               child := first_child
            until
               child = Void
            loop
               if child.is_shown then
                  Result := Result + child.default_width
                  numc := numc + 1
               end
               child := child.next
            end
            if numc > 1 then
               Result := Result + (numc - 1) * bar_size
            end
         end
      end

   default_height: INTEGER
         -- Get default height
      local
         child: SB_WINDOW
         h, numc: INTEGER
      do
         if (options & SPLITTER_VERTICAL) /= 0 then
            from
               child := first_child
            until
               child = Void
            loop
               if child.is_shown then
                  Result := Result + child.default_height
                  numc := numc + 1
               end
               child := child.next
            end
            if numc > 1 then
               Result := Result + (numc - 1) * bar_size
            end
         else
            from
               child := first_child
            until
               child = Void
            loop
               if child.is_shown then
                  h := child.default_height
                  Result := Result.max(h)
               end
               child := child.next
            end
         end
      end

   set_splitter_style (style: INTEGER)
         -- Change splitter style
      local
         opts: INTEGER
         child: SB_WINDOW
      do
         opts := new_options (style, SPLITTER_MASK)
         if options /= opts then
            -- Split direction changed; need re-layout of everything
            if (opts & SPLITTER_VERTICAL) /= (options & SPLITTER_VERTICAL) then
               from
                  child := first_child
               until
                  child = Void
                  loop
                  if child.is_shown then
                     child.set_width (0)
                     child.set_height (0)
                  end
                  child := child.next
               end
               if (opts & SPLITTER_VERTICAL) /= 0 then
                  set_default_cursor (application.get_default_cursor (Def_vsplit_cursor))
               else
                  set_default_cursor (application.get_default_cursor (Def_hsplit_cursor))
               end
               set_drag_cursor (default_cursor)
               recalc
            end
            -- Split mode reversal; re-layout first and last only
            if (opts & SPLITTER_REVERSED) /= (options & SPLITTER_REVERSED) then
               if first_child /= Void then
                  first_child.set_width (0)
                  first_child.set_height (0)
                  last_child.set_width (0)
                  last_child.set_height (0)
               end
               recalc
            end
            options := opts
         end
      end

   get_splitter_style: INTEGER
         -- Return current splitter style
      do
         Result := (options & SPLITTER_MASK)
      end

   set_bar_size (bs: INTEGER)
         -- Change splitter bar size
      do
         if bs /= bar_size then
            bar_size := bs
            recalc
         end
      end

feature -- Message processing

	handle_2 (sender: SB_MESSAGE_HANDLER; type, key: INTEGER; data: ANY): BOOLEAN
    	do
--			if		match_function_2 (SEL_LEFTBUTTONPRESS,	0, type, key) then Result := on_left_btn_press (sender, key, data)
--			elseif  match_function_2 (SEL_LEFTBUTTONRELEASE,0, type, key) then Result := on_left_btn_release (sender, key, data)
--			elseif  match_function_2 (SEL_MOTION,			0, type, key) then Result := on_motion (sender, key, data)

         	if		match_function_2	(SEL_FOCUS_UP,		0, type, key) then Result := on_focus_up		(sender, key, data)
         	elseif  match_function_2	(SEL_FOCUS_DOWN,	0, type, key) then Result := on_focus_down	(sender, key, data)
         	elseif  match_function_2	(SEL_FOCUS_LEFT,	0, type, key) then Result := on_focus_left	(sender, key, data)
         	elseif  match_function_2	(SEL_FOCUS_RIGHT,	0, type, key) then Result := on_focus_right	(sender, key, data)
         	else Result := Precursor(sender, type, key, data); end
		end

   on_left_btn_press (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         ev: SB_EVENT
      do
         ev ?= data
         if is_enabled then
            grab_mouse
            if message_target /= Void
               and then message_target.handle_2 (Current, SEL_LEFTBUTTONRELEASE, message, data)
             then 
               Result := True
            elseif (options & SPLITTER_VERTICAL) /= 0 then
               window := find_v_split (ev.win_y)
               if window /= Void then
                  if (options & SPLITTER_REVERSED) /= 0 then
                     split := window.y_pos
                  else
                     split := window.y_pos + window.height
                  end
                  offset := ev.win_y - split
                  if (options & SPLITTER_TRACKING) = 0 then
                     draw_v_split (split)
                  end
                  flags := flags | Flag_pressed
                  unset_flags (Flag_update)
               end
            else
               window := find_h_split (ev.win_x)
               if window /= Void then
                  if (options & SPLITTER_REVERSED) /= 0 then
                     split := window.x_pos
                  else
                     split := window.x_pos + window.width
                  end
                  offset := ev.win_x - split
                  if (options & SPLITTER_TRACKING) = 0 then
                     draw_h_split (split)
                  end
               end
               flags := flags | Flag_pressed
               unset_flags (Flag_update)
            end
            Result := True
         end
      end

   on_left_btn_release (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         flgs: INTEGER
      do
         flgs := flags
         if is_enabled then
            release_mouse
            flags := flags | Flag_update
            unset_flags (Flag_changed)
            unset_flags (Flag_pressed)
            if message_target /= Void 
               and then message_target.handle_2 (Current, SEL_LEFTBUTTONRELEASE, message, data)
             then 
               Result := True
            elseif (flgs & Flag_pressed) /= 0 then
               if (options & SPLITTER_TRACKING) = 0 then
                  if (options & SPLITTER_VERTICAL) /= 0 then
                     draw_v_split(split)
                     adjust_v_layout
                  else
                     draw_h_split(split)
                     adjust_h_layout
                  end
                  if (flgs & Flag_changed) /= 0 then
                     if message_target /= Void then
                        message_target.do_handle_2 (Current, SEL_CHANGED, message, Void)
                     end
                  end
               end
               if (flgs & Flag_changed) /= 0 then
                  if message_target /= Void then
                     message_target.do_handle_2 (Current, SEL_COMMAND, message, Void)
                  end
               end
            end
            Result := True
         end
      end

   on_motion (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         ev: SB_EVENT
         oldsplit: INTEGER
      do
         ev ?= data
         if ev /= Void then
            if (flags & Flag_pressed) /= 0 then
               oldsplit := split
               if (options & SPLITTER_VERTICAL) /= 0 then
                  move_v_split(ev.win_y - offset)
                  if split /= oldsplit then
                     if (options & SPLITTER_TRACKING) = 0 then
                        draw_v_split(oldsplit)
                        draw_v_split(split)
                     else
                        adjust_v_layout
                        if message_target /= Void then
                           message_target.do_handle_2 (Current, SEL_CHANGED, message, Void)
                        end
                     end
                     flags := flags | Flag_changed
                  end
               else
                  move_h_split (ev.win_x - offset)
                  if split /= oldsplit then
                     if (options & SPLITTER_TRACKING) = 0 then
                        draw_h_split (oldsplit)
                        draw_h_split (split)
                     else
                        adjust_h_layout
                        if message_target /= Void then
                           message_target.do_handle_2 (Current, SEL_CHANGED, message, Void)
                        end
                     end
                     flags := flags | Flag_changed
                  end
               end
               Result := True
            end
         end
      end

   on_focus_next (sender: SB_MESSAGE_HANDLER; selector : INTEGER; data : ANY): BOOLEAN
      do
         if (options & SPLITTER_VERTICAL) /= 0 then
            Result := on_focus_down (sender,selector,data)
         else
            Result := on_focus_right (sender,selector,data)
         end
      end

   on_focus_prev (sender: SB_MESSAGE_HANDLER; selector : INTEGER; data : ANY): BOOLEAN
      do
         if (options & SPLITTER_VERTICAL) /= 0 then
            Result := on_focus_up (sender,selector,data)
         else
            Result := on_focus_left (sender,selector,data)
         end
      end

   on_focus_up (sender: SB_MESSAGE_HANDLER; selector : INTEGER; data : ANY): BOOLEAN
      local
         child: SB_WINDOW
      do
         if (options & SPLITTER_VERTICAL) /= 0 then
            from
               if focus_child /= Void then
                  child := focus_child.prev
               else
                  child := last_child
               end
            until
               Result or else child = Void
            loop
               if child.is_enabled and then child.can_focus then
                  child.do_handle_2 (Current, SEL_FOCUS_SELF, 0, data)
                  Result := True
               elseif child.is_composite and then
                  child.handle_2 (Current, SEL_FOCUS_UP, selector, data)
                then 
                  Result := True
               else
                  child := child.prev
               end
            end
         end
      end

   on_focus_down (sender: SB_MESSAGE_HANDLER; selector : INTEGER; data : ANY): BOOLEAN
      local
         child: SB_WINDOW
      do
         if (options & SPLITTER_VERTICAL) /= 0 then
            from
               if focus_child /= Void then
                  child := focus_child.next
               else
                  child := first_child
               end
            until
               Result or else child = Void
            loop
               if child.is_enabled and then child.can_focus then
                  child.do_handle_2 (Current, SEL_FOCUS_SELF, 0, data)
                  Result := True
               elseif child.is_composite and then
                  child.handle_2 (Current, SEL_FOCUS_DOWN, selector, data)
                then 
                  Result := True
               else
                  child := child.next
               end
            end
         end
      end

   on_focus_left (sender: SB_MESSAGE_HANDLER; selector : INTEGER; data : ANY): BOOLEAN
      local
         child: SB_WINDOW
      do
         if (options & SPLITTER_VERTICAL) = 0 then
            from
               if focus_child /= Void then
                  child := focus_child.prev
               else
                  child := last_child
               end
            until
               Result or else child = Void
            loop
               if child.is_enabled and then child.can_focus then
                  child.do_handle_2 (Current, SEL_FOCUS_SELF, 0, data)
                  Result := True
               elseif child.is_composite and then
                  child.handle_2 (Current, SEL_FOCUS_LEFT, selector, data)
                then 
                  Result := True
               else
                  child := child.prev
               end
            end
         end
      end

   on_focus_right (sender: SB_MESSAGE_HANDLER; selector : INTEGER; data : ANY): BOOLEAN
      local
         child: SB_WINDOW
      do
         if (options & SPLITTER_VERTICAL) = 0 then
            from
               if focus_child /= Void then
                  child := focus_child.next
               else
                  child := first_child
               end
            until
               Result or else child = Void
            loop
               if child.is_enabled and then child.can_focus then
                  child.do_handle_2 (Current, SEL_FOCUS_SELF, 0, data)
                  Result := True
               elseif child.is_composite and then
                  child.handle_2 (Current, SEL_FOCUS_RIGHT, selector, data)
                then 
                  Result := True
               else
                  child := child.next
               end
            end
         end
      end

feature {NONE} -- Implementation

   layout
      local
         pos,w,h: INTEGER
         child,stretcher: SB_WINDOW
      do  
         if (options & SPLITTER_VERTICAL) /= 0 then
            -- Vertical
            if (options & SPLITTER_REVERSED) /= 0 then
               pos := height
               from
                  stretcher := first_child
               until
                  stretcher = Void or else stretcher.is_shown
               loop
                  stretcher := stretcher.next
               end
               from
                  child := last_child
               until
                  child = Void
               loop
                  if child.is_shown then
                     w := child.width
                     h := child.height
                     if w <= 1  and then h <= 1 then
                        h := child.default_height
                     end
                     if child = stretcher then
                        h := pos.max(0)
                     end
                     child.position(0, pos - h, width, h)
                     pos := pos - h - bar_size
                  end
                  child := child.prev
               end
            else
               pos := 0
               from
                  stretcher := last_child
               until
                  stretcher = Void or else stretcher.is_shown
               loop
                  stretcher := stretcher.prev
               end
               from
                  child := first_child
               until
                  child = Void
               loop
                  if child.is_shown then
                     w := child.width
                     h := child.height
                     if w <= 1  and then h <= 1 then
                        h := child.default_height
                     end
                     if child = stretcher then
                        h := (height-pos).max(0)
                     end
                     child.position(0,pos,width,h)
                     pos := pos+h+bar_size
                  end
                  child := child.next
               end
            end
         else
            -- Horizontal
            if (options & SPLITTER_REVERSED) /= 0 then
               pos := width
               from
                  stretcher := first_child
               until
                  stretcher = Void or else stretcher.is_shown
               loop
                  stretcher := stretcher.next
               end
               from
                  child := last_child
               until
                  child = Void
               loop
                  if child.is_shown then
                     w := child.width
                     h := child.height
                     if w <= 1  and then h <= 1 then
                        w := child.default_width
                     end
                     if child = stretcher then
                        w := pos.max(0)
                     end
                     child.position(pos-w,0,w,height)
                     pos := pos-w-bar_size
                  end
                  child := child.prev
               end
            else
               pos := 0
               from
                  stretcher := last_child
               until
                  stretcher = Void or else stretcher.is_shown
               loop
                  stretcher := stretcher.prev
               end
               from
                  child := first_child
               until
                  child = Void
               loop
                  if child.is_shown then
                     w := child.width
                     h := child.height
                     if w <= 1  and then h <= 1 then
                        w := child.default_width
                     end
                     if child = stretcher then
                        w := (width-pos).max(0)
                     end
                     child.position(pos,0,w,height)
                     pos := pos+w+bar_size
                  end
                  child := child.next
               end
            end
         end
         unset_flags (Flag_dirty)
      end

   adjust_h_layout
      local
         pos, w, h: INTEGER;
         child, stretcher: SB_WINDOW;
      do
         if window = Void then
            -- TODO Error reporting
         else
            if (options & SPLITTER_REVERSED) /= 0 then
               pos := window.x_pos + window.width;
               window.position(split,0,pos-split,height);
               pos := split-bar_size;
               from
                  stretcher := first_child
               until
                  stretcher = Void or else stretcher.is_shown
               loop
                  stretcher := stretcher.next;
               end
               from
                  child := window.prev
               until
                  child = Void
               loop
                  if child.is_shown then
                     w := child.width;
                     h := child.height;
                     if w <= 1  and then h <= 1 then
                        w := child.default_width;
                     end
                     if child = stretcher then
                        w := pos.max(0)
                     end
                     child.position(pos-w,0,w,height);
                     pos := pos-w-bar_size;
                  end
                  child := child.prev;
               end
            else
               pos := window.x_pos;
               window.position(pos,0,split-pos,height);
               pos := split+bar_size;
               from
                  stretcher := last_child
               until
                  stretcher = Void or else stretcher.is_shown
               loop
                  stretcher := stretcher.prev;
               end
               from
                  child := window.next
               until
                  child = Void
               loop
                  if child.is_shown then
                     w := child.width;
                     h := child.height;
                     if w <= 1  and then h <= 1 then
                        w := child.default_width;
                     end
                     if child = stretcher then
                        w := (width-pos).max(0)
                     end
                     child.position(pos,0,w,height);
                     pos := pos+w+bar_size;
                  end
                  child := child.next;
               end
            end
         end
      end

   adjust_v_layout
      local
         pos,w,h: INTEGER;
         child,stretcher: SB_WINDOW;
      do
         if window = Void then
            -- TODO Error reporting
         else
            if (options & SPLITTER_REVERSED) /= 0 then
               pos := window.y_pos + window.height;
               window.position(0,split,width,pos-split);
               pos := split - bar_size;
               from
                  stretcher := first_child
               until
                  stretcher = Void or else stretcher.is_shown
               loop
                  stretcher := stretcher.next;
               end
               from
                  child := window.prev
               until
                  child = Void
               loop
                  if child.is_shown then
                     w := child.width;
                     h := child.height;
                     if w <= 1  and then h <= 1 then
                        h := child.default_height;
                     end
                     if child = stretcher then
                        h := pos.max(0)
                     end
                     child.position(0,pos-h,width,h);
                     pos := pos-h-bar_size;
                  end
                  child := child.prev;
               end
            else
               pos := window.y_pos;
               window.position(0, pos, width, split - pos);
               pos := split + bar_size;
               from
                  stretcher := last_child
               until
                  stretcher = Void or else stretcher.is_shown
               loop
                  stretcher := stretcher.prev;
               end
               from
                  child := window.next
               until
                  child = Void
               loop
                  if child.is_shown then
                     w := child.width;
                     h := child.height;
                     if w <= 1  and then h <= 1 then
                        h := child.default_height;
                     end
                     if child = stretcher then
                        h := (height-pos).max(0)
                     end
                     child.position(0,pos,width,h);
                     pos := pos+h+bar_size;
                  end
                  child := child.next;
               end
            end
         end
      end
      
   move_h_split (pos: INTEGER)
         -- Move the horizontal split intelligently
      local
         smin,smax: INTEGER;
         hints: INTEGER;
      do
         if window = Void then
            -- TODO Error reporting
         else
            hints := window.layout_hints;
            if (options & SPLITTER_REVERSED) /= 0 then
               smin := bar_size;
               smax := window.x_pos + window.width;
               if (hints & Layout_fill_x) /= 0 
                  and then (hints & Layout_fix_width) /= 0
                then 
                  smax := smax - window.default_width;
               end
            else
               smin := window.x_pos;
               smax := width - bar_size;
               if (hints & Layout_fill_x) /= 0 
                  and then (hints & Layout_fix_width) /= 0
                then 
                  smin := smin + window.default_width;
               end
            end
            split := pos;
            split := split.max (smin);
            split := split.min (smax);
         end
      end

   move_v_split (pos: INTEGER)
         -- Move the vertical split intelligently
      local
         smin, smax: INTEGER
         hints: INTEGER
      do
         if window = Void then
            -- TODO Error reporting
         else
            hints := window.layout_hints
            if (options & SPLITTER_REVERSED) /= 0 then
               smin := bar_size
               smax := window.y_pos+window.height
               if (hints & Layout_fill_y) /= 0 
                  and then (hints & Layout_fix_height) /= 0
                then 
                  smax := smax - window.default_height
               end
            else
               smin := window.y_pos
               smax := height-bar_size
               if (hints & Layout_fill_y) /= 0 
                  and then (hints & Layout_fix_height) /= 0
                then 
                  smin := smin + window.default_height
               end
            end
            split := pos
            split := split.max(smin)
            split := split.min(smax)
         end
      end

   draw_h_split (pos: INTEGER)
      local
         dc: SB_DC_WINDOW
      do
         dc := paint_dc
         dc.make (Current)
         dc.clip_children (False)
         dc.set_function (dc.Blt_not_dst);  -- Does this always show up?
         dc.fill_rectangle(pos, 0, bar_size, height)
         dc.stop;
      end

   draw_v_split (pos: INTEGER)
      local
         dc: SB_DC_WINDOW
      do
         dc := paint_dc
         dc.make (Current)
         dc.clip_children (False)
         dc.set_function (dc.Blt_not_dst)  -- Does this always show up?
         dc.fill_rectangle (0, pos, width, bar_size)
         dc.stop
      end

   find_h_split (pos: INTEGER): SB_WINDOW
         -- Find child just before split
      local
         done: BOOLEAN;
      do
         Result := first_child;
         if (options & SPLITTER_REVERSED) /= 0 then
            from
               done := False;
            until
               done or else Result = Void
            loop
               if Result.is_shown then
                  if Result.x_pos - bar_size <= pos  and then pos < Result.x_pos then
                     done := True;
                  end
               end
               if not done then
                  Result := Result.next
               end
            end
         else
            from
               done := False;
            until
               done or else Result = Void
            loop
               if Result.is_shown then
                  if Result.x_pos + Result.width <= pos
                     and then pos < Result.x_pos + Result.width + bar_size
                   then
                     done := True;
                  end
               end
               if not done then
                  Result := Result.next
               end
            end
         end
      end

   find_v_split (pos: INTEGER): SB_WINDOW
         -- Find child just before split
      local
         done: BOOLEAN;
      do
         Result := first_child;
         if (options & SPLITTER_REVERSED) /= 0 then
            from
               done := False;
            until
               done or else Result = Void
            loop
               if Result.is_shown then
                  if Result.y_pos - bar_size <= pos  and then pos < Result.y_pos then
                     done := True;
                  end
               end
               if not done then
                  Result := Result.next
               end
            end
         else
            from
               done := False;
            until
               done or else Result = Void
            loop
               if Result.is_shown then
                  if Result.y_pos + Result.height <= pos
                     and then pos < Result.y_pos + Result.height + bar_size
                   then
                     done := True;
                  end
               end
               if not done then
                  Result := Result.next
               end
            end
         end
      end
end
