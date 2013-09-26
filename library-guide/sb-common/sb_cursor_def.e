note
	description:"The Cursor"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

deferred class SB_CURSOR_DEF

inherit

	SB_SERVER_RESOURCE
    	redefine
        	destruct
      	end

	SB_CURSOR_CONSTANTS
	SB_SHARED_APPLICATION

feature

	width	: INTEGER;	-- Width
	height	: INTEGER;	-- Height
	hot_x	: INTEGER;	-- Hot spot x
	hot_y	: INTEGER;	-- Hot spot x

feature { NONE } -- Implementation

   	source:  STRING;     -- Source data
   	mask:    STRING;     -- Mask data
   	glyph:   INTEGER;    -- Glyph type cursor (stock cursor)
   	owned:   BOOLEAN;    -- Owns data

feature

	class_name: STRING = "SB_CURSOR"

feature -- Creation

	make_from_stock (a_glyph : INTEGER)
			-- Make stock cursor
    	require
			a_glyph > 0
		do
        	init_resource
         	source := Void
         	mask := Void
         	width := 0
         	height := 0
         	hot_x := -1
         	hot_y := -1
         	glyph := a_glyph
         	owned := False
		end

	make_from_bitmap, make_from_bits (src, msk: STRING; w, h: INTEGER; hx, hy: INTEGER)
    	require
    		src /= Void
         	msk /= Void
      	do
         	init_resource
         	create source.make_from_string (src)
         	create mask.make_from_string (msk)
         	width := w
         	height := h
         	hot_x := hx
         	hot_y := hy
         	glyph := 0
         	owned := False
      	end

feature -- Actions

--	destroy_resource is
--			-- Destroy cursor
--      deferred
--		end

feature -- Destruction

	destruct
    	do
        	destroy_resource
         	source := Void
         	mask := Void
         	Precursor
      	end

end
