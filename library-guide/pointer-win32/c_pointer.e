expanded class C_POINTER

inherit
	POINTER_ACCESS
		export
		{ANY} -- TEMP
			is_equal,
			standard_is_equal,
			generating_type,
			
			c_move_char,
			c_move_byte,
			c_move_short,
			c_move_long,
			c_move_quad,
			c_move_float,
			c_move_double,
			c_at_offset
		{NONE}
			all
		end

feature

	item: POINTER

	base, limit: POINTER

	set_item(p: like item) is
		do
			item := p
		end

	set_item_size(p: like item; size: INTEGER) is
		do
			item := p
			base := p
			limit := p + size
		end

	set_base_limit(b, l: POINTER) is
		do
			base := b
			limit := l
		end

feature -- get

	get_char  : CHARACTER	is require valid_access (1, 0) do Result := c_get_char	(item, 0) end
	get_byte  : INTEGER		is require valid_access (1, 0) do Result := c_get_byte	(item, 0) end
	get_short : INTEGER		is require valid_access (2, 0) do Result := c_get_short	(item, 0) end
	get_long  : INTEGER		is require valid_access (4, 0) do Result := c_get_long	(item, 0) end
--	get_quad  : BIT 64		is require valid_access (8, 0) do Result := c_get_quad	(item, 0) end
	get_float : DOUBLE		is require valid_access (4, 0) do Result := c_get_float	(item, 0) end
	get_double: DOUBLE		is require valid_access (8, 0) do Result := c_get_double(item, 0) end

	get_int8  : INTEGER_8	is require valid_access (1, 0) do Result := c_get_byte	(item, 0) end
	get_int16 : INTEGER_16	is require valid_access (2, 0) do Result := c_get_short	(item, 0) end
	
	get_char_at		(offs: INTEGER): CHARACTER	is require valid_access(1, offs) do Result := c_get_char	(item, offs) end
	get_byte_at		(offs: INTEGER): INTEGER	is require valid_access(1, offs) do Result := c_get_byte	(item, offs) end
	get_short_at	(offs: INTEGER): INTEGER	is require valid_access(2, offs) do Result := c_get_short	(item, offs) end
	get_long_at		(offs: INTEGER): INTEGER	is require valid_access(4, offs) do Result := c_get_long	(item, offs) end
--	get_quad_at		(offs: INTEGER): BIT 64		is require valid_access(8, offs) do Result := c_get_quad	(item, offs) end
	get_float_at	(offs: INTEGER): DOUBLE		is require valid_access(4, offs) do Result := c_get_float	(item, offs) end
	get_double_at	(offs: INTEGER): DOUBLE		is require valid_access(8, offs) do Result := c_get_double  (item, offs) end

feature -- put

	put_char  (v: CHARACTER)	is require valid_access (1, 0) do c_put_char	(item, 0, v) end
	put_byte  (v: INTEGER)		is require valid_access (1, 0) do c_put_byte	(item, 0, v) end
	put_short (v: INTEGER)		is require valid_access (2, 0) do c_put_short	(item, 0, v) end
	put_long  (v: INTEGER)		is require valid_access (4, 0) do c_put_long	(item, 0, v) end
--	put_quad  (v: BIT 64)		is require valid_access (8, 0) do c_put_quad	(item, 0, v) end
	put_float (v: REAL)		is require valid_access (4, 0) do c_put_float	(item, 0, v) end
	put_double(v: DOUBLE)		is require valid_access (8, 0) do c_put_double	(item, 0, v) end

	put_char_at		(v: CHARACTER;	offs: INTEGER)	is require valid_access(1, offs) do c_put_char	(item, offs, v) end
	put_byte_at		(v: INTEGER;	offs: INTEGER)	is require valid_access(1, offs) do c_put_byte	(item, offs, v) end
	put_short_at	(v: INTEGER;	offs: INTEGER)	is require valid_access(2, offs) do c_put_short	(item, offs, v) end
	put_long_at		(v: INTEGER;	offs: INTEGER)	is require valid_access(4, offs) do c_put_long	(item, offs, v) end
--	put_quad_at		(v: BIT 64;		offs: INTEGER)	is require valid_access(8, offs) do c_put_quad	(item, offs, v) end
	put_float_at	(v: REAL;		offs: INTEGER)	is require valid_access(4, offs) do c_put_float	(item, offs, v) end
	put_double_at	(v: DOUBLE;		offs: INTEGER)	is require valid_access(8, offs) do c_put_double(item, offs, v) end

feature -- validation

	valid_access(size, offs: INTEGER): BOOLEAN is
		local
			p: POINTER
		do
			if base /= default_pointer and then limit /= default_pointer then
				p := item + offs
				if compare(p, base) >= 0 and then compare((p + (size - 1)), limit) < 0 then
					Result := True
				end
			else
			--	Result := True -- No Check if no valid base/limit to check against!
			end
		end

feature -- move/copy

--	move_s(from, to,

feature -- adjust pointer

	advance(by: INTEGER) is
		do
			item := item + by
		end

feature -- comparison

	compare_other(other: like Current): INTEGER is
			-- Return -1, 0, +1 for Current <, =, > other
		do
			Result := compare(item, other.item)
		end

	compare(p1, p2: POINTER): INTEGER is
		do
			Result := c_cmp_pointer(p1, p2)
		end

feature -- Memory allocation

	calloc(size: INTEGER) is
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