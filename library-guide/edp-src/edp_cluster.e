--|---------------------------------------------------------|
--| Copyright (c) Howard Thomson 1999,2000,2001,2006		|
--| 52 Ashford Crescent										|
--| Ashford, Middlesex TW15 3EB								|
--| United Kingdom											|
--|---------------------------------------------------------|

-- Cluster / Directory of (Eiffel ?) Classes

note
	description: "A cluster of Eiffel Classes"
	author: "Howard Thomson"
	todo: "[
		Fix 'expand' to detect non-existent or inaccessible directory path
		Edit get_class; dependency on CLASS_INTERFACE, FEC specific
		Review recursive scan of directory
			-- see comments in ePosix/ABSTRACT_DIRECTORY
			ensure assertions not met when traversing symbolic links
	]"
class EDP_CLUSTER

inherit

	ANY	-- for SE2.1rc#1

	ET_LACE_CLUSTER
		redefine
			make
		end

	EDP_GLOBAL

create
	make

feature -- Attributes

	cluster_info_file_name: STRING = ".edp_db"

	directory_path: STRING
	
--	classes:	FEC_LIST [ EDP_CLASS ]
	
	walked: BOOLEAN
	status: INTEGER
	
	class_name_clash: BOOLEAN

	locked: BOOLEAN
		-- is class not editable ?
		do
		end

	Status_null			: INTEGER = 0	-- No validity checks yet done
	Status_invalid_path	: INTEGER = 1
	Status_files_ok		: INTEGER = 2	-- No conflicting file updates
	Status_names_ok		: INTEGER = 3	-- No conflicting class names
	Status_OK			: INTEGER = 4

feature -- Creation

	make (a_name: like name_id; a_pathname: like pathname_id; a_universe: ET_UNIVERSE)
			-- Create new cluster
		do
			directory_path := a_pathname.name.twin
--			create classes.make
			precursor (a_name, a_pathname, a_universe)
		end

	add_classes, expand
		require
			valid_directory: not directory_path.is_empty	-- ???
		local
--			d: POSIX_DIRECTORY
--			fs: POSIX_FILE_SYSTEM
		do
--			if not walked then
--				walked := true
--				create fs
--				if fs.is_directory (directory_path) then
--					create d.make (directory_path)
--					d.set_recursive (is_recursive)
--					d.set_extension_filter (".e")
--					from
--						d.start
--					until
--						d.exhausted
--					loop
--						add_match(d.full_name)
--						d.forth
--					end
--					status := Status_OK
--				else
--					fx_trace(0, <<"Invalid path: ", directory_path>>)
--					status := Status_invalid_path
--				end
--			end
		end
		
--	add_match(s: STRING) is
--		local
--			sc: STRING	-- copy STRING, SE BUG
--			cn:	STRING	-- class name string
--			ec: EDP_CLASS
--			id: ET_IDENTIFIER
--		do
--			create sc.make_from_string(s)
--			cn := fn_to_cn (sc)
--			if has (cn) then
--				class_name_clash := true
--			end
--			create id.make (cn)
--#			create ec.make_edp (repository.identifiers # cn, sc)
--			create ec.make (id, classes.count + 1)
--			ec.set_filename (sc)
--			ec.set_cluster (Current)
--			classes.add_tail (ec)
--		end

	has(a_name: STRING): BOOLEAN
		-- is there a class named 'name' in this cluster
		local
			i: INTEGER
			n: INTEGER
		do
--			from
--				n := repository.identifiers # a_name
--				i := 1
--			until
--				i > classes.count or Result
--			loop
--				if (classes @ i).class_name = n then
--					Result := true
--				end
--				i := i + 1
--			end
		end
			

	fn_to_cn (s: STRING): STRING
		-- Convert filename to classname
		-- [ ..../ ] classname.e
		local
			i: INTEGER
		do
			Result := s.twin
			Result.remove_tail (2)	-- remove the ".e"
			from
				i := Result.index_of ('/', 1)
			until
				i = 0
			loop
--#				Result.remove_between (1, i)
				i := Result.index_of ('/', 1)
			end
		end

	set_directory_path (path: STRING)
		-- new value for 'directory_path'
		do
			if (path.count + 1) > directory_path.count then	-- SE STRING bug
				directory_path.resize (path.count + 1)
			end
			directory_path.copy (path)
			io.put_string (directory_path); io.put_string ("%N")
		end

	load_file_names
		-- Scan directory path for all matching file names
		do
			add_classes	-- Match '*.e' TODO
		end

	get_universe(p: EDP_PROJECT)
		-- Add the classes from this cluster to the project
		local
			i: INTEGER	-- counter
		do
--			add_classes
--			from
--				i := 1
--			until
--				i > classes.count
--			loop
--				p.add_class (classes @ i)
--				i := i + 1
--			end
		end

	is_parent (s: STRING): BOOLEAN
			-- Check whether directory_path is a substring of s
		require
			valid_path: directory_path /= Void
		do
--			if s.has_prefix (directory_path) then
--				Result := True
--			end
		end

	scan_cluster(p: EDP_PROJECT)
		local
			i: INTEGER
			c: EDP_CLASS
		do
--			from
--				i := 1
--			until
--				i > classes.count
--			loop
--				c := (classes @ i)
--				if not c.scanned then
--					c.scan
--				end
--				i := i + 1
--			end
		end

end -- EDP_CLUSTER