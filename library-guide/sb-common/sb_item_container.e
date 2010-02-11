indexing
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

 	item(index: GI): GT is
      		-- Return the item at the given index
      	require
         	valid_accessor(index);
      	deferred
      	end

feature -- Item change

 	set_item_text(index: GI; text: STRING) is
         	-- Change item text
      	require
         	valid_accessor(index)
      	deferred
      	end

 	set_item_icon(index: GI; icon: SB_ICON) is
        	-- Change item icon
      	require
         	valid_accessor(index)
      	deferred
      	end

	set_item_data(index: GI; data: ANY) is
         	-- Change item data
      	require
         	valid_accessor(index)
      	do
         	item(index).set_data(data);
      	end

feature -- Item move

 	move_item(new_index, old_index: GI) is
         	-- Remove item from container
      	require
         	valid_accessor(old_index);
         	valid_accessor(new_index);
      	do
         	move_item_notify(new_index, old_index, False)
      	end

 	move_item_notify(new_index, old_index: GI; notify: BOOLEAN) is
         	-- Remove item from container
      	require
         	valid_accessor(old_index);
         	valid_accessor(new_index);
      	deferred
      	end

feature -- Item removal

 	remove_item(index: GI) is
         	-- Remove item from container
      	require
         	valid_accessor(index);
      	do
         	remove_item_notify(index,False)
      	end

 	remove_item_notify(index: GI; notify: BOOLEAN) is
         	-- Remove item from container
      	require
         	valid_accessor(index);
      	deferred
      	end

   	clear_items, wipe_out is
      	do
         	clear_items_notify(False)
      	end

   	clear_items_notify(notify: BOOLEAN) is
         	-- Remove all items from list
      	deferred
      	end

feature -- Actions

   	recalc is
      		-- Recalculate layout
      	deferred
      	end

   	update is
      	deferred
      	end

feature -- Validation

	valid_accessor(index: GI): BOOLEAN is
      	deferred
      	end

	DEFAULT_ACCESSOR: GI is do end;	-- Original

end
