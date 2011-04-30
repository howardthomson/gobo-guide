class SB_PV_HEIGHT

inherit

	SB_ONCE_PROPERTIES

	SB_PV_MINIMUM_HEIGHT
		redefine
			set_minimum_height
		end

feature

	height: INTEGER

	height_private: INTEGER is
		do
			Result := height
		end

	set_height (new_height: like height) is
		do
			height := new_height.max (minimum_height)
		end

	set_minimum_height (a_height: like minimum_height) is
		do
			Precursor (a_height)
			height := height.max (minimum_height)
		end

	once_property_height: SB_PROPERTY_HEIGHT is
		once
			create Result
--			once_properties.add_last(Result)
		end

	add_property_height is
		local
			p: SB_PROPERTY_HEIGHT
		do
			p := once_property_height
			p.enable
		end

end