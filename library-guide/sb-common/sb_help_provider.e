indexing
	description:"Object wich provides help string"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

deferred class SB_HELP_PROVIDER

inherit

	SB_MESSAGE_SENDER

	SB_WINDOW_CONSTANTS

feature -- Data

	help_text: STRING
		-- Help text

	on_query_help(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
		local
         	wc: SB_WINDOW_COMMANDS
      	do
         	if help_text /= Void and then not help_text.is_empty and then (flags & Flag_help) /= Zero then
            	sender.do_handle_2 (Current, SEL_COMMAND, wc.Id_setstringvalue, help_text)
            	Result := True
         	end
      	end

   	set_help_text(text: STRING) is
         	-- Set the status line help text for Current list
      	do
         	help_text := text
      	end

   	flags: INTEGER is
      	deferred
      	end

end
