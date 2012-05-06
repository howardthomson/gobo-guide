note
	description: "Property values for side layout"

class SB_PV_LAYOUT_SIDE_VALUES

feature

	Side_normal	: INTEGER = 0	-- Default layout mode
	Side_top	: INTEGER = 0	-- Pack on top side (default)
	Side_bottom	: INTEGER = 1	-- Pack on bottom side
	Side_left	: INTEGER = 2	-- Pack on left side
	Side_right	: INTEGER = 3	-- Pack on right side

	Side_mask	: INTEGER = 3
end