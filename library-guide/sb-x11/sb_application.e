indexing
    description: "[
            -- X Window System implementation code for SB_APP
	]"
	todo: "[
			Modify add_repaint &c to not export X internals to cross-platform
			classes and code
			Re-code get_next_event et-al to ensure that blocking actions only occur after processing of
			currently accumulated events after the expiration of the last blocking action.
	]"

	done: "[
			FIXGC: cross_bits etc once routines currently return a POINTER as the once value. The once value
			should be a reference to the manifest array, so that the GC will not collect it, making the
			currently available POINTER value invalid.
	]"

class SB_APPLICATION

inherit
	
	SB_APPLICATION_DEF
	SB_MODALITY

	SB_KEYS

	X_EVENT_TYPES
	X_H
	X_PREDEFINED_ATOMS

	SB_UTILS

	SB_DC_CONSTANTS

	MEMORY	-- for reporting allocated bytes

	STRING_HANDLER	-- For access to STRING internal storage

creation {EV_APPLICATION_IMP}

	make	-- This class inherited by root class only

feature	-- Class name

	class_name: STRING is
			-- Name of class
		once
			Result := "SB_APPLICATION"
		end

feature	--{NONE}	-- Attributes

	display				: X_DISPLAY
	default_root_window	: X_WINDOW
	wcontext			: X_CONTEXT        -- Window hash context

	repaints,
	repaintrecs			: SB_REPAINT

	wmDeleteWindow		: X_ATOM	-- Catch delete window
	wmQuitApp			: X_ATOM	-- Catch quit application
	wmProtocols			: X_ATOM	-- Window manager protocols
	wmMotifHints		: X_ATOM	-- Motif hints
	wmTakeFocus			: X_ATOM	-- Focus explicitly set by app
	wmState				: X_ATOM	-- Window state
	ddeTargets			: X_ATOM	-- DDE targets atom
	ddeAtom				: X_ATOM	-- DDE exchange atom
	ddeDelete			: X_ATOM	-- DDE delete target atom

	dde_typelist		: ARRAY [ INTEGER ];	-- FXDragType	DDE drop type list

	ddeAction			: INTEGER;    -- DDE action
	ansAction			: INTEGER;    -- Reply action

	xcbSelection		: X_ATOM    	-- Clipboard selection

	xcb_typelist		: ARRAY [ INTEGER ];	-- Clipboard type list
	xsel_typelist		: ARRAY [ INTEGER ]; 	-- Selection type list
	xdnd_typelist		: ARRAY [ INTEGER ]; 	-- XDND type list

	xdndProxy			: X_ATOM   	-- XDND proxy atom
	xdndAware			: X_ATOM   	-- XDND awareness atom

	xdndEnter			: X_ATOM   	-- XDND enter window message
	xdndLeave			: X_ATOM   	-- XDND leave window message
	xdndPosition		: X_ATOM   	-- XDND position update message
	xdndStatus			: X_ATOM		-- XDND status feedback message
	xdndDrop			: X_ATOM   	-- XDND drop message
	xdndFinished		: X_ATOM   	-- XDND finished message

	xdndSelection		: X_ATOM   	-- XDND selection atom

	xdndActionMove		: X_ATOM   	-- XDND Move action
	xdndActionCopy		: X_ATOM   	-- XDND Copy action
	xdndActionLink		: X_ATOM   	-- XDND Link action
	xdndActionPrivate	: X_ATOM   	-- XDND Private action

	xdndTypes			: X_ATOM   	-- XDND types list atom

--	xdndSource			: FXID;   	-- XDND drag source window
--	xdndTarget			: FXID;   	-- XDND drop target window
--	xdndProxyTarget		: FXID;   	-- XDND window to set messages to

	xdndStatusPending	: BOOLEAN;	-- XDND waiting for status feedback
	xdndStatusReceived	: BOOLEAN; 	-- XDND received at least one status
	xdndWantUpdates		: BOOLEAN;    -- XDND target wants new positions while in rect

	xdndRect			: SB_RECTANGLE;		-- XDND rectangle bounding target

	stipples			: ARRAY [ X_PIXMAP ];   -- Standard stipple patterns 23 No

	shmi		: BOOLEAN	-- Use XSHM Image possible
	shmp		: BOOLEAN	-- Use XSHM Pixmap possible
	synchronize	: BOOLEAN	-- Synchronized


feature {NONE} -- Implementation routines

	make_imp is
		do
			create normal_font.make (Current, "helvetica", 9)	--, FONTWEIGHT_BOLD);

			init_colours

					-- DDE
			ddeAction := DRAG_REJECT		-- Drag and drop action requested
			ansAction := DRAG_REJECT		-- Drag and drop action suggested

			xdndWantUpdates := True;		-- XDND target always wants new positions

				-- Miscellaneous stuff
			shmi := True
			shmp := True
			synchronize := False
		end

	make_cursors is
		local
			new_cursor: SB_CURSOR
		do
				-- Make some cursors
			create cursors.make (1, Def_rotate_cursor + 1)

				-- Stock cursors
			create new_cursor.make_from_stock (Current, CURSOR_ARROW);	cursors.put (new_cursor, Def_arrow_cursor)
			create new_cursor.make_from_stock (Current, CURSOR_RARROW);	cursors.put (new_cursor, Def_rarrow_cursor)
			create new_cursor.make_from_stock (Current, CURSOR_IBEAM);	cursors.put (new_cursor, Def_text_cursor)

		-- Cursors from bit patterns

				-- Cursors for splitter
			cursors.put (hsplit_cursor, Def_hsplit_cursor)
			cursors.put (vsplit_cursor, Def_vsplit_cursor)
			cursors.put (xsplit_cursor, Def_xsplit_cursor)

				-- Color swatch
			cursors.put (swatch_cursor, Def_swatch_cursor)

				-- Move
			cursors.put (move_cursor, Def_move_cursor)

				-- Dragging edges/corners
			cursors.put (resizetop_cursor, 		Def_dragh_cursor)
			cursors.put (resizeleft_cursor, 	Def_dragv_cursor)
			cursors.put (resizetopright_cursor,	Def_dragtr_cursor)
			cursors.put (resizetopleft_cursor,	Def_dragtl_cursor)

				-- DND actions
			cursors.put (dontdrop_cursor, Def_dndstop_cursor)
			cursors.put (dndcopy_cursor,  Def_dndcopy_cursor)
			cursors.put (dndmove_cursor,  Def_dndmove_cursor)
			cursors.put (dndlink_cursor,  Def_dndlink_cursor)

				-- Crosshairs
			cursors.put (crosshair_cursor, Def_crosshair_cursor)

				-- NE,NW,SE,SW corners
			cursors.put (ne_cursor, Def_cornerne_cursor)
			cursors.put (nw_cursor, Def_cornernw_cursor)
			cursors.put (se_cursor, Def_cornerse_cursor)
			cursors.put (sw_cursor, Def_cornersw_cursor)

			  -- Rotate
			cursors.put(rotate_cursor, Def_rotate_cursor)
		end

	init_colours is
		do
			border_color	:= sbrgb (0, 0, 0)
			base_color		:= sbrgb (192, 192, 192)
			hilite_color	:= make_hilite_color (base_color)
	        shadow_color	:= make_shadow_color (base_color)
	        back_color		:= sbrgb (255, 255, 255)
	        fore_color		:= sbrgb (0, 0, 0)
	        sel_fore_color	:= sbrgb (255, 255, 255)
	        sel_back_color	:= sbrgb (0, 0, 128)
	        tip_fore_color	:= sbrgb (0, 0, 0)
			tip_back_color	:= sbrgb (255, 255, 192)
		end

feature -- Event processing

   peek_event: BOOLEAN is
         -- Peek to determine if there's an event
      do
         if initialized then
         	-- todo
         end
      end

--	#################### run_one_event #######################

	run_one_event is
         -- Perform one event dispatch
		local
			ev: SB_RAW_EVENT_DEF
		do

			create_new_resources
		
			ev := get_next_event (True)
			if ev /= Void then
				ev.process (Current)
			else
					-- Sleep waiting for an event
				display.flush
				sleep_on_select
				
					-- Update current time
				sus_time.make_from_now
			end
		end

	select_api: SELECT_API is
		once
			create Result.make
		end

	sleep_on_select is
		local
			i: INTEGER
		do

			-- New select() implementation
			check
		--		xevq.events_queued(xevq.Queued_already) = 0
			end
			select_api.zero_all
			select_api.set_read (display.connection_number)
			if timers /= Void then
				select_api.set_delta (timers.seconds - sus_time.seconds, timers.micro_secs - sus_time.microseconds)
				select_api.execute_timeout
			else
				select_api.set_delta (0, 0)
				select_api.execute
			end
			if select_api.max >= 1 then
				if select_api.is_set_read (display.connection_number) then
					i := xevq.events_queued (xevq.Queued_after_reading)
				end
			end
		end

feature -- Timers implementation

	sus_time: SB_TIME_VALUE is
			-- Single UNIX Specification Time Value
		once
			create Result.make_from_now
		end

	timers, free_timers: SB_TIMER

	get_timer: SB_TIMER is
		do
			if free_timers /= Void then
				Result := free_timers
				free_timers := Result.next
			else
				create Result
			end
		end

-- This version for re-development

	XXXprocess_timers is
		local
			t: SB_TIMER
		do
				-- Handle all past due timers
			sus_time.make_from_now	-- Moved after blocking call in get_next_event
			from
				t := timers
			until
				t = Void or else not t.is_due (sus_time)
			loop
				timers := t.next
				if t.target /= Void then
					if event_timeout.process_with_id_and_event (t.message) then
				--		refresh
					end
				end
				t.set_next (free_timers)
				free_timers := t
				t := timers
			end
		end

feature -- Timeouts

	add_timeout (ms: INTEGER; tgt: SB_MESSAGE_HANDLER; sel: INTEGER): SB_TIMER is
			-- Add timeout message to be sent to target object in ms milliseconds;
			-- the timer fires only once after the interval expires.
		require else
			good_target: tgt /= Void
			good_timeout: ms > 0
		local
			t, tl, p: SB_TIMER
			secs,
			mu_secs: INTEGER
		--	tc: INTEGER	-- timeout count
		do
			-- This loop solely for debug reporting
		--	from
		--		tc := 0; t := timers
		--	until
		--		t = Void
		--	loop
		--		t := t.next; tc := tc + 1
		--	end
		--	edp_trace.start(0, "SB_APPLICATION::add_timeout current_count = ").next(tc.out).done
		--	edp_trace.start(0, "SB_APPLICATION::add_timeout, delay = ").next(ms.out).done

			t := get_timer
		--	sus_time.make_from_now
			secs    := sus_time.seconds
			mu_secs := sus_time.microseconds
			from
				mu_secs := mu_secs + ms * 1000
			until
				mu_secs < 1_000_000
			loop
				mu_secs := mu_secs - 1_000_000
				secs := secs + 1
			end

			t.set_target(tgt)
			t.set_message(sel)
			t.set_time(secs, mu_secs)
			if False then
				-- Prepend to timer list	
				t.set_next(timers)
				timers := t
			else
				-- Insert into ordered timer list
				from
					p := Void
					tl := timers
				until
					tl = Void or else t.precedes(tl)
				loop
					p := tl
					tl := tl.next
				end
				if p = Void then
					t.set_next(timers)
					timers := t
				else
					check p.next = tl end
					t.set_next(tl)
					p.set_next(t)
				end
			end
			Result := t
			check
				not_due: not t.is_due(sus_time)
			end
		end

	remove_timeout (timer: SB_TIMER) is
    		-- Remove timeout
		require else
			good_timer : timer /= Void
		local
			p, t: SB_TIMER
		do
			from
				p := Void
				t := timers
			until
				t = Void or else t = timer
			loop
				p := t
				t := t.next
			end
			if timer = t then
				-- found in list
				if p /= Void then
					p.set_next(t.next)
				else
					timers := t.next
				end
			else
				-- Possible error ??
			end
		end

feature {NONE}

	check_signals: BOOLEAN is
		do
		end

	xevq: X_EVENT_QUEUE is
		once
			create Result.make(display)
		end

	select_at_last_event: BOOLEAN
		-- This is True if 'select' was called at last get_next_event

--	chores: SB_CHORE

	get_next_event (blocking: BOOLEAN): SB_RAW_EVENT_DEF is
			-- Get an event
		local
			ev: SB_RAW_EVENT
		do
			ev := invocation.ev
				-- Set to no-op just in case
			ev.set_type (0)

				-- Timers
			if timers /= Void and then timers.is_due (sus_time) then
				Result := timers
				timers := timers.next

		--	if check_signals then
		--		Result := Void

		--	elseif initialized and then xevq.events_queued (xevq.Queued_after_flush) /= 0 then
			elseif initialized and then xevq.events_queued (xevq.Queued_already) /= 0 then

				-- Get an event
				xevq.next_event (ev)

				-- Input Context Filter
			--	if xim and then XFilterEvent... then

				-- Save expose events for later...
			--	if True and (ev.type = Expose or ev.type = Graphics_expose) then
			--		add_repaint(ev.xexpose.window, ev.xexpose.x, ev.xexpose.y, ev.xexpose.width, ev.xexpose.height, False)
			--		check ev.xexpose.width /= 0 and ev.xexpose.height /= 0 end
			--	else
				--	if Motion
				--	elseif Wheel
				--	elseif ConfigureNotify
				--	end

					Result := ev
			--	end

				-- Repaints
			elseif repaints /= Void then
				Result := repaints
				repaints := repaints.next

				-- Chores
			elseif chores /= Void then
				Result := chores
				chores := chores.next

				-- Refresher
			elseif again or refresher_window /= Void then
				if again then
					refresher_window := root_window
					again := False
				end
				Result := refresher_window				
				if refresher_window.first_child /= Void then
					refresher_window := refresher_window.first_child
				else
					from
					until
						refresher_window.next /= Void or else refresher_window.parent = Void
					loop
						refresher_window := refresher_window.parent
					end
					refresher_window := refresher_window.next
				end			
			end
		end


feature {SB_WINDOW, SB_RAW_EVENT} -- Repaint routines

	add_repaint (win: INTEGER; ax,ay, aw,ah: INTEGER; a_synth: BOOLEAN) is
			-- Smart rectangle compositing algorithm
		local
			x,y, w,h: INTEGER
			synth: BOOLEAN
			px,py, pw,ph: INTEGER
			hint, area: INTEGER;
			r, pr: SB_REPAINT
			break: BOOLEAN
		do
			x := ax; y := ay; w := aw; h := ah
			synth := a_synth

			hint := w * h;
			w := w + x;
			h := h + y;

			from
				r := repaints
			until
		  		r = Void
			loop
			    	-- Find overlap with outstanding rectangles
			 	from
			 		r := repaints; pr := Void
			 		break := False
			 	until
			 		r = Void or break
			 	loop
			    	if r.window = win then

				        	-- Tentatively conglomerate rectangles
				        px := x.min (r.rect_x)
				        py := y.min (r.rect_y)
				        pw := w.max (r.rect_w)
				        ph := h.max (r.rect_h)
				        area := (pw - px) * (ph - py)

				        	-- New area MUCH bigger than sum; forget about it
				        if(area <= (hint + r.hint) * 2) then

					        -- Take old paintrect out of the list
							if pr = Void then
								repaints := r.next
							else
								pr.set_next(r.next)
							end

					        r.set_next(repaintrecs);
					        repaintrecs := r;

					        -- New rectangle
					        synth := synth or r.is_synth;		-- Synthethic is preserved!
					        hint := area;
					        x := px;
					        y := py;
					        w := pw;
					        h := ph;
					        break := True
						else
							pr := r
							r := r.next
						end
					else
						pr := r
						r := r.next
					end -- if
				end
			end
				-- Get rectangle, recycled if possible
			if repaintrecs /= Void then
				r := repaintrecs
			    repaintrecs := r.next;
			else
				create r
			end
				-- Fill it
			r.set_window (win)
			r.set_xywh (x,y,w,h)
			r.set_hint (hint)
			r.set_synth (synth)
			r.set_next (Void)
			if pr /= Void then
				pr.set_next(r)
			else
				repaints := r
			end
		end

	remove_repaints (win: SB_WINDOW; x,y, aw,ah: INTEGER) is
			-- Remove repaints by dispatching them
		local
			r, pr, nr: SB_REPAINT
			w,h: INTEGER
			ev: SB_RAW_EVENT
		do
			w := aw + x
			h := ah + y

			create ev.make
				-- Flush the buffer and wait till the X server catches up;
				-- resulting events, if any, are buffered in the client.
			display.sync (False)
				-- Fish out the expose events and compound them
			from
			until
				not xevq.check_mask_event (ExposureMask, ev)
			loop
				if ev.xany.type /= NoExpose then
					add_repaint (ev.xexpose.window, ev.xexpose.x, ev.xexpose.y,
													ev.xexpose.width, ev.xexpose.height, False)
				end
			end
				-- Then process events pertaining to window win and overlapping
				-- with the given rectangle; other events are left in the queue.
			from
				r := repaints; pr := Void
			until
				r = Void
			loop
				if win = Void
				or else (win.xwin.id = r.window -- XXXX
						and then x < r.rect_w and then y < r.rect_h
						and then r.rect_x < w and then r.rect_y < h) then

					ev.set_type (Expose)
					ev.xexpose.set_window (r.window)
					ev.xexpose.set_x (r.rect_x)
					ev.xexpose.set_y (r.rect_y)
					ev.xexpose.set_width (r.rect_w - r.rect_x)
					ev.xexpose.set_height (r.rect_h - r.rect_y)

					dispatch_event (ev)

					nr := r.next
					if pr = Void then
						repaints := r.next
					else
						pr.set_next (r.next)
					end

					r.set_next (repaintrecs)
					repaintrecs := r

					r := nr
				else
					pr := r
					r := r.next
				end
			end

				-- Flush the buffer again
			display.flush
		end

	scroll_repaints (win: X_WINDOW; dx, dy: INTEGER) is
			-- Scroll repaint rectangles; some slight trickyness here:- the
			-- rectangles don't just move, they stretch in the scroll direction
			-- This means the original dirty area will remain part of the area to
			-- be painted.
		local
  			r: SB_REPAINT
  		do
  			from
  				r := repaints
  			until
  				r = Void
  			loop
				if r.window = win.id then
					if dx > 0 then r.inc_w (dx) else r.inc_x (dx) end
					if dy > 0 then r.inc_h (dy) else r.inc_y (dy) end
				end
				r := r.next
			end
  		end

feature {NONE} -- Implementation

	find_window_with_id (w: INTEGER): SB_WINDOW is
		do
			if w /= 0 then
				Result := wcontext.item (w)
				check Result /= Void end
			end
		end

	find_window_at (x,y: INTEGER; xid: INTEGER): SB_WINDOW is
			-- Find window from root x,y, starting from given window
		local
			rootwin, window, child: INTEGER
			wx, wy: INTEGER
		do
--			if initialized then
--				rootwin := display.default_root_window.id
--				if xid = 0 then
--					window := rootwin
--				else
--					window := xid
--				end
--				from
--				until
--					not rootwin.translate_coordinates(rootwin, window, x,y)
--				loop
--					window := child
--				end
--				Result := find_window_with_id(window)
--			end
		end

-- ############################### dispatch_event ########################################

feature {SB_RAW_EVENT_DEF}

	dispatch_event (ev: SB_RAW_EVENT) is
			-- Dispatch event to widget
		local
			window:	SB_WINDOW
			sym:	INTEGER
			state:	INTEGER
			answer:		INTEGER	-- ???? X_ATOM
			ev_xexpose:	X_EXPOSE_EVENT
			ev_key:		X_KEY_EVENT
			ev_button:	X_BUTTON_EVENT
			ev_motion:	X_MOTION_EVENT
			ev_configure: X_CONFIGURE_EVENT
			b: BOOLEAN
			s: STRING
			l_event: SB_EVENT
		do
			window := find_window_with_id (ev.window)	-- re implement as: window := ev.window
			if window /= Void then

				inspect ev.type

					-- Repaint event
				when Graphics_expose, Expose then
					ev_xexpose := ev.to_x_expose_event
					l_event := event_paint
					l_event.set_event_target (window)
					l_event.set_rect_xywh (ev_xexpose.x, ev_xexpose.y, ev_xexpose.width, ev_xexpose.height)
					l_event.set_synthetic (ev_xexpose.send_event)
					l_event.set_data (l_event)
					window.process_event (l_event)

					-- Not interested in this event
				when No_expose then

					-- Keyboard
				when Key_press, Key_release then
					ev_key := ev.to_x_key_event
					if ev_key.type = Key_press then
						l_event := event_key_press
					else
						l_event := event_key_release
					end
				--	l_event.set_type (SEL_KEYPRESS + ev_key.type - Key_press);
					l_event.set_time (ev_key.time)
					l_event.set_win_x (ev_key.x)
					l_event.set_win_y (ev_key.y)
					l_event.set_root_x (ev_key.x_root)
					l_event.set_root_y (ev_key.y_root)
					state := ev_key.state & (Button4Mask | Button5Mask).bit_not     -- Exclude wheel buttons
					s := ev_key.lookup_string
					sym := ev_key.last_key_symbol
					if s /= Void then
						l_event.set_text (s)
					else
						l_event.set_text (once "")
					end
					l_event.set_code (sym)
					if ev_key.type = Key_press then
						if sym = key_shift_l	then state := state | SHIFTMASK;	end
						if sym = key_shift_r	then state := state | SHIFTMASK;	end
						if sym = key_control_l	then state := state | CONTROLMASK;	end
						if sym = key_control_l	then state := state | CONTROLMASK;	end
						if sym = key_alt_l		then state := state | ALTMASK;		end
						if sym = key_alt_r		then state := state | ALTMASK;		end
					else
						if sym = key_shift_l	then state := state & (SHIFTMASK  ).bit_not; end
						if sym = key_shift_r	then state := state & (SHIFTMASK  ).bit_not; end
						if sym = key_control_l	then state := state & (CONTROLMASK).bit_not; end
						if sym = key_control_l	then state := state & (CONTROLMASK).bit_not; end
						if sym = key_alt_l		then state := state & (ALTMASK	  ).bit_not; end
						if sym = key_alt_r		then state := state & (ALTMASK	  ).bit_not; end
					end
					l_event.set_state (state)

					-- Rules:

					-- 1) grab  window
					-- 2) accelerators
					-- 3) modal popups
					-- 4) modal dialog
					-- 5) focus window

			        if keyboard_grab_window /= Void then
			        	if keyboard_grab_window.handle_2 (Current, l_event.type, 0, l_event) then refresh end
			        else
			          	if ev.xkey.type = Key_press then
			            	key_window := focus_window;
			          	end
			          	if key_window /= Void then
			            	-- FIXME doesSaveUnder test should go away
			            	-- FIXME keyWindow should always be the modal window
			            	-- FIXME should popups grab keyboard
			            	-- FIXME perhaps pass modal event when key window is below or equal to modal window
			            	if invocation = Void	-- was /=
			            	or else invocation.modality = MODAL_FOR_NONE
			            	or else (invocation.window /= Void and then invocation.window.contains_child (key_window))
			            	or else key_window.get_shell.does_save_under then
			             		key_window.do_handle_2 (Current, l_event.type, 0, l_event)
			              		refresh
			            	else
			            		if ev.xany.type = Key_press then
			              			beep
			              		end
			           		end
			           	end
			        end

					-- Motion
				when Motion_notify then
					ev_motion := ev.xmotion
					event.set_type (SEL_MOTION)
					event.set_time (ev_motion.time)
					event.set_win_x (ev_motion.x)
					event.set_win_y (ev_motion.y)
				    event.set_root_x (ev_motion.x_root)
				    event.set_root_y (ev_motion.y_root)
				    event.set_code (0)
				    event.set_state (ev_motion.state & (Button4Mask | Button5Mask).bit_not)        -- Exclude wheel buttons
				    if ((event.root_x - event.rootclick_x).abs >= drag_delta)
				    or else ((event.root_y - event.rootclick_y).abs >= drag_delta) then
				          event.set_moved (True)
				    end
				    if mouse_grab_window /= Void then
				    --	window->translateCoordinatesTo (event.win_x, event.win_y, mouseGrabWindow, event.win_x, event.win_y);

				    	if mouse_grab_window.handle_2 (Current, event.type, 0, event) then refresh end
				        -- FIXME doesSaveUnder test should go away
				   else
				       	if invocation = Void
					 	or else invocation.modality = MODAL_FOR_NONE
					 	--or else (invocation.modality = MODAL_FOR_POPUP and then window.get_shell = invocation.window)
					 	or else (invocation.window /= Void and then invocation.window.is_owner_of(window))
					 	or else window.get_shell.does_save_under then
				    		if window.handle_2 (Current, SEL_MOTION, 0, event) then refresh end
				    	end
				    end
				    event.set_last_x (event.win_x)
				    event.set_last_y (event.win_y)

					-- Button
				when Button_press, Button_release then
						ev_button := ev.to_x_button_event
						event.set_time (ev_button.time)
						event.set_win_x (ev_button.x)
						event.set_win_y (ev_button.y)
						event.set_root_x (ev_button.x_root)
						event.set_root_y (ev_button.y_root)
						event.set_state (ev_button.state & (Button4Mask | Button5Mask).bit_not)          -- Exclude wheel buttons

					--	if ev_button.button = Button3 then
					--		edp_trace.start(0, "Button 3 Event occurred").done
					--	end

					-- Rules:
					--
					-- 1) grab window
					-- 2) if modal popup, break out of modal loop for popup
					-- 3) if modal dialog, or application modal, beep
					-- 4) dispatch to window

					-- Popups should get focus (grab keyboard+mouse); focus should revert to
					--	        -- old window after done with popup. Force focus to previous window or popup.

						if ev_button.button = Button4 or else ev_button.button = Button5 then
							-- Mouse wheel
							event.set_type (SEL_MOUSEWHEEL);
							if ev_button.button = Button4 then
								event.set_code (120)		-- * ev_button.subwindow)
							else
								event.set_code (-120)	--  * ev_button.subwindow)
							end

							from
							until
								window = Void
							loop
								if window.handle_2 (Current, SEL_MOUSEWHEEL, 0, event) then
									refresh
									window := Void
								else
									window := window.parent
								end
							end

						else
							-- Mouse button
							event.set_code (ev_button.button)
							if ev_button.type = Button_press then
					            if ev_button.button = Button1 then
					            	event.set_type (SEL_LEFTBUTTONPRESS);	event.set_state(event.state | LEFTBUTTONMASK);
					            elseif ev_button.button = Button2 then
					            	event.set_type (SEL_MIDDLEBUTTONPRESS);	event.set_state(event.state | MIDDLEBUTTONMASK);
					            elseif ev_button.button = Button3 then
									event.set_type (Sel_rightbuttonpress);	event.set_state(event.state | RIGHTBUTTONMASK);
					            end

					            if not event.moved
					            and then (event.time - event.click_time < click_speed)
					            and then (event.code = event.click_button) then
									event.set_click_count (event.click_count + 1)
						        	event.set_click_time (event.time)

						        else
						        	event.set_click_count (1)
						            event.set_click_x (event.win_x)
						            event.set_click_y (event.win_y)
						            event.set_rootclick_x (event.root_x)
						            event.set_rootclick_y (event.root_y)
						            event.set_click_button (event.code)
						            event.set_click_time (event.time)
						        end
						        state := event.state & (LEFTBUTTONMASK | MIDDLEBUTTONMASK | RIGHTBUTTONMASK)
						        if (state = LEFTBUTTONMASK) or else (state = MIDDLEBUTTONMASK) or else (state = RIGHTBUTTONMASK) then
									event.set_moved (False)
								end

							else -- Button_release
								if ev_button.button = Button1 then
									event.set_type (SEL_LEFTBUTTONRELEASE); event.set_state (event.state & (LEFTBUTTONMASK).bit_not)
								elseif ev_button.button = Button2 then
									event.set_type (SEL_MIDDLEBUTTONRELEASE); event.set_state (event.state & (MIDDLEBUTTONMASK).bit_not)
								elseif ev_button.button = Button3 then
									event.set_type (Sel_rightbuttonrelease); event.set_state (event.state & (RIGHTBUTTONMASK).bit_not)
								end
							end
							if mouse_grab_window /= Void then
								if event.type = SEL_MIDDLEBUTTONPRESS then
								--	edp_trace.start (0, "Handling Middle button press in mouse grabbed window").done
								end
								if mouse_grab_window.handle_2 (Current, event.type, 0, event) then
									refresh
								end

							-- FIXME doesSaveUnder test should go away
							elseif invocation = Void
										or else invocation.modality = MODAL_FOR_NONE
										--or else (invocation.modality = MODAL_FOR_DIALOG and then window.get_shell = invocation.window)
										or else (invocation.window /= Void and then invocation.window.is_owner_of(window))
										or else window.get_shell.does_save_under then
								if event.type = SEL_MIDDLEBUTTONPRESS then
								--	edp_trace.start (0, "Handling Middle button press in normal window").done
								end

								if window.handle_2 (Current, event.type, 0, event) then
									refresh
								end
							else
								if ev.type = Button_press then	-- FIXME need pop down spring-loaded widget such as FXPopup if clicked outside of it...
									beep
								end
							end
							event.set_last_x (event.win_x)
							event.set_last_y (event.win_y)
						--	event.trace
						end

					-- Crossing
				when Enter_notify, Leave_notify then
			        event.set_time (ev.xcrossing.time)
			        if mouse_grab_window = Void or else mouse_grab_window = window then
			        	if ev.xcrossing.mode = NotifyGrab
			        	or else ev.xcrossing.mode = NotifyUngrab
			        	or else (ev.xcrossing.mode = NotifyNormal and then ev.xcrossing.detail /= NotifyInferior) then
							debug
								if Leave_notify /= (Enter_notify + 1) then
									edp_trace.start (0, "Enter_Notify / Leave_Notify not consecutive !!").done
								end
								if (SEL_ENTER + 1) /= SEL_LEAVE then
									edp_trace.start(0, "SEL_ENTER / SEL_LEAVE not consecutive !!").done
								end
							end -- debug
			            	event.set_type (SEL_ENTER + ev.xany.type - EnterNotify)
							event.set_win_x (ev.xcrossing.x)
							event.set_win_y (ev.xcrossing.y)
							event.set_root_x (ev.xcrossing.x_root)
							event.set_root_y (ev.xcrossing.y_root)
				            event.set_code (ev.xcrossing.mode)
			            	if window.handle_2 (Current, event.type, 0, event) then
			            		refresh
			            	end
					  	end
			        end

					-- Focus change on shell window
				when Focus_in, Focus_out then
					window := window.get_shell
					if ev.xfocus.type = FocusOut and then focus_window = window then
						event.set_type (SEL_FOCUSOUT)
						if window.handle_2 (Current, SEL_FOCUSOUT, 0, event) then refresh end
						focus_window := Void
					end
					if ev.xfocus.type = FocusIn and then focus_window /= window then
						event.set_type (SEL_FOCUSIN)
						if window.handle_2 (Current, SEL_FOCUSIN, 0, event) then refresh end
						focus_window := window
					end

					-- Map
				when Map_notify then
					event.set_type (SEL_MAP)
					if window.handle_2 (Current, SEL_MAP, 0, event) then
						refresh
					end

					-- Unmap
				when Unmap_notify then
					event.set_type (SEL_UNMAP)
					if window.handle_2 (Current, SEL_UNMAP, 0, event) then
						refresh
					end

					-- Create
				when Create_notify then
					event.set_type (SEL_CREATE)
					event.set_rect_x (ev.xcreatewindow.x)
					event.set_rect_y (ev.xcreatewindow.y)
					event.set_rect_w (ev.xcreatewindow.width)
					event.set_rect_h (ev.xcreatewindow.height)
					if window.handle_2 (Current, SEL_CREATE, 0, event) then refresh end

					-- Destroy
				when Destroy_notify then
					event.set_type(SEL_DESTROY);
					if window.handle_2 (Current, SEL_DESTROY, 0, event) then refresh end

					-- Configure
				when Configure_notify then
					ev_configure := ev.xconfigure
			        event.set_type (SEL_CONFIGURE)
			        	-- According to the ICCCM, if its synthetic, the coordinates are relative
			        	-- to root window; otherwise, they're relative to the parent; so we use
			        	-- the old coordinates if its not a synthetic configure notify
			        if window.get_shell = window and then not ev.xconfigure.send_event then
			        	ev.xconfigure.set_x (window.x_pos)	check ev_configure.x = window.x_pos end
			        	ev.xconfigure.set_y (window.y_pos)	check ev_configure.y = window.y_pos end
			        end
					event.set_rect_x (ev_configure.x);		check event.rect_x = ev_configure.x 	 end
					event.set_rect_y (ev_configure.y);		check event.rect_y = ev_configure.y 	 end
					event.set_rect_w (ev_configure.width);	check event.rect_w = ev_configure.width  end
					event.set_rect_h (ev_configure.height);	check event.rect_h = ev_configure.height end
					event.set_synthetic (ev_configure.send_event)
					if window.handle_2 (Current, SEL_CONFIGURE, 0, event) then refresh end

					-- Circulate
				when Circulate_notify then
			        event.set_type(SEL_RAISED + (ev.xcirculate.place & 1));
			        if window.handle_2 (Current, event.type, 0, event) then refresh end

					-- Selection Clear
				when Selection_clear then
					if ev.xselectionclear.selection.id = Xa_primary then
						if selection_window /= Void then
							event.set_type(SEL_SELECTION_LOST);
							event.set_time(ev.xselectionclear.time);
							if selection_window.handle_2 (Current, SEL_SELECTION_LOST, 0, event) then refresh end
							selection_window := Void
						end
						xsel_typelist := Void

					elseif ev.xselectionclear.selection = xcbSelection then
						if clipboard_window /= Void then
							event.set_time(ev.xselectionclear.time);
							event.set_type(SEL_CLIPBOARD_LOST);
							if clipboard_window.handle_2 (Current, SEL_CLIPBOARD_LOST, 0, event) then refresh end
							clipboard_window := Void;
						end
						xcb_typelist := Void
					end

					-- Selection Request
				when Selection_request then
					answer := None;
					if ev.xselectionrequest.selection.id = Xa_primary then
						if selection_window /= Void then
					    	if ev.xselectionrequest.target = ddeTargets then            -- Request for TYPES
				--	        	fx_trace((100,"Window %ld being requested by window %ld for SELECTION TYPES; sending %d types\n", ev.xselectionrequest.owner, ev.xselectionrequest.requestor, xselNumTypes));
				--				answer := fxsendtypes(display.to_external, ev.xselectionrequest.requestor, ev.xselectionrequest.property, xselTypeList, xselNumTypes);
				--
							else	-- Request for DATA
				--	            event.set_type(SEL_SELECTION_REQUEST);
				--	            event.set_time(ev.xselectionrequest.time);
				--	            event.set_target(ev.xselectionrequest.target);
				--	            ddeData := Void;
				--	            ddeSize := 0;
				--	            selection_window.do_handle_2 (Current, SEL_SELECTION_REQUEST, 0, event);
				--	            fx_trace(100, <<"Window %ld being requested by window %ld for SELECTION DATA of type %ld; sending %d bytes\n",
				--					ev.xselectionrequest.owner, ev.xselectionrequest.requestor, ev.xselectionrequest.target, ddeSize));
				--	            answer := fxsenddata(display.to_external, ev.xselectionrequest.requestor, ev.xselectionrequest.property, ev.xselectionrequest.target, ddeData, ddeSize);
				--	            ddeData := Void;
				--	            ddeSize := 0;
					        end
						end
					elseif ev.xselectionrequest.selection.id = xcbSelection.id then
				--	   	if clipboard_window /= Void then
				--	       	if(ev.xselectionrequest.target==ddeTargets){            -- Request for TYPES
				--	           	fx_trace((100,"Window %ld being requested by window %ld for CLIPBOARD TYPES; sending %d types\n",ev.xselectionrequest.owner,ev.xselectionrequest.requestor,xcbNumTypes));
				--	           	answer := fxsendtypes(display.to_external, ev.xselectionrequest.requestor, ev.xselectionrequest.property, xcbTypeList, xcbNumTypes);
				--	       	else                                                   -- Request for DATA
				--	           	event.set_type(SEL_CLIPBOARD_REQUEST);
				--	           	event.set_time(ev.xselectionrequest.time);
				--	           	event.set_target(ev.xselectionrequest.target);
				--	           	ddeData := Void;
				--	           	ddeSize := 0;
				--	           	clipboard_window.do_handle_2 (Current, SEL_CLIPBOARD_REQUEST, 0, event);
				--	           	fx_trace((100,"Window %ld being requested by window %ld for CLIPBOARD DATA of type %ld; sending %d bytes\n",ev.xselectionrequest.owner,ev.xselectionrequest.requestor,ev.xselectionrequest.target,ddeSize));
				--	           	answer := fxsenddata(display.to_external, ev.xselectionrequest.requestor, ev.xselectionrequest.property, ev.xselectionrequest.target, ddeData, ddeSize);
				--	           	ddeData := Void;
				--	           	ddeSize := 0;
				--	       	end
				--	   	end
					elseif ev.xselectionrequest.selection.id = xdndSelection.id then
				--	   	if drag_window /= Void then
				--	       	if ev.xselectionrequest.target = ddeTargets then            -- Request for TYPES
				--	           	fx_trace((100,"Window %ld being requested by window %ld for XDND TYPES; sending %d types\n",ev.xselectionrequest.owner,ev.xselectionrequest.requestor,xdndNumTypes));
				--	           	answer := fxsendtypes(display.to_external, ev.xselectionrequest.requestor, ev.xselectionrequest.property, xdndTypeList, xdndNumTypes);
				--	       	else                                                   -- Request for DATA
				--	           	event.set_type(SEL_DND_REQUEST);
				--	           	event.set_time(ev.xselectionrequest.time);
				--	           	event.set_target(ev.xselectionrequest.target);
				--	           	ddeData := Void;
				--	           	ddeSize := 0;
				--	           	drag_window.do_handle_2 (Current, SEL_DND_REQUEST, 0, event);
				--	           	fx_trace(100, <<"Window %ld being requested by window %ld for XDND DATA of type %ld; sending %d bytes",
				--					ev.xselectionrequest.owner, ev.xselectionrequest.requestor, ev.xselectionrequest.target, ddeSize));
				--	           	answer := fxsenddata(display.to_external, ev.xselectionrequest.requestor, ev.xselectionrequest.property, ev.xselectionrequest.target, ddeData, ddeSize);
				--	           	ddeData := Void;
				--	           	ddeSize := 0;
				--	       	end
				--		end
					end
				--	fx_trace(0, <<"Sending back response to requestor = ", ev.xselectionrequest.requestor.out>>)
				--	fxsendreply(display.to_external, ev.xselectionrequest.requestor, ev.xselectionrequest.selection, answer, ev.xselectionrequest.target, ev.xselectionrequest.time);

					-- Client message
				when Client_message then
							-- WM_PROTOCOLS
						if ev.xclient.message_type = wmProtocols.id then
							if ev.xclient.data_l (0) = wmDeleteWindow.id then		-- WM_DELETE_WINDOW
								window := find_window_with_id (ev.xany.window)
								if window /= Void then
						            event.set_type (SEL_CLOSE)
						            window.do_handle_2 (Current, SEL_CLOSE, 0, event)
						        end

							elseif ev.xclient.data_l (0) = wmQuitApp.id then			-- WM_QUIT_APP
						    	window := find_window_with_id (ev.xany.window)
						        if window /= Void then
						        	event.set_type (SEL_CLOSE)
						            window.do_handle_2 (Current, SEL_CLOSE, 0, event)
						        end
					
							elseif ev.xclient.data_l (0) = wmTakeFocus.id then		-- WM_TAKE_FOCUS
						    --	if invocation /= Void and then invocation.window /= Void and then invocation.window.id /= 0 then
							--		ev.xclient.set_window (invocation.window.id)
							--	end
						        -- Assign focus to innermost modal dialog, even when trying to focus
						        -- on another window; these other windows are dead to inputs anyway.
						        -- XSetInputFocus causes a spurious BadMatch error; we ignore this in xerrorhandler
							--	XSetInputFocus(display.to_external, ev.xclient.window, RevertToParent, ev.xclient.data_l(1));
							end
					
						-- XDND Enter from source
						elseif ev.xclient.message_type = xdndEnter.id then
					--	        FXint ver=(ev.xclient.data.l[1]>>24)&255;
					--	        fx_trace((100,"DNDEnter from remote window %ld\n",ev.xclient.data.l[0]));
					--	        if(ver > XDND_PROTOCOL_VERSION) return; -- #######
					--	        xdndSource := ev.xclient.data.l[0];                                  -- Now we're talking to this guy
					--	        if ddeTypeList /= Void then
					--				-- FXFREE(&ddeTypeList);ddeNumTypes=0;
					--			end
					--	        if(ev.xclient.data.l[1]&1){
					--	          fxrecvtypes(display.to_external,xdndSource,xdndTypes,ddeTypeList,ddeNumTypes);
					
					--	        else{
					--	          FXMALLOC(&ddeTypeList,FXDragType,3);
					--	          ddeNumTypes=0;
					--	          if ev.xclient.data.l[2] then ddeTypeList[0] := ev.xclient.data.l[2]; ddeNumTypes++; end
					--	          if ev.xclient.data.l[3] then ddeTypeList[1] := ev.xclient.data.l[3]; ddeNumTypes++; end
					--	          if ev.xclient.data.l[4] then ddeTypeList[2] := ev.xclient.data.l[4]; ddeNumTypes++; end
					--	        end
					--	#ifndef NDEBUG
					--	        FXuint tt;
					--	        for(tt=0; tt<ddeNumTypes; tt++){
					--	          fx_trace((100,"ddeTypeList[%d]=%d (%s)\n",tt,ddeTypeList[tt],getDragTypeName(ddeTypeList[tt]).text()));
					--	          }
					--	#endif
					--	        }
					
						-- XDND Leave from source
						elseif ev.xclient.message_type = xdndLeave.id then
					--	        fx_trace((100, <<"DNDLeave from remote window ", ev.xclient.data_l(0).out>>)
					--	        if(xdndSource!=(FXID)ev.xclient.data.l[0])
					--				-- ####return;        -- We're not talking to this guy
					--			end
					--	        if dropWindow /= Void then
					--	          event.type=SEL_DND_LEAVE;
					--	          if dropWindow.handle_2 (Current, SEL_DND_LEAVE, 0, &event)) refresh();
					--	          dropWindow := Void
					--	        end
					--	        if ddeTypeList /= Void then
					--				{FXFREE(&ddeTypeList);ddeNumTypes=0;}
					--			end
					--	        xdndSource=0;
					--	        }
					
						-- XDND Position from source
						elseif ev.xclient.message_type = xdndPosition.id then
					--	        fx_trace((100,"DNDPosition from remote window %ld\n",ev.xclient.data.l[0]));
					--	        if xdndSource /= ev.xclient.data_l(0) then
					--			--#	return;        -- ##### We're not talking to this guy
					--			end
					--	        event.set_time(ev.xclient.data_l(3))
					--	        event.set_root_x (ev.xclient.data_l(2) >> 16)
					--	        event.set_root_y (ev.xclient.data_l(2) & 0xffff)
					--	        -- Search from target window down; there may be another window
					--	        -- (like e.g. the dragged shape window) right under the cursor.
					--	        -- Note this is the target window, not the proxy target....
					--	        win := find_window_at(event.root_x, event.root_y, ev.xclient.window);
					--	        if ev.xclient.data_l(4) = xdndActionCopy then
					--				ddeAction := DRAG_COPY
					--	        elseif ev.xclient.data_l(4) = xdndActionMove then
					--				ddeAction := DRAG_MOVE;
					--	        elseif ev.xclient.data_l(4) = xdndActionLink then
					--				ddeAction := DRAG_LINK;
					--	        elseif ev.xclient.data_l(4) = xdndActionPrivate then
					--				ddeAction := DRAG_PRIVATE;
					--	        else
					--				ddeAction := DRAG_COPY
					--			end
					--	        ansAction := DRAG_REJECT;
					--	        xdndWantUpdates := TRUE;
					--	        xdndRect.set_x(event.root_x);
					--	        xdndRect.set_y(event.root_y);
					--	        xdndRect.set_w(1);
					--	        xdndRect.set_h(1);
					--	        fx_trace((100,"x=%d y=%d win=%p dropWindow=%p\n",event.root_x,event.root_y,win,dropWindow));
					--	        if win /= drop_window then
					--	          if drop_window /= Void then
					--	            event.set_type(SEL_DND_LEAVE);
					--	            if drop_window.handle_2 (Current, SEL_DND_LEAVE, 0, event) then refresh end
					--	          end
					--	          drop_window := Void;
					--	          if win /= Void and then win.is_drop_enabled then
					--	            drop_window := win;
					--	            event.set_type(SEL_DND_ENTER);
					--	            if drop_window.handle_2 (Current, SEL_DND_ENTER, 0, event) then refresh end
					--	          end
					--	        end
					--	        if dropWindow /= Void then
					--	          Window tmp;
					--	          event.set_type(SEL_DND_MOTION)
					--	          XTranslateCoordinates(display.to_external, XDefaultRootWindow(display.to_external), dropWindow->id(),
					--					event.root_x,event.root_y,&event.win_x,&event.win_y,&tmp);
					--	          if dropWindow.handle_2 (Current, SEL_DND_MOTION, 0, event))
					--				refresh
					--			  end
					--	        end
					--	        se.xclient.type=ClientMessage;
					--	        se.xclient.display=display.to_external;
					--	        se.xclient.message_type=xdndStatus;
					--	        se.xclient.format=32;
					--	        se.xclient.window=xdndSource;
					--	        se.xclient.data.l[0]=ev.xclient.window;                   -- Proxy Target window
					--	        se.xclient.data_l(1)=0;
					--	        if(ansAction!=DRAG_REJECT) se.xclient.data.l[1]|=1;       -- Target accepted
					--	        if(xdndWantUpdates) se.xclient.data.l[1]|=2;              -- Target wants continuous position updates
					--	        se.xclient.data.l[2]= mksel(xdndRect.x, xdndRect.y);
					--	        se.xclient.data.l[3]= mksel(xdndRect.w, xdndRect.h);
					--	        if(ansAction==DRAG_COPY) se.xclient.data.l[4]=xdndActionCopy; -- Drag and Drop Action accepted
					--	        else if(ansAction==DRAG_MOVE) se.xclient.data.l[4]=xdndActionMove;
					--	        else if(ansAction==DRAG_LINK) se.xclient.data.l[4]=xdndActionLink;
					--	        else if(ansAction==DRAG_PRIVATE) se.xclient.data.l[4]=xdndActionPrivate;
					--	        else se.xclient.data.l[4]=None;
					--	        XSendEvent(display.to_external,xdndSource,True,NoEventMask,&se);
					--	        }
					--
					--	-- XDND Drop from source
						elseif ev.xclient.message_type = xdndDrop.id then
					--	        fx_trace((100,"DNDDrop from remote window %ld\n",ev.xclient.data.l[0]));
					--	        if(xdndSource!=(FXID)ev.xclient.data.l[0])
					--			--#	return;        -- We're not talking to this guy
					--	        if dropWindow /= Void then
					--	        	event.set_type(SEL_DND_DROP)
					--	        	event.set_time(ev.xclient.data_l(2))
					--	        	if dropWindow.handle(Current, mksel(SEL_DND_DROP, 0), event) then
					--					refresh
					--				end
					--	        	dropWindow := Void
					--	        end
					--	        se.xclient.set_type(ClientMessage)                            -- Drop window has finished processing of the drop
					--	        se.xclient.display = display.to_external;
					--	        se.xclient.message_type = xdndFinished;
					--	        se.xclient.format = 32;
					--	        se.xclient.window = xdndSource;
					--	        se.xclient.data.l(0]=ev.xclient.window;                   -- Proxy Target window
					--	        se.xclient.data_l(1]=0;
					--	        se.xclient.data_l(2]=0;
					--	        se.xclient.data_l(3]=0;
					--	        se.xclient.data_l(4]=0;
					--	        XSendEvent(display.to_external,xdndSource,True,NoEventMask,&se);
					--	        if(ddeTypeList){FXFREE(&ddeTypeList);ddeNumTypes=0;}
					--	        xdndSource := 0;
					--	        }
					--
					--	-- XDND Status from target
						elseif ev.xclient.message_type = xdndStatus.id then
					--		-- We ignore ev.xclient.data.l[0], because some other
					--	    -- toolkits, e.g. Qt, do not place the proper value there;
					--	    -- the proper value is xdndTarget, NOT xdndProxyTarget or None
					--	    --if(xdndTarget /= ev.xclient.data.l[0]) then
					--			--# return;        // We're not talking to this guy
					--		  end
					--	    ansAction := DRAG_REJECT;
					--	    if ev.xclient.data_l(1) & 1 then
					--	    	if		ev.xclient.data_l(4) = xdndActionCopy.id then ansAction := DRAG_COPY;
					--	    	elseif 	ev.xclient.data_l(4) = xdndActionMove.id then ansAction := DRAG_MOVE;
					--	    	elseif 	ev.xclient.data_l(4) = xdndActionLink.id then ansAction := DRAG_LINK;
					--	    	elseif 	ev.xclient.data_l(4) = xdndActionPrivate.id then ansAction := DRAG_PRIVATE;
					--			end
					--	    end
					--	    xdndWantUpdates := ev.xclient.data_l(1) & 2;
					--	    xdndRect.set_x(ev.xclient.data_l(2) >> 16)
					--	    xdndRect.set_y(ev.xclient.data_l(2) & 0xffff)
					--	    xdndRect.set_w(ev.xclient.data_l(3) >> 16)
					--	    xdndRect.set_h(ev.xclient.data_l(3) & 0xffff)
					--	    xdndStatusReceived := TRUE;
					--	    xdndStatusPending := FALSE;
					--		fx_trace(100, <<"DNDStatus from remote window ",
					--			ev.xclient.data_l (0).out,
					--			" action = ", ansAction.out,
					--			" rect= ",
					--				xdndRect.x.out,",",
					--				xdndRect.y.out,",",
					--				xdndRect.w.out,",",
					--				xdndRect.h.out,",",
					--			" updates= ", xdndWantUpdates.out>>);
						end

					-- Property change
				when Property_notify then
					--	event.set_time(ev.xproperty.time);
					--	{	char* atomname = XGetAtomName (display.to_external, ev.xproperty.atom)
					--		fx_trace ((100,"PropertyNotify %s\n",atomname));
					--		XFree (atomname);
					--	}
					--	if ev.xproperty.atom = wmState.id then
					--		fx_trace ((100,"Window State Change\n"));
					--	end

					-- Keyboard mapping
				when Mapping_notify then
				--	if ev.xmapping.request /= MappingPointer then
				--		XRefreshKeyboardMapping (&ev.xmapping);
				--	end

				else
					-- Unhandled event type!!
				end -- inspect
			else
--#				edp_trace.start(0, "dispatch_event - window void").done; -- ev.trace
			end -- window /= Void
		end -- dispatch

feature --

	open_display (dsp_name: STRING): BOOLEAN is
			-- Open the display
		local
			dn: STRING
		do
			if not initialized then
				if dsp_name = Void then
					dn := ":0"
				else
					dn := dsp_name
				end

			    -- What's going on
			    --fx_trace(100,<<class_name, "::openDisplay: opening display.%N">>);

				set_error_handler

				create display.make (dn)

				if False then -- not display.is_open then
					Result := False
		--#			io.put_string ("Display open FAILED!!%N"); -- io.flush
				else
					Result := True

					--io.put_string ("Display is OPEN!!%N"); io.flush
				--	fx_trace (100, <<"Display is OPEN!!%N">>)

	    		--	-- For debugging
	    		--	if (synchronize)
				--		display.set_synchronize (True)

	    			-- Make hash context for window mapping
					create wcontext.make

				    -- Don't have it!
				--	fx_trace(100, <<"Shared memory not available%N">>)
				    shmi := False
				    shmp := False

				    -- Window manager communication
					create  wmDeleteWindow	.make(display,	"WM_DELETE_WINDOW",	False)
					create  wmQuitApp		.make(display,	"_WM_QUIT_APP",		False)
					create  wmProtocols		.make(display,	"WM_PROTOCOLS",		False)
					create  wmMotifHints	.make(display,	"_MOTIF_WM_HINTS",	False)
					create  wmTakeFocus		.make(display,	"WM_TAKE_FOCUS",	False)
					create  wmState			.make(display,	"WM_STATE",			False)

    				-- Extended Window Manager support
				--	create  wmNetSupported	.make(display,	"_NET_SUPPORTED",				False);
				--	create  wmNetState		.make(display,	"_NET_WM_STATE",				False);
				--	create  wmNetHMaximized	.make(display,	"_NET_WM_STATE_MAXIMIZED_HORZ",	False);
				--	create  wmNetVMaximized	.make(display,	"_NET_WM_STATE_MAXIMIZED_VERT",	False);

				    -- DDE property
					create  ddeAtom			.make(display,	"_FOX_DDE",			False)
					create  ddeDelete		.make(display,	"DELETE",			False)
					create  ddeTargets		.make(display,	"TARGETS",			False)

				    -- Clipboard
					create  xcbSelection	.make(display,	"CLIPBOARD",		False)

				    -- XDND protocol awareness
					create  xdndProxy		.make(display,	"XdndProxy",		False)
					create  xdndAware		.make(display,	"XdndAware",		False)

				    -- XDND Messages
					create  xdndEnter		.make(display,	"XdndEnter",		False)
					create  xdndLeave		.make(display,	"XdndLeave",		False)
					create  xdndPosition	.make(display,	"XdndPosition",		False)
					create  xdndStatus		.make(display,	"XdndStatus",		False)
					create  xdndDrop		.make(display,	"XdndDrop",			False)
					create  xdndFinished	.make(display,	"XdndFinished",		False)

				    -- XDND Selection atom
					create  xdndSelection	.make(display,	"XdndSelection",	False)

				    -- XDND Actions
					create  xdndActionCopy	.make(display,	"XdndActionCopy",	False)
					create  xdndActionMove	.make(display,	"XdndActionMove",	False)
					create  xdndActionLink	.make(display,	"XdndActionLink",	False)
					create  xdndActionPrivate.make(display,	"XdndActionPrivate",False)

				    -- XDND Types list
				    create  xdndTypes		.make(display,	"XdndTypeList",		False)


					default_root_window := display.root_window(0)

					-- Make Stipples and Hatch Patterns
					make_stipples

				    -- We have been initialized
				    initialized := True
					Result := True
				end
			end
		end

feature -- synchronization

	flush_aux (b: BOOLEAN) is
		do
			display.flush
		end

feature -- X error handling

	set_error_handler is
		local
			i: INTEGER
		do
				-- kludge for GEC/EDP: internal reference to routines otherwise only
				-- referenced by routine address in the $feature_name form
			if False then
				i := c_x_error_handler(default_pointer, default_pointer)
				i := c_x_io_error_handler(default_pointer)
			end
				-- end kludge
			c_set_error_handler(Current, $c_x_error_handler, $c_x_io_error_handler)
		end

	c_set_error_handler(c: ANY; fa, fb: POINTER) is
		external "C"
		alias "sb_set_x_error_handler"
		end

	c_x_error_handler(dspl: POINTER; eev: POINTER): INTEGER is
		local
			p: C_POINTER
		do
			Result := 1	-- XXX
			fx_trace2("SB_APPLICATION::x_error_handler")
			p.set_item(eev); p.set_base_limit(eev, eev + 20)

		--	type, display, serial, error_code, major-opcode, minor-opcode
			fx_trace2("Error Info --"
					+ " type: "			+ p.get_long_at(0).out
					+ " display: " 		+ p.get_long_at(4).out
					+ " res-id: " 		+ p.get_long_at(8).out
					+ " serial: " 		+ p.get_long_at(12).out
					+ " err: "   		+ p.get_byte_at(16).out
					+ " (" + x_error_code(p.get_byte_at(16)) + ")"
					+ " major: " 		+ p.get_byte_at(17).out
					+ " (" + x_request_type_string(p.get_byte_at(17)) + ")"
					+ " minor: "		+ p.get_byte_at(18).out)

		end

	x_error_code (n: INTEGER): STRING is
			-- Return a string code name from the error index
		do
			if n >= 1 and n <= 17 then
				Result := x_error_code_list.item(n)
			else
				Result := once "???"
			end
		end

	x_error_code_list: ARRAY [ STRING ] is
		once
			create Result.make(1, 17)
			Result.put("BadRequest",		1)
			Result.put("BadValue",			2)
			Result.put("BadWindow",			3)
			Result.put("BadPixmap",			4)
			Result.put("BadAtom",			5)
			Result.put("BadCursor",			6)
			Result.put("BadFont",			7)
			Result.put("BadMatch",			8)
			Result.put("BadDrawable",		9)
			Result.put("BadAccess",			10)
			Result.put("BadAlloc",			11)
			Result.put("BadColor",			12)
			Result.put("BadGC",				13)
			Result.put("BadIDChoice",		14)
			Result.put("BadName",			15)
			Result.put("BadLength",			16)
			Result.put("BadImplementation",	17)
		end

	x_request_type_string (a_opcode: INTEGER): STRING is
		do
			inspect a_opcode

			when 1   then Result := once "CreateWindow"              
			when 2   then Result := once "ChangeWindowAttributes"        
			when 3   then Result := once "GetWindowAttributes"     
			when 4   then Result := once "DestroyWindow"
			when 5   then Result := once "DestroySubwindows"   
			when 6   then Result := once "ChangeSaveSet"
			when 7   then Result := once "ReparentWindow"
			when 8   then Result := once "MapWindow"
			when 9   then Result := once "MapSubwindows"
			when 10  then Result := once "UnmapWindow"
			when 11  then Result := once "UnmapSubwindows"  
			when 12  then Result := once "ConfigureWindow"  
			when 13  then Result := once "CirculateWindow"  
			when 14  then Result := once "GetGeometry"
			when 15  then Result := once "QueryTree"
			when 16  then Result := once "InternAtom"
			when 17  then Result := once "GetAtomName"
			when 18  then Result := once "ChangeProperty" 
			when 19  then Result := once "DeleteProperty" 
			when 20  then Result := once "GetProperty"
			when 21  then Result := once "ListProperties" 
			when 22  then Result := once "SetSelectionOwner"    
			when 23  then Result := once "GetSelectionOwner"    
			when 24  then Result := once "ConvertSelection"   
			when 25  then Result := once "SendEvent"
			when 26  then Result := once "GrabPointer"
			when 27  then Result := once "UngrabPointer"
			when 28  then Result := once "GrabButton"
			when 29  then Result := once "UngrabButton"
			when 30  then Result := once "ChangeActivePointerGrab"          
			when 31  then Result := once "GrabKeyboard"
			when 32  then Result := once "UngrabKeyboard" 
			when 33  then Result := once "GrabKey"
			when 34  then Result := once "UngrabKey"
			when 35  then Result := once "AllowEvents"       
			when 36  then Result := once "GrabServer"      
			when 37  then Result := once "UngrabServer"        
			when 38  then Result := once "QueryPointer"        
			when 39  then Result := once "GetMotionEvents"           
			when 40  then Result := once "TranslateCoords"                
			when 41  then Result := once "WarpPointer"       
			when 42  then Result := once "SetInputFocus"         
			when 43  then Result := once "GetInputFocus"         
			when 44  then Result := once "QueryKeymap"       
			when 45  then Result := once "OpenFont"    
			when 46  then Result := once "CloseFont"     
			when 47  then Result := once "QueryFont"
			when 48  then Result := once "QueryTextExtents"     
			when 49  then Result := once "ListFonts"  
			when 50  then Result := once "ListFontsWithInfo" 
			when 51  then Result := once "SetFontPath" 
			when 52  then Result := once "GetFontPath" 
			when 53  then Result := once "CreatePixmap"        
			when 54  then Result := once "FreePixmap"      
			when 55  then Result := once "CreateGC"    
			when 56  then Result := once "ChangeGC"    
			when 57  then Result := once "CopyGC"  
			when 58  then Result := once "SetDashes"     
			when 59  then Result := once "SetClipRectangles"             
			when 60  then Result := once "FreeGC"  
			when 61  then Result := once "ClearArea"             
			when 62  then Result := once "CopyArea"    
			when 63  then Result := once "CopyPlane"     
			when 64  then Result := once "PolyPoint"     
			when 65  then Result := once "PolyLine"    
			when 66  then Result := once "PolySegment"       
			when 67  then Result := once "PolyRectangle"         
			when 68  then Result := once "PolyArc"   
			when 69  then Result := once "FillPoly"    
			when 70  then Result := once "PolyFillRectangle"             
			when 71  then Result := once "PolyFillArc"       
			when 72  then Result := once "PutImage"    
			when 73  then Result := once "GetImage" 
			when 74  then Result := once "PolyText8"     
			when 75  then Result := once "PolyText16"      
			when 76  then Result := once "ImageText8"      
			when 77  then Result := once "ImageText16"       
			when 78  then Result := once "CreateColormap"          
			when 79  then Result := once "FreeColormap"        
			when 80  then Result := once "CopyColormapAndFree"               
			when 81  then Result := once "InstallColormap"           
			when 82  then Result := once "UninstallColormap"             
			when 83  then Result := once "ListInstalledColormaps"                  
			when 84  then Result := once "AllocColor"      
			when 85  then Result := once "AllocNamedColor"           
			when 86  then Result := once "AllocColorCells"           
			when 87  then Result := once "AllocColorPlanes"            
			when 88  then Result := once "FreeColors"      
			when 89  then Result := once "StoreColors"       
			when 90  then Result := once "StoreNamedColor"           
			when 91  then Result := once "QueryColors"       
			when 92  then Result := once "LookupColor"       
			when 93  then Result := once "CreateCursor"        
			when 94  then Result := once "CreateGlyphCursor"             
			when 95  then Result := once "FreeCursor"      
			when 96  then Result := once "RecolorCursor"         
			when 97  then Result := once "QueryBestSize"         
			when 98  then Result := once "QueryExtension"          
			when 99  then Result := once "ListExtensions"          
			when 100 then Result := once "ChangeKeyboardMapping"
			when 101 then Result := once "GetKeyboardMapping"
			when 102 then Result := once "ChangeKeyboardControl"                
			when 103 then Result := once "GetKeyboardControl"             
			when 104 then Result := once "Bell"
			when 105 then Result := once "ChangePointerControl"
			when 106 then Result := once "GetPointerControl"
			when 107 then Result := once "SetScreenSaver"          
			when 108 then Result := once "GetScreenSaver"          
			when 109 then Result := once "ChangeHosts"       
			when 110 then Result := once "ListHosts"     
			when 111 then Result := once "SetAccessControl"               
			when 112 then Result := once "SetCloseDownMode"
			when 113 then Result := once "KillClient" 
			when 114 then Result := once "RotateProperties"
			when 115 then Result := once "ForceScreenSaver"
			when 116 then Result := once "SetPointerMapping"
			when 117 then Result := once "GetPointerMapping"
			when 118 then Result := once "SetModifierMapping"
			when 119 then Result := once "GetModifierMapping"
			when 127 then Result := once "NoOperation"
			else
				Result := once "##UNDEFINED##"
			end
	end


	c_x_io_error_handler (dspl: POINTER): INTEGER is
		do
--#			edp_trace.start(0, "SB_APPLICATION::x_io_error_handler").done
		end

	beep is
			-- Beep the sounder
		do
		end

--	#########################################################################################################################

	close_display: BOOLEAN is
		do
			if initialized then

	    		-- What's going on
				edp_trace.start(100, class_name).next("::closeDisplay: closing display.%N").done

				--
				--	    -- Free standard stipples
				--	    XFreePixmap(display.to_external, stipples @ Stipple_0);
				--	    XFreePixmap(display.to_external, stipples @ Stipple_1);
				--	    XFreePixmap(display.to_external, stipples @ Stipple_2);
				--	    XFreePixmap(display.to_external, stipples @ Stipple_3);
				--	    XFreePixmap(display.to_external, stipples @ Stipple_4);
				--	    XFreePixmap(display.to_external, stipples @ Stipple_5);
				--	    XFreePixmap(display.to_external, stipples @ Stipple_6);
				--	    XFreePixmap(display.to_external, stipples @ Stipple_7);
				--	    XFreePixmap(display.to_external, stipples @ Stipple_8);
				--	    XFreePixmap(display.to_external, stipples @ Stipple_9);
				--	    XFreePixmap(display.to_external, stipples @ Stipple_10);
				--	    XFreePixmap(display.to_external, stipples @ Stipple_11);
				--	    XFreePixmap(display.to_external, stipples @ Stipple_12);
				--	    XFreePixmap(display.to_external, stipples @ Stipple_13);
				--	    XFreePixmap(display.to_external, stipples @ Stipple_14);
				--	    XFreePixmap(display.to_external, stipples @ Stipple_15);
				--	    XFreePixmap(display.to_external, stipples @ Stipple_16);
				--
				--	    -- Free hatch patterns
				--	    XFreePixmap(display.to_external, stipples @ Stipple_horz);
				--	    XFreePixmap(display.to_external, stipples @ Stipple_vert);
				--	    XFreePixmap(display.to_external, stipples @ Stipple_cross);
				--	    XFreePixmap(display.to_external, stipples @ Stipple_diag);
				--	    XFreePixmap(display.to_external, stipples @ Stipple_revdiag);
				--	    XFreePixmap(display.to_external, stipples @ Stipple_crossdiag);

				-- Close display
				display.close

	    		display := Void
				initialized := False
			end
			Result := True
		end

feature -- Stipples

	make_stipples is
			-- FIXGC
		local
			sp, la: ARRAY [ INTEGER_8 ]
		do
			sp := <<	-- stipple_patterns
				0x00,0x00,0x00,0x00, 0x00,0x00,0x00,0x00,   -- 0 (white)
				0x00,0x00,0x00,0x88, 0x00,0x00,0x00,0x88,
				0x00,0x22,0x00,0x88, 0x00,0x22,0x00,0x88,
				0x00,0x22,0x00,0xaa, 0x00,0x22,0x00,0xaa,
				0x00,0xaa,0x00,0xaa, 0x00,0xaa,0x00,0xaa,
				0x00,0xaa,0x44,0xaa, 0x00,0xaa,0x44,0xaa,
				0x11,0xaa,0x44,0xaa, 0x11,0xaa,0x44,0xaa,
				0x11,0xaa,0x55,0xaa, 0x11,0xaa,0x55,0xaa,
				0x55,0xaa,0x55,0xaa, 0x55,0xaa,0x55,0xaa,   -- 8 (50% grey)
				0x55,0xaa,0x55,0xee, 0x55,0xaa,0x55,0xee,
				0x55,0xbb,0x55,0xee, 0x55,0xbb,0x55,0xee,
				0x55,0xbb,0x55,0xff, 0x55,0xbb,0x55,0xff,
				0x55,0xff,0x55,0xff, 0x55,0xff,0x55,0xff,
				0x55,0xff,0xdd,0xff, 0x55,0xff,0xdd,0xff,
				0x77,0xff,0xdd,0xff, 0x77,0xff,0xdd,0xff,
				0x77,0xff,0xff,0xff, 0x77,0xff,0xff,0xff,
				0xff,0xff,0xff,0xff, 0xff,0xff,0xff,0xff    -- 16 (black)
			>>
				-- Standard stipples
			create stipples.make (0, 24)
			stipples.put (create {X_PIXMAP}.from_bits (default_root_window, sp.area.item_address (8 * Stipple_0 ), 8, 8), Stipple_0)
			stipples.put (create {X_PIXMAP}.from_bits (default_root_window, sp.area.item_address (8 * Stipple_1 ), 8, 8), Stipple_1)
			stipples.put (create {X_PIXMAP}.from_bits (default_root_window, sp.area.item_address (8 * Stipple_2 ), 8, 8), Stipple_2)
			stipples.put (create {X_PIXMAP}.from_bits (default_root_window, sp.area.item_address (8 * Stipple_3 ), 8, 8), Stipple_3)
			stipples.put (create {X_PIXMAP}.from_bits (default_root_window, sp.area.item_address (8 * Stipple_4 ), 8, 8), Stipple_4)
			stipples.put (create {X_PIXMAP}.from_bits (default_root_window, sp.area.item_address (8 * Stipple_5 ), 8, 8), Stipple_5)
			stipples.put (create {X_PIXMAP}.from_bits (default_root_window, sp.area.item_address (8 * Stipple_6 ), 8, 8), Stipple_6)
			stipples.put (create {X_PIXMAP}.from_bits (default_root_window, sp.area.item_address (8 * Stipple_7 ), 8, 8), Stipple_7)
			stipples.put (create {X_PIXMAP}.from_bits (default_root_window, sp.area.item_address (8 * Stipple_8 ), 8, 8), Stipple_8)
			stipples.put (create {X_PIXMAP}.from_bits (default_root_window, sp.area.item_address (8 * Stipple_9 ), 8, 8), Stipple_9)
			stipples.put (create {X_PIXMAP}.from_bits (default_root_window, sp.area.item_address (8 * Stipple_10), 8, 8), Stipple_10)
			stipples.put (create {X_PIXMAP}.from_bits (default_root_window, sp.area.item_address (8 * Stipple_11), 8, 8), Stipple_11)
			stipples.put (create {X_PIXMAP}.from_bits (default_root_window, sp.area.item_address (8 * Stipple_12), 8, 8), Stipple_12)
			stipples.put (create {X_PIXMAP}.from_bits (default_root_window, sp.area.item_address (8 * Stipple_13), 8, 8), Stipple_13)
			stipples.put (create {X_PIXMAP}.from_bits (default_root_window, sp.area.item_address (8 * Stipple_14), 8, 8), Stipple_14)
			stipples.put (create {X_PIXMAP}.from_bits (default_root_window, sp.area.item_address (8 * Stipple_15), 8, 8), Stipple_15)
			stipples.put (create {X_PIXMAP}.from_bits (default_root_window, sp.area.item_address (8 * Stipple_16), 8, 8), Stipple_16)
				-- Hatch patterns
			stipples.put (create {X_PIXMAP}.from_bits (default_root_window, hor_bits,	24,24),	Stipple_horz)
			stipples.put (create {X_PIXMAP}.from_bits (default_root_window, ver_bits,	24,24),	Stipple_vert)
			stipples.put (create {X_PIXMAP}.from_bits (default_root_window, cross_bits,	24,24),	Stipple_cross)

			stipples.put (create {X_PIXMAP}.from_bits (default_root_window, diag_bits,	   16,16), Stipple_diag)
			stipples.put (create {X_PIXMAP}.from_bits (default_root_window, revdiag_bits,  16,16), Stipple_revdiag)
			stipples.put (create {X_PIXMAP}.from_bits (default_root_window, crossdiag_bits,16,16), Stipple_crossdiag)
		end

			-- Standard-issue cross hatch pattern
	cross_bits: POINTER is
		do
			Result := cross_bits_manifest_array.area.item_address (0)
		end

	cross_bits_manifest_array: ARRAY [ INTEGER_8 ] is
		once
			Result := <<
				0x08, 0x82, 0x20, 0x08, 0x82, 0x20, 0x08, 0x82, 0x20, 0xff, 0xff, 0xff,
				0x08, 0x82, 0x20, 0x08, 0x82, 0x20, 0x08, 0x82, 0x20, 0x08, 0x82, 0x20,
				0x08, 0x82, 0x20, 0xff, 0xff, 0xff, 0x08, 0x82, 0x20, 0x08, 0x82, 0x20,
				0x08, 0x82, 0x20, 0x08, 0x82, 0x20, 0x08, 0x82, 0x20, 0xff, 0xff, 0xff,
				0x08, 0x82, 0x20, 0x08, 0x82, 0x20, 0x08, 0x82, 0x20, 0x08, 0x82, 0x20,
				0x08, 0x82, 0x20, 0xff, 0xff, 0xff, 0x08, 0x82, 0x20, 0x08, 0x82, 0x20
			>>
		end

			-- Standard-issue diagonal cross hatch pattern
	crossdiag_bits: POINTER is
		do
			Result := crossdiag_bits_manifest_array.area.item_address (0)
		end

	crossdiag_bits_manifest_array: ARRAY [ INTEGER_8 ] is
		once
			Result := <<
				0x22, 0x22, 0x14, 0x14, 0x08, 0x08, 0x14, 0x14, 0x22, 0x22, 0x41, 0x41,
				0x80, 0x80, 0x41, 0x41, 0x22, 0x22, 0x14, 0x14, 0x08, 0x08, 0x14, 0x14,
				0x22, 0x22, 0x41, 0x41, 0x80, 0x80, 0x41, 0x41
			>>
		end

			-- Standard-issue diagonal hatch pattern
	diag_bits: POINTER is
		do
			Result := diag_bits_manifest_array.area.item_address (0)
		end

	diag_bits_manifest_array: ARRAY [ INTEGER_8 ] is
			-- FIXGC
		once
			Result := <<
				0x20, 0x20, 0x10, 0x10, 0x08, 0x08, 0x04, 0x04, 0x02, 0x02, 0x01, 0x01,
				0x80, 0x80, 0x40, 0x40, 0x20, 0x20, 0x10, 0x10, 0x08, 0x08, 0x04, 0x04,
				0x02, 0x02, 0x01, 0x01, 0x80, 0x80, 0x40, 0x40
			>>
		end

			-- Standard-issue horizontal hatch pattern
	hor_bits: POINTER is
		do
			Result := hor_bits_manifest_array.area.item_address (0)
		end

	hor_bits_manifest_array: ARRAY [ INTEGER_8 ] is
		once
			Result := <<
				0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff,
				0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
				0x00, 0x00, 0x00, 0xff, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
				0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff,
				0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
				0x00, 0x00, 0x00, 0xff, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
			>>
		end

			-- Standard-issue reverse diagonal hatch pattern
	revdiag_bits: POINTER is
		do
			Result := revdiag_bits_manifest_array.area.item_address (0)
		end

	revdiag_bits_manifest_array: ARRAY [ INTEGER_8 ] is
		once
			Result := <<
				0x02, 0x02, 0x04, 0x04, 0x08, 0x08, 0x10, 0x10, 0x20, 0x20, 0x40, 0x40,
				0x80, 0x80, 0x01, 0x01, 0x02, 0x02, 0x04, 0x04, 0x08, 0x08, 0x10, 0x10,
				0x20, 0x20, 0x40, 0x40, 0x80, 0x80, 0x01, 0x01
			>>
		end

			-- Standard-issue vertical hatch pattern
	ver_bits: POINTER is
		do
			Result := ver_bits_manifest_array.area.item_address (0)
		end

	ver_bits_manifest_array: ARRAY [ INTEGER_8 ] is
		once
			Result := <<
				0x08, 0x82, 0x20, 0x08, 0x82, 0x20, 0x08, 0x82, 0x20, 0x08, 0x82, 0x20,
				0x08, 0x82, 0x20, 0x08, 0x82, 0x20, 0x08, 0x82, 0x20, 0x08, 0x82, 0x20,
				0x08, 0x82, 0x20, 0x08, 0x82, 0x20, 0x08, 0x82, 0x20, 0x08, 0x82, 0x20,
				0x08, 0x82, 0x20, 0x08, 0x82, 0x20, 0x08, 0x82, 0x20, 0x08, 0x82, 0x20,
				0x08, 0x82, 0x20, 0x08, 0x82, 0x20, 0x08, 0x82, 0x20, 0x08, 0x82, 0x20,
				0x08, 0x82, 0x20, 0x08, 0x82, 0x20, 0x08, 0x82, 0x20, 0x08, 0x82, 0x20
			>>
		end

feature -- Clipboard

	clipboard_set_data (window: SB_WINDOW; type: INTEGER; data: STRING) is
		do
		end

   clipboard_get_data (window: SB_WINDOW; type: INTEGER): STRING is
		do
		end

   clipboard_get_types (window: SB_WINDOW): ARRAY [INTEGER] is
		do
		end


feature -- Free routines -- to release recources

	free_xcb_typelist is
		do
			xcb_typelist := Void
		end

feature -- dde checking (DEBUG)

	check_dde_data is
		do
--			if dde_data /= Void then
--				fx_trace(0, <<"dde_data = ", dde_data.out, " .storage = ", dde_data.storage.out,
--					".count = ", dde_data.count.out>> )
--				fx_trace(0, <<dde_data>> )
--			end
		end

feature -- GC tracing reporting (DEBUG)

	report_gc_alloc (ev: SB_RAW_EVENT) is
		do
		--	if ev.serial - last_gc_report_serial > 20 then
		--		last_gc_report_serial := ev.serial
		--		fx_trace(0, <<"GC allocated mem approx: ", allocated_bytes.out, " Progress = ", gc_progress.out>> )
		--	end
		end

	last_gc_report_serial: INTEGER

	gc_progress: INTEGER is
--		external "C" alias "get_gc_progress" end
		do end

end
