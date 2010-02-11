indexing

	author:	"Howard Thomson"
	copyright: "[
		--|---------------------------------------------------------|
		--| Copyright (c) Howard Thomson 1999,2000,2004					|
		--| 52 Ashford Crescent										|
		--| Ashford, Middlesex TW15 3EB								|
		--| United Kingdom											|
		--|---------------------------------------------------------|
	]"

	platform: "Win32"

class SB_MMAP_INTERFACE

feature

--	Prot_none : INTEGER is 0	-- Page can be read.
--	Prot_read : INTEGER is 1	-- Page can be written.
--	Prot_write: INTEGER is 2	-- Page can be executed.
--	Prot_exec : INTEGER is 4	-- Page can not be accessed.

	-- Sharing types (must choose one and only one of these).
--	MAP_SHARED	 : INTEGER is 1		-- Share changes.
--	MAP_PRIVATE	 : INTEGER is 2		-- Changes are private.
--	MAP_FIXED	 : INTEGER is 16	-- Interpret addr exactly.
--	MAP_ANONYMOUS: INTEGER is 32	-- Don't use a file.


--	c_mmap(start: POINTER; length: INTEGER; prot, flags, fd, offset: INTEGER): POINTER is
--		external "C"
--		alias "mmap"
--		end

--	c_munmap(start: POINTER; length: INTEGER): INTEGER is
--		external "C"
--		alias "munmap"
--		end

end