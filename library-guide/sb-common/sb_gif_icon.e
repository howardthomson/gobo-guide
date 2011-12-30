indexing
	description:"GIF Icon"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Initial stub implementation"

	todo: "[
		Fix bug in or called from 'load_pixels', probably in SB_BIT8_STREAM
	]"

class SB_GIF_ICON

inherit

	SB_ICON
		rename
        	make_opts as icon_make_opts
      	redefine
         	make,
         	load_pixels,
         	save_pixels
      	end

creation

   	make,
   	make_opts

feature -- Creation

   	make(a: SB_APPLICATION; pix: ARRAY [ INTEGER_8 ]) is
         	-- Construct an icon from memory stream formatted as CompuServe GIF 
         	-- format
      	do
         	make_opts (a, pix, sbrgb (192,192,192), Zero, 1, 1)
      	end

	make_opts (a: SB_APPLICATION; pix: ARRAY[INTEGER_8]; clr: INTEGER; opts: INTEGER; w,h: INTEGER) is
    		-- Construct an icon from memory stream
    		-- formatted as CompuServe GIF format
      	local
         	ms: SB_BIT8_STREAM;
      	do
        	icon_make_opts (a, Void, clr, opts & (IMAGE_ALPHA).bit_not, w, h)
        	if pix /= Void then
            	create ms.make
            	ms.open (pix, ms.SB_STREAM_LOAD)
            	if ms.code = ms.SB_STREAM_OK then
					load_pixels (ms)
            	end
         	end
      	end

   save_pixels (store: SB_STREAM) is
         -- Save pixels into stream in [un]GIF format
      do
         -- TODO: Implement
      end


   load_pixels (store: SB_STREAM) is
         -- Load pixels from stream in CompuServe GIF format
      local
         gio: SB_GIF_IO
         clearcolor: INTEGER
      do
         data := Void
         create gio
         if gio.load (store) then
            data := gio.data
            clearcolor := gio.clear_color
            set_width (gio.width)
            set_height (gio.height)
            if (options & IMAGE_ALPHACOLOR) = Zero then
               transparent_color := clearcolor
            end
            if (options & IMAGE_ALPHAGUESS) /= Zero then
               transparent_color := guesstransp
            end
            if transparent_color = 0 then
               options := options | IMAGE_OPAQUE
            end
            options := options & (IMAGE_ALPHA).bit_not
            options := options | IMAGE_OWNED
	--	 	fx_trace(0, <<"SB_GIF_ICON::load_pixels - load OK",
	--	 		"%N%T width : ", width.out,
	--	 		"%N%T height: ", height.out,
	--	 		"%N%T transparent_color: ", transparent_color.out
	--	 	>>)
         else
		 	fx_trace(0, <<"SB_GIF_ICON::load_pixels - load FAILED">>)

         end
	end
end
