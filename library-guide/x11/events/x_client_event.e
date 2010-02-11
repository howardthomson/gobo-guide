class X_CLIENT_EVENT
	-- Interface to Xlib's XClientEvent structure

inherit 

	X_ANY_EVENT

creation 

	make,
	from_x_struct

feature -- Access

--		Atom message_type;
--		int format;
--		union {
--			char b[20];
--			short s[10];
--			long l[5];
--			} data;


	message_type: INTEGER is
		do
			Result := c_message_type (to_external)
		end

	format: INTEGER is
		do
			Result := c_format (to_external)
		end
	
	data_b (i: INTEGER): INTEGER is
			-- Get 'byte' data element indexed (from 0) at 'i'
		require
			valid_index: i >= 0 and then i < 20
		local
			p: C_POINTER
		do
			p.set_item_size (to_external, size)
			p.advance (data_offset)
			Result := p.get_byte_at (i)
		end

	data_w (i: INTEGER): INTEGER is
			-- Get 'short' data element indexed (from 0) at 'i'
		require
			valid_index: i >= 0 and then i < 10
		local
			p: C_POINTER
		do
			p.set_item_size (to_external, size)
			p.advance (data_offset)
			Result := p.get_short_at (i * 2)
		end

	data_l (i: INTEGER): INTEGER is
			-- Get 'long' data element indexed (from 0) at 'i'
		require
			valid_index: i >= 0 and then i < 10
		do
			lmp.set_from_pointer (to_external, size)
			if {PLATFORM}.pointer_bytes = 8 then
				Result := lmp.read_integer_64 (data_offset + (i * 8)).as_integer_32
			else
				Result := lmp.read_integer_32 (data_offset + (i * 4))
			end
		end

feature -- Modification

	set_message_type (i: INTEGER) is
		do
			c_set_message_type (to_external, i)
		ensure
			message_type = i
		end

	set_format (i: INTEGER) is
		do
			c_set_format (to_external, i)
		ensure
			format = i
		end

	set_data_b (d: INTEGER; i: INTEGER) is
			-- Set 'byte' data element indexed (from 0) at 'i'
		require
			valid_index: i >= 0 and then i < 20
		local
			p: C_POINTER
		do
			p.set_item (to_external)
			p.advance (data_offset)
			p.put_byte_at (d, i)
		end

	set_data_w (d: INTEGER; i: INTEGER) is
			-- Set 'byte' data element indexed (from 0) at 'i'
		require
			valid_index: i >= 0 and then i < 10
		local
			p: C_POINTER
		do
			p.set_item (to_external)
			p.advance (data_offset)
			p.put_short_at (d, i * 2)
		end

	set_data_l (d: INTEGER; i: INTEGER) is
			-- Set 'byte' data element indexed (from 0) at 'i'
		require
			valid_index: i >= 0 and then i < 5
		local
			p: C_POINTER
		do
			p.set_item (to_external)
			p.advance (data_offset)
			p.put_long_at (d, i * 4)
		end

feature {NONE} -- Managed Pointer once function

	lmp: MANAGED_POINTER is
		once
			create Result.share_from_pointer (default_pointer, 0)
		end

	data_offset: INTEGER is
		once
			if {PLATFORM}.pointer_bytes = 8 then
					-- 64-bit data layout
				Result := 56
			else
				Result := 28
			end
		end

feature {NONE} -- external functions

	c_message_type	(p: POINTER): INTEGER is	external "C struct XClientMessageEvent access message_type use <X11/Xlib.h>"	end
	c_format		(p: POINTER): INTEGER is	external "C struct XClientMessageEvent access format use <X11/Xlib.h>"			end
		
	c_set_message_type	(p: POINTER; i: INTEGER) is    external "C struct XClientMessageEvent access message_type type Atom use <X11/Xlib.h>"	end
	c_set_format		(p: POINTER; i: INTEGER) is    external "C struct XClientMessageEvent access format       type int  use <X11/Xlib.h>"   end
	
end
