indexing

	description:

		"Objects that implement the XPath contains() function"

	library: "Gobo Eiffel XPath Library"
	copyright: "Copyright (c) 2004, Colin Adams and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class XM_XPATH_CONTAINS

inherit

	XM_XPATH_SYSTEM_FUNCTION
		undefine
			pre_evaluate
		redefine
			evaluate_item
		end

	XM_XPATH_COLLATING_FUNCTION

creation

	make

feature {NONE} -- Initialization

	make is
			-- Establish invariant
		do
			name := "contains"
			minimum_argument_count := 2
			maximum_argument_count := 3
			create arguments.make (3)
			arguments.set_equality_tester (expression_tester)
			compute_static_properties
		end

feature -- Access

	item_type: XM_XPATH_ITEM_TYPE is
			-- Data type of the expression, where known
		do
			Result := type_factory.boolean_type
			if Result /= Void then
				-- Bug in SE 1.0 and 1.1: Make sure that
				-- that `Result' is not optimized away.
			end
		end

feature -- Status report

	required_type (argument_number: INTEGER): XM_XPATH_SEQUENCE_TYPE is
			-- Type of argument number `argument_number'
		do
			if argument_number < 3 then
				create Result.make_optional_string
			else
				create Result.make_single_string
			end
		end

	is_test_for_zero: BOOLEAN
			-- If this is set we return 0 for a zero length string, 1 for any other;
			-- Set by the optimizer.

feature -- Evaluation

	evaluate_item (a_context: XM_XPATH_CONTEXT) is
			-- Evaluate as a single item
		local
			a_collator: ST_COLLATOR
			an_atomic_value, another_atomic_value: XM_XPATH_ATOMIC_VALUE
			s1, s2: STRING
		do
			a_collator := collator (3, a_context, False)
			if a_collator = Void then
				create {XM_XPATH_INVALID_ITEM} last_evaluated_item.make_from_string ("Unsupported collation", 2, Dynamic_error)
			else
				arguments.item (1).evaluate_item (a_context)
				an_atomic_value ?= arguments.item (1).last_evaluated_item
				if an_atomic_value = Void then
					create {XM_XPATH_STRING_VALUE} an_atomic_value.make ("")
				end
				arguments.item (2).evaluate_item (a_context)
				another_atomic_value ?= arguments.item (2).last_evaluated_item
				if another_atomic_value = Void then
					create {XM_XPATH_STRING_VALUE} another_atomic_value.make ("")
				end
				s1 := an_atomic_value.string_value
				s2 := another_atomic_value.string_value
				if s2.count = 0 then
					create {XM_XPATH_BOOLEAN_VALUE} last_evaluated_item.make (True)
				elseif s1.count = 0 then
					create {XM_XPATH_BOOLEAN_VALUE} last_evaluated_item.make (False)
				else
					create {XM_XPATH_BOOLEAN_VALUE} last_evaluated_item.make (collation_contains (s1, s2, a_collator))
				end
			end
		end

feature {XM_XPATH_EXPRESSION} -- Restricted

	compute_cardinality is
			-- Compute cardinality.
		do
			set_cardinality_exactly_one
		end

feature {NONE} -- Implementation

	collation_contains (s1, s2: STRING; a_collator: ST_COLLATOR): BOOLEAN is
			-- Does `s1' contain `s2' according to the rules of `a_collator'?
		require
			first_string_not_void: s1 /= Void
			second_string_not_void: s2 /= Void
			collator_not_void: a_collator /= Void
		local
			an_index: INTEGER
			a_substring: STRING
		do
			from
				an_index := 1
			variant
				s1.count - s2.count + 1 - an_index
			until
				Result or else an_index > s1.count - s2.count
			loop
				a_substring := s1.substring (an_index, an_index + s2.count - 1)
				Result := a_collator.three_way_comparison (a_substring, s2) = 0
				an_index := an_index + 1
			end
		end
	
end
	
