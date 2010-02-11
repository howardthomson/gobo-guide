indexing
	description: "Cursor position and mouse buttons state"

	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

class SB_CURSOR_POSITION

inherit
	SB_POINT
    	rename
        	make as make_point
      	end

creation

	make

feature -- Creation

	make (x_, y_: INTEGER; buttons_: INTEGER) is
		do
			make_point(x_, y_)
			buttons := buttons_;
		end

feature -- Data

	buttons: INTEGER;

end
