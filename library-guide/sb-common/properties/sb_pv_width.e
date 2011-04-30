class SB_PV_WIDTH

inherit

	SB_ONCE_PROPERTIES

	SB_PV_MINIMUM_WIDTH
		redefine
			set_minimum_width
		end

feature

	width: INTEGER

	width_private: INTEGER is
		do
			Result := width
		end

	set_width (new_width: like width) is
		do
			width := new_width.max (minimum_width)
		end

	set_minimum_width (a_width: like minimum_width) is
		do
			Precursor (a_width)
			width := width.max (minimum_width)
		end

	once_property_width: SB_PROPERTY_WIDTH is
		once
			create Result
--			once_properties.add_last (Result)
		end

	add_property_width is
		local
			p: SB_PROPERTY_WIDTH
		do
			p := once_property_width
			p.enable
		end

end