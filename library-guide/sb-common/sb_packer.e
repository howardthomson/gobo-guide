note
	description: "[
		Packer is a layout manager which automatically places child windows inside its
		area against the left, right, top, or bottom side. The side against which a child
		is placed is determined by the Layout_side_top, Layout_side_bottom, Layout_side_left,
		and Layout_side_right hints given by the child window.
	]"

	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

	mods: "[
		handle routine - originally from SB_COMPOSITE and undefined from SB_FRAME
	]"

class SB_PACKER

inherit

	SB_COMPOSITE
      	rename
      			-- from SB_WINDOW
         	make as make_composite
      	redefine
      		make_ev,
         	on_paint,
   			handle_2,
         	layout,
         	default_width,
         	default_height,
         	class_name
         select
         	make_ev
      	end

   	SB_FRAME 
      	rename
      			-- from SB_WINDOW
         	make_opts as make_frame_opts,
         	make_window as make_composite
      	undefine
      		make_ev,
         	make,
         	make_sb,
         	create_resource,
         	destroy_resource,
         	detach_resource,
         	destruct,
         	is_composite,
         	default_height,
         	default_width,
         	layout,
         	handle_2,
         	on_paint,
         	on_cmd_update,
         	on_key_press,
         	on_key_release,
         	class_name
      	end

   SB_PACKER_COMMANDS

   SB_PACKER_CONSTANTS

create

   make, make_opts

feature

   h_spacing: INTEGER;
         -- Horizontal child spacing

   v_spacing: INTEGER;
         -- Vertical child spacing

feature -- class name

	class_name: STRING
		once
			Result := "SB_PACKER"
		end

feature -- Creation

	make_ev
			-- Eiffel Vision creation routine ...
		do
	--		make_sb (Void, Layout_fill_x | Layout_fill_y)
			make_sb (Void, Layout_fill_x | Layout_fill_y | Frame_line) -- TEMP
		end

	make (p: SB_COMPOSITE)
         	-- Construct packer layout manager
      	do
			make_opts (p, 0, 0,0,0,0, DEFAULT_SPACING, DEFAULT_SPACING, DEFAULT_SPACING, DEFAULT_SPACING,
				DEFAULT_SPACING, DEFAULT_SPACING)
		end

	make_sb (p: SB_COMPOSITE; opts: INTEGER)
		do
			make_opts (p, opts, 0,0,0,0, DEFAULT_SPACING, DEFAULT_SPACING, DEFAULT_SPACING, DEFAULT_SPACING,
					DEFAULT_SPACING, DEFAULT_SPACING)
		end

   	make_opts (p: SB_COMPOSITE; opts: INTEGER; x,y,w,h, pl,pr,pt,pb, hs,vs: INTEGER)
         	-- Construct packer layout manager
      	do
         	make_composite (p, opts, x,y,w,h)
	         	-- TODO actually this is from the frame, but we can't use
	         	-- creation procedure because of adding this to parent list
	         	-- of children
         	flags := flags | Flag_shown
         	back_color := application.base_color
         	base_color := application.base_color
         	hilite_color := application.hilite_color
         	shadow_color := application.shadow_color
         	border_color := application.border_color
         	pad_top := pt
         	pad_bottom := pb
         	pad_left := pl
         	pad_right := pr
         	if (options & Frame_thick) = Frame_thick then
            	border := 2
         	elseif (options & (Frame_sunken | Frame_raised)) =
            	(Frame_sunken | Frame_raised) then
            	border := 1
         	else
            	border := 0
         	end
	         	---- end of TODO
         	h_spacing := hs
         	v_spacing := vs
      	end

feature -- Quieries

	default_width: INTEGER
			-- Compute minimum width based on child layout hints
		local
			w, wcum, wmax, mw: INTEGER
			side, hints: INTEGER
			child: SB_WINDOW
		do
			if (options & Pack_uniform_width) /= 0 then
				mw := max_child_width
			end

			from
				child := last_child
			until
				child = Void
			loop
				if child.is_shown then
					hints := child.layout_hints
					side := hints & Layout_side_mask
					if (hints & Layout_fix_width) /= 0 then
						w := child.width
					elseif (options & Pack_uniform_width) /= 0 then
						w := mw
					else
						w := child.default_width
					end

					if (hints & Layout_right) /= 0
						and then (hints & Layout_center_x) /= 0
					then
						w := child.x_pos + w
						if w > wmax then
							wmax := w
						end
					elseif side = Layout_side_left or side = Layout_side_right then
						if child.next /= Void then
							wcum := wcum + h_spacing
						end
						wcum := wcum + w
					else
			        	if w > wcum then
			        		wcum := w
			        	end
					end
				end
				child := child.prev
			end
			Result := pad_left + pad_right + (border*2) + wcum.max(wmax)
		end

   default_height: INTEGER
         -- Compute minimum height based on child layout hints
      local
         h, hcum, hmax, mh: INTEGER
         side, hints: INTEGER
         child: SB_WINDOW
      do
         if (options & Pack_uniform_height) /= 0 then
            mh := max_child_height
         end
         from
            child := last_child
         until
            child = Void
         loop
            if child.is_shown then
               hints := child.layout_hints
               side := hints & Layout_side_mask
               if (hints & Layout_fix_height) /= 0 then
                  h := child.height
               elseif (options & Pack_uniform_height) /= 0 then
                  h := mh
               else h := child.default_height
               end

               if (hints & Layout_bottom) /= 0 and then
                  (hints & Layout_center_y) /= 0 then
                  h := child.y_pos+h
                  if h > hmax then
                     hmax := h
                  end
               elseif side = Layout_side_top or else side = Layout_side_bottom then
                  if child.next /= Void then
                     hcum := hcum + v_spacing
                  end
                  hcum := hcum+h
               else
                  if h > hcum then
                     hcum := h
                  end
               end
            end
            child := child.prev
         end
         Result := pad_top + pad_bottom + (border * 2) + hcum.max (hmax)
      end

   set_packing_hints (ph: INTEGER)
         -- Change packing hints
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

   get_packing_hints: INTEGER
         -- Return packing hints
      do
         Result := (options & (Pack_uniform_height | Pack_uniform_width))
      end

   set_h_spacing(hs: INTEGER)
         -- Change horizontal inter-child spacing
      do
         if h_spacing /= hs then
            h_spacing := hs
            recalc
            update
         end
      end

   set_v_spacing(vs: INTEGER)
         -- Change vertical inter-child spacing
      do
         if v_spacing /= vs then
            v_spacing := vs
            recalc
            update
         end
      end

feature -- Message processing

	handle_2 (sender: SB_MESSAGE_HANDLER; type, key: INTEGER; data: ANY): BOOLEAN
    	do
        	if		match_function_2 (SEL_FOCUS_UP,		0, type, key) then Result := on_focus_up	(sender, key, data)
        	elseif match_function_2 (SEL_FOCUS_DOWN,	0, type, key) then Result := on_focus_down	(sender, key, data)
        	elseif match_function_2 (SEL_FOCUS_LEFT,	0, type, key) then Result := on_focus_left	(sender, key, data)
        	elseif match_function_2 (SEL_FOCUS_RIGHT,	0, type, key) then Result := on_focus_right	(sender, key, data)
			else Result := Precursor {SB_COMPOSITE} (sender, type, key, data)
			end
		end

   on_paint (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         ev: SB_EVENT
         dc: SB_DC_WINDOW
      do
         ev ?= data;
         if ev /= Void then
         	dc := paint_dc
            dc.make_event (Current, ev)
            dc.set_foreground (back_color)
            dc.fill_rectangle (ev.rect_x, ev.rect_y, ev.rect_w, ev.rect_h)
            draw_frame(dc, 0,0, width,height)
            dc.stop
            Result := True
         end
      end


   on_focus_up (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         child, c: SB_WINDOW
         cury, childy: INTEGER
         done: BOOLEAN
      do
         if focus_child /= Void then
            cury := focus_child.y_pos
            from
               done := False
            until
               done
            loop
               child := Void
               childy := -10000000
               from
                  c := first_child
               until
                  c = Void
               loop
                  if c.is_shown and then c.y_pos < cury  and then childy < c.y_pos then
                     childy := c.y_pos
                     child := c
                  end
                  c := c.next
               end
               if child = Void then
                  done := True
               elseif child.is_enabled and then child.can_focus then
                  child.do_handle_2 (Current, SEL_FOCUS_SELF, 0, data);
                  done := True
                  Result := True
               elseif child.is_composite
                  and then child.handle_2 (Current, SEL_FOCUS_UP, selector,data)
                then
                  done := True
                  Result := True
               else
                  cury := childy
               end
            end
         else
            child := last_child
            from
               done := False
            until
               done or else child = Void
            loop
               if child.is_shown then
                  if child.is_enabled and then child.can_focus then
                     child.do_handle_2 (Current, SEL_FOCUS_SELF, 0, data);
                     Result := True;
                  elseif child.is_composite
                     and then child.handle_2 (Current, SEL_FOCUS_UP, selector, data)
                   then
                     Result := True
                  end
               end
               child := child.prev
            end
         end
      end

   on_focus_down (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         child, c: SB_WINDOW
         cury, childy: INTEGER
         done: BOOLEAN
      do
         if focus_child /= Void then
            cury := focus_child.y_pos
            from
               done := False
            until
               done
            loop
               child := Void
               childy := 10000000
               from
                  c := first_child
               until
                  c = Void
               loop
                  if c.is_shown and then cury < c.y_pos and then c.y_pos < childy then
                     childy := c.y_pos
                     child := c
                  end
                  c := c.next
               end
               if child = Void then
                  done := True;
               elseif child.is_enabled and then child.can_focus then
                  child.do_handle_2 (Current, SEL_FOCUS_SELF, 0, data);
                  done := True
                  Result := True
               elseif child.is_composite
                  and then child.handle_2 (Current, SEL_FOCUS_DOWN, selector, data)
                then
                  done := True
                  Result := True
               else
                  cury := childy
               end
            end
         else
            from
               child := first_child
               done := False
            until
               done or else child = Void
            loop
               if child.is_shown then
                  if child.is_enabled and then child.can_focus then
                     child.do_handle_2 (Current, SEL_FOCUS_SELF, 0, data);
                     Result := True;
                  elseif child.is_composite
                     and then child.handle_2 (Current, SEL_FOCUS_DOWN, selector, data)
                   then
                     Result := True
                  end
               end
               child := child.next
            end
         end
      end

   on_focus_left (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         child,c: SB_WINDOW
         curx,childx: INTEGER
         done: BOOLEAN
      do
         if focus_child /= Void then
            curx := focus_child.x_pos
            from
               done := False
            until
               done
            loop
               child := Void
               childx := -10000000
               from
                  c := first_child
               until
                  c = Void
               loop
                  if c.is_shown and then c.x_pos  < curx  and then childx < c.x_pos then
                     childx := c.x_pos
                     child := c
                  end
                  c := c.next
               end
               if child = Void then
                  done := True
               elseif child.is_enabled and then child.can_focus then
                  child.do_handle_2 (Current, SEL_FOCUS_SELF, 0, data)
                  done := True
                  Result := True
               elseif child.is_composite
                  and then child.handle_2 (Current, SEL_FOCUS_LEFT, selector, data)
                then
                  done := True
                  Result := True
               else
                  curx := childx
               end
            end
         else
            child := last_child
            from
               done := False
            until
               done or else child = Void
            loop
               if child.is_shown then
                  if child.is_enabled and then child.can_focus then
                     child.do_handle_2 (Current, SEL_FOCUS_SELF, 0, data);
                     Result := True
                  elseif child.is_composite
                     and then child.handle_2 (Current, SEL_FOCUS_LEFT, selector, data)
                   then
                     Result := True
                  end
               end
               child := child.prev
            end
         end
      end

   on_focus_right (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         child,c: SB_WINDOW
         curx,childx: INTEGER
         done: BOOLEAN
      do
         if focus_child /= Void then
            curx := focus_child.x_pos;
            from
               done := False
            until
               done
            loop
               child := Void
               childx := 10000000
               from
                  c := first_child
               until
                  c = Void
               loop
                  if c.is_shown and then curx < c.x_pos and then c.x_pos < childx then
                     childx := c.x_pos
                     child := c
                  end
                  c := c.next
               end
               if child = Void then
                  done := True
               elseif child.is_enabled and then child.can_focus then
                  child.do_handle_2 (Current, SEL_FOCUS_SELF, 0, data)
                  done := True
                  Result := True
               elseif child.is_composite
                  and then child.handle_2 (Current, SEL_FOCUS_RIGHT, selector, data)
                then
                  done := True
                  Result := True
               else
                  curx := childx
               end
            end
         else
            from
               child := first_child;
               done := False
            until
               done or else child = Void
            loop
               if child.is_shown then
                  if child.is_enabled and then child.can_focus then
                     child.do_handle_2 (Current, SEL_FOCUS_SELF, 0, data);
                     Result := True
                  elseif child.is_composite
                     and then child.handle_2 (Current, SEL_FOCUS_RIGHT, selector, data)
                   then
                     Result := True
                  end
               end
               child := child.next
            end
         end
      end


feature {NONE} -- Implementation

   layout
         -- Recalculate layout
      local
         left,right,top,bottom,x,y,w,h,mw,mh: INTEGER
         child: SB_WINDOW
         hints: INTEGER
      do

         	-- Placement rectangle; right/bottom non-inclusive
         left := border + pad_left
         right := width - border - pad_right
         top := border + pad_top
         bottom := height - border - pad_bottom

		check
			left_le_right: left <= right
			top_le_bottom: top <= bottom
		end

         	-- Get maximum child size
         if (options & Pack_uniform_width) /= 0 then
            mw := max_child_width
         end
         if (options & Pack_uniform_height) /= 0 then
            mh := max_child_height;
         end

        	 -- Pack them in the cavity
         from
            child := first_child
         until
            child = Void
         loop
            if child.is_shown then
               hints := child.layout_hints
               x := child.x_pos
               y := child.y_pos

               		-- Height
               if (hints & Layout_fix_height) /= 0 then
                  h := child.height
               elseif (options & Pack_uniform_height) /= 0 then
                  h := mh
               elseif (hints & Layout_fill_y) /= 0 then
                  h := bottom - top;
               else
                  h := child.default_height
               end
				check h >= 0 end

               		-- Width
               if (hints & Layout_fix_width) /= 0 then
                  w := child.width
               elseif (options & Pack_uniform_width) /= 0 then
                  w := mw
               elseif (hints & Layout_fill_x) /= 0 then
                  w := right - left
               else
                  w := child.default_width
               end
				check w >= 0 end

               		-- Vertical
               if (hints & Layout_side_left) /= 0 then
                  -- Y
                  if (hints & Layout_bottom) = 0 or else (hints & Layout_center_y) = 0 then
                     if (hints & Layout_center_y) /= 0 then
                        y := top + (bottom - top - h) // 2
                     elseif (hints & Layout_bottom) /= 0 then
                        y := bottom - h
                     else
                        y := top;
                     end
                  end
                  	-- X
                  if (hints & Layout_right) = 0 or else (hints & Layout_center_x) = 0 then
                     if (hints & Layout_center_x) /= 0 then
                        x := left + (right - left - w) // 2
                     elseif (hints & Layout_side_bottom) /= 0 then
                        x := right-w;
                        right := right - (w + h_spacing)
                     else
                        x := left
                        left := left + (w + h_spacing)
                     end
                  end
                  	-- Horizontal
               else
                  	-- X
                  if (hints & Layout_right) = 0 or else (hints & Layout_center_x) = 0 then
                     if (hints & Layout_center_x) /= 0 then
                        x := left + (right - left - w) // 2;
                     elseif (hints & Layout_right) /= 0 then
                        x := right - w
                     else
                        x := left
                     end
                  end
                  	-- Y
                  if (hints & Layout_bottom) = 0 or else (hints & Layout_center_y) = 0 then
                     if (hints & Layout_center_y) /= 0 then
                        y := top + (bottom - top - h) // 2
                     elseif (hints & Layout_side_bottom) /= 0 then
                        y := bottom - h
                        bottom := bottom - (h + v_spacing)
                     else
                        y := top
                        top := top + (h + v_spacing)
                     end
                  end
               end
               child.position (x,y, w,h)
            end
            child := child.next
         end
         unset_flags (Flag_dirty)
      end
end
