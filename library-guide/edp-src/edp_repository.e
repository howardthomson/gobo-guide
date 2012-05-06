-- Repository for Eiffel Design information


-- Information retained for objects of type:
--		Feature		
--		Class
--		Cluster		A set of classes, named for selection on Projects 
--		Project		The set of clusters for a given project
--		Universe	The set of all known classes & clusters

note
	description: "[
		This singleton class, reachable from EDP_GLOBALS, links to all
		instances of:
			EDP_CLUSTER		: Eiffel ACE cluster spec
			EDP_DIRECTORY	: Filesystem Directory
			EDP_FILE_PATH	: Filesystem file path
			EDP_FILE		: File (unique inode/device)

			EDP_CLASS_FILE	: Eiffel class
			EDP_C_FILE		: 'C' source file
			EDP_CPP_FILE	: 'C++' source file
			EDP_JAVA_FILE	: Java source file
			EDP_J_BYTECODE	: Java bytecode (class) file
	]"

	todo: "[
		Remove GPL/FEC dependency:

			MY_STRINGS

	]"

class EDP_REPOSITORY

inherit

	EDP_GOBO_STRINGS

	KL_IMPORTED_STRING_ROUTINES
		export
			{NONE} all
		undefine
			is_equal
		end

	KL_IMPORTED_CHARACTER_ROUTINES
		export
			{NONE} all
		undefine
			is_equal
		end

	KL_IMPORTED_INTEGER_ROUTINES
		export
			{NONE} all
		undefine
			is_equal
		end

	KL_IMPORTED_ANY_ROUTINES
		export
			{NONE} all
		undefine
			is_equal
		end

create
	make

feature -- Constant attributes

	clusters: DS_ARRAYED_LIST [ EDP_CLUSTER ]

	scanners: DS_ARRAYED_LIST [ SCANNER ]

	load_status: INTEGER

	Load_default,
	Load_failed,
	Load_done: INTEGER = unique
	
feature

	make
		do
			create clusters.make(128)
			create scanners.make(512)
		end

	load
			-- Load from default location(s)
		do
			load_from(".edp_repository")
		end

	load_from(fname: STRING)
			-- Create/initialise from lines in a text file
		local
--			fh: TEXT_FILE_READ
			s: STRING
			i: INTEGER
			b: BOOLEAN
		do
--			create s.make(0)
--			create fh.connect_to(fname)
--			if fh.is_connected then
--				from
--					i := 1
--				until
--					fh.end_of_input
--				loop
--					s.clear_count
--					fh.read_line_in(s)
--					if not fh.end_of_input and then not s.is_empty then
--						if s.has_suffix("loadpath.se") then
--							load_from(expand_filename(s))
--						else
--							-- ## Testing Recursive search
--							b := add_cluster(expand_filename(s), True)
--						end
--					end
--					i := i + 1
--				end
--				fh.disconnect
--				load_status := Load_done
--			else
				load_status := Load_failed
--			end	
		end

	gobo: STRING = "${GOBO}"
	eposix: STRING = "${EPOSIX}"

	gobo_path	: STRING = "/data/eiffel/lib/gobo"
	eposix_path : STRING = "/data/eiffel/lib/eposix"
	
	expand_filename(s: STRING): STRING
			-- expand ${env_name} into equivalent value
			-- Temporary version for ${EPOSIX} and ${GOBO} only !!
		local
			i: INTEGER
			h, t: STRING
		do
			i := s.substring_index(gobo, 1)
			if i /= 0 then
				h := s.twin	-- clone(s)
				h.keep_head(i - 1)
				t := s.twin	-- clone(s)
				t.remove_head(i + gobo.count - 1)
				h.append(gobo_path)
				h.append(t)
				Result := h
			else
				i := s.substring_index(eposix, 1)
				if i /= 0 then
					h := s.twin	-- clone(s)
					h.keep_head(i - 1)
					t := s.twin	-- clone(s)
					t.remove_head(i + eposix.count - 1)
					h.append(eposix_path)
					h.append(t)
					Result := h
				else
					Result := s
				end
			end
		end
				
				

	add_cluster(s: STRING; recursive: BOOLEAN): BOOLEAN
			-- Create and append new EDP_CLUSTER element
			-- Check that no existing recursive cluster includes the
			-- argument as a sub-directory
		local
			i: INTEGER
			id: ET_IDENTIFIER
			cp: ET_IDENTIFIER
			c: EDP_CLUSTER
		do
			from
				i := 1
				Result := True
			until
				i > clusters.count or not Result
			loop
				c := clusters.item(i)
				if c.is_recursive and then c.is_parent(s) then
					Result := False
				end
				i := i + 1
			end
			if Result then
				edp_trace.st(once "Repository add: '").n(s).n(once "'").d
				create id.make((clusters.count + 1).out)
				create cp.make(s)
				create c.make(id, cp)
				if recursive then
					c.set_recursive(True)
				end
				clusters.force_last(c)
			end
				
		end

	expand
			-- expand file list by walking file tree
		local
			i: INTEGER
			c: EDP_CLUSTER
		do
			from
				i := 1
			until
				i > clusters.count
			loop
				clusters.item(i).expand
				i := i + 1
			end
		end

	add_to_project(p: EDP_PROJECT)
			-- Add all clusters of repository to the project
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i > clusters.count
			loop
				p.add_cluster_obj(clusters @ i)
				i := i + 1
			end
		end

feature -- factory routines

	any_class_window: EDP_CLASS_WINDOW

	open_class_window(p: EDP_PROJECT; s: STRING)
		do
			create any_class_window.make(Void)
			any_class_window.create_resource
		end

feature -- string storage

	edp_unique_strings: EDP_STRING_STORE
		once
			create Result.make
		end

	infix "#" (a_string: STRING): INTEGER
		do
			Result := edp_unique_strings # a_string
		end

	infix "@" (i: INTEGER): STRING
		do
			Result := edp_unique_strings @ i
		end

feature {NONE} -- invariant facilities

	singleton_memory: EDP_REPOSITORY
		once
			Result := Current
		end

invariant
	singleton_class: Current = singleton_memory
end -- EDP_REPOSITORY
