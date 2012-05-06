note
	description:"widely used constants"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"mostly complete"

	todo: "[
		Split into X and Win32 implementations and
		SB_DEFS_DEF common deferred class
	]"

expanded class SB_DEFS

inherit

	SB_DEFS_DEF

feature -- Path separator (WIN32)

	PATHSEP, Path_sep: CHARACTER = '\'

	PATHSEPSTRING, Path_sep_string: STRING = "\"

	PATHLISTSEP, Path_list_sep: CHARACTER = ';'

	PATHLISTSEPSTRING, Path_list_sep_string: STRING = ";"

	ISPATHSEP, is_path_sep(c: CHARACTER): BOOLEAN
		do
			Result := c = '/' or else c = '\'
		end

end
