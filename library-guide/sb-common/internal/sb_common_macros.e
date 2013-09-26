note
	description:"wide used macros"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"partly complete"

expanded class SB_COMMON_MACROS

feature

   sbrgba (r,g,b,a : INTEGER ) : INTEGER
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

   sbrgb (r,g,b : INTEGER ) : INTEGER
         -- Make RGB color
      local
         br, bg, bb : INTEGER
      do
         br := (r & 0x000000FF)
         bg := (g & 0x000000FF) |<< 8;
         bb := (b & 0x000000FF) |<< 16;

         Result := br | bg | bb | 0xFF000000
      end

	sbredval (rgba : INTEGER) : INTEGER
         	-- Get red value from RGBA color
      	do
         	Result := rgba & 0x000000FF
      	end

   	sbgreenval (rgba : INTEGER) : INTEGER
         -- Get green value from RGBA color
      	do
         	Result := ((rgba |>> 8) & 0x000000FF)
      	end

   	sbblueval (rgba : INTEGER) : INTEGER
         	-- Get blue value from RGBA color
      	do
         	Result := ((rgba |>> 16) & 0x000000FF)
      	end

   sbalphaval (rgba : INTEGER) : INTEGER
         -- Get alpha value from RGBA color
      local
         rgbab : INTEGER
      do
         Result := ((rgba |>> 24) & 0x000000FF)
      end

end
