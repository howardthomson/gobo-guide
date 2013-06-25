--|---------------------------------------------------------|
--| Copyright (c) Howard Thomson 1999,2000					|
--| 52 Ashford Crescent										|
--| Ashford, Middlesex TW15 3EB								|
--| United Kingdom											|
--|---------------------------------------------------------|
note

	todo: "[
		FIX GEC complaints Lines 64/65/70/72 (+5)
	]"
deferred class EDP_CLASS_FILE

-- One object for each unique file containing class text in the repository

inherit

	EDP_FILE
		rename
			make as file_make
		end

	STRING_HANDLER	-- For edp_string creation

-- create { EDP_CLASS_FILE_SET }	--


feature -- Attributes

	scanner:	SCANNER

--	file_modified: EDP_DATE
--	file_crc_text: EDP_CRC	-- CRC signature over all text
--	file_crc_scan: EDP_CRC -- signature of all eiffel-significant symbols

feature -- Status

	scanned: BOOLEAN
		do
--#			Result := scanner /= Void and then scanner.scanned_ok
		end

feature -- Scanning

	edp_str: STRING

	scan
			-- GOBO Gelex scanner version
		require
			not_scanned: not scanned
			valid_filename: filename /= Void and then filename.count > 0
		local
			fd: SB_FILE_HANDLE
		--	src: SB_TEXT_PAGE_BUFFER
			storage: NATIVE_ARRAY [ CHARACTER ]
		do
			if scanner /= Void then
			--	scanner.re_scan
			else
				create fd.open_read (filename)
				create src.make_from_file (fd)

				create edp_str.make (src.last + 1)
				edp_str.from_c_substring (src.page_buf, 1, src.last)

				create scanner.make_from_string (Current, edp_str)	--#

				edp_str := Void

				fd.close
				src.done_with

				-- Check for load_fail XXX
				if not scanned then
		--#			print("LOAD-FAIL: "); print(name.name); print("%N")
				end
			end
		end


end -- class EDP_CLASS_FILE
