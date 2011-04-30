indexing
	description:"Separator Options"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"mostly complete"

class SB_SEPARATOR_CONSTANTS

feature -- Separator Options

	SEPARATOR_NONE	: INTEGER is 0         -- Nothing visible
	SEPARATOR_GROOVE: INTEGER is 0x00008000	-- 1000 0000 0000 0000B;		-- Etched-in looking groove
	SEPARATOR_RIDGE	: INTEGER is 0x00010000	-- 1 0000 0000 0000 0000B;		-- Embossed looking ridge
	SEPARATOR_LINE	: INTEGER is 0x00020000	-- 10 0000 0000 0000 0000B;	-- Simple line

	SEPARATOR_MASK: INTEGER is
		once
         	Result := SEPARATOR_GROOVE | SEPARATOR_RIDGE | SEPARATOR_LINE
      	end

feature { NONE }

	SEPARATOR_EXTRA: INTEGER is 2;

end
