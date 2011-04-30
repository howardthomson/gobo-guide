indexing
	description:"Persistent store definition"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete, but require some testing and thinking"

deferred class SB_STREAM

inherit

	SB_STREAM_CONSTANTS
	SB_EXPANDED

feature -- Creation

	make is
		do
         	dir := SB_STREAM_DEAD
         	code := SB_STREAM_OK
         	pos := 0
      	end

feature -- Data

	swap: BOOLEAN
    		-- Swap bytes on readin

   	dir: INTEGER   
         	-- Direction of current transfer

   	code: INTEGER
         	-- Status code

   	pos: INTEGER
         	-- Position

feature -- Queries

	is_little_endian: BOOLEAN is
         	-- Return implementation's endianness
    	do
         	-- TODO: Implement proper check
         	Result := True
    	end

feature -- Actions

   open(save_or_load: INTEGER) is
         -- Open archive
      require
         save_or_load = SB_STREAM_SAVE or else save_or_load = SB_STREAM_LOAD
         dir = SB_STREAM_DEAD
      do
         dir := save_or_load;
         pos := 0;
         code := SB_STREAM_OK
      end

	close is
			-- Close
		require
			dir /= SB_STREAM_DEAD
		do
			dir := SB_STREAM_DEAD
			code := SB_STREAM_OK
		end

	set_error(err: INTEGER) is
			-- Set status code, unless there was a previous code already
		do
			if code = SB_STREAM_OK then
				code := err
			end
		end

	position(p: INTEGER) is
			-- Move to position
		require
			dir /= SB_STREAM_DEAD
			p >= 0
		do
			if code = SB_STREAM_OK then
				pos := p
			end
		end

	swap_bytes(s: BOOLEAN) is
    		-- Change swap bytes flag
    	do
         	swap := s
		end

feature -- Save

   	write_byte(b: INTEGER_8) is
      	do
--##		save_items($b, 1)
         	pos := pos + 1
      	end

	write_byte_i(b: INTEGER) is
		local
			b8: INTEGER_8
		do
			b8 := b.to_integer_8
--#			save_items($b8, 1)
			pos := pos + 1
		end

--	write_word(w: BIT 16) is
--		do           	
--			save_items($w, 2)
--			pos := pos + 2
--		end

   	write_word_i(w: INTEGER) is
      	do
--##		save_items($w, 2);
         	pos := pos + 2;
      	end

   	write_dword(dw: INTEGER) is
      	do
--##		save_items($dw, 4)
         	pos := pos + 4
      	end

   	write_dword_i(dw: INTEGER) is
      	do
--##		save_items($dw, 4)
         	pos := pos + 4
      	end

	write_double(d: REAL_64) is
		do
--##		save_items($d, 8);
        	pos := pos + 8;
      	end

   save_byte_array(ba: ARRAY[INTEGER_8]) is
      require
        ba /= Void
      local
         i,e: INTEGER;
      do
         from
            i := ba.lower
            e := ba.upper
         until
            i > e
         loop
            write_byte(ba.item(i))
            i := i + 1
         end
      end

   save_byte_array_i(ba: ARRAY[INTEGER]) is
      require
        ba /= Void
      local
         i,e: INTEGER;
      do
         from
            i := ba.lower
            e := ba.upper
         until
            i > e
         loop
            write_byte_i(ba.item(i));
            i := i + 1;
         end
      end

--	save_word_array(wa: ARRAY[BIT 16]) is
--		require
--	        wa /= Void
--	    local
--	    	i,e: INTEGER;
--	    do
--	    	from
--	    		i := wa.lower
--	            e := wa.upper
--	         until
--	            i > e
--	         loop
--	            write_word(wa.item(i))
--	            i := i + 1
--	         end
--		end

   save_word_array_i(wa: ARRAY[INTEGER]) is
      require
        wa /= Void
      local
         i,e: INTEGER
      do
         from
            i := wa.lower
            e := wa.upper
         until
            i > e
         loop
            write_word_i(wa.item(i))
            i := i + 1
         end
      end

   save_dword_array(wa: ARRAY[INTEGER]) is
      require
        wa /= Void
      local
         i,e: INTEGER;
      do
         from
            i := wa.lower
            e := wa.upper
         until
            i > e
         loop
            write_dword(wa.item(i))
            i := i + 1
         end
      end

   save_dword_array_i(wa: ARRAY[INTEGER]) is
      require
        wa /= Void
      local
         i,e: INTEGER
      do
         from
            i := wa.lower
            e := wa.upper
         until
            i > e
         loop
            write_dword_i(wa.item(i))
            i := i + 1
         end
      end


feature -- Load

	int_64: INTEGER_64

	int_64_address: POINTER is
		do
			Result := $int_64
		end

	read_byte_i, read_uint8: INTEGER is
		do
			Result := read_int8
			Result := Result & 0x00ff
		end

	read_byte, read_int8: INTEGER_8 is
		local
			p: POINTER
			cp: C_POINTER
		do
			p := int_64_address
			load_items (p, 1)
			cp.set_item (p)
			Result := cp.get_int8
			pos := pos + 1
--			fx_trace(0, <<"SB_STREAM::read_int8: Result = ", Result.out>>)
		end

	read_int16, read_word_i: INTEGER_16 is
		local
			p: POINTER
			cp: C_POINTER
		do
			p := int_64_address
			load_items (p, 2);
			cp.set_item (p)
			Result := cp.get_int16
			pos := pos + 2
			if swap then Result := swap_int16(Result) end
--			fx_trace(0, <<"SB_STREAM::read_int16: Result = ", Result.out>>)
		end

	read_int32, read_dword: INTEGER is
		local
			p: POINTER
			cp: C_POINTER
		do
			p := int_64_address
			load_items (p, 4)
			cp.set_item (p)
			Result := cp.get_long
			pos := pos + 4
			if swap then Result := swap_int32(Result) end
--			fx_trace(0, <<"SB_STREAM::read_int32: Result = ", Result.out>>)
      end

--	XXread_dword_i: INTEGER is
--		do
--			load_items(get_r, 4)
--			pos := pos + 4
--			if swap then swap4(get_r) end
--		end

--	XXread_double: REAL_64 is
--		do
--			load_items(get_r, 8)
--			pos := pos + 8
--			if swap then swap8(get_r) end
--		end

   load_byte_array(n: INTEGER): ARRAY[INTEGER_8] is
      require
         n >= 0
      local
         i: INTEGER
      do
         create Result.make(1,n)
         from
            i := 1
         until
            i > n
         loop
            Result.put(read_byte, i);
            i := i + 1
         end
      end

   load_byte_array_i(n: INTEGER): ARRAY[INTEGER] is
      require
         n >= 0
      local
         i: INTEGER;
      do
         create Result.make(1,n)
         from
            i := 1
         until
            i > n
         loop
            Result.put(read_byte_i, i)
            i := i + 1
         end
      end

   load_word_array_i(n: INTEGER): ARRAY[INTEGER] is
      require
         n >= 0
      local
         i: INTEGER
      do
         create Result.make(1,n)
         from
            i := 1
         until
            i > n
         loop
            Result.put(read_word_i,i);
            i := i + 1
         end
      end

   load_dword_array(n: INTEGER): ARRAY[INTEGER] is
      require
         n >= 0
      local
         i: INTEGER
      do
         create Result.make(1,n)
         from
            i := 1
         until
            i > n
         loop
            Result.put(read_dword,i)
            i := i + 1
         end
      end

--	load_dword_array_i(n: INTEGER): ARRAY [ INTEGER ] is
--		require
--			n >= 0
--		local
--			i: INTEGER
--		do
--			create Result.make(1,n)
--			from
--				i := 1
--			until
--				i > n
--			loop
--				Result.put(read_dword_i, i);
--				i := i + 1;
--			end
--		end

   read_byte_array(ba: ARRAY [ INTEGER_8 ]; start, n: INTEGER) is
      require
         ba /= Void
         start >= 0 and then n >= 0
      local
         i: INTEGER;
      do
         from
            i := 0
         until
            i >= n	-- WAS >=
         loop
            ba.put(read_byte, start + i)
            i := i + 1
         end
      end

feature {NONE} -- Implementation (deferred)

	save_items(buf: POINTER; n: INTEGER) is
         	-- Save bunch of items
    	require
         	buf /= default_pointer and then n >= 0
         	dir = SB_STREAM_SAVE
      	deferred
      	end

	load_items(buf: POINTER; n: INTEGER) is
		-- Load bunch of items
		require
			buf /= default_pointer and then n >= 0
			dir = SB_STREAM_LOAD
		deferred
		end

feature -- Byte swapping for INTEGER_16, INTEGER and INTEGER_64

	swap_int16(i: INTEGER_16): INTEGER_16 is
		do
			Result := (i |<< 8) | ((i |>> 8) & 0xff)
		end

	swap_int32(i: INTEGER): INTEGER is
		do
			Result := ((i |<< 24) & 0xff000000)
					| ((i |<<  8) & 0x00ff0000)
					| ((i |>>  8) & 0x0000ff00)
					| ((i |>> 24) & 0x000000ff)
		end

	swap_int64(i: INTEGER_64): INTEGER_64 is
		do
			Result := ((i |<< 56) & 0xff00000000000000)
					| ((i |<< 40) & 0x00ff000000000000)
					| ((i |<< 24) & 0x0000ff0000000000)
					| ((i |<<  8) & 0x000000ff00000000)
					| ((i |>>  8) & 0x00000000ff000000)
					| ((i |>> 24) & 0x0000000000ff0000)
					| ((i |>> 40) & 0x000000000000ff00)
					| ((i |>> 56) & 0x00000000000000ff)
		end

end
