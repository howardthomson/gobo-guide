indexing
	description: "[
		The scroll area widget manages a content area and a viewport
		area through which the content is viewed.  When the content area
		becomes larger than the viewport area, scrollbars are placed to
		permit viewing of the entire content by scrolling the content.
		Depending on the mode, scrollbars may be displayed on an as-needed
		basis, always, or never.
		Normally, the scroll area's size and the content's size are independent;
		however, it is possible to disable scrolling in the h_scroll_bar
		(vertical) direction.  In Current case, the content width (height)
		will influence the width (height) of the scroll area widget.
		For content which is time-consuming to repaint, continuous
		scrolling may be turned off.
	]"

	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

	todo: "[
		Check sizing of the vertical scroll bar - malfunction when displayed
		as a child of an SB_TAB_BOOK.
	
		Review constraint on pos_x/pos_y both <= 0
		On reduction of the content size, e.g. on tree compaction, the content
		could usefully not move w.r.t. the cursor, with left/top space infilled
		with hatched/shaded area, subject to smooth movement back to the normal
		offset.
	]"

class SB_SCROLL_AREA

inherit

	SB_COMPOSITE
		rename
			make as composite_make
		redefine
			make_ev,
        	default_height,
        	default_width,
        	destruct,
        	layout,
        	handle_2,
			class_name,
        	on_key_press,
        	on_key_release,
        	on_right_btn_press,
        	on_right_btn_release	--,
--        	set_parent
      	end

	SB_SCROLL_AREA_CONSTANTS

	SB_SCROLL_BAR_CONSTANTS

creation

	make, make_opts, make_ev

feature -- class name

	class_name: STRING is
		once
			Result := "SB_SCROLL_AREA"
		end

feature {NONE} -- Creation

	make_ev is
		do
			make (Void, 0)
		end

	make (p: SB_COMPOSITE; opts: INTEGER) is
		do
			make_opts (p, opts, 0,0,0,0)
		end

	make_opts (p: SB_COMPOSITE; opts: INTEGER; x,y, w,h: INTEGER) is
		do
        	composite_make (p, opts, x,y, w,h)
         	flags := flags | Flag_shown
         	create h_scroll_bar.make_opts (Current, Current, Id_hscrolled, SCROLLBAR_HORIZONTAL, 0,0,0,0)
         	create v_scroll_bar.make_opts (Current, Current, Id_vscrolled, SCROLLBAR_VERTICAL,   0,0,0,0)
         	create scroll_corner.make (Current)
         	back_color := application.back_color
         	viewport_w := 1
         	viewport_h := 1
         	content_w := 1
        	content_h := 1
		end

	XXset_parent (a_parent: SB_COMPOSITE) is
		do
			Precursor (a_parent)
	--		if parent = Void then
	         	create h_scroll_bar.make_opts (Current, Current, Id_hscrolled, SCROLLBAR_HORIZONTAL, 0,0,0,0)
	         	create v_scroll_bar.make_opts (Current, Current, Id_vscrolled, SCROLLBAR_VERTICAL,   0,0,0,0)
	         	create scroll_corner.make (Current)
	--		end
		end

feature -- Attributes

	h_scroll_bar: SB_SCROLL_BAR
	v_scroll_bar: SB_SCROLL_BAR
	
	pos_x: INTEGER	-- X position of content relative to left of viewport
	pos_y: INTEGER	-- Y position of content relative to top  of viewport

feature { NONE } -- Implementation attributes

	scroll_corner: SB_SCROLL_CORNER

	scroll_timer: SB_TIMER
  
	viewport_w: INTEGER	--
	viewport_h: INTEGER	-- Viewport size reduced by scrollbar active screen space
   
	content_w: INTEGER		-- Content size, potentially larger, (or smaller), than
	content_h: INTEGER		-- the viewport size.
   
feature -- Queries

	default_width: INTEGER is
    		-- Get default width
      	local
         	w: INTEGER
      	do
         	if (options & HSCROLLER_NEVER) /= Zero 
            	and then (options & HSCROLLER_ALWAYS) /= Zero
          	then
          	--	fx_trace(0, <<"SB_SCROLL_AREA::default_width">> )
            	w := content_width
         	end
         	if (options & VSCROLLER_NEVER) = Zero then w := w + v_scroll_bar.default_width end
         	if (options & HSCROLLER_NEVER) = Zero then w := w + h_scroll_bar.default_width end
         	Result := w.max(1)
      	end

	default_height: INTEGER is
			-- Get default height
		local
         	h: INTEGER
      	do
         	if (options & VSCROLLER_NEVER) /= Zero 
            	and then (options & VSCROLLER_ALWAYS) /= Zero
          	then
            	h := content_height
         	end
         	if (options & VSCROLLER_NEVER) = Zero then h := h + v_scroll_bar.default_height end
         	if (options & HSCROLLER_NEVER) = Zero then h := h + h_scroll_bar.default_height end
         	Result := h.max(1)
      	end

	viewport_height: INTEGER is
    		-- Return viewport height
      	do
         	Result := height
      	end

	viewport_width: INTEGER is
    		-- Return viewport width
      	do
         	Result := width
      	end

	content_width: INTEGER is
    		-- Return content width
      	do
         	Result := 1
      	end

	content_height: INTEGER is
    		-- Return content height
      	do
         	Result := 1
      	end

	get_scroll_style: INTEGER is
    		-- Return scroll style
      	do
         	Result := (options & SCROLLER_MASK)
      	end

	is_h_scrollable: BOOLEAN is
    		-- Return True if horizontally scrollable
		do
        	Result :=  (options & HSCROLLER_NEVER ) = Zero 
        	   or else (options & HSCROLLER_ALWAYS) = Zero
      	end

	is_v_scrollable: BOOLEAN is
    		-- Return True if vertically scrollable
		do
			Result := (options & VSCROLLER_NEVER ) = Zero
			  or else (options & VSCROLLER_ALWAYS) = Zero
      	end

feature -- Actions

	set_scroll_style (style: INTEGER) is
    		-- Change scroll style
      	local
         	opts: INTEGER
      	do
         	opts := new_options (style, SCROLLER_MASK)
         	if options /= opts then
            	options := opts
            	recalc
         	end
      	end

   set_scroll_position (x, y: INTEGER) is
         -- Set the current position
      local
         new_x, new_y: INTEGER
      do
         	-- Set scroll bars
         h_scroll_bar.set_scroll_position(- x)
         v_scroll_bar.set_scroll_position(- y)

         	-- Then read back valid position from scroll bars
         new_x := - h_scroll_bar.scroll_position
         new_y := - v_scroll_bar.scroll_position

         	-- Move content if there's a change
         if new_x /= pos_x or else new_y /= pos_y then
            move_contents (new_x, new_y)
         end
      end

	move_contents (x, y: INTEGER) is
    		-- Move content
    	local
         	dx, dy: INTEGER
      	do
         	dx := x - pos_x
         	dy := y - pos_y
         	pos_x := x
         	pos_y := y
		--	fx_trace(0, <<"SB_SCROLL_AREA::move_contents - dx: ", dx.out, " dy: ", dy.out>>)
         	scroll(0, 0, viewport_w, viewport_h, dx, dy)
      	end

feature -- Message processing

	handle_2 (sender: SB_MESSAGE_HANDLER; type, key: INTEGER; data: ANY): BOOLEAN is
    	do
        	if		match_function_2 (SEL_MOUSEWHEEL,0,				type, key) then Result := on_v_mouse_wheel (sender, key, data)
        	elseif  match_function_2 (SEL_COMMAND, Id_hscrolled,	type, key) then Result := on_h_scroller_changed (sender, key, data)
        	elseif  match_function_2 (SEL_COMMAND, Id_vscrolled,	type, key) then Result := on_v_scroller_changed (sender, key, data)
        	elseif  match_function_2 (SEL_CHANGED, Id_hscrolled,	type, key) then Result := on_h_scroller_dragged (sender, key, data)
        	elseif  match_function_2 (SEL_CHANGED, Id_vscrolled,	type, key) then Result := on_v_scroller_dragged (sender, key, data)
        	elseif  match_function_2 (Sel_timeout, Id_autoscroll,	type, key) then Result := on_auto_scroll (sender, key, data)
        	else Result := Precursor(sender, type, key, data)
        	end
		end

   	on_key_press (sender: SB_MESSAGE_HANDLER; key: INTEGER; data: ANY): BOOLEAN is
   		do
   		--	fx_trace(0, <<"SB_SCROLL_AREA::on_key_press">>)
   			Result := Precursor (sender, key, data)
   		end

   	on_key_release (sender: SB_MESSAGE_HANDLER; key: INTEGER; data: ANY): BOOLEAN is
   		do
   		--	fx_trace(0, <<"SB_SCROLL_AREA::on_key_release">>)
   			Result := Precursor (sender, key, data)
   		end

   	on_right_btn_press (sender: SB_MESSAGE_HANDLER; key: INTEGER; data: ANY): BOOLEAN is
   		do
   		--	fx_trace(0, <<"SB_SCROLL_AREA::on_right_btn_press">>)
   			Result := Precursor (sender, key, data)
   		end

   	on_right_btn_release (sender: SB_MESSAGE_HANDLER; key: INTEGER; data: ANY): BOOLEAN is
   		do
   		--	fx_trace(0, <<"SB_SCROLL_AREA::on_right_btn_release">>)
   			Result := Precursor (sender, key, data)
   		end

	on_h_mouse_wheel (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
    	do
        	h_scroll_bar.do_handle_2 (sender, SEL_MOUSEWHEEL, selector, data)
        	Result := True
      	end

	on_v_mouse_wheel (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
			-- Process (vertical ?) mouse wheel event
			-- Occurs only if window is 'enabled'
    	do
        	v_scroll_bar.do_handle_2 (sender, SEL_MOUSEWHEEL, selector, data)
        	Result := True
      	end

	on_h_scroller_changed (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
			-- Called from horizontal scroll bar on change
	   	local
	       	i: INTEGER
	       	new_x: INTEGER
	   	do
	   		i := deref_integer (data)
	       	new_x := - i
	       	if new_x /= pos_x then
	           	move_contents (new_x, pos_y)
	       	end
	       	unset_flags (Flag_tip)
	       	Result := True
	   	end

	on_v_scroller_changed (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
			-- Called from vertical scroll bar on change
		local
			i: INTEGER
			new_y: INTEGER
		do
			i := deref_integer (data)
			new_y := - i
			if new_y /= pos_y then
				move_contents (pos_x, new_y)
			end
			unset_flags (Flag_tip)
			Result := True
		end

	on_h_scroller_dragged (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
	  	local
	       	i: INTEGER
	       	new_x: INTEGER;
	   	do
	       	if (options & SCROLLERS_DONT_TRACK) = Zero then
	       		i := deref_integer (data)
	           	new_x := - i
	           	if new_x /= pos_x then
	           		move_contents (new_x, pos_y)
	           	end
	       	end
	       	unset_flags (Flag_tip)
	       	Result := True
	   	end

	on_v_scroller_dragged (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
	   	local
			i: INTEGER
	       	new_y: INTEGER
	   	do
	       	if (options & SCROLLERS_DONT_TRACK) = Zero then
				i := deref_integer (data)
	           	new_y := - i
	           	if new_y /= pos_y then
	           		move_contents (pos_x, new_y)
	          	end
	       	end
	       	unset_flags (Flag_tip)
	       	Result := True
	   	end

	on_auto_scroll (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
    	local
        	dx,dy: INTEGER
        	cp: SB_CURSOR_POSITION
        	xx, yy: INTEGER
        	oldposx, oldposy: INTEGER
      	do
         	scroll_timer := Void

         		-- Autoscroll while close to the wall
         	dx := 0
         	dy := 0

         		-- Where's the cursor?
         	cp := get_cursor_position
         	if cp /= Void then
            	xx := cp.x; yy := cp.y
         	end
         		-- If scrolling only while inside, and not inside, we stop scrolling
         	if (flags & Flag_scrollinside) = Zero
            	or else (0 <= xx and then 0 <= yy and then xx < viewport_w and then yy < viewport_h)
          	then
            		-- Figure scroll amount x
            	if xx < AUTOSCROLL_FUDGE then
            		dx := AUTOSCROLL_FUDGE - xx
            	elseif viewport_w - AUTOSCROLL_FUDGE <= xx then
            		dx := viewport_w - AUTOSCROLL_FUDGE - xx
            	end

            		-- Figure scroll amount y
            	if yy < AUTOSCROLL_FUDGE then
            		dy := AUTOSCROLL_FUDGE - yy
            	elseif viewport_h - AUTOSCROLL_FUDGE <= yy then
            		dy := viewport_h - AUTOSCROLL_FUDGE - yy
            	end

            		-- Keep autoscrolling
            	if dx /= 0 or else dy /= 0 then
               		oldposx := pos_x
               		oldposy := pos_y
               		if (flags & Flag_scrollinside) /= Zero then
	                  	check
	                     	dx.abs  <= AUTOSCROLL_FUDGE
	                     	dy.abs  <= AUTOSCROLL_FUDGE
	                  	end
	                  	dx := dx * acceleration.item (dx.abs)
	                  	dy := dy * acceleration.item (dy.abs)
	               	end

	               		-- Scroll a bit
	               	set_scroll_position(pos_x + dx, pos_y + dy)

						-- Setup next timer if we can still scroll some more
					if (pos_x /= oldposx) or else (pos_y /= oldposy) then
						scroll_timer := application.add_timeout (application.scroll_speed, Current, selid (selector))
					end
				end

            		-- Kill tip
            	unset_flags (Flag_tip)
			end
		end

feature -- Destruction

	destruct is
    	do
        	if scroll_timer /= Void then
				application.remove_timeout (scroll_timer)
				scroll_timer := Void
        	end
        	h_scroll_bar := Void
        	v_scroll_bar := Void
        	scroll_corner:= Void
        	Precursor
		end


feature { NONE } -- Implementation

	AUTOSCROLL_FUDGE: INTEGER is 11
			-- Proximity to wall at which we start autoscrolling

	SCROLLER_MASK: INTEGER is
    	once
        	Result := (HSCROLLER_ALWAYS | HSCROLLER_NEVER
        			| VSCROLLER_ALWAYS | VSCROLLER_NEVER
        			| SCROLLERS_DONT_TRACK);
		end

	layout is
    	local
        	new_x, new_y, sh_h, sv_w: INTEGER
		do
        	-- Inviolate
			check
				-- Review this in connection with todo list
        		pos_x <= 0 and then pos_y <= 0
        	end
        		-- Initial viewport size
			viewport_w := viewport_width
        	viewport_h := viewport_height
         		-- ALWAYS determine content size
         	content_w := content_width
         	content_h := content_height
         		-- Get dimensions of the scroll bars
         	if (options & HSCROLLER_NEVER) = Zero then sh_h := h_scroll_bar.default_height end
         	if (options & VSCROLLER_NEVER) = Zero then sv_w := v_scroll_bar.default_width end
         		-- Should we disable the scroll bars?
         		-- A bit tricky as the scrollbars may influence each other's presence
         	if (options & (HSCROLLER_ALWAYS | VSCROLLER_ALWAYS)) = Zero
            	and then (content_w <= viewport_w)
            	and then (content_h <= viewport_h)
          	then
            	sh_h := 0; sv_w := 0
         	end
         	if (options & HSCROLLER_ALWAYS) = Zero and then (content_w <= viewport_w - sv_w) then sh_h := 0 end
         	if (options & VSCROLLER_ALWAYS) = Zero and then (content_h <= viewport_h - sh_h) then sv_w := 0 end
         	if (options & HSCROLLER_ALWAYS) = Zero and then (content_w <= viewport_w - sv_w) then sh_h := 0 end
         		-- Viewport size with scroll bars taken into account
         	viewport_w := viewport_w - sv_w
         	viewport_h := viewport_h - sh_h
         		-- Adjust content size, now that we know about those scroll bars
         	if (options & HSCROLLER_NEVER) /= Zero and then (options & HSCROLLER_ALWAYS) /= Zero then
            	content_w := viewport_w
         	end
         	if (options & VSCROLLER_NEVER) /= Zero and then (options & VSCROLLER_ALWAYS) /= Zero then
            	content_h := viewport_h
         	end
         		-- Furthermore, content size won't be smaller than the viewport
         	if content_w < viewport_w then content_w := viewport_w end
         	if content_h < viewport_h then content_h := viewport_h end
         		-- Content size
         	h_scroll_bar.set_range (content_w)
         	v_scroll_bar.set_range (content_h)
         		-- Page size may have changed
         	h_scroll_bar.set_page_size (viewport_w)
         	v_scroll_bar.set_page_size (viewport_h)
         		-- Position may have changed
         	h_scroll_bar.set_scroll_position (- pos_x)
         	v_scroll_bar.set_scroll_position (- pos_y)
         		-- Get back the adjusted position
         	new_x := - h_scroll_bar.scroll_position
         	new_y := - v_scroll_bar.scroll_position
         		-- Scroll to force position back into range
         	if new_x /= pos_x or else new_y /= pos_y then
            	move_contents (new_x, new_y)
         	end
         		-- Read back validated position
         	pos_x := - h_scroll_bar.scroll_position
         	pos_y := - v_scroll_bar.scroll_position
         		-- Hide or show h_scroll_bar scroll bar
         	if sh_h /= 0 then
            	h_scroll_bar.position (0, height - sh_h, width - sv_w, sh_h)
            	h_scroll_bar.show
            	h_scroll_bar.raise
         	else
            	h_scroll_bar.hide
         	end
         		-- Hide or show v_scroll_bar scroll bar
         	if sv_w /= 0 then
            	v_scroll_bar.position (width - sv_w, 0, sv_w, height - sh_h)
            	v_scroll_bar.show
            	v_scroll_bar.raise
         	else
            	v_scroll_bar.hide
         	end
         		-- Hide or show scroll scroll_corner
         	if sv_w /= 0 and then sh_h /= 0 then
            	scroll_corner.position (width - sv_w, height - sh_h, sv_w, sh_h)
            	scroll_corner.show
            	scroll_corner.raise
         	else
            	scroll_corner.hide
         	end
         		-- No more dirty
         	unset_flags (Flag_dirty)
      	end

   start_auto_scroll (x, y: INTEGER; only_when_inside: BOOLEAN): BOOLEAN is
      local
         autoscrolling: BOOLEAN
      do
         unset_flags (Flag_scrollinside)
         if only_when_inside then flags := flags | Flag_scrollinside end
         if h_scroll_bar.page_size < h_scroll_bar.range then
            if (x < AUTOSCROLL_FUDGE) and then (0 < h_scroll_bar.scroll_position)
              then autoscrolling := True
            elseif (viewport_w - AUTOSCROLL_FUDGE <= x) 
            		and then (h_scroll_bar.scroll_position < h_scroll_bar.range - h_scroll_bar.page_size)
             then
            	autoscrolling := True
             end
         end
         if v_scroll_bar.page_size < v_scroll_bar.range then
            if (y < AUTOSCROLL_FUDGE) and then (0 < v_scroll_bar.scroll_position)
             then 
               autoscrolling := True
            elseif (viewport_h - AUTOSCROLL_FUDGE <= y)
               and then (v_scroll_bar.scroll_position < v_scroll_bar.range - v_scroll_bar.page_size)
             then
               autoscrolling := True
            end
         end
         if only_when_inside and then 
            (x < 0 or else y < 0 or else viewport_w <= x or else viewport_h <= y)
          then
            autoscrolling := False
         end
         if autoscrolling then
            if scroll_timer = Void then
               scroll_timer := application.add_timeout (application.scroll_speed, Current, Id_autoscroll)
            end
         else
            if scroll_timer /= Void then
               application.remove_timeout (scroll_timer)
               scroll_timer := Void
            end
         end
         Result := autoscrolling
      end

	stop_auto_scroll is
    	do
         	if scroll_timer /= Void then
            	application.remove_timeout (scroll_timer)
            	scroll_timer := Void
         	end
         	unset_flags (Flag_scrollinside)
    	end

	acceleration: ARRAY [ INTEGER ] is
    	once
--         	Result := { ARRAY [ INTEGER ] 1, << 1, 1, 1, 2, 3, 4, 6, 7, 8, 16, 32, 64 >> }	-- GEC/EDP Version
         	Result := << 1, 1, 1, 2, 3, 4, 6, 7, 8, 16, 32, 64 >>
      	end

invariant
	only_left_or_above: pos_x <= 0 and pos_y <= 0
end
