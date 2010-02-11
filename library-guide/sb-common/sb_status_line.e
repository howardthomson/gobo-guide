indexing
	description: "[
		The status line normally shows its permanent message;
		when moving the mouse over a Widget which has status-line help, the
		status line temporarily replaces its normal message with the help information;
		the status line obtains the help message by sending the Widget a
		Id_query_help message with type SEL_UPDATE. If this query does not result
		in a new status string, the message_target of the status line is tried via
		an ordinary SEL_UPDATE message. If none of the above work then the status 
		line will display the normal text, i.e. the string set via set_normal_text.
		If the message contains a newline (\n), then the part before the newline will
		be displayed in the highlight color, while the part after the newline is
		is_shown using the normal text color."
	]"
	author: "Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright: "Copyright (c) 2002, Eugene Melekhov and others"
	license: "Eiffel Forum Freeware License v2 (see forum.txt)"
	status: "Mostly complete"

	todo: "[
		Add delay for update visibility on status change.

		Add popup history window facility, a sequence of past time/detail events.
	]"

class SB_STATUS_LINE

inherit
	SB_FRAME
      	rename
         	make	  as frame_make,
         	make_opts as frame_make_opts
      	redefine
         	default_width,
         	default_height,
         	create_resource,
         	detach_resource,
         	destruct,
         	handle_2,
         	on_update,
         	on_paint,
         	class_name,
         	
         -- #### Debugging only ###
         	trace_values,
         	create_resource_imp,
         	resize_imp
      	end

creation
   make,
   make_opts

feature -- class name

	class_name: STRING is
		once
			Result := "SB_STATUS_LINE"
		end

feature -- Creation

	make (p: SB_COMPOSITE) is
		do
			make_opts(p, Void, 0);
		end

   make_opts(p: SB_COMPOSITE; tgt: SB_MESSAGE_HANDLER; selector: INTEGER) is
      do
         frame_make_opts(p, Frame_sunken | Layout_left | Layout_fill_y | Layout_fill_x | Layout_side_bottom, 0,0,0,0, 4,4,2,2);
         flags := flags | Flag_shown
         text := default_message
         normal_text := default_message
         font := application.normal_font
         text_color := application.fore_color
         text_highlight_color := application.fore_color
         message_target := tgt
         message := selector
      end

feature -- Data

	text: STRING
		-- Current status message
		
	normal_text: STRING
		-- Normally displayed message
		
	font: SB_FONT
		-- Font
		
	text_color: INTEGER
		-- Status text color
		
	text_highlight_color: INTEGER
		-- Status text highlight color

feature -- Queries

	default_width: INTEGER is
			-- Get default width
		do
			Result := pad_left + pad_right + (border*2) + 8
		end

   	default_height: INTEGER is
         	-- Get default height
      	do
         	Result := font.get_font_height + pad_top + pad_bottom + (border*2)
      	end

feature -- Actions

	set_text(txt: STRING) is
			-- Change the temporary status message
		do
			if not text.is_equal(txt) then
				text := txt
				update
--				update_rectangle (border, border, width - (border*2), height - (border*2))
--				repaint_rectangle(border, border, width - (border*2), height - (border*2))
--				application.flush
			end
		end

   set_normal_text(txt: STRING) is
         -- Change the permanent status message
      do
         if not normal_text.is_equal(txt) then
            normal_text := txt
			update
--			update_rectangle (border, border, width - (border*2), height - (border*2))
--			repaint_rectangle(border, border, width - (border*2), height - (border*2))
--			application.flush
         end
      end

	set_font(fnt: SB_FONT) is
			-- Set the text font
		require
			fnt /= Void
		do
			if font /= fnt then
				font := fnt
				recalc
				update
			end
		end

   set_text_color(clr: INTEGER) is
         -- Change the text color
      do
         if text_color /= clr then
            text_color := clr
            update_rectangle (border, border, width - (border*2), height - (border*2))
         end
      end

   set_text_highlight_color(clr: INTEGER) is
         -- Change the text color
      do
         if text_highlight_color /= clr then
            text_highlight_color := clr
            update_rectangle (border, border, width - (border*2), height - (border*2))
         end
      end

feature -- Resource management

   create_resource is
      do
         Precursor
         font.create_resource
      end

   detach_resource is
      do
         Precursor
         font.detach_resource
      end

feature -- Message processing

	handle_2 (sender: SB_MESSAGE_HANDLER; type, key: INTEGER; data: ANY): BOOLEAN is
      	do
        	if		match_function_2 (SEL_COMMAND, Id_setstringvalue, type, key) then Result := on_cmd_set_string_value (sender, key, data)
         	elseif  match_function_2 (SEL_COMMAND, Id_getstringvalue, type, key) then Result := on_cmd_get_string_value (sender, key, data)
         	else Result := Precursor (sender, type, key, data)
         	end
      	end

	on_paint (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
		local
			ev: SB_EVENT
         	dc: SB_DC_WINDOW
         	ty, pos, len: INTEGER
      	do
         	ev ?= data
         	check
            	ev /= Void
         	end
         	dc := paint_dc
         	dc.make_event (Current, ev)
         	ty := pad_top + (height - pad_top - pad_bottom - font.get_font_height) // 2
         	dc.set_foreground (back_color)
         	dc.fill_rectangle (ev.rect_x, ev.rect_y, ev.rect_w, ev.rect_h);

		--	fx_trace(0, <<"SB_STATUS_LINE::on_paint: x/y/w/h: ",
		--		ev.rect_x.out, "/", ev.rect_y.out, "/", ev.rect_w.out, "/", ev.rect_h.out>>)
		--	print_run_time_stack
         	
         	if not text.is_empty then
            	dc.set_font (font)
            	pos := u.find_forward (text, '%N', 1)
            	len := text.count
            	if pos > 0 then
               		dc.set_foreground (text_highlight_color);
               		dc.draw_text_offset (pad_left, ty + font.get_font_ascent, text, pos, pos - len  + 1)
               		dc.set_foreground(text_color)
               		dc.draw_text_offset (pad_left + font.get_text_width_offset(text, 1, pos - 1),
                                   ty + font.get_font_ascent, text, pos + 1, len - pos)
            	else
               		dc.set_foreground (text_color)
               		dc.draw_text (pad_left, ty + font.get_font_ascent, text)
            	end
         	end
         	draw_frame (dc, 0, 0, width, height)
         	dc.stop
         	Result := True
		--	fx_trace(0, <<"SB_STATUS_LINE::on_paint">>)
		end

   on_update (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      local
         helpsource: SB_WINDOW
      do
         -- Regular GUI update
         Result := Precursor (sender, selector, data)

         helpsource := application.cursor_window
         if (helpsource = Void or else not helpsource.handle_2 (Current, SEL_UPDATE, Id_query_help, Void))
            and then
            (message_target = Void or else not message_target.handle_2 (Current, SEL_UPDATE, message, Void))
          then
            set_text(normal_text)
         end
         Result := True
      end

   on_cmd_get_string_value (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      local
         str: STRING
      do
         str ?= data
         check
            str /= Void
         end
         str.make_from_string (text)
         Result := True
      end

   on_cmd_set_string_value (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      local
         str: STRING
      do
         str ?= data
         set_text (str)
         Result := True
      end

feature -- Destruction

   destruct is
      do
         font := Void
         Precursor
      end


feature {NONE} -- Implementation

   default_message: STRING is "Ready."

feature -- Debugging

	trace_values is
		do
		--	fx_trace(0, <<"SB_STATUS_LINE::trace_values",
		--		" width: ", width.out,
		--		" height: ", height.out>>)
		end

	create_resource_imp is
		do
			Precursor
		--	fx_trace(0, <<"SB_STATUS_LINE::create_resource_imp",
		--		" width: ", width.out,
		--		" height: ", height.out>>)
		end

	resize_imp(w, h: INTEGER) is
		do
			fx_trace(0, <<"SB_STATUS_LINE::resize_imp before",
				" width: ", width.out,
				" height: ", height.out>>)
			Precursor(w, h)
			fx_trace(0, <<"SB_STATUS_LINE::resize_imp after",
				" width: ", width.out,
				" height: ", height.out>>)
		end	
invariant
--	rq_trace(<<out, " width: ", width.out>>)
end
