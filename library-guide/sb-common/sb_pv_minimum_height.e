class SB_PV_MINIMUM_HEIGHT

inherit

	SB_ONCE_PROPERTIES

feature

	minimum_height: INTEGER

	minimum_height_private: INTEGER is
		do
			Result := minimum_height
		end

	set_minimum_height (new_minimum_height: like minimum_height) is
		do
			minimum_height := new_minimum_height
		end

	once_property_minimum_height: SB_PROPERTY_MINIMUM_WIDTH is
		once
			create Result
--			once_properties.add_last (Result)
		end

	add_property_minimum_height is
		local
			p: SB_PROPERTY_MINIMUM_HEIGHT
		do
			p := once_property_minimum_height
			p.enable
		end

end