note
	description:"SB_LABEL constants"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"mostly complete"

class SB_LABEL_CONSTANTS

inherit

	SB_FRAME_CONSTANTS

feature

	ICON_TEXT_MASK: INTEGER
		once
			Result := ICON_AFTER_TEXT | ICON_BEFORE_TEXT 
				    | ICON_ABOVE_TEXT | ICON_BELOW_TEXT
		end

feature -- Relationship options for icon-labels

	ICON_UNDER_TEXT : INTEGER = 0         	-- Icon appears under text
	ICON_AFTER_TEXT : INTEGER = 0x00080000	-- Icon appears after text (to its right)
	ICON_BEFORE_TEXT: INTEGER = 0x00100000	-- Icon appears before text (to its left)
	ICON_ABOVE_TEXT : INTEGER = 0x00200000	-- Icon appears above text
	ICON_BELOW_TEXT : INTEGER = 0x00400000	-- Icon appears below text

	TEXT_OVER_ICON: INTEGER 
			-- Same as ICON_UNDER_TEXT
		once 
			Result := ICON_UNDER_TEXT;
		end

	TEXT_AFTER_ICON: INTEGER
         	-- Same as ICON_BEFORE_TEXT
      	once
         	Result := ICON_BEFORE_TEXT;
      	end

  	TEXT_BEFORE_ICON: INTEGER
         	-- Same as ICON_AFTER_TEXT
      	once
         	Result := ICON_AFTER_TEXT;
      	end

  	TEXT_ABOVE_ICON: INTEGER
         	-- Same as ICON_BELOW_TEXT
      	once
         	Result := ICON_BELOW_TEXT;
      	end

  	TEXT_BELOW_ICON: INTEGER
         	-- Same as ICON_ABOVE_TEXT
      	once
         	Result := ICON_ABOVE_TEXT
      	end

  	LABEL_NORMAL: INTEGER
         	-- Normal way to show label
      	once
         	Result := JUSTIFY_NORMAL | ICON_BEFORE_TEXT
      	end

end
