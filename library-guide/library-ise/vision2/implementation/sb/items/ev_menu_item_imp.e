indexing
	description: "Eiffel Vision menu item. GTK+ implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2006-11-09 14:46:06 -0800 (Thu, 09 Nov 2006) $"
	revision: "$Revision: 64944 $"

	sb_todo: "[
		implement:
			make
			initialize
			on_activate
	]"

class
	EV_MENU_ITEM_IMP

inherit
	EV_MENU_ITEM_I
		redefine
			interface
		end

	EV_ITEM_IMP
		redefine
			make,
			interface,
--			initialize
		end

	EV_SENSITIVE_IMP
		redefine
			interface
		end

	EV_TEXTABLE_IMP
		redefine
			interface,
			set_text,
			accelerators_enabled
		end

	EV_MENU_ITEM_ACTION_SEQUENCES_IMP

create
	make

feature {NONE} -- Initialization

	is_dockable: BOOLEAN is False

--	old_make (an_interface: like interface) is
--			-- Create a menu.
--		do
--			assign_interface (an_interface)
--			set_c_object ({EV_GTK_DEPENDENT_EXTERNALS}.gtk_image_menu_item_new)
--			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_image_menu_item_set_image (c_object, pixmap_box)
--		end

	make is
			-- Initialize `Current'
		do
--			Precursor {EV_ITEM_IMP}

			pixmapable_imp_initialize
			textable_imp_initialize


--			if pixmap_box = default_pointer then
--				pixmapable_imp_initialize
--				{EV_GTK_EXTERNALS}.gtk_box_pack_start (box, pixmap_box, False, True, 0)
--			end
		end

feature -- Element change

	set_text (a_text: STRING_GENERAL) is
			-- Assign `a_text' to `text'.
		local
--			tab_mod: INTEGER
		do
--			tab_mod := temp_string.count \\ 8
--			if tab_mod < 4 then
--				temp_string.replace_substring_all ("%T", "%T%T%T")
--			else
--				temp_string.replace_substring_all ("%T", "%T%T")
--			end
			Precursor {EV_TEXTABLE_IMP} (a_text)
		end

feature {EV_ANY_I, EV_INTERMEDIARY_ROUTINES} -- Implementation

	accelerators_enabled: BOOLEAN is True

	on_activate is
		local
			p_imp: EV_MENU_ITEM_LIST_IMP
		do
			p_imp ?= parent_imp
			if p_imp /= Void then
				if p_imp.item_select_actions_internal /= Void then
					p_imp.item_select_actions_internal.call ([interface])
				end
--				{EV_GTK_EXTERNALS}.gtk_menu_shell_deactivate (p_imp.list_widget)
			end
--			{EV_GTK_EXTERNALS}.gtk_menu_item_deselect (c_object)
			if select_actions_internal /= Void then
				select_actions_internal.call (Void)
			end
		end

	interface: EV_MENU_ITEM;

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

end -- class EV_MENU_ITEM_IMP

