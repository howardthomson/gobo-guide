indexing
	description:"ARRAY sorter."
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

class SB_H_ARRAY_SORTER [G]

inherit

	SB_ARRAY_SORTER [ G ]

feature -- sort


	sort(array: ARRAY [ G ]; comparator: SB_COMPARATOR [ G ]): BOOLEAN is
			-- Sort array using comparator object
		local
			v, c: G
         	i, j, h: INTEGER
         	nitems: INTEGER
      	do
         	nitems := array.count;
         	from h := 1 until h > nitems // 9 loop h := 3*h+1 end
         	from
         	until
            	h <= 0
         	loop
            	from
               		i := h + 1
            	until
               		i > nitems
            	loop
               		from
               			v := array.item(i)
               			j := i
               		until
                  		j <= h or else comparator.compare(array.item(j - h), v) <= 0
               		loop
                  		array.put(array.item(j - h), j)
                  		Result := True
                  		j := j - h
               		end
               		array.put(v, j)
               		i := i + 1
            	end
            	h := h // 3
         	end
		end
end
