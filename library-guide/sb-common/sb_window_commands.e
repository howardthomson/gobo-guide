indexing
	description:"SB_WINDOW commands"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v1 (see forum.txt)"
	status:		"mostly complete"


expanded class SB_WINDOW_COMMANDS

inherit

	SB_MESSAGE_HANDLER_COMMANDS
    	rename
    		Id_last as Message_handler_id_last
		end

feature


feature -- Once function implementation

	Id_none					: INTEGER is once Result := Message_handler_id_last + 1 end
	Id_hide					: INTEGER is once Result := Message_handler_id_last + 2 end
	Id_show					: INTEGER is once Result := Message_handler_id_last + 3 end
	Id_toggleshown			: INTEGER is once Result := Message_handler_id_last + 4 end
	Id_lower				: INTEGER is once Result := Message_handler_id_last + 5 end
	Id_raise				: INTEGER is once Result := Message_handler_id_last + 6 end
	Id_delete				: INTEGER is once Result := Message_handler_id_last + 7 end
	Id_disable				: INTEGER is once Result := Message_handler_id_last + 8 end
	Id_enable				: INTEGER is once Result := Message_handler_id_last + 9 end
	Id_uncheck				: INTEGER is once Result := Message_handler_id_last + 10 end
	Id_check				: INTEGER is once Result := Message_handler_id_last + 12 end
	Id_unknown				: INTEGER is once Result := Message_handler_id_last + 12 end
	Id_update				: INTEGER is once Result := Message_handler_id_last + 13 end
	Id_autoscroll			: INTEGER is once Result := Message_handler_id_last + 14 end
	Id_caretblink			: INTEGER is once Result := Message_handler_id_last + 15 end
	Id_hscrolled			: INTEGER is once Result := Message_handler_id_last + 16 end
	Id_vscrolled			: INTEGER is once Result := Message_handler_id_last + 17 end
	Id_setvalue				: INTEGER is once Result := Message_handler_id_last + 18 end
	Id_setintvalue			: INTEGER is once Result := Message_handler_id_last + 19 end
	Id_setrealvalue			: INTEGER is once Result := Message_handler_id_last + 20 end
	Id_setstringvalue		: INTEGER is once Result := Message_handler_id_last + 21 end	-- To here
	Id_setintrange			: INTEGER is once Result := Message_handler_id_last + 22 end
	Id_setrealrange			: INTEGER is once Result := Message_handler_id_last + 23 end
	Id_getintvalue			: INTEGER is once Result := Message_handler_id_last + 24 end
	Id_getrealvalue			: INTEGER is once Result := Message_handler_id_last + 25 end
	Id_getstringvalue		: INTEGER is once Result := Message_handler_id_last + 26 end
	Id_getintrange			: INTEGER is once Result := Message_handler_id_last + 27 end
	Id_getrealrange			: INTEGER is once Result := Message_handler_id_last + 28 end
	Id_getvalue				: INTEGER is once Result := Message_handler_id_last + 29 end
	Id_query_tip			: INTEGER is once Result := Message_handler_id_last + 30 end
	Id_query_help			: INTEGER is once Result := Message_handler_id_last + 31 end
	Id_query_menu			: INTEGER is once Result := Message_handler_id_last + 32 end
	Id_hotkey				: INTEGER is once Result := Message_handler_id_last + 33 end
	Id_accel				: INTEGER is once Result := Message_handler_id_last + 34 end
	Id_unpost				: INTEGER is once Result := Message_handler_id_last + 35 end
	Id_post					: INTEGER is once Result := Message_handler_id_last + 36 end
	Id_mdi_TILEHORIZONTAL	: INTEGER is once Result := Message_handler_id_last + 37 end
	Id_mdi_TILEVERTICAL		: INTEGER is once Result := Message_handler_id_last + 38 end
	Id_mdi_CASCADE			: INTEGER is once Result := Message_handler_id_last + 39 end
	Id_mdi_MAXIMIZE			: INTEGER is once Result := Message_handler_id_last + 40 end
	Id_mdi_MINIMIZE			: INTEGER is once Result := Message_handler_id_last + 41 end
	Id_mdi_RESTORE			: INTEGER is once Result := Message_handler_id_last + 42 end
	Id_mdi_CLOSE			: INTEGER is once Result := Message_handler_id_last + 43 end
	Id_mdi_WINDOW			: INTEGER is once Result := Message_handler_id_last + 44 end
	Id_mdi_menuWINDOW		: INTEGER is once Result := Message_handler_id_last + 45 end
	Id_mdi_menuMINIMIZE		: INTEGER is once Result := Message_handler_id_last + 46 end
	Id_mdi_menuRESTORE		: INTEGER is once Result := Message_handler_id_last + 47 end
	Id_mdi_menuCLOSE		: INTEGER is once Result := Message_handler_id_last + 48 end
	Id_mdi_NEXT				: INTEGER is once Result := Message_handler_id_last + 49 end
	Id_mdi_PREV				: INTEGER is once Result := Message_handler_id_last + 50 end
	Id_CLOSE_DOCUMENT		: INTEGER is once Result := Message_handler_id_last + 51 end
	Id_CLOSE_ALL_DOCUMENTS	: INTEGER is once Result := Message_handler_id_last + 52 end
	Id_last					: INTEGER is once Result := Message_handler_id_last + 53 end

end
