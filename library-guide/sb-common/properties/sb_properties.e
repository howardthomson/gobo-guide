note

	todo: "[
		Make properties frozen, returning once_properties, and arrange to adapt
		each property on-the-fly to the values and hidden/shown depending on the
		target window/object
	]"

-- deferred
class SB_PROPERTIES

inherit

	SB_ONCE_PROPERTIES

feature

	frozen properties: ARRAY [ SB_PROPERTY ]
		do
			Result := once_properties
			disable_all(Result)
			add_properties
		end

	disable_all(a: ARRAY [ SB_PROPERTY ])
			-- disable all properties in array
		local
			i: INTEGER
		do
			from
				i := a.count
			until
				i = 0
			loop
				(a @ i).disable
				i := i - 1
			end
		end
	
	add_properties
		do
		end

	print_properties
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i > properties.count
			loop
				fx_trace2("Property: " + (properties @ i).name)
				i := i + 1
			end
		end

end