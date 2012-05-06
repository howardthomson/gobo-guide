deferred class SB_PV_HEIGHT

inherit

	SB_ONCE_PROPERTIES

	SB_PV_MINIMUM_HEIGHT
		redefine
			set_minimum_height
		end

feature

	height: INTEGER
		do
			Result := height_sb
		end

	height_sb: INTEGER

	set_height (a_height: like height)
		do
			height_sb := a_height.max (minimum_height_sb)
		end

	set_minimum_height (a_height: like minimum_height)
		do
			Precursor (a_height)
			height_sb := height_sb.max (minimum_height)
		end

	once_property_height: SB_PROPERTY_HEIGHT
		once
			create Result
--			once_properties.add_last(Result)
		end

	add_property_height
		local
			p: SB_PROPERTY_HEIGHT
		do
			p := once_property_height
			p.enable
		end

end