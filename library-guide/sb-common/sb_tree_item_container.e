note
	description:"Tree like item container widget"

	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

	todo: "[
		re-consider committing to SB_TREE_ITEM_LIST for inheritance by SB_TREE_LIST
		which precludes (?) redefining the type of the tree items
	]"

deferred class SB_TREE_ITEM_CONTAINER [ G -> SB_TREE_LIST_ITEM ]

inherit

	SB_ITEM_CONTAINER [ G, G ]
    	rename
         	set_item_icon as set_item_open_icon
      	end

feature

	first_item: G
	last_item: G

	item_count: INTEGER
		local
        	i: G
      	do
         	from
            	i := first_item
         	until
            	i = Void
         	loop
            	i := i.next
            	Result := Result + 1
         	end
      	end

	item (index: G): G
         	-- Return the item at the given index
      	do
         	Result ?= index
      	end

feature -- Validation

	valid_accessor (index: G): BOOLEAN
      	do
        -- 	Result := index /= DEFAULT_ACCESSOR
         	Result := index /= Void
      	end

--	DEFAULT_ACCESSOR: G is do end;

feature {NONE}

--	ITEM_TYPE: G is do end

end
