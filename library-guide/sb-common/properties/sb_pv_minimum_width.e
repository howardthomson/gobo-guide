class SB_PV_MINIMUM_WIDTH

inherit

	SB_ONCE_PROPERTIES

feature

	minimum_width: INTEGER

	minimum_width_private: INTEGER is
		do
			Result := minimum_width
		end

	set_minimum_width (new_minimum_width: like minimum_width) is
		do
			minimum_width := new_minimum_width
		end

	once_property_minimum_width: SB_PROPERTY_MINIMUM_WIDTH is
		once
			create Result
--			once_properties.add_last (Result)
		end

	add_property_minimum_width is
		local
			p: SB_PROPERTY_MINIMUM_WIDTH
		do
			p := once_property_minimum_width
			p.enable
		end

end