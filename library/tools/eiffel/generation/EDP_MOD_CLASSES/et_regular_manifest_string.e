indexing

	description:

		"Eiffel manifest strings with no special character"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 1999-2002, Eric Bezault and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date: 2005/07/13 19:39:28 $"
	revision: "$Revision: 1.14 $"

	edp_mods: "[
		Added hash_code to implement HASHABLE for DIFF comparison
	]"

class ET_REGULAR_MANIFEST_STRING

inherit

	ET_MANIFEST_STRING

create

	make

feature -- Hashing

	hash_code: INTEGER is
		do
			-- TODO hash_code
		end

feature {NONE} -- Initialization

	make (a_literal: like literal) is
			-- Create a new manifest string.
		require
			a_literal_not_void: a_literal /= Void
			-- valid_literal: ([^"%\n]*).recognizes (a_literal)
		do
			value := a_literal
			make_leaf
		ensure
			literal_set: literal = a_literal
			line_set: line = no_line
			column_set: column = no_column
		end

feature -- Access

	value: STRING
			-- String value

	literal: STRING is
			-- Literal value
		do
			Result := value
		end

	last_position: ET_POSITION is
			-- Position of last character of current node in source code
		do
			create {ET_COMPRESSED_POSITION} Result.make (line, column + value.count + 1)
		end

feature -- Processing

	process (a_processor: ET_AST_PROCESSOR) is
			-- Process current node.
		do
			a_processor.process_regular_manifest_string (Current)
		end

invariant

	-- valid_literal: ([^"%\n]*).recognizes (literal)

end
