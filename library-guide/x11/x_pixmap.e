indexing

		description: "Interface to Xlib's Pixmap resource"

	author: "Stephane Hillion"
	copyright: "Copyright (c) 1998-2006, Stephane Hillion and Howard Thomson"
	license: "GNU Public License (see COPYING)"

class X_PIXMAP

inherit

	ANY -- ISE ??

	X_DRAWABLE

creation

	make, from_bits

creation { X_EVENT }

	from_external

creation { X_GLOBAL }

	make_special

feature -- Attributes

	width  : INTEGER      -- Pixmap's width in pixels
	height : INTEGER      -- Pixmap's height in pixels
	depth  : INTEGER      -- Pixmap's depth

feature { NONE } -- Creation

	make (win: X_WINDOW; w, h, d: INTEGER) is
			-- Create a new pixmap.
    	require
      		win /= Void
      		w > 0
     	 	h > 0
    	do
      		init (win.display, win.screen)

      		display := win.display
      		width   := w
      		height  := h
      		depth   := d

      		id      := x_create_pixmap (display.to_external,
				  win.id,
				  width,
				  height,
				  depth)
    	end

	from_bits (win: X_WINDOW; bits: POINTER; w, h: INTEGER) is
  		do
  			display := win.display
  			width  := w
  			height := h
  			depth  := 1
			id := x_create_bitmap_from_bits (display.to_external, win.id, bits, w, h)
  		end

	from_external (a_display: X_DISPLAY; scr, pid: INTEGER) is
			-- Encapsulate an existing pixmap in a X_PIXMAP object.
    	require
    		a_display /= Void
    	do
      		init (a_display, scr)
      		display := a_display
			x_get_geometry (display.to_external, pid, $id, $id, $id,
                      $width, $height, $id, $depth)
			id := pid
    	end

	make_special (pid : INTEGER) is
		do
			id := pid
		end

feature -- Destruction

	destroy is
		do
			x_free_pixmap (display.to_external, id)
		end

feature { NONE } -- External functions

  	x_create_pixmap (d: POINTER; wid, w, h, dp: INTEGER) : INTEGER is
    	external "C use <X11/Xlib.h>"
    	alias "XCreatePixmap"
    	end

  	x_get_geometry (d: POINTER; wid: INTEGER;
                  rid, x, y, w, h, brdr, dpth: POINTER) is
    	external "C use <X11/Xlib.h>"
    	alias "XGetGeometry"
    	end

  	x_create_bitmap_from_bits (dp: POINTER; wid: INTEGER; bp: POINTER; w, h: INTEGER): INTEGER is
    	external "C use <X11/Xlib.h>"
  		alias "XCreateBitmapFromData"
  		end

	x_free_pixmap (d: POINTER; wid: INTEGER) is
		external "C use <X11/Xlib.h>"
		alias "XFreePixmap"
		end

end
