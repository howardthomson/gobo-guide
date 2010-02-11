indexing
	description: "[
		Abstract base class for all top-level windows

		TopWindows are usually managed by a Window Manager under X11 and
		therefore borders and window-menus and other decorations like resize-
		handles are subject to the Window Manager's interpretation of the
		decoration hints.

		When a TopWindow is closed, it sends a SEL_CLOSE message to its
		target.  The target should return 0 in response to this message if
		there is no objection to proceeding with closing the window, and
		return 1 otherwise.  After the SEL_CLOSE message has been sent and
		no objection was raised, the window will delete itself.

		When receiving a SEL_UPDATE, the target can update the title string
		of the window, so that the title of the window reflects the name
		of the document, for example.

		For convenience, TopWindow provides the same layout behavior as
		the Packer widget, as well as docking and undocking of toolbars.
		TopWindows can be owned by other windows, or be free-floating.

		Owned TopWindows will usually remain stacked on top of the owner
		windows; also, the lifetime of an owned window should not
		exceed that of the owner.

		The application will receive an ID_QUIT message when the last
		MainWindow is hidden, therefore normally terminating the application.
	]"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

	todo: "[
		maximise, minimise, restore ??
	]"

deferred class SB_TOP_WINDOW_DEF

inherit

	SB_SHELL
		rename         
			make_top as shell_make_top,
			make_child as shell_make_child,
			Id_last as Shell_id_last
		undefine
         	hide		
		redefine
			handle_2,
			create_resource,
			detach_resource,
			default_width,
			default_height,
			show,
			layout,
			destruct,
			class_name
		end
      	
   	SB_TOP_WINDOW_COMMANDS
   	SB_TOP_WINDOW_CONSTANTS

feature -- Attributes

   	title: STRING         -- Window title
   	icon: SB_ICON         -- Window icon (big)
   	mini_icon: SB_ICON    -- Window icon (small)

   	pad_top: INTEGER      -- Top margin
   	pad_bottom: INTEGER   -- Bottom margin
   	pad_left: INTEGER     -- Left margin
   	pad_right: INTEGER    -- Right margin

   	h_spacing: INTEGER    -- Horizontal child spacing
   	v_spacing: INTEGER    -- Vertical child spacing

feature -- class name

	class_name: STRING is
		once
			Result := "SB_TOP_WINDOW"
		end

feature -- creation

	make_top_title (a: SB_APPLICATION; name: STRING) is
		do
			make_top (a, name, Void, Void, 0, 0,0,0,0, 0,0,0,0, 0,0)
		end

   make_top (a: SB_APPLICATION; name: STRING; ic, mi: SB_ICON; opts: INTEGER;
                        x,y,w,h,  pl,pr,pt,pb,  hs,vs: INTEGER) is
      do
         shell_make_top (a, opts, x,y,w,h)
         title := name
         icon := ic
         mini_icon := mi
         create accel_table.make
         pad_top := pt
         pad_bottom := pb
         pad_left := pl
         pad_right := pr
         h_spacing := hs
         v_spacing := vs
      end

   make_child (own: SB_WINDOW; name: STRING; ic, mi: SB_ICON; opts: INTEGER;
                   x,y,w,h, pl,pr,pt,pb, hs,vs: INTEGER) is
      do
         shell_make_child (own, opts, x,y,w,h)
         title := name
         icon := ic
         mini_icon := mi
         create accel_table.make
         pad_top := pt
         pad_bottom := pb
         pad_left := pl
         pad_right := pr
         h_spacing := hs
         v_spacing := vs
      end

feature -- Resource creation (and attachment)

   	create_resource is
      	do
         	Precursor
         		-- Create icons
         	if icon /= Void then
            	icon.create_resource
         	end
         	if mini_icon /= Void then
            	mini_icon.create_resource
         	end
         	if is_attached then
            	if application.initialized then
            		create_resource_def
               			-- Set title
               		set_title_int
               			-- Set decorations
               		set_decorations_int
               			-- Set icon for X-Windows
               		set_icons_int
            	end
         	end
		end

	create_resource_def is
		deferred
		end

feature -- Resource destruction (and detachment)

	detach_resource is
    	do
        	Precursor
         	if icon /= Void then
            	icon.detach_resource
         	end
         	if mini_icon /= Void then
            	mini_icon.detach_resource
         	end
      	end

   	close (notify: BOOLEAN) is
   			-- called from on_close for SEL_CLOSE event from application
      	local
         	window: SB_WINDOW
         	mw: SB_MAIN_WINDOW
         	done: BOOLEAN
      	do
         	-- Ask message_target if desired
        	if not notify
        	or else message_target = Void
         	or else not message_target.handle_2 (Current, SEL_CLOSE, message, Void) then

         		set_message_target (Void)
         		set_message (0)
         	
            	-- Hide Current window
            	hide;
            	-- If there was another main level window still visible, that's all we do
            	from
               		window := get_root.first_child
            	until
               		window = Void or else done
            	loop
               		if window /= Current then
                  		mw ?= window
                  		if mw /= Void then
                     		done := True
                  		end
               		end
               		window := window.next
            	end
            	if not done then
               		-- Self destruct
               		-- We've just hidden the last remaining top level window:- quit the application
               		application.do_handle_2 (Current, SEL_COMMAND, application.ID_QUIT, Void)
            	end
            	destroy_resource
            	destruct
         	end
		end
		
feature -- Destruction

	destruct is
		do
			icon := Void
			mini_icon := Void
			Precursor
		end

feature -- actions

	show is
    	do
			Precursor
			raise
		end
		
   	show_at (placement: INTEGER) is
      	do
         	place (placement)
         	show
      	end

   	place (placement: INTEGER) is
         	-- Position the window based on placement
      	local
         	rw, rh, ox, oy, ow, oh, wx, wy, ww, wh: INTEGER
         	x, y: INTEGER
         	cp: SB_CURSOR_POSITION
         	over: SB_WINDOW
         	p: SB_POINT
         	t: BOOLEAN
      	do
         		-- Default placement:- leave it where it was
         	wx := x_pos
         	wy := y_pos
         	ww := width
         	wh := height
         		-- Get root window size
         	rw := get_root.width
         	rh := get_root.height

         		-- Placement policy
         	inspect placement

         	when PLACEMENT_CURSOR then
            	-- Place such that it contains the cursor

            		-- Get dialog location in root coordinates
            	p := translate_coordinates_to(get_root,0,0);
            	wx := p.x; wy := p.y
            		-- Where's the mouse?
            	cp := get_root.get_cursor_position;
            	if cp /= Void then
               		x := cp.x; y := cp.y
            	end

            	-- Place such that mouse in the middle, placing it as
            	-- close as possible in the center of the owner window.
            	-- Don't move the window unless the mouse is not inside.
            	if (wx = 0 and wy = 0) or else  x < wx or else y < wy 
               		or else wx+ww <= x or else wy+wh <= y 
             	then
               		-- Get the owner
               		if owner /= Void then
                  		over := owner
               		else
                  		over := get_root
               		end

               		-- Get owner window size
               		ow := over.width
               		oh := over.height

               		-- Owner's coordinates to root coordinates
               		p := over.translate_coordinates_to(get_root,0,0);
               		ox := p.x; oy := p.y

               		-- Adjust position
               		wx := ox + (ow - ww) // 2
               		wy := oy + (oh - wh) // 2

               		-- Move by the minimal amount
               		if x < wx
                	then wx := x - 20
               		elseif (wx + ww) <=x then
                  		wx := x - ww + 20
               		end

               		if y < wy then
                  		wy := y - 20
               		elseif (wy + wh) <=y then
                  		wy := y - wh + 20
               		end
            	end

            	-- Adjust so dialog is fully visible
            	if wx < 0 then
               		wx := 10
            	end      
            	if wy < 0 then
               		wy := 10
            	end
            	if (wx+ww) > rw then
               		wx := rw - ww - 10
            	end
            	if (wy+wh) > rh then
               		wy := rh - wh - 10
            	end

         when PLACEMENT_OWNER then
            	-- Place centered over the owner

            	-- Get the owner
            	if owner /= Void then
               		over := owner
            	else
               		over := get_root
            	end
   
            	-- Get owner window size
            	ow := over.width
            	oh := over.height
   
            	-- Owner's coordinates to root coordinates
            	p := over.translate_coordinates_to(get_root,0,0);
            	ox := p.x; oy := p.y
   
            	-- Adjust position
            	wx := ox+(ow - ww) // 2
            	wy := oy+(oh - wh) // 2

            	-- Adjust so dialog is fully visible
            	if wx < 0 then
               		wx := 10
            	end      
            	if wy < 0 then
               		wy := 10
            	end
            	if (wx + ww) > rw then
               		wx := rw - ww - 10
            	end
            	if (wy + wh) > rh then
               		wy := rh - wh - 10
            	end

         	when PLACEMENT_SCREEN then
            	-- Place centered on the screen

            	-- Adjust position
            	wx := (rw - ww) // 2
            	wy := (rh - wh) // 2

         	when PLACEMENT_VISIBLE then
            	-- Place to make it fully visible

            	-- Adjust so dialog is fully visible
            	if wx < 0 then
               		wx := 10
            	end      
            	if wy < 0 then
               		wy := 10
            	end
            	if (wx + ww) > rw then
               		wx := rw - ww - 10
            	end
            	if (wy + wh) > rh then
               		wy := rh - wh - 10
            	end

         	when PLACEMENT_MAXIMIZED then
            	-- Place maximized
            	wx := 0
            	wy := 0
            	ww := rw            -- Yes, I know:- we should substract the borders;
            	wh := rh            -- trouble is, no way to know how big those are....

         	when PLACEMENT_DEFAULT then
            	-- Default placement
         	end

         	-- Place it
         	position (wx, wy, ww, wh)
		end


   default_width: INTEGER is
      local
         w, wcum, wmax, mw: INTEGER
         child: SB_WINDOW
         hints: INTEGER
      do
         if (options & Pack_uniform_width) = Pack_uniform_width then
            mw := max_child_width;
         end
         from
            child := last_child
         until
            child = Void
         loop
            if child.is_shown then
               hints := child.layout_hints
               if (hints & Layout_fix_width) = Layout_fix_width then
                  w := child.width
               elseif (options & Pack_uniform_width) = Pack_uniform_width then
                  w := mw
               else
                  w := child.default_width
               end
               if (hints & Layout_right) = Layout_right and then 
                  (hints & Layout_center_x) = Layout_center_x 
                then
                  -- Fixed X
                  w := child.x_pos+w;
                  if w > wmax then
                     wmax := w;
                  end
               elseif (hints & Layout_side_left) = Layout_side_left then
                  -- Left or right
                  if child.next /= Void then
                     wcum := wcum + h_spacing
                  end
                  wcum := wcum + w
               else
                  if w>wcum then
                     wcum := w
                  end
               end
            end
            child := child.prev
         end
         Result := pad_left+pad_right+ wcum.max(wmax)
      end

   default_height: INTEGER is
      local
         h, hcum, hmax, mh: INTEGER
         child: SB_WINDOW
         hints: INTEGER
      do
         if (options & Pack_uniform_height) = Pack_uniform_height then
            mh := max_child_height;
         end
         from
            child := last_child
         until
            child = Void
         loop
            if child.is_shown then
               hints := child.layout_hints
               if (hints & Layout_fix_height) = Layout_fix_height then
                  h := child.height
               elseif (options & Pack_uniform_height) = Pack_uniform_height then
                  h := mh
               else
                  h := child.default_height
               end
               if (hints & Layout_bottom) = Layout_bottom and then 
                  (hints & Layout_center_y) = Layout_center_y 
                then
                  -- Fixed Y
                  h := child.y_pos+h
                  if h > hmax then
                     hmax := h
                  end
               elseif (hints & Layout_side_top) = Layout_side_top then
                  -- Top or bottom
                  if child.next /= Void then
                     hcum := hcum + v_spacing
                  end
                  hcum := hcum + h
               else
                  if h > hcum then
                     hcum := h
                  end
               end
            end
            child := child.prev
         end
         Result := pad_top + pad_bottom + hcum.max (hmax)
      end

   iconify is
		deferred
      end

   deiconify is
		deferred
      end

   is_iconified: BOOLEAN is
		deferred
      end

   set_title (name: STRING) is
         -- Change window title
      do
         if not title.is_equal (name) then
            title := name
            if is_attached then
               set_title_int
            end
         end
      end

   set_pad_top (pt: INTEGER) is
         -- Change top padding
      do
         if pad_top /= pt then
            pad_top := pt
            recalc
            update
         end
      end

   set_pad_bottom (pb: INTEGER) is
         -- Change bottom padding
      do
         if pad_bottom /= pb then
            pad_bottom := pb
            recalc
            update
         end
      end
      
   set_pad_left (pl: INTEGER) is
         -- Change left padding
      do
         if pad_left /= pl then
            pad_left := pl
            recalc
            update
         end
      end

   set_pad_right (pr: INTEGER) is
         -- Change right padding
      do
         if pad_right /= pr then
            pad_right := pr
            recalc
            update
         end
      end

   	set_h_spacing (hs: INTEGER) is
         	-- Change horizontal spacing between children
      	do
         	if h_spacing /= hs then
            	h_spacing := hs
            	recalc
            	update
         	end
      	end

   	set_v_spacing (vs: INTEGER) is
         	-- Change vertical spacing between children
      	do
         	if v_spacing /= vs then
            	v_spacing := vs
            	recalc
            	update
         	end
      	end

   	get_packing_hints: INTEGER is
      	do
         	Result := options & (Pack_uniform_height | Pack_uniform_width)
      	end
   
   	set_packing_hints (ph: INTEGER) is
         	-- Change packing hints for children
      	local
         	opts: INTEGER
      	do
         	opts := new_options (ph, (Pack_uniform_height | Pack_uniform_width))
         	if opts /= options then
            	options := opts
            	recalc
            	update
         	end
		end

	set_decorations (decorations: INTEGER) is
         	-- Change title and border decorations
      	local
         	opts: INTEGER;
      	do
         	opts := new_options (decorations, Decor_all)
         	if options /= opts then
            	options := opts
            	if is_attached then
               		set_decorations_int
            	end
            	recalc
         	end
      	end

   	get_decorations: INTEGER is
      	do
         	Result := (options & Decor_all)
      	end

	set_icon (ic: SB_ICON) is
         -- Change window icon
    	do
         	if icon /= ic then
            	icon := ic
            	if is_attached then
               		set_icons_int
            	end
         	end
      	end

   	set_mini_icon (ic: SB_ICON) is
         -- Change window mini (title) icon
      	do
         	if mini_icon /= ic then
            	mini_icon := ic
            	if is_attached then
               		set_icons_int
            	end
         	end
      	end


feature {ANY} -- Message processing

   handle_2 (sender: SB_MESSAGE_HANDLER; type, key: INTEGER; data: ANY): BOOLEAN is
      do
         if 	match_function_2 (SEL_CLOSE,	0, 					type, key) then Result := on_cmd_close				(sender, key, data)
         elseif match_function_2 (SEL_COMMAND,Id_setstringvalue,	type, key) then Result := on_cmd_set_string_value	(sender, key, data)
         elseif match_function_2 (SEL_COMMAND,ID_ICONIFY,			type, key) then Result := on_cmd_iconify			(sender, key, data)
         elseif match_function_2 (SEL_COMMAND,ID_DEICONIFY,			type, key) then Result := on_cmd_deiconify			(sender, key, data)
         else Result := Precursor(sender, type, key, data)
         end
      end

	on_cmd_close (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
		do
			close (True)
			Result := True
		end

   on_cmd_set_string_value (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      local
         str: STRING;
      do
         str ?= data
         if str /= Void then
            set_title (str)
         end
         Result := True
      end

   on_cmd_iconify (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         iconify
         Result := True
      end

   on_cmd_deiconify (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         deiconify
         Result := True
      end

   on_focus_up (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
      end

   on_focus_down (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
      end

   on_focus_left (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
      end

   on_focus_right (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
      end


feature {NONE} -- Implementation

	offx, offy: INTEGER

	set_title_int is
		deferred
		end

	set_icons_int is
		deferred
		end

	set_decorations_int is
		deferred
		end

   layout is
      local
         left, right, top, bottom, x,y, w,h: INTEGER;
         mw,mh: INTEGER
         child: SB_WINDOW
         hints: INTEGER
      do
		check width >= 0 and height >= 0 end

         	-- Placement rectangle; right/bottom non-inclusive
         left := pad_left
         right := left.max (width - pad_right)
         top := pad_top
         bottom := top.max (height - pad_bottom)

		check left >= 0 and right >= left and top >= 0 and bottom >= top end

         -- Get maximum child size
         if (options & Pack_uniform_width) /= b0 then
            mw := max_child_width
         end
         if (options & Pack_uniform_height) /= b0 then
            mh := max_child_height
         end

         -- Pack them in the cavity
         from
            child := first_child
         until
            child = Void
         loop
            if child.is_shown then
               hints := child.layout_hints;
               x := child.x_pos;
               y := child.y_pos;
               
               	-- Vertical
               if (hints & Layout_side_left) /= b0 then
                  	-- Height
                  if (hints & Layout_fix_height) /= b0 then
                     h := child.height
                  elseif (options & Pack_uniform_height) /= b0 then
                     h := mh
                  elseif (hints & Layout_fill_y) /= b0 then
                     h := bottom-top
                  else 
                     h := child.default_height
                  end
                  if h < 0 then h := 0 end
					check h >= 0 end
					
                 	 -- Width
                  if (hints & Layout_fix_width) /= b0 then
                     w := child.width
                  elseif (options & Pack_uniform_width) /= b0 then
                     w := mw
                  elseif (hints & Layout_fill_x) /= b0 then
                     w := right - left
                  else
                     w := child.width_for_height(h); -- Width is a function of height!
                  end
                  if w < 0 then w := 0 end
					check w >= 0 end
					
                 	 -- Y
                  if (hints & Layout_bottom) = b0 or else (hints & Layout_center_y) /= b0
                   then
                     if (hints & Layout_center_y) = Layout_center_y then
                        y := top+(bottom-top-h)//2;
                     elseif (hints & Layout_bottom) = Layout_bottom then
                        y := bottom - h
                     else
                        y := top
                     end
                  end

                  	--  X
                  if (hints & Layout_right) = b0 or else (hints & Layout_center_x) = b0
                   then
                     if (hints & Layout_center_x) = Layout_center_x then
                        x := left + (right - left - w) // 2
                     elseif (hints & Layout_side_bottom) /= b0 then
                        x := right - w
                        right := right - (w+h_spacing)
                     else
                        x := left
                        left := left + (w + h_spacing)
                     end
                  end
               else
                  	-- Width
                  if (hints & Layout_fix_width) /= b0 then
                     w := child.width
                  elseif (options & Pack_uniform_width) /= b0 then
                     w := mw
                  elseif (hints & Layout_fill_x) /= b0 then
                     w := right - left
                  else
                     w := child.default_width
                  end
                  if w < 0 then w := 0 end
					check w >= 0 end

                  	-- Height
                  if (hints & Layout_fix_height) /= b0 then
                     h := child.height
                  elseif (options & Pack_uniform_height) /= b0 then
                     h := mh
                  elseif (hints & Layout_fill_y) /= b0 then
                     h := bottom - top
                  else 
                     h := child.height_for_width (w) -- Height is a function of width!
                  end
                  if h < 0 then h := 0 end
					check h >= 0 end

                  	--  X
                  if (hints & Layout_right) = b0 or else (hints & Layout_center_x) = b0
                   then
                     if (hints & Layout_center_x) /= b0 then
                        x := left + (right - left - w) // 2
                     elseif (hints & Layout_right) /= b0 then
                        x := right - w
                     else
                        x := left
                     end
                  end
                  	-- Y
                  if (hints & Layout_bottom) = b0 or else (hints & Layout_center_y) = b0
                   then
                     if (hints & Layout_center_y) /= b0 then
                        y := top + (bottom - top - h) // 2
                     elseif (hints & Layout_side_bottom) /= b0 then
                        y := bottom - h
                        bottom := bottom - (h + v_spacing)
                     else
                        y := top
                        top := top + (h + v_spacing)
                     end
                  end
               end
               
				check w >= 0 and then h >= 0 end

               child.position (x, y, w, h)
            end
            child := child.next
         end
         unset_flags (Flag_dirty)
      end

end
