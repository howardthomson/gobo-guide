class SELECT_API

create
	make

feature {NONE} -- Implementation attributes

	read_fd_set,
	write_fd_set,
	except_fd_set
		: MANAGED_POINTER

	timeout: MANAGED_POINTER

feature -- Attributes

	max_fd:	INTEGER		-- The highest set fd index

	max: INTEGER		-- return value from select

feature -- Creation routines

	make
		do
			-- allocate read, write and exception FD_SETs
			create read_fd_set	.make (c_fd_set_size)
			create write_fd_set	.make (c_fd_set_size)
			create except_fd_set.make (c_fd_set_size)
			create timeout.make (2 * ({PLATFORM}.pointer_bytes))
			zero_all
		end

feature -- Timeout routines

	set_delta (s, us: INTEGER)
		do
			set_delta_s (s)
			set_delta_us (us)
		end

	set_delta_s (s: INTEGER)
			-- Set seconds timeout
		do
			if {PLATFORM}.pointer_bytes = 4 then
				timeout.put_integer_32 (s, 0)
			else
				timeout.put_integer_64 (s, 0)
			end
		end

	set_delta_us (us: INTEGER)
			-- Set micro-seconds timeout
		do
			if {PLATFORM}.pointer_bytes = 4 then
				timeout.put_integer_32 (us, 4)
			else
				timeout.put_integer_64 (us, 8)
			end
		end

	delta_s: INTEGER
			-- Read timeout seconds
		do
			if {PLATFORM}.pointer_bytes = 4 then
				Result := timeout.read_integer_32 (0)
			else
				Result := timeout.read_integer_64 (0).as_integer_32
			end
		end

	delta_us: INTEGER
			-- Read timeout micro-seconds
		do
			if {PLATFORM}.pointer_bytes = 4 then
				Result := timeout.read_integer_32 (4)
			else
				Result := timeout.read_integer_64 (8).as_integer_32
			end
		end

feature -- Zero routines

	zero_all
		do
			zero_read
			zero_write
			zero_except
			set_delta (0, 0)
			max_fd := 0
		end

	zero_read
			-- unset all read selections
		do
			c_fd_zero (read_fd_set.item)
		end

	zero_write
			-- unset all write selections
		do
			c_fd_zero (write_fd_set.item)
		end

	zero_except
			-- unset all exception selections
		do
			c_fd_zero (except_fd_set.item)
		end

feature -- Set routines

	set_read (f: INTEGER)
			-- Set a read fd bit
		do
			c_fd_set (f, read_fd_set.item)
			if f > max_fd then max_fd := f end
		end

	set_write (f: INTEGER)
			-- Set a write fd bit
		do
			c_fd_set (f, write_fd_set.item)
			if f > max_fd then max_fd := f end
		end

	set_except (f: INTEGER)
			-- Set a write fd bit
		do
			c_fd_set (f, except_fd_set.item)
			if f > max_fd then max_fd := f end
		end

feature -- Unset routines

	unset_read (f: INTEGER)
			-- Unset a read fd bit
		do
			c_fd_unset (f, read_fd_set.item)
		end

	unset_write (f: INTEGER)
			-- Unset a write fd bit
		do
			c_fd_unset (f, write_fd_set.item)
		end

	unset_except (f: INTEGER)
			-- Unset an except fd bit
		do
			c_fd_unset (f, except_fd_set.item)
		end

feature -- Test functions

	is_set_read (f: INTEGER): BOOLEAN
			-- Unset a read fd bit
		do
			Result := c_fd_is_set (f, read_fd_set.item) /= 0
		end

	is_set_write (f: INTEGER): BOOLEAN
			-- Unset a write fd bit
		do
			Result := c_fd_is_set (f, write_fd_set.item) /= 0
		end

	is_set_except (f: INTEGER): BOOLEAN
			-- Set an except fd bit
		do
			Result := c_fd_is_set (f, except_fd_set.item) /= 0
		end


feature -- Do select

	execute
			-- call 'select' with current settings
		do
			max := c_select (max_fd + 1, read_fd_set.item, write_fd_set.item, except_fd_set.item, default_pointer)
		end

	execute_timeout
			-- call 'select' with current settings and timeout
		do
			max := c_select (max_fd + 1, read_fd_set.item, write_fd_set.item, except_fd_set.item, timeout.item)
		end

feature { NONE } -- implementation

	c_fd_set_size: INTEGER
		external "C macro use <sys/select.h>"
		alias "sizeof(fd_set)"
		end

	c_fd_zero (p: POINTER)
		external "C macro signature (fd_set*) use <sys/select.h>"
		alias "FD_ZERO"
		end
	
	c_fd_set (f: INTEGER; p: POINTER)
		external "C macro signature (int,fd_set*) use <sys/select.h>"
		alias "FD_SET"
		end
	
	c_fd_unset (f: INTEGER; p: POINTER)
		external "C macro signature (int,fd_set*) use <sys/select.h>"
		alias "FD_CLR"
		end
	
	c_fd_is_set (f: INTEGER; p: POINTER): INTEGER
		external "C macro signature (int,fd_set*): int use <sys/select.h>"
		alias "FD_ISSET"
		end

	c_select (f: INTEGER; pr, pw, pe, tp: POINTER): INTEGER
		external "C use <sys/select.h>"
		alias "select"
		end
end