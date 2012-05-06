note

	description: "Interface to Xlib's XSetWindowAttributes structure"

	author: "Stephane Hillion"
	copyright: "Copyright (c) 1998-2006, Stephane Hillion and Howard Thomson"
	license: "GNU Public License (see COPYING)"

	C_struct: "[
		typedef struct {
		    Pixmap background_pixmap;		/* background or None or ParentRelative */
		    unsigned long background_pixel;	/* background pixel */
		    Pixmap border_pixmap;			/* border of the window */
		    unsigned long border_pixel;		/* border pixel value */
		    int bit_gravity;				/* one of bit gravity values */
		    int win_gravity;				/* one of the window gravity values */
		    int backing_store;				/* NotUseful, WhenMapped, Always */
		    unsigned long backing_planes;	/* planes to be preseved if possible */
		    unsigned long backing_pixel;	/* value to use in restoring planes */
		    Bool save_under;				/* should bits under be saved? (popups) */
		    long event_mask;				/* set of events that should be saved */
		    long do_not_propagate_mask;		/* set of events that should not propagate */
		    Bool override_redirect;			/* boolean value for override-redirect */
		    Colormap colormap;				/* color map to be associated with window */
		    Cursor cursor;					/* cursor to be displayed (or None) */
		} XSetWindowAttributes;
	]"

class X_SET_WINDOW_ATTRIBUTES

inherit

	X_STRUCT

	X_WINDOW_CONSTANTS

create

	make

feature -- GC Debug

	class_name: STRING
		do
			Result := once "X_SET_WINDOW_ATTRIBUTES"
		end

feature -- mask

	mask: INTEGER

	reset
		do
			mask := 0
		end

feature -- Modification

	set_background_pixmap (p: X_PIXMAP)
    	do
			c_set_background_pixmap (to_external, p.id)
      		mask := mask | Cw_back_pixmap
		end

	set_background_pixel (i: INTEGER)
    	do
    		c_set_background_pixel (to_external, i)
      		mask := mask | Cw_back_pixel
    	end

  	set_border_pixmap (p: X_PIXMAP)
    	do
    		c_set_border_pixmap (to_external, p.id)
      		mask := mask | Cw_border_pixmap
    	end

  	set_border_pixel (i: INTEGER)
    	do
    		c_set_border_pixel (to_external, i)
      		mask := mask | Cw_border_pixel
    	end

  	set_bit_gravity (i: INTEGER)
    	do
    		c_set_bit_gravity (to_external, i)
      		mask := mask | Cw_bit_gravity
    	end

  	set_win_gravity (i: INTEGER)
    	do
      		c_set_win_gravity (to_external, i)
      		mask := mask | Cw_win_gravity
    	end

  	set_backing_store (i : INTEGER)
    	do
      		c_set_backing_store (to_external, i)
      		mask := mask | Cw_backing_store
    	end

  	set_backing_planes (i : INTEGER)
    	do
      		c_set_backing_planes (to_external, i)
      		mask := mask | Cw_backing_planes
    	end

  	set_backing_pixel (i : INTEGER)
    	do
      		c_set_backing_pixel (to_external, i)
      		mask := mask | Cw_backing_pixel
    	end

  	set_save_under (b: BOOLEAN)
  		local
  			v: INTEGER
    	do
    		if b then
    			v := 1 -- else v := 0
    		end
			c_set_save_under (to_external, v)
      		mask := mask | Cw_save_under
    	end

  	set_event_mask (m: INTEGER)
    	do
    		c_set_event_mask (to_external, m)
      		mask := mask | Cw_event_mask
    	end

  	set_do_not_propagate_mask (m: INTEGER)
    	do
      		c_set_do_not_propagate_mask (to_external, m)
      		mask := mask | Cw_do_not_propagate
		end

  	set_override_redirect (b: BOOLEAN)
  		local
  			v: INTEGER
    	do
    		if b then
    			v := 1 -- else v := 0
    		end
      		c_set_override_redirect (to_external, v)
      		mask := mask | Cw_override_redirect
    	end

  	set_colormap (a_colormap: X_COLORMAP)
    	do
      		c_set_colormap (to_external, a_colormap.id)
      		mask := mask | Cw_colormap
    	end

  	set_cursor (a_cursor: X_CURSOR)
    	do
      		c_set_cursor (to_external, a_cursor.id)
      		mask := mask | Cw_cursor
    	end

feature { NONE }

--	size: INTEGER is 60	-- TODO (probably) not 64-bit portable!

	size: INTEGER
		external
			"C macro use <X11/Xlib.h>"
		alias
			"sizeof(XSetWindowAttributes)"
		end

	c_set_background_pixmap		(p: POINTER; v: INTEGER) external "C struct XSetWindowAttributes access background_pixmap     type Pixmap use <X11/Xlib.h>"	end
	c_set_background_pixel		(p: POINTER; v: INTEGER) external "C struct XSetWindowAttributes access background_pixel      type unsigned long use <X11/Xlib.h>"	end
	c_set_border_pixmap			(p: POINTER; v: INTEGER) external "C struct XSetWindowAttributes access border_pixmap         type Pixmap use <X11/Xlib.h>"	end
	c_set_border_pixel			(p: POINTER; v: INTEGER) external "C struct XSetWindowAttributes access border_pixel        	 type unsigned long use <X11/Xlib.h>"	end
	c_set_bit_gravity			(p: POINTER; v: INTEGER) external "C struct XSetWindowAttributes access bit_gravity        	 type int use <X11/Xlib.h>"	end
	c_set_win_gravity			(p: POINTER; v: INTEGER) external "C struct XSetWindowAttributes access win_gravity        	 type int use <X11/Xlib.h>"	end
	c_set_backing_store			(p: POINTER; v: INTEGER) external "C struct XSetWindowAttributes access backing_store         type int use <X11/Xlib.h>"	end
	c_set_backing_planes		(p: POINTER; v: INTEGER) external "C struct XSetWindowAttributes access backing_planes        type unsigned long use <X11/Xlib.h>"	end
	c_set_backing_pixel			(p: POINTER; v: INTEGER) external "C struct XSetWindowAttributes access backing_pixel         type unsigned long use <X11/Xlib.h>"	end
	c_set_save_under			(p: POINTER; v: INTEGER) external "C struct XSetWindowAttributes access save_under            type Bool use <X11/Xlib.h>"	end
	c_set_event_mask			(p: POINTER; v: INTEGER) external "C struct XSetWindowAttributes access event_mask            type long use <X11/Xlib.h>"	end
	c_set_do_not_propagate_mask	(p: POINTER; v: INTEGER) external "C struct XSetWindowAttributes access do_not_propagate_mask type long use <X11/Xlib.h>"	end
	c_set_override_redirect		(p: POINTER; v: INTEGER) external "C struct XSetWindowAttributes access override_redirect     type Bool use <X11/Xlib.h>"	end
	c_set_colormap				(p: POINTER; v: INTEGER) external "C struct XSetWindowAttributes access colormap              type Colormap use <X11/Xlib.h>"	end
	c_set_cursor				(p: POINTER; v: INTEGER) external "C struct XSetWindowAttributes access cursor                type Cursor use <X11/Xlib.h>"	end

end
