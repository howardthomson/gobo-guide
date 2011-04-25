indexing
	description:
		"Eiffel Vision button. Slyboots implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "press, push, label, pixmap"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_BUTTON_IMP

inherit
	EV_BUTTON_I
		redefine
			interface
		end

	EV_PRIMITIVE_IMP
		rename
			sb_widget as sb_button
		redefine
			sb_button,
			interface,
--			initialize,
			old_make,
			set_foreground_color,
			on_focus_changed	--,
--			event_widget
		end

	EV_PIXMAPABLE_IMP
		redefine
			interface	--,
--			initialize
		end

	EV_TEXTABLE_IMP
		redefine
			interface,
--			initialize,
			align_text_left,
			align_text_center,
			align_text_right
		end

	EV_FONTABLE_IMP
		redefine
			interface	--,
--			initialize
		end

	EV_BUTTON_ACTION_SEQUENCES_IMP
		export
			{EV_INTERMEDIARY_ROUTINES} select_actions_internal
		end

create
	make

feature {NONE} -- Implementation Attributes

	sb_button: SB_BUTTON

feature {NONE} -- Initialization

	old_make (an_interface: like interface) is
			-- Connect interface and initialize `c_object'.
		do
print ("EV_BUTTON_IMP::make #1%N")
			base_make (an_interface)
print ("EV_BUTTON_IMP::make #2%N")
			create sb_button.make_ev
print ("EV_BUTTON_IMP::make completed%N")
		end

	make is
			-- `Precursor' initialization,
			-- create button box to hold label and pixmap.
		local
--			l_composite: SB_COMPOSITE
		do
--			if parent_imp /= Void then
--				l_composite ?= parent_imp.sb_widget
--			end
--			if l_composite = Void then
--				print ("EV_BUTTON_IMP -- l_composite = Void !%N")
--			end

--			pixmapable_imp_initialize
--			textable_imp_initialize
--			align_text_center
--			Precursor {EV_PRIMITIVE_IMP}
		end

	XXfontable_widget: POINTER is
			-- Pointer to the widget that may have fonts set.
		do
			Result := text_label
		end

feature -- Access

	is_default_push_button: BOOLEAN
			-- Is this button currently a default push button
			-- for a particular container?

feature -- Status Setting

	align_text_center is
			-- Display `text' centered.
		do
			TODO_class_line ("__EV_BUTTON_IMP__", "align_text_center")
			
			Precursor {EV_TEXTABLE_IMP}
--			{EV_GTK_EXTERNALS}.gtk_alignment_set (button_box, 0.5, 0.5, 0, 0)
		end

	align_text_left is
			-- Display `text' left aligned.
		do
			TODO_class_line ("__EV_BUTTON_IMP__", "align_text_left")
			
			Precursor {EV_TEXTABLE_IMP}
--			{EV_GTK_EXTERNALS}.gtk_alignment_set (button_box, 0.0, 0.5, 0, 0)
		end

	align_text_right is
			-- Display `text' right aligned.
		do
			TODO_class_line ("__EV_BUTTON_IMP__", "align_text_right")
			
			Precursor {EV_TEXTABLE_IMP}
--			{EV_GTK_EXTERNALS}.gtk_alignment_set (button_box, 1.0, 0.5, 0, 0)
		end

	enable_default_push_button is
			-- Set the style of the button corresponding
			-- to the default push button.
		do
			enable_can_default
		end

	disable_default_push_button is
			-- Remove the style of the button corresponding
			-- to the default push button.
		do
			TODO_class_line ("__EV_BUTTON_IMP__", "disable_default_push_button")
			
			is_default_push_button := False
--			{EV_GTK_EXTERNALS}.gtk_widget_unset_flags (visual_widget, {EV_GTK_ENUMS}.gtk_has_default_enum)
--			{EV_GTK_EXTERNALS}.gtk_widget_queue_draw (visual_widget)
		end

	enable_can_default is
			-- Allow the style of the button to be the default push button.
		do
			TODO_class_line ("__EV_BUTTON_IMP__", "enable_can_default")
			
			is_default_push_button := True
--			{EV_GTK_EXTERNALS}.gtk_widget_set_flags (visual_widget, {EV_GTK_ENUMS}.gtk_has_default_enum)
--			{EV_GTK_EXTERNALS}.gtk_widget_queue_draw (visual_widget)
		end

	set_foreground_color (a_color: EV_COLOR) is
		do
			TODO_class_line ("__EV_BUTTON_IMP__", "set_foreground_color")
			
			Precursor {EV_PRIMITIVE_IMP} (a_color)
--			real_set_foreground_color (text_label, a_color)
		end

feature {NONE} -- implementation

	on_focus_changed (a_has_focus: BOOLEAN) is
			-- Called from focus intermediary agents when focus for `Current' has changed.
			-- if `a_has_focus' then `Current' has just received focus.
		local
			top_level_dialog_imp: EV_DIALOG_IMP
			rad_but: EV_RADIO_BUTTON_IMP
		do
			Precursor {EV_PRIMITIVE_IMP} (a_has_focus)
			top_level_dialog_imp ?= top_level_window_imp
			if
				top_level_dialog_imp /= Void
			then
				if a_has_focus then
					rad_but ?= Current
					if rad_but = Void then
							-- We do not want radio buttons to affect current push button behavior
						top_level_dialog_imp.set_current_push_button (interface)
					end
				elseif top_level_dialog_imp.internal_current_push_button = interface then
					top_level_dialog_imp.set_current_push_button (Void)
				end
			end
		end

	XXforeground_color_pointer: POINTER is
			-- Pointer to fg color for `Current'.
		do
			TODO_class_line ("__EV_BUTTON_IMP__", "foreground_color_pointer")
			
--			Result := {EV_GTK_EXTERNALS}.gtk_style_struct_text (
--				{EV_GTK_EXTERNALS}.gtk_rc_get_style (text_label)
--			)
		end

feature {EV_ANY_I} -- implementation

	interface: EV_BUTTON
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

invariant
	button_box_not_null: is_usable implies button_box /= NULL

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




end -- class EV_BUTTON_IMP

