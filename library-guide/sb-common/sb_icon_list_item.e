indexing
	description:"Icon List item"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

class SB_ICON_LIST_ITEM

inherit

	SB_ITEM
      	rename
         	make as base_make,
         	icon as mini_icon,
         	set_icon as set_mini_icon
      	redefine
         	create_resource,
         	detach_resource
      	end

--insert

	SB_ICON_LIST_CONSTANTS
		export { NONE } all
		end

creation

	make_empty, make

feature -- Creation

	make(text: STRING; bi,mi: SB_ICON; dt: ANY) is
    	do
        	base_make(text,mi,dt);
        	big_icon := bi;
		end

feature -- Data

	big_icon: SB_ICON;

feature -- Queries

   width (list: SB_GENERIC_ICON_LIST [ SB_ICON_LIST_ITEM ]): INTEGER is
      local
         options: INTEGER;
         iw,tw: INTEGER;
      do
         options := list.get_list_style;
         if (options & ICONLIST_BIG_ICONS) /= Zero then
            if big_icon /= Void then iw := big_icon.width; end
            if not label.is_empty then tw := 4+list.font.get_text_width_len(label,count(label,1)); end
            Result := SIDE_SPACING+tw.max(iw);
         elseif (options & ICONLIST_MINI_ICONS) /= Zero then
            if mini_icon /= Void then iw := mini_icon.width; end
            if not label.is_empty then tw := 4+list.font.get_text_width_len(label,count(label,1)); end
            if iw /= 0 and then tw /= 0 then iw := iw + MINI_TEXT_SPACING; end
            Result := SIDE_SPACING+iw+tw;
         else
            Result := SIDE_SPACING;
         end
      end

   height (list: SB_GENERIC_ICON_LIST [ SB_ICON_LIST_ITEM ]): INTEGER is
      local
         options: INTEGER;
         ih,th: INTEGER;
      do
         options := list.get_list_style;
         if (options & ICONLIST_BIG_ICONS) /= Zero then
            if big_icon /= Void then ih := big_icon.height; end
            if not label.is_empty then th := 4+list.font.get_font_height; end
            if ih /= 0 and then th /= 0 then ih := ih + BIG_TEXT_SPACING; end
            Result := BIG_LINE_SPACING+ih+th;
         elseif (options & ICONLIST_MINI_ICONS) /= Zero then
            if mini_icon /= Void then ih := mini_icon.height; end
            if not label.is_empty then th := 4+list.font.get_font_height; end
            Result := ih.max(th);
         else
            if mini_icon /= Void then ih := mini_icon.height; end
            if not label.is_empty then th := 4+list.font.get_font_height; end
            Result := ih.max(th);
         end
      end

feature -- Actions

   set_big_icon(icn: SB_ICON) is
      do
         big_icon := icn;
      end

feature -- Resource management

	create_resource is
    	do
         	Precursor;
         	if big_icon /= Void then big_icon.create_resource; end
      	end

   	detach_resource is
      	do
         	Precursor;
         	if big_icon /= Void then big_icon.detach_resource; end
      	end

feature {SB_GENERIC_ICON_LIST, SB_FILE_LIST} -- Implementation

   	draw (list: SB_GENERIC_ICON_LIST [ SB_ICON_LIST_ITEM ]; dc: SB_DC; x, y, w, h: INTEGER) is
      	local
         	options: INTEGER;
      	do
         	options := list.get_list_style;
         	if (options & list.ICONLIST_BIG_ICONS) /= Zero then
            	draw_big_icon(list, dc, x,y,w,h);
         	elseif (options & list.ICONLIST_MINI_ICONS) /= Zero then
            	draw_mini_icon(list, dc, x,y,w,h);
         	else
            	draw_details(list, dc, x,y,w,h);
         	end
      	end

   draw_big_icon (list: SB_GENERIC_ICON_LIST [ SB_ICON_LIST_ITEM ]; dc: SB_DC; x, y, w, h: INTEGER) is
      local
         iw, ih, tw, th, ss, tlen, tdrw, dw, s, sp, xt, yt, xi, yi: INTEGER
         font: SB_FONT
      do
         font := list.font;
         sp := w - SIDE_SPACING;
         if not label.is_empty then
            tlen := count(label, 1);
            tw := 4 + font.get_text_width_len(label, tlen)
            th := 4 + font.get_font_height;
            yt := y + h - th - BIG_LINE_SPACING // 2;
            tdrw := tlen;
            dw := 0;
            if tw>sp then
               dw := font.get_text_width("...");
               s := sp-dw;
               from
                  tw := 4+font.get_text_width_len(label,tdrw);
               until
                  tw <= s or else tdrw <= 1
               loop
                  tw := 4+font.get_text_width_len(label,tdrw);
                  tdrw := tdrw-1;
               end
               if tw>s then dw := 0; end
            end
            if tw <= sp then
               xt := x + (w - tw - dw) // 2;
               if is_selected then
                  dc.set_foreground(list.sel_back_color);
                  dc.fill_rectangle(xt, yt, tw + dw, th);
                  dc.set_foreground(list.sel_text_color);
               else
                  dc.set_foreground(list.text_color);
               end
               dc.draw_text_len(xt + 2, yt + font.get_font_ascent + 2, label, tdrw);
               if dw /= 0 then dc.draw_text(xt + tw - 2, yt + font.get_font_ascent + 2, "..."); end
               if has_focus then
                  dc.draw_focus_rectangle(xt + 1, yt + 1, tw + dw - 2, th - 2);
               end
            end
            ss := BIG_TEXT_SPACING; -- Space between text and icon only added if we have both icon and text
         end
         if big_icon /= Void then
            iw := big_icon.width;
            ih := big_icon.height;
            xi := x + (w - iw) // 2;
            yi := y + BIG_LINE_SPACING // 2 + (h - th - BIG_LINE_SPACING - ss - ih) // 2;
            if is_selected then
               dc.draw_icon_shaded(big_icon, xi, yi);
            else
               dc.draw_icon(big_icon, xi, yi);
            end
         end
      end

   draw_mini_icon (list: SB_GENERIC_ICON_LIST [ SB_ICON_LIST_ITEM ]; dc: SB_DC; x_, y_, w, h: INTEGER) is
      local
         iw,ih,tw,th,tlen,tdrw,dw,s,sp: INTEGER
         x,y: INTEGER;
         font: SB_FONT;
      do
         font := list.font;
         x := x_;y := y_;
         x := x + SIDE_SPACING//2;
         sp := w-SIDE_SPACING;
         if mini_icon /= Void then
            iw := mini_icon.width;
            ih := mini_icon.height;
            if is_selected then
               dc.draw_icon_shaded(mini_icon,x,y+(h-ih)//2);
            else
               dc.draw_icon(mini_icon,x,y+(h-ih)//2);
            end
            x := x + iw+MINI_TEXT_SPACING;
            sp := sp - (iw+MINI_TEXT_SPACING);
         end
         if not label.is_empty then
            tlen := count(label,1);
            tw := 4+font.get_text_width_len(label,tlen);
            th := 4+font.get_font_height;
            tdrw := tlen;
            dw := 0;
            if tw>sp then
               dw := font.get_text_width("...");
               s := sp-dw;
               from
                  tw := 4+font.get_text_width_len(label,tdrw);
               until
                  tw <= s or else tdrw <= 1
               loop
                  tw := 4+font.get_text_width_len(label,tdrw);
                  tdrw := tdrw-1;
               end
               if tw>s then dw := 0; end
            end
            if tw <= sp then
               y := y + (h-th)//2;
               if is_selected then
                  dc.set_foreground(list.sel_back_color);
                  dc.fill_rectangle(x,y,tw+dw,th);
                  dc.set_foreground(list.sel_text_color);
               else
                  dc.set_foreground(list.text_color);
               end
               dc.draw_text_len(x+2,y+font.get_font_ascent+2,label,tdrw);
               if dw /= 0 then dc.draw_text(x+tw-2,y+font.get_font_ascent+2,"..."); end
               if has_focus then
                  dc.draw_focus_rectangle(x+1,y+1,tw+dw-2,th-2);
               end
            end
         end
      end

   draw_details (list: SB_GENERIC_ICON_LIST [ SB_ICON_LIST_ITEM ]; dc: SB_DC; x_, y_, w, h: INTEGER) is
      local
         font: SB_FONT;
         header: SB_HEADER;
         iw,ih,tw,th,tlen,tdrw,ddw,dw,s,hi,space,tail: INTEGER;
         ts,x,y: INTEGER;
         done,done1: BOOLEAN;
      do
         x := x_; y := y_;
         font := list.font;
         header := list.header;
         if header.items_count /= 0 then
            if is_selected then
               dc.set_foreground(list.sel_back_color);
               dc.fill_rectangle(x, y, header.width, h);
            end
            if has_focus then
               dc.draw_focus_rectangle(x + 1, y + 1, header.width - 2, h - 2);
            end
            x := x + SIDE_SPACING // 2;
            if mini_icon /= Void then
               iw := mini_icon.width;
               ih := mini_icon.height;
               dc.draw_icon(mini_icon, x, y + (h - ih) // 2);
               x := x + iw + DETAIL_TEXT_SPACING;
            end
            if not label.is_empty then
               ts := 1;
               th := font.get_font_height;
               ddw := font.get_text_width("...");
               y := y + (h - th - 4) // 2;
               if is_selected then
                  dc.set_foreground(list.sel_text_color);
               else
                  dc.set_foreground(list.text_color);
               end
               tail := iw + DETAIL_TEXT_SPACING + SIDE_SPACING // 2;
               from
                  hi := 1;
                  done := false;
               until
                  hi > header.items_count or else done
               loop
                  space := header.item(hi).size-tail;
                  tlen := count(label,ts);
                  if tlen > 0 then
                     tw := font.get_text_width_offset(label,ts,tlen);
                     tdrw := tlen;
                     dw := 0;
                     if tw > space-4 then
                        dw := ddw;
                        s := space-4-dw;
                        from
                           done1 := False
                        until
                           done1
                        loop
                           tw := 4+font.get_text_width_offset(label,ts,tdrw);
                           if tw <= s or else tdrw <= 1 then
                              done1 := True;
                           else
                              tdrw := tdrw-1;
                           end
                        end
                        if tw > space-4 then dw := 0 end
                     end
                     if tw <= (space-4) then
                        dc.draw_text_offset(x+2,y+font.get_font_ascent+2,label,ts,tdrw);
                        if dw /= 0 then dc.draw_text(x+tw+2,y+font.get_font_ascent+2,"...") end
                     end
                  end
                  if ts + tlen > label.count then
                     done := true;
                  else
                     x := x + space;
                     ts := ts + tlen + 1;
                     tail := 0;
                     hi := hi + 1;
                  end
               end
            end
         end
      end

   item_hit (list: SB_GENERIC_ICON_LIST [ SB_ICON_LIST_ITEM ]; rx,ry,rw,rh: INTEGER): INTEGER is
         -- See if item got hit and where:
         --		0 is outside,
         --		1 is icon,
         --		2 is text
      local
         options: INTEGER;
         iw,tw,ih,th,ss,ix,iy,tx,ty,w,h,sp: INTEGER;
         font: SB_FONT;
      do
         options := list.get_list_style;
         font := list.font;
         if (options & ICONLIST_BIG_ICONS) /= Zero then
            w := list.item_space;
            h := list.item_height;
            sp := w-SIDE_SPACING;
            if not label.is_empty then
               tw := 4+font.get_text_width_len(label,count(label,1));
               th := 4+font.get_font_height;
               if tw>sp then tw := sp end
               if big_icon /= Void then ss := BIG_TEXT_SPACING end
            end
            if big_icon /= Void then
               iw := big_icon.width;
               ih := big_icon.height;
            end
            ty := h-th-BIG_LINE_SPACING // 2;
            iy := BIG_LINE_SPACING // 2 + (h-th-BIG_LINE_SPACING-ss-ih)//2;
            ix := (w-iw) // 2;
            tx := (w-tw) // 2;
         elseif (options & ICONLIST_MINI_ICONS) /= Zero then
            ix := SIDE_SPACING // 2;
            tx := SIDE_SPACING // 2;
            sp := list.item_space-SIDE_SPACING;
            if mini_icon /= Void then
               iw := mini_icon.width;
               ih := mini_icon.height;
               tx := tx + iw + MINI_TEXT_SPACING;
               sp := sp - iw - MINI_TEXT_SPACING;
            end
            if not label.is_empty then
               tw := 4 + font.get_text_width_len(label, count(label, 1));
               th := 4 + font.get_font_height;
               if tw > sp then tw := sp end
            end
            h := list.item_height;
            iy := (h - ih) // 2;
            ty := (h - th) // 2;
         else
            ix := SIDE_SPACING // 2;
            tx := SIDE_SPACING // 2;
            if mini_icon /= Void then
               iw := mini_icon.width;
               ih := mini_icon.height;
               tx := tx + iw+DETAIL_TEXT_SPACING;
            end
            if not label.is_empty then
               tw := 10000000;
               th := 4 + font.get_font_height;
            end
            h := list.item_height;
            iy := (h - ih) // 2;
            ty := (h - th) // 2;
         end
         if ix <= rx+rw and then iy <= ry+rh and then rx<ix+iw and then ry<iy+ih then
            -- In icon
            Result := 1;
         elseif tx <= rx+rw and then ty <= ry+rh and then rx<tx+tw and then ry<ty+th then
            -- In text
            Result := 2;
         else
            -- Outside
            Result := 0;
         end
      end

	SIDE_SPACING: INTEGER is 4;
    	-- Left or right spacing between items

	DETAIL_TEXT_SPACING: INTEGER is 2;
        -- Spacing between text and icon in detail icon mode

	MINI_TEXT_SPACING: INTEGER is 2;
        -- Spacing between text and icon in mini icon mode

	BIG_LINE_SPACING: INTEGER is 6;
        -- Line spacing in big icon mode

	BIG_TEXT_SPACING: INTEGER is 2;    
        -- Spacing between text and icon in big icon mode

	count(txt: STRING; start: INTEGER): INTEGER is
    		-- Helper function
      	local
         	i, e: INTEGER;
      	do
         	from
            	i := start
            	e := txt.count
         	until
            	i > e or else txt.item(i) = '%T'
         	loop
            	i := i + 1;
         	end
         	Result := i - start;
      	end

end
