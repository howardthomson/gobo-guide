indexing

		description: "C Structure -- Xlib XCharStruct"

	author:	"Howard Thomson"
	copyright: "Copyright (c) 2006, Howard Thomson"
	license: "Eiffel Forum License v2 (see forum.txt)"

expanded class X_CHAR_STRUCT

inherit 

	SE_EXP_12_BYTES
  
feature { NONE } -- Offsets of elements in Struct

	Base_lbearing		: INTEGER is 0
	Base_rbearing		: INTEGER is 2
	Base_width			: INTEGER is 4
	Base_ascent			: INTEGER is 6
	Base_descent		: INTEGER is 8
	Base_attributes		: INTEGER is 10

--	size: INTEGER is 12
	
feature -- Access

	lbearing		: INTEGER	is do Result := as_short(Base_lbearing	) end
	rbearing		: INTEGER	is do Result := as_short(Base_rbearing	) end
	width			: INTEGER	is do Result := as_short(Base_width		) end
	ascent			: INTEGER	is do Result := as_short(Base_ascent	) end
	descent			: INTEGER	is do Result := as_short(Base_descent	) end
	attributes		: INTEGER	is do Result := as_short(Base_attributes) end

end 
