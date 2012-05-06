note
	platform: "X11"
	todo: "[
		Rewrite to use expanded version of SB_SEGMENT for ARRAY.
		X requires that to_external of the array produces the address
		of a contiguous array of 16-bit x,y pairs !!!
	]"
		
class SB_CHECK_BUTTON

inherit
	 SB_CHECK_BUTTON_DEF

create
	make

feature

	seg_make(ix, iy: INTEGER): ARRAY [ SB_SEGMENT ]
		local
         	seg: ARRAY [SB_SEGMENT];
         	s: SB_SEGMENT;
		do
			create seg.make(1, 6);
            s.make(3+ix, 5+iy, 5+ix, 7+iy);	seg.put(s, 1);
            s.make(3+ix, 6+iy, 5+ix, 8+iy);	seg.put(s, 2);
            s.make(3+ix, 7+iy, 5+ix, 9+iy);	seg.put(s, 3);
            s.make(5+ix, 7+iy, 9+ix, 3+iy);	seg.put(s, 4);
            s.make(5+ix, 8+iy, 9+ix, 4+iy);	seg.put(s, 5);
            s.make(5+ix, 9+iy, 9+ix, 5+iy);	seg.put(s, 6);
            Result := seg
		end


end
