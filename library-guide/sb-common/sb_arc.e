indexing
	description:"The Arc object"

	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license: 	"Eiffel Forum Freeware License v1 (see forum.txt)"
	status:		"partly complete"

class SB_ARC

feature
	x: INTEGER;
			-- x coord of the upper left corner of the arc bounding rectangle.
	y: INTEGER;
			-- y coord of the upper left corner of the arc bounding rectangle.
	w: INTEGER;
			-- width of the arc bounding rectangle.
	h: INTEGER;
			-- height of the arc bounding rectangle.   
	a: INTEGER;
			-- the start of the arc relative to the three-o'clock position 
			-- from the center, in units of degrees*64.
	b: INTEGER;
			-- path and extent of the arc relative to the start of the arc,
			-- in units of degrees*64.
end

