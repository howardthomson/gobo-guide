indexing
	description:"The Application Object"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"partly complete"

	todo: "[
		Need auto create_resource call after creation or modification of
			windows and widgets
		group/reorder features; remove unnecessary getters;
		implement incomplete features; implement signal/timeout/chore
			stuff properly
		Move X dependent code to X implementation of SB_APPLICATION
	]"

deferred class SB_APPLICATION_DEF

inherit

	SB_MESSAGE_HANDLER
		rename
			Id_last as MESSAGE_HANDLER_ID_LAST
		redefine
			handle_2
		end
      
	SB_APPLICATION_COMMANDS
	SB_DEFAULT_CURSORS
	SB_CURSOR_CONSTANTS
      
	SB_VISUAL_CONSTANTS

	SB_MODALITY
	SB_FONT_CONSTANTS
	SB_APPLICATION_CURSORS

	SB_EXPANDED
	
	MEMORY	-- for GC control

	SB_SHARED_APPLICATION

feature -- Creation

	make (a_name, a_vendor: STRING) is
			-- Construct application object; the name and vendor strings are
      		-- used as keys into the registry database for this application's
      		-- settings
		require
        	a_name /= Void
         	a_vendor /= Void
      	do
      
			shared_app.set_value (Current)
      	
        	dpy := ":0.0"
	 		create event
	 		event.set_event_originator (Current)
        	create registry.make (a_name, a_vendor)
        	again := True
        	create mono_visual.make (application, VISUAL_MONOCHROME)
        	create default_visual.make (application, VISUAL_DEFAULT)

        	create wait_cursor.make_from_stock (application, CURSOR_WATCH)
        	wait_count := 0

        	make_cursors

        		-- Other settings
        	typing_speed   := 800
        	click_speed    := 400
        	scroll_speed   := 80
        	scroll_delay   := 600
        	blink_speed    := 500
        	animation_speed := 10
        	menu_pause     := 400
        	tooltip_pause  := 800
        	tooltip_time   := 3000
        	drag_delta     := 6
        	wheel_lines    := 1

			make_imp

        	create root_window.make (application, default_visual)

        		-- Change 'True' to pre-selectable value prior to 'make'
        	init (True)
		end

feature {NONE} -- Implementation

    make_imp is
    		-- Do platform dependant 'make'
    	deferred
    	end

    make_cursors is
    		-- Do platform dependant 'make_cursors'
    	deferred
    	end

	init_colours is
    		-- Do platform dependant 'init_colours'
		deferred
		end

feature {EV_APPLICATION_IMP}

	launch is
			-- Application startup after initial preparation
		local
			exit_code: INTEGER
		do
    		create_resource
    		exit_code := run
		end

feature -- Data

	name: STRING is
    	do
        	Result := registry.app_key
      	end

   	vendor: STRING is
      	do
         	Result := registry.vendor_key
      	end

	registry: SB_REGISTRY
			-- Application setting registry
			
	initialized: BOOLEAN
			-- Has been initialized

	arguments: ARRAY[STRING]		-- Application arguments. Valid after the init.

	normal_font: SB_FONT			-- default font

	mono_visual: SB_VISUAL			-- Monochrome visual
	default_visual: SB_VISUAL		-- Default [color] visual

	root_window	: SB_ROOT_WINDOW	-- Root window
	focus_window: SB_WINDOW			-- Window which has the focus
	cursor_window: SB_WINDOW		-- Window under the cursor

	widgets_display_window: SB_WIDGETS_DISPLAY_TREE

	wait_cursor: SB_CURSOR         -- current wait cursor

	get_default_cursor, default_cursor (which: INTEGER): SB_CURSOR is
         	-- Obtain a default cursor
      	do
         	Result := cursors.item (which)
      	end

	typing_speed	: INTEGER;	-- Typing speed
	click_speed		: INTEGER;	-- Double click speed
	scroll_speed	: INTEGER;	-- Scroll speed
	scroll_delay	: INTEGER;  -- Scroll delay
	blink_speed		: INTEGER;  -- Cursor blink speed
	animation_speed	: INTEGER;  -- Animation speed
	menu_pause		: INTEGER;  -- Menu popup delay
	tooltip_pause	: INTEGER;  -- Tooltip popup delay
	tooltip_time	: INTEGER;  -- Tooltip display time
	drag_delta		: INTEGER;  -- Minimum distance considered a move
	wheel_lines		: INTEGER;  -- Scroll by this many lines

	border_color	: INTEGER;  -- Border color
	base_color		: INTEGER;  -- Background color of GUI controls
	hilite_color	: INTEGER;  -- Highlight color of GUI controls
	shadow_color	: INTEGER;  -- Shadow color of GUI controls
	back_color		: INTEGER;  -- Background color
	fore_color		: INTEGER;  -- Foreground color
	sel_fore_color	: INTEGER;  -- Select foreground color
	sel_back_color	: INTEGER;  -- Select background color
	tip_fore_color	: INTEGER;  -- Tooltip foreground color
	tip_back_color	: INTEGER;  -- Tooltip background color

	flag_so_rescan	: BOOLEAN	-- Flag to schedule SO Rescan
	so_sequence		: INTEGER	-- Monotonically increasing sequence for updating
								-- shared objects to select for deletion.

feature -- Shared objects

	schedule_so_rescan is
			-- Schedule a rescan of Shared Objects
			-- e.g. fonts/menus/bitmaps/images etc
		do
			flag_so_rescan := True
		end

	do_so_rescan is
			-- Perform Shared Objects Rescan to scavenge shared resources
		do
				-- First, update all resource in-use sequence numbers
			so_sequence := so_sequence + 1
			root_window.update_so_references

				-- Now process deletions for resources no longer accessible
			-- TODO
			
			flag_so_rescan := False
		end

feature -- Queries

   is_modal_window (window: SB_WINDOW): BOOLEAN is
         -- True if the window is modal
      require
         valid_window: window /= Void
      local
         inv: SB_INVOCATION
      do
         from
            inv := invocation
         until
            inv = Void or else Result
         loop
            Result := inv.window = window and then inv.modality /= MODAL_FOR_NONE
            inv := inv.upper
         end
      end

   get_modal_window: SB_WINDOW is
         -- Return window of current modal loop
      do
         if invocation /= Void then 
            Result := invocation.window
         end
      end

   get_modal_modality: INTEGER is
         -- Return mode of current modal loop
      do
         if invocation /= Void then 
            Result := invocation.modality
         end
      end

feature -- Actions

   set_normal_font (font: SB_FONT) is
         -- Change default font
      require
         good_font: font /= Void
      do
         normal_font := font
      end

   set_default_cursor (which: INTEGER; cursor: SB_CURSOR) is
         -- Change default cursor
      require
         good_cursor: cursor /= Void
      do
         cursors.put (cursor, which)
      end

   set_typing_speed (speed: INTEGER) is
         -- Change typing speed
      do
         typing_speed := speed
         registry.write_integer_entry ("SETTINGS", "typingspeed", typing_speed)
      end

   set_click_speed (speed: INTEGER) is
      do
         click_speed := speed
         registry.write_integer_entry ("SETTINGS", "clickspeed", click_speed)
      end

   set_scroll_speed (speed: INTEGER) is
      do
         scroll_speed := speed
         registry.write_integer_entry ("SETTINGS", "scrollspeed", scroll_speed)
      end

   set_scroll_delay (delay: INTEGER) is
      do
         scroll_delay := delay
         registry.write_integer_entry ("SETTINGS", "scrolldelay", scroll_delay)
      end

   set_blink_speed (speed: INTEGER) is
      do
         blink_speed := speed;
         registry.write_integer_entry ("SETTINGS", "blinkspeed", blink_speed);
      end

   set_animation_speed (speed: INTEGER) is
      do
         animation_speed := speed;
         registry.write_integer_entry ("SETTINGS", "animspeed", animation_speed);
      end

   set_menu_pause (pause: INTEGER) is
      do
         menu_pause := pause;
         registry.write_integer_entry ("SETTINGS", "menupause", menu_pause);
      end

   set_tooltip_pause (pause: INTEGER) is
      do
         tooltip_pause := pause
         registry.write_integer_entry ("SETTINGS", "tooltippause", tooltip_pause)
      end

   set_tooltip_time (time: INTEGER) is
      do
         tooltip_time := time
         registry.write_integer_entry ("SETTINGS", "tooltiptime", tooltip_time)
      end

   set_drag_delta (delta: INTEGER) is
      do
         drag_delta := delta
         registry.write_integer_entry ("SETTINGS", "dragdelta", drag_delta)
      end

   set_wheel_lines (lines: INTEGER) is
      do
         wheel_lines := lines
         registry.write_integer_entry ("SETTINGS", "wheellines", wheel_lines)
      end

   set_border_color (color: INTEGER) is
      do
         border_color := color
         registry.write_color_entry ("SETTINGS", "bordercolor", border_color)
      end

   set_base_color (color: INTEGER) is
      do
         base_color := color
         registry.write_color_entry ("SETTINGS", "basecolor", base_color)
      end

   set_hilite_color (color: INTEGER) is
      do
         hilite_color := color
         registry.write_color_entry ("SETTINGS", "hilitecolor", hilite_color)
      end

   set_shadow_color (color: INTEGER) is
      do
         shadow_color := color
         registry.write_color_entry ("SETTINGS", "shadowcolor", shadow_color)
      end

   set_back_color (color: INTEGER) is
      do
         back_color := color
         registry.write_color_entry ("SETTINGS", "backcolor", back_color)
      end

   set_fore_color (color: INTEGER) is
      do
         fore_color := color
         registry.write_color_entry ("SETTINGS", "forecolor", fore_color)
      end

   set_sel_fore_color (color: INTEGER) is
      do
         sel_fore_color := color
         registry.write_color_entry ("SETTINGS", "selforecolor", sel_fore_color)
      end

   set_sel_back_color (color: INTEGER) is
      do
         sel_back_color := color
         registry.write_color_entry ("SETTINGS", "selbackcolor", sel_back_color)
      end

   set_tip_fore_color (color: INTEGER) is
      do
         tip_fore_color := color
         registry.write_color_entry ("SETTINGS", "tipforecolor", tip_fore_color);         
      end

   set_tip_back_color (color: INTEGER) is
      do
         tip_back_color := color
         registry.write_color_entry ("SETTINGS", "tipbackcolor", tip_back_color);         
      end

	beep is
			-- Beep
		deferred
		end

   begin_wait_cursor is
         -- Begin of wait-cursor block; wait-cursor blocks may be 
         -- nested.
      do
         if initialized then
            if wait_count = 0 then
               if wait_cursor.is_attached then
--#ifdef WIN32
 --                 t := wapi_crs.SetCursor(wait_cursor.resource_id);
--#endif
               end
            end
            wait_count := wait_count + 1;
         end
		ensure f: false
      end

--	begin_wait_cursor_imp is
--		deferred
--		end

   end_wait_cursor is
         -- End of wait-cursor block
      do
         if initialized and then wait_count > 0 then
            wait_count := wait_count - 1;
            if wait_count = 0 then
--#ifdef WIN32
--               t := wapi_crs.SetCursor (cursor_window.default_cursor.resource_id)
--#endif
            end
         end
		ensure f: false
      end

--	end_wait_cursor_imp is
--		deferred
--		end

   set_wait_cursor (cursor: SB_CURSOR) is
         -- Change to a new wait cursor
      require
         good_cursor: cursor /= Void
--#ifdef WIN32
      local
         t: INTEGER;
--#endif
      do
         if initialized and then wait_cursor /= cursor then
            wait_cursor := cursor
            if wait_count > 0 then
--               t := wapi_crs.SetCursor(wait_cursor.resource_id);
            end
         end
		ensure f: false
      end

--	set_wait_cursor_imp(cursor: SB_CURSOR) is
--		deferred
--		end

feature -- Display actions

	open_display (dpyname: STRING): BOOLEAN is
			-- Connection to display; this is called by init()
		deferred
		end

	close_display: BOOLEAN is
		deferred
		end

   set_default_visual (visual: SB_VISUAL) is
      do
         default_visual := visual
      end

feature {NONE} -- Window queries

   	find_window_with_id (xid: INTEGER): SB_WINDOW is
         	--  Find window from id
		deferred
      	end

   	find_window_at (x, y: INTEGER; xid: INTEGER): SB_WINDOW is
         	--  Find window from root x, y, starting from given window
		deferred
      	end

feature -- Message processing

	handle_2 (sender: SB_MESSAGE_HANDLER; type, key: INTEGER; data: ANY): BOOLEAN is
    	do
			if		match_function_2 (Sel_timeout,ID_QUIT, type, key) then Result := on_cmd_quit (sender, key, data)
         	elseif	match_function_2 (SEL_SIGNAL, ID_QUIT, type, key) then Result := on_cmd_quit (sender, key, data)
         	elseif	match_function_2 (SEL_CHORE,  ID_QUIT, type, key) then Result := on_cmd_quit (sender, key, data)
         	elseif	match_function_2 (SEL_COMMAND,ID_QUIT, type, key) then Result := on_cmd_quit (sender, key, data)
         	elseif	match_function_2 (SEL_COMMAND,ID_DUMP, type, key) then Result := on_cmd_dump (sender, key, data)
         	elseif  match_function_2 (SEL_COMMAND,ID_OPEN_WINDOW_TREE, type, key) 
         													  then Result := on_open_window_tree(sender, key, data)
         	else Result := Precursor(sender, type, key, data) end
      	end

	on_cmd_quit (object: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): like handle_2
		do
			fxerror ("SB_APPLICATION_DEF::on_cmd_quit -- exit()").do_nothing
			exit (0)
			Result := True
		end

	on_cmd_dump (object: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): like handle_2 is
		do
		--	dump_widgets;
			Result := True
		end

	on_open_window_tree(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): like handle_2 is
		do
			open_widgets_display_window
			Result := True
		end

	open_widgets_display_window is
		do
			if widgets_display_window = Void then
				create widgets_display_window.make
			end
		end

feature {SB_WIDGETS_DISPLAY_TREE}

	on_widgets_display_window_close is
		do
			widgets_display_window := Void
		end

feature -- Timeouts		

	add_timeout (ms: INTEGER; tgt: SB_MESSAGE_HANDLER; sel: INTEGER): SB_TIMER is
    		-- Add timeout message to be sent to target object in ms milliseconds;
    		-- the timer fires only once after the interval expires.
    	require
        	good_target: tgt /= Void
        	good_timeout: ms >0
		deferred
		end

   	remove_timeout (timer: SB_TIMER) is
         -- Remove timeout
      	require
         	good_timer: timer /= Void
		deferred
      	end

feature -- Chores

	chores: SB_CHORE

	add_chore (a_chore: SB_CHORE) is
			-- Add an idle processing message to be sent to target object when
			-- the system becomes idle, i.e. there are no events to be processed.
		require
			chore_exists: a_chore /= Void
		local
			c: SB_CHORE
		do
			-- TODO: Add last, instead of first
			a_chore.set_next (chores)
			chores := a_chore
		end

	remove_chore (chore: SB_CHORE) is
			-- Remove idle processing message
		require
			chore_exists: chore /= Void
		local
			c, lc: SB_CHORE
		do
			from
				c := chores
			until
				c = Void or else c = chore
			loop
				lc := c
				c := c.next
			end
			if c = chore then
				-- Found!
				if lc = Void then
					chores := c.next
				else
					lc.set_next(c.next)
				end
			end
		end

   add_signal (sig: INTEGER; tgt: SB_MESSAGE_HANDLER; sel: INTEGER; immediate: BOOLEAN; flags: INTEGER) is
         -- Add signal processing message to be sent to target object when
         -- the signal sig is raised; flags are to be set as per POSIX definitions.
         -- When immediate is TRUE, the message will be sent to the target right away;
         -- this should be used with extreme care as the application is interrupted
         -- at an unknown point it its execution.
      do
--         ext_add_signal(to_external, sig, tgt, sel, immediate, flags)
      end

   remove_signal (sig: INTEGER) is
         -- Remove signal message for signal sig
      do
--         ext_remove_signal(to_external, sig)
      end

   add_input (fd: INTEGER; mode: INTEGER; tgt: SB_MESSAGE_HANDLER; sel: INTEGER): BOOLEAN is
         -- Add a file descriptor fd to be watched for activity as determined
         -- by mode, where mode is a bitwise OR (INPUT_READ, INPUT_WRITE, INPUT_EXCEPT).
         -- A message of type SEL_IO_READ, SEL_IO_WRITE, or SEL_IO_EXCEPT will be sent
         -- to the target when the specified activity is detected on the file descriptor.
      do
--         Result := ext_add_input(to_external, fd, mode, tgt, sel)
      end

   remove_input (fd: INTEGER; mode: INTEGER): BOOLEAN is
         -- Remove input message and target object for the specified file descriptor
         -- and mode, which is a bitwise OR of (INPUT_READ, INPUT_WRITE, INPUT_EXCEPT).
      do
--         Result := ext_remove_input(to_external, fd, mode)
      end

feature -- Resource management

	flag_default_resources_created: BOOLEAN
	flag_new_resource: BOOLEAN	--# Move this to SB_APPLICATION_DEF

	set_do_create_resource is
		do
			flag_new_resource := True
		end

	create_new_resources is
		do
			if flag_new_resource then
				create_resource
				flag_new_resource := False
			end
		end

	create_resource is
		do
			if not flag_default_resources_created then
				create_default_resources
				flag_default_resources_created := True
			end
				-- Create all windows
			root_window.create_resource
		end

   create_default_resources is
      	-- Create application's windows
      do
         	-- Create visuals
         mono_visual.create_resource
         default_visual.create_resource
         	-- Create default font
         normal_font.create_resource
         	-- Create cursors
         wait_cursor.create_resource;
         (cursors @ Def_arrow_cursor	).create_resource;	-- Note these ;'s necessary
         (cursors @ Def_rarrow_cursor	).create_resource;	-- due to leading ('s
         (cursors @ Def_text_cursor		).create_resource;
         (cursors @ Def_hsplit_cursor	).create_resource;
         (cursors @ Def_vsplit_cursor	).create_resource;
         (cursors @ Def_xsplit_cursor	).create_resource;
         (cursors @ Def_swatch_cursor	).create_resource;
         (cursors @ Def_move_cursor		).create_resource;
         (cursors @ Def_dragh_cursor	).create_resource;
         (cursors @ Def_dragv_cursor	).create_resource;
         (cursors @ Def_dragtl_cursor	).create_resource;
         (cursors @ Def_dragtr_cursor	).create_resource;
         (cursors @ Def_dndstop_cursor	).create_resource;
         (cursors @ Def_dndcopy_cursor	).create_resource;
         (cursors @ Def_dndmove_cursor	).create_resource;
         (cursors @ Def_dndlink_cursor	).create_resource;
         (cursors @ Def_crosshair_cursor).create_resource;
         (cursors @ Def_cornerne_cursor	).create_resource;
         (cursors @ Def_cornernw_cursor	).create_resource;
         (cursors @ Def_cornerse_cursor	).create_resource;
         (cursors @ Def_cornersw_cursor	).create_resource;
         (cursors @ Def_rotate_cursor	).create_resource;
      end

   destroy_resource is
      	-- Destroy application's windows
      do
         root_window.destroy_resource
         normal_font.destroy_resource

         wait_cursor.destroy_resource;
         (cursors @ Def_arrow_cursor	).destroy_resource;
         (cursors @ Def_rarrow_cursor	).destroy_resource;
         (cursors @ Def_text_cursor		).destroy_resource;
         (cursors @ Def_hsplit_cursor	).destroy_resource;
         (cursors @ Def_vsplit_cursor	).destroy_resource;
         (cursors @ Def_xsplit_cursor	).destroy_resource;
         (cursors @ Def_swatch_cursor	).destroy_resource;
         (cursors @ Def_move_cursor		).destroy_resource;
         (cursors @ Def_dragh_cursor	).destroy_resource;
         (cursors @ Def_dragv_cursor	).destroy_resource;
         (cursors @ Def_dragtl_cursor	).destroy_resource;
         (cursors @ Def_dragtr_cursor	).destroy_resource;
         (cursors @ Def_dndstop_cursor	).destroy_resource;
         (cursors @ Def_dndcopy_cursor	).destroy_resource;
         (cursors @ Def_dndmove_cursor	).destroy_resource;
         (cursors @ Def_dndlink_cursor	).destroy_resource;
         (cursors @ Def_crosshair_cursor).destroy_resource;
         (cursors @ Def_cornerne_cursor	).destroy_resource;
         (cursors @ Def_cornernw_cursor	).destroy_resource;
         (cursors @ Def_cornerse_cursor	).destroy_resource;
         (cursors @ Def_cornersw_cursor	).destroy_resource;
         (cursors @ Def_rotate_cursor	).destroy_resource;

         mono_visual.destroy_resource
         default_visual.destroy_resource
      end

   detach_resource is
     	 -- Detach application's windows
      do
         root_window.detach_resource
         normal_font.detach_resource

         wait_cursor.detach_resource;
         (cursors @ Def_arrow_cursor	).detach_resource;
         (cursors @ Def_rarrow_cursor	).detach_resource;
         (cursors @ Def_text_cursor		).detach_resource;
         (cursors @ Def_hsplit_cursor	).detach_resource;
         (cursors @ Def_vsplit_cursor	).detach_resource;
         (cursors @ Def_xsplit_cursor	).detach_resource;
         (cursors @ Def_swatch_cursor	).detach_resource;
         (cursors @ Def_move_cursor		).detach_resource;
         (cursors @ Def_dragh_cursor	).detach_resource;
         (cursors @ Def_dragv_cursor	).detach_resource;
         (cursors @ Def_dragtl_cursor	).detach_resource;
         (cursors @ Def_dragtr_cursor	).detach_resource;
         (cursors @ Def_dndstop_cursor	).detach_resource;
         (cursors @ Def_dndcopy_cursor	).detach_resource;
         (cursors @ Def_dndmove_cursor	).detach_resource;
         (cursors @ Def_dndlink_cursor	).detach_resource;
         (cursors @ Def_crosshair_cursor).detach_resource;
         (cursors @ Def_cornerne_cursor	).detach_resource;
         (cursors @ Def_cornernw_cursor	).detach_resource;
         (cursors @ Def_cornerse_cursor	).detach_resource;
         (cursors @ Def_cornersw_cursor	).detach_resource;
         (cursors @ Def_rotate_cursor	).detach_resource;

         mono_visual.detach_resource
         default_visual.detach_resource
      end

feature -- Run

	peek_event: BOOLEAN is
			-- Peek to determine if there's an event
		deferred
		end

	run_one_event is
			-- Perform one event dispatch
		deferred
		end

	run: INTEGER is
			-- Run the main application event loop until stop() is called,
			-- and return the exit code passed as argument to stop().
		local
			inv: SB_INVOCATION
		do
			from
				create inv.make (invocation, MODAL_FOR_NONE, Void)
				invocation := inv
			until
				inv.done
			loop
				run_one_event
			end
			Result := invocation.code
			invocation := inv.upper
		end

   run_while_events (window: SB_WINDOW): BOOLEAN is
         -- Run event loop while there are events are available in the queue.
         --  Returns True when all events in the queue have been handled, and False when
         -- the event loop was terminated due to 'stop' or 'stop_modal'.
         -- Except for the modal window and its children, user input to all windows
         --  is blocked; if the modal window is Void all user input is blocked.
      local
         inv: SB_INVOCATION
      do
         from
            create inv.make (invocation, MODAL_FOR_NONE, window)
            invocation := inv
         until
            inv.done or else not peek_event
         loop
            run_one_event
         end
         Result := not inv.done
         invocation := inv.upper
      end

   run_modal: INTEGER is
         -- Run modal event loop, blocking keyboard and mouse events to all windows
         -- until stopModal is called.
      local
         inv: SB_INVOCATION
      do
         from
            create inv.make (invocation, MODAL_FOR_WINDOW, Void)
            invocation := inv
         until
            inv.done
         loop
            run_one_event
         end
         Result := inv.code
         invocation := inv.upper
      end

   run_modal_for (window: SB_WINDOW): INTEGER is
         -- Run a modal event loop for the given window, until stop() or stopModal() is 
         -- called. Except for the modal window and its children, user input to all
         -- windows is blocked; if the modal window is NULL no user input is blocked.
      local
         inv: SB_INVOCATION
      do
         from
            create inv.make (invocation, MODAL_FOR_WINDOW, window)
            invocation := inv
         until
            inv.done
         loop
            run_one_event
         end
         Result := inv.code
         invocation := inv.upper
      end

   run_modal_while_shown (window: SB_WINDOW): BOOLEAN is
         -- Run modal while window is shown, or until stop() or stopModal() is called.
         -- Except for the modal window and its children, user input to all windows
         -- is blocked; if the modal window is NULL all user input is 
         -- blocked.
      require
         valid_window: window /= Void
      local
         inv: SB_INVOCATION
      do
         from
            create inv.make (invocation, MODAL_FOR_WINDOW, window)
            invocation := inv
         until
            inv.done or else not window.is_shown
         loop
            run_one_event
         end
         Result := inv.code /= 0
         invocation := inv.upper
      end

   run_popup (window: SB_WINDOW): INTEGER is
         -- Run popup menu while shown, until stop() or stopModal() is called.
         -- Also returns when entering previous cascading popup menu.
      require
         valid_window: window /= Void
      local
         inv: SB_INVOCATION
      do
         from
            create inv.make (invocation, MODAL_FOR_POPUP, window)
            invocation := inv
         until
            inv.done or else not window.is_shown
         loop
            run_one_event
         end
         Result := inv.code
         invocation := inv.upper
      end

   stop (value: INTEGER) is
         -- Terminate the outermost event loop, and all inner modal loops;
         -- All more deeper nested event loops will be terminated with code equal
         -- to 0, while the outermost event loop will return code equal to value.
      local
         inv: SB_INVOCATION
      do
         from
            inv := invocation
         until
            inv = Void
         loop
            inv.set_done
            inv.set_code (0)
            if inv.upper = Void then
               inv.set_code (value)
            end
            inv := inv.upper
         end
      end

	stop_modal_window (window: SB_WINDOW; value: INTEGER) is
         -- Break out of the matching modal loop, returning code equal to value.
         -- All deeper nested event loops are terminated with code equal to 0.
      require
         valid_window: window /= Void
      local
        inv: SB_INVOCATION
        done: BOOLEAN
      do
         if is_modal_window (window) then
            from
               inv := invocation
               done := False
            until
               inv = Void or else done
            loop
               inv.set_done
               inv.set_code (0)
               if inv.window = window and then inv.modality /= MODAL_FOR_NONE then
                  inv.set_code (value)
                  done := True
               end
               inv := inv.upper
            end
		 else
         end
      end
   
   stop_modal (value: INTEGER) is
         -- Break out of the innermost modal loop, returning code equal to value.
      local
         inv: SB_INVOCATION
         done: BOOLEAN
      do
         from
            inv := invocation
            done := False
         until
            inv = Void or else done
         loop
            inv.set_done
            inv.set_code (0)
            if inv.modality /= MODAL_FOR_NONE then
               inv.set_code (value)
               done := True
            end
            inv := inv.upper
         end
      end

   exit (code: INTEGER) is
         -- Exit application.
         -- Closes the display and writes the registry.
      do
         -- Write the registry
         registry.write

         -- Exit the program
         stop (code)
      end

feature -- Painting
   
	force_refresh is
         -- Force GUI refresh
		require
			valid_root_window: root_window /= Void
		do
			root_window.force_refresh
		end

	refresh is
			-- Schedule a refresh
		do
			again := True
		end

	flush is
			-- Flush pending repaints
		do
			flush_aux (False)
		end

   force_flush is
         -- Flush pending repaints
      do
         flush_aux (True)
      end

feature -- Initialization

	init (connect: BOOLEAN) is
    		-- Initialize application. Parses and removes common command 
			-- line  arguments, reads the registry. Finally, if connect 
			-- is TRUE, it opens display.
		local
        	d: STRING
         	maxcols: INTEGER
         	fontdesc: SB_FONT_DESC
         	i: INTEGER
         	args: ARGUMENTS
      	do
         		-- Try locate display
--#ifndef WIN32
--			d := getenv("DISPLAY");
--        	if d /= Void then
--           	dpy := d;
--        	end
--#endif
         		-- make command line arguments array and parse out args
--         	create args
--       	create arguments.make(0, 0)
--         	arguments.put(args.command_name, 0);
--         	fx_trace2("args.count: " + args.argument_count.out)
--     		from
--         		i := 1
--     		until
--        		i > args.argument_count
--			loop
--				if args.argument(i).is_equal("-maxcolors") then
--             		-- Set maximum number of colors
--             		i := i+1;
--             		if (i <= args.argument_count) then
--                		if args.argument(i).is_integer then
--                 			maxcols := args.argument(i).to_integer
--                		end
--                		if maxcols < 2 then
--                 			-- TODO report error and exit
--                 			maxcols := 2
--                		end
--                		i := i+1;
--             		else
--                		-- TODO report error and exit
--             		end
--#ifndef WIN32
--				elseif args.argument(i).is_equal("-sync") then
--             		-- Start synchronized mode
--             		synchronize := True;
--             		i := i+1;
--          	elseif args.argument(i).is_equal("-noshm") then
--             		-- Do not use X shared memory extension, even if available
--             		shmi := False;
--             		shmp := False;
--             		i := i+1;
--          	elseif args.argument(i).is_equal("-shm") then
--             		-- Force use X shared memory extension, if available
--             		shmi := True;
--             		shmp := True;
--             		i := i+1;
--				elseif args.argument(i).is_equal("-display") then
--             		-- Alternative display
--             		i := i+1;
--             		if (i <= args.argument_count) then
--                		dpy := args.argument(i);
--                		fx_trace2("SB_APPLICATION_DEF::init -- set display to: " + dpy)
--                		i := i+1;
--             		else
--                		-- TODO report error and exit
--                		fx_trace2("SB_APPLICATION_DEF::init -- No display argument to '-display'")
--             		end
--#endif
--         		else
--             		-- Copy program arguments
--             		arguments.force(args.argument(i), arguments.count);
--         		end
--         		i := i + 1
--     		end

			registry.read

       			-- Parse font and change default font
       		create fontdesc
       		if fontdesc.parse (registry.read_string_entry ("SETTINGS", "normalfont", Void)) then
          		normal_font.set_font_desc (fontdesc)
       		end

       			-- Change some settings
       		typing_speed	:= registry.read_integer_entry ("SETTINGS", "typingspeed",	typing_speed)
       		click_speed		:= registry.read_integer_entry ("SETTINGS", "clickspeed",	click_speed)
       		scroll_speed	:= registry.read_integer_entry ("SETTINGS", "scrollspeed",	scroll_speed)
       		scroll_delay	:= registry.read_integer_entry ("SETTINGS", "scrolldelay",	scroll_delay)
       		blink_speed		:= registry.read_integer_entry ("SETTINGS", "blinkspeed",	blink_speed)
       		animation_speed	:= registry.read_integer_entry ("SETTINGS", "animspeed",	animation_speed)
       		menu_pause		:= registry.read_integer_entry ("SETTINGS", "menupause",	menu_pause)
       		tooltip_pause	:= registry.read_integer_entry ("SETTINGS", "tippause",		tooltip_pause)
       		tooltip_time	:= registry.read_integer_entry ("SETTINGS", "tiptime",		tooltip_time)
       		drag_delta		:= registry.read_integer_entry ("SETTINGS", "dragdelta",	drag_delta)
       		wheel_lines		:= registry.read_integer_entry ("SETTINGS", "wheellines",	wheel_lines)
       
       			-- Colors; defaults are those values determined previously
       		border_color	:= registry.read_color_entry ("SETTINGS", "bordercolor", border_color)
       		base_color		:= registry.read_color_entry ("SETTINGS", "basecolor",	 base_color)
       		hilite_color	:= registry.read_color_entry ("SETTINGS", "hilitecolor", hilite_color)
       		shadow_color	:= registry.read_color_entry ("SETTINGS", "shadowcolor", shadow_color)
       		back_color		:= registry.read_color_entry ("SETTINGS", "backcolor",	 back_color)
       		fore_color		:= registry.read_color_entry ("SETTINGS", "forecolor",	 fore_color)
       		sel_fore_color	:= registry.read_color_entry ("SETTINGS", "selforecolor",sel_fore_color)
       		sel_back_color	:= registry.read_color_entry ("SETTINGS", "selbackcolor",sel_back_color)
       		tip_fore_color	:= registry.read_color_entry ("SETTINGS", "tipforecolor",tip_fore_color)
       		tip_back_color	:= registry.read_color_entry ("SETTINGS", "tipbackcolor",tip_back_color)

       			--  Maximum number of colors to allocate
       		max_colors		:= registry.read_integer_entry ("SETTINGS", "maxcolors", max_colors)
       			-- Command line takes precedence
       		if maxcols > 0 then 
          		max_colors := maxcols
       		end

       			-- Set maximum number of colors in default visual to be nice to legacy
       			-- Motif applications which don't handle color allocation gracefully.
       		root_window.visual.set_max_colors (max_colors)

       			--  Open display
       		if connect then
          		if not open_display (dpy) then
             		-- TODO report error and exit
          		end
       		end
		end

feature -- DND

	register_drag_type (typename: STRING): INTEGER is
			-- Register new DND type
		do
			if initialized then
--				mem.collection_off
--#ifdef WIN32
--				Result := wapi_clb.RegisterClipboardFormat (typename.to_external)
--#else
--#endif
--				mem.collection_on
			end
		end

   get_drag_type_name (type: INTEGER): STRING is
         -- Get drag type name
      local
--#ifdef WIN32
         buf: STRING;
--#endif
      do
         if initialized then
--#ifdef WIN32
--			create buf.make_filled ('%U', 256);
--			mem.collection_off
--			if wapi_clb.GetClipboardFormatName (type, buf.to_external, 256) /= 0 then
--				create Result.make_from_string (buf)
--			end
--			mem.collection_on;
--#endif            
         end
      end


feature { SB_WINDOW_DEF } -- Implementation

	sel_type_list: ARRAY [ INTEGER ]
   	dde_type_list: ARRAY [ INTEGER ]

   	dnd_source: INTEGER;

   	key_window			: SB_WINDOW		-- Window in which key was pressed
   	refresher_window	: SB_WINDOW		-- GUI refresher pointer
   	popup_window		: SB_POPUP		-- Current popup window
   	mouse_grab_window	: SB_WINDOW		-- Window which grabbed the mouse
   	keyboard_grab_window: SB_WINDOW		-- Window which grabbed the keyboard
   	selection_window	: SB_WINDOW		-- Selection window
   	clipboard_window	: SB_WINDOW		-- Clipboard window
   	drop_window			: SB_WINDOW		-- Drop target window
   	drag_window			: SB_WINDOW		-- Drag source window

	set_key_window (w: SB_WINDOW) is
		do
        	key_window := w
      	end

   	set_refresher_window (w: SB_WINDOW) is
      	do
         	refresher_window := w
      	end

   	set_popup_window(w: SB_POPUP) is
         	-- Set current popup window
      	do
         	popup_window := w
      	end

   	set_mouse_grab_window (w: SB_WINDOW) is
      	do
         	mouse_grab_window := w
      	end

   	set_keyboard_grab_window (w: SB_WINDOW) is
      	do
         	keyboard_grab_window := w
      	end

   	set_selection_window (w: SB_WINDOW) is
      	do
         	selection_window := w
      	end

   	set_sel_type_list (l: ARRAY[INTEGER]) is
      	do
         	sel_type_list := l
      	end

   	set_clipboard_window (w: SB_WINDOW) is
      	do
         	clipboard_window := w
      	end

   	set_drag_window (w: SB_WINDOW) is
      	do
         	drag_window := w
      	end

   	set_drop_window (w: SB_WINDOW) is
      	do
         	drop_window := w
      	end

   	set_cursor_window (w: SB_WINDOW) is
      	do
         	cursor_window := w
      	end

   	set_focus_window (w: SB_WINDOW) is
      	do
         	focus_window := w
      	end

	event: SB_EVENT

   	dragdrop_set_data(window: SB_WINDOW; type: INTEGER; data: STRING) is
      	do
      	--	dde_data := data
      	end

   	dragdrop_get_data (window: SB_WINDOW; type: INTEGER): STRING is
         -- Retrieve DND selection data
      local
         answer: INTEGER
      do
         if drag_window /= Void then
            event.set_type (SEL_DND_REQUEST)
            event.set_target (type)
            dde_data := Void
            drag_window.do_handle_2 (application, SEL_DND_REQUEST, 0, event)
            Result := dde_data
         else
--			answer := sendrequest (dnd_source, window.resource_id, type)
--			Result := recvdata (answer)
         end
      end

   dragdrop_get_types (window: SB_WINDOW): ARRAY[INTEGER] is
      do
         Result := dde_type_list
      end

	selection_set_data (window: SB_WINDOW; type: INTEGER; data: STRING) is
    	do
      		fx_trace2 ("SB_APPLICATION_DEF::selection_set_data")
      		dde_data := data
		end

   selection_get_data (window: SB_WINDOW; type: INTEGER): STRING is
      do
         if selection_window /= Void then
fx_trace2("SB_APPLICATION_DEF::selection_get_data - #1")
            event.set_type (SEL_SELECTION_REQUEST)
fx_trace2("SB_APPLICATION_DEF::selection_get_data - #2")
            event.set_target (type)
fx_trace2("SB_APPLICATION_DEF::selection_get_data - #3")
            dde_data := Void
fx_trace2("SB_APPLICATION_DEF::selection_get_data - #4")
			check selection_window /= Void end
			fx_trace2 ("Selection window info: " + selection_window.out)
            selection_window.do_handle_2 (Current, SEL_SELECTION_REQUEST, 0, event)
fx_trace2("SB_APPLICATION_DEF::selection_get_data - #5")
            Result := dde_data
            dde_data := Void
         end
      end

	selection_get_types (window: SB_WINDOW): ARRAY[INTEGER] is
      	do
         	if selection_window /= Void then
            	Result := sel_type_list
         	end
      	end

   	clipboard_set_data (window: SB_WINDOW; type: INTEGER; data: STRING) is
      	deferred
      	end

   	clipboard_get_data (window: SB_WINDOW; type: INTEGER): STRING is
      	deferred
      	end

   	clipboard_get_types (window: SB_WINDOW): ARRAY[INTEGER] is
      	deferred
      	end

feature { NONE } -- Implementation

   XXsenddata (window: INTEGER; data: STRING): INTEGER is
         -- Send data via shared memory
      local
         hMap, hMapCopy: INTEGER
         ptr: POINTER
         size, processid, process, t: INTEGER
      do
--         if data /= Void and then data.count > 0 then
--            mem.collection_off
--            size := data.count
--            hMap := wapi_fmf.CreateFileMapping (-1, default_pointer, wapi_af.PAGE_READWRITE, 0,
--                                                size+4, ("_SB_DDE").to_external);
--            mem.collection_on;
--            if hMap /= 0 then
--               ptr := wapi_fmf.MapViewOfFile(hMap, wapi_fmm.FILE_MAP_WRITE, 0, 0, size+4);
--               if ptr /= default_pointer then
--                  mem.mem_copy (ptr, $size, 4)
--                  mem.collection_off
--                  mem.mem_copy (ptr + 4, data.to_external, size)
--                  mem.collection_on
--                  t := wapi_fmf.UnmapViewOfFile (ptr)
--               end
--               t := wapi_wf.GetWindowThreadProcessId (window, $processid)
--               process := wapi_prf.OpenProcess (wapi_prm.PROCESS_DUP_HANDLE, 1, processid)
--               t := wapi_hf.DuplicateHandle (wapi_prf.GetCurrentProcess, hMap, process, $hMapCopy,
--                                            wapi_fmm.FILE_MAP_ALL_ACCESS, 1,
--                                            wapi_ar.DUPLICATE_CLOSE_SOURCE or wapi_ar.DUPLICATE_SAME_ACCESS)
--               t := wapi_hf.CloseHandle(process)
--            end
--            Result := hMapCopy
--         end
		ensure f: false
      end


	XXrecvdata (hMap: INTEGER): STRING is
			-- Receive data via shared memory
		local
        	ptr: POINTER
        	size, t: INTEGER;
      	do
--			if hMap /= 0 then
--            	ptr := wapi_fmf.MapViewOfFile (hMap, wapi_fmm.FILE_MAP_READ, 0, 0, 0);
--            	if ptr /= default_pointer then
--					mem.mem_copy ($size, ptr, 4)
--               		create Result.make_filled ('%U', size)
--               		mem.collection_off
--               		mem.mem_copy (Result.to_external, ptr + 4, size)
--               		mem.collection_on
--					t := wapi_fmf.UnmapViewOfFile (ptr)
--            	end
--            	t := wapi_hf.CloseHandle (hMap)
--         	end
      	end

	XXsendrequest (window, requestor, type: INTEGER): INTEGER is
         -- Send request for data
      	local
         	loops: INTEGER
         	t: INTEGER
         	done: BOOLEAN
      	do
--         	loops := 1000
--         	t := wapi_mf.PostMessage (window, WM_DND_REQUEST, type, requestor)
--         	from
--         	until
--            	done
--         	loop
--            	if wapi_mf.PeekMessage (msg.ptr, 0, WM_DND_REPLY, WM_DND_REPLY, 1B) /= 0 then
--               		done := true
--            	elseif loops = 0 then
--               		--fxwarning("timed out\n")
--            	else
--               		u.sleep(10000);  -- Don't burn too much CPU here:- the other guy needs it more....
--               		loops := loops - 1
--            	end
--         	end
--         	Result := msg.wParam
		ensure f: false
      	end

feature {SB_RAW_EVENT_DEF}

	invocation: SB_INVOCATION
		-- Modal loop invocation

feature

	max_colors: INTEGER
		-- Maximum number of colors to allocate

	dde_data: STRING
		-- DDE array

	again: BOOLEAN
		-- Refresher goes again

	wait_count: INTEGER
		-- Number of times wait cursor was called

	cursors: ARRAY [SB_CURSOR]
		-- Cursors

	dpy: STRING
		-- Initial display guess


feature {NONE}

	flush_aux (sync: BOOLEAN) is
			-- Flush pending repaints
		deferred
		end

	repaint is
			-- Paint all windows marked for repainting.
			-- On return all the applications windows have been painted.
--#ifdef WIN32
		local
			top: SB_WINDOW
			t: INTEGER
--#endif
		do
			if initialized then
--#ifdef WIN32
				from
					top := root_window.first_child
				until
					top = Void
				loop
			--		t := wapi_pf.RedrawWindow (top.resource_id, default_pointer, 0,
			--                            (wapi_rdw.RDW_ERASENOW or wapi_rdw.RDW_UPDATENOW 
			--                             or wapi_rdw.RDW_ALLCHILDREN))
					top := top.next;
				end
--#endif
			end
		end

feature -- Window GUI Manipulation

	register_window (w: SB_WINDOW_DEF) is
			-- Register window's creation in window browse tree
		local
			ww: SB_WINDOW
		do
			ww ?= w
			if widgets_display_window /= Void then
				widgets_display_window.add_window (ww)
			end
		end

feature -- Stop request processing

	is_stop_requested: BOOLEAN is
			-- Return True when GUI has received a Stop request
			-- Run GUI update to check events
		do
			Result := False	-- FIXME
		end

feature -- Event reporting, sequence count

	ev_sequence_counter: INTEGER

	next_ev_sequence: INTEGER is
		do
			ev_sequence_counter := ev_sequence_counter + 1
			Result := ev_sequence_counter
		end

end
