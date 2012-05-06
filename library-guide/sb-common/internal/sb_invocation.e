note

		description:"Modal loop invocation object"

	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

class SB_INVOCATION

create

   make

feature {SB_APPLICATION}

	make (a_upper: SB_INVOCATION; a_mode: INTEGER; a_window: SB_WINDOW)
		do
			upper := a_upper
			modality := a_mode
			window := a_window
		end

feature

	upper: SB_INVOCATION	-- Upper invocation
	window: SB_WINDOW		-- Window to match
	modality: INTEGER		-- Modality mode
	done: BOOLEAN			-- True if higher invocation is done
	code: INTEGER			-- Return code

feature { SB_APPLICATION_DEF, SB_RAW_EVENT_DEF }

   set_done
      do
         done := True
      end

   set_code(a_code: INTEGER)
      do
         code := a_code
      end

	ev: SB_RAW_EVENT
		do
			if inv_ev = Void then
				create inv_ev.make
			end
			Result := inv_ev
		end

feature {NONE}

	inv_ev: SB_RAW_EVENT

end
