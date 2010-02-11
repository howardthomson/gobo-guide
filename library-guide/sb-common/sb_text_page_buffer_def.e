indexing
	author: "Howard Thomson"
	copyright: "[
		--|---------------------------------------------------------|
		--| Copyright (c) Howard Thomson 1999,2000,2004				|
		--| 52 Ashford Crescent										|
		--| Ashford, Middlesex TW15 3EB								|
		--| United Kingdom											|
		--|---------------------------------------------------------|
	]"

	todo: "[
		Adapt for usage of buffer sizes much less than the page size ?
	]"
	
deferred class SB_TEXT_PAGE_BUFFER_DEF

feature -- Attributes

	first,		-- index of first valid character in buffer
	gap_start,	-- index of start of insertion gap
	gap_end,	-- index 1 beyond end of gap
	last		-- last valid character in buffer 
		: INTEGER

	next: like Current

	array_buf: ARRAY [ CHARACTER ]
				-- buffer for sizes <= Max_array_size
				
	page_buf: POINTER
				-- Address of memory mapped page
				
	map_length: INTEGER
				-- length of contiguous mapped memory region

	is_mapped: BOOLEAN
				-- is memory mapping valid ?--

	c_index: INTEGER
			-- index of next character to fetch from content
			-- c_index >=0 and then c_index <= length
				
feature {NONE} -- Creation

	make_size(size: INTEGER) is
		deferred
		ensure
			map_success: is_mapped
		end

--	make_from_file(fd: POSIX_FILE_DESCRIPTOR) is	-- Linux version
--	make_from_file(fd: SB_FILE_HANDLE) is			-- Win32 version
	make_from_file(fd: ANY) is						-- deferred version
		deferred
		ensure
			map_success: is_mapped
		end

feature -- Linkage control

	set_next(n: like next) is
		do
			next := n
		end

feature -- Test !!

	test_print is
		local
			s: STRING
		do
--			create s.from_external(page_buf)
--			s.append("TEST APPENDED STRING")
--			io.put_string(s)
--			io.put_string("%N")
		end

	copy_from(other: like Current) is
			-- TEMP to test operation
		local
			from_p, to_p: C_POINTER
		do
			from_p.set_item(other.page_buf)
			to_p.set_item(page_buf)
			to_p.c_move_char(from_p.item, to_p.item, other.map_length)

			first := other.first
			last := other.last
			gap_start := other.gap_start
			gap_end := other.gap_end
		end

	done_with is
		do
			dispose
		end

	touch is
			-- Read all the buffer bytes:
			-- Access to page-in
		local
			p: C_POINTER
			c: CHARACTER
			i: INTEGER
		do
			from
				p.set_item(page_buf)
				i := 0
			until
				i < map_length
			loop
				c := p.get_char_at(i)
				i := i + 1
			end
		end

feature {NONE} -- Implementation

	size_rounded(n: INTEGER): INTEGER is
			-- use page_size sys call
		do
			Result := ((n + 4095) // 4096) * 4096
		end

	dispose is
			-- Unmap page addressed by page_buf if needed
		deferred
		ensure then
			no_longer_mapped: not is_mapped
		end

invariant
--	length = last - first - (gap_end - gap_start)
end
