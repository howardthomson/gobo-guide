deferred class SB_PV_WIDTH

inherit

	SB_ONCE_PROPERTIES

	SB_PV_MINIMUM_WIDTH
		redefine
			set_minimum_width
		end

feature

	width: INTEGER
		do
			Result := width_sb
		end

	width_sb: INTEGER

	set_width (a_width: like width)
		do
			width_sb := a_width.max (minimum_width_sb)
		end

	set_minimum_width (a_width: like minimum_width)
		do
			Precursor (a_width)
			width_sb := width_sb.max (minimum_width)
		end

	once_property_width: SB_PROPERTY_WIDTH
		once
			create Result
--			once_properties.add_last (Result)
		end

	add_property_width
		local
			p: SB_PROPERTY_WIDTH
		do
			p := once_property_width
			p.enable
		end

end