indexing
	description: "[
		Window for viewing/editing scanned symbol sequences.
		Edited symbols revert to Unscanned status.
	]"
	todo: "[
		Establish why changing #&~ operator to & ~ operator pair causes weird side effects
		with reports of mismatching arguments to prefix "+" and prefix "-" elsewhere in the code.
		
		Line 248 (approx) fix 'first_index_of' missing in STRING of free_elks
		
		Use OOSC Undo/Redo history structure for processing editing events.
	
		move_contents/scroll undraw/redraw cursor
			and/or adjust cursor display position
		cursor position defined by:
			symbol index
			character offset
			
		on_paint -
			only redraw symbols within the viewport!
			only redraw within the expose event area
			cache the symbol_number of the first visible line

		Need splittable, independently-scrollable areas
		Is it necessary to prevent/avoid simultaneous display of the same symbols in
		distinct split sections?

		Maintain and display cursor position.
		Make editable or read-only.
		Process key events.
		Provide for Undo/Redo
		Cut/Copy/Paste
		Align etc..
		Shift etc.
		Mouse wheel
		Mouse motion while key-down (grabbed)

		Mouse wheel in scroll_bar moves in pixels, not lines !!

		Provide for set_font
	]"
	done: "[
		on_paint -
			process strings etc for embedded tabs etc.
	]"
		
class EDP_SYMBOL_EDITOR

inherit

	SB_SCROLL_AREA
		rename
			make as make_scroll_area,
			Id_last as scroll_area_id_last
		redefine
			class_name,
			create_resource,
			content_width,
			content_height,
			can_focus,
			set_focus,
			kill_focus,
			handle_2,
			on_paint,
			on_left_btn_press,
			on_key_press,
			on_focus_in,
			on_focus_out,
			on_cmd_delete

			-- intercept scroll to cache first visible symbol index
		end

	EDP_GLOBAL

	EDP_SYMBOL_EDITOR_COMMANDS
		rename
			Id_last as Edp_symbol_editor_id_last
		select
			Frame_id_last
		end

	EDP_SYMBOL_EDITOR_CONSTANTS

	SB_KEYS
		export {NONE} all
		end

	POSITION_ROUTINES

create

	make

feature -- Attributes

	cursor_line,	-- Line on which cursor rests
	cursor_column	-- Column of cursor
		: INTEGER

	start_index,	-- first symbol index
	start_offset,	-- offset from lhs of first symbol
	end_index,		-- last symbol index
	end_offset		-- offset from lhs of last symbol
		: INTEGER	-- Selected text range

	blinker: SB_TIMER
			-- Blink timer

	scanner: SCANNER

	font: SB_FONT
	fw, fh: INTEGER		-- Font width,height
	ws: STRING			-- "w" string

	sel_back_color: INTEGER
			-- Background colour for selected text
	
feature -- Focus [ Move to event section when working ]

	can_focus: BOOLEAN is
			-- Tree List widget can receive focus
		once
			Result := True;
		end

	set_focus is
			-- Move the focus to this window
		do
			Precursor;
			set_default(SB_TRUE)
		end

	kill_focus is
			-- Remove the focus from this window
		do
			Precursor;
			set_default(SB_MAYBE)
		end

feature -- option values

	is_editable: BOOLEAN is
			-- Return True if text field may be edited
		do
			Result := (options & TEXTFIELD_READONLY) = Zero
		end

feature -- class name

	class_name: STRING is
		once
			Result := "SB_SYMBOL_EDITOR"
		end

feature -- Creation

	make (p: SB_COMPOSITE; s: SCANNER) is
		require
			valid_parent: p /= Void
			valid_scanner: s /= Void
		do
			scanner := s
			cursor_line := 1
			cursor_column := 1
				-- Note that invariant must be satisfied before calling make_scroll_area ....
			make_scroll_area (p, Layout_fill_x | Layout_fill_y)
         	flags := flags | Flag_enabled | Flag_caret;
        -- 	options := options | TEXTFIELD_READONLY
			font := application.normal_font
			sel_back_color := sbrgb (156,255,255)
		--	set_default_cursor (application.cursors @ Def_xsplit_cursor)
		end

	create_resource is
		do
			Precursor
			ws := once "w"
			fw := font.text_width_offset (ws, 1,1)
			fh := font.font_height
			v_scroll_bar.set_line_size (fh)

				-- This SHOULD not be necessary!
			if default_cursor /= Void then
				default_cursor.create_resource
			end

		end

feature -- Redefined routines

	content_width: INTEGER is
		do
			Result := scanner.max_column * fw + 1
		end

	content_height: INTEGER is
		do
			Result := scanner.max_line * fh + 1
		end

	on_paint (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
		local
			ev: SB_EVENT
			dc: SB_DC_WINDOW
		do
			ev ?= data
			check
				ev /= Void
			end
			dc := paint_dc
         	dc.make_event (Current, ev)

			dc.set_foreground (back_color)
			dc.fill_rectangle (ev.rect_x, ev.rect_y, ev.rect_w, ev.rect_h)

			dc.set_foreground (application.fore_color)
			draw_symbols (dc, ev)

         	if (flags & Flag_caret) /= Zero then
				dc_draw_cursor (dc, True)
			end
			
         	dc.stop
         	Result := True
		end

	draw_symbols (dc: SB_DC_WINDOW; ev: SB_EVENT) is
		local
			i: INTEGER					-- Symbol index
			s, s_next: SCANNER_SYMBOL	-- Scanner symbol
			t: STRING					-- Symbol text
			w_top, w_bottom: INTEGER
				-- Top and bottom of viewable window
			bw: INTEGER		-- background box
		do
			w_top := - pos_y
			w_bottom := - pos_y + height
			from
				i := 1	-- Should be cached first visible index
			until
				i > scanner.num_symbols
			loop
				s := scanner.symbol (i)
				if ((s.line + 1) * fh) >= w_top then
					t := s.text (scanner)
					if t.index_of ('%T', 1) /= 0 then
						t := expand_tabs (t, s.column)
					end
					if is_selected (i)
					or else s.is_match_fail	-- TEMP
					then
						dc.set_foreground (sel_back_color)
						if (i + 1) <= scanner.num_symbols then
							s_next := scanner.symbol (i + 1)
							if s_next.line /= s.line
							or else not (is_selected (i + 1) or else s_next.is_match_fail) then
								s_next := Void
							end
						end
						if s_next = Void then
							bw := t.count * fw
						else
							bw := (s_next.column - s.column) * fw
						end
						dc.fill_rectangle (
							pos_x + ((s.column - 1) * fw) + 3,		-- x
							pos_y + (s.line * fh) - font.ascent,	-- y
							bw,	fh)									-- width / height
						dc.set_foreground (application.fore_color)
					end
					dc.draw_text_offset (
						pos_x + ((s.column - 1) * fw) + 3,	-- x
						pos_y + ((s.line   - 1) * fh) + fh,	-- y	
						t, 1, t.count)
				end
				if (s.line - 1) * fh > w_bottom then
					-- break out of loop
					i := scanner.num_symbols
				end
				i := i + 1
			end
		end

	is_selected (i: INTEGER): BOOLEAN is
			-- Is the symbol @ i in the current selected text ?
			-- NB Does not account for partial symbol selection!
		do
			if start_index >= 1 and end_index >= start_index then
				Result := i >= start_index and i <= end_index
			end
		end

	draw_cursor (state: INTEGER) is
		local
			dc: SB_DC_WINDOW
		do
			if is_attached then
            	if (state.bit_xor(flags) & Flag_caret) /= Zero then
					dc := paint_dc
					dc.make(Current)
               		if (flags & Flag_caret) /= Zero then
                  		unset_flags (Flag_caret);
                  		dc_draw_cursor(dc, False)
               		else
               			dc_draw_cursor(dc, True)
                  		flags := flags | Flag_caret;
					end
					dc.stop
				end
			end
		end

	dc_draw_cursor (dc: SB_DC_WINDOW; draw: BOOLEAN) is
		local
			cx, cy: INTEGER	-- Cursor x,y
		do
			-- draw cursor
			dc.set_foreground (0x000000ff)	-- Red
			cx := pos_x + (cursor_column * fw) - fw + 2
			cy := pos_y + (cursor_line   * fh) - fh + 2
			if draw then
				dc.fill_rectangle (cx, cy, 1, fh)
			else
				update_rectangle (cx, cy, 1, fh)
			end
		end

	tab_expanded_string: STRING is
		once
			create Result.make (250)
		end

	expand_tabs(s: STRING; col: INTEGER): STRING is
		local
			es: STRING		-- local ref to destination string
			i: INTEGER		-- current source string index
			c: CHARACTER	-- current source character
			sc: INTEGER		-- string column
		do
			from
				es := tab_expanded_string; es.wipe_out
				i := 1
				sc := col
			until
				i > s.count
			loop
				c := s @ i
				if c /= '%T' then
					es.extend (c); sc := sc + 1
				else
					from
						es.extend (' '); sc := sc + 1
					until
						((sc - 1) & 3) = 0
					loop
						es.extend (' '); sc := sc + 1
					end
				end
				i := i + 1
			end
			Result := es
		end

feature -- event handling

	handle_2 (sender: SB_MESSAGE_HANDLER; type, key: INTEGER; data: ANY): BOOLEAN is
    	do
        	if		match_function_2 (Sel_timeout, ID_BLINK,			type, key) then Result := on_blink 					(sender,key,data)
       	-- 	elseif  match_function_2 (Sel_timeout, Id_autoscroll,		type, key) then Result := on_auto_scroll 			(sender,key,data)
       	-- 	elseif  match_function_2 (SEL_VERIFY,  0,					type, key) then Result := on_verify 				(sender,key,data)
       	-- 	elseif  match_function_2 (SEL_UPDATE,  0,					type, key) then Result := on_update 				(sender,key,data)

       	-- 	elseif  match_function_2 (SEL_UPDATE,  Id_query_tip,		type, key) then Result := on_query_tip 				(sender,key,data)
       	-- 	elseif  match_function_2 (SEL_UPDATE,  Id_query_help,		type, key) then Result := on_query_help 			(sender,key,data)

       	-- 	elseif  match_function_2 (SEL_UPDATE,  ID_TOGGLE_EDITABLE,	type, key) then Result := on_upd_toggle_editable 	(sender,key,data)
       	-- 	elseif  match_function_2 (SEL_UPDATE,  ID_CUT_SEL,			type, key) then Result := on_upd_have_selection 	(sender,key,data)
       	--	elseif  match_function_2 (SEL_UPDATE,  ID_COPY_SEL,			type, key) then Result := on_upd_have_selection 	(sender,key,data)
       	--	elseif  match_function_2 (SEL_UPDATE,  ID_PASTE_SEL,		type, key) then Result := on_upd_yes 				(sender,key,data)
       	--	elseif  match_function_2 (SEL_UPDATE,  ID_DELETE_SEL,		type, key) then Result := on_upd_have_selection 	(sender,key,data)
       	--	elseif  match_function_2 (SEL_UPDATE,  ID_SELECT_ALL,		type, key) then Result := on_upd_select_all 		(sender,key,data)

        	elseif  match_function_2 (SEL_COMMAND, ID_CURSOR_HOME,		type, key) then Result := on_cmd_cursor_home 		(sender,key,data)
        	elseif  match_function_2 (SEL_COMMAND, ID_CURSOR_HOME_LINE,	type, key) then Result := on_cmd_cursor_home_line	(sender,key,data)
       		elseif  match_function_2 (SEL_COMMAND, ID_CURSOR_END,		type, key) then Result := on_cmd_cursor_end 		(sender,key,data)
       		elseif  match_function_2 (SEL_COMMAND, ID_CURSOR_END_LINE,	type, key) then Result := on_cmd_cursor_end_line	(sender,key,data)
       	 	elseif  match_function_2 (SEL_COMMAND, ID_CURSOR_RIGHT,		type, key) then Result := on_cmd_cursor_right 		(sender,key,data)
       		elseif  match_function_2 (SEL_COMMAND, ID_CURSOR_LEFT,		type, key) then Result := on_cmd_cursor_left 		(sender,key,data)
       		elseif  match_function_2 (SEL_COMMAND, ID_CURSOR_UP,		type, key) then Result := on_cmd_cursor_up 			(sender,key,data)
       		elseif  match_function_2 (SEL_COMMAND, ID_CURSOR_DOWN,		type, key) then Result := on_cmd_cursor_down 		(sender,key,data)
       		elseif  match_function_2 (SEL_COMMAND, ID_BACKSPACE,		type, key) then Result := on_cmd_backspace 			(sender,key,data)
       		elseif  match_function_2 (SEL_COMMAND, Id_delete,			type, key) then Result := on_cmd_delete 			(sender,key,data)

       		elseif  match_function_2 (SEL_COMMAND, ID_MARK,				type, key) then Result := on_cmd_mark 				(sender,key,data)
       		elseif  match_function_2 (SEL_COMMAND, ID_EXTEND,			type, key) then Result := on_cmd_extend 			(sender,key,data)
       		elseif  match_function_2 (SEL_COMMAND, ID_SELECT_ALL,		type, key) then Result := on_cmd_select_all 		(sender,key,data)
       		elseif  match_function_2 (SEL_COMMAND, ID_DESELECT_ALL,		type, key) then Result := on_cmd_deselect_all 		(sender,key,data)
       		elseif  match_function_2 (SEL_COMMAND, ID_CUT_SEL,			type, key) then Result := on_cmd_cut_sel 			(sender,key,data)
       		elseif  match_function_2 (SEL_COMMAND, ID_COPY_SEL,			type, key) then Result := on_cmd_copy_sel 			(sender,key,data)
       		elseif  match_function_2 (SEL_COMMAND, ID_PASTE_SEL,		type, key) then Result := on_cmd_paste_sel 			(sender,key,data)
       		elseif  match_function_2 (SEL_COMMAND, ID_DELETE_SEL,		type, key) then Result := on_cmd_delete_sel 		(sender,key,data)
       		elseif  match_function_2 (SEL_COMMAND, ID_INSERT_STRING,	type, key) then Result := on_cmd_insert_string 		(sender,key,data)
       		elseif  match_function_2 (SEL_COMMAND, ID_TOGGLE_EDITABLE,	type, key) then Result := on_cmd_toggle_editable 	(sender,key,data)
        	else Result := Precursor(sender, type, key, data)
        	end
		end

   	on_focus_in (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      	do
         	Result := Precursor (sender, selector, data)
         	if is_editable then
            	if blinker = Void then
               		blinker := application.add_timeout (application.blink_speed, Current, ID_BLINK)
            	end
            	draw_cursor (Flag_caret)
         	end
    --   	if has_selection then
    --			update_rectangle (border, border, width - (border * 2), height - (border * 2))
    --		end
         	Result := True;
      	end

   	on_focus_out (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      	do
         	Result := Precursor (sender, selector, data)
         	if blinker /= Void then application.remove_timeout (blinker); blinker := Void end
         	draw_cursor (Zero)
    --	 	if has_selection then
    --	      	update_rectangle (border, border, width - (border * 2), height - (border * 2))
    --	   	end
      	end


	on_blink (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
		do
        	draw_cursor (flags.bit_xor (Flag_caret))
        	blinker := application.add_timeout (application.blink_speed, Current, ID_BLINK)
        	Result := False
      	end

	on_key_press (sender: SB_MESSAGE_HANDLER; key: INTEGER; data: ANY): BOOLEAN is
    	local
    		event: SB_EVENT
    	do
    		event ?= data
         	check
            	event /= Void
         	end
         	unset_flags (Flag_tip)
         	if is_enabled then
            	Result := True

            	if not event_key_press.emit_with_id_data (message, data) then

               		unset_flags (Flag_update);

               		inspect event.code

	                when key_right, key_kp_right then
	                  if not event.shift then
	                     event_command.process_with_id (ID_DESELECT_ALL).discard_result
	                  end
	                  event_command.process_with_id (ID_CURSOR_RIGHT).discard_result
	                  if event.shift then
	                     event_command.process_with_id (ID_EXTEND).discard_result
	                  else
	                     event_command.process_with_id (ID_MARK).discard_result
	                  end

	                when key_left, key_kp_left then
	                  if not event.shift then
	                     event_command.process_with_id (ID_DESELECT_ALL).discard_result
	                  end
					  event_command.process_with_id (ID_CURSOR_LEFT).discard_result

	                  if event.shift then
	                     event_command.process_with_id (ID_EXTEND).discard_result
	                  else
	                     event_command.process_with_id (ID_MARK).discard_result
	                  end

	                when key_up, key_kp_up then
	                --	fx_trace(0, <<"EDP_SYMBOL_EDITOR=> Up">>)
	                  if not event.shift then
	                     event_command.process_with_id (ID_DESELECT_ALL).discard_result
	                  end
	                  event_command.process_with_id (ID_CURSOR_UP).discard_result
	                  if event.shift then
	                     event_command.process_with_id (ID_EXTEND).discard_result
	                  else
	                     event_command.process_with_id (ID_MARK).discard_result
	                  end

	                when key_down, key_kp_down then
	                	if not event.shift then
	                		event_command.process_with_id (ID_DESELECT_ALL).discard_result
	                	end
	                  	event_command.process_with_id (ID_CURSOR_DOWN).discard_result
	                	if event.shift then
	                		event_command.process_with_id (ID_EXTEND).discard_result
	                	else
	                		event_command.process_with_id (ID_MARK).discard_result
	                	end

	              	when key_home, key_kp_home then
	                  if not event.shift then
	                     event_command.process_with_id (ID_DESELECT_ALL).discard_result
	                  end
	                  if event.control then
	                  	 event_command.process_with_id (ID_CURSOR_HOME).discard_result
	               	  else
	                  	 event_command.process_with_id (ID_CURSOR_HOME_LINE).discard_result
	                  end
	                  if event.shift then
	                     event_command.process_with_id (ID_EXTEND).discard_result
	                  else
	                     event_command.process_with_id (ID_MARK).discard_result
	                  end

	                when key_end, key_kp_end then
	                --	fx_trace (0, <<"EDP_SYMBOL_EDITOR=> End">>)
	                  if not event.shift then
	                     event_command.process_with_id (ID_DESELECT_ALL).discard_result
	                  end
	                  if event.control then
	                  	event_command.process_with_id (ID_CURSOR_END_LINE).discard_result
	                  else
	                  	event_command.process_with_id (ID_CURSOR_END).discard_result
	                  end
	                  if event.shift then
	                     event_command.process_with_id (ID_EXTEND).discard_result
	                  else
	                     event_command.process_with_id (ID_MARK).discard_result
	                  end

	                when key_insert, key_kp_insert then
	                --	fx_trace (0, <<"EDP_SYMBOL_EDITOR=> Insert">>)
	                  if event.control then
	                     event_command.process_with_id (ID_COPY_SEL).discard_result
	                  elseif event.shift then
	                     if is_editable then
	                        event_command.process_with_id (ID_PASTE_SEL).discard_result
	                     else
	                        application.beep;
	                     end
	                  else
	                     event_command.process_with_id (ID_TOGGLE_OVERSTRIKE).discard_result
	                  end

	                when key_delete, key_kp_delete then
	                --	fx_trace (0, <<"EDP_SYMBOL_EDITOR=> Delete">>)
	                  if is_editable then
	                     if has_selection then
	                        event_command.process_with_id (ID_DELETE_SEL).discard_result
	                     else
	                        event_command.process_with_id (Id_delete).discard_result
	                     end
	                  else
	                     application.beep;
	                  end

	                when key_backspace then
	                --	fx_trace (0, <<"EDP_SYMBOL_EDITOR=> Backspace">>)
	                  if is_editable then
	                     if has_selection then
	                        event_command.process_with_id (ID_DELETE_SEL).discard_result
	                     else
	                        event_command.process_with_id (ID_BACKSPACE).discard_result
	                     end
	                  else
	                     application.beep
	                  end

	                when key_return, key_kp_enter then -- Done
	                --	fx_trace (0, <<"EDP_SYMBOL_EDITOR=> Enter/Return">>)
	                  if is_editable then
	                     flags := flags | Flag_update;
	                     unset_flags (Flag_changed);
	                --#	 event_command.emit_with_id_data (message, contents).discard_result
	                  else
	                     application.beep
	                  end

	                when key_a then -- Select All
	                --	fx_trace (0, <<"EDP_SYMBOL_EDITOR=> Select-all">>)
	                  if event.control then
	                     event_command.process_with_id (ID_SELECT_ALL).discard_result
	                  else
	                     Result := make_ins (event);
	                  end

	                when key_x then -- CUT
	                --	fx_trace (0, <<"EDP_SYMBOL_EDITOR=> Cut">>)
	                  if not event.control then
	                     Result := make_ins (event);
	                  elseif event.code = key_f20 then
	                     if is_editable then
	                        event_command.process_with_id (ID_CUT_SEL).discard_result
	                     else
	                        application.beep
	                     end
	                   end

	                when key_c then -- COPY
	                --	fx_trace (0, <<"EDP_SYMBOL_EDITOR=> Copy">>)
	                  if not event.control then
	                     Result := make_ins (event);
	                  elseif event.code = key_f16 then
	                     event_command.process_with_id (ID_COPY_SEL).discard_result
	                  end

	                when key_v then -- PASTE
	                --	fx_trace (0, <<"EDP_SYMBOL_EDITOR=> Paste">>)
	                  if not event.control then
	                     Result := make_ins (event);
	                  elseif event.code = key_f18 then
	                     if is_editable then
	                        event_command.process_with_id (ID_PASTE_SEL).discard_result
	                     else
	                        application.beep;
	                     end
	                  end

				--	when key_page_up then -- PAGE_UP
				--		event_command.process_with_id (Id_page_up).discard_result

				--	when key_page_down then -- PAGE_DOWN
				--		event_command.process_with_id (Id_page_down).discard_result
				
	                else -- inspect default
	                --	fx_trace (0, <<"EDP_SYMBOL_EDITOR=> #other#">>)
	                	Result := make_ins (event)
	                end
            	end
			end
			if not Result then
			--	print_run_time_stack
				edp_trace.simple (0, "False Result for EDP_SYMBOL_EDITOR::on_key_press")
			end
		end

--############################### Cursor Position Events ##################################

	on_cmd_cursor_home (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
			-- Move cursor to start of text
		do
			set_cursor (1, 1)
        	Result := True
    	end

   	on_cmd_cursor_end (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
			-- Move cursor to end of text
      	do
      		-- TODO
        	Result := True
      	end

	on_cmd_cursor_home_line (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
			-- Move cursor to start of line
		do
			set_cursor (1, cursor_line)
        	Result := True
    	end

   	on_cmd_cursor_end_line (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
			-- Move cursor to end of line
      	do
      		-- TODO
        	Result := True
      	end

   	on_cmd_cursor_left (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      	do
			set_cursor (cursor_column - 1, cursor_line)
        	Result := True
      	end

   	on_cmd_cursor_right (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
			-- Move cursor right one character
      	do
			set_cursor (cursor_column + 1, cursor_line)
        	Result := True
      	end

   	on_cmd_cursor_up (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      	do
			set_cursor (cursor_column, cursor_line - 1)
        	Result := True
      	end

   	on_cmd_cursor_down (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      	do
			set_cursor(cursor_column, cursor_line + 1)
        	Result := True
      	end

   	on_cmd_cursor_page_up (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      	do
        	Result := True
      	end

   	on_cmd_cursor_page_down (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      	do
        	Result := True
      	end

--#################################### Selection events #########################################

   	on_cmd_mark (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      	do
        	Result := True
      	end

   	on_cmd_extend (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      	do
        	Result := True
      	end

   	on_cmd_select_all (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      	do
        	Result := True
      	end

   	on_cmd_deselect_all (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      	do
        	Result := True
      	end

   	on_cmd_copy_sel (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      	do
        	Result := True
      	end

--############################### Modifying Events ##############################################

   	on_cmd_insert_string (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
   			-- Insert new text at current cursor position
		local
			s: STRING
      	do
      		s ?= data
      			check s /= Void end

      	--	scanner.set_insertion_point(cursor_line, cursor_column, False)
      		scanner.insert_string (s, cursor_line, cursor_column)
      		cursor_column := cursor_column + 1

			update_rectangle (0, cursor_line * fh - font.ascent, width, fh)
        	Result := True
      	end

   	on_cmd_overstrike_string (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
   			-- Replace current selected text (if any) by new text
		local
			event: SB_EVENT
			s: STRING
      	do
      		s ?= data
      			check s /= Void end

      	--	scanner.set_insertion_point(cursor_line, cursor_column, False)
      		scanner.insert_string (s, cursor_line, cursor_column)
      		cursor_column := cursor_column + 1

			update_rectangle(0, cursor_line * fh - font.ascent, width, fh)
        	Result := True
      	end

   	on_cmd_backspace (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
   			-- Backspace and remove one character
		local
			last_line: INTEGER
			update_all: BOOLEAN
      	do
      	--	if selection /= Void then
      	--		scanner.delete_selection(selection)
      	--		set_cursor_from_selection(selection)
      	--		selection := Void
      	--	else
      			last_line := cursor_line
				scanner.delete_backward (cursor_line, cursor_column)
				set_cursor (scanner.cursor_column, scanner.cursor_line)
				if cursor_line /= last_line then
					update_all := True
				end
		--	end
			if update_all then
				update
			else
				update_current_line
			end
        	Result := True
      	end

   	on_cmd_delete (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
   			-- Delete one character, cursor stays put
      	do
--			scanner.set_insertion_point(cursor_line, cursor_column, True)
      	--	if selection /= Void then
      	--		scanner.delete_selection(selection)
      	--		set_cursor_from_selection(selection)
      	--		selection := Void
      	--	else
				scanner.delete_forward (cursor_line, cursor_column)
		--	end
        	Result := True
      	end

   	on_cmd_cut_sel (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
   			-- Cut the selected text, push on cut buffer
      	do
        	Result := True
      	end

   	on_cmd_paste_sel (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
   			-- Paste selection
      	do
        	Result := True
      	end

   	on_cmd_delete_sel (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
   			-- Delete the selection
      	do
        	Result := True
      	end

--##################################################

   	on_cmd_toggle_editable (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      	do
      		if (options & TEXTFIELD_READONLY) = Zero then
      			options := options | TEXTFIELD_READONLY
      		else
      			unset_options (TEXTFIELD_READONLY)
      		end
        	Result := True
      	end

--#############

	make_ins (event: SB_EVENT): BOOLEAN is
		do
			Result := True;
        	if (event.state & (CONTROLMASK | ALTMASK)) /= Zero
              or else event.text.is_empty or else event.text.item(1).code < 32 then
              	edp_trace.st ("make_ins -- control character!").d
            	Result := False
         	elseif is_editable then
            	if (options & TEXTFIELD_OVERSTRIKE) /= Zero then
             		do_handle_2 (Current, SEL_COMMAND, ID_OVERST_STRING, event.text)
            	else
               		do_handle_2 (Current, SEL_COMMAND, ID_INSERT_STRING, event.text)
       	    	end
         	else
            	application.beep
         	end
      	end


	on_left_btn_press (sender: SB_MESSAGE_HANDLER; key: INTEGER; data: ANY): BOOLEAN is
		local
			ev: SB_EVENT
		do
			Precursor(sender, key, data).discard_result
			ev ?= data
				check ev /= Void end
			set_cursor_xy (ev.win_x, ev.win_y).discard_result
			Result := True

			-- TEMP
--			scanner.place_cursor(cursor_line, cursor_column)
		end

	set_cursor (col, line: INTEGER) is
		local
			new_col, new_line: INTEGER
		do
		--	edp_trace.start (0, "set_cursor(").next(col.out).next(",").next(line.out).next(")").done
			if col < 1 then
				new_col := 1
			else
				new_col := col
			end
			if line < 1 then
				new_line := 1
			else
				new_line := line
			end
			set_cursor_xy (((new_col - 1) * fw) + pos_x, ((new_line - 1) * fh) + pos_y).discard_result
			check
				correct_line:	cursor_line = new_line
				correct_column:	cursor_column = new_col
			end
		end

	set_cursor_xy (ax, ay: INTEGER): BOOLEAN is
			-- Try to position cursor at x,y in window
		local
			l, c: INTEGER	-- Line/Column of click position
			i: INTEGER
		do
		--	edp_trace.start (0, "Before: cl/cc/i/o ").next(cursor_line.out).next("/").next(cursor_column.out).next("/")
		--		.next(cursor_index.out).next("/").next(cursor_offset.out).done
			l := ((ay - pos_y) // fh) + 1
			c := ((ax - pos_x) // fw) + 1
		--	edp_trace.st("set_cursor_xy - l/c: ").next(l.out).next("/").next(c.out).done
			draw_cursor (0)	-- Undraw cursor
			cursor_line := l
			cursor_column := c
			draw_cursor (Flag_caret)	-- Draw new cursor
		--	edp_trace.st ("set_cursor_xy(").n(ax.out).n(", ").n(ay.out).n("): cl/cc ").n(cursor_line.out).n("/").n(cursor_column.out).d
		end

	update_current_line is
			-- Update screen for current line
		do
			update_rectangle (0, cursor_line * fh - font.ascent, width, fh)
		end

invariant
	valid_scanner: scanner /= Void
	valid_line: cursor_line >= 1
	valid_column: cursor_column >= 1

	-- Selected text attributes
	valid_start_offset: start_offset >= 0
	valid_end_offset: end_offset >= 0
	valid_start_index: start_index = 0 or else (start_index >= 1 and start_index <= scanner.num_symbols)
	valid_end_index: end_index = 0 or else (end_index >= start_index and end_index <= scanner.num_symbols)
end