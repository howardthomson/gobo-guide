-- Properties in Slyboots objects:
--	width			SB_DRAWABLE
--	height				"
--	x_pos			SB_WINDOW
--	y_pos				"
--	default_cursor		"
--	drag_cursor			"
--	accel_table			"
--	layout				"
		
--	icon
--	background_colour
--	foreground_colour


deferred class SB_PROPERTY

feature -- Attributes

	enabled: BOOLEAN
		-- True if this property relevent to targeted object

feature

	name: STRING is
		deferred
		end

	enable is
			-- Set enabled
		do
			enabled := True
		ensure
			enabled_set: enabled
		end

	disable is
			-- reset enabled
		do
			enabled := False
		ensure
			disabled: not enabled
		end
end
