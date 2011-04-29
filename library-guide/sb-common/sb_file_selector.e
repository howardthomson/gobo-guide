indexing
	description:"File selection widget"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"
	todo: "[
		on_cmd_item_dbl_clicked - non-conforming argument to do_handle
	]"

class SB_FILE_SELECTOR

inherit
   	SB_PACKER
      	rename
         	Id_last as PACKER_ID_LAST,
         	Id_delete as PACKER_ID_DELETE,
         	make as packer_make,
         	make_opts as packer_make_opts,
         	on_cmd_delete as packer_on_cmd_delete
      	redefine
         	handle_2
      	end

	SB_FILE_SELECTOR_COMMANDS
	SB_FILE_SELECTOR_CONSTANTS
	SB_CONSTANTS
	SB_UTILS
	SB_EXPANDED
--	SB_MESSAGE_REFFER
	SB_REFERENCE_BOOLEAN
	
creation

	make, make_opts

feature -- Data

   accept_button: SB_BUTTON		-- Accept button
   cancel_button: SB_BUTTON		-- Cancel button
   
   select_mode: INTEGER			-- Select mode
         
feature -- Creation

	make (p: SB_COMPOSITE; opts: INTEGER)
			-- Construct a file selector
		do
			make_opts (p, Void, 0, opts, 0,0,0,0)
		end

	make_opts (p: SB_COMPOSITE; tgt: SB_MESSAGE_HANDLER; sel: INTEGER; opts: INTEGER; x,y, w,h: INTEGER)
			-- Construct a file selector
		local
         	table: SB_ACCEL_TABLE
         	buttons, fileframe, filterframe, frame, f: SB_HORIZONTAL_FRAME
         	fields: SB_MATRIX
         	l: SB_LABEL
         	b: SB_BUTTON
         	tb: SB_TOGGLE_BUTTON
         	mc: SB_MENU_COMMAND
         	mb: SB_MENU_BUTTON
         	sep1: SB_MENU_SEPARATOR
         	rfc: SB_RECENT_FILES_COMMANDS
      	do
         	packer_make_opts(p, opts, x,y,w,h,
         		DEFAULT_SPACING, DEFAULT_SPACING, DEFAULT_SPACING, DEFAULT_SPACING,
         		DEFAULT_SPACING, DEFAULT_SPACING)
         	create mrufiles.make_opts(application, "Visited Directories", Current, ID_VISIT)
         	message_target := tgt
         	message := sel
         	create buttons.make_opts(Current, Layout_side_top | Layout_fill_x,
         			0,0,0,0, DEFAULT_SPACING, DEFAULT_SPACING, DEFAULT_SPACING, DEFAULT_SPACING, 0,0);
         	create fields.make(Current,3, MATRIX_BY_COLUMNS | Layout_side_bottom | Layout_fill_x)
         	create l.make_sb(fields, "&File Name:", JUSTIFY_LEFT | Layout_center_y)
	--#		l.set_opts( ... JUSTIFY_LEFT | Layout_center_y)
         	create filename_entry.make(fields,25,TEXTFIELD_ENTER_ONLY | Layout_fill_column
                               | Layout_fill_x | Frame_sunken | Frame_thick)
         	filename_entry.set_target_and_message(Current, ID_ACCEPT)
         	create b.make_opts(fields, "&OK", Void, Current, ID_ACCEPT, BUTTON_INITIAL | BUTTON_DEFAULT 
                       | Frame_raised | Frame_thick | Layout_fill_x, 0,0, 0,0, 20,20, DEFAULT_PAD, DEFAULT_PAD)
         	create accept_button.make_opts(buttons, Void, Void, Void,0, Layout_fix_x | Layout_fix_y
                                   | Layout_fix_width | Layout_fix_height, 0,0,0,0, 0,0,0,0)
         	create l.make_sb(fields,"File F&ilter:",JUSTIFY_LEFT | Layout_center_y)
         	create filterframe.make_opts(fields, Layout_fill_column | Layout_fill_x | Layout_fill_y, 0,0,0,0, 0,0,0,0,
                                 DEFAULT_SPACING, DEFAULT_SPACING)
         	create filefilter.make_sb(filterframe, 10, 4, COMBOBOX_STATIC | Layout_fill_x | Frame_sunken | Frame_thick)
         	filefilter.set_target_and_message(Current, ID_FILEFILTER)
         	create readonly.make(filterframe, "Read Only", Void,0, ICON_BEFORE_TEXT | JUSTIFY_LEFT | Layout_center_y);
         	create cancel_button.make_opts(fields, "&Cancel", Void, Void,0, BUTTON_DEFAULT | Frame_raised 
                                   | Frame_thick | Layout_fill_x, 0,0, 0,0, 20,20, DEFAULT_PAD, DEFAULT_PAD)
         	create frame.make_opts(Current, Layout_side_top | Layout_fill_x | Layout_fill_y | Frame_sunken | Frame_thick,
                           0,0,0,0, 0,0,0,0, DEFAULT_SPACING, DEFAULT_SPACING);
         	create filebox.make_opts(frame, Current, ID_FILELIST, ICONLIST_MINI_ICONS | ICONLIST_BROWSESELECT | ICONLIST_AUTOSIZE
                        | Layout_fill_x | Layout_fill_y, 0,0,0,0)
         	create l.make_sb(buttons, "Directory:", Layout_center_y)
			create {SB_GIF_ICON} up_dir_icon.make (application, tbuplevel)
         	create {SB_GIF_ICON} new_dir_icon.make(application, tbnewfolder)
         	create {SB_GIF_ICON} list_icon	.make (application, tblist)
         	create {SB_GIF_ICON} icons_icon	.make (application, tbbigicons)
         	create {SB_GIF_ICON} detailicon	.make (application, tbdetails)
         	create {SB_GIF_ICON} home_icon	.make (application, home)
         	create {SB_GIF_ICON} work_icon	.make (application, work)
         	create {SB_GIF_ICON} shown_icon	.make (application, fileshown)
         	create {SB_GIF_ICON} hidden_icon.make (application, filehidden)
         	create {SB_GIF_ICON} mark_icon	.make (application, mark)
         	create {SB_GIF_ICON} clear_icon	.make (application, clear)
        	create {SB_BMP_ICON} delete_icon.make_opts (application, deletefile, 0, IMAGE_ALPHAGUESS, 1,1)
         	create {SB_GIF_ICON} move_icon	.make (application, movefile)
         	create {SB_GIF_ICON} copy_icon	.make (application, copyfile)
         	create {SB_GIF_ICON} link_icon	.make (application, linkfile)
         	create dirbox.make_opts(buttons, 5, Current, ID_DIRTREE,
         				Frame_sunken | Frame_thick | Layout_fill_x | Layout_center_y, 0,0,0,0, 1,1,1,1)
         	create bookmarks.make_opts (Current, Popup_shrinkwrap)
	       	create mc.make_opts (bookmarks, "&Set bookmark%T%TBookmark current directory.", mark_icon, Current, ID_BOOKMARK, 0)
	       	create mc.make_opts (bookmarks, "&Clear bookmarks%T%TClear bookmarks.", clear_icon, mrufiles, rfc.ID_CLEAR, 0)
         	create sep1.make(bookmarks)
         	sep1.set_target_and_message(mrufiles, rfc.ID_ANYFILES)
         	create mc.make_sb (bookmarks, Void, mrufiles, rfc.ID_FILE_1)
			create mc.make_sb (bookmarks, Void, mrufiles, rfc.ID_FILE_2)
         	create mc.make_sb (bookmarks, Void, mrufiles, rfc.ID_FILE_3)
	       	create mc.make_sb (bookmarks, Void, mrufiles, rfc.ID_FILE_4)
	       	create mc.make_sb (bookmarks, Void, mrufiles, rfc.ID_FILE_5)
	       	create mc.make_sb (bookmarks, Void, mrufiles, rfc.ID_FILE_6)
	       	create mc.make_sb (bookmarks, Void, mrufiles, rfc.ID_FILE_7)
	       	create mc.make_sb (bookmarks, Void, mrufiles, rfc.ID_FILE_8)
	       	create mc.make_sb (bookmarks, Void, mrufiles, rfc.ID_FILE_9)
	       	create mc.make_sb (bookmarks, Void, mrufiles, rfc.ID_FILE_10)
         	create f.make_opts (buttons, Layout_fix_width, 0,0, 4,1, DEFAULT_PAD, DEFAULT_PAD, DEFAULT_PAD, DEFAULT_PAD,
                       DEFAULT_SPACING, DEFAULT_SPACING)

         	create b.make_opts (buttons, "%TGo up one directory%TMove up to higher directory.", up_dir_icon, Current, ID_DIRECTORY_UP,
                       BUTTON_TOOLBAR | Frame_raised, 0,0,0,0, 3,3,3,3)
         	create b.make_opts (buttons,"%TGo to home directory%TBack to home directory.", home_icon, Current, ID_HOME,
                       BUTTON_TOOLBAR | Frame_raised, 0,0,0,0, 3,3,3,3)
         	create b.make_opts (buttons, "%TGo to work directory%TBack to working directory.", work_icon, Current, ID_WORK,
                       BUTTON_TOOLBAR | Frame_raised, 0,0,0,0, 3,3,3,3)
         	create mb.make_opts (buttons, "%TBookmarks%TVisit bookmarked directories.", mark_icon, bookmarks,
                        MENUBUTTON_NOARROWS | MENUBUTTON_ATTACH_LEFT | MENUBUTTON_TOOLBAR | Frame_raised, 0,0,0,0, 3,3,3,3);
         	create b.make_opts (buttons, "%TCreate new directory%TCreate new directory.", new_dir_icon, Current, ID_NEW,
                       BUTTON_TOOLBAR | Frame_raised, 0,0,0,0, 3,3,3,3)

         	create b.make_opts (buttons, "%TShow list%TDisplay directory with small icons.", list_icon, filebox, filebox.ID_SHOW_MINI_ICONS,
                  BUTTON_TOOLBAR | Frame_raised, 0,0,0,0, 3,3,3,3)
         	create b.make_opts (buttons,"%TShow icons%TDisplay directory with big icons.", icons_icon, filebox, filebox.ID_SHOW_BIG_ICONS,
                  BUTTON_TOOLBAR | Frame_raised, 0,0,0,0, 3,3,3,3)
         	create b.make_opts (buttons,"%TShow details%TDisplay detailed directory listing.", detailicon, filebox, filebox.ID_SHOW_DETAILS,
                  BUTTON_TOOLBAR | Frame_raised, 0,0,0,0, 3,3,3,3)
         	create tb.make_opts (buttons,"%TShow hidden files%TShow hidden files and directories.",
                        "%THide Hidden Files%THide hidden files and directories.", hidden_icon, shown_icon, filebox, filebox.ID_TOGGLE_HIDDEN,
                        TOGGLEBUTTON_TOOLBAR | Frame_raised, 0,0,0,0, 3,3,3,3)
         	table := get_shell.accel_table
         	readonly.hide
         	if table /= Void then
            	table.add_accel (mksel(0,			key_backspace), Current, mksel (SEL_COMMAND, ID_DIRECTORY_UP), 			 0)
            	table.add_accel (mksel(0,			key_delete	 ), Current, mksel (SEL_COMMAND, Id_delete), 				 0)
            	table.add_accel (mksel(CONTROLMASK,	key_h		 ), Current, mksel (SEL_COMMAND, ID_HOME), 					 0)
            	table.add_accel (mksel(CONTROLMASK,	key_w		 ), Current, mksel (SEL_COMMAND, ID_WORK), 					 0)
            	table.add_accel (mksel(CONTROLMASK,	key_n		 ), Current, mksel (SEL_COMMAND, ID_NEW), 					 0)
            	table.add_accel (mksel(CONTROLMASK,	key_b		 ), filebox, mksel (SEL_COMMAND, filebox.ID_SHOW_BIG_ICONS),  0)
            	table.add_accel (mksel(CONTROLMASK,	key_s		 ), filebox, mksel (SEL_COMMAND, filebox.ID_SHOW_MINI_ICONS), 0)
            	table.add_accel (mksel(CONTROLMASK,	key_l		 ), filebox, mksel( SEL_COMMAND, filebox.ID_SHOW_DETAILS), 	 0)
         	end
         	set_select_mode (SELECTFILE_ANY)    -- For backward compatibility, Current HAS to be the default!
         	set_pattern_list ("All Files (*)")

		--	print("SB_FILE_SELECTOR... current directory is: "); print (ff.current_directory); print ("%N")
         	
         	set_directory (ff.current_directory)
         	filebox.set_focus
         	accept_button.hide
		end

feature -- Queries

   filename: STRING
         -- Return file name, if any
      do
         Result := ff.absolute_with_base (filebox.directory, filename_entry.contents);
      end

	filenames: ARRAY [ STRING ]
         	-- Return array of strings containing the selected file names.
         	-- If no files were selected, a Void is returned.
      	local
         	i, n, e: INTEGER
      	do
         	e := filebox.items_count;
         	if e /= 0 then
            	if select_mode = SELECTFILE_MULTIPLE_ALL then
               		from
                  		i := 1
						n := 0;
               		until
                  		i > e
               		loop
                  		if filebox.item (i).is_selected and then not filebox.item (i).filename.is_equal ("..") then
                     		n := n+1;
                  		end
                  		i := i+1
               		end
               		if n > 0 then
                  		create Result.make(1, n)
                  		from
                     		i := 1
                     		n := 1
                  		until
                     		i > e
                  		loop
                     		if filebox.item (i).is_selected and then not filebox.item (i).filename.is_equal ("..") then
                        		Result.put (filebox.item_pathname (i), n)
                        		n := n+1
                     		end
                     		i := i+1
                  		end
               		end
            	else
               		from
                  		i := 1;
                  		n := 0;
               		until
                  		i > e
               		loop
                  		if filebox.item (i).is_selected and then filebox.item (i).is_file then
                     		n := n+1;
                  		end
                  		i := i+1
               		end
               		if n > 0 then
                  		create Result.make(1,n)
                  		from
                     		i := 1;
                     		n := 1;
                  		until
                     		i > e
                  		loop
                     		if filebox.item (i).is_selected and then filebox.item (i).is_file then
                        		Result.put (filebox.item_pathname (i), n)
                        		n := n+1;
                     		end
                     		i := i+1
                  		end
               		end
            	end
         	end
		end

   pattern: STRING
         -- Return file pattern
      do
         Result := filebox.pattern;
      end

   pattern_list: STRING
         -- Return list of patterns
      local
         pat: STRING
         i, e: INTEGER;
      do
         from
            create Result.make_empty
            i := 1
            e := filefilter.items_count
         until
            i > e
         loop
            if not Result.is_empty then Result.append_character('%N') end
            Result.append_string(filefilter.item_text(i))
            i := i + 1;
         end
      end

   current_pattern: INTEGER
         -- Return current pattern number
      do
         Result := filefilter.current_item;
      end

   patterns_count: INTEGER
      do
         Result := filefilter.items_count
      end
      
   pattern_text(patno: INTEGER): STRING
         -- Get pattern text for given pattern number
      require
         patno > 0 and then patno <= patterns_count
      do
         Result := filefilter.item_text(patno);
      end

   directory: STRING
         -- Return directory
      do
         Result := filebox.directory;
      end

   item_space: INTEGER is
         -- Return the inter-item spacing (in pixels)
      do
         Result := filebox.item_space;
      end

   file_box_style: INTEGER
         -- Return file list style
      do
         Result := filebox.get_list_style;
      end

   read_only_shown: BOOLEAN
         -- Return True if readonly is is_shown
      do
         Result := readonly.is_shown;
      end

   read_only_state: INTEGER
         -- Get readonly state
      do
         Result := readonly.state
      end

feature -- Actions

	set_filename(path: STRING)
			-- Change file name
		require
			path /= Void
		local
			abspath: STRING
		do
			abspath := ff.absolute(path)
			if select_mode = SELECTFILE_DIRECTORY then
				filebox.set_directory(abspath)
				dirbox.set_directory(abspath)
				filename_entry.set_text("")
			else
				filebox.set_current_file(abspath)
				dirbox.set_directory(ff.directory(abspath))
				filename_entry.set_text(ff.name(abspath))
			end
		ensure
--			implemented: false
      	end

   set_pattern(ptrn: STRING)
         -- Change file pattern
      do
         filefilter.set_text(ptrn);
         filebox.set_pattern(ptrn);
      end


   set_pattern_list(ptrns: STRING)
         -- Change the list of file patterns is_shown in the file dialog.
         -- Each pattern comprises an optional name, followed by a pattern in
         -- parentheses.  The patterns are separated by newlines.
         -- For example,
         --
         --  "*%N*.cpp,*.cc%N*.hpp,*.hh,*.h"
         --
         -- and
         --
         --  "All Files (*)%NC++ Sources (*.cpp,*.cc)%NC++ Headers (*.hpp,*.hh,*.h)"
         --
         -- will set the same three patterns, but the former shows no pattern names.
      local
         pat: STRING;
         i: INTEGER;
         done: BOOLEAN;
      do
         filefilter.clear_items;
         from
            done := False
            i := 0;
         until
            done
         loop
            pat := section(ptrns, '%N', i, 1)
            if pat.is_empty then
               done := True
            else
               filefilter.append_item(pat, Void);
               i := i+1
            end
         end
         if filefilter.items_count = 0 then
            filefilter.append_item("All Files (*)", Void);
         end
         set_current_pattern(1);
      end

   set_pattern_list_arr(ptrns: ARRAY[STRING])
         -- Set list of patterns as name, pattern pairs.
         -- (DEPRECATED)
      local
         i, e: INTEGER
      do
         filefilter.clear_items;
         if ptrns /= Void then
            from
               i := 1;
               e := ptrns.count
            until
               i >= e
            loop
               filefilter.append_item(ptrns.item(i)+ " ("+ptrns.item(i+1)+"s)", Void);
               i := i+1
            end
         end
         if filefilter.items_count = 0 then
            filefilter.append_item("All Files (*)", Void);
         end
         set_current_pattern(1);
      end

	set_current_pattern(n: INTEGER)
			-- After setting the list of patterns, this call will
			-- initially select pattern n as the active one.
		require
			n > 0 and then n <= patterns_count
		do
			filefilter.set_current_item(n);
			filebox.set_pattern(pattern_from_text(filefilter.item_text(n)));
		end

   set_pattern_text(patno: INTEGER; text: STRING) is
         -- Change pattern text for pattern number
      require
         patno > 0 and then patno <= patterns_count
      do
         filefilter.set_item_text(patno,text);
         if patno = filefilter.current_item then
            set_pattern(pattern_from_text(text));
         end
      end

	set_directory(path: STRING)
			-- Change directory
		require
			path /= Void
		local
			abspath: STRING
		do
			abspath := ff.absolute(path)
--print(abspath); print("%N")
			filebox.set_directory(abspath)
			dirbox.set_directory(abspath)
			if select_mode /= SELECTFILE_ANY then
				filename_entry.set_text("")
			end
		end

   set_item_space(s: INTEGER)
         -- Set the inter-item spacing (in pixels)
      do
         filebox.set_item_space(s);
      end

	set_file_box_style(style: INTEGER)
			-- Change file list style
		do
			filebox.set_list_style(style);
		end

	set_select_mode(mode: INTEGER)
			-- Change file selection mode
		do
         	inspect mode
         	when SELECTFILE_EXISTING then
            	filebox.show_only_directories(False);
            	filebox.set_list_style((filebox.get_list_style & (FILELISTMASK).bit_not) | LIST_BROWSESELECT);
         	when SELECTFILE_MULTIPLE, SELECTFILE_MULTIPLE_ALL then
            	filebox.show_only_directories(False);
            	filebox.set_list_style((filebox.get_list_style & (FILELISTMASK).bit_not) | LIST_EXTENDEDSELECT);
         	when SELECTFILE_DIRECTORY then
            	filebox.show_only_directories(True);
            	filebox.set_list_style((filebox.get_list_style & (FILELISTMASK).bit_not) | LIST_BROWSESELECT);
         	else
            	filebox.show_only_directories(False);
            	filebox.set_list_style((filebox.get_list_style & (FILELISTMASK).bit_not) | LIST_BROWSESELECT);
         	end
         	select_mode := mode;
      	end

	show_read_only(sh: BOOLEAN)
			-- Show readonly button
      	do
           	if sh then
              	readonly.show
           	else
              	readonly.hide
           	end
      	end

	set_read_only_state(st: INTEGER)
    		-- Set initial state of readonly button
    	do
        	readonly.set_state(st)
      	end

feature -- Message processing

	handle_2 (sender: SB_MESSAGE_HANDLER; type, key: INTEGER; data: ANY): BOOLEAN is
    	do
        	if		match_function_2 (SEL_COMMAND,				ID_ACCEPT,		type, key) then Result := on_cmd_accept 			(sender,key,data);
        	elseif  match_function_2 (SEL_CHANGED,				ID_ACCEPT,		type, key) then Result := on_file_changed 			(sender,key,data);
        	elseif  match_function_2 (SEL_COMMAND,				ID_FILEFILTER,	type, key) then Result := on_cmd_filter 			(sender,key,data);
        	elseif  match_function_2 (SEL_DOUBLECLICKED,		ID_FILELIST,	type, key) then Result := on_cmd_item_dbl_clicked	(sender,key,data);
        	elseif  match_function_2 (SEL_SELECTED,				ID_FILELIST,	type, key) then Result := on_cmd_item_selected 		(sender,key,data);
        	elseif  match_function_2 (SEL_DESELECTED,			ID_FILELIST,	type, key) then Result := on_cmd_item_deselected 	(sender,key,data);
        	elseif  match_function_2 (Sel_rightbuttonrelease,	ID_FILELIST,	type, key) then Result := on_popup_menu 			(sender,key,data);
        	elseif  match_function_2 (SEL_COMMAND,				ID_DIRECTORY_UP,type, key) then Result := on_cmd_directory_up 		(sender,key,data);
        	elseif  match_function_2 (SEL_UPDATE,				ID_DIRECTORY_UP,type, key) then Result := on_upd_directory_up 		(sender,key,data);
        	elseif  match_function_2 (SEL_COMMAND,				ID_DIRTREE,		type, key) then Result := on_cmd_dir_tree 			(sender,key,data);
        	elseif  match_function_2 (SEL_COMMAND,				ID_HOME,		type, key) then Result := on_cmd_home 				(sender,key,data);
        	elseif  match_function_2 (SEL_COMMAND,				ID_WORK,		type, key) then Result := on_cmd_work 				(sender,key,data);
        	elseif  match_function_2 (SEL_COMMAND,				ID_VISIT,		type, key) then Result := on_cmd_visit 				(sender,key,data);
        	elseif  match_function_2 (SEL_COMMAND,				ID_BOOKMARK,	type, key) then Result := on_cmd_bookmark 			(sender,key,data);
        	elseif  match_function_2 (SEL_COMMAND,				ID_NEW,			type, key) then Result := on_cmd_new 				(sender,key,data);
        	elseif  match_function_2 (SEL_UPDATE,				ID_NEW,			type, key) then Result := on_upd_new 				(sender,key,data);
        	elseif  match_function_2 (SEL_COMMAND,				Id_delete,		type, key) then Result := on_cmd_delete 			(sender,key,data);
        	elseif  match_function_2 (SEL_COMMAND,				ID_MOVE,		type, key) then Result := on_cmd_move 				(sender,key,data);
        	elseif  match_function_2 (SEL_COMMAND,				ID_COPY,		type, key) then Result := on_cmd_copy 				(sender,key,data);
        	elseif  match_function_2 (SEL_COMMAND,				ID_LINK,		type, key) then Result := on_cmd_link 				(sender,key,data);
        	elseif  match_function_2 (SEL_UPDATE,				ID_COPY,		type, key) then Result := on_upd_selected 			(sender,key,data);
        	elseif  match_function_2 (SEL_UPDATE,				ID_MOVE,		type, key) then Result := on_upd_selected 			(sender,key,data);
        	elseif  match_function_2 (SEL_UPDATE,				ID_LINK,		type, key) then Result := on_upd_selected 			(sender,key,data);
        	elseif  match_function_2 (SEL_UPDATE,				Id_delete,		type, key) then Result := on_upd_selected 			(sender,key,data);
        	else Result := Precursor (sender, type, key, data)
        	end
      	end

   on_cmd_accept (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         msg: INTEGER
         tgt: SB_MESSAGE_HANDLER
         path: STRING
         i: INTEGER
         dir: STRING
      do
         msg := accept_button.message
         tgt := accept_button.message_target

         -- Get (first) filename
         path := filename;

         if ff.is_directory(path) then
            -- In directory mode
            if select_mode = SELECTFILE_DIRECTORY then
			   if tgt /= Void then tgt.do_handle_2 (accept_button, SEL_COMMAND, msg, ref_true) end
               Result := True
            else
               -- Hop over to that directory
			   dirbox.set_directory(path)
               filebox.set_directory(path)
               filename_entry.set_text("")
               Result := True
            end
         else
            -- Get directory part of path
            dir := ff.directory(path)
            -- In file mode, directory part of path should exist
            if ff.is_directory(dir) then
               if select_mode = SELECTFILE_ANY then
                  -- In any mode, existing directory part is good enough
                if tgt /= Void then tgt.do_handle_2 (accept_button, SEL_COMMAND, msg, ref_true) end
                  Result := True
               elseif select_mode = SELECTFILE_EXISTING then
                  -- In existing mode, the whole filename must exist and be a file
                  if ff.is_file(path) then
                   if tgt /= Void then tgt.do_handle_2 (accept_button, SEL_COMMAND, msg, ref_true) end
                     Result := True
                  end
               elseif select_mode = SELECTFILE_MULTIPLE then
                  -- In multiple mode, return if all selected files exist
                  from
                       i := 1
                  until
                     Result or else i > filebox.items_count
                  loop
                     if filebox.item(i).is_selected and then filebox.item(i).is_file then
                      if tgt /= Void then tgt.do_handle_2 (accept_button, SEL_COMMAND, msg, ref_true) end
                        Result := True
                     else
                        i := i + 1
                     end
                  end
               else
                  -- Multiple files and/or directories
                  from
                       i := 1
                  until
                     Result or else i > filebox.items_count
                  loop
                     if filebox.item(i).is_selected and then not filebox.item(i).filename.is_equal("..") then
                      if tgt /= Void then tgt.do_handle_2 (accept_button, SEL_COMMAND, msg, ref_true) end
                        Result := True
                     else
                        i := i+1
                     end
                  end
               end
            end
            if not Result then
               -- Go up to the lowest directory which still exists
               from
               until
                  ff.is_top_directory(dir) or else ff.is_directory(dir)
               loop
                  dir := ff.up_level(dir);
               end
               -- Switch as far as we could go
               dirbox.set_directory(dir)
               filebox.set_directory(dir)
               -- Put the tail end back for further editing
               check dir.count <= path.count end
               if path.count > dir.count and then ISPATHSEP(path.item(dir.count + 1)) then
                  path.remove_substring(1, dir.count + 1)
               else
                  path.remove_substring(1, dir.count)
               end
               -- Replace text box with new stuff
               filename_entry.set_text(path)
               filename_entry.select_all
               -- Beep
               application.beep
               Result := True
            end
         end
      end

   on_cmd_filter (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         pat, ext, name: STRING
      do
         pat ?= data check pat /= Void end
         pat := pattern_from_text(pat)
         filebox.set_pattern(pat)
         if select_mode = SELECTFILE_ANY then
            ext := extension_from_pattern(pat)
            if not ext.is_empty then
               name := ff.strip_extension(filename_entry.contents)
               if not name.is_empty then filename_entry.set_text(name + "." + ext) end
            end
         end
         Result := True
      end

	on_cmd_item_dbl_clicked (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
		local
			index: SE_REFERENCE [ INTEGER ]
		do
      		index ?= data check index /= Void end
      		if index.item > 0 then
				-- If directory, open the directory
    			if filebox.item(index.item).is_directory then
    	      		set_directory(filebox.item_pathname(index.item));
				elseif select_mode /= SELECTFILE_DIRECTORY then
    	      		-- Only return if we wanted a file
        	       	if filebox.item(index.item).is_file then
        	        	if accept_button.message_target /= Void then 
							accept_button.message_target.do_handle_2 (accept_button, SEL_COMMAND, accept_button.message, ref_true);
                  		end
              		end
          		end
         	end
			Result := True
		end

   on_cmd_item_selected (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
		 index: SE_REFERENCE [ INTEGER ]
         text,file: STRING;
         i,e: INTEGER
      do
         index ?= data check index /= Void end
         if select_mode = SELECTFILE_MULTIPLE then
            from
               i := 1
               e := filebox.items_count
               create text.make_empty
            until
               i > e
            loop
               if filebox.item(i).is_file and then filebox.item(i).is_selected then
                  if not text.is_empty then text.append_character(' ') end
                  text.append_character('"'); text.append_string(filebox.item(i).filename); text.append_character('"');
               end
               i := i + 1
            end
            filename_entry.set_text (text)
         elseif select_mode = SELECTFILE_MULTIPLE_ALL then
            from
               i := 1
               e := filebox.items_count
               create text.make_empty
            until
               i > e
            loop
               if filebox.item(i).is_selected and then not filebox.item(i).filename.is_equal("..") then
                  if not text.is_empty then text.append_character(' ') end
                  text.append_character('"'); text.append_string(filebox.item(i).filename); text.append_character('"');
               end
               i := i + 1
            end
            filename_entry.set_text(text);
         elseif select_mode = SELECTFILE_DIRECTORY then
            if filebox.item(index.item).is_directory then
               text := filebox.item(index.item).filename
               filename_entry.set_text(text)
            end
         else
            if filebox.item(index.item).is_file then
               text := filebox.item(index.item).filename
               filename_entry.set_text(text)
            end
         end
         Result := True;
      end

	on_cmd_item_deselected (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
		local
         	text, file: STRING
         	i, e: INTEGER
      	do
         	if select_mode = SELECTFILE_MULTIPLE then
            	from
               		i := 1
               		e := filebox.items_count;
               		create text.make_empty
            	until
               		i > e
            	loop
               		if filebox.item(i).is_file and then filebox.item(i).is_selected then
                  		if not text.is_empty then text.append_character(' ') end
                  		text.append_character('"'); text.append_string(filebox.item(i).filename); text.append_character('"');
               		end
               		i := i+1
            	end
            	filename_entry.set_text(text)
         	elseif select_mode = SELECTFILE_MULTIPLE_ALL then
            	from
               		i := 1
               		e := filebox.items_count
               		create text.make_empty
            	until
               		i > e
            	loop
               		if filebox.item(i).is_selected and then not filebox.item(i).filename.is_equal("..") then
                  		if not text.is_empty then text.append_character(' ') end
                  		text.append_character('"'); text.append_string(filebox.item(i).filename); text.append_character('"');
               		end
               		i := i+1
            	end
            	filename_entry.set_text(text)
         	end
         	Result := True
      	end

   on_cmd_directory_up (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         set_directory (ff.up_level (filebox.directory))
         Result := True
      end

   on_upd_directory_up (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         dir: STRING
      do
         dir := filebox.directory
         if ff.is_top_directory (dir) then
            sender.do_handle_2 (Current, SEL_COMMAND, Id_disable, Void)
         else
            sender.do_handle_2 (Current, SEL_COMMAND, Id_enable, Void)
         end
         Result := True;
      end

   on_cmd_dir_tree (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         s: STRING
      do
         s ?= data check s /= Void end
         filebox.set_directory(s)
         if select_mode = SELECTFILE_DIRECTORY then
            filename_entry.set_text ("")
         end
         Result := True
      end

   on_cmd_home(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         set_directory (ff.home_directory)
         Result := True
      end

   on_cmd_work (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         set_directory (ff.current_directory)
         Result := True
      end

   on_cmd_bookmark (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         mrufiles.append_file (filebox.directory)
         Result := True
      end

   on_cmd_visit (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         s: STRING
      do
         s ?= data check s /= Void end
         set_directory (s)
         Result := True
      end

   on_cmd_new (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
--         dir, name, dirname: STRING
--         new_dir_icon: SB_GIF_ICON
--         input_server: SB_INPUT_DIALOG_SERVER
--         message_server: SB_MESSAGE_SERVER
      do
--         dir := filebox.directory;
--         name := "DirectoryName";
--         create new_dir_icon.make(application, dlgnewfolder);
--         if input_server.get_string(name, Current, "Create New Directory", "Create new directory in: "+dir, new_dir_icon) then
--            dirname := ff.absolute_with_base(dir, name);
--            if ff.exists(dirname) then
--               message_server.show_error(Current, "Already Exists", "File or directory "+dirname+" already exists.%N", MBOX_OK);
--            elseif ff.create_directory(dirname, 111111111B) /= 0 
--               message_server.show_error(Current, "Cannot Create", "Cannot create directory "+dirname+".%N", MBOX_OK);
--            end
--         end
         Result := True
      end

   on_upd_new (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         dir: STRING
      do
         dir := filebox.directory
         if ff.is_writable (dir) then
            sender.do_handle_2 (Current, SEL_COMMAND, Id_enable, Void)
         else
            sender.do_handle_2 (Current, SEL_COMMAND, Id_disable, Void)
         end
         Result := True
      end

   on_cmd_move (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
      end

   on_cmd_copy (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
      end

   on_cmd_link (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
      end

   on_cmd_delete (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
      end

   on_upd_selected (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         i, e: INTEGER
         done: BOOLEAN
      do
         from
            i := 1
            e := filebox.items_count
         until
            i > e or else done
         loop
            if filebox.item(i).is_selected then
               sender.do_handle_2 (Current, SEL_COMMAND, Id_enable, Void)
               done := True
            else
               i := i+1
            end
         end
         if not done then
            sender.do_handle_2 (Current, SEL_COMMAND, Id_disable, Void)
         end
         Result := True;
      end

	on_popup_menu (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
		local
         	event : SB_EVENT
         	filemenu, sortmenu, viewmenu, bkmarks: SB_MENU_PANE
         	mc: SB_MENU_COMMAND
         	ms: SB_MENU_SEPARATOR
         	mcs: SB_MENU_CASCADE
         	sep1: SB_MENU_SEPARATOR
      	do
         	event ?= data check event /= Void end
         	if not event.moved then
            	create filemenu.make(Current);
            --	create mc.make_opts(filemenu, "Up one level",   up_dir_icon, Current, ID_DIRECTORY_UP, 0);
            --	create mc.make_opts(filemenu, "Home directory", home_icon,   Current, ID_HOME, 0);
            --	create mc.make_opts(filemenu, "Work directory", work_icon,   Current, ID_WORK, 0);
            	create ms.make(filemenu);

            	create sortmenu.make(Current);
            	create mcs.make(filemenu,"Sort by",sortmenu);
            --	create mc.make(sortmenu, "Name",	filebox, filebox.ID_SORT_BY_NAME);
            --	create mc.make(sortmenu, "Type",	filebox, filebox.ID_SORT_BY_TYPE);
            --	create mc.make(sortmenu, "Size",	filebox, filebox.ID_SORT_BY_SIZE);
            --	create mc.make(sortmenu, "Time",	filebox, filebox.ID_SORT_BY_TIME);
            --	create mc.make(sortmenu, "User",	filebox, filebox.ID_SORT_BY_USER);
            --	create mc.make(sortmenu, "Group",	filebox, filebox.ID_SORT_BY_GROUP);
            --	create mc.make(sortmenu, "Reverse", filebox, filebox.ID_SORT_REVERSE);

            	create viewmenu.make(Current);
            	create mcs.make(filemenu,"View",viewmenu);
            --	create mc.make(viewmenu, "Small icons",	filebox, filebox.ID_SHOW_MINI_ICONS);
            --	create mc.make(viewmenu, "Big icons",	filebox, filebox.ID_SHOW_BIG_ICONS);
            --	create mc.make(viewmenu, "Details",		filebox, filebox.ID_SHOW_DETAILS);
            --	create mc.make(viewmenu, "Rows",		filebox, filebox.ID_ARRANGE_BY_ROWS);
            --	create mc.make(viewmenu, "Columns",		filebox, filebox.ID_ARRANGE_BY_COLUMNS);
            --	create mc.make(viewmenu, "Hidden files",filebox, filebox.ID_TOGGLE_HIDDEN);

            	create bkmarks.make(Current);
            	create mcs.make(filemenu,"Bkmarks",bkmarks);
            --	create mc.make_opts(bkmarks, "Set bookmark",  mark_icon, Current, ID_BOOKMARK, 0);
            --	create mc.make_opts(bkmarks, "Clear bkmarks", clear_icon, mrufiles, mrufiles.ID_CLEAR, 0);
            	create sep1.make (bkmarks)
            	sep1.set_target_and_message(mrufiles,mrufiles.ID_ANYFILES);
            --	create mc.make_opts (bkmarks, Void, Void, mrufiles, mrufiles.ID_FILE_1, 0);
            --	create mc.make_opts (bkmarks, Void, Void, mrufiles, mrufiles.ID_FILE_2, 0);
            --	create mc.make_opts (bkmarks, Void, Void, mrufiles, mrufiles.ID_FILE_3, 0);
            --	create mc.make_opts (bkmarks, Void, Void, mrufiles, mrufiles.ID_FILE_4, 0);
            --	create mc.make_opts (bkmarks, Void, Void, mrufiles, mrufiles.ID_FILE_5, 0);
            --	create mc.make_opts (bkmarks, Void, Void, mrufiles, mrufiles.ID_FILE_6, 0);
            --	create mc.make_opts (bkmarks, Void, Void, mrufiles, mrufiles.ID_FILE_7, 0);
            --	create mc.make_opts (bkmarks, Void, Void, mrufiles, mrufiles.ID_FILE_8, 0);
            --	create mc.make_opts (bkmarks, Void, Void, mrufiles, mrufiles.ID_FILE_9, 0);
            --	create mc.make_opts (bkmarks, Void, Void, mrufiles, mrufiles.ID_FILE_10,0);

            	create sep1.make (filemenu)
            --	create mc.make_opts (filemenu, "New directory...", new_dir_icon,	Current, ID_NEW,   0)
            --	create mc.make_opts (filemenu, "Copy...",		  copy_icon,	Current, ID_COPY,  0)
            --	create mc.make_opts (filemenu, "Move...",		  move_icon,	Current, ID_MOVE,  0)
            --	create mc.make_opts (filemenu, "Link...",		  link_icon,	Current, ID_LINK,  0)
            --	create mc.make_opts (filemenu, "Delete...",		  delete_icon,	Current, Id_delete, 0)

            	filemenu.create_resource;
            	filemenu.pop_up(Void, event.root_x, event.root_y,0,0);
            	Result := application.run_modal_while_shown(filemenu);
            	Result := True;
         	end
      	end

   on_file_changed (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
      end

feature { NONE } -- Implementation

	FILELISTMASK: INTEGER
		once
			Result := (ICONLIST_EXTENDEDSELECT
					 | ICONLIST_SINGLESELECT
					 | ICONLIST_BROWSESELECT
					 | ICONLIST_MULTIPLESELECT)
		end

	filebox			: SB_FILE_LIST;		-- File list widget
	filename_entry	: SB_TEXT_FIELD;	-- File name entry field
	filefilter		: SB_COMBO_BOX;		-- Combobox for pattern list
	bookmarks		: SB_MENU_PANE;		-- Menu for bookmarks
	readonly		: SB_CHECK_BUTTON;	-- Open file as read only
	dirbox			: SB_DIR_BOX;		-- Directory hierarchy list
	
	up_dir_icon	: SB_ICON;	-- Up directory icon
	new_dir_icon: SB_ICON;	-- New directory icon
	list_icon	: SB_ICON;	-- List mode icon
	detailicon	: SB_ICON;	-- Detail mode icon
	icons_icon	: SB_ICON;	-- Icon mode icon
	home_icon	: SB_ICON;	-- Go home icon
	work_icon	: SB_ICON;	-- Go home icon
	shown_icon	: SB_ICON;	-- Files is_shown icon
	hidden_icon	: SB_ICON;	-- Files hidden icon
	mark_icon	: SB_ICON;	-- Book mark icon
	clear_icon	: SB_ICON;	-- Book clear icon
	delete_icon	: SB_ICON;	-- Delete file icon
	move_icon	: SB_ICON;	-- Rename file icon
	copy_icon	: SB_ICON;	-- Copy file icon
	link_icon	: SB_ICON;	-- Link file icon

   mrufiles: SB_RECENT_FILES
         -- Recently visited places

   pattern_from_text (txt: STRING): STRING
         -- Strip pattern from text if present
      local
         b,e: INTEGER;
      do
         e := rfind (txt, ')', txt.count)  -- Search from the end so we can allow ( ) in the pattern name itself
         b:= rfind (txt, '(', e-1)
         if 0 < b and then b < e then
            Result := txt.substring (b, e)
         else
            create Result.make_from_string (txt)
         end
      end

	extension_from_pattern (ptrn: STRING): STRING is
			-- Return the first extension "ext1" found in the pattern if the
         	-- pattern is of the form "*.ext1,*.ext2,..." or the is_empty string
         	-- if the pattern contains other wildcard combinations.
      	require
         	ptrn /= Void
      	local
         	b, e: INTEGER
         	c: CHARACTER
         	done: BOOLEAN
      	do
         	b := 1
         	if ptrn.item (b) = '*' then
            	b := b+1
            	if ptrn.item (b) = '.' then
               		b := b+1
               		e := b
               		from
               		until
                  	e > ptrn.count or else done or else Result /= Void
               		loop
                  		c := ptrn.item(e)
                  		if c = ','  or else c = '|' then
                     		done := True
                  		elseif (c = '*' or else c = '?' or else c = '[' or else c = ']' 
                        or else c = '^' or else c = '!')
                   		then
                     		create Result.make_empty
                  		else
                     		e := e+1
                  		end
                  		Result := mid (pattern, b, e-b)
               		end
            	end
         	end
         	if Result = Void then
            	create Result.make_empty
         	end
		end
   
	tbuplevel: ARRAY [ INTEGER_8 ] is
		once
			Result := <<
				0x47, 0x49, 0x46, 0x38, 0x37, 0x61, 0x10, 0x00, 
				0x10, 0x00, 0xF1, 0x00, 0x00, 0xB2, 0xC0, 0xDC, 
				0x00, 0x00, 0x00, 0xFF, 0xFF, 0x00, 0xFF, 0xFF, 
				0xFF, 0x2C, 0x00, 0x00, 0x00, 0x00, 0x10, 0x00, 
				0x10, 0x00, 0x00, 0x02, 0x32, 0x84, 0x8F, 0x79, 
				0xC1, 0xAC, 0x18, 0xC4, 0x90, 0x22, 0x3C, 0xD0, 
				0xB2, 0x76, 0x78, 0x7A, 0xFA, 0x0D, 0x56, 0xE4, 
				0x05, 0x21, 0x35, 0x96, 0xCC, 0x29, 0x62, 0x92, 
				0x76, 0xA6, 0x28, 0x08, 0x8E, 0x35, 0x5B, 0x75, 
				0x28, 0xFC, 0xBA, 0xF8, 0x27, 0xFB, 0xF5, 0x36, 
				0x44, 0xCE, 0xE5, 0x88, 0x44, 0x14, 0x00, 0x00, 
				0x3B
			>>
		end

	tbnewfolder: ARRAY [ INTEGER_8 ] is
		once
			Result := <<
				0x47, 0x49, 0x46, 0x38, 0x37, 0x61, 0x10, 0x00, 
				0x10, 0x00, 0xF1, 0x00, 0x00, 0xB2, 0xC0, 0xDC, 
				0x00, 0x00, 0x00, 0xFF, 0xFF, 0x00, 0xFF, 0xFF, 
				0xFF, 0x2C, 0x00, 0x00, 0x00, 0x00, 0x10, 0x00, 
				0x10, 0x00, 0x00, 0x02, 0x30, 0x84, 0x8F, 0xA9, 
				0x19, 0xEB, 0xBF, 0x1A, 0x04, 0xF2, 0x54, 0x1A, 
				0xB2, 0x69, 0x1C, 0x05, 0x31, 0x80, 0x52, 0x67, 
				0x65, 0xE6, 0xB9, 0x51, 0x54, 0xC8, 0x82, 0xE2, 
				0xF5, 0xB5, 0x2D, 0xB9, 0xBA, 0xF2, 0xB8, 0xD9, 
				0xFA, 0x55, 0xCB, 0x22, 0xA3, 0x9B, 0x31, 0x4E, 
				0x44, 0xDE, 0x24, 0x51, 0x00, 0x00, 0x3B
			>>
		end

	tbbigicons: ARRAY [ INTEGER_8 ] is
		once
			Result := <<
				0x47, 0x49, 0x46, 0x38, 0x37, 0x61, 0x10, 0x00, 
				0x10, 0x00, 0xF1, 0x00, 0x00, 0xB2, 0xC0, 0xDC, 
				0x00, 0x00, 0x80, 0xFF, 0xFF, 0xFF, 0x00, 0x00, 
				0x00, 0x2C, 0x00, 0x00, 0x00, 0x00, 0x10, 0x00, 
				0x10, 0x00, 0x00, 0x02, 0x22, 0x84, 0x8F, 0xA9, 
				0xAB, 0xE1, 0x9C, 0x82, 0x78, 0xD0, 0xC8, 0x59, 
				0xAD, 0xC0, 0xD9, 0xD1, 0x0C, 0x1A, 0xC3, 0x48, 
				0x1E, 0x5E, 0x28, 0x7D, 0xD0, 0x15, 0x80, 0xAC, 
				0x7B, 0x86, 0x21, 0x59, 0xCA, 0x46, 0x01, 0x00, 
				0x3B
			>>
		end

	tbdetails: ARRAY [ INTEGER_8 ] is
		once
			Result := <<
				0x47, 0x49, 0x46, 0x38, 0x37, 0x61, 0x10, 0x00, 
				0x10, 0x00, 0xF1, 0x00, 0x00, 0xB2, 0xC0, 0xDC, 
				0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x00, 0x00, 
				0x00, 0x2C, 0x00, 0x00, 0x00, 0x00, 0x10, 0x00, 
				0x10, 0x00, 0x00, 0x02, 0x27, 0x84, 0x8F, 0xA9, 
				0xBB, 0xE1, 0x01, 0x5E, 0x74, 0xAC, 0x8A, 0x8B, 
				0xB3, 0x16, 0x75, 0xF1, 0x49, 0x49, 0x52, 0xA7, 
				0x7C, 0x0F, 0x24, 0x52, 0x64, 0x62, 0xA6, 0xA8, 
				0xBA, 0x1E, 0x6D, 0x48, 0x43, 0xB1, 0x6C, 0x9C, 
				0xE0, 0x7E, 0x1B, 0x05, 0x00, 0x3B
			>>
		end

	tblist: ARRAY [ INTEGER_8 ] is
		once
			Result := <<
				0x47, 0x49, 0x46, 0x38, 0x37, 0x61, 0x10, 0x00, 
				0x10, 0x00, 0xF1, 0x00, 0x00, 0xB2, 0xC0, 0xDC, 
				0x00, 0x00, 0x80, 0xFF, 0xFF, 0xFF, 0x00, 0x00, 
				0x00, 0x2C, 0x00, 0x00, 0x00, 0x00, 0x10, 0x00, 
				0x10, 0x00, 0x00, 0x02, 0x2A, 0x84, 0x8F, 0xA9, 
				0x8B, 0x11, 0xEA, 0xA0, 0x78, 0xA3, 0x82, 0x30, 
				0x41, 0x1D, 0x37, 0x36, 0xCF, 0x84, 0x22, 0x03, 
				0x1E, 0xA5, 0x81, 0x51, 0x56, 0xAA, 0xAD, 0xA7, 
				0xF3, 0x8C, 0xF2, 0x7C, 0x76, 0x92, 0xCA, 0xB1, 
				0x5B, 0x17, 0x9B, 0xF5, 0x6C, 0x28, 0x00, 0x00, 
				0x3B
			>>
		end

	home: ARRAY [ INTEGER_8 ] is
		once
			Result := <<
				0x47, 0x49, 0x46, 0x38, 0x37, 0x61, 0x10, 0x00, 
				0x10, 0x00, 0xC2, 0x00, 0x00, 0xB2, 0xC0, 0xDC, 
				0x00, 0x00, 0x00, 0x84, 0x00, 0x00, 0xFF, 0xFF, 
				0x00, 0xFF, 0xFF, 0xFF, 0x00, 0x00, 0x00, 0x00, 
				0x00, 0x00, 0x00, 0x00, 0x00, 0x2C, 0x00, 0x00, 
				0x00, 0x00, 0x10, 0x00, 0x10, 0x00, 0x00, 0x03, 
				0x3B, 0x08, 0xBA, 0xDC, 0xAE, 0x21, 0x28, 0x21, 
				0x1F, 0x08, 0x63, 0x48, 0x6A, 0x71, 0xD4, 0x9C, 
				0xE3, 0x11, 0x84, 0x57, 0x31, 0x23, 0x59, 0x6A, 
				0x4D, 0xAA, 0xAE, 0xA7, 0xFB, 0xC2, 0x4B, 0x30, 
				0xCF, 0xE7, 0xA5, 0x46, 0xD1, 0x8E, 0xEE, 0x19, 
				0x1B, 0x29, 0x27, 0x5C, 0x69, 0x7C, 0x35, 0xE0, 
				0x71, 0xF8, 0x1B, 0x06, 0x91, 0x10, 0x9E, 0x54, 
				0x6A, 0xA9, 0x02, 0x12, 0x00, 0x3B
			>>
		end

	fileshown: ARRAY [ INTEGER_8 ] is
		once
			Result := <<
				0x47, 0x49, 0x46, 0x38, 0x37, 0x61, 0x10, 0x00, 
				0x10, 0x00, 0xF2, 0x00, 0x00, 0xB2, 0xC0, 0xDC, 
				0x00, 0x00, 0x00, 0xC0, 0xC0, 0xFF, 0xFF, 0xFF, 
				0xFF, 0xC0, 0xC0, 0xC0, 0xFF, 0xFF, 0xC0, 0xFF, 
				0x80, 0x00, 0x00, 0x00, 0x00, 0x2C, 0x00, 0x00, 
				0x00, 0x00, 0x10, 0x00, 0x10, 0x00, 0x00, 0x03, 
				0x43, 0x08, 0xAA, 0xD1, 0xFB, 0x30, 0x08, 0x19, 
				0xE0, 0x6A, 0x4D, 0x68, 0x5C, 0xEF, 0xF8, 0x03, 
				0x46, 0x80, 0x1D, 0x10, 0x80, 0x28, 0x5A, 0x9E, 
				0x5A, 0xEB, 0x86, 0xA6, 0x99, 0xCE, 0x4D, 0xD1, 
				0x0C, 0x6E, 0x1E, 0x16, 0xC6, 0x3D, 0x93, 0xBC, 
				0x0A, 0x2B, 0xB7, 0x09, 0x32, 0x7E, 0xBB, 0x9E, 
				0x87, 0x18, 0x08, 0xAE, 0x68, 0x84, 0x1E, 0xE1, 
				0x99, 0xC3, 0x08, 0x60, 0x47, 0xE4, 0xA7, 0x64, 
				0xE2, 0x78, 0xB9, 0x09, 0x00, 0x3B
			>>
		end

	filehidden: ARRAY [ INTEGER_8 ] is
		once
			Result := <<
				0x47, 0x49, 0x46, 0x38, 0x37, 0x61, 0x10, 0x00, 
				0x10, 0x00, 0xF1, 0x00, 0x00, 0xB2, 0xC0, 0xDC, 
				0xA0, 0xA0, 0xA4, 0xC0, 0xC0, 0xFF, 0xFF, 0xFF, 
				0xFF, 0x2C, 0x00, 0x00, 0x00, 0x00, 0x10, 0x00, 
				0x10, 0x00, 0x00, 0x02, 0x2C, 0x84, 0x1D, 0x79, 
				0xCB, 0x21, 0x1E, 0xD8, 0x49, 0x49, 0x58, 0x1A, 
				0xE7, 0xD8, 0x83, 0xF2, 0xAE, 0x7D, 0x22, 0x88, 
				0x8C, 0x62, 0x06, 0x04, 0xE6, 0x87, 0xAA, 0xEB, 
				0xD6, 0xBE, 0x70, 0xF8, 0xC6, 0xB2, 0x5D, 0xD3, 
				0x2B, 0xBE, 0xEB, 0x26, 0x9A, 0xC2, 0x08, 0x81, 
				0x05, 0x00, 0x3B
			>>
		end

	mark: ARRAY [ INTEGER_8 ] is
		once
			Result := <<
				0x47, 0x49, 0x46, 0x38, 0x37, 0x61, 0x10, 0x00, 
				0x10, 0x00, 0xF2, 0x00, 0x00, 0xB2, 0xC0, 0xDC, 
				0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00, 0x00, 
				0x80, 0xA0, 0x8C, 0x68, 0x00, 0x00, 0x00, 0x00, 
				0x00, 0x00, 0x00, 0x00, 0x00, 0x2C, 0x00, 0x00, 
				0x00, 0x00, 0x10, 0x00, 0x10, 0x00, 0x00, 0x03, 
				0x2F, 0x08, 0xBA, 0xAC, 0xD1, 0x70, 0xBD, 0x08, 
				0xC3, 0xA4, 0x52, 0x88, 0x4B, 0x83, 0xDE, 0x18, 
				0xE0, 0x69, 0x03, 0xD7, 0x58, 0xE4, 0x50, 0x9A, 
				0xA2, 0xA3, 0xAA, 0x1A, 0x77, 0x05, 0xEF, 0x37, 
				0x33, 0xF4, 0x60, 0x4B, 0xD5, 0x78, 0x47, 0x04, 
				0x0B, 0x2F, 0x44, 0x2C, 0x1A, 0x8F, 0x8A, 0x04, 
				0x00, 0x3B
			>>
		end

	clear: ARRAY [ INTEGER_8 ] is
		once
			Result := <<
				0x47, 0x49, 0x46, 0x38, 0x37, 0x61, 0x10, 0x00, 
				0x10, 0x00, 0xF2, 0x00, 0x00, 0xB2, 0xC0, 0xDC, 
				0x00, 0x00, 0xFF, 0xAD, 0xD8, 0xE6, 0x00, 0x00, 
				0x00, 0xFF, 0x00, 0x00, 0x00, 0x00, 0x80, 0xA0, 
				0x8C, 0x68, 0x00, 0x00, 0x00, 0x2C, 0x00, 0x00, 
				0x00, 0x00, 0x10, 0x00, 0x10, 0x00, 0x00, 0x03, 
				0x43, 0x08, 0xBA, 0x10, 0x21, 0x2C, 0x2E, 0x07, 
				0xA5, 0x0B, 0x8A, 0xCA, 0x25, 0xEE, 0x63, 0x83, 
				0xD4, 0x69, 0x4A, 0x28, 0x7A, 0xA5, 0x19, 0x69, 
				0xCE, 0x40, 0x10, 0x6A, 0xF6, 0xC9, 0x6F, 0xDC, 
				0xCC, 0x6E, 0x40, 0x14, 0x36, 0xEE, 0xEE, 0x05, 
				0x9E, 0x4A, 0x00, 0x31, 0x0D, 0x82, 0xC1, 0x9A, 
				0xA2, 0xB8, 0x38, 0x26, 0x95, 0x25, 0xD0, 0x13, 
				0xD6, 0x94, 0x0C, 0x7E, 0x2A, 0xDB, 0xC2, 0x70, 
				0xDD, 0x78, 0x23, 0x09, 0x00, 0x3B
			>>
		end

	work: ARRAY [ INTEGER_8 ] is
		once
			Result := <<
				0x47, 0x49, 0x46, 0x38, 0x37, 0x61, 0x10, 0x00, 
				0x10, 0x00, 0xF1, 0x00, 0x00, 0xB2, 0xC0, 0xDC, 
				0x00, 0x00, 0x00, 0x80, 0x80, 0x00, 0x80, 0x00, 
				0x00, 0x2C, 0x00, 0x00, 0x00, 0x00, 0x10, 0x00, 
				0x10, 0x00, 0x00, 0x02, 0x28, 0x84, 0x8F, 0xA9, 
				0x10, 0x1D, 0x8B, 0x9A, 0x10, 0x0E, 0x1E, 0x39, 
				0x9F, 0x65, 0x93, 0x6E, 0x16, 0x64, 0xDA, 0x12, 
				0x0C, 0x4E, 0x46, 0x9A, 0x46, 0x38, 0x46, 0xEA, 
				0x95, 0xB6, 0x50, 0x29, 0xC7, 0x1F, 0xF3, 0x7E, 
				0xCD, 0xCD, 0xF7, 0x4A, 0x01, 0x00, 0x3B
			>>
		end

	dlgnewfolder: ARRAY [ INTEGER_8 ] is
		once
			Result := <<
				0x47, 0x49, 0x46, 0x38, 0x37, 0x61, 0x20, 0x00, 
				0x20, 0x00, 0xF2, 0x00, 0x00, 0xB2, 0xC0, 0xDC, 
				0x80, 0x80, 0x80, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
				0x00, 0xC0, 0xC0, 0xC0, 0x00, 0x00, 0x00, 0x80, 
				0x80, 0x00, 0x00, 0x00, 0x00, 0x2C, 0x00, 0x00, 
				0x00, 0x00, 0x20, 0x00, 0x20, 0x00, 0x00, 0x03, 
				0x83, 0x08, 0xBA, 0xDC, 0xFE, 0x30, 0xCA, 0x49, 
				0x6B, 0x0C, 0x38, 0x67, 0x0B, 0x83, 0xF8, 0x20, 
				0x18, 0x70, 0x8D, 0x37, 0x10, 0x67, 0x8A, 0x12, 
				0x23, 0x09, 0x98, 0xAB, 0xAA, 0xB6, 0x56, 0x40, 
				0xDC, 0x78, 0xAE, 0x6B, 0x3C, 0x5F, 0xBC, 0xA1, 
				0xA0, 0x70, 0x38, 0x2C, 0x14, 0x60, 0xB2, 0x98, 
				0x32, 0x99, 0x34, 0x1C, 0x05, 0xCB, 0x28, 0x53, 
				0xEA, 0x44, 0x4A, 0xAF, 0xD3, 0x2A, 0x74, 0xCA, 
				0xC5, 0x6A, 0xBB, 0xE0, 0xA8, 0x16, 0x4B, 0x66, 
				0x7E, 0xCB, 0xE8, 0xD3, 0x38, 0xCC, 0x46, 0x9D, 
				0xDB, 0xE1, 0x75, 0xBA, 0xFC, 0x9E, 0x77, 0xE5, 
				0x70, 0xEF, 0x33, 0x1F, 0x7F, 0xDA, 0xE9, 0x7B, 
				0x7F, 0x77, 0x7E, 0x7C, 0x7A, 0x56, 0x85, 0x4D, 
				0x84, 0x82, 0x54, 0x81, 0x88, 0x62, 0x47, 0x06, 
				0x91, 0x92, 0x93, 0x94, 0x95, 0x96, 0x91, 0x3F, 
				0x46, 0x9A, 0x9B, 0x9C, 0x9D, 0x9E, 0x9A, 0x2E, 
				0xA1, 0xA2, 0x13, 0x09, 0x00, 0x3B
			>>
		end

	deletefile: ARRAY [ INTEGER_8 ] is
		once
			Result := <<
				0x42, 0x4D, 0x7E, 0x00, 0x00, 0x00, 0x00, 0x00, 
				0x00, 0x00, 0x3E, 0x00, 0x00, 0x00, 0x28, 0x00, 
				0x00, 0x00, 0x10, 0x00, 0x00, 0x00, 0x10, 0x00, 
				0x00, 0x00, 0x01, 0x00, 0x01, 0x00, 0x00, 0x00, 
				0x00, 0x00, 0x40, 0x00, 0x00, 0x00, 0x6D, 0x0B, 
				0x00, 0x00, 0x6D, 0x0B, 0x00, 0x00, 0x02, 0x00, 
				0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0xDC, 0xC0, 
				0xB2, 0x00, 0x00, 0x00, 0x84, 0x00, 0x00, 0x00, 
				0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x20, 0x04, 
				0x00, 0x00, 0x70, 0x00, 0x00, 0x00, 0x78, 0x08, 
				0x00, 0x00, 0x38, 0x10, 0x00, 0x00, 0x1C, 0x30, 
				0x00, 0x00, 0x0E, 0x60, 0x00, 0x00, 0x07, 0xC0, 
				0x00, 0x00, 0x03, 0x80, 0x00, 0x00, 0x07, 0xC0, 
				0x00, 0x00, 0x0E, 0x60, 0x00, 0x00, 0x3C, 0x30, 
				0x00, 0x00, 0x78, 0x18, 0x00, 0x00, 0x70, 0x04, 
				0x00, 0x00, 0x00, 0x00, 0x00, 0x00
			>>
		end

	copyfile: ARRAY [ INTEGER_8 ] is
		once
			Result := <<
				0x47, 0x49, 0x46, 0x38, 0x37, 0x61, 0x10, 0x00, 
				0x10, 0x00, 0xA1, 0x00, 0x00, 0xB2, 0xC0, 0xDC, 
				0x00, 0x00, 0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
				0xCB, 0x2C, 0x00, 0x00, 0x00, 0x00, 0x10, 0x00, 
				0x10, 0x00, 0x00, 0x02, 0x3C, 0x84, 0x8F, 0x09, 
				0xC1, 0xAD, 0x18, 0x84, 0x14, 0xEC, 0x99, 0x38, 
				0x63, 0xB0, 0xBA, 0x57, 0x85, 0x4D, 0xD2, 0x06, 
				0x52, 0x8C, 0xD9, 0x90, 0x97, 0x48, 0x0D, 0xEE, 
				0xF0, 0x2D, 0x68, 0xFB, 0x06, 0xF0, 0x2A, 0xDA, 
				0x0C, 0xEC, 0xA4, 0xCD, 0x0B, 0x54, 0x41, 0x78, 
				0x3F, 0xE1, 0xC1, 0x06, 0x74, 0x19, 0x2F, 0xC4, 
				0xDD, 0x72, 0x91, 0x54, 0x3E, 0x7C, 0x29, 0x40, 
				0x01, 0x00, 0x3B
			>>
		end

	movefile: ARRAY [ INTEGER_8 ] is
		once
			Result := <<
				0x47, 0x49, 0x46, 0x38, 0x37, 0x61, 0x10, 0x00, 
				0x10, 0x00, 0xC2, 0x00, 0x00, 0xB2, 0xC0, 0xDC, 
				0x7F, 0x7F, 0x65, 0xB3, 0xB3, 0x8E, 0x00, 0x00, 
				0x00, 0xFF, 0xFF, 0xCB, 0x00, 0x00, 0x00, 0x00, 
				0x00, 0x00, 0x00, 0x00, 0x00, 0x2C, 0x00, 0x00, 
				0x00, 0x00, 0x10, 0x00, 0x10, 0x00, 0x00, 0x03, 
				0x3E, 0x08, 0xBA, 0xDC, 0x10, 0x30, 0x3A, 0x16, 
				0x84, 0x15, 0x70, 0xAA, 0x7A, 0x6B, 0xD0, 0x5E, 
				0x98, 0x39, 0xDC, 0x65, 0x7D, 0x24, 0x06, 0x09, 
				0x43, 0xEB, 0x52, 0x26, 0x4B, 0xCC, 0x44, 0xBB, 
				0x88, 0x32, 0x3D, 0xD4, 0x5B, 0xBC, 0xB7, 0xB5, 
				0x57, 0x24, 0xB2, 0xA3, 0xE9, 0x26, 0x3F, 0xD7, 
				0x0F, 0x69, 0x3C, 0x3A, 0x92, 0x2E, 0xDE, 0xB3, 
				0x39, 0x1B, 0x20, 0x95, 0x4A, 0x40, 0x02, 0x00, 
				0x3B
			>>
		end

	linkfile: ARRAY [ INTEGER_8 ] is
		once
			Result := <<
				0x47, 0x49, 0x46, 0x38, 0x37, 0x61, 0x10, 0x00, 
				0x10, 0x00, 0xA1, 0x00, 0x00, 0xB2, 0xC0, 0xDC, 
				0x00, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0x00, 0x00, 
				0x00, 0x2C, 0x00, 0x00, 0x00, 0x00, 0x10, 0x00, 
				0x10, 0x00, 0x00, 0x02, 0x20, 0x84, 0x8F, 0xA9, 
				0xCB, 0xED, 0x0F, 0x4F, 0x98, 0x33, 0xD1, 0x00, 
				0x82, 0xD8, 0xFB, 0x6A, 0x3E, 0x09, 0x1E, 0x48, 
				0x89, 0x1F, 0x59, 0x82, 0xD9, 0x65, 0x51, 0xD1, 
				0x0B, 0xC7, 0xF2, 0x8C, 0x14, 0x00, 0x3B
			>>
		end
end
