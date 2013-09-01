note

	description: "Interface to Xlib's Colormap resource."

	author: "Stephane Hillion"
	copyright: "Copyright (c) 1998-2006, Stephane Hillion and Howard Thomson"
	license: "Eiffel Forum License v2 (see forum.txt)"

class X_COLORMAP

inherit

	X_RESOURCE

create

	make,
	from_external

feature {NONE} -- Creation

	make (win: X_WINDOW; visual: X_VISUAL; alloc_mode: INTEGER)
		-- creates a colormap of the specified visual type for the screen
      	-- on which the specified window resides.
    	require
      		win_not_void: win /= Void
      		visual_not_void: visual /= Void
    	do
      		display := win.display
      		screen := win.screen
      		id := x_create_colormap (display.to_external,
				    	win.id, visual.to_external, alloc_mode)
    	end

  	from_external (disp: X_DISPLAY; scr: INTEGER; cid: INTEGER)
      		-- Creates a colormap from an external one.
    	require
      		disp /= Void
    	do
      		display := disp
      		screen  := scr
      		id      := cid
    	end

feature -- Installation

	install
			-- installs the colormap for its associated screen
    	do
      		x_install_colormap (display.to_external, id)
    	end

  	uninstall
      		-- uninstalls the colormap
    	do
      		x_uninstall_colormap (display.to_external, id)
    	end

feature -- Destruction

  	free
    	require
      		id /= display.default_colormap (screen).id
    	do
      		x_free_colormap (display.to_external, id).do_nothing
    	end

feature

 	screen : INTEGER
      	-- screen number

	alloc_color (col : X_COLOR)
      		-- Allocates a read-only colormap entry.
      		-- `col' is modified by this method.
    	require
			col /= Void
    	do
      		x_alloc_color (display.to_external, id, col.to_external)
    	end

	alloc_named_color (col_name: STRING; col_close, col_exact: X_COLOR)
		-- looks up the named color
		-- `col_close' and `col_exact' are modified.
		require
      		col_name   /= Void
			col_close  /= Void
			col_exact  /= Void
		do
		--	x_alloc_named_color (display.to_external, id, string_to_external(col_name),
        --		col_close.to_external, col_exact.to_external)
    	ensure
    		implemented: false
    	end

--	alloc_color_cells (n : INTEGER) : C_VECTOR [C_INT] is
--			-- allocates read/write color cells
--		require
--			n > 0
--		local
--			ci : C_INT
--		do
--			create ci.make
--			create Result.make (n, ci)
--			x_alloc_color_cells (display.to_external, id, false, default_pointer, 0,
--				Result.to_external, n)
--		end

  	store_color (col: X_COLOR)
      	-- changes the colormap entry of the pixel value specified in
      	-- the `pixel' member of `col'.
    	require
     		col /= Void
    	do
      		x_store_color (display.to_external, id, col.to_external)
    	end

  	store_named_color (col_name : STRING;
		     pix      : INTEGER;
		     mask     : INTEGER_8)
      		-- looks up the named color with respect to the screen associated
      		-- with the colormap and stores the result in the colormap.
    	require
      		col_name /= Void
		do
		--	x_store_named_color (display.to_external, id,
        --		col_name.to_external, pix, mask.to_character)
    	ensure
    		implemented: false
    	end

	parse_color (name : STRING; col : X_COLOR) : BOOLEAN
			-- modify col and return True if name exists
		require
			name /= Void
			col  /= Void
		do
		--	Result := x_parse_color (display.to_external, id,
        --				name.to_external, col.to_external) /= 0
		ensure
			implemented: false
		end

feature {NONE} -- External functions

--	xalloc_all (i : INTEGER) : INTEGER is
--		external "C use <X11/Xlib.h>"	
--		alias "alloc_all"
--		end
--
--	xalloc_none (i : INTEGER) : INTEGER is
--		external "C use <X11/Xlib.h>"	
--    	alias "alloc_none"
--    	end

	x_create_colormap (d : POINTER; rid : INTEGER;
                     dv : POINTER; a : INTEGER) : INTEGER
		external "C use <X11/Xlib.h>"
    	alias "XCreateColormap"
    	end

  	x_install_colormap (pDisplay: POINTER; rid : INTEGER)
		external "C use <X11/Xlib.h>"
    	alias "XInstallColormap"
    	end

  	x_uninstall_colormap (pDisplay: POINTER; rid : INTEGER)
		external "C use <X11/Xlib.h>"
    	alias "XUninstallColormap"
    	end

  	XFreeColormap, x_free_colormap (pDisplay: POINTER; iColormap: INTEGER): INTEGER
		external "C use <X11/Xlib.h>"
    	alias "XFreeColormap"
    	end

  	x_alloc_color (d : POINTER; rid : INTEGER; col : POINTER)
		external "C use <X11/Xlib.h>"
    	alias "XAllocColor"
    	end

  	x_alloc_named_color (d : POINTER; rid : INTEGER; str, c1, c2 : POINTER)
		external "C use <X11/Xlib.h>"
    	alias "XAllocNamedColor"
    	end

  	x_alloc_color_cells (d : POINTER; rid : INTEGER; b : BOOLEAN; p : POINTER;
                       i : INTEGER; buf : POINTER; n : INTEGER)
		external "C use <X11/Xlib.h>"
    	alias "XAllocColorCells"
    	end

  	x_store_color (d : POINTER; rid : INTEGER; col : POINTER)
		external "C use <X11/Xlib.h>"
    	alias "XStoreColor"
    	end

  	x_store_named_color (d : POINTER; rid : INTEGER;
                       str : POINTER; pix : INTEGER; mk : CHARACTER)
		external "C use <X11/Xlib.h>"
    	alias "XStoreNamedColor"
    	end

  	x_parse_color (d : POINTER; rid : INTEGER; n, c : POINTER) : INTEGER
		external "C use <X11/Xlib.h>"
    	alias "XParseColor"
    	end

end
