note

		description: "Tree item"

	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

	todo: "[
		Expand/contract full-depth headings-only/headings+items
		Distinquish between Closed/Show-sub-headings/Open
		Add set-of icons and icon-actions/states

		Try: SB_TREE_LIST ==> SB_GENERIC_TREE_LIST [ SB_TREE_LIST_ITEM ]

		Fix default_width, default_height re is_multi_line property

	]"

class SB_TREE_LIST_ITEM

inherit

	SB_ITEM
		rename
			make	 as base_make,
			icon	 as open_icon,
         	set_icon as set_open_icon
      	redefine
         	create_resource,
         	detach_resource
      	end

create

	make_empty, make

feature -- Creation

	make (text: STRING; oi,ci: SB_ICON; dt: ANY)
		do
			base_make (text, oi, dt)
			closed_icon := ci
			if text.has ('%N') then
				set_multi_line (True)
			end
		end

feature -- Data

	closed_icon: SB_ICON

	prev,
	next,
	parent,
	first_child,
	last_child
		: like Current

feature -- Queries

	below_item: like Current
  			-- Item immediately below on screen
		local
        	item: like Current
      	do
         	item := Current;
         	if first_child /= Void then
            	Result := first_child
         	else
            	from
            	until
               		item.next /= Void or else item.parent = Void
            	loop
               		item := item.parent
            	end
            	Result := item.next
         	end
      	end

  	above_item: like Current
      	local
         	item: like Current
      	do
         	item := prev;
         	if item = Void then
            	Result := parent;
         	else
            	from
            	until
               		item.last_child = Void
            	loop
               		item := item.last_child
            	end
            	Result := item
         	end
      	end

   children_count: INTEGER
      local
         item: SB_TREE_LIST_ITEM
      do
         from
            item := first_child
         until
            item = Void
         loop
            item := item.next
            Result := Result + 1
         end
      end

   is_leaf: BOOLEAN
         -- Return True if node is a leaf-item, i.e. has no children
      do
         Result := first_child = Void;
      end

	width (list: SB_GENERIC_TREE_LIST [ SB_TREE_LIST_ITEM ]): INTEGER
		local
			w, oiw, ciw: INTEGER
		do
			if open_icon /= Void then oiw := open_icon.width end
			if closed_icon /= Void then ciw := closed_icon.width end
			w := oiw.max (ciw)
			if not label.is_empty then
				if w /= 0 then w := w + ICON_SPACING end
				if is_multi_line then
					w := w + 4 + multi_line_width (list.font, label)
				else
					w := w + 4 + list.font.get_text_width (label)
				end
			end
			Result := SIDE_SPACING + w
		end

	height (list: SB_GENERIC_TREE_LIST [ SB_TREE_LIST_ITEM ]): INTEGER
		local
			th,		-- Text height
			oih,	-- Open icon height
			cih		-- Closed icon height
         		: INTEGER
		do
			if open_icon /= Void then
				oih := open_icon.height
			end
			if closed_icon /= Void then
				cih := closed_icon.height
			end
			if not label.is_empty then
				if is_multi_line then
					th := 4 + multi_line_height (list.font, label)
				else
					th := 4 + list.font.get_font_height
				end
			end
			Result := th.max (oih.max (cih))
		end

	is_opened: BOOLEAN
		do
			Result := (state & OPENED) /= 0
		end

	is_expanded: BOOLEAN
		do
			Result := (state & EXPANDED_MASK) /= 0
		end

   has_items: BOOLEAN
      do
         Result := (state & HASITEMS) /= 0
            or else first_child /= Void
      end

	is_multi_line: BOOLEAN
		do
			Result := (state & Multi_line) /= 0
		end

feature -- setter routines (modified)

	set_first_child (i: like Current)
		do
			first_child := i
		end

	set_last_child (i: like Current)
		do
			last_child := i
		end

	set_prev (i: like Current)
		do
			prev := i
		end

	set_next (i: like Current)
		do
			next := i;
		end

	set_parent (i: like Current)
		do
			parent := i;
		end


feature -- Resource management

   create_resource
      do
         Precursor
         if closed_icon /= Void then
         	closed_icon.create_resource
         end
      end

   detach_resource
      do
         Precursor
         if closed_icon /= Void then
         	closed_icon.detach_resource
         end
      end

feature {SB_GENERIC_TREE_LIST}

   draw (list: SB_GENERIC_TREE_LIST [ SB_TREE_LIST_ITEM ]; dc: SB_DC; x_, y_, w, h: INTEGER)
      local
         ih,th,tw: INTEGER
         xx,yy: INTEGER
         font: SB_FONT
         icon: SB_ICON
      do
         xx := x_;
         yy := y_;
         font := list.font;
         if (state & OPENED) /= 0 then
            icon := open_icon
         else
            icon := closed_icon;
         end
         if icon /= Void then ih := icon.height end
     --    if not label.is_empty then th := 4 + list.font.get_font_height end
         xx := xx + SIDE_SPACING // 2
         if icon /= Void then
            dc.draw_icon(icon, xx, yy + (h - ih) // 2)
            xx := xx + ICON_SPACING + icon.width
         end
         xx := xx + draw_other_icons (list, dc, xx,yy, w,h)
         if not label.is_empty then
         	if not is_multi_line then
         		th := 4 + list.font.get_font_height
            	tw := 4 + font.get_text_width(label)
            --	yy := yy + (h - th) // 2
            else
            	th := 4 + multi_line_height(font, label)
            	tw := 4 + multi_line_width(font, label)
            --	yy := yy + 
            end
           	yy := yy + (h - th) // 2;
            if is_selected then
               dc.set_foreground (list.sel_back_color)
               dc.fill_rectangle (xx, yy, tw, th)
               if not is_enabled then
                  dc.set_foreground (u.make_shadow_color (list.back_color))
               else
                  dc.set_foreground (list.sel_text_color)
               end
            else
               if not is_enabled then
                  dc.set_foreground (u.make_shadow_color(list.back_color));
               else
                  dc.set_foreground (list.text_color);
               end
            end
            if not is_multi_line then
            	dc.draw_text (xx + 2, yy + font.get_font_ascent + 2, label)
			else
				draw_multi_line_text (dc, font, xx + 2, yy + font.get_font_ascent + 2, label)
			end
            if has_focus then
               dc.draw_focus_rectangle (xx+1, yy+1, tw-2, th-2);
            end
         end
      end

	multi_line_width (a_font: SB_FONT; s: STRING): INTEGER
		local
			c: CHARACTER	-- Current character in string
			i: INTEGER		-- Index through string
			tw: INTEGER		-- Tab width
			
			w, wd, wmax: INTEGER	-- width, width_delta, width_max
		--	j: INTEGER			-- left/right index for line
			nb: INTEGER				-- string count
			si, sj: INTEGER			-- left/right tab index
		do
			tw := a_font.get_text_width (once "wwww")
			from
				nb := s.count
				i := 1
				w := 0
				si := 1
			until
				i > nb
			loop
				c := s.item(i)
				if c = '%N' or c = '%T' then
					sj := i - 1
					if sj >= si then
						wd := a_font.get_text_width_offset (s, si, sj-si+1)
						w := w + wd
					end
					if c = '%T' then
						w := w + tw
					elseif c = '%N' then
						if w > wmax then wmax := w end
						w := 0
					end
					si := i + 1
				end
				i := i + 1
			end
			if si <= nb then
				wd := a_font.get_text_width_offset (s, si, nb-si+1)
				w := w + wd
				if w > wmax then wmax := w end
			end
			Result := wmax
		end

	multi_line_height (a_font: SB_FONT; s: STRING): INTEGER
		do
			Result := a_font.get_font_height * (1 + s.occurrences('%N'))
		end

	draw_multi_line_text (dc: SB_DC; a_font: SB_FONT; a_x, a_y: INTEGER; s: STRING)
		--	dc.draw_text(a_x, a_y, s)
		local
			c: CHARACTER	-- Current character in string
			i: INTEGER		-- Index through string
			tw: INTEGER		-- Tab width
			fh: INTEGER		-- font height
			yy: INTEGER
			w, wd: INTEGER	-- width, width_delta, width_max
		--	j: INTEGER			-- left/right index for line
			nb: INTEGER				-- string count
			si, sj: INTEGER			-- left/right tab index
		do
			tw := a_font.get_text_width (once "wwww")
			fh := a_font.get_font_height
			yy := a_y
			from
				nb := s.count
				i := 1
				w := 0
				si := 1
			until
				i > nb
			loop
				c := s.item (i)
				if c = '%N' or c = '%T' then
					sj := i - 1
					if sj >= si then
						dc.draw_text_offset (a_x + w, yy, s, si, sj-si+1)
						wd := a_font.get_text_width_offset (s, si, sj-si+1)
						w := w + wd
					end
					if c = '%T' then
						w := w + tw
					elseif c = '%N' then
						w := 0
						yy := yy + fh
					end
					si := i + 1
				end
				i := i + 1
			end
			if si <= nb then
				dc.draw_text_offset(a_x + w, yy, s, si, nb-si+1)
			end
		end


	draw_other_icons (list: SB_GENERIC_TREE_LIST [ SB_TREE_LIST_ITEM ]; dc: SB_DC; x_, y_, w, h: INTEGER): INTEGER
		do
			Result := 0
		end

   item_hit (list: SB_GENERIC_TREE_LIST [ SB_TREE_LIST_ITEM ]; x_, y_: INTEGER): INTEGER
         -- Return item hit code: 0 no hit; 1 hit the icon; 2 hit the text
      local
         oiw, oih,	-- open icon width/height
         ciw, cih,	-- closed icon width/height
         tw,th,		-- text width height
         iw,ih,		-- icon width/height
         ix,iy,		-- icon position
         tx,ty,		-- text position
         h			-- height
         	: INTEGER
         font: SB_FONT
      do
         font := list.font
         if open_icon /= Void then
            oiw := open_icon.width
            oih := open_icon.height
         end
         if closed_icon /= Void then
            ciw := closed_icon.width
            cih := closed_icon.height
         end
         if not label.is_empty then
            tw := 4 + font.get_text_width (label)
            th := 4 + font.get_font_height
         end
         iw := oiw.max (ciw)
         ih := oih.max (cih)
         h := th.max (ih)
         ix := SIDE_SPACING // 2
         tx := SIDE_SPACING // 2
         if iw /= 0 then tx := tx + iw + ICON_SPACING end
         iy := (h - ih) // 2
         ty := (h - th) // 2

         if ix <= x_ and then iy <= y_ and then x_ < ix + iw and then y_ < iy + ih then
            -- In icon ?
            Result := 1
         elseif tx <= x_ and then ty <= y_ and then x_ < tx + tw and then y_ < ty + th then
            -- In text ?
            Result := 2
         end
      end

feature -- Actions

   	set_closed_icon (a_icon: SB_ICON)
      	do
         	closed_icon := a_icon
      	end

   	set_opened (a_opened: BOOLEAN)
      	do
         	if a_opened then
            	state := state | OPENED
         	else
            	state := state & (OPENED).bit_not
         	end
      	end

   	set_expanded (a_expanded: BOOLEAN)
      	do
         	if a_expanded then
            	state := state | EXPANDED_MASK
         	else
            	state := state & (EXPANDED_MASK).bit_not
         	end
      	end

	set_has_items (a_hasitems: BOOLEAN)
      	do
         	if a_hasitems then
            	state := state | HASITEMS
         	else
            	state := state & (HASITEMS).bit_not
         	end
      	end

	set_multi_line (a_multi_line: BOOLEAN)
      	do
         	if a_multi_line then
            	state := state | Multi_line
         	else
            	state := state & (Multi_line).bit_not
         	end
      	end

feature {NONE} -- Implementation

   	OPENED		 : INTEGER = 0x00000020
   	EXPANDED_MASK: INTEGER = 0x00000040
   	HASITEMS	 : INTEGER = 0x00000080
	Multi_line	 : INTEGER = 0x00000100	-- Is Multi Line [Has newline chars]

   	ICON_SPACING  : INTEGER = 4         -- Spacing between icon and label
   	SIDE_SPACING  : INTEGER = 6         -- Left or right spacing between items
   	LINE_SPACING  : INTEGER = 4         -- Line spacing between items
   	DEFAULT_INDENT: INTEGER = 8         -- Indent between parent and child

feature { SB_GENERIC_TREE_LIST }

   	x, y: INTEGER;

   	set_x (a_x: INTEGER)
      	do
         	x := a_x
      	end

	set_y (a_y: INTEGER)
      	do
         	y := a_y
      	end
end
