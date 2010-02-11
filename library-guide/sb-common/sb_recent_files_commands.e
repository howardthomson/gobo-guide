indexing
	description:"SB_RECENT_FILES commands"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v1 (see forum.txt)"
	status:		"mostly complete"

expanded class SB_RECENT_FILES_COMMANDS

inherit

	SB_MESSAGE_HANDLER_COMMANDS
		rename
			Id_last as MESSAGE_HANDLER_ID_LAST
		end

feature

	ID_CLEAR	: INTEGER is once Result := MESSAGE_HANDLER_ID_LAST + 1	end
	ID_ANYFILES	: INTEGER is once Result := MESSAGE_HANDLER_ID_LAST + 2	end
	ID_FILE_1	: INTEGER is once Result := MESSAGE_HANDLER_ID_LAST + 3	end
	ID_FILE_2	: INTEGER is once Result := MESSAGE_HANDLER_ID_LAST + 4	end
	ID_FILE_3	: INTEGER is once Result := MESSAGE_HANDLER_ID_LAST + 5	end
	ID_FILE_4	: INTEGER is once Result := MESSAGE_HANDLER_ID_LAST + 6	end
	ID_FILE_5	: INTEGER is once Result := MESSAGE_HANDLER_ID_LAST + 7	end
	ID_FILE_6	: INTEGER is once Result := MESSAGE_HANDLER_ID_LAST + 8	end
	ID_FILE_7	: INTEGER is once Result := MESSAGE_HANDLER_ID_LAST + 9	end
	ID_FILE_8	: INTEGER is once Result := MESSAGE_HANDLER_ID_LAST + 10 end
	ID_FILE_9	: INTEGER is once Result := MESSAGE_HANDLER_ID_LAST + 11 end
	ID_FILE_10	: INTEGER is once Result := MESSAGE_HANDLER_ID_LAST + 12 end
	Id_last		: INTEGER is once Result := MESSAGE_HANDLER_ID_LAST + 13 end
end
