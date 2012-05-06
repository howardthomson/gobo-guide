note
   description: "Abstract ARRAY sorter."
   author: "Eugene Melekhov <eugene_melekhov@mail.ru>"
   copyright: "Copyright (c) 2002, Eugene Melekhov and others"
   license: "Eiffel Forum Freeware License v2 (see forum.txt)"
   status: "Mostly complete"

deferred class SB_SORTER [ G ]

feature

	array_sort(array: ARRAY [ G ]; comparator: SB_COMPARATOR [ G ]): BOOLEAN
			-- Sort given array using comparator object. Returns True 
			-- if array was changed.
		require
			array /= Void and then comparator /= Void
		deferred
		end

	list_sort(first_item: G; comparator: SB_COMPARATOR [ G ]): ARRAY [ G ]
			-- Sort given list using comparator object. Returns array 
			-- of two elements first is the first item and the second is 
			-- the last item in the sorted list
		require
			comparator /= Void
		deferred
		end

end
