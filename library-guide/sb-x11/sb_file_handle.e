class SB_FILE_HANDLE

inherit

	ANY -- For ISE ??

	SB_FILE_HANDLE_DEF

	RAW_FILE
		rename
			descriptor as fd,
			open_read as elks_open_read,
			open_write as elks_open_write
		end

create

	open_read

feature -- TODO

	open_read(s: STRING) is
		do
			make_open_read(s)
		end

	open_write(s: STRING) is
		do
			make_open_write(s)
		end
end
