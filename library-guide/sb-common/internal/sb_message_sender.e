indexing
   description: "[
		Base class for objects that have target to send message to,
		and the message to send
	]"

	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

deferred class SB_MESSAGE_SENDER

inherit

	SB_MESSAGE_HANDLER
		rename
			Id_last as Message_handler_id_last
		undefine
			handle_2,
			on_default_2
		end

feature -- Data
         
	message: INTEGER
		-- Message ID

feature -- Setters

	set_message_target (target: SB_MESSAGE_HANDLER) is
			-- Set the message target object for this window
		do
			message_target := target
		end

	set_message (sel: INTEGER) is
			-- Set the message identifier for this window
		do
			message := sel
		end

	set_target_and_message (target: SB_MESSAGE_HANDLER; sel: INTEGER) is
			-- Set the message target object and message for this window
		do
			message_target := target
			message := sel
		end

feature -- Actions

	event_of_type_with_target (a_type: INTEGER; a_target: SB_MESSAGE_HANDLER): SB_EVENT
		do
			Result := new_event
			Result.set_type (a_type)
			Result.set_event_target (a_target)
		end

	send (message_type: INTEGER; data: ANY): BOOLEAN is
			-- Handle message, and return the result
		do
			if message_target /= Void then
--				Result := message_target.handle_2 (Current, message_type, message, data)
				Result := event_of_type_with_target (message_type, message_target).process_with_id_data (message, data)
			end
		end

	frozen do_send (message_type: INTEGER; data: ANY) is
			-- Handle message, and forget the result
		local
			tmp: BOOLEAN
		do
			if message_target /= Void then
--				tmp := message_target.handle_2 (Current, message_type, message, data)
				tmp := event_of_type_with_target (message_type, message_target).process_with_id_data (message, data)
			end
		end

end
