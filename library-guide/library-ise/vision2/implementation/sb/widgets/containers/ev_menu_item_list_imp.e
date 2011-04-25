indexing
	description: "Eiffel Vision menu item list. GTK+ implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_MENU_ITEM_LIST_IMP

inherit
	EV_MENU_ITEM_LIST_I
		redefine
			interface
		end

	EV_ITEM_LIST_IMP [EV_MENU_ITEM]
		redefine
			insert_i_th,
			interface,
			remove_i_th
		end

	EV_MENU_ITEM_LIST_ACTION_SEQUENCES_IMP

feature {NONE} -- Implementation

	insert_i_th (v: like item; pos: INTEGER) is
		do
		-- TODO
		end

	insert_menu_item (an_item_imp: EV_MENU_ITEM_IMP; pos: INTEGER) is
			-- Generic menu item insertion.
		do
			child_array.go_i_th (pos)
			child_array.put_left (an_item_imp.interface)
			an_item_imp.set_item_parent_imp (Current)
		end

	separator_imp_by_index (an_index: INTEGER): EV_MENU_SEPARATOR_IMP is
			-- Separator before item `an_index'.
		require
			an_index_within_bounds:
				an_index > 0 and then an_index <= interface.count
		local
			cur: CURSOR
			cur_item: INTEGER
			sep_imp: EV_MENU_SEPARATOR_IMP
		do
			cur := cursor
			from
				start
				cur_item := 1
			until
				(index = count + 1) or else an_index = cur_item
			loop
				sep_imp ?= i_th (index).implementation
				if sep_imp /= Void then
					Result := sep_imp
				end
				forth
				cur_item := cur_item + 1
			end
			go_to (cur)
		end

	is_menu_separator_imp (an_item_imp: EV_ITEM_I): BOOLEAN is
		local
			sep_imp: EV_MENU_SEPARATOR_IMP
		do
			sep_imp ?= an_item_imp
			Result := sep_imp /= Void
		end

	remove_i_th (a_position: INTEGER) is
			-- Remove item at `a_position'
		local
			item_imp: EV_ITEM_IMP
			radio_imp: EV_RADIO_MENU_ITEM_IMP
			sep_imp: EV_MENU_SEPARATOR_IMP
			an_index: INTEGER
			has_radio_item: BOOLEAN
			temp_item_pointer, l_null: POINTER
		do
		end

feature -- Radio Group

	radio_group_ref: POINTER_REF is
		do
			--| FIXME IEK Use opo syntax when available in compiler.
			--| Same applies to access of action sequences.
--			if radio_group_ref_internal = Void then
--				create radio_group_ref_internal
--			end
--			Result := radio_group_ref_internal
		end

	set_radio_group (p: POINTER) is
			-- Assign `p' to `radio_group'.
		do
--			radio_group_ref.set_item (p)
		end

	radio_group: POINTER is
			-- GSList with all radio items of this container.
		do
--			Result := radio_group_ref.item
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_MENU_ITEM_LIST;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_MENU_ITEM_LIST_IMP

