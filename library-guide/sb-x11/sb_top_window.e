-- X Window System Implementation

class SB_TOP_WINDOW

inherit

	SB_TOP_WINDOW_DEF
		redefine
			set_focus,
			kill_focus,
			move,
			resize,
			position
		end

create
	make_top_title, make_top, make_child

feature

	create_resource_def is
		local
			protocols: ARRAY [ INTEGER ]
			discard: INTEGER
		do
			create protocols.make (1, 2)
			protocols.put (application.wmDeleteWindow.id, 1)
			protocols.put (application.wmTakeFocus.id, 2)
			discard := xwin.set_wm_protocols (protocols)
--#			set_wm_hints
		end

	set_wm_hints is
		local
			wmh: X_SIZE_HINTS
		do
				-- Set size and position for Window Manager
			create wmh.make
			
      		if x_pos /= 0 or else y_pos /= 0 then		-- Force explicit position
        		wmh.set_flags (wmh.US_position | wmh.P_position)
			end
        	wmh.set_position (x_pos, y_pos)
      		
      		if (options & Decor_shrinkable) = Zero then
      				-- Cannot shrink, so set min size
        		wmh.set_min_size (default_width, default_height)
        		wmh.set_base_size (width, height)
        	end
      		if (options & Decor_stretchable) = Zero then
      				-- Cannot grow, so set max size
        		wmh.set_max_size (default_width, default_height)
        	end
      		wmh.set_size (width, height)
      		wmh.set_resize_inc (0, 0)
      		wmh.set_aspect (0, 0, 0, 0)
      		wmh.set_win_gravity (NorthWestGravity)		-- Tim Alexeevsky <realtim@mail.ru>
      		wmh.set_win_gravity (StaticGravity)			-- Account for border (ICCCM)

      			-- Set hints
      		xwin.set_wm_normal_hints (wmh)
		end
		
	set_focus is
      	do
         	Precursor
         	if is_attached then
				xwin.set_input_focus (RevertToPointerRoot, CurrentTime)
         	end
		end

	kill_focus is
		local
			win: SB_WINDOW
		do
         	Precursor
         	if is_attached then
				-- TODO
			--	win := display.get_input_focus_window
				if win /= Void and then win.is_equal (Current) then
					if owner /= Void and then owner.is_attached then
			--			fx_trace(100, <<"focus back to owner">>)
						owner.xwin.set_input_focus (RevertToPointerRoot, CurrentTime)
					else
			--			fx_trace(100, <<"focus back to NULL">>)
					--	XSetInputFocus(DISPLAY(getApp()), PointerRoot, RevertToPointerRoot, CurrentTime);
			--			display.set_input_focus_pointer_root
					end
				end
         	end
      	end

	hide is
      	do
         	if (flags & Flag_shown) = Flag_shown then
            	kill_focus
            	unset_flags (Flag_shown)
            	if is_attached then
					xwin.withdraw_window
            	end
         	end
      	end

	move (x, y: INTEGER) is
		do
         	if x /= x_pos or else y /= y_pos then
            	x_pos := x
            	y_pos := y
            	if is_attached then
               		-- Calculate the required window position based on the desired
               		-- position of the *client* rectangle.
					-- TODO
            	end
         	end
      	end

   	resize (w, h: INTEGER) is
      	do
         	if (flags & Flag_dirty) = Flag_dirty  or else w /= width or else h /= height then
            	width := w.max (1)
            	height := h.max (1)
            	if is_attached then
               		-- Calculate the required window size based on the desired
               		-- size of the *client* rectangle.
					-- TODO
               		layout
            	end
         	end
      	end

   position (x, y, w, h: INTEGER) is
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
				-- TODO
               layout
            end
         end
      end

	iconify is
      	do
         	if is_attached then
				-- TODO
         	end
      	end

	deiconify is
      	do
         	if is_attached then
				-- TODO
         	end
      	end

   	is_iconified: BOOLEAN is
		do
			if is_attached then
				-- TODO
			end     
		end

feature { NONE } -- Implementation

	sp: POINTER

	set_title_int is
		local
			own: SB_WINDOW
			wmhints: X_WM_HINTS
	--		s: POINTER
		do
			if title /= Void and then not title.is_empty then
		--		fx_trace(0, <<"SB_TOP_WINDOW::set_title_int - %"", title, "%"">>)
				xwin.store_name (title)
		--		xwin.set_icon_name (title)

		--		sp := title.to_external
		--		if XStringListToTextProperty ($sp, 1, t.to_external) then
		--			xwin.set_name (t)
		--			xwin.set_icon_name (t)
		--	--		t.free
		--		end

			end
		end

--	XStringListToTextProperty(p: POINTER; n: INTEGER; p2: POINTER): BOOLEAN is
--		external "C use <X11/Xlib.h>"
--		alias "XStringListToTextProperty"
--		end

	set_icons_int is
		do
        	if icon /= Void then
      		--	if icon.is_attached and icon.shape /= default_resource then
			--		-- TODO
            --	end
         	end

         	if mini_icon /= Void then
            --	if mini_icon.is_attached and mini_icon.shape /= default_resource then
			--		-- TODO
			--	end
         	end
      	end

	set_decorations_int is
		do
			-- Thanks to testing from Sander Jansen <sxj@cfdrc.com>
			-- Get old style
		end

end
