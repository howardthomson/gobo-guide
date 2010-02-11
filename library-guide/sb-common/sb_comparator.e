indexing
	description: "[
		Abstract item comparator, used in sorters.
		Descendants must define 'compare' function to return value > 0 if a > b,
		< 0 if a < b and 0 if a = b
	]"

	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

deferred class SB_COMPARATOR [ G ]

feature -- Comparison routine

   compare(a, b: G): INTEGER is
      deferred
      end

end
