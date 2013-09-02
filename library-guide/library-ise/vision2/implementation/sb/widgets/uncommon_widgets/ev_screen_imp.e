note
	description:
		"EiffelVision screen. Slyboots implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "screen, root, window, visual, top"
	date: "$Date$"
	revision: "$Revision$"


class
	EV_SCREEN_IMP

inherit
	EV_SCREEN_I
		redefine
			interface,
			widget_at_mouse_pointer
		end

	EV_DRAWABLE_IMP
		redefine
			interface,
			dispose,
			make
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Set up action sequence connections and create graphics context.
		do
			todo_class_line ("__EV_SCREEN_IMP__", "__LINE__ 1")

--#			gc := {EV_GTK_EXTERNALS}.gdk_gc_new (drawable)
--#			{EV_GTK_EXTERNALS}.gdk_gc_set_subwindow (gc, {EV_GTK_EXTERNALS}.gdk_include_inferiors_enum)
			init_default_values
			set_is_initialized (True)
		end

feature -- Status report

	pointer_position: EV_COORDINATE
			-- Position of the screen pointer.
		local
			l_display_data: TUPLE [a_window: POINTER; a_x: INTEGER; a_y: INTEGER; a_mask: INTEGER]	-- FIXME
		do
		--	l_display_data := app_implementation.retrieve_display_data
			create Result.set (l_display_data.a_x, l_display_data.a_y)
		end

	widget_at_position (x, y: INTEGER): EV_WIDGET
			-- Widget at position ('x', 'y') if any.
		local
			l_pointer_position: like pointer_position
			l_widget_imp: EV_WIDGET_IMP
			l_change: BOOLEAN
		do
			l_pointer_position := pointer_position
				-- If `x' and `y' are at the pointer position then as an optimization we do not change the position of the mouse.
			l_change := l_pointer_position.x /= x or else l_pointer_position.y /= y
			if l_change then
				set_pointer_position (x, y)
			end
			l_widget_imp := widget_imp_at_pointer_position
			if l_change then
				set_pointer_position (l_pointer_position.x, l_pointer_position.y)
			end
			if l_widget_imp /= Void then
				Result := l_widget_imp.interface
			end
		end

	widget_at_mouse_pointer: EV_WIDGET
			-- Widget at mouse pointer if any.
		local
			l_widget_imp: EV_WIDGET_IMP
		do
			l_widget_imp := widget_imp_at_pointer_position
			if l_widget_imp /= Void then
				Result := l_widget_imp.interface
			end
		end

	widget_imp_at_pointer_position: EV_WIDGET_IMP
			-- Widget implementation at current mouse pointer position (if any)
		local
			a_x, a_y: INTEGER
			gdkwin, gtkwid: POINTER
		do
			todo_class_line ("__EV_SCREEN_IMP__", "__LINE__ 1")

--			gdkwin := {EV_GTK_EXTERNALS}.gdk_window_at_pointer ($a_x, $a_y)
--			if gdkwin /= default_pointer then
--				from
--					{EV_GTK_EXTERNALS}.gdk_window_get_user_data (gdkwin, $gtkwid)
--				until
--					Result /= Void or else gtkwid = default_pointer
--				loop
--					Result ?= {EV_GTK_CALLBACK_MARSHAL}.c_get_eif_reference_from_object_id (gtkwid)
--					gtkwid := {EV_GTK_EXTERNALS}.gtk_widget_struct_parent (gtkwid)
--				end
--			end
		end

feature -- Status setting

	set_default_colors
			-- Set foreground and background color to their default values.
		local
			a_default_colors: EV_STOCK_COLORS
		do
			create a_default_colors
			set_background_color (a_default_colors.default_background_color)
			set_foreground_color (a_default_colors.default_foreground_color)
		end

feature -- Basic operation

	redraw
			-- Redraw the entire area.
		do
			todo_class_line ("__EV_SCREEN_IMP__", "__LINE__ 1")

--			{EV_GTK_EXTERNALS}.gdk_window_invalidate_rect (drawable, default_pointer, True)
--			{EV_GTK_EXTERNALS}.gdk_window_process_updates (drawable, True)
		end

	x_test_capable: BOOLEAN
			-- Is current display capable of performing x tests.
		local
			a_event_base, a_error_base, a_maj_ver, a_min_ver: INTEGER
		do
			todo_class_line ("__EV_SCREEN_IMP__", "__LINE__ 1")

--			Result := x_test_query_extension (
--					{EV_GTK_EXTERNALS}.gdk_display,
--					$a_event_base,
--					$a_error_base,
--					$a_maj_ver,
--					$a_min_ver)

		end

	set_pointer_position (a_x, a_y: INTEGER)
			-- Set pointer position to (a_x, a_y).
		local
			a_success_flag: BOOLEAN
		do
			check
				x_test_capable: x_test_capable
			end

			todo_class_line ("__EV_SCREEN_IMP__", "__LINE__ 1")

--			a_success_flag := x_test_fake_motion_event ({EV_GTK_EXTERNALS}.gdk_display, -1, a_x, a_y, 0)
			check
				pointer_position_set: a_success_flag
			end
		end

	fake_pointer_button_press (a_button: INTEGER)
			-- Fake button `a_button' press on pointer.
		local
			a_success_flag: BOOLEAN
		do
			check
				x_test_capable: x_test_capable
			end
			todo_class_line ("__EV_SCREEN_IMP__", "__LINE__ 1")

--			a_success_flag := x_test_fake_button_event ({EV_GTK_EXTERNALS}.gdk_display, a_button, True, 0)
			check
				fake_pointer_button_press_success: a_success_flag
			end
		end

	fake_pointer_button_release (a_button: INTEGER)
			-- Fake button `a_button' release on pointer.
		local
			a_success_flag: BOOLEAN
		do
			check
				x_test_capable: x_test_capable
			end
			todo_class_line ("__EV_SCREEN_IMP__", "__LINE__ 1")

--			a_success_flag := x_test_fake_button_event ({EV_GTK_EXTERNALS}.gdk_display, a_button, False, 0)
			check
				fake_pointer_button_release_success: a_success_flag
			end
		end

	fake_pointer_wheel_up
			-- Simulate the user rotating the mouse wheel up.
		do
				--| Mouse pointer button number 4 relates to mouse wheel up
			fake_pointer_button_press (4)
		end

	fake_pointer_wheel_down
			-- Simulate the user rotating the mouse wheel down.
		do
				--| Mouse pointer button number 5 relates to mouse wheel up
			fake_pointer_button_press (5)
		end

	fake_key_press (a_key: EV_KEY)
			-- Fake key `a_key' press.
		local
			a_success_flag: BOOLEAN
			a_key_code: INTEGER
		do
			todo_class_line ("__EV_SCREEN_IMP__", "__LINE__ 1")

			check
				x_test_capable: x_test_capable
			end
--			a_key_code := key_conversion.key_code_to_gtk (a_key.code).to_integer_32
--			a_key_code := x_keysym_to_keycode ({EV_GTK_EXTERNALS}.gdk_display, a_key_code)
--			a_success_flag := x_test_fake_key_event ( {EV_GTK_EXTERNALS}.gdk_display, a_key_code, True, 0)
			check
				fake_key_press_success: a_success_flag
			end
		end

	fake_key_release (a_key: EV_KEY)
			-- Fake key `a_key' release.
		local
			a_success_flag: BOOLEAN
			a_key_code: INTEGER
		do
			todo_class_line ("__EV_SCREEN_IMP__", "__LINE__ 1")

			check
				x_test_capable: x_test_capable
			end
--			a_key_code := key_conversion.key_code_to_gtk (a_key.code).to_integer_32
--			a_key_code := x_keysym_to_keycode ( {EV_GTK_EXTERNALS}.gdk_display, a_key_code)
--			a_success_flag := x_test_fake_key_event (
--								{EV_GTK_EXTERNALS}.gdk_display,
--								a_key_code,
--								False,
--								0
--					)
			check
				fake_key_release_success: a_success_flag
			end
		end

--	key_conversion: EV_GTK_KEY_CONVERSION
--			-- Utilities for converting X key codes.
--		once
--			create Result
--		end

feature -- Measurement

	horizontal_resolution: INTEGER
			-- Number of pixels per inch along horizontal axis
		do
			todo_class_line ("__EV_SCREEN_IMP__", "__LINE__ 1")

--			Result := horizontal_resolution_internal
		end

	vertical_resolution: INTEGER
			-- Number of pixels per inch along vertical axis
		do
			todo_class_line ("__EV_SCREEN_IMP__", "__LINE__ 1")

--			Result := vertical_resolution_internal
		end

	height: INTEGER
			-- Vertical size in pixels.
		do
			todo_class_line ("__EV_SCREEN_IMP__", "__LINE__ 1")

--			Result := {EV_GTK_EXTERNALS}.gdk_screen_height
		end

	width: INTEGER
			-- Horizontal size in pixels.
		do
			todo_class_line ("__EV_SCREEN_IMP__", "__LINE__ 1")

--			Result := {EV_GTK_EXTERNALS}.gdk_screen_width
		end

feature {NONE} -- Externals (XTEST extension)

	frozen x_keysym_to_keycode (a_display: POINTER; a_keycode: INTEGER): INTEGER
		external
			"C: EIF_INTEGER| <X11/Xlib.h>"
		alias
			"XKeysymToKeycode"
		end

	frozen x_test_fake_button_event (a_display: POINTER; a_button: INTEGER; a_is_press: BOOLEAN; a_delay: INTEGER): BOOLEAN
		external
			"C: EIF_BOOL| <X11/extensions/XTest.h>"
		alias
			"XTestFakeButtonEvent"
		end

	frozen x_test_fake_key_event (a_display: POINTER; a_keycode: INTEGER; a_is_press: BOOLEAN; a_delay: INTEGER): BOOLEAN
		external
			"C: EIF_BOOL| <X11/extensions/XTest.h>"
		alias
			"XTestFakeKeyEvent"
		end

	frozen x_test_fake_motion_event (a_display: POINTER; a_scr_num, a_x, a_y, a_delay: INTEGER): BOOLEAN
		external
			"C: EIF_BOOL| <X11/extensions/XTest.h>"
		alias
			"XTestFakeMotionEvent"
		end

	frozen x_test_query_extension (a_display, a_event_base, a_error_base, a_major_version, a_minor_version: POINTER): BOOLEAN
		external
			"C: EIF_BOOL| <X11/extensions/XTest.h>"
		alias
			"XTestQueryExtension"
		end

feature {NONE} -- Implementation

	create_resource
		do
		end

	destroy_resource
		do
		end

	flush
			-- Force all queued draw to be called.
		do
			-- By default do nothing
		end

	update_if_needed
			-- Update `Current' if needed
		do
			-- By default do nothing
		end

	destroy
		do
			set_is_destroyed (True)
		end

	dispose
			-- Cleanup
		do
		end

	drawable: POINTER
			-- Pointer to the screen (root window)
		do
			todo_class_line ("__EV_SCREEN_IMP__", "__LINE__ 1")

--			Result := {EV_GTK_EXTERNALS}.gdk_root_parent
		end

	mask: POINTER
			-- Mask of `Current', which is always NULL
		do
			todo_class_line ("__EV_SCREEN_IMP__", "__LINE__ 1")

			-- Not applicable to screen
		end

	interface: EV_SCREEN;

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




end -- class EV_SCREEN_IMP

