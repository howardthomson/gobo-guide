indexing
	description:"FileList item"

	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

class SB_FILE_LIST_ITEM

inherit

	SB_ICON_LIST_ITEM

creation

	make_empty, make

feature -- Data

	assoc: SB_FILE_ASSOCIATION;	-- File association record
	size: INTEGER;         		-- File size
	date: INTEGER;         		-- File time

feature -- Queries

   is_file: BOOLEAN is
         -- Return true if this is a file item
      do
         Result := (state & (FOLDER | BLOCKDEV | CHARDEV | FIFO | SOCK)) = Zero
      end

   is_directory: BOOLEAN is
         -- Return true if this is a directory item
      do
         Result := (state & FOLDER) /= Zero;
      end

   is_executable: BOOLEAN is
         -- Return true if this is an executable item
      do
         Result := (state & EXECUTABLE) /= Zero;
      end

   is_symlink: BOOLEAN is
         -- Return true if this is a symbolic link item
      do
         Result := (state & SYMLINK) /= Zero;
      end

   is_chardev: BOOLEAN is
         -- Return true if this is a character device item
      do
         Result := (state & CHARDEV) /= Zero;
      end

   is_blockdev: BOOLEAN is
         -- Return true if this is a block device item
      do
         Result := (state & BLOCKDEV) /= Zero;
      end

   is_fifo: BOOLEAN is
         -- Return true if this is an FIFO item
      do
         Result := (state & FIFO) /= Zero;
      end

   is_socket: BOOLEAN is
         -- Return true if this is a socket
      do
         Result := (state & SOCK) /= Zero;
      end

   filename: STRING is
      local
      --   u: expanded SB_UTILS;
      do
         Result := u.section(label,'%T',0,1);
      end

feature -- Actions

	set_directory(set: BOOLEAN) is
		do
			if set then
				state := state | FOLDER
			else
				state := state & (FOLDER).bit_not
			end
		end

   set_executable(set: BOOLEAN) is
      do
         if set then
            state := state | EXECUTABLE
         else
            state := state & (EXECUTABLE).bit_not
         end
      end

   set_symlink(set: BOOLEAN) is
      do
         if set then
            state := state | SYMLINK
         else
            state := state & (SYMLINK).bit_not
         end
      end

   set_chardev(set: BOOLEAN) is
      do
         if set then
            state := state | CHARDEV
         else
            state := state & (CHARDEV).bit_not
         end
      end

   set_blockdev(set: BOOLEAN) is
      do
         if set then
            state := state | BLOCKDEV
         else
            state := state & (BLOCKDEV).bit_not
         end
      end

	set_fifo(set: BOOLEAN) is
		do
			if set then
				state := state | FIFO
			else
				state := state & (FIFO).bit_not
			end
		end

	set_socket(set: BOOLEAN) is
		do
			if set then
				state := state | SOCK
			else
				state := state & (SOCK).bit_not
			end
		end

	set_date(dt: INTEGER) is
		do
			date := dt;
		end

	set_size(sz: INTEGER) is
		do
			size := sz;
		end

	set_assoc(ass: SB_FILE_ASSOCIATION) is
		do
			assoc := ass;
		end

feature { NONE } -- Implementation


	FOLDER		: INTEGER is 0x00000040	-- Directory item
	EXECUTABLE	: INTEGER is 0x00000080	-- Executable item
	SYMLINK		: INTEGER is 0x00000100	-- Symbolic linked item
	CHARDEV		: INTEGER is 0x00000200	-- Character special item
	BLOCKDEV	: INTEGER is 0x00000400	-- Block special item
	FIFO		: INTEGER is 0x00000800	-- FIFO item
	SOCK		: INTEGER is 0x00001000	-- Socket item

end
