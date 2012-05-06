note
	description:"Base composite"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

deferred class SB_COMPOSITE

inherit
	SB_WINDOW
		redefine
			handle_2,
			layout,
			on_cmd_update,
			on_key_press,
			on_key_release,
			create_resource,
			detach_resource,
			destroy_resource,
			default_width,
			default_height,
			is_composite,
			destruct
		end

	SB_COMPOSITE_COMMANDS

	SB_KEYS
	
feature -- resource creation/deletion

   	create_resource
         	-- Create server-side resources
      	local
         	c : SB_WINDOW
      	do
         	Precursor
         	from
            	c := first_child
         	until
            	c = Void
         	loop
--print ("Creating resources (in SB_COMPOSITE ["); print (($Current).out); print ("]) for: ")
--print (c.generating_type); print (" ["); print (($c).out); print ("]%N")
            	c.create_resource
            	c := c.next
         	end
--print ("Done creating resources in SB_COMPOSITE%N")
      	end

   	detach_resource
         	-- Detach server-side resources
      	local
         	c : SB_WINDOW
      	do
         	from
            	c := first_child
         	until
            	c = Void
         	loop
            	c.detach_resource
            	c := c.next
         	end
         	Precursor
      	end

	destroy_resource
    		-- Destroy server-side resources
      	local
         	c : SB_WINDOW
      	do
         	from
            	c := first_child
         	until
            	c = Void
         	loop
            	c.destroy_resource
            	c := c.next
         	end
         	Precursor
      	end

feature -- Event handlers

	on_key_press (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
		local
			event: SB_EVENT
      	do
         		-- Bounce to focus widget
         	if focus_child /= Void and then focus_child.handle_2 (sender, SEL_KEYPRESS, selector,data) then
            	Result := True
         	elseif is_enabled and then message_target /= Void -- Try target first
            and then message_target.handle_2 (Current, SEL_KEYPRESS, message, data) then
            	Result := True
         	elseif accel_table /= Void and then accel_table.handle_2 (Current, SEL_KEYPRESS, selector, data) then
            	Result := True
         	else
            		-- Otherwise, perform the default keyboard processing
            	event ?= data
            	if event /= Void then
               		inspect event.code
               		when key_next then
                	  	Result := handle_2 (Current, SEL_FOCUS_NEXT, 0, data)
               		when key_prior, key_iso_left_tab then
                	  	Result := handle_2 (Current, SEL_FOCUS_PREV, 0, data)
               		when key_up, key_kp_up then
                	  	Result := handle_2 (Current, SEL_FOCUS_UP, 0, data)
               		when key_down, key_kp_down then
                	  	Result := handle_2 (Current, SEL_FOCUS_DOWN, 0, data)
               		when key_left, key_kp_left then
                	  	Result := handle_2 (Current, SEL_FOCUS_LEFT, 0, data)
               		when key_right, key_kp_right then
                	  	Result := handle_2 (Current, SEL_FOCUS_RIGHT, 0, data)
               		when key_tab then
                	  	if (event.state & SHIFTMASK) = SHIFTMASK then
                	     	Result := handle_2 (Current, SEL_FOCUS_PREV, 0, data)
                	  	else
                	     	Result := handle_2 (Current, SEL_FOCUS_NEXT, 0, data)
                		end
               		else
                	  	Result := False;
            		end
				end
			end
		end

	on_key_release (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
    	do
         	-- Bounce to focus widget
         	if (focus_child /= Void and then focus_child.handle_2 (sender, SEL_KEYRELEASE, selector, data))
            or else (is_enabled and then message_target /= Void 
                     and then message_target.handle_2 (Current, SEL_KEYRELEASE, message, data))
            	or else (accel_table /= Void and then accel_table.handle_2 (Current, SEL_KEYRELEASE, selector, data))
          	then 
            	Result := True
         	end
      	end

   on_focus_next (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         c: SB_WINDOW;
      do
         update
         from
            if focus_child /= Void then
               c := focus_child.next
            else
               c := first_child
            end
         until
            c = Void or Result
         loop
            if c.is_shown then
               if c.is_enabled and c.can_focus then
                  c.do_handle_2 (Current, SEL_FOCUS_SELF, 0, data)
                  Result := True
               elseif c.is_composite
                  and then c.handle_2 (Current, SEL_FOCUS_NEXT, selector, data) then
                  Result := True
               end
            end
            c := c.next
         end
      end

   on_focus_prev (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         c: SB_WINDOW
      do
         from
            if focus_child /= Void then
               c := focus_child.prev
            else
               c := last_child
            end
         until
            c = Void or Result
         loop
            if c.is_shown then
               if c.is_enabled and c.can_focus then
                  c.do_handle_2 (Current, SEL_FOCUS_SELF, 0, data);
                  Result := True
               elseif c.is_composite
                  and then c.handle_2 (Current, SEL_FOCUS_PREV, selector, data) then
                  Result := True
               end
            end
            c := c.prev
         end
      end

   on_cmd_update (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         c : SB_WINDOW
         temp : INTEGER
      do
         update
         from
            c := first_child
         until
            c = Void
         loop
            if c.is_shown then
               c.do_handle_2 (sender, SEL_COMMAND, Id_update, data);
            end
            c := c.next
         end
         Result := True
      end

feature -- Queries

   default_width: INTEGER
         -- Return default width
      local
         c: SB_WINDOW
         t: INTEGER
      do
         from
            c := first_child
         until
            c = Void
         loop
            if c.is_shown then
               t := c.x_pos + c.width
               if Result < t then
                  Result := t
               end
            end
            c := c.next
         end
      end

   default_height: INTEGER
         -- Return default height
      local
         c : SB_WINDOW
         t : INTEGER
      do
         from
            c := first_child
         until
            c = Void
         loop
            if c.is_shown then
               t := c.y_pos + c.height
               if Result < t then
                  Result := t
               end
            end
            c := c.next
         end
      end

   max_child_width: INTEGER
      local
         c: SB_WINDOW
         hints: INTEGER
         t: INTEGER
      do
         from
            c := first_child
         until
            c = Void
         loop
            if c.is_shown then
               hints := c.layout_hints
               if (hints & Layout_fix_width) = Layout_fix_width then
                  t := c.width
               else
                  t := c.default_width
               end
               if Result < t then
                  Result := t
               end
            end
            c := c.next
         end
      end

   max_child_height: INTEGER
      local
         c: SB_WINDOW
         hints: INTEGER
         t: INTEGER
      do
         from
            c := first_child
         until
            c = Void
         loop
            if c.is_shown then
               hints := c.layout_hints
               if (hints & Layout_fix_height) = Layout_fix_height then
                  t := c.height
               else
                  t := c.default_height
               end
               if Result < t then
                  Result := t
               end
            end
            c := c.next
         end
      end

   is_composite : BOOLEAN = True

feature -- Message processing

	handle_2 (sender: SB_MESSAGE_HANDLER; type, key: INTEGER; data: ANY): BOOLEAN
      	do
         	if		match_function_2	(SEL_FOCUS_NEXT, 0, type, key) then Result := on_focus_next (sender, key, data)
         	elseif  match_function_2	(SEL_FOCUS_PREV, 0, type, key) then Result := on_focus_prev (sender, key, data)
         	elseif  match_function_2 	(SEL_FOCUS_UP,	 0, type, key) then Result := on_focus_prev (sender, key, data)
         	elseif  match_function_2	(SEL_FOCUS_DOWN, 0, type, key) then Result := on_focus_next (sender, key, data)
         	elseif  match_function_2	(SEL_FOCUS_LEFT, 0, type, key) then Result := on_focus_prev (sender, key, data)
         	elseif  match_function_2	(SEL_FOCUS_RIGHT,0, type, key) then Result := on_focus_next (sender, key, data)
         	else Result := Precursor(sender, type, key, data)
         	end
      	end

feature -- Destruction

	destruct
    	do
         	from
         	until
            	first_child = Void
         	loop
            	first_child.destruct
         	end
         	Precursor
      	end

feature { NONE } -- Implementation


	layout
    		-- Just tell server where the windows are!
    	local
         	c : SB_WINDOW
      	do
         	from
            	c := first_child
         	until
            	c = Void
         	loop
            	if c.is_shown then
               		c.position (c.x_pos, c.y_pos, c.width, c.height)
            	end
            	c := c.next
         	end
         	unset_flags (Flag_dirty)
      	end

end
