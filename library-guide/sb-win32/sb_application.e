note

	todo: "[
		Fix Mouse Wheel: find_window_at is currently missing ?
	]"

class SB_APPLICATION

inherit
	SB_APPLICATION_DEF
		redefine
			register_window
		end

	SB_APPLICATION_EXTERNALS
	SB_EXTERNAL_OBJECT

	SB_WAPI_WINDOW_MESSAGES
		export {NONE} all
		end

feature -- Attributes

feature -- Unimplemented !!!

	flush_aux (sync: BOOLEAN)
		do
		end

	find_window_with_id (i: INTEGER): SB_WINDOW
		do
		end

	find_window_at (x, y: INTEGER; i: INTEGER): SB_WINDOW
		do
		end

	peek_event: BOOLEAN
		do
		end

	add_timeout (ms: INTEGER; tgt: SB_MESSAGE_HANDLER; sel: INTEGER): SB_TIMER
		do
		end

	remove_timeout(timer: SB_TIMER)
		do
		end

	open_display (dpyname: STRING): BOOLEAN
			-- Connection to display; this is called by init()
		do
         	Result := np_open_display (to_external, dpyname)
         	if Result then
            	initialized := True
            else
            	fx_trace (0, <<"open_display: FALSE">>)
         	end
      	end

	close_display: BOOLEAN
		do
			-- TODO
		end

	beep
    	local
    		t: INTEGER;
    	do
      		if initialized then
            	t := wapi_api.MessageBeep (wapi_mbfl.MB_OK)
         	end
		end

	run_one_event
			-- Perform one event dispatch
		do
			create_new_resources
			ext_run_one_event (to_external, $again)
		end

	init_colours
		do
			border_color	:= sbrgb (0, 0, 0)
         	base_color 		:= sbrgb (192, 192, 192)
         	hilite_color 	:= u.make_hilite_color (base_color)
         	shadow_color 	:= u.make_shadow_color (base_color)
         	back_color		:= sbrgb (255, 255, 255)
         	fore_color		:= sbrgb (0, 0, 0)
         	sel_fore_color 	:= sbrgb (255, 255, 255)
         	sel_back_color 	:= sbrgb (0, 0, 128)
         	tip_fore_color 	:= sbrgb (0, 0, 0)
         	tip_back_color 	:= sbrgb (255, 255, 192)
		end

feature -- Creation

	make_imp
		do
		--	create normal_font.make_opts(Current, "helvetica", 9, FONTWEIGHT_BOLD, FONTSLANT_REGULAR, FONTENCODING_DEFAULT, FONTSETWIDTH_DONTCARE, Zero);
			create normal_font.make(Current, "fixedsys", 9)	-- , FONTWEIGHT_BOLD, FONTSLANT_REGULAR, FONTENCODING_DEFAULT, FONTSETWIDTH_DONTCARE, Zero);
			init_colours
			from_external(ext_make(Current, hinstance, SEL_IO_READ, SEL_IO_WRITE, SEL_IO_EXCEPT,
            		$handle_event_helper,
            		$handle_signal_helper,
            		$handle_input_helper,
            		$handle_refresher_helper,
            		$dispatch_event_helper));
		end

feature -- Cursors

	make_cursors
		local
			new_cursor: SB_CURSOR
		do
			-- Make some cursors
			create cursors.make(1, Def_rotate_cursor + 1)

			-- Stock cursors
			create new_cursor.make_from_stock (Current, CURSOR_ARROW);	cursors.put (new_cursor, Def_arrow_cursor)
			create new_cursor.make_from_stock (Current, CURSOR_RARROW);	cursors.put (new_cursor, Def_rarrow_cursor)
			create new_cursor.make_from_stock (Current, CURSOR_IBEAM);	cursors.put (new_cursor, Def_text_cursor)

		-- Cursors from bit patterns

			-- Cursors for splitter
			cursors.put (hsplit_cursor, Def_hsplit_cursor)
			cursors.put (vsplit_cursor, Def_vsplit_cursor)
			cursors.put (xsplit_cursor, Def_xsplit_cursor)

			-- Color swatch
			cursors.put (swatch_cursor, Def_swatch_cursor)

			-- Move
			cursors.put (move_cursor, Def_move_cursor)

			-- Dragging edges/corners
			cursors.put (resizetop_cursor, 		Def_dragh_cursor)
			cursors.put (resizeleft_cursor, 	Def_dragv_cursor)
			cursors.put (resizetopright_cursor,	Def_dragtr_cursor)
			cursors.put (resizetopleft_cursor,	Def_dragtl_cursor)

			-- DND actions
			cursors.put (dontdrop_cursor, Def_dndstop_cursor)
			cursors.put (dndcopy_cursor,  Def_dndcopy_cursor)
			cursors.put (dndmove_cursor,  Def_dndmove_cursor)
			cursors.put (dndlink_cursor,  Def_dndlink_cursor)

			-- Crosshairs
			cursors.put (crosshair_cursor, Def_crosshair_cursor)

			-- NE,NW,SE,SW corners
			cursors.put (ne_cursor, Def_cornerne_cursor)
			cursors.put (nw_cursor, Def_cornernw_cursor)
			cursors.put (se_cursor, Def_cornerse_cursor)
			cursors.put (sw_cursor, Def_cornersw_cursor)

			  -- Rotate
			cursors.put (rotate_cursor, Def_rotate_cursor)		
		end

feature {NONE} -- static private data

	lastmovehwnd, oldhwnd: POINTER
	lastmovelParam: INTEGER

feature {SB_WINDOW_DEF}

	register_window (w: SB_WINDOW_DEF)
		do
			Precursor (w)
			target_set := w
		end

feature {NONE} -- helpers for external C code

	target_set: SB_MESSAGE_HANDLER

	frozen handle_event_helper (target: SB_MESSAGE_HANDLER; cmnd, id: INTEGER): BOOLEAN
		local
			mh: SB_MESSAGE_HANDLER
		do
			if false then
				mh := target_set
			else
				mh ?= target
			end
			check mh /= Void end
			Result := mh.handle_2 (Current, cmnd, id, event)
		end

   frozen handle_signal_helper (target: SB_MESSAGE_HANDLER; selector, signal: INTEGER): BOOLEAN
      do
         -- todo implement
      end

   frozen handle_input_helper (target: SB_MESSAGE_HANDLER; selector: INTEGER; input: POINTER): BOOLEAN
      do
         -- todo implement
      end

	frozen handle_refresher_helper: BOOLEAN
			-- GUI updating:- walk the whole widget tree
		do
			if refresher_window /= Void then
				refresher_window.do_handle_2 (Current, SEL_UPDATE, 0, Void)
				if refresher_window.first_child /= Void then
					refresher_window := refresher_window.first_child
				else
					from
					until
						refresher_window.next /= Void or else refresher_window.parent = Void
					loop
						refresher_window := refresher_window.parent
					end
					refresher_window := refresher_window.next
				end
				Result := True
			else
					-- We walked the whole tree; should we do it again?
				if again then
					refresher_window := root_window
					again := False
					Result := True
				end
			end
		end

   get_sb_window (hwnd: POINTER): SB_WINDOW
      local
      do
         if hwnd /= default_pointer and then wapi_wf.IsWindow (hwnd) /= 0 then
            Result := GetWindowLong (hwnd, 0)
         end
      end

   	leave_window (win, anc: SB_WINDOW)
      		-- Generate SEL_LEAVE for windows wnd and its ancestors; note that the
      		-- LEAVE events are generated in the order from child to parent
      	local
         	t: INTEGER
--       	pt: expanded SB_WAPI_POINT
         	dwpts: INTEGER
      	do
         	if win /= Void  and then (win.parent /= Void and win /= anc) then
            	event.set_type (SEL_LEAVE)
            	dwpts := wapi_mf.GetMessagePos
      --      	pt.set_x (wapi_wmc.GET_X_LPARAM(dwpts))
      --      	pt.set_y (wapi_wmc.GET_Y_LPARAM(dwpts))
      --      	event.set_root_x (pt.x)
      --      	event.set_root_y (pt.y)
      --      	t := wapi_cf.ScreenToClient (win.resource_id, pt.ptr)
      --      	event.set_win_x (pt.x)
      --      	event.set_win_y (pt.y)
            	win.do_handle_2 (Current, SEL_LEAVE, 0, event)
            	leave_window (win.parent, anc)
         	end
      	end

	enter_window (win, anc: SB_WINDOW)
      		-- Generate SEL_ENTER for windows and its ancestors; note that the
      		-- ENTER events are generated in the order from parent to child
      	local
         	t: INTEGER
		--	pt: expanded SB_WAPI_POINT
         	dwpts: INTEGER
      	do
         	if win /= Void and then (win.parent /= Void and then win /= anc) then
            	enter_window (win.parent, anc)
            	event.set_type (SEL_ENTER)
            	dwpts := wapi_mf.GetMessagePos
            --	pt.set_x (wapi_wmc.GET_X_LPARAM (dwpts))
            --	pt.set_y (wapi_wmc.GET_Y_LPARAM (dwpts))
            --	event.set_root_x (pt.x)
            --	event.set_root_y (pt.y)
            --	t := wapi_cf.ScreenToClient (win.resource_id, pt.ptr)
            --	event.set_win_x (pt.x)
            --	event.set_win_y (pt.y)
            	win.do_handle_2 (Current, SEL_ENTER, 0, event)
         	end
      	end

   frozen dispatch_event_helper (hWnd: POINTER; uMsg, wParam, lParam: INTEGER): INTEGER
      local
         rect: SB_WAPI_RECT
         pt, pt_root: SB_WAPI_POINT
         ps: SB_WAPI_PAINTSTRUCT
         window, oldwindow, ancestor, win: SB_WINDOW
         dwpts: INTEGER
         t: INTEGER
         t1,t2: INTEGER_32
         t3: POINTER
         hwnd1: POINTER
         uScanCode: INTEGER
         ks, buf: STRING
         curinside, oldinside: BOOLEAN
         iFormat: INTEGER
         nchanged: INTEGER
         state: INTEGER_32
         hdc: POINTER
         old_palette: POINTER
         sbp: SB_POINT
      do
         if wapi_wf.IsWindow (hWnd) = 0 then
            Result := wapi_mf.DefWindowProc (hWnd, uMsg, wParam, lParam)
         else
            window := GetWindowLong (hWnd, 0)
            if window = Void and then uMsg /= WM_CREATE then
               Result := wapi_mf.DefWindowProc (hWnd, uMsg, wParam, lParam)
            else
               create rect.make
               create pt.make
               create pt_root.make
               create ps.make
               	-- Translate Win32 message to FOX message type
               inspect uMsg
                  -- Repaint event
               when WM_PAINT then
					-- "Michael S. Harrison" <michaelh@inertiagames.com>:
					-- An application should call the GetUpdateRect function to determine
					-- whether the window has an update region. If GetUpdateRect returns Zero,
					-- the application should not call the BeginPaint and EndPaint functions.
                  if wapi_pf.GetUpdateRect (hWnd, rect.ptr, 0) /= 0 then
                     event.set_type (SEL_PAINT)
                     event.set_synthetic (True)
                     t3 := wapi_pf.BeginPaint (hWnd, ps.ptr)
                     event.set_rect_x (rect.left)
                     event.set_rect_y (rect.top)
                     event.set_rect_w (rect.right - rect.left)
                     event.set_rect_h (rect.bottom - rect.top)
                     window.do_handle_2 (Current, SEL_PAINT, 0, event)
                     wapi_pf.EndPaint (hWnd, ps.ptr)
                  end
                  
                  -- Keyboard
               when WM_KEYDOWN, WM_SYSKEYDOWN, WM_KEYUP, WM_SYSKEYUP then
                  if uMsg = WM_KEYUP or uMsg = WM_SYSKEYUP then
                     event.set_type (SEL_KEYRELEASE)
                  else  
                     event.set_type (SEL_KEYPRESS)
                  end
                  event.set_time (wapi_mf.GetMessageTime)
                  dwpts := wapi_mf.GetMessagePos
                  pt.set_x (wapi_wmc.GET_X_LPARAM(dwpts))
                  pt.set_y (wapi_wmc.GET_Y_LPARAM(dwpts))
                  event.set_root_x (pt.x)
                  event.set_root_y (pt.y)
                  t := wapi_cf.ScreenToClient (hWnd, pt.ptr)
                  event.set_win_x (pt.x)
                  event.set_win_y (pt.y)
                  event.set_state (sbmodifierkeys)
                  -- Translate to keysym
                  event.set_code (wkbMapKeyCode(hWnd, uMsg, wParam, lParam));
                  -- Translate to string on KeyPress
                  t1 := (wapi_wmc.HIWORD (lParam))
                  t2 := (wapi_kbf.KF_EXTENDED + wapi_kbf.KF_UP + 255)
                  t1 := t1 & t2
                  uScanCode := t1
                  create ks.make_filled ('%U', 255)
                  create buf.make_filled('%U',10)
                  mem.collection_off
                  t := wapi_kf.GetKeyboardState (ks.area.base_address)
                  t := wapi_kf.ToAscii (wParam, uScanCode, ks.area.base_address, buf.area.base_address, t1)
                  mem.collection_on
                  buf.keep_head (t)
                  if event.type = SEL_KEYPRESS then
                     -- Replace text string
                     event.set_text (buf)
                  else
                     -- Clear string on KeyRelease
                     event.clear_text
                  end                  
                  --  Dispatch to proper target
                  if keyboard_grab_window /= Void then
                     if keyboard_grab_window.handle_2 (Current, event.type, 0, event) then
                        refresh
                     end
                  else
                     if event.type = SEL_KEYPRESS then
                        key_window := focus_window
                     end
                     if key_window /= Void then
                        -- FIXME doesSaveUnder test should go away
                        if invocation = Void or else invocation.modality = MODAL_FOR_NONE 
                           or else (invocation.window /= Void and then invocation.window.is_owner_of (key_window))
                           or  else key_window.get_shell.does_save_under
                         then
                           if key_window.handle_2 (Current, event.type, 0, event) then
                              refresh
                           end
                        else
                           if event.type = SEL_KEYPRESS then
                              beep
                           end
                        end
                     end
                  end
                  Result := 0
                  
                  -- The grab might be broken; in FOX, we ignore this!!
               when WM_CANCELMODE then
                  -- Capture changed
               when WM_CAPTURECHANGED then
                  -- TrackMouseEvent
               when WM_MOUSELEAVE then
                  -- If we're still in a window, determine if the cursor is in some
                  -- other inferior window of this window's shell.  If not, that means
                  -- we left the shell and generate one final LEAVE event.
                  -- We do not generate LEAVE events here when moving between inferiors
                  -- because these WM_MOUSELEAVE events are generated out of sequence,
                  -- i.e. we will have received an WM_MOUSEMOVE on the new window prior
                  -- to receiving a WM_MOUSELEAVE on the old window, which is bad!
                  if oldhwnd /= default_pointer then
                     dwpts := wapi_mf.GetMessagePos
                     hwnd1 := wapi_wf.WindowFromPoint (wapi_wmc.GET_X_LPARAM (dwpts), wapi_wmc.GET_Y_LPARAM (dwpts))
                     if hwnd1 = default_pointer or else (window.get_shell.resource_id /= hwnd1 
                                     and then wapi_wf.IsChild (window.get_shell.resource_id, hwnd1) = 0)
                      then
                        event.set_time (wapi_mf.GetMessageTime)
                        event.set_code (CROSSINGNORMAL)
                        leave_window (window, root_window)
                        oldhwnd := default_pointer
                        refresh
                     end
                  end
                  --  Motion
               when WM_MOUSEMOVE then
                  event.set_time (wapi_mf.GetMessageTime)
                  pt_root.set_x (wapi_wmc.GET_X_LPARAM(lParam))
                  pt_root.set_y (wapi_wmc.GET_Y_LPARAM(lParam))
                  pt.set_x (pt_root.x)
                  pt.set_y (pt_root.y)
                  t := wapi_cf.ClientToScreen (hWnd,pt_root.ptr)
                  event.set_root_x (pt_root.x)
                  event.set_root_y (pt_root.y)
                  
                  event.set_state (sbmodifierkeys)
                  	-- Set moved flag
                  if (event.root_x - event.rootclick_x).abs >= drag_delta 
                     or else (event.root_y - event.rootclick_y).abs >= drag_delta
                   then
                     event.set_moved (True)
                  end
                  -- Was grabbed
                  if mouse_grab_window /= Void then
                     -- Translate to grab window's coordinate system
                     sbp := window.translate_coordinates_to (mouse_grab_window, pt.x, pt.y)
                     event.set_win_x (sbp.x)
                     event.set_win_y (sbp.y)
                     -- Moved out of/into rectangle of grabbed window
                     t := wapi_wf.GetClientRect (mouse_grab_window.resource_id, rect.ptr)
                     curinside := (0 <= event.win_x and then event.win_x < rect.right
                     	  and then 0 <= event.win_y and then event.win_y < rect.bottom)
                     oldinside := (0 <= event.last_x and then event.last_x < rect.right
                     	  and then 0 <= event.last_y and then event.last_y < rect.bottom)

                     -- Crossed window boundary
                     if curinside /= oldinside then
                        if curinside then
                           event.set_type (SEL_ENTER)
                           event.set_code (CROSSINGNORMAL)
                           if mouse_grab_window.handle_2 (Current, SEL_ENTER, 0, event) then
                              refresh
                           end
                        else
                           event.set_type (SEL_LEAVE)
                           event.set_code (CROSSINGNORMAL)
                           if mouse_grab_window.handle_2 (Current, SEL_LEAVE, 0, event) then
                              refresh
                           end
                        end
                     end
                  else
                     -- Not grabbed
                     if hWnd /= oldhwnd then
                  		if oldhwnd /= default_pointer then
                           oldwindow := get_sb_window (oldhwnd)
                           ancestor := window.common_ancestor (window, oldwindow)
                           event.set_code (CROSSINGNORMAL)
                           leave_window (oldwindow, ancestor)
                           enter_window (window, ancestor)
                        else
                           enter_window (window, root_window)
                        end
                        refresh
                     end
                  end
                  
                  -- Suppress spurious `tickling' motion events
                  if hWnd /= lastmovehwnd or else lParam /= lastmovelParam then
                     	-- Was still grabbed, but possibly new grab window!
                     if mouse_grab_window /= Void then
                        	-- Translate to grab window's coordinate system
                        sbp := window.translate_coordinates_to(mouse_grab_window, pt.x, pt.y)
                        event.set_win_x (sbp.x)
                        event.set_win_y (sbp.y)
                        	-- Dispatch to grab window
                        event.set_type (SEL_MOTION)
                        event.set_code (0)
                        if mouse_grab_window.handle_2 (Current, SEL_MOTION, 0, event) then
                           refresh
                        end
                        -- Was not grabbed
                     elseif invocation = Void
                        or else invocation.modality = MODAL_FOR_NONE 
                        or else (invocation.window /= Void and then invocation.window.is_owner_of (window))
                        or else window.get_shell.does_save_under
                      then
                        	-- Set event coordinates
                        event.set_win_x (pt.x)
                        event.set_win_y (pt.y)
                        if window.handle_2 (Current, SEL_MOTION, 0, event) then
                           refresh
                        end
                     end
                     -- Update most recent mouse position
                     event.set_last_x (pt.x)
                     event.set_last_y (pt.y)

                     -- Set TrackMouseEvent on each window we enter, so we'll be notified when
                     -- we depart this window, because we will not know when we get the last
                     -- move event!
                     if oldhwnd /= hWnd then
				if false then
                --		tme.cbSize = sizeof (TRACKMOUSEEVENT);
                --		tme.dwFlags = TME_LEAVE;
                --		tme.hwndTrack = (HWND)hWnd;
                --		tme.dwHoverTime = HOVER_DEFAULT;
                --		TrackMouseEvent (&tme);
				end
                        oldhwnd := hWnd
                     end

                     	-- Remember this for tickling test
                     lastmovehwnd := hWnd
                     lastmovelParam := lParam
                  end
                  -- Button
               when WM_LBUTTONDOWN, WM_MBUTTONDOWN, WM_RBUTTONDOWN,
               		WM_LBUTTONUP,   WM_MBUTTONUP,   WM_RBUTTONUP
                then
                  event.set_time (wapi_mf.GetMessageTime)
                  pt.set_x (wapi_wmc.GET_X_LPARAM(lParam))
                  pt.set_y (wapi_wmc.GET_Y_LPARAM(lParam))
                  event.set_win_x (pt.x)
                  event.set_win_y (pt.y)
                  t := wapi_cf.ClientToScreen (hWnd, pt.ptr)
                  event.set_root_x (pt.x)
                  event.set_root_y (pt.y)
                  event.set_state (sbmodifierkeys)
                  
                  if uMsg = WM_LBUTTONDOWN or else uMsg = WM_MBUTTONDOWN 
                     or else uMsg = WM_RBUTTONDOWN
                   then
                     if uMsg = WM_LBUTTONDOWN then
                        event.set_type (SEL_LEFTBUTTONPRESS)
                        event.set_code (LEFTBUTTON)
                     end
                     if uMsg = WM_MBUTTONDOWN then
                        event.set_type (SEL_MIDDLEBUTTONPRESS)
                        event.set_code (MIDDLEBUTTON)
                     end
                     if uMsg = WM_RBUTTONDOWN then
                        event.set_type (Sel_rightbuttonpress)
                        event.set_code (RIGHTBUTTON)
                     end
                     if not event.moved and then (event.time - event.click_time < click_speed)
                        and then (event.code = event.click_button)
                      then
                        event.set_click_count (event.click_count + 1)
                        event.set_click_time (event.time)
                     else
                        event.set_click_count (1)
                        event.set_click_x (event.win_x)
                        event.set_click_y (event.win_y)
                        event.set_rootclick_x (event.root_x)
                        event.set_rootclick_y (event.root_y)
                        event.set_click_button (event.code)
                        event.set_click_time (event.time)
                     end
                     state := event.state & (LEFTBUTTONMASK | MIDDLEBUTTONMASK | RIGHTBUTTONMASK);
                     if state = LEFTBUTTONMASK or else state = MIDDLEBUTTONMASK 
                        or else state = RIGHTBUTTONMASK
                      then
                        event.set_moved (False)
                     end
                  else
                     if uMsg = WM_LBUTTONUP then
                        event.set_type (SEL_LEFTBUTTONRELEASE)
                        event.set_code (LEFTBUTTON)
                     end
                     if uMsg = WM_MBUTTONUP then 
                        event.set_type (SEL_MIDDLEBUTTONRELEASE)
                        event.set_code (MIDDLEBUTTON)
                     end
                     if uMsg = WM_RBUTTONUP then
                        event.set_type (Sel_rightbuttonrelease)
                        event.set_code (RIGHTBUTTON)
                     end
                  end
                  if mouse_grab_window /= Void then
                        sbp := window.translate_coordinates_to (mouse_grab_window, event.win_x, event.win_y)
                        event.set_win_x (sbp.x)
                        event.set_win_y (sbp.y)
                     if mouse_grab_window.handle_2 (Current, event.type, 0, event) then
                        refresh;
                     end
                     -- FIXME doesSaveUnder test should go away
                  elseif invocation = Void or else invocation.modality = MODAL_FOR_NONE
                     or else (invocation.window /= Void and then invocation.window.is_owner_of(window)) 
                     or else window.get_shell.does_save_under
                   then
                     if window.handle_2 (Current, event.type, 0, event) then
                        refresh;
                     end
                  elseif uMsg = WM_LBUTTONDOWN or uMsg = WM_MBUTTONDOWN or uMsg = WM_RBUTTONDOWN
                   then
                     beep;
                  end
                  event.set_last_x (event.win_x)
                  event.set_last_y (event.win_y)

                  -- Mouse wheel
               when WM_MOUSEWHEEL then
                  event.set_type (SEL_MOUSEWHEEL)
                  event.set_time (wapi_mf.GetMessageTime)
                  pt.set_x (wapi_wmc.GET_X_LPARAM (lParam))
                  pt.set_y (wapi_wmc.GET_Y_LPARAM (lParam))
                  event.set_root_x (pt.x)
                  event.set_root_y (pt.y)
                  event.set_code (wapi_wmc.GET_Y_LPARAM(wParam))
                  event.set_state (sbmodifierkeys)
--#                  window := find_window_at (event.root_x, event.root_y, default_pointer)
                  if window /= Void then
                     t := wapi_cf.ScreenToClient (window.resource_id, pt.ptr)
                     event.set_win_x (pt.x)
                     event.set_win_y (pt.y)
                     from
                     until
                        window = Void
                     loop
                        if window.handle_2 (Current, SEL_MOUSEWHEEL, 0, event) then
                           refresh
                           window := Void
                        else
                           window := window.parent
                        end
                     end
                  end
                  --  Focus
               when WM_SETFOCUS, WM_KILLFOCUS then
                  window := window.get_shell
                  if uMsg = WM_KILLFOCUS and then focus_window = window then
                     event.set_type (SEL_FOCUSOUT)
                     if window.handle_2 (Current, SEL_FOCUSOUT, 0, event) then
                        refresh
                     end
                     focus_window := Void
                  end
                  if uMsg = WM_SETFOCUS and then focus_window /= window then
                     event.set_type (SEL_FOCUSIN)
                     if window.handle_2 (Current, SEL_FOCUSIN, 0, event) then
                        refresh
                     end
                     focus_window := window
                  end

                  -- Map or Unmap
               when WM_SHOWWINDOW then
                  if wParam /= 0 then
                     event.set_type (SEL_MAP)
                     if window.handle_2 (Current, SEL_MAP, 0, event) then
                        refresh
                     end
                  else
                     event.set_type (SEL_UNMAP)
                     if window.handle_2 (Current, SEL_UNMAP, 0, event) then
                        refresh
                     end
                  end

                  -- Create
               when WM_CREATE then
                  event.set_type(SEL_CREATE)
                  window := ext_get_sbwnd_from_createstruct (lParam)
                  target_set := window	-- Fix Gobo's type-set analysis
                  SetWindowLong (hWnd, 0, window)

                  if window.handle_2 (Current, SEL_CREATE, 0, event) then
                     refresh
                  end

                  -- Close
               when WM_CLOSE then
                  -- Semantics: SEL_CLOSE is a suggestion that the window be closed;
                  -- SEL_DESTROY is a notify that destruction has already taken place.
                  -- Thus, a toplevel window gets a close, and MAY decide not to be closed;
                  -- If it thinks its OK to close, it gets a SEL_DESTROY also.
                  event.set_type (SEL_CLOSE)
                  if window.handle_2 (Current, SEL_CLOSE, 0, event) then
                     refresh
                  end

                  -- Destroy
               when WM_DESTROY then
                  event.set_type (SEL_DESTROY)
                  if window.handle_2 (Current, SEL_DESTROY, 0, event) then
                     refresh
                  end

                  -- Configure (size)
               when WM_SIZE then
                  event.set_type (SEL_CONFIGURE)
                  event.set_rect_x (window.x_pos)
                  event.set_rect_y (window.y_pos)
                  event.set_rect_w (wapi_wmc.LOWORD (lParam))
                  event.set_rect_h (wapi_wmc.HIWORD (lParam))
                  if window.handle_2 (Current, SEL_CONFIGURE, 0, event) then
                     refresh
                  end

                  -- Configure (move)
               when WM_MOVE then
                  event.set_type (SEL_CONFIGURE)
                  event.set_rect_x (wapi_wmc.GET_X_LPARAM(lParam))
                  event.set_rect_y (wapi_wmc.GET_Y_LPARAM(lParam))
                  event.set_rect_w (window.width)
                  event.set_rect_h (window.height)
                  if window.handle_2 (Current, SEL_CONFIGURE, 0, event) then
                     refresh
                  end

                  -- Lost clipboard ownership
               when WM_DESTROYCLIPBOARD then
                  if clipboard_window /= Void then
                     event.set_time (wapi_mf.GetMessageTime)
                     event.set_type (SEL_CLIPBOARD_LOST)
                     if clipboard_window.handle_2 (Current, SEL_CLIPBOARD_LOST, 0, event) then
                        refresh
                     end
                     clipboard_window := Void
                  end

                  -- Safeguard it in the clipboard
               when WM_RENDERALLFORMATS then
                  if clipboard_window /= Void then
                     t := wapi_clb.OpenClipboard (hWnd)
                     t := wapi_clb.EmptyClipboard
                     from
                        iFormat := wapi_clb.EnumClipboardFormats (0)
                     until
                        iFormat = 0
                     loop
                        event.set_type (SEL_CLIPBOARD_REQUEST)
                        event.set_time (wapi_mf.GetMessageTime)
                        event.set_target (iFormat)
                        if clipboard_window.handle_2 (Current, SEL_CLIPBOARD_REQUEST, 0, event) then
                           refresh
                        end
                        iFormat := wapi_clb.EnumClipboardFormats (iFormat)
                     end
                     t := wapi_clb.CloseClipboard
                  end
                  
                  -- We're asked to provide certain format to the clipboard
               when WM_RENDERFORMAT then
                  if clipboard_window /= Void then
                     event.set_type (SEL_CLIPBOARD_REQUEST)
                     event.set_time (wapi_mf.GetMessageTime)
                     event.set_target (wParam)
                     clipboard_window.do_handle_2 (Current, SEL_CLIPBOARD_REQUEST, 0, event)
                  end

                  -- Change the cursor based on the window
               when WM_SETCURSOR then
                  if wait_count /= 0 then
                     t3 := wapi_crs.SetCursor (wait_cursor.resource_id)  -- Show wait cursor
                  elseif mouse_grab_window = Void and then window.default_cursor /= Void
                     and then wapi_wmc.LOWORD (lParam) = HTCLIENT
                   then
                     t3 := wapi_crs.SetCursor (window.default_cursor.resource_id) -- Show default cursor
                  else
                     Result := wapi_mf.DefWindowProc (hWnd, uMsg, wParam, lParam)
                  end

               when WM_PALETTECHANGED, WM_QUERYNEWPALETTE then 
                  -- Suggested by Boris Kogan <bkogan@j51.com>
                  if uMsg = WM_PALETTECHANGED and then
--#                     wParam = POINTER_TO_INT (hWnd) then
		true then
                     Result := wapi_mf.DefWindowProc (hWnd, uMsg, wParam, lParam)
                  else
                     if window.visual.hPalette /= default_pointer then
                        hdc := wapi_dcf.GetDC (hWnd)
                        old_palette := wapi_clr.SelectPalette (hdc, window.visual.hPalette, 0)
                        nchanged := wapi_clr.RealizePalette (hdc)
                        if nchanged /= 0 then
                           t := wapi_pf.InvalidateRect (hWnd, default_pointer, 1)
                           t3 := wapi_clr.SelectPalette (hdc, old_palette, 1)
                           t := wapi_dcf.ReleaseDC (hWnd, hdc)
                           Result := nchanged
                        end
                     end
                  end
               when WM_QUERYENDSESSION then -- Session will end if this app thinks its OK
                  Result := 1; -- Return 1 if OK to terminate

               when WM_ENDSESSION then -- Session will now end for sure
                  exit(0);             -- Write registry and terminate

        --		when WM_DND_ENTER then
                  -- todo
        --       when WM_DND_LEAVE then
                  -- todo
        --       when WM_DND_DROP then
                  -- todo
        --       when WM_DND_POSITION_REJECT, WM_DND_POSITION_COPY, WM_DND_POSITION_MOVE,
        --          WM_DND_POSITION_LINK, WM_DND_POSITION_PRIVATE
        --        then
                  -- todo
        --       when WM_DND_STATUS_REJECT, WM_DND_STATUS_COPY, WM_DND_STATUS_MOVE,
        --          WM_DND_STATUS_LINK, WM_DND_STATUS_PRIVATE
        --        then
                  -- todo
        --       when WM_DND_REQUEST then
                  -- todo
               else
                  Result := wapi_mf.DefWindowProc (hWnd, uMsg, wParam, lParam)
               end
            end
         end
      end

feature -- Clipboard

	clipboard_set_data (window: SB_WINDOW; type: INTEGER; data: STRING)
		local
			hGlobalMemory: POINTER
			pGlobalMemory: POINTER
			t: INTEGER
			tp: POINTER
		do
			hGlobalMemory := wapi_mfn.GlobalAlloc (wapi_gmem.GMEM_MOVEABLE, data.count)
			if hGlobalMemory /= default_pointer then
				pGlobalMemory := wapi_mfn.GlobalLock (hGlobalMemory)
				check
					pGlobalMemory /= default_pointer
				end
				mem.collection_off
--#				mem.mem_copy (pGlobalMemory, data.area.base_address, data.count)
				mem.collection_on
				t := wapi_mfn.GlobalUnlock (hGlobalMemory)
				tp := wapi_clb.SetClipboardData (type, hGlobalMemory)
			end
		end

   clipboard_get_data (window: SB_WINDOW; type: INTEGER): STRING
      local
         hClipMemory: POINTER
         pClipMemory: POINTER
         size, t: INTEGER
      do
         if wapi_clb.IsClipboardFormatAvailable (type) /= 0 then
            if wapi_clb.OpenClipboard (window.resource_id) /= 0 then
               hClipMemory := wapi_clb.GetClipboardData (type)
               if hClipMemory /= default_pointer then
                  size := wapi_mfn.GlobalSize (hClipMemory)
                  create Result.make_filled ('%U', size)
                  pClipMemory := wapi_mfn.GlobalLock (hClipMemory)
                  check
                     pClipMemory /= default_pointer
                  end
                  mem.collection_off
--#                  mem.mem_copy (Result.area.base_address, pClipMemory, size)
                  mem.collection_on
                  t := wapi_mfn.GlobalUnlock (hClipMemory)
                  t := wapi_clb.CloseClipboard
               end
            end
         end
      end

   clipboard_get_types (window: SB_WINDOW): ARRAY [ INTEGER ]
      local
         i, count, format, t: INTEGER
      do
         if wapi_clb.OpenClipboard (window.resource_id) /= 0 then
            count := wapi_clb.CountClipboardFormats
            if count /= 0 then
               create Result.make (1, count)
               from
                  i := 1
                  format := wapi_clb.EnumClipboardFormats(0)
               until
                  i > count or else format = 0
               loop
                  Result.put (format, i)
                  format := wapi_clb.EnumClipboardFormats (format)
                  i := i + 1
               end
            end
            t := wapi_clb.CloseClipboard
         end
      end

   	display: POINTER
      	do
			Result := ext_get_display (to_external)
      	end

	stipple (index: INTEGER): POINTER
		require
   		--	implemented: false
		do
			Result := ext_get_stipple (to_external, index)
		end

	hinstance: POINTER
    	once
         	Result := wapi_dl.GetModuleHandle (default_pointer)
      	end

feature {NONE} -- Non portable calls

	np_open_display (p: POINTER; dpyname: STRING): BOOLEAN
      	do
--       	mem.collection_off;
         	if dpyname = Void then
            	Result := ext_open_display (p, dpy.area.base_address)
         	else
            	Result := ext_open_display (p, dpyname.area.base_address)
         	end
--       	mem.collection_on
      	end

feature {NONE} -- SB_WAPI functions

	wapi_sif:	SB_WAPI_SYSTEM_INFORMATION_FUNCTIONS
   	wapi_ct:	SB_WAPI_COLOR_TYPES
   	wapi_dcf: 	SB_WAPI_DEVICE_CONTEXT_FUNCTIONS
   	wapi_dp: 	SB_WAPI_DEVICE_PARAMETERS
   	wapi_spi: 	SB_WAPI_SYSTEMPARAMETERSINFO_CODES
   	wapi_api: 	SB_WAPI_APIFUN
   	wapi_mbfl: 	SB_WAPI_MESSAGE_BOX_FLAGS
   	wapi_crs: 	SB_WAPI_CURSOR_FUNCTIONS
   	wapi_pf: 	SB_WAPI_PAINTING_AND_DRAWING_FUNCTIONS
   	wapi_rdw: 	SB_WAPI_REDRAW_WINDOW_FLAGS
   	wapi_clb: 	SB_WAPI_CLIPBOARD_FUNCTIONS
   	wapi_wf: 	SB_WAPI_WINDOW_FUNCTIONS
   	wapi_mf: 	SB_WAPI_MESSAGE_AND_MESSAGE_QUEUE_FUNCTIONS
   	wapi_cf: 	SB_WAPI_COORDINATE_SPACE_AND_TRANSFORMATION_FUNCTIONS
   	wapi_kf: 	SB_WAPI_KEYBOARD_INPUT_FUNCTIONS
   	wapi_kbf: 	SB_WAPI_KF_FLAGS
   	wapi_clr: 	SB_WAPI_COLOR_FUNCTIONS
   	wapi_wmc: 	SB_WAPI_MACRO
   	wapi_dl: 	SB_WAPI_DYNAMIC_LINK_LIBRARY_FUNCTIONS
   	wapi_fmf:	SB_WAPI_FILE_MAPPING_FUNCTIONS
   	wapi_fmm:	SB_WAPI_FILE_MAPPING_ACCESS_MASKS
   	wapi_af: 	SB_WAPI_VIRTUAL_MEMORY_ALLOCATION_FLAGS
   	wapi_prf: 	SB_WAPI_PROCESS_AND_THREAD_FUNCTIONS
   	wapi_prm: 	SB_WAPI_PROCESS_AND_THREAD_ACCESS_MASKS
   	wapi_hf: 	SB_WAPI_HANDLE_AND_OBJECT_FUNCTIONS
   	wapi_ar: 	SB_WAPI_FILES_AND_DIRS_ACCESS_RIGHTS
   	wapi_mfn: 	SB_WAPI_MEMORY_MANAGEMENT_FUNCTIONS
   	wapi_gmem: 	SB_WAPI_GLOBAL_MEMORY_ALLOCATION_FLAGS

   	MulDiv (number, numerator, denominator: INTEGER): INTEGER
      	external "C use <windows.h>"
      	alias "MulDiv"
      	end

   	GetWindowLong (hwnd: POINTER; nindex: INTEGER): SB_WINDOW
         	-- Gets user data from window and casts to SB_WINDOW.
         	-- low-level hack
		do
			if false then
				Result ?= target_set	-- Fix Gobo's dynamic-type-set analysis
			else
				Result := c_GetWindowLong (hwnd, nindex)
			end
      	end

   	c_GetWindowLong (hwnd: POINTER; nindex: INTEGER): SB_WINDOW
         	-- Gets user data from window and casts to SB_WINDOW.
         	-- low-level hack
      	external "C inline"
      	alias "((EIF_REFERENCE) GetWindowLong ($hwnd, $nindex))"
      	end

   	SetWindowLong (hwnd: POINTER; nindex: INTEGER; wnd: SB_WINDOW)
         	-- Casts SB_WINDOW to long and sets it to window user data.
         	-- low-level hack
      	external "C inline"
      	alias "SetWindowLong ($hwnd, $nindex, (long)$wnd);%N"
      	end

   	sbmodifierkeys: INTEGER_32
      	external "C"
      	alias "sbmodifierkeys"
      	end

   	wkbMapKeyCode (hwnd: POINTER; umsg, wparam, lparam: INTEGER): INTEGER
      	external "C"
      	alias "wkbMapKeyCode"
      	end

end