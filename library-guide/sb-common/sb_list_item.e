indexing
	description:"SB_LIST item"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

class SB_LIST_ITEM

inherit

	SB_ITEM

creation

	make_empty,
	make

feature -- Queries

	width(list: SB_LIST): INTEGER is
		local
         	w: INTEGER
      	do
         	if icon /= Void then w := icon.width end
         	if not label.is_empty then
            	if w /= 0 then  w := w + ICON_SPACING end
            	w := w + list.font.get_text_width(label);
         	end
         	Result := SIDE_SPACING + w;
      	end

   	height(list: SB_LIST): INTEGER is
      	local
         	th, ih: INTEGER;
      	do
         	if not label.is_empty then th := list.font.get_font_height end
         	if icon /= Void then ih := icon.height end
         	Result := LINE_SPACING + th.max(ih);
      	end

feature { SB_LIST }

   draw(list: SB_LIST; dc: SB_DC; x_, y_, w, h: INTEGER) is
      local
         ih: INTEGER -- Icon Height
         th: INTEGER -- text Height (?)
         xx,yy: INTEGER;
      do
         xx := x_;
         yy := y_;
         if icon /= Void then ih := icon.height end
         if not label.is_empty then th := list.font.get_font_height end
         if is_selected then
            dc.set_foreground(list.sel_back_color);
         else
            dc.set_foreground(list.back_color);
         end
         dc.fill_rectangle(xx, yy, w, h);
         if has_focus then
            dc.draw_focus_rectangle(xx+1, yy+1, w-2, h-2);
         end
         xx := xx + SIDE_SPACING // 2;
         if icon /= Void then
            dc.draw_icon(icon, xx, yy + (h-ih) // 2);
            xx := xx + ICON_SPACING + icon.width;
         end
         if not label.is_empty then
            dc.set_font(list.font);
            if not is_enabled then
               dc.set_foreground(u.make_shadow_color(list.back_color));
            elseif (state & SELECTED) /= Zero then
               dc.set_foreground(list.sel_text_color);
            else
               dc.set_foreground(list.text_color);
            end
            dc.draw_text(xx, yy + (h-th) // 2 + list.font.get_font_ascent, label);
         end
      end

   item_hit(list: SB_LIST; x_, y_: INTEGER): INTEGER is
         -- Return item hit code: 0 no hit; 1 hit the icon; 2 hit the text
      local
         iw,ih,tw,th,ix,iy,tx,ty,h: INTEGER;
         font: SB_FONT;
      do 
         font := list.font;
         if icon /= Void then
            iw := icon.width;
            ih := icon.height;
         end
         if not label.is_empty then
            tw := 4 + font.get_text_width(label);
            th := 4 + font.get_font_height;
         end
         h := LINE_SPACING + th.max(ih);
         ix := SIDE_SPACING // 2;
         tx := SIDE_SPACING // 2;
         if iw /= 0 then tx := tx + iw+ICON_SPACING end
         iy := (h-ih) // 2;
         ty := (h-th) // 2;

         if ix <= x_ and then iy <= y_ and then x_<ix+iw and then y_<iy+ih then
            -- In icon
            Result := 1;
         elseif tx <= x_ and then ty <= y_ and then x_<tx+tw and then y_<ty+th then
            -- In text
            Result := 2;
         end
      end

feature {SB_BASE_LIST}

   x, y: INTEGER;

   set_x(x_: INTEGER) is
      do
         x := x_;
      end

   set_y(y_: INTEGER) is
      do
         y := y_;
      end

feature {NONE} -- Implementation

   ICON_SPACING: INTEGER is 4;
         -- Spacing between icon and label
   SIDE_SPACING: INTEGER is 6;
         -- Left or right spacing between items
   LINE_SPACING: INTEGER is 4
         -- Line spacing between items
end
