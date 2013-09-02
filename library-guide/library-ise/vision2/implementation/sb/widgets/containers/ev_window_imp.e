note

		description: "Eiffel Vision window. Slyboots implementation."

	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_WINDOW_IMP

inherit
	EV_WINDOW_I
		undefine
			propagate_foreground_color,
			propagate_background_color
		redefine
			interface
		end

	EV_CELL_IMP
--		rename
--			sb_widget as sb_window
		undefine
			x_position,
			y_position,
			screen_x,
			screen_y,
--			minimum_width,
--			minimum_height,
			width,
			height,
			show,
			has
--				-- SB_ ...
--			class_name,
--			default_width_sb,
--			default_height_sb,
--			on_paint
		redefine
			interface,
--			sb_window,
			make,
			on_size_allocate,
			hide,
			on_widget_mapped,
			destroy,
			has_focus,
			on_focus_changed
		end

	EV_SB_WINDOW_IMP
--		rename
--			make_ev as make_window_ev
		undefine
			initialize,
			parent_imp
--			set_width,
--			set_height
--			set_minimum_width,
--			set_minimum_height
		redefine
--			sb_window,
			make,
			interface,
			has_focus,
			show,
			hide
		end

	EV_WINDOW_ACTION_SEQUENCES_IMP

create
	make

feature {NONE} -- Attributes

--	sb_window: SB_TOP_WINDOW

feature {NONE} -- Initialization

	make
			-- Create the vertical box `vbox' and horizontal box `container_widget'
			-- to put in the window.
			-- The `vbox' will be able to contain the menu bar, the `container_widget'
			-- and the status bar.
			-- The `container_widget' will contain the child of the window.
		local
			app_imp: like app_implementation
		do
		--	check false end
			set_is_initialized (False)
			create_sb_window

			create accel_list.make (10)
		--	create upper_bar
		--	create lower_bar

		--	create vbox.make (sb_window)

			internal_is_border_enabled := True
			configure_event_pending := True
			user_can_resize := True
			set_is_initialized (True)
		end

	create_sb_window
		do
	--		create {SB_TOP_WINDOW} sb_window.make_top_title (application, "Title ...")
		end

feature  -- Access

	has_focus: BOOLEAN
			-- Does `Current' have the keyboard focus?
		do
			Result := internal_has_focus
		end

 	maximum_width: INTEGER
			-- Maximum width that application wishes widget
			-- instance to have.

	maximum_height: INTEGER
			-- Maximum height that application wishes widget
			-- instance to have.

	title: STRING_32
			-- Application name to be displayed by
			-- the window manager.
		do
				-- TODO: should this we .twin ?
	--		Result := sb_window.title
		end

	menu_bar: EV_MENU_BAR
			-- Horizontal bar at top of client area that contains menu's.

feature -- Status setting

	add_transient_child (a_child: EV_SB_WINDOW_IMP)
			-- Add `a_child' as transient child for `Current'.
		require
			a_child_not_void: a_child /= Void
		do
			todo_class_line ("__EV_WINDOW_IMP__", "__LINE__ 4")
		end

	remove_transient_child (a_child: EV_SB_WINDOW_IMP)
			-- Remove `a_child' as transient child for `Current'.
		require
			a_child_not_void: a_child /= Void
		do
			todo_class_line ("__EV_WINDOW_IMP__", "__LINE__ 5")
		end

	internal_enable_border
			-- Ensure a border is displayed around `Current'.
		local
			l_decor: INTEGER
		do
			todo_class_line ("__EV_WINDOW_IMP__", "__LINE__ 7")
		end

	internal_disable_border
			-- Ensure no border is displayed around `Current'.
		local
			l_decor: INTEGER
			l_x, l_y: INTEGER
			l_temp: INTEGER
		do
			todo_class_line ("__EV_WINDOW_IMP__", "__LINE__ 6")
		end

	disable_user_resize_called: BOOLEAN
		-- Has `disable_user_resize' been called?

	disable_user_resize
			-- Forbid the resize of the window.
		do
			disable_user_resize_called := True
			user_can_resize := False
			if is_displayed then
				forbid_resize
			end
		end

	enable_user_resize
			-- Allow the resize of the window.
		do
			user_can_resize := True
			if is_displayed then
				allow_resize
			end
		end

	allow_resize
			-- Allow the resize of the window.
		local
			l_geometry: POINTER
		do
			todo_class_line ("__EV_WINDOW_IMP__", "__LINE__ 8")
			internal_enable_border
		end

	show
			-- Map the Window to the screen.
		do
			if not is_show_requested then
				call_show_actions := True
				if disable_user_resize_called then
					if not user_can_resize then
						forbid_resize
					else
							-- Forbid the window manager from resizing window.
						allow_resize
					end
				end
				Precursor {EV_SB_WINDOW_IMP}
			end
			if blocking_window /= Void then
				set_blocking_window (Void)
			end
		end

	call_show_actions: BOOLEAN
		-- Should the show actions be called?

	hide
			-- Unmap the Window from the screen.
		local
			a_x_pos, a_y_pos: INTEGER
		do
			if is_show_requested then
				a_x_pos := x_position
				a_y_pos := y_position
				disable_capture
--#				Precursor {EV_SB_WINDOW_IMP}
					-- Setting positions so that if `Current' is reshown then it reappears in the same place, as on Windows.
				allow_resize
				set_position (a_x_pos, a_y_pos)
			end
		end

feature -- Element change

	set_maximum_width (a_max_width: INTEGER)
			-- Set `maximum_width' to `a_max_width'.
		do
			internal_set_maximum_size (a_max_width, maximum_height)
		end

	set_maximum_height (a_max_height: INTEGER)
			-- Set `maximum_height' to `a_max_height'.
		do
			internal_set_maximum_size (maximum_width, a_max_height)
		end

	set_title (new_title: STRING_GENERAL)
			-- Set `title' to `new_title'.
		local
			l_title_32: STRING_32
			l_title: STRING
		do
			l_title ?= new_title
			if l_title /= Void then
	--			sb_window.set_title (l_title)
			end
		end

	set_menu_bar (a_menu_bar: EV_MENU_BAR)
			-- Set `menu_bar' to `a_menu_bar'.
		local
			mb_imp: detachable EV_MENU_BAR_IMP
		do
			todo_class_line ("__EV_WINDOW_IMP__", "__LINE__ 10")

			mb_imp ?= a_menu_bar.implementation
			mb_imp.set_parent_window_imp (Current)	-- ???
	--		mb_imp.sb_widget.set_parent (vbox)
			menu_bar := a_menu_bar
		end

	remove_menu_bar
			-- Set `menu_bar' to `Void'.
		local
			mb_imp: detachable EV_MENU_BAR_IMP
		do
			if menu_bar /= Void then
				todo_class_line ("__EV_WINDOW_IMP__", "__LINE__ 11")
			end
			menu_bar := Void
		end

feature {EV_SB_WINDOW_IMP} -- Access

--	accel_list: HASH_TABLE [EV_ACCELERATOR, INTEGER]
--		-- Lookup table for accelerator access.

feature {NONE} -- Accelerators

	connect_accelerator (an_accel: EV_ACCELERATOR)
			-- Connect key combination `an_accel' to this window.
		local
			acc_imp: EV_ACCELERATOR_IMP
		do
			todo_class_line ("__EV_WINDOW_IMP__", "__LINE__ 12")
		end

	disconnect_accelerator (an_accel: EV_ACCELERATOR)
			-- Disconnect key combination `an_accel' from this window.
		local
			acc_imp: EV_ACCELERATOR_IMP
		do
			if an_accel /= Void then
				acc_imp ?= an_accel.implementation
--				accel_list.remove (acc_imp.accel_id)
			end
		end

feature {EV_ANY_IMP} -- Implementation

	destroy
			-- Destroy `Current'
		do
			disable_capture
			hide
			Precursor {EV_CELL_IMP}
		end

feature {EV_APPLICATION_IMP} -- Implementation

	on_widget_mapped
			-- `Current' has been mapped to the screen.
		do
			Precursor
			if show_actions_internal /= Void and call_show_actions then
				show_actions_internal.call (Void)
			end
			call_show_actions := False
		end

feature {NONE} -- Implementation

	internal_has_focus: BOOLEAN
			-- Does `Current' have the keyboard focus?

	internal_set_maximum_size (a_max_width, a_max_height: INTEGER)
			-- Set maximum width and height of `Current' to `a_max_width' and `a_max_height'.
		local
			l_geometry: POINTER
		do
			todo_class_line ("__EV_WINDOW_IMP__", "__LINE__ 13")
		end

	previously_focused_widget: POINTER
		-- Widget that was previously focused within `Current'.

	set_focused_widget (a_widget: EV_WIDGET_IMP)
			-- Set currently focused widget to `a_widget'.
		do
			check not_implemented: false end
			if a_widget /= Void then
	--			previously_focused_widget := a_widget.c_object
			else
				previously_focused_widget := default_pointer
			end
		end

	previous_x_position, previous_y_position: INTEGER
		-- Positions of previously set x and y coordinates of `Current'.

	initialize_client_area
			-- Initialize the client area of 'Current'.
		local
			bar_imp: EV_VERTICAL_BOX_IMP
		do
			todo_class_line ("__EV_WINDOW_IMP__", "__LINE__ 14")
		end

feature {EV_INTERMEDIARY_ROUTINES, EV_APPLICATION_IMP} -- Implementation

	on_size_allocate (a_x, a_y, a_width, a_height: INTEGER)
			-- GdkEventConfigure event occurred.
		local
			l_x_pos, l_y_pos: INTEGER
		do
			todo_class_line ("__EV_WINDOW_IMP__", "__LINE__ 15")
		end

	call_window_state_event (a_changed_mask, a_new_state: INTEGER)
			-- Call either minimize, maximize or restore actions for window
		do
			-- Move implementation from EV_TITLED_WINDOW_IMP when necessary
		end

	on_set_focus_event (a_widget_ptr: POINTER)
			-- The focus of a widget has changed within `Current'.
		local
			l_previously_focused_widget: EV_WIDGET_IMP
			a_widget: EV_WIDGET_IMP
		do
			todo_class_line ("__EV_WINDOW_IMP__", "__LINE__ 14x")

--			a_widget ?= app_implementation.eif_object_from_gtk_object (a_widget_ptr)
--			l_previously_focused_widget ?= app_implementation.eif_object_from_gtk_object (previously_focused_widget)
--			if a_widget /= Void then
--				set_focused_widget (a_widget)
--				a_widget.on_focus_changed (True)
--			end
--			if l_previously_focused_widget /= Void and then l_previously_focused_widget /= a_widget then
--				set_focused_widget (Void)
--				l_previously_focused_widget.on_focus_changed (False)
--			end
		end

feature {EV_SB_WINDOW_IMP, EV_PICK_AND_DROPABLE_IMP, EV_APPLICATION_IMP} -- Implementation

	modal_window_count: INTEGER
		-- Number of windows modal to current.

	increase_modal_window_count
			-- Increase modal window count.
		do
			if modal_window_count = 0 then
				disallow_window_manager_focus
			end
			modal_window_count := modal_window_count + 1
		end

	decrease_modal_window_count
			-- Decrease modal window count.
		require
			modal_window_count_decreasable: modal_window_count > 0
		do
			modal_window_count := modal_window_count - 1
			if modal_window_count = 0 then
				allow_window_manager_focus
			end
		end

	has_modal_window: BOOLEAN
			-- Does `Current' have a transient window that is modal to `Current'.
		do
			Result := modal_window_count > 0
		end

	allow_window_manager_focus
			-- Allow the window manager to give the focus to `Current'.
		do
			todo_class_line ("__EV_WINDOW_IMP__", "__LINE__ 16")
		end

	disallow_window_manager_focus
			-- Disallow the window manager to give the focus to `Current'.
		do
			todo_class_line ("__EV_WINDOW_IMP__", "__LINE__ 17")
		end

feature {EV_MENU_BAR_IMP, EV_ACCELERATOR_IMP, EV_APPLICATION_IMP} -- Implementation

	on_focus_changed (a_has_focus: BOOLEAN)
			-- Called from focus intermediary agents when focus for `Current' has changed.
			-- if `a_has_focus' then `Current' has just received focus.
		do
			internal_has_focus := a_has_focus
			Precursor {EV_CELL_IMP} (a_has_focus)
			if a_has_focus then
--#				on_set_focus_event ({EV_SB_EXTERNALS}.gtk_window_struct_focus_widget (c_object))
			else
				on_set_focus_event (default_pointer)
			end
		end

feature {EV_ACCELERATOR_IMP, EV_MENU_BAR_IMP} -- Implementation

	vbox: SB_VERTICAL_FRAME
			-- Vertical_box to have a possibility for a menu on the
			-- top and a status bar at the bottom.

feature {EV_INTERMEDIARY_ROUTINES}

	call_close_request_actions
			-- Call the close request actions.
		do
			if close_request_actions_internal /= Void
	--		and then not app_implementation.is_in_transport
			and then not has_modal_window then
				close_request_actions_internal.call (Void)
			end
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_WINDOW;
		-- Interface object of `Current'

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




end -- class EV_WINDOW_IMP

