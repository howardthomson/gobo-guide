indexing
	description: "[
		The tab book layout manager arranges pairs of children;
		the even numbered children (0,2,4,...) are usually tab items,
		and are placed on the top.  The odd numbered children are
		usually layout managers, and are placed below; all the odd
		numbered children are placed on top of each other, similar
		to the switcher widget.  When the user presses one of the
		tab items, the tab item is raised above the neighboring tabs,
		and the corresponding panel is raised to the top.
		Thus, a tab book can be used to present many GUI controls
		in a small space by placing several panels on top of each
		other and using tab items to select the desired panel.
	]"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

class SB_TAB_BOOK

inherit

	SB_TAB_BAR
      	redefine
         	default_height,
         	default_width,
         	handle_2,
         	on_paint,
         	on_focus_left,
         	on_focus_right,
         	on_focus_next,
         	on_focus_prev,
         	on_focus_up,
         	on_focus_down,
         	on_cmd_open_item,
         	layout,
         	class_name
      	end

creation

   make, make_opts

feature -- class name

	class_name: STRING is
		once
			Result := "SB_TAB_BOOK"
		end

feature -- Queries

	default_width: INTEGER is
    		-- Return default width
    	local
         	w, wtabs, wmaxtab, wpnls, t, ntabs: INTEGER
         	hints: INTEGER
         	tab, pane: SB_WINDOW
      	do
         	if (options & TABBOOK_SIDEWAYS) /= Zero then
            		-- Left or right tabs
            	from
               		tab := first_child
            	until
               		tab = Void or else tab.next = Void
            	loop
               		pane := tab.next
               		if tab.is_shown then
                  		hints := tab.layout_hints
                  		if (hints & Layout_fix_width) /= Zero then
							t := tab.width
				  		else
							t := tab.default_width
				  		end
                  		if t > wtabs then wtabs := t end
                  		t := pane.default_width
                  		if t > wpnls then wpnls := t end
               		end
               		tab := tab.next.next
            	end
            	w := wtabs + wpnls;
         	else
            		-- Top or bottom tabs
            	from
               		tab := first_child
            	until
               		tab = Void or else tab.next = Void
            	loop
               		pane := tab.next
               		if tab.is_shown then
                	  	hints := tab.layout_hints
                	  	if (hints & Layout_fix_width) /= Zero then t := tab.width else t := tab.default_width end
                	  	if t > wmaxtab then wmaxtab := t end
                	  	wtabs := wtabs + t
                	  	t := pane.default_width
                	  	if t > wpnls then wpnls := t end
                	  	ntabs := ntabs + 1
               		end
               		tab := tab.next.next
            	end
            	if (options & Pack_uniform_width) /= Zero then wtabs := ntabs * wmaxtab end
            	wtabs := wtabs + 5
            	w := wtabs.max (wpnls)
         	end
         	Result := w + pad_left + pad_right + (border * 2)
		end

  default_height: INTEGER is
         -- Return default height
      local
         h, htabs, hmaxtab, hpnls, t, ntabs: INTEGER
         hints: INTEGER
         tab, pane: SB_WINDOW
      do
         if (options & TABBOOK_SIDEWAYS) /= Zero then
            -- Left or right tabs
            from
               tab := first_child
            until
               tab = Void or else tab.next = Void
            loop
               pane := tab.next
               if tab.is_shown then
                  hints := tab.layout_hints
                  if (hints & Layout_fix_height) /= Zero then t := tab.height else t := tab.default_height end
                  if t > hmaxtab then hmaxtab := t end
                  htabs := htabs + t
                  t := pane.default_height
                  if t > hpnls then hpnls := t end
                  ntabs := ntabs + 1
               end
               tab := tab.next.next
            end
            if (options & Pack_uniform_height) /= Zero then htabs := ntabs*hmaxtab end
            htabs := htabs + 5
            h := htabs.max(hpnls)
         else
            -- Top or bottom tabs
            from
               tab := first_child
            until
               tab = Void or else tab.next = Void
            loop
               pane := tab.next
               if tab.is_shown then
                  hints := tab.layout_hints
                  if (hints & Layout_fix_height) /= Zero then t := tab.height else t := tab.default_height end
                  if t > htabs then htabs := t end
                  t := pane.default_height;
                  if t > hpnls then hpnls := t end
               end
               tab := tab.next.next
            end
            h := htabs + hpnls
         end
         Result := h + pad_top + pad_bottom + (border*2)
      end


feature -- Message processing

	handle_2 (sender: SB_MESSAGE_HANDLER; type, selector: INTEGER; data: ANY): BOOLEAN is
    	do
        	if		match_function_2 (SEL_FOCUS_NEXT,	0,			 type, selector) then Result := on_focus_next		(sender, selector, data);
         	elseif 	match_function_2 (SEL_FOCUS_PREV,	0,			 type, selector) then Result := on_focus_prev 		(sender, selector, data);
         	elseif 	match_function_2 (SEL_FOCUS_UP,		0,			 type, selector) then Result := on_focus_up			(sender, selector, data);
         	elseif 	match_function_2 (SEL_FOCUS_DOWN,	0,			 type, selector) then Result := on_focus_down 		(sender, selector, data);
         	elseif 	match_function_2 (SEL_FOCUS_LEFT,	0,			 type, selector) then Result := on_focus_left 		(sender, selector, data);
         	elseif 	match_function_2 (SEL_FOCUS_RIGHT,	0,			 type, selector) then Result := on_focus_right		(sender, selector, data);
         	elseif 	match_function_2 (SEL_COMMAND,		ID_OPEN_ITEM,type, selector) then Result := on_cmd_open_item	(sender, selector, data);
         	else
            	Result := Precursor(sender, type, selector, data)
         	end
      	end

   	on_paint (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      	local
         	ev: SB_EVENT;
         	dc: SB_DC_WINDOW;
      	do
         	ev ?= data;
         	check
            	ev /= Void
         	end
         	dc := paint_dc
         	dc.make_event (Current, ev)
         	dc.set_foreground (back_color)
         	dc.fill_rectangle (ev.rect_x, ev.rect_y, ev.rect_w, ev.rect_h)
         	draw_frame (dc, 0, 0, width, height)
         	dc.stop
         	Result := True
      	end

   	on_focus_next (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      	local
         	child: SB_WINDOW
         	which: INTEGER
      	do
         	child := focus_child
         	if child /= Void then
            	child := child.next
            	if child = Void then
               		Result := False
            	else
               		which := index_of_child (child)
               		if which \\ 2 = 1 then
                  		child := child.next
                  		which := which + 1
               		end
            	end
         	else
            	child := first_child
            	which := 0
         	end
         	from
         	until
            	child = Void or else child.next = Void
            	or else (child.is_shown and then child.is_enabled)
         	loop
            	child := child.next.next
            	which := which + 2
         	end
         	if child /= Void then
            	set_top_child (which // 2, True)
            	child.do_handle_2 (Current, SEL_FOCUS_SELF, 0, data)
            	Result := True
         	end
      	end

   on_focus_prev (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      local
         child: SB_WINDOW
         which: INTEGER
         done: BOOLEAN
      do
         child := focus_child
         if child /= Void then
            child := child.prev
            if child = Void then
               done := True
            else
               which := index_of_child (child)
            end
         else
            child := last_child
            if child = Void then
               done := True
            else
               which := index_of_child (child)
            end
         end
         if not done then
            if which \\ 2 = 1 then
               child := child.prev
            end
            from
            until
               child = Void or else child.prev = Void 
               or else (child.is_shown and then child.is_enabled)
            loop
               child := child.prev.prev
               which := which - 2
            end
            if child /= Void then
               set_top_child (which // 2, True)
               child.do_handle_2 (Current, SEL_FOCUS_SELF, 0, data)
               Result := True
            end
         end
      end

   on_focus_up (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      local
         child: SB_WINDOW
      do
         if (options & TABBOOK_SIDEWAYS) /= Zero then
            Result := handle_2 (Current, SEL_FOCUS_PREV, 0, data)
         else
            if focus_child /= Void then
               child := Void;
               if index_of_child (focus_child) \\ 2 = 1 then
                  -- We're on a panel
                  if (options & TABBOOK_BOTTOMTABS) = Zero then
                     child := focus_child.prev
                  end
               else
                  -- We're on a tab
                  if (options & TABBOOK_BOTTOMTABS) /= Zero then
                     child := focus_child.next;
                  end
               end
               if child /= Void and then
                  (child.handle_2 (Current, SEL_FOCUS_SELF, 0, data)
                   or else child.handle_2 (Current, SEL_FOCUS_UP, 0, data))
                then
                  Result := True;
               end
            end
         end
      end

   on_focus_down (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      local
         child: SB_WINDOW
      do
         if (options & TABBOOK_SIDEWAYS) /= Zero then
            Result := handle_2 (Current, SEL_FOCUS_NEXT, 0, data)
         else
            if focus_child /= Void then
               child := Void
               if index_of_child (focus_child) \\ 2 = 1 then
                  -- We're on a panel
                  if (options & TABBOOK_BOTTOMTABS) /= Zero then child := focus_child.prev end
               else
                  -- We're on a tab
                  if (options & TABBOOK_BOTTOMTABS) = Zero then child := focus_child.next end
               end
               if child /= Void and then
                  (child.handle_2 (Current, SEL_FOCUS_SELF, 0, data)
                   or else child.handle_2 (Current, SEL_FOCUS_DOWN, 0, data))
                then
                  Result := True;
               end
            end
         end
      end

   on_focus_left (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      local
         child: SB_WINDOW
      do
         if (options & TABBOOK_SIDEWAYS)= Zero then
            Result := handle_2 (Current, SEL_FOCUS_PREV, 0, data)
         else
            if focus_child /= Void then
               child := Void
               if index_of_child (focus_child)\\2 = 1 then
                  -- We're on a panel
                  if (options & TABBOOK_BOTTOMTABS) = Zero then child := focus_child.prev end
               else
                  -- We're on a tab
                  if (options & TABBOOK_BOTTOMTABS) /= Zero then child := focus_child.next end
               end
               if child /= Void and then
                  (child.handle_2 (Current, SEL_FOCUS_SELF, 0, data)
                   or else child.handle_2 (Current, SEL_FOCUS_LEFT, 0, data))
                then
                  Result := True
               end
            end
         end
      end

   on_focus_right (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      local
         child: SB_WINDOW;
      do
         if (options & TABBOOK_SIDEWAYS) = Zero then
            Result := handle_2 (Current, SEL_FOCUS_NEXT, 0, data);
         else
            if focus_child /= Void then
               child := Void
               if index_of_child (focus_child) \\ 2 = 1 then
                  -- We're on a panel
                  if (options & TABBOOK_BOTTOMTABS) = Zero then child := focus_child.prev end
               else
                  -- We're on a tab
                  if (options & TABBOOK_BOTTOMTABS) /= Zero then child := focus_child.next end
               end
               if child /= Void and then
                  (child.handle_2 (Current, SEL_FOCUS_SELF, 0, data)
                   or else child.handle_2 (Current, SEL_FOCUS_RIGHT, 0, data))
                then
                  Result := True
               end
            end
         end
      end

	on_cmd_open_item (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      	local
         	child: SB_WINDOW
      	do
         	child ?= sender
         	check
            	child /= Void
         	end
		--	fx_trace(0, <<"SB_TAB_BOOK::...open_item: index_of_child = ", index_of_child(child).out>>)
         	set_top_child (index_of_child(child) // 2, True)
         	Result := True
      	end

feature {NONE} -- Implementation

   layout is
      local
         i, x,y,w,h, px,py,pw,ph, wmaxtab,hmaxtab, newcurrent: INTEGER
         raisepane, raisetab, pane, tab: SB_WINDOW
         hints: INTEGER
      do

	--	fx_trace(0, <<"SB_TAB_BOOK::layout">>)

         newcurrent := -1
         -- Measure tabs again
         from
            tab := first_child
            i := 0
         until 
            tab = Void or else tab.next = Void
         loop
            pane := tab.next;
            if tab.is_shown then
               hints := tab.layout_hints
               if (hints & Layout_fix_width ) /= Zero then w := tab.width  else w := tab.default_width  end
               if (hints & Layout_fix_height) /= Zero then h := tab.height else h := tab.default_height end
               if w > wmaxtab then wmaxtab := w end
               if h > hmaxtab then hmaxtab := h end
               if newcurrent < 0 or else i <= top_child then newcurrent := i end
            end
            tab := tab.next.next
            i := i + 1
         end

         	-- This will change only if current now invisible
         top_child := newcurrent

         if (options & TABBOOK_SIDEWAYS) /= Zero then
            -- Left or right tabs
            -- Placements for tab items and tab panels
            y := border + pad_top
            py := y
            pw := width  - pad_left - pad_right  - (border*2) - wmaxtab
            ph := height - pad_top  - pad_bottom - (border*2)
            if (options & TABBOOK_BOTTOMTABS) /= Zero then
               -- Right tabs
               x := width - pad_right - border - wmaxtab
               px := border + pad_left
            else
               x := border + pad_left
               px := x + wmaxtab
            end

            -- Place all of the children
            from
               tab := first_child
               i := 0
            until
               tab = Void or else tab.next = Void
            loop

               pane := tab.next;
               if tab.is_shown then
                  hints := tab.layout_hints
                  if (hints & Layout_fix_height) /= Zero then h := tab.height
                  elseif (options & Pack_uniform_height) /= Zero then h := hmaxtab;
                  else h := tab.default_height end
                  pane.position (px,py, pw,ph)
                  if top_child = i then
                     if (options & TABBOOK_BOTTOMTABS) /= Zero then   -- Right tabs
                        tab.position (x - 2, y, wmaxtab + 2, h + 3)
                     else
                        tab.position (x, y, wmaxtab + 2, h + 3)
                     end
                     tab.update_rectangle (0, 0, wmaxtab + 2, h + 3)
                     pane.show
                     raisetab := tab
                     raisepane := pane
                  else
                     if (options & TABBOOK_BOTTOMTABS) /= Zero then     -- Right tabs
                        tab.position (x - 2, y + 2, wmaxtab, h)
                     else
                        tab.position (x + 2, y + 2, wmaxtab, h)
                     end
                     tab.update_rectangle (0, 0, wmaxtab, h)
                     pane.hide;
                  end
                  y := y + h
               else
                  pane.hide
               end
               tab := tab.next.next
               i := i + 1
            end

            -- Hide spurious last tab
            if tab /= Void then tab.resize (0,0) end

         else
            -- Top or bottom tabs
            -- Placements for tab items and tab panels
            x := border + pad_left
            px := x
            pw := width - pad_left - pad_right - (border * 2)
            ph := height - pad_top - pad_bottom - (border * 2) - hmaxtab
            if (options & TABBOOK_BOTTOMTABS) /= Zero then         -- Bottom tabs
               y := height - pad_bottom - border - hmaxtab
               py := border + pad_top
            else
               y := border + pad_top
               py := y + hmaxtab
            end

            -- Place all of the children
            from
               tab := first_child
               i := 0
            until
               tab = Void or else tab.next = Void
            loop
               pane := tab.next
               if tab.is_shown then
                  hints := tab.layout_hints
                  if (hints & Layout_fix_width) /= Zero then w := tab.width
                  elseif (options & Pack_uniform_width) /= Zero then w := wmaxtab
                  else w := tab.default_width end
                  pane.position (px, py, pw, ph)
                  if top_child = i then
                     if (options & TABBOOK_BOTTOMTABS) /= Zero then      -- Bottom tabs
                        tab.position (x, y - 2, w + 3, hmaxtab + 2)
                     else
                        tab.position (x, y, w + 3, hmaxtab + 2)
                     end
                     tab.update_rectangle (0, 0, w + 3, hmaxtab + 2)
                     pane.show
                     raisepane := pane
                     raisetab := tab
                  else
                     if (options & TABBOOK_BOTTOMTABS) /= Zero then      -- Bottom tabs
                        tab.position (x + 2, y - 2, w, hmaxtab)
                     else
                        tab.position (x + 2, y + 2, w, hmaxtab)
                     end
                     tab.update_rectangle (0, 0, w, hmaxtab)
                     pane.hide
                  end
                  x := x + w
               else
                  pane.hide
               end
               tab := tab.next.next
               i := i + 1
            end

            -- Hide spurious last tab
            if tab /= Void then tab.resize (0,0) end
         end

         -- Raise tab over panel and panel over all other tabs
         if raisepane /= Void then raisepane.raise end
         if raisetab /= Void then raisetab.raise end

         unset_flags (Flag_dirty)
      end

end
