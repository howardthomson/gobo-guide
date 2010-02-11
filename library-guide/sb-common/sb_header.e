indexing
   description: "[
		Header control may be placed over a table or list to provide a resizable
		caption above one or more columns.
		Each caption comprises a label and an optional icon; in addition, an arrow
		may be is_shown to indicate whether the items in that column are sorted, and
		if so, whether they are sorted in increasing or decreasing order.
		Each caption can be interactively resized.  During the resizing, if the
		HEADER_TRACKING was specified, the header control sends a SEL_CHANGED message
		to its message_target, with the message data set to the caption number being resized,
		of the type INTEGER.
		If the HEADER_TRACKING was not specified the SEL_CHANGED message is sent at
		the end of the resizing operation.
		Clicking on a caption causes a message of type SEL_COMMAND to be sent to the
		message_target, with the message data set to the caption number being clicked.
		A single click on a split causes a message of type SEL_CLICKED to be sent to the
		target.
   	]"

	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

	todo: "[
		When dragging end of last header item to resize it, avoid the situation where the
		content size changes as a result, resulting in the content moving rightward, instead
		of the r/h end of the item resizing leftward. Consider how to increase the size of the r/h
		item by dragging - drag the content leftward beyond its existing boundary ?
	]"

class SB_HEADER

inherit
   
	SB_FRAME
    	rename
         	make	  as frame_make,
         	make_opts as frame_make_opts,
         	Id_last	  as FRAME_ID_LAST
      	redefine
         	default_width,
         	default_height,
         	on_paint,
         	on_left_btn_press,
         	on_left_btn_release,
         	on_ungrabbed,
         	on_motion,
         	create_resource,
         	detach_resource,
         	destruct,
         	layout,
         	class_name
      	end

	SB_ARRAYED_ITEM_CONTAINER [ SB_HEADER_ITEM ]

	SB_HEADER_COMMANDS

	SB_HEADER_CONSTANTS

creation

   make,
   make_opts

feature -- Attributes

   text_color: INTEGER
         -- Text color

   font: SB_FONT
         -- Text font

   timer: SB_TIMER
         -- Tip hover timer

   help_text: STRING
         -- Help text

   state: BOOLEAN
         -- Button state

   active: INTEGER
         -- Active button

   activepos: INTEGER
         -- Position of active item

   activesize: INTEGER
         -- Size of active item

   offset: INTEGER
         -- Offset where split grabbed

feature -- class name

	class_name: STRING is
		once
			Result := "SB_HEADER"
		end

feature -- Creation

   make (p: SB_COMPOSITE; tgt: SB_MESSAGE_HANDLER; sel: INTEGER; opts: INTEGER) is
         -- Construct header
      local
         o: INTEGER
      do
         if opts = Zero then
            o := HEADER_NORMAL
         else
            o := opts
         end
         make_opts (p, tgt, sel, o, 0,0,0,0, DEFAULT_PAD, DEFAULT_PAD, DEFAULT_PAD, DEFAULT_PAD)
      end

   make_opts(p: SB_COMPOSITE; tgt: SB_MESSAGE_HANDLER; sel: INTEGER; opts: INTEGER;
             x, y, w, h, pl, pr,pt, pb: INTEGER) is
         -- Construct header
      do
         frame_make_opts (p, opts, x,y,w,h, pl,pr,pt,pb)
         set_flags (Flag_enabled | Flag_shown)
         message_target := tgt
         message := sel
         create items.make (1, 0)
         text_color := application.fore_color
         font := application.normal_font
         timer := Void
         state := False
         active := 0
         activepos := 0
         activesize := 0
         offset := 0
      end

feature -- Resource management

   create_resource is
         -- Create server-side resources
      local
         i,e: INTEGER
      do
         Precursor
         font.create_resource
         from
            i := items.lower
            e := items.upper
         until
            i > e
         loop
            if items.item (i).icon /= Void then
               items.item (i).icon.create_resource
            end
            i := i + 1
         end
      end

   detach_resource is
         -- Detach server-side resources
      local
         i,e: INTEGER
      do
         Precursor
         font.detach_resource
         from
            i := items.lower
            e := items.upper
         until
            i > e
         loop
            if items.item (i).icon /= Void then
               items.item (i).icon.detach_resource
            end
            i := i + 1
         end
      end

feature -- Destruction

   destruct is
      do
         font := Void
         if timer /= Void then
            application.remove_timeout (timer)
            timer := Void
         end
         clear_items
         Precursor
      end

feature -- Queries

   default_width: INTEGER is
         -- Return default width
      local
         i, e: INTEGER
      do
         if (options & HEADER_VERTICAL) /= Zero then
            from
               i := 1
               e := items.count
            until
               i > e
            loop
               Result := Result.max (items.item (i).width (Current))
               i := i + 1
            end
         else
            from
               i := 1
               e := items.count
            until
               i > e
            loop
               Result := Result + items.item (i).width (Current)
               i := i + 1
            end
         end
      end

   default_height: INTEGER is
         -- Return default height
      local
         i, e: INTEGER
      do
         if (options & HEADER_VERTICAL) /= Zero then
            from
               i := 1
               e := items.count
            until
               i > e
            loop
               Result := Result + items.item (i).height (Current)
               i := i + 1
            end
         else
            from
               i := 1
               e := items.count
            until
               i > e
            loop
               Result := Result.max(items.item (i).height (Current))
               i := i + 1
            end
         end
      end

   get_header_style: INTEGER is
         -- Get header style options
      do
         Result := (options & HEADER_MASK)
      end

feature -- Item queries

   item_at (off: INTEGER): INTEGER is
         -- Return item-index given pixel-offset from left
      local
         x,y, i,e, w,h: INTEGER;
         done: BOOLEAN;
      do
         if (options & HEADER_VERTICAL) /= Zero then
            from
               i := 1
               e := items.count
            until
               i > e or else Result /= 0
            loop
               h := items.item (i).height (Current);
               if y <= off and then off < y + h then
                  Result := i
               else
                  y := y + h
                  i := i + 1
               end
            end
         else
            from
               i := 1
               e := items.count
            until
               i > e or else Result /= 0
            loop
               w := items.item (i).width (Current);
               if x <= off and then off < x + w then
                  Result := i
               else
                  x := x + w
                  i := i + 1
               end
            end
         end
      end

   item_offset(index: INTEGER): INTEGER is
         -- Compute offset from the left side of item at index
      require
         index > 0 and then index <= items_count
      local
         i,e: INTEGER;
      do
         if (options & HEADER_VERTICAL) /= Zero then
            from
               i := 1;
               e := items.count;
            until
               i > e
            loop
               Result := Result+ items.item(i).height(Current)
               i := i+1;
            end
         else
            from
               i := 1;
               e := items.count;
            until
               i > e
            loop
               Result := Result+items.item(i).width(Current);
               i := i+1;
            end
         end
      end

feature -- Actions

   set_font (fnt: SB_FONT) is
         -- Change text font
      require
         fnt /= Void
      do
         if font /= fnt then
            font := fnt;
            recalc;
            update;
         end
      end

   set_text_color(clr: INTEGER) is
         -- Set the current text color
      do
         if clr /= text_color then
            text_color := clr;
            update;
         end
      end

   set_header_style (style: INTEGER) is
         -- Set header style options
      local
         opts: INTEGER;
      do
         opts := (options & (HEADER_MASK).bit_not)  |  (style & HEADER_MASK)
         if options /= opts then
            options := opts
            recalc
            update
         end
      end

   set_help_text(text: STRING) is
         -- Set the status line help text for this header      
      do
         help_text := text;
      end

feature -- Item actions

    set_item_text(index: INTEGER; text: STRING) is
          -- Change item text
       do
          items.item(index).set_text(text);
          update;
       end

    set_item_icon(index: INTEGER; icon: SB_ICON) is
          -- Change item icon
       do
          if items.item(index).icon /= icon then
             items.item(index).set_icon(icon);
             update;
          end
       end

    set_item_size(index, size_: INTEGER) is
          -- Change item size
       require
         valid_accessor(index)
       local
          size: INTEGER;
       do
          size := size_.max(0);
          if item(index).size /= size then
             item(index).set_size(size);
          -- if (flags & Flag_pressed) = Zero then
             	recalc;
          -- end
          end
       end

    set_item_arrow_dir(index, dir: INTEGER) is
          -- Change sort direction (False, True, MAYBE)
       require
         valid_accessor(index)
       do
          if item(index).arrow_dir /= dir then
             item(index).set_arrow_dir(dir);
             update;
          end
       end

   replace_item_with_new(index: INTEGER; text: STRING;icon: SB_ICON; size: INTEGER; data: ANY; notify: BOOLEAN) is
         -- Replace items text, icon, and user-data pointer
      require
         valid_accessor(index)
      do
         replace_item(index, create_item(text, icon, size.max(0), data), notify);
      end

   insert_new_item(index: INTEGER; text: STRING;icon: SB_ICON; size: INTEGER; data: ANY; notify: BOOLEAN) is
         -- Replace items text, icon, and user-data pointer
      require
         valid_accessor(index)
      do
         insert_item(index, create_item(text, icon, size.max(0), data), notify);
      end

   append_new_item(text: STRING; icon: SB_ICON; size: INTEGER; data: ANY; notify: BOOLEAN) is
         -- Append new item with given text and optional icon, and user-data pointer
      do
         insert_item(items_count + 1, create_item(text, icon, size.max(0), data), notify);
      end

   prepend_new_item(text: STRING;icon: SB_ICON; size: INTEGER; data: ANY; notify: BOOLEAN) is
         -- Prepend new item with given text and optional icon, and user-data pointer
      do
         insert_item(1, create_item(text, icon, size.max(0), data), notify);
      end

feature -- Message processing

   on_paint(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      local
         ev: SB_EVENT;
         dc: SB_DC_WINDOW;
         x,y, w,h, i,e: INTEGER;
      do
         ev ?= data;
         check
            ev /= Void
         end
         dc := paint_dc
         dc.make_event(Current,ev);
         dc.set_foreground(back_color);
         dc.fill_rectangle(ev.rect_x, ev.rect_y, ev.rect_w, ev.rect_h);
         if (options & HEADER_VERTICAL) /= Zero then
            from
               i := items.lower
               e := items.upper
            until
               i > e
            loop
               h := items.item(i).height(Current);
               if ev.rect_y < y + h and then y < ev.rect_y + ev.rect_h then
                  items.item(i).draw(Current, dc, 0, y, width,h);
                  if i = active and then state then
                     if (options & Frame_thick) /= Zero then
                        draw_double_sunken_rectangle(dc, 0, y, width, h);
                     else
                        draw_sunken_rectangle(dc, 0, y, width, h);
                     end
                  else
                     if (options & Frame_thick) /= Zero then
                        draw_double_raised_rectangle(dc, 0, y, width, h);
                     else
                        draw_raised_rectangle(dc, 0, y, width, h);
                     end
                  end
               end
               y := y+h;
               i := i+1;
            end
            if y < height then
               if (options & Frame_thick) /= Zero then
                  draw_double_raised_rectangle(dc, 0, y, width, height - y);
               else
                  draw_raised_rectangle(dc, 0, y, width, height - y);
               end
            end
         else
            from
               i := items.lower
               e := items.upper
            until
               i > e
            loop
               w := items.item(i).width(Current);
               if ev.rect_x < x + w and then x < ev.rect_x + ev.rect_w then
                  items.item (i).draw (Current, dc, x, 0, w, height);
                  if i = active and then state then
                     if (options & Frame_thick) /= Zero then
                        draw_double_sunken_rectangle (dc, x, 0, w, height);
                     else
                        draw_sunken_rectangle (dc, x, 0, w, height);
                     end
                  else
                     if (options & Frame_thick) /= Zero then
                        draw_double_raised_rectangle (dc, x, 0, w, height);
                     else
                        draw_raised_rectangle (dc, x, 0, w, height);
                     end
                  end
               end
               x := x+w;
               i := i+1
            end
            if x < width then
               if (options & Frame_thick) /= Zero then
                  draw_double_raised_rectangle(dc, x, 0, width - x, height);
               else
                  draw_raised_rectangle(dc, x, 0, width - x, height);
               end
            end
         end
         dc.stop;
         Result := True     
      end

   on_left_btn_press(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      local
         ev: SB_EVENT;
         i,e,x,y,w,h: INTEGER;
         done: BOOLEAN;
      do
         ev ?= data;
         check
            ev /= Void
         end
         unset_flags (Flag_tip);
         do_handle_2 (Current, SEL_FOCUS_SELF, 0, data);
         if is_enabled then
            grab_mouse;
            if message_target = Void or else not message_target.handle_2 (Current, SEL_LEFTBUTTONPRESS, message, data) then
               if (options & HEADER_VERTICAL) /= Zero then
                  -- Vertically oriented
                  from
                     i := items.lower;
                     e := items.upper;
                  until
                     i > e or else done
                  loop
                     h := items.item(i).height(Current);
                     if (options & HEADER_BUTTON) /= Zero and then y+FUDGE <= ev.win_y and then ev.win_y<y+h-FUDGE then
                        -- Hit a header button?
                        active := i;
                        activepos := y;
                        activesize := h;
                        state := True;
                        update_rectangle(0, activepos, width, activesize);
                        set_flags (Flag_pressed);
                        done := True;
                     elseif y + h - FUDGE <= ev.win_y and then ev.win_y < y + h then
                        -- Upper end of a button
                        set_drag_cursor(application.default_cursor(Def_vsplit_cursor));
                        active := i;
                        activepos := y;
                        activesize := h;
                        offset := ev.win_y - activepos - activesize;
                        set_flags (Flag_pressed | Flag_trydrag)
                        set_drag_cursor (application.default_cursor (Def_vsplit_cursor));
                        done := True;
                     elseif y+h <= ev.win_y and then ev.win_y < y+h+FUDGE then
                        -- Lower end of last button at Current place
                        set_drag_cursor (application.default_cursor (Def_vsplit_cursor));
                        active := i;
                        activepos := y;
                        activesize := h;
                        offset := ev.win_y - activepos - activesize;
                        set_drag_cursor(application.default_cursor (Def_vsplit_cursor));
                        set_flags (Flag_pressed | Flag_trydrag)
                     end
                     -- Hit nothing, next item
                     y := y + h;
                     i := i + 1;
                  end
               else
                  -- Horizontally oriented
                  from
                     i := items.lower;
                     e := items.upper;
                  until
                     i > e or else done
                  loop
                     w := items.item(i).width(Current);
                     if (options & HEADER_BUTTON) /= Zero and then x+FUDGE <= ev.win_x and then ev.win_x < x+w-FUDGE then
                        -- Hit a header button?
                        active := i;
                        activepos := x;
                        activesize := w;
                        state := True;
                        update_rectangle(activepos,0,activesize,height);
                        set_flags (Flag_pressed);
                        done := True;
                     elseif x+w-FUDGE <= ev.win_x and then ev.win_x<x+w then
                        -- Upper end of a button
                        set_drag_cursor(application.default_cursor(Def_hsplit_cursor));
                        active := i;
                        activepos := x;
                        activesize := w;
                        offset := ev.win_x-activepos-activesize;
                        set_flags (Flag_pressed | Flag_trydrag)
                        set_drag_cursor(application.default_cursor(Def_hsplit_cursor));
                        done := True
                     elseif x + w <= ev.win_x and then ev.win_x < x + w + FUDGE then
                        -- Lower end of last button at Current place
                        active := i
                        activepos := x
                        activesize := w
                        offset := ev.win_x - activepos - activesize
                        set_flags (Flag_pressed | Flag_trydrag)
                        set_drag_cursor(application.default_cursor (Def_hsplit_cursor))
                     end
                     -- Hit nothing, next item
                     x := x + w;
					 i := i + 1;
                  end
               end
            end
            unset_flags (Flag_update);
            Result := True
         end
      end

   on_left_btn_release(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      local
         ev: SB_EVENT;
         flg: INTEGER;
      do
         flg := flags;
         if is_enabled then
            release_mouse;
            set_flags (Flag_update);
            unset_flags (Flag_pressed | Flag_dodrag | Flag_trydrag)
            if message_target = Void or else not message_target.handle_2 (Current, SEL_LEFTBUTTONRELEASE, message, data) then
               ev ?= data check ev /= Void end
               if not ev.moved and then (flg & Flag_trydrag) /= Zero then
                  do_send(SEL_CLICKED, ref_integer(active));
               elseif (flags & Flag_dodrag) /= Zero then
                  set_drag_cursor(application.default_cursor(Def_arrow_cursor));
                  if (options & HEADER_TRACKING) = Zero then
                     draw_split(activepos + activesize);
                     set_item_size(active, activesize);
                     if message_target /= Void then
                        message_target.do_handle_2 (Current, SEL_CHANGED, message, ref_integer(active));
                     end
                  end
               elseif state then
                  state := False;
                  if (options & HEADER_VERTICAL) /= Zero then
                     update_rectangle(0, activepos, width, activesize);
                  else
                     update_rectangle(activepos, 0, activesize, height);
                  end
                  if message_target /= Void then
                     message_target.do_handle_2 (Current, SEL_COMMAND, message, ref_integer(active));
                  end
               end
            end
            Result := True
         end
      end

   on_ungrabbed(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         Result := precursor(sender,selector,data);
         unset_flags (Flag_pressed | Flag_changed);
         set_flags (Flag_update);
         Result := True
      end

   on_motion(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      local
         ev: SB_EVENT;
         i,e, x,y, w,h, oldsplit, newsplit: INTEGER;
         flg: INTEGER;
         done: BOOLEAN;
      do
         ev ?= data;
         check
            ev /= Void
         end
         flg := flags;

         	-- Kill the tip
         unset_flags (Flag_tip);

         	-- Kill the tip timer
         if timer /= Void then
         	application.remove_timeout(timer);
            timer := Void
 		 end

         if (flags & Flag_pressed) /= Zero then
            	-- Had the button pressed
            	-- Dragging
            if (flags & Flag_trydrag) /= Zero then
              if (options & HEADER_TRACKING) = Zero then
                 draw_split(activepos + activesize);
              end
              unset_flags (Flag_trydrag);
              set_flags (Flag_dodrag);
            elseif (flags & Flag_dodrag) /= Zero then
               -- We were dragging a split
               oldsplit := activepos + activesize;
               if (options & HEADER_VERTICAL) /= Zero then
                  activesize := ev.win_y - offset - activepos;
               else
                  activesize := ev.win_x - offset - activepos;
               end
               activesize := activesize.max(0);
               newsplit := activepos + activesize;
               if newsplit /= oldsplit then
                  if (options & HEADER_TRACKING) = Zero then
                     draw_split(oldsplit);
                     draw_split(newsplit);
                  else
                     set_item_size(active, activesize);
                     if message_target /= Void then
                        message_target.do_handle_2 (Current, SEL_CHANGED, message, ref_integer(active));
                     end
                  end
               end
            else
               -- We pressed the button
               if (options & HEADER_VERTICAL) /= Zero then
                  if activepos <= ev.win_y and then ev.win_y < activepos + activesize and then 0 <= ev.win_x and then ev.win_x < width then
                     if not state then
                        state := True;
                        update_rectangle(0, activepos, width, activesize);
                     end
                  else
                     if state then
                        state := False;
                        update_rectangle(0, activepos, width, activesize);
                     end
                  end
               else
                  if activepos <= ev.win_x and then ev.win_x < activepos + activesize and then 0 <= ev.win_y and then ev.win_y < height then
                     if not state then
                        state := True;
                        update_rectangle(activepos, 0, activesize, height);
                     end
                  else
                     if state then
                        state := False;
                        update_rectangle(activepos, 0, activesize, height);
                     end
                  end
               end
            end
            Result := True
         else
            -- Just hovering over the widget
            if (options & HEADER_VERTICAL) /= Zero then
               from
                  i := items.lower;
                  e := items.upper;
               until
                  i > e or else done
               loop
                  h := items.item(i).height(Current);
                  if y+h-FUDGE <= ev.win_y and then ev.win_y < y+h+FUDGE then
                     set_default_cursor(application.default_cursor(Def_vsplit_cursor));
                     done := True;
                  else
                     y := y + h;
                     i := i + 1;
                  end
               end
            else
               from
                  i := items.lower;
                  e := items.upper;
               until
                  i > e or else done
               loop
                  w := items.item(i).width(Current);
                  if x+w-FUDGE <= ev.win_x and then ev.win_x < x+w+FUDGE then
                     set_default_cursor(application.default_cursor(Def_hsplit_cursor));
                     done := True;
                  else
                     x := x + w;
                     i := i + 1
                  end
               end
            end
            if not done then
               -- Not over a split, back to normal cursor
               set_default_cursor(application.default_cursor(Def_arrow_cursor));
            end
            -- Reset tip timer if nothing's going on
            timer := application.add_timeout(application.menu_pause, Current, ID_TIPTIMER);
            -- Force GUI update only when needed
            if (flg & Flag_tip) /= Zero then
               Result := True
            end
         end
      end

   on_tip_timer(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         timer := Void;
         set_flags (Flag_tip);
         Result := True
      end

   on_query_tip(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      local
         index: INTEGER;
         cp: SB_CURSOR_POSITION;
      do
         if (flags & Flag_tip) /= Zero then
            cp := get_cursor_position;
            if cp /= Void then
               if (options & HEADER_VERTICAL) /= Zero then
                  index := item_at(cp.y);
               else
                  index := item_at(cp.x);
               end
            end
            if 0 < index then
               sender.do_handle_2 (Current, SEL_COMMAND, Id_setstringvalue, items.item(index).label);
               Result := True
            end
         end
      end

   on_query_help(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         if not help_text.is_empty and then (flags & Flag_help) /= Zero then
            sender.do_handle_2 (Current, SEL_COMMAND, Id_setstringvalue, help_text);
            Result := True
         end
      end

feature {NONE} -- Implementation

   	ITEM_TYPE: SB_HEADER_ITEM is do end

   	FUDGE: INTEGER is 8;

   	HEADER_MASK: INTEGER is
      	once
         	Result := HEADER_BUTTON | HEADER_TRACKING | HEADER_VERTICAL;
      	end

   	draw_split(pos: INTEGER) is
      	local
         	dc: SB_DC_WINDOW;
         	sbp: SB_POINT;
      	do
      		dc := paint_dc
         	dc.make(parent);
         	sbp := translate_coordinates_to(parent,pos,pos);
         	dc.clip_children(False);
         	dc.set_function(dc.Blt_not_dst);
         	if (options & HEADER_VERTICAL) /= Zero then
            	dc.fill_rectangle(0, sbp.y, parent.width, 2);
         	else
            	dc.fill_rectangle(sbp.x, 0, 2, parent.height);
         	end
         	dc.stop
      	end

   	create_item(text: STRING;icon: SB_ICON; size: INTEGER; data: ANY): SB_HEADER_ITEM is
      	do
         	create Result.make_opts(text, icon, size, data);
      	end

   	layout is
      	do
         	-- Force repaint
         	update;
         	-- No more dirty
         	unset_flags (Flag_dirty);
      	end
end
