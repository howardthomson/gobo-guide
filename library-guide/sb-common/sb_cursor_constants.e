indexing
	description:"SB_CURSOR constants"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"mostly complete"

class SB_CURSOR_CONSTANTS

feature

	-- Stock cursor types
	CURSOR_ARROW      : INTEGER is 1;    -- Default left pointing arrow
	CURSOR_RARROW     : INTEGER is 2;    -- Right arrow
	CURSOR_IBEAM      : INTEGER is 3;    -- Text I-Beam
	CURSOR_WATCH      : INTEGER is 4;    -- Stopwatch or hourglass
	CURSOR_CROSS      : INTEGER is 5;    -- Crosshair
	CURSOR_UPDOWN     : INTEGER is 6;    -- Move up, down
	CURSOR_LEFTRIGHT  : INTEGER is 7;    -- Move left, right
	CURSOR_MOVE       : INTEGER is 8;    -- Move up,down,left,right

end