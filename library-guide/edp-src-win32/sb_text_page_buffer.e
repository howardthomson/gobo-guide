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
	platform: "Win32"

	todo: "[
		Adapt for usage of buffer sizes much less than the page size ?
	]"
	
class SB_TEXT_PAGE_BUFFER

inherit

	SB_TEXT_PAGE_BUFFER_DEF

	SB_MMAP_INTERFACE

	SB_WAPI_FILE_FUNCTIONS
	SB_WAPI_FILE_MAPPING_FUNCTIONS
	SB_WAPI_FILE_MAPPING_ACCESS_MASKS
	SB_WAPI_VIRTUAL_MEMORY_ALLOCATION_FLAGS
		rename
			mem_free as sb_wapi_mem_free
		end
	SB_WAPI_FILES_AND_DIRS_ACCESS_RIGHTS

create
	make_size, make_from_file

feature {NONE} -- Attributes

	file_mapping_handle: POINTER
		-- Handle for file mapping

feature {NONE} -- Creation

	make_size(size: INTEGER)
		do
--			map_length := size_rounded(size)
--			page_buf := c_mmap(default_pointer, map_length,
--					Prot_read + Prot_write, Map_private + Map_anonymous, -1, 0)
--			is_mapped := True
		end

	make_from_file(fd: SB_FILE_HANDLE)
		require else
			file_is_open: fd.is_open
		do
			last := GetFileSize(fd.handle, default_pointer)
			file_mapping_handle := CreateFileMapping(fd.handle,
													default_pointer,	-- security attributes (opt)
													Page_readonly,		-- Access attributes
													0,0,				-- File size
													default_pointer)	-- Mapping name (opt)
				check valid_mapping_handle: file_mapping_handle /= Invalid_handle_value end
			page_buf := MapViewOfFile(file_mapping_handle, File_map_read, 0, 0, 0)
			if page_buf /= default_pointer then
				is_mapped := True
			end
		ensure then
			is_mapped
		end



feature {NONE} -- Implementation

	dispose
			-- Unmap page addressed by page_buf if needed
		local
			i: INTEGER
		do
			if is_mapped then
--				i := c_munmap(page_buf, map_length)
				is_mapped := False
			end
		end

invariant
--	length = last - first - (gap_end - gap_start)
end
