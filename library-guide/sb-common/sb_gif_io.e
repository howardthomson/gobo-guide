indexing
	description:"GIF input/output"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Initial stub implementation"

	todo: "[
		Debug - non-functioning GIF image in icon test program
		Code based on Fox, arounf 1.1.14
	]"

class SB_GIF_IO

inherit

	SB_COMMON_MACROS

	SB_DEFS

	SB_EXPANDED

feature -- Data

	data: ARRAY[INTEGER_8]

	width: INTEGER
	height: INTEGER

	clear_color: INTEGER
	version_89a: BOOLEAN
	alpha: INTEGER
	has_alpha: BOOLEAN

feature -- Actions

	load(store: SB_STREAM): BOOLEAN is
			-- Load image from stream
		local
         	c1,c2,flags: INTEGER_8
         	i: INTEGER
         	done: BOOLEAN
         	BitMask: INTEGER
         	ncolors: INTEGER
      	do
         	if check_signature(store) and then check_version(store) then
            	-- Get screen descriptor
            	c1 := store.read_byte; c2 := store.read_byte	-- Skip screen width
            	c1 := store.read_byte; c2 := store.read_byte	-- Skip screen height
            	flags := store.read_byte;                   	-- Get flags
            	alpha := store.read_uint8						-- Background
            	c2 := store.read_byte							-- Skip aspect ratio

            	-- Determine number of colors
            	ncolors := 0x00000002 |<< (flags & 7)				-- SE 2.1
            	BitMask := ncolors - 1

            	-- Get colormap
            	if (flags & COLORMAP) /= 0 then
            	--	edp_trace.simple(0, "SB_GIF_IO::load - colormap from stream")
               		clrmap := store.load_byte_array(3 * ncolors)
            	else
               		-- Fill with simple palette
               	--	edp_trace.simple(0, "SB_GIF_IO::load colormap from ega_palette")
               		create clrmap.make(1, 256 * 3)
               		from
                	  	i := 0
               		until
                	  	i > 255
               		loop
                	  	clrmap.put(ega_palette.item((i \\ 16) * 3 + 1), 3 * i + 1)
                	  	clrmap.put(ega_palette.item((i \\ 16) * 3 + 2), 3 * i + 2)
                	  	clrmap.put(ega_palette.item((i \\ 16) * 3 + 3), 3 * i + 3)
                	  	i := i + 1
               		end
            	end

            	-- Assume no alpha
            	clear_color := 0
            	has_alpha := False

            	-- Process it
            	from
               		done := False
            	until
               		done
           		loop
               		c1 := store.read_byte
               		if c1 = EXTENSION then
                  		Result := process_extension(store, ncolors)
               		--	edp_trace.start(0, "SB_GIF_IO::load - process_extension, Result = ").next(Result.out).done
               		elseif c1 = IMAGESEP then
                  		Result := process_image(store, BitMask)
               		--	fx_trace(0, <<"SB_GIF_IO::load - process_image, Result = ", Result.out>>)
               		--	fx_trace(0, <<"SB_GIF_IO::load - stream pos = ", store.pos.out>>)
                  		done := True
               		else
                  		Result := False
               		--	fx_trace(0, <<"SB_GIF_IO::load - Fail, Not EXTENSION or IMAGESEP: ", c1.out>>)
                  		done := True
               		end
            	end
            --	fx_trace(0, <<"SB_GIF_IO::load - DONE">>)
            else
            	fx_trace(0, <<"SB_GIF_IO::load - signature BAD">>)
         	end
		end

	save(store: SB_STREAM; dt: ARRAY [ INTEGER_8 ]; clr, w, h: INTEGER): BOOLEAN is
        	-- Save a gif file to a stream
		do
		end

feature {NONE} -- Implementation

	ASCPECTEXT		: INTEGER_8 is 	0x52	--   101 0010B
	COMMENTEXT		: INTEGER_8 is 	0xfe	--  1111 1110B
	PLAINTEXTEXT	: INTEGER_8 is 	0x01	--          1B
	APPLICATIONEXT	: INTEGER_8 is 	0xff	--  1111 1111B
	GRAPHICCONTROLEXT:INTEGER_8 is 	0xf9	--  1111 1001B
	EXTENSION		: INTEGER_8 is 	0x21	--    10 0001B
	IMAGESEP		: INTEGER_8 is 	0x2c	--	  10 1100B
	TRAILER			: INTEGER_8 is 	0x3b	--	  11 1011B
	INTERLACE		: INTEGER_8 is 	0x40	--	 100 0000B
	COLORMAP		: INTEGER_8 is 	0x80	--	1000 0000B

	ega_palette: ARRAY [ INTEGER_8 ] is
    	once
        	Result :=
        --	{ ARRAY [ INTEGER_8 ] 1,
        	<<	-- SE 2.1
				0x00, 0x00, 0x00,	--	0,         0,         0,
                0x00, 0x00, 0x80,	--	0,         0,         1000 0000B,
                0x00, 0x80, 0x00,	--	0,         1000 0000B, 0,
                0x00, 0x80, 0x80,	--	0,         1000 0000B, 1000 0000B,
                0x80, 0x00, 0x00,	--	1000 0000B, 0,         0,
                0x80, 0x00, 0x80,	--	1000 0000B, 0,         1000 0000B,
                0x80, 0x80, 0x00,	--	1000 0000B, 1000 0000B, 0,
                0xa8, 0xa8, 0xc8,	--	1100 1000B, 1100 1000B, 1100 1000B,
                0x64, 0x64, 0x64,	--	0110 0100B, 0110 0100B, 0110 0100B,
                0x64, 0x64, 0xff,	--	0110 0100B, 0110 0100B, 1111 1111B,
                0x64, 0xff, 0x64,	--	0110 0100B, 1111 1111B, 0110 0100B,
                0x64, 0xff, 0xff,	--	0110 0100B, 1111 1111B, 1111 1111B,
                0xff, 0x64, 0x64,	--	1111 1111B, 0110 0100B, 0110 0100B,
                0xff, 0x64, 0xff,	--	1111 1111B, 0110 0100B, 1111 1111B,
                0xff, 0xff, 0x64,	--	1111 1111B, 1111 1111B, 0110 0100B,
                0xff, 0xff, 0xff	--	1111 1111B, 1111 1111B, 1111 1111B
			>>
		--	}	-- SE 2.1
		end

   clrmap: ARRAY [ INTEGER_8 ]

   check_signature(store: SB_STREAM): BOOLEAN is
      local
         c1,c2,c3: INTEGER_8
      do
         c1 := store.read_byte
         c2 := store.read_byte
         c3 := store.read_byte
         if		  c1 = 	0x47	-- 'g'
         and then c2 = 	0x49	-- 'i'
         and then c3 = 	0x46	-- 'f'
         then
            Result := True
         else
         	fx_trace(0, <<"SB_GIF_IO::check_signature - FAIL">>)
         end
      end

	check_version(store: SB_STREAM): BOOLEAN is
		local
			c1, c2, c3: INTEGER_8
		do
         	c1 := store.read_byte
         	c2 := store.read_byte
         	c3 := store.read_byte

         	if		 c1 = 0x38	--	'8'
         	and then c2 = 0x37	--	'7'
         	and then c3 = 0x61	--	'a'
         	then
            	version_89a := False
            	Result := True
         	elseif   c1 = 0x38	--	'8'
         	and then c2 = 0x39	--	'9'
         	and then c3 = 0x61	--	'a'
         	then
            	version_89a := True
            	Result := True
           	else
           		fx_trace(0, <<"SB_GIF_IO::check_version - FAIL">>)
         	end
      	end

	process_extension(store: SB_STREAM; ncolors: INTEGER): BOOLEAN is
    	local
         	c2, c3, flags: INTEGER_8
         	size: INTEGER
         	i: INTEGER
         	t: INTEGER_8
      	do
         	-- Read extension code
         	c2 := store.read_byte
         	if c2 = GRAPHICCONTROLEXT then
            	-- Graphic Control Extension
            	size := store.read_uint8
            	if size = 4 then
               		Result := True
               		flags := store.read_byte  -- Flags
               		c3 := store.read_byte; c3 := store.read_byte   -- Delay time
               		alpha := store.read_uint8 -- Alpha color index
               		c3 := store.read_byte
               		has_alpha := (flags & 1) /= 0
               		-- Make unique transparency color; patch
               		-- from Daniel Gehriger <bulk@linkcad.com>
               		if has_alpha then
                  		from
                     		i := ncolors - 1
                  		until
                     		i < 0
                  		loop
                     		if clrmap.item(3*i+1) = clrmap.item(3*alpha+1)
                        	and then clrmap.item(3*i+2) = clrmap.item(3*alpha+2)
                        	and then clrmap.item(3*i+3) = clrmap.item(3*alpha+3) and then i /= alpha
                      		then
                        		t := clrmap.item(3*alpha+1)+1
                        		clrmap.put(t,3*alpha+1)
                        		if clrmap.item(3*alpha+1) = 0 then
                           			t := clrmap.item(3*alpha+2)+1
                           			clrmap.put(t,3*alpha+2)
                           			if clrmap.item(3*alpha+2) = 0 then
                              			t := clrmap.item(3*alpha+3)+1
                              			clrmap.put(t, 3*alpha+3)
                           			end
                        		end
                        		i := ncolors  -- Try again with new value
                     		end
                     		i := i - 1
                  		end
               		end
            	end
         	else
            	-- Other extension
            	from
               		size := store.read_uint8
            	until
               		store.code /= store.SB_STREAM_OK or else size <= 0
            	loop
               		from
                  		i := 0
               		until
                  		i >= size
               		loop
                  		c3 := store.read_byte
                  		i := i + 1
               		end
            	end
         	end
		end

	process_image(store: SB_STREAM; BitMask: INTEGER): BOOLEAN is
    	local
         	Yinit, Yinc: ARRAY[INTEGER]
         	imwidth,
         	imheight,
         	npixels,
         	maxpixels	: INTEGER
         	c1,c2,c3,
         	flags		: INTEGER_8
         	size		: INTEGER
         	BitOffset	: INTEGER			-- Bit Offset of next code
         	XC, YC		: INTEGER			-- Output X and Y coords of current pixel
         	Pass		: INTEGER			-- Used by output routine if interlaced pic
         	OutCount	: INTEGER			-- Decompressor output 'stack count'
         	CodeSize	: INTEGER			-- Code size, read from GIF header
         	InitCodeSize: INTEGER			-- Starting code size, used during Clear
         	Code		: INTEGER			-- Value returned by ReadCode
         	MaxCode		: INTEGER			-- limiting value for current code size
         	ClearCode	: INTEGER			-- GIF clear code
         	EOFCode		: INTEGER			-- GIF end-of-information code
         	CurCode,
         	OldCode,
         	InCode		: INTEGER			-- Decompressor variables
         	FirstFree	: INTEGER			-- First free code, generated per GIF spec
         	FreeCode	: INTEGER			-- Decompressor,next free slot in hash table
         	FinChar		: INTEGER			-- Decompressor variable
         	ReadMask	: INTEGER			-- Code AND mask for current code size
         	prfx		: ARRAY[INTEGER]	-- The hash table used by the decompressor
         	Suffix		: ARRAY[INTEGER]	-- The hash table used by the decompressor
         	OutCode		: ARRAY[INTEGER]	-- An output array used by the decompressor
         	ByteOffset	: INTEGER
         	i,ix		: INTEGER
         	ib			: INTEGER_8
         	ptr			: INTEGER
         	done		: BOOLEAN
         	error		: BOOLEAN
         	intrlace	: BOOLEAN
         	ncolors		: INTEGER
		do
			if not error then

			--	Yinit := { ARRAY [ INTEGER ] 1, << 0, 4, 2, 1 >> }	-- GEC/EDP
			--	Yinc  := { ARRAY [ INTEGER ] 1, << 8, 8, 4, 2 >> }	-- GEC/EDP
				Yinit := << 0, 4, 2, 1 >>
				Yinc  := << 8, 8, 4, 2 >>
            	create prfx.make(0,4095)
            	create Suffix.make(0,4095)
            	create OutCode.make(0,4096)
            	-- Image separator
            	c1 := store.read_byte; c2 := store.read_byte
            	c1 := store.read_byte; c2 := store.read_byte

            	-- Get image width
				imwidth := store.read_int16

            	-- Get image height
				imheight := store.read_int16

            	-- Get image flags
            	flags := store.read_byte

            	maxpixels := imwidth*imheight

            	-- Allocate memory
            	create data.make(1, 3*maxpixels)

            	-- Has a colormap
            	if (flags & COLORMAP) /= 0 then
					ncolors := 0x00000002 |<< (flags & 7)				-- SE 2.1
               		clrmap := store.load_byte_array(3*ncolors)
            	end

            	-- Interlaced image
            	intrlace := (flags & INTERLACE) /= 0

            	-- Start reading the raster data. First we get the intial code size
            	-- and compute decompressor constant values, based on this code size.
            	CodeSize := store.read_uint8

            	ClearCode := 0x00000001 |<< CodeSize.to_integer_8
           	 	EOFCode := ClearCode+1
            	FreeCode := ClearCode+2
            	FirstFree := ClearCode+2

            	-- The GIF spec has it that the code size is the code size used to
            	-- compute the above values is the code size given in the file, but the
            	-- code size used in compression/decompression is the code size given in
            	-- the file plus one.
            	CodeSize := CodeSize + 1
            	InitCodeSize := CodeSize
            	MaxCode := 0x00000001 |<< CodeSize.to_integer_8
            	ReadMask := MaxCode - 1

            	-- Read all blocks into memory, reusing pixel storage.
            	-- We assume that since it's compressed, it should take less room!
            	from
               		ptr := 1
               		size := store.read_uint8
            	until
               		store.code /= store.SB_STREAM_OK or else size <= 0
            	loop
               		store.read_byte_array(data, ptr, size)
               		ptr := ptr + size
               		size := store.read_uint8
            	end
			--	fx_trace(0, <<"SB_GIF_IO::process_image -- After reading from stream:%N",
			--		"ptr = ", ptr.out, " stream_pos = ", store.pos.out>>)

            	npixels := 0
            	BitOffset := 0
            	XC := 0
            	YC := 0
            	Pass := 0
            	OutCount := 0

            	-- Drop data at the end, so we can resuse pixel memory
            	ptr := 2*maxpixels + 1

            	-- Decompress the file, continuing until you see the GIF EOF code.
            	-- One obvious enhancement is to add checking for corrupt files here.
            	from
               		done := False
            	until
               		done
            	loop
               		-- Fetch the next code from the raster data stream.  The codes can be
               		-- any length from 3 to 12 bits, packed into 8-bit bytes, so we have to
               		-- maintain our location in the source array as a BIT Offset.  We compute
               		-- the byte Offset into the raster array by dividing this by 8, pick up
               		-- three bytes, compute the bit Offset into our 24-bit chunk, shift to
               		-- bring the desired code to the bottom, then mask it off and return it.
               		ByteOffset := BitOffset |>> 3
               		Code := (uint8_to_int(data.item(ByteOffset+1)))
               			  + (uint8_to_int(data.item(ByteOffset+2))) |<< 8
               		if CodeSize >= 8 then
                  		Code := Code + ((uint8_to_int(data.item(ByteOffset+3))) |<< 16)
               		end
               		Code := Code |>> (BitOffset & 7).to_integer_8
               		BitOffset := BitOffset + CodeSize
               		Code := Code & ReadMask
               		-- Are we done?
               		if Code = EOFCode or else npixels >= maxpixels then
                  		done := True
               		elseif Code = ClearCode then
                  		-- Clear code sets everything back to its initial value, then reads the
                  		-- immediately subsequent code as uncompressed data.
                  		CodeSize := InitCodeSize
                  		MaxCode := 0x00000001 |<< CodeSize.to_integer_8
                  		ReadMask := MaxCode-1
                  		FreeCode := FirstFree

                  		-- Get next code
                  		ByteOffset := BitOffset |>> 3
                  		Code := (uint8_to_int(data.item(ByteOffset+1)))
                  			  + (uint8_to_int(data.item(ByteOffset+2))) |<< 8
                  		if CodeSize >= 8 then
                    	-- 	tmp_b32_1 := uint8_to_int(data.item(ByteOffset+3))
                    	 	Code := Code + uint8_to_int(data.item(ByteOffset+3)) |<< 16
                  		end
                  		Code := (Code |<< (BitOffset & 7).to_integer_8)
                  		BitOffset := BitOffset + CodeSize
                  		Code := Code & ReadMask

                  		CurCode := Code
                  		OldCode := Code
                  		FinChar := CurCode & BitMask
                  		if not intrlace then
                     		data.put(int_to_int8(FinChar), ptr)
                     		ptr := ptr + 1
                  		else
                     		--FXASSERT(0<=YC && YC<imheight)
                     		--FXASSERT(0<=XC && XC<imwidth)
                     		data.put(int_to_int8(FinChar), ptr + YC*imwidth+XC)
                     		XC := XC + 1
                     		if XC >= imwidth then
                        		XC := 0
                        		YC := YC + Yinc.item(Pass+1)
                        		if YC >= imheight then
                           			Pass := Pass + 1
                           			YC := Yinit.item(Pass//4 + 1)
                        		end
                     		end
                  		end
                  		npixels := npixels + 1
               		else
                  		-- If not a clear code, must be data: save same as CurCode and InCode
                  		if FreeCode >= 4096 then
                     		-- If we're at maxcode and didn't get a clear, stop loading
                     		--fxwarning("fxloadGIF: problem!\n")
						--	fx_trace(0, <<"SB_GIF_IO::process_image #1 - OutCount > 4096">>)
                     		exceptions.raise("loadgif")
                  		end
                  		CurCode := Code
                  		InCode := Code

                  		if CurCode >= FreeCode then
                     		-- If greater or equal to FreeCode, not in the hash table yet
                     		-- repeat the last character decoded
                     		CurCode := OldCode
                     		if OutCount > 4096 then
                        		-- fxwarning("fxloadGIF: problem!\n")
								fx_trace(0, <<"SB_GIF_IO::process_image #2 - OutCount > 4096">>)
                        		exceptions.raise("loadgif")
                     		end
                     		OutCode.put(FinChar, OutCount)
                     		OutCount := OutCount + 1
                  		end
                  		-- Unless this code is raw data, pursue the chain pointed to by CurCode
                  		-- through the hash table to its end; each code in the chain puts its
                  		-- associated output code on the output
                  		-- queue.
                  		from
                  		until
                     		OutCount > 4096 or else CurCode <= BitMask
                  		loop
                     		OutCode.put(Suffix.item(CurCode), OutCount)
                     		OutCount := OutCount + 1
                     		CurCode := prfx.item(CurCode)
                  		end
                  		if OutCount > 4096 then
                     		--fxwarning("fxloadGIF: problem!\n")
							fx_trace(0, <<"SB_GIF_IO::process_image #3 - OutCount > 4096">>)
                     		exceptions.raise("loadgif")
                  		end

                  		-- The last code in the chain is treated as raw data
                  	--	tmp_b32_1 := CurCode; tmp_b32_2 := BitMask
                  		FinChar := CurCode & BitMask
                  		OutCode.put(FinChar, OutCount)
                  		OutCount := OutCount + 1

                  		-- Now we put the data out to the Output routine.
                  		-- It's been stacked LIFO, so deal with it that way...

                  		-- safety thing: prevent exceeding range
                  		if npixels + OutCount > maxpixels then
                     		OutCount := maxpixels-npixels
                  		end
                  		npixels := npixels + OutCount

                  		if not intrlace then
                     		from
                        		i := OutCount - 1
                     		until
                        		i < 0
                     		loop
                        	--	tmp_b8_1 := int_to_int8(OutCode.item(i))
                        		data.put(int_to_int8(OutCode.item(i)), ptr)
                        		ptr := ptr + 1
                        		i := i - 1
                     		end
                		else
                     		from
                        		i := OutCount - 1
                     		until
                        		i < 0
                     		loop
                        		check 0 <= YC and then YC < imheight end
                        		check 0 <= XC and then XC < imwidth  end
                        	--	tmp_b8_1 := int_to_int8(OutCode.item(i))
                        		data.put(int_to_int8(OutCode.item(i)), ptr + YC*imwidth+XC)
                        		XC := XC + 1
                        		if XC >= imwidth then
                           			XC := 0
                           			YC := YC + Yinc.item(Pass)
                           			if YC >= imheight then
                              			Pass := Pass + 1
                              			YC := Yinit.item(Pass//4)
                           			end
                        		end
                        		i := i - 1
                     		end
                  		end
                  		OutCount := 0

                  		-- Build the hash table on-the-fly. No table is stored in the file
                  		prfx.put(OldCode,FreeCode)
                  		Suffix.put(FinChar,FreeCode)
                  		OldCode := InCode

                  		-- Point to the next slot in the table.  If we exceed the current
                  		-- MaxCode value, increment the code size unless it's already 12.  If it
                  		-- is, do nothing: the next code decompressed better be CLEAR
                  		FreeCode := FreeCode + 1
                  		if FreeCode >= MaxCode then
                  			if CodeSize < 12 then
								CodeSize := CodeSize + 1
                        		MaxCode := MaxCode * 2
                        		ReadMask := (0x00000001 |<< CodeSize.to_integer_8) - 1
                    		end
              			end
               		end
            	end
            	-- Did the stream stop prematurely?
            	if npixels /= maxpixels then
            		print("fxloadGIF: image truncated%N")
            	else

	            	width := imwidth
	            	height := imheight

	            	-- Apply colormap
	            	from
	            		i := 0
	            	until
	            		i >= maxpixels
	            	loop
					--	fx_trace(0, <<"SB_GIF_IO - Apply colormap - get/put... - ",
					--		(2*maxpixels + i + 1).out, " ",
					--		(3*i+1).out, " ",
					--		(3*i+2).out, " ",
					--		(3*i+3).out
					--	>>)            	
	            		ix := uint8_to_int(data.item(2*maxpixels + i + 1))
	            		data.put(clrmap.item(3*ix+1),3*i+1)
	            		data.put(clrmap.item(3*ix+2),3*i+2)
	            		data.put(clrmap.item(3*ix+3),3*i+3)
	            		i := i + 1
	            	end
	            end
            	-- If we had a transparent color, use it
            --	if havealpha then
            --  	clear_color := sbrgb(clrmap.item(3*alpha +1),
            --                        clrmap.item(3*alpha+2),
            --                        clrmap.item(3*alpha+3))
            --	end

            	-- Remark:- the above code is correct, but all our icons don't have
            	-- an alpha (they're GIF87a's) and so we need to fix those first...

				clear_color := sbrgb(uint8_to_int(clrmap.item(3*alpha +1)),
									 uint8_to_int(clrmap.item(3*alpha +2)),
									 uint8_to_int(clrmap.item(3*alpha +3)));
				-- We're done!
				Result := True
			else
				Result := False
				data := Void
			end
		rescue
			fx_trace(0, <<"Rescue clause in SB_GIF_IO::process_image">>)
			error := True
			retry
		end

	exceptions: EXCEPTIONS is
			-- Should be in parent class somewhere
		once
			create Result
		end

	int_to_bit32(i: INTEGER): INTEGER is
		do
			Result := i
		end

	int_to_int8, int_to_bit8(i: INTEGER): INTEGER_8 is
			-- Avoid fit_integer_8 requirement for unsigned 8-bit value
			-- which has the top bit set (of 8-bits)
		do
			if (i & 0x0080) /= 0 then
				Result := (i | 0xffffff00).to_integer_8
			else
				Result := i.to_integer_8
			end
		end

	bit32_to_int(b: INTEGER): INTEGER is
		do
			Result := b
		end

	uint8_to_int, bit8_to_int(b: INTEGER_8): INTEGER is
		do
			Result := b
			Result := Result & 0x00ff
		end
end
