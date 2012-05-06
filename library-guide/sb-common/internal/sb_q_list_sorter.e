note
	description: "[
		Quick and durty list sorter based on the ARRAY sorting
		let me know if you have better algorithm.
	]"
	author: "Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright: "Copyright (c) 2002, Eugene Melekhov and others"
	license: "Eiffel Forum Freeware License v2 (see forum.txt)"
	status: "Mostly complete"

class SB_Q_LIST_SORTER [ reference G -> SB_TREE_LIST_ITEM ]

inherit

	SB_LIST_SORTER [ G ]

feature -- Sorting

	sort(first_item: G; comparator: SB_COMPARATOR [ G ]): ARRAY [ G ]
    		-- Sort given list using comparator object. Returns array
         	-- of two elements first is the first item and the second is
         	-- the last item in the sorted list
		local
         	i,n: INTEGER
         --	cur, prv: reference G
         --	arr: ARRAY [ reference G ]
         	cur, prv: G
         	arr: ARRAY [ G ]
         	sorter: SB_H_ARRAY_SORTER [ G ]
      	do
			if sorter =  Void then
				create sorter
			end
			create Result.make(1, 2)
         	-- Count items
         	from
            	cur := first_item;
            	n := 0
         	until
            	cur = Void
         	loop
            	cur := cur.next;
            	n := n + 1;
         	end
         	if n > 1 then
            	create arr.make(1, n);
            	from
               		i := 1
               		cur := first_item
            	until
               		i > n
            	loop
               		arr.put(cur,i);
               		cur := cur.next;
               		i := i+1
            	end
            	if sorter.sort(arr, comparator) then
               		from
                  		i := 1
                		prv := void_g;
               		until
                  		i > n
               		loop
                  		cur := arr.item(i);
                  		cur.set_prev(prv);
                  		if prv /= Void then
                    		prv.set_next(cur);
                  		end
                  		prv := cur;
                  		i := i+1
               		end
            		arr.item(n).set_next(void_g);
            	end
            	Result.put(arr.item(1), 1);
            	Result.put(arr.item(n), 2);
         	else
            	Result.put(first_item, 1);
            	Result.put(first_item, 2);
         	end
		end

	void_g: G
end
