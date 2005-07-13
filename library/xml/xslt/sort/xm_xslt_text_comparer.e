indexing

	description:

		"Objects that compare text strings"

	library: "Gobo Eiffel XSLT Library"
	copyright: "Copyright (c) 2004, Colin Adams and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class XM_XSLT_TEXT_COMPARER

inherit
	
	KL_COMPARATOR [XM_XPATH_ITEM]

	XM_XPATH_DEBUGGING_ROUTINES

create

	make, make_from_collator

feature {NONE} -- Initialiaztion

	make (a_comparer: KL_COMPARATOR [XM_XPATH_ITEM]) is
			-- Establish invariant.
		require
			comparer_mot_void: a_comparer /= Void
		do
			todo ("make", False)
		end
	
	make_from_collator (a_collator: ST_COLLATOR) is
			-- Establish invariant
		require
			collator_not_void: a_collator /= Void
		do
			collator := a_collator
		ensure
			collator_set: collator = a_collator
		end
	
feature -- Comparison

	less_than (u, v: XM_XPATH_ITEM): BOOLEAN is
			-- Is `u' considered less than `v'?
		local
			s1, s2: STRING
		do
			if collator /= Void then
				s1 := u.string_value
				s2 := v.string_value
				Result := collator.less_than (s1, s2)
			else
				Result := comparer.less_than (u, v)
			end
		end

feature {NONE} -- Implementation

	collator: ST_COLLATOR
			-- Collator used to perform string comparisons

	comparer: KL_COMPARATOR [XM_XPATH_ITEM]
			-- Comparator used to perform string comparisons

invariant

	collator_or_comparer: collator /= Void xor comparer /= Void

end
