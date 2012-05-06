note
	description:"SB_PROGRESS_BAR constants"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"mostly complete"

class SB_PROGRESS_BAR_CONSTANTS

inherit

   SB_FRAME_CONSTANTS

feature -- Progress bar styles

	PROGRESSBAR_HORIZONTAL	: INTEGER = 0			-- Horizontal display
	PROGRESSBAR_VERTICAL	: INTEGER = 0x00008000	-- Vertical display
	PROGRESSBAR_PERCENTAGE	: INTEGER = 0x00010000	-- Show percentage done
	PROGRESSBAR_DIAL		: INTEGER = 0x00020000	-- Show as a dial instead of bar

	PROGRESSBAR_NORMAL: INTEGER
		once
			Result := Frame_sunken | Frame_thick
		end

end
