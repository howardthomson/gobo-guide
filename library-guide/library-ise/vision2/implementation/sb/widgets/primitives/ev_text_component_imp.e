indexing

	description:
		"EiffelVision text component, gtk implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	id: "$Id: ev_text_component_imp.e 65793 2007-01-05 01:20:35Z king $"
	date: "$Date: 2007-01-04 17:20:35 -0800 (Thu, 04 Jan 2007) $"
	revision: "$Revision: 65793 $"

deferred class
	EV_TEXT_COMPONENT_IMP

inherit
	EV_TEXT_COMPONENT_I
		redefine
			interface
		end

	EV_PRIMITIVE_IMP
		redefine
			interface,
			initialize
		end

	EV_TEXT_COMPONENT_ACTION_SEQUENCES_IMP
		export
			{EV_INTERMEDIARY_ROUTINES} change_actions_internal
		end

feature -- Initialization

	initialize is
			-- Initialize `Current'.
		do
			set_minimum_width_in_characters (4)
				-- Set default width to 4 characters, as on Windows.
			Precursor {EV_PRIMITIVE_IMP}
		end

feature {EV_INTERMEDIARY_ROUTINES} -- Implementation

	on_change_actions is
			-- The text has been changed by the user.
		deferred
		end

feature -- Resizing

	set_minimum_width_in_characters (nb: INTEGER) is
			-- Make `nb' characters visible on one line.
		do
			set_minimum_width (nb * maximum_character_width)
				-- 10 = size of handle
		end

	maximum_character_width: INTEGER is
			-- Maximum width of a single character in `Current'.
		do
			Result := font.string_width (once "W")
		end

	font: EV_FONT is
			-- Current font displayed by widget. (This can be removed if text component is made fontable)
		deferred
		end

feature {NONE} -- Implementation

--	foreground_color_pointer: POINTER is
--			-- Pointer to fg color for `a_widget'.
--		do
--			Result := {EV_GTK_EXTERNALS}.gtk_style_struct_text (
--				{EV_GTK_EXTERNALS}.gtk_rc_get_style (visual_widget)
--			)
--		end

feature {EV_ANY_I} -- Implementation		

	interface: EV_TEXT_COMPONENT;

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




end -- class EV_TEXT_COMPONENT_IMP
