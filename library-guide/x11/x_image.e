note

	description: "Implementation of Xlib's XImage"

	author: "Stephane Hillion"
	copyright: "Copyright (c) 1998-2006, Stephane Hillion and Howard Thomson"
	license: "Eiffel Forum License v2 (see forum.txt)"

class X_IMAGE

inherit

	X_GLOBAL
		rename
	--		x_alloc as xxx1,
			x_free as xxx2
		end

create

	make_pointer

feature {NONE} -- Initialization

	make_pointer(
			disp			: X_DISPLAY;
			visual			: X_VISUAL;
			a_depth,
			a_format,
			a_offset		: INTEGER;
			p				: POINTER;		-- dta: C_VECTOR [C_BYTE];
			wdth,
			hght,
			a_bitmap_pad,
			a_bytes_per_line : INTEGER)
      		-- Allocates the memory needed for an XImage structure for the
      		-- specified display
    	require
      		disp   /= Void
      		visual /= Void
      	--	dta   /= Void
    	do
      		display     := disp
      		to_external := x_create_image (display.to_external,
				     visual.to_external,
				     a_depth,
				     a_format,
				     a_offset,
				     p,
				     wdth,
				     hght,
				     a_bitmap_pad,
				     a_bytes_per_line)
    	end

feature -- Access

	to_external: POINTER	-- External representation

	display: X_DISPLAY

  	width: INTEGER
      		-- Width in pixels
    	require
      		to_external /= default_pointer
    	do
      		Result := c_width (to_external)
    	end

  	height: INTEGER
      		-- Height in pixels
    	require
      		to_external /= default_pointer
    	do
      		Result := c_height (to_external)
    	end

    xoffset: INTEGER
    	do
    		Result := c_xoffset (to_external)
    	end

    format: INTEGER
    		-- Bits format: XYbitmap/XYpixmap/Zpixmap
    	require
    		to_external /= default_pointer
    	do
    		Result := c_format (to_external)
    	end

--	set_data (new_data: like save_data) is
--		do
--			c_set_data (to_external, new_data.to_pointer)
--			save_data := new_data
--		end

    set_data (new_data: POINTER)	-- p: POINTER) is
    	do
    		c_set_data (to_external, new_data)
    	--	save_data := new_data
    	end

    byte_order: INTEGER
    	do
    		Result := c_byte_order (to_external)
    	end

    bitmap_unit: INTEGER
    	do
    		Result := c_bitmap_unit (to_external)
    	end

    bitmap_bit_order: INTEGER
    	do
    		Result := c_bitmap_bit_order (to_external)
    	end

    bitmap_pad: INTEGER
    	do
    		Result := c_bitmap_pad (to_external)
    	end

    depth: INTEGER
    		-- Image depth: bits per pixel
    	require
    		to_external /= default_pointer
    	do
    		Result := c_depth (to_external)
    	end

    bytes_per_line: INTEGER
    	do
    		Result := c_bytes_per_line (to_external)
    	end

    bits_per_pixel: INTEGER
    	do
    		Result := c_bits_per_pixel (to_external)
    	end

    red_mask: INTEGER
    	do
    		Result := c_red_mask (to_external)
    	end

    green_mask: INTEGER
    	do
    		Result := c_green_mask (to_external)
    	end

    blue_mask: INTEGER
    	do
    		Result := c_blue_mask (to_external)
    	end

    data: POINTER
        	do
        		Result := c_data (to_external)
        	end

feature -- Get/Put Pixel

	put_pixel (x, y: INTEGER; pixel: INTEGER)
		do
--			check false end
			x_put_pixel (to_external, x, y, pixel)
		end

feature -- Image format

	Xy_bitmap : INTEGER = 0
	Xy_pixmap : INTEGER = 1
	Z_pixmap  : INTEGER = 2

feature {NONE} -- Private

	data_count: INTEGER

feature {SB_IMAGE} -- External functions TEMPORARY!

	x_alloc(n: INTEGER): POINTER
		external "C use <X11/Xlibint.h>"
		alias "Xmalloc"
		end

	x_free(p: POINTER)
		external "C use <X11/Xlibint.h>"
		alias "XFree"
		end

feature {NONE} -- External functions

	x_put_pixel(p: POINTER; x,y: INTEGER; pix: INTEGER)
		external "C signature (XImage*, int, int, int) use <X11/Xutil.h>"
		alias "XPutPixel"
		end

	x_create_image (dsp, vis : POINTER; d, f, o : INTEGER; dt : POINTER;
		  w, h, bp, bpl : INTEGER) : POINTER
		external "C use <X11/Xlib.h>"
    	alias "XCreateImage"
    	end

	c_width					(p: POINTER): INTEGER external "C struct XImage access width use <X11/Xlib.h>"				end --
	c_height				(p: POINTER): INTEGER external "C struct XImage access height use <X11/Xlib.h>"				end -- size of image */
	c_xoffset				(p: POINTER): INTEGER external "C struct XImage access xoffset use <X11/Xlib.h>"			end	-- number of pixels offset in X direction */
	c_format				(p: POINTER): INTEGER external "C struct XImage access format use <X11/Xlib.h>"				end	-- XYBitmap, XYPixmap, ZPixmap */
	c_data					(p: POINTER): POINTER external "C struct XImage access data use <X11/Xlib.h>"				end -- pointer to image data */
	c_byte_order			(p: POINTER): INTEGER external "C struct XImage access byte_order use <X11/Xlib.h>"			end -- data byte order, LSBFirst, MSBFirst */
	c_bitmap_unit			(p: POINTER): INTEGER external "C struct XImage access bitmap_unit use <X11/Xlib.h>"		end -- quant. of scanline 8, 16, 32 */
	c_bitmap_bit_order		(p: POINTER): INTEGER external "C struct XImage access bitmap_bit_order use <X11/Xlib.h>"	end -- LSBFirst, MSBFirst */
	c_bitmap_pad			(p: POINTER): INTEGER external "C struct XImage access bitmap_pad use <X11/Xlib.h>"			end -- 8, 16, 32 either XY or ZPixmap */
	c_depth					(p: POINTER): INTEGER external "C struct XImage access depth use <X11/Xlib.h>"				end -- depth of image */
	c_bytes_per_line		(p: POINTER): INTEGER external "C struct XImage access bytes_per_line use <X11/Xlib.h>"		end -- accelarator to next line */
	c_bits_per_pixel		(p: POINTER): INTEGER external "C struct XImage access bits_per_pixel use <X11/Xlib.h>"		end -- bits per pixel (ZPixmap) */
	c_red_mask				(p: POINTER): INTEGER external "C struct XImage access red_mask use <X11/Xlib.h>"			end -- bits in z arrangment */
	c_green_mask			(p: POINTER): INTEGER external "C struct XImage access green_mask use <X11/Xlib.h>"			end
	c_blue_mask				(p: POINTER): INTEGER external "C struct XImage access blue_mask use <X11/Xlib.h>"			end

	c_set_width				(p: POINTER; i: INTEGER) external "C struct XImage access width            type int    use <X11/Xlib.h>"	end --
	c_set_height			(p: POINTER; i: INTEGER) external "C struct XImage access height           type int    use <X11/Xlib.h>"	end -- size of image */
	c_set_xoffset			(p: POINTER; i: INTEGER) external "C struct XImage access xoffset          type int    use <X11/Xlib.h>"	end	-- number of pixels offset in X direction */
	c_set_format			(p: POINTER; i: INTEGER) external "C struct XImage access format           type int    use <X11/Xlib.h>"	end	-- XYBitmap, XYPixmap, ZPixmap */
	c_set_data				(p: POINTER; d: POINTER) external "C struct XImage access data             type char * use <X11/Xlib.h>"	end -- pointer to image data */
	c_set_byte_order		(p: POINTER; i: INTEGER) external "C struct XImage access byte_order       type int    use <X11/Xlib.h>"	end -- data byte order, LSBFirst, MSBFirst */
	c_set_bitmap_unit		(p: POINTER; i: INTEGER) external "C struct XImage access bitmap_unit      type int    use <X11/Xlib.h>"	end -- quant. of scanline 8, 16, 32 */
	c_set_bitmap_bit_order	(p: POINTER; i: INTEGER) external "C struct XImage access bitmap_bit_order type int    use <X11/Xlib.h>"	end -- LSBFirst, MSBFirst */
	c_set_bitmap_pad		(p: POINTER; i: INTEGER) external "C struct XImage access bitmap_pad       type int    use <X11/Xlib.h>"	end -- 8, 16, 32 either XY or ZPixmap */
	c_set_depth				(p: POINTER; i: INTEGER) external "C struct XImage access depth            type int    use <X11/Xlib.h>"	end -- depth of image */
	c_set_bytes_per_line	(p: POINTER; i: INTEGER) external "C struct XImage access bytes_per_line   type int    use <X11/Xlib.h>"	end -- accelarator to next line */
	c_set_bits_per_pixel	(p: POINTER; i: INTEGER) external "C struct XImage access bits_per_pixel   type int    use <X11/Xlib.h>"	end -- bits per pixel (ZPixmap) */

	c_set_red_mask			(p: POINTER; i: INTEGER) external "C struct XImage access red_mask    type unsigned long use <X11/Xlib.h>"	end -- bits in z arrangment */
	c_set_green_mask		(p: POINTER; i: INTEGER) external "C struct XImage access green_mask  type unsigned long use <X11/Xlib.h>"	end
	c_set_blue_mask			(p: POINTER; i: INTEGER) external "C struct XImage access blue_mask   type unsigned long use <X11/Xlib.h>"	end


end
