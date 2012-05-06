note

	description: "Interface to Xlib's Display structure"

	author: "Stephane Hillion"
	copyright: "Copyright (c) 1998-2006, Stephane Hillion and Howard Thomson"
	license: "GNU Public License (see COPYING)"

class X_DISPLAY

inherit

	X_GLOBAL
    	redefine
    		is_equal
    	end

    X11_EXTERNAL_ROUTINES
    	redefine
    		is_equal
    	end

create 

	make,
	from_external

feature { NONE } -- Creation.

	make (name: STRING)
    		-- opens a display channel.
    		-- name = "" opens the default display channel.
    	require
      		name /= Void
    	do
      		to_external := XOpenDisplay (string_to_external(name))
      		if to_external = default_pointer then
				--raise (Xlib_exception, << "Can't open display ", name >>)
      		end
    	ensure
      		to_external /= default_pointer
    	end

  	from_external (ptr: POINTER)
      		-- creates an X_DISPLAY instance from an external display pointer.
		require
			valid_ptr: ptr /= default_pointer
    	do
      		to_external := ptr
    	ensure
      		to_external = ptr
    	end

feature -- Destruction.

	close
    		-- close the display.
    	require
			to_external /= default_pointer
		do
      		x_close_display (to_external)
      		to_external := default_pointer
    	ensure
      		to_external = default_pointer
    	end
  
feature

	is_equal(other: like Current): BOOLEAN
    		-- Is other represent the same display as `Current'?
    	do
			Result := to_external = other.to_external
		end

	to_external: POINTER	-- External representation of the display

--  display_string: STRING is
--  		-- returns the display's name
--  	require
--  		to_external /= default_pointer
--    	do
--  		create Result.from_external (x_display_string (to_external))
--    	end

  	screen_count: INTEGER
      		-- returns the number of available screens
    	require
      		to_external /= default_pointer
    	do
      		Result := x_screen_count (to_external)
    	end

	cached_default_screen: INTEGER

  	default_screen : INTEGER
      		-- returns the default screen number referenced in make 
    	require
      		to_external /= default_pointer
    	do
			if cached_default_screen = 0 then
      			cached_default_screen := 1 + x_default_screen (to_external)
      		end
      		Result := cached_default_screen - 1
    	end

  	width (scr: INTEGER) : INTEGER
      		-- returns the width of the specified screen in pixels
    	require
      		to_external /= default_pointer
      		scr < screen_count
    	do
      		Result := x_display_width (to_external, scr)
    	end

  	height (scr: INTEGER) : INTEGER
      		-- returns the height of the specified screen in pixels
    	require
      		to_external /= default_pointer
      		scr < screen_count
    	do
      		Result := x_display_height (to_external, scr)
    	end

	width_mm(scr: INTEGER): INTEGER
			-- returns the width of the specified screen in millimeters
		require
			to_external /= default_pointer
			scr < screen_count
		do
			Result := x_display_width_mm (to_external, scr)
		end

	height_mm(scr: INTEGER): INTEGER
			-- returns the height of the specified screen in millimeters
    	require
      		to_external /= default_pointer
      		scr < screen_count
    	do
      		Result := x_display_height_mm (to_external, scr)
    	end

	black_pixel_cached: BOOLEAN
	black_pixel_value: INTEGER

  	black_pixel(scr: INTEGER): INTEGER
      		-- returns the black pixel value for the specified screen
    	require
      		to_external /= default_pointer
      		scr < screen_count
    	do
			if not black_pixel_cached then
				black_pixel_cached := True
      			black_pixel_value := XBlackPixel(to_external, scr)
      		end
      		Result := black_pixel_value
    	end

	white_pixel_cached: BOOLEAN
	white_pixel_value: INTEGER

	white_pixel(scr: INTEGER): INTEGER
			-- returns the white pixel value for the specified screen
		require
			to_external /= default_pointer
			scr < screen_count
		do
			if not white_pixel_cached then
				white_pixel_cached := True
				white_pixel_value := XWhitePixel(to_external, scr)
			end
			Result := white_pixel_value
		end

	cells(scr: INTEGER): INTEGER
			-- the number of cells in the default colormap for the 
			-- specifier screen
		require
			to_external /= default_pointer
			scr < screen_count
		do
			Result := x_display_cells (to_external, scr)
		end
  
	default_visual(scr: INTEGER): X_VISUAL
			-- returns the default visual type for the specified screen
		require
			to_external /= default_pointer
			scr < screen_count
		do
    		create Result.from_external(x_default_visual (to_external, scr))
		end

	default_gc(scr: INTEGER): X_GC
			-- returns the default GC for the root window of the specified screen    
		require
    		to_external /= default_pointer
			scr < screen_count
		do
      		create Result.from_external (Current, scr, XDefaultGC(to_external, scr))
		end

	default_colormap(scr: INTEGER): X_COLORMAP
			-- returns the default colormap ID for allocation 
			-- on the specified screen    
    	require
			to_external /= default_pointer
			scr < screen_count
		do
			create Result.from_external (Current, scr, XDefaultColormap(to_external, scr))
		end

	default_depth(scr: INTEGER): INTEGER
      		-- returns the depth (number of planes) of the 
      		-- default root window for the specified screen
    	require
      		to_external /= default_pointer
      		scr < screen_count
    	do
      		Result := XDefaultDepth (to_external, scr)
    	end

  	root_window(scr: INTEGER): X_WINDOW
      		-- returns the root window
    	require
      		to_external /= default_pointer
      		scr < screen_count
    	do
      		create { X_DRAWABLE_WINDOW } Result.from_external(Current, scr, x_root_window(to_external, scr))
    	end

	default_root_window: X_DRAWABLE_WINDOW
		do
			Result ?= root_window(default_screen)
		end

--	list_depths (scr: INTEGER): C_VECTOR [C_INT] is
--    		-- returns the array of depths that are 
--    		-- available on the specified screen
--    	require
--      		to_external /= default_pointer
--      		scr < screen_count
--    	local
--      		p: POINTER
--      		i: C_INT
--    	do
--     		p := XListDepths(to_external, scr, $read)
--			create i.make
--     		create Result.from_external (p, read, i)
--    	end

	flush
      		-- flushes the output buffer
    	do
      		x_flush (to_external)
    	end

	sync(empty_queue: BOOLEAN)
      		-- flushes the output buffer and then waits until all requests 
      		-- have been received and processed by the X server
    	do
      		x_sync (to_external, empty_queue)
    	end

  	protocol_version: INTEGER
      		-- returns the major version number of the X protocol 
      		-- associated with the connected display 
    	require
      		to_external /= default_pointer
    	do
      		Result := x_protocol_version(to_external)
    	end

  	protocol_revision: INTEGER
      		-- returns the minor protocol revision number of the X server
    	require
      		to_external /= default_pointer
    	do
      		Result := x_protocol_revision(to_external)
    	end

  	vendor_release: INTEGER
      		-- returns a number related to a vendor's release of the X server
    	do
      		Result := x_vendor_release (to_external)
    	end

--  	server_vendor: STRING is
--      		-- returns a pointer to a string that provides 
--      		-- some identification of the owner of the X server implementation
--    	do
--      		create Result.from_external (x_server_vendor (to_external))
--    	end

	set_close_down_mode(mode: INTEGER)
      		-- defines what will happen to the client's resources 
      		-- at connection close
    	do
      		x_set_close_down_mode(to_external, mode)
    	end

feature  -- close down mode values

--	Destroy_all		: INTEGER is
--	Retain_temporary: INTEGER is
--	Retain_permanent: INTEGER is

feature

	kill_client (res_id: INTEGER)
			-- forces a close-down of the client that created the resource 
			-- if a valid resource is specified
		do
			x_kill_client (to_external, res_id)
		end

--	list_fonts (filter: STRING; nmax: INTEGER): X_FONT_NAMES is
--			-- returns an array of available font names or Void
--		require
--			filter /= Void
--		local
--			tab: POINTER
--			s: C_STRING
--		do
--			tab := x_list_fonts (to_external, filter.to_external, nmax, $read)
--			if tab /= default_pointer then
--				create s.make
--				create Result.from_external (tab, read, s)
--			end
--		end

--	get_font_path: X_FONT_PATH is
--		-- returns an array of strings containing the search path
--		local
--			tab	: POINTER
--			s	: C_STRING
--		do
--			tab := x_get_font_path (to_external, $read)
--			if tab /= default_pointer then
--				create s.make
--				Result.from_external (tab, read, s)
--			end
--		end

--	set_font_path (fp: X_FONT_PATH) is
--			-- defines the directory search path for font lookup
--		require
--			fp /= Void
--		do
--			x_set_font_path (to_external, fp.to_external, fp.count)
--		end

  	bell (percent : INTEGER)
      		-- rings the bell on the keyboard on the specified display, if possible
    	require
      		percent >= -100 and then percent <= 100
    	do
      		x_bell(to_external, percent)
    	end

	auto_repeat_on
			-- turns on auto-repeat for the keyboard on the specified display
    	do
			x_auto_repeat_on (to_external)
    	end

	auto_repeat_off
			-- turns off auto-repeat for the keyboard on the specified display
		do
			x_auto_repeat_off (to_external)
		end

--	screen (scr : INTEGER): X_SCREEN is
--			-- returns a pointer to the screen of the specified display
--		require
--			scr < screen_count
--		do
--			create Result.from_external (x_screen_of_display (to_external, scr))
--		end

	connection_number: INTEGER
			-- returns a connection number for the display
		do
			Result := XConnectionNumber (to_external)
		end

	max_request_size: INTEGER
			-- returns the maximum request size (in 4-byte units) supported 
			-- by the server without using an extended-length protocol encoding
		do
			Result := x_max_request_size (to_external)
		end

	extended_max_request_size: INTEGER
			-- returns Zero if the specified display does not support an 
			-- extended-length protocol encoding; otherwise, it returns 
			-- the maximum request size (in 4-byte units) supported by the 
			-- server using the extended-length encoding    
		do
			Result := x_extended_max_request_size (to_external)
		end

	last_known_request_processed: INTEGER
			-- extracts the full serial number of the last request known 
			-- by Xlib to have been processed by the X server    
		do
			Result := x_last_known_request_processed (to_external)
		end

	next_request: INTEGER
			-- extracts the full serial number that is to be used 
			-- for the next request
		do
			Result := x_next_request (to_external)
		end

	queue_length: INTEGER
			-- returns the length of the event queue for the connected display
		do
			Result := x_q_length (to_external)
		end

feature -- Buffers

--	store_bytes(buf: C_VECTOR [C_BYTE]) is
--			-- stores data in the standard buffer
--		require
--			buf  /= Void
--		do
--			x_store_bytes (to_external, buf.to_external, buf.count)
--		end

--	fetch_bytes: C_VECTOR [C_BYTE] is
--			-- returns the data stored in the standard buffer, if the buffer 
--			-- contains data. Otherwise, the function returns Void
--		local
--			buf : POINTER
--			b   : C_BYTE
--    	do
--     		buf := x_fetch_bytes (to_external, $read)
--     		if buf /= default_pointer then
--				create b.make
--        		create Result.from_external (buf, read, b)
--     		end
--		end

--	store_buffer(buf: C_VECTOR [C_BYTE]; buf_n: INTEGER) is
--			-- stores data in the buffer specified by buf_n
--		require
--			buf   /= Void
--			buf_n >= 0 and then buf_n < 8
--		do
--			x_store_buffer (to_external, buf.to_external, buf.count, buf_n)
--		end

--	fetch_buffer(buf_n : INTEGER) : C_VECTOR [C_BYTE] is
--			-- returns the data stored in the buffer buf_n, if the buffer 
--			-- contains data. Otherwise, the function returns Void
--    	require
--      		buf_n >= 0 and then buf_n < 8
--    	local
--      		buf : POINTER
--      		b   : C_BYTE
--    	do
--     		buf := x_fetch_buffer (to_external, $read, buf_n)
--     		if buf /= default_pointer then
--				create b.make
--        		create Result.from_external (buf, read, b)
--     		end
--    	end

	rotate_buffers(buf_n: INTEGER)
			-- rotates the cut buffers, such that buffer 0 becomes buffer 8, 
			-- buffer 1 becomes n + 1 mod 8, and so on    
		require
			buf_n >= 0 and then buf_n < 8
		do
			x_rotate_buffers (to_external, buf_n)
		end

feature { NONE } -- Implementation

	read: INTEGER

end 
