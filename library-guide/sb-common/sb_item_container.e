note
	description:"Base class for various item containers like list/icon_list/tree etc"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

	Mods: "[
		ITEM_ACCESSOR_TYPE changed to 'like ITEM_TYPE' in various places
	]"

deferred class SB_ITEM_CONTAINER [ GI, GT -> SB_ITEM ]

	-- GI is the type of 'index' for this container
	-- GT is the type of 'item' in this container

inherit

	ANY	-- ??
	SB_MESSAGE_SENDER

feature -- Item access

 	item(index: GI): GT
      		-- Return the item at the given index
      	require
         	valid_accessor(index);
      	deferred
      	end

feature -- Item change

 	set_item_text(index: GI; text: STRING)
         	-- Change item text
      	require
         	valid_accessor(index)
      	deferred
      	end

 	set_item_icon(index: GI; icon: SB_ICON)
        	-- Change item icon
      	require
         	valid_accessor(index)
      	deferred
      	end

	set_item_data(index: GI; data: ANY)
         	-- Change item data
      	require
         	valid_accessor(index)
      	do
         	item(index).set_data(data);
      	end

feature -- Item move

 	move_item(new_index, old_index: GI)
         	-- Remove item from container
      	require
         	valid_accessor(old_index);
         	valid_accessor(new_index);
      	do
         	move_item_notify(new_index, old_index, False)
      	end

 	move_item_notify(new_index, old_index: GI; notify: BOOLEAN)
         	-- Remove item from container
      	require
         	valid_accessor(old_index);
         	valid_accessor(new_index);
      	deferred
      	end

feature -- Item removal

 	remove_item(index: GI)
         	-- Remove item from container
      	require
         	valid_accessor(index);
      	do
         	remove_item_notify(index,False)
      	end

 	remove_item_notify(index: GI; notify: BOOLEAN)
         	-- Remove item from container
      	require
         	valid_accessor(index);
      	deferred
      	end

   	clear_items, wipe_out
      	do
         	clear_items_notify(False)
      	end

   	clear_items_notify(notify: BOOLEAN)
         	-- Remove all items from list
      	deferred
      	end

feature -- Actions

   	recalc
      		-- Recalculate layout
      	deferred
      	end

   	update
      	deferred
      	end

feature -- Validation

	valid_accessor(index: GI): BOOLEAN
      	deferred
      	end

	DEFAULT_ACCESSOR: GI do end;	-- Original

end
