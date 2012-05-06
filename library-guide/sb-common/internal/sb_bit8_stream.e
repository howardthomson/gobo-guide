note
	description:"Persistent store definition"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete, but require some testing and thinking"

class SB_BIT8_STREAM

inherit

	SB_STREAM
      	rename
         	open as stream_open
      	redefine
         	make,
         	close,
         	position,
         	read_byte,
         	read_byte_i,
         	write_byte,
         	write_byte_i
      	end

create

   	make

feature -- Creation

   	make
      	do
         	data := Void
         	Precursor
      	end

feature -- Data

   	data: ARRAY [ INTEGER_8 ]

feature -- Actions

   	open (dt: ARRAY[INTEGER_8]; save_or_load: INTEGER)
    		-- Open memory store
      	do
         	if dt /= Void then
            	data := dt
         	else
            	create data.make (1, 0)
         	end
         	stream_open (save_or_load)
      	end

   close
         -- Close memory store
      do
         data := Void
         Precursor
      end

	position (p: INTEGER)
         	-- Move to position
      	require else
         	data /= Void
      	local
         	res: BOOLEAN
      	do
         	if code = SB_STREAM_OK then
            	res := True
            	if dir = SB_STREAM_SAVE then
               		if p + data.lower > data.upper then
                  		set_space(p + 1);
                  		if p + data.lower > data.upper then
                     		code := SB_STREAM_FULL;
                     		res := False;
                  		end
               		end
            	else
               		if p + data.lower > data.upper then
                  		code := SB_STREAM_END;
                  		res := False;
               		end
            	end
         	end
         	if res then
            	pos := p;
         	end
		end

   set_space (sp: INTEGER)
         -- Set available space
      require
         data /= Void
         sp >= 0
      do
         if sp /= data.upper - data.lower + 1 then
            data.resize(data.lower, data.lower + sp - 1);
         end
      end


   give_buffer (buffer: ARRAY[INTEGER_8])
      require
         buffer /= Void
         -- Give buffer to stream
      do
         data := buffer;
      end

feature -- Save

   write_byte (b: INTEGER_8)
      require else
         data /= Void
         code = SB_STREAM_OK
      do
         data.force(b, data.lower + pos);
         pos := pos +1;
      end

	write_byte_i (b: INTEGER)
		require else
			data /= Void
			code = SB_STREAM_OK
		local
			t: INTEGER_8;
		do
--			c_inline_c ("_b8 = _b;%N");
			data.force(t, data.lower + pos);
			pos := pos +1;
		end

feature -- Load

	read_byte: INTEGER_8
		require else
			data /= Void
			code = SB_STREAM_OK
		do
			if pos + data.lower > data.upper then
				code := SB_STREAM_END
			else
				Result := data.item(data.lower + pos)
				Result := Result & 0x00ff
				pos := pos+1;
--				fx_trace(0, <<"SB_BIT8_STREAM::read_byte: Result = ", Result.out>>)
			end
		end

	read_byte_i: INTEGER
		require else
			data /= Void
			code = SB_STREAM_OK
		do
			if pos + data.lower > data.upper then
				code := SB_STREAM_END
			else
				Result := (data.item(data.lower+pos)).to_integer;
				pos := pos+1;
			end
		ensure then
			implemented: false
		end

feature {NONE} -- Implementation

   save_items (buf: POINTER; n: INTEGER)
         -- Save bunch of items
		require else
			implemented: false
      do
--         if code = SB_STREAM_OK then
--            if n > 0 then
--               if pos + data.lower + n > data.upper + 1 then
--                  set_space(pos+n);
--                  if pos + data.lower + n <= data.upper + 1 then
--                     mem.collection_off
--                     mem.mem_copy (data.area.item_address (0) + pos,buf,n);
--                     mem.collection_on
--                  end
--               end
--            end
--         end
      end

	load_items (buf: POINTER; n: INTEGER)
			-- Load bunch of items
		local
			b, d: POINTER;
			p, nn: INTEGER;
			cp: C_POINTER
		do
			if code = SB_STREAM_OK then
				if n > 0 then
					if pos + data.lower + n > data.upper + 1 then
						code := SB_STREAM_END
					else
				--		mem.collection_off
						d := data.area.item_address (0)
						b := buf
						p := pos
						nn := n
						cp.c_move_char (cp.c_at_offset (d, pos), b, nn)
				--		mem.collection_on
					end
				end
			end
		end

end
