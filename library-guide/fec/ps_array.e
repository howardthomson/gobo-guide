--------------------------------------------------------------------------------
-- FEC -- Native Eiffel Compiler for SUN/SPARC
--
--  Copyright (C) 1997 Fridtjof Siebert
--    EMail: fridi@gr.opengroup.org
--    SMail: Fridtjof Siebert 
--           5b rue du 26 mai 1944
--           38940 St. Martin le Vinoux
--           Grenoble
--
--  This program is free software; you can redistribute it and/or modify
--  it under the terms of the GNU Lesser General Public License as published by
--  the Free Software Foundation; Version 2.
--
--  This program is distributed in the hope that it will be useful,
--  but WITHOUT ANY WARRANTY; without even the implied warranty of
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--  GNU Lesser General Public License for more details.
--
--  You should have received a copy of the GNU Lesser General Public License
--  along with this program; if not, write to the Free Software
--  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
--
--------------------------------------------------------------------------------

class PS_ARRAY [ KEY -> COMPARABLE, ELEMENT -> SORTABLE [ KEY ]]  -- Partly sorted Array

-- A Partly sorted array. This is a sorted array data structure that allows
-- fast insertion and retrieval of elements and fast sorting of the complete
-- array. 
--
-- This array stores n Elements in sorted subarray whose sizes are powers of two.
-- For every "1" at Position i in the binary representation of n there is a 
-- sorted array of 2^i Elements. So for n=10, we have two arrays, eight are
-- stored in one sorted array, two in another. Adding one Element to this list
-- will add a new array with a single Element (which is sorted). Adding yet
-- another element forces to join the new element, and the elements in the
-- one- and two-element-arrays into one sorted four-element-array. 

create

	make
	
feature { NONE }

	data: BINARY_SEARCH_ARRAY [ KEY, ELEMENT ]

	msb_of_count: INTEGER
			-- 2^log2(count) = Most significant bit of count.

	min_size: INTEGER = 7			-- minimum number of elements allocated.
	msb_of_min_size: INTEGER = 3	-- msb(min_size)
	
feature { ANY }
		
	count: INTEGER
			-- number of elements in the array

	item alias "@" (i: INTEGER): ELEMENT
		do
			Result := data.item (i)
		end
	
	is_empty: BOOLEAN 
		do
			Result := count = 0
		ensure
			Result = (count = 0)
		end  -- is_empty

	make -- create an empty array
		do
			create data.make (1, min_size)
			count := 0
			msb_of_count := 0
		ensure
			count = 0
		end -- make	
		
	add (element: ELEMENT) 
		local
			first_empty, c_div_fe: INTEGER
			index: INTEGER
		do
			count := count + 1
			if count = 1 then
				msb_of_count := 1
			elseif count = 2 * msb_of_count then
				msb_of_count := count
				if count > data.upper then
					data.resize (1, count * 2 - 1)
				end
			end
			
			from
				first_empty := 1
				c_div_fe := count
			until
				c_div_fe \\ 2 = 1
			loop
				first_empty := 2 * first_empty
				c_div_fe := c_div_fe // 2
			end

			data.put (element, first_empty)
			from
				index := 1
			until
				index = first_empty
			loop
				join_arrays (index, first_empty, index)
				index := index * 2
			end
		end  -- add

	find (key: KEY): ELEMENT
		local
			index, c_mod_index, search_index: INTEGER
		do
			from
				index := 2 * msb_of_count
				c_mod_index := count
			until
				c_mod_index = 0 or 
				Result /= Void
			loop
				index := index // 2
				if c_mod_index >= index then
					search_index := data.binary_search (key, index, 2 * index - 1)
					if search_index >= 0 then
						Result := data @ search_index
					end
					c_mod_index := c_mod_index - index
				end
			end
		end -- find

	has (key: KEY): BOOLEAN
		do
			Result := find(key) /= Void
		end -- has

	replace (element: ELEMENT)
		require
			-- find (element.key) /= Void
		local
			index, c_mod_index, search_index: INTEGER
		do
			from
				index := 2 * msb_of_count
				c_mod_index := count
				search_index := -1
			until
				search_index >= 0
			loop
				index := index // 2
				if c_mod_index >= index then
					search_index := data.binary_search (element.key, index, 2*index-1)
					c_mod_index := c_mod_index - index
				end;
			end
			data.put (element, search_index)
		end -- replace

	get_sorted: SORTED_ARRAY [ KEY, ELEMENT ]
		local
			index, c_div_index, result_len, l1, l2, j: INTEGER
		do
			create Result.make (1, count)
			from
				index := 1
				c_div_index := count
			until
				c_div_index = 0
			loop
				if c_div_index \\ 2 = 1 then				
					from
						l1 := index - 1
						l2 := result_len - 1
						j := index + result_len
					until
						j = 0
					loop
						if l1 < 0 or else
							(l2 >= 0 and then
							 (data @ (index+l1)).key < (Result @ (1+l2)).key)
						then Result.put (Result @ (1+l2)    ,j); l2 := l2 - 1
						else Result.put (data   @ (index+l1),j); l1 := l1 - 1
						end
						j := j - 1
					end;
					result_len := result_len + index
				end
				index := index * 2
				c_div_index := c_div_index // 2
			end
		ensure 
			Result.lower = 1
			Result.upper = count
		end -- get_sorted

feature { NONE }
	
	join_arrays (src, dst, len: INTEGER)
		local
			j, l1, l2: INTEGER
		do
			from
				j := 2 * len
				l1 := len - 1
				l2 := len - 1
			until
				j = 0
			loop
				j := j - 1
				if l1 < 0 or else
					(l2 >= 0 and then
					(data @ (src+l1)).key < (data @ (dst+l2)).key)
				then data.put (data @ (dst+l2), dst+j); l2 := l2 - 1
				else data.put (data @ (src+l1), dst+j); l1 := l1 - 1
				end
			end	
		end -- join_arrays
		
end -- PS_ARRAY


