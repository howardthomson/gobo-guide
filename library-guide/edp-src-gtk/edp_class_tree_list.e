--|---------------------------------------------------------|
--| Copyright (c) Howard Thomson 1999,2000,2001,2006		|
--| 52 Ashford Crescent										|
--| Ashford, Middlesex TW15 3EB								|
--| United Kingdom											|
--|---------------------------------------------------------|
note
	description: "[
		Tree List of Eiffel Classes
		Subtrees for different versions
	]"
	author:	"Howard Thomson"
	todo: "[
		Change on_right_button_press to popup an appropriate menu
		Add facility to SB_TREE_LIST to insert client specific drawable entity
			between tree-box and label

		Error markings on conflicting class files are marked on the wrong file!
	]"
class EDP_CLASS_TREE_LIST

inherit

--	SB_GENERIC_TREE_LIST [ EDP_CLASS_LIST_ITEM ]
--		redefine
--			on_right_btn_press
--		end

	EV_TREE

create

	default_create	--make

feature

--	class_menu: SB_MENU is
--		once
--			create Result
--		end

feature -- Generic item creation

--	create_item (text: STRING; oi, ci: EV_PIXMAP; data: ANY): EDP_CLASS_LIST_ITEM
--		do
--			create Result.make (text, oi, ci, data)
--		end

feature -- Menu click processing

--	class_tree_menu: SB_MENU_PANE
--		local
--		--	sub_menu: SB_MENU_
--			command: SB_MENU_COMMAND
--		--	title: SB_MENU_TITLE
--		once
--			create Result.make (Current)
--			create command.make_sb (Result, "Open Class Window", Current, 2)
--		end			

--	on_right_btn_press (sender: SB_MESSAGE_HANDLER; key: INTEGER; data: ANY): BOOLEAN
--		local
--			et_c: ET_CLASS
--			c: EDP_CLASS
--			ev: SB_EVENT
--		do
--			Result := True
--			et_c ?= current_item.data
--			if et_c /= Void then
--				c ?= et_c.data
--			end
--			if c /= Void then
--				c.make_class_window
--			elseif current_item.data /= Void then
--				ev ?= data
--				if ev /= Void then
--					class_tree_menu.pop_up (Void, ev.root_x, ev.root_y, 0,0)
--				end
--			else
--				Result := Precursor (sender, key, data)
--			end
--		end
end
