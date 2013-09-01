note
	description:
		"Eiffel Vision textable. Slyboots implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2007-03-16 18:03:51 -0800 (Fri, 16 Mar 2007) $"
	revision: "$Revision: 67351 $"

deferred class
	EV_TEXTABLE_IMP

inherit
	EV_TEXTABLE_I
		redefine
			interface
		end

feature {NONE} -- Initialization

	textable_imp_initialize
			-- Create a GtkLabel to display the text.
		do
			create text_label.make_ev
			text_label.show
--#			{EV_GTK_EXTERNALS}.gtk_misc_set_alignment (text_label, 0.0, 0.5)
--#			{EV_GTK_EXTERNALS}.gtk_misc_set_padding (text_label, 2, 0)
		end

feature -- Access

	text: STRING_32
			-- Text of the label.
		local
			l_str: STRING_32
		do
			if real_text /= Void then
				Result := real_text
			else
				l_str := text_label.label
				if l_str /= Void then
					Result := l_str
				else
					Result := ""
				end
			end
		end

	text_alignment: INTEGER
			-- Alignment of the text in the label.
		local
			an_alignment_code: INTEGER
		do
			Result := text_alignment_internal

			check
				        Result = {EV_TEXT_ALIGNMENT_CONSTANTS}.Ev_text_alignment_center
				or else Result = {EV_TEXT_ALIGNMENT_CONSTANTS}.Ev_text_alignment_left
				or else Result = {EV_TEXT_ALIGNMENT_CONSTANTS}.Ev_text_alignment_right
			end
		end

feature {NONE} -- Internal status

	text_alignment_internal: INTEGER

feature -- Status setting

	align_text_center
			-- Display `text' centered.
		do
			text_alignment_internal := {EV_TEXT_ALIGNMENT_CONSTANTS}.Ev_text_alignment_center
--			check false end
--#			{EV_GTK_EXTERNALS}.gtk_misc_set_alignment (text_label, 0.5, 0.5)
--#			{EV_GTK_EXTERNALS}.gtk_label_set_justify (text_label, {EV_GTK_EXTERNALS}.gtk_justify_center_enum)
		end

	align_text_left
			-- Display `text' left aligned.
		do
			text_alignment_internal := {EV_TEXT_ALIGNMENT_CONSTANTS}.Ev_text_alignment_left
--			check false end
--#			{EV_GTK_EXTERNALS}.gtk_misc_set_alignment (text_label, 0, 0.5)
--#			{EV_GTK_EXTERNALS}.gtk_label_set_justify (text_label, {EV_GTK_EXTERNALS}.gtk_justify_left_enum)
		end

	align_text_right
			-- Display `text' right aligned.
		do
			text_alignment_internal := {EV_TEXT_ALIGNMENT_CONSTANTS}.Ev_text_alignment_right
--			check false end
--#			{EV_GTK_EXTERNALS}.gtk_misc_set_alignment (text_label, 1, 0.5)
--#			{EV_GTK_EXTERNALS}.gtk_label_set_justify (text_label, {EV_GTK_EXTERNALS}.gtk_justify_right_enum)
		end

feature -- Element change	

	set_text (a_text: STRING_GENERAL)
			-- Assign `a_text' to `text'.
		local
			l_str: STRING
		do
			if accelerators_enabled then
				real_text := a_text
				l_str := u_lined_filter (a_text)
		--		text_label.set_text (a_text)
			else
				real_text := Void
		--		text_label.set_text (a_text)
			end
		end

feature {EV_ANY_IMP} -- Implementation

	app_implementation: EV_APPLICATION_IMP
		deferred
		end

	text_label: SB_LABEL
			-- Slyboots Label containing `text'.

	accelerators_enabled: BOOLEAN
			-- Does `Current' have keyboard accelerators enabled?
		do
			Result := False
		end

	real_text: STRING_32
			-- Internal `text'. (with ampersands)

	filter_ampersand (s: STRING_32; char: CHARACTER)
			-- Replace occurrences of '&' from `s'  by `char' and
			-- replace occurrences of "&&" with '&'.
		require
			s_not_void: s /= Void
			s_has_at_least_one_ampersand: s.occurrences ('&') > 0
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i > s.count
			loop
				if s.item (i) = '&' then
					if s.item (i + 1) /= '&' then
						s.put (char, i)
					else
						i := i + 1
					end
				end
				i := i + 1
			end
			s.replace_substring_all (once "&&", once "&")
		end

	u_lined_filter (s: STRING_GENERAL): STRING_32
			-- Copy of `s' with underscores instead of ampersands.
			-- (If `s' does not contain ampersands, return `s'.)
		require
			s_not_void: s /= Void
		do
			Result := s.twin
			Result.replace_substring_all (once  "_", once  "__")
			if s.has_code (('&').natural_32_code) then
				filter_ampersand (Result, '_')
			end
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_TEXTABLE

invariant
	text_label_not_void: is_usable implies text_label /= Void

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




end -- class EV_TEXTABLE_IMP

