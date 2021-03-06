indexing

	description: "Library global definitions"

	author: "Stephane Hillion"
	copyright: "Copyright (c) 1998-2006, Stephane Hillion and Howard Thomson"
	license: "GNU Public License (see COPYING)"

class X_GLOBAL

inherit 

	X11_EXTERNAL_ROUTINES

feature -- Public "constants"

	None_resource: INTEGER is 0

	All_planes: INTEGER is
			-- returns a value with all bits set to 1 suitable 
			-- for use in a plane argument to a procedure
		do
			Result := x_all_planes
		end

  	None_window: X_WINDOW is
    	once
    		create Result.make_special (None_resource)
    	end

	None_cursor: X_CURSOR is
    	once
    		create Result.make_special (None_resource)
    	end

	None_pixmap: X_PIXMAP is
    	once
    		create Result.make_special (None_resource)
    	end

end 
