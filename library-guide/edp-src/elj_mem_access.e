indexing

    description:

        "access and casts to/from raw byte data"

    library:    "ELJ"
    author:     "Uwe Sander"
    copyright:  ""
    license:    "Eiffel Forum Freeware License v1 (see forum.txt)"
    date:       "$Date: 2001/11/26 19:07:32 $"
    revision:   "$Revision: 1.7 $"
    last:       "$Author: usander $"

	todo: "[
		Adapt for SE and ISE
	]"


deferred class ELJ_MEM_ACCESS

inherit	--insert

	PLATFORM	-- For SE2.2b
	ANY			-- For SE2.2b5, to define is_equal
feature -- read access

	Xas_large_integer (a_offset: INTEGER): INTEGER_64 is
			-- returns the contents of the buffer at offset
			-- a_offset as integer
		require
			valid_offset: fits_into_buffer (a_offset, integer_length * 2)
			has_storage: pointer /= default_pointer
		local
			ptr: C_POINTER
		do
			ptr.set_item (pointer)
			Result := ptr.get_quad_at (a_offset)
		ensure
--			implemented: false
		end -- as_large_integer
		
	as_integer (a_offset: INTEGER): INTEGER is
			-- returns the contents of the buffer at offset
			-- a_offset as integer
		require
			valid_offset: fits_into_buffer (a_offset, integer_length)
			has_storage: pointer /= default_pointer	
		local
			ptr: C_POINTER
		do
			ptr.set_item (pointer)
			Result := ptr.get_long_at (a_offset)
		end -- as_integer
		
	as_character (a_offset: INTEGER): CHARACTER is
			-- returns the contents of the buffer at offset
			-- a_offset as character
		require
			valid_offset: fits_into_buffer (a_offset, character_length)
			has_storage: pointer /= default_pointer
		local
			ptr: C_POINTER
		do
			ptr.set_item (pointer)
			Result := ptr.get_char_at(a_offset)
		end -- as_character
		
	as_integer_8 (a_offset: INTEGER): INTEGER_8 is
			-- returns the contents of the buffer at offset
			-- a_offset as character
		require
			valid_offset: fits_into_buffer (a_offset, character_length)
			has_storage: pointer /= default_pointer
		local
			ptr: C_POINTER
		do
			ptr.set_item (pointer)
			Result := ptr.get_byte_at (a_offset).as_integer_8
		end -- as_integer_8
		
	as_real (a_offset: INTEGER): REAL is
			-- returns the contents of the buffer at offset
			-- a_offset as real
		require
			valid_offset: fits_into_buffer (a_offset, real_length)
			has_storage: pointer /= default_pointer
		local
			ptr: C_POINTER
		do
			ptr.set_item (pointer)
			Result := ptr.get_float_at(a_offset)
		end -- as_real
		
	as_double (a_offset: INTEGER): REAL is
			-- returns the contents of the buffer at offset
			-- a_offset as double
		require
--#			valid_offset: fits_into_buffer (a_offset, double_length)
			has_storage: pointer /= default_pointer
		local
			ptr: C_POINTER
			off: INTEGER
			res: REAL
		do
			ptr.set_item (pointer)
			Result := ptr.get_double_at(a_offset)
		end -- as_double
		
--	Xas_string (a_offset, a_length: INTEGER): STRING is
--			-- returns the contents of the buffer at offset
--			-- a_offset as string
--		require
--			valid_offset: fits_into_buffer (a_offset, a_length)
--			has_storage: pointer /= default_pointer
--		local
--			ptr: POINTER
--			off: INTEGER
--			len: INTEGER
--			res: POINTER
--		do
--			Result := result_buffer
--			Result.make_filled ('%U', a_length)
--			
--			ptr := pointer
--			off := a_offset
--			len := a_length
--			res := Result.to_external
--			
--			c_inline_c ("memcpy(_res, ((char*) _ptr) + _off, _len);%N")
--		end -- as_string
		
	as_short (a_offset: INTEGER): INTEGER is
			-- returns the contents of the buffer at offset
			-- a_offset as integer
			-- if short differs in length from integer, only the
			-- count of bytes which make a short are used
		require
			valid_offset: fits_into_buffer (a_offset, short_length)
			has_storage: pointer /= default_pointer
		local
			ptr: C_POINTER
		do
			ptr.set_item (pointer)
			Result := ptr.get_short_at(a_offset)
		end -- as_short

	as_pointer (a_offset: INTEGER): POINTER is
			-- returns the contents of the buffer at offset
			-- a_offset as pointer
		require
		--	valid_offset: fits_into_buffer (a_offset, short_length)
			has_storage: pointer /= default_pointer
		local
			ptr: POINTER
			off: INTEGER
			res: POINTER
		do
			ptr.set_item (pointer)
			off := a_offset
			
--			c_inline_c ("_res = (*(void**)(((char*) _ptr) + _off));%N")
			
			Result := res
		end -- as_short


	Xas_raw (a_offset: INTEGER; a_val: POINTER; a_count: INTEGER) is
			-- results in a simple memcpy
		require
			valid_offset: fits_into_buffer (a_offset, a_count)
			has_storage: pointer /= default_pointer
		local
			ptr: POINTER
			off: INTEGER
			len: INTEGER
			val: POINTER
		do
			ptr.set_item (pointer)
			off := a_offset
			len := a_count
			val := a_val
			
--			c_inline_c ("memcpy(_val, ((char*) _ptr) + _off, _len);%N")
		end -- set_raw
	
	Xraw_pointer (a_offset: INTEGER): POINTER is
			-- Address of buffer at offset
		require
			has_storage: pointer /= default_pointer
		local
			ptr: POINTER
			off: INTEGER
			res: POINTER
		do
			ptr.set_item (pointer)
			off := a_offset
			
--			c_inline_c ("_res = (void*)(((char*) _ptr) + _off);%N")
			
			Result := res
		end -- raw_pointer

feature -- write access

	Xset_large_integer (a_offset: INTEGER; a_val: INTEGER_64) is
			-- sets the contents of the buffer at offset
			-- a_offset as integer
		require
			valid_offset: fits_into_buffer (a_offset, integer_length)
			has_storage: pointer /= default_pointer
		local
			ptr: POINTER
			off: INTEGER
--			val: BIT 64
		do
			ptr.set_item (pointer)
			off := a_offset
--			val := a_val.storage

--			c_inline_c ("*(__int64*)(((char*) _ptr) + _off) = *((__int64*)&_val);%N")
		ensure
--			value_set: as_large_integer (a_offset) = a_val
		end -- set_large_integer
		
	set_integer (a_offset: INTEGER; a_val: INTEGER) is
			-- sets the contents of the buffer at offset
			-- a_offset as integer
		require
			valid_offset: fits_into_buffer (a_offset, integer_length)
			has_storage: pointer /= default_pointer
		local
			ptr: C_POINTER
		do
			ptr.set_item (pointer)
			ptr.put_long_at(a_val, a_offset)
		ensure
			value_set: as_integer (a_offset) = a_val
		end -- set_integer

	set_integer_8(a_offset: INTEGER; a_val: INTEGER_8) is
			-- sets the contents of the buffer at offset
			-- a_offset as INTEGER_8
		require
			valid_offset: fits_into_buffer (a_offset, character_length)
			has_storage: pointer /= default_pointer
		local
			ptr: C_POINTER
		do
			ptr.set_item (pointer)
			ptr.put_byte_at(a_val, a_offset)
		ensure
	--		value_set: as_integer_8 (a_offset) = a_val	
		end

	set_character (a_offset: INTEGER; a_val: CHARACTER) is
			-- sets the contents of the buffer at offset
			-- a_offset as character
		require
			valid_offset: fits_into_buffer (a_offset, character_length)
			has_storage: pointer /= default_pointer
		local
			ptr: C_POINTER
		do
			ptr.set_item (pointer)
			ptr.put_char_at(a_val, a_offset)
		ensure
			value_set: as_character (a_offset) = a_val
		end -- set_character
		
	XXset_real (a_offset: INTEGER; a_val: REAL) is
			-- sets the contents of the buffer at offset
			-- a_offset as real
		require
			valid_offset: fits_into_buffer (a_offset, real_length)
			has_storage: pointer /= default_pointer
		local
			ptr: POINTER
			off: INTEGER
			val: REAL
		do
			ptr.set_item (pointer)
			off := a_offset
			val := a_val

--			c_inline_c ("*(float*)(((char*) _ptr) + _off) = _val;%N")
		ensure
			value_set: as_real (a_offset) = a_val
		end -- set_real
		
	XXset_double (a_offset: INTEGER; a_val: REAL) is
			-- sets the contents of the buffer at offset
			-- a_offset as double
		require
--#			valid_offset: fits_into_buffer (a_offset, double_length)
			has_storage: pointer /= default_pointer
		local
			ptr: POINTER
			off: INTEGER
			val: REAL
		do
			ptr.set_item (pointer)
			off := a_offset
			val := a_val

--			c_inline_c ("*(double*)(((char*) _ptr) + _off) = _val;%N")
		ensure
			value_set: as_double (a_offset) = a_val
		end -- set_double
		
--	Xset_string (a_offset: INTEGER; a_val: STRING) is
--			-- sets the contents of the buffer at offset
--			-- a_offset as string
--		require
--			string_to_set: a_val /= Void
--			valid_offset: fits_into_buffer (a_offset, a_val.count)
--			has_storage: pointer /= default_pointer
--		local
--			ptr: POINTER
--			off: INTEGER
--			len: INTEGER
--			val: POINTER
--		do
--			ptr.set_item (pointer)
--			off := a_offset
--			len := a_val.count
--			val := a_val.area.item_address (0)
--			
--			c_inline_c ("memcpy(((char*) _ptr) + _off, _val, _len);%N")
--		ensure
--			value_set: a_val.is_equal (as_string (a_offset, a_val.count))
--		end -- set_string
		
	set_short (a_offset: INTEGER; a_val: INTEGER) is
			-- sets the contents of the buffer at offset
			-- a_offset as short
		require
			valid_offset: fits_into_buffer (a_offset, short_length)
			has_storage: pointer /= default_pointer
		local
			ptr: C_POINTER
		do
			ptr.set_item (pointer)
			ptr.put_short_at(a_val, a_offset)
		ensure
			value_set: as_short (a_offset) = a_val
		end -- set_short

	set_pointer(a_offset: INTEGER; a_val: POINTER) is
			-- sets the content of buffer at offset as pointer
		local
			ptr: POINTER
			off: INTEGER
			val: POINTER
		do
			ptr.set_item (pointer)
			off := a_offset
			val := a_val

--			c_inline_c ("*(void **)(((char*) _ptr) + _off) = _val;%N")
		ensure
			value_set: as_pointer (a_offset) = a_val
		end -- set_pointer
	
--	Xset_raw (a_offset: INTEGER; a_val: POINTER; a_count: INTEGER) is
--			-- results in a simple mecpy
--		require
--			valid_offset: fits_into_buffer (a_offset, a_count)
--			has_storage: pointer /= default_pointer
--		local
--			ptr: POINTER
--			off: INTEGER
--			len: INTEGER
--			val: POINTER
--		do
--			ptr.set_item (pointer)
--			off := a_offset
--			len := a_count
--			val := a_val
--			
--			c_inline_c ("memcpy(((char*) _ptr) + _off, _val, _len);%N")
--		end -- set_raw
	
	XXchange_size_at (a_offset, a_old_len, a_new_len: INTEGER) is
		require
			has_storage: pointer /= default_pointer
			offset_not_negative: a_offset >= 0
			meaningful_old_length: a_old_len > 0
			meaningful_new_length: a_new_len > 0
			valid_offset: fits_into_buffer (a_offset, a_old_len)
		local
			ptr:		POINTER
			off:		INTEGER
			len:		INTEGER
			sze:		INTEGER
			old_len:	INTEGER
			new_len:	INTEGER
			old_sze:	INTEGER
		do
			if a_old_len /= a_new_len then
				off := a_offset
				ptr := pointer

				old_len := a_old_len
				new_len := a_new_len
				
				len := new_len - old_len
				
				sze := size + len
				old_sze := size

			--	set_buffer_size (sze)
				ptr := pointer
				
				len := old_sze - (a_offset + a_old_len)

--				c_inline_c ("memmove(((char*) _ptr) + _off + _new_len, ((char*) _ptr) + _off + _old_len, _len);%N")
			end -- if
		ensure
			implemented: false
		end -- change_size_at		
		
feature

	fits_into_buffer (a_offset, a_length: INTEGER): BOOLEAN is
			-- internal validation routine
		do
			Result := a_offset + a_length < size	-- ## WAS <= size
		end -- fits_into_buffer
	
	integer_length: INTEGER is
			-- returns length of an integer in bytes
			-- calculation bases on integer_bits from PLATFORM
		do
			Result := Integer_bits // 8
		end -- integer_length
		
	real_length: INTEGER is
			-- returns length of a real in bytes
			-- calculation bases on real_bits from PLATFORM
		do
			Result := Real_bits // 8
		end -- real_length
		
--	double_length: INTEGER is
--			-- returns length of a double in bytes
--			-- calculation bases on double_bits from PLATFORM
--		do
--			Result := Double_bits // 8
--		end -- double_length
		
	character_length: INTEGER is
			-- returns length of a character in bytes
			-- calculation bases on character_bits from PLATFORM
		do
			Result := Character_bits // 8
		end -- character_length

	short_length: INTEGER is
			-- returns length of a short in bytes
			-- calculation checks wether an int consists of
			-- two or four bytes
		do
			if integer_length = 4 then
				Result := integer_length // 2
			else
				Result := integer_length
			end -- if
		end -- short_length

feature -- the memory accesses

	pointer: POINTER is
		deferred
		end -- pointer
	
	size: INTEGER is
		deferred
		end -- size

feature {NONE}

--	set_buffer_size (a_value: INTEGER) is
		-- it is up to the implementation of 'set_buffer_size' how to handle
		-- requests that would result in shrinking the available space;
		-- a suggestion may be never to shrink the memory, but to set
		-- attribute 'size'and store the real buffer size in another attribute
--		deferred
--		end -- set_size

feature -- internal string buffering

	string_buffer: STRING is
		once
			create Result.make(256)
		end
	
	result_buffer: STRING is
		do
			Result := string_buffer
		end -- result_buffer

	elj_pass_pointer(p: POINTER): POINTER is
		do
			Result := p
		end

end -- deferred class ELJ_MEM_ACCESS