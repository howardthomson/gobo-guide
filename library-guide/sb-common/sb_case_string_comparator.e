indexing
	description:"Case sensitive string comparition class"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

class SB_CASE_STRING_COMPARATOR

inherit

	SB_STRING_COMPARATOR

feature -- Comparison

	compare(a,b: STRING; len: INTEGER): INTEGER is
			-- Result = 0 => Strings are equal for 'len' characters
			-- Result > 0 => (a > b) or (a.count > b.count) 
			-- Result < 0 => (a < b) or (a.count < b.count)
		local
         	i, j: INTEGER
         	e1, e2: INTEGER
         	n: INTEGER
      	do
         	from
            	i := 1
            	j := 1
            	e1 := a.count
            	e2 := b.count
            	n := len
         	until
            	n <= 0 or else Result /= 0 or else (i > e1 and then j > e2)
         	loop
            	if i > e1 then
               		Result := - 1
            	elseif j > e2 then
               		Result := 1
            	else
               		Result := a.item(i).code - b.item(i).code
               		n := n - 1
               		i := i + 1
               		j := j + 1
            	end
         	end
      	end
end
