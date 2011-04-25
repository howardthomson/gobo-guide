indexing
	description:
		"Eiffel Vision password field. GTK+ implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2006-01-22 18:25:44 -0800 (Sun, 22 Jan 2006) $"
	revision: "$Revision: 56675 $"

class
	EV_PASSWORD_FIELD_IMP

inherit
	EV_PASSWORD_FIELD_I
		undefine
			hide_border
		redefine
			interface
		end

	EV_TEXT_FIELD_IMP
		redefine
			initialize,
			interface
		end

create
	make

feature {NONE} -- Initialization

	initialize is
			-- Create password field with `*'.
		do
			todo_class_line ("__EV_PASSWORD_FIELD_IMP__", "__LINE__")

			Precursor {EV_TEXT_FIELD_IMP}
--			{EV_GTK_EXTERNALS}.gtk_entry_set_visibility (entry_widget, False)		
		end

feature {NONE} -- Implementation

	interface: EV_PASSWORD_FIELD;

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




end -- class EV_PASSWORD_FIELD_IMP

