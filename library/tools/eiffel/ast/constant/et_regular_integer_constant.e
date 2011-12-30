note

	description:

		"Eiffel integer constants with no underscore"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 1999-2009, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

	edp_mods: "[
		Added hash_code to implement HASHABLE for DIFF comparison
	]"

class ET_REGULAR_INTEGER_CONSTANT

inherit

	ET_INTEGER_CONSTANT

create

	make

feature -- Hashing

	hash_code: INTEGER
		do
			-- TODO hash_code
		end

feature {NONE} -- Initialization

	make (a_literal: like literal)
			-- Create a new Integer constant.
		require
			a_literal_not_void: a_literal /= Void
--			valid_literal: ([0-9]+).recognizes (a_literal)
		do
			literal := a_literal
			make_leaf
			compute_value
		ensure
			literal_set: literal = a_literal
			line_set: line = no_line
			column_set: column = no_column
		end

feature -- Processing

	process (a_processor: ET_AST_PROCESSOR)
			-- Process current node.
		do
			a_processor.process_regular_integer_constant (Current)
		end

feature {NONE} -- Implementation

	compute_value
			-- Compute value of current integer constant.
			-- Make result available in `value' or set
			-- `has_overflow' to true if an overflow
			-- occurred during computation.
		local
			v, d: NATURAL_64
			i, nb: INTEGER
			l_n1: NATURAL_64
			l_n2: NATURAL_64
			l_zero_code: NATURAL_32
		do
			l_zero_code := ('0').natural_32_code
			l_n1 := {NATURAL_64}.Max_value // 10
			l_n2 := {NATURAL_64}.max_value \\ 10
			has_overflow := False
			nb := literal.count
			from i := 1 until i > nb loop
				d := literal.item (i).natural_32_code - l_zero_code
				if v < l_n1 or (v = l_n1 and d <= l_n2) then
					v := 10 * v + d
				else
						-- Overflow.
					has_overflow := True
					value := v 			-- TEMP
					report_overflow (l_n1, l_n2)		-- TEMP
					i := nb + 1
				end
				i := i + 1
			end
			value := v
		end

	report_overflow (a_n1, a_n2:NATURAL_64)
		do
			print ("Has_overflow set: ")
			print (literal)
			print (" -- ")
			print (value.out)
			print ("%N")
			print ("n1 ({NATURAL_64}.Max_value // 10) = ")
			print (a_n1.out)
			print ("%N")
			print ("n2 ({NATURAL_64}.Max_value \\ 10) = ")
			print (a_n2.out)
			print ("%N")
		end

invariant

--	valid_literal: ([0-9]+).recognizes (literal)

end
