indexing
	description:"SB_TAB_ITEM constants"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"mostly complete"

class SB_TAB_ITEM_CONSTANTS

inherit

	SB_LABEL_CONSTANTS

feature -- Tab Item orientations which affect border

	TAB_TOP		: INTEGER is 0			-- Top side tabs
	TAB_LEFT	: INTEGER is 0x00800000	-- Left side tabs
	TAB_RIGHT	: INTEGER is 0x01000000	-- Right side tabs
	TAB_BOTTOM	: INTEGER is 0x01800000	-- Bottom side tabs

	TAB_TOP_NORMAL: INTEGER is
      	once
         	Result := JUSTIFY_NORMAL | ICON_BEFORE_TEXT | TAB_TOP | Frame_raised | Frame_thick
      	end

	TAB_BOTTOM_NORMAL: INTEGER is
      	once
         	Result :=  JUSTIFY_NORMAL | ICON_BEFORE_TEXT | TAB_BOTTOM | Frame_raised | Frame_thick
      	end

	TAB_LEFT_NORMAL: INTEGER is
      	once
         	Result := JUSTIFY_LEFT | JUSTIFY_CENTER_Y | ICON_BEFORE_TEXT | TAB_LEFT | Frame_raised | Frame_thick
      	end

	TAB_RIGHT_NORMAL: INTEGER is
      	once
         	Result := JUSTIFY_LEFT | JUSTIFY_CENTER_Y | ICON_BEFORE_TEXT | TAB_RIGHT | Frame_raised | Frame_thick
      	end

end
