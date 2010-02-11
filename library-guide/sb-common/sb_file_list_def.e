indexing
	description:"File List Widget"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

	todo: "[
		Split out Win32 dependent code
		Implement Posix code into X11_Impl cluster
	]"

deferred class SB_FILE_LIST_DEF

inherit

	SB_GENERIC_ICON_LIST [ SB_FILE_LIST_ITEM ]
      	rename
         	Id_last as ICON_LIST_ID_LAST
      	redefine
         	make_opts,
         	handle_2,
         	on_dnd_enter,
         	on_dnd_leave,
         	on_dnd_motion,
         	on_dnd_drop,
         	on_dnd_request,
         	on_begin_drag,
         	on_end_drag,
         	on_dragged,
         	on_cmd_set_value,
         	create_resource,
         	detach_resource,
         	destroy_resource
      	end

   SB_FILE_LIST_CONSTANTS

   SB_FILE_LIST_COMMANDS

feature -- Attributes

	directory		: STRING       	-- Current directory
	org_directory	: STRING       	-- Original directory
	drop_directory	: STRING		-- Drop directory

	drop_action		: INTEGER		-- Drop action
	drag_files		: STRING        -- Dragged files
	associations	: SB_FILE_DICT	-- Association table
	pattern			: STRING        -- Pattern of file names
	match_mode		: INTEGER	-- File wildcard match mode
	timestamp		: INTEGER       -- Time when last refreshed
	refresh_timer	: SB_TIMER      -- Refresh timer
	open_timer	 	: SB_TIMER      -- Open up folder when hovering

	big_folder		: SB_ICON       -- Big folder icon
	mini_folder		: SB_ICON       -- Mini folder icon
	big_doc			: SB_ICON       -- Big document icon
	mini_doc		: SB_ICON       -- Mini document icon
	big_app			: SB_ICON       -- Big application icon
	mini_app		: SB_ICON       -- Mini application icon

feature -- Creation

   	make_opts(p: SB_COMPOSITE; tgt: SB_MESSAGE_HANDLER; selector: INTEGER; opts: INTEGER; x,y,w,h: INTEGER) is
    		-- Construct a file list
		do
        	Precursor(p, tgt,selector, opts, x,y,w,h)
         	directory := PATHSEPSTRING
         	org_directory := PATHSEPSTRING
         	pattern := "*"
         	flags := flags | Flag_enabled | Flag_droptarget
         	associations := Void
         	append_header("Name",			Void, 200)
         	append_header("Type",			Void, 100)
         	append_header("Size",			Void,  60)
         	append_header("Modified Date",	Void, 150)
         	append_header("User",			Void,  50)
         	append_header("Group",			Void,  50)
         	append_header("Attributes",		Void, 100)

			create { SB_GIF_ICON } big_folder 	.make(application, bigfolder)
         	create { SB_GIF_ICON } mini_folder	.make(application, minifolder)
         	create { SB_GIF_ICON } big_doc		.make(application, bigdoc)
         	create { SB_GIF_ICON } mini_doc		.make(application, minidoc)
         	create { SB_GIF_ICON } big_app		.make(application, bigapp)
         	create { SB_GIF_ICON } mini_app		.make(application, miniapp)

         	match_mode := FILEMATCH_FILE_NAME
         				| FILEMATCH_NOESCAPE
         				| FILEMATCH_CASEFOLD

         	if (options & FILELIST_NO_OWN_ASSOC) = Zero then
            	create associations.make(application)
         	end
         	drop_action := DRAG_MOVE
         	comparator.set_type(1)
			set_item_comparator(comparator)
-- SE 2.1 reported conformity problem
			set_items_sorter(sorter)			-- ???
		ensure then
		--	implemented: false
		end

feature -- Queries

	current_file: STRING is
    		-- Return current file, Void if absent
      	do
         	if current_item > 0 then
            	Result := item_pathname(current_item)
         	end
      	end

	hidden_files_shown: BOOLEAN is
    		-- Return True if showing hidden files
      	do
         	Result := (options & FILELIST_SHOWHIDDEN) /= Zero
      	end

	only_directories_shown: BOOLEAN is
    		-- Return True if showing directories only
		do
			Result := (options & FILELIST_SHOWDIRS) /= Zero
      	end

feature -- Item queries

	item_pathname(index: INTEGER): STRING is
    		-- Return full pathname of item at index
       	require
          	index > 0 and then index <= items_count
       	do
          	Result := ff.absolute_with_base(directory, utils.section(item(index).label, '%T', 0, 1))
       	end

feature -- Actions

	set_current_file(pathname: STRING) is
    		-- Set current file
      	require
         	pathname /= Void
      	do
         	if not pathname.is_empty then
            	set_directory(ff.directory(pathname));
            	set_current_item(find_item_by_name(ff.name(pathname)), False)
         	end
      	end

	set_directory(pathname: STRING) is
    		-- Set current directory
    	require
         	pathname /= Void
      	local
         	path: STRING;
		do
        	if not pathname.is_empty then
            	from
					path := ff.absolute_with_base(directory, pathname)
			--		print("SB_FILE_LIST_DEF. path = "); print(path); print("%N")
            	until
               		ff.is_top_directory(path) or else ff.is_directory(path)
            	loop
					path := ff.up_level(path)
			--		print("SB_FILE_LIST_DEF. path = "); print(path); print("%N")
            	end
            	if not directory.is_equal(path) then
               		directory := path
               		clear_items
               		list_directory
               		sort_items
            	end
         	end
      	end

   	set_pattern(ptrn: STRING) is
         	-- Change wildcard matching pattern
      	require
         	ptrn /= Void
      	do
         	if not ptrn.is_empty then
            	if not pattern.is_equal(ptrn) then
               		pattern := ptrn;
               		list_directory;
               		sort_items;
            	end
         	end
      	end

   set_match_mode(mode: INTEGER) is
         -- Change wildcard matching mode
      do
         if match_mode /= mode then
            match_mode := mode
            list_directory
            sort_items
         end
      end

   show_hidden_files(showing: BOOLEAN) is
         -- Show or hide hidden files
      local
         opts: INTEGER;
      do
         if showing then
            opts := (options | FILELIST_SHOWHIDDEN)
         else
            opts := (options & (FILELIST_SHOWHIDDEN).bit_not);
         end
         if opts /= options then
            options := opts
            list_directory
            sort_items
         end
      end

   show_only_directories(showing: BOOLEAN) is
         -- Show directories only
      local
         opts: INTEGER
      do
         if showing then
            opts := (options | FILELIST_SHOWDIRS)
         else
            opts := (options & (FILELIST_SHOWDIRS).bit_not);
         end
         if opts /= options then
            options := opts
            list_directory
            sort_items
         end
      end

   set_associations(assocs: SB_FILE_DICT) is
         -- Change file associations
      do
         if associations /= assocs then
            associations := assocs;
            clear_items
            list_directory
            sort_items
         end
      end

feature -- Message processing

	handle_2 (sender: SB_MESSAGE_HANDLER; type, key: INTEGER; data: ANY): BOOLEAN is
    	do
			if		match_function_2 (SEL_DRAGGED,		0,					type, key) then Result := on_dragged 				(sender,key,data);
        	elseif  match_function_2 (Sel_timeout,		ID_REFRESHTIMER,	type, key) then Result := on_refresh_timer 			(sender,key,data);
        	elseif  match_function_2 (Sel_timeout,		ID_OPENTIMER,		type, key) then Result := on_open_timer 			(sender,key,data);
        	elseif  match_function_2 (SEL_DND_ENTER,	0,					type, key) then Result := on_dnd_enter 				(sender,key,data);
        	elseif  match_function_2 (SEL_DND_LEAVE,	0,					type, key) then Result := on_dnd_leave 				(sender,key,data);
        	elseif  match_function_2 (SEL_DND_DROP,		0,					type, key) then Result := on_dnd_drop 				(sender,key,data);
        	elseif  match_function_2 (SEL_DND_MOTION,	0,					type, key) then Result := on_dnd_motion 			(sender,key,data);
        	elseif  match_function_2 (SEL_DND_REQUEST,	0,					type, key) then Result := on_dnd_request 			(sender,key,data);
        	elseif  match_function_2 (SEL_BEGINDRAG,	0,					type, key) then Result := on_begin_drag 			(sender,key,data);
        	elseif  match_function_2 (SEL_ENDDRAG,		0,					type, key) then Result := on_end_drag 				(sender,key,data);
        	elseif  match_function_2 (SEL_UPDATE,		ID_DIRECTORY_UP,	type, key) then Result := on_upd_directory_up 		(sender,key,data);

        	elseif  match_functions_2 (SEL_UPDATE, ID_SORT_BY_NAME, ID_SORT_BY_GROUP,type, key) then Result := on_upd_sort		(sender,key,data);

        	elseif  match_function_2 (SEL_UPDATE,		ID_SORT_REVERSE,	type, key) then Result := on_upd_sort_reverse 		(sender,key,data);
        	elseif  match_function_2 (SEL_UPDATE,		ID_SET_PATTERN,		type, key) then Result := on_upd_set_pattern 		(sender,key,data);
        	elseif  match_function_2 (SEL_UPDATE,		ID_SET_DIRECTORY,	type, key) then Result := on_upd_set_directory 		(sender,key,data);
        	elseif  match_function_2 (SEL_UPDATE,		ID_SHOW_HIDDEN,		type, key) then Result := on_upd_show_hidden 		(sender,key,data);
        	elseif  match_function_2 (SEL_UPDATE,		ID_HIDE_HIDDEN,		type, key) then Result := on_upd_hide_hidden 		(sender,key,data);
        	elseif  match_function_2 (SEL_UPDATE,		ID_TOGGLE_HIDDEN,	type, key) then Result := on_upd_toggle_hidden 		(sender,key,data);
        	elseif  match_function_2 (SEL_COMMAND,		ID_DIRECTORY_UP,	type, key) then Result := on_cmd_directory_up 		(sender,key,data);

        	elseif  match_functions_2 (SEL_COMMAND, ID_SORT_BY_NAME, ID_SORT_BY_GROUP,type, key) then Result := on_cmd_sort		(sender,key,data);

        	elseif  match_function_2 (SEL_COMMAND,		ID_SORT_REVERSE,	type, key) then Result := on_cmd_sort_reverse 		(sender,key,data);
        	elseif  match_function_2 (SEL_COMMAND,		ID_SET_PATTERN,		type, key) then Result := on_cmd_set_pattern 		(sender,key,data);
        	elseif  match_function_2 (SEL_COMMAND,		ID_SET_DIRECTORY,	type, key) then Result := on_cmd_set_directory 		(sender,key,data);
        	elseif  match_function_2 (SEL_COMMAND,		Id_setvalue,		type, key) then Result := on_cmd_set_value 			(sender,key,data);
        	elseif  match_function_2 (SEL_COMMAND,		Id_setstringvalue,	type, key) then Result := on_cmd_set_string_value	(sender,key,data);
        	elseif  match_function_2 (SEL_COMMAND,		Id_getstringvalue,	type, key) then Result := on_cmd_get_value 			(sender,key,data);
        	elseif  match_function_2 (SEL_COMMAND,		ID_SHOW_HIDDEN,		type, key) then Result := on_cmd_show_hidden 		(sender,key,data);
        	elseif  match_function_2 (SEL_COMMAND,		ID_HIDE_HIDDEN,		type, key) then Result := on_cmd_hide_hidden 		(sender,key,data);
        	elseif  match_function_2 (SEL_COMMAND,		ID_TOGGLE_HIDDEN,	type, key) then Result := on_cmd_toggle_hidden 		(sender,key,data);
         	elseif  match_function_2 (SEL_COMMAND,		ID_HEADER_CHANGE,	type, key) then Result := on_cmd_header 			(sender,key,data);
         	elseif  match_function_2 (SEL_UPDATE,		ID_HEADER_CHANGE,	type, key) then Result := on_upd_header 			(sender,key,data);
         	else Result := Precursor(sender, type, key, data)
         	end
      end

	on_refresh_timer(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
		local
        	interval: INTEGER
         	changetime: INTEGER;
      	do
         	interval := REFRESHINTERVAL;
         	-- Only update if user is not interacting with the file list
         	if (flags & Flag_update) /= Zero then
            	-- Test if a change has occurred
            	if ff.is_directory(directory) then
               		changetime := ff.created(directory).max(ff.touched(directory))
               		if timestamp /= changetime or else changetime = 0 then
                  		-- File system does not support mod-time on directory:- we schedule
                  		-- next refresh in REFRESHINTERVALLONG ms instead of REFRESHINTERVAL ms
                  		if changetime = 0 then
                     		interval := REFRESHINTERVALLONG;
                  		end
                  		-- Refresh contents
                  		list_directory;
                  		sort_items;

                  		-- Last time checked
                  		timestamp := changetime;
               		end
            	else
               		-- Move to higher directory
               		set_directory(ff.up_level(directory));
            	end
         	end

         	-- Reset timer again
       --  	fx_trace(0, <<"SB_FILE_LIST_DEF::on_refresh_time - interval = ", interval.out>>)
--#			refresh_timer := application.add_timeout(interval, Current, ID_REFRESHTIMER);
      	end

   on_open_timer(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      local
         cp: SB_CURSOR_POSITION;
         index: INTEGER;
      do
         open_timer := Void;
         cp := get_cursor_position;
         if cp /= Void then
            index := item_at(cp.x, cp.y);
         end
         if 0 < index and then item(index).is_directory then
            drop_directory := item_pathname(index);
            set_directory(drop_directory);
            open_timer := application.add_timeout(700, Current, ID_OPENTIMER);
         end
         Result := True;
      end

   on_dnd_enter(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         Result := Precursor(sender, selector, data)
         	-- Keep original directory
         org_directory := directory
         Result := True
      end

   on_dnd_leave(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         Result := Precursor(sender,selector,data);
         	-- Cancel open up timer
         if open_timer /= Void then
            application.remove_timeout(open_timer)
            open_timer := Void
         end

         	-- Stop scrolling
         stop_auto_scroll

         	-- Restore original directory
         set_directory(org_directory)
         Result := True
      end

   on_dnd_motion(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      local
         event: SB_EVENT
         index: INTEGER
      do
         event ?= data check event /= Void end
         -- Cancel open up timer
         if open_timer /= Void then application.remove_timeout(open_timer); open_timer := Void end

         -- Start autoscrolling
         if not (start_auto_scroll(event.win_x,event.win_y,False)
             or else
             -- Give base class a shot
             not Precursor (sender,selector,data))
          then
            -- Dropping list of filenames
            if offered_dnd_type(FROM_DRAGNDROP,uri_list_type) then

               -- Drop in the background
               drop_directory := directory;

               -- What is being done (move,copy,link)
               drop_action := inquire_dnd_action;

               -- We will open up a folder if we can hover over it for a while
               index := item_at(event.win_x,event.win_y);
               if 0 < index and then item(index).is_directory then
                  -- Set open up timer
                  open_timer := application.add_timeout(700,Current,ID_OPENTIMER);
                  -- Directory where to drop, or directory to open up
                  drop_directory := item_pathname(index);
               end
               -- See if dropdirectory is writable
               if ff.is_writable(drop_directory) then
                  accept_drop(DRAG_ACCEPT);
               end
               Result := True;
            end
         else
            Result := True;
         end
      end

   on_dnd_drop (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      local
         dnd_data: STRING
         len: INTEGER;
         p,q,e: INTEGER;
         url,filesrc,filedst: STRING;
      do
         	-- Cancel open up timer
         if open_timer /= Void then application.remove_timeout(open_timer); open_timer := Void end
        	 -- Stop scrolling
         stop_auto_scroll;

         	-- Restore original directory
         set_directory(org_directory);

        	 -- Perhaps message_target wants to deal with it
         if not Precursor(sender,selector,data) then
            	-- Get uri-list of files being dropped
            dnd_data := get_dnd_data(FROM_DRAGNDROP,uri_list_type)
            if dnd_data /= Void then
               from
                  p := 1;
                  q := 1;
                  e := dnd_data.count
               until
                  p > e
               loop
                  from
                  until
                     q > e or else dnd_data.item(q) = '%R'
                  loop
                     q := q+1;
                  end
                  if q > p then
                     url := dnd_data.substring(p,q-1)
                     -- TODO
                     --filesrc := (FXURL::fileFromURL(url));
                     filesrc := "qqq"
                     filedst := drop_directory+PATHSEPSTRING+ff.name(filesrc);
                     -- Move, Copy, or Link as appropriate
                     if drop_action = DRAG_MOVE then
                        print("Moving file: " + filesrc+" to "+filedst+"%N");
                        --if not ff.move(filesrc,filedst) then
                        --  application.beep;
                        --end
                     elseif drop_action = DRAG_COPY then
                        print("Copying file: " + filesrc+" to "+filedst+"%N");
                        --if not ff.copy(filesrc,filedst) then
                        --  application.beep;
                        --end
                     elseif drop_action = DRAG_LINK then
                        print("Linking file: " + filesrc+" to "+filedst+"%N");
                        --if not ff.copy(filesrc,filedst) then
                        --  application.beep;
                        --end
                     end
                  end
                  if q < e and then dnd_data.item(q) = '%R' then q := q + 2 end
                  p := q;
               end
               Result := True;
            end
         else
            Result := True;
         end
      end

	on_dnd_request(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
    	local
        	event: SB_EVENT;
         	dnd_data: STRING;
      	do
         	event ?= data check event /= Void end
         	-- Perhaps the message_target wants to supply its own data
         	if not Precursor(sender, selector, data) then
            	if event.target = uri_list_type then
               		-- Return list of filenames as a uri-list
               		if not drag_files.is_empty then
                  		create dnd_data.make_from_string(drag_files);
        --###			do_set_dnd_data(FROM_DRAGNDROP, event.target, dnd_data);
               		end
               		Result := True;
            	elseif event.target = delete_type then
               		-- Delete selected files
               		print("Delete files not yet implemented%N");
               		Result := True;
            	end
         	else
            	Result := True
         	end
		ensure then
			implemented: false
      	end

   on_begin_drag(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      local
         i,e: INTEGER
         arr: ARRAY[INTEGER];
      do
         Result := Precursor(sender, selector, data)
         if Result = False then
            create arr.make(1,1);
            arr.put(uri_list_type,1);
            if begin_drag(arr) then
               create drag_files.make_empty
               from
                  i := 1;
                  e := items.count;
               until
                  i > e
               loop
                  if item(i).is_selected then
                     if not drag_files.is_empty then drag_files.append_string("%R%N") end
                     -- TODO FXURL::fileToURL(getItemPathname(i)
                     drag_files.append_string(item_pathname(i));
                  end
                  i := i+1
               end
               Result := True;
            end
         end
      end

   on_end_drag(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         if not Precursor(sender,selector,data) then
            do_end_drag(did_accept /= DRAG_REJECT);
            set_drag_cursor(default_cursor);
            create drag_files.make_empty
         end
         Result := True;
      end

   on_dragged(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      local
         event: SB_EVENT
         action: INTEGER;
      do
         event ?= data check event /= Void end
         if not Precursor(sender, selector, data) then
            action := DRAG_MOVE;
            if (event.state & CONTROLMASK) /= Zero then action := DRAG_COPY end
            if (event.state & SHIFTMASK) /= Zero then action := DRAG_MOVE end
            if (event.state & ALTMASK)  /= Zero then action := DRAG_LINK end
            do_handle_drag(event.root_x, event.root_y, action);
            if did_accept /= DRAG_REJECT then
               if action = DRAG_MOVE then
                  set_drag_cursor(application.default_cursor(Def_dndmove_cursor));
               elseif action = DRAG_LINK then
                  set_drag_cursor(application.default_cursor(Def_dndlink_cursor));
               else
                  set_drag_cursor(application.default_cursor(Def_dndcopy_cursor));
               end
            else
               set_drag_cursor(application.default_cursor(Def_dndstop_cursor));
            end
         end
         Result := True;
      end

   on_cmd_set_value, on_cmd_set_string_value(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      local
         str: STRING;
      do
         str ?= data check str /= Void end
         set_current_file(str);
      end

   on_cmd_get_value(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      local
         str: STRING;
      do
         str ?= data check str /= Void end
         str.make_from_string(current_file);
         Result := True;
      end

   on_cmd_directory_up(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         set_directory(ff.up_level(directory));
         Result := True;
      end

   on_upd_directory_up(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         if ff.is_top_directory(directory) then
            sender.do_handle_2 (Current, SEL_COMMAND, Id_disable,data);
         else
            sender.do_handle_2 (Current, SEL_COMMAND, Id_enable,data);
         end
         Result := True;
      end

   on_cmd_sort(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      local
         t: INTEGER
      do
         t := selid(selector) - ID_SORT_BY_NAME+1;
         if comparator.type = t then
            comparator.reverse;
         else
            comparator.set_type(t)
         end
         sort_items;
         Result := True;
      end

   on_upd_sort(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      local
         t: INTEGER;
      do
         if comparator.type.abs = (selid(selector) - ID_SORT_BY_NAME + 1) then
            sender.do_handle_2 (Current, SEL_COMMAND, Id_check, Void);
         else
            sender.do_handle_2 (Current, SEL_COMMAND, Id_uncheck, Void);
         end
         Result := True;
      end

   on_cmd_sort_reverse(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         comparator.reverse
      end

   on_upd_sort_reverse(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         if comparator.type < 0 then
            sender.do_handle_2 (Current, SEL_COMMAND, Id_check, Void);
         else
            sender.do_handle_2 (Current, SEL_COMMAND, Id_uncheck, Void);
         end
      end

   on_cmd_set_pattern(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      local
         str: STRING
      do
         str ?= data check data /= Void end
         set_pattern(str);
         Result := True;
      end

   on_upd_set_pattern(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         sender.do_handle_2 (Current, SEL_COMMAND, Id_setvalue, pattern);
         Result := True;
      end

   on_cmd_set_directory(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      local
         str: STRING
      do
         str ?= data check data /= Void end
         set_directory(str);
         Result := True;
      end

   on_upd_set_directory(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         sender.do_handle_2 (Current, SEL_COMMAND, Id_setvalue, directory);
         Result := True;
      end

   on_cmd_toggle_hidden(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         show_hidden_files (not hidden_files_shown);
         Result := True;
      end

   on_upd_toggle_hidden(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         if hidden_files_shown then
            sender.do_handle_2 (Current, SEL_COMMAND, Id_check, Void);
         else
            sender.do_handle_2 (Current, SEL_COMMAND, Id_uncheck, Void);
         end
         Result := True;
      end

   on_cmd_show_hidden(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         show_hidden_files(True);
         Result := True;
      end

   on_upd_show_hidden(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         if hidden_files_shown then
            sender.do_handle_2 (Current, SEL_COMMAND, Id_check, Void);
         else
            sender.do_handle_2 (Current, SEL_COMMAND, Id_uncheck, Void);
         end
         Result := True;
      end

   on_cmd_hide_hidden(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         show_hidden_files(False);
         Result := True;
      end

   on_upd_hide_hidden(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      do
         if hidden_files_shown then
            sender.do_handle_2 (Current, SEL_COMMAND, Id_uncheck, Void);
         else
            sender.do_handle_2 (Current, SEL_COMMAND, Id_check, Void);
         end
         Result := True;
      end

	on_cmd_header(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
		local
		--   index: INTEGER_REF
			index: SE_REFERENCE [ INTEGER ]
		do
			index ?= data check index /= Void end
        	if index.item < 7 then
            	do_handle_2 (Current, SEL_COMMAND, ID_SORT_BY_NAME + index.item - 1, Void);
         	end
         	Result := True;
      	end

   on_upd_header (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      local
         i, type: INTEGER
      do
         from
            type := comparator.type
            i := 1;
         until
            i > 6
         loop
            if type = i then
               header.set_item_arrow_dir (i, SB_FALSE)
            elseif type = -i then
               header.set_item_arrow_dir (i, SB_TRUE)
            else
               header.set_item_arrow_dir (i, SB_MAYBE)
            end
            i := i+1
         end
         Result := True
      end

feature -- Resource management

   create_resource is
         -- Create server-side resources
      do
         Precursor
         if delete_type = 0 then
            delete_type := application.register_drag_type (delete_type_name);
         end
         if uri_list_type = 0 then
            uri_list_type := application.register_drag_type (uri_list_type_name);
         end

         if refresh_timer = Void then
            refresh_timer := application.add_timeout (REFRESHINTERVAL, Current, ID_REFRESHTIMER);
         end
         big_folder	.create_resource
         mini_folder.create_resource
         big_doc	.create_resource
         mini_doc	.create_resource
         big_app	.create_resource
         mini_app	.create_resource
         list_directory    -- Do we have to do Current here?
         sort_items
      end

   detach_resource is
         -- Detach server-side resources
      do
         Precursor
         if refresh_timer /= Void then
            application.remove_timeout(refresh_timer);
            refresh_timer := Void
         end
         if open_timer /= Void then
            application.remove_timeout(open_timer);
            open_timer := Void
         end
         big_folder	.detach_resource
         mini_folder.detach_resource
         big_doc	.detach_resource
         mini_doc	.detach_resource
         big_app	.detach_resource
         mini_app	.detach_resource
         delete_type := 0
         uri_list_type := 0
      end

   destroy_resource is
         -- Destroy server-side resources
      do
         Precursor
         if refresh_timer /= Void then
            application.remove_timeout(refresh_timer)
            refresh_timer := Void
         end
         if open_timer /= Void then
            application.remove_timeout(open_timer)
            open_timer := Void
         end
         big_folder	.destroy_resource
         mini_folder.destroy_resource
         big_doc	.destroy_resource
         mini_doc	.destroy_resource
         big_app	.destroy_resource
         mini_app	.destroy_resource
      end

feature {NONE} -- Implementation

	comparator: SB_FILE_LIST_ITEM_COMPARATOR is
		once
			create Result
		end

	sorter: SB_H_ARRAY_SORTER [ SB_FILE_LIST_ITEM ] is
		once
			create Result
		end

	create_item (txt: STRING; big,mini: SB_ICON; data: ANY): SB_FILE_LIST_ITEM is
    	do
        	create Result.make(txt, big, mini, data);
		end

	list_directory is
		deferred
		end

	convert_filetime (low_time, hi_time: INTEGER): INTEGER is
--		external "C"
--		alias "sb_file_filetime"

		do
		ensure
			implemented: false
		end

	TIMEFORMAT: STRING is once Result := "%%m/%%d/%%Y %%H:%%M:%%S" end

	REFRESHINTERVAL		: INTEGER is  1000
	REFRESHINTERVALLONG	: INTEGER is 15000

	bigapp: ARRAY [ INTEGER_8 ] is
		once
			Result := <<
				0x47, 0x49, 0x46, 0x38, 0x37, 0x61, 0x20, 0x00,
				0x20, 0x00, 0xF2, 0x00, 0x00, 0xB2, 0xC0, 0xDC,
				0x80, 0x80, 0x80, 0x00, 0x00, 0x00, 0xC0, 0xC0,
				0xC0, 0x00, 0x00, 0x80, 0xFF, 0xFF, 0xFF, 0x00,
				0x00, 0x00, 0x00, 0x00, 0x00, 0x2C, 0x00, 0x00,
				0x00, 0x00, 0x20, 0x00, 0x20, 0x00, 0x00, 0x03,
				0x82, 0x08, 0xBA, 0xDC, 0xFE, 0x2C, 0xC8, 0x49,
				0xAB, 0xBD, 0x53, 0x84, 0xC1, 0xBB, 0xFF, 0x60,
				0x38, 0x04, 0xDA, 0x40, 0x9C, 0x68, 0xAA, 0xAE,
				0x2C, 0xB9, 0xB1, 0x70, 0xCA, 0x09, 0xF3, 0xEC,
				0x9A, 0x71, 0x5C, 0x0F, 0x34, 0x7F, 0xE7, 0x31,
				0x81, 0x70, 0x38, 0xBC, 0x89, 0x8E, 0xC8, 0x51,
				0x09, 0xC3, 0x6C, 0x2A, 0x37, 0x81, 0x82, 0x74,
				0x4A, 0xAD, 0x5A, 0xAB, 0xCF, 0xD1, 0x75, 0xCB,
				0x95, 0x66, 0xA3, 0xDD, 0x30, 0xF5, 0x2B, 0x2E,
				0x17, 0xC8, 0xE6, 0x30, 0x3A, 0xCD, 0x5D, 0xB3,
				0xAF, 0xEE, 0x37, 0xF6, 0x06, 0x96, 0x5B, 0xE3,
				0x76, 0x2F, 0x3D, 0x7F, 0xDF, 0xF3, 0xC7, 0x7E,
				0x7F, 0x7A, 0x4B, 0x82, 0x53, 0x78, 0x79, 0x87,
				0x76, 0x89, 0x72, 0x8B, 0x6F, 0x59, 0x49, 0x90,
				0x1F, 0x2E, 0x4D, 0x94, 0x4C, 0x44, 0x97, 0x98,
				0x99, 0x9A, 0x43, 0x10, 0x9D, 0x9E, 0x9F, 0xA0,
				0xA1, 0x00, 0x09, 0x00, 0x3B
			>>
		end

	miniapp: ARRAY [ INTEGER_8 ] is
		once
			Result := <<
				0x47, 0x49, 0x46, 0x38, 0x37, 0x61, 0x10, 0x00,
				0x10, 0x00, 0xF2, 0x00, 0x00, 0xB2, 0xC0, 0xDC,
				0x80, 0x80, 0x80, 0xC0, 0xC0, 0xC0, 0x00, 0x00,
				0x00, 0xFF, 0xFF, 0xFF, 0x00, 0x00, 0x80, 0x00,
				0x00, 0x00, 0x00, 0x00, 0x00, 0x2C, 0x00, 0x00,
				0x00, 0x00, 0x10, 0x00, 0x10, 0x00, 0x00, 0x03,
				0x38, 0x08, 0xBA, 0xDC, 0x10, 0x30, 0xCA, 0x09,
				0x85, 0xBD, 0xF8, 0x86, 0x11, 0x44, 0xF9, 0x60,
				0xF8, 0x6D, 0x9D, 0x58, 0x10, 0x03, 0x8A, 0x92,
				0x02, 0xE5, 0x72, 0x02, 0x21, 0xCF, 0xB4, 0xCC,
				0xD6, 0x38, 0x71, 0xE7, 0xF4, 0xCE, 0xDB, 0xB0,
				0xDF, 0xCC, 0xF7, 0x23, 0xF2, 0x48, 0xAE, 0xD7,
				0x60, 0xC9, 0x6C, 0x3A, 0x07, 0x8E, 0xE8, 0x22,
				0x01, 0x00, 0x3B
			>>
		end

	bigdoc: ARRAY [ INTEGER_8 ] is
		once
			Result := <<
				0x47, 0x49, 0x46, 0x38, 0x37, 0x61, 0x20, 0x00,
				0x20, 0x00, 0xF2, 0x00, 0x00, 0xBF, 0xBF, 0xBF,
				0x80, 0x80, 0x80, 0xFF, 0xFF, 0xFF, 0x00, 0x00,
				0x00, 0xC0, 0xC0, 0xC0, 0x00, 0x00, 0x00, 0x00,
				0x00, 0x00, 0x00, 0x00, 0x00, 0x2C, 0x00, 0x00,
				0x00, 0x00, 0x20, 0x00, 0x20, 0x00, 0x00, 0x03,
				0x79, 0x08, 0x0A, 0xD1, 0xFE, 0xF0, 0xAD, 0x49,
				0x99, 0xB8, 0x38, 0xEB, 0x1B, 0x46, 0xAD, 0xC1,
				0x26, 0x66, 0x8D, 0xF7, 0x2D, 0xE1, 0x38, 0x06,
				0x44, 0x77, 0x2A, 0xA9, 0xBA, 0x85, 0xAD, 0xF9,
				0xC5, 0x32, 0x79, 0xD5, 0x27, 0x9E, 0x73, 0x83,
				0xA0, 0xF0, 0xF6, 0x93, 0x11, 0x6C, 0x13, 0x5F,
				0x31, 0x73, 0x24, 0x2E, 0x45, 0x4D, 0xD0, 0x13,
				0x8A, 0x44, 0x4D, 0x37, 0x51, 0x8A, 0x72, 0x9A,
				0x4D, 0x5E, 0x35, 0x5D, 0xEB, 0x17, 0x13, 0x86,
				0x8D, 0xC9, 0x55, 0xF3, 0x59, 0x50, 0xB6, 0xAC,
				0xDB, 0xDB, 0x27, 0x7C, 0xCD, 0x4E, 0xBB, 0xCF,
				0xF3, 0xB7, 0x3D, 0xBE, 0xCC, 0xE3, 0xF7, 0x74,
				0x7E, 0x63, 0x82, 0x5F, 0x84, 0x57, 0x86, 0x5C,
				0x80, 0x7A, 0x37, 0x04, 0x8D, 0x8E, 0x8F, 0x90,
				0x91, 0x8D, 0x76, 0x42, 0x95, 0x96, 0x97, 0x98,
				0x0B, 0x09, 0x00, 0x3B
			>>
		end

	minidoc: ARRAY [ INTEGER_8 ] is
		once
			Result := <<
				0x47, 0x49, 0x46, 0x38, 0x37, 0x61, 0x10, 0x00,
				0x10, 0x00, 0xF2, 0x00, 0x00, 0xBF, 0xBF, 0xBF,
				0x80, 0x80, 0x80, 0xFF, 0xFF, 0xFF, 0xC0, 0xC0,
				0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
				0x00, 0x00, 0x00, 0x00, 0x00, 0x2C, 0x00, 0x00,
				0x00, 0x00, 0x10, 0x00, 0x10, 0x00, 0x00, 0x03,
				0x36, 0x08, 0x10, 0xDC, 0xAE, 0x70, 0x89, 0x49,
				0xE7, 0x08, 0x51, 0x56, 0x3A, 0x04, 0x86, 0xC1,
				0x46, 0x11, 0x24, 0x01, 0x8A, 0xD5, 0x60, 0x2A,
				0x21, 0x6A, 0xAD, 0x9A, 0xAB, 0x9E, 0xAE, 0x30,
				0xB3, 0xB5, 0x0D, 0xB7, 0xF2, 0x9E, 0xDF, 0x31,
				0x14, 0x90, 0x27, 0xF4, 0xD5, 0x86, 0x83, 0xA4,
				0x72, 0x09, 0x2C, 0x39, 0x9F, 0xA6, 0x04, 0x00,
				0x3B
			>>
		end

	bigfolder: ARRAY [ INTEGER_8 ] is
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

	bigfolderopen: ARRAY [ INTEGER_8 ] is
		once
			Result := <<
				0x47, 0x49, 0x46, 0x38, 0x37, 0x61, 0x20, 0x00,
				0x20, 0x00, 0xF2, 0x00, 0x00, 0xB2, 0xC0, 0xDC,
				0x77, 0x77, 0x77, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
				0x00, 0xBB, 0xBB, 0xBB, 0x00, 0x00, 0x00, 0x80,
				0x80, 0x00, 0x00, 0x00, 0x00, 0x2C, 0x00, 0x00,
				0x00, 0x00, 0x20, 0x00, 0x20, 0x00, 0x00, 0x03,
				0xA1, 0x08, 0xBA, 0x10, 0xFE, 0x8F, 0xC9, 0x49,
				0x83, 0xB8, 0x18, 0x07, 0xCA, 0xA5, 0x1D, 0x04,
				0x28, 0x86, 0xC4, 0xD6, 0x71, 0x1F, 0x39, 0x8E,
				0xE6, 0xC9, 0xA4, 0xAB, 0x4A, 0x42, 0xB4, 0xE3,
				0x09, 0x72, 0x2C, 0x66, 0xFC, 0x55, 0xBC, 0x02,
				0x5D, 0x6E, 0xB8, 0x32, 0xFC, 0x14, 0x16, 0xA2,
				0x52, 0x68, 0x5C, 0xC0, 0x96, 0xD0, 0x41, 0xD3,
				0x41, 0xA8, 0x5A, 0xAF, 0xD8, 0xEC, 0x15, 0x64,
				0xB4, 0xF4, 0xBE, 0xE0, 0x4C, 0x21, 0x20, 0x1D,
				0x0B, 0xCF, 0xCA, 0x40, 0x81, 0xD0, 0x8D, 0xBA,
				0x07, 0xEA, 0x32, 0xF9, 0x1D, 0x1D, 0xB7, 0xD1,
				0x78, 0x99, 0xFD, 0x17, 0xA0, 0xE3, 0xD5, 0x53,
				0x79, 0x82, 0x25, 0x05, 0x53, 0x7E, 0x50, 0x85,
				0x7C, 0x83, 0x82, 0x89, 0x48, 0x8B, 0x50, 0x6A,
				0x47, 0x7D, 0x8F, 0x67, 0x91, 0x8E, 0x87, 0x42,
				0x04, 0x05, 0x92, 0x98, 0x4A, 0x9B, 0x4E, 0x9D,
				0x3A, 0x4D, 0x97, 0x94, 0x43, 0xA3, 0x0D, 0x06,
				0xA9, 0xAA, 0xAB, 0xAC, 0xAD, 0xAD, 0x47, 0x0A,
				0x9B, 0xB2, 0xB3, 0xB4, 0xB5, 0xB6, 0x2E, 0xB8,
				0xB9, 0xBA, 0xBB, 0xBC, 0xBD, 0xBE, 0xBF, 0xC0,
				0x13, 0x09, 0x00, 0x3B
			>>
		end

	minifolder: ARRAY [ INTEGER_8 ] is
		once
			Result := <<
				0x47, 0x49, 0x46, 0x38, 0x37, 0x61, 0x10, 0x00,
				0x10, 0x00, 0xF2, 0x00, 0x00, 0xB2, 0xC0, 0xDC,
				0x80, 0x80, 0x80, 0xC0, 0xC0, 0xC0, 0xFF, 0xFF,
				0x00, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0xFF, 0x00,
				0x00, 0x00, 0x00, 0x00, 0x00, 0x2C, 0x00, 0x00,
				0x00, 0x00, 0x10, 0x00, 0x10, 0x00, 0x00, 0x03,
				0x3B, 0x08, 0xBA, 0xDC, 0x1B, 0x10, 0x3A, 0x16,
				0xC4, 0xB0, 0x22, 0x4C, 0x50, 0xAF, 0xCF, 0x91,
				0xC4, 0x15, 0x64, 0x69, 0x92, 0x01, 0x31, 0x7E,
				0xAC, 0x95, 0x8E, 0x58, 0x7B, 0xBD, 0x41, 0x21,
				0xC7, 0x74, 0x11, 0xEF, 0xB3, 0x5A, 0xDF, 0x9E,
				0x1C, 0x6F, 0x97, 0x03, 0xBA, 0x7C, 0xA1, 0x64,
				0x48, 0x05, 0x20, 0x38, 0x9F, 0x50, 0xE8, 0x66,
				0x4A, 0x75, 0x24, 0x00, 0x00, 0x3B
			>>
		end

	minifolderopen: ARRAY [ INTEGER_8 ] is
		once
			Result := <<
				0x47, 0x49, 0x46, 0x38, 0x37, 0x61, 0x10, 0x00,
				0x10, 0x00, 0xF2, 0x00, 0x00, 0xB2, 0xC0, 0xDC,
				0x00, 0x00, 0x00, 0x7F, 0x7F, 0x7F, 0xFF, 0xFF,
				0xFF, 0xD9, 0xD9, 0xD9, 0xFF, 0xFF, 0x00, 0x00,
				0x00, 0x00, 0x00, 0x00, 0x00, 0x2C, 0x00, 0x00,
				0x00, 0x00, 0x10, 0x00, 0x10, 0x00, 0x00, 0x03,
				0x42, 0x08, 0xBA, 0xDC, 0x2C, 0x10, 0xBA, 0x37,
				0x6A, 0x15, 0x13, 0x88, 0x41, 0x4A, 0x27, 0x43,
				0x14, 0x29, 0x9B, 0x67, 0x82, 0x56, 0x18, 0x68,
				0xDC, 0xE9, 0x12, 0x42, 0x20, 0xCE, 0x62, 0x11,
				0x6F, 0x69, 0x1E, 0xC3, 0x72, 0xFB, 0xB9, 0xB2,
				0x18, 0xEB, 0x47, 0xBC, 0xAD, 0x4A, 0xC4, 0x93,
				0x6C, 0xC5, 0x7A, 0x99, 0x62, 0x4C, 0x1A, 0x2D,
				0xC0, 0x04, 0x50, 0xAF, 0x58, 0x6C, 0x66, 0xCB,
				0x6D, 0x24, 0x00, 0x00, 0x3B
			>>
		end

end

