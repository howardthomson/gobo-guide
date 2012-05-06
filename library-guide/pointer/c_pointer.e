expanded class C_POINTER

inherit
	POINTER_ACCESS
		export
		{ANY} -- TEMP
			c_move_char,
			c_move_byte,
			c_move_short,
			c_move_long,
			c_move_quad,
			c_move_float,
			c_move_double,
			c_at_offset,
	--	{ANY}
			generating_type,
			is_equal,
			standard_is_equal;
		{NONE}
			all
		end

feature

	item: POINTER

	base, limit: POINTER

	set_item(p: like item)
		do
			item := p
		end

	set_item_size(p: like item; size: INTEGER)
		do
			item := p
			base := p
			limit := p + size
		end

	set_base_limit(b, l: POINTER)
		do
			base := b
			limit := l
		end

feature -- get

	get_char  : CHARACTER require valid_access (1, 0) do Result := c_get_char	(item, 0) end
	get_byte  : INTEGER require valid_access (1, 0) do Result := c_get_byte	(item, 0) end
	get_short : INTEGER require valid_access (2, 0) do Result := c_get_short	(item, 0) end
	get_long  : INTEGER require valid_access (4, 0) do Result := c_get_long	(item, 0) end
	get_quad  : INTEGER_64 require valid_access (8, 0) do Result := c_get_quad	(item, 0) end
	get_float : REAL_32 require valid_access (4, 0) do Result := c_get_float	(item, 0) end
	get_double: REAL_64 require valid_access (8, 0) do Result := c_get_double(item, 0) end

	get_int8  : INTEGER_8 require valid_access (1, 0) do Result := c_get_byte	(item, 0) end
	get_int16 : INTEGER_16 require valid_access (2, 0) do Result := c_get_short (item, 0) end
	
	get_char_at		(offs: INTEGER): CHARACTER require valid_access(1, offs) do Result := c_get_char	(item, offs) end
	get_byte_at		(offs: INTEGER): INTEGER require valid_access(1, offs) do Result := c_get_byte	(item, offs) end
	get_short_at	(offs: INTEGER): INTEGER require valid_access(2, offs) do Result := c_get_short	(item, offs) end
	get_long_at		(offs: INTEGER): INTEGER require valid_access(4, offs) do Result := c_get_long	(item, offs) end
	get_quad_at		(offs: INTEGER): INTEGER_64 require valid_access(8, offs) do Result := c_get_quad	(item, offs) end
	get_float_at	(offs: INTEGER): REAL_32 require valid_access(4, offs) do Result := c_get_float	(item, offs) end
	get_double_at	(offs: INTEGER): REAL_64 require valid_access(8, offs) do Result := c_get_double  (item, offs) end

	get_ubyte_at(offs: INTEGER): INTEGER
			-- Get byte unsigned at offset
		require
			valid_access(1, offs)
		do
			Result := c_get_byte(item, offs)
			Result := Result & 0x00ff
		end

feature -- put

	put_char  (v: CHARACTER) require valid_access (1, 0) do c_put_char	(item, 0, v) end
	put_byte  (v: INTEGER) require valid_access (1, 0) do c_put_byte	(item, 0, v) end
	put_short (v: INTEGER) require valid_access (2, 0) do c_put_short	(item, 0, v) end
	put_long  (v: INTEGER) require valid_access (4, 0) do c_put_long	(item, 0, v) end
	put_quad  (v: INTEGER_64) require valid_access (8, 0) do c_put_quad	(item, 0, v) end
	put_float (v: REAL_32) require valid_access (4, 0) do c_put_float	(item, 0, v) end
	put_double(v: REAL_64) require valid_access (8, 0) do c_put_double	(item, 0, v) end

	put_char_at		(v: CHARACTER;	offs: INTEGER) require valid_access(1, offs) do c_put_char	(item, offs, v) end
	put_byte_at		(v: INTEGER;	offs: INTEGER) require valid_access(1, offs) do c_put_byte	(item, offs, v) end
	put_short_at	(v: INTEGER;	offs: INTEGER) require valid_access(2, offs) do c_put_short	(item, offs, v) end
	put_long_at		(v: INTEGER;	offs: INTEGER) require valid_access(4, offs) do c_put_long	(item, offs, v) end
	put_quad_at		(v: INTEGER_64;	offs: INTEGER) require valid_access(8, offs) do c_put_quad	(item, offs, v) end
	put_float_at	(v: REAL_32;	offs: INTEGER) require valid_access(4, offs) do c_put_float	(item, offs, v) end
	put_double_at	(v: REAL_64;	offs: INTEGER) require valid_access(8, offs) do c_put_double(item, offs, v) end

feature -- validation

	valid_if_no_limits: BOOLEAN = True

	valid_access(size, offs: INTEGER): BOOLEAN
		local
			p: POINTER
		do
			if base /= default_pointer and then limit /= default_pointer then
				p := item + offs
				if compare(p, base) >= 0 and then compare((p + (size - 1)), limit) < 0 then
					Result := True
				end
			elseif valid_if_no_limits then
				Result := True -- No Check if no valid base/limit to check against!
			else
				Result := False
			end
		end

feature -- move/copy

--	move_s(from, to,

feature -- adjust pointer

	advance(by: INTEGER)
		do
			item := item + by
		end

feature -- comparison

	compare_other(other: like Current): INTEGER
			-- Return -1, 0, +1 for Current <, =, > other
		do
			Result := compare(item, other.item)
		end

	compare(p1, p2: POINTER): INTEGER
		do
			Result := c_cmp_pointer(p1, p2)
		end

feature -- Memory allocation

	calloc(size: INTEGER)
		require
			implemented: false
		do
--			fx_trace(0, <<"C_POINTER::calloc -- INVALID FUNCTION !!!">>)
--			item := c_calloc(size, 1)
		ensure
			item /= default_pointer
			implemented: false
		end

--	c_calloc(s, n: INTEGER): POINTER is
--		external "C signature (size_t, size_t): EIF_POINTER"
--		alias "calloc"
--		end

end