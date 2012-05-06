note

	author: "Howard Thomson"

	copyright: "[
		--|---------------------------------------------------------|
		--| Copyright (c) Howard Thomson 1999,2000,2006				|
		--| 52 Ashford Crescent										|
		--| Ashford, Middlesex TW15 3EB								|
		--| United Kingdom											|
		--|---------------------------------------------------------|
	]"

	todo: "[
		Establish whether Windows supports an equivalent concept of a file's
		Inode number, uniquely identifiying a file within a file-system.
		Note that the MinGW include file 'stat.h' indicates that the st_ino
		field of the statbuf is always 0, implying that any such number is
		not available via that route.
	]"

deferred class EDP_FILE

-- Represents a single operating system file
-- Possibly with multiple path names: TODO !!

-- creation

	-- No creation permitted

feature

	file_index:	INTEGER	-- Unique index of this object in EDP_FILE_NAMES.files

	os_device:	INTEGER
	os_file_id:	INTEGER	-- Operating System unique file identifying numbers

	is_writeable: BOOLEAN	-- Is file writeable/updateable ?

	filename_id: INTEGER	-- id of filename string in EDP_FILE_NAMES.strings

	filename: STRING
		deferred
		end

feature { NONE } -- shared singleton

	all_files: EDP_FILE_NAMES
		once
			create Result.make
		end

feature { NONE }	-- Creation

	make (fname: STRING)
		local
			fi:	INTEGER	-- filename index
			xi: INTEGER	-- existing file index
			fn: EDP_CLASS_FILE
		do
	--		filename_id := all_files.strings # fname
	--		fn ?= Current
	--		all_files.files.add_tail(fn)
	--		file_index := all_files.files.count
		end

end -- class EDP_FILE
