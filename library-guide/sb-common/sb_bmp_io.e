indexing
	description:"BMP input/output"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Initial stub implementation"

	todo: "[
		replace c_inline_c code for GEC compatible compilation
		
		Edit for consistent access to int8/int16/int32 values
		Remove BIT values
	]"

class SB_BMP_IO

inherit

	SB_COMMON_MACROS

	SB_DEFS

	SB_EXPANDED

feature -- Data

	data: ARRAY [ INTEGER_8 ]

	width: INTEGER
	height: INTEGER

	clear_color: INTEGER

feature -- Actions

	load(store: SB_STREAM): BOOLEAN is
			-- Load image from stream
		local
			c1, c2: INTEGER;
			bfSize, bfOffBits, biSize, biWidth, biHeight, biPlanes,
			biBitCount, biCompression, biSizeImage, biXPelsPerMeter,
			biYPelsPerMeter, biClrUsed, biClrImportant,bPad,maxpixels: INTEGER;
			i, j, ix, ok, cmaplen: INTEGER;
			colormap: ARRAY [INTEGER_8];
			error: BOOLEAN;
		do
			if not error then
				-- Check signature
			--	fx_trace(0, <<"SB_BM_IO::load -- About to read first byte" >>)
				c1 := store.read_uint8;
				c2 := store.read_uint8;

				if c1 /= 66 or else c2 /= 77 then	-- "bm"
			--		fx_trace(0, <<"SB_BM_IO::load -- Not 'bm': ", c1.out, " ", c2.out >>)
					sb_exceptions.raise("loadbmp");
				else
			--		fx_trace(0, <<"SB_BM_IO::load -- 'bm' OK" >>)
				end

				-- Get size and offset
				bfSize := read32(store);
				c1 := read16(store);
				c1 := read16(store);
				bfOffBits := read32(store);
				biSize := read32(store);

				if biSize = WIN_NEW or else biSize = OS2_NEW then
					-- New bitmap format
					biWidth         := read32(store);
					biHeight        := read32(store);
					biPlanes        := read16(store);
					biBitCount      := read16(store);
					biCompression   := read32(store);
					biSizeImage     := read32(store);
               		biXPelsPerMeter := read32(store);
               		biYPelsPerMeter := read32(store);
               		biClrUsed       := read32(store);
               		biClrImportant  := read32(store);
            	else
               		-- Old format
               		biWidth         := read16(store);
               		biHeight        := read16(store);
               		biPlanes        := read16(store);
               		biBitCount      := read16(store);

               		-- Not in old versions so have to compute them
               		biSizeImage := (((biPlanes * biBitCount * biWidth) + 31) // 32) * 4 * biHeight;
               		biCompression   := BIH_RGB;
               		biXPelsPerMeter := 0;
               		biYPelsPerMeter := 0;
               		biClrUsed       := 0;
               		biClrImportant  := 0;
            	end

			--	fx_trace(0, <<"SB_BMP_IO::load -- ",
			--		"%N%T bfOffBits      : ", bfOffBits.out,
			--		"%N%T bfSize         : ", bfSize.out,
			--		"%N%T bfOffBits      : ", bfOffBits.out,
			--		"%N%T biSize         : ", biSize.out,
			--		"%N%T biWidth        : ", biWidth.out,
			--		"%N%T biHeight       : ", biHeight.out,
			--		"%N%T biPlanes       : ", biPlanes.out,
			--		"%N%T biBitCount     : ", biBitCount.out,
			--		"%N%T biCompression  : ", biCompression.out,
			--		"%N%T biSizeImage    : ", biSizeImage.out,
			--		"%N%T biXPelsPerMeter: ", biXPelsPerMeter.out,
			--		"%N%T biYPelsPerMeter: ", biYPelsPerMeter.out,
			--		"%N%T biClrUsed      : ", biClrUsed.out,
			--		"%N%T biSize         : ", biSize.out,
			--		"%N%T biClrImportant : ", biClrImportant.out
			--	>>)


            	-- Ought to be 1
            	if biPlanes /= 1 then
				--	fx_trace(0, <<"SB_BM_IO::load -- biPlanes /= 1: ", biPlanes.out >>)
            		sb_exceptions.raise("loadbmp")
            	end

            	-- Check for supported depths
            	if		 biBitCount /= 1
            	and then biBitCount /= 4
            	and then biBitCount /= 8
            	and then biBitCount /= 24
            	and then biBitCount /= 32 then
				--	fx_trace(0, <<"SB_BM_IO::load -- biBitCount /= 1 | 2 | 4 | 24 | 32" >>)
               		sb_exceptions.raise("loadbmp");
            	end

            	-- Check for supported compressions
            	if biCompression /= BIH_RGB and then biCompression /= BIH_RLE4 and then biCompression /= BIH_RLE8 then
				--	fx_trace(0, <<"SB_BM_IO::load -- biCompression bad" >>)
               		sb_exceptions.raise("loadbmp");
            	end

            	-- Skip ahead to colormap
            	bPad := 0;
            	if biSize /= WIN_OS2_OLD then

               		-- 40 bytes read from biSize to biClrImportant
               		j := biSize - 40;
               		from
                  		i := 0;
               		until
                  		i >= j
               		loop
                  		c1 := store.read_uint8;
                  		i := i + 1;
               		end
               		bPad := bfOffBits - (biSize + 14);
            	end

            	-- load up colormap, if any
            	if biBitCount <= 8 then
               		if biClrUsed /= 0 then
                  		cmaplen := biClrUsed;
               		else
                  		cmaplen := 1 |<< biBitCount.to_integer_8
               		end
               		create colormap.make(1, 256 * 3);
               		from
                  		i := 0;
               		until
                  		i >= cmaplen
               		loop
                  		colormap.put(store.read_int8, 3 * i + 3);
                  		colormap.put(store.read_int8, 3 * i + 2);
                  		colormap.put(store.read_int8, 3 * i + 1);
                  		if biSize /= WIN_OS2_OLD then
                     		c1 := store.read_uint8;
                     		bPad := bPad - 4;
                  		end
                  		i := i + 1
               		end
            	end

            	-- Waste any unused bytes between the colour map (if present)
            	-- and the start of the actual bitmap data.
            	if biSize /= WIN_OS2_OLD then
               		from
               		until
                  		bPad <= 0
               		loop
                  		c1 := store.read_uint8;
                  		bPad := bPad - 1;
               		end
            	end

            	-- Allocate memory
            	maxpixels := biWidth * biHeight;
            	create data.make(1, maxpixels * 3);

            	-- load up the image
            	inspect biBitCount
            	when 1 then
				--	fx_trace(0, <<"SB_BM_IO::load -- load_bmp_1" >>)
               		Result := load_bmp_1(store, data, data.lower + 2 * maxpixels, biWidth, biHeight);
           		 when 4 then
				--	fx_trace(0, <<"SB_BM_IO::load -- load_bmp_4" >>)
               		Result := load_bmp_4(store, data, data.lower + 2 * maxpixels, biWidth, biHeight, biCompression);
            	when 8 then
				--	fx_trace(0, <<"SB_BM_IO::load -- load_bmp_8" >>)
               		Result := load_bmp_8(store, data, data.lower + 2 * maxpixels, biWidth, biHeight, biCompression);
            	when 16 then
				--	fx_trace(0, <<"SB_BM_IO::load -- load_bmp_16" >>)
               		Result := load_bmp_16(store, data, data.lower, biWidth, biHeight);
            	when 24 then
				--	fx_trace(0, <<"SB_BM_IO::load -- load_bmp_24" >>)
               		Result := load_bmp_24(store, data, data.lower, biWidth, biHeight);
            	when 32 then
				--	fx_trace(0, <<"SB_BM_IO::load -- load_bmp_32" >>)
               		Result := load_bmp_32(store, data, data.lower, biWidth, biHeight);
            	end

            	if Result then
            	--	fx_trace(0, <<"SB_BMP_IO::load - load_bmp OK">>)
               		width := biWidth;
               		height := biHeight;
               		-- Apply colormap
               		if biBitCount <= 8 then
						from
							i := 0;
						until
							i >= maxpixels
						loop
							ix := data.item(2*maxpixels+i+1).to_integer;
                        	data.put(colormap.item(3*ix+1),3*i+1);
                        	data.put(colormap.item(3*ix+2),3*i+2);
                        	data.put(colormap.item(3*ix+3),3*i+3);
                        	i := i + 1;
                  		end
               		end
               		-- No transparent color:- bitmaps are opaque
               		clear_color := 0;
            	end
         	--	fx_trace(0, << "SB_BMP_IO::load - SUCCEEDED !!" >> )
         	else
         	--	fx_trace(0, << "SB_BMP_IO::load - FAILED" >> )
            	Result := False;
            	data := Void
			end
		rescue
         	error := True;
         	retry;
		end

	save(store: SB_STREAM; dt: ARRAY[INTEGER_8]; clr, w, h: INTEGER): BOOLEAN is
			-- Save a gif file to a stream
		do
		ensure
			implemented: false
		end

feature {NONE} -- Implementation

	BIH_RGB: INTEGER is 0;
	BIH_RLE8: INTEGER is 1;
	BIH_RLE4: INTEGER is 2;

	WIN_OS2_OLD: INTEGER is 12;
	WIN_NEW: INTEGER is 40;
	OS2_NEW: INTEGER is 64;

	-- MONO returns total intensity of r,g,b triple (i = .33R + .5G + .17B)
	MONO (r,g,b: INTEGER): INTEGER is
    	do
         	Result := (r*11 + g*16 + b*5) // 32;
      	end

	read32 (store: SB_STREAM): INTEGER is
      	local
         	c1, c2, c3, c4: INTEGER;
      	do
			c1 := store.read_uint8;
         	c2 := store.read_uint8;
         	c3 := store.read_uint8;
         	c4 := store.read_uint8;
			Result := ((c1       ) & 0x000000ff)
					| ((c2 |<<  8) & 0x0000ff00)
					| ((c3 |<< 16) & 0x00ff0000)
					| ((c4 |<< 24) & 0xff000000)
      	end

	read16 (store: SB_STREAM): INTEGER is
      	local
         	c1, c2: INTEGER;
      	do
         	c1 := store.read_uint8
         	c2 := store.read_uint8
			Result := ((c1      ) & 0x00ff)
					| ((c2 |<< 8) & 0xff00)
      	end

   	load_bmp_1(store: SB_STREAM; pic8: ARRAY[INTEGER_8]; start, w, h: INTEGER): BOOLEAN is
      	local
         	i, j, bitnum, padw: INTEGER;
         	pp, c: INTEGER;
         	b8: INTEGER	-- WAS BIT 32;
      	do
			c := 0;
--         	padw := ((w+31)//32)*32;
--
--         	-- Read data
--         from
--            i := h - 1;
--         until
--            i < 0
--         loop
--            pp := start + (i*w);
--            from
--               j := 0;
--               bitnum :=0;
--            until
--               j >= padw
--            loop
--               if bitnum \\ 8 = 0 then
--                  c := store.read_uint8;
--                  bitnum := 0;
--               end
--               if j < w then
--
--                  c_inline_c ("_b8 = (unsigned char)(_c);%N");
--
--
--
--                  if (b8 and 10000000B) /= Zero then
--                     pic8.put(1B,pp);
--                  else
--                     pic8.put(0B,pp);
--                  end
--                  pp := pp + 1;
--                  c := c*2;
--               end
--               j := j + 1;
--               bitnum := bitnum + 1;
--            end
--            i := i - 1;
--         end
--         Result := True;
      end


   load_bmp_4(store: SB_STREAM; pic8: ARRAY[INTEGER_8]; start, w, h, comp: INTEGER): BOOLEAN is
      local
         i,j, x,y, nybnum, padw: INTEGER
         pp, c, c1: INTEGER
         b8: INTEGER_8
      -- b32: BIT 32
         done: BOOLEAN
      do
         Result := True
         -- Read uncompressed data
         if comp = BIH_RGB then
    --     	fx_trace(0, <<"SB_BMP_IO::load_bmp_4 - Comp = BIH_RGB">>)
            padw := ((w+7) // 8) *8
            from
               i := h - 1
            until
               i < 0
            loop
               pp := start + (i*w)
               from
                  j := 0
                  nybnum := 0
               until
                  j >= padw
               loop
                  if nybnum \\ 2 = 0 then
                     c := store.read_uint8
                     nybnum := 0
                  end
                  if j < w then
--#                  c_inline_c ("_b8 = (_c&0xf0)>>4;%N");
                     pic8.put(b8, pp)
--         	fx_trace(0, <<"SB_BMP_IO::load_bmp_4 - #1 byte: ", b8.out>>)
                     pp := pp + 1
                     c := c * 16
                  end
                  j := j + 1
                  nybnum := nybnum + 1
               end
               i := i - 1
            end
         elseif comp = BIH_RLE4 then
            -- Read RLE4 compressed data
            x := 0
            y := 0
            pp := start+x+(h-y-1)*w
            from
               done := False
            until
               done or y >= h
            loop
               c := store.read_uint8
               if c /= 0 then
                  -- Encoded mode c!=0
                  c1 := store.read_uint8
                  from
                     i :=0;
                  until
                     i >= c
                  loop
                     if i \\ 2 /= 0 then
--#                     c_inline_c ("_b8 = (_c1&0x0f);%N")
                        pic8.put(b8,pp)
--         	fx_trace(0, <<"SB_BMP_IO::load_bmp_4 - #2 byte: ", b8.out>>)
                     else
--#                        c_inline_c ("_b8 = ((_c1>>4)&0x0f);%N")
                        pic8.put(b8,pp)
--         	fx_trace(0, <<"SB_BMP_IO::load_bmp_4 - #3 byte: ", b8.out>>)
                     end
                     i := i + 1
                     x := x + 1
                     pp := pp + 1
                  end
               else
                  -- Escape codes: c == 0
                  c := store.read_uint8;
                  if c = 0 then
                     --/ End of line
                     x := 0;
                     y := y+1;
                     pp := start+x+(h-y-1)*w
                  elseif c = 1 then
                     --  End of pic8
                     done := True
                  elseif c = 2 then
                     -- Delta
                     c := store.read_uint8
                     x := x+c;
                     c := store.read_uint8
                     y := y + c;
                     pp := start+x+(h-y-1)*w
                  else
                     -- Absolute mode
                     from
                        i := 0
                     until
                        i >= c
                     loop
                        if i \\ 2 = 0 then
                           c1 := store.read_uint8
--#                           c_inline_c ("_b8 = ((_c1 >> 4) & 0x0f);%N")
                           pic8.put(b8,pp)
--         	fx_trace(0, <<"SB_BMP_IO::load_bmp_4 - #4 byte: ", b8.out>>)
                        else
--#                           c_inline_c ("_b8 = (_c1&0x0f);%N")
                           pic8.put(b8,pp)
--         	fx_trace(0, <<"SB_BMP_IO::load_bmp_4 - #5 byte: ", b8.out>>)
                        end
                        i := i + 1
                        x := x + 1
                        pp := pp + 1
                     end
                     -- Read pad byte
                     if c \\ 4 = 1 or else c \\ 4 = 2 then
                        c1 := store.read_uint8
                     end
                  end
               end
            end
         else
         	fx_trace(0, <<"SB_BMP_IO::load_bmp_4 -- Unknown compression type">>)
            -- Unknown compression type
            Result := False
         end
      end

   load_bmp_8(store: SB_STREAM; pic8: ARRAY[INTEGER_8]; start, w, h, comp: INTEGER): BOOLEAN is
      local
         i,j,x,y,padw: INTEGER;
         pp,c,c1: INTEGER;
         b8: INTEGER_8;
      --   b32: BIT 32;
         done: BOOLEAN;
      do
--         Result := True;
--         -- Read uncompressed data
--         if comp = BIH_RGB then
--            padw := ((w+3)//4)*4;
--            from
--               i := h - 1;
--            until
--               i < 0
--            loop
--               pp := start + (i*w);
--               from
--                  j := 0;
--               until
--                  j >= padw
--               loop
--                  c := store.read_uint8;
--                  if j < w then
--
--                     c_inline_c ("_b8 = _c1;%N");
--
--
--
--                     pic8.put(b8,pp);
--                     pp := pp + 1;
--                  end
--                  j := j + 1;
--               end
--               i := i - 1;
--            end
--         elseif comp = BIH_RLE8 then
--            -- Read RLE8 compressed data
--            x := 0;
--            y := 0;
--            pp := start+x+(h-y-1)*w;
--            from
--               done := False;
--            until
--               done or y >= h
--            loop
--               c := store.read_uint8;
--               if c /= 0 then
--                  -- Encoded mode
--                  c1 := store.read_uint8;
--                  from
--                     i :=0;
--                  until
--                     i >= c
--                  loop
--
--                     c_inline_c ("_b8 = _c1;%N");
--
--
--
--                     pic8.put(b8,pp);
--                     i := i + 1;
--                     x := x + 1;
--                     pp := pp + 1;
--                  end
--               else
--                  -- Escape codes: c==0
--                  c := store.read_uint8;
--                  if c = 0 then
--                     --/ End of line
--                     x := 0;
--                     y := y+1;
--                     pp := start+x+(h-y-1)*w;
--                  elseif c = 1 then
--                     --  End of pic8
--                     done := True;
--                  elseif c = 2 then
--                     -- Delta
--                     x := x + store.read_uint8;
--                     y := y + store.read_uint8;
--                     pp := start+x+(h-y-1)*w;
--                  else
--                     -- Absolute mode
--                     from
--                        i := 0;
--                     until
--                        i >= c
--                     loop
--                        pic8.put(store.read_uint8, pp);
--                        i := i + 1;
--                        x := x + 1;
--                        pp := pp + 1;
--                     end
--                     -- Odd length run: read an extra pad byte
--                     if c\\2 /= 0 then
--                        c1 := store.read_uint8;
--                     end
--                  end
--               end
--            end
--         else
--            -- Unknown compression type
--            Result := False;
--         end
      end

	load_bmp_16(store: SB_STREAM; pic16: ARRAY[INTEGER_8]; start, w, h: INTEGER): BOOLEAN is
		local
         	i, j, padb: INTEGER
         	pp, c: INTEGER
         	b8: INTEGER_8
         	rgb16: INTEGER_16
      	do
         	padb := (4-((w*2)\\4))\\4;
         	from
            	i := h-1;
         	until
            	i < 0
         	loop
            	pp := start+(i*w*3);
            	from
               		j := 0;
            	until
               		j >= w
            	loop
               		rgb16 := store.read_int16;

       --        	c_inline_c ("_b8 =((_rgb16 >> 10) & 0x1F) << 3;%N") -- Red
               		pic16.put(b8, pp); pp := pp+1;

        --       	c_inline_c ("_b8=((_rgb16 >> 5) & 0x1F) << 3;%N"); -- Green
               		pic16.put(b8, pp); pp := pp+1;

         --      	c_inline_c ("_b8=(_rgb16 & 0x1F) << 3;%N"); -- Blue
               		pic16.put(b8, pp); pp := pp+1;
               		j := j + 1;
            	end
            	from
               		j := 0;
            	until
               		j >= padb
            	loop
               		c := store.read_uint8;
               		j := j + 1
            	end
            	i := i - 1;
         	end
        	Result :=  True;
      	end

   	load_bmp_24(store: SB_STREAM; pic24: ARRAY[INTEGER_8]; start, w, h: INTEGER): BOOLEAN is
      local
         i,j,padb: INTEGER;
         pp,c: INTEGER;
      do
         padb := (4-((w*3)\\4))\\4;
         from
            i := h-1;
         until
            i < 0
         loop
            pp := start+(i*w*3);
            from
               j := 0;
            until
               j >= w
            loop
               pic24.put(store.read_int8, pp + 2); -- Blue
               pic24.put(store.read_int8, pp + 1); -- Green
               pic24.put(store.read_int8, pp + 0); -- Red
               pp := pp + 3;
               j := j + 1;
            end
            from
               j := 0;
            until
               j >= padb
            loop
               c := store.read_uint8;
               j := j + 1
            end
            i := i - 1;
         end
         Result :=  True;
      end

	load_bmp_32(store: SB_STREAM; pic32: ARRAY[INTEGER_8]; start, w, h: INTEGER): BOOLEAN is
    	local
        	i, j: INTEGER;
        	pp, c: INTEGER;
      	do
         	from
            	i := h-1;
         	until
            	i < 0
         	loop
            	pp := start+(i*w*3);
            	from
               		j := 0;
            	until
               		j >= w
            	loop
               		pic32.put(store.read_int8, pp + 2); -- Blue
               		pic32.put(store.read_int8, pp + 1); -- Green
               		pic32.put(store.read_int8, pp + 0); -- Red
               		c := store.read_int8;
               		pp := pp + 3;
               		j := j + 1;
            	end
            	i := i - 1;
         	end
         	Result :=  True;
		end

end
