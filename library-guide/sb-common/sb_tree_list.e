note
	description:"Tree List Widget"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

class SB_TREE_LIST

inherit

	SB_GENERIC_TREE_LIST [ SB_TREE_LIST_ITEM ]

create

	make, make_opts, make_ev

feature -- Generic item creation, SE limitation

	create_item (text: STRING; oi, ci: SB_ICON; data: ANY): SB_TREE_LIST_ITEM
		do
			create Result.make (text, oi, ci, data)
		end

end
