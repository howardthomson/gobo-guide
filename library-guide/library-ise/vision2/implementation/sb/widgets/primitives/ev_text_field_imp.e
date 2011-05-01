indexing
	description: "EiffelVision text field. Slyboots implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2007-02-01 19:42:46 -0800 (Thu, 01 Feb 2007) $"
	revision: "$Revision: 66438 $"

class
	EV_TEXT_FIELD_IMP

inherit
	EV_TEXT_FIELD_I
		redefine
			interface,
			hide_border
		end

	EV_TEXT_COMPONENT_IMP
		redefine
			interface,
		--	visual_widget,
			create_change_actions,
		--	needs_event_box,
			on_key_event,
			set_minimum_width_in_characters,
			initialize
		end

	EV_FONTABLE_IMP
		redefine
			interface	--,
	--		visual_widget
		end

	EV_TEXT_FIELD_ACTION_SEQUENCES_IMP
		export
			{EV_INTERMEDIARY_ROUTINES}
				return_actions_internal
		redefine
			create_return_actions
		end

create
	make

feature {NONE} -- Initialization

	needs_event_box: BOOLEAN is
			-- Does `a_widget' need an event box?
		do
			Result := True
		end

	make (an_interface: like interface) is
			-- Create a gtk entry.
		local
			a_vbox: POINTER
		do
			base_make (an_interface)
		--	TODO
			set_text (once "")
		end

	initialize
			-- Initialize `Current'.
		do
			align_text_left
			Precursor
		end

feature -- Access

	text: STRING_32 is
			-- Text displayed in field.
		local
	--		a_cs: EV_GTK_C_STRING
		do
	--		create a_cs.share_from_pointer ({EV_GTK_EXTERNALS}.gtk_entry_get_text (entry_widget))
	--		Result := a_cs.string
		end

feature -- Status setting

	set_minimum_width_in_characters (nb: INTEGER) is
			-- Make `nb' characters visible on one line.
		do
	--		{EV_GTK_EXTERNALS}.gtk_widget_set_minimum_size (entry_widget, (nb + 1) * maximum_character_width, -1)
		end

	set_text (a_text: STRING_GENERAL) is
			-- Assign `a_text' to `text'.
		do
			-- TODO
			on_change_actions
		end

	append_text (a_text: STRING_GENERAL) is
			-- Append `a_text' to the end of the text.
		do
		--	TODO
			on_change_actions
		end

	prepend_text (a_text: STRING_GENERAL) is
			-- Prepend `a_text' to the end of the text.
		do
		--	TODO	
			on_change_actions
		end

	set_capacity (len: INTEGER) is
			-- Set the maximum number of characters that `Current' can hold to `len'.
		do
	--		{EV_GTK_DEPENDENT_EXTERNALS}.gtk_entry_set_max_length (entry_widget, len)
		end

	align_text_left
			-- Make text left aligned.
		do
			text_alignment := {EV_TEXT_ALIGNMENT_CONSTANTS}.ev_text_alignment_left
	--		{EV_GTK_EXTERNALS}.gtk_entry_set_alignment (entry_widget, 0.0)
		end

	align_text_right
			-- Make text right aligned.
		do
			text_alignment := {EV_TEXT_ALIGNMENT_CONSTANTS}.ev_text_alignment_right
--			{EV_GTK_EXTERNALS}.gtk_entry_set_alignment (entry_widget, 1.0)
		end

	align_text_center
			-- Make text center aligned.
		do
			text_alignment := {EV_TEXT_ALIGNMENT_CONSTANTS}.ev_text_alignment_center
	--		{EV_GTK_EXTERNALS}.gtk_entry_set_alignment (entry_widget, 0.5)
		end

feature -- Status Report

	text_alignment: INTEGER
		-- Text alignment of `Current'.

	caret_position: INTEGER is
			-- Current position of the caret.
		do
	--		Result := {EV_GTK_EXTERNALS}.gtk_editable_get_position (entry_widget) + 1
		end

	capacity: INTEGER is
			-- Return the maximum number of characters that the
			-- user may enter.
		do
	--		Result := {EV_GTK_EXTERNALS}.gtk_entry_struct_text_max_length (entry_widget)
		end

feature {EV_ANY_I, EV_INTERMEDIARY_ROUTINES} -- Implementation

	on_key_event (a_key: EV_KEY; a_key_string: STRING_32; a_key_press: BOOLEAN)
		do
			Precursor (a_key, a_key_string, a_key_press)
			if a_key_press then
				on_change_actions
			end
		end

	create_return_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Create an initialize return actions for `Current'.
		do
			create Result
	--		real_signal_connect_after (entry_widget, once "activate", agent (App_implementation.gtk_marshal).text_field_return_intermediary (c_object), Void)
		end

feature -- Status report

	is_editable: BOOLEAN is
			-- Is the text editable.
		do
	--		Result := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_editable_get_editable (entry_widget)
		end

	has_selection: BOOLEAN is
			-- Is something selected?
		local
			a_start, a_end: INTEGER
		do
	--		Result := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_editable_get_selection_bounds (entry_widget, $a_start, $a_end)
		end

	selection_start: INTEGER is
			-- Index of the first character selected.
		local
			a_start, a_end: INTEGER
			has_sel: BOOLEAN
		do
	--		has_sel := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_editable_get_selection_bounds (entry_widget, $a_start, $a_end)
			Result := a_start + 1
		end

	selection_end: INTEGER is
			-- Index of the last character selected.
		local
			a_start, a_end: INTEGER
			has_sel: BOOLEAN
		do
	--		has_sel := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_editable_get_selection_bounds (entry_widget, $a_start, $a_end)
			Result := a_end
		end

	clipboard_content: STRING_32 is
			-- `Result' is current clipboard content.
		do
			Result := App_implementation.clipboard.text
		end

feature -- status settings

	hide_border is
			-- Hide the border of `Current'.
		do
	--		{EV_GTK_DEPENDENT_EXTERNALS}.gtk_entry_set_has_frame (entry_widget, False)
		end

	set_editable (a_editable: BOOLEAN) is
			-- Set editable state to `a_editable'.
		do
	--		{EV_GTK_EXTERNALS}.gtk_editable_set_editable (entry_widget, a_editable)
		end

	set_caret_position (pos: INTEGER) is
			-- Set the position of the caret to `pos'.
		do
	--		{EV_GTK_EXTERNALS}.gtk_editable_set_position (entry_widget, pos - 1)
		end

feature -- Basic operation

	insert_text (txt: STRING_GENERAL) is
			-- Insert `txt' at the current position.
		do
			insert_text_at_position (txt, caret_position)
			on_change_actions
		end

	insert_text_at_position (txt: STRING_GENERAL; a_pos: INTEGER) is
			-- Insert `txt' at the current position at position `a_pos'
		local
	--		a_cs: EV_GTK_C_STRING
			pos: INTEGER
		do
			pos := a_pos - 1
			a_cs := txt
	--		{EV_GTK_EXTERNALS}.gtk_editable_insert_text (
	--			entry_widget,
	--			a_cs.item,
	--			txt.count,
	--			$pos
	--		)
		end

	select_region (start_pos, end_pos: INTEGER) is
			-- Select (highlight) the text between
			-- 'start_pos' and 'end_pos'.
		do
	--		{EV_GTK_EXTERNALS}.gtk_editable_select_region (entry_widget, start_pos.min (end_pos) - 1, end_pos.max (start_pos))
		end

	deselect_all is
			-- Unselect the current selection.
		do
	--		{EV_GTK_EXTERNALS}.gtk_editable_select_region (entry_widget, 0, 0)
		end

	delete_selection is
			-- Delete the current selection.
		do
	--		{EV_GTK_EXTERNALS}.gtk_editable_delete_selection (entry_widget)
			on_change_actions
		end

	cut_selection is
			-- Cut the `selected_region' by erasing it from
			-- the text and putting it in the Clipboard
			-- to paste it later.
			-- If the `selected_region' is empty, it does
			-- nothing.
		do
	--		{EV_GTK_EXTERNALS}.gtk_editable_cut_clipboard (entry_widget)
			on_change_actions
		end

	copy_selection is
			-- Copy the `selected_region' in the Clipboard
			-- to paste it later.
			-- If the `selected_region' is empty, it does
			-- nothing.
		do
	--		{EV_GTK_EXTERNALS}.gtk_editable_copy_clipboard (entry_widget)
		end

	paste (index: INTEGER) is
			-- Insert the string which is in the
			-- Clipboard at the `index' position in the
			-- text.
			-- If the Clipboard is empty, it does nothing.
		do
			insert_text_at_position (clipboard_content, index)
			on_change_actions
		end

feature {EV_ANY_I, EV_INTERMEDIARY_ROUTINES} -- Implementation

	create_change_actions: EV_NOTIFY_ACTION_SEQUENCE is
		do
			create Result
		end

	stored_text: STRING_32
			-- Value of 'text' prior to a change action, used to compare
			-- between old and new text.

	on_change_actions is
			-- A change action has occurred.
		local
			new_text: STRING_32
		do
			new_text := text
			if not in_change_action and then (stored_text /= Void and then not new_text.is_equal (stored_text)) or else stored_text = Void then
					-- The text has actually changed
				in_change_action := True
				if change_actions_internal /= Void then
					change_actions_internal.call (Void)
				end
				in_change_action := False
				stored_text := text
			end

		end

	in_change_action: BOOLEAN
		-- Is `Current' in the process of calling `on_change_actions'

feature {NONE} -- Implementation

	entry_widget: POINTER
		-- A pointer on the text field

	visual_widget: POINTER is
			-- Pointer to the widget shown on screen.
		do
			Result := entry_widget
		end

feature {EV_TEXT_FIELD_I} -- Implementation

	interface: EV_TEXT_FIELD;
			--Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

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




end -- class EV_TEXT_FIELD_IMP
