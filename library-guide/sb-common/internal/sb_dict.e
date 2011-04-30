indexing
	description:"[
		The dictionary class maintains a fast-access hash table of entities
		indexed by a HASHABLE key
	]"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

class SB_DICT [G, H -> HASHABLE]

creation
   make

feature -- Creation

	make is
			-- Construct an empty dictionary
		do
		--	create dictionary.with_capacity(10)
		end

feature -- Queries

	find(key: H): G is
			-- Find entry by given key.
		do
		--	Result := dictionary.reference_at(key);
		end

feature -- Actions

   insert_if(key: H; entry: G) is
         -- Insert a new entry into the table given key and mark.
         -- If there is already an entry with that key, leave it unchanged,
         -- otherwise insert the new entry.
      do
      --   if not dictionary.has(key) then
      --      dictionary.put(entry,key);
      --   end
      end

   replace(key: H; entry: G) is
         -- Replace data at key. If there was no existing entry,
         -- a new entry is inserted.
      do
      --   dictionary.put(entry,key);
      end

   remove(key: H) is
         -- Remove data given key.
      do
      --   dictionary.remove (hotkey);
      end

   wipe_out is
         -- remove all entries from the table
      do
      --   dictionary.clear
      end
      
feature {NONE} -- Implementation

--	dictionary: DICTIONARY[G, H];

end
