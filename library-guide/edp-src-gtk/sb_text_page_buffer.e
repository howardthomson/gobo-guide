note
	author: "Howard Thomson"
	copyright: "[
		--|---------------------------------------------------------|
		--| Copyright (c) Howard Thomson 1999,2000,2004				|
		--| 52 Ashford Crescent										|
		--| Ashford, Middlesex TW15 3EB								|
		--| United Kingdom											|
		--|---------------------------------------------------------|
	]"
	platform: "Posix"

	todo: "[
		Adapt for usage of buffer sizes much less than the page size ?
	]"

class SB_TEXT_PAGE_BUFFER

inherit

	SB_TEXT_PAGE_BUFFER_DEF

	SB_MMAP_INTERFACE

create
	make_size	--, make_from_file


feature {NONE} -- Creation

	make_size (size: INTEGER)
		do
			map_length := size_rounded(size)
			page_buf := c_mmap(default_pointer, map_length,
					Prot_read + Prot_write, Map_private + Map_anonymous, -1, 0)
			is_mapped := True
		end

--	make_from_file (fd: SB_FILE_HANDLE)
--		do
--			last := fd.count
--			map_length := size_rounded(last)
--			page_buf := c_mmap(default_pointer, map_length,
--					Prot_read + Prot_write, Map_private, fd.fd, 0)
--			is_mapped := True
--		end

	dispose
			-- Unmap page addressed by page_buf if needed
		local
			i: INTEGER
		do
			if is_mapped then
				i := c_munmap(page_buf, map_length)
				is_mapped := False
			end
		end

invariant
--	length = last - first - (gap_end - gap_start)
end
