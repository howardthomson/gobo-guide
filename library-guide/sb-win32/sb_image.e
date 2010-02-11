-- Win32 Implementation

class SB_IMAGE

inherit

	SB_IMAGE_DEF
		redefine
			get_dc,
			release_dc
		end

	SB_NOT_IMPLEMENTED
	SB_EXPANDED

creation

	make, make_opts

feature

   restore is
         -- Retrieves pixels from the server-side image.  For example, to make
         -- screen snapshots, or to retrieve an image after it has been drawin
         -- into by various means.
      require else
         width >= 1 and height >= 1
      local
         size, bytes_per_line, skip, x,y: INTEGER
         bmi: SB_WAPI_BITMAPINFOHEADER
         pixels: ARRAY[INTEGER_8]
         i,j: INTEGER
         wapi_dcf: SB_WAPI_DEVICE_CONTEXT_FUNCTIONS
         wapi_bmp: SB_WAPI_BITMAP_FUNCTIONS
         wapi_ci: SB_WAPI_DIB_COLOR_IDENTIFIERS
         wapi_bcm: SB_WAPI_BITMAP_COMPRESSION_MODES
         hdcmem: POINTER
         t: INTEGER
      do
         if is_attached then
            --  Make array for data if needed
            if data = Void or else (options & IMAGE_OWNED) = Zero then
               size := width * height * channels
               create data.make (1, width * height * 3)
               options := options | IMAGE_OWNED
            end

            if data /= Void then
               -- Got local buffer to receive into
               -- Set up the bitmap info
               bytes_per_line := ((width * 3 + 3) // 4) * 4
               skip := bytes_per_line - width * 3
               create bmi.make
               bmi.set_biWidth (width)
               bmi.set_biHeight (- height) -- Negative heights means upside down!
               bmi.set_biPlanes (1)
               bmi.set_biBitCount (24)
               bmi.set_biCompression (wapi_bcm.BI_RGB)
               bmi.set_biSizeImage (0)
               bmi.set_biXPelsPerMeter (0)
               bmi.set_biYPelsPerMeter (0)
               bmi.set_biClrUsed (0)
               bmi.set_biClrImportant (0)

               -- DIB format pads to multiples of 4 bytes...
               create pixels.make (1, bytes_per_line * height)

               -- Make device context
               hdcmem := wapi_dcf.CreateCompatibleDC (default_pointer)
               mem.collection_off
               t := wapi_bmp.GetDIBits (hdcmem, resource_id, 0, height, pixels.area.base_address, bmi.ptr,
                                       wapi_ci.DIB_RGB_COLORS)
               mem.collection_on
               if t = 0 then
                  -- todo: Report error
               end

               -- Stuff it into our own data structure
               from
                  y := 0
                  i := data.lower
                  j := 1
               until
                  y >= height
               loop
                  from
                     x := 0
                  until
                     x >= width
                  loop
                     data.put(pixels.item (j + 2), i)
                     data.put(pixels.item (j + 1), i + 1)
                     data.put(pixels.item (j), i + 2)
                     i := i + channels
                     j := j + 3
                     x := x + 1
                  end
                  j := j + skip
                  y := y + 1
               end
               t := wapi_dcf.DeleteDC (hdcmem)
            end
         end
      end

   render is
         -- Render the server-side representation of the image from client-side
         -- pixels.  Normally, IMAGE_DITHER is used which causes the server-side
         -- representation to be rendered using a 16x16 ordered dither if necessary;
         -- however if IMAGE_NEAREST is used a faster (but uglier-looking), nearest
         -- neighbor algorithm is used.  
      require else
         width >= 1 and height >= 1
      local
         bytes_per_line, skip, w, h: INTEGER
         bmi: SB_WAPI_BITMAPINFOHEADER
         pixels: ARRAY[INTEGER_8]
         i, j: INTEGER
         wapi_dcf: SB_WAPI_DEVICE_CONTEXT_FUNCTIONS
         wapi_bmp: SB_WAPI_BITMAP_FUNCTIONS
         wapi_ci: SB_WAPI_DIB_COLOR_IDENTIFIERS
         wapi_bcm: SB_WAPI_BITMAP_COMPRESSION_MODES
         wapi_pf: SB_WAPI_PAINTING_AND_DRAWING_FUNCTIONS
         hdcmem: POINTER
         t: INTEGER
         t1: POINTER
         t2: INTEGER_32
      do
         if is_attached then
            -- Fill with pixels if there is data
            if data /= Void and then width > 0 and then height > 0 then 
               create bmi.make
               bmi.set_biWidth (width)
               bmi.set_biHeight (height)
               bmi.set_biPlanes (1)
               bmi.set_biBitCount (24)
               bmi.set_biCompression (wapi_bcm.BI_RGB)
               bmi.set_biSizeImage (0)
               bmi.set_biXPelsPerMeter (0)
               bmi.set_biYPelsPerMeter (0)
               bmi.set_biClrUsed (0)
               bmi.set_biClrImportant (0)

               -- DIB format pads to multiples of 4 bytes...
               t2 := (width * 3 + 3)
               bytes_per_line := t2 & (0x00000003).bit_not
               skip := bytes_per_line + width * 3
               create pixels.make (1, bytes_per_line * height)
               from
                  h := height - 1
                  i := data.lower
                  j := h * bytes_per_line + 1
               until
                  h < 0
               loop
                  from
                     w := width - 1
                  until
                     w < 0
                  loop
                     pixels.put(data.item (i+2), j)
                     pixels.put(data.item (i+1), j + 1)
                     pixels.put(data.item (i), j + 2)
                     i := i + channels
                     j := j + 3
                     w := w - 1
                  end
                  j := j - skip
                  h := h - 1
               end

               -- The MSDN documentation for SetDIBits() states that "the device context
               -- identified by the (first) parameter is used only if the DIB_PAL_COLORS
               -- constant is set for the (last) parameter". This may be true, but under
               -- Win95 you must pass in a non-NULL hdc for the first parameter; otherwise
               -- this call to SetDIBits() will fail (in contrast, it works fine under
               -- Windows NT if you pass in a NULL hdc).
               hdcmem := wapi_dcf.CreateCompatibleDC (default_pointer)
               mem.collection_off
               t := wapi_bmp.SetDIBits (hdcmem, resource_id, 0, height, pixels.area.base_address, bmi.ptr,
                                     wapi_ci.DIB_RGB_COLORS)
               mem.collection_on
               if t = 0 then
                  -- todo: report error
               end
               t := wapi_pf.GdiFlush
               t := wapi_dcf.DeleteDC (hdcmem)
            end
         end
      end

	create_resource_imp is
         	-- Create the server side pixmap, then call render() to fill it with the
         	-- pixel data from the client-side buffer.  After the server-side image has 
         	-- been created, the client-side pixel buffer will be deleted unless 
         	-- IMAGE_KEEP has been specified.  If the pixel buffer is not owned, i.e.
         	-- the flag IMAGE_OWNED is not set, the pixel buffer will not be deleted.
      	require else
         	application /= Void
      	local
         	wapi_dcf: SB_WAPI_DEVICE_CONTEXT_FUNCTIONS
         	wapi_wf: SB_WAPI_WINDOW_FUNCTIONS
         	wapi_bmp: SB_WAPI_BITMAP_FUNCTIONS
         	hdc: POINTER
         	t: INTEGER
      	do
			-- Initialize visual
            visual.create_resource
            -- Create a bitmap compatible with current display
            hdc := wapi_dcf.GetDC (wapi_wf.GetDesktopWindow)
            resource_id := wapi_bmp.CreateCompatibleBitmap (hdc, width.max (1), height.max (1))
            t := wapi_dcf.ReleaseDC (wapi_wf.GetDesktopWindow, hdc)
			if not is_attached then
            	-- todo: Report error
        	end
		end

   	destroy_resource_imp is
         	-- Destroy the server-side pixmap.  
         	-- The client-side pixel buffer is not affected.
      	local
         	wapi_dcf: SB_WAPI_DEVICE_CONTEXT_FUNCTIONS
         	t: INTEGER
      	do
        	-- Delete bitmap
            t := wapi_dcf.DeleteObject (resource_id)
      	end

feature -- Transformation

	resize_imp (w_, h_: INTEGER) is
         	-- Resize both client-side and server-side representations (if any) to the 
         	-- given width and height.  The new representations typically contain garbage
         	-- after this operation and need to be re-filled.
      	local
         	w, h: INTEGER
         	wapi_dcf: SB_WAPI_DEVICE_CONTEXT_FUNCTIONS
         	wapi_bmp: SB_WAPI_BITMAP_FUNCTIONS
         	wapi_wf: SB_WAPI_WINDOW_FUNCTIONS
         	hdc: POINTER
         	t: INTEGER
      	do
        	t := wapi_dcf.DeleteObject (resource_id)
            hdc := wapi_dcf.GetDC (wapi_wf.GetDesktopWindow)
            resource_id := wapi_bmp.CreateCompatibleBitmap (hdc, w, h)
            t := wapi_dcf.ReleaseDC (wapi_wf.GetDesktopWindow, hdc)
            if not is_attached then
            	-- todo: report error
            end
      	end

feature {SB_DC} -- Implementation

	get_dc: POINTER is
		local
         	wapi_dcf: SB_WAPI_DEVICE_CONTEXT_FUNCTIONS
         	wapi_wf: SB_WAPI_WINDOW_FUNCTIONS
         	t: POINTER
      	do
         	Result := wapi_dcf.CreateCompatibleDC (default_pointer)
         	t := wapi_dcf.SelectObject (Result, resource_id)
      	end

   	release_dc (dc: POINTER): INTEGER is
      	local
         	wapi_dcf: SB_WAPI_DEVICE_CONTEXT_FUNCTIONS
      	do
         	Result := wapi_dcf.DeleteDC (dc)
      	end

end