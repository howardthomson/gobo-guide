indexing
	description: "[
		Vertical frame layout manager widget is used to
		automatically place child-windows vertically from top-to-bottom,
		or bottom-to-top, depending on the child window's layout hints.
   	]"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

class SB_VERTICAL_FRAME

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
			Result := "SB_VERTICAL_FRAME"
		end

feature -- Queries

   default_width: INTEGER is
         -- Return default width
      local
         w, wmax, mw: INTEGER
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
                  w := child.x_pos + w
               end
               if wmax < w then
                  wmax := w
               end
            end
            child := child.next
         end
         Result := pad_left + pad_right + wmax + (border * 2)
      end

   default_height: INTEGER is
         -- Return default height
      local
         h, hcum, hmax, numc, mh: INTEGER
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
               else
                  hcum := hcum + h
                  numc := numc +1
               end
               if hmax < h then
                  hmax := h
               end
            end
            child := child.next
         end
         if numc > 1 then
            hcum := hcum + (numc - 1) * v_spacing
         end
         if hmax < hcum then
            hmax := hcum
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
			remain := bottom - top

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
					if (hints & Layout_bottom) = Zero
						or else (hints & Layout_center_y) = Zero
					then
							-- Layout_fix_y
						if (hints & Layout_fix_height) /= Zero then
							h := child.height
						elseif (options & Pack_uniform_width) /= Zero then
							h := mh
						else
							h := child.default_height
						end
						check
							h >= 0
						end
						if (hints & Layout_center_y) /= Zero
						or else ((hints & Layout_fill_y) /= Zero and then (hints & Layout_fix_height) = Zero)
						then
							sumexpand := sumexpand + h
							numexpand := numexpand + 1
						else
							remain := remain - h
						end
						numc := numc + 1
					end
				end
				child := child.next
			end

				-- Child spacing
			if numc > 1 then
				remain := remain - v_spacing * (numc - 1)
			end
				-- Do the layout
			from
				child := first_child
			until
				child = Void
			loop
				if child.is_shown then
					hints := child.layout_hints

						-- Determine child width
					if (hints & Layout_fix_width) /= Zero then
						w := child.width
					elseif (options & Pack_uniform_width) /= Zero then
						w := mw
					elseif (hints & Layout_fill_x) /= Zero then
						w := right - left
					else
						w := child.default_width
					end

						-- Determine child x-position
					if (hints & Layout_right) /= Zero and then (hints & Layout_center_x) /= Zero then
						x := child.x_pos
					elseif (hints & Layout_center_x) /= Zero then
						x := left + (right - left - w) // 2
					elseif (hints & Layout_right) /= Zero then
						x := right - w
					else
						x := left
					end

						-- Layout child in Y
					y := child.y_pos
					if (hints & Layout_fix_height) /= Zero then
						h := child.height
					elseif (options & Pack_uniform_width) /= Zero then
						h := mh
					else
						h := child.default_height
					end
					if (hints & Layout_bottom) = Zero or else (hints & Layout_center_y) = Zero then
							-- Layout_fix_y
						extra_space := 0
						total_space := 0
						if (hints & Layout_fill_y) /= Zero and then (hints & Layout_fix_height) = Zero then
							if sumexpand > 0 then
									-- Divide space proportionally to width
								t := h * remain
								h := t // sumexpand
								e := e+t \\ sumexpand
								if e >= sumexpand then
									h := h + 1
									e := e - sumexpand
								end
							else
									-- Divide the space equally
								check
									numexpand > 0
								end
								h := remain // numexpand
								e := e + remain \\ numexpand
								if e >= numexpand then
									h := h + 1
									e := e - numexpand
								end
							end
						elseif (hints & Layout_center_y) /= Zero then
							if sumexpand > 0 then
									-- Divide space proportionally to width
								t := h * remain
								total_space := t // sumexpand - h
								e := e + t \\ sumexpand
								if e >= sumexpand then
									total_space := total_space + 1
									e := e - sumexpand
								end
							else
									-- Divide the space equally
								check
									numexpand > 0
								end
								total_space := remain // numexpand - h
								e := e + remain \\ numexpand
								if e >= numexpand then
									total_space := total_space + 1
									e := e - numexpand
								end
							end
							extra_space := total_space // 2
						end
						if (hints & Layout_bottom) /= Zero then
							y := bottom - h - extra_space
							bottom := bottom - h - v_spacing - total_space
						else
							y := top + extra_space
							top := top + h + v_spacing + total_space
						end
					end
					child.position (x, y, w, h)
				end
				child := child.next
			end
			unset_flags (Flag_dirty)
		end
end
