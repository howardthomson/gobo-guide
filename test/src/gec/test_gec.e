indexing

	description:

		"Test 'gec'"

	copyright: "Copyright (c) 2006, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

deferred class TEST_GEC

inherit

	TOOL_TEST_CASE

feature -- Access

	program_name: STRING is "gec"
			-- Program name

feature -- Test

	test_gec is
			-- Test 'gec'.
		do
			compile_program
		end

end
