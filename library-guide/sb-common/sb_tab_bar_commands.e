indexing
	description:"SB_TAB_BAR commands"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v1 (see forum.txt)"
	status:		"mostly complete"

expanded class SB_TAB_BAR_COMMANDS

inherit

	SB_PACKER_COMMANDS
		rename
			Id_last as PACKER_ID_LAST
		end

feature

	ID_OPEN_ITEM	: INTEGER is once Result := PACKER_ID_LAST           end
	ID_OPEN_FIRST	: INTEGER is once Result := PACKER_ID_LAST + 1       end
	ID_OPEN_SECOND	: INTEGER is once Result := PACKER_ID_LAST + 2;      end
	ID_OPEN_THIRD	: INTEGER is once Result := PACKER_ID_LAST + 3;      end
	ID_OPEN_FOURTH	: INTEGER is once Result := PACKER_ID_LAST + 4;      end
	ID_OPEN_FIFTH	: INTEGER is once Result := PACKER_ID_LAST + 5;      end
	ID_OPEN_SIXTH	: INTEGER is once Result := PACKER_ID_LAST + 6;      end
	ID_OPEN_SEVENTH	: INTEGER is once Result := PACKER_ID_LAST + 7;      end
	ID_OPEN_EIGHTH	: INTEGER is once Result := PACKER_ID_LAST + 8;      end
	ID_OPEN_NINETH	: INTEGER is once Result := PACKER_ID_LAST + 9;      end
	ID_OPEN_TENTH	: INTEGER is once Result := PACKER_ID_LAST + 10;     end
	ID_OPEN_LAST	: INTEGER is once Result := PACKER_ID_LAST + 100;    end
	Id_last			: INTEGER is once Result := PACKER_ID_LAST + 101;    end

end
