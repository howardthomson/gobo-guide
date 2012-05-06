note
	description:"Popup window"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

	todo: "[
		Check default_width operation; should, for SB_COMBO_BOX, return a
		maximum size of child elements ?
	]"

class SB_POPUP_DEF

inherit
   	SB_SHELL
      	rename
         	make as window_make,
         	make_top as shell_make_top,
         	make_child as shell_make_child,
         	Id_last as SHELL_ID_LAST
      	redefine
         	default_height,
         	default_width,
         	class_name,
         	does_override_redirect,
         	does_save_under,
         	show,
         	hide,
         	layout,
         	destruct,
         	handle_2,
         	on_paint,
         	on_enter,
         	on_leave,
         	on_motion,
         	on_map,
         	on_focus_next,
         	on_focus_prev,
         	on_key_press,
         	on_key_release,
         	on_ungrabbed
      	end

   SB_POPUP_COMMANDS

   SB_POPUP_CONSTANTS

	SB_DRAW_HELPER
		redefine
        	draw_groove_rectangle,
        	draw_double_raised_rectangle
      	end

	SB_EXPANDED

create

   make,
   make_opts

feature -- Creation

	make (ownr: SB_WINDOW; opts: INTEGER)
			-- Construct popup pane
		local
			o: INTEGER
		do
			if opts = 0 then
				o := Popup_vertical | Frame_raised | Frame_thick
			else
				o := opts
			end
			make_opts (ownr, o, 0,0,0,0)
		end

	make_opts (ownr: SB_WINDOW; opts: INTEGER; x, y, w, h: INTEGER)
      	do
         	shell_make_child (ownr, opts, x,y,w,h)
         	default_cursor := application.default_cursor (Def_rarrow_cursor)
         	drag_cursor := application.default_cursor (Def_rarrow_cursor)
         	set_flags (Flag_enabled)
         	grab_owner := Void
         	base_color := application.base_color
         	hilite_color := application.hilite_color
         	shadow_color := application.shadow_color
         	border_color := application.border_color
         	if (options & Frame_thick) /= 0 then
            	border := 2
         	elseif (options & (Frame_sunken | Frame_raised)) /= 0 then
            	border := 1
         	else
           		border := 0
         	end
		 	set_width  (width.max (1 + border*2))	--##
		 	set_height (height.max(1 + border*2))	--##
		end

feature -- Data

	base_color	: INTEGER
	hilite_color: INTEGER
	shadow_color: INTEGER
	border_color: INTEGER

   border: INTEGER

feature -- Queries

   default_width: INTEGER
         -- Get default width
      local
         child: SB_WINDOW
         w,wmax,wcum,n: INTEGER
         hints: INTEGER
      do
         from
            child := first_child
         until
            child = Void
         loop
            if child.is_shown then
               hints := child.layout_hints
               if (hints & Layout_fix_width) /= 0 then
                  w := child.width
               else
                  w := child.default_width
               end
               wmax := wmax.max(w)
               wcum := wcum + w
               n := n + 1
            end
            child := child.next
         end

         if (options & Pack_uniform_width) /= 0 then 
            wcum := n*wmax
         end
         if (options & Popup_horizontal) /= 0 then
            wmax := wcum
         end
         Result := wmax + border*2
      end

   default_height: INTEGER
         -- Get default width
      local
         child: SB_WINDOW
         h,hmax,hcum,n: INTEGER
         hints: INTEGER
      do
         from
            child := first_child
         until
            child = Void
         loop
            if child.is_shown then
               hints := child.layout_hints
               if (hints & Layout_fix_height) /= 0 then
                  h := child.height
               else
                  h := child.default_height
               end
               hmax := hmax.max(h)
               hcum := hcum + h
               n := n + 1
            end
            child := child.next
         end
         if (options & Pack_uniform_height) /= 0 then
            hcum := n*hmax
         end
         if (options & Popup_horizontal) = 0 then
            hmax := hcum
         end
         Result := hmax + border*2
      end

   get_frame_style: INTEGER
         -- Get current frame style
      do
         Result := (options & Frame_mask)
      end

   get_orientation: INTEGER
         -- Return popup orientation
      do
         Result := (options & Popup_horizontal)
      end

   shrink_wrap: BOOLEAN
         -- Return shrinkwrap mode
      do
         if (options & Popup_shrinkwrap) /= 0 then
            Result := True
         end
      end

   get_grab_owner: SB_WINDOW
         -- Window which will get grabbed when outside
         -- if it has none, it's owned by itself
      do
         if grab_owner /= Void then
            Result := grab_owner
         else
            Result := Current
         end
      end

feature -- Actions

	show
		local
			c: SB_POPUP
		do
        	if (flags & Flag_shown) = 0 then
            	Precursor
            	prev_active := application.popup_window
            	c ?= Current
            	if prev_active /= Void then prev_active.set_next_active (c) end
            		application.set_popup_window (c)
            	set_focus
         	end
      	end

   hide
      do
         if (flags & Flag_shown) /= 0 then
            Precursor
            if application.popup_window = Current then application.set_popup_window (prev_active) end
            if prev_active /= Void then prev_active.set_next_active (next_active) end
            if next_active /= Void then next_active.set_prev_active (prev_active) end
            next_active := Void
            prev_active := Void
            kill_focus
         end
      end

   set_frame_style (style: INTEGER)
         -- Change frame style
      local
         opts: INTEGER
         b: INTEGER
      do
         opts := new_options (style, Frame_mask)
         if options /= opts then
            if (opts & Frame_thick) /= 0 then
               b := 2
            elseif (opts & (Frame_sunken | Frame_raised)) /= 0 then
               b := 1
            else
               b := 0
            end
            options := opts
            if border /= b then
               border := b
               recalc
            end
            update
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

   set_base_color (clr: INTEGER)
         -- Change base color
      do
         if base_color /= clr then
            base_color := clr
            update
         end
      end

   set_orientation (orient: INTEGER)
         -- Change popup orientation
      local
         opts: INTEGER
      do
         opts := new_options (orient, Popup_horizontal)
         if options /= opts then
            options := opts
            recalc
         end
      end

   set_shrink_wrap(sw: BOOLEAN)
         -- Change shrinkwrap mode
      do
         if sw then
            options := options | Popup_shrinkwrap
         else
            unset_options (Popup_shrinkwrap)
         end
      end

	pop_up (grabto: SB_WINDOW; x_, y_, w_, h_: INTEGER)
    		-- Popup the menu and grab to the given owner
      	local
         	rw, rh: INTEGER
         	x,y, w,h: INTEGER
      	do
			-- ### Temp 
			if not is_attached then
				create_resource
			end
			-- ### Temp
   		
         	x := x_; y := y_; w := w_; h := h_;
         	rw := get_root.width
         	rh := get_root.height
         	grab_owner := grabto
         	if (options & Popup_shrinkwrap) /= 0 or else w <= 1 then
            	w := default_width
         	end
         	if (options & Popup_shrinkwrap) /= 0 or else h <= 1 then
            	h := default_height
         	end
         	if x + w > rw then
            	x := rw-w
         	end
         	if y + h > rh then
            	y := rh-h
         	end

         	if x < 0 then
            	x := 0
         	end
         	if y < 0 then
            	y := 0
         	end
         	position (x,y, w,h)
         
         	show
         	raise
         	set_focus
         	if grab_owner = Void then
            	grab_mouse
         	end
      	end

	pop_down
    		-- Pop down the menu
      	do
         	if grab_owner = Void then
            	release_mouse
         	end
         	grab_owner := Void
         	kill_focus
         	hide
      	end

feature -- Message processing

	handle_2 (sender: SB_MESSAGE_HANDLER; type, key: INTEGER; data: ANY): BOOLEAN
		do
			if	   match_function_2 (SEL_FOCUS_UP,			 0, type, key) then Result := on_focus_up		(sender, key, data)
			elseif match_function_2 (SEL_FOCUS_DOWN,		 0, type, key) then Result := on_focus_down		(sender, key, data)
			elseif match_function_2 (SEL_FOCUS_LEFT,		 0, type, key) then Result := on_focus_left		(sender, key, data)
			elseif match_function_2 (SEL_FOCUS_RIGHT,		 0, type, key) then Result := on_focus_right	(sender, key, data)
			elseif match_function_2 (SEL_FOCUS_NEXT,		 0, type, key) then Result := on_default		(sender, key, data)
			elseif match_function_2 (SEL_FOCUS_PREV,		 0, type, key) then Result := on_default		(sender, key, data)
			elseif match_function_2 (SEL_LEFTBUTTONPRESS,	 0, type, key) then Result := on_button_press	(sender, key, data)
			elseif match_function_2 (SEL_LEFTBUTTONRELEASE,	 0, type, key) then Result := on_button_release	(sender, key, data)
			elseif match_function_2 (SEL_MIDDLEBUTTONPRESS,	 0, type, key) then Result := on_button_press	(sender, key, data)
			elseif match_function_2 (SEL_MIDDLEBUTTONRELEASE,0, type, key) then Result := on_button_release	(sender, key, data)
			elseif match_function_2 (Sel_rightbuttonpress,	 0, type, key) then Result := on_button_press 	(sender, key, data)
			elseif match_function_2 (Sel_rightbuttonrelease, 0, type, key) then Result := on_button_release	(sender, key, data)

			elseif match_function_2 (SEL_COMMAND,	Id_unpost, type, key) then Result := on_cmd_unpost(sender, key, data)

			elseif match_functions_2 (SEL_COMMAND, ID_CHOICE, ID_CHOICE + 999, type, key) then Result := on_cmd_choice (sender, key, data)

			else Result := Precursor (sender, type, key, data)
			end
      end


	on_paint (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
		local
			ev: SB_EVENT
			dc: SB_DC_WINDOW
		do
			ev ?= data
			check
				ev /= Void
			end
			dc := paint_dc
			dc.make_event (Current, ev)
			dc.set_foreground (back_color)
			dc.fill_rectangle (border, border, width - border*2, height - border*2)
			draw_frame (dc, 0, 0, width, height)
			dc.stop
			Result := True
      end

   on_focus_up (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         if (options & Popup_horizontal) = 0 then
            Result := on_focus_prev (sender, selector, data)
         end
      end

   on_focus_down (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         if (options & Popup_horizontal) = 0 then
            Result := on_focus_next (sender, selector, data)
         end
      end

   on_focus_left (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         if (options & Popup_horizontal) /= 0 then
            Result := on_focus_prev (sender, selector, data)
         end
      end

   on_focus_right (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         if (options & Popup_horizontal) /= 0 then
            Result := on_focus_prev (sender, selector, data)
         end
      end

   on_focus_next (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         child: SB_WINDOW;
         done: BOOLEAN
      do
         if focus_child /= Void then
            from
               child := focus_child.next
            until
               done or else child = Void
            loop
               if child.is_shown then
                  if child.handle_2 (Current, SEL_FOCUS_SELF, 0, data) then
                     done := True
                     Result := True
                  end
               end
               child := child.next
            end
         end
         from
            child := first_child
         until
            done or else child = Void
         loop
            if child.is_shown then
               if child.handle_2 (Current, SEL_FOCUS_SELF, 0, data) then
                  done := True
                  Result := True
               end
            end
            child := child.next
         end
      end

   on_focus_prev (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         child: SB_WINDOW;
         done: BOOLEAN
      do
         if focus_child /= Void then
            from
               child := focus_child.prev
            until
               done or else child = Void
            loop
               if child.is_shown then
                  if child.handle_2 (Current, SEL_FOCUS_SELF, 0, data) then
                     done := True
                     Result := True
                  end
               end
               child := child.prev
            end
         end
         from
            child := last_child
         until
            done or else child = Void
         loop
            if child.is_shown then
               if child.handle_2 (Current, SEL_FOCUS_SELF, 0, data) then
                  done := True
                  Result := True
               end
            end
            child := child.prev
         end
      end

   on_enter (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         event: SB_EVENT
         sbp: SB_POINT
      do
         Result := Precursor (sender, selector, data)
         event ?= data;
         check
            event /= Void
         end
         if event.code = CROSSINGNORMAL then
            sbp := translate_coordinates_to(parent, event.win_x, event.win_y)
            if contains(sbp.x, sbp.y) and then get_grab_owner.is_mouse_grabbed then
               get_grab_owner.release_mouse
            end
         end
         Result := True;
      end

   on_leave (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         event: SB_EVENT;
         sbp: SB_POINT;
      do
         Result := Precursor (sender, selector, data)
         event ?= data;
         check
            event /= Void
         end
         if event.code = CROSSINGNORMAL then
            sbp := translate_coordinates_to(parent, event.win_x, event.win_y);
            if not contains(sbp.x, sbp.y) and then is_shown and then not get_grab_owner.is_mouse_grabbed
               and then get_grab_owner.is_shown
             then
               get_grab_owner.grab_mouse
            end
         end
         Result := True
      end

   on_motion (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         event: SB_EVENT;
         p: SB_POINT;
      do
         event ?= data check event /= Void end
         if contains(event.root_x,event.root_y) then
            if get_grab_owner.is_mouse_grabbed then
               get_grab_owner.release_mouse
            end
         else
            p := get_grab_owner.parent.translate_coordinates_from(get_root,event.root_x,event.root_y);
            if not get_grab_owner.contains(p.x,p.y) then
               if not get_grab_owner.is_mouse_grabbed and then get_grab_owner.is_shown then
                  get_grab_owner.grab_mouse
               end
            end
         end
         Result := True
      end

	on_map (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
		local
			x, y, buttons: INTEGER
			cp: SB_CURSOR_POSITION
		do
			Result := Precursor (sender, selector, data)
			cp := get_cursor_position
			if cp /= Void
			and then 0 <= cp.x and then 0 <= cp.y 
			and then width > cp.x and then height > cp.y
			then
				if get_grab_owner.is_mouse_grabbed then
					get_grab_owner.release_mouse
				end
			end
			Result := True
		end

   on_button_press (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         do_handle_2 (Current, SEL_COMMAND, Id_unpost, Void)
         Result := True
      end

   on_button_release (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         event: SB_EVENT
      do
         event ?= data
         check
            event /= Void
         end
         if event.moved then
            do_handle_2 (Current, SEL_COMMAND, Id_unpost, Void)
         end
         Result := True
      end

   on_ungrabbed (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         Result := Precursor (sender, selector, data)
         do_handle_2 (Current, SEL_COMMAND, Id_unpost, Void)
         Result := True
      end

   on_cmd_unpost (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         if grab_owner /= Void then
            grab_owner.do_handle_2 (Current, SEL_COMMAND, Id_unpost, data)
         else
            pop_down
            if is_mouse_grabbed then
               release_mouse
            end
         end
         Result := True
      end

   on_key_press (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         event: SB_EVENT
      do
         event ?= data
         check
            event /= Void
         end
         if event.code = sbk.key_escape or else event.code = sbk.key_cancel 
            or else event.code = sbk.key_alt_l or else event.code = sbk.key_alt_r
          then
            do_handle_2 (Current, SEL_COMMAND, Id_unpost, Void)
            Result := True
         else
            Result := Precursor (sender, selector, data)
         end
      end

   on_key_release (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         event: SB_EVENT
      do
         event ?= data
         check
            event /= Void
         end
         if event.code = sbk.key_escape or else event.code = sbk.key_cancel then
            do_handle_2 (Current, SEL_COMMAND, Id_unpost, Void)
            Result := True
         else
            Result := Precursor (sender, selector, data)
         end
      end

   on_cmd_choice (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         Result := True
      end

feature -- Destruction

   destruct
      do
         if application.popup_window = Current then application.set_popup_window (prev_active) end
         if prev_active /= Void then prev_active.set_next_active (next_active) end
         if next_active /= Void then next_active.set_prev_active (prev_active) end
         prev_active := Void
         next_active := Void
         grab_owner := Void
         Precursor
      end


feature {NONE}-- Implementation

   grab_owner: SB_WINDOW
         -- Window which will get grabbed when outside

	layout
    	local
         	child: SB_WINDOW
         	hints: INTEGER
         	w,h,x,y,remain,t: INTEGER
         	mh,mw,sumexpand,numexpand,e: INTEGER
      	do
         	if (options & Popup_horizontal) /= 0 then
            	-- Horizontal

            	-- Get maximum size if uniform packed
            	if (options & Pack_uniform_width) /= 0 then
               		mh := max_child_width
            	end
            	-- Space available
            	remain := width - border * 2

            	-- Find number of paddable children and total space remaining
            	from
               		child := first_child
            	until
               		child = Void
            	loop
               		if child.is_shown then
                  		hints := child.layout_hints;
                  		if (hints & Layout_fix_width) /= 0 then
                     		w := child.width;
                  		elseif (options & Pack_uniform_width) /= 0 then
                     		w := mw
                  		else
                     		w := child.default_width
                  		end
                  		check
                     		w >= 0
                  		end
                  		if (hints & Layout_fill_x) /= 0 and then (hints & Layout_fix_width) = 0 then
                     		sumexpand := sumexpand + w
                     		numexpand := numexpand + 1
                  		else
                     		remain := remain - w
                  		end
               		end
               		child := child.next
            	end

            	-- Do the layout
            	from
               		x := border
               		child := first_child
            	until
               		child = Void
            	loop
               		if child.is_shown then
                  		hints := child.layout_hints
                  		if (hints & Layout_fix_width) /= 0 then
                     		w := child.width
                  		elseif (options & Pack_uniform_width) /= 0 then
                     		w := mw
                  		else
                     		w := child.default_width
                  		end
                  		if (hints & Layout_fill_x) /= 0 and then (hints & Layout_fix_width) = 0 then
                     		if sumexpand > 0 then 
                        		t := w * remain
                        		w := t // sumexpand
                        		e := e + t \\ sumexpand
                        		if e >= sumexpand then
                           			w := w + 1
                           			e := e - sumexpand;
                        		end
                     		else
                        		check
                           			numexpand > 0
                        		end
                        		w := remain // numexpand
                        		e := e + remain \\ numexpand
                        		if e >= numexpand then
                           			w := w + 1
                           			e := e - numexpand
                        		end
                     		end
                  		end
                  		child.position (x, border, w, height - border * 2)
                  		x := x + w
               		end
               		child := child.next
            	end
         	else
            	-- Vertical
            	-- Get maximum size if uniform packed
            	if (options & Pack_uniform_height) /= 0 then
               		mh := max_child_height
            	end

            	-- Space available
            	remain := height - border * 2

            	-- Find number of paddable children and total space remaining
            	from
               		child := first_child
            	until
               		child = Void
            	loop
               		if child.is_shown then
                  		hints := child.layout_hints
                  		if (hints & Layout_fix_height) /= 0 then
                     		h := child.height;
                  		elseif (options & Pack_uniform_height) /= 0 then
                     		h := mh;
                  		else
                     		h := child.default_height
                  		end
                  		check
                     		h >= 0
                  		end
                  		if (hints & Layout_fill_y) /= 0 and then (hints & Layout_fix_height) = 0 then
                     		sumexpand := sumexpand + h
                     		numexpand := numexpand + 1
                  		else
                     		remain := remain - h
                  		end
               		end
               		child := child.next
            	end

            	-- Do the layout
            	from
               		y := border;
               		child := first_child;
            	until
               		child = Void
            	loop
               		if child.is_shown then
                  		hints := child.layout_hints
                  		if (hints & Layout_fix_height) /= 0 then
                     		h := child.height
                  		elseif (options & Pack_uniform_height) /= 0 then
                     		h := mh
                  		else
                     		h := child.default_height
                  		end
                  		if (hints & Layout_fill_y) /= 0 and then (hints & Layout_fix_height) = 0 then
                     		if sumexpand > 0 then
                        		t := h * remain
                        		h := t // sumexpand
                        		e := e + t \\ sumexpand
                        		if e >= sumexpand then
                           			h := h + 1
                           			e := e - sumexpand
                        		end
                     		else
                        		check
                           			numexpand > 0
                        		end
                        		h := remain // numexpand
                        		e := e + remain \\ numexpand
                        		if e >= numexpand then
                           			h := h + 1
                           			e := e - numexpand
                        		end
                     		end
                  		end
                  		child.position (border, y, width - border * 2, h)
                  		y := y + h;
               		end
               		child := child.next
            	end
         	end
         	unset_flags (Flag_dirty)
		end

   does_override_redirect: BOOLEAN
         -- Popups do override-redirect
      do
         Result := True
      end

	does_save_under: BOOLEAN
			-- Popups do save-unders
		once
			Result := True
		end

	class_name: STRING
		do
			Result := "SB_POPUP"
		end

	draw_groove_rectangle (dc: SB_DC_WINDOW; x, y, w, h: INTEGER)
      	do
         	dc.set_foreground(shadow_color)
         	dc.fill_rectangle(x, y, w, 1)
         	dc.fill_rectangle(x, y, 1, h)
         	dc.fill_rectangle(x + 1, y + h - 2, w - 2, 1)
         	dc.fill_rectangle(x + w - 2, y + 1, 1, h - 2)
         	dc.set_foreground(hilite_color)
         	dc.fill_rectangle(x + 1, y + 1, w - 2, 1)
         	dc.fill_rectangle(x + 1, y + 1, 1, h - 2)
         	dc.fill_rectangle(x + 1, y + h - 1, w, 1)
         	dc.fill_rectangle(x + w - 1, y + 1, 1, h)
      	end

	draw_double_raised_rectangle (dc: SB_DC_WINDOW; x, y, w, h: INTEGER)
		do
			dc.set_foreground(base_color)
         	dc.fill_rectangle(x, y, w - 1, 1)
         	dc.fill_rectangle(x, y, 1, h - 1)
         	dc.set_foreground(hilite_color)
         	dc.fill_rectangle(x + 1, y + 1, w - 2, 1)
         	dc.fill_rectangle(x + 1, y + 1, 1, h - 2)
         	dc.set_foreground(shadow_color)
         	dc.fill_rectangle(x + 1, y + h - 2, w - 2, 1)
         	dc.fill_rectangle(x + w - 2, y + 1, 1, h - 1)
         	dc.set_foreground(border_color)
         	dc.fill_rectangle(x, y + h - 1, w, 1)
         	dc.fill_rectangle(x + w - 1, y, 1, h)
      	end

feature {SB_POPUP_DEF}

	prev_active: SB_POPUP
		-- Popup below this one in stack

	next_active: SB_POPUP
		-- Popup above this one in stack

	set_prev_active (pa: SB_POPUP)
		do
			prev_active := pa
		end

	set_next_active(na: SB_POPUP)
			-- Popup above this one in stack
		do
			next_active := na
		end

invariant
--	width >= (border * 2)	--##
--	height >= (border * 2)	--##
end
