--|---------------------------------------------------------|
--| Copyright (c) Howard Thomson 1999,2000,2001,2006		|
--| 52 Ashford Crescent										|
--| Ashford, Middlesex TW15 3EB								|
--| United Kingdom											|
--|---------------------------------------------------------|
-- The Makefile information for a specific root class and cluster set

deferred class EDP_PROJECT

inherit

	EDP_GLOBAL

feature -- Attributes

	project_id:		INTEGER	-- Unique EDP object ID
	project_name:	STRING

	display_target:	EDP_DISPLAY_TARGET
	
	root_class:		INTEGER	-- Name of root class
	root_creation:	INTEGER	-- Name of root creation feature

	Status_null,	  		-- No project settings yet set
	Status_bad_universe,	-- One or more Cluster paths is invalid
	Status_universe_OK,		-- All universe cluster directory trees have been walked
	Status_load_failed,		-- One or more files are missing, or duplicated in universe
	Status_loaded,			-- All classes of project clusters loaded, scanned & parsed
	Status_invalid,			-- One or more classes failed validity tests
	Status_validated,		-- Eiffel class set is Eiffel valid
	Status_generated,		-- Byte (internal) code generated
	Status_compiled			-- Compiled to (native) executable file
		:INTEGER is unique

	--	Find: Identify Class Universe
	--	Load: 
	--	Scan
	--	Parse
	--	Ancestors
	--	Features
	--	Run-Classes

	
feature {NONE} -- Attributes (Redundant ?)

	trace_parsing: BOOLEAN

feature { NONE } -- Redundant routines ?

	set_trace_parsing(tp: BOOLEAN) is
		do
			trace_parsing := tp
		end

feature -- Status

	status: INTEGER	-- Current project status

	is_walked: BOOLEAN is
			-- Have all Cluster directories been tree walked ?
		do
			Result := status >= Status_universe_OK
		end

	is_loaded: BOOLEAN is
			-- Have all required classes been loaded ?
		do
			Result := status >= Status_loaded
		end
		
	is_validated: BOOLEAN is
			-- Has the project been confirmed as Eiffel valid ?
		do
			Result := status >= Status_validated
		end

	is_generated: BOOLEAN is
			-- Has intermediate code been generated ?
		do
			Result := status >= Status_generated
		end

	is_compiled: BOOLEAN is
			-- Has executable code been generated ?
		do
			Result := status >= Status_compiled
		end

feature -- Status reset

	set_null is
		do
			status := Status_null
		end

	set_load_failed is
		require
			-- status = Status_null
		do
			status := Status_load_failed
		ensure
			status = Status_load_failed
		end

	set_not_validated is
			-- Revert to requires validation after editing loaded file(s)
		require
			status >= Status_loaded
		do
			status := Status_loaded
		end

feature -- creation

	make (name: STRING) is
		do
			project_name := name
			set_null
		end

feature -- setup ----------------------------------------------------------------

--	XXset_root_class(root_class_arg: INTEGER) is
--		do
--			root_class := root_class_arg
--		end
		
--	XXset_root_creation(root_creation_arg: INTEGER) is
--		do
--			root_creation := root_creation_arg
--		end

feature -- GUI -------------------------------------------------------------------

	set_display_target (t: EDP_DISPLAY_TARGET) is
			-- window to report events and info to
			--| change to non GUI ancestor class to
			--| permit non-GUI executable
		do
			display_target := t
		end
		
feature -- Process ---------------------------------------------------------------
		
	pre_parse is
			-- identify class set from selected clusters
			-- check for updated original source text
			-- invalidate cached class info as required
		require
			--is_walked
		deferred
		end

	parse_all is
		deferred
		end

		----------------------------------------------------------------------------
		
	validate is
			-- check all classes in project for Eiffel validity
			-- confirm status of root class and creation routine
		require
			--Loaded_OK:	is_loaded
		deferred
		end

	--------------------------------------------------------------------------------------------------------

	compile is
			-- generate executable project
		require
		do
			validate
			if is_generated then
				
			end
		end

	execute is
			-- run the project executable
		require
			--is_generated or is_compiled
		do
--			trace_s("Execute -- Not Implemented%N")
		end

---------------------------------------------------------------------------------

--#####################################!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	add_cluster (s: STRING) is
		local
			c: EDP_CLUSTER
		do
		--	trace_s("Adding cluster: "); trace_s(s); trace_s("%N")
	--		!!c.make(s, false)
		--	c.set_directory_path(s)
	--		clusters.add_tail(c)
		end
		---------------------------------------------------------------------------------------------------------------

	add_cluster_obj (c: EDP_CLUSTER) is
			-- Add cluster if not already in
		do
--			if not clusters.has(c) then
--				clusters.add_tail(c)
--				if display_target /= Void then
--					display_target.add_cluster(c)
--				end
--			end
		end

	add_class (edpc: EDP_CLASS) is
		do
			if display_target /= Void then
				display_target.add_class (edpc)
			end
		end			

end -- EDP_PROJECT-- The Makefile information for a specific root class and cluster set