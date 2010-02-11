indexing
	platform:	"Win32 Implementation"
	description:"Widely used file queries and operations"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	adaptation:	"Howard Thomson <qo27@dial.pipex.com>"
	copyright:	"Copyright (c) 2003, Howard Thomson and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"mostly complete"

expanded class SB_FILE

inherit

	SB_FILE_DEF

feature -- Implementation of deferred routines

	list_files_opts (path, pattern: STRING; flags: INTEGER_32): ARRAY[STRING] is
			-- List files in a given directory.
			-- Returns the array of string which matched the
			-- pattern or satisfied the flag conditions.
      	local
         	matchmode: INTEGER_32
         	ffData: SB_WAPI_WIN32_FIND_DATA
         	hFindFile: POINTER
         	pathname, filename: STRING
         	no_more: BOOLEAN
         	t: INTEGER
      	do
         	create ffData.make
         	create Result.make (1, 0)

         	matchmode := FILEMATCH_FILE_NAME | FILEMATCH_NOESCAPE
         		-- Folding case
         	if (flags & LIST_CASEFOLD) /= Zero then matchmode := matchmode | FILEMATCH_CASEFOLD end

         	-- Copy directory name
         	create pathname.make_from_string (path)
         	if pathname.item (pathname.count) /= PATHSEP then
            	pathname.append_character (PATHSEP)
         	end
         	pathname.append_character ('*')

         		-- Open directory
         	mem.collection_off
         	hFindFile := wapi_ff.FindFirstFile (pathname.area.base_address, ffData.ptr)
         	mem.collection_on
         	if hFindFile /= wapi_ar.Invalid_handle_value then
            	from
            	until
               		no_more
            	loop
               		filename := ffData.file_name
               		fx_trace (0, <<"filename (before matching): ", filename>>)
               			-- Filter out files; a bit tricky...
               		if not ((ffData.file_attributes & wapi_ar.FILE_ATTRIBUTE_DIRECTORY) = Zero
                    	and then ((flags & LIST_NO_FILES) /= Zero 
                    or else ((ffData.file_attributes & wapi_ar.FILE_ATTRIBUTE_HIDDEN) /= Zero 
                    	and then (flags & LIST_HIDDEN_FILES) = Zero)
                    or else ((flags & LIST_ALL_FILES) = Zero 
                    	and then not match_opts (pattern, filename, matchmode))))
                  		-- Filter out directories; even more tricky!
                  	and then not ((ffData.file_attributes & wapi_ar.FILE_ATTRIBUTE_DIRECTORY) /= Zero
                    and then ((flags & LIST_NO_DIRS) /= Zero 
                    	or else ((ffData.file_attributes & wapi_ar.FILE_ATTRIBUTE_HIDDEN) /= Zero
                    		and then (flags & LIST_HIDDEN_DIRS) = Zero)
                        or else ((filename.is_equal (".") or else filename.is_equal (".."))
                        	and then (flags & LIST_NO_PARENT) /= Zero)
                        or else ((flags & LIST_ALL_DIRS) = Zero
                        	and then not match_opts (pattern, filename, matchmode))))
                	then                  
                  		-- Add to list
                  		fx_trace (0, <<"Adding (", filename, "), Result.count = ", Result.count.out>>)
                  		Result.force (filename, result.count + 1)
                  		fx_trace (0, <<"New Result.count = ", Result.count.out>>)
               		end
               		no_more := wapi_ff.FindNextFile (hFindFile, ffData.ptr) = 0
            	end
            	t := wapi_ff.FindClose (hFindFile)
			else
				fx_trace (0, <<"Invalid handle">>)
         	end
		end

feature

   environment (var: STRING): STRING is
         -- Return value of environment variable name
      local
         buffer_size: INTEGER
         exit: BOOLEAN
      do
         from
            create Result.make_empty
         until
            exit
         loop
            mem.collection_off
            buffer_size := wapi_pf.GetEnvironmentVariable
               (var.area.base_address, Result.area.base_address, buffer_size)
            mem.collection_on
            if buffer_size = 0 then
               -- The variable is not present
               Result := Void
               exit := True
            elseif buffer_size < Result.count then
               -- The buffer size is enough
               Result.resize (buffer_size)
               exit := True
            else
               -- The buffer size is not enough
               -- Let's increase the size
               Result.resize (buffer_size)
            end
         end
      end

   user_directory (user: STRING): STRING is
         -- Return the home directory for a given user.
      local
         key, str1, str2: STRING
         hkey: POINTER      
         home: STRING
         t, sz, res: INTEGER
      do
         if user.is_empty then
            str1 := environment ("HOME")
            if str1 /= Void then
               Result := str1
            else
               str2 := environment ("HOMEPATH");
               if str2 /= Void then -- This should be good for WinNT, Win2K according to MSDN
                  str1 := environment ("HOMEDRIVE");
                  if str1 = Void then str1 := "c:" end
                  Result := str1 + str2
               end
            end
            if Result = Void then
               key := "Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders"
               mem.collection_off
               res := wapi_rf.RegOpenKeyEx (wapi_rkc.HKEY_CURRENT_USER, key.area.base_address, 0, wapi_rkc.KEY_READ, $hkey)
               mem.collection_on
               if res = 0 then
                  create home.make_filled ('%U', 1024)
                  sz := 1024
                  -- Change "Personal" to "Desktop" if you want...
                  key := "Personal"
                  mem.collection_off
                  res := wapi_rf.RegQueryValueEx (hkey, key.area.base_address, default_pointer, default_pointer, home.area.base_address, $sz)
                  mem.collection_on
                  t := wapi_rf.RegCloseKey (hkey)
                  if res = 0 then
                     home.resize (sz)
                     Result := home
                  end
               end
            end
            if Result = Void then
               Result := "c:" + PATHSEPSTRING
            end
         end
      end

   temp_directory: STRING is
         -- Return temporary directory.
      local
         buffer: STRING
         len: INTEGER
      do
         create buffer.make_filled ('%U', 1024)
         mem.collection_off
         len := wapi_ff.GetTempPath (1024, buffer.area.base_address)
         mem.collection_on
         if 1 < len and then ISPATHSEP (buffer.item (len)) and then not ISPATHSEP (buffer.item (len-1)) then
            len := len - 1
         end
         if len > 0 then
            buffer.resize (len)
            Result := buffer
         end
      end

   current_directory: STRING is
         -- Get the current working directory
      local
         buffer: STRING
         len: INTEGER
      do
         create buffer.make_filled ('%U', 1024)
         mem.collection_off
         len := wapi_ff.GetCurrentDirectory (1024, buffer.area.base_address)
         mem.collection_on
         if len > 0 then
            buffer.resize (len)
            Result := buffer
         end
      end

   	current_drive: STRING is
         	-- Return the current drive (for Win32 systems)
      	local
         	buffer: STRING
         	res: INTEGER
      	do
         	create Result.make_empty
         	create buffer.make_filled ('%U',1024)
         	res := wapi_ff.GetCurrentDirectory (1024, buffer.area.base_address)
         	if res /= 0 and then utils.is_alpha (buffer.item (1)) 
            and then buffer.item (2) = ':' then
            	buffer.put (u.to_lower (buffer.item (1)), 1)
            	buffer.resize (2)
            	Result := buffer
         	end
      	end

   	set_current_directory (path: STRING) is
         	-- Set the current working directory
      	local
         	t: INTEGER
      	do
         	mem.collection_off
         	t := wapi_ff.SetCurrentDirectory (path.area.base_address)
         	mem.collection_on
      	end

   set_current_drive (drv: STRING): BOOLEAN is
         -- Set the current drive (for Win32 systems)
      local
         t: INTEGER
         buffer: STRING
      do
         if utils.is_alpha (drv.item (1)) and then drv.item (2) = ':' then
            create buffer.make_empty
            buffer.append_character (drv.item (1))
            buffer.append_character (':')
            mem.collection_off
            Result := wapi_ff.SetCurrentDirectory (buffer.area.base_address) /= 0
            mem.collection_on
         end
      end

	drive (file: STRING): STRING is
    		-- Return the drive letter prefixing Current file name (if any).
		require else
        	file /= Void
      	do
         	create Result.make_empty
         	if file.count >= 2
         	and then utils.is_alpha (file.item (1))
         	and then file.item (2) = ':'
         	then
         		Result.append_character (u.to_lower (file.item (1)))
         		Result.append_character (':')
         	end
      	end

	expand (file: STRING): STRING is      
			-- Perform tilde or environment variable expansion
		local
         	buffer_size: INTEGER
         	exit: BOOLEAN
      	do
         	from
            	create Result.make_empty
         	until
            	exit
			loop
				mem.collection_off
				buffer_size := wapi_sif.ExpandEnvironmentStrings (file.area.base_address, Result.area.base_address, buffer_size)
				mem.collection_on
				if buffer_size = 0 then
					Result := file
					exit := True
				elseif buffer_size <= Result.count then
						-- The buffer size is enough
					Result.resize (buffer_size - 1)
					exit := True
				else
						-- The buffer size is not enough
						-- Let's increase the size
					Result.resize (buffer_size)
				end
			end
		end

	absolute_with_base (base, file: STRING): STRING is
			-- Return absolute path from base directory and file name
		require else
			file /= Void and then base /= Void
		local
			pathfile: STRING
		do
			pathfile := expand (file)
         	if pathfile.count > 0 and then ISPATHSEP (pathfile.item (1)) then
            	if pathfile.count >= 2 and then ISPATHSEP (pathfile.item (2)) then
	               	Result := simplify (pathfile)   -- UNC
            	else
	               	Result := simplify (current_drive + pathfile)
            	end
			elseif pathfile.count >= 2
			and then utils.is_alpha (pathfile.item (1))
        	and then pathfile.item (2) = ':'
        	then            
            	if pathfile.count >= 3 and then ISPATHSEP (pathfile.item (3))
             	then
               		Result := simplify (pathfile)
            	else
					Result := simplify (pathfile.substring (1, 2) + PATHSEPSTRING + utils.mid (pathfile, 3, 10 * 1024))
            	end
         	end
         	if Result = Void then
				Result := simplify (absolute (base) + PATHSEPSTRING + pathfile)
			end
		end

	relative_with_base (base, file: STRING): STRING is
			-- Return relative path of file to given base directory
			-- Examples:
			--
			--  Base       File         Result
			--  /a/b/c     /a/b/c/d     d
			--  /a/b/c/    /a/b/c/d     d
			--  /a/b/c/d   /a/b/c       ../
			--  ../a/b/c   ../a/b/c/d   d
			--  /a/b/c/d   /a/b/q       ../../q
			--  /a/b/c     /a/b/c       .
			--  /a/b/c/    /a/b/c/      .
			--  ./a        ./b          ../b
			--  a          b            ../b
		require else
			base /= Void and then file /= Void
		local
			p, q, b, ee: INTEGER
		do
			create Result.make_empty
				-- Find branch point
			from
				ee := base.count - 1
			until
				p > ee or else p >= file.count or else u.to_lower (base.item (p + 1)) /= u.to_lower (file.item (p + 1))
			loop
				if ISPATHSEP (file.item (p + 1)) then
					b := p
				end
				p := p + 1
			end

				-- Paths are equal
			if (p > ee or else (ISPATHSEP (base.item (p + 1)) and then p + 1 > ee)) 
			and then (p >= file.count or else (ISPATHSEP (file.item (p + 1)) and then p + 1 >= file.count))
			then
				Result := "."
			else
		    		-- Directory base is prefix of file
		    	if ( p > ee and then p < file.count and then ISPATHSEP (file.item (p + 1)))
		       	or else (p >= file.count and then p <= ee and then ISPATHSEP (base.item (p + 1)))
		     	then
		       		b := p
		    	end
		    
		    		-- Up to branch point
		    	from
		       		p := b
		       		q := b
		    	until
		       		p > ee
		    	loop
		       		from
		       		until
		          		q > ee or else ISPATHSEP (base.item (q + 1))
		       		loop
		          		q := q + 1
		       		end
		       		if q > p then Result.append_string (".." + PATHSEPSTRING) end
		       		from
		       		until
		          		q > ee or else not ISPATHSEP (base.item (q + 1))
		       		loop
		          		q := q + 1
		       		end
		       		p := q
		    	end

		    		-- Strip leading path character off, if any
		    	from
		    	until
					b >= file.count or else not ISPATHSEP (file.item (b + 1))
		    	loop
		       		b := b + 1
		    	end
		    		-- Append tail end
		    	if b < file.count then
		       		Result.append_string (file.substring (b + 1, file.count))
				end
			end
		end

	root (file: STRING): STRING is
			-- Return root directory of a given path
		do
			if not file.is_empty and then ISPATHSEP (file.item (1)) then
				if file.count >= 2 and then ISPATHSEP (file.item (2))then
					Result := PATHSEPSTRING + PATHSEPSTRING   -- UNC
				else
					Result := current_drive + PATHSEPSTRING
				end
			elseif file.count >= 2 and then utils.is_alpha (file.item (1))
			and then file.item (2) = ':' then
				if file.count >= 3 and then ISPATHSEP (file.item (3)) then
					Result := file.substring (1, 3)
				else
					Result := file.substring (1, 2) + PATHSEPSTRING
				end
			else
				Result := current_drive + PATHSEPSTRING
			end
		end

	enquote (file: STRING; forcequotes_: BOOLEAN): STRING is
         	-- Enquote filename to make safe for shell
    	require else
        	file /= Void
      	local
         	i, ee: INTEGER
         	c: CHARACTER
         	forcequotes: BOOLEAN
      	do
         	create Result.make_empty
         	forcequotes := forcequotes_
         	from
            	i := 1
            	ee := file.count
         	until
            	i > ee
         	loop
            	c := file.item (i)
            	if  c = '<' -- Redirections
               	or else c = '>'
               	or else c = '|'
               	or else c = '$'
               	or else c = ':'
               	or else c = '*' -- Wildcards
               	or else c = '?'
               	or else c = ' ' -- White space
             	then
               		forcequotes := True;
               		Result.append_character (c)
            	else
               		-- Normal characters just added
               		Result.append_character (c)
            	end
            	i := i + 1
         	end
			if forcequotes then Result := "%"" + Result + "%"" end
		end

   dequote (file: STRING): STRING is
         -- Dequote filename to get original again
      local
         i, e: INTEGER
         c: CHARACTER
      do
         create Result.make_empty
         e := file.count
         from
            i := 1
         until
            i > e or else not utils.is_space (file.item (i))
         loop
            i := i + 1
         end

         if i <= e and then file.item (i) = '"' then
            i := i + 1
            from
            until
               i > e or else file.item (i) = '"'
            loop
               c := file.item (i)
               Result.append_character (c)
               i := i + 1
            end
         else
            from
            until
               i > e or else utils.is_space (file.item (i))
            loop
               c := file.item (i)
               Result.append_character (c)
               i := i + 1
            end
         end
      end

	is_file (file: STRING): BOOLEAN is
			-- Return true if input path is a file name
		local
			atts: INTEGER_32
		do
			if not file.is_empty then
        	    mem.collection_off
        	    atts := wapi_ff.GetFileAttributes (file.area.base_address)
        	    Result := (atts /= 0xFFFFFFFF and then
                       (atts & wapi_ar.FILE_ATTRIBUTE_DIRECTORY) = Zero)
				mem.collection_on
			end
		end


feature { NONE } -- Implementation

	wapi_pf	: SB_WAPI_PROCESS_AND_THREAD_FUNCTIONS
   	wapi_ff	: SB_WAPI_FILE_FUNCTIONS
   	wapi_rf	: SB_WAPI_REGISTRY_FUNCTIONS
   	wapi_rkc: SB_WAPI_REGISTRY_KEY_CONSTANTS
   	wapi_sif: SB_WAPI_SYSTEM_INFORMATION_FUNCTIONS
   	wapi_ar	: SB_WAPI_FILES_AND_DIRS_ACCESS_RIGHTS
   	wapi_fa	: SB_WAPI_FILE_ACTIONS
   	wapi_hf	: SB_WAPI_HANDLE_AND_OBJECT_FUNCTIONS

   	ext_size (file: POINTER): INTEGER is
      	external "C"
      	alias "sb_file_size"
      	end

   	ext_modified (file: POINTER): INTEGER is
      	external "C"
      	alias "sb_file_modified"
      	end

   	ext_accessed (file: POINTER): INTEGER is
      	external "C"
      	alias "sb_file_accessed"
      	end

   	ext_created (file: POINTER): INTEGER is
      	external "C"
      	alias "sb_file_created"
      	end

   	ext_touched (file: POINTER): INTEGER is
      	external "C"
      	alias "sb_file_touched"
      	end

   	ext_executable (file: POINTER): BOOLEAN is
      	external "C"
      	alias "sb_file_executable"
      	end

   	ext_mode (file: POINTER): INTEGER_32 is
      	external "C"
      	alias "sb_file_mode"
      	end

   	ext_match (pattern, file: POINTER): BOOLEAN is
      	external "C"
      	alias "sbfilematch"
      	end

	ext_format_time (buffer: POINTER; bufsize: INTEGER; format: POINTER; filetime: INTEGER): INTEGER is
    	external "C"
    	alias "sb_format_time"
    	end

end