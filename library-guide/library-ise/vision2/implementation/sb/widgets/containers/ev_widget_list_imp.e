note

		description: "Eiffel Vision widget list. Slyboots implementation."

	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "widget list, container"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_WIDGET_LIST_IMP

inherit
	EV_WIDGET_LIST_I
		undefine
			propagate_foreground_color,
			propagate_background_color
		redefine
			interface
		end

	EV_CONTAINER_IMP
		undefine
			replace,
			interface_item
		redefine
			make,
			interface
--			initialize
		end

	EV_DYNAMIC_LIST_IMP [EV_WIDGET]
		undefine
			extend,
			initialize
		redefine
			make,
			interface
		end

feature {NONE} -- Initialization

	make is
			-- Initialize `Current'
		do
			Precursor {EV_CONTAINER_IMP}
			Precursor {EV_DYNAMIC_LIST_IMP}
		end

feature {NONE} -- Implementation

	insert_i_th (v: like item; i: INTEGER)
			-- Insert `v' at position `i'.
		local
			v_imp: EV_WIDGET_IMP
		do
print ("EV_WIDGET_LIST_IMP::insert_ith ...%N")
			v_imp ?= v.implementation
			child_array.go_i_th (i)
			child_array.put_left (v)
			on_new_item (v_imp)
print ("EV_WIDGET_LIST_IMP::insert_ith exit ...%N")
		end

	remove_i_th (i: INTEGER) is
			-- Remove item at `i'-th position.
		local
			v_imp: EV_WIDGET_IMP
			a_index: INTEGER
		do
			a_index := index
				-- Store the index in case it is changed as a result of an event on the pass back to gtk
			v_imp ?= i_th (i).implementation
			child_array.go_i_th (i)
			child_array.remove
			on_removed_item (v_imp)
			index := a_index
				-- The call to gtk_container_remove might indirectly fire an event which changes the index so we reset just to make sure
		end

feature {NONE} -- Implementation

	interface: EV_WIDGET_LIST;
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

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

end -- class EV_WIDGET_LIST_IMP

