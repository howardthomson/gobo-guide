indexing
	platform:	"Linux / X Window System Implementation"
	description:"Widely used file queries and operations"
	author:		"Howard Thomson <howard.thomson@dial.pipex.com>"
	copyright:	"Copyright (c) 2003-2006, Howard Thomson and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"mostly complete"

class SB_FILE

inherit
	SB_FILE_DEF

	KL_SHARED_FILE_SYSTEM

	KL_OPERATING_SYSTEM
		rename
			execution_environment as unused_execution_environment
		end

	KL_SHARED_EXECUTION_ENVIRONMENT

feature -- Implementation of deferred routines

	list_files_opts(path, pattern: STRING; flags: INTEGER): ARRAY[STRING] is
		do
		end

feature

	nyi_test: BOOLEAN is False

	environment(var: STRING): STRING is
    		-- Return value of environment variable name
		require else
			valid_name: var /= Void and then not var.is_empty
		do
			Result := Execution_environment.variable_value(var)
		end

	user_directory(user: STRING): STRING is
			-- Return the home directory for a given user.
		do
			if nyi_test then not_yet_implemented end
		--	create Result.make_empty
			Result := (once "/").twin
		end

	temp_directory: STRING is
    		-- Return temporary directory.
		do
         	-- Conform Linux File Hierarchy standard; this should be
         	-- good for SUN, SGI, HP-UX, AIX, and OSF1 also.
         	Result := "/tmp";
      	end

   	current_directory: STRING is
         	-- Get the current working directory
      	local
         	buffer: STRING;
		do
			if nyi_test then not_yet_implemented end
		--	create Result.make_empty
		--	Result := (once "/").twin
			Result := current_working_directory
      	end

	current_drive: STRING is
         	-- Return the current drive (for Linux systems)
      	do
         	create Result.make_empty;
      	end

	set_current_directory(path: STRING) is
			-- Set the current working directory
		do
			if nyi_test then not_yet_implemented end
		end

	set_current_drive(drv: STRING): BOOLEAN is
			-- Set the current drive (for Win32 systems)
		do
			if nyi_test then not_yet_implemented end
		end

	drive(file: STRING): STRING is
    		-- Return the drive letter prefixing Current file name (if any).
      	do
         	create Result.make_empty
      	end

   	expand(file: STRING): STRING is      
         	-- Perform tilde or environment variable expansion
        require else
        	non_void_file: file /= Void
        --	count_ge_1: file.count >= 1
		local
			b, e, n: INTEGER;
		do
			create Result.make_empty

			-- Expand leading tilde of the form ~/filename or ~user/filename
			n := 1;
			if file.count >= 2 and then (file @ n) = '~' then
				n := n + 1;
				b := n;
				from
				until
					n > file.count or else ISPATHSEP(file @ n)
				loop
					n := n + 1
				end
    			e := n;
    			Result.append(user_directory(file.substring(b, e - b)));
    		end

			-- Expand environment variables of the form $HOME, ${HOME}, or $(HOME)
			from
			until
				n > file.count
			loop
				if (file @ n) = '$' then
					n := n + 1;
			    	if (file @ n) = '{' or else (file @ n) = '(' then
			    		n := n + 1;
			    	end
			    	b := n;
					from
					until
						not(is_alnum(file @ n) or else (file @ n) = '_')
					loop
						n := n + 1
					end
			    	e := n;
			    	if (file @ n) = '}' or else (file @ n) = ')' then
			    		n := n + 1;
			    	end
			    	Result.append(environment(file.substring(b, e - b)));
				else
			    	Result.extend(file @ n);
			    	n := n + 1;
			    end
			end
      	end

	absolute_with_base(base, file: STRING): STRING is
			-- Return absolute path from base directory and file name
		require else
			file /= Void and then base /= Void
			
		local
			pathfile: STRING;
		do
			pathfile := expand(file);
			if pathfile.count > 0 and then ISPATHSEP(pathfile.item(1)) then
				Result := simplify(pathfile);
			end
			if Result = Void then
				Result := simplify(absolute(base) + PATHSEPSTRING + pathfile);
			end
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
		require else
			base /= Void and then file /= Void
		local
			p, q, b, ee: INTEGER;
		do
			create Result.make_empty;
			-- Find branch point
			from
				ee := base.count -1
			until
				p > ee or else p >= file.count or else base.item(p+1) /= file.item(p+1)
			loop
				if ISPATHSEP(file.item(p+1)) then
					b := p;
				end
				p := p+1
			end

			-- Paths are equal
			if (p > ee or else (ISPATHSEP(base.item(p+1)) and then p+1 >ee)) 
			and then (p >= file.count or else (ISPATHSEP(file.item(p+1)) and then p+1 >= file.count))
			then
				Result := ".";
			else
				-- Directory base is prefix of file
				if ( p > ee and then p < file.count and then ISPATHSEP(file.item(p+1)))
				or else (p >= file.count and then p <= ee and then ISPATHSEP(base.item(p+1)))
				then
					b := p;
				end

				-- Up to branch point
				from
					p := b;
					q := b;
				until
					p > ee
				loop
					from
					until
						q > ee or else ISPATHSEP(base.item(q+1))
					loop
						q:=q+1
					end
					if q>p then Result.append_string(".." + PATHSEPSTRING) end
					from
					until
						q > ee or else not ISPATHSEP(base.item(q+1))
					loop
						q := q + 1
					end
					p := q
				end

				-- Strip leading path character off, if any
				from
				until
					b >= file.count or else not ISPATHSEP(file.item(b+1))
				loop
					b := b + 1;
				end
				-- Append tail end
				if b < file.count then
					Result.append_string(file.substring(b+1, file.count))
				end
			end
		end

	root(file: STRING): STRING is
			-- Return root directory of a given path
		do
			Result := PATHSEPSTRING
		end

	enquote(file: STRING; a_force_quotes: BOOLEAN): STRING is
			-- Enquote filename to make safe for shell
    	require else
        	file /= Void
		local
         	i, ee: INTEGER;
         	c: CHARACTER;
         	force_quotes: BOOLEAN;
		do
         	create Result.make_empty
         	force_quotes := a_force_quotes
         	from
            	i := 1;
            	ee := file.count
         	until
            	i > ee
         	loop
            	c := file.item(i);             
            	if c = '%'' then -- Quote needs to be escaped
               		Result.append_string("\'");
				elseif c = '\' then -- Backspace needs to be escaped, of course
               		Result.append_string("\\");
            	elseif (c = '#' or else c = '~') and then i /= 1 then
               		Result.append_character(c); -- Only quote if at begin of filename
            	elseif c = '#' or else c = '~' 
               	or else c = '!' -- Special in csh
               	or else c = '"'
               	or else c = '$' -- Variable substitution
               	or else c = '&'
               	or else c = '('
               	or else c = ')'
               	or else c = ';'
               	or else c = '<' -- Redirections, pipe
               	or else c = '>'
               	or else c = '|'
               	or else c = '`' -- Command substitution
               	or else c = '^' -- Special in sh
               	or else c = '*' -- Wildcard characters
               	or else c = '?'
               	or else c = '['
               	or else c = ']'
               	or else c = '%T' -- White space
               	or else c = '%N'
               	or else c = ' '
             	then
               		force_quotes := True;
               		Result.append_character(c)
            	else
               		-- Normal characters just added
               		Result.append_character(c)
            	end
            	i := i + 1
         	end
         	if force_quotes then Result := "'" + Result + "'" end
		end

	dequote(file: STRING): STRING is
			-- Dequote filename to get original again
		local
			i, e: INTEGER;
			c: CHARACTER;
		do
			create Result.make_empty
			e := file.count
			from
				i := 1;
			until
				i > e or else not utils.is_space(file.item(i))
			loop
				i := i+1;
			end

			if i <= e and then file.item(i) = '%'' then
				i := i+1;
				from
				until
					i > e or else file.item(i)='%''
				loop
					c := file.item(i);
					if c = '\' and then i+1 <= e then
						i := i+1
						c := file.item(i);
					end
					Result.append_character(c);
					i := i+1;
				end
			else
				from
				until
					i > e or else utils.is_space(file.item(i))
				loop
					c := file.item(i);
					if c = '\' and then i+1 <= e then
						i := i+1
						c := file.item(i);
					end
					Result.append_character(c);
					i := i+1;
				end
			end
		end

	is_file(file: STRING): BOOLEAN is
			-- Return true if input path is a file name
		do
			Result := file_system.is_file_readable(file)
		end


end
