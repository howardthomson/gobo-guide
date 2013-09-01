note
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_SB_WINDOW_IMP

inherit
	EV_SB_WIDGET_IMP
		rename
			sb_widget as sb_window
		redefine
			show,
			screen_x,
			screen_y,
			x_position,
			y_position,
			width,
			height,
			set_width,
			set_height
		end

feature {NONE} -- Implementation Attributes

feature {NONE} -- Implementation

	parent_imp: EV_CONTAINER_IMP
			-- Parent of `Current', always Void as windows cannot be parented
		do
			-- Return Void
		end

	set_blocking_window (a_window: EV_WINDOW)
			-- Set as transient for `a_window'.
		do
			if not is_destroyed then
				if a_window /= Void then
					internal_blocking_window ?= a_window.implementation
					internal_blocking_window.add_transient_child (Current)
				else
					if internal_blocking_window /= Void then
						internal_blocking_window.remove_transient_child (Current)
						internal_blocking_window := Void
					end
				end
			else
				internal_blocking_window := Void
			end
		end

	blocking_window: EV_WINDOW
			-- Window this dialog is a transient for.
		do
			if internal_blocking_window /= Void and then not internal_blocking_window.is_destroyed then
				Result := internal_blocking_window.interface
			end
		end

	internal_blocking_window: EV_WINDOW_IMP
			-- Window that `Current' is relative to.
			-- Implementation

	set_width (a_width: INTEGER)
			-- Set the horizontal size to `a_width'.
		do
			set_size (a_width, height)
		end

	set_height (a_height: INTEGER)
			-- Set the vertical size to `a_height'.
		do
			set_size (width, a_height)
		end

	set_size (a_width, a_height: INTEGER)
			-- Set the horizontal size to `a_width'.
			-- Set the vertical size to `a_height'.
		local
			l_width, l_height: INTEGER
		do
				-- Set constraints so that resize does not break existing minimum sizing.
			l_width := a_width.max (minimum_width)
			l_height := a_height.max (minimum_height)
			sb_window.resize (l_width, l_height)
				-- {EV_GTK_EXTERNALS}.gtk_window_set_default_size (c_object, l_width, l_height)
	--		sb_window.set_default_size (l_width, l_height)
				-- Set configure_event_pending to True so that dimensions are updated immediately.
			configure_event_pending := True

				-- If user cannot resize window then we recall `forbid_resize' which will update the dimensions.
			if is_displayed and then not user_can_resize then
				forbid_resize
			end
		end

	width: INTEGER
			-- Width of `Current'.
		do
			if configure_event_pending then
				Result := sb_window.width
				Result := Result.max (minimum_width)
			else
				Result := Precursor
			end
		end

	height: INTEGER
			-- Height of `Current'.
		do
			if configure_event_pending then
				Result := sb_window.height
				Result := Result.max (minimum_height)
			else
				Result := Precursor
			end
		end

	set_x_position (a_x: INTEGER)
			-- Set horizontal offset to parent to `a_x'.
		do
			set_position (a_x, y_position)
		end

	set_y_position (a_y: INTEGER)
			-- Set vertical offset to parent to `a_y'.
		do
			set_position (x_position, a_y)
		end

	set_position (a_x, a_y: INTEGER)
			-- Set horizontal offset to parent to `a_x'.
			-- Set vertical offset to parent to `a_y'.
		do
			sb_window.move (a_x, a_y)
		end

	configure_event_pending: BOOLEAN
		-- Has `Current' experienced a configure event?

	x_position, screen_x: INTEGER
			-- Horizontal position of the window on screen,
		do
			Result := sb_window.x_pos
		end

	y_position, screen_y: INTEGER
			-- Vertical position of the window on screen,
		do
			Result := sb_window.y_pos
		end

	default_wm_decorations: INTEGER
			-- Default WM decorations of `Current'.
		do
			Result := 0 -- No decorations
		end

	show
			-- Request that `Current' be displayed when its parent is.
		do
			if not is_show_requested then
				sb_window.show
			end
		end

	hide
			-- Hide `Current'.
		do
			if is_show_requested then
				if
					is_modal and then
					internal_blocking_window /= Void and then
					not internal_blocking_window.is_destroyed and then
					internal_blocking_window.is_show_requested
				then
					internal_blocking_window.decrease_modal_window_count
				end
				is_modal := False
				set_blocking_window (Void)
				sb_window.hide
			end
		end

	is_modal: BOOLEAN
		-- Is `Current' modal?

	show_modal_to_window (a_window: EV_WINDOW)
			-- Show `Current' modal with respect to `a_window'.
		local
			l_window_imp: EV_WINDOW_IMP
		do
			l_window_imp ?= a_window.implementation
			is_modal := True
			l_window_imp.increase_modal_window_count
			show_relative_to_window (a_window)
			block
			is_modal := False
				-- No need to call `set_blocking_window' to Void since this is done when
				-- current is hidden.

			if not l_window_imp.is_destroyed then
				if l_window_imp.is_show_requested then
						-- Get window manager to always show parent window.
						-- This is a hack in case parent window was minimized and restored
						-- by the modal dialog, when closed the window managed would restore the
						-- focus to the previously focused window which may or may not be `l_window_imp',
						-- this leads to odd behavior when closing the modal dialog so we always raise the window.
--#					{EV_GTK_EXTERNALS}.gdk_window_raise ({EV_GTK_EXTERNALS}.gtk_widget_struct_window (l_window_imp.c_object))
				end
			end
		end

feature -- Basic operations

	show_relative_to_window (a_window: EV_WINDOW)
			-- Show `Current' with respect to `a_window'.
		do
			set_blocking_window (a_window)
			show
				-- This extra call is needed otherwise the Window will not be transient.
			set_blocking_window (a_window)
		end

	block
			-- Wait until window is closed by the user.
		local
			l_app_imp: like app_implementation
		do
			from
				l_app_imp := app_implementation
			until
				blocking_condition
			loop
				l_app_imp.process_event_queue (True)
			end
		end

	blocking_condition: BOOLEAN
			-- Condition when blocking ceases if enabled.
		do
			Result := is_destroyed or else not is_show_requested or else app_implementation.is_destroyed
		end

feature {EV_INTERMEDIARY_ROUTINES, EV_APPLICATION_IMP}

	user_can_resize: BOOLEAN
			-- Can `Current' be resized by the user?
		deferred
		end

	on_key_event (a_key: EV_KEY; a_key_string: STRING_32; a_key_press: BOOLEAN)
			-- `a_key' has either been pressed or released
		deferred
		end

	XX_process_key_event (a_key_event: POINTER)
			-- Translation routine used for key events
		local
			keyval: NATURAL_32
			a_key_string: STRING_32
			a_key: EV_KEY
			a_key_press: BOOLEAN
			l_app_imp: like app_implementation
			l_accel_list: EV_ACCELERATOR_LIST
			l_window_imp: EV_WINDOW_IMP
			a_focus_widget: EV_WIDGET_IMP
			l_block_events: BOOLEAN
			l_tab_controlable: EV_TAB_CONTROLABLE_I
			l_char: CHARACTER_32
			l_any: ANY
			l_accel: EV_ACCELERATOR
			l_accel_imp: EV_ACCELERATOR_IMP
		do
			l_app_imp := app_implementation
				-- Perform translation on key values from gdk.
	--		keyval := {EV_GTK_EXTERNALS}.gdk_event_key_struct_keyval (a_key_event)
	--		if keyval > 0 and then valid_gtk_code (keyval) then
	--			create a_key.make_with_code (key_code_from_gtk (keyval))
	--		end
	--		if {EV_GTK_EXTERNALS}.gdk_event_key_struct_type (a_key_event) = {EV_GTK_EXTERNALS}.gdk_key_press_enum then
	--			l_window_imp ?= Current
	--				-- Call accelerators if present.
	--			if a_key /= Void and then l_window_imp /= Void then
	--				l_accel_list := l_window_imp.accelerators_internal
	--				if l_accel_list /= Void and then not l_accel_list.is_empty then
	--					l_accel := l_accel_list [1]
	---					if l_accel /= Void then
	--						l_accel_imp ?= l_accel.implementation
	--							-- We retrieve an accelerator implementation object to generate an accelerator id for hash table lookup.
	--						l_accel := l_window_imp.accel_list.item (l_accel_imp.generate_accel_id (a_key, l_app_imp.ctrl_pressed, l_app_imp.alt_pressed, l_app_imp.shift_pressed))
	--						if l_accel /= Void then
	--							l_app_imp.do_once_on_idle (agent (l_accel.actions).call (Void))
	--						end
	--					end
	--				end
	--			end
	--			a_key_press := True
	--			create a_cs.share_from_pointer ({EV_GTK_EXTERNALS}.gdk_event_key_struct_string (a_key_event))
	--			a_key_string := a_cs.string
	--			if a_key_string /= Void and then a_key_string.valid_index (1) then
	--				l_char := a_key_string @ 1
	--				if l_char.is_character_8 then
	--					if not l_char.to_character_8.is_printable and then l_char.code <= 127 then
	--						a_key_string := Void
	--							-- Non displayable characters
	--					end
	--				end
	--			end
				if a_key /= Void and then a_key.text.count /= 1 and then not a_key.is_numpad then
					inspect a_key.code
					when {EV_KEY_CONSTANTS}.key_space then
						a_key_string := once " "
					when {EV_KEY_CONSTANTS}.key_enter then
						a_key_string := once "%N"
					when {EV_KEY_CONSTANTS}.key_tab then
						a_key_string := once "%T"
					else
						a_key_string := Void
					end
				end
	--		end

	--		a_focus_widget ?= l_app_imp.eif_object_from_gtk_object ({EV_GTK_EXTERNALS}.gtk_window_struct_focus_widget (c_object))
			l_any := Current
			if a_focus_widget = Void then
					-- If the focus widget is not available then set it to the current window.
				a_focus_widget ?= l_any
			end
			if a_focus_widget /= Void and then a_focus_widget.is_sensitive and then a_focus_widget.has_focus then
				if a_key /= Void then
					if a_focus_widget.default_key_processing_handler /= Void then
						l_block_events := not a_focus_widget.default_key_processing_handler.item ([a_key])
					end
					if not l_block_events then
						l_tab_controlable ?= a_focus_widget
						if l_tab_controlable /= Void and then not l_tab_controlable.is_tabable_from then
							l_block_events := a_key.is_arrow or else a_key.code = {EV_KEY_CONSTANTS}.key_tab
						end
					end
					if not l_block_events then
	--					{EV_GTK_EXTERNALS}.gtk_main_do_event (a_key_event)
					end
				end
				if l_app_imp.pick_and_drop_source /= Void and then a_key_press and then a_key /= Void and then (a_key.code = {EV_KEY_CONSTANTS}.key_escape or a_key.code = {EV_KEY_CONSTANTS}.key_alt) then
					l_app_imp.pick_and_drop_source.end_transport (0, 0, 0, 0, 0, 0, 0, 0)
				else
					if a_key_press then
						if a_key /= Void and then l_app_imp.key_press_actions_internal /= Void then
							l_app_imp.key_press_actions_internal.call ([a_focus_widget.interface, a_key])
						end
						if a_key_string /= Void and then l_app_imp.key_press_string_actions_internal /= Void then
							l_app_imp.key_press_string_actions_internal.call ([a_focus_widget.interface, a_key_string])
						end
					else
						if a_key /= Void and then l_app_imp.key_release_actions_internal /= Void then
							l_app_imp.key_release_actions_internal.call ([a_focus_widget.interface, a_key])
						end
					end
					if a_focus_widget /= l_any then
						on_key_event (a_key, a_key_string, a_key_press)
					end
					a_focus_widget.on_key_event (a_key, a_key_string, a_key_press)
				end
			else
					-- Execute the gdk event as normal.
	--			{EV_GTK_EXTERNALS}.gtk_main_do_event (a_key_event)
			end
		end

	call_close_request_actions
			-- Call the close request actions.
		deferred
		end

feature {EV_ANY_I} -- Implementation

	forbid_resize
			-- Forbid the resize of the window.
		local
			l_width, l_height: INTEGER
		do
			l_width := width
			l_height := height

			-- TODO
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_SB_WINDOW_IMP
