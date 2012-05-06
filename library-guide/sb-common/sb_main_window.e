note
	description:"Main application window"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

class SB_MAIN_WINDOW

inherit
	SB_TOP_WINDOW
		rename
			make as window_make
		redefine
			on_cmd_close,
			class_name
      	end

create

	make, make_opts

feature -- class name

	class_name: STRING
		once
			Result := "SB_MAIN_WINDOW"
		end

feature -- Creation

	make (a: SB_APPLICATION; name: STRING)
    	do
        	make_opts (a, name, Void, Void, Decor_all, 0,0,0,0, 0,0,0,0, 0,0);
      	end

	make_opts (a: SB_APPLICATION; name: STRING; ic, mi: SB_ICON; opts: INTEGER;
                        x,y,w,h, pl,pr,pt,pb, hs,vs: INTEGER)
    	do
        	make_top (a, name, ic, mi, opts, x,y,w,h, pl,pr,pt,pb, hs,vs)
      	end
      
feature -- Queries

	main_windows_number: INTEGER
			-- count of main windows
    	local
        	win: SB_WINDOW
        	mw: SB_MAIN_WINDOW
      	do
         	from
            	win := parent.first_child
         	until
            	win = Void
         	loop
            	mw ?= win
            	if mw /= Void and then not mw.is_shown then
               		Result := Result + 1
            	end
               	win := win.next
         	end
      	end

feature -- Message Processing

	on_cmd_close (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
			-- Unless target catches it, close down the app
		do
			fx_trace(0, <<"SB_MAIN_WINDOW::on_close -- routine entry">>)
        	-- If not handled, and this was the last main window, we die.
         	if (message_target = Void or else not message_target.handle_2 (Current, SEL_CLOSE, message, Void))
            	and then main_windows_number = 1	-- XXX should be 1 !!!
          	then
            	application.do_handle_2 (Current, SEL_COMMAND, application.ID_QUIT, Void);
         	end
         	Result := True
      	end
end
