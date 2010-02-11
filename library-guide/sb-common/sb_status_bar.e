indexing
	description:"Status bar"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

class SB_STATUS_BAR

inherit

	SB_HORIZONTAL_FRAME
    	rename
        	make as frame_make
      	redefine
      		make_sb,
         	make_opts,
         	default_width,
         	default_height,
         	layout,
         	class_name
      	end

	SB_STATUS_BAR_CONSTANTS

creation

	make, make_sb, make_opts

feature -- class name

	class_name: STRING is
		once
			Result := "SB_STATUS_BAR"
		end

feature -- Creation

	make(p: SB_COMPOSITE) is
		do
			make_sb(p, 0)
		end

	make_sb(p: SB_COMPOSITE; opts: INTEGER) is
    	do
        	make_opts(p, opts, 0,0,0,0, 3,3,2,2, 4,0);
      	end

	make_opts(p: SB_COMPOSITE; opts: INTEGER; x, y, w, h, pl, pr, pt, pb, hs, vs: INTEGER) is
		do
			Precursor(p, opts,  x,y,w,h,  pl,pr,pt,pb,  hs,vs);
        	create drag_corner.make(Current);
        	create status_line.make(Current);
      	end

feature -- Data

	drag_corner: SB_DRAG_CORNER;
	status_line: SB_STATUS_LINE;

feature -- Queries

	default_width: INTEGER is
    		-- Return default width
      	local
			w, wcum, numc: INTEGER;
			child: SB_WINDOW;
			hints: INTEGER;
      	do
			from
            	child := drag_corner.next;
         	until
            	child = Void
         	loop
            	if child.is_shown then
               		hints := child.layout_hints;
               		if (hints & Layout_fix_width) /= Zero then
               			w := child.width;
               		else
               			w := child.default_width
               		end
               		wcum := wcum + w;
               		numc := numc + 1;
            	end
            	child := child.next
         	end
         	if numc > 1 then wcum := wcum + (numc - 1) * h_spacing end
         	if (options & STATUSBAR_WITH_DRAGCORNER) /= Zero  and then (numc > 1) then
            	wcum := wcum + drag_corner.default_width;
         	end
			Result := pad_left + pad_right + wcum + (border * 2);
		end

   default_height: INTEGER is
         -- Return default height
      local
         h, hmax: INTEGER;
         child: SB_WINDOW;
         hints: INTEGER;
      do

         from
            child := drag_corner.next;
         until
            child = Void
         loop
            if child.is_shown then
               hints := child.layout_hints;
               if (hints & Layout_fix_height) /= Zero then h := child.height;
               else h := child.default_height end
               if hmax < h then hmax := h end
            end
            child := child.next
         end
         h := pad_top + pad_bottom + hmax;
         if (options & STATUSBAR_WITH_DRAGCORNER) /= Zero 
            and then (h < drag_corner.default_height)
          then
            h := drag_corner.default_height;
         end
         Result := h + (border * 2);
      end

   get_corner_style: BOOLEAN is
         -- Return True if drag drag_corner is_shown
      do
         Result := (options & STATUSBAR_WITH_DRAGCORNER) /= Zero
      end

feature -- Actions

   set_corner_style (withcorner: BOOLEAN) is
         -- Show or hide the drag drag_corner
      local
         opts: INTEGER
      do
         if withcorner then
            opts := options | STATUSBAR_WITH_DRAGCORNER
         else
            opts := options & (STATUSBAR_WITH_DRAGCORNER).bit_not
         end
         if options /= opts then
            options := opts
            recalc
            update
         end
      end

feature {NONE} -- Implementation

   layout is
      local
         left,right,top,bottom: INTEGER
         remain,extra_space,total_space,t: INTEGER
         x,y,w,h,numc,sumexpand,numexpand,e: INTEGER
         hints: INTEGER
         child: SB_WINDOW
      do

         -- Placement rectangle; right/bottom non-inclusive
         left := border+pad_left
         right := width-border-pad_right
         top := border+pad_top
         bottom := height-border-pad_bottom
         remain := right-left

         -- Find number of paddable children and total width
         from
            child := drag_corner.next
         until
            child = Void
         loop
            if child.is_shown then
               hints := child.layout_hints
               if (hints & Layout_fix_width) /= Zero then w := child.width
               else w := child.default_width; end
               check
                  w >= 0
               end
               if (hints & Layout_center_x) /= Zero 
                  or else ((hints & Layout_fill_x) /= Zero and then (hints & Layout_fix_width) = Zero)
                then
                  sumexpand := sumexpand + w;
                  numexpand := numexpand + 1;
               else
                  remain := remain - w
               end
               numc := numc + 1
            end
            child := child.next
         end

         -- Child spacing
         if numc>1 then remain := remain - h_spacing*(numc-1) end

         -- Substract drag_corner width
         if (options & STATUSBAR_WITH_DRAGCORNER) /= Zero and then (numc>1) then
            right := right - drag_corner.default_width;
            remain := remain - drag_corner.default_width;
         end

         from
            child := drag_corner.next;
         until
            child = Void
         loop
            if child.is_shown then
               hints := child.layout_hints;

               -- Layout child in Y
               y := child.y_pos;
               if (hints & Layout_fix_height) /= Zero then h := child.height;
               else h := child.default_height; end
               extra_space := 0;
               if (hints & Layout_fill_y) /= Zero and then (hints & Layout_fix_height)=Zero then
                  h := bottom-top;
                  if h<0 then h := 0; end
               elseif (hints & Layout_center_y) /= Zero then
                  if h<(bottom-top) then extra_space := (bottom-top-h)//2 end
               end
               if (hints & Layout_bottom) /= Zero then
                  y := bottom-extra_space-h;
               else -- hints and Layout_top
                  y := top+extra_space;
               end

               -- Layout child in X
               x := child.x_pos;
               if (hints & Layout_fix_width) /= Zero then w := child.width
               else w := child.default_width end
               extra_space := 0;
               total_space := 0;
               if (hints & Layout_fill_x) /= Zero and then (hints & Layout_fix_width) = Zero then
                  if sumexpand > 0 then
                     t := w * remain;
                     check
                        sumexpand > 0
                     end
                     w := t // sumexpand;
                     e := e + t \\ sumexpand;
                     if e >= sumexpand then w := w + 1; e := e - sumexpand end
                  else
                     check
                        numexpand > 0
                     end
                     w := remain // numexpand;
                     e := e + remain \\ numexpand;
                     if e >= numexpand then w := w + 1; e := e - numexpand end
                  end
               elseif (hints & Layout_center_x) /= Zero then
                  if sumexpand > 0 then
                     t := w * remain;
                     check
                        sumexpand > 0
                     end
                     total_space := t // sumexpand - w;
                     e := e + t \\ sumexpand;
                     if e >= sumexpand then total_space := total_space + 1; e := e - sumexpand end
                  else
                     check 
                        numexpand>0
                     end
                     total_space := remain // numexpand - w;
                     e := e + remain \\ numexpand;
                     if e >= numexpand then total_space := total_space + 1; e := e - numexpand end
                  end
                  extra_space := total_space // 2;
               end
               if (hints & Layout_right) /= Zero then
                  x := right - w - extra_space;
                  right := right - w - h_spacing - total_space;
               else -- hints and Layout_left
                  x := left + extra_space;
                  left := left + w + h_spacing + total_space;
               end
               child.position(x,y,w,h);
            end
            child := child.next
         end

         -- Just make sure drag_corner grip's on top
         if (options & STATUSBAR_WITH_DRAGCORNER) /= Zero then
            if numc > 1 then
               drag_corner.position(width - border - drag_corner.default_width,
                               height - border - drag_corner.default_height,
                               drag_corner.default_width, drag_corner.default_height);
            else
               drag_corner.position(width - pad_right - border - drag_corner.default_width,
                               height - border - pad_bottom - drag_corner.default_height,
                               drag_corner.default_width, drag_corner.default_height);
            end
            drag_corner.show;
            drag_corner.raise;
         else
            drag_corner.hide;
         end
         unset_flags (Flag_dirty);
      end

end
