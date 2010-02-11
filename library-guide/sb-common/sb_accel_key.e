indexing
	description:"Accelerator map entry"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

class SB_ACCEL_KEY

inherit

	ANY	-- for SE 2.1

creation { SB_ACCEL_TABLE }

	make

feature { SB_ACCEL_TABLE }

	make (a_code: INTEGER; a_target: SB_MESSAGE_HANDLER; a_message_down, a_message_up: INTEGER) is
		require
			target_not_void: a_target /= Void
		do
			code		 := a_code;
			target		 := a_target;
			message_down := a_message_down;
			message_up	 := a_message_up;
		end

	target: SB_MESSAGE_HANDLER;
			-- Target object of message

	message_down: INTEGER;
			-- Message being sent at key press

	message_up: INTEGER;
			-- Message being sent at key release

	code: INTEGER;
			-- Keysym and modifier mask to match
end
