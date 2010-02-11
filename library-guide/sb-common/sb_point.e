indexing

		description:"The Point"
	
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v1 (see forum.txt)"
	status:		"Mostly complete"

class SB_POINT

inherit
	ANY	-- For SE 2.1

creation make

feature -- Creation

   set_xy, make (a_x, a_y: INTEGER) is
      do
         x := a_x.to_integer_16
         y := a_y.to_integer_16
      end

feature -- Data

   x,y : INTEGER_16

   set_x (a_x: INTEGER) is
      do
         x := a_x.to_integer_16
      end

   set_y (a_y: INTEGER) is
      do
         y := a_y.to_integer_16
      end

end
