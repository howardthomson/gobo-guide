indexing

	description:

		"Test 'event/tagcount' example"

	library: "Gobo Eiffel XML Library"
	copyright: "Copyright (c) 2003, Eric Bezault and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

deferred class XM_ETEST_TAGCOUNT

inherit

	EXAMPLE_TEST_CASE
		redefine
			program_dirname
		end

feature -- Access

	program_name: STRING is "tagcount"
			-- Program name

	library_name: STRING is "xml"
			-- Library name of example

feature -- Test

	test_print is
			-- Test 'event/tagcount' example.
		do
			compile_program
		end

feature {NONE} -- Implementation

	program_dirname: STRING is
			-- Name of program source directory
		do
			Result := file_system.nested_pathname ("${GOBO}", <<"example", library_name, "event", program_name>>)
			Result := Execution_environment.interpreted_string (Result)
		end

end