deferred class SB_PV_MINIMUM_WIDTH

inherit

	SB_ONCE_PROPERTIES

feature

	minimum_width: INTEGER
		do
			Result := minimum_width_sb
		end

	minimum_width_sb: INTEGER

	set_minimum_width (a_minimum_width: like minimum_width)
		do
			minimum_width_sb := a_minimum_width
		end

	once_property_minimum_width: SB_PROPERTY_MINIMUM_WIDTH
		once
			create Result
--			once_properties.add_last (Result)
		end

	add_property_minimum_width
		local
			p: SB_PROPERTY_MINIMUM_WIDTH
		do
			p := once_property_minimum_width
			p.enable
		end

end