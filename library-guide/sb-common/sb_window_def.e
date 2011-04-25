indexing
	description:"Base class for all windows"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

	todo: "[
		Alter destruction process to remove window from displayed window
		browse list in widgets-display-tree widget.
			Modify 'destruct'
			Add notify routine to SB_APPLICATION_DEF
			Add notify routine to SB_WIDGETS_DISPLAY_TREE

		Default on_right_btn_release menu ??
			If movement since press less than limit then call redefineable
			routine to popup an appropriate menu at the pointer position.
			Allow for design-mode menu actions

		on_upd_toggle_shown - use REFERENCE [ BOOLEAN ]
	]"

deferred class SB_WINDOW_DEF

inherit

	SB_MESSAGE_SENDER
		rename
		--	Id_last as Message_sender_id_last
		end

	SB_MESSAGE_HANDLER
    	rename
      		Id_last as Message_handler_id_last
      	redefine
        	handle_2
      	end

	SB_DRAWABLE
    	rename
        	make as make_drawable
		redefine
        	destruct,
        	resize,
        	detach_resource,
        	set_width,
        	set_height,
       -- 	properties,
        	add_properties
        --	class_name
      	end

	SB_PV_X
	SB_PV_Y

	SB_WINDOW_COMMANDS
	SB_WINDOW_CONSTANTS

	SB_DEFAULT_CURSORS

	SB_OPTIONS
		export { SB_WINDOW }
			options
		end

	SB_FLAGS
		export { SB_WINDOW_DEF }
			flags
		end

	SB_SELECTABLE
	SB_ZERO

	SB_RAW_EVENT_DEF	-- For screen redraw processing
	SB_EXPANDED

	KL_SHARED_EXCEPTIONS

feature -- attributes

	parent,							-- Parent Window
	owner,							-- Owner  Window
	first_child,					-- First Child
	last_child,						-- Last Child
	next,							-- Next Sibling
	prev,							-- Previous Sibling
	focus_child: SB_WINDOW         -- Focus Child

   	window_key: INTEGER
   			-- Window key

   	accel_table: SB_ACCEL_TABLE
   			-- Accelerator table

   	default_cursor: SB_CURSOR
   			-- Normal Cursor

   	drag_cursor: SB_CURSOR
   			-- Cursor during drag

	back_color: INTEGER
			-- Window background color

	help_tag: STRING
			-- Help tag

feature  -- Common DND types

   	delete_type: INTEGER;         -- Delete request
   	delete_type_name: STRING is "DELETE"

   	text_type: INTEGER;         -- Ascii text request
   	text_type_name : STRING is "text/plain"

   	string_type: INTEGER is
         -- Clipboard text type (pre-registered)
		deferred
		end

   	color_type: INTEGER;         -- Color
   	color_type_name: STRING is "application/x-color"

   	uri_list_type: INTEGER;         -- URI List
   	uri_list_type_name: STRING is "text/uri-list"

feature -- class name

	class_name: STRING is
		once
			Result := "SB_WINDOW"
		end

feature -- Creation

	make_ev is
		do
			make_drawable (0, 0)
			application.register_window (current_w)

			default_cursor := application.get_default_cursor (Def_arrow_cursor)
			drag_cursor	   := application.get_default_cursor (Def_arrow_cursor)
			back_color := application.base_color
			set_flags (Flag_dirty | Flag_update | Flag_recalc)
			set_options (0)
			application.set_do_create_resource
		ensure
			default_cursor /= Void
			drag_cursor /= Void
		end

	make (p: SB_COMPOSITE; opts: INTEGER; x, y, w, h: INTEGER) is
    	require
        	p /= Void
      	do
         	make_drawable (w, h)
         	if p /= Void then
	         	set_parent (p)
			end
         	application.register_window (current_w)
				-- Cursors
         	default_cursor := application.get_default_cursor (Def_arrow_cursor)
         	drag_cursor	   := application.get_default_cursor (Def_arrow_cursor)
         	x_pos := x
         	y_pos := y
         	back_color := application.base_color
         	set_flags (Flag_dirty | Flag_update | Flag_recalc)
         	set_options (opts)
         	application.set_do_create_resource
		ensure
         	parent /= Void
         	owner /= Void
         	visual /= Void
         	default_cursor /= Void
         	drag_cursor /= Void
		end

feature { EV_WIDGET_IMP } -- Creation special

	set_parent (p: SB_COMPOSITE) is
		do
--	print ("set_parent -- generating_type = "); print (generating_type); print (" Current: "); print (($Current).out)
--	print (" new parent: "); print (($p).out); print ("%N")
--	print_run_time_stack
			if parent /= Void then
				print ("set_parent called twice for same object !%N")
				Exceptions.die (1)
			end
         	parent := p
         	owner := parent
         	visual := parent.visual
         	prev := parent.last_child
         	parent.set_last_child (current_w)
         	if prev /= Void then
            	window_key := prev.window_key + 1
            	prev.set_next (current_w)
         	else
           		window_key := 1
           		parent.set_first_child (current_w)
         	end
		ensure
         	parent /= Void
         	owner /= Void
         	visual /= Void
		end

	make_root (app: SB_APPLICATION; vis: SB_VISUAL) is
			-- Only used for the root window
		do
         	make_drawable (1,1)
         	visual := vis
         	window_key := 1
         	default_cursor := application.get_default_cursor (Def_arrow_cursor)
         	drag_cursor := application.get_default_cursor (Def_arrow_cursor)
         	flags := Flag_dirty | Flag_shown | Flag_update | Flag_recalc
         	options := Layout_fix_x     | Layout_fix_y
         			| Layout_fix_width | Layout_fix_height
      	end

	make_shell (app: SB_APPLICATION; own: SB_WINDOW; opts: INTEGER; x, y, w, h: INTEGER) is
    		-- Used for shell windows
      	do
         	make_drawable (w, h)
         	parent := app.root_window
         	owner := own
         	visual := application.default_visual
         	prev := parent.last_child
         	parent.set_last_child (current_w)

         	if prev /= Void then
            	window_key := prev.window_key + 1
            	prev.set_next (current_w)
         	else
           		window_key := 1
           		parent.set_first_child (current_w)
         	end
         	application.register_window (current_w)

         	default_cursor := application.get_default_cursor (Def_arrow_cursor)
         	drag_cursor    := application.get_default_cursor (Def_arrow_cursor)
         	x_pos := x
         	y_pos := y
         	back_color := application.base_color
         	flags := Flag_dirty | Flag_update | Flag_recalc | Flag_shell
         	options := opts
      	end

feature -- resource creation/deletion

	create_resource is
			-- Create all of the server-side resources for this window
		require else
			parent /= Void and then parent.is_attached
			owner /= Void implies owner.is_attached
		-- 	not is_attached
			application /= Void and then application.initialized
			visual /= Void
		do
			if not is_attached then	-- ???
if visual = Void then
	print ("SB_WINDOW_DEF::create_resource -- visual = Void !%N")
	print (once "   "); print (generating_type); print ("%N")
end
				visual.create_resource
				if default_cursor /= Void then
					default_cursor.create_resource
				end
				if drag_cursor /= Void then
					drag_cursor.create_resource
				end
				create_resource_imp
				flags := flags | Flag_owned
			end
		end

	create_resource_imp is
		deferred
		end

   detach_resource is
         -- Detach the server-side resources for this window
      do
         	-- Detach visual
         visual.detach_resource
         	-- Detach default cursor
         if default_cursor /= Void then
            default_cursor.detach_resource
         end
         	-- Detach drag cursor
         if drag_cursor /= Void then
            drag_cursor.detach_resource
         end
         if is_attached then
            if application.initialized then
				detach_resource_imp
            end
            	--  No longer grabbed
			ungrab
            Precursor
         end
      end

	detach_resource_imp is
   		deferred
   		end

	on_destroy_imp is
			-- event handling: SEL_DESTROY from SB_APPLICATION
		do
			on_destroy_def
         		-- No longer grabbed
         	ungrab
         	unset_flags (Flag_shown | Flag_focused)
			detach_resource
			reset_resource_id
		end

	on_destroy_def is
		deferred
		end

	destroy_resource is
         	-- Destroy the server-side resources for this window
		do
         	if is_attached then
            	if application.initialized then
					if (flags & Flag_owned) /= Zero then
						destroy_resource_imp
					end
            	end
            		-- No longer grabbed
				ungrab
				unset_flags (Flag_focused | Flag_owned)
				reset_resource_id
         	end
      	end

	destroy_resource_imp is
		deferred
		end

	update_so_references is
		do
		end

feature -- Event processing: refresh window

	process (app: SB_APPLICATION) is
		do
			do_handle_2 (app, SEL_UPDATE, 0, Void)
		end

feature

	ungrab is
			-- remove any mouse/keyboard grabs
		do
         	if application.mouse_grab_window = Current then
            	application.set_mouse_grab_window (Void)
         	end
         	if application.keyboard_grab_window = Current then
            	application.set_keyboard_grab_window (Void)
         	end
         	if application.cursor_window = Current then
         		application.set_cursor_window (Void)
         	end
         	if application.focus_window = Current then
         		application.set_focus_window (Void)
         	end
		end

feature

	current_w: SB_WINDOW is
			-- 	Current as an SB_WINDOW
		do
			Result ?= Current
		end

   	get_shell: SB_WINDOW is
      	do
         	from
            	Result := current_w
         	until
            	Result.parent = Void or else Result.parent.parent = Void
         	loop
            	Result := Result.parent
         	end
      	end

   	get_root: SB_WINDOW is
      	do
         	from
            	Result := current_w
         	until
            	Result.parent = Void
         	loop
            	Result := Result.parent
         	end
      	end

	set_window_key (key: INTEGER) is
    		-- Change window key
      	do
         	window_key := key
      	end

   	default_width: INTEGER is
         	-- Return the default width of this window
      	do
         	Result := 1
      	end

   	default_height: INTEGER is
         	-- Return the default height of this window
      	do
         	Result := 1
      	end

   	width_for_height (given_height: INTEGER): INTEGER is
         	-- Return width for given height
      	do
         	Result := default_width
      	end

   	height_for_width (given_width: INTEGER): INTEGER is
         	-- Return height for given width
      	do
         	Result := default_height
      	end

   	set_x (x: INTEGER) is
         	-- Set this window's x-coordinate, in the parent's coordinate system
      	do
         	x_pos := x
         	recalc
      	end

   	set_y (y: INTEGER) is
         	-- Set this window's y-coordinate, in the parent's coordinate system
      	do
         	y_pos := y
         	recalc
      	end

	set_width (w: INTEGER) is
			-- Set the window width
		do
--			if w < 0 then
--				width := 0
--			else
--				width := w
--			end
			width := w.max (minimum_width)
			recalc
		end

   set_height (h: INTEGER) is
         -- Set the window height
      do
         if h < 0 then
            height := 0
         else
            height := h
         end
         recalc
      end

   set_layout_hints (lout: INTEGER) is
         -- Set layout hints for this window
      local
         opts: INTEGER
      do
         opts := new_options (lout, Layout_mask)
         if options /= opts then
            options := opts
            recalc
         end
      end

   layout_hints: INTEGER is
         -- Get layout hints for this window
      do
         Result := options & Layout_mask
      end

   set_accel_table (at: SB_ACCEL_TABLE) is
         -- Set the accelerator table
      do
         accel_table := at
      end

   add_hot_key (code: INTEGER) is
         -- Add a hot key
      local
         accel: SB_ACCEL_TABLE
         win: SB_WINDOW
      do
         from
            win := current_w
         until
            win = Void or else win.accel_table = Void
         loop
            accel := win.accel_table
            win := win.parent
         end
         if accel /= Void then
            accel.add_accel (code, current_w, mksel (SEL_KEYPRESS, Id_hotkey), mksel (SEL_KEYRELEASE, Id_hotkey))
         end
      end

   remove_hot_key (code: INTEGER) is
         -- Remove a hot key
      local
         accel: SB_ACCEL_TABLE
         win: SB_WINDOW
      do
         from
            win := current_w
         until
            win = Void or else win.accel_table = Void
         loop
            accel := win.accel_table
            win := win.parent
         end
         if accel /= Void then
            accel.remove_accel (code)
         end
      end

   is_shell: BOOLEAN is
         -- Return true if window is a shell window
      do
         Result := (flags & Flag_shell) = Flag_shell
      end

   is_child_of (window: SB_WINDOW): BOOLEAN is
         -- Is the specified window this window's parent
      local
         w: SB_WINDOW
      do
         if window /= Current then
            from
               w := parent
            until
               Result or else w = Void
            loop
               if w = window then
                  Result := True
               else
                  w := w.parent
               end
            end
         end
      end

	is_owner_of (window: SB_WINDOW): BOOLEAN is
   			-- True if specified window is owned by this window
		local
			w: SB_WINDOW
   		do
   			from
   				w := window
   			until
   				w = Void or else Result
   			loop
   				if w = Current then
   					Result := True
   				end
   				w := w.owner
   			end
   		end

   contains_child (child: SB_WINDOW): BOOLEAN is
         -- Is the specified window a child of this window
      local
         ch: SB_WINDOW
      do
         from
            ch := child
         until
            Result or ch = Void
         loop
            if ch = Current then
               Result := true
            else
               ch := ch.parent
            end
         end
      end

   get_child_at (x, y: INTEGER): SB_WINDOW is
         -- Return the child window at specified coordinates (if any)
      local
         child: SB_WINDOW
      do
         if 0 <= x and 0 <= y and x < width and  y < height then
            from
               child := last_child
            until
               Result /= Void or else child = Void
            loop
               if child.is_shown and child.x_pos <= x and child.y_pos <= y
               and x < child.x_pos + child.width and y < child.y_pos + child.height then
                  Result := child
               else
                  child := child.prev
               end
            end
         end
      end

	child_count: INTEGER is
    		-- Return the number of child windows for this window
    	local
        	child: SB_WINDOW
      	do
         	from
            	child := first_child
         	until
            	child = Void
         	loop
            	Result := Result + 1
            	child := child.next
         	end
      	end

	index_of_child (window: SB_WINDOW): INTEGER is
			-- Return the index (starting from 0) of the specified
			-- child window, or -1 if the window is not a child.
		local
         	w: SB_WINDOW
      	do
         	if window = Void or else window.parent /= Current then
            	Result := -1
         	else
            	from
               		w := window
            	until
               		w.prev = Void
            	loop
               		Result := Result + 1
               		w := w.prev
            	end
         	end
      	end

   child_at_index (index: INTEGER): SB_WINDOW is
         -- Return the child window at specified index,
         -- or Void if the index is < 0 or out of range
      local
         i: INTEGER
      do
         if index >= 0 then
            from
               i := index
               Result := first_child
            until
               i > 0 and Result /= Void
            loop
               Result := Result.next
               i := i - 1
            end
         end
      end

   common_ancestor (a,b: SB_WINDOW): SB_WINDOW is
         -- Return the common ancestor of window a and window b
      local
         p1, p2: SB_WINDOW
      do
         if a /= Void or  b /= Void then
            if a = Void then
               Result := b.get_root
            elseif b = Void then
               Result := a.get_root
            else
               from
                  p1 := a
               until
                  p1 = Void or Result /= Void
               loop
                  from
                     p2 := b
                  until
                     p2 = Void or Result /= Void
                  loop
                     if p2 = p1 then
                        Result := p1
                     else
                        p2 := p2.parent
                     end
                  end
                  p1 := p1.parent
               end
            end
         end
      end

	set_default_cursor (cursor: SB_CURSOR) is
    		-- Set the default cursor for this window
      	require
         	good_cursor: cursor /= Void
      	do
         	if default_cursor /= cursor then
            	if is_attached then
               		if cursor.is_attached then
						set_default_cursor_imp(cursor)
               		end
            	end
            	default_cursor := cursor
         	end
      	end

	set_default_cursor_imp (cursor: SB_CURSOR) is
		deferred
		end

   	set_drag_cursor (cursor: SB_CURSOR) is
         -- Set the drag cursor for this window
    	require
         	good_cursor: cursor /= Void
      	do
         	if drag_cursor /= cursor then
            	if is_attached then
               		if cursor.is_attached then
						set_drag_cursor_imp(cursor)
               		end
            	end
            	drag_cursor := cursor
         	end
      	end

   	set_drag_cursor_imp (cursor: SB_CURSOR) is
   		deferred
   		end

   	get_cursor_position: SB_CURSOR_POSITION is
         	-- Return the cursor position and mouse button-state
		deferred
      	end

   	set_cursor_position (x,y: INTEGER): BOOLEAN is
         	-- Warp the cursor to the new position
		deferred
      	end

   is_enabled: BOOLEAN is
         -- Return true if this window is able to receive
         -- mouse and keyboard events
      do
         Result := (flags & Flag_enabled) = Flag_enabled
      end

   is_active: BOOLEAN is
         -- Return true if the window is active
      do
         Result := (flags & Flag_active) = Flag_active
      end

   can_focus: BOOLEAN is
         -- Return true if this window is a control capable of
         -- receiving the focus
      do
         Result := False
      end

   has_focus: BOOLEAN is
         -- Return true if this window has the focus
      do
         Result := (flags & Flag_focused) = Flag_focused
      end

   set_focus is
         -- Set focus to this widget.
         -- The chain of focus from shell down to a control is changed.
         -- Widgets now in the chain may or may not gain real focus,
         -- depending on whether parent window already had a real focus!
         -- Setting the focus to a composite will cause descendants to
         -- loose it.
      do
         if parent /= Void and then parent.focus_child /= Current then
            if parent.focus_child /= Void then
               parent.focus_child.kill_focus;
            else
               parent.set_focus
            end
            parent.set_focus_child(current_w)
            if parent.has_focus then
               do_handle_2 (Current, SEL_FOCUSIN, 0, Void)
            end
         end
         flags := flags | Flag_focused
      end

   kill_focus is
         -- Remove the focus from this window
      do
         if parent /= Void and then parent.focus_child = Current then
            if focus_child /= Void then
               focus_child.kill_focus
            end
            if has_focus then
               do_handle_2 (Current, SEL_FOCUSOUT, 0, Void)
            end
            parent.set_focus_child(Void)
         end
         unset_flags (Flag_help)
      end

   set_default (enable_: INTEGER) is
         -- Make widget drawn as default
      local
         win: SB_WINDOW
      do
         if enable_ = SB_FALSE then
            unset_flags (Flag_default)
         elseif enable_ = SB_TRUE then
            if (flags & Flag_default) /= Flag_default then
               win := find_default(get_shell)
               if win /= Void then
                  win.set_default(0)
               end
               flags := flags | Flag_default
            end
         elseif enable_ = SB_MAYBE then
            if (flags & Flag_default) = Flag_default then
               unset_flags (Flag_default);
               win := find_initial(get_shell)
               if win /= Void then
                  win.set_default(1)
               end
            end
         end
      end

  is_flag_default: BOOLEAN is
         -- Return true if widget is drawn as default
      do
         Result := (flags & Flag_default) = Flag_default
      end

   set_initial (enable_: BOOLEAN) is
      local
         win: SB_WINDOW
      do
         if (flags & Flag_initial) = Flag_initial and not enable_ then
            unset_flags (Flag_initial)
         end
         if (flags & Flag_initial) /= Flag_initial and enable_ then
            win := find_initial(get_shell)
            if win /= Void then
               win.set_initial(False)
            end
            flags := flags | Flag_initial
         end
      end

   is_initial: BOOLEAN is
      do
         Result := (flags & Flag_initial) = Flag_default
      end

	enable is
			-- Enable the window to receive mouse and keyboard events
		do
			if (flags & Flag_enabled) /= Flag_enabled then
				flags := flags | Flag_enabled
				if is_attached then
					enable_imp
				end
			end
		end

	enable_imp is
		deferred
		end

	disable is
			-- Disable the window from receiving mouse and keyboard events
      	do
        	kill_focus
        	if (flags & Flag_enabled) = Flag_enabled then
				unset_flags (Flag_enabled)
            	if is_attached then
					disable_imp
            	end
         	end
      	end

   	disable_imp is
   		deferred
   		end

feature -- actions (cont'd)

	raise is
    		-- Raise this window to the top of the stacking order
		do
			if is_attached then
				raise_imp
         	end
      	end

	raise_imp is
   		deferred
   		end

	lower is
    		-- Lower this window to the bottom of the stacking order
    	do
			if is_attached then
				lower_imp
			end
		end

	lower_imp is
   		deferred
   		end

	move (x, y: INTEGER) is
    		-- Move this window to the specified position in the parent's
			-- coordinates
		do
        	if (flags & Flag_dirty) /= Zero or else x /= x_pos or else y /= y_pos then
            	x_pos := x
            	y_pos := y
            	if is_attached then
               		-- Similar as for position(), we have to generate protocol
               		-- here so as to make the display reflect reality...
					move_imp(x, y)
               		if (flags & Flag_dirty) /= Zero then
                  		layout
               		end
            	end
         	end
		end

	move_imp (x, y: INTEGER) is
		deferred
		end

   resize (w_, h_: INTEGER) is
         -- Resize this window to the specified width and height
      local
         w, h: INTEGER
      do
         w := w_; h := h_

         if w < 0 then
            w := 0
         end
         if h < 0 then
            h := 0
         end
         if (flags & Flag_dirty) /= Zero or else w /= width or else h /= height then
            if is_attached then
               		-- Similar as for position(), we have to generate protocol here..
				resize_imp (w, h)

               		-- And of course the size has changed so layout is needed
               width := w
               height := h
               layout
            else
               width := w
               height := h
            end
         end
      end

	resize_imp (w, h: INTEGER) is
		deferred
		end

	position (x, y, w_, h_: INTEGER) is
			-- Move and resize this window in the parent's coordinates
		local
			w,h: INTEGER
			ow,oh: INTEGER
        	resized: BOOLEAN
			sl: SB_STATUS_LINE
      	do
      	 	ow := width
      	 	oh := height
         	if w_ < 0 then w := 0 else w := w_ end
         	if h_ < 0 then h := 0 else h := h_ end
         	resized := (w /= width) or else (h /= height)

         	if (flags & Flag_dirty) = Flag_dirty or else
            	x /= x_pos or else y /= y_pos or else resized
          	then
            	x_pos := x
            	y_pos := y
            	width := w
            	height := h

            	if is_attached then
	               		-- Alas, we have to generate some protocol here even if the placement
	               		-- as recorded in the widget hasn't actually changed.  This is because
	               		-- there are ways to change the placement w/o going through position()!
					position_imp (x, y, w, h, ow, oh)
	               		-- We don't have to layout the interior of this widget unless
	               		-- the size has changed or it was marked as dirty:- this is
	               		-- a very good optimization as it's applied recursively!
               		if (flags & Flag_dirty) = Flag_dirty or resized then
                  		layout
               		end
            	end
			end
		end

	position_imp (x, y, w, h, ow, oh: INTEGER) is
     	deferred
     	end

   recalc is
         -- Mark this window's layout as dirty
      do
         if parent /= Void then
            parent.recalc
         end
         flags := flags | Flag_dirty
      end

   force_refresh is
         --  Force a GUI update of this window and its children
      local
         child: SB_WINDOW
      do
         do_handle_2 (Current, SEL_UPDATE, 0, Void)
         from
            child := first_child
         until
            child = Void
         loop
            child.force_refresh
            child := child.next
         end
      end

   reparent (new_parent: SB_COMPOSITE) is
         -- Change the parent for this window
      require
         new_parent /= Void
         parent /= Void
         parent /= get_root
         new_parent /= parent implies not contains_child(new_parent)
         new_parent /= parent and then is_attached implies new_parent.is_attached
         new_parent /= parent and then not is_attached implies not new_parent.is_attached
      do
         if new_parent /= parent then
            	-- Kill focus chain through this window
            kill_focus
            	-- Flag old parent as to be recalculated
            parent.recalc
            	-- Unlink from old parent
            if prev /= Void then
               prev.set_next (next)
            else
               parent.set_first_child (next)
            end
            if next /= Void then
               next.set_prev (prev)
            else
               parent.set_last_child (prev)
            end
            	-- Link to new parent
            parent := new_parent
            prev := parent.last_child
            next := Void
            parent.set_last_child (current_w)
            if prev /= Void then
               prev.set_next (next)
            else
               parent.set_first_child (next)
            end
            	-- New owner is the new parent
            owner := parent
            	-- Hook up to new window in server too
            if is_attached and then parent.is_attached then
				reparent_imp
            end
            	-- Flag as to be recalculated
            recalc
         end
      end

	reparent_imp is
		deferred
		end

	frozen -- ???
	update_rectangle (x_, y_, w_, h_: INTEGER) is
			-- Mark the specified rectangle dirty, i.e. to be repainted
		require
--			good_width: w_ >= 0
--			good_height: h_ >= 0
		local
			x,y,w,h: INTEGER;
		do
         	x := x_; y := y_; w := w_; h := h_
         	if w < 0 then w := 0 end	-- TEMP ?
         	if h < 0 then h := 0 end	-- TEMP ?
         	if is_attached then
            		-- We toss out rectangles outside the visible area
            	if x < width and then y < height and then x+w > 0 and then y+h > 0 then
               			-- Intersect with the window
               		if x < 0 then
                  		w := w+x
                  		x := 0
               		end
               		if y < 0 then
                  		h := h+y
                  		y := 0
               		end
               		if x+w > width then
                  		w := width-x
               		end
               		if y+h > height then
                  		h := height-y
               		end
               			-- Append the rectangle; it is a synthetic expose event!!
               		if w > 0 and then h > 0 then
						update_rectangle_imp (x, y, w, h)
               		end
            	end
		 	else -- not is_attached
		 --		edp_trace.st("SB_WINDOW_DEF::update_rectangle, not is_attached - ").n(Current.out).d
         	end
		end

	update_rectangle_imp (x, y, w, h: INTEGER) is
		deferred
		end

	update is
			-- Mark the entire window client area dirty
		do
			update_rectangle (0, 0, width, height);
		end

   repaint_rectangle (x_, y_, w_, h_: INTEGER) is
         -- If marked but not yet painted, paint the given area
		require
			good_width: w_ >= 0
			good_height: h_ >= 0
      local
         x,y,w,h: INTEGER;
      do
         x := x_; y := y_; w := w_; h := h_;
         if is_attached then
            	-- We toss out rectangles outside the visible area
            if x < width and then y < height and then x+w > 0 and then y+h > 0 then
               	-- Intersect with the window
               if x < 0 then
                  w := w + x;
                  x := 0;
               end
               if y < 0 then
                  h := h + y;
                  y := 0;
               end
               if x+w > width then
                  w := width - x;
               end
               if y+h > height then
                  h := height - y;
               end
               if w > 0 and then h > 0 then
					repaint_rectangle_imp(x, y, w, h)
               end
            end
         end
      end

	repaint_rectangle_imp (x, y, w, h: INTEGER) is
		deferred
		end

	repaint is
			-- If marked but not yet painted, paint the given area
		do
			repaint_rectangle (0, 0, width, height)
		end

	grab_mouse is
			-- Grab the mouse to this window; future mouse events will be
        	-- reported to this window even while the cursor goes outside
        	-- of this window
		deferred
		end

   	release_mouse is
         	-- Release the mouse grab
        deferred
      	end

   	is_mouse_grabbed: BOOLEAN is
         	-- Return true if the window has been grabbed
      	do
         	Result := application.mouse_grab_window = Current;
      	end

   	grab_keyboard is
      	do
         	if is_attached then
            	if (flags & Flag_shown) = b0 then
               		-- TODO warning
            	else
					grab_keyboard_imp
	               	application.set_keyboard_grab_window (current_w)
            	end
         	end
      	end

   	grab_keyboard_imp is
   		deferred
   		end

   	release_keyboard is
         	-- Release the mouse grab
      	do
         	if is_attached then
            	application.set_keyboard_grab_window(Void);
            	release_keyboard_imp
         	end
      	end

	release_keyboard_imp is
		deferred
		end

   is_keyboard_grabbed: BOOLEAN is
      do
         Result := application.keyboard_grab_window = Current;
      end

   show is
         -- Show this window
      do
         if (flags & Flag_shown) /= Flag_shown then
            flags := flags | Flag_shown;
            if is_attached then
				show_imp
            end
         end
      end

   	show_imp is
   		deferred
   		end

	hide is
			-- Hide this window
		do
         	if is_shown then
            	kill_focus
            	unset_flags (Flag_shown)
            	if is_attached then
					hide_imp
            	end
         	end
      	end

	hide_imp is
		deferred
		end

   is_shown: BOOLEAN is
         -- Return true if the window is shown
      do
         Result := (flags & Flag_shown) = Flag_shown
      end

	is_composite: BOOLEAN is
    		-- Return true if the window is composite
    	do
    		Result := False
    	end

   	is_under_cursor: BOOLEAN is
         	-- Return true if the window is under the cursor
      	do
         	Result := application.cursor_window = Current
      	end

   	has_selection: BOOLEAN is
         	-- Return true if this window owns the selection
      	do
         	Result := application.selection_window = Current;
      	end

   acquire_selection (types: ARRAY [ INTEGER ]): BOOLEAN is
         -- Try to acquire the selection, given a list of drag types
      require
         types /= Void and then not types.is_empty
      do
         if is_attached then
           if application.selection_window /= Void then
             application.selection_window.do_handle_2 (application, SEL_SELECTION_LOST, 0, application.event);
             application.set_selection_window(Void);
             application.set_sel_type_list(Void);
           end
           if application.selection_window = Void then
             application.set_sel_type_list(types);
             application.set_selection_window(current_w);
             application.selection_window.do_handle_2 (Current, SEL_SELECTION_GAINED, 0, application.event);
           end
           Result := True;
        end
     end

  release_selection is
         --  Release the selection
      do
         if is_attached then
            if application.selection_window = Current then
               do_handle_2 (Current, SEL_SELECTION_LOST, 0, application.event);
               application.set_sel_type_list(Void);
               application.set_selection_window(Void);
            end
         end
      end

	has_clipboard: BOOLEAN is
    		--  Return true if this window owns the clipboard
		do
			Result := application.clipboard_window = Current;
      	end

	acquire_clipboard (types: ARRAY [ INTEGER ]): BOOLEAN is
    		-- Try to acquire the clipboard, given a list of drag types
      	require
        	types /= Void and then not types.is_empty
      	local
        	i,e: INTEGER;
        	t: INTEGER;
      	do
        	if is_attached then
				Result := acquire_clipboard_imp(types)
         	end
      	end

   	acquire_clipboard_imp (types: ARRAY [ INTEGER ]): BOOLEAN is
   		deferred
   		end

	release_clipboard: BOOLEAN is
			--  Release the clipboard
		do
        	if is_attached then
            	if application.clipboard_window = Current then
					release_clipboard_imp
               		application.set_clipboard_window(Void)
               		Result := True;
            	end
         	end
      	end

	release_clipboard_imp is
		deferred
		end

   enable_drop is
         -- Enable this window to receive drops
      do
         flags := flags | Flag_droptarget
      end

   disable_drop is
         -- Disable this window from receiving drops
      do
         unset_flags (Flag_droptarget);
      end

   is_drop_enabled: BOOLEAN is
         -- Return true if this window is able to receive drops
      do
         Result := (flags & Flag_droptarget) = Flag_droptarget;
      end

   is_dragging : BOOLEAN is
         -- Return true if a drag operaion has been initiated from this
         -- window
      do
         Result := application.drag_window = Current;
      end

   begin_drag (drag: ARRAY [INTEGER]): BOOLEAN is
         -- Initiate a drag operation with a list of previously registered
         -- drag types
      do
      end

   frozen do_handle_drag (x, y, action: INTEGER) is
         -- When dragging, inform the drop-target of the new position
         --  and the drag action
      local
         t: BOOLEAN
      do
         t := handle_drag(x,y,action);
      end

   handle_drag (x, y, action: INTEGER): BOOLEAN is
         -- When dragging, inform the drop-target of the new position
         --  and the drag action
      do
      end

   frozen do_end_drag (drop: BOOLEAN) is
         -- Terminate the drag operation with or without actually dropping
         --  the data
      local
         t: BOOLEAN;
      do
         t := end_drag(drop);
      end

   end_drag (drop: BOOLEAN): BOOLEAN is
         -- Terminate the drag operation with or without actually dropping
         --  the data
      do
      end

   is_drop_target: BOOLEAN is
         -- Return true if this window is the target of a drop
      do
      end

   set_drag_rectangle (x, y, w, h, want_updates: BOOLEAN) is
         --  When being dragged over, indicate that no further
         --  SEL_DND_MOTION messages are required while the cursor is inside
         --  the given rectangle
      do
      end

   clear_drag_rectangle is
         -- When being dragged over, indicate we want to receive SEL_DND_MOTION
         -- messages every time the cursor moves
      do
      end

   accept_drop (action: INTEGER) is
         -- When being dragged over, indicate acceptance or rejection of the
         -- dragged data
      do
      end

   did_accept: INTEGER is
         -- The target accepted our drop
      do
      end

   inquire_dnd_types (origin: INTEGER): ARRAY[INTEGER] is
         -- When being dragged over, inquire the drag types which are
         -- being offered
      do
      end

   offered_dnd_type (origin, type: INTEGER): BOOLEAN is
         -- When being dragged over, return true if we are offered the
         -- given drag type
      do
      end

   inquire_dnd_action: INTEGER is
         -- When being dragged over, return the drag action
      do
      end

	get_dnd_data (origin, type: INTEGER): STRING is
    		-- Get dropped data; called in response to DND enter or DND drop
    	require
        	is_attached
      	do
         	inspect origin
            when FROM_DRAGNDROP then
               	Result := application.dragdrop_get_data (current_w, type)
         	when FROM_CLIPBOARD then
            	Result := application.clipboard_get_data (current_w, type)
         	when FROM_SELECTION then
            	Result := application.selection_get_data (current_w, type)
			end
		end

   set_dnd_data (origin, type: INTEGER; data: STRING): BOOLEAN is
       	-- Set DND data; the array must be allocated with FXMALLOC and
       	--  ownership is transferred to the system
      require
         is_attached
      do

         inspect origin

         when FROM_DRAGNDROP then
            application.dragdrop_set_data (current_w, type, data)   -- FIXME need to know 8, 16, 32 format
         when FROM_CLIPBOARD then
            application.clipboard_set_data (current_w, type, data)
         when FROM_SELECTION then
            application.selection_set_data (current_w, type, data)
         end
         Result := True
      end

   contains (parentx, parenty: INTEGER): BOOLEAN is
         -- Return true if window logically contains the given point
      do
         Result := x_pos <= parentx and then parentx < x_pos + width
            and then y_pos <= parenty and then parenty < y_pos + height
      end


   set_back_color (clr: INTEGER) is
         -- Set window background color
      do
         if clr /= back_color then
            back_color := clr
            update
         end
      end

   link_before (sibling: SB_WINDOW) is
         -- Relink this window before sibling in the window list
      do
         if sibling /= Current then
            if prev /= Void then
               prev.set_next (next)
            else
               parent.set_first_child (next)
            end
            if next /= Void then
               next.set_prev(prev)
            else
               parent.set_last_child (prev)
            end
            next := sibling
            if sibling /= Void then
               prev := sibling.prev
            else
               prev := parent.last_child
            end
            if prev /= Void then
               prev.set_next (current_w)
            else
               parent.set_first_child (current_w)
            end
            if next /= Void then
               next.set_prev (current_w)
            else
               parent.set_last_child (current_w)
            end
            recalc
         end
      end

   link_after (sibling: SB_WINDOW) is
         -- Relink this window after sibling in the window list
      do
         if sibling /= Current then
            if prev /= Void then
               prev.set_next(next)
            else
               parent.set_first_child (next)
            end
            if next /= Void then
               next.set_prev(prev)
            else
               parent.set_last_child (prev)
            end
            if sibling /= Void then
               next := sibling.next
            else
               prev := parent.first_child
            end
            prev := sibling
            if prev /= Void then
               prev.set_next(current_w)
            else
               parent.set_first_child (current_w)
            end
            if next /= Void then
               next.set_prev (current_w)
            else
               parent.set_last_child (current_w)
            end
            recalc
         end
      end

	does_save_under: BOOLEAN is
		once
			Result := False
		end

feature -- Message processing

	on_paint (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): like handle_2 is
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
         	dc.fill_rectangle (0, 0, width, height)
         	dc.stop
         	Result := True
      	end

   on_map (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): like handle_2 is
      do
         if message_target /= Void
            and then message_target.handle_2 (Current, SEL_MAP, message, data)
          then
            Result := True
         end
      end

   on_unmap (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): like handle_2 is
      do
         if application.mouse_grab_window = Current then
            application.set_mouse_grab_window (Void)
         end
         if application.keyboard_grab_window = Current then
            application.set_keyboard_grab_window (Void)
         end
         if message_target /= Void
            and then message_target.handle_2 (Current, SEL_UNMAP, message, data)
          then
            Result := True
         end
      end

	on_configure (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): like handle_2 is
		do
			if message_target /= Void
				and then message_target.handle_2 (Current, SEL_CONFIGURE, message, data)
			then
				Result := True
			end
		end

   on_update (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): like handle_2 is
      do
         Result := True

         -- Do layout
         if (flags & Flag_dirty) /= Zero then
            layout
         end
         	-- Do GUI update
         if (flags & Flag_update) /= Zero then
            if message_target = Void then
               	-- No target, so we're done
               Result := False
            else
               	-- Ask the target object to update the state of this widget
               Result := message_target.handle_2 (Current, SEL_UPDATE, message, Void);
            end
         end
      end

   on_motion (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): like handle_2 is
      do
         if is_enabled and then message_target /= Void and then
            message_target.handle_2 (Current, SEL_MOTION, message, data)
          then
            Result := True
         end
      end

   on_mouse_wheel (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): like handle_2 is
      do
         if is_enabled and then message_target /= Void and then
            message_target.handle_2 (Current, SEL_MOUSEWHEEL, message, data)
          then
            Result := True
         end
      end

   on_enter (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): like handle_2 is
      local
         event: SB_EVENT
      do
         Result := True
         event ?= data
         if event /= Void then
            if event.code /= sbd.CROSSINGGRAB then
               application.set_cursor_window (current_w)
               if (event.state & (sbd.SHIFTMASK | sbd.CONTROLMASK | sbd.LEFTBUTTONMASK
                                     | sbd.MIDDLEBUTTONMASK | sbd.RIGHTBUTTONMASK)) = b0
                then
                  flags := flags | Flag_tip
               end
               flags := flags | Flag_help
            end
            if is_enabled and then message_target /= Void then
               message_target.do_handle_2 (Current, SEL_ENTER, message, data)
            end
         end
      end

   on_leave (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): like handle_2 is
      local
         event: SB_EVENT
      do
         Result := True
         event ?= data
         if event /= Void then
            if event.code /= sbd.CROSSINGGRAB then
               application.set_cursor_window (parent)
               unset_flags (Flag_tip | Flag_help)
            end
            if is_enabled and then message_target /= Void then
               message_target.do_handle_2 (Current, SEL_LEAVE, message, data)
            end
         end
      end

   on_left_btn_press (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): like handle_2 is
      do
         unset_flags (Flag_tip)
         do_handle_2 (Current, SEL_FOCUS_SELF, 0, data);
         if is_enabled then
            grab_mouse;
            if message_target /= Void
               and then message_target.handle_2 (Current, SEL_LEFTBUTTONPRESS, message, data)
             then
               Result := True
            end
         end
      end

   on_left_btn_release (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): like handle_2 is
      do
         if is_enabled then
            release_mouse;
            if message_target /= Void
               and then message_target.handle_2 (Current, SEL_LEFTBUTTONRELEASE, message, data)
             then
               Result := True
            end
         end
      end

   on_middle_btn_press (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): like handle_2 is
      do

		edp_trace.st("SB_WINDOW_DEF::on_middle_btn_press called").d

         unset_flags (Flag_tip)
         do_handle_2 (Current, SEL_FOCUS_SELF, 0, data)
         if is_enabled then
            grab_mouse
            if message_target /= Void
               and then message_target.handle_2 (Current, SEL_MIDDLEBUTTONPRESS, message, data)
             then
               Result := True
            end
         end
      end

   on_middle_btn_release (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): like handle_2 is
      do
         if is_enabled then
            release_mouse
            if message_target /= Void
               and then message_target.handle_2 (Current, SEL_MIDDLEBUTTONRELEASE, message, data)
             then
               Result := True
            end
         end
      end

	on_right_btn_press (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): like handle_2 is
		do
			unset_flags (Flag_tip)
			do_handle_2 (Current, SEL_FOCUS_SELF, 0, data)
		   	if is_enabled then
	           	grab_mouse
	           	if message_target /= Void then
					if message_target.handle_2 (Current, Sel_rightbuttonpress, message, data) then
						Result := True
					end
				else
				--	on_menu_popup_right_btn(Current, selector, data)
				end
			end
		end

   	on_right_btn_release (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): like handle_2 is
   		local
   			ev: SB_EVENT
      	do
         	if is_enabled then
            	release_mouse
            	if message_target /= Void then
               		if message_target.handle_2 (Current, Sel_rightbuttonrelease, message, data) then
               			Result := True
               		end
               	else
               		ev ?= data
               			check ev /= Void end
               		if (ev.win_x - ev.click_x).abs < 2
               		and then (ev.win_y - ev.click_y).abs < 2 then
				--		on_menu_popup_right_btn(Current, selector, data)
						edp_trace.st("on_menu_popup ...").d
					end
				--	if ev /= Void then
				--		edp_trace.st("Click Pos: ").n(ev.click_x.out).n("/").n(ev.click_y.out)
				--		.n(" Now Pos: ").n(ev.win_x.out).n("/").n(ev.win_y.out).d
				--	else
				--		edp_trace.st("Click Pos: event is Void!").d
				--	end
            	end
			end
		end

   	on_begin_drag (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): like handle_2 is
      	do
         	if message_target /= Void
            	and then message_target.handle_2 (Current, SEL_BEGINDRAG, message, data)
          	then
            	Result := True
         	end
      	end

	on_end_drag (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): like handle_2 is
		do
         	if message_target /= Void
            	and then message_target.handle_2 (Current, SEL_ENDDRAG, message, data)
          	then
            	Result := True
         	end
      	end

   on_dragged (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): like handle_2 is
      do
         if message_target /= Void
            and then message_target.handle_2 (Current, SEL_DRAGGED, message, data)
          then
            Result := True
         end
      end

   on_key_press (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): like handle_2 is
      do
         if is_enabled and then message_target /= Void
            and then message_target.handle_2 (Current, SEL_KEYPRESS, message, data)
          then
            Result := True
         end
      end

   on_key_release (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): like handle_2 is
      do
         if is_enabled and then message_target /= Void
            and then message_target.handle_2 (Current, SEL_KEYRELEASE, message, data)
          then
            Result := True
         end
      end

   on_ungrabbed (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): like handle_2 is
      do
         if message_target /= Void then
            message_target.do_handle_2 (Current, SEL_UNGRABBED, message, data);
         end
         --#ifdef WIN32
         --  SetCursor((HCURSOR)defaultCursor->id());    // FIXME Maybe should be done with WM_SETCURSOR?
         --#endif
         Result := True
      end

   	on_destroy (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): like handle_2 is
   			-- handle the Destroy_notify event from SB_APPLICATION
      	do
      		on_destroy_imp
			Result := True
		end

	on_focus_self (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
    	do
        	if is_enabled and then can_focus then
            	set_focus;
            	Result := True
         	end
      	end

   on_focus_in (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         flags := flags | Flag_focused;
         if focus_child /= Void then
            focus_child.do_handle_2 (focus_child, SEL_FOCUSIN, 0, Void);
         end
         if message_target /= Void then
            message_target.do_handle_2 (Current, SEL_FOCUSIN, message, data);
         end
         Result := True
      end

   on_focus_out (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         unset_flags (Flag_focused);
         if focus_child /= Void then
            focus_child.do_handle_2 (focus_child, SEL_FOCUSOUT, 0, Void);
         end
         if message_target /= Void then
            message_target.do_handle_2 (Current, SEL_FOCUSOUT, message, data);
         end
         Result := True
      end

   on_selection_lost (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         if message_target /= Void then
            message_target.do_handle_2 (Current, SEL_SELECTION_LOST, message, data);
         end
         Result := True
      end

   on_selection_gained (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         if message_target /= Void then
            message_target.do_handle_2 (Current, SEL_SELECTION_GAINED, message, data);
         end
         Result := True
      end

	on_selection_request (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
		local
			s1, s2: STRING
		do
			-- ##DEBUG##
			s1 := "Void"; s2 := "Void"
			if message_target /= Void then s1 := message_target.out end
			if data /= Void then s2 := data.out end
      		edp_trace.st("SB_WINDOW_DEF::on_selection_request - #1 - message_target= ").n(s1).n(" data = ").n(s2).d
      		-- ##DEBUG-END##

			if message_target /= Void
			and then message_target /= sender
			and then message_target.handle_2 (Current, SEL_SELECTION_REQUEST, message, data)
			then
				Result := True
			end
		end

   on_clipboard_lost (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         if message_target /= Void then
            message_target.do_handle_2 (Current, SEL_CLIPBOARD_LOST, message, data);
         end
         Result := True
      end

   on_clipboard_gained (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         if message_target /= Void then
            message_target.do_handle_2 (Current, SEL_CLIPBOARD_GAINED, message, data);
         end
         Result := True
      end

   on_clipboard_request (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         if message_target /= Void and then
            message_target.handle_2 (Current, SEL_CLIPBOARD_REQUEST, message, data)
          then
            Result := True
         end
      end

   on_dnd_enter (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         if message_target /= Void and then
            message_target.handle_2 (Current, SEL_DND_ENTER, message, data)
          then
            Result := True
         end
      end

   on_dnd_leave (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         if message_target /= Void and then
            message_target.handle_2 (Current, SEL_DND_LEAVE, message, data)
          then
            Result := True
         end
      end

   on_dnd_motion (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         if message_target /= Void and then
            message_target.handle_2 (Current, SEL_DND_MOTION, message, data)
          then
            Result := True
         end
      end

   on_dnd_drop (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         if message_target /= Void and then
            message_target.handle_2 (Current, SEL_DND_DROP, message, data)
          then
            Result := True
         end
      end

   on_dnd_request (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         if message_target /= Void and then
            message_target.handle_2 (Current, SEL_DND_REQUEST, message, data)
          then
            Result := True
         end
      end

   on_cmd_show (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         if not is_shown then
            show
            recalc
         end
         Result := True
      end

   on_cmd_hide (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         if is_shown then
            hide
            recalc
         end
         Result := True
      end

   	on_upd_toggle_shown (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      	local
         	snd: SB_MESSAGE_HANDLER;
      	do
         	snd := sender
         	if snd /= Void then
            	snd.do_handle_2 (Current, SEL_COMMAND, Id_enable, Void)
            	snd.do_handle_2 (Current, SEL_COMMAND, Id_show, Void)
--#          	snd.do_handle_2 (Current, SEL_COMMAND, Id_setvalue, is_shown)
         	end
         	Result := True
		ensure
--			implemented: false
		end

   on_cmd_toggle_shown (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         if is_shown then
            hide
         else
            show
         end
         recalc
         Result := True
      end

   on_cmd_raise (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         raise
         Result := True
      end

   on_cmd_lower (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         lower
         Result := True
      end

	on_cmd_enable (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      	do
         	enable
         	Result := True
      	end

   	on_cmd_disable (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      	do
         	disable
         	Result := True
      	end

	on_cmd_update (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      	do
         	update
         	Result := True
      	end

   	on_upd_yes (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      	local
         	snd: SB_MESSAGE_HANDLER
      	do
         	snd := sender
         	if snd /= Void then
            	snd.do_handle_2 (Current, SEL_COMMAND, Id_enable, Void)
            	snd.do_handle_2 (Current, SEL_COMMAND, Id_show  , Void)
         	end
         	Result := True
      	end

   	on_cmd_delete (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      	do
         	Result := True
      	end

   handle_2 (sender: SB_MESSAGE_HANDLER; type, key: INTEGER; data: ANY): BOOLEAN is
      do
         if		match_function_2 (SEL_UPDATE,				0, type, key) then Result := on_update 				(sender, key, data);
         elseif match_function_2 (SEL_PAINT,				0, type, key) then Result := on_paint 				(sender, key, data);
         elseif match_function_2 (SEL_MOTION,				0, type, key) then Result := on_motion 				(sender, key, data);
         elseif match_function_2 (SEL_CONFIGURE,			0, type, key) then Result := on_configure 			(sender, key, data);
         elseif match_function_2 (SEL_MOUSEWHEEL,			0, type, key) then Result := on_mouse_wheel 		(sender, key, data);
         elseif match_function_2 (SEL_MAP,					0, type, key) then Result := on_map 				(sender, key, data);
         elseif match_function_2 (SEL_UNMAP,				0, type, key) then Result := on_unmap 				(sender, key, data);
         elseif match_function_2 (SEL_DRAGGED,				0, type, key) then Result := on_dragged 			(sender, key, data);
         elseif match_function_2 (SEL_ENTER,				0, type, key) then Result := on_enter 				(sender, key, data);
         elseif match_function_2 (SEL_LEAVE,				0, type, key) then Result := on_leave 				(sender, key, data);
         elseif match_function_2 (SEL_DESTROY,				0, type, key) then Result := on_destroy 			(sender, key, data);
         elseif match_function_2 (SEL_FOCUSIN,				0, type, key) then Result := on_focus_in 			(sender, key, data);
         elseif match_function_2 (SEL_FOCUSOUT,				0, type, key) then Result := on_focus_out 			(sender, key, data);
         elseif match_function_2 (SEL_SELECTION_LOST,		0, type, key) then Result := on_selection_lost 		(sender, key, data);
         elseif match_function_2 (SEL_SELECTION_GAINED,		0, type, key) then Result := on_selection_gained 	(sender, key, data);
         elseif match_function_2 (SEL_SELECTION_REQUEST,	0, type, key) then Result := on_selection_request 	(sender, key, data);
         elseif match_function_2 (SEL_CLIPBOARD_LOST,		0, type, key) then Result := on_clipboard_lost 		(sender, key, data);
         elseif match_function_2 (SEL_CLIPBOARD_GAINED,		0, type, key) then Result := on_clipboard_gained 	(sender, key, data);
         elseif match_function_2 (SEL_CLIPBOARD_REQUEST,	0, type, key) then Result := on_clipboard_request 	(sender, key, data);
         elseif match_function_2 (SEL_LEFTBUTTONPRESS,		0, type, key) then Result := on_left_btn_press 		(sender, key, data);
         elseif match_function_2 (SEL_LEFTBUTTONRELEASE,	0, type, key) then Result := on_left_btn_release 	(sender, key, data);
         elseif match_function_2 (SEL_MIDDLEBUTTONPRESS,	0, type, key) then Result := on_middle_btn_press	(sender, key, data);
         elseif match_function_2 (SEL_MIDDLEBUTTONRELEASE,	0, type, key) then Result := on_middle_btn_release	(sender, key, data);
         elseif match_function_2 (Sel_rightbuttonpress,		0, type, key) then Result := on_right_btn_press 	(sender, key, data);
         elseif match_function_2 (Sel_rightbuttonrelease,	0, type, key) then Result := on_right_btn_release 	(sender, key, data);
         elseif match_function_2 (SEL_UNGRABBED,			0, type, key) then Result := on_ungrabbed 			(sender, key, data);
         elseif match_function_2 (SEL_KEYPRESS,				0, type, key) then Result := on_key_press 			(sender, key, data);
         elseif match_function_2 (SEL_KEYRELEASE,			0, type, key) then Result := on_key_release 		(sender, key, data);
         elseif match_function_2 (SEL_DND_ENTER,			0, type, key) then Result := on_dnd_enter 			(sender, key, data);
         elseif match_function_2 (SEL_DND_LEAVE,			0, type, key) then Result := on_dnd_leave 			(sender, key, data);
         elseif match_function_2 (SEL_DND_DROP,				0, type, key) then Result := on_dnd_drop 			(sender, key, data);
         elseif match_function_2 (SEL_DND_MOTION,			0, type, key) then Result := on_dnd_motion 			(sender, key, data);
         elseif match_function_2 (SEL_DND_REQUEST,			0, type, key) then Result := on_dnd_request 		(sender, key, data);
         elseif match_function_2 (SEL_FOCUS_SELF,			0, type, key) then Result := on_focus_self 			(sender, key, data);
         elseif match_function_2 (SEL_BEGINDRAG,			0, type, key) then Result := on_begin_drag 			(sender, key, data);
         elseif match_function_2 (SEL_ENDDRAG,				0, type, key) then Result := on_end_drag 			(sender, key, data);
         elseif match_function_2 (SEL_UPDATE,				Id_toggleshown,	type, key) then Result := on_upd_toggle_shown 	(sender, key, data);
         elseif match_function_2 (SEL_UPDATE,				Id_delete, 		type, key) then Result := on_upd_yes			(sender, key, data);
         elseif match_function_2 (SEL_COMMAND,			Id_show, 		type, key) then Result := on_cmd_show 			(sender, key, data);
         elseif match_function_2 (SEL_COMMAND,			Id_hide, 		type, key) then Result := on_cmd_hide 			(sender, key, data);
         elseif match_function_2 (SEL_COMMAND,			Id_toggleshown, type, key) then Result := on_cmd_toggle_shown 	(sender, key, data);
         elseif match_function_2 (SEL_COMMAND,			Id_raise, 		type, key) then Result := on_cmd_raise 			(sender, key, data);
         elseif match_function_2 (SEL_COMMAND,			Id_lower, 		type, key) then Result := on_cmd_lower 			(sender, key, data);
         elseif match_function_2 (SEL_COMMAND,			Id_enable, 		type, key) then Result := on_cmd_enable 		(sender, key, data);
         elseif match_function_2 (SEL_COMMAND,			Id_disable, 	type, key) then Result := on_cmd_disable 		(sender, key, data);
         elseif match_function_2 (SEL_COMMAND,			Id_update, 		type, key) then Result := on_cmd_update 		(sender, key, data);
         elseif match_function_2 (SEL_COMMAND,			Id_delete, 		type, key) then Result := on_cmd_delete 		(sender, key, data);
         else Result := Precursor (sender, type, key, data)
         end
      end

feature -- Destruction

	destruct is
      	do
         	if prev /= Void then
            	prev.set_next (next)
         	elseif parent /= Void then
            	parent.set_first_child (next)
         	end
         	if next /= Void then
            	next.set_prev (prev)
         	elseif parent /= Void then
            	parent.set_last_child (prev)
         	end
         	if parent /= Void and then parent.focus_child = Current then
            	parent.set_focus_child (Void)
         	end
         	if application.focus_window 		= Current then application.set_focus_window			(Void) end
         	if application.cursor_window 		= Current then application.set_cursor_window		(parent) end
         	if application.mouse_grab_window 	= Current then application.set_mouse_grab_window	(Void) end
         	if application.keyboard_grab_window	= Current then application.set_keyboard_grab_window	(Void) end
         	if application.key_window 			= Current then application.set_key_window			(Void) end
         	if application.selection_window 	= Current then application.set_selection_window		(Void) end
         	if application.clipboard_window 	= Current then application.set_clipboard_window		(Void) end
         	if application.drag_window 			= Current then application.set_drag_window			(Void) end
         	if application.drop_window 			= Current then application.set_drop_window			(Void) end
         	if application.refresher_window 	= Current then application.set_refresher_window		(parent) end
         	if parent /= Void then
            	parent.recalc
         	end
         	destroy_resource
         	parent := Void
         	owner := Void
         	first_child := Void
         	last_child := Void
         	next := Void
         	prev := Void
         	focus_child := Void
         	default_cursor := Void
         	drag_cursor := Void
         	accel_table := Void
         	message_target := Void
         	Precursor
      	end

feature {SB_WINDOW_DEF}

   set_last_child (ch: SB_WINDOW) is
      do
         last_child := ch
      end

   set_first_child (ch: SB_WINDOW) is
      do
         first_child := ch
      end

   set_next (nw: SB_WINDOW) is
      do
         next := nw
      end

   set_prev (pw: SB_WINDOW) is
      do
         prev := pw
      end

   set_focus_child(ch: SB_WINDOW) is
      do
         focus_child := ch
      end

feature { NONE } -- Implementation

   find_default (window: SB_WINDOW): SB_WINDOW is
      require
         non_void_window: window /= Void
      local
         win: SB_WINDOW
      do
         if (window.flags & Flag_default) = Flag_default then
            Result := window
         else
            from
               win := window.first_child
            until
               win = Void or Result /= Void
            loop
               Result := find_default (win)
               win := win.next
            end
         end
      end

	find_initial (window: SB_WINDOW): SB_WINDOW is
		require
			non_void_window: window /= Void
		local
			win: SB_WINDOW
		do
			if (window.flags & Flag_initial) = Flag_initial then
				Result := window
			else
				from
					win := window.first_child
				until
					win = Void or Result /= Void
				loop
					Result := find_initial (win)
					win := win.next
				end
			end
		end

	does_override_redirect: BOOLEAN is
		do
			Result := False
		end

	layout is
			-- Propagate window size change
		do
			unset_flags (Flag_dirty)
		end

   	Layout_mask: INTEGER is
      	once
         	Result := (Layout_side_mask  | Layout_right  | Layout_center_x | Layout_bottom
                     | Layout_center_y   | Layout_fix_x  | Layout_fix_y    | Layout_fix_width
                     | Layout_fix_height | Layout_fill_x | Layout_fill_y)
      	end

   	Layout_side_mask: INTEGER is
      	once
         	Result := (Layout_side_left | Layout_side_right | Layout_side_top | Layout_side_bottom)
      	end

   	Layout_HORIZONTAL_mask: INTEGER is
         	-- Horizontal placement options
      	once
         	Result := (Layout_left | Layout_right | Layout_center_x | Layout_fix_x | Layout_fill_x);
      	end

	Layout_VERTICAL_mask: INTEGER is
			-- Vertical placement options
		once
			Result := (Layout_top | Layout_bottom | Layout_center_y | Layout_fix_y | Layout_fill_y);
		end

feature -- Properties

--	frozen properties: ARRAY [ SB_PROPERTY ] is
--		once
--			create Result.make (1, 0)
--			add_properties (Result)
--		ensure then
--	--		Result.count >= 4
--		end

	add_properties is
		local
		--	p_x: SB_PROPERTY_X
		--	p_y: SB_PROPERTY_Y
		do
			Precursor
		--	create p_x;		to.add_last(p_x)
		--	create p_y;		to.add_last(p_y)
		end


feature -- Debugging

	trace_values is
		do
		end

	report_status is
			-- Report (print) configuration status info
		do
			print (once "Reporting status for: "); print (generating_type); print (once " @ "); print (($Current).out); print (once "%N")
			print (once "   Options: "); print (options.out); print (once "%N")
			print (once "   Width: "); print (width.out); print (once "%N")
			print (once "   Height: "); print (height.out); print (once "%N")
			print (once "   x_pos: "); print (x_pos.out); print (once "%N")
			print (once "   y_pos: "); print (y_pos.out); print (once "%N")
			
		end

end
