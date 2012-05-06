note
	platform:	"Win32"
	description:	"[
		Win32 implementation of all platform mapped windows
	]"
	todo: "[
		implement acquire/release clipboard
	]"

class SB_WINDOW

inherit

	SB_WINDOW_DEF
		redefine
			get_dc,
			release_dc
		end

feature

	grab_keyboard_imp
		do
			-- TODO
		end

	release_keyboard_imp
		do
			-- TODO
		end

	window_class_name: STRING
		once
			Result := "SBWindow"
		end

	create_resource_imp
		local
         	dwStyle, dwExStyle: INTEGER_32
         	hParent: POINTER
         	t: SB_TOP_WINDOW
         	t1: INTEGER
         	ws: SB_WAPI_WINDOW_STYLES
         	sw: SB_WAPI_SHOWWINDOW_COMMANDS
         	wf: SB_WAPI_WINDOW_FUNCTIONS
         	tt: INTEGER
		do
        		-- Most windows use these style bits
            dwStyle := ws.WS_CHILD | ws.WS_VISIBLE | ws.WS_CLIPSIBLINGS | ws.WS_CLIPCHILDREN
            dwExStyle := ws.WS_EX_NOPARENTNOTIFY;
            hParent := parent.resource_id
            if (flags & Flag_shell) = Flag_shell then
            	t ?= Current
               	if t /= Void then
                  	dwStyle := ws.WS_OVERLAPPEDWINDOW
               	elseif does_override_redirect then
                  		-- To control window placement or control decoration, a window 
                  		--  manager often needs to redirect map or configure requests. 
                  		--  Popup windows, however, often need to be mapped without 
                  		--  a window manager getting in the way.
                  	dwStyle := ws.WS_POPUP
                  	dwExStyle := ws.WS_EX_TOOLWINDOW
               	else
                  		-- Other top-level shell windows (like dialogs)
                  	dwStyle := ws.WS_POPUP | ws.WS_CAPTION;
                  	dwExStyle := ws.WS_EX_DLGMODALFRAME | ws.WS_EX_TOOLWINDOW
                  	-- if(hParent==GetDesktopWindow() && getApp()->getMainWindow()!=0){
                  	-- if(getApp()->getMainWindow()->id()) hParent=(HWND)getApp()->getMainWindow()->id();
               	end
               	if owner /= Void then 
                  	hParent := owner.resource_id
               	end
			end
            -- Create this window

			check valid_parent: hParent /= default_pointer end
			check valid_display_pointer: application.display /= default_pointer end

			fx_trace (0, <<"class_name = ", class_name>>)
            
            mem.collection_off
            resource_id := wf.CreateWindowEx (dwExStyle, window_class_name.area.base_address, default_pointer, dwStyle, x_pos, y_pos,
                                              width.max (1), height.max (1), hParent, default_pointer, application.display, $Current)
            mem.collection_on
            	-- We put the XdndAware property on all toplevel windows, so that
            	-- when dragging, we need to search no further than the toplevel window.
            if (flags & Flag_shell) = Flag_shell then
               --HANDLE propdata=(HANDLE)XDND_PROTOCOL_VERSION;
               -- SetProp((HWND)xid,(LPCTSTR)MAKELONG(getApp()->xdndAware,0),propdata);
            end

			check is_attached end
            
            if not is_attached then
            	-- Uh-oh, we failed
           		tt := wf.GetLastError;
               	fx_trace(0, <<"SB_WINDOW::create_resource FAILED ", tt.out>>)
            else
               -- Show if it was supposed to be.  Apparently, initial state
               -- is neither shown nor hidden, so an explicit hide is needed.
               -- Patch thanks to "Glenn Shen" <shen@hks.com>
               if (flags & Flag_shown) /= Zero then
                  t1 := wf.ShowWindow (resource_id, sw.SW_SHOWNOACTIVATE)
               else
                  t1 := wf.ShowWindow (resource_id, sw.SW_HIDE)
               end
            end
		end

	detach_resource_imp
		do
		end

	destroy_resource_imp
		local
        	wf: SB_WAPI_WINDOW_FUNCTIONS
        	t: INTEGER
		do
				-- Delete the XdndAware property
            if (flags & Flag_shell) /= Zero then
            --	RemoveProp (resource_id, application.xdndAware, 0)
            end
            	-- Break binding between HWND and Eiffel
            t := wf.SetWindowLong (resource_id, 0, 0)
            	-- Zap the window
            t := wf.DestroyWindow (resource_id)
		end

	on_destroy_def
		local
			wf: SB_WAPI_WINDOW_FUNCTIONS
			t: INTEGER
		do
			t := wf.SetWindowLong (resource_id, 0, 0);
		end

	string_type: INTEGER
			-- Clipboard text type (pre-registered)
      	local
         	cf: SB_WAPI_CLIPBOARD_FORMATS
      	once
         	Result := cf.CF_TEXT
      	end
		-------------------------------------------


	set_default_cursor_imp(cursor: SB_CURSOR)
			-- Set the default cursor for this window
      	local
         	fn: SB_WAPI_CURSOR_FUNCTIONS
         	t: POINTER
		do
        	if not is_mouse_grabbed then
        		t := fn.SetCursor (cursor.resource_id)
        	end
      	end

   	set_drag_cursor_imp (cursor: SB_CURSOR)
    		-- Set the drag cursor for this window
      	local
         	fn: SB_WAPI_CURSOR_FUNCTIONS
         	t: POINTER
      	do
        	if is_mouse_grabbed then
            	t := fn.SetCursor (cursor.resource_id)
			end
      	end

	once_point: SB_WAPI_POINT
		once
			create Result.make
		end

	get_cursor_position: SB_CURSOR_POSITION
		local
         	point: SB_WAPI_POINT
         	fn1: SB_WAPI_CURSOR_FUNCTIONS
         	fn2: SB_WAPI_COORDINATE_SPACE_AND_TRANSFORMATION_FUNCTIONS
         	t: INTEGER
		do
			point := once_point
         	if (is_attached) then
            	t := fn1.GetCursorPos (point.ptr)
            	t := fn2.ScreenToClient (resource_id, point.ptr)
            	create Result.make (point.x, point.y, sbmodifierkeys)
         	end
		end

	set_cursor_position(x, y: INTEGER): BOOLEAN
		local
         	pt: SB_WAPI_POINT
         	fn1: SB_WAPI_CURSOR_FUNCTIONS
         	fn2: SB_WAPI_COORDINATE_SPACE_AND_TRANSFORMATION_FUNCTIONS
         	t: INTEGER
		do
         	if is_attached then
         		pt := once_point
            	pt.set_x (x)
            	pt.set_y (y)
            	t := fn2.ClientToScreen (resource_id, pt.ptr)
            	t := fn1.SetCursorPos (pt.x, pt.y)
            	Result := True
         	end
		end

	enable_imp
         	-- Enable the window to receive mouse and keyboard events
		local
         	fn: SB_WAPI_WINDOW_FUNCTIONS
         	t: INTEGER
		do
			t := fn.EnableWindow (resource_id, 1)
		end

	disable_imp
         	-- Disable the window from receiving mouse and keyboard events
		local
         	fn: SB_WAPI_WINDOW_FUNCTIONS
         	fn1: SB_WAPI_MOUSE_INPUT_FUNCTIONS
         	fn2: SB_WAPI_CURSOR_FUNCTIONS
         	t: INTEGER
         	t1: POINTER
		do
			t := fn.EnableWindow (resource_id, 0)
			if application.mouse_grab_window = Current then
				t := fn1.ReleaseCapture
				t1 := fn2.SetCursor (default_cursor.resource_id)
				do_handle_2 (Current, SEL_UNGRABBED, 0, application.event)
				application.set_mouse_grab_window (Void)
			end
			if application.keyboard_grab_window = Current then
				application.set_keyboard_grab_window (Void)
			end
		end

	raise_imp
		local
         	wf: SB_WAPI_WINDOW_FUNCTIONS
         	swp: SB_WAPI_SWP_FLAGS
         	hwnd: SB_WAPI_HWND_VALUES
         	t: INTEGER
		do
			t := wf.SetWindowPos (resource_id, hwnd.HWND_TOP, 0,0, 0,0,
				swp.SWP_NOMOVE | swp.SWP_NOSIZE
				| swp.SWP_NOACTIVATE | swp.SWP_NOOWNERZORDER);
		end

	lower_imp
		local
         	wf: SB_WAPI_WINDOW_FUNCTIONS
         	swp: SB_WAPI_SWP_FLAGS
         	hwnd: SB_WAPI_HWND_VALUES
         	t: INTEGER
		do
			t := wf.SetWindowPos (resource_id, hwnd.HWND_BOTTOM, 0,0, 0,0,
				swp.SWP_NOMOVE | swp.SWP_NOSIZE
				| swp.SWP_NOACTIVATE | swp.SWP_NOOWNERZORDER)
		end

	move_imp (x, y: INTEGER)
		local
			wf: SB_WAPI_WINDOW_FUNCTIONS
			swp: SB_WAPI_SWP_FLAGS
			t: INTEGER
		do
        	t := wf.SetWindowPos (resource_id, default_pointer, x,y, 0,0,
					swp.SWP_NOSIZE
					| swp.SWP_NOZORDER
					| swp.SWP_NOACTIVATE
					| swp.SWP_NOOWNERZORDER)
		end
	
	resize_imp (w, h: INTEGER)
      	local
         	wf: SB_WAPI_WINDOW_FUNCTIONS
         	swp: SB_WAPI_SWP_FLAGS
         	hwnd: SB_WAPI_HWND_VALUES
         	t: INTEGER
		do
			t := wf.SetWindowPos (resource_id, default_pointer, 0,0, w,h,
				swp.SWP_NOMOVE | swp.SWP_NOZORDER 
                | swp.SWP_NOACTIVATE | swp.SWP_NOOWNERZORDER)
		end
        	
	position_imp (x, y, w, h, ow, oh: INTEGER)
		local
         	wf: SB_WAPI_WINDOW_FUNCTIONS
         	swp: SB_WAPI_SWP_FLAGS
         	t: INTEGER
		do
			t := wf.SetWindowPos (resource_id, default_pointer, x,y, w,h,
				swp.SWP_NOZORDER | swp.SWP_NOACTIVATE | swp.SWP_NOOWNERZORDER)
		end

	reparent_imp
		local
         	wf: SB_WAPI_WINDOW_FUNCTIONS
         	t: POINTER
		do
			t := wf.SetParent (resource_id, parent.resource_id)
		end

	once_rect: SB_WAPI_RECT
		once
			create Result.make
		end

	scroll (x, y, w, h, dx, dy: INTEGER)
         -- Scroll rectangle x,y,w,h by a shift of dx,dy
      local
         sw: SB_WAPI_SHOWWINDOW_COMMANDS
         sbf: SB_WAPI_SCROLL_BAR_FUNCTIONS
         rect: SB_WAPI_RECT
         t: INTEGER
      do
         if is_attached and then 0 < w and then 0 < h 
            and then  (dx /= 0 or else dy /= 0)
          then
          	rect := once_rect
            rect.set_left (x)
            rect.set_top (y)
            rect.set_right (x + w)
            rect.set_bottom (y + h)
            t := sbf.ScrollWindowEx (resource_id, dx, dy, rect.ptr, rect.ptr, default_pointer, default_pointer, sw.SW_INVALIDATE)
         end
      end

	update_rectangle_imp(x, y, w, h: INTEGER)
		local
         	r: SB_WAPI_RECT;
         	pf: SB_WAPI_PAINTING_AND_DRAWING_FUNCTIONS
         	t: INTEGER;
		do
          	r := once_rect
			r.set_left (x)
			r.set_top (y)
			r.set_right (x + w)
			r.set_bottom (y + h)
			t := pf.InvalidateRect (resource_id, r.ptr, 1)
		end

	repaint_rectangle_imp (x, y, w, h: INTEGER)
		local
         	r: SB_WAPI_RECT
         	pf: SB_WAPI_PAINTING_AND_DRAWING_FUNCTIONS
         	rdw: SB_WAPI_REDRAW_WINDOW_FLAGS
         	t: INTEGER
		do
          	r := once_rect
			r.set_left (x)
			r.set_top (y)
			r.set_right (x + w)
			r.set_bottom (y + h)
			t := pf.RedrawWindow (resource_id, r.ptr, default_pointer,
                                       rdw.RDW_UPDATENOW)
		end

	grab_mouse
         -- Grab the mouse to this window; future mouse events will be
         -- reported to this window even while the cursor goes outside
         -- of this window
      	local
         	mf: SB_WAPI_MOUSE_INPUT_FUNCTIONS
         	cf: SB_WAPI_CURSOR_FUNCTIONS
         	t: POINTER
      	do
         	if is_attached then
            	t := mf.SetCapture (resource_id)
            	if mf.GetCapture /= resource_id then
               		t := mf.SetCapture (resource_id)
            	end
            	t := cf.SetCursor (drag_cursor.resource_id)
            	application.set_mouse_grab_window (Current)
         	end
		end

	release_mouse
         -- Release the mouse grab
      	local
         	mf: SB_WAPI_MOUSE_INPUT_FUNCTIONS
         	cf: SB_WAPI_CURSOR_FUNCTIONS
         	t: INTEGER
         	t1: POINTER
      	do
         	if is_attached then
            	application.set_mouse_grab_window (Void)
            	t := mf.ReleaseCapture
            	t1 := cf.SetCursor (default_cursor.resource_id)
         	end
		end

	show_imp
		local
         	sw: SB_WAPI_SHOWWINDOW_COMMANDS
         	wf: SB_WAPI_WINDOW_FUNCTIONS
         	t: INTEGER
		do
			t := wf.ShowWindow (resource_id, sw.SW_SHOWNOACTIVATE)
		end

	hide_imp
		local
         	cf: SB_WAPI_CURSOR_FUNCTIONS
         	sw: SB_WAPI_SHOWWINDOW_COMMANDS
         	wf: SB_WAPI_WINDOW_FUNCTIONS
         	t: INTEGER
         	t1: POINTER
		do
			if application.mouse_grab_window = Current then
            	release_mouse
                t1 := cf.SetCursor (default_cursor.resource_id)
                do_handle_2 (Current, SEL_UNGRABBED, 0, application.event)
                application.set_mouse_grab_window (Void)
      		end
            if application.keyboard_grab_window = Current then
            	application.set_keyboard_grab_window (Void)
            end
            t := wf.ShowWindow (resource_id, sw.SW_HIDE)
		end

   translate_coordinates_from (fromwindow: SB_WINDOW; fromx, fromy: INTEGER): SB_POINT
         -- Translate coordinates from fromwindow's coordinate space to
         -- this window's coordinate space
      require
         fromwindow /= Void
      local
         pt: SB_WAPI_POINT
         cf: SB_WAPI_COORDINATE_SPACE_AND_TRANSFORMATION_FUNCTIONS
         t: INTEGER
      do
         create Result.make (0, 0)
         if is_attached and fromwindow.is_attached then
         	pt := once_point
            pt.set_x (fromx)
            pt.set_y (fromy)
            t := cf.ClientToScreen (fromwindow.resource_id, pt.ptr)
            t := cf.ScreenToClient (resource_id, pt.ptr)
            Result.make (pt.x, pt.y)
         end
      end

   translate_coordinates_to (towindow: SB_WINDOW; fromx, fromy: INTEGER): SB_POINT
         -- Translate coordinates from this window's coordinate space
         --  to towindow's coordinate space
      require
         towindow /= Void
      local
         pt: SB_WAPI_POINT
         cf: SB_WAPI_COORDINATE_SPACE_AND_TRANSFORMATION_FUNCTIONS
         t: INTEGER
      do
         create Result.make (0, 0)
         if is_attached and towindow.is_attached then
         	pt := once_point
            pt.set_x (fromx)
            pt.set_y (fromy)
            t := cf.ClientToScreen (resource_id, pt.ptr)
            t := cf.ScreenToClient (towindow.resource_id, pt.ptr)
            Result.make (pt.x, pt.y)
         end
      end

	acquire_clipboard_imp (types: ARRAY [ INTEGER ]): BOOLEAN
		local
        	cfn: SB_WAPI_CLIPBOARD_FUNCTIONS
			t: INTEGER
			tp: POINTER
			i, e: INTEGER
		do
			if cfn.OpenClipboard (resource_id) /= 0 then
				t := cfn.EmptyClipboard  -- Will cause SEL_CLIPBOARD_LOST to be sent to owner
				from
					i := types.lower
					e := types.upper
				until
					i > e
				loop
					tp := cfn.SetClipboardData (types.item (i), default_pointer)
					i := i + 1
				end
				t := cfn.CloseClipboard
				if cfn.GetClipboardOwner = resource_id then
					application.set_clipboard_window (Current)
					do_handle_2 (Current, SEL_CLIPBOARD_GAINED, 0, application.event)
					Result := True
				end
			end
		end

	release_clipboard_imp
		local
         	cfn: SB_WAPI_CLIPBOARD_FUNCTIONS
         	t: INTEGER
		do
        	if cfn.OpenClipboard (resource_id) /= 0 then
            	t := cfn.EmptyClipboard   -- Will cause SEL_CLIPBOARD_LOST to be sent to Current window
                t := cfn.CloseClipboard
        	end
		end
	

feature {NONE}-- Implementation

   	get_dc: POINTER
      	local
         	fn: SB_WAPI_DEVICE_CONTEXT_FUNCTIONS;
      	do
         	Result := fn.GetDC (resource_id)
      	end

   	release_dc (dc: POINTER): INTEGER
      	local
         	fn: SB_WAPI_DEVICE_CONTEXT_FUNCTIONS;
      	do
         	Result := fn.ReleaseDC (resource_id, dc)
      	end

	sbmodifierkeys: INTEGER_32
		external "C"
		alias "sbmodifierkeys"
		end;

invariant
--	width_positive: width > 0		-- ???
--	height_positive: height > 0		-- ???
end