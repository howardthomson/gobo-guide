note
	description: "[
		The tab bar layout manager arranges tab items side by side,
		and raises the active tab item above the neighboring tab items.
		The tab bar can be have the tab items on the top or bottom for 
		horizontal arrangement, or on the left or right for vertical arrangement.
	]"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

class SB_TAB_BAR

inherit
	SB_PACKER
      	rename
         	Id_last as PACKER_ID_LAST,
         	make as packer_make,
         	make_opts as packer_make_opts
      	redefine
         	default_width,
         	default_height,
         	handle_2,
         	on_paint,
         	on_focus_up,
         	on_focus_down,
         	on_focus_prev,
         	on_focus_next,
         	on_focus_left,
         	on_focus_right,
         	layout,
         	class_name
      	end

   SB_TAB_BAR_CONSTANTS

   SB_TAB_BAR_COMMANDS

create

   make, make_opts

feature -- class name

	class_name: STRING
		once
			Result := "SB_TAB_BAR"
		end

feature -- Creation

	make (p: SB_COMPOSITE; opts: INTEGER)
			-- Construct a tab bar
		do
         	make_opts(p, Void,0, opts, 0,0,0,0,
         			DEFAULT_SPACING, DEFAULT_SPACING, DEFAULT_SPACING, DEFAULT_SPACING);
      	end

   make_opts (p: SB_COMPOSITE; tgt: SB_MESSAGE_HANDLER; sel: INTEGER; opts: INTEGER;
              x,y,w,h, pl,pr,pt,pb: INTEGER)
         -- Construct a tab bar
      do
         packer_make_opts(p, opts, x,y,w,h, pl,pr,pt,pb, 0,0)
         flags := flags | Flag_enabled
         message_target := tgt
         message := sel
         top_child := 0
      end

feature -- Data

   top_child: INTEGER

feature -- Queries

   get_tab_style: INTEGER
         -- Return tab bar style
      do
         Result := options & TABBOOK_MASK
      end

   default_width: INTEGER
         -- Return default width
      local
         w,wtabs, wmaxtab, t, ntabs: INTEGER
         hints: INTEGER
         child: SB_WINDOW
      do
         if (options & TABBOOK_SIDEWAYS) /= Zero then
            wtabs := 0
            from
               child := first_child
            until
               child = Void
            loop
               if child.is_shown then
                  hints := child.layout_hints
                  if (hints & Layout_fix_width) /= Zero then
                     t := child.width
                  else
                     t := child.default_width
                  end
                  if t > wtabs then
                     wtabs := t
                  end
               end
               child := child.next
            end
            w := wtabs
         else
            wtabs := 0
            wmaxtab := 0
            ntabs := 0
            from
               child := first_child
            until
               child = Void
            loop
               if child.is_shown then
                  hints := child.layout_hints
                  if (hints & Layout_fix_width) /= Zero then
                     t := child.width
                  else
                     t := child.default_width
                  end
                  if t > wmaxtab then
                     wmaxtab := t
                  end
                  wtabs := wtabs + t
                  ntabs := ntabs + 1
               end
               child := child.next
            end
            if (options & Pack_uniform_width) /= Zero then
               wtabs := ntabs * wmaxtab
            end
            w := wtabs + 5
         end
         Result := w + pad_left + pad_right + (border * 2)
      end

   default_height: INTEGER
         -- Return default height
      local
         h, htabs, hmaxtab, t, ntabs: INTEGER
         hints: INTEGER
         child: SB_WINDOW
      do
         if (options & TABBOOK_SIDEWAYS) /= Zero then
            htabs := 0
            hmaxtab := 0
            ntabs := 0
            from
               child := first_child
            until
               child = Void
            loop
               if child.is_shown then
                  hints := child.layout_hints
                  if (hints & Layout_fix_height) /= Zero then
                     t := child.height
                  else
                     t := child.default_height
                  end
                  if t > hmaxtab then
                     hmaxtab := t
                  end
                  htabs := htabs + t
                  ntabs := ntabs + 1
               end
               child := child.next
            end
            if (options & Pack_uniform_height) /= Zero then
               htabs := ntabs * hmaxtab
            end
            h := htabs+5
         else
            htabs := 0
            from
               child := first_child
            until
               child = Void
            loop
               if child.is_shown then
                  hints := child.layout_hints
                  if (hints & Layout_fix_height) /= Zero then
                     t := child.height
                  else
                     t := child.default_height
                  end
                  if t > htabs then
                     htabs := t
                  end
               end
               child := child.next
            end
            h := htabs
         end
         Result := h + pad_top + pad_bottom + (border * 2)
      end

feature -- Actions

   set_tab_style(style: INTEGER)
         -- Change tab tab style
      local
         opts: INTEGER;
      do
        opts := new_options (style, TABBOOK_MASK)
         if options /= opts then
            options := opts
            recalc
            update
         end
      end

	set_top_child(panel: INTEGER; notify: BOOLEAN)
			-- Change currently active tab item;
			-- this raises the active tab item slightly above the neighboring
			-- tab items.
		do
			if 0 <= panel  and then top_child /= panel then
				top_child := panel
				if notify and then message_target /= Void then
--## non-conforming argument: top_child: INTEGER !
					message_target.do_handle_2 (Current, SEL_COMMAND, message, ref_integer (top_child))
				end
				recalc
				update
			end
		end

feature -- Message processing

	handle_2 (sender: SB_MESSAGE_HANDLER; type, key: INTEGER; data: ANY): BOOLEAN
    	do
        	if		match_function_2 (SEL_COMMAND,ID_OPEN_ITEM, type, key) then Result := on_cmd_open_item (sender, key, data)
        	elseif 	match_function_2 (SEL_COMMAND,Id_setvalue,  type, key) then Result := on_cmd_set_value (sender, key, data)
        	elseif 	match_function_2 (SEL_COMMAND,Id_getvalue,  type, key) then Result := on_cmd_get_value (sender, key, data)
        	elseif 	match_functions_2 (SEL_UPDATE, ID_OPEN_FIRST, ID_OPEN_LAST, type, key) then
            	Result := on_upd_open (sender, key, data)
         	elseif 	match_functions_2 (SEL_COMMAND, ID_OPEN_FIRST, ID_OPEN_LAST, type, key) then
            	Result := on_cmd_open (sender, key, data)
         	else Result := Precursor(sender, type, key, data) end
      	end

   on_paint (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         ev: SB_EVENT
         dc: SB_DC_WINDOW
      do
         ev ?= data
         if ev /= Void then
         	dc := paint_dc
            dc.make_event (Current,ev)
            dc.set_foreground (back_color)
            dc.fill_rectangle (ev.rect_x, ev.rect_y, ev.rect_w, ev.rect_h)
            draw_frame (dc, 0, 0, width, height)
            dc.stop
         end
         Result := True;
      end

   on_focus_next (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
         -- Focus moved to next visible tab
      local
         child: SB_WINDOW
      do
         child := focus_child
         if child /= Void then
            child := child.next
         else
            child := first_child
         end
         from
         until
            child = Void or else child.is_shown
         loop
            child := child.next
         end
         if child /= Void then
            set_top_child (index_of_child (child), True)
            child.do_handle_2 (Current, SEL_FOCUS_SELF, 0, data)
            Result := True
         end
      end

   on_focus_prev (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
         -- Focus moved to previous visible tab
      local
         child: SB_WINDOW
      do
         child := focus_child
         if child /= Void then
            child := child.prev
         else
            child := last_child
         end
         from
         until
            child = Void or else child.is_shown
         loop
            child := child.prev
         end
         if child /= Void then
            set_top_child (index_of_child (child), True)
            child.do_handle_2 (Current, SEL_FOCUS_SELF, 0, data)
            Result := True
         end
      end

   on_focus_up (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         if (options & TABBOOK_SIDEWAYS) /= Zero then
            Result :=  handle_2 (Current, SEL_FOCUS_PREV, 0, data)
         end
      end

   on_focus_down (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         if (options & TABBOOK_SIDEWAYS) /= Zero then
            Result :=  handle_2 (Current, SEL_FOCUS_NEXT, 0, data)
         end
      end

   on_focus_left (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         if (options & TABBOOK_SIDEWAYS) = Zero then
            Result :=  handle_2 (Current, SEL_FOCUS_PREV, 0, data)
         end
      end

   on_focus_right (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         if (options & TABBOOK_SIDEWAYS) = Zero then
            Result :=  handle_2 (Current, SEL_FOCUS_NEXT, 0, data)
         end
      end

   on_cmd_open_item (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
         -- The sender of the message is the item to open up
      local
         child: SB_WINDOW
      do
         child ?= sender
         if child /= Void then
            set_top_child (index_of_child (child), True)
         end
         Result := True
      end

   on_cmd_set_value (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
         -- Update value from a message
      local
		val: INTEGER_REF;
      do
         val ?= data
         if val /= Void then
            set_top_child (val.item, False)
         end
         Result := True
      end

   on_cmd_get_value (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
         -- Obtain value
      local
		val: INTEGER_REF
      do
         val ?= data
         if val /= Void then
            val.set_item (top_child)
         end
         Result := True
      end

   on_cmd_open (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
         -- Open item
      do
         set_top_child (selid (selector) - ID_OPEN_FIRST, True)
         Result := True    
      end

   on_upd_open (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
         -- Update the nth button
      local
         msg: INTEGER;
      do
         if selid(selector) - ID_OPEN_FIRST = top_child then 
            msg := Id_check
         else
            msg := Id_uncheck
         end
         sender.do_handle_2 (Current, SEL_COMMAND, msg, Void)
         Result := True
      end

feature {NONE} -- Implementation

   layout
      local
         i, x, y, w, h, wmaxtab, hmaxtab, newcurrent: INTEGER
         raisetab, tab: SB_WINDOW
         hints: INTEGER
      do
         newcurrent := -1;

         -- Measure tabs again
         wmaxtab := 0
         hmaxtab := 0
         from
            tab := first_child
            i := 0
         until
            tab = Void
         loop
            if tab.is_shown then
               hints := tab.layout_hints
               if (hints & Layout_fix_width) /= Zero then
                  w := tab.width
               else
                  w := tab.default_width;
               end
               if (hints & Layout_fix_height) /= Zero then
                  h := tab.height
               else
                  h := tab.default_height;
               end
               if w > wmaxtab then
                  wmaxtab := w
               end
               if h > hmaxtab then
                  hmaxtab := h
               end
               if newcurrent < 0 or else  i <= top_child then
                  newcurrent := i
               end
            end
            tab := tab.next
            i := i + 1
         end

         -- Changes current only if old current no longer visible
         top_child := newcurrent;

         if (options & TABBOOK_SIDEWAYS) /= Zero then
            -- Tabs on left or right
            -- Placements for tab items and tab panels
            y := border + pad_top
            if (options & TABBOOK_BOTTOMTABS) /= Zero then
               -- Right tabs
               x := width - pad_right - border - wmaxtab
            else
               x := border + pad_left
            end

            -- Place all of the children
            from
               i := 0
               tab := first_child
            until
               tab = Void
            loop
               if tab.is_shown then
                  hints := tab.layout_hints
                  if (hints & Layout_fix_height) /= Zero then
                     h := tab.height
                  elseif (options & Pack_uniform_height) /= Zero then
                     h := hmaxtab
                  else
                     h := tab.default_height
                  end
                  if top_child = i then
                     if (options & TABBOOK_BOTTOMTABS) /= Zero then
                        -- Right tabs
                        tab.position (x - 2, y, wmaxtab + 2, h + 3)
                     else
                        tab.position (x, y, wmaxtab + 2, h + 3)
                     end
                     tab.update_rectangle (0, 0, wmaxtab + 2, h + 3)
                     raisetab := tab
                  else
                     if (options & TABBOOK_BOTTOMTABS) /= Zero then
                        -- Right tabs
                        tab.position (x - 2, y + 2, wmaxtab, h)
                     else
                        tab.position (x + 2, y + 2, wmaxtab, h)
                     end
                     tab.update_rectangle (0, 0, wmaxtab, h)
                  end
                  y := y + h
               end
               tab := tab.next
               i := i + 1
            end
         else
            -- Tabs on top or bottom
            -- Placements for tab items and tab panels
            x := border + pad_left
            if (options & TABBOOK_BOTTOMTABS) /= Zero then
               -- Bottom tabs
               y := height - pad_bottom - border - hmaxtab     
            else
               y := border + pad_top
            end

            -- Place all of the children
            from
               i := 0
               tab := first_child
            until
               tab = Void
            loop
               if tab.is_shown then
                  hints := tab.layout_hints
                  if (hints & Layout_fix_width) /= Zero then
                     w := tab.width
                  elseif (options & Pack_uniform_width) /= Zero then
                     w := wmaxtab
                  else
                     w := tab.default_width
                  end
                  if top_child = i then
                     if (options & TABBOOK_BOTTOMTABS) /= Zero then
                        -- Bottom tabs
                        tab.position (x, y - 2, w + 3, hmaxtab + 2)
                     else
                        tab.position (x, y, w + 3, hmaxtab + 2)
                     end
                     tab.update_rectangle (0, 0, w + 3, hmaxtab + 2)
                     raisetab := tab
                  else
                     if (options & TABBOOK_BOTTOMTABS) /= Zero then
                        -- Bottom tabs
                        tab.position (x + 2, y - 2, w, hmaxtab)
                     else
                        tab.position (x + 2, y + 2, w, hmaxtab)
                     end
                     tab.update_rectangle (0, 0, w, hmaxtab)
                  end
                  x := x + w
               end
               tab := tab.next
               i := i + 1
            end
         end
         if raisetab /= Void then
            raisetab.raise
         end
         unset_flags (Flag_dirty)
      end
end
