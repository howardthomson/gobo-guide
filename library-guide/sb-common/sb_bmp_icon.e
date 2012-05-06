note
	description:"BMP Icon"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Initial stub implementation"

class SB_BMP_ICON

inherit

	SB_ICON
		rename
			make_opts as icon_make_opts
		redefine
			make,
			load_pixels,
			save_pixels
		end

create

	make,
	make_opts

feature -- Creation

	make(a: SB_APPLICATION; pix: ARRAY[INTEGER_8])
			-- Construct icon from memory stream formatted in Microsoft BMP format
		do
			make_opts(a, pix, sbrgb(192,192,192), Zero, 1,1);
		end

	make_opts(a: SB_APPLICATION; pix: ARRAY[INTEGER_8]; clr: INTEGER; opts: INTEGER; w,h: INTEGER)
			-- Construct icon from memory stream formatted in Microsoft BMP format
		local
			ms: SB_BIT8_STREAM;
		do
			icon_make_opts(a, Void, clr, opts & (IMAGE_ALPHA).bit_not, w, h);
			if pix /= Void then
				create ms.make
				ms.open(pix, ms.SB_STREAM_LOAD);
				if ms.code = ms.SB_STREAM_OK then
               		load_pixels(ms);
               		ms.close;
            	end	
         	end
      	end

   	save_pixels(store: SB_STREAM)
         	-- Save pixels into stream formatted in Microsoft BMP format
      	do
         	-- TODO: Implement
      	end


   	load_pixels(store: SB_STREAM)
         	-- Load pixels from stream formatted in Microsoft BMP format
      	local
         	clearcolor: INTEGER;
      	do
         	if (options & IMAGE_OWNED) /= Zero then
            	data := Void;
         	end
         	if bmp_io.load(store) then
            	data := bmp_io.data;
            	clearcolor := bmp_io.clear_color;
            	set_width  (bmp_io.width)
            	set_height (bmp_io.height)
            	if (options & IMAGE_ALPHACOLOR) = Zero then
               		transparent_color := clearcolor;
            	end
            	if (options & IMAGE_ALPHAGUESS) /= Zero then
               		transparent_color := guesstransp;
            	end
            	if transparent_color = 0 then
               		options := options | IMAGE_OPAQUE;
            	end
            	options := options & (IMAGE_ALPHA).bit_not
            	options := options | IMAGE_OWNED
         	end
      	end
end
