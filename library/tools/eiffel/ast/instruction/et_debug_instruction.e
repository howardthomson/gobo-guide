indexing

	description:

		"Eiffel debug instructions"

	library:    "Gobo Eiffel Tools Library"
	author:     "Eric Bezault <ericb@gobosoft.com>"
	copyright:  "Copyright (c) 1999-2002, Eric Bezault and others"
	license:    "Eiffel Forum Freeware License v1 (see forum.txt)"
	date:       "$Date$"
	revision:   "$Revision$"

class ET_DEBUG_INSTRUCTION

inherit

	ET_INSTRUCTION

creation

	make

feature {NONE} -- Initialization

	make (a_keys: like keys; a_debug_compound: like debug_compound; an_end: like end_keyword) is
			-- Create a new debug instruction.
		require
			a_debug_compound_not_void: a_debug_compound /= Void
			an_end_not_void: an_end /= Void
		do
			keys := a_keys
			debug_compound := a_debug_compound
			end_keyword := an_end
		ensure
			keys_set: keys = a_keys
			debug_compound_set: debug_compound = a_debug_compound
			end_keyword_set: end_keyword = an_end
		end

feature -- Access

	debug_keyword: ET_TOKEN is
			-- 'debug' keyword
		do
			Result := debug_compound.keyword
		ensure
			debug_keyword_not_void: Result /= Void
		end

	end_keyword: ET_TOKEN
			-- 'end' keywords

	keys: ET_DEBUG_KEYS
			-- Debug keys

	debug_compound: ET_COMPOUND
			-- Compound

	position: ET_POSITION is
			-- Position of first character of
			-- current node in source code
		do
			Result := debug_keyword.position
		end

	break: ET_BREAK is
			-- Break which appears just after current node
		do
			Result := end_keyword.break
		end

invariant

	debug_compound_not_void: debug_compound /= Void
	end_keyword_not_void: end_keyword /= Void

end -- class ET_DEBUG_INSTRUCTION
