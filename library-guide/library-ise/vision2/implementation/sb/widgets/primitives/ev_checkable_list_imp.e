note
	description: "Eiffel Vision checkable list. Gtk implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2006-01-22 18:25:44 -0800 (Sun, 22 Jan 2006) $"
	revision: "$Revision: 56675 $"


class
	EV_CHECKABLE_LIST_IMP
	
inherit
	EV_CHECKABLE_LIST_I
		undefine
			wipe_out,
			selected_items,
			call_pebble_function,
			disable_default_key_processing
		redefine
			interface
		end
	
	EV_LIST_IMP
		redefine
			interface,
			initialize,
			initialize_model
		end
		
	EV_CHECKABLE_LIST_ACTION_SEQUENCES_IMP
	
create
	make

feature -- Initialization

	initialize
			-- Setup `Current'
		do
			Precursor {EV_LIST_IMP}
			TODO_class_line ("EV_CHECKABLE_LIST_IMP", "__LINE__")
		end

	boolean_tree_model_column: INTEGER = 2

	on_tree_path_toggle (a_tree_path_str: POINTER)
			-- 
		local
			a_tree_path, a_int_ptr: POINTER
			a_tree_iter: EV_GTK_TREE_ITER_STRUCT
			a_success: BOOLEAN
			mp: MANAGED_POINTER
			a_list_item: EV_LIST_ITEM
			a_selected: BOOLEAN
			a_gvalue: POINTER
		do
			create a_tree_iter.make
			a_tree_path := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_path_new_from_string (a_tree_path_str)
			a_success := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_model_get_iter (list_store, a_tree_iter.item, a_tree_path)
			if a_success then
				a_int_ptr := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_path_get_indices (a_tree_path)
				create mp.share_from_pointer (a_int_ptr, App_implementation.integer_bytes)
				a_list_item := child_array @ (mp.read_integer_32 (0) + 1)
				a_gvalue := {EV_GTK_DEPENDENT_EXTERNALS}.c_g_value_struct_allocate
				{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_model_get_value (list_store, a_tree_iter.item, boolean_tree_model_column,  a_gvalue)
				a_selected := {EV_GTK_DEPENDENT_EXTERNALS}.g_value_get_boolean (a_gvalue)
					-- Toggle the currently selected value
				{EV_GTK_DEPENDENT_EXTERNALS}.g_value_set_boolean (a_gvalue, not a_selected)
				{EV_GTK_DEPENDENT_EXTERNALS}.gtk_list_store_set_value (list_store, a_tree_iter.item, boolean_tree_model_column,  a_gvalue)
				
				if a_selected then
						-- We are toggling so `a_selected' is status before toggle
					if uncheck_actions_internal /= Void then
						uncheck_actions_internal.call ([a_list_item])
					end
				else
					if check_actions_internal /= Void then
						check_actions_internal.call ([a_list_item])
					end
				end
				
				a_gvalue.memory_free
			end
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_path_free (a_tree_path)
		end

	initialize_model
			-- Create our data model for `Current'
		do
			TODO_class_line ("EV_CHECKABLE_LIST_IMP", "__LINE__")
		end

feature -- Access

	is_item_checked (list_item: EV_LIST_ITEM): BOOLEAN
			--
		local
			item_imp: EV_LIST_ITEM_IMP
		do
			item_imp ?= list_item.implementation

			TODO_class_line ("EV_CHECKABLE_LIST_IMP", "__LINE__")
						
		end

feature -- Status setting

	check_item (list_item: EV_LIST_ITEM)
			-- Ensure check associated with `list_item' is
			-- checked.
		local
			item_imp: EV_LIST_ITEM_IMP
		do
			item_imp ?= list_item.implementation

			TODO_class_line ("EV_CHECKABLE_LIST_IMP", "__LINE__")

			if check_actions_internal /= Void then
				check_actions_internal.call ([list_item])
			end
		end

	uncheck_item (list_item: EV_LIST_ITEM)
			-- Ensure check associated with `list_item' is
			-- checked.
		local
			item_imp: EV_LIST_ITEM_IMP
		do
			item_imp ?= list_item.implementation

			TODO_class_line ("EV_CHECKABLE_LIST_IMP", "__LINE__")

			if uncheck_actions_internal /= Void then
				uncheck_actions_internal.call ([list_item])
			end
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_CHECKABLE_LIST;
	
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




end -- class EV_CHECKABLE_LIST_IMP

