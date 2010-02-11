indexing
	description:"Widely used file queries and operations"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"mostly complete"

	todo: "[
		Remove Win32 specific code and transfer to descendant class
		specific to Win32 platform code
	]"

deferred class SB_FILE_DEF

inherit

	SB_NOT_IMPLEMENTED
		export {NONE} all
		end

	SB_DEFS

	SB_FILE_CONSTANTS

	KL_SHARED_FILE_SYSTEM

	KL_SHARED_OPERATING_SYSTEM

	SB_UTILS

	SB_EXPANDED

feature

	environment(var: STRING): STRING is
    		-- Return value of environment variable name
		require
			valid_name: var /= Void and then not var.is_empty
		deferred
		end

	home_directory: STRING is
		-- Return the home directory for the current user.
		do
			Result := user_directory("");
		end

	user_directory(user: STRING): STRING is
			-- Return the home directory for a given user.
		require
			user /= Void
		deferred
		end

   	temp_directory: STRING is
         	-- Return temporary directory.
		deferred
      	end

   	current_directory: STRING is
         	-- Get the current working directory
		deferred
      	end

   	current_drive: STRING is
        	-- Return the current drive (for Win32 systems)
		deferred
		end

   	exec_path: STRING is
         	-- Get executable path
      	do
         	Result := environment("PATH");
      	end

   	set_current_directory(path: STRING) is
         	-- Set the current working directory
      	require
         	path /= Void and then not path.is_empty
		deferred
      	end

   	set_current_drive(drv: STRING): BOOLEAN is
         	-- Set the current drive (for Win32 systems)
      	require
         	drv /= Void and then drv.count >= 2
		deferred
      	end

   	directory(file: STRING): STRING is
    		-- Return the directory part of the path name.
         	-- Note that directory("/bla/bla/") is "/bla/bla" and NOT "/bla".
         	-- However, directory("/bla/bla") is "/bla" as we expect not 
      	require
         	file /= Void
      	local
         	n, i, e: INTEGER;
      	do
         	create Result.make_empty;
         	if not file.is_empty then
            	i := 0;
            	if operating_system.is_windows then
            		-- strip Win32 leading Drive denotation
	            	if file.count >= 2
	            	and then utils.is_alpha(file.item(1))
	               	and then file.item(2) = ':' then
	               		i := 2;
	            	end
				end
            	if i < file.count and then ISPATHSEP(file.item(i+1)) then i := i+1 end
            	from
               		n := i;
               		e := file.count-1
            	until
               		i > e
            	loop
               		if ISPATHSEP(file.item(i+1)) then n := i end
               		i := i+1;
            	end
            	if n > 0 then
               		Result := file.substring(1,n);
            	end
        	end
		end

	name(file: STRING): STRING is
    		-- Return name and extension part of the path name.
        	-- Note that name("/bla/bla/") is "" and NOT "bla".
        	-- However, name("/bla/bla") is "bla" as we expect not 
		require
         	file /= Void
      	local
         	f, n, e: INTEGER;
      	do
         	create Result.make_empty
         	if not file.is_empty then
            	n := 0;
            	if operating_system.is_windows then
	            	if file.count >= 2 and then utils.is_alpha(file.item(1))
	               	and then file.item(2) = ':' then
	               		n := 2;
	            	end
				end
            	from
               		f := n;
               		e := file.count-1
            	until
               		n > e
            	loop
               		if ISPATHSEP(file.item(n + 1)) then f := n + 1 end
               		n := n+1;
            	end
            	if n - f > 0 then
               		Result := file.substring(1 + f, n);
            	end
         	end
      	end

	title(file: STRING): STRING is
         -- Return file title, i.e. document name only
         --
         --  /path/aa        -> aa
         --  /path/aa.bb     -> aa
         --  /path/aa.bb.cc  -> aa.bb
         --  /path/.aa       -> .aa
      require
         file /= Void
      local
         f,e,b,i,ee: INTEGER;
         done: BOOLEAN;
      do
         create Result.make_empty
         if not file.is_empty then
            i := 0;
			if operating_system.is_windows then
	            if file.count >= 2 and then utils.is_alpha(file.item(1))
	               and then file.item(2) = ':' then
	               i := 2
	            end
			end
            from
               f := i;
               ee := file.count-1
            until
               i > ee
            loop
               if ISPATHSEP(file.item(i+1)) then f := i+1 end
               i := i+1;
            end
            b := f;
            if b < file.count and then file.item(b+1) = '.' then b := b + 1 end  -- Leading '.'
            from
               e := i;
            until
               i <= b or else done
            loop
               i := i-1
               if file.item(i+1) = '.' then
                  e := i;
                  done := True
               end
            end
            if e-f > 0 then
               Result := file.substring(1+f,e);
            end
         end
      end

   extension(file: STRING): STRING is
         -- Return extension part of the file name
         --
         --  /path/aa        -> ""
         --  /path/aa.bb     -> bb
         --  /path/aa.bb.cc  -> cc
         --  /path/.aa       -> ""
      require
         file /= Void
      local
         f,e,i,n,ee: INTEGER;
         done: BOOLEAN;
      do
         create Result.make_empty;
         if not file.is_empty then
            n := 0;
            if operating_system.is_windows then
	            if file.count >= 2 and then utils.is_alpha(file.item(1))
	               and then file.item(2) = ':' then
	               n := 2
	            end
			end
            from
               f := n;
               ee := file.count-1
            until
               n > ee
            loop
               if ISPATHSEP(file.item(n+1)) then f := n+1 end
               n := n+1;
            end
            if f < file.count and then file.item(f+1) = '.' then f := f+1 end  -- Leading '.'
            from
               e := n;
               i := n;
            until
               i <= f or else done
            loop
               i := i-1
               if file.item(i+1) = '.' then
                  e := i+1;
                  done := True;
               end
            end
            if n-e > 0 then
               Result := file.substring(e+1,n);
            end
         end
      end

   strip_extension(file: STRING): STRING is
         -- Return file name less the extension
         --
         --  /path/aa        -> /path/aa
         --  /path/aa.bb     -> /path/aa
         --  /path/aa.bb.cc  -> /path/aa.bb
         --  /path/.aa       -> /path/.aa
      require
         file /= Void
      local
         f,e,n,ee: INTEGER;
         done: BOOLEAN;
      do
         create Result.make_empty
         if not file.is_empty then
            n := 0;
            if operating_system.is_windows
            and then file.count >= 2
            and then utils.is_alpha(file.item(1))
            and then file.item(2) = ':' then
            	n := 2
            end
            from
               f := n;
               ee := file.count-1
            until
               n > ee
            loop
               if ISPATHSEP(file.item(n+1)) then f := n+1 end
               n := n+1;
            end
            if f < file.count and then file.item(f+1) = '.' then f := f+1 end -- Leading '.'
            from
               e := n;
            until
               n <= f or else done
            loop
               n := n-1
               if file.item(n+1) = '.' then
                  e := n;
                  done := True
               end
            end
            if e > 0 then
               Result := file.substring(1,e);
            end
         end
      end

	drive(file: STRING): STRING is
    		-- Return the drive letter prefixing Current file name (if any).
		require
        	file /= Void
		deferred
      	end

   	expand(file: STRING): STRING is      
         	-- Perform tilde or environment variable expansion
      	require
         	file /= Void
		deferred
      	end

--### 'todo' from here #################################################

	simplify(file: STRING): STRING is
	    	-- Simplify a file path; the path will remain relative if it was relative,
	        -- or absolute if it was absolute.  Also, a trailing "/" will be preserved
	        -- as Current is important in other functions.
	        --
	        -- Examples:
	        --
	        --  /aa/bb/../cc    -> /aa/cc
	        --  /aa/bb/../cc/   -> /aa/cc/
	        --  /aa/bb/../..    -> /
	        --  ../../bb        -> ../../bb
	        --  ../../bb/       -> ../../bb/
	        --  /../            -> /
	        --  ./aa/bb/../../  -> ./
	        --  a/..            -> .
	        --  a/../           -> ./
	        --  ./a             -> ./a
	        --  /////./././      -> /
	        --  c:/../          -> c:/
	        --  c:a/..          -> c:
		require
         	file /= Void
      	local
         	p, q, s, ee: INTEGER;
      	do
         	if not file.is_empty then
             	create Result.make_from_string(file);
				if not operating_system.is_windows then
	             	if ISPATHSEP(result.item(q+1)) then
	                	Result.put(PATHSEP,p+1)
	                	p := p+1;
	                	from
	                   		ee := Result.count-1
	                	until
	                   		q > ee or else not ISPATHSEP(Result.item(q+1))
	                	loop
	                   		q := q+1;
	                	end
	             	end
				else
	             	if ISPATHSEP(Result.item(q+1)) then  -- UNC
	                	Result.put(PATHSEP,p+1)
	                	p := p+1;
	                	q := q+1;
	                	if ISPATHSEP(result.item(q+1)) then
	                   		Result.put(PATHSEP,p+1)
	                   		p := p+1;
	                   		from
	                      		ee := Result.count-1
	                   		until
	                      		q > ee or else not ISPATHSEP(Result.item(q+1))
	                   		loop
	                      		q := q+1;
	                   		end
	                	end
	             	elseif utils.is_alpha(result.item(q+1))
	             	and then Result.item(q+2) = ':' then
	                	Result.put(Result.item(q+1),p+1); p:= p+1; q := q+1
	                	Result.put(':',p+1); p := p+1;
	                	q := q+1;
	                	if q < Result.count and then ISPATHSEP(Result.item(q+1)) then
	                   		Result.put(PATHSEP,p+1) p := p+1
	                   		from
	                      		ee := Result.count-1
	                   		until
	                      		q > ee or else not ISPATHSEP(Result.item(q+1))
	                   		loop
	                      		q := q+1;
	                   		end
	                	end
	             	end
             	end
             	s := p;
             	from
                	ee := Result.count-1
             	until
                	q > ee
             	loop
                	from
                	until
                   		q > ee or else p > ee or else ISPATHSEP(Result.item(q+1))
                	loop
                   		Result.put(Result.item(q+1),p+1)
                   		p := p+1; q := q+1;
                	end
                	if 2 <= p and then result.item(p) = '.' and then ISPATHSEP(result.item(p-1))
                   	and then q <= ee and then ISPATHSEP(Result.item(q+1)) then
                   		p := p-2;
                	elseif 3 <= p and then Result.item(p) = '.' and then Result.item(p-1) = '.' 
                   	and then ISPATHSEP(Result.item(p-2)) 
                  	and then not (5 <= p and then Result.item(p-3) = '.' and then Result.item(p-4) = '.')
                 	then
                   		p := p-2;
                   		if s+2 <= p then
                      		p := p-2;
                      		from
                      		until
                         		p<=s or else ISPATHSEP(Result.item(p+1))
                      		loop
                         		p := p-1;
                      		end
                      		if p = 0 then
                         		Result.put('.',p+1);
                         		p := p+1;
                      		end
                   		end
                	end
                	if q <= ee and then ISPATHSEP(Result.item(q+1)) then
                   		from
                   		until
                      		q > ee or else not ISPATHSEP(Result.item(q+1))
                   		loop
                      		q := q+1;
                   		end
                   		if p = 0 or else not ISPATHSEP(Result.item(p)) then
                      		Result.put(PATHSEP,p+1);
                      		p := p+1
                   		end
                	end
             	end
             	Result.resize(p);
          	else
             	create Result.make_empty
          	end
		end

	absolute(file: STRING): STRING is
         	-- Return absolute path from current directory and file name
      	require
         	file /= Void
      	local
         	pathfile: STRING;
      	do
         	pathfile := expand(file);
			if not operating_system.is_windows then
	         	if pathfile.count > 0 and then ISPATHSEP (pathfile.item(1)) then
	            	Result := simplify (pathfile);
	         	end
			else
	         	if pathfile.count > 0 and then ISPATHSEP(pathfile.item(1)) then
	            	if pathfile.count >= 2 and then ISPATHSEP(pathfile.item(2)) then
	               		Result := simplify(pathfile);   -- UNC
	            	else
	               		Result := simplify(current_drive + pathfile);
	            	end
	         	elseif pathfile.count >= 2 and then utils.is_alpha(pathfile.item(1))
	            and then pathfile.item(2) = ':'
	          	then            
	            	if pathfile.count >= 3 and then ISPATHSEP(pathfile.item(3))
	             	then
	               		Result := simplify(pathfile);
	            	else
	               		Result := simplify (pathfile.substring(1, 2) + PATHSEPSTRING + utils.mid(pathfile, 3, 10 * 1024));
	            	end
	         	end
			end
         	if Result = Void then
            	Result := simplify(current_directory + PATHSEPSTRING + pathfile);
         	end
		end

	absolute_with_base(base, file: STRING): STRING is
			-- Return absolute path from base directory and file name
		require
			file /= Void and then base /= Void
		deferred
		end

	relative(file: STRING): STRING is
			-- Return relative path of file to the current directory
		require
			file /= Void
		do
			Result := relative_with_base(current_directory, file);
		end

	relative_with_base(base, file: STRING): STRING is
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
		require
			base /= Void and then file /= Void
		deferred
		end

	root(file: STRING): STRING is
			-- Return root directory of a given path
		require
			file /= Void
		deferred
		end

	enquote(file: STRING; forcequotes_: BOOLEAN): STRING is
			-- Enquote filename to make safe for shell
		require
			file /= Void
		deferred
		end

	dequote(file: STRING): STRING is
			-- Dequote filename to get original again
		require
			file /= Void
		deferred
		end


	unique_filename(file: STRING): STRING is
			-- Generate unique filename of the form pathnameXXX.ext, where
			-- pathname.ext is the original input file, and XXX is a number,
			-- possibly is_empty, that makes the file unique.
		require
			file /= Void
		local
			ext, path, filename: STRING;
			count: INTEGER;
		do
--			if not exists(file) then
--				create Result.make_from_string(file);
--			else
--				create Result.make_empty
--				ext := extension(file);
--            	path := strip_extension(file);                 -- Use the new API (Jeroen)
--            	if not ext.is_empty then ext.prepend(".") end  -- Only add period when non-is_empty extension
--            	from
--               		count := 0;
--            	until
--               		count >= 1000
--            	loop
--               	filename := path + count.out + ext;
--               	if not exists(filename) then
--                	  	Result := filename;
--                	  	count := 1000;
--               	else
--                	  	count := count+1;
--              	end
--				end
--			end
		ensure
			implemented: false
		end

	search(pathlist, file: STRING): STRING is
			-- Search path list for this file, return full path name for first 
			-- occurrence
		require
			pathlist /= Void and then file /= Void
		do
			not_implemented;
		end

	up_level(file: STRING): STRING is
			-- Return path to directory above input directory name
		require
			file /= Void
		local
			beg, endd: INTEGER;
			done: BOOLEAN;
		do
			if not file.is_empty then
				beg := 0;
            	endd := file.count;
				if not operating_system.is_windows then
            		if ISPATHSEP(file.item(1)) then
	               		beg := beg + 1;
            		end
				else
	           		if ISPATHSEP(file.item(1)) then
	               		beg := beg + 1;
	               		if file.count >= 2 and then ISPATHSEP(file.item(2)) then
	                  		beg := beg + 1;     -- UNC
	               		end
            		elseif file.count >= 2 and then utils.is_alpha(file.item(1)) 
	               	and then file.item(2) = ':'
             		then
	               		beg := beg + 2;
	               		if file.count >= 3 and then ISPATHSEP(file.item(3)) then
	                  		beg := beg + 1;
	               		end
            		end
				end
            	if beg < endd and then ISPATHSEP(file.item(endd)) then endd := endd-1 end
            		from
            		until
	               		endd <= beg or else done
            		loop
	               		endd := endd - 1
	               		if ISPATHSEP(file.item(endd+1)) then
	                  		done := True;
	               		end
            		end
            		Result := utils.mid(file, 1, endd);
         		else
            	create Result.make_from_string(PATHSEPSTRING);
	       	end
		end

--   is_absolute(file: STRING): BOOLEAN is
--         -- Return true if file name is absolute
--      require
--         file /= Void
--      do
--         if not file.is_empty then
--#ifndef WIN32
--            Result := ISPATHSEP(file.item(1));
--#else
--            Result := ISPATHSEP(file.item(1))
--               or else (file.count >= 2 and then utils.is_alpha(file.item(1))
--                        and then file.item(2) = ':')
--#endif
--         end
--      end

	is_top_directory(file: STRING): BOOLEAN is
			-- Return true if input directory is a top-level directory
		require
			file /= Void
		do
			if not file.is_empty then
				if not operating_system.is_windows then
					Result := ISPATHSEP(file.item(1)) and then file.count = 1;
				else
					Result := ((ISPATHSEP(file.item(1))
						and then (file.count = 1 or else (file.count = 2 and then ISPATHSEP(file.item(2))))))
					or else (file.count >= 2 and then utils.is_alpha(file.item(1)) and then file.item(2) = ':' 
						and then (file.count = 2 or else (file.count = 3 and then ISPATHSEP(file.item(3)))))
				end
			end
		end

	is_file(file: STRING): BOOLEAN is
			-- Return true if input path is a file name
		require
			file /= Void
		deferred
		end

	is_link(file: STRING): BOOLEAN is
			-- Return true if input path is a link
		require
			filename_not_void: file /= Void
		do
		end

	is_directory(path: STRING): BOOLEAN is
			-- Return true if input path is a directory
		require
			path /= Void
		do
			Result := file_system.directory_exists(path)

--#ifdef WIN32
--      local
--         atts: INTEGER;
--      do
--         if not path.is_empty then
--            mem.collection_off
--            atts := wapi_ff.GetFileAttributes(path.to_external)
--            mem.collection_on
--            Result := (atts /= 11111111111111111111111111111111B and then
--                       (atts and wapi_ar.FILE_ATTRIBUTE_DIRECTORY) /= Zero)
--         end
--#endif
		end

--	is_readable(file: STRING): BOOLEAN is
--			-- Return true if file is readable
--		require
--			file /= Void
--#ifdef WIN32
--		local
--			atts: INTEGER;
--		do
--			if not file.is_empty then
--				mem.collection_off
--				atts := wapi_ff.GetFileAttributes(file.to_external)
--				mem.collection_on
--				Result := atts /= 11111111111111111111111111111111B
--			end
--#endif
--		end

	is_writable, is_writeable(file: STRING): BOOLEAN is
			-- Return true if file is writable
		require
			file /= Void
--#ifdef WIN32
--      local
--         atts: INTEGER;
		do
--         if not file.is_empty then
--            mem.collection_off
--            atts := wapi_ff.GetFileAttributes(file.to_external)
--            mem.collection_on
--            Result := (atts /= 11111111111111111111111111111111B and then
--                       (atts and wapi_ar.FILE_ATTRIBUTE_READONLY) = Zero)
--         end
--#endif
			Result := False	--## Temp!!
		ensure
--			implemented: false
		end

	is_executable(file: STRING): BOOLEAN is
--   -- Return true if file is executable
--      require
--         file /= Void
		do
--#ifdef WIN32
--         mem.collection_off
--         Result := ext_executable(file.to_external);
--         mem.collection_on
--#endif
		end

--   is_owner_read_write_execute(file: STRING): BOOLEAN is
--         -- Return true if owner has read-write-execute permissions
--      require
--         file /= Void
--      do
--#ifdef WIN32
--           Result := True;
--#endif
--      end

--   is_owner_readable(file: STRING): BOOLEAN is
--         -- Return true if owner has read permissions
--      require
--         file /= Void
--      do
--#ifdef WIN32
--         Result := is_readable(file);
--#endif
--      end

--   is_owner_writable(file: STRING): BOOLEAN is
--         -- Return true if owner has write permissions
--      do
--#ifdef WIN32
--         Result := is_writable(file);
--#endif
--      end

--   is_owner_executable(file: STRING): BOOLEAN is
--         -- Return true if owner has execute permissions
--      do
--#ifdef WIN32
--         -- TODO
--         Result := True;
--#endif
--      end

--   is_group_read_write_execute(file: STRING): BOOLEAN is
--         -- Return true if group has read-write-execute permissions
--      do
--#ifdef WIN32
--         Result := True;
--#endif
--      end

--   is_group_readable(file: STRING): BOOLEAN is
--         -- Return true if group has read permissions
--      do
--#ifdef WIN32
--         Result := is_readable(file);
--#endif
--      end
--
--   is_group_writable(file: STRING): BOOLEAN is
--         -- Return true if group has write permissions
--      do
--#ifdef WIN32
--         Result := is_writable(file);
--#endif
--      end

--   is_group_executable(file: STRING): BOOLEAN is
--         -- Return true if group has execute permissions
--      do
--#ifdef WIN32
--         Result := True;
--         -- TODO
--#endif
--      end

--   is_other_read_write_execute(file: STRING): BOOLEAN is
--         -- Return true if others have read-write-execute permissions
--      do
--#ifdef WIN32
--         Result := True;
--#endif
--      end

--   is_other_readable(file: STRING): BOOLEAN is
--         -- Return true if others have read permissions
--      do
--#ifdef WIN32
--         Result := is_readable(file);
--#endif
--      end
--
--   is_other_writable(file: STRING): BOOLEAN is
--         -- Return true if others have write permissions
--      do
--#ifdef WIN32
--         Result := is_writable(file);
--#endif
--      end

--   is_other_executable(file: STRING): BOOLEAN is
--         -- Return true if others have execute permissions
--      do
--#ifdef WIN32
--         Result := True;
--         -- TODO
--#endif
--      end

--   is_set_uid(file: STRING): BOOLEAN is
--         -- Return true if the file sets the user resource_id on execution
--      do
--      end

--   is_set_gid(file: STRING): BOOLEAN is
--         -- Return true if the file sets the group resource_id on execution
--      do
--      end

--   is_set_sticky(file: STRING): BOOLEAN is
--         -- Return true if the file has the sticky bit set
--      do
--      end

--   owner_from_uid(uid: INTEGER): STRING is
--         -- Return owner name from uid if available
--      do
--         Result := "user"
--      end

--   owner(file: STRING): STRING is
--         -- Return owner name of file if available
--      require
--         file /= Void
--      do
--         create Result.make_empty
--      end

--   group_from_gid(gid: INTEGER): STRING is
--         -- Return group name from gid if available
--      do
--         Result := "group"
--      end

--   group(file: STRING): STRING is
--         -- Return group name of file if available
--      require
--         file /= Void
--      do
--         create Result.make_empty
--      end

--   permissions_from_mode(a_mode: INTEGER): STRING is
--         -- Return permissions string
--      do
--         Result := "-rwxrwxrwx"
--      end

--   size(file: STRING): INTEGER is
--         -- Return file size in bytes
--      require
--         file /= Void
--      do
--         if not file.is_empty then
--            mem.collection_off
--            Result := ext_size(file.to_external);
--            mem.collection_on
--         end
--      end

--   modified(file: STRING): INTEGER is
--         -- Return last modified time for Current file
--      require
--         file /= Void
--      do
--         if not file.is_empty then
--            mem.collection_off
--            Result := ext_modified(file.to_external);
--            mem.collection_on
--         end
--      end

--   accessed(file: STRING): INTEGER is
--         -- Return last accessed time for Current file
--      require
--         file /= Void
--      do
--         if not file.is_empty then
--            mem.collection_off
--            Result := ext_accessed(file.to_external);
--            mem.collection_on
--         end
--      end

	created(file: STRING): INTEGER is
			-- Return created time for Current file
		require
			file /= Void
		do
--         if not file.is_empty then
--            mem.collection_off
--            Result := ext_created(file.to_external);
--            mem.collection_on
--         end
		end

	touched(file: STRING): INTEGER is
			-- Return touched time for Current file
		require
			file /= Void
		do
--         if not file.is_empty then
--            mem.collection_off
--            Result := ext_touched(file.to_external);
--            mem.collection_on
--         end
		end

	match(pattern, file: STRING): BOOLEAN is
			-- Match filenames using *, ?, [^a-z], and so on
		require
			pattern /= Void and then file /= Void
		do
			Result := match_opts(pattern, file, FILEMATCH_NOESCAPE | FILEMATCH_FILE_NAME);
		end

	pattern_matcher: RX_PCRE_REGULAR_EXPRESSION is
		once
			create Result.make
		end

	match_opts(pattern, file: STRING; flags: INTEGER): BOOLEAN is
			-- Match filenames using *, ?, [^a-z], and so on
		require
        	pattern /= Void and then file /= Void
        local
        	p: RX_PATTERN_MATCHER
      	do
			p := pattern_matcher
			p.compile(pattern)
			if p.is_compiled then
				Result := p.recognizes(file)
			else
				print("Pattern does not compile: "); print(pattern); print("%N")
				Result := True
			end
		end

	list_files(path, pattern: STRING): ARRAY[STRING] is
			-- List files in a given directory.
			-- Returns the array of string which matched the
			-- pattern or satisfied the flag conditions.
		do
			Result := list_files_opts(path, pattern, LIST_MATCHING_FILES | LIST_MATCHING_DIRS);
		end

	list_files_opts(path, pattern: STRING; flags: INTEGER): ARRAY[STRING] is
		require
        	path /= Void and then not path.is_empty
        	pattern /= Void and then not pattern.is_empty
		deferred
		end



--   time(filetime: INTEGER): STRING is
--         -- Convert file time to date-string
--      do
--         Result := format_time(timeformat, filetime);
--      end

--   format_time(format: STRING;filetime: INTEGER): STRING is
--         -- Convert file time to date-string as per strftime.
--         -- Format characters supported by most systems are:
--         --
--         --  %a %A %b %B %c %d %H %I %j %m %M %p %S %U %w %W %x %X %y %Y %Z %%
--         --
--         -- Some systems support additional conversions.
--      require
--         format /= Void
--      local
--         sz: INTEGER;
--      do
--         create Result.make_filled('%U',1024);
--         mem.collection_off
--         sz := ext_format_time(Result.to_external,1024,format.to_external,filetime);
--         mem.collection_on;
--         Result.resize(sz);
--      end

--   exists(file: STRING): BOOLEAN is
--         -- Return true if file exists
--      require
--         file /= Void
--      do
--#ifdef WIN32
--         Result := is_readable(file);
--#endif
--      end
--
--   identical(file1,file2: STRING): BOOLEAN is
--         -- Return true if files are identical
--      do
--      end
--
--   mode(file: STRING): INTEGER is
--         -- Return the mode flags for Current file
--      require
--         file /= Void and then not file.is_empty
--      do
--         mem.collection_off
--         Result := ext_mode(file.to_external);
--         mem.collection_on
--      end


	set_mode(file: STRING; a_mode: INTEGER) is
			-- Change the mode flags for Current file
		do         
			not_implemented
		end

	create_directory(path: STRING; a_mode: INTEGER): BOOLEAN is
			-- Create new directory
		require
			path /= Void and then not path.is_empty
		do
			not_implemented
		end

	create_file(file: STRING; a_mode: INTEGER) is
			-- Create new (is_empty) file
		require
			file /= Void and then not file.is_empty
		do
			not_implemented
		end

	concatenate_files(srcfile1, srcfile2, dstfile: STRING; overwrite: BOOLEAN) is
    		-- Concatenate srcfile1 and srcfile2 to a dstfile.
        	-- If overwrite is true, then the operation fails if dstfile already exists.
        	-- srcfile1 and srcfile2 should not be the same as dstfile.
      	require
         	srcfile1 /= Void and then not srcfile1.is_empty 
         	srcfile2 /= Void and then not srcfile2.is_empty 
         	dstfile /= Void and then not dstfile.is_empty 
      	do
         	not_implemented
      	end

	remove_file(file: STRING): BOOLEAN is
    		-- Remove file or directory, recursively.
      	require
         	file /= Void and then not file.is_empty
      	do
			not_implemented
		end

	copy_file( srcfile,dstfile: STRING; overwrite: BOOLEAN) is
    		-- Copy file or directory, recursively
      	require
      		implemented: false
         	srcfile /= Void and then not srcfile.is_empty 
         	dstfile /= Void and then not dstfile.is_empty 
      	do
         	not_implemented
      	end

	move_file(srcfile, dstfile: STRING; overwrite: BOOLEAN) is
    		-- Rename or move file or directory
		require
			srcfile /= Void and then not srcfile.is_empty 
			dstfile /= Void and then not dstfile.is_empty 
      	do
         	not_implemented
      	end

	create_link(srcfile, dstfile: STRING; overwrite: BOOLEAN) is
    		-- Link file
      	require
         	srcfile /= Void and then not srcfile.is_empty 
         	dstfile /= Void and then not dstfile.is_empty 
      	do
         	not_implemented
      	end

	create_symlink(srcfile, dstfile: STRING overwrite: BOOLEAN) is
    		-- Symbolic link file
    	require
         	srcfile /= Void and then not srcfile.is_empty 
         	dstfile /= Void and then not dstfile.is_empty 
      	do
         	not_implemented
      	end

	symlink(file: STRING): STRING is
    		-- Read symbolic link
    	require
         	file /= Void and then not file.is_empty 
      	do
         	create Result.make_empty
      	end

	timeformat: STRING is once Result := "%%m/%%d/%%Y %%H:%%M:%%S" end

end
