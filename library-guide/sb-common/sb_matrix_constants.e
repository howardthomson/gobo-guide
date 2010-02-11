indexing
	description:"SB_MATRIX constants"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"mostly complete"

class SB_MATRIX_CONSTANTS

feature

	MATRIX_BY_ROWS	 : INTEGER is 0x00000000	-- 0B;					-- Fixed number of rows, add columns as needed
	MATRIX_BY_COLUMNS: INTEGER is 0x00020000	-- 10 0000 0000 0000 0000B;	-- Fixed number of columns, adding rows as needed

end
