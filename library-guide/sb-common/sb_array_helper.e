note
	description:"Helper class implementing missing insert feature"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

	todo: "[
		Adapt for ISE
	]"

class SB_ARRAY_HELPER [ E ]

feature {NONE}

	array_insert (arr: ARRAY[E]; item: E; index: INTEGER)
    	require
        	arr /= Void and then index >= arr.lower and then index <= arr.upper+1
      	local
         	up: INTEGER;
      	do
         	if index = arr.upper + 1 then
            	arr.force (item, index);
         	else
            	up := arr.upper;
            	arr.resize (arr.lower, up + 1)
				array_move (arr, index, up, 1)
            	arr.put (item, index)
         	end
      	end

	array_remove (arr: ARRAY[E]; index: INTEGER)
		require
			array_not_void: arr /= Void
			valid_index: index >= arr.lower and then index <= arr.upper
		do
			array_move (arr, index, arr.upper, -1)
			arr.resize (arr.lower, arr.upper - 1)
		end

feature {NONE}

	array_move (arr: ARRAY[E]; l, u, by: INTEGER)
			-- move elements in array between 'l' and 'u'
			-- by offset 'by'
		require
			by_non_zero: by /= 0
		local
			i: INTEGER
		do

-- FIX for move direction !!!
			if by > 0 then
				from
					i := l
				until
					i > u
				loop
					arr.put (arr @ i, i + by)
					i := i + 1
				end
			else
				from
					i := u
				until
					i < l
				loop
					arr.put (arr @ i, i + by)
				end
			end
		end

end
