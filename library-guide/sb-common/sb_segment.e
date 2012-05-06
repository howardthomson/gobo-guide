note
	description:"Segment"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

   mods: "[
   		Adapted for X11
   			Changed to expanded class
   			Changed to integer_16 16-bit values for X
   		]"

expanded class SB_SEGMENT

feature -- Creation

   make (x1_, y1_, x2_, y2_: INTEGER)
      do
         x1 := x1_.to_integer_16;
         y1 := y1_.to_integer_16;
         x2 := x2_.to_integer_16;
         y2 := y2_.to_integer_16;
      end

feature -- Data

	x1: INTEGER_16
	y1: INTEGER_16;
	x2: INTEGER_16;
	y2: INTEGER_16;

feature -- Actions

	set_x1(x1_: INTEGER)
		do
			x1 := x1_.to_integer_16;
		end

   	set_y1(y1_: INTEGER)
      	do
         	y1 := y1_.to_integer_16;
      	end

   	set_x2(x2_: INTEGER)
      	do
         	x2 := x2_.to_integer_16;
      	end

   	set_y2(y2_: INTEGER)
      	do
         	y2 := y2_.to_integer_16;
      	end
end
