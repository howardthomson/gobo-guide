class SB_ONCE_PROPERTIES

feature

	once_properties: ARRAY [ SB_PROPERTY ]
		once
			create Result.make(1, 0)
		end

end