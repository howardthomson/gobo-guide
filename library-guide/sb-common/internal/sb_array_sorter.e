note
	description:"Abstract ARRAY sorter."
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

deferred class SB_ARRAY_SORTER [ G ]

inherit

	SB_SORTER [ G ]
		rename
			array_sort as sort
		end

feature -- Sorting

	list_sort(first_item: G; comparator: SB_COMPARATOR [ G ]): ARRAY [ G ]
			-- Sort given list using comparator object. Returns array 
			-- of two elements first is the first item and the second is 
			-- the last item in the sorted list
		do
			check False end
		end

end
