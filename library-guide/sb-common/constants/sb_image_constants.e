note
	description:"Image rendering hints"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"mostly complete"

	todo: "[
		IMAGE_DITHER is 00B ????
	]"

class SB_IMAGE_CONSTANTS

feature -- Image rendering hints

	IMAGE_KEEP       : INTEGER = 0x00000001		-- Keep pixel data in client
	IMAGE_OWNED      : INTEGER = 0x00000002		-- Pixel data is owned by image
--#	IMAGE_DITHER     : INTEGER is 0x00000000		-- Dither image to look better
	IMAGE_NEAREST    : INTEGER = 0x00000004		-- Turn off dithering and map to nearest color
	IMAGE_ALPHA      : INTEGER = 0x00000008		-- Data has alpha channel
	IMAGE_OPAQUE     : INTEGER = 0x00000010		-- Force opaque background
	IMAGE_ALPHACOLOR : INTEGER = 0x00000020		-- Override transparancy color
	IMAGE_SHMI       : INTEGER = 0x00000040		-- Using shared memory image
	IMAGE_SHMP       : INTEGER = 0x00000080		-- Using shared memory pixmap
	IMAGE_ALPHAGUESS : INTEGER = 0x00000100		-- Guess transparency color from corners

end
