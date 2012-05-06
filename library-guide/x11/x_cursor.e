note

	description: "Interface to Xlib's Cursor resource."

	author: "Stephane Hillion"
	copyright: "Copyright (c) 1998-2006, Stephane Hillion and Howard Thomson"
	license: "GNU Public License (see COPYING)"

class X_CURSOR

inherit

	ANY -- For ISE ??

  	X_RESOURCE
	X_CURSOR_DEFINES

create

	make,
	from_glyph,
	from_pixmap,
	from_external

create { X_GLOBAL }

	make_special

feature {NONE} -- Creation

	make (disp: X_DISPLAY; type: INTEGER)
			-- Creates a standard cursor from its glyph number `type'
		require
			disp /= Void
		do
			display := disp
			id := x_create_font_cursor (display.to_external, type)
		end

	from_glyph (disp: X_DISPLAY; f_font, m_font: X_FONT;
			f_glyph, m_glyph: INTEGER; cf, cm: X_COLOR)
			-- Creates a cursor from a font glyph
		require
			disp   /= Void
			f_font /= Void
			m_font /= Void
			cf     /= Void
			cm     /= Void
		do
			display := disp
			id := x_create_glyph_cursor (display.to_external, f_font.id,
					m_font.id, f_glyph, m_glyph,
					cf.to_external, cm.to_external)
		end

	from_pixmap (disp : X_DISPLAY; f_pix, m_pix : X_PIXMAP;
    				cf, cm : X_COLOR; xhot, yhot : INTEGER)
			-- Creates a cursor from a pixmap.
			-- `field' pixel of cf and cm is ignored
		require
			disp   /= Void
      		f_pix  /= Void
      		m_pix  /= Void
     		cf     /= Void
			cm     /= Void
		do
			display := disp
			id      := x_create_pixmap_cursor (display.to_external, f_pix.id,
            				m_pix.id, cf.to_external, cm.to_external, xhot, yhot)
		end

  	from_external (disp : X_DISPLAY; cid : INTEGER)
    	require
      		disp /= Void
    	do
      		display := disp
      		id      := cid
    	end

  	make_special (xid : INTEGER)
    	do
      		id := xid
    	end

feature -- Destruction

	free
    		-- deletes the association between the cursor resource ID and the cursor.
    	do
      		x_free_cursor (display.to_external, id)
    	end

feature

	recolor (fcol, bcol: X_COLOR)
    		-- changes the color of the cursor, and if the cursor is being
    		-- displayed on a screen, the change is visible immediately.
    	do
      		x_recolor_cursor (display.to_external, id, fcol.to_external,
            		bcol.to_external)
		end

	query_best_cursor (d : X_DRAWABLE; w, h : INTEGER)
    		-- returns the largest cursor's size that can be displayed.
		do
    		x_query_best_cursor (display.to_external, d.id, w, h,
				$last_width, $last_height)
		end

	last_width  : INTEGER
	last_height : INTEGER


feature {NONE} -- External function

--#####################################################################

  	x_create_font_cursor (d : POINTER; type : INTEGER) : INTEGER
    	external "C use <X11/Xlib.h>"
    	alias "XCreateFontCursor"
    	end

  	x_create_glyph_cursor (d : POINTER; sf, mf, sg, mg : INTEGER;
                         sc, mc : POINTER) : INTEGER
    	external "C use <X11/Xlib.h>"
    	alias "XCreateGlyphCursor"
    	end

  	x_create_pixmap_cursor (d : POINTER; sp, mp : INTEGER;
                          sc, mc : POINTER; xh, yh : INTEGER) : INTEGER
    	external "C use <X11/Xlib.h>"
    	alias "XCreatePixmapCursor"
    	end

  	x_free_cursor (d : POINTER; rid : INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XFreeCursor"
    	end

  	x_recolor_cursor (d : POINTER; rid : INTEGER; fc, bc : POINTER)
    	external "C use <X11/Xlib.h>"
    	alias "XRecolorCursor"
    	end

  	x_query_best_cursor (d : POINTER; did, w, h : INTEGER; wr, hr : POINTER)
    	external "C use <X11/Xlib.h>"
    	alias "XQueryBestCursor"
    	end

end
