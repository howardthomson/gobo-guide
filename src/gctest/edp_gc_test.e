class EDP_GC_TEST

create

	make

feature -- Attributes

	random: RANDOM

	gc_roots: ARRAY [ ANY ]

feature -- Creation

	make
		local
			i, j: INTEGER
			s: SPECIAL [ INTEGER_8 ]
		do
				-- Create source of [pseudo] randomess
			create random.make
				-- Create array of GC 'roots'
			create gc_roots.make (1, 4096)
				-- Pseudo-randomly create objects, of various sizes ...
			from random.start until False loop
				i := random.item
				i := i.bit_and ((1 |<< 11) - 1)
				i := i |<< 4
				create s.make (i)
				random.forth
				j := random.item.bit_and (4095)
				gc_roots.put (s, j + 1)
				random.forth
			end
		end

end