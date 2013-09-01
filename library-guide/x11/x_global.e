note

	description: "Library global definitions"

	author: "Stephane Hillion"
	copyright: "Copyright (c) 1998-2006, Stephane Hillion and Howard Thomson"
	license: "Eiffel Forum License v2 (see forum.txt)"

class X_GLOBAL

inherit

	X11_EXTERNAL_ROUTINES

feature -- Public "constants"

	None_resource: INTEGER = 0

	All_planes: INTEGER
			-- returns a value with all bits set to 1 suitable
			-- for use in a plane argument to a procedure
		do
			Result := x_all_planes
		end

  	None_window: X_WINDOW
    	once
    		create Result.make_special (None_resource)
    	end

	None_cursor: X_CURSOR
    	once
    		create Result.make_special (None_resource)
    	end

	None_pixmap: X_PIXMAP
    	once
    		create Result.make_special (None_resource)
    	end

end
