note

		description: "Arrayed item container widget"

	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

deferred class SB_ARRAYED_ITEM_CONTAINER [ G -> SB_ITEM ]

inherit

	SB_ITEM_CONTAINER [ INTEGER, G ]

	SB_ARRAY_HELPER [ G ]

feature -- Item access

   items_count: INTEGER
         -- Return the number of items in the list
      do
         Result := items.count
      end

   item(index: INTEGER): G
         -- Return the item at the given index
      do
         Result := items.item (index)
      end

   replace_item(index: INTEGER; new_item: G; notify: BOOLEAN)
         -- Replace the item with a [possibly subclassed] item
      require
         valid_accessor(index)
         new_item /= Void
      do
         	-- Notify item will be replaced
         do_send (SEL_REPLACED, ref_integer(index))
         	-- Copy the state over
         new_item.copy_state (items.item(index))
         	-- Add new
         items.put (new_item, index)
         	-- Redo layout
         recalc
      end

   insert_item (index: INTEGER; new_item: G; notify: BOOLEAN)
         -- Insert a new [possibly subclassed] item at the give index
      require
         index > 0 and then index <= items_count+1
         new_item /= Void
      do 
         	-- Add item to list
         array_insert (items, new_item, index)
        	-- Notify item has been inserted
         do_send (SEL_INSERTED, ref_integer(index))
         	-- Redo layout
         recalc
      end

   append_item(new_item: G; notify: BOOLEAN)
         -- Append a [possibly subclassed] item to the list
      do
         insert_item (items.count + 1, new_item, notify)
      end

   prepend_item (new_item: G; notify: BOOLEAN): INTEGER
         -- Prepend a [possibly subclassed] item to the list
      do
         insert_item (1, new_item, notify)
      end

   remove_item_notify (index: INTEGER; notify: BOOLEAN)
         -- Remove item from list
      do
         	-- Notify item will be deleted
         do_send (SEL_DELETED, ref_integer(index))
         	-- Remove item from list
         array_remove (items, index)
         	-- Redo layout
         recalc
      end

   clear_items_notify (notify: BOOLEAN)
         -- Remove all items from list
      local
         index: INTEGER
      do
         	-- Delete items
         from 
            index := items.count
         until
            index <= 0
         loop
            do_send (SEL_DELETED, ref_integer(index));
            index := index - 1
         end
        	 -- Free array
         create items.make (1, 0)
         	-- Redo layout
         recalc
      end

   move_item_notify(new_index, old_index: INTEGER; notify: BOOLEAN)
         -- Move item from old_index to new_index
      local
         old_item: G;
         ix: INTEGER;
      do
         -- Did it change?
         if old_index /= new_index then
            old_item := items.item(old_index);
            if new_index < old_index then
               from
                  ix := old_index
               until
                  ix <= new_index
               loop                  
                  items.put(items.item(ix - 1), ix);
                  ix := ix-1;
               end
            else
               from
                  ix := new_index
               until
                  ix <= old_index
               loop                  
                  items.put(items.item(ix), ix-1);
                  ix := ix-1;
               end
            end
            items.put(old_item, new_index);
            -- Redo layout
            recalc
         end
      end

feature -- Validation

	valid_accessor(index: INTEGER): BOOLEAN
		do
			Result := index /= DEFAULT_ACCESSOR and then index <= items_count
		end

feature { NONE } -- Implementation

	items: ARRAY [ G ];
		-- Item list
end
