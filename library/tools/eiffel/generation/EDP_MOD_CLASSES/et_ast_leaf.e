indexing

	description:

		"Eiffel AST leaf nodes"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 2002-2004, Eric Bezault and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date: 2004/09/04 18:51:53 $"
	revision: "$Revision: 1.7 $"

	edp_mods: "[
		Additional inheritance for EDP

		New deferred feature: has_same_text for DIFF processing
	]"

deferred class ET_AST_LEAF

inherit

	ET_AST_NODE
		undefine
			last_position
		redefine
			first_position
		end

	ET_COMPRESSED_POSITION
		rename
			make as make_with_position,
			make_default as make
		end

	EDP_AST_LEAF	-- Added HAT for EDP Project

	DIFF_SYMBOL

feature -- Access

	has_same_text (other: ET_AST_LEAF): BOOLEAN is
			-- Do 'Current' and 'other' have the same 'text'
		deferred
		end

	position: ET_POSITION is
			-- Position of first character of
			-- current node in source code
		do
			Result := Current
		end

	first_position: ET_POSITION is
			-- Position of first character of current node in source code
		do
			Result := Current
		end

	first_leaf: ET_AST_LEAF is
			-- First leaf node in current node
		do
			Result := Current
		end

	last_leaf: ET_AST_LEAF is
			-- Last leaf node in current node
		do
			Result := Current
		end

	break: ET_BREAK
			-- Break which appears just after current node

feature -- Setting

	set_break (a_break: like break) is
			-- Set `break' to `a_break'.
		do
			break := a_break
		ensure
			break_set: break = a_break
		end

end
