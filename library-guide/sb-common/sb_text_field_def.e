note
	description: "[
		A text field is a single-line text entry widget.

		The text field widget supports clipboard for cut-and-paste operations.

		Text input may be constrained to a certain format; the built-in
		capabilities support integer and real number entry constraints;
		additional constraints on the input may be implemented by intercepting
		the SEL_VERIFY message; a custom handler should examine the tentative
		input string passed in the message data, and return a value of "0"
		if the new input is accepted.
		
		During text entry, the text field sends a SEL_CHANGED message to its message_target,
		with the message data set to the current text value of type STRING.

		When the text is accepted by hitting ENTER, the SEL_COMMAND message is sent.
	]"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

   modifications: "[
		on_selection_request -- check for 'len /= 0' non-Zero length of selection to copy
		off by one second argument to STRING.substring altered
	]"

class SB_TEXT_FIELD_DEF

inherit

	SB_FRAME
		rename
			make_opts as frame_make_opts,
			make as frame_make,
			set_cursor_position as window_set_cursor_position,
			Id_last as FRAME_ID_LAST
		redefine
			make_ev,
			can_focus,
			default_height,
			default_width,
			layout,
			enable,
			disable,
			set_focus,
			kill_focus,
			create_resource,
			handle_2,
			on_update,
			on_cmd_delete,
			on_key_press,
			on_key_release,
			on_left_btn_press,
			on_left_btn_release,
			on_middle_btn_press,
			on_middle_btn_release,
			on_motion,
			on_paint,
			on_selection_lost,
			on_selection_gained,
			on_selection_request,
			on_clipboard_lost,
			on_clipboard_gained,
			on_clipboard_request,
			on_focus_in,
			on_focus_out,
			on_focus_self
		end

	SB_TEXT_FIELD_COMMANDS
	SB_TEXT_FIELD_CONSTANTS

	SB_KEYS
		export {NONE} all
		end

create

   make,
   make_opts

feature -- Creation

	make_ev
		do
			make (Void, 1, 0)
		end

   make (p: SB_COMPOSITE; ncols: INTEGER; opts: INTEGER)
         -- Construct text field wide enough to display ncols columns_count
      local
         o: INTEGER
      do
         if opts = Zero then
            o := TEXTFIELD_NORMAL
         else
            o := opts
         end
         make_opts (p, ncols, Void, 0, o, 0, 0, 0, 0,
                   DEFAULT_PAD, DEFAULT_PAD, DEFAULT_PAD, DEFAULT_PAD)
      end

   make_opts (p: SB_COMPOSITE; ncols: INTEGER; tgt: SB_MESSAGE_HANDLER; selector: INTEGER; opts: INTEGER;
             x,y, w,h, pl,pr,pt,pb: INTEGER)
         -- Construct text field wide enough to display ncols columns_count
      do
         frame_make_opts (p, opts, x, y, w, h, pl, pr, pt, pb)
         if ncols < 0 then
            columns_count := 0
         else
            columns_count := ncols
         end
         create contents.make_empty
         flags := flags | Flag_enabled
         
         message_target := tgt
         message := selector
         
         default_cursor := application.default_cursor (Def_text_cursor)
         drag_cursor	:= application.default_cursor (Def_text_cursor)
--print ("text_font being assigned ...%N")
         text_font		:= application.normal_font
         back_color		:= application.back_color
         text_color		:= application.fore_color
         sel_back_color := application.sel_back_color
         sel_text_color := application.sel_fore_color
         cursor_color	:= application.fore_color
         
         cursor_position := 0
         anchor_position := 0
         
         blinker := Void
         shift := 0
         
         create help_text.make_empty
         create tip_text.make_empty
      end

feature -- Data

	contents: STRING
			-- Edited text

	text_font: SB_FONT
			-- Text font
   
	text_color: INTEGER
			-- Text color

	sel_back_color: INTEGER
			-- Selected background color

	sel_text_color: INTEGER
			-- Selected text color

	cursor_color: INTEGER
			-- Color of the cursor
   
	cursor_position: INTEGER
			-- Cursor position

	anchor_position: INTEGER
			-- Anchor position
   
	columns_count: INTEGER
			-- Number of columns_count visible
   
	help_text: STRING
			-- Help string

	tip_text: STRING
			-- Tooltip

feature -- Queries

  default_width: INTEGER
         -- Return default width
      do
         Result := pad_left + pad_right + (border*2)
         			+ columns_count * text_font.get_text_width ("8")
      end

   default_height: INTEGER
         -- Return default height
      do
         Result := pad_top + pad_bottom + (border*2)
         			+ text_font.get_font_height
      end

   is_editable: BOOLEAN
         -- Return True if text field may be edited
      do
         Result := (options & TEXTFIELD_READONLY) = Zero
      end

   can_focus: BOOLEAN
         -- Returns true because a text field can receive focus
      once
         Result := True
      end

   get_justify: INTEGER
         -- Return text justification mode
      do
         Result := (options | JUSTIFY_MASK)
      end

   get_text_style: INTEGER
         -- Return text style
      do
         Result := (options | TEXTFIELD_MASK)
      end

   is_pos_selected (pos: INTEGER): BOOLEAN
      -- Return True if position pos is selected
      do
         Result := has_selection and then anchor_position.min (cursor_position) <= pos 
            and then pos <= anchor_position.max (cursor_position)
      end

   is_pos_visible(pos: INTEGER): BOOLEAN
      -- Return True if position is fully visible
      local
         x, len: INTEGER
      do
         len := contents.count
         if 0 <= pos and then pos <= len then
            x := coord(pos)
            Result := border+pad_left <= x and then x <= width-border-pad_right
         end
      end

feature -- Actions

   enable
         -- Enable text field
      do
         if (flags | Flag_enabled) = Zero then
            Precursor
            update
         end
      end

   disable
         -- Disable text field
      do
         if (flags | Flag_enabled) /= Zero then
            Precursor
            update
         end
      end

   set_focus
         -- Move the focus to this window
      do
         Precursor
         set_default (SB_TRUE)
         unset_flags (Flag_update)
      end

   kill_focus
         -- Remove the focus from this window
      do
         Precursor
         set_default (SB_MAYBE)
         flags := flags | Flag_update
         if (flags | Flag_changed) /= Zero then
            unset_flags (Flag_changed)
            if (options & TEXTFIELD_ENTER_ONLY) = Zero  
               and then message_target /= Void then
               message_target.do_handle_2 (Current, SEL_COMMAND, message, contents)
            end
         end
      end

   set_editable (edit: BOOLEAN)
         -- Change text field editability
      do
         if edit then
            unset_options (TEXTFIELD_READONLY)
         else
            options := options | TEXTFIELD_READONLY
         end
      end

   set_cursor_position (pos_: INTEGER)
         -- Set cursor position
      local
         len, pos: INTEGER
      do
         len := contents.count
         if		pos_ > len then pos := len
         elseif pos_ < 0 then pos := 0
         else 	pos := pos_
         end
         if cursor_position /= pos then
            draw_cursor(Zero)
            cursor_position := pos
            if is_editable and then has_focus then draw_cursor (Flag_caret) end
         end
      end

   set_anchor_position (pos_: INTEGER)
         -- Change anchor position
      local
         len, pos: INTEGER
      do
         len := contents.count
         if pos_ > len then pos := len
         elseif pos_ < 0 then pos := 0
         else pos := pos_ end
         anchor_position := pos
      end

   set_font (fnt: SB_FONT)
      require
         fnt /= Void
      do
        if text_font /= fnt then
           text_font := fnt
           recalc
           update
        end
      end

   set_text (text: STRING)
         -- Set the text
      local
         len: INTEGER
      do
         if not contents.is_equal (text) then
            len := text.count
            contents := text
            if anchor_position >len then anchor_position := len end
            if cursor_position > len then cursor_position := len end
            if anchor_position = cursor_position then release_selection end
            if is_attached then layout end
            make_pos_visible (cursor_position)
            update_rectangle (border, border, width-(border*2), height-(border*2))
         end
      end

  set_text_color (clr: INTEGER)
         -- Change text color
      do
         if text_color /= clr then
            text_color := clr
            update
         end
      end

   set_sel_back_color (clr: INTEGER)
         -- Change selected background color
      do
         if sel_back_color /= clr then
            sel_back_color := clr
            update
         end
      end

   set_sel_text_color (clr: INTEGER)
         -- Change selected text color
      do
         if sel_text_color /= clr then
           sel_text_color := clr
           update
         end
      end
      
	set_cursor_color (clr: INTEGER)
			-- Change color of the cursor
		do
         	if cursor_color /= clr then
           		cursor_color := clr
           		update
         	end
      	end

   set_columns_count (cols: INTEGER)
         -- Change width of text field in terms of number of columns_count * 
         -- `m'
      local
         ncols: INTEGER
      do
         ncols := cols
         if ncols < 0 then ncols := 0 end
         if columns_count /= ncols then
            shift := 0
            columns_count := ncols
            layout   -- This may not be necessary!
            recalc
            update
         end
      end

   set_justify (mode: INTEGER)
         -- Change text justification mode
      local
         opts: INTEGER
      do
         opts := new_options (mode, JUSTIFY_MASK)
         if options /= opts then
            shift := 0
            options := opts
            recalc
            update
         end
      end

   set_help_text (text: STRING)
         -- Set the status line help text
      do
         help_text := text
      end

   set_tip_text (text: STRING)
         -- Set the tool tip message
      do
         tip_text := text
      end

   set_text_style (style: INTEGER)
         -- Change text style
      local
         opts: INTEGER
      do
         opts := new_options (style, TEXTFIELD_MASK)
         if options /= opts then
            shift := 0
            options := opts
            recalc
            update
         end
      end

   select_all
         -- Select all text
      do
         set_anchor_position (0)
         set_cursor_position (contents.count)
         extend_selection (cursor_position)
      end

   set_selection (pos, len: INTEGER)
         -- Select len characters starting at given position pos
      do
         set_anchor_position (pos)
         set_cursor_position (pos+len)
         extend_selection (cursor_position)
      end

   extend_selection (pos_: INTEGER)
         -- Extend the selection from the anchor to the given position
      local
         types: ARRAY [INTEGER]
         l: INTEGER
         pos: INTEGER
         t: BOOLEAN
      do
         create types.make (1, 1)
         l := contents.count

         	-- Validate position
         if pos_ < 0 then pos := 0 
         elseif pos_ > l then pos := l;
         else pos := pos_ end

         	-- Got a selection at all?
         if anchor_position /= pos then
            types.put (string_type, 1)
            if not has_selection then
               t := acquire_selection (types)
            end
         else
            if has_selection then
               release_selection
            end
         end
         update_rectangle (border, border, width-(border*2), height-(border*2))
      end

   kill_selection
         -- Unselect the text
      do
         if has_selection then
            release_selection;
            update_rectangle (border, border, width-(border*2), height-(border*2))
         end
      end

   make_pos_visible (pos_: INTEGER)
         -- Scroll text to make the given position visible
      local
         cw, ll, rr, ww, oldshift, len, pos: INTEGER
      do
         if is_attached then
            oldshift := shift
            len := contents.count
            ll := border+pad_left
            rr := width-border-pad_right
            ww := rr-ll
            if pos_ > len then pos := len 
            elseif pos_ < 0 then pos := 0
            else pos := pos_ end

            if (options & JUSTIFY_RIGHT) /= Zero then
               check
                  shift >= 0
               end
               if (options & TEXTFIELD_PASSWD) /= Zero then
                  cw := text_font.get_text_width("*")*(len-pos)
               else
                  cw := text_font.get_text_width_offset(contents, pos+1, len-pos)
               end
               if shift-cw>0 then shift := cw
               elseif shift - cw < -ww then shift := cw - ww end
               check
                  shift >= 0
               end
            else
               check
                  shift <= 0
               end
               if (options & TEXTFIELD_PASSWD) /= Zero then
                  cw := text_font.get_text_width ("*") * pos
               else
                  cw := text_font.get_text_width_len (contents, pos)
               end
               if shift+cw<0 then shift := -cw
               elseif shift+cw >= ww then shift := ww-cw end
               check
                  shift <= 0
               end
            end
            if shift /= oldshift then
               update_rectangle (border, border, width-(border*2), height-(border*2))
            end
         end
      end

feature -- Message processing

	handle_2 (sender: SB_MESSAGE_HANDLER; type, key: INTEGER; data: ANY): BOOLEAN
    	do
        	if		match_function_2 (Sel_timeout, ID_BLINK,				type, key) then Result := on_blink 					(sender,key,data);
        	elseif  match_function_2 (Sel_timeout, Id_autoscroll,			type, key) then Result := on_auto_scroll 			(sender,key,data);
        	elseif  match_function_2 (SEL_VERIFY,  0,						type, key) then Result := on_verify 				(sender,key,data);
        	elseif  match_function_2 (SEL_UPDATE,  0,						type, key) then Result := on_update 				(sender,key,data);

        	elseif  match_function_2 (SEL_UPDATE,  Id_query_tip,			type, key) then Result := on_query_tip 				(sender,key,data);
        	elseif  match_function_2 (SEL_UPDATE,  Id_query_help,			type, key) then Result := on_query_help 			(sender,key,data);

        	elseif  match_function_2 (SEL_UPDATE,  ID_TOGGLE_EDITABLE,		type, key) then Result := on_upd_toggle_editable 	(sender,key,data);
        	elseif  match_function_2 (SEL_UPDATE,  ID_TOGGLE_OVERSTRIKE,	type, key) then Result := on_upd_toggle_overstrike 	(sender,key,data);
        	elseif  match_function_2 (SEL_UPDATE,  ID_CUT_SEL,				type, key) then Result := on_upd_have_selection 	(sender,key,data);
        	elseif  match_function_2 (SEL_UPDATE,  ID_COPY_SEL,				type, key) then Result := on_upd_have_selection 	(sender,key,data);
        	elseif  match_function_2 (SEL_UPDATE,  ID_PASTE_SEL,			type, key) then Result := on_upd_yes 				(sender,key,data);
        	elseif  match_function_2 (SEL_UPDATE,  ID_DELETE_SEL,			type, key) then Result := on_upd_have_selection 	(sender,key,data);
        	elseif  match_function_2 (SEL_UPDATE,  ID_SELECT_ALL,			type, key) then Result := on_upd_select_all 		(sender,key,data);

        	elseif  match_function_2 (SEL_COMMAND, Id_setvalue,				type, key) then Result := on_cmd_set_value 			(sender,key,data);
        	elseif  match_function_2 (SEL_COMMAND, Id_setintvalue,			type, key) then Result := on_cmd_set_int_value 		(sender,key,data);
        	elseif  match_function_2 (SEL_COMMAND, Id_setrealvalue,			type, key) then Result := on_cmd_set_real_value 	(sender,key,data);
        	elseif  match_function_2 (SEL_COMMAND, Id_setstringvalue,		type, key) then Result := on_cmd_set_string_value 	(sender,key,data);
        	elseif  match_function_2 (SEL_COMMAND, Id_getintvalue,			type, key) then Result := on_cmd_get_int_value 		(sender,key,data);
        	elseif  match_function_2 (SEL_COMMAND, Id_getrealvalue,			type, key) then Result := on_cmd_get_real_value 	(sender,key,data);
        	elseif  match_function_2 (SEL_COMMAND, Id_getstringvalue,		type, key) then Result := on_cmd_get_string_value 	(sender,key,data);

        	elseif  match_function_2 (SEL_COMMAND, ID_CURSOR_HOME,			type, key) then Result := on_cmd_cursor_home 		(sender,key,data);
        	elseif  match_function_2 (SEL_COMMAND, ID_CURSOR_END,			type, key) then Result := on_cmd_cursor_end 		(sender,key,data);
        	elseif  match_function_2 (SEL_COMMAND, ID_CURSOR_RIGHT,			type, key) then Result := on_cmd_cursor_right 		(sender,key,data);
        	elseif  match_function_2 (SEL_COMMAND, ID_CURSOR_LEFT,			type, key) then Result := on_cmd_cursor_left 		(sender,key,data);
        	elseif  match_function_2 (SEL_COMMAND, ID_MARK,					type, key) then Result := on_cmd_mark 				(sender,key,data);
        	elseif  match_function_2 (SEL_COMMAND, ID_EXTEND,				type, key) then Result := on_cmd_extend 			(sender,key,data);
        	elseif  match_function_2 (SEL_COMMAND, ID_SELECT_ALL,			type, key) then Result := on_cmd_select_all 		(sender,key,data);
        	elseif  match_function_2 (SEL_COMMAND, ID_DESELECT_ALL,			type, key) then Result := on_cmd_deselect_all 		(sender,key,data);
        	elseif  match_function_2 (SEL_COMMAND, ID_CUT_SEL,				type, key) then Result := on_cmd_cut_sel 			(sender,key,data);
        	elseif  match_function_2 (SEL_COMMAND, ID_COPY_SEL,				type, key) then Result := on_cmd_copy_sel 			(sender,key,data);
        	elseif  match_function_2 (SEL_COMMAND, ID_PASTE_SEL,			type, key) then Result := on_cmd_paste_sel 			(sender,key,data);
        	elseif  match_function_2 (SEL_COMMAND, ID_DELETE_SEL,			type, key) then Result := on_cmd_delete_sel 		(sender,key,data);
        	elseif  match_function_2 (SEL_COMMAND, ID_OVERST_STRING,		type, key) then Result := on_cmd_overst_string 		(sender,key,data);
        	elseif  match_function_2 (SEL_COMMAND, ID_INSERT_STRING,		type, key) then Result := on_cmd_insert_string 		(sender,key,data);
        	elseif  match_function_2 (SEL_COMMAND, ID_BACKSPACE,			type, key) then Result := on_cmd_backspace 			(sender,key,data);
        	elseif  match_function_2 (SEL_COMMAND, Id_delete,				type, key) then Result := on_cmd_delete 			(sender,key,data);
        	elseif  match_function_2 (SEL_COMMAND, ID_TOGGLE_EDITABLE,		type, key) then Result := on_cmd_toggle_editable 	(sender,key,data);
        	elseif  match_function_2 (SEL_COMMAND, ID_TOGGLE_OVERSTRIKE,	type, key) then Result := on_cmd_toggle_overstrike 	(sender,key,data);
        	else Result := Precursor(sender, type, key, data)
        	end
      end

   on_update(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         if not Precursor(sender, selector, data) then
            if (options & TEXTFIELD_AUTOHIDE) /= Zero and then is_shown then hide; recalc; end
            if (options & TEXTFIELD_AUTOGRAY) /= Zero then disable end
         end
         Result := True;
      end

   on_paint(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         ev: SB_EVENT
         dc: SB_DC_WINDOW
         xx: INTEGER
      do
         ev ?= data
         check
            ev /= Void
         end
         dc := paint_dc
         dc.make_event (Current, ev)

         	-- Draw frame
         draw_frame (dc, 0, 0, width, height)

         	-- Gray background if disabled
         if is_enabled then
            dc.set_foreground (back_color)
         else
            dc.set_foreground (base_color)
         end
         
         	-- Draw background
         dc.fill_rectangle(border, border, width-(border*2), height-(border*2))

         	-- Draw text, clipped against frame interior
         dc.set_clip_rectangle_coords (border, border, width-(border*2), height-(border*2))
         draw_text_range (dc, 0, contents.count)

         -- Draw caret
         if (flags & Flag_caret) /= Zero then
            xx := coord (cursor_position)-1
            dc.set_foreground (cursor_color)
            dc.fill_rectangle (xx, pad_top+border, 1, height-pad_bottom-pad_top-(border*2))
            dc.fill_rectangle (xx-2, pad_top+border, 5, 1)
            dc.fill_rectangle (xx-2, height-border-pad_bottom-1, 5, 1)
         end
         dc.stop
         Result := True
      end

   on_key_press (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         event: SB_EVENT
      do
         event ?= data;
         check
            event /= Void
         end
         unset_flags (Flag_tip)
         if is_enabled then
            Result := True
            if message_target = Void
               or else not message_target.handle_2 (Current, SEL_KEYPRESS, message, data)
             then
               unset_flags (Flag_update)

               inspect event.code

               when key_right, key_kp_right then
                  if (event.state & SHIFTMASK) = Zero then
                     do_handle_2 (Current, SEL_COMMAND, ID_DESELECT_ALL, Void);
                  end
                  do_handle_2 (Current, SEL_COMMAND, ID_CURSOR_RIGHT, Void);
                  if (event.state & SHIFTMASK) /= Zero then
                     do_handle_2 (Current, SEL_COMMAND, ID_EXTEND, Void);
                  else
                     do_handle_2 (Current, SEL_COMMAND, ID_MARK, Void);
                  end

               when key_left, key_kp_left then
                  if (event.state & SHIFTMASK) = Zero then
                     do_handle_2 (Current, SEL_COMMAND, ID_DESELECT_ALL, Void);
                  end
                  do_handle_2 (Current, SEL_COMMAND, ID_CURSOR_LEFT, Void);
                  if (event.state & SHIFTMASK) /= Zero then
                     do_handle_2 (Current, SEL_COMMAND, ID_EXTEND, Void);
                  else
                     do_handle_2 (Current, SEL_COMMAND, ID_MARK, Void);
                  end

               when key_home, key_kp_home then
                  if (event.state & SHIFTMASK) = Zero then
                     do_handle_2 (Current, SEL_COMMAND, ID_DESELECT_ALL, Void);
                  end
                  do_handle_2 (Current, SEL_COMMAND, ID_CURSOR_HOME, Void);
                  if (event.state & SHIFTMASK) /= Zero then
                     do_handle_2 (Current, SEL_COMMAND, ID_EXTEND, Void);
                  else
                     do_handle_2 (Current, SEL_COMMAND, ID_MARK, Void);
                  end

               when key_end, key_kp_end then
                  if (event.state & SHIFTMASK) = Zero then
                     do_handle_2 (Current, SEL_COMMAND, ID_DESELECT_ALL, Void);
                  end
                  do_handle_2 (Current, SEL_COMMAND, ID_CURSOR_END, Void);
                  if (event.state & SHIFTMASK) /= Zero then
                     do_handle_2 (Current, SEL_COMMAND, ID_EXTEND, Void);
                  else
                     do_handle_2 (Current, SEL_COMMAND, ID_MARK, Void);
                  end

               when key_insert, key_kp_insert then
                  if (event.state & CONTROLMASK) /= Zero then
                     do_handle_2 (Current, SEL_COMMAND, ID_COPY_SEL, Void);
                  elseif (event.state & SHIFTMASK) /= Zero then
                     if is_editable then
                        do_handle_2 (Current, SEL_COMMAND, ID_PASTE_SEL, Void);
                     else
                        application.beep;
                     end
                  else
                     do_handle_2 (Current, SEL_COMMAND, ID_TOGGLE_OVERSTRIKE, Void);
                  end

               when key_delete, key_kp_delete then
                  if is_editable then
                     if has_selection then
                        do_handle_2 (Current, SEL_COMMAND, ID_DELETE_SEL, Void);
                     else
                        do_handle_2 (Current, SEL_COMMAND, Id_delete, Void);
                     end
                  else
                     application.beep;
                  end

               when key_backspace then
                  if is_editable then
                     if has_selection then
                        do_handle_2 (Current, SEL_COMMAND, ID_DELETE_SEL, Void);
                     else
                        do_handle_2 (Current, SEL_COMMAND, ID_BACKSPACE, Void);
                     end
                  else
                     application.beep;
                  end

               when key_return, key_kp_enter then -- Done
                  if is_editable then
                     flags := flags | Flag_update;
                     unset_flags (Flag_changed);
                     if message_target /= Void then
                        message_target.do_handle_2 (Current, SEL_COMMAND, message, contents);
                     end
                  else
                     application.beep;
                  end

               when key_a then -- Select All
                  if (event.state & CONTROLMASK) = Zero then
                     Result := make_ins(event);
                  else
                     do_handle_2 (Current, SEL_COMMAND, ID_SELECT_ALL, Void);
                  end

               when key_x then -- CUT
                  if (event.state & CONTROLMASK) = Zero then
                     Result := make_ins(event);
                  elseif event.code = key_f20 then
                     if is_editable then
                        do_handle_2 (Current, SEL_COMMAND, ID_CUT_SEL, Void);
                     else
                        application.beep;
                     end
                   end
               when key_c then -- COPY
                  if (event.state & CONTROLMASK) = Zero then
                     Result := make_ins(event);
                  elseif event.code = key_f16 then
                     do_handle_2 (Current, SEL_COMMAND, ID_COPY_SEL, Void);
                  end

               when key_v then -- PASTE
                  if (event.state & CONTROLMASK) = Zero then
                     Result := make_ins(event);
                  elseif event.code = key_f18 then
                     if is_editable then
                        do_handle_2 (Current, SEL_COMMAND, ID_PASTE_SEL, Void);
                     else
                        application.beep;
                     end
                  end
               else
                  Result := make_ins(event);
               end
            end
         end
      end

   on_key_release(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         if message_target /= Void
            and then message_target.handle_2 (Current, SEL_KEYRELEASE, message, data)
          then
            Result := True;
         end
      end

   on_left_btn_press(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         ev: SB_EVENT;
         pos: INTEGER;
      do
         ev ?= data;
         check
            ev /= Void
         end
         unset_flags (Flag_tip);
         do_handle_2 (Current, SEL_FOCUS_SELF, 0, data);
         if is_enabled then
            Result := True;
            grab_mouse;
            if message_target = Void
               or else not message_target.handle_2 (Current, SEL_LEFTBUTTONPRESS, message, data)
             then
               if ev.click_count = 1 then
                  pos := index(ev.win_x);
                  set_cursor_position(pos);
                  if (ev.state & SHIFTMASK) /= Zero then
                     extend_selection(pos);
                  else
                     kill_selection;
                     set_anchor_position(pos);
                  end
                  make_pos_visible(pos);
                  flags := flags | Flag_pressed;
                  unset_flags (Flag_update);
               else
                  set_anchor_position(0);
                  set_cursor_position(contents.count);
                  extend_selection(contents.count);
                  make_pos_visible(cursor_position);
               end
            end
         end
      end

   on_left_btn_release(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         if is_enabled then
            Result := True;
            release_mouse;
            unset_flags (Flag_pressed);
            if message_target /= Void then
               message_target.do_handle_2 (Current, SEL_LEFTBUTTONRELEASE, message, data)
            end
         end
      end

   on_middle_btn_press(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         ev: SB_EVENT
         pos: INTEGER
      do

--      trace_switch(True)
      
         unset_flags (Flag_tip);
         do_handle_2 (Current, SEL_FOCUS_SELF, 0, data);
         if is_enabled then
            Result := True;
            grab_mouse;
            if message_target = Void
            or else not message_target.handle_2 (Current, SEL_MIDDLEBUTTONPRESS, message, data) then
				ev ?= data
				check ev /= Void end
               pos := index(ev.win_x);
               set_cursor_position(pos);
               set_anchor_position(pos);
               make_pos_visible(pos);
               update_rectangle(border, border, width - (border * 2), height - (border * 2));
               unset_flags (Flag_update);
            end
         end
 --        trace_switch(False)
         
      end

   on_middle_btn_release(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         len: INTEGER;
         dnd_data: STRING;
      do
         if is_enabled then
            Result := True;
            release_mouse;
            if message_target = Void
               or else not message_target.handle_2 (Current, SEL_MIDDLEBUTTONRELEASE, message, data)
             then
               -- Paste text from selection (X-Windows only)
               if is_editable then
                  dnd_data := get_dnd_data(FROM_SELECTION, string_type)
                  if dnd_data /= Void then
                     do_handle_2 (Current, SEL_COMMAND, ID_INSERT_STRING, dnd_data);
                  end
               else
                  application.beep;
               end
            end
         end
      end

   on_verify(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         p: STRING;
      do
         p ?= data;
         check
            p /= Void
         end

         -- Limit number of columns_count
         if (options & TEXTFIELD_LIMITED) /= Zero and then p.count > columns_count
            or else (options & TEXTFIELD_INTEGER) /= Zero and then not p.is_integer
            or else (options & TEXTFIELD_REAL) /= Zero and then not p.is_real
            or else message_target /= Void and then message_target.handle_2 (Current, SEL_VERIFY, message, data)
          then
            Result := True;
         end
      end

   on_motion(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         ev: SB_EVENT;
         t: INTEGER;
         tm: SB_TIMER;
      do
         ev ?= data;
         check
            ev /= Void
         end
         if (flags & Flag_pressed) /= Zero then
            if ev.win_x < (border + pad_left) or else (width - border - pad_right) < ev.win_x then
               tm := application.add_timeout(application.scroll_speed, Current, Id_autoscroll);
            else
               t := index(ev.win_x);
               if t /= cursor_position then
                  draw_cursor(Zero);
                  cursor_position := t;
                  extend_selection(cursor_position);
               end
            end
            Result := True;
         end
      end

   on_selection_lost(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         Result := Precursor(sender, selector, data);
         update;
         Result := True;
      end

   on_selection_gained(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         Result := Precursor(sender, selector, data);
         update;
         Result := True;
      end

	on_selection_request(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
    	local
        	event: SB_EVENT;
        	dnd_data: STRING
        	start, len: INTEGER
        	t: BOOLEAN;
      	do
        	if Precursor(sender, selector, data) then
            	-- The message_target wants to supply its own data for the selection
            	Result := True;
         	else
				event ?= data
				check event /= Void end
            	-- Return text of the selection
            	if event.target = string_type then
               		check
                  		(0 <= anchor_position and then anchor_position <= contents.count)
                  		and (0 <= cursor_position and then cursor_position <= contents.count)
               		end
               		if anchor_position < cursor_position then
                	  	start := anchor_position;
                	  	len := cursor_position - anchor_position;
               		else
                	  	start := cursor_position;
                	  	len := anchor_position - cursor_position;
               		end
					if len /= 0 then
               			if (options & TEXTFIELD_PASSWD) /= Zero then
                	  		create dnd_data.make_filled('*', len);      -- We shall not reveal the password!
               			else
                  			dnd_data := contents.substring(start+1, start+1 + len - 1);	-- MOD HAT 3-June-2002
               			end
               			t := set_dnd_data(FROM_SELECTION, string_type, dnd_data);
               			Result := True;
					end
            	end
        	end
		end

   on_clipboard_lost(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         Result := Precursor(sender, selector, data);
         create clipped.make_empty;
         Result := True;
      end

   on_clipboard_gained(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         Result := Precursor(sender, selector, data);
         Result := True;
      end

   on_clipboard_request(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         event: SB_EVENT;
         dnd_data: STRING;
         len: INTEGER
         t: BOOLEAN;
      do
         if Precursor(sender, selector, data) then
            -- The message_target wants to supply its own data for the selection
            Result := True;
         else
            event ?= data;
            check
               event /= Void
            end
            -- Return clipped text
            if event.target = string_type then
               len := clipped.count;
               if (options & TEXTFIELD_PASSWD) /= Zero then
                  create dnd_data.make_filled('*', len);      -- We shall not reveal the password!
               else
                  create dnd_data.make_from_string(clipped);
               end

               dnd_data.append_character('%U');

               t := set_dnd_data(FROM_CLIPBOARD, string_type, dnd_data);
               Result := True;
            end
         end
      end

   on_focus_self(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         event: SB_EVENT;
      do
         if Precursor(sender, selector, data) then
            event ?= data;
            check
               event /= Void
            end
            if event.type = SEL_KEYPRESS or else event.type = SEL_KEYRELEASE then
               do_handle_2 (Current, SEL_COMMAND, ID_SELECT_ALL, Void);
            end
            Result := True;
         end
      end

   on_focus_in(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         Result := Precursor(sender, selector, data);
         if is_editable then
            if blinker = Void then
               blinker := application.add_timeout(application.blink_speed, Current, ID_BLINK);
            end
            draw_cursor(Flag_caret);
         end
         if has_selection then
            update_rectangle(border, border, width-(border*2), height-(border*2));
         end
         Result := True;
      end

   on_focus_out(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         Result := Precursor(sender, selector, data);
         if blinker /= Void then application.remove_timeout(blinker); blinker := Void end
         draw_cursor(Zero);
         if has_selection then
            update_rectangle(border, border, width-(border*2), height-(border*2));
         end
      end

   on_blink(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         draw_cursor(flags.bit_xor(Flag_caret));
         blinker := application.add_timeout(application.blink_speed, Current, ID_BLINK);
         Result := False;
      end

	on_auto_scroll(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
    	local
    	--	buttons: INTEGER;
         	x, y, t, ll, rr, ww, tw, lim: INTEGER;
         	cp: SB_CURSOR_POSITION;
         	tm: SB_TIMER;
      	do

         	if (flags & Flag_pressed) /= Zero then
            	t := cursor_position;
            	cp := get_cursor_position;
            	if cp /= Void then
              		x := cp.x; y := cp.y;
    --          	buttons := cp.buttons;
            	end
            	ll := border+pad_left;
            	rr := width-border-pad_right;
            	ww := rr-ll;

            	if (options & TEXTFIELD_PASSWD) /= Zero then
               		tw := text_font.get_text_width("*") * contents.count;
            	else
               		tw := text_font.get_text_width(contents)
            	end
            	if (options & JUSTIFY_RIGHT) /= Zero then
               		lim := tw-ww;

               		-- Scroll left
               		if x<ll then
                  		if lim>0 then
                     		shift := shift + ll-x;
                     		if shift >= lim then
                        		shift := lim;
                     		else
                        		tm := application.add_timeout(application.scroll_speed, Current, Id_autoscroll);
                     		end
                  		end
                  		t := index(ll);
               		end

               		-- Scroll right
               		if rr<x then
                  		if lim > 0 then
                     		shift := shift + rr-x;
                     		if shift <= 0 then
                        		shift := 0;
                     		else
                        		tm := application.add_timeout(application.scroll_speed, Current, Id_autoscroll);
                     		end
                  		end
                  		t := index(rr);
               		end
               		check
                  		shift >= 0
               		end
            	else
               		lim := ww-tw;

               		-- Scroll left
               		if x < ll then
                  		if lim < 0 then
                     		shift := shift + ll-x;
                     		if shift >= 0 then
                        		shift := 0;
                     		else
                        		tm := application.add_timeout(application.scroll_speed, Current, Id_autoscroll);
                     		end
                  		end
                  		t := index(ll);
               		end

               		-- Scroll right
               		if rr < x then
                  		if lim < 0 then
                     		shift := shift + rr - x;
                     		if shift <= lim then
                        		shift := lim;
                     		else
                        		tm := application.add_timeout(application.scroll_speed, Current, Id_autoscroll);
                     		end
                  		end
                  		t := index(rr);
               		end
               		check
                  		shift <= 0
               		end
            	end

            	-- Extend the selection
            	if t /= cursor_position then
               		draw_cursor(Zero);
               		cursor_position := t;
               		extend_selection(cursor_position);
            	end
         	end
         	Result := True;
      	end

   on_query_help(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         if not help_text.is_empty and then (flags & Flag_help) /= Zero then
            sender.do_handle_2 (Current, SEL_COMMAND, Id_setstringvalue, help_text);
            Result := True;
         end
      end

   on_query_tip(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         if not tip_text.is_empty and then (flags & Flag_tip) /= Zero then
            sender.do_handle_2 (Current, SEL_COMMAND, Id_setstringvalue, tip_text);
            Result := True;
         end
      end

   on_cmd_set_value, on_cmd_set_string_value(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         text: STRING
      do
         text ?= data;
         check
            text /= Void
         end
         set_text(text);
         Result := True;
      end

   on_cmd_get_string_value (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         str: STRING;
      do
         str ?= data;
         check
            str /= Void
         end
         str.make_from_string(contents);
         Result := True;
      end

   on_cmd_set_int_value(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         i: INTEGER_REF;
      do
         i ?= data
         check
            i /= Void
         end
         set_text(i.out);
         Result := True;
      end

   on_cmd_set_real_value(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         i: REAL_REF;
      do
         i ?= data
         check
            i /= Void
         end
         set_text(i.out);
         Result := True;
      end

   on_cmd_get_int_value(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         i: INTEGER_REF;
      do
         i ?= data
         check
            i /= Void
         end
         i.set_item(contents.to_integer);
         Result := True;
      end

   on_cmd_get_real_value(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         i: REAL_REF;
      do
         i ?= data
         check
            i /= Void
         end
         i.set_item(contents.to_real);
         Result := True;
      end

   on_cmd_cursor_home(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         set_cursor_position(0);
         make_pos_visible(0);
         Result := True;
      end

   on_cmd_cursor_end(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         set_cursor_position(contents.count);
         make_pos_visible(cursor_position);
         Result := True;
      end

   on_cmd_cursor_right(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         set_cursor_position(cursor_position+1);
         make_pos_visible(cursor_position);
         Result := True;
      end

   on_cmd_cursor_left(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         set_cursor_position(cursor_position-1);
         make_pos_visible(cursor_position);
         Result := True;
      end

   on_cmd_mark(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         set_anchor_position(cursor_position);
         Result := True;
      end

   on_cmd_extend (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         extend_selection (cursor_position)
         Result := True
      end

   on_cmd_select_all (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         select_all
         make_pos_visible (cursor_position)
         Result := True
      end

   on_cmd_deselect_all (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         kill_selection
         Result := True
      end

   on_cmd_cut_sel (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         types: ARRAY [INTEGER]
      do
         if has_selection then
            if is_editable then
               create types.make (1, 1)
               types.put (string_type, 1)
               if acquire_clipboard (types) then
                  if anchor_position < cursor_position then
                     clipped := contents.substring (anchor_position + 1, cursor_position - 1)
                  else
                     clipped := contents.substring (cursor_position, anchor_position - 1)
                  end
                  do_handle_2 (Current, SEL_COMMAND, ID_DELETE_SEL, Void)
               end
            else
               application.beep
            end
         end
         Result := True
      end

   on_cmd_copy_sel (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         types: ARRAY [INTEGER]
      do
         if has_selection then
            create types.make (1, 1)
            types.put (string_type, 1)
            if acquire_clipboard (types) then
               if anchor_position < cursor_position then
                  clipped := contents.substring (anchor_position + 1, cursor_position)
               else
                  clipped := contents.substring (cursor_position + 1, anchor_position)
               end
            end
         end
         Result := True
      end

   on_cmd_paste_sel (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         dnd_data, str: STRING
         i, e: INTEGER
      do
         if is_editable then
            if has_selection then
               do_handle_2 (Current, SEL_COMMAND, ID_DELETE_SEL, Void)
            end
            dnd_data := get_dnd_data (FROM_CLIPBOARD, string_type)
            if dnd_data /= Void then
               create str.make_empty
               from
                  i := 1
                  e := dnd_data.count
               until
                  i > e or else dnd_data.item (i) = '%U'
               loop
                  str.append_character (dnd_data.item (i))
                  i := i + 1
               end
               do_handle_2 (Current, SEL_COMMAND, ID_INSERT_STRING, str)
            end
         else
            application.beep
         end
         Result := True
      end

   on_cmd_delete_sel(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         st, en: INTEGER;
      do
         if has_selection then
            st := anchor_position.min (cursor_position)
            en := anchor_position.max (cursor_position)
            set_cursor_position (st)
            set_anchor_position (st)
            contents.remove_substring (st + 1, en)
            layout
            make_pos_visible (st)
            kill_selection
            flags := flags | Flag_changed
            if message_target /= Void then
               message_target.do_handle_2 (Current, SEL_CHANGED, message, contents)
            end
         end
         Result := True
      end

   on_cmd_overst_string (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         str, tentative: STRING
         len: INTEGER
         reppos, replen: INTEGER
      do
         str ?= data check str /= Void end
         reppos := cursor_position
         if has_selection then
            reppos := anchor_position.min (cursor_position)
            replen := anchor_position.max (cursor_position) - reppos
         end 
         create tentative.make_from_string (contents)
         len := str.count
         tentative.replace_substring(str, reppos + 1, reppos + replen)
         if handle_2 (Current, SEL_VERIFY, 0, tentative) then
            application.beep;
         else
            set_cursor_position (reppos)
            set_anchor_position (reppos)
            contents := tentative
            layout
            set_cursor_position (reppos + len)
            set_anchor_position (reppos + len)
            make_pos_visible (reppos + len)
            kill_selection
            update_rectangle (border, border, width - (border * 2), height - (border * 2))
            flags := flags | Flag_changed
            do_send (SEL_CHANGED, contents)
            Result := True
         end
      end

   on_cmd_insert_string (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         str, tentative: STRING
         len: INTEGER
         reppos, replen: INTEGER
      do
         str ?= data check str /= Void end
         reppos := cursor_position
         if has_selection then
            reppos := anchor_position.min (cursor_position)
            replen := anchor_position.max (cursor_position) - reppos
         end 
         create tentative.make_from_string (contents)
         len := str.count
         tentative.remove_substring(reppos + 1, reppos + replen)
         tentative.insert_string(str, reppos + 1)
         if handle_2 (Current, SEL_VERIFY, 0, tentative) then
            application.beep
         else
            set_cursor_position (reppos)
            set_anchor_position (reppos)
            contents := tentative
            layout
            set_cursor_position (reppos + len)
            set_anchor_position (reppos + len)
            make_pos_visible (reppos+len)
            kill_selection
            update_rectangle (border, border, width - (border * 2), height - (border * 2))
            flags := flags | Flag_changed
            if message_target /= Void then
               message_target.do_handle_2 (Current, SEL_CHANGED, message, contents)
            end
         end
         Result := True
      end

   on_cmd_backspace (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         if cursor_position<1 then
            application.beep
         else
            set_cursor_position (cursor_position - 1)
            set_anchor_position (cursor_position)
            contents.remove (cursor_position + 1)
            layout
            make_pos_visible (cursor_position)
            update_rectangle (border, border, width - (border * 2), height - (border * 2))
            flags := flags | Flag_changed
            if message_target /= Void then
               message_target.do_handle_2 (Current, SEL_CHANGED, message, contents)
            end
         end
         Result := True
      end

   on_cmd_delete (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         if cursor_position >= contents.count then
            application.beep
         else
            contents.remove(cursor_position+1)
            layout
            set_cursor_position(cursor_position)
            set_anchor_position(cursor_position)
            make_pos_visible(cursor_position)
            update_rectangle(border, border, width-(border*2), height-(border*2))
            flags := flags | Flag_changed
            if message_target /= Void then
               message_target.do_handle_2 (Current, SEL_CHANGED, message, contents)
            end
         end
         Result := True
      end

   on_cmd_toggle_editable(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         options := options.bit_xor(TEXTFIELD_READONLY);
         Result := True;
      end

   on_upd_toggle_editable(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         if (options & TEXTFIELD_READONLY) /= Zero then
            sender.do_handle_2 (Current, SEL_COMMAND, Id_uncheck, Void);
         else
            sender.do_handle_2 (Current, SEL_COMMAND, Id_check, Void);
         end
         sender.do_handle_2 (Current, SEL_COMMAND, Id_show, Void);
         sender.do_handle_2 (Current, SEL_COMMAND, Id_enable, Void);
         Result := True
      end

   on_cmd_toggle_overstrike(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         options := options.bit_xor (TEXTFIELD_OVERSTRIKE)
         Result := True
      end

   on_upd_toggle_overstrike(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         if (options & TEXTFIELD_OVERSTRIKE) /= Zero then
            sender.do_handle_2 (Current, SEL_COMMAND, Id_check, Void);
         else
            sender.do_handle_2 (Current, SEL_COMMAND, Id_uncheck, Void);
         end
         sender.do_handle_2 (Current, SEL_COMMAND, Id_show, Void);
         sender.do_handle_2 (Current, SEL_COMMAND, Id_enable, Void);
         Result := True
      end

   on_upd_have_selection(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         if has_selection then
            sender.do_handle_2 (Current, SEL_COMMAND, Id_enable, data)
         else
            sender.do_handle_2 (Current, SEL_COMMAND, Id_disable, data)
         end
         Result := True
      end

   on_upd_select_all(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         if contents.is_empty then
            sender.do_handle_2 (Current, SEL_COMMAND, Id_disable, data)
         else
            sender.do_handle_2 (Current, SEL_COMMAND, Id_enable, data)
         end
         Result := True
      end

feature -- Resource management

   create_resource
         -- Create server-side resources
      do
         Precursor
         text_font.create_resource
      end

feature {NONE} -- Implementation

   TEXTFIELD_MASK: INTEGER
      once
         Result := (TEXTFIELD_PASSWD | TEXTFIELD_INTEGER | TEXTFIELD_REAL | TEXTFIELD_READONLY
                    | TEXTFIELD_ENTER_ONLY | TEXTFIELD_LIMITED | TEXTFIELD_OVERSTRIKE 
                    | TEXTFIELD_AUTOGRAY | TEXTFIELD_AUTOHIDE)
      end

   blinker: SB_TIMER
         -- Blink timer

   shift: INTEGER
         -- Shift amount

   clipped: STRING
         -- Clipped text

   index (a_x: INTEGER): INTEGER
      local
         x,len, cx,cw: INTEGER
         done: BOOLEAN
      do
         len := contents.count
         x := a_x

         if (options & JUSTIFY_RIGHT) /= Zero then
            check
               shift >= 0
            end
            x := x - (shift + width - border - pad_right)
            if x > 0 then
               Result := len
            elseif (options & TEXTFIELD_PASSWD) /= Zero then
               cw := text_font.get_text_width ("*")
               Result := len + (x - (cw // 2)) // cw
               if Result<0 then Result := 0 end
               check
                  0 <= Result and then Result <= len
               end
            else
               cx := 0
               Result := len
               from
               until
                  0 >= Result or else done
               loop
                  check
                     0 < Result
                  end
                  cw := text_font.get_text_width_offset (contents, Result - 1 + 1, 1)
                  if x > (cx - (cw // 2)) then
                     done := true
                  else
                     cx := cx - cw
                     Result := Result - 1
                  end
               end
               check
                  0 <= Result and then Result <= len
               end
            end
         else
            check
               shift <= 0
            end
            x := x - shift - border - pad_left
            if x < 0 then
               Result := 0
            elseif (options & TEXTFIELD_PASSWD) /= Zero then
               cw := text_font.get_text_width ("*")
               Result := (x + (cw // 2)) // cw
               if Result>len then Result := len end
               check
                  0 <= Result and then Result <= len
               end
            else
               cx := 0
               Result := 0
               from
               until
                  Result >= len or else done
               loop
                  check
                     Result <= len
                  end
                  cw := text_font.get_text_width_offset (contents, Result + 1, 1)
                  if x < (cx + (cw // 2)) then
                     done := True
                  else
                     cx := cx + cw
                     Result := Result + 1
                  end
               end
               check
                  0 <= Result and then Result <= len
               end
            end
         end
      end

   coord (i: INTEGER): INTEGER
         -- Find coordinate from index
      require
         0 <= i and then i <= contents.count
      do
         if (options & JUSTIFY_RIGHT) /= Zero then
            if(options & TEXTFIELD_PASSWD) /= Zero then
               Result := shift + width - border - pad_right - text_font.get_text_width("*") * (contents.count - i)
            else
               Result := shift + width - border - pad_right - text_font.get_text_width_offset(contents, i + 1, contents.count - i)
            end
         else
            if (options & TEXTFIELD_PASSWD) /= Zero then
               Result := shift + border + pad_left + text_font.get_text_width("*") * i
            else
               Result := shift + border + pad_left + text_font.get_text_width_len(contents, i)
            end
         end
      end

   layout
      local
         ll, rr, ww, tw, len: INTEGER
      do
         if is_attached then
            len := contents.count
            ll := border + pad_left
            rr := width - border - pad_right
            ww := rr - ll
            if ww <= 0 then
               shift := 0
            else
               if (options & TEXTFIELD_PASSWD) /= Zero then
                  tw := text_font.get_text_width("*") * len
               else
                  tw := text_font.get_text_width(contents)
               end
               if (options & JUSTIFY_RIGHT) /= Zero then
                  if shift < 0 then shift := 0 end
                  if ww >= tw then shift := 0
                  elseif shift + ww > tw then shift := tw - ww end
                  check
                     shift >= 0
                  end
               else
                  if shift > 0 then shift := 0 end
                  if ww >= tw then
                  	shift := 0
                  elseif shift + tw < ww then
                  	shift := ww - tw
                  end
               end
            end
            update;
            unset_flags (Flag_dirty)
         end
      end

   draw_cursor (state: INTEGER)
      local
         cl, ch, xx, len: INTEGER;
         dc: SB_DC_WINDOW
      do
         if is_attached then
            if (state.bit_xor (flags) & Flag_caret) /= Zero then
            	dc := paint_dc
               dc.make (Current)
               len := contents.count
               check
                  (0 <= cursor_position and then cursor_position <= len)
                  (0 <= anchor_position and then anchor_position <= len)
               end
               xx := coord (cursor_position) - 1
               dc.set_clip_rectangle_coords (border, border, width - (border * 2), height - (border * 2))
               if (flags & Flag_caret) /= Zero then
                  dc.set_foreground (back_color)
                  dc.fill_rectangle (xx, pad_top + border, 1, height - pad_bottom - pad_top - (border * 2))
                  dc.fill_rectangle (xx-2, pad_top+border, 5, 1)
                  dc.fill_rectangle (xx-2, height - border - pad_bottom - 1, 5, 1)
                  cl := cursor_position - 1
                  ch := cursor_position + 1
                  draw_text_range (dc, cl.max (0), ch.min (len))     -- Gotta redraw these letters...
                  unset_flags (Flag_caret)
               else
                  dc.set_foreground (cursor_color)
                  dc.fill_rectangle (xx, pad_top+border, 1, height-pad_bottom-pad_top-(border*2))
                  dc.fill_rectangle (xx-2, pad_top+border, 5, 1)
                  dc.fill_rectangle (xx-2, height-border-pad_bottom-1, 5, 1)
                  flags := flags | Flag_caret
               end
               dc.stop
            end
         end
      end

   draw_text_range (dc: SB_DC_WINDOW; fm, to: INTEGER)
      local
         sx, ex, xx, yy, cw, hh, ww, si, ei: INTEGER
      do
         if to > fm then
            dc.set_font (text_font)
            	-- Text color
            dc.set_foreground (text_color)
            	-- Height
            hh := text_font.get_font_height

            if (options & JUSTIFY_TOP) /= Zero  and then (options & JUSTIFY_BOTTOM) /= Zero then
               -- Text centered in y
               yy := border + pad_top + (height - pad_bottom - pad_top - (border * 2) - hh) // 2
            elseif (options & JUSTIFY_TOP) /= Zero then
               -- Text sticks to top of field
               yy := pad_top + border
            elseif (options & JUSTIFY_BOTTOM) /= Zero then
               -- Text sticks to bottom of field
               yy := height - pad_bottom - border - hh
            else
               -- Text centered in y
               yy := border + pad_top + (height - pad_bottom - pad_top - (border * 2) - hh) // 2
            end

            if anchor_position < cursor_position then
               si := anchor_position
               ei := cursor_position
            else
               si := cursor_position
               ei := anchor_position
            end

            if (options & TEXTFIELD_PASSWD) /= Zero then
               -- Password mode
               cw := text_font.get_text_width ("*")
               ww := cw * contents.count

               -- Text sticks to right of field
               if (options & JUSTIFY_RIGHT) /= Zero then
                  xx := shift + width - border - pad_right - ww
               else
                  -- Text on left is the default
                  xx := shift + border + pad_left
               end

               if not has_selection or else to <= si or else ei <= fm then
                  -- Nothing selected
                  draw_pwdtext_fragment (dc, xx, yy, fm, to);
               else
                  -- Stuff selected
                  if fm < si then
                     draw_pwdtext_fragment (dc, xx, yy, fm, si)
                  else
                     si := fm;
                  end
                  if ei<to then
                     draw_pwdtext_fragment (dc, xx, yy, ei, to);
                  else
                     ei := to
                  end
                  if si < ei then
                     sx := xx + cw * si
                     ex := xx + cw * ei
                     if has_focus then
                        dc.set_foreground (sel_back_color)
                        dc.fill_rectangle (sx, pad_top + border, ex - sx, height - pad_top - pad_bottom - (border * 2))
                        dc.set_foreground (sel_text_color)
                        draw_pwdtext_fragment (dc, xx, yy, si, ei)
                     else
                        dc.set_foreground (base_color)
                        dc.fill_rectangle (sx, pad_top+border, ex-sx, height-pad_top-pad_bottom-(border*2));
                        dc.set_foreground (text_color)
                        draw_pwdtext_fragment (dc, xx, yy, si, ei)
                     end
                  end
               end
            else
               -- Normal mode
               ww := text_font.get_text_width (contents)
               if (options & JUSTIFY_RIGHT) /= Zero then
                  -- Text sticks to right of field
                  xx := shift + width - border - pad_right - ww
               else
                  -- Text on left is the default
                  xx := shift + border + pad_left
               end

               if not has_selection or else to <= si or else ei <= fm then
                  -- Nothing selected
                  draw_text_fragment (dc, xx, yy, fm, to)
               else
                  -- Stuff selected
                  if fm < si then
                     draw_text_fragment (dc, xx, yy, fm, si)
                  else
                     si := fm
                  end
                  if ei < to then
                     draw_text_fragment (dc, xx, yy, ei, to)
                  else
                     ei := to
                  end
                  if si < ei then
                     sx := xx + text_font.get_text_width_len (contents, si)
                     ex := xx + text_font.get_text_width_len (contents, ei)
                     if has_focus then
                        dc.set_foreground (sel_back_color)
                        dc.fill_rectangle (sx, pad_top + border, ex - sx, height - pad_top - pad_bottom - (border * 2))
                        dc.set_foreground (sel_text_color)
                        draw_text_fragment (dc, xx, yy, si, ei)
                     else
                        dc.set_foreground (base_color)
                        dc.fill_rectangle (sx, pad_top + border, ex - sx, height - pad_top - pad_bottom - (border * 2))
                        dc.set_foreground (text_color)
                        draw_text_fragment (dc, xx, yy, si, ei)
                     end
                  end
               end
            end
         end
      end

   draw_text_fragment (dc: SB_DC_WINDOW; x,y, fm,to: INTEGER)
      local
         l_x, l_y: INTEGER
      do
         l_x := x + text_font.get_text_width_len (contents, fm)
         l_y := y + text_font.get_font_ascent
         dc.draw_text_offset (l_x, l_y, contents, fm + 1, to - fm)
      end

   draw_pwdtext_fragment (dc: SB_DC_WINDOW; x, y, fm, to: INTEGER)
      local
         i, l_y, cw: INTEGER;
      do 
         cw := text_font.get_text_width ("*")
         l_y := y + text_font.get_font_ascent
         from
            i := fm
         until 
            i >= to
         loop 
            dc.draw_text (x + cw * i, l_y, "*")
            i := i + 1
         end
      end

	make_ins (event: SB_EVENT): BOOLEAN
		do
			Result := True
        	if (event.state & (CONTROLMASK | ALTMASK)) /= Zero
              or else event.text.is_empty or else event.text.item (1).code < 32 then
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
   
end
