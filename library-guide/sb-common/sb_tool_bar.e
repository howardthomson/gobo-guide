note
	description:"ToolBar control."
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

class SB_TOOL_BAR

inherit

	SB_PACKER
		rename
         	Id_last as PACKER_ID_LAST,
         	make as packer_make,
         	make_opts as packer_make_opts
      	redefine
         	default_width,
         	default_height,
         	width_for_height,
         	handle_2,
         	layout,
         	destruct,
         	class_name
      	end
      
	SB_TOOL_BAR_COMMANDS

create

   make, make_opts

feature -- class name

	class_name: STRING
		once
			Result := "SB_TOOL_BAR"
		end

feature -- Creation

   make (p: SB_COMPOSITE; opts: INTEGER)
         -- Construct a non-floatable toolbar.
         -- The toolbar cannot be undocked.
      local
         o: INTEGER
      do
         if opts = 0 then
            o := Layout_top | Layout_left | Layout_fill_x;
         else
            o := opts
         end
         make_opts (p, Void, o, 0,0,0,0, 3,3,2,2, DEFAULT_SPACING, DEFAULT_SPACING)
      end

   make_float (p, q: SB_COMPOSITE; opts: INTEGER)
         -- Construct a floatable toolbar
         -- Normally, the toolbar is docked under window p.
         -- When floated, the toolbar can be docked under window q, which is
         -- typically an SB_TOOL_BAR_SHELL window.
      local
         o: INTEGER
      do
         if opts = 0 then
            o := Layout_top | Layout_left | Layout_fill_x;
         end
         make_opts (p, q, o, 0,0,0,0, 3,3,2,2, DEFAULT_SPACING, DEFAULT_SPACING);
      end

	make_opts (p, q: SB_COMPOSITE; opts: INTEGER; x,y,w,h, pl,pr,pt,pb, hs,vs: INTEGER)
    		-- Construct a toolbar. Normally, the toolbar is docked under window p.
    		-- When floated, the toolbar can be docked under window q, which is
        	-- typically an SB_TOOL_BAR_SHELL window.
      	do
         	packer_make_opts (p, opts, x,y,w,h, pl,pr,pt,pb, hs,vs);
         	if q = Void then
           		dry_dock := Void
         	else
           		dry_dock := p
         	end
         	wet_dock := q
		--#	create outline	-- Not needed: expanded class
         	dock_after := Void
         	dock_side := 0
         	docking := False
      	end

feature -- Data

   dry_dock: SB_COMPOSITE
         -- Parent when docked

   wet_dock: SB_COMPOSITE
         -- Parent when floating

feature -- Queries

   default_width: INTEGER
         -- Return default width
      local
         w, wcum, wmax, mw, n: INTEGER
         child: SB_WINDOW
         hints: INTEGER
         t: SB_TOOL_BAR_GRIP
      do
         if (options & Pack_uniform_width) /= 0 then
            mw := max_child_width
         end
         from
            child := first_child
         until
            child = Void
         loop
            if child.is_shown then
               hints := child.layout_hints
               t ?= child;
               if t /= Void then
                  w := child.default_width
               elseif (hints & Layout_fix_width) /= 0 then
                  w := child.width
               elseif (options & Pack_uniform_width) /= 0 then
                  w := mw
               else
                  w := child.default_width
               end
               if wmax < w then
                  wmax := w
               end
               wcum := wcum + w
               n := n + 1
            end
            child := child.next
         end
         if (options & Layout_side_left) = 0 then
            -- Horizontal
            if n > 1 then
               wcum := wcum + (n-1)*h_spacing
            end
            wmax := wcum
         end
         Result := pad_left + pad_right + wmax + (border*2)
      end

   default_height: INTEGER
         -- Return default height
      local
         h, hcum, hmax, mh, n: INTEGER
         child: SB_WINDOW
         hints: INTEGER
         t: SB_TOOL_BAR_GRIP
      do
         if (options & Pack_uniform_height) /= 0 then
            mh := max_child_height
         end
         from
            child := first_child
         until
            child = Void
         loop
            if child.is_shown then
               hints := child.layout_hints
               t ?= child
               if t /= Void then
                  h := child.default_height
               elseif (hints & Layout_fix_width) /= 0 then
                  h := child.height
               elseif (options & Pack_uniform_width) /= 0 then
                  h := mh
               else
                  h := child.default_height
               end
               if hmax < h then
                  hmax := h
               end
               hcum := hcum + h
               n := n + 1
            end
            child := child.next
         end
         if (options & Layout_side_left) /= 0 then
            -- Vertical
            if n > 1 then
               hcum := hcum + (n-1)*v_spacing
            end
            hmax := hcum
         end
         Result := pad_left + pad_right + hmax + (border*2)
      end

   width_for_height (givenheight: INTEGER): INTEGER
         -- Return width for given height
      local
         wtot, wmax, hcum, w, h, mw, mh, space, ngalleys: INTEGER
         child: SB_WINDOW
         hints: INTEGER
         t: SB_TOOL_BAR_GRIP
      do
         space := givenheight - pad_top - pad_bottom - (border*2)
         if space < 1 then
            space := 1
         end;
         if (options & Pack_uniform_width) /= 0 then
            mw := max_child_width
         end
         if (options & Pack_uniform_height) /= 0 then
            mh := max_child_height
         end
         from
            child := first_child
         until
            child = Void
         loop
            if child.is_shown then
               hints := child.layout_hints
               t ?= child
               if t /= Void then
                  w := child.default_width
               elseif (hints & Layout_fix_width) /= 0 then
                  w := child.width
               elseif (options & Pack_uniform_width) /= 0 then
                  w := mw
               else
                  w := child.default_width
               end
               if t /= Void then
                  h := child.default_height
               elseif (hints & Layout_fix_height) /= 0 then
                  h := child.height
               elseif (options & Pack_uniform_height) /= 0 then
                  h := mh
               else
                  h := child.default_height
               end
               if hcum+h > space then
                  hcum := 0
               end
               if hcum = 0 then
                  ngalleys := ngalleys + 1
               end
               hcum := hcum + h + v_spacing
               if wmax < w then
                  wmax := w
               end
            end
            child := child.next
         end
         wtot := wmax * ngalleys
         Result := pad_left + pad_right + wtot + (border*2)
      end

   get_height_for_width (givenwidth: INTEGER): INTEGER
         -- Return height for given width
      local
         htot, hmax, wcum, w, h, mw, mh, space, ngalleys: INTEGER
         child: SB_WINDOW
         hints: INTEGER
         t: SB_TOOL_BAR_GRIP
      do
         space := givenwidth - pad_left - pad_right - (border*2)
         if space < 1 then
            space := 1
         end;
         if (options & Pack_uniform_width) /= 0 then
            mw := max_child_width
         end
         if (options & Pack_uniform_height) /= 0 then
            mh := max_child_height
         end
         from
            child := first_child
         until
            child = Void
         loop
            if child.is_shown then
               hints := child.layout_hints;
               t ?= child
               if t /= Void then
                  w := child.default_width
               elseif (hints & Layout_fix_width) /= 0 then
                  w := child.width
               elseif (options & Pack_uniform_width) /= 0 then
                  w := mw
               else
                  w := child.default_width
               end
               if t /= Void then
                  h := child.default_height
               elseif (hints & Layout_fix_height) /= 0 then
                  h := child.height
               elseif (options & Pack_uniform_height) /= 0 then
                  h := mh
               else
                  h := child.default_height
               end
               if wcum+w > space then
                  wcum := 0
               end
               if wcum = 0 then
                  ngalleys := ngalleys + 1
               end
               wcum := wcum + w + h_spacing
               if hmax < h then
                  hmax := h
               end
            end
            child := child.next
         end
         htot := hmax * ngalleys
         Result := pad_top + pad_bottom + htot + (border*2)
      end

   is_docked: BOOLEAN
         -- Return true if toolbar is docked
      do
         Result := parent /= wet_dock
      end

   get_docking_side: INTEGER
         -- Return docking side
      do
         Result := (options & Layout_side_mask)
      end

feature -- Message processing

   handle_2 (sender: SB_MESSAGE_HANDLER; type, key: INTEGER; data: ANY): BOOLEAN
      do
         if		match_function_2 (SEL_FOCUS_PREV,	0, 				type, key) then Result := on_focus_left		(sender, key, data)
         elseif match_function_2 (SEL_FOCUS_NEXT,	0,				type, key) then Result := on_focus_right	(sender, key, data)
         elseif match_function_2 (SEL_UPDATE,		ID_UNDOCK, 		type, key) then Result := on_upd_undock		(sender, key, data)
         elseif match_function_2 (SEL_UPDATE,		ID_DOCK_TOP, 	type, key) then Result := on_upd_dock_top	(sender, key, data)
         elseif match_function_2 (SEL_UPDATE,		ID_DOCK_BOTTOM, type, key) then Result := on_upd_dock_bottom(sender, key, data)
         elseif match_function_2 (SEL_UPDATE,		ID_DOCK_LEFT, 	type, key) then Result := on_upd_dock_left	(sender, key, data)
         elseif match_function_2 (SEL_UPDATE,		ID_DOCK_RIGHT, 	type, key) then Result := on_upd_dock_right	(sender, key, data)
         elseif match_function_2 (SEL_COMMAND,		ID_UNDOCK,		type, key) then Result := on_cmd_undock		(sender, key, data)
         elseif match_function_2 (SEL_COMMAND,		ID_DOCK_TOP,	type, key) then Result := on_cmd_dock_top	(sender, key, data)
         elseif match_function_2 (SEL_COMMAND,		ID_DOCK_BOTTOM, type, key) then Result := on_cmd_dock_bottom(sender, key, data)
         elseif match_function_2 (SEL_COMMAND,		ID_DOCK_LEFT,	type, key) then Result := on_cmd_dock_left	(sender, key, data)
         elseif match_function_2 (SEL_COMMAND,		ID_DOCK_RIGHT, 	type, key) then Result := on_cmd_dock_right	(sender, key, data)
         elseif match_function_2 (SEL_BEGINDRAG,	ID_TOOLBARGRIP, type, key) then Result := on_begin_drag_grip(sender, key, data)
         elseif match_function_2 (SEL_ENDDRAG,		ID_TOOLBARGRIP, type, key) then Result := on_end_drag_grip	(sender, key, data)
         elseif match_function_2 (SEL_DRAGGED,		ID_TOOLBARGRIP, type, key) then Result := on_dragged_grip	(sender, key, data)
         else Result := Precursor(sender, type, key, data); end
      end

   on_cmd_undock(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         undock
         Result := True
      end

   on_upd_undock (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         if is_docked then
            sender.do_handle_2 (Current, SEL_COMMAND, Id_uncheck, Void)
         else
            sender.do_handle_2 (Current, SEL_COMMAND, Id_check, Void)
         end
         if wet_dock /= Void then
            sender.do_handle_2 (Current, SEL_COMMAND, Id_enable, Void)
         else
            sender.do_handle_2 (Current, SEL_COMMAND, Id_disable, Void)
         end
         Result := True
      end

   on_cmd_dock_top (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         dock_inner (Layout_side_top)
         Result := True
      end

   on_upd_dock_top (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         if is_docked and then (options & Layout_side_mask) = Layout_side_top then
            sender.do_handle_2 (Current, SEL_COMMAND, Id_check, Void)
         else
            sender.do_handle_2 (Current, SEL_COMMAND, Id_uncheck, Void)
         end
         Result := True
      end

   on_cmd_dock_bottom (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         dock_inner(Layout_side_bottom);
         Result := True;
      end

   on_upd_dock_bottom(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         if is_docked and then (options & Layout_side_mask) = Layout_side_bottom then
            sender.do_handle_2 (Current, SEL_COMMAND, Id_check, Void)
         else
            sender.do_handle_2 (Current, SEL_COMMAND, Id_uncheck, Void)
         end
         Result := True
      end

   on_cmd_dock_left (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         dock_inner (Layout_side_left)
         Result := True
      end

   on_upd_dock_left (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         if is_docked and then (options & Layout_side_mask) = Layout_side_left then
            sender.do_handle_2 (Current, SEL_COMMAND, Id_check, Void)
         else
            sender.do_handle_2 (Current, SEL_COMMAND, Id_uncheck, Void)
         end
         Result := True
      end

   on_cmd_dock_right (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         dock_inner (Layout_side_right)
         Result := True
      end

   on_upd_dock_right (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         if is_docked and then (options & Layout_side_mask) = Layout_side_right then
            sender.do_handle_2 (Current, SEL_COMMAND, Id_check, Void)
         else
            sender.do_handle_2 (Current, SEL_COMMAND, Id_uncheck, Void)
         end
         Result := True
      end

   on_begin_drag_grip (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         event: SB_EVENT
         x,y: INTEGER
         dc: SB_DC_WINDOW
         pt: SB_POINT
      do
         event ?= data
         check
            event /= Void
         end
         dc := paint_dc
         dc.make (get_root)
         pt := translate_coordinates_to (get_root, 0, 0)
         outline.set_x (pt.x)
         outline.set_y (pt.y)
         outline.set_w (width)
         outline.set_h (height)
         dock_after := prev
         dock_side := (options & Layout_side_mask)
         docking := is_docked
         dc.clip_children (False)
         dc.set_function (dc.Blt_src_xor_dst)
         dc.set_foreground (sbrgb (255, 255, 255))
         dc.set_line_width (3)
         dc.draw_rectangle (outline.x, outline.y, outline.w, outline.h)
         application.flush
         dc.stop
         Result := True
      end

   on_end_drag_grip (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         grip: SB_TOOL_BAR_GRIP
         event: SB_EVENT
         x,y: INTEGER
         dc: SB_DC_WINDOW
      do
         event ?= data
         grip ?= sender
         check
            event /= Void
            grip /= Void
         end
         dc := paint_dc
         dc.make (get_root)
         dc.clip_children (False)
         dc.set_function (dc.Blt_src_xor_dst)
         dc.set_foreground (sbrgb (255, 255, 255))
         dc.set_line_width (3)
         dc.draw_rectangle (outline.x, outline.y, outline.w, outline.h);
         application.flush
         if docking then
            dock (dock_side, dock_after)
         else
            undock;
            x := event.root_x - event.click_x - grip.x_pos
            y := event.root_y - event.click_y - grip.y_pos
            wet_dock.move (x, y)
         end
         Result := True
      end

	on_dragged_grip (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
		local
			grip: SB_TOOL_BAR_GRIP
			event: SB_EVENT
			left, right, top, bottom, x, y: INTEGER
			child, after, harbor: SB_WINDOW
			 newoutline: SB_RECTANGLE
			 hints, opts: INTEGER
			 done: BOOLEAN
			 dc: SB_DC_WINDOW
			 pt: SB_POINT
		do
			event ?= data
			grip ?= sender
			check
				event /= Void
				grip /= Void
			end

				-- Current grip location
			x := event.root_x - event.click_x - grip.x_pos
			y := event.root_y - event.click_y - grip.y_pos

				-- Move the highlight
			newoutline.set_x (x)
			newoutline.set_y (y)
			newoutline.set_w (width)
			newoutline.set_h (height)

				-- Initialize
			if dry_dock /= Void and then wet_dock /= Void then
					-- We can float if not close enough to docking spot
				harbor := dry_dock
				dock_after := Void
				docking := False
			else
					-- If too far from docking spot, snap back to original location
				harbor := parent
				dock_side := (options & Layout_side_mask)
				dock_after := prev
				docking := True
			end

				-- Dry_Dock location in root coordinates
			pt := harbor.translate_coordinates_to (get_root, 0,0)

				-- Inner bounds
			left  :=  pt.x; right   :=  harbor.width  + pt.x
			top   :=  pt.y; bottom  :=  harbor.height + pt.y

				-- Find place where to dock
			after := Void
			child := harbor.first_child
			from
				done := False
			until
				done or else left >= right or else top >= bottom
			loop
					-- Determine docking side
				if top <= y and then y < bottom then
					if (x - left).abs < PROXIMITY then
						opts := options
						options := (options & (Layout_side_mask).bit_not) | Layout_side_left
						if (options & Layout_fix_height) /= 0 then
							newoutline.set_h (height)
						elseif (options & (Layout_fill_y | Layout_fill_x)) /= 0 then
							newoutline.set_h (bottom-top)
							newoutline.set_y (top)
						else
							newoutline.set_h (default_height)
						end
						if (options & Layout_fix_width) /= 0 then
							newoutline.set_w (width)
						else
							newoutline.set_w (width_for_height (newoutline.h))
						end
						options := opts
						newoutline.set_x (left)
						dock_side := Layout_side_left
						dock_after := after
						docking := True
					end
					if (x - right).abs < PROXIMITY then
						opts := options
						options := (options & (Layout_side_mask).bit_not) | Layout_side_right
						if (options & Layout_fix_height) /= 0 then
							newoutline.set_h (height)
						elseif (options & (Layout_fill_y | Layout_fill_x)) /= 0 then
							newoutline.set_h (bottom - top)
							newoutline.set_y (top)
						else
							newoutline.set_h (default_height)
						end
						if (options & Layout_fix_width) /= 0 then
							newoutline.set_w (width)
						else
							newoutline.set_w (width_for_height (newoutline.h))
						end
						options := opts
						newoutline.set_x (right - newoutline.w)
						dock_side := Layout_side_right
						dock_after := after
						docking := True
					end
				end
				if left <= x and then x < right then
					if (y - top).abs < PROXIMITY then
						opts := options
						options := (options & (Layout_side_mask).bit_not) | Layout_side_top
						if (options & Layout_fix_width) /= 0 then
							newoutline.set_w(width)
						elseif (options & (Layout_fill_x | Layout_fill_y)) /= 0 then
							newoutline.set_w (right-left)
							newoutline.set_x (left)
						else
							newoutline.set_w (default_width)
						end
						if (options & Layout_fix_height) /= 0 then
							newoutline.set_h (height)
						else
							newoutline.set_h (height_for_width (newoutline.w))
						end
						options := opts
						newoutline.set_y (top)
						dock_side := Layout_side_top
						dock_after := after
						docking := True
					end
					if (y - bottom).abs < PROXIMITY then
						opts := options
						options := (options & (Layout_side_mask).bit_not) | Layout_side_bottom
						if (options & Layout_fix_width) /= 0 then
							newoutline.set_w (width)
						elseif (options & (Layout_fill_x | Layout_fill_y)) /= 0 then
							newoutline.set_w (right-left)
							newoutline.set_x (left)
						else
							newoutline.set_w(default_width)
						end
						if (options & Layout_fix_height) /= 0 then
							newoutline.set_h (height)
						else
							newoutline.set_h (height_for_width (newoutline.w))
						end
						options := opts
						newoutline.set_y (bottom - newoutline.h)
						dock_side := Layout_side_bottom
						dock_after := after
						docking := True
					end
				end
				if child = Void then
					done := True
				else
						-- Get child hints
					hints := child.layout_hints
						-- Some final fully stretched child also marks the end
					if (hints & Layout_fill_x) /= 0 and then (hints & Layout_fill_y) /= 0 then
						done := True
					else
							-- Advance inward
						if child /= Current then
							if child.is_shown then
								if (hints & Layout_side_left) /= 0 then
										-- Vertical
									if (hints & Layout_right) = 0 or else (hints & Layout_center_x) = 0 then
			                     		if (hints & Layout_side_bottom) /= 0 then
											right := child.x_pos + pt.x
			                     		else
			                     			left := child.x_pos + child.width + pt.x
			                     		end
			                  		end
			               		else
			               				-- Horizontal
			                  		if  (hints & Layout_bottom) = 0 or else (hints & Layout_center_y) = 0 then
			                     		if (hints & Layout_side_bottom) /= 0 then
			                     			bottom := child.y_pos + pt.y
				                     	else
				                     		top := child.y_pos + child.height + pt.y
				                     	end
				                  	end
				               	end
							end
						end
			    	end
			   	end
				after := child
					-- Next one
				child := child.next
			end
				-- Did rectangle move?
			if  newoutline.x /= outline.x or else newoutline.y /= outline.y
				or else newoutline.w /= outline.w or else newoutline.h /= outline.h
			then
				dc := paint_dc
				dc.make (get_root)
				dc.clip_children (False)
				dc.set_function (dc.Blt_src_xor_dst)
				dc.set_foreground (sbrgb (255, 255, 255))
				dc.set_line_width (3)
				dc.draw_rectangle (outline.x, outline.y, outline.w, outline.h)
				outline := newoutline
				dc.draw_rectangle (outline.x, outline.y, outline.w, outline.h)
				dc.stop
				application.flush
			end
			Result := True
		end

feature -- Actions

   set_dry_dock (dry: SB_COMPOSITE)
         -- Set parent when docked.
         -- If it was docked, reparent under the new docking window.
      local
         child, after: SB_WINDOW
         hints: INTEGER
         done: BOOLEAN
      do
         if dry /= Void and then dry.is_attached and then parent = dry_dock then
            reparent (dry)
            child := dry.first_child
            after := Void
            from
            until
               child = Void
            loop
               hints := child.layout_hints
               if (hints & Layout_fill_x) /= 0  and then (hints & Layout_fill_y) /=0 then
                  done := True;
               else
                  after := child
                  child := child.next
               end
            end
            link_after (after)
         end
         dry_dock := dry
      end

   set_wet_dock(wet: SB_COMPOSITE)
         -- Set parent when floating.
         -- If it was undocked, then reparent under the new floating window.
      do
         if wet /= Void and then wet.is_attached and then parent = wet_dock then
            reparent (wet)
         end
         wet_dock := wet
      end

   dock(side: INTEGER;after: SB_WINDOW)
         -- Dock the bar against the given side, after some other widget.
         -- However, if after is Void it will be docked as the outermost bar.
      do
         set_docking_side (side)
         if dry_dock /= Void and then not is_docked then
            reparent (dry_dock)
            wet_dock.hide
         end
         link_after (after)
      end

   dock_inner(side: INTEGER)
         -- Dock the bar as the innermost bar just before the 
         -- work-area
      local
         child: SB_WINDOW
         hints: INTEGER
         done: BOOLEAN
         after: SB_WINDOW
      do
         set_docking_side (side)
         if dry_dock /= Void and then not is_docked then
            reparent (dry_dock)
            wet_dock.hide
         end
         after := Void
         child := parent.first_child
         from
         until
            done or child = Void
         loop
            hints := child.layout_hints
            if (hints & Layout_fill_x) /= 0 and then (hints & Layout_fill_y) /= 0
             then
               done := True
            else
               after := child
               child := child.next
            end
         end
         link_after (after)
      end

   undock
         -- Undock or float the bar.
         -- The initial position of the wet dock is a few pixels
         -- below and to the right of the original docked position.
      local
         pt: SB_POINT;
      do
         if wet_dock  /= Void and then is_docked then
            pt := translate_coordinates_to (get_root, 8, 8)
            reparent(wet_dock)
            wet_dock.position (pt.x, pt.y, wet_dock.default_width, wet_dock.default_height)
            wet_dock.show
         end
      end
   
   set_docking_side (side_: INTEGER)
         -- Set docking side
      local
         side: INTEGER
      do
         side := side_
         if (options & Layout_side_mask) /= side then
            if (side & Layout_side_left) /= 0 then
               	-- New orientation is vertical
               if  (options & Layout_side_left) = 0 then
                  	-- Was horizontal
                  if (options & Layout_right) /= 0 and then (options & Layout_center_x) /= 0 then
                     side := side | Layout_fix_y
                  elseif (options & Layout_right) /= 0 then
                     side := side | Layout_bottom
                  elseif (options & Layout_center_x) /= 0 then
                     side := side | Layout_center_y
                  end
                  if (options & Layout_fill_x) /= 0 then
                     side := side | Layout_fill_y
                  end
               else
                  	-- Was vertical already
                  side := side | (options & (Layout_bottom | Layout_center_y | Layout_fill_y))
               end
            else
               	-- New orientation is horizontal
               if (options & Layout_side_left) /= 0 then
                  -- Was vertical
                  if (options & Layout_bottom) /= 0 
                     and then (options & Layout_center_y) /= 0 
                   then
                     side := side | Layout_fix_x
                  elseif (options & Layout_bottom) /= 0 then
                     side := side | Layout_right
                  elseif (options & Layout_center_y) /= 0 then
                     side := side | Layout_center_x
                  end
                  if (options & Layout_fill_y) /= 0 then
                     side := side | Layout_fill_x
                  end
               else
                  side := side | (options & (Layout_right | Layout_center_x | Layout_fill_x));
               end
            end

            	-- Simply preserve these options
            side := side | (options & (Layout_fix_width | Layout_fix_height))
            	-- Update the layout
            set_layout_hints (side)
         end
      end

feature -- Destruction

   destruct
      do
         dry_dock := Void
         wet_dock := Void
         dock_after := Void
         Precursor
      end


feature {NONE}-- Implementation

	outline: SB_RECTANGLE	-- Outline is_shown while dragging
	dock_after: SB_WINDOW   -- Dock after Current window
	dock_side: INTEGER   -- Dock on Current side
	docking: BOOLEAN		-- Dock it

   layout
      local
         galleyleft, galleyright, galleytop, galleybottom, galleywidth, galleyheight: INTEGER
         tleft, tright, ttop, bleft, bright, bbottom: INTEGER
         ltop, lbottom, lleft, rtop, rbottom, rright: INTEGER
         x,y, w,h, mw,mh: INTEGER
         hints: INTEGER
         child: SB_WINDOW
         t: SB_TOOL_BAR_GRIP
      do
         -- Get maximum child size
         if (options & Pack_uniform_width) /= 0 then
            mw := max_child_width
         end
         if (options & Pack_uniform_height) /= 0 then
            mh := max_child_height
         end

         if (options & Layout_side_left) /= 0 then
            -- Vertical toolbar
            galleywidth := 0
            from
               child := first_child
            until
               child = Void
            loop
               if child.is_shown then
                  hints := child.layout_hints
                  t ?= child
                  if t /= Void then
                     w := child.default_width
                  elseif (hints & Layout_fix_width) /= 0 then
                     w := child.width
                  elseif (options & Pack_uniform_width) /= 0 then
                     w := mw;
                  else
                     w := child.default_width
                  end
                  if galleywidth < w then
                     galleywidth := w
                  end
               end
               child := child.next
            end
            galleyleft := border+pad_left
            galleyright := width-border-pad_right
            galleytop := border+pad_top
            galleybottom := height-border-pad_bottom

            tleft := galleyleft
            tright := galleyleft+galleywidth
            ttop := galleytop
            bright := galleyright
            bleft := galleyright-galleywidth
            bbottom := galleybottom
            from
               child := first_child
            until
               child = Void
            loop
               if child.is_shown then
                  hints := child.layout_hints
                  t ?= child
                  if t /= Void then
                     w := galleywidth
                     h := child.default_height
                  else
                     if (hints & Layout_fix_width) /= 0 then
                        w := child.width
                     elseif (options & Pack_uniform_width) /= 0 then
                        w := mw;
                     else
                        w := child.default_width
                     end
                     if (hints & Layout_fix_height) /= 0 then
                        h := child.height
                     elseif (options & Pack_uniform_height) /= 0 then
                        h := mh
                     else
                        h := child.default_height
                     end
                  end
                  if (hints & Layout_bottom) /= 0 then
                     if bbottom - h < galleytop and then bbottom /= galleybottom then
                        bright := bleft
                        bleft := bleft - galleywidth
                        bbottom := galleybottom
                     end
                     y := bbottom - h
                     bbottom := bbottom - (h + v_spacing);
                     x := bleft+(galleywidth - w) // 2
                  else
                     if ttop+h>galleybottom and then ttop /= galleytop then
                        tleft := tright
                        tright := tright + galleywidth
                        ttop := galleytop
                     end
                     y := ttop
                     ttop := ttop + (h+v_spacing)
                     x := tleft+(galleywidth-w)//2
                  end
                  child.position(x,y,w,h)
               end
               child := child.next
            end
         else
            -- Horizontal toolbar
            galleyheight := 0
            from
               child := first_child
            until
               child = Void
            loop
               if child.is_shown then
                  hints := child.layout_hints
                  t ?= child
                  if t /= Void then
                     h := child.default_height
                  elseif (hints & Layout_fix_height) /= 0 then
                     h := child.height
                  elseif (options & Pack_uniform_height) /= 0 then
                     h := mh;
                  else
                     h := child.default_height;
                  end
                  if galleyheight < h then
                     galleyheight := h;
                  end
               end
               child := child.next
            end
            galleyleft := border + pad_left
            galleyright := width - border - pad_right
            galleytop := border + pad_top
            galleybottom := height - border - pad_bottom
            ltop := galleytop
            lbottom := galleytop + galleyheight
            lleft := galleyleft
            rbottom := galleybottom
            rtop := galleybottom - galleyheight
            rright := galleyright
            from 
               child := first_child
            until
               child = Void
            loop
               if child.is_shown then
                  hints := child.layout_hints
                  t ?= child
                  if t /= Void then
                     w := child.default_width
                     h := galleyheight
                  else
                     if (hints & Layout_fix_width) /= 0 then
                        w := child.width
                     elseif (options & Pack_uniform_width) /= 0 then
                        w := mw
                     else
                        w := child.default_width
                     end
                     if (hints & Layout_fix_height) /= 0 then
                        h := child.height
                     elseif (options & Pack_uniform_height) /= 0 then
                        h := mh
                     else
                        h := child.default_height
                     end
                  end
                  if (hints & Layout_right) /= 0 then
                     if rright - w < galleyleft and then rright /= galleyright then
                        rbottom := rtop
                        rtop := rtop - galleyheight
                        rright := galleyright
                     end
                     x := rright - w
                     rright := rright - (w + h_spacing)
                     y := rtop + (galleyheight - h) // 2
                  else
                     if lleft + w > galleyright and then lleft /= galleyleft then
                        ltop := lbottom
                        lbottom := lbottom + galleyheight
                        lleft := galleyleft
                     end
                     x := lleft
                     lleft := lleft + (w + h_spacing)
                     y := ltop + (galleyheight - h) // 2
                  end
                  child.position (x,y, w,h)
               end
               child := child.next
            end
         end
         unset_flags (Flag_dirty)
      end

   -- How close to edge before considered docked
   PROXIMITY: INTEGER = 30
   FUDGE: INTEGER = 5

end
