note
	description: "[
		A tab item is placed in a tab bar or tab book.
		When selected, the tab item sends a message to its
		parent, and causes itself to become the active tab,
		and raised slightly above the other tabs.
		In the tab book, activating a tab item also causes
		the corresponding panel to be raised to the top.
	]"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

class SB_TAB_ITEM

inherit

   	SB_LABEL
      	rename
         	make as label_make,
         	make_opts as label_make_opts
      	redefine
         	can_focus,
         	on_paint,
         	on_focus_in,
         	on_focus_out,
         	on_key_press,
         	on_key_release,
         	on_hot_key_press,
         	on_hot_key_release,
         	on_left_btn_press,
         	on_left_btn_release,
         	on_ungrabbed,
         	class_name
      	end

	SB_TAB_ITEM_CONSTANTS

	SB_TAB_BAR_CONSTANTS

create

	make, make_opts

feature -- class name

	class_name: STRING
		once
			Result := "SB_TAB_ITEM"
		end

feature -- Creation

--	make (p: SB_COMPOSITE; text: STRING; opts: INTEGER)
	make (p: SB_COMPOSITE; text: STRING)
         	-- Construct a tab item
      	local
      		opts: INTEGER -- WAS an argument
         	o: INTEGER
      	do
         	if opts = 0 then
            	o := TAB_TOP_NORMAL
         	else
            	o := opts
         	end
         	make_opts(p, text, Void,o, 0,0,0,0,
                   DEFAULT_PAD, DEFAULT_PAD,DEFAULT_PAD, DEFAULT_PAD);
      	end

	make_opts (p: SB_COMPOSITE; text: STRING; ic: SB_ICON; opts: INTEGER;
            		x, y, w, h, pl, pr,pt, pb: INTEGER)
         	-- Construct a tab item
    	do
        	label_make_opts (p, text, ic, opts, x,y,w,h, pl,pr,pt,pb)
        	border := 2;
      	end

feature -- Queries

	can_focus: BOOLEAN
         	-- Returns true because a tab item can receive focus
    	once
        	Result := True;
      	end

	get_tab_orientation: INTEGER
    		-- Return current radio button style
      	do
        	Result := (options & TAB_ORIENT_MASK);
      	end

feature -- Actions

   set_tab_orientation (style: INTEGER)
         -- Change radio button style
      local
         opts: INTEGER
      do
         opts := new_options (style, TAB_ORIENT_MASK)
         if options /= opts then
            options := opts;
            recalc;
            update;
         end
      end

feature -- Message processing

	on_paint (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
		local
		 event: SB_EVENT;
         dc: SB_DC_WINDOW;
         tw,th,iw,ih,tx,ty,ix,iy: INTEGER;
         pt: SB_POINT;
         t: INTEGER;
      do
         event ?= data;
         check
            event /= Void
         end
         dc := paint_dc
         dc.make_event(Current,event);
         dc.set_foreground(back_color);
         dc.fill_rectangle(event.rect_x, event.rect_y, event.rect_w, event.rect_h);
         
         t := options & TAB_ORIENT_MASK;
         if t = TAB_LEFT then
            dc.set_foreground(hilite_color);
            dc.draw_line(2, 0, width - 1, 0);
            dc.draw_line(0, 2, 1, 1);
            dc.draw_line(0, height - 2, 0, 2);
            dc.set_foreground(shadow_color);
            dc.draw_line(2, height - 2, width - 1, height - 2);
            dc.set_foreground(border_color);
            dc.draw_line(3, height - 1, width - 1, height - 1);
         elseif t = TAB_RIGHT then
            dc.set_foreground(hilite_color);
            dc.draw_line(0, 0, width - 3, 0);
            dc.draw_line(width - 3, 0, width - 1, 3);
            dc.set_foreground(shadow_color);
            dc.draw_line(width - 2, 2, width - 2, height - 2);
            dc.draw_line(0, height - 2, width - 2, height - 2);
            dc.set_foreground(border_color);
            dc.draw_line(0, height - 1, width - 3, height - 1);
            dc.draw_line(width - 1, 3, width - 1, height - 4);
            dc.draw_line(width - 3, height - 1, width - 1, height - 4);
         elseif t = TAB_BOTTOM then
            dc.set_foreground(hilite_color);
            dc.draw_line(0, 0, 0, height - 4);
            dc.draw_line(0, height - 4, 1, height - 2);
            dc.set_foreground(shadow_color);
            dc.fill_rectangle(2, height - 2, width - 4, 1);
            dc.draw_line(width - 2, 0, width - 2, height - 3);
            dc.fill_rectangle(width - 2, 0, 2, 1);
            dc.set_foreground(border_color);
            dc.draw_line(3, height - 1, width - 4, height - 1);
            dc.draw_line(width - 4, height - 1, width - 1, height - 4);
            dc.fill_rectangle(width - 1, 1, 1, height - 4);
         elseif t = TAB_TOP then
            dc.set_foreground(hilite_color);
            dc.fill_rectangle(0, 2, 1, height - 2);
            dc.draw_line(0, 2, 2, 0);
            dc.fill_rectangle(2, 0, width - 4, 1);
            dc.set_foreground(shadow_color);
            dc.draw_line(width - 2, 1, width - 2, height - 1);
            dc.set_foreground(border_color);
            dc.draw_line(width - 2, 1, width - 1, 2);
            dc.draw_line(width - 1, 2, width - 1, height - 2);
            dc.set_foreground(hilite_color);
            dc.draw_line(width - 1, height - 1, width - 1, height - 1);
         end
         if not label.is_empty then
            tw := label_width(label);
            th := label_height(label);
         end
         if icon /= Void then
            iw := icon.width;
            ih := icon.height;
         end
         pt := just_x(tw, iw);ix := pt.x; tx := pt.y;
         pt := just_y(th, ih);iy := pt.x; ty := pt.y;
         if icon /= Void then
            if is_enabled then
               dc.draw_icon(icon, ix, iy);
            else
               dc.draw_icon_sunken(icon, ix, iy);
            end
         end
         if not label.is_empty then
            dc.set_font(font);
            if is_enabled then
               dc.set_foreground(text_color);
               draw_label(dc, label, hot_off, tx, ty, tw, th);
               if has_focus then
                  dc.draw_focus_rectangle(border + 2, border + 2, width - 2 * border - 4, height - 2 * border - 4);
               end
            else
               dc.set_foreground(hilite_color);
               draw_label(dc, label, hot_off, tx + 1, ty + 1, tw, th);
               dc.set_foreground(shadow_color);
               draw_label(dc, label, hot_off, tx, ty, tw, th);
            end
         end
         dc.stop;
         Result := True
      end

   on_focus_in (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         Result := Precursor (sender,selector,data);
         update_rectangle(border,border,width-(border*2),height-(border*2));
         Result := True
      end

   on_focus_out (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         Result := Precursor (sender,selector,data);
         update_rectangle(border,border,width-(border*2),height-(border*2));
         Result := True
      end

   on_ungrabbed (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         Result := Precursor (sender,selector,data);
         unset_flags (Flag_pressed);
         flags := flags | Flag_update;
         Result := True
      end

   on_left_btn_press (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         tbc: SB_TAB_BAR_COMMANDS
      do
         if not Precursor(sender,selector,data) then
            if is_enabled then
               parent.do_handle_2 (Current, SEL_COMMAND, tbc.ID_OPEN_ITEM, data);
               flags := flags | Flag_pressed;
               unset_flags (Flag_update);
               Result := True
            end
         end
      end

   on_left_btn_release (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         if not Precursor(sender,selector,data) then
            if is_enabled then
               flags := flags | Flag_update;
               unset_flags (Flag_pressed);
               Result := True
            end
         end
      end

   on_key_press (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         event: SB_EVENT
         tbc: SB_TAB_BAR_COMMANDS
      do
         event ?= data
         check
            event /= Void
         end
         unset_flags (Flag_tip)
         if is_enabled then
            if message_target /= Void
               and then message_target.handle_2 (Current, SEL_KEYPRESS, message, data)
            then
              Result := True
            elseif event.code = sbk.key_space or else event.code = sbk.key_kp_space
             then
               parent.do_handle_2 (Current, SEL_COMMAND, tbc.ID_OPEN_ITEM, data);
               Result := True
            end
         end
      end

	on_key_release (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
    	local
        	event: SB_EVENT
      	do
         	event ?= data
         	check
            	event /= Void
         	end
         	if is_enabled then
            	if (message_target /= Void and then message_target.handle_2 (Current, SEL_KEYRELEASE, message, data))
               	or else (event.code = sbk.key_space or else event.code = sbk.key_kp_space)
             	then
               		Result := True
            	end
         	end
      	end

	on_hot_key_press (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
		local
			tbc: SB_TAB_BAR_COMMANDS
		do
         	do_handle_2 (Current, SEL_FOCUS_SELF, 0, data)
         	unset_flags (Flag_tip)
         	if is_enabled then
            	parent.do_handle_2 (Current, SEL_COMMAND, tbc.ID_OPEN_ITEM, data)
         	end
         	Result := True
      	end

	on_hot_key_release (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
		do
			Result := True
		end

feature {NONE} -- Implementation

	TAB_ORIENT_MASK: INTEGER
		once
			Result := (TAB_TOP | TAB_LEFT | TAB_RIGHT | TAB_BOTTOM)
		end

end
