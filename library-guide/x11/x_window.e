note

	description: "Implementation of Xlib's Window"

	author: "Stephane Hillion"
	copyright: "Copyright (c) 1998-2006, Stephane Hillion and Howard Thomson"
	license: "GNU Public License (see COPYING)"
	
	todo: "[
		Re-format class text, for 4-col tab left alignment
	]"

class X_WINDOW

inherit 

	X_RESOURCE
	X_WINDOW_CONSTANTS
	X_PORTABILITY_ROUTINES

create 

	make,
	from_external

create { X_EVENT_QUEUE, X_GLOBAL }

	make_special

feature { NONE } -- Creation

	make (parent: X_WINDOW;
			x, y, width, height,
			border_width,
			depth,
			window_class : INTEGER;
			visual       : X_VISUAL;
			mask         : INTEGER;
			attributes   : X_SET_WINDOW_ATTRIBUTES)
    	require
      		parent     /= Void
      		visual     /= Void
      		attributes /= Void
		do
    		display := parent.display
			screen  := parent.screen
			id      := x_create_window (parent.display.to_external,
									parent.id,
									x, y, width, height,
									border_width,
									depth,
									window_class,
									visual.to_external,
									mask,
									attributes.to_external)
		end
	----------------------------------------------------------

	from_external (disp: X_DISPLAY; scr: INTEGER; xid: INTEGER)
    	require
    		disp /= Void
			scr  <  disp.screen_count
		do
			display	:= disp
			screen	:= scr
			id		:= xid
		end
	----------------------------------------------------------

	make_special (xid : INTEGER)
    	do
    		id := xid
		end

feature -- Destruction

	destroy
    	require
      		not is_same_resource(display.root_window(screen))
    	do
      		x_destroy_window(display.to_external, id)
    	end
	----------------------------------------------------------

  	destroy_subwindows
    	do
      		x_destroy_subwindows(display.to_external, id)
    	end

feature

	screen: INTEGER
		-- The screen on which the window is displayed

feature -- configuration

	get_attributes: X_WINDOW_ATTRIBUTES
    	-- Returns the current attributes for this window
    	do
			create Result.make
      		x_get_window_attributes (display.to_external, id, Result.to_external)
		end
	----------------------------------------------------------

	change_attributes (mask: INTEGER; swa: X_SET_WINDOW_ATTRIBUTES)
			-- Depending on the mask, `change_attributes' uses the window 
			-- attributes in the swa structure to change the specified
			-- window attributes
		require
			swa /= Void
		do
			x_change_window_attributes (display.to_external, id, 
					mask, swa.to_external)
		end
	----------------------------------------------------------

	define_cursor (cursor: X_CURSOR)
			-- If a cursor is set, it will be used when the pointer is in 
			-- the window.  If the cursor is `None_cursor', this method undoes
			-- the effect of a previous `define_cursor' call
		do
			x_define_cursor (display.to_external, id, cursor.id)
		end
	----------------------------------------------------------

	select_input (mask: INTEGER)
			-- requests that the X server report the events associated
			-- with the specified event mask.
		require
			not is_same_resource (display.root_window (screen))
		do
			x_select_input (display.to_external, id, (mask))
		end
	----------------------------------------------------------

	set_transient_for_hint (win: X_WINDOW)
			-- sets the WM_TRANSIENT_FOR property of the specified window
			-- to the specified window.
		require
			not is_same_resource (display.root_window (screen))
		do
			x_set_transient_for_hint (display.to_external, id, win.id)
		end
	----------------------------------------------------------

	set_wm_hints (val: X_WM_HINTS)
			-- sets the window manager hints.
		require
			not is_same_resource (display.root_window (screen))
			val /= Void
		do
			x_set_wm_hints (display.to_external, id, val.to_external)
		end
	----------------------------------------------------------

--	get_wm_hints: X_WM_HINTS is
--			-- reads the window manager hints and returns Void if no 
--			-- WM_HINTS property was set on the window or returns a 
--			-- X_WM_HINTS structure if it succeeds.
--		require
--			not is_same_resource (display.root_window (screen))
--		local
--			p: POINTER
--		do
--			p := x_get_wm_hints (display.to_external, id)
--			if p /= default_pointer then
--				create Result.from_external (p)
--			end
--		end
	----------------------------------------------------------

	set_class_hint (ch: X_CLASS_HINT)
			-- sets the class hint for the specified window.
		require
			ch /= Void
		do
			x_set_class_hint (display.to_external, id, ch.to_external)
		end
	----------------------------------------------------------

--	get_class_hint: X_CLASS_HINT is
--			-- returns the class hint of the window or Void on error
--		local
--			p: POINTER
--		do
--			if x_get_class_hint (display.to_external, id, p) /= 0 then
--				create Result.from_external (p)
--			end
--		end

feature -- name and title

	store_name (name: STRING)
      		-- assigns the name passed to `name' to the window
    	require
      		not is_same_resource (display.root_window (screen))
    	do
      		x_store_name (display.to_external, id, string_to_external(name))
    	end

	set_icon_name (name: STRING)
			-- sets the name to be displayed in a window's icon
		require
			not is_same_resource (display.root_window (screen))
		do
			x_set_icon_name (display.to_external, id, string_to_external(name))
		end
  
feature -- mapping

  	map
      		-- Maps the window and all of its subwindows that have had map requests.
    	require
      		not is_same_resource (display.root_window (screen))
    	do
      		x_map_window (display.to_external, id)
    	end

  	unmap
      		-- unmap the window and all its subwindows.
    	require
      		not is_same_resource (display.root_window (screen))
    	do
      		x_unmap_window (display.to_external, id)
    	end

  	map_subwindows
      		-- maps all subwindows for `Current' window in top-to-bottom
      		-- stacking order.
    	require
      		not is_same_resource (display.root_window (screen))
    	do
      		x_map_subwindows (display.to_external, id)
    	end

  	unmap_subwindows
      		-- unmaps all subwindows for `Current' window.
    	require
      		not is_same_resource (display.root_window (screen))
    	do
      		x_unmap_subwindows (display.to_external, id)
    	end

  	map_raised
      		-- similar to `map'. it also raises the window.
    	require
      		not is_same_resource (display.root_window (screen))
    	do
      		x_map_raised (display.to_external, id)
    	end

feature -- window stack

  	raise_window
      		-- raises the specified window to the top of the stack so that 
      		-- no sibling window obscures it.
    	require
      		not is_same_resource (display.root_window (screen))
    	do
      		x_raise_window (display.to_external, id)
    	end

  	lower 
      		-- lowers the specified window to the bottom of the stack so that 
      		-- it does not obscure any sibling windows.
    	require
      		not is_same_resource (display.root_window (screen))
    	do
      		x_lower_window (display.to_external, id)
    	end

  	circulate_subwindows_up
      		-- raises the lowest mapped child of the window that is partially 
      		-- or completely occluded by another child
    	do
      		x_circulate_subwindows_up (display.to_external, id)
    	end

  	circulate_subwindows_down
      		-- lowers the highest mapped child of the window that partially 
      		-- or completely occludes another child
    	do
      		x_circulate_subwindows_down (display.to_external, id)
    	end

  	reparent (parent : X_WINDOW; x, y : INTEGER)
      		-- removes `Current' from its current position in the hierarchy,
      		-- and inserts it as the child of the specified `parent' window
    	require
      		not is_same_resource (display.root_window (screen))
    	do
      		x_reparent_window (display.to_external, id, parent.id, x, y)
    	end

feature -- Focus

  	set_input_focus (revert_to, time : INTEGER)
      		-- changes the input focus and the last-focus-change time
    	do
      		x_set_input_focus (display.to_external, id, revert_to, time)
    	end

feature -- size and location

  	get_geometry
      		-- fills the following attributes : last_root_id,  last_x, 
      		-- last_y, last_width, last_height, last_border_width, last_depth.
    	do
      		x_get_geometry (display.to_external,
		      id,
		      $last_root_id,
		      $last_x,
		      $last_y,
                      $last_width,
		      $last_height,
		      $last_border_width,
		      $last_depth)
    	end

  	last_root_id      : INTEGER
  	last_x            : INTEGER
  	last_y            : INTEGER
  	last_width        : INTEGER
  	last_height       : INTEGER
  	last_border_width : INTEGER
  	last_depth        : INTEGER

  	translate_coordinates (win : X_WINDOW; x, y : INTEGER) : BOOLEAN
			-- If it returns True, it takes the `x' and `y' coordinates
			-- relative to the window's origin and returns these coordinates
			-- to `last_translated_x' and `last_translated_y' relative to 
			-- `win' origin.  If it returns False, `Current' and `win' are 
			-- on different screens, and `last_translated_x' and 
			-- `last_translated_y' are Zero. If the coordinates are 
			-- contained in a mapped child of `win', that child is returned 
			-- to child_return.  Otherwise, child_return is set to `None_resource'.
    	require
      		win /= Void
    	do
    		last_translated_child := 0	-- kludge for GEC/EDP
      		Result := x_translate_coordinates (display.to_external, id,
					 win.id, x, y,
					 $last_translated_x,
					 $last_translated_y,
					 $last_translated_child)
    	end

  	last_translated_x     : INTEGER
  	last_translated_y     : INTEGER
  	last_translated_child : INTEGER

  	move (x, y: INTEGER)
      		-- moves the specified window to the specified x and y coordinates
    	require
      		not is_same_resource (display.root_window (screen))
      		valid_x: x >= -32767 and x <= 32767
      		valid_y: y >= -32767 and y <= 32767
    	do
      		x_move_window (display.to_external, id, x, y)
    	end

  	resize (width, height: INTEGER)
      		-- changes the inside dimensions of the specified window, not
      		-- including its borders.
    	require
      		not is_same_resource (display.root_window (screen))
      		valid_width : width  >= -32767 and width  <= 32767
      		valid_height: height >= -32767 and height <= 32767
    	do
      		x_resize_window (display.to_external, id, width, height)
    	end

  	move_resize (x, y, width, height: INTEGER)
      		-- changes the size and location of the window
    	require
      		not is_same_resource (display.root_window (screen))
      		valid_x: x >= -32767 and x <= 32767
      		valid_y: y >= -32767 and y <= 32767
      		valid_width : width  >= -32767 and width  <= 32767
      		valid_height: height >= -32767 and height <= 32767
    	do
      		x_move_resize_window (display.to_external, id, x, y, width, height)
    	end

	withdraw_window
		do
			x_withdraw_window(display.to_external, id, display.default_screen)
		end

  	set_border_width (w : INTEGER)
      		-- sets the specified window's border width to the specified width.
    	require
      		not is_same_resource (display.root_window (screen))
    	do
      		x_set_window_border_width (display.to_external, id, w)
    	end

	set_wm_normal_hints (sh: X_SIZE_HINTS)
			-- replaces the size hints for the WM_NORMAL_HINTS property on 
			-- the window
		require
			not is_same_resource (display.root_window (screen))
		do
			x_set_wm_normal_hints (display.to_external, id, sh.to_external)
		end

	get_wm_normal_hints: X_SIZE_HINTS
      		-- returns the size hints stored in the WM_NORMAL_HINTS property
      		-- on the window. `last_supplied_hints' is set.
    	do
      		create Result.make
      		x_get_wm_normal_hints (display.to_external, id, 
			     Result.to_external, $last_supplied_hints)
    	end

  	last_supplied_hints: INTEGER

	last_parent_id: INTEGER

feature -- grabbing

	grab_pointer (owner_ev      : BOOLEAN; 
                mask          : INTEGER; 
                pointer_sync, 
                keyboard_sync : INTEGER;
                confine_win   : X_WINDOW;
                curs          : X_CURSOR;
                time          : INTEGER) : INTEGER
      -- grabs control of the pointer and returns `Grab_success' if 
      -- the grab was successful.
		require
			not is_same_resource (display.root_window (screen))
			confine_win /= Void
			curs /= Void
		do
			Result := x_grab_pointer (display.to_external, id, owner_ev, 
				(mask), pointer_sync, 
				keyboard_sync, confine_win.id, curs.id, time)
		end

  	ungrab_pointer (time: INTEGER)
      		-- releases the pointer and any queued events if this client has
      		-- actively grabbed the pointer from `grab_pointer', 
      		-- `grab_button', or from a normal button press.
      		-- `time' is timestamp or `Current_time'
    	require
      		not is_same_resource (display.root_window (screen))
    	do
      		x_ungrab_pointer (display.to_external, time)
    	end
		----------------------------------------------------------

  change_active_pointer_grab (mask : INTEGER; 
                              curs : X_CURSOR;
                              time : INTEGER)
      -- changes the specified dynamic parameters if the pointer is
      -- actively grabbed by the client and if the specified time is 
      -- no earlier than the last-pointer-grab time and no later than
      -- the current X server time.
    require
      not is_same_resource (display.root_window (screen))
      curs /= Void
    do
      x_change_active_pointer_grab (display.to_external, (mask),
				    curs.id, time)
    end

  grab_button (button, 
               modifs        : INTEGER; 
               owner_ev      : BOOLEAN;
               mask          : INTEGER;
               pointer_sync,
               keyboard_sync : INTEGER;
               confine_win   : X_WINDOW;
               curs          : X_CURSOR)
      -- establishes a passive grab.
      -- `button' = 0 means any button.
    require
      not is_same_resource (display.root_window (screen))
      confine_win /= Void
      curs /= Void
    do
      x_grab_button (display.to_external, button, modifs, id, owner_ev,
		     (mask), pointer_sync, keyboard_sync,
		     confine_win.id, curs.id)
    end

	ungrab_button (button, modifs: INTEGER)
			-- releases the passive button/key combination on the window if it
			-- was grabbed by this client.
		do
			x_ungrab_button (display.to_external, button, modifs, id)
		end

	grab_keyboard (owner_ev      : BOOLEAN; 
                 pointer_sync, 
                 keyboard_sync : INTEGER; 
                 time          : INTEGER)
			-- grabs control of the keyboard and generates `Focus_in' and 
			-- `Focus_out' events.
		require
			not is_same_resource (display.root_window (screen))
		do
			x_grab_keyboard (display.to_external, id, owner_ev, 
						pointer_sync, keyboard_sync, time)
		end
  
  ungrab_keyboard (time: INTEGER)
      -- releases the keyboard and any queued events if this client 
      -- has it actively grabbed from either grab_keyboard or grab_key.
    do
      x_ungrab_keyboard (display.to_external, time)
    end

  grab_key (key_code, 
            modifs        : INTEGER; 
            owner_ev      : BOOLEAN;
            pointer_sync,
            keyboard_sync : INTEGER)
      -- establishes a passive grab on the keyboard.
    require
      not is_same_resource (display.root_window (screen))
    do
      x_grab_key (display.to_external, key_code, modifs,
                  id, owner_ev, pointer_sync, keyboard_sync)
    end

	ungrab_key (key_code, modifs : INTEGER)
			-- releases the key combination on the specified window if it 
			-- was grabbed by this client.
		do
			x_ungrab_key (display.to_external, key_code, modifs, id)
		end

feature -- Properties

	change_property (
			prop,
			type    : X_ATOM;
			format,
			mode    : INTEGER;
        	buf     : POINTER;
			n_elem  : INTEGER)
		require
			prop   /= Void
			type   /= Void
			format =  8 or else format = 16 or else format = 32
		do
			fx_trace(0, <<"X_WINDOW::change_property called">>)
			x_change_property (display.to_external, id, prop.id, type.id,
                         format, mode, buf, n_elem)
		end

	get_property (prop,	type: X_ATOM; start, len: INTEGER; del: BOOLEAN) : BOOLEAN
		require
			prop /= Void
			type /= Void
		do
			Result := x_get_window_property (display.to_external, id, 
				prop.id, start, len,
				del, type.id, 
				$last_property_type,
				$last_property_format,
				$last_property_nitems,
				$last_property_bytes_after,
				$last_property) = 0
    end

	last_property_type        : INTEGER
	last_property_format      : INTEGER
	last_property_nitems      : INTEGER
	last_property_bytes_after : INTEGER
	last_property             : POINTER

  	set_wm_protocols (prot: ARRAY [ INTEGER ]): INTEGER
    	do
      		Result := x_set_wm_protocols (display.to_external, id,
				 	array_to_external(prot),
				    prot.count)
    	end

feature { NONE }

	n   : INTEGER
	ptr : POINTER

feature {NONE} -- External functions

	x_create_window (d: POINTER; wid, x, y, w, h, bw, 
                   pl, typ: INTEGER; vis: POINTER; 
                   mask: INTEGER; attr: POINTER) : INTEGER
		external "C use <X11/Xlib.h>"
		alias "XCreateWindow"
		end

  	x_destroy_window (d: POINTER; rid: INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XDestroyWindow"
    	end

  	x_destroy_subwindows (d: POINTER; rid: INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XDestroySubwindows"
    	end

  	x_get_window_attributes (d: POINTER; wid: INTEGER; attr: POINTER)
    	external "C use <X11/Xlib.h>"
    	alias "XGetWindowAttributes"
    	end

  	x_change_window_attributes (d: POINTER; wid: INTEGER; msk: INTEGER; buf: POINTER)
    	external "C use <X11/Xlib.h>"
    	alias "XChangeWindowAttributes"
    	end

  	x_define_cursor (d : POINTER; rid, cid : INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XDefineCursor"
    	end

  	x_select_input (d : POINTER; rid, msk : INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XSelectInput"
    	end

  	x_set_transient_for_hint (d : POINTER; wid, tid : INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XSetTransientForHint"
    	end

  	x_set_wm_hints (d : POINTER; wid : INTEGER; wmh : POINTER)
    	external "C use <X11/Xlib.h>"
    	alias "XSetWMHints"
    	end

  	x_get_wm_hints (d : POINTER; wid : INTEGER) : POINTER
    	external "C use <X11/Xlib.h>"
    	alias "XGetWMHints"
    	end

  	x_set_class_hint (d : POINTER; wid : INTEGER; p : POINTER)
    	external "C use <X11/Xlib.h>"
    	alias "XSetClassHint"
    	end

  	x_get_class_hint (d : POINTER; wid : INTEGER; p : POINTER) : INTEGER
    	external "C use <X11/Xlib.h>"
    	alias "XGetClassHint"
    	end

  	x_store_name (d : POINTER; wid : INTEGER; str : POINTER)
    	external "C use <X11/Xlib.h>"
    	alias "XStoreName"
    	end

  	x_fetch_name (d : POINTER; wid : INTEGER; str : POINTER) : INTEGER
    	external "C use <X11/Xlib.h>"
    	alias "XFetchName"
    	end

  	x_set_icon_name (d : POINTER; wid : INTEGER; nm : POINTER)
    	external "C use <X11/Xlib.h>"
    	alias "XSetWMIconName"	-- Was XSetIconName
    	end

  	x_get_icon_name (d : POINTER; wid : INTEGER; nm : POINTER)
    	external "C use <X11/Xlib.h>"
    	alias "XGetIconName"
    	end

  	x_map_window (d : POINTER; rid : INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XMapWindow"
    	end

  	x_unmap_window (d : POINTER; rid : INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XUnmapWindow"
    	end

  	x_map_subwindows (d : POINTER; rid : INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XMapSubwindows"
    	end

  	x_unmap_subwindows (d : POINTER; rid : INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XUnmapSubwindows"
    	end

  	x_map_raised (d : POINTER; rid : INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XMapRaised"
    	end

  	x_raise_window (d : POINTER; rid : INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XRaiseWindow"
    	end

  	x_lower_window (d : POINTER; rid : INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XLowerWindow"
    	end

  	x_circulate_subwindows_up (d : POINTER; rid : INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XCirculateSubwindowsUp"
    	end

  	x_circulate_subwindows_down (d : POINTER; rid : INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XCirculateSubwindowsDown"
    	end

  	x_reparent_window (d : POINTER; rid, pid, x, y : INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XReparentWindow"
    	end

  	x_set_input_focus (d : POINTER; rid, i, j : INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XSetInputFocus"
    	end

  	x_get_geometry (d : POINTER; wid : INTEGER; 
                  rid, x, y, w, h, brdr, dpth : POINTER)
    	external "C use <X11/Xlib.h>"
    	alias "XGetGeometry"
    	end  

  	x_translate_coordinates (d : POINTER; rid, wid, x, y : INTEGER;
                           rx, ry, rc : POINTER) : BOOLEAN
    	external "C use <X11/Xlib.h>"
    	alias "XTranslateCoordinates"
    	end

  	x_move_window (d : POINTER; rid, x, y : INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XMoveWindow"
    	end

  	x_resize_window (d : POINTER; rid, w, h : INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XResizeWindow"
    	end

  	x_move_resize_window (d : POINTER; rid, x, y, w, h : INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XMoveResizeWindow"
    	end

  	x_set_window_border_width (d : POINTER; rid, w : INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XSetWindowBorderWidth"
    	end

  	x_set_wm_normal_hints (d : POINTER; rid : INTEGER; sh : POINTER)
    	external "C use <X11/Xlib.h>"
    	alias "XSetWMNormalHints"
    	end

  	x_get_wm_normal_hints (d : POINTER; rid : INTEGER; sh, hs : POINTER)
    	external "C use <X11/Xlib.h>"
    	alias "XGetWMNormalHints"
    	end

  	x_query_tree (d: POINTER; wid: INTEGER; r, p, t, nb: POINTER)
    	external "C use <X11/Xlib.h>"
    	alias "XQueryTree"
    	end

  	x_grab_pointer (d: POINTER; wid: INTEGER; own: BOOLEAN; 
                  msk, ps, ks, cid, mid, time: INTEGER): INTEGER
    	external "C use <X11/Xlib.h>"
    	alias "XGrabPointer"
    	end

  	x_ungrab_pointer (d: POINTER; time: INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XUngrabPointer"
    	end

  	x_change_active_pointer_grab (d: POINTER; mask, cid, time: INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XChangeActivePointerGrab"
    	end

  	x_grab_button (d: POINTER; but, mod, wid : INTEGER; 
                 own: BOOLEAN; msk, ps, ks, cid, mid: INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XGrabButton"
    	end

  	x_ungrab_button (d: POINTER; but, mod, wid: INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XUngrabButton"
    	end

  	x_grab_keyboard (d: POINTER; wid: INTEGER; 
                   own: BOOLEAN; ps, ks, time: INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XGrabKeyboard"
    	end

	x_ungrab_keyboard (d : POINTER; time : INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XUngrabKeyboard"
    	end

	x_grab_key (d :POINTER; kc, mod, wid : INTEGER; 
                 own : BOOLEAN; ps, ks : INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XGrabKey"
    	end

	x_ungrab_key (d : POINTER; kc, mod, wid : INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XUngrabKey"
    	end

  	x_change_property (d : POINTER; id1, id2, id3, f, m : INTEGER;
                     b : POINTER; nb : INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XChangeProperty"
    	end

  	x_get_window_property (d : POINTER; id1, id2, off, len : INTEGER;
                         del : BOOLEAN; id3 : INTEGER;
                         r1, r2, r3, r4, r5 : POINTER) : INTEGER
    	external "C use <X11/Xlib.h>"
    	alias "XGetWindowProperty"
    	end

	x_set_wm_protocols (d : POINTER; wid : INTEGER; p : POINTER; i : INTEGER) : INTEGER
		external "C use <X11/Xlib.h>"
    	alias "XSetWMProtocols"
    	end

	x_withdraw_window (d: POINTER; rid, scr: INTEGER)
		external "C use <X11/Xlib.h>"
		alias "XWithdrawWindow"
		end


end 
