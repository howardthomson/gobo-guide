indexing

	description: "Base class for all X resources"

	author: "Stephane Hillion"
	copyright: "Copyright (c) 1998-2006, Stephane Hillion and Howard Thomson"
	license: "GNU Public License (see COPYING)"

class X_RESOURCE

inherit

	X_GLOBAL

create

	-- No creation

feature -- Attributes

	display: X_DISPLAY
			-- The display of the resource.

	id: INTEGER
			-- The X id.

	is_same_resource (other: X_RESOURCE): BOOLEAN is
    		-- Equality test
    	do
      		Result := display.is_equal (other.display) and then id = other.id
    	end

	is_attached: BOOLEAN is
		do
			Result := id /= 0
		end
end 
