indexing
	description: "Eiffel Vision menu. SLyboots implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2006-09-28 15:05:06 -0700 (Thu, 28 Sep 2006) $"
	revision: "$Revision: 63964 $"

class
	EV_MENU_IMP

inherit
	EV_MENU_I
		redefine
			interface
		end

	EV_MENU_ITEM_IMP
		undefine
			parent
		redefine
			make,
			interface,
			initialize,
			on_activate,
			destroy,
			show
		end

	EV_MENU_ITEM_LIST_IMP
		redefine
			make,
			interface,
			initialize,
			destroy
		end

create
	make

feature {EV_SB_WIDGET_IMP} -- Attributes

	sb_menu: SB_MENU_TITLE

feature {NONE} -- Initialization

	make
		do
print ("EV_MENU_IMP::make ...%N")
		end

	initialize is
		do
print ("EV_MENU_IMP::initialize ...%N")
			TODO_class_line ("EV_MENU_IMP", "#1")
			Precursor {EV_MENU_ITEM_LIST_IMP}
			Precursor {EV_MENU_ITEM_IMP}
		end

feature -- Basic operations

	show is
			-- Pop up on the current pointer position.
		local
			pc: EV_COORDINATE
			bw: INTEGER
		do
			pc := (create {EV_SCREEN}).pointer_position
--			bw := {EV_GTK_EXTERNALS}.gtk_container_struct_border_width (list_widget)
--			if not interface.is_empty then
--				app_implementation.do_once_on_idle (agent c_gtk_menu_popup (list_widget, pc.x + bw, pc.y + bw, 0, {EV_GTK_EXTERNALS}.gtk_get_current_event_time))
--			end
		end

	show_at (a_widget: EV_WIDGET; a_x, a_y: INTEGER) is
			-- Pop up on `a_x', `a_y' relative to the top-left corner of `a_widget'.
		do
--			if not interface.is_empty then
--				app_implementation.do_once_on_idle (agent c_gtk_menu_popup (list_widget,
--					a_widget.screen_x + a_x,
--					a_widget.screen_y + a_y, 0, {EV_GTK_EXTERNALS}.gtk_get_current_event_time)
--				)
--			end
		end

feature {EV_ANY_I} -- Implementation

	on_activate is
		local
			p_imp: EV_MENU_ITEM_LIST_IMP
		do
			p_imp ?= parent_imp
			if p_imp /= Void then
				if p_imp.item_select_actions_internal /= Void then
					p_imp.item_select_actions_internal.call ([interface])
				end
			end
			if select_actions_internal /= Void then
				select_actions_internal.call (Void)
			end
		end

	interface: EV_MENU

feature {NONE} -- Implementation

	destroy is
			-- Destroy the menu
		do
			interface.wipe_out
			Precursor {EV_MENU_ITEM_IMP}
		end

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

end -- class EV_MENU_IMP

