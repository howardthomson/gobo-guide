note
	description:"Container which supports sorting items"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

deferred class SB_SORTABLE_ITEM_CONTAINER [ GI, GT -> SB_ITEM ]

inherit

	SB_ITEM_CONTAINER [ GI, GT ]

feature

	item_comparator: SB_COMPARATOR [ GT ];
		-- Item comparator used for sorting items;

	items_sorter: SB_SORTER [ GT ];
		-- Items sorter;

	set_item_comparator(comp: like item_comparator)
			-- Change item comparition object
		do
			item_comparator := comp;
		end

	set_items_sorter(sort: like items_sorter)
    		-- Change items sorting object
      	do
         	items_sorter := sort;
      	end

   	sort_items
         	-- Sort items using current comparator object
      	deferred
      	end

end
