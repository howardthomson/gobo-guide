note
	description: "[
		DialogBox window. When receiving ID_CANCEL or ID_ACCEPT,
		the DialogBox breaks out of the modal loop and returns FALSE or TRUE,
		respectively. To close the DialogBox when not running modally, simply
		send it Id_hide.
	]"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

class SB_DIALOG_BOX

inherit

	SB_TOP_WINDOW
    	rename
        	Id_last		as TOP_WINDOW_ID_LAST,
        	make_child	as top_window_make_child,
        	make_top	as top_window_make_top,
        	make_ev		as top_window_make_ev
      	redefine
        	handle_2,
        	on_key_press,
        	on_key_release,
        	class_name
      	end

	SB_DIALOG_BOX_COMMANDS

	SB_EXPANDED

create

	make_top,
	make_child,
	make_top_opts,
	make_child_opts,
	make_ev

feature -- class name

	class_name: STRING
		once
			Result := "SB_DIALOG_BOX"
		end

feature -- Creation

	make_ev
		do
			make_top (application, once "Default dialog name", 0)
		end

	make_top (a: EV_APPLICATION_IMP; name: STRING; opts: INTEGER)
    		-- Construct free-floating dialog
      	local
         	o: INTEGER
      	do
         	if opts = Zero then
            	o := Decor_title | Decor_border
         	else
            	o := opts
         	end
         	make_top_opts (a, name, o, 0,0,0,0, 10,10,10,10, 4,4);
      	end

   	make_top_opts (a: EV_APPLICATION_IMP; name: STRING; opts: INTEGER; x,y,w,h, pl,pr,pt,pb, hs,vs: INTEGER)
      	do
         	top_window_make_top (a, name, Void, Void, opts, x,y,w,h, pl,pr,pt,pb, hs,vs);
      	end

	make_child (ownr: SB_WINDOW; name: STRING; opts: INTEGER)
			-- Construct dialog which will always float over the owner window
		local
			o: INTEGER
      	do
         	if opts = Zero then
            	o := Decor_title | Decor_border
         	end
         	make_child_opts (ownr, name, o, 0,0,0,0, 10,10,10,10, 4,4);
      	end

	make_child_opts (ownr: SB_WINDOW; name: STRING; opts: INTEGER; x,y,w,h, pl,pr,pt,pb, hs,vs: INTEGER)
		do
			top_window_make_child (ownr, name, Void, Void, opts, x,y,w,h, pl,pr,pt,pb, hs,vs);
		end

feature -- Actions

	execute: INTEGER
    		-- Run modal invocation of the dialog
      	do
        	Result := execute_at (PLACEMENT_CURSOR)
      	end

	execute_at (placement: INTEGER): INTEGER
    		-- Run modal invocation of the dialog
      	do
       		create_resource
        	show_at (placement)
         	Result := application.run_modal_for (Current)
      	end

feature -- Message processing

	handle_2 (sender: SB_MESSAGE_HANDLER; type, key: INTEGER; data: ANY): BOOLEAN
    	do
        	if		match_function_2 (SEL_COMMAND, 	ID_CANCEL,	type, key) then Result := on_cmd_cancel (sender, key, data);
        	elseif	match_function_2 (SEL_CLOSE,	0,			type, key) then Result := on_cmd_cancel (sender, key, data);
        	elseif	match_function_2 (SEL_COMMAND, 	ID_ACCEPT,	type, key) then Result := on_cmd_accept (sender, key, data);
        	else Result := Precursor(sender, type, key, data)
        	end
      	end

	on_key_press (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
		local
         	ev: SB_EVENT;
      	do
         	ev ?= data
         	check
            	ev /= Void
         	end
         	if Precursor (sender, selector, data) then
            	Result := True
         	elseif ev.code = sbk.key_escape then
            	do_handle_2 (Current, SEL_COMMAND, ID_CANCEL, Void)
            	Result := True
         	end
      	end

	on_key_release (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
    	local
         	ev: SB_EVENT
      	do
         	ev ?= data
         	check
            	ev /= Void
         	end
         	if Precursor (sender, selector, data)
            	or else  ev.code = sbk.key_escape
          	then
            	Result := True
         	end
      	end

   	on_cmd_accept (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
         	-- Close dialog with an accept
      	do
         	application.stop_modal_window (Current, SB_TRUE)
         	hide
         		-- hide is not working?
         	Result := True
      	end

   	on_cmd_cancel (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      	do
         	application.stop_modal_window (Current, SB_FALSE)
         	hide
         	Result := True
      	end

end
