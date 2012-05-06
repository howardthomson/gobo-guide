note
	description: "EiffelVision toggle button, gtk implementation."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	id: "$Id: ev_toggle_button_imp.e 56675 2006-01-23 02:25:44Z manus $";
	date: "$Date: 2006-01-22 18:25:44 -0800 (Sun, 22 Jan 2006) $";
	revision: "$Revision: 56675 $"
	
class
	EV_TOGGLE_BUTTON_IMP
	
inherit
	EV_TOGGLE_BUTTON_I
		redefine
			interface
		end
	
	EV_BUTTON_IMP
		redefine
			make,
			interface
		end
	
create
	make

feature {NONE} -- Initialization

	make
			-- Create a gtk toggle button.
		do
--			base_make (an_interface)
--			set_c_object ({EV_GTK_EXTERNALS}.gtk_toggle_button_new)
		end

feature -- Status setting

	enable_select
			-- Set `is_selected' `True'.
		do
			if not is_selected then
--				{EV_GTK_EXTERNALS}.gtk_toggle_button_set_active (visual_widget, True)
			end
		end

	disable_select
				-- Set `is_selected' `False'.
		do
			if is_selected then
--				{EV_GTK_EXTERNALS}.gtk_toggle_button_set_active (visual_widget, False)
			end	
		end

feature -- Status report
	
	is_selected: BOOLEAN
			-- Is toggle button pressed?
		do
--			Result := {EV_GTK_EXTERNALS}.gtk_toggle_button_get_active (visual_widget)
		end 

feature {EV_ANY_I}

	interface: EV_TOGGLE_BUTTON;

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




end -- class EV_TOGGLE_BUTTON_IMP

