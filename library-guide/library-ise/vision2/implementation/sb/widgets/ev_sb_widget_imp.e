note

	description: "Objects that ..."

	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_SB_WIDGET_IMP

inherit
	EV_ANY_IMP

feature {EV_SB_WIDGET_IMP, EV_TREE_NODE_IMP, EV_ANY, EV_ANY_I} -- Implementation Attributes

	sb_widget: SB_WINDOW

feature {NONE} -- Implementation

	make
			-- Initialize `sb_widget'.
			-- Redefine in descendants, if necessary
		do
			set_is_initialized (True)
		end


	initialize is
		do
		end

feature {EV_ANY_I} -- Position retrieval

	screen_x: INTEGER is
			-- Horizontal position of the client area on screen,
		do
			if is_displayed then
				TODO_class_line ("EV_SB_WIDGET_IMP::screen_x", "__LINE__")
			end
		end

	screen_y: INTEGER is
			-- Vertical position of the client area on screen,
		do
			if is_displayed then
				TODO_class_line ("EV_SB_WIDGET_IMP::screen_y", "__LINE__")
			end
		end

feature {EV_ANY_I, EV_INTERMEDIARY_ROUTINES} -- Implementation

	x_position: INTEGER is
			-- Horizontal offset relative to parent `x_position'.
			-- Unit of measurement: screen pixels.
		do
			Result := sb_widget.x_pos
			Result := Result.max (0)
		end

	y_position: INTEGER is
			-- Vertical offset relative to parent `y_position'.
			-- Unit of measurement: screen pixels.
		do
			Result := sb_widget.y_pos
			Result := Result.max (0)
		end

	widget_imp_at_pointer_position: EV_WIDGET_IMP is
			-- Widget implementation at current mouse pointer position (if any)
		do
--			Result ?= app_implementation.gtk_widget_imp_at_pointer_position
		end

	minimum_width, real_minimum_width: INTEGER is
			-- Minimum width that the widget may occupy.
		do
			if not is_destroyed then
				Result := sb_widget.minimum_width
			end
		end

	minimum_height, real_minimum_height: INTEGER is
			-- Minimum height that the widget may occupy.
		do
			if not is_destroyed then
				Result := sb_widget.minimum_height
			end
		end

	set_pointer_style (a_pointer: EV_POINTER_STYLE) is
			-- Assign `a_pointer' to `pointer_style'.
		do
			if a_pointer /= pointer_style then
				pointer_style := a_pointer
				TODO_class_line ("EV_SB_WIDGET_IMP::set_pointer_style", "__LINE__")
--				if is_displayed or else previous_gdk_cursor /= default_pointer then
--					internal_set_pointer_style (a_pointer)
--						-- `internal_set_pointer_style' will get called in `on_widget_mapped'
--				end
			end
		end

	internal_set_pointer_style (a_cursor: EV_POINTER_STYLE) is
			-- Assign `a_cursor' to `pointer_style', used for PND
		local
			a_cursor_imp: EV_POINTER_STYLE_IMP
		do
			if a_cursor /= Void then
				a_cursor_imp ?= a_cursor.implementation
				-- TODO
			end
			-- TODO
--			previous_gdk_cursor := a_cursor_ptr
		end

	pointer_style: EV_POINTER_STYLE
			-- Cursor displayed when the pointer is over this widget.
			-- Position retrieval.

	set_focus is
			-- Grab keyboard focus.
		do
			if not has_focus then
				internal_set_focus
			end
		end

	internal_set_focus is
			-- Grab keyboard focus.
		local
			l_window, l_widget: POINTER
			l_interface: EV_ANY
			l_app_imp: like app_implementation
		do
			l_app_imp := app_implementation
				-- If any previous widget has the capture then disable it.
				-- If a Pick and Drop is occurring we leave the capture as is.
--			if l_app_imp.captured_widget /= Void and then not l_app_imp.is_in_transport then
--				l_interface := interface
--				if l_interface /= l_app_imp.captured_widget then
--					l_app_imp.captured_widget.disable_capture
--				end
--			end
--			if {EV_GTK_EXTERNALS}.gtk_is_window (c_object) then
--				l_window := c_object
--					l_widget := default_pointer -- This will unset any previous focused widget.
--			else
--				l_window := {EV_GTK_EXTERNALS}.gtk_widget_get_toplevel (c_object)
--				l_widget := visual_widget
--				if {EV_GTK_EXTERNALS}.gtk_object_struct_flags (l_widget) & {EV_GTK_EXTERNALS}.gtk_can_focus_enum /= {EV_GTK_EXTERNALS}.gtk_can_focus_enum then
--					l_widget := default_pointer
--				end
--			end
--			{EV_GTK_EXTERNALS}.gtk_window_set_focus (l_window, l_widget)
		end

	has_focus: BOOLEAN is
			-- Does widget have the keyboard focus?
		do
		end

	width: INTEGER is
			-- Horizontal size measured in pixels.
		local
			l_minimum_width: like real_minimum_width
			l_allocated_width: INTEGER
		do
			-- TODO
--			Result := l_minimum_width.max (l_allocated_width)
		end

	height: INTEGER is
			-- Vertical size measured in pixels.
		local
			l_minimum_height: like real_minimum_height
			l_allocated_height: INTEGER
		do
			-- TODO
			Result := l_minimum_height.max (l_allocated_height)
		end

	show is
			-- Request that `Current' be displayed when its parent is.
		do
			sb_widget.show
		end

feature -- Status report

	is_show_requested: BOOLEAN is
			-- Will `Current' be displayed when its parent is?
			-- See also `is_displayed'.
		do
			-- TODO
		end

	is_displayed: BOOLEAN is
			-- Is `Current' visible on the screen?
		local
			l_win: EV_WINDOW_IMP
		do
		end

feature {EV_ANY_I} -- Implementation

	top_level_window_imp: EV_WINDOW_IMP is
			-- Window implementation that `Current' is contained within (if any)
		do
			-- TODO
		end

	top_level_window: EV_WINDOW is
			-- Window the current is contained within (if any)
		local
			a_window_imp: EV_WINDOW_IMP
		do
			a_window_imp := top_level_window_imp
			if a_window_imp /= Void then
				Result := a_window_imp.interface
			end
		end

--	event_widget: POINTER is	-- ???
--		do
--		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EV_SB_WIDGET_IMP
