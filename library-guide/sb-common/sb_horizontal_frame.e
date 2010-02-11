indexing
	description: "[
		Horizontal frame layout manager widget is used to
		automatically place child-windows horizontally from left-to-right,
		or right-to-left, depending on the child window's layout hints.
	]"

	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

class SB_HORIZONTAL_FRAME

inherit

	SB_PACKER
		redefine
        	default_width,
         	default_height,
         	layout,
         	class_name
      	end

creation

	make, make_sb, make_opts, make_ev

feature -- class name

	class_name: STRING is
		once
			Result := "SB_HORIZONTAL_FRAME"
		end

feature -- Queries

	default_width: INTEGER is
    		-- Return default width
      	local
         	w, wcum, wmax, numc, mw: INTEGER
         	child: SB_WINDOW
         	hints: INTEGER
      	do
         	if (options & Pack_uniform_width) /= Zero then
            	mw := max_child_width
         	end
         	from
            	child := first_child
         	until
            	child = Void
         	loop
            	if child.is_shown then
               		hints := child.layout_hints
               		if (hints & Layout_fix_width) /= Zero then
                  		w := child.width
               		elseif (options & Pack_uniform_width) /= Zero then
                  		w := mw
               		else
                  		w := child.default_width
               		end
               		if (hints & Layout_right) /= Zero 
                  		and then (hints & Layout_center_x) /= Zero 
                	then
                  			-- Layout_fix_x
                  		w := child.x_pos + w
               		else
                  		wcum := wcum + w
                  		numc := numc + 1
               		end
               		if wmax < w then
                  		wmax := w
               		end
            	end
            	child := child.next
         	end
         	if numc > 1 then
            	wcum := wcum + (numc - 1) * h_spacing
         	end
         	wmax := wmax.max (wcum)
         	Result := pad_left + pad_right + wmax + (border * 2)
		end

	default_height: INTEGER is
			-- Return default height
		local
         	h, hmax, mh: INTEGER
         	child: SB_WINDOW
         	hints: INTEGER
      	do
         	if (options & Pack_uniform_height) /= Zero then
            	mh := max_child_height
         	end
         	from        
            	child := first_child
         	until
            	child = Void
         	loop
            	if child.is_shown then
               		hints := child.layout_hints
               		if (hints & Layout_fix_height) /= Zero then
                  		h := child.height
               		elseif (options & Pack_uniform_height) /= Zero then
                  		h := mh
               		else
                  		h := child.default_height
               		end
               		if (hints & Layout_bottom) /= Zero
                  	and then (hints & Layout_center_y) /= Zero
                	then
                  			-- Layout_fix_y
                  		h := child.y_pos + h
               		end
               		if hmax < h then
                  		hmax := h
               		end
            	end
            	child := child.next
         	end
         	Result := pad_top + pad_bottom + hmax + (border * 2)
		end

feature {NONE} -- Implementation

   layout is
      local
         left, right, top, bottom, mw, mh,
         remain, extra_space, total_space, t,
         x, y, w, h, numc, sumexpand, numexpand, e: INTEGER
         hints: INTEGER
         child: SB_WINDOW
      do
         	-- Placement rectangle; right/bottom non-inclusive
         left := border + pad_left
         right := width - border - pad_right
         top := border + pad_top
         bottom := height - border - pad_bottom
         remain := right - left

         	-- Get maximum child size
         if (options & Pack_uniform_width) /= Zero then
            mw := max_child_width
         end
         if (options & Pack_uniform_height) /= Zero then
            mh := max_child_height
         end

         	-- Find number of paddable children and total width
         from
            child := first_child
         until 
            child = Void
         loop
            if child.is_shown then
               hints := child.layout_hints
               if (hints & Layout_right) = Zero 
                  or else (hints & Layout_center_x) = Zero
                then
                  	-- Layout_fix_x
                  if (hints & Layout_fix_width) /= Zero then
                     w := child.width
                  elseif (options & Pack_uniform_width) /= Zero then
                     w := mw;
                  else
                     w := child.default_width
                  end
                  --FXASSERT(w>=0);
                  if (hints & Layout_center_x) /= Zero
                     or else ((hints & Layout_fill_x) /= Zero and then (hints & Layout_fix_width) = Zero)
                   then
                     sumexpand := sumexpand + w
                     numexpand := numexpand + 1
                  else
                     remain := remain - w
                  end
                  numc := numc + 1
               end
            end
            child := child.next
         end

         	-- Child spacing
         if numc > 1 then
            remain := remain - h_spacing * (numc - 1)
         end
         	-- Do the layout
         from
            child := first_child
         until
            child = Void
         loop
            if child.is_shown then
               hints := child.layout_hints

               	-- Determine child height
               if (hints & Layout_fix_height) /= Zero then
                  h := child.height
               elseif (options & Pack_uniform_height) /= Zero then
                  h := mh
               elseif (hints & Layout_fill_y) /= Zero then
                  h := bottom-top
               else
                  h := child.default_height
               end

               	-- Determine child y-position
               if (hints & Layout_bottom) /= Zero and then (hints & Layout_center_y) /= Zero then
                  y := child.y_pos
               elseif (hints & Layout_center_y) /= Zero then
                  y := top+(bottom-top-h)//2
               elseif (hints & Layout_bottom) /= Zero then
                  y := bottom-h
               else
                  y := top
               end

               -- Layout child in X
               x := child.x_pos
               if (hints & Layout_fix_width) /= Zero then
                  w := child.width
               elseif (options & Pack_uniform_width) /= Zero then
                  w := mw
               else
                  w := child.default_width
               end
               if (hints & Layout_right) = Zero or else (hints & Layout_center_x) = Zero then
                  -- Layout_fix_x
                  extra_space := 0
                  total_space := 0
                  if (hints & Layout_fill_x) /= Zero and then (hints & Layout_fix_width) = Zero then
                     if sumexpand > 0 then
                        -- Divide space proportionally to width
                        t := w * remain
                        	check sumexpand > 0 end
                        w := t // sumexpand
                        e := e + t \\ sumexpand
                        if e >= sumexpand then 
                           w := w + 1
                           e := e - sumexpand
                        end
                     else
                        -- Divide the space equally
                        	check numexpand > 0 end
                        w := remain // numexpand
                        e := e + remain \\ numexpand
                        if e >= numexpand then
                           w := w + 1
                           e := e - numexpand
                        end
                     end
                  elseif (hints & Layout_center_x) /= Zero then
                     if sumexpand > 0 then
                        	-- Divide space proportionally to width
                        t := w * remain
                       		check sumexpand > 0 end
                        total_space := t // sumexpand - w
                        e := e + t \\ sumexpand
                        if e >= sumexpand then
                           total_space := total_space + 1
                           e := e-sumexpand
                        end
                     else
                        	-- Divide the space equally
                        check numexpand > 0 end
                        total_space := remain // numexpand - w
                        e := e + remain \\ numexpand
                        if e >= numexpand then
                           total_space := total_space + 1
                           e := e - numexpand
                        end
                     end
                     extra_space := total_space // 2
                  end
                  if (hints & Layout_right) /= Zero then
                     x := right - w - extra_space
                     right := right - w - h_spacing - total_space
                  else
                     x := left + extra_space
                     left := left + w + h_spacing + total_space
                  end
               end
               child.position(x,y,w,h)
            end
            child := child.next
         end
         unset_flags (Flag_dirty)
      end
end
