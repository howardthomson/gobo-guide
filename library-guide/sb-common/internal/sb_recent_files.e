indexing
	description: "[
		The recent files object manages a most recently used (MRU)
		file list by means of the standard system registry.
		When connected to a widget, like a menu command, the recent files object
		updates the menu commands label to the associated recent file name; when
		the menu command is invoked, the recent file object sends its message_target a
		SEL_COMMAND message with the message data set to the associated file name,
		of the type const char*.
		When adding or removing file names, the recent files object automatically
		updates the system registry to record these changes.
	]"
	author: "Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright: "Copyright (c) 2002, Eugene Melekhov and others"
	license: "Eiffel Forum Freeware License v2 (see forum.txt)"
	status: "Mostly complete"
	todo: "[
		remove 'expanded XXX'

		Fix SB_WINDOW_COMMANDS usage
	]"

class SB_RECENT_FILES

inherit

	SB_MESSAGE_HANDLER
    	rename
    		Id_last as Message_handler_id_last
      	redefine
         	handle_2
      	end

	SB_MESSAGE_SENDER
		rename
		--	Id_last as Message_sender_id_last
		end

	SB_RECENT_FILES_COMMANDS

creation

   make, make_opts

feature -- Attributes

	group: STRING
			-- MRU File group

	maxfiles: INTEGER
			-- Maximum number of files to track

feature { NONE } -- Private Attributes

   application: SB_APPLICATION
   
feature -- class name

	class_name: STRING is
		once
			Result := "SB_RECENT_FILES"
		end

feature -- Creation

   	make (app: SB_APPLICATION; tgt: SB_MESSAGE_HANDLER; selector: INTEGER) is
         	-- Make new Recent Files Group with default groupname
      	require
         	app /= Void
      	do
         	make_opts (app,"Recent Files", tgt, selector)
         	maxfiles := 10
      	end

	make_opts (app: SB_APPLICATION; grp: STRING; tgt: SB_MESSAGE_HANDLER; selector: INTEGER) is
         	-- Make new Recent Files Group with groupname grp
      	require
         	app /= Void
         	grp /= Void
      	do
         	application := app
         	create group.make_from_string(grp)
         	message_target := tgt
         	message := selector
        	maxfiles := 10
		end

feature -- Settings

	set_max_files (mx: INTEGER) is
    		-- Change number of files we're tracking
      	do
         	maxfiles := mx
      	end

   	set_group_name (grp: STRING) is
         	-- Set group name
      	do
         	create group.make_from_string (grp)
      	end

feature -- Actions 

   append_file (filename: STRING) is
         -- Append a file
      require
         filename /= Void
      local
         newname, oldname, key: STRING
         i,j: INTEGER
         done, done1: BOOLEAN
      do
         create newname.make_from_string (filename);
         i := 1; j := 1
         from
         until
            done
         loop
            from
               done1 := false
            until
               done1
            loop
               key := "FILE"+ j.out; j := j+1;
               oldname := application.registry.read_string_entry (group, key, Void)
               if oldname = Void or else not oldname.is_equal (filename) then
                  done1 := True
               end
            end
            key := "FILE"+i.out; i := i+1
            application.registry.write_string_entry (group, key, newname)
            newname := oldname     
            if oldname = Void or else oldname.is_empty or else i > maxfiles then
               done := True
            end
         end
      end

   remove_file (filename: STRING) is
         -- Remove a file
      require
         filename /= Void
      local
         name, key: STRING
         i, j: INTEGER
         done: BOOLEAN
      do
--         i := 1; j := 1;
--         from
--         until
--            done
--         loop
--            key := "FILE"+i.out; i := i+1;
--            name := application.registry.read_string_entry (group, key, Void)
--            application.registry.delete_entry (group, key)
--            if name = Void or else name.is_empty then
--               done := True
--            else
--               if not name.is_equal(filename) then
--                  key := "FILE"+i.out; j := j+1
--                  application.registry.write_string_entry (group, key, name)
--               end
--            end
--            if i > maxfiles then
--               done := True
--            end
--         end
      end

	clear is
    		-- Clear the list of files
      	do
   --      	application.registry.delete_section (group)
      	end

feature -- Message processing

   handle_2 (sender: SB_MESSAGE_HANDLER; type, key: INTEGER; data: ANY): BOOLEAN is
      do
         if		match_function_2 (SEL_UPDATE,	ID_ANYFILES,type, key) then Result := on_upd_any_files	(sender, key, data)
         elseif match_function_2 (SEL_UPDATE,	ID_CLEAR,	type, key) then Result := on_upd_any_files	(sender, key, data)
         elseif match_function_2 (SEL_COMMAND,	ID_CLEAR,	type, key) then Result := on_cmd_clear		(sender, key, data)
         
         elseif match_functions_2 (SEL_COMMAND,	ID_FILE_1, ID_FILE_10, type, key) then Result := on_cmd_file (sender, key, data)
         elseif match_functions_2 (SEL_UPDATE,	ID_FILE_1, ID_FILE_10, type, key) then Result := on_upd_file (sender, key, data)
         else Result := Precursor (sender, type, key, data) end
      end

	on_cmd_clear (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
    	do
        	clear
        	Result := True
		end

	on_cmd_file (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
    	local
        	filename, key: STRING
      	do
         	if message_target /= Void then
            	key := "FILE" + (selid(selector) - ID_FILE_1 + 1).out;
            	filename := application.registry.read_string_entry (group, key, Void)
            	if filename /= Void then do_send (SEL_COMMAND, filename) end
         	end
         	Result := True;
      	end

	on_upd_file (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
		local
			which: INTEGER
			filename, string: STRING
			key: STRING
		do
			which := selid (selector) - ID_FILE_1 + 1
			key := "FILE" + which.out
			filename := application.registry.read_string_entry (group, key, Void)
			if filename /= Void then
				if which < 10 then
					string := "& " + which.out + filename
				else
					string := "1&0 " + filename
				end
			--	sender.do_handle_2 (Current, SEL_COMMAND, wc.Id_setstringvalue, string)
			--	sender.do_handle_2 (Current, SEL_COMMAND, wc.Id_show, Void)
			else
			--	sender.do_handle_2 (Current, SEL_COMMAND, wc.Id_hide, Void)
			end
			Result := True
		end

	on_upd_any_files (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
		do
			if application.registry.read_string_entry (group, "FILE1", Void) /= Void then
--				sender.do_handle_2 (Current, SEL_COMMAND, wc.Id_show, Void)
			else
--				sender.do_handle_2 (Current, SEL_COMMAND, wc.Id_hide, Void)
			end
			Result := True
		end

end
