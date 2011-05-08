indexing
	description: "EiffelVision item, Slyboots implementation"
	legal: "See notice at end of class.";
	status: "See notice at end of class."
	date: "$Date: 2007-03-22 16:17:43 -0800 (Thu, 22 Mar 2007) $";
	revision: "$Revision: 67481 $"


	sb_todo: "[
		implement:
			call_button_event_actions
	]"

deferred class
	EV_ITEM_IMP

inherit
	EV_ITEM_I
		redefine
			interface
		end

	EV_PICK_AND_DROPABLE_IMP
		redefine
			interface,
			destroy
		end

	EV_PIXMAPABLE_IMP
		redefine
			interface
		end

	EV_ITEM_ACTION_SEQUENCES_IMP

feature {NONE} -- Initialization

--	old_make (an_interface: like interface)
--		do
--		end

	call_button_event_actions (
			a_type: INTEGER;
			a_x, a_y, a_button: INTEGER;
			a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
			a_screen_x, a_screen_y: INTEGER)
		is
			-- Call pointer_button_press_actions or pointer_double_press_actions
			-- depending on event type in first position of `event_data'.
		local
			t : TUPLE [INTEGER, INTEGER, INTEGER, DOUBLE, DOUBLE, DOUBLE,
				INTEGER, INTEGER]
		do
			t := [a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure,
				a_screen_x, a_screen_y]
--			if a_type = {EV_GTK_EXTERNALS}.gDK_BUTTON_PRESS_ENUM then
				if pointer_button_press_actions_internal /= Void then
					pointer_button_press_actions_internal.call (t)
				end
--			else -- a_type = {EV_GTK_EXTERNALS}.gDK_2BUTTON_PRESS_ENUM
				if pointer_double_press_actions_internal /= Void then
					pointer_double_press_actions_internal.call (t)
				end
--			end
        end

feature -- Access

	parent_imp: EV_ITEM_LIST_IMP [EV_ITEM] is
			-- The parent of the Current widget
			-- May be void.
		do
			Result := item_parent_imp
		end

feature {EV_ANY_I} -- Implementation

	destroy is
			-- Destroy `Current'
		do
			if parent_imp /= Void then
					parent_imp.interface.prune (interface)
			end
			Precursor {EV_PICK_AND_DROPABLE_IMP}
		end

	item_parent_imp: EV_ITEM_LIST_IMP [EV_ITEM]
		-- Used to store parent imp of items where parent stores
		-- items in a list widget instead of the c_object.

	set_item_parent_imp (a_parent: EV_ITEM_LIST_IMP [EV_ITEM]) is
			-- Set `item_parent_imp' to `a_parent'.
		do
			item_parent_imp := a_parent
print ("EV_ITEM_IMP::set_item_parent_imp called ...%N")
		end

feature {EV_ANY_I} -- Implementation

	update_for_pick_and_drop (starting: BOOLEAN)
			-- Pick and drop status has changed so update appearance of
			-- `Current' to reflect available targets.
		do
			-- Redefined by descendents.
		end

	interface: EV_ITEM;

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




end -- class EV_ITEM_IMP

