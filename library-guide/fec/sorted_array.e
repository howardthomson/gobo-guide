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

class SORTED_ARRAY [ KEY -> COMPARABLE, ELEMENT -> SORTABLE [ KEY ]]

-- this class provides efficient binary search functions for
-- sorted arrays. 
--
-- NOTE: It is the client's responsibility to keep the elements of
-- the array sorted in increasing order.

inherit

	BINARY_SEARCH_ARRAY [ KEY, ELEMENT ]
		rename
			has as array_has
		end

create

	make
	
feature { ANY }
			
	find (key: KEY): ELEMENT
		local
			index: INTEGER
		do
			index := binary_search (key, lower, upper)
			if index >= 0 then
				Result := item (index)
			end
		end
			
	has (key: KEY): BOOLEAN
		do
			Result := binary_search (key, lower, upper) >= 0
		end
			
end -- SORTED_ARRAY
