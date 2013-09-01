note
	description: "Interface to Xlib's Atom resource"

	author: "Stephane Hillion"
	copyright: "Copyright (c) 1998-2006, Stephane Hillion and Howard Thomson"
	license: "Eiffel Forum License v2 (see forum.txt)"

class X_ATOM

inherit

	X_RESOURCE

create

	make,
	make_predefined

feature { NONE } -- Initialization

	make (a_display: X_DISPLAY; a_name: STRING; if_exists: BOOLEAN)
		    -- Creates the atom identifier associated with the specified
		    -- `name' string.  If `if_exists' is False, the atom is created
		    -- if it does not exist. Therefore `make' can create a
		    -- `None_resource' atom.
    	require
      		a_display /= Void
      		a_name /= Void
    	do
      		display := a_display
 			id := x_intern_atom (display.to_external, string_to_external (a_name), if_exists)
		end

	make_predefined (a_display: X_DISPLAY; n: INTEGER)
			-- Creates an atom from an external identifier `n'.
		require
			a_display /= Void
		do
			display := a_display
			id := n
		end

feature -- Name

	get_atom_name: STRING
			-- returns the name associated with the specified atom.
		require
			id /= None_resource
		do
--			create Result.from_external (x_get_atom_name (display.to_external, id))
		ensure
			implemented: false
		end

end
