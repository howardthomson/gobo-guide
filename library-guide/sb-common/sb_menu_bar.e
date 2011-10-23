indexing
	description:"Menu bar"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

class SB_MENU_BAR

inherit

	SB_TOOL_BAR
      	redefine
         	make,
         	make_float,
         	make_opts,
         	contains,
         	handle_2,
         	on_enter,
         	on_leave,
         	on_focus_left,
         	on_focus_right,
         	on_motion,
         	class_name
      	end

create

   	make,
   	make_opts,
   	make_ev

feature -- class name

	class_name: STRING is
		once
			Result := "SB_MENU_BAR"
		end

feature -- Creation

   	make (p: SB_COMPOSITE; opts: INTEGER) is
         	-- Construct a non-floatable menubar.
         	-- The menubar can not be undocked.
      	do
        	make_opts (p, Void, opts | Layout_top | Layout_left | Layout_fill_x,
                   0,0,0,0, 3,3,2,2, DEFAULT_SPACING, DEFAULT_SPACING)
      	end

   make_float (p,q: SB_COMPOSITE; opts: INTEGER) is
         -- Construct a floatable menubar
         -- Normally, the menubar is docked under window p.
         -- When floated, the menubar can be docked under window q, which is
         -- typically a Shell window (?).
      do
         make_opts (p,q, opts | Layout_top | Layout_left | Layout_fill_x,
                   0, 0,0,0, 3,3,2,2, DEFAULT_SPACING, DEFAULT_SPACING)
      end

   make_opts (p,q: SB_COMPOSITE; opts: INTEGER; x, y, w, h, pl, pr, pt, pb, hs, vs: INTEGER) is
      do
         Precursor (p,q, opts, x,y,w,h, pl,pr,pt,pb, hs,vs)
         flags := flags | Flag_enabled
         drag_cursor := application.get_default_cursor (Def_rarrow_cursor)
      end

feature -- Queries

   contains (parentx, parenty: INTEGER): BOOLEAN is
         -- Return true if popup contains this point
      local
         pt: SB_POINT
      do
         if Precursor (parentx, parenty) then
            Result := True
         else
            if focus_child /= Void then
               pt := parent.translate_coordinates_to (Current, parentx, parenty)
               if focus_child.contains (pt.x, pt.y) then
                  Result := True
               end
            end
         end
      end

feature -- Message processing

   handle_2 (sender: SB_MESSAGE_HANDLER; type, key: INTEGER; data: ANY): BOOLEAN is
      do
         if     match_function_2 (SEL_ENTER,              0, type, key) then Result := on_enter         (sender, key, data)
         elseif match_function_2 (SEL_LEFTBUTTONPRESS,    0, type, key) then Result := on_button_press  (sender, key, data)
         elseif match_function_2 (SEL_LEFTBUTTONRELEASE,  0, type, key) then Result := on_button_release(sender, key, data)
         elseif match_function_2 (SEL_MIDDLEBUTTONPRESS,  0, type, key) then Result := on_button_press  (sender, key, data)
         elseif match_function_2 (SEL_MIDDLEBUTTONRELEASE,0, type, key) then Result := on_button_release(sender, key, data)
         elseif match_function_2 (Sel_rightbuttonpress,   0, type, key) then Result := on_button_press  (sender, key, data)
         elseif match_function_2 (Sel_rightbuttonrelease, 0, type, key) then Result := on_button_release(sender, key, data)
         elseif match_function_2 (SEL_FOCUS_NEXT,         0, type, key) then Result := on_default       (sender, key, data)
         elseif match_function_2 (SEL_FOCUS_PREV,         0, type, key) then Result := on_default       (sender, key, data)
         elseif match_function_2 (SEL_FOCUS_UP,           0, type, key) then Result := on_default       (sender, key, data)
         elseif match_function_2 (SEL_FOCUS_DOWN,         0, type, key) then Result := on_default       (sender, key, data)
         elseif match_function_2 (SEL_COMMAND,            Id_unpost, type, key) then Result := on_cmd_unpost (sender, key, data)
         else Result := Precursor (sender, type, key, data)
         end
      end

   on_focus_left (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      local
         child: SB_WINDOW
      do
         if focus_child /= Void then
            from
               child := focus_child.prev
            until
               child = Void
            loop
               if child.is_enabled and then child.can_focus then
                  child.do_handle_2 (Current, SEL_FOCUS_SELF, 0, data);
                  Result := True
               end
               child := child.prev
            end
            if not Result then
               from
                  child := last_child
               until
                  child = Void
               loop
                  if child.is_enabled and then child.can_focus then
                     child.do_handle_2 (Current, SEL_FOCUS_SELF, 0, data)
                     Result := True
                  end
                  child := child.prev
               end
            end
         end
      end

   on_focus_right (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      local
         child: SB_WINDOW
      do
         if focus_child /= Void then
            from
               child := focus_child.next
            until
               child = Void
            loop
               if child.is_enabled and then child.can_focus then
                  child.do_handle_2 (Current, SEL_FOCUS_SELF, 0, data)
                  Result := True
               end
               child := child.next
            end
            if not Result then
               from
                  child := first_child
               until
                  child = Void
               loop
                  if child.is_enabled and then child.can_focus then
                     child.do_handle_2 (Current, SEL_FOCUS_SELF, 0, data);
                     Result := True
                  end
                  child := child.next
               end
            end
         end
      end

   on_enter (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      local
         ev: SB_EVENT
         pt: SB_POINT
      do
         ev ?= data
         check
            ev /= Void
         end
         Result := Precursor (sender, selector, data)
         if  focus_child /= Void and then focus_child.is_active then
            if ev.code = CROSSINGNORMAL then
               pt := translate_coordinates_to (parent, ev.win_x, ev.win_y)
               if contains (pt.x, pt.y) and then is_mouse_grabbed then
                  release_mouse
               end
            end
         end
         Result := True
      end

   on_leave (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      local
         ev: SB_EVENT
         pt: SB_POINT
      do
         ev ?= data
         check
            ev /= Void
         end
         Result := Precursor (sender, selector, data)
         if focus_child /= Void and then focus_child.is_active then
            if ev.code = CROSSINGNORMAL then
               pt := translate_coordinates_to (parent, ev.win_x, ev.win_y)
               if  not contains (pt.x, pt.y) and then not is_mouse_grabbed then
                  grab_mouse
               end
            end
         end
      end

	on_motion (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
		local
			ev: SB_EVENT
			pt: SB_POINT
		do
			ev ?= data
			check ev /= Void end
			if focus_child /= Void and then focus_child.is_active then
				pt := translate_coordinates_to (parent, ev.win_x, ev.win_y)
				if contains (pt.x, pt.y) then
					if is_mouse_grabbed then
						release_mouse
					end
				else
					if not is_mouse_grabbed then
						grab_mouse
					end
				end
			end
			Result := False
		end

	on_button_press (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
		do
			do_handle_2 (Current, SEL_COMMAND, Id_unpost, Void)
			Result := True
		end

	on_button_release (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
		local
			ev: SB_EVENT
		do
			ev ?= data
			check ev /= Void end
			if ev.moved then
				do_handle_2 (Current, SEL_COMMAND, Id_unpost, Void)
			end
			Result := True
		end

	on_cmd_unpost (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
		do
			if focus_child /= Void then
				focus_child.kill_focus
			end
			Result := True
		end

end
