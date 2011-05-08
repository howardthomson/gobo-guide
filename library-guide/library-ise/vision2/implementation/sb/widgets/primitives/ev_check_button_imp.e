note

		description: "EiffelVision check button, Slyboots implementation."

	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	id: "$Id: ev_check_button_imp.e 57641 2006-03-23 07:29:03Z manus $";
	date: "$Date$";
	revision: "$Revision"
	
class
	EV_CHECK_BUTTON_IMP

inherit
	EV_CHECK_BUTTON_I
		redefine
			interface
		end
	
	EV_TOGGLE_BUTTON_IMP
		undefine
			default_alignment
		redefine
			make,
			set_text,
			interface
		end

create
	make

feature {NONE} -- Initialization
		
	make is
			-- Initialize 'Current'
		do
--			Precursor {EV_TOGGLE_BUTTON_IMP}
			align_text_left
		end

feature -- Element change

	set_text (txt: STRING_GENERAL) is
			-- Set current button text to `txt'.
			-- Redefined because we want the text to be left-aligned.
		do
			Precursor {EV_TOGGLE_BUTTON_IMP} (txt)
			TODO_class_line ("EV_CHECK_BUTTON_IMP::set_text", "__LINE__")
		end

feature {EV_ANY_I}

	interface: EV_CHECK_BUTTON;
	
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




end -- class EV_CHECK_BUTTON_IMP

