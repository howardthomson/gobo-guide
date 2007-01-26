indexing

	description:

		"Gobo Eiffel Compiler"

	copyright: "Copyright (c) 2005-2007, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class GEC

inherit

	GEC_VERSION

	KL_SHARED_EXCEPTIONS
	KL_SHARED_ARGUMENTS
	KL_SHARED_EXECUTION_ENVIRONMENT
	KL_SHARED_STANDARD_FILES
	KL_SHARED_OPERATING_SYSTEM
	KL_SHARED_FILE_SYSTEM
	KL_IMPORTED_STRING_ROUTINES
	UT_SHARED_TEMPLATE_EXPANDER

	UC_SHARED_STRING_EQUALITY_TESTER
		export {NONE} all end

	UT_SHARED_ISE_VERSIONS
		export {NONE} all end

create

	execute

feature -- Execution

	execute is
			-- Start 'gec' execution.
		local
			a_filename: STRING
			a_file: KL_TEXT_INPUT_FILE
			nb: INTEGER
		do
			Arguments.set_program_name ("gec")
			create error_handler.make_standard
			parse_arguments
			a_filename := ace_filename
			create a_file.make (a_filename)
			a_file.open_read
			if a_file.is_open_read then
				last_universe := Void
				nb := a_filename.count
				if nb > 5 and then a_filename.substring (nb - 4, nb).is_equal (".xace") then
					parse_xace_file (a_file)
				elseif nb > 4 and then a_filename.substring (nb - 3, nb).is_equal (".ecf") then
					parse_ecf_file (a_file)
				else
					parse_ace_file (a_file)
				end
				a_file.close
				if last_universe /= Void then
					process_universe (last_universe)
					debug ("stop")
						std.output.put_line ("Press Enter...")
						std.input.read_character
					end
					if last_universe.error_handler.has_error then
						Exceptions.die (2)
					end
				else
					Exceptions.die (3)
				end
			else
				report_cannot_read_error (a_filename)
				Exceptions.die (1)
			end
		rescue
			Exceptions.die (4)
		end

feature -- Access

	error_handler: UT_ERROR_HANDLER
			-- Error handler

	last_universe: ET_UNIVERSE
			-- Last universe parsed, if any

feature {NONE} -- Eiffel config file parsing

	parse_ace_file (a_file: KI_CHARACTER_INPUT_STREAM) is
			-- Read Ace file `a_file'.
			-- Put result in `last_universe' if no error occurred.
		require
			a_file_not_void: a_file /= Void
			a_file_open_read: a_file.is_open_read
		local
			l_lace_parser: ET_LACE_PARSER
			l_lace_error_handler: ET_LACE_ERROR_HANDLER
		do
			last_universe := Void
			create l_lace_error_handler.make_standard
			create l_lace_parser.make (l_lace_error_handler)
			l_lace_parser.parse_file (a_file)
			if not l_lace_parser.syntax_error then
				last_universe := l_lace_parser.last_universe
			end
		end

	parse_xace_file (a_file: KI_CHARACTER_INPUT_STREAM) is
			-- Read Xace file `a_file'.
			-- Put result in `last_universe' if no error occurred.
		require
			a_file_not_void: a_file /= Void
			a_file_open_read: a_file.is_open_read
		local
--			l_xace_parser: ET_XACE_UNIVERSE_PARSER
--			l_xace_error_handler: ET_XACE_DEFAULT_ERROR_HANDLER
--			l_xace_variables: DS_HASH_TABLE [STRING, STRING]
--			l_splitter: ST_SPLITTER
--			l_cursor: DS_LIST_CURSOR [STRING]
--			l_definition: STRING
--			l_index: INTEGER
--			gobo_eiffel: STRING
		do
				-- Xace is not supported.
				-- Parse Ace file as default.
			parse_ace_file (a_file)
--			last_universe := Void
--			create l_xace_error_handler.make_standard
--			create l_xace_variables.make_map (100)
--			l_xace_variables.set_key_equality_tester (string_equality_tester)
--			gobo_eiffel := Execution_environment.variable_value ("GOBO_EIFFEL")
--			if gobo_eiffel /= Void then
--				l_xace_variables.force_last (gobo_eiffel, "GOBO_EIFFEL")
--			end
--			if defined_variables /= Void then
--				create l_splitter.make
--				l_cursor := l_splitter.split (defined_variables).new_cursor
--				from l_cursor.start until l_cursor.after loop
--					l_definition := l_cursor.item
--					if l_definition.count > 0 then
--						l_index := l_definition.index_of ('=', 1)
--						if l_index = 0 then
--							l_xace_variables.force_last ("", l_definition)
--						elseif l_index = l_definition.count then
--							l_xace_variables.force_last ("", l_definition.substring (1, l_index - 1))
--						elseif l_index /= 1 then
--							l_xace_variables.force_last (l_definition.substring (l_index + 1, l_definition.count), l_definition.substring (1, l_index - 1))
--						end
--					end
--					l_cursor.forth
--				end
--			end
--			create l_xace_parser.make_with_variables (l_xace_variables, l_xace_error_handler)
--			l_xace_parser.parse_file (a_file)
--			if not l_xace_error_handler.has_error then
--				last_universe := l_xace_parser.last_universe
--			end
		end

	parse_ecf_file (a_file: KI_CHARACTER_INPUT_STREAM) is
			-- Read ECF file `a_file'.
			-- Put result in `last_universe' if no error occurred.
		require
			a_file_not_void: a_file /= Void
			a_file_open_read: a_file.is_open_read
		do
				-- ECF is not supported.
				-- Parse Ace file as default.
			parse_ace_file (a_file)
		end

feature {NONE} -- Processing

	process_universe (a_universe: ET_UNIVERSE) is
			-- Process `a_universe'.
		require
			a_universe_not_void: a_universe /= Void
		local
			l_null_error_handler: ET_NULL_ERROR_HANDLER
			l_system: ET_SYSTEM
			l_builder: ET_DYNAMIC_TYPE_SET_BUILDER
			l_class: ET_CLASS
			l_generator: ET_C_GENERATOR
			l_file: KL_TEXT_OUTPUT_FILE
			l_command: KL_SHELL_COMMAND
			l_base_name: STRING
			l_c_config: DS_HASH_TABLE [STRING, STRING]
			l_variables: DS_HASH_TABLE [STRING, STRING]
			l_command_name: STRING
			l_cc_template: STRING
			l_link_template: STRING
			l_filename: STRING
		do
			if is_silent then
				create l_null_error_handler.make_standard
				a_universe.set_error_handler (l_null_error_handler)
			end
			a_universe.error_handler.set_ise
			a_universe.set_ise_version (ise_latest)
			if is_verbose then
-- TODO.
			end
			create l_system.make (a_universe)
			l_system.set_catcall_mode (is_cat)
			create {ET_DYNAMIC_PUSH_TYPE_SET_BUILDER} l_builder.make (l_system)
			l_system.set_dynamic_type_set_builder (l_builder)
			l_system.compile
			l_class := a_universe.root_class
			if l_class = a_universe.none_class then
				-- Do nothing.
			elseif not l_system.has_fatal_error then
					-- C code generation.
				l_base_name := a_universe.system_name
				if l_base_name = Void then
				else
					l_base_name := l_class.lower_name
				end
				l_filename := l_base_name + ".c"
				create l_file.make (l_filename)
				l_file.open_write
				if l_file.is_open_write then
					create l_generator.make (l_system)
					l_generator.generate (l_file)
					l_file.close
						-- C code compilation.
					l_c_config := c_config
					create l_variables.make (10)
					l_variables.put ("", "includes")
					l_variables.put ("", "libs")
					l_variables.put (l_base_name + l_c_config.item ("exe"), "exe")
					l_variables.put (l_base_name + ".c", "c")
					if is_finalize and then l_c_config.has ("cflags_finalize") then
						l_variables.put (l_c_config.item ("cflags_finalize"), "cflags")
					elseif l_c_config.has ("cflags") then
						l_variables.put (l_c_config.item ("cflags"), "cflags")
					else
						l_variables.put ("", "cflags")
					end
					if is_finalize and then l_c_config.has ("lflags_finalize") then
						l_variables.put (l_c_config.item ("lflags_finalize"), "lflags")
					elseif l_c_config.has ("lflags") then
						l_variables.put (l_c_config.item ("lflags"), "lflags")
					else
						l_variables.put ("", "lflags")
					end
					if operating_system.is_windows then
						l_filename := l_base_name + ".bat"
					else
						l_filename := l_base_name + ".sh"
					end
					create l_file.make (l_filename)
					l_file.open_write
					if l_file.is_open_write then
						if operating_system.is_windows then
							l_file.put_line ("@echo off")
						else
							l_file.put_line ("#!/bin/sh")
						end
						l_cc_template := l_c_config.item ("cc")
						l_command_name := template_expander.expand_from_values (l_cc_template, l_variables)
						l_file.put_line (l_command_name)
						l_variables.put (l_base_name + l_c_config.item ("obj"), "objs")
						l_link_template := l_c_config.item ("link")
						l_command_name := template_expander.expand_from_values (l_link_template, l_variables)
						l_file.put_line (l_command_name)
						l_file.close
						if not operating_system.is_windows then
							create l_command.make ("chmod a+x " + l_filename)
							l_command.execute
						end
						if not no_c_compile then
							create l_command.make (file_system.absolute_pathname (l_filename))
							l_command.execute
						end
					else
						report_cannot_write_error (l_filename)
						Exceptions.die (1)
					end
				else
					report_cannot_write_error (l_filename)
					Exceptions.die (1)
				end
			end
		end

	c_config: DS_HASH_TABLE [STRING, STRING] is
			-- C compiler configuration
		local
			l_name: STRING
			l_filename: STRING
			l_file: KL_TEXT_INPUT_FILE
			l_default: BOOLEAN
			l_line: STRING
			i: INTEGER
			l_value, l_variable: STRING
		do
			l_name := Execution_environment.variable_value ("GOBO_CC")
			if l_name = Void then
				l_filename := file_system.nested_pathname ("${GOBO}", <<"tool", "gec", "config", "c", "default.cfg">>)
				l_filename := Execution_environment.interpreted_string (l_filename)
				create l_file.make (l_filename)
				l_file.open_read
				if l_file.is_open_read then
					l_file.read_line
					if not l_file.end_of_file then
						l_name := STRING_.cloned_string (l_file.last_string)
						STRING_.left_adjust (l_name)
						STRING_.right_adjust (l_name)
					end
					l_file.close
				end
			end
			if l_name = Void then
				l_default := True
				if operating_system.is_windows then
					l_name := "msc"
				else
					l_name := "gcc"
				end
			end
			create Result.make (10)
				-- Put some platform-dependent default values.
			if operating_system.is_windows then
				Result.put ("cl -nologo $cflags $includes -c $c", "cc")
				Result.put ("cl -nologo $lflags $objs -o $exe -link $libs", "link")
				Result.put (".obj", "obj")
				Result.put (".exe", "exe")
				Result.put ("", "cflags")
				Result.put ("", "lflags")
			else
				Result.put ("gcc $cflags $includes -c $c", "cc")
				Result.put ("gcc $lflags -o $exe $objs $libs", "link")
				Result.put (".o", "obj")
				Result.put ("", "exe")
				Result.put ("", "cflags")
				Result.put ("", "lflags")
			end
			l_filename := file_system.nested_pathname ("${GOBO}", <<"tool", "gec", "config", "c", l_name>>)
			l_filename := Execution_environment.interpreted_string (l_filename)
			if not file_system.has_extension (l_filename, ".cfg") then
				l_filename := l_filename + ".cfg"
			end
			create l_file.make (l_filename)
			l_file.open_read
			if l_file.is_open_read then
				from
					l_file.read_line
				until
					l_file.end_of_file
				loop
					l_line := STRING_.cloned_string (l_file.last_string)
					STRING_.left_adjust (l_line)
					STRING_.right_adjust (l_line)
					if l_line.count >= 2 then
						if l_line.item (1) = '-' and l_line.item (2) = '-' then
							-- Ignore comments.
						else
							i := l_line.index_of (':', 2)
							if i /= 0 then
								l_variable := l_line.substring (1, i - 1)
								STRING_.right_adjust (l_variable)
								l_value := l_line.substring (i + 1, l_line.count)
								STRING_.left_adjust (l_value)
								Result.force (l_value, l_variable)
							end
						end
					end
					l_file.read_line
				end
				l_file.close
			elseif not l_default then
				report_cannot_read_error (l_filename)
				Exceptions.die (1)
			end
		ensure
			c_config_not_void: Result /= Void
			no_void_variables: not Result.has_item (Void)
			cc_defined: Result.has ("cc")
			link_defined: Result.has ("link")
			exe_defined: Result.has ("exe")
			obj_defined: Result.has ("obj")
		end

feature -- Error handling

	report_cannot_read_error (a_filename: STRING) is
			-- Report that `a_filename' cannot be
			-- opened in read mode.
		require
			a_filename_not_void: a_filename /= Void
		local
			an_error: UT_CANNOT_READ_FILE_ERROR
		do
			create an_error.make (a_filename)
			error_handler.report_error (an_error)
		end

	report_cannot_write_error (a_filename: STRING) is
			-- Report that `a_filename' cannot be
			-- opened in write mode.
		require
			a_filename_not_void: a_filename /= Void
		local
			an_error: UT_CANNOT_WRITE_TO_FILE_ERROR
		do
			create an_error.make (a_filename)
			error_handler.report_error (an_error)
		end

	report_version_number is
			-- Report version number.
		local
			a_message: UT_VERSION_NUMBER
		do
			create a_message.make (Version_number)
			error_handler.report_info (a_message)
		end

feature -- Status report

	is_finalize: BOOLEAN is
			-- Compilation with optimizations turned on?
		do
			Result := finalize_flag.was_found
		end

	is_cat: BOOLEAN is
			-- Should CAT-call errors be considered as fatal errors?
		do
			Result := cat_flag.was_found
		end

	no_c_compile: BOOLEAN is
			-- Should the back-end C compiler not be invoked on the generated C code?
		do
			Result := no_c_compile_flag.was_found
		end

	is_silent: BOOLEAN is
			-- Should gec run in silent mode?
		do
			Result := silent_flag.was_found
		end

	is_verbose: BOOLEAN is
			-- Should gec run in verbose mode?
		do
			Result := verbose_flag.was_found
		end

feature -- Argument parsing

	ace_filename: STRING
			-- Name of the ace file

	cat_flag: AP_FLAG
			-- Flag for '--cat'

	finalize_flag: AP_FLAG
			-- Flag for '--finalize'

	no_c_compile_flag: AP_FLAG
			-- Flag for '--nocc'

	silent_flag: AP_FLAG
			-- Flag for '--silent'

	verbose_flag: AP_FLAG
			-- Flag for '--verbose'

	version_flag: AP_FLAG
			-- Flag for '--version'

	parse_arguments is
			-- Initialize options and parse the command line.
		local
			a_parser: AP_PARSER
			a_list: AP_ALTERNATIVE_OPTIONS_LIST
		do
			create a_parser.make
			a_parser.set_application_description ("Gobo Eiffel Compiler, translate Eiffel programs into C code.")
			a_parser.set_parameters_description ("ace_filename")
				-- Options.
			create finalize_flag.make_with_long_form ("finalize")
			finalize_flag.set_description ("Compile with optimizations turned on.")
			a_parser.options.force_last (finalize_flag)
			create cat_flag.make_with_long_form ("cat")
			cat_flag.set_description ("CAT-call errors should be considered as fatal errors.")
			a_parser.options.force_last (cat_flag)
			create no_c_compile_flag.make_with_long_form ("nocc")
			no_c_compile_flag.set_description ("Do not invoke the back-end C compiler on the generated C code.")
			a_parser.options.force_last (no_c_compile_flag)
			create silent_flag.make_with_long_form ("silent")
			silent_flag.set_description ("Run gec in silent mode.")
			a_parser.options.force_last (silent_flag)
			create verbose_flag.make_with_long_form ("verbose")
			verbose_flag.set_description ("Run gec in verbose mode.")
			a_parser.options.force_last (verbose_flag)
			create version_flag.make ('V', "version")
			version_flag.set_description ("Print the version number of gec and exit.")
			create a_list.make (version_flag)
			a_parser.alternative_options_lists.force_last (a_list)
				-- Parsing.
			a_parser.parse_arguments
			if version_flag.was_found then
				report_version_number
				Exceptions.die (0)
			elseif a_parser.parameters.count /= 1 then
				error_handler.report_info_message (a_parser.help_option.full_usage_instruction (a_parser))
				Exceptions.die (1)
			else
				ace_filename := a_parser.parameters.first
			end
		ensure
			ace_filename_not_void: ace_filename /= Void
			cat_flag_not_void: cat_flag /= Void
			finalize_flag_not_void: finalize_flag /= Void
			silent_flag_not_void: silent_flag /= Void
			verbose_flag_not_void: verbose_flag /= Void
			no_c_compile_flag_not_void: no_c_compile_flag /= Void
		end

invariant

	error_handler_not_void: error_handler /= Void
	ace_filename_not_void: ace_filename /= Void
	cat_flag_not_void: cat_flag /= Void
	finalize_flag_not_void: finalize_flag /= Void
	silent_flag_not_void: silent_flag /= Void
	verbose_flag_not_void: verbose_flag /= Void
	no_c_compile_flag_not_void: no_c_compile_flag /= Void

end
