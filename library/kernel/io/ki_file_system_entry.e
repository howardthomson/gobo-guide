indexing

	description:

		"Interface for file system entries (files, directories, ...)"

	author:     "Eric Bezault <ericb@gobosoft.com>"
	copyright:  "Copyright (c) 2001, Eric Bezault and others"
	license:    "Eiffel Forum Freeware License v1 (see forum.txt)"
	date:       "$Date$"
	revision:   "$Revision$"

deferred class KI_FILE_SYSTEM_ENTRY

feature {NONE} -- Initialization

	make (a_name: STRING) is
			-- Create a new file system entry object.
		require
			a_name_not_void: a_name /= Void
		deferred
		ensure
			name_set: name = a_name
			is_closed: is_closed
		end

feature -- Access

	name: STRING is
			-- File system entry name
		deferred
		ensure
			name_not_void: Result /= Void
		end

feature -- Status report

	is_open: BOOLEAN is
			-- Has file system entry been opened?
		deferred
		end

	is_closed: BOOLEAN is
			-- Is file system entry closed?
		deferred
		ensure
			definition: Result = not is_open
		end

feature -- Basic operations

	open is
			-- Try to open file system entry. Set `is_open'
			-- to true if operation was successful.
		require
			is_closed: is_closed
		deferred
		end

	close is
			-- Close file system entry if it is closable,
			-- let it open otherwise.
		require
			not_closed: not is_closed
		deferred
		end

	delete is
			-- Delete current file system entry.
			-- Do nothing if the entry could not be deleted
			-- (for example if the entry does not exist or
			-- if a directory is not empty).
		require
			is_closed: is_closed
		deferred
		end

end -- class KI_FILE_SYSTEM_ENTRY
