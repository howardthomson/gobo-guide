class SB_FILE_HANDLE

inherit

	SB_FILE_HANDLE_DEF

	SB_WAPI_FILE_FUNCTIONS
	SB_WAPI_FILE_ACTIONS
	SB_WAPI_FILES_AND_DIRS_ACCESS_RIGHTS
	SB_WAPI_WINDOW_FUNCTIONS

creation

	open_read

feature -- Attributes

	handle: POINTER
		-- Windows file handle

feature -- Routines

	open_read(path: STRING) is
		require else
			path /= Void and then path.count > 1
		local
			h: like handle
		do
			h := CreateFile(
				path.area.base_address,	-- File path name
				Generic_read,			-- Read access flag
				0,						-- Share mode
				default_pointer,		-- Security attributes
				Open_existing,			-- Create flags
				0,						-- Attributes and flags
				default_pointer			-- Template file ??
			)
			if h /= Invalid_handle_value then
				handle := h
				fx_trace(0, <<"SB_FILE_HANDLE::open_read(%"", path, "%") OK">>)
			else
				fx_trace(0, <<"SB_FILE_HANDLE::open_read failed: ", GetLastError.out>>)
			end
		end

	open_write (path: STRING) is
		do
		end

	close is
		do
		end

	is_open: BOOLEAN is
		do
			Result := handle /= default_pointer
		end

end