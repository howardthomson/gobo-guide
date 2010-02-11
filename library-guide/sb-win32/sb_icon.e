indexing
	description: "[
				An Icon is an image with two additional server-side resources: a shape
				bitmap, which is used to mask those pixels where the background should
				be preserved during the drawing, and a etch bitmap, which is used to
				draw the icon when it is disabled.
				]"
   
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Initial stub implementation"
	platform:	"Win32"

class SB_ICON

inherit

	SB_ICON_DEF
		redefine
			render,
			set_transparent_color,
			resize
		end

creation

	make, make_opts

feature -- not implemented

	resize_imp (w, h: INTEGER) is
		do
		end

feature -- Resource management

	create_resource_imp is
		    -- Create the server side pixmap, the shape bitmap, and the etch bitmap, then 
		    -- call render() to fill it with the pixel data from the client-side buffer.  After the server-
		    -- side pixmap and bitmaps have been created, the client-side pixel buffer will be deleted unless
		    -- IMAGE_KEEP has been specified. If the pixel buffer is not owned, i.e. the flag IMAGE_OWNED 
		    -- is not set, the pixel buffer will not be deleted.
		local
         	hdc: POINTER
         	wapi_dcf: SB_WAPI_DEVICE_CONTEXT_FUNCTIONS
         	wapi_bmp: SB_WAPI_BITMAP_FUNCTIONS
         	wapi_wf: SB_WAPI_WINDOW_FUNCTIONS
         	t: INTEGER
		do
			-- Initialize visual
            visual.create_resource

            -- Create a memory DC compatible with current display
            hdc := wapi_dcf.GetDC (wapi_wf.GetDesktopWindow)
            resource_id := wapi_bmp.CreateCompatibleBitmap (hdc, width.max (1), height.max (1))
            t := wapi_dcf.ReleaseDC (wapi_wf.GetDesktopWindow, hdc)
            if not is_attached then
            	-- todo: report Error
            end

            -- Make shape bitmap
            shape := wapi_bmp.CreateBitmap (width.max (1), height.max (1), 1, 1, default_pointer)
            if shape = default_pointer then
            	-- todo: report Error
            end
               
            -- Make etch bitmap
            etch := wapi_bmp.CreateBitmap (width.max (1), height.max (1), 1, 1, default_pointer)
            if etch = default_pointer then
            	-- todo: report Error
            end
		end

	destroy_resource_imp is
			-- Destroy the server-side pixmap and the shape bitmap and etch bitmap.  
			-- The client-side pixel buffer is not affected.
		local
			wapi_dcf: SB_WAPI_DEVICE_CONTEXT_FUNCTIONS;
			t: INTEGER
		do
			-- Delete shape, etch, and image bitmaps
			t := wapi_dcf.DeleteObject (shape)
			t := wapi_dcf.DeleteObject (etch)
			t := wapi_dcf.DeleteObject (resource_id)
		end

feature -- Actions

   render is
         -- Render the server-side pixmap, shape bitmap and etch bitmap for the icon
         -- from the client-side pixel buffer.  
      do
         if is_attached then
            -- Render the image (color) pixels as usual
            Precursor;
            -- Fill with pixels if there is data
            if data /= Void and then width > 0 and then height > 0 then 
               mem.collection_off
               ext_render (data.area.base_address, width, height, channels,
                          shape,etch, transparent_color, resource_id, options)
               mem.collection_on
            end
         end
      end

   resize (w_, h_: INTEGER) is
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
         if w_ < 1 then
            w := 1
         else
            w := w_
         end
         if h_ < 1 then
            h := 1
         else
            h := h_
         end
         if width /= w or else height /= h then

            	-- Resize device dependent pixmap
            if is_attached then


               	-- Delete old bitmaps
               t := wapi_dcf.DeleteObject (resource_id)
               t := wapi_dcf.DeleteObject (shape)
               t := wapi_dcf.DeleteObject (etch)

               	-- Create a bitmap compatible with current display
               hdc := wapi_dcf.GetDC (wapi_wf.GetDesktopWindow)
               resource_id := wapi_bmp.CreateCompatibleBitmap (hdc, w, h)
               t := wapi_dcf.ReleaseDC (wapi_wf.GetDesktopWindow, hdc)
               if not is_attached then
                  -- todo report Error
               end

               	-- Make shape bitmap
               shape := wapi_bmp.CreateBitmap (w, h, 1, 1, default_pointer)
               if shape = default_pointer then
                  -- todo report Error
               end

               	-- Make etch bitmap
               etch := wapi_bmp.CreateBitmap (w, h, 1, 1, default_pointer)
               if etch = default_pointer then
                  -- todo report Error
               end

            end
            	-- Resize data array iff total size changed
            if data /= Void and then (w*h) /= (width * height) then
               if (options & IMAGE_OWNED) /= Zero then
                  data.resize (1, w * h * channels)
               else
                  create data.make (1, w * h * channels)
                  options := options | IMAGE_OWNED
               end
            end

            	-- Remember new size
            width := w
            height := h
         end
      end

	set_transparent_color (color: INTEGER) is
			-- Change transparency color
		do
			transparent_color := color
		end

feature {NONE} -- External C features

	ext_render (p: POINTER; w, h, ch: INTEGER; sh, etc: POINTER; transp: INTEGER; xid: POINTER; opts: INTEGER_32) is
		external "C"
		alias "sb_icon_render"
		end

end
