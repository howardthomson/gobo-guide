note
	description:"Icon List Widget"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

	bugs: "[
		Inheritance problems, type of ITEM_TYPE
	
		on_auto_scroll -- called from SB_APPLICATION::process_timers with Void data,
		and retrieved by routine as assumed non-Void event

		Should this be a deferred class (create_item was inherited as deferred), or
		should the implementation below be retained ?

		Note that GEC/EDP failed to detect that create_item was still deferred, that this
		class was in the system, and this class is not declared as deferred, as of 5-8-2007
	]"

class SB_ICON_LIST

inherit

	SB_GENERIC_ICON_LIST [ SB_ICON_LIST_ITEM ]

feature

	create_item(txt: STRING; big,mini: SB_ICON; data: ANY): SB_ICON_LIST_ITEM
		do
			create {SB_ICON_LIST_ITEM} Result.make (txt, big, mini, data)
		end

end
