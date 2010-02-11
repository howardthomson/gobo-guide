indexing
	description:"Header item"
	category:	"Display item"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

class SB_HEADER_ITEM

inherit

	SB_ITEM
      	rename
         	make as base_make
      	redefine
         	copy_state
      	end

   	SB_HEADER_CONSTANTS
      	export {NONE} all
      	end

creation

	make,
	make_opts

feature -- Creation

   make(text: STRING) is
      require
         text /= Void
      do
         make_opts(text,Void,0,Void)
      end

   make_opts(text: STRING; ic: SB_ICON; sz: INTEGER;dt: ANY) is
      do
         base_make(text,ic,dt);
         size := sz; 
         arrow_dir := SB_MAYBE;
      end

feature -- Data

   size: INTEGER;
   arrow_dir: INTEGER;

feature -- Quieries

   width(header: SB_HEADER): INTEGER is
         -- Return the item's width in the header
      local
         w: INTEGER;
      do
         if (header.get_header_style & HEADER_VERTICAL) /= Zero then
            if icon /= Void then w := icon.width end
            if not label.is_empty then
               w := w + header.font.get_text_width(label);
               if icon /= Void then w := w + ICON_SPACING end
            end
            Result := w + header.pad_left + header.pad_right + (header.border * 2);
         else
            Result := size;
         end
      end

   height(header: SB_HEADER): INTEGER is
         -- Return the item's height in the header
      local
         th,ih: INTEGER;
      do
         if (header.get_header_style & HEADER_VERTICAL) = Zero then
            if not label.is_empty then th := header.font.get_font_height end
            if icon /= Void then ih := icon.height end
            Result := th.max(ih) + header.pad_top + header.pad_bottom + (header.border * 2);
         else
            Result := size;
         end
      end


feature -- Actions

   set_size(size_: INTEGER) is
      do
         size := size_;
      end

   set_arrow_dir(dir: INTEGER) is
         -- Change sort direction (False, True, MAYBE)
      do
         arrow_dir := dir;
      end

feature { SB_HEADER }

   draw(header: SB_HEADER; dc: SB_DC; x_, y_, w_, h_: INTEGER) is
      local
         x,y,w,h: INTEGER;
         dw,num, tw,th,ty,aa: INTEGER;
         font: SB_FONT;
         done: BOOLEAN;  
      do
         x:= x_; y:=y_; w:=w_; h:=h_;
         font := header.font;
         -- Clip to inside of header control
         dc.set_clip_rectangle_coords(x,y,w,h);

         -- Account for borders
         w := w - (header.pad_left + header.pad_right + (header.border * 2));
         h := h - (header.pad_top  + header.pad_bottom + (header.border * 2));
         x := x +  header.border + header.pad_left;
         y := y +  header.border + header.pad_top;

         -- Draw icon
         if icon /= Void then
            if icon.width <= w then
               dc.draw_icon(icon, x, y+(h-icon.height)//2);
               x := x + icon.width;
               w := w - icon.width;
            end
         end

         -- Draw text
         if not label.is_empty then
            dw := font.get_text_width("...");
            num := label.count;
            tw := font.get_text_width(label);
            th := font.get_font_height;
            ty := y + (h - th) // 2 + font.get_font_ascent;
            dc.set_font(font);
            if icon /= Void then  x := x + ICON_SPACING; w := w - ICON_SPACING; end
            if tw <= w then
               dc.set_foreground(header.text_color);
               dc.draw_text(x, ty, label);
               x := x + tw;
               w := w - tw;
            else
               from
                  done := False;
               until
                  num <= 0 or done
               loop
                  tw := font.get_text_width_len(label,num)
                  if tw <= (w-dw) then
                     done := true;
                  else
                     num := num-1;
                  end
               end
               if num > 0 then
                  dc.set_foreground(header.text_color);
                  dc.draw_text_len(x, ty, label, num);
                  dc.draw_text(x + tw, ty, "...");
                  x := x + tw + dw;
                  w := w - (tw + dw);
               else
                  tw := font.get_text_width_len(label, 1);
                  if tw <= w then
                     dc.set_foreground(header.text_color);
                     dc.draw_text_len(x, ty, label, 1);
                     x := x + tw;
                     w := w - tw;
                  end
               end
            end
         end

         -- Draw arrows
         if arrow_dir /= SB_MAYBE then
            aa := (font.get_font_height - 3) // 2 * 2 + 1;
            if icon /= Void or else not label.is_empty then
               x := x + ARROW_SPACING;
               w := w - ARROW_SPACING;
            end
            if w>aa then
               if arrow_dir = SB_TRUE then
                  y := y + (h - aa) // 2;
                  dc.set_foreground(header.hilite_color);
                  dc.draw_line(x + aa // 2, y, x + aa - 1, y + aa);
                  dc.draw_line(x, y + aa, x + aa, y + aa);
                  dc.set_foreground(header.shadow_color);
                  dc.draw_line(x + aa // 2, y, x, y + aa);
               else
                  y := y + (h - aa) // 2;
                  dc.set_foreground(header.hilite_color);
                  dc.draw_line(x + aa // 2, y + aa, x + aa - 1, y);
                  dc.set_foreground(header.shadow_color);
                  dc.draw_line(x + aa // 2, y + aa, x, y);
                  dc.draw_line(x,y,x+aa,y);
               end
            end
         end
         -- Restore original clip path
         dc.clear_clip_rectangle;
      end

feature { SB_HEADER_ITEM, SB_ITEM_CONTAINER }

   copy_state(other: like Current) is
      do
         size := other.size
      end

feature { NONE } -- Implementation

   ARROW_SPACING: INTEGER is 8;
   ICON_SPACING: INTEGER is 4;

end
