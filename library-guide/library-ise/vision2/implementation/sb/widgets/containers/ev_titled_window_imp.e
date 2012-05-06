note
	description:
		"Eiffel Vision titled window. Slyboots implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TITLED_WINDOW_IMP

inherit
	EV_TITLED_WINDOW_I
		undefine
			propagate_foreground_color,
			propagate_background_color,
			lock_update,
			unlock_update
		redefine
			interface
		end

	EV_WINDOW_IMP
		redefine
			sb_window,
			interface,
			make,
			create_sb_window,
			default_wm_decorations,
			is_displayed,
			call_window_state_event
		end

	EV_TITLED_WINDOW_ACTION_SEQUENCES_IMP

create
	make

feature {NONE} -- Implementation Attributes

	sb_window: SB_TOP_WINDOW

feature {NONE} -- Initialization

	make
			-- Create the titled window.
		do
			Precursor
		end

	create_sb_window
		do
			create {SB_TOP_WINDOW} sb_window.make_top_title (app_implementation.sb_application, once "Default Title")
				-- TEMP: track windows created so far ...
			app_implementation.sb_application.open_widgets_display_window
		end

feature {EV_APPLICATION_IMP} -- Implementation

	call_window_state_event (a_changed_mask, a_new_state: INTEGER)
			-- Handle either minimize, maximize or restore event for `Current'.
			-- Call minimize_actions, maximize_actions, restore_actions as appropriate
			-- Set is_minimized, is_maximised as appropriate
		local
			l_call_restore: BOOLEAN
		do
			TODO_class_line ("EV_TITLED_WINDOW_IMP", "__LINE__")

--			if this_is_a_minimize_event then
--					is_minimized := True
--					is_maximized := False
--					if minimize_actions_internal /= Void then
--						minimize_actions_internal.call (Void)
--					end
--				else
--					l_call_restore := True
--				end
--			elseif this_is_a_maximize_event then
--					is_maximized := True
--					is_minimized := False
--					if maximize_actions_internal /= Void then
--						maximize_actions_internal.call (Void)
--					end
--				else
--					l_call_restore := True
--				end
--			end
--			if l_call_restore then
--				is_minimized := False
--				is_maximized := False
--				if restore_actions_internal /= Void then
--					restore_actions_internal.call (Void)
--				end
--			end
		end

feature -- Access

	icon_name: STRING_32
			-- Alternative name, displayed when window is minimised.
		do
			if icon_name_holder /= Void then
				Result := icon_name_holder
			else
				Result := title
			end
		end

	icon_pixmap: EV_PIXMAP
			-- Window icon.

	icon_mask: EV_PIXMAP
			-- Transparency mask for `icon_pixmap'.

feature -- Status report

	is_minimized: BOOLEAN
			-- Is displayed iconified/minimised?

	is_maximized: BOOLEAN
			-- Is displayed at maximum size?

	is_displayed: BOOLEAN
			-- Is 'Current' displayed on screen?
		do
			Result := Precursor {EV_WINDOW_IMP} and not is_minimized
		end

feature -- Status setting

	raise
			-- Request that window be displayed above all other windows.
		do
			if not is_show_requested then
				show
			elseif is_minimized then
				restore
			end
			sb_window.raise
		end

	lower
			-- Request that window be displayed below all other windows.
		do
			sb_window.lower
		end

	minimize
			-- Display iconified/minimised.
		do
			is_minimized := True
			is_maximized := False
			sb_window.iconify
		end

	maximize
			-- Display at maximum size.
		do
			is_maximized := True
			is_minimized := False
			sb_window.maximize
		end

	restore
			-- Restore to original position when minimized or maximized.
		do
			if is_maximized then
				is_maximized := False
--				sb_window.restore
			elseif is_minimized then
				is_minimized := False
				sb_window.deiconify	-- deiconify ??
			end
		end

feature -- Element change

	set_icon_name (an_icon_name: STRING_GENERAL)
			-- Assign `an_icon_name' to `icon_name'.
		do
--			a_cs := an_icon_name
--			{EV_GTK_EXTERNALS}.gdk_window_set_icon_name (
--				{EV_GTK_EXTERNALS}.gtk_widget_struct_window (c_object), a_cs.item)
--			icon_name_holder := an_icon_name.twin
		end

	set_icon_pixmap (an_icon: EV_PIXMAP)
			-- Assign `an_icon' to `icon'.
		local
			pixmap_imp: EV_PIXMAP_IMP
		do
			pixmap_imp ?= an_icon.twin.implementation
			icon_pixmap := pixmap_imp.interface
			check
				icon_implementation_exists: pixmap_imp /= Void
			end
--			{EV_GTK_EXTERNALS}.gdk_window_set_icon ({EV_GTK_EXTERNALS}.gtk_widget_struct_window (c_object), NULL, pixmap_imp.drawable, pixmap_imp.mask)
		end

feature {NONE} -- Implementation

	default_wm_decorations: INTEGER
			-- Default WM decorations of `Current'.?
		do
			TODO_class_line ("EV_TITLED_WINDOW_IMP", "__LINE__")
		end

feature {EV_ANY_I} -- Implementation

	icon_name_holder: STRING_32
			-- Name holder for applications icon name

	interface: EV_TITLED_WINDOW;

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

end -- class EV_TITLED_WINDOW_IMP

