note

	description: "Interface to the InputOutput Window"

	author: "Stephane Hillion"
	copyright: "Copyright (c) 1998-2006, Stephane Hillion and Howard Thomson"
	license: "GNU Public License (see COPYING)"

class X_DRAWABLE_WINDOW

inherit 

  	X_WINDOW
    	rename
      		make          as x_window_make,
      		from_external as x_window_from_external
    	end

  	X_DRAWABLE

create 

  	make,
  	from_external,
  	make_simple

feature { NONE } -- Creation

  	make (parent       : X_WINDOW;
        x,
        y,
        width,
        height,
        border_width,
        depth        : INTEGER;
        visual       : X_VISUAL;
        mask         : INTEGER;
        attributes   : X_SET_WINDOW_ATTRIBUTES)
      	-- Creates an InputOutput window
    do
      	x_window_make (parent,
		     x, y, width, height,
		     border_width, depth,
		     Input_output,
		     visual,
		     mask, attributes)
      		init (parent.display, parent.screen)
    	end

  	from_external (disp : X_DISPLAY; scr : INTEGER; xid : INTEGER)
      		-- Encapsulates an external window in an instance
    	do
      		x_window_from_external (disp, scr, xid)
      		init (disp, scr)
    	end

  	make_simple (parent : X_WINDOW; 
	       x, 
	       y, 
	       width, 
	       height,
	       border_width,
	       border_pixel,
	       background_pixel : INTEGER)
      		-- Simplified creation procedure
    	do
      		init (parent.display, parent.screen)

      		display := parent.display
      		screen  := parent.screen

      		id := x_create_simple (parent.display.to_external,
			     parent.id,
			     x,
			     y,
			     width,
			     height,
			     border_width,
			     border_pixel,
			     background_pixel)
    	end

feature

  	clear
      		-- clears the entire area in the window and is equivalent to
      		-- clear_area (0, 0, 0, 0, False).
    	do
      		x_clear_window (display.to_external, id)
    	end
		--------

  	clear_area (x, y, w, h : INTEGER; send_event : BOOLEAN)
      		-- paints a rectangular area in the window according to the 
      		-- specified dimensions with the window's background pixel or pixmap.
    	do
      		x_clear_area (display.to_external, id, x, y, w, h, send_event)
    	end
		--------

feature -- colors

  	set_border (pixel : INTEGER)
      		-- sets the border of the window to the pixel value specified
    	require
      		not is_same_resource (display.root_window (screen))
    	do
      		x_set_window_border (display.to_external, id, pixel)
    	end
		--------

  	set_background (pixel : INTEGER)
      		-- sets the background of the window to the pixel value specified
    	do
      		x_set_window_background (display.to_external, id, pixel)
    	end
    --------

	set_colormap (c : X_COLORMAP)
      		-- sets the specified colormap of the window
    	require
      		not is_same_resource (display.root_window (screen))
    	do
      		x_set_window_colormap (display.to_external, id, c.id)
    	end
		--------

feature -- pixmaps

	set_background_pixmap (pix : X_PIXMAP)
      		-- sets the background pixmap of the window to the specified 
      		-- pixmap. To unset the pixmap use 'None_pixmap'.
    	do
      		x_set_window_background_pixmap (display.to_external, id, pix.id)
    	end
		--------
  
  	set_border_pixmap (pix : X_PIXMAP)
      		-- sets the border pixmap of the window to the specified pixmap.
      		-- To unset the pixmap use 'None_pixmap'.
    	require
      		not is_same_resource (display.root_window (screen))
    	do
      		x_set_window_border_pixmap (display.to_external, id, pix.id)
    	end
		--------

feature {NONE} -- External functions

  	x_create_simple (d : POINTER; pid, x, y, w, h, 
			bw, bp, bgp : INTEGER) : INTEGER
    	external "C use <X11/Xlib.h>"
    	alias "XCreateSimpleWindow"
    	end
		---------

  	x_clear_window (d : POINTER; rid : INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XClearWindow"
    	end
		--------

  	x_clear_area (d : POINTER; rid, x, y, w, h : INTEGER; b : BOOLEAN)
    	external "C use <X11/Xlib.h>"
    	alias "XClearArea"
    	end
    	--------

  	x_set_window_border (d : POINTER; rid, pix : INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XSetWindowBorder"
    	end

  	x_set_window_background (d : POINTER; rid, pix : INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XSetWindowBackground"
    	end

  	x_set_window_colormap (d : POINTER; rid, cid : INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XSetWindowColormap"
    	end

  	x_set_window_background_pixmap (d : POINTER; wid, pid : INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XSetWindowBackgroundPixmap"
    	end

  	x_set_window_border_pixmap (d : POINTER; wid, pid : INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XSetWindowBorderPixmap"
    	end

end 
