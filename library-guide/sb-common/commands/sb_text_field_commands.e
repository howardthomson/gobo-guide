indexing
   description: "SB_TEXT_FIELD commands"
   author: "Eugene Melekhov <eugene_melekhov@mail.ru>"
   copyright: "Copyright (c) 2002, Eugene Melekhov and others"
   license: "Eiffel Forum Freeware License v1 (see forum.txt)"
   status: "mostly complete"

expanded class SB_TEXT_FIELD_COMMANDS

inherit

	SB_FRAME_COMMANDS
		rename
			Id_last as FRAME_ID_LAST
     	--	Id_delete as FRAME_ID_DELETE
		end

feature

	ID_CURSOR_HOME		: INTEGER is once Result := FRAME_ID_LAST end
	ID_CURSOR_END		: INTEGER is once Result := FRAME_ID_LAST + 1 end
	ID_CURSOR_RIGHT		: INTEGER is once Result := FRAME_ID_LAST + 2 end
	ID_CURSOR_LEFT		: INTEGER is once Result := FRAME_ID_LAST + 3 end
	ID_MARK				: INTEGER is once Result := FRAME_ID_LAST + 4 end
	ID_EXTEND			: INTEGER is once Result := FRAME_ID_LAST + 5 end
	ID_SELECT_ALL		: INTEGER is once Result := FRAME_ID_LAST + 6 end
	ID_DESELECT_ALL		: INTEGER is once Result := FRAME_ID_LAST + 7 end
	ID_CUT_SEL			: INTEGER is once Result := FRAME_ID_LAST + 7 end
	ID_COPY_SEL			: INTEGER is once Result := FRAME_ID_LAST + 8 end
	ID_PASTE_SEL		: INTEGER is once Result := FRAME_ID_LAST + 9 end
	ID_DELETE_SEL		: INTEGER is once Result := FRAME_ID_LAST + 10 end
	ID_OVERST_STRING	: INTEGER is once Result := FRAME_ID_LAST + 11 end
	ID_INSERT_STRING	: INTEGER is once Result := FRAME_ID_LAST + 12 end
	ID_BACKSPACE		: INTEGER is once Result := FRAME_ID_LAST + 13 end
--	Id_delete			: INTEGER is once Result := FRAME_ID_LAST + 14 end
	ID_TOGGLE_EDITABLE	: INTEGER is once Result := FRAME_ID_LAST + 15 end
	ID_TOGGLE_OVERSTRIKE: INTEGER is once Result := FRAME_ID_LAST + 16 end
	ID_BLINK			: INTEGER is once Result := FRAME_ID_LAST + 17 end
	Id_last				: INTEGER is once Result := FRAME_ID_LAST + 18 end

end
