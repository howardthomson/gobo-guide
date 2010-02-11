indexing

		description: "A child of the Root window"

	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

class SB_SHELL_DEF

inherit
   
	SB_COMPOSITE
		redefine
			create_resource,
         	kill_focus,
         	on_configure,
         	on_focus_next,
         	on_focus_prev,
         	on_key_press,
         	on_key_release,
         	recalc,
         	set_focus,
         	class_name
		end

	SB_SHELL_COMMANDS
	SB_EXPANDED

feature -- class name

	class_name: STRING is
		once
			Result := "SB_SHELL"
		end

feature {NONE} -- creation

   make_top (a: SB_APPLICATION; opts: INTEGER; x, y, w, h : INTEGER) is
         -- Create a toplevel window
      do
         make_shell (a, Void, opts, x,y,w,h)
      end

   make_child (own: SB_WINDOW; opts: INTEGER; x, y, w, h : INTEGER) is
      do
         make_shell (own.application, own, opts, x,y,w,h)
      end

feature -- resource creation/deletion

	create_resource is
		local
			w, h: INTEGER
		do
				-- Create this widget and all of its children
			Precursor
				-- Adjust size if necessary
			if 1 < width then 
				w := width
			else 
				w := default_width
			end
			if 1 < height then
				h := height
			else
				h := default_height
			end
				-- Resize this widget
			resize (w, h)
		end

feature -- focus &c

   recalc is
      do
         application.set_refresher_window (Current) -- As long as layout cleanup is done with GUI update
         application.refresh
         set_flags (Flag_dirty)
      end

   set_focus is
      do
         set_flags (Flag_focused)
      end

   kill_focus is
      do
         if focus_child /= Void then
            focus_child.kill_focus
         end
         unset_flags (Flag_focused)
         set_flags (Flag_update)
      end

feature {ANY} -- Message handlers

	on_configure (sender: SB_MESSAGE_HANDLER; selector : INTEGER; data: ANY): BOOLEAN is
		local
			ev: SB_EVENT
			t: BOOLEAN
		do
			ev ?= data
			t := Precursor (sender, selector, data)
			x_pos := ev.rect_x
			y_pos := ev.rect_y

			if ev /= Void and then (ev.rect_w /= width or ev.rect_h /= height) then
					-- Record new size
				width := ev.rect_w
				height := ev.rect_h
				layout
			--	recalc -- FIXME This causes trouble on MSWindows
			end
			Result := True     
		end

	on_key_press (sender: SB_MESSAGE_HANDLER; selector : INTEGER; data: ANY): BOOLEAN is
		local
			ev: SB_EVENT
			def: SB_WINDOW
		do
				-- Try to handle normally
			if Precursor (sender, selector, data) then
				Result := True
			else
            		--  If not handled yet, try the default button
				ev ?= data
            	if ev /= Void and then (ev.code = sbk.key_return or else ev.code = sbk.key_kp_enter) then
               			-- Find default widget
               		def := find_default (Current)
               			-- Handle default key
               		if def /= Void and then def.handle_2 (sender, SEL_KEYPRESS, selector, data) then
                  		Result := True
               		end
            	end
         	end
      	end

   on_key_release (sender: SB_MESSAGE_HANDLER; selector : INTEGER; data: ANY): BOOLEAN is
      local
         ev: SB_EVENT
         def: SB_WINDOW
      do
         -- Try to handle normally
         if Precursor (sender,selector,data) then
            Result := True
         else
            --  If not handled yet, try the default button
            ev ?= data
            if ev /= Void and then (ev.code = sbk.key_return or else ev.code = sbk.key_kp_enter) then
               -- Find default widget
               def := find_default (Current)
               -- Handle default key
               if def /= Void and then def.handle_2 (sender, SEL_KEYRELEASE, selector, data) then
                  Result := True
               end;
            end
         end
      end

   on_focus_next(sender: SB_MESSAGE_HANDLER; selector : INTEGER; data: ANY): BOOLEAN is
      local
         c: SB_WINDOW
      do
         if focus_child /= Void then            
            from
               c := focus_child.next
            until
               c = Void or Result
            loop
               if c.is_enabled and then  c.can_focus then
                  c.do_handle_2 (Current, SEL_FOCUS_SELF, 0, data)
                  Result := True
               elseif c.is_composite
                  and then c.handle_2 (Current, SEL_FOCUS_NEXT, selector, data) then
                  Result := True
               end
               c := c.next
            end
            if not Result then
               focus_child.kill_focus
            end
         end
         if not Result then
            from
               c := first_child
            until
               c = Void or Result
            loop
               if c.is_enabled and then  c.can_focus then
                  c.do_handle_2 (Current, SEL_FOCUS_SELF, 0, data);
                  Result := True;
               elseif c.is_composite
                  and then c.handle_2 (Current, SEL_FOCUS_NEXT, selector, data) then
                  Result := True
               end
               c := c.next
            end
         end
      end

   on_focus_prev(sender: SB_MESSAGE_HANDLER; selector : INTEGER; data: ANY): BOOLEAN is
      local
         c: SB_WINDOW
      do
         if focus_child /= Void then            
            from
               c := focus_child.prev
            until
               c = Void or Result
            loop
               if c.is_enabled and then c.can_focus then
                  c.do_handle_2 (Current, SEL_FOCUS_SELF, 0, data)
                  Result := True
               elseif c.is_composite
                  and then c.handle_2 (Current, SEL_FOCUS_PREV, selector, data) then
                  Result := True
               end
               c := c.prev;
            end
            if not Result then
               focus_child.kill_focus
            end
         end
         if not Result then
            from
               c := last_child
            until
               c = Void or Result
            loop
               if c.is_enabled and then  c.can_focus then
                  c.do_handle_2 (Current, SEL_FOCUS_SELF, 0, data)
                  Result := True
               elseif c.is_composite
                  and then c.handle_2 (Current, SEL_FOCUS_PREV, selector, data) then
                  Result := True
               end
               c := c.prev
            end
         end
      end

end
