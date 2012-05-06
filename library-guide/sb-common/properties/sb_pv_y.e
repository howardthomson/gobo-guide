deferred class SB_PV_Y

inherit
	SB_PROPERTY_VALUE [ INTEGER ]
		rename
	--		value as y_private,
	--		set_value as set_y
		end

feature
	y_pos: INTEGER

	y_private: INTEGER
		do
			Result := y_pos
		end

--	set_y(new_y: like y_pos) is
--		do
--			y := new_y
--		end

	set_y(new_y: INTEGER)
		deferred
		end

end