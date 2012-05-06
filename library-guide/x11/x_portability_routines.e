note
	description: "Routines for compiler portability"
	author: "Howard Thomson"
	copyright: "Copyright (c) 2004-2006, Howard Thomson"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$31-Mar-2004$"
	revision: "$0.1$"

class

	X_PORTABILITY_ROUTINES

inherit

	X_PORTABILITY_ANCHORS
	
feature {NONE} -- Implementation

	pow (b, p: REAL_64): REAL_64
		do
			Result := b ^ p
		end

	string_to_external (s: STRING): POINTER
			-- Get external POINTER for C processing from STRING
		do
--			Result := s.to_external
			Result := s.area.item_address (0)
		end

	any_to_pointer (a: ANY): POINTER
		do
--			Result := a.to_pointer
			Result := $a
		end		

	array_to_external (a: ARRAY [ ANY ]): POINTER
		do
--			Result := a.to_external
			Result := a.area.item_address (0)
		end


end -- class X_PORTABILITY_ROUTINES
