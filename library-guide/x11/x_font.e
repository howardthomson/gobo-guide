note

	description: "Interface to Xlib's Font resource"

	author: "Stephane Hillion"
	copyright: "Copyright (c) 1998-2006, Stephane Hillion and Howard Thomson"
	license: "GNU Public License (see COPYING)"

	TODO: "[
		Do not create new X_FONT_STRUCT for every call to 'query_font'
		Free allocated memory on dispose!!
	]"

class X_FONT

inherit 

	X_RESOURCE

	X_PORTABILITY_ROUTINES
	
create 

  	make,
  	from_external

feature {NONE} -- Creation

  	make (disp : X_DISPLAY; name : STRING)
      		-- Loads the specified font
    	require
      		disp /= Void
      		name /= Void
		do
			display := disp
			id      := x_load_font (display.to_external, string_to_external(name))
		end

	from_external (disp : X_DISPLAY; fid : INTEGER)
      		-- Creates an instance of X_FONT from an external identifier.
		require
			disp /= Void
		do
			display := disp
			id      := fid
		end

feature {NONE} -- implementation attributes: cached info

	font_struct: X_FONT_STRUCT

feature -- Destruction

	unload
			-- Deletes the association between the font resource ID
			-- and this font
		do
			x_unload_font (display.to_external, id)
		end

	query_font : X_FONT_STRUCT
			-- Returns a X_FONT_STRUCT class, which contains information
			-- associated with the font
		do
			if font_struct = Void then
				create font_struct.from_external (x_query_font (display.to_external, id))
			end
			Result := font_struct
		end
  
feature {NONE} -- External functions

  	x_load_font (disp, str : POINTER) : INTEGER
    	external "C use <X11/Xlib.h>"
    	alias "XLoadFont"
    	end
      
  	x_unload_font (d : POINTER; rid : INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XUnloadFont"
    	end

  	x_query_font (d : POINTER; rid : INTEGER) : POINTER
    	external "C use <X11/Xlib.h>"
    	alias "XQueryFont"
    	end

end 
