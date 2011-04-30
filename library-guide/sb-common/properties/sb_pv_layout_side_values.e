indexing
	description: "Property values for side layout"

class SB_PV_LAYOUT_SIDE_VALUES

feature

	Side_normal	: INTEGER is 0	-- Default layout mode
	Side_top	: INTEGER is 0	-- Pack on top side (default)
	Side_bottom	: INTEGER is 1	-- Pack on bottom side
	Side_left	: INTEGER is 2	-- Pack on left side
	Side_right	: INTEGER is 3	-- Pack on right side

	Side_mask	: INTEGER is 3
end