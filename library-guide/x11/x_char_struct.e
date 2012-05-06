note

		description: "C Structure -- Xlib XCharStruct"

	author:	"Howard Thomson"
	copyright: "Copyright (c) 2006, Howard Thomson"
	license: "Eiffel Forum License v2 (see forum.txt)"

expanded class X_CHAR_STRUCT

inherit 

	SE_EXP_12_BYTES
  
feature { NONE } -- Offsets of elements in Struct

	Base_lbearing		: INTEGER = 0
	Base_rbearing		: INTEGER = 2
	Base_width			: INTEGER = 4
	Base_ascent			: INTEGER = 6
	Base_descent		: INTEGER = 8
	Base_attributes		: INTEGER = 10

--	size: INTEGER is 12
	
feature -- Access

	lbearing		: INTEGER do Result := as_short(Base_lbearing	) end
	rbearing		: INTEGER do Result := as_short(Base_rbearing	) end
	width			: INTEGER do Result := as_short(Base_width		) end
	ascent			: INTEGER do Result := as_short(Base_ascent	) end
	descent			: INTEGER do Result := as_short(Base_descent	) end
	attributes		: INTEGER do Result := as_short(Base_attributes) end

end 
