indexing
   	description: "Visual describes pixel format of a drawable"
   	author: "Eugene Melekhov <eugene_melekhov@mail.ru>"
   	copyright: "Copyright (c) 2002, Eugene Melekhov and others"
   	license: "Eiffel Forum Freeware License v2 (see forum.txt)"
   	status: "Partly complete"

class SB_VISUAL

inherit

	SB_VISUAL_DEF

	SB_DEFS

creation

   make

feature -- Creation

	make_imp is
		do
			hPalette := default_pointer
			pixel_format := 0
		end

	create_resource_imp is
    		-- Create resource
		local
			hdc: POINTER
			nPlanes, nBitsPixel: INTEGER
			t: INTEGER_32
			t1: INTEGER
		do
             	-- Check for palette support
             hdc := wapi_dcf.GetDC (wapi_wf.GetDesktopWindow)

             t := (wapi_dcf.GetDeviceCaps (hdc, wapi_dp.RASTERCAPS))

             if (t & wapi_rc.RC_PALETTE) /= Zero then
                depth := wapi_dcf.GetDeviceCaps (hdc, wapi_dp.COLORRES)
                if depth <= 8 then
                    hPalette := create_all_purpose_palette
                    type := VISUALTYPE_INDEX
                elseif depth = 16 then
                    red_count := 32
                    green_count := 64
                    blue_count := 32
                    type := VISUALTYPE_TRUE
                elseif depth = 15 then
                    red_count := 32
                    green_count := 32
                    blue_count := 32
                    type := VISUALTYPE_TRUE
                elseif depth >= 24 then
                    red_count := 256
                    green_count := 256
                    blue_count := 256
                	type := VISUALTYPE_TRUE
            	end
            else
                nPlanes := wapi_dcf.GetDeviceCaps (hdc, wapi_dp.PLANES)
                nBitsPixel := wapi_dcf.GetDeviceCaps (hdc, wapi_dp.BITSPIXEL)
                depth := (1).bit_shift_left (nPlanes * nBitsPixel).to_integer_8
            	type := VISUALTYPE_UNKNOWN
            end
            color_count := red_count * green_count * blue_count
            t1 := wapi_dcf.ReleaseDC (wapi_wf.GetDesktopWindow, hdc)
            	-- This is just a placeholder
        	resource_id := default_pointer + 1
		end

	destroy_resource_imp is
			-- Destroy resource
		local
         	t: INTEGER
      	do
        	-- Delete palette
            if hPalette /= default_pointer then
            	t := wapi_dcf.DeleteObject (hPalette)
            	hPalette := default_pointer
            end
      	end

feature

   pixel (clr: INTEGER): INTEGER is
         -- Get device pixel value for color
      do
         Result := wapi_wmc.PALETTERGB (sbredval (clr), sbgreenval (clr), sbblueval (clr))
      end

   color (pix: INTEGER): INTEGER is
         -- Get color value for device pixel value
      do
         Result := wapi_wmc.PALETTEINDEX (pix)
      end

feature {ANY} -- Implementation

	hPalette: POINTER
			-- Palette, if any

	pixel_format: INTEGER
			-- PIXELFORMAT number

	create_all_purpose_palette: POINTER is
		external "C"
		alias "sb_visual_create_palette"
		end

feature {NONE} -- SB_WAPI functions

	wapi_dcf: SB_WAPI_DEVICE_CONTEXT_FUNCTIONS
	wapi_dp	: SB_WAPI_DEVICE_PARAMETERS
	wapi_rc	: SB_WAPI_RASTER_CAPABILITIES
	wapi_wf	: SB_WAPI_WINDOW_FUNCTIONS
	wapi_wmc: SB_WAPI_MACRO

end
