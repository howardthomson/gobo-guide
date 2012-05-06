note
	description:"The Event"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

	TODO: "[
		Change event processing to:
		
			event.process
			if event.handled then
				...
			end

			How to pass the event iteself to targeted routines ?
		]"

class SB_EVENT

inherit

	SB_MODIFIER_MASKS

feature

	type			: INTEGER			-- Event type
	time			: INTEGER			-- Time of last event
	win_x,  win_y	: INTEGER			-- Window-relative x/y-coord
	root_x, root_y	: INTEGER			-- Root x/y-coord
	state			: INTEGER			-- Keyboard/Modifier state
	code			: INTEGER			-- Button, Keysym, or mode; DDE Source
	text			: STRING			-- Text of keyboard event
	last_x, last_y	: INTEGER         	-- Window-relative coord of previous mouse location
	click_x, click_y: INTEGER			-- Window-relative y-coord of mouse press
	rootclick_x,
	rootclick_y		: INTEGER			-- Root-relative x-coord of mouse press
	click_time		: INTEGER			-- Time of mouse button press
	click_button	: INTEGER			-- Mouse button pressed
	click_count		: INTEGER         	-- Click-count
	moved			: BOOLEAN         	-- Moved cursor since press

--	rect			: SB_RECTANGLE		-- Rectangle
		-- Removed due to expanded class problems with Estudio
		
	rect_x,
	rect_y,
	rect_w,
	rect_h			: INTEGER			-- Rectangle
	synthetic		: BOOLEAN         	-- True if synthetic expose event
	target			: INTEGER         	-- Target drag type

	event_originator: SB_MESSAGE_HANDLER	-- The originator of this event, if /= Void
	event_target	: SB_MESSAGE_HANDLER	-- The target processor of this event
	event_id		: INTEGER				-- Event sub-type
	data			: ANY					-- Associated data

	normal: BOOLEAN
		do
			Result := (state & (SHIFTMASK | CONTROLMASK)) = 0
		end

	shift: BOOLEAN
		do
			Result := (state & SHIFTMASK) /= 0
		end

	control: BOOLEAN
		do
			Result := (state & CONTROLMASK) /= 0
		end

	shift_control: BOOLEAN
		do
			Result := shift and control
		end

	shift_only: BOOLEAN
		do
			Result := (state & SHIFTMASK) = SHIFTMASK
		end

	control_only: BOOLEAN
		do
			Result := (state & CONTROLMASK) = CONTROLMASK
		end

	trace
		do
			fx_trace(0, <<"SB_EVENT::trace: ",
						"Type: ", type.out,
						" click_count: ", click_count.out
			>> )
		end

	set_rect_x (a_x: INTEGER)
		do
			rect_x := a_x
		end

	set_rect_y (a_y: INTEGER)
		do
			rect_y := a_y
		end

	set_rect_w (a_w: INTEGER)
		do
			rect_w := a_w
		end

	set_rect_h (a_h: INTEGER)
		do
			rect_h := a_h
		end

	set_rect_xywh (a_x, a_y, a_w, a_h: INTEGER)
		do
			rect_x := a_x
			rect_y := a_y
			rect_w := a_w
			rect_h := a_h
		end

   set_type (a_type: like type)
      do
         type := a_type
      end

   set_time (a_time: like time)
      do
         time := a_time
      end

   set_state (a_state: like state)
      do
         state := a_state
      end

   set_code (a_code: like code)
      do
         code:= a_code
      end

   set_text (a_text: like text)
      do
         text := a_text
      end

   clear_text
      do
         text := Void
      end

   set_last_x (a_last_x: like last_x)
      do
         last_x := a_last_x
      end

   set_last_y (a_last_y: like last_y)
      do
         last_y := a_last_y
      end

   set_click_x (a_click_x: like click_x)
      do
         click_x := a_click_x
      end

   set_click_y (a_click_y: like click_y)
      do
         click_y := a_click_y
      end

   set_rootclick_x (a_rootclick_x: like rootclick_x)
      do
         rootclick_x := a_rootclick_x
      end

   set_rootclick_y (a_rootclick_y: like rootclick_y)
      do
         rootclick_y := a_rootclick_y
      end

   set_click_button (a_click_button: like click_button)
      do
         click_button := a_click_button
      end

   set_win_x (a_win_x: like win_x)
      do
         win_x := a_win_x
      end

   set_win_y (a_win_y: like win_y)
      do
         win_y := a_win_y
      end

   set_root_x (a_root_x: like root_x)
      do
         root_x := a_root_x
      end

   set_root_y (a_root_y: like root_y)
      do
         root_y := a_root_y
      end

   set_click_time (a_click_time: like click_time)
      do
         click_time := a_click_time
      end

   set_click_count (a_click_count: like click_count)
      do
         click_count := a_click_count
      end

   set_moved (a_moved: like moved)
      do
         moved := a_moved
      end
  
   set_synthetic (a_synthetic: like synthetic)
      do
         synthetic := a_synthetic
      end

	set_target (a_target: like target)
		do
			target := a_target
		end

	set_data (a_data: like data)
		do
			data := a_data
		end

feature -- Event processing

	reset
		do
			event_id := 0
			data := Void
		end

	set_event_originator (an_originator: SB_MESSAGE_HANDLER)
		do
			event_originator := an_originator
		end

	set_event_target (a_target: SB_MESSAGE_HANDLER)
		do
			event_target := a_target
		end

	set_event_id (an_id: INTEGER)
		do
			event_id := an_id
		end

	process: BOOLEAN
			-- Process event where message_target = sender
		do
			event_target.process_event (Current)
			Result := event_target.handled
		end

	process_with_id (an_id: INTEGER): BOOLEAN
		do
			event_id := an_id
			Result := process
		end

	process_with_data (a_data: ANY): BOOLEAN
		do
			data := a_data
			Result := process
		end

	process_with_id_data (an_id: INTEGER; a_data: ANY): BOOLEAN
		do
			event_id := an_id
			data := a_data
			Result := process
		end

	process_with_id_and_event (an_id: INTEGER): BOOLEAN
		do
			event_id := an_id
			data := Current
			Result := process
		end

feature -- Target event processing


--#######
-- change send_... routines back to having a message_target parameter
-- add emit_... routines (as send_... below) sending to registered targets

	send (a_target: SB_MESSAGE_HANDLER): BOOLEAN
		do
			if a_target = Void then
				--	Result := False
			else
				event_target := a_target
				Result := process
			end
		end

	send_with_id (a_target: SB_MESSAGE_HANDLER; an_id: INTEGER): BOOLEAN
		do
			if a_target = Void then
				--	Result := False
			else
				event_target := a_target
				event_id := an_id
				Result := process
			end
		end

	send_with_data (a_target: SB_MESSAGE_HANDLER; a_data: ANY): BOOLEAN
		do
			if a_target = Void then
				--	Result := False
			else
				event_target := a_target
				data := a_data
				Result := process
			end
		end

	send_with_id_data (a_target: SB_MESSAGE_HANDLER; an_id: INTEGER; a_data: ANY): BOOLEAN
		do
			if a_target = Void then
				--	Result := False
			else
				event_target := a_target
				event_id := an_id
				data := a_data
				Result := process
			end
		end

	emit: BOOLEAN
		local
			l_target: SB_MESSAGE_HANDLER
		do
			l_target := event_originator.message_target
			if l_target = Void then
				--	Result := False
			else
				event_target := l_target
				Result := process
			end
		end

	emit_with_id (an_id: INTEGER): BOOLEAN
		local
			l_target: SB_MESSAGE_HANDLER
		do
			l_target := event_originator.message_target
			if l_target = Void then
				--	Result := False
			else
				event_target := l_target
				event_id := an_id
				Result := process
			end
		end

	emit_with_data (a_data: ANY): BOOLEAN
		local
			l_target: SB_MESSAGE_HANDLER
		do
			l_target := event_originator.message_target
			if l_target = Void then
				--	Result := False
			else
				event_target := l_target
				data := a_data
				Result := process
			end
		end

	emit_with_id_data (an_id: INTEGER; a_data: ANY): BOOLEAN
		local
			l_target: SB_MESSAGE_HANDLER
		do
			l_target := event_originator.message_target
			if l_target = Void then
				--	Result := False
			else
				event_target := l_target
				event_id := an_id
				data := a_data
				Result := process
			end
		end

end
