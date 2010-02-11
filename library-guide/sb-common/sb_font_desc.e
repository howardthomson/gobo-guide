indexing
	description: "Font style"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Partly complete"

class SB_FONT_DESC

feature -- Attributes

	face	: STRING;	-- Face name
	size	: INTEGER;	-- Size in deci-points
	weight	: INTEGER;	-- Weight [light, normal, bold, ...]
	slant	: INTEGER;	-- Slant [normal, italic, oblique, ...]
	encoding: INTEGER;	-- Encoding of character set
	setwidth: INTEGER;	-- Set width [normal, condensed, expanded, ...]

feature -- Creation



	flags: INTEGER;		-- Flags

	parse(desc: STRING): BOOLEAN is
		do
		end 

end
