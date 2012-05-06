note
	description:"Abstract linked list sorter"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

deferred class SB_LIST_SORTER [ G -> SB_TREE_LIST_ITEM ]

inherit

	SB_SORTER [ G ]
		rename
			list_sort as sort
		end

feature -- Sorting

	array_sort(array: ARRAY [ G ]; comparator: SB_COMPARATOR [ G ]): BOOLEAN
			-- Sort given array using comparator object. Returns True 
			-- if array was changed.
		require else
			array /= Void and then comparator /= Void
		do
			check false end
		end

end
