indexing
   description: "SB_VISUAL constants"
   author: "Eugene Melekhov <eugene_melekhov@mail.ru>"
   copyright: "Copyright (c) 2002, Eugene Melekhov and others"
   license: "Eiffel Forum Freeware License v2 (see forum.txt)"
   status: "mostly complete"

class SB_VISUAL_CONSTANTS

feature -- Construction options for FXVisual class

	VISUAL_DEFAULT      : INTEGER is 0x00000000  -- Default visual
	VISUAL_MONOCHROME   : INTEGER is 0x00000001	-- Must be monochrome visual
	VISUAL_BEST         : INTEGER is 0x00000002	-- Best (deepest) visual
	VISUAL_INDEXCOLOR   : INTEGER is 0x00000004	-- Palette visual
	VISUAL_GRAYSCALE    : INTEGER is 0x00000008	-- Gray scale visual
	VISUAL_TRUECOLOR    : INTEGER is 0x00000010	-- Must be true color visual
	VISUAL_OWNCOLORMAP  : INTEGER is 0x00000020	-- Allocate private colormap
	VISUAL_DOUBLEBUFFER : INTEGER is 0x00000040	-- Double-buffered [FXGLVisual]
	VISUAL_STEREO       : INTEGER is 0x00000080	-- Stereo [FXGLVisual]
	VISUAL_NOACCEL      : INTEGER is 0x00000100	-- No hardware acceleration [for broken h/w]

feature -- Visual type

   VISUALTYPE_UNKNOWN  : INTEGER is 1;        -- Undetermined visual type
   VISUALTYPE_MONO     : INTEGER is 2;        -- Visual for drawing into 1-bpp surfaces
   VISUALTYPE_TRUE     : INTEGER is 3;        -- True color
   VISUALTYPE_INDEX    : INTEGER is 4;        -- Index [palette] color
   VISUALTYPE_GRAY     : INTEGER is 5;        -- Gray scale

end