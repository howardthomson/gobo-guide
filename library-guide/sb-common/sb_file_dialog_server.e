indexing
	description:"Class used to display various file open/save dialogs"

	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

	todo: "[
			Remove redundant STRING creation, or move to make occur only
			instead of otherwise Void return
	]"

class SB_FILE_DIALOG_SERVER

inherit	--insert

	SB_CONSTANTS
	SB_EXPANDED

feature -- Actions

	open_filename (ownr: SB_WINDOW; caption, path, patterns: STRING; initial: INTEGER): STRING
		   -- Open existing filename
		local
			opendialog: SB_FILE_DIALOG
			filename: STRING
		do
		--	create Result.make_empty
			create opendialog.make (ownr, caption, 0)
			opendialog.set_select_mode (SELECTFILE_EXISTING)
			opendialog.set_pattern_list (patterns)
			opendialog.set_current_pattern (initial)
			opendialog.set_filename (path)
			if opendialog.execute /= 0 then
				filename := opendialog.filename
				if ff.is_file(filename) then Result := filename end
			end
	   end

	open_filenames (ownr: SB_WINDOW; caption, path, patterns: STRING; initial: INTEGER): ARRAY [ STRING ]
			-- Open multiple existing files
		local
			opendialog: SB_FILE_DIALOG
		do
			create opendialog.make (ownr, caption, 0)
			opendialog.set_select_mode (SELECTFILE_MULTIPLE)
			opendialog.set_pattern_list (patterns)
			opendialog.set_current_pattern (initial)
			opendialog.set_filename (path)
			if opendialog.execute /= 0 then
				Result := opendialog.filenames
			end
		end

	save_filename (ownr: SB_WINDOW; caption, path, patterns: STRING; initial: INTEGER): STRING
			-- Save to filename
		local
			opendialog: SB_FILE_DIALOG
			filename: STRING
		do
			create Result.make_empty
			create opendialog.make (ownr, caption, 0)
			opendialog.set_select_mode (SELECTFILE_ANY)
			opendialog.set_pattern_list (patterns)
			opendialog.set_current_pattern (initial)
			opendialog.set_filename (path)
			if opendialog.execute /= 0 then
				filename := opendialog.filename
				if ff.is_file(filename) then Result := filename end
			end
		end

	open_directory (ownr: SB_WINDOW; caption, path: STRING): STRING
			-- Open directory name
		local
			opendialog: SB_FILE_DIALOG
			filename: STRING
		do
			create Result.make_empty
			create opendialog.make (ownr, caption, 0)
			opendialog.set_select_mode (SELECTFILE_DIRECTORY)
			opendialog.set_filename (path)
			if opendialog.execute /= 0 then
				filename := opendialog.filename
				if ff.is_directory (filename) then Result := filename end
			end
		end
end
