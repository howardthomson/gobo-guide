deferred class SB_PV_X

inherit
	SB_PROPERTY_VALUE [ INTEGER ]
		rename
	--		value as x_private,
	--		set_value as set_x
		end

feature
	x_pos: INTEGER

	x_private: INTEGER
		do
			Result := x_pos
		end

--	set_x_pos(new_x: like x_pos) is
--		do
--			x_pos := new_x
--		end

	set_x(x: INTEGER)
		deferred
		end

end