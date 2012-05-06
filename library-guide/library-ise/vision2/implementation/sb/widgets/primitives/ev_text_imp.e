note

	description:
		"EiffelVision text area, Slyboots implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	id: "$Id: ev_text_imp.e 65780 2006-12-29 23:13:47Z king $"
	date: "$Date: 2006-12-29 15:13:47 -0800 (Fri, 29 Dec 2006) $"
	revision: "$Revision: 65780 $"

class
	EV_TEXT_IMP

inherit
	EV_TEXT_I
		redefine
			interface,
			text_length,
			selected_text
		end

	EV_TEXT_COMPONENT_IMP
		redefine
			make,
			interface,
			insert_text,
			create_change_actions,
			dispose,
			text_length,
			selected_text
		end

	EV_FONTABLE_IMP
		redefine
			interface
		end

	SB_WINDOW
		rename
			make as make_sb_window,
			show as show_sb,
			hide as hide_sb,
			set_focus as set_focus_sb,
			has_focus as has_focus_sb,
			parent as parent_sb,
			move as move_sb,
			drag_cursor as drag_cursor_sb,
			raise as raise_sb,
			lower as lower_sb,
			x_offset as x_offset_sb,
			y_offset as y_offset_sb,
			flush as flush_sb,
			selected as selected_sb,
			has_selection as has_selection_sb,
			default_width as default_width_sb,
			default_height as default_height_sb
		undefine
			set_minimum_width,
			set_minimum_height
		end

create
	make

feature {NONE} -- Initialization

	create_change_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Hook up the change actions for the text widget
		do
			Result := Precursor {EV_TEXT_COMPONENT_IMP}
		end

	make
			-- Initialize `Current'
		do
--			create {SB_TEXT_FIELD} sb_widget.make_ev
			make_ev
			enable_word_wrapping
			set_editable (True)
			set_background_color ((create {EV_STOCK_COLORS}).white)
			Precursor {EV_TEXT_COMPONENT_IMP}
		end

feature -- Access

	clipboard_content: STRING_32
			-- `Result' is current clipboard content.
		do
			Result := App_implementation.clipboard.text
		end

feature -- Status report

	line_number_from_position (i: INTEGER): INTEGER
			-- Line containing caret position `i'.
		do
			-- TODO
			Result := Result.max (1)
		end

	is_editable: BOOLEAN
			-- Is the text editable by the user?

	has_selection: BOOLEAN
			-- Does `Current' have a selection?
		do
			-- TODO
		end

	selection_start: INTEGER
			-- Index of the first character selected.
		do
			Result := selection_start_internal
		end

	selection_end: INTEGER
			-- Index of the last character selected.
		do
			Result := selection_end_internal
		end

	selected_text: STRING_32
			-- Text currently selected in `Current'.
		local
			a_selected: BOOLEAN
			l_char: POINTER
		do
			-- TODO
		end

feature -- Status setting

	set_editable (flag: BOOLEAN)
			-- if `flag' then make the component read-write.
			-- if not `flag' then make the component read-only.
		do
			is_editable := flag
			-- TODO
		end

	set_caret_position (pos: INTEGER)
			-- set current insertion position
		do
			internal_set_caret_position (pos)
		end

feature -- Basic operation

	select_region (start_pos, end_pos: INTEGER)
			-- Select (hilight) the text between
			-- `start_pos' and `end_pos'. Both `start_pos' and
			-- `end_pos' are selected.
		local
--			a_start_iter, a_end_iter: EV_GTK_TEXT_ITER_STRUCT
		do
--			create a_start_iter.make
--			create a_end_iter.make
--			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_get_iter_at_offset (text_buffer, a_start_iter.item, start_pos - 1)
--			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_get_iter_at_offset (text_buffer, a_end_iter.item, end_pos)
--			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_move_mark (
--										text_buffer,
--										{EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_get_selection_bound (text_buffer),
--										a_start_iter.item
--			)
--			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_move_mark (
--										text_buffer,
--										{EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_get_insert (text_buffer),
--										a_end_iter.item
--			)
		end

	deselect_all
			-- Unselect the current selection.
		local
--			a_iter: EV_GTK_TEXT_ITER_STRUCT
		do
--			create a_iter.make
--			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_get_iter_at_mark (
--											text_buffer,
--											a_iter.item,
--											{EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_get_insert (text_buffer)
--			)
--			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_move_mark (
--										text_buffer,
--										{EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_get_selection_bound (text_buffer),
--										a_iter.item
--			)
		end

	delete_selection
			-- Delete the current selection.
		do
--			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_delete_selection (text_buffer, True, True)
		end

	cut_selection
			-- Cut `selected_region' by erasing it from
			-- the text and putting it in the Clipboard to paste it later.
			-- If `selectd_region' is empty, it does nothing.
		local
			clip_imp: EV_CLIPBOARD_IMP
		do
			if has_selection then
				clip_imp ?= App_implementation.clipboard.implementation
--				{EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_cut_clipboard (text_buffer, clip_imp.clipboard, True)
			end
		end

	copy_selection
			-- Copy `selected_region' into the Clipboard.
			-- If the `selected_region' is empty, it does nothing.
		local
			clip_imp: EV_CLIPBOARD_IMP
		do
			if has_selection then
				clip_imp ?= App_implementation.clipboard.implementation
--				{EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_copy_clipboard (text_buffer, clip_imp.clipboard)
			end
		end

	paste (index: INTEGER)
			-- Insert the contents of the clipboard
			-- at `index' postion of `text'.
			-- If the Clipboard is empty, it does nothing.
		local
			clip_imp: EV_CLIPBOARD_IMP
--			a_iter: EV_GTK_TEXT_ITER_STRUCT
--			a_text: EV_GTK_C_STRING
		do
			clip_imp ?= App_implementation.clipboard.implementation
--			create a_iter.make
--			a_text := clip_imp.text
--			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_get_iter_at_offset (text_buffer, a_iter.item, index - 1)
--			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_insert (text_buffer, a_iter.item, a_text.item, -1)
			a_text.set_with_eiffel_string (once "")
		end

feature -- Access

	text: STRING_32
		do
		end

	line (a_line: INTEGER): STRING_32
			-- Returns the content of line `a_line'.
		do
		end

	first_position_from_line_number (a_line: INTEGER): INTEGER
			-- Position of the first character on line `a_line'.
		do
		end

	last_position_from_line_number (a_line: INTEGER): INTEGER
			-- Position of the last character on line `a_line'.
		do
		end

feature -- Status report

	text_length: INTEGER
			-- Number of characters in `Current'
		do
		end

	line_count: INTEGER
			-- Number of display lines present in widget.
		do
		end

	current_line_number: INTEGER
			-- Returns the number of the display line the cursor currently
			-- is on.
		do
		end

	caret_position: INTEGER
			-- Current position of the caret.
		do
		end

	has_word_wrapping: BOOLEAN
			-- Does `Current' have word wrapping enabled?

feature -- Status setting

	insert_text (a_text: STRING_GENERAL)
		do
		end

	set_text (a_text: STRING_GENERAL)
			-- Set `text' to `a_text'
		do
		end

	append_text (a_text: STRING_GENERAL)
			-- Append `a_text' to `text'.
		do
--			append_text_internal (text_buffer, a_text)
		end

	prepend_text (a_text: STRING_GENERAL)
			-- Prepend 'txt' to `text'.
		do
		end

	delete_text (start, finish: INTEGER)
			-- Delete the text between `start' and `finish' index
			-- both sides include.
		do
		end

feature -- Basic operation

	scroll_to_line (a_line: INTEGER)
			-- Scroll `Current' to line number `a_line'
		do
		end

	scroll_to_end
			-- Scroll to the last line position of `Current'.
		do
		end

	enable_word_wrapping
			-- Enable word wrapping for `Current'
		do
			-- TODO
			has_word_wrapping := True
		end

	disable_word_wrapping
			-- Disable word wrapping for `Current'
		do
			-- TODO
			has_word_wrapping := False
		end

feature {NONE} -- Implementation

	visual_widget: POINTER
			-- Pointer to the GtkWidget representing `Current'
		do
			Result := text_view
		end

	selection_start_internal: INTEGER
			-- Index of the first character selected.
		do
		end

	selection_end_internal: INTEGER
			-- Index of the last character selected.
		do
		end

	dispose
			-- Clean up `Current'
		do
			Precursor {EV_TEXT_COMPONENT_IMP}
		end

	on_change_actions
			-- The text within the widget has changed.
		do
			if change_actions_internal /= Void then
				change_actions_internal.call (Void)
			end
		end

	append_text_internal (a_text_buffer: POINTER; a_text: STRING_GENERAL)
			-- Append `txt' to `text'.
		do
		end

	internal_set_caret_position (pos: INTEGER)
			-- set current insertion position
		do
		end

--	text_view: POINTER
		-- Pointer to the GtkTextView widget

--	scrolled_window: POINTER
		-- Pointer to the GtkScrolledWindow

--	text_buffer: POINTER
			-- Pointer to the GtkTextBuffer.

	needs_event_box: BOOLEAN
		do
		--	Result := True	-- ???
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_TEXT;

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

end -- class EV_TEXT_IMP

