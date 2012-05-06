class SB_TREE_LIST_ITEM_COMPARATOR

inherit

	SB_COMPARATOR [ SB_TREE_LIST_ITEM ]

feature

	compare(a, b: SB_TREE_LIST_ITEM): INTEGER
		do
			Result := a.label.three_way_comparison(b.label)
		end

end