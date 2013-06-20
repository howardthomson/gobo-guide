--|---------------------------------------------------------|
--| Copyright (c) Howard Thomson 1999,2000,2001,2006		|
--| 52 Ashford Crescent										|
--| Ashford, Middlesex TW15 3EB								|
--| United Kingdom											|
--|---------------------------------------------------------|

class EDP_PROJECT_GOBO

inherit

	EDP_PROJECT
	KL_SHARED_FILE_SYSTEM

create

	make, make_from_ace_file

feature -- Attributes

	ast_factory: ET_AST_FACTORY

	error_handler: EDP_ERROR_HANDLER

feature -- Attributes (Ace)

	et_lace_clusters: ET_LACE_CLUSTERS
	et_system: ET_LACE_SYSTEM
	et_lace_parser: ET_LACE_PARSER

	lace_error_handler: EDP_LACE_ERROR_HANDLER
	lace_ast_factory: ET_LACE_AST_FACTORY

feature -- Target info

	filename: STRING
			-- file name of ace file

	error_target: EDP_ERROR_TARGET
			-- GUI Error reporting target

feature -- Creation

	make_from_ace_file (a_filename: STRING; an_error_target: EDP_ERROR_TARGET)
		require
			filename_not_void: a_filename /= Void
		do
			filename := a_filename
			error_target := an_error_target
			parse_ace_file
		end

	parse_ace_file
		local
			file: KL_TEXT_INPUT_FILE
		do
			create file.make (filename)
			file.open_read
			if file.is_open_read then
				create lace_ast_factory.make
				create error_handler.make
				error_handler.set_target (error_target)
				lace_ast_factory.set_error_handler (error_handler)
				create lace_error_handler.make (Void)
				create et_lace_parser.make_with_factory (lace_ast_factory, lace_error_handler)
				et_lace_parser.parse_file (file)
				if et_lace_parser.syntax_error then
					print (once "Ace file syntax error ...%N")
				end
				file.close
			end
		end

	reload_ace_file
		local
			file: KL_TEXT_INPUT_FILE
		do
			if et_lace_parser = Void then
				parse_ace_file
			else
				create file.make (filename)
				file.open_read
				if file.is_open_read then
					et_lace_parser.parse_file (file)
					file.close
					et_system := Void
				end
			end
		end

	pre_parse
			-- Process all clusters and map filenames to
			-- class names by pre-processing cluster files
		do
			reload_ace_file
			if et_lace_parser /= Void
			and then et_lace_parser.last_system /= Void
			then
				if et_system = Void then
					et_system := et_lace_parser.last_system
					et_system.activate_processors
					if false then
						et_system.set_use_reference_keyword (True)
						et_system.set_use_attribute_keyword (False)
					end
					et_system.preparse_recursive
				else
					et_system.preparse_recursive
				end
				if display_target /= Void then
					set_classes_tree (display_target)
				end
			end
		end

feature -- Display classes

	set_classes_tree (a_target: EDP_DISPLAY_TARGET)
		require
			a_target_not_void: a_target /= Void
		local
			a_cursor: DS_HASH_TABLE_CURSOR [ET_CLASS, ET_CLASS_NAME]
			a_class: ET_CLASS
		do
			a_target.classes_wipe_out
-- TODO: ET_SYSTEM.classes no longer available
--			a_cursor := et_system.classes.new_cursor
			from a_cursor.start until a_cursor.after loop
				from
					a_class := a_cursor.item
				until
					a_class = Void
				loop
					a_target.add_class (a_class)
-- TODO: ET_CLASS.overridden_class no longer available
--					a_class := a_class.overridden_class
				end
				a_cursor.forth
			end
			a_target.sort_classes
		end

	parse_all
			-- Parse and check, as far as possible, all class files
		local
			u: EDP_UNIVERSE
		do
--			if et_lace_universe /= Void and then et_lace_universe.is_preparsed then
--				et_lace_universe.reset_classes
--				create et_system.make (et_lace_universe)
--	--			et_system.set_c_code_generation (False)
--	--			et_system.set_c_code_compilation (False)
--				et_system.compile_all
--				u ?= et_lace_universe
--				if display_target /= Void then
--					u.set_classes_tree (display_target)
--				end
--				if et_system.has_fatal_error then
--					-- Set display status for compile failure
--					--...
--					print (once "Has fatal error!%N")
--				else
--	--				generate_c_code
--				end
--			end
		end

	generate_c_code
			-- Generate C code for current system.
		local
			l_generator: ET_C_GENERATOR
		do
--			create l_generator.make (et_system)
--			l_generator.generate (et_system.universe.system_name)
		end

--	validate
--		local
--			u: EDP_UNIVERSE
--		do
--			if et_lace_universe /= Void and then et_lace_universe.is_preparsed then
--				et_lace_universe.reset_classes
--				create et_system.make (et_lace_universe)
--			--	et_system.set_c_code_generation (True)
--			--	et_system.set_c_code_compilation (False)
--			--	et_system.compile_all
--			--	et_system.compile_system
--				et_system.compile
--				u ?= et_lace_universe
--				if display_target /= Void then
--					u.set_classes_tree (display_target)
--				end
--				if et_system.has_fatal_error then
--					-- Set display status for compile failure
--					--...
--					print (once "Has fatal error!%N")
--				else
--	--				generate_c_code
--				end
--			end
--		end

	validate
		local
			u: EDP_UNIVERSE
		do
			if et_system /= Void then
			--	et_system.set_c_code_generation (True)
			--	et_system.set_c_code_compilation (False)
				et_system.compile
		--		u ?= et_lace_universe
				if display_target /= Void then
		--			u.set_classes_tree (display_target)
				end
				if et_system.error_handler.has_error then
					-- Set display status for compile failure
					--...
					print (once "Has fatal error!%N")
				else
	--				generate_c_code
				end
			end
		end

	system_name: STRING
			-- The name of the system to be built
			-- Read from the Ace file ...
		do
			if et_lace_parser /= Void then
				Result := et_lace_parser.last_system.system_name
			else
				Result := once "##Unknown##"
			end
		end

end
