-- X Window System Implementation
note

	todo: "[
		string_type - Define XA_STRING in an X related class
	]"

class SB_WINDOW

inherit
	SB_WINDOW_DEF
		rename
			resource_id as xwin
		redefine
			xwin
		end

	X_WINDOW_CONSTANTS

	X_GLOBAL	-- For None_...

	X_PREDEFINED_ATOMS -- For Xa_string

create
	make_ev

feature -- attributes

	xwin: X_WINDOW

	xdwin: X_DRAWABLE_WINDOW
		do
			Result ?= xwin
		ensure
			xwin /= Void implies Result /= Void
		end

	x_offset: INTEGER
	y_offset: INTEGER
			-- Offset of X-window from virtual x,y to ensure that
			-- X protocol values of x,y,width,height fit within the
			-- 16-bit signed value space

feature -- resource creation/deletion

	create_resource_imp
		require else
			parent /= Void implies parent.xwin /= Void
		--	owner /= Void implies owner.xwin /= Void
			visual /= Void	-- XX
		local
			wattr: X_SET_WINDOW_ATTRIBUTES
			hint: X_CLASS_HINT
			mask: INTEGER
		do
			visual.create_resource

				-- Fill in the attributes
			create wattr.make

			mask := basic_event_mask

				-- Events for shell windows
			if is_shell then
				mask := mask | shell_event_mask
			end

				-- If enabled, turn on some more events
			if (flags & Flag_enabled) /= 0 then
				mask := mask | enabled_event_mask
			end

				-- Events for normal windows
			wattr.set_event_mask (mask)

				-- Do not propagate events to ancestor windows ??
		--	wattr.set_do_not_propagate_mask (NOT_PROPAGATE_MASK)

				-- Obtain colormap
		--	wattr.set_colormap (visual.colormap)

				-- This is needed for OpenGL
		--	wattr.set_border_pixel (0)

				-- Background
		--	wattr.set_background_pixmap (None)
		--	wattr.set_background_pixel (visual.get_pixel(back_color))

				-- Preserving content during resize will be faster:- not turned
				-- on yet as we will have to recode all widgets to decide when to
				-- repaint or not to repaint the display when resized...
		--	wattr.set_bit_gravity (NorthWestGravity)
			wattr.set_bit_gravity (ForgetGravity)

				-- The window gravity is NorthWestGravity, which means
				-- if a child keeps same position relative to top/left
				-- of its parent window, nothing extra work is incurred.
			wattr.set_win_gravity (NorthWestGravity)

				-- Determine override redirect
			wattr.set_override_redirect (does_override_redirect)

				-- Determine save-unders
			wattr.set_save_under (does_save_under)

				-- DEBUG: check default_cursor validity
			if default_cursor.xid = Void then
				check false end
			--	edp_trace.start (0, "default_cursor is invalid!").done
			else
					-- Set cursor
				wattr.set_cursor (default_cursor.xid)
			end -- DEBUG

			check
				parent_not_void:	parent /= Void
				pxid_not_void:		parent.xwin /= Void
				visual_ok:			visual.visual /= Void
				wattr_ok:			wattr /= Void
			end

			-- Finally, create the window
			create {X_DRAWABLE_WINDOW} xwin.make (
				parent.xwin,					-- parent
				x_pos, y_pos,					-- position
				width.max (1), height.max (1), 	-- width/height
				0,								-- border_width ??
				visual.depth,					-- bits-per-pixel
				visual.visual,
				wattr.mask,
				wattr)

				-- Uh-oh, we failed
	    	if not xwin.is_attached then
	    		check false end
			--	edp_trace.start (0, "SB_WINDOW::create_resource_imp -- UNABLE TO CREATE WINDOW !!!").done
			end

			application.wcontext.put (Current)

				--     Set resource and class name for toplevel windows.
				--     In a perfect world this would be set in FXTopWindow, but for some strange reasons
				--     some window-managers (e.g. fvwm) this will be too late and they will not recognize them.
				--     Patch from axel.kohlmeyer@chemie.uni-ulm.de
			if is_shell then
				create hint.make
				hint.set_res_name ("Slyboots_App")
				hint.set_res_class ("Slyboots_Window")
				xwin.set_class_hint (hint)
			end

				--	We put the XdndAware property on all toplevel windows, so that
				--	when dragging, we need to search no further than the toplevel window.
			if is_shell then
	--      --	Atom propdata=(Atom)XDND_PROTOCOL_VERSION;
	--			prop_data.wipe_out
	--			prop_data.extend(XDND_PROTOCOL_VERSION);
	--      --	XChangeProperty(DISPLAY(application()), xwin, application.xdndAware, XA_ATOM, 32, PropModeReplace, (unsigned char*)&propdata, 1);
	--			xwin.change_property (application.xdndAware, XA_ATOM, 32, PropModeReplace, (unsigned char*)&propdata, 1);
			end
	--
				--	If window is a shell and it has an owner, make it stay on top of the owner
	--		if is_shell and then owner /= Void then
	--			xwin.set_transient_for_hint (owner.getShell)
	--		end
	--
				--	If colormap different, set WM_COLORMAP_WINDOWS property properly
	--    	if(visual->colormap /= DefaultColormap(DISPLAY(application()),DefaultScreen(DISPLAY(application())))){
	--			FXTRACE((150,"%s::create: %p: adding to WM_COLORMAP_WINDOWS\n",getClassName(),this));
	--			add_colormap_windows
	--		end

				-- Show if it was supposed to be
			if (flags & Flag_shown) /= 0 and then (0 < width) and then (0 < height) then
				xwin.map
				flush
			end
		end

	detach_resource_imp
		do
			-- TODO
			check false end
		end

	destroy_resource_imp
			-- Destroy the server-side resources for this window
		do
			application.wcontext.remove (Current)

				-- If colormap different, set WM_COLORMAP_WINDOWS property properly
        --	if(visual->colormap /= DefaultColormap(DISPLAY(getApp()),DefaultScreen(DISPLAY(getApp())))) then
        --		fx_trace((150,"%s::destroy: %p: removing from WM_COLORMAP_WINDOWS\n",class_name,this));
        --		remove_colormap_windows
        -- 	end
        		-- Delete the XdndAware property
        	if is_shell then
          	--	XDeleteProperty(application.display.to_external, xwin.id, application.xdndAware)
          	end
        		-- Delete the window
        	xwin.destroy
		end

	on_destroy_def
		do
			application.wcontext.remove (Current)
		end

feature

	string_type: INTEGER
			-- Clipboard text type (pre-registered)
		once
			Result := Xa_string
		end

	basic_event_mask: INTEGER
			-- Basic events
		once
			Result := Structure_notify_mask
					| Exposure_mask
					| Property_change_mask
					| Enter_window_mask | Leave_window_mask
					| Key_press_mask	| Key_release_mask
		end

	shell_event_mask: INTEGER
			-- Additional events for shell widget events
		once
			Result := Focus_change_mask | Structure_notify_mask
		end

	enabled_event_mask: INTEGER
			-- Additional events for enabled widgets
		once
			Result := Button_press_mask | Button_release_mask | Pointer_motion_mask
		end

	grab_event_mask: INTEGER
			-- These events are grabbed for mouse grabs
		once
			Result := ButtonPressMask | ButtonReleaseMask
				| PointerMotionMask
				| EnterWindowMask | LeaveWindowMask
		end

	not_propagate_mask: INTEGER
			-- Do not propagate mask
		once
			Result := KeyPressMask | KeyReleaseMask
					| ButtonPressMask | ButtonReleaseMask
					| PointerMotionMask | ButtonMotionMask
		end

	set_default_cursor_imp(cursor: SB_CURSOR)
		do
			xwin.define_cursor(cursor.xid)
		end

   	set_drag_cursor_imp (cursor: SB_CURSOR)
         	-- Set the drag cursor for this window
      	require else
         	good_cursor: cursor /= Void
      	do
      		if is_mouse_grabbed then
      			-- TODO
			--	edp_trace.start(0, class_name).next("set_drag_cursor -- TODO").done
      		end
      	end

   	get_cursor_position: SB_CURSOR_POSITION
         	-- Return the cursor position and mouse button-state
      	do
         	if (is_attached) then
         		-- TODO
			--	edp_trace.start(0, class_name, "::get_cursor_position -- TODO").done
				Result := Void
         	end
      	end

	set_cursor_position (x, y : INTEGER): BOOLEAN
         	-- Warp the cursor to the new position
      	do
         	if is_attached then
         		-- TODO
			--	edp_trace.start(0, class_name).next("set_cursor_position -- TODO").done
			--	display.warp_pointer (None, xwin, 0, 0, 0, 0, x, y)
            	Result := True
         	end
      	end

	enable_imp
         	-- Enable the window to receive mouse and keyboard events
      	local
      		events: INTEGER
		do
			events := basic_event_mask | enabled_event_mask
		   	if is_shell then
		   		events := events | shell_event_mask
		   	end
		   	xwin.select_input (events)
		end

	disable_imp
    		-- Disable the window from receiving mouse and keyboard events
      	local
      		events: INTEGER
      	do
		    events := basic_event_mask
		    if is_shell then
		    	events := events | shell_event_mask
			end
			xwin.select_input (events)
            if application.mouse_grab_window = Current then
				xwin.ungrab_pointer (CurrentTime)
				display.flush
               	do_handle_2 (Current, SEL_UNGRABBED, 0, application.event)
                application.set_mouse_grab_window (Void)
			end
            if application.keyboard_grab_window = Current then
		    	xwin.ungrab_keyboard (application.event.time)
		 		display.flush
            	application.set_keyboard_grab_window (Void)
			end
		end

	display: X_DISPLAY
		do
			Result := application.display
		end

	flush
		do
			display.flush
		end

	raise_imp
			-- Raise this window to the top of the stacking order
      	do
			xwin.raise_window
      	end

	lower_imp
		do
			xwin.lower
		end

	move_imp (x, y: INTEGER)
         	-- Move this window to the specified position in the parent's
         	-- coordinates
      	do
			xwin.move (x, y)
      	end

   	resize_imp (w, h: INTEGER)
         	-- Resize this window to the specified width and height
      	do
			if 0 < w and 0 < h then
				if (flags & Flag_shown) /= 0 and then (width <= 0 or height <= 0) then
	          		xwin.map
	        	end
	        	xwin.resize (w, h)
			else
				if 0 < width and 0 < height then
	        		xwin.unmap
	        	end
			end
      	end

   	position_imp (x, y, w, h, ow, oh: INTEGER)
         	-- Move and resize this window in the parent's coordinates
      	local
         	resized: BOOLEAN
      	do
	    	if 0 < w and 0 < h then
	        	if (flags & Flag_shown) /= 0 and then (ow <= 0 or else oh <= 0) then
	          		xwin.map
	        	end
	        	xwin.move_resize (x, y, w, h)
	      	else
				if 0 < ow and 0 < oh then
	        		xwin.unmap
				end
      		end
      	end

   	reparent_imp
         	-- Change the parent for this window
		do
			xwin.reparent (parent.xwin, 0, 0)
      	end

	scroll (x, y, w, h, dx, dy : INTEGER)
        	-- Scroll rectangle x,y,w,h by a shift of dx,dy
      	local
			tx,ty,fx,fy,ex,ey,ew,eh: INTEGER
			--      XEvent event
		do
			if is_attached and then 0 < w and then 0 < h
         	and then  (dx /= 0 or else dy /= 0) then

			    if w <= dx.abs or else h <= dy.abs then
					-- No overlap:- repaint the whole thing
			    	application.add_repaint (xwin.id, x, y, w, h, True)

				else
					-- Has overlap, so blit contents and repaint the exposed parts

						-- Force server to catch up
					display.sync (False)

					-- Pull any outstanding repaint events into our own repaint rectangle list
			   --	while(XCheckWindowEvent(DISPLAY(getApp()),xid,ExposureMask,&event)){
			   --		if(event.xany.type==NoExpose) continue;
			   --		application.add_repaint(xid, event.xexpose.x, event.xexpose.y, event.xexpose.width, event.xexpose.height, 0);
			   --		if(event.xgraphicsexpose.count==0) break;
			   --	end

			      	-- Scroll all repaint rectangles of this window by the dx,dy
			      	application.scroll_repaints (xwin, dx, dy)

			      	-- Compute blitted area
			      	if dx > 0 then	-- Content shifted right
			      		fx := x
			      		tx := x + dx
			      		ex := x
			      		ew := dx
			      	else			-- Content shifted left
			      		fx := x - dx
			      		tx := x
			      		ex := x + w + dx
			      		ew := -dx
			      	end
			      	if dy > 0 then	-- Content shifted down
			      		fy := y
			      		ty := y + dy
			      		ey := y
			     		eh := dy
			      	else			-- Content shifted up
			      		fy := y - dy
			      		ty := y
			      		ey := y + h + dy
			      		eh := -dy
			      	end

			      	-- BLIT the contents
			      	xdwin.copy_area (tx, ty, xdwin, fx, fy, w-ew, h-eh)	-- FIXME: scroll_gc ???

			      	-- Post additional rectangles for the uncovered areas
			      	if dy /= 0 then
			      		application.add_repaint (xwin.id, x, ey, w, eh, True)
			      	end
					if dx /= 0 then
			        	application.add_repaint (xwin.id, ex, y, ew, h, True)
			      	end
				end
			end
		end

	update_rectangle_imp (x, y, w, h : INTEGER)
        	-- Mark the specified rectangle dirty, i.e. to be repainted
		do
			application.add_repaint (xwin.id, x,y, w,h, True)
		end

	repaint_rectangle_imp (ax, ay, aw, ah: INTEGER)
			-- If marked but not yet painted, paint the given area
		local
			x,y,w,h: INTEGER
		do
			if is_attached then

				x := ax; y := ay; w := aw; h := ah
	    			-- We toss out rectangles outside the visible area
	    		if (x >= width or else y >= height or else x + w <= 0 or else y + h <= 0)
	    		then
					-- Not visible
	    		else

		    		-- Intersect with the window
		    		if x < 0 then w := w + x; x := 0; end
		    		if y < 0 then h := h + y; y := 0; end
					if x + w > width  then w := width  - x; end
		    		if y + h > height then h := height - y; end

		    		if w > 0 and h > 0 then
		      			application.remove_repaints (Current, x,y, w,h)
					end
				end
			end
		end

	grab_mouse
         	-- Grab the mouse to this window; future mouse events will be
         	-- reported to this window even while the cursor goes outside
         	-- of this window
      	local
      		t: INTEGER
      	do
         	if is_attached then
				t := xwin.grab_pointer (False, grab_event_mask, GrabModeAsync, GrabModeAsync, None_window, None_cursor, application.event.time)
				if t /= GrabSuccess then
					t := xwin.grab_pointer (False, grab_event_mask, GrabModeAsync, GrabModeAsync, None_window, None_cursor, CurrentTime)
				end
            	application.set_mouse_grab_window (Current)
         	end
      	end

   	release_mouse
         	-- Release the mouse grab
      	do
         	if is_attached then
            	application.set_mouse_grab_window (Void)
				xwin.ungrab_pointer (application.event.time)
				application.flush	-- TEMP to avoid system lockout
         	end
      	end

	show_imp
			-- Show this window
		do
			if 0 < width and then 0 < height then
				xwin.map
			end
		end

   	hide_imp
         	-- Hide this window
      	do
			if application.mouse_grab_window = Current then
				xwin.ungrab_pointer (CurrentTime)
				display.flush
				do_handle_2 (Current, SEL_UNGRABBED, 0, application.event)
				application.set_mouse_grab_window (Void)
			end
			if application.keyboard_grab_window = Current then
				xwin.ungrab_keyboard (application.event.time)
				display.flush;
				application.set_keyboard_grab_window (Void)
			end
			xwin.unmap
      end

   translate_coordinates_from (fromwindow: SB_WINDOW; fromx, fromy: INTEGER): SB_POINT
         -- Translate coordinates from fromwindow's coordinate space to
         -- this window's coordinate space
      require -- else
         fromwindow /= Void
      do
         create Result.make (0, 0)
         if is_attached and fromwindow.is_attached then
			if fromwindow.xwin.translate_coordinates (xwin, fromx, fromy) then
				Result.set_x (fromwindow.xwin.last_translated_x)
				Result.set_y (fromwindow.xwin.last_translated_y)
			end
         end
      end

   translate_coordinates_to (towindow: SB_WINDOW; fromx, fromy: INTEGER): SB_POINT
         -- Translate coordinates from this window's coordinate space
         --  to towindow's coordinate space
      require -- else
         towindow /= Void
      do
         create Result.make (0, 0)
         if is_attached and towindow.is_attached then
			if xwin.translate_coordinates (towindow.xwin, fromx, fromy) then
				Result.set_x (xwin.last_translated_x)
				Result.set_y (xwin.last_translated_y)
			end
         end
      end

   acquire_clipboard_imp(types: ARRAY[INTEGER]): BOOLEAN
         -- Try to acquire the clipboard, given a list of drag types
      require else
         types /= Void and then not types.is_empty
      do
			if application.clipboard_window /= Void then
				application.clipboard_window.do_handle_2 (application, SEL_CLIPBOARD_LOST, 0, application.event)
				application.set_clipboard_window (Void)
				application.free_xcb_typelist
			end
		--  display.set_selection_owner (application.xcb_selection, xwin, application.event.time)
		--  if display.get_selection_owner (application.xcb_selection) /= xwin then
		--		Result := False
		--	else
		--    	if application.clipboard_window = Void then
		--			application.set_xcb_typelist (types)
		--      	application.set_clipboard_window (Current)
		--      	application.clipboard_window.do_handle_2 (Current, SEL_CLIPBOARD_GAINED, 0, application.event);
		--    	end
		--    	Result := True
		--	end
      end

	release_clipboard_imp
		require else
			implemented: false
		do
			do_handle_2 (Current, SEL_CLIPBOARD_LOST, 0, application.event)

		--  display.set_selection_owner (application.xcb_selection, None, application.event.time)

		--	application.set_xcb_typelist (Void)
		end

feature { NONE } -- Implementation

	add_colormap_windows
		do
		end

	rem_colormap_windows
    	do
      	end

feature -- Implementation features - to be moved to appropriate textual location

	grab_keyboard_imp
		do
		end

	release_keyboard_imp
		do
		end

end
