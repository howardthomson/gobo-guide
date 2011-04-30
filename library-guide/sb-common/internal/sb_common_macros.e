indexing
	description:"wide used macros"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"partly complete"

expanded class SB_COMMON_MACROS

feature

   sbrgba (r,g,b,a : INTEGER ) : INTEGER is
         -- Make RGBA color
      local
         br, bg, bb, ba : INTEGER
      do
         br := (r & 0x000000FF)
         bg := (g & 0x000000FF) |<< 8;
         bb := (b & 0x000000FF) |<< 16;
         ba := (a & 0x000000FF) |<< 24;

         Result := br | bg | bb | ba
      end

   sbrgb (r,g,b : INTEGER ) : INTEGER is
         -- Make RGB color
      local
         br, bg, bb : INTEGER
      do
         br := (r & 0x000000FF)
         bg := (g & 0x000000FF) |<< 8;
         bb := (b & 0x000000FF) |<< 16;

         Result := br | bg | bb | 0xFF000000
      end
      
	sbredval (rgba : INTEGER) : INTEGER is
         	-- Get red value from RGBA color
      	do
         	Result := rgba & 0x000000FF
      	end;

   	sbgreenval (rgba : INTEGER) : INTEGER is
         -- Get green value from RGBA color
      	do
         	Result := ((rgba |>> 8) & 0x000000FF)
      	end;

   	sbblueval (rgba : INTEGER) : INTEGER is
         	-- Get blue value from RGBA color
      	do
         	Result := ((rgba |>> 16) & 0x000000FF)
      	end;

   sbalphaval (rgba : INTEGER) : INTEGER is
         -- Get alpha value from RGBA color
      local
         rgbab : INTEGER
      do
         Result := ((rgba |>> 24) & 0x000000FF)
      end;

   sbrgbacompval(rgba, comp : INTEGER) : INTEGER is
         -- Get component value of RGBA color
      do
         Result := ((rgba |>> (comp*8).to_integer_8) & 0x000000FF)
      end;

   sbclamp(lo, x, hi: INTEGER): INTEGER is
         -- Clamp value x to range [lo..hi]
      do
         if x < lo then
            Result := lo
         elseif x > hi then
            Result := hi
         else
            Result := x
         end
      end

	sbabs(arg: INTEGER): INTEGER is
		do
			if arg < 0 then
				Result := - arg
			else
				Result := arg
			end
		end
  
end
