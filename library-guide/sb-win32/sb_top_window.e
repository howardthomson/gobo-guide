class SB_TOP_WINDOW

inherit

	SB_TOP_WINDOW_DEF
		redefine
			set_focus,
			kill_focus,
			move,
			resize,
			position,
			window_class_name
		end

feature -- not implemented ...

	is_iconified: BOOLEAN is
		do
		end

	iconify is
		do
		end

	deiconify is
		do
		end

feature -- resource processing

	window_class_name: STRING is
		once
			Result := "SBTopWindow"
		end

	create_resource_def is
		do
		end

feature -- todo

	set_title_int is
      	local
         	wf: SB_WAPI_WINDOW_FUNCTIONS;
        	t: INTEGER
      	do
         	if not title.is_empty then
            --	m.collection_off
            	t := wf.SetWindowText (resource_id, title.area.base_address)
            --	m.collection_on 
			end
		end

	set_icons_int is
		do
		end

	set_decorations_int is
		do
		end

feature

   is_minimized: BOOLEAN is
      local
         wf: SB_WAPI_WINDOW_FUNCTIONS
      do
         if is_attached then
            Result := (wf.IsIconic (resource_id) = 1)
         end         
      end

   is_maximized: BOOLEAN is
      local
         wf: SB_WAPI_WINDOW_FUNCTIONS
      do
         if is_attached then
            Result := (wf.IsZoomed (resource_id) = 1)
         end         
      end

   set_focus is
      local
         kf: SB_WAPI_KEYBOARD_INPUT_FUNCTIONS
         t: POINTER
      do
         Precursor
         if is_attached then
            t := kf.SetFocus (resource_id)
         end
      end

   kill_focus is
      local
         kf: SB_WAPI_KEYBOARD_INPUT_FUNCTIONS;
         t: POINTER;
      do
         Precursor;
         if is_attached then
            if kf.GetFocus = resource_id then
               if owner /= Void and then owner.is_attached then
                  t := kf.SetFocus (owner.resource_id)
               else
                  t := kf.SetFocus (default_pointer)
               end
            end
         end
      end

   hide is
      local
         sw: SB_WAPI_SHOWWINDOW_COMMANDS
         wf: SB_WAPI_WINDOW_FUNCTIONS
         t: INTEGER
      do
         if (flags & Flag_shown) = Flag_shown then
            kill_focus
            unset_flags (Flag_shown)
            if is_attached then
               t := wf.ShowWindow (resource_id, sw.SW_HIDE)
            end
         end
      end

   move (x, y: INTEGER) is
      local
         rect: SB_WAPI_RECT
         rf: SB_WAPI_RECTANGLE_FUNCTIONS
         wf: SB_WAPI_WINDOW_FUNCTIONS
         gwl: SB_WAPI_GWL_OFFSETS
         swp: SB_WAPI_SWP_FLAGS
         t: INTEGER
         dwStyle,dwExStyle: INTEGER
      do
         if x /= x_pos or else y /= y_pos then
            x_pos := x
            y_pos := y
            if is_attached then
               -- Calculate the required window position based on the desired
               -- position of the *client* rectangle.
               t := rf.SetRect (rect.ptr, x_pos, y_pos, 0, 0)
               dwStyle := wf.GetWindowLong (resource_id, gwl.GWL_STYLE)
               dwExStyle := wf.GetWindowLong (resource_id, gwl.GWL_EXSTYLE)
               t := wf.AdjustWindowRectEx (rect.ptr, dwStyle, 0, dwExStyle)
               t := wf.SetWindowPos (resource_id, default_pointer, rect.left, rect.top, 0, 0, swp.SWP_NOSIZE 
                                    | swp.SWP_NOZORDER | swp.SWP_NOOWNERZORDER)
            end
         end
      end

   resize (w, h: INTEGER) is
      local
         rect: SB_WAPI_RECT
         rf: SB_WAPI_RECTANGLE_FUNCTIONS
         wf: SB_WAPI_WINDOW_FUNCTIONS
         gwl: SB_WAPI_GWL_OFFSETS
         swp: SB_WAPI_SWP_FLAGS
         t: INTEGER
         dwStyle,dwExStyle: INTEGER
      do
         if (flags & Flag_dirty) = Flag_dirty  or else w /=width or else h /= height then
            width := w.max(1)
            height := h.max(1)
            if is_attached then
               -- Calculate the required window size based on the desired
               -- size of the *client* rectangle.
               t := rf.SetRect(rect.ptr, 0,0, width,height);
               dwStyle := wf.GetWindowLong(resource_id, gwl.GWL_STYLE);
               dwExStyle := wf.GetWindowLong(resource_id, gwl.GWL_EXSTYLE);
               t := wf.AdjustWindowRectEx(rect.ptr, dwStyle, 0, dwExStyle);
               t := wf.SetWindowPos(resource_id, default_pointer, 0,0,
               		(rect.right - rect.left).max(1), (rect.bottom - rect.top).max(1),
               		swp.SWP_NOMOVE | swp.SWP_NOZORDER | swp.SWP_NOOWNERZORDER);
               layout
            end
         end
      end

   position (x, y, w, h: INTEGER) is
      local
         rect: SB_WAPI_RECT
         rf: SB_WAPI_RECTANGLE_FUNCTIONS
         wf: SB_WAPI_WINDOW_FUNCTIONS
         gwl: SB_WAPI_GWL_OFFSETS
         swp: SB_WAPI_SWP_FLAGS
         t: INTEGER
         dwStyle, dwExStyle: INTEGER
      do
         if (flags & Flag_dirty) = Flag_dirty or else x /= x_pos or else y /= y_pos
            or else w /= width or else h /= height
          then
            x_pos := x
            y_pos := y
            width := w.max (1)
            height := h.max (1)
            if is_attached then
               -- Calculate the required window position & size based on the desired
               -- position & size of the *client* rectangle.
               t := rf.SetRect (rect.ptr, x_pos, y_pos, x_pos + width, y_pos + height)
               dwStyle := wf.GetWindowLong (resource_id, gwl.GWL_STYLE)
               dwExStyle := wf.GetWindowLong (resource_id, gwl.GWL_EXSTYLE)
               t := wf.AdjustWindowRectEx (rect.ptr, dwStyle, 0, dwExStyle)
               t := wf.SetWindowPos (resource_id, default_pointer, rect.left, rect.top, (rect.right - rect.left).max (1),
                                     (rect.bottom - rect.top).max (1), swp.SWP_NOZORDER | swp.SWP_NOOWNERZORDER);
               layout
            end
         end
      end

   maximize(notify: BOOLEAN) is
      local
         wf: SB_WAPI_WINDOW_FUNCTIONS;
         sw: SB_WAPI_SHOWWINDOW_COMMANDS;
         t: INTEGER;
      do
         if not is_maximized then
            if is_attached then
               t := wf.ShowWindow(resource_id, sw.SW_MAXIMIZE);
            end
            if notify and then message_target /= Void then
               message_target.do_handle(Current, mksel (SEL_MAXIMIZE, message), Void)
            end
         end
      end

   minimize(notify: BOOLEAN) is
      local
         wf: SB_WAPI_WINDOW_FUNCTIONS;
         sw: SB_WAPI_SHOWWINDOW_COMMANDS;
         t: INTEGER;
      do
         if not is_minimized then
            if is_attached then
               t := wf.ShowWindow(resource_id, sw.SW_MINIMIZE);
            end
            if notify and then message_target /= Void then
               message_target.do_handle(Current, mksel (SEL_MINIMIZE, message), Void)
            end
         end
      end

   restore(notify: BOOLEAN) is
      local
         wf: SB_WAPI_WINDOW_FUNCTIONS;
         sw: SB_WAPI_SHOWWINDOW_COMMANDS;
         t: INTEGER;
      do
         if is_minimized or else is_maximized then
            if is_attached then
               t := wf.ShowWindow(resource_id, sw.SW_RESTORE);
            end
            if notify and then message_target /= Void then
               message_target.do_handle(Current,mksel (SEL_RESTORE,message),Void)
            end
         end
      end

end