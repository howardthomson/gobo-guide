indexing
	description:
		"EiffelVision Tree, Slyboots implementation"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	EV_TREE_IMP

inherit
	EV_TREE_I
		redefine
			interface,
			initialize,
			call_pebble_function,
			append
		end

	EV_PRIMITIVE_IMP
		redefine
			sb_widget,
			interface,
			initialize,
			call_button_event_actions,
			create_pointer_motion_actions,
			set_to_drag_and_drop,
			able_to_transport,
			ready_for_pnd_menu,
			disable_transport,
			on_mouse_button_event,
			pre_pick_steps,
			post_drop_steps,
			call_pebble_function,
			on_pointer_motion
		end

	EV_ITEM_LIST_IMP [EV_TREE_NODE]
		redefine
			interface,
			insert_i_th,
			remove_i_th,
			append,
			initialize
		end

	EV_TREE_ACTION_SEQUENCES_IMP

	EV_PND_DEFERRED_ITEM_PARENT
		redefine
			call_selection_action_sequences
		end

create
	make

feature {EV_SB_WIDGET_IMP, EV_TREE_NODE_IMP} -- Implementation Attributes

	sb_widget: SB_TREE_LIST

feature {NONE} -- Initialization

	needs_event_box: BOOLEAN is
			-- Does `a_widget' need an event box?
		do
			Result := True
		end

	make (an_interface: like interface) is
			-- Create an empty Tree.
		do
			base_make (an_interface)
			create {SB_TREE_LIST} sb_widget.make_ev
		end

	call_selection_action_sequences is
			-- Call the appropriate selection action sequences
		local
			a_selected_item: EV_TREE_NODE
			a_selected_item_imp: EV_TREE_NODE_IMP
			previous_selected_item_imp: EV_TREE_NODE_IMP
		do
			a_selected_item := selected_item

			if a_selected_item /= previous_selected_item then
				if previous_selected_item /= Void then
					previous_selected_item_imp ?= previous_selected_item.implementation
					if previous_selected_item_imp.deselect_actions_internal /= Void then
						previous_selected_item_imp.deselect_actions_internal.call (Void)
					end
					if deselect_actions_internal /= Void then
						deselect_actions_internal.call (Void)
					end
				end
				if a_selected_item /= Void then
					a_selected_item_imp ?= a_selected_item.implementation
					if a_selected_item_imp.select_actions_internal /= Void then
						a_selected_item_imp.select_actions_internal.call (Void)
					end
					if select_actions_internal /= Void then
						select_actions_internal.call (Void)
					end
				end
			end
			previous_selected_item := a_selected_item
		end

	initialize is
			-- 
		do
			Precursor {EV_ITEM_LIST_IMP}
			Precursor {EV_PRIMITIVE_IMP}
			Precursor {EV_TREE_I}

			-- TODO
			initialize_pixmaps
		end

	create_pointer_motion_actions: EV_POINTER_MOTION_ACTION_SEQUENCE is
			-- Create a pointer_motion action sequence.
		do
			create Result
		end

	call_button_event_actions (
			a_type: INTEGER;
			a_x, a_y, a_button: INTEGER;
			a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
			a_screen_x, a_screen_y: INTEGER)
		is
		local
			t : TUPLE [INTEGER, INTEGER, INTEGER, DOUBLE, DOUBLE, DOUBLE,
				INTEGER, INTEGER]
			tree_item_imp: EV_TREE_NODE_IMP
			a_expander_size, a_horizontal_separator: INTEGER
			a_success: BOOLEAN
			a_tree_path, a_tree_column: POINTER
			a_depth: INTEGER
			avoid_item_events: BOOLEAN
			a_gdkwin, a_gtkwid: POINTER
			l_x, l_y: INTEGER
		do
			Precursor {EV_PRIMITIVE_IMP} (a_type, a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y)

			-- TODO
		end

	on_pointer_motion (a_motion_tuple: TUPLE [INTEGER, INTEGER, DOUBLE, DOUBLE, DOUBLE, INTEGER, INTEGER]) is
		local
			a_row_imp: EV_TREE_NODE_IMP
		do
			Precursor (a_motion_tuple)
			if not app_implementation.is_in_transport and then a_motion_tuple.integer_item (2) > 0 and a_motion_tuple.integer_item (1) <= width then
				a_row_imp := item_from_coords (a_motion_tuple.integer_item (1), a_motion_tuple.integer_item (2))
				if a_row_imp /= Void then
					if a_row_imp.pointer_motion_actions_internal /= Void then
						a_row_imp.pointer_motion_actions_internal.call (a_motion_tuple)
					end
				end
			end
		end

feature -- Status report

	selected_item: EV_TREE_NODE is
			-- Item which is currently selected
		local
			a_selection: POINTER
			a_tree_path_list: POINTER
			a_model: POINTER
			a_tree_path: POINTER
			a_tree_node_imp: EV_TREE_NODE_IMP
		do
			a_selection := {EV_GTK_EXTERNALS}.gtk_tree_view_get_selection (tree_view)
			a_tree_path_list := {EV_GTK_EXTERNALS}.gtk_tree_selection_get_selected_rows (a_selection, $a_model)

			if a_tree_path_list /= NULL then
					a_tree_path := {EV_GTK_EXTERNALS}.glist_struct_data (a_tree_path_list)
					a_tree_node_imp := node_from_tree_path (a_tree_path)
					{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_path_list_free_contents (a_tree_path_list)
					{EV_GTK_EXTERNALS}.g_list_free (a_tree_path_list)
					Result := a_tree_node_imp.interface
			end
		end

	XXnode_from_tree_path (a_tree_path: POINTER): EV_TREE_NODE_IMP is
			-- Retrieve node from `a_tree_path'
		local
			i, a_depth: INTEGER
			a_tree_node: EV_TREE_NODE
		do
--			a_depth := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_path_get_depth (a_tree_path)
--			from
--				create mp.share_from_pointer (a_int_ptr, App_implementation.integer_bytes * a_depth)
--				a_tree_node := i_th (mp.read_integer_32 (0) + 1)
--				i := 1
--			until
--				i = a_depth
--			loop
--				a_tree_node := a_tree_node.i_th (mp.read_integer_32 (i * App_implementation.integer_bytes) + 1)
--				i := i + 1
--			end
--			Result ?= a_tree_node.implementation
		end

	selected: BOOLEAN is
			-- Is one item selected?
		do
			Result := selected_item /= Void
		end

feature -- Implementation

	ensure_item_visible (an_item: EV_TREE_NODE) is
			-- Ensure `an_item' is visible in `Current'.
			-- Tree nodes may be expanded to achieve this.
		local
			tree_item_imp: EV_TREE_NODE_IMP
			a_path: POINTER
		do
			tree_item_imp ?= an_item.implementation
	--		a_path := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_model_get_path (tree_store, tree_item_imp.list_iter.item)
	--		{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_scroll_to_cell (tree_view, a_path, NULL, False, 0, 0)
	--		{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_path_free (a_path)
		end

	set_to_drag_and_drop: BOOLEAN is
		do
			if pnd_row_imp /= Void then
				Result := pnd_row_imp.mode_is_drag_and_drop
			else
				Result := mode_is_drag_and_drop
			end
		end

	able_to_transport (a_button: INTEGER): BOOLEAN is
			-- Is list or row able to transport PND data using `a_button'.
		do
			if pnd_row_imp /= Void then
				Result := pnd_row_imp.able_to_transport (a_button)
			else
				Result := Precursor (a_button)
			end
		end

	ready_for_pnd_menu (a_button, a_type: INTEGER): BOOLEAN is
			-- Is list or row able to display PND menu using `a_button'
		do
			if a_button = 3 and then a_type = {EV_GTK_EXTERNALS}.gdk_button_release_enum then
				if pnd_row_imp /= Void then
					Result := pnd_row_imp.mode_is_target_menu or else pnd_row_imp.mode_is_configurable_target_menu
				else
					Result := mode_is_target_menu or else mode_is_configurable_target_menu
				end
			end
		end

	disable_transport is
		do
			Precursor
			update_pnd_status
		end

	update_pnd_status is
			-- Update PND status of list and its children.
		local
			a_enable_flag: BOOLEAN
			i: INTEGER
			a_cursor: CURSOR
			a_tree_node_imp: EV_TREE_NODE_IMP
			l_child_array: like child_array
		do
			from
				a_cursor := child_array.cursor
				l_child_array := child_array
				l_child_array.start
				i := 1
			until
				i > l_child_array.count or else a_enable_flag
			loop
				l_child_array.go_i_th (i)
				if l_child_array.item /= Void then
					a_tree_node_imp ?= l_child_array.item.implementation
					a_enable_flag := a_tree_node_imp.is_transport_enabled_iterator
				end
				i := i + 1
			end
			l_child_array.go_to (a_cursor)
			update_pnd_connection (a_enable_flag)
		end

	update_pnd_connection (a_enable: BOOLEAN) is
			-- Update the PND connection status for `Current'.
		do
			if not is_transport_enabled then
				if a_enable or pebble /= Void then
					is_transport_enabled := True
				end
			elseif not a_enable and pebble = Void then
				is_transport_enabled := False
			end
		end

	on_mouse_button_event (
			a_type: INTEGER
			a_x, a_y, a_button: INTEGER;
			a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
			a_screen_x, a_screen_y: INTEGER)
		is
			-- Initialize a pick and drop transport.
		do
			pnd_row_imp := item_from_coords (a_x, a_y)

			if pnd_row_imp /= Void and then not pnd_row_imp.able_to_transport (a_button) then
				pnd_row_imp := Void
			end
			Precursor (
				a_type,
				a_x, a_y, a_button,
				a_x_tilt, a_y_tilt, a_pressure,
				a_screen_x, a_screen_y
			)
		end

	pnd_row_imp: EV_TREE_NODE_IMP
			-- Implementation object of the current row if in PND transport.

	temp_pebble: ANY
			-- Temporary pebble holder used for PND implementation with nodes.

	temp_pebble_function: FUNCTION [ANY, TUPLE [], ANY]
			-- Returns data to be transported by PND mechanism.

	temp_accept_cursor, temp_deny_cursor: EV_POINTER_STYLE

	call_pebble_function (a_x, a_y, a_screen_x, a_screen_y: INTEGER) is
			-- Set `pebble' using `pebble_function' if present.
		do
			temp_pebble := pebble
			temp_pebble_function := pebble_function
			if pnd_row_imp /= Void then
				pebble := pnd_row_imp.pebble
				pebble_function := pnd_row_imp.pebble_function
			end

			if pebble_function /= Void then
				pebble_function.call ([a_x, a_y]);
				pebble := pebble_function.last_result
			end
		end

	pre_pick_steps (a_x, a_y, a_screen_x, a_screen_y: INTEGER) is
			-- Steps to perform before transport initiated.
		do
			temp_accept_cursor := accept_cursor
			temp_deny_cursor := deny_cursor
			App_implementation.on_pick (Current, pebble)

			if pnd_row_imp /= Void then
				if pnd_row_imp.pick_actions_internal /= Void then
					pnd_row_imp.pick_actions_internal.call ([a_x, a_y])
				end
				accept_cursor := pnd_row_imp.accept_cursor
				deny_cursor := pnd_row_imp.deny_cursor
			else
				if pick_actions_internal /= Void then
					pick_actions_internal.call ([a_x, a_y])
				end
			end

			pointer_x := a_screen_x.to_integer_16
			pointer_y := a_screen_y.to_integer_16

			if pnd_row_imp = Void then
				if (pick_x = 0 and then pick_y = 0) then
					App_implementation.set_x_y_origin (a_screen_x, a_screen_y)
				else
					if pick_x > width then
						pick_x := width.to_integer_16
					end
					if pick_y > height then
						pick_y := height.to_integer_16
					end
					App_implementation.set_x_y_origin (pick_x + (a_screen_x - a_x), pick_y + (a_screen_y - a_y))
				end
			else
				if (pnd_row_imp.pick_x = 0 and then pnd_row_imp.pick_y = 0) then
					App_implementation.set_x_y_origin (a_screen_x, a_screen_y)
				else
					if pick_x > width then
						pick_x := width.to_integer_16
					end
					if pick_y > row_height then
						pick_y := row_height.to_integer_16
					end
					App_implementation.set_x_y_origin (
						pnd_row_imp.pick_x + (a_screen_x - a_x),
						pnd_row_imp.pick_y +
						(a_screen_y - a_y) +
						((child_array.index_of (pnd_row_imp.interface, 1) - 1) * row_height)
					)
				end
			end
			modify_widget_appearance (True)
		end

	post_drop_steps (a_button: INTEGER)  is
			-- Steps to perform once an attempted drop has happened.
		do
			App_implementation.set_x_y_origin (0, 0)
--			last_pointed_target := Void

			if pebble_function /= Void then
				if pnd_row_imp /= Void then
					pnd_row_imp.set_pebble_void
				else
					temp_pebble := Void
				end
			end

			accept_cursor := temp_accept_cursor
			deny_cursor := temp_deny_cursor
			pebble := temp_pebble
			pebble_function := temp_pebble_function

			temp_pebble := Void
			temp_pebble_function := Void
			temp_accept_cursor := Void
			temp_deny_cursor := Void

			pnd_row_imp := Void
		end

feature {EV_TREE_NODE_IMP}

	item_from_coords (a_x, a_y: INTEGER): EV_TREE_NODE_IMP is
			-- Returns the row index at relative coordinate `a_y'.
		local
			a_tree_path, a_tree_column: POINTER
			a_success: BOOLEAN
			a_int_ptr: POINTER
			mp: MANAGED_POINTER
			a_depth: INTEGER
			a_tree_node_imp: EV_TREE_NODE_IMP
			i: INTEGER
			current_depth_index: INTEGER
		do
			a_success := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_get_path_at_pos (tree_view, 1, a_y, $a_tree_path, $a_tree_column, NULL, NULL)
			if a_success then
				a_int_ptr := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_path_get_indices (a_tree_path)
				a_depth := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_path_get_depth (a_tree_path)
				from
					create mp.share_from_pointer (a_int_ptr, app_implementation.integer_bytes * a_depth)
					current_depth_index := mp.read_integer_32 (0) + 1
					a_tree_node_imp ?= child_array.i_th (current_depth_index).implementation
					i := 1
				until
					i = a_depth
				loop
					current_depth_index := mp.read_integer_32 (i * app_implementation.integer_bytes) + 1
					a_tree_node_imp ?= a_tree_node_imp.child_array.i_th (current_depth_index).implementation
					i := i + 1
				end
				Result := a_tree_node_imp
				{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_path_free (a_tree_path)
			end
		end

feature {NONE} -- Implementation

	previous_selected_item: EV_TREE_NODE
			-- Item that was selected previously.

	append (s: SEQUENCE [EV_TREE_ITEM]) is
			-- Add 's' to 'Current'
		do
			Precursor (s)
		end

	insert_i_th (v: like item; i: INTEGER) is
			-- Insert `v' at position `i'.
		local
			item_imp: EV_TREE_NODE_IMP
		do
			item_imp ?= v.implementation
			item_imp.set_parent_imp (Current)

			child_array.go_i_th (i)
			child_array.put_left (v)

			item_imp.add_item_and_children_to_parent_tree (Current, Void, i)
			update_row_pixmap (item_imp)

			if item_imp.is_transport_enabled_iterator then
				update_pnd_connection (True)
			end
		end

	remove_i_th (a_position: INTEGER) is
			-- Remove item at `a_position'
		local
			item_imp: EV_TREE_NODE_IMP
		do
			item_imp ?= (child_array @ (a_position)).implementation
				-- Remove from tree if present
--			{EV_GTK_EXTERNALS}.gtk_tree_store_remove (tree_store, item_imp.list_iter.item)
			item_imp.set_parent_imp (Void)
			child_array.go_i_th (a_position)
			child_array.remove
			update_pnd_status
		end

feature {EV_TREE_NODE_IMP} -- Implementation

	get_text_from_position (a_tree_node_imp: EV_TREE_NODE_IMP): STRING_32 is
			-- Retrieve cell text from `a_tree_node_imp`
		do
			-- TODO
		end

	set_text_on_position (a_tree_node_imp: EV_TREE_NODE_IMP; a_text: STRING_GENERAL) is
			-- Set cell text at to `a_text'.
		do
			-- TODO
		end

	update_row_pixmap (a_tree_node_imp: EV_TREE_NODE_IMP) is
			-- Set the pixmap for `a_tree_node_imp'.
		do
			-- TODO
		end

	set_row_height (value: INTEGER) is
			-- Make `value' the new height of all the rows.
		do
			-- TODO
		end

	row_height: INTEGER is
			-- Height of rows in `Current'
		do
			-- TODO
		end

feature {NONE} -- Implementation

	pixmaps_size_changed is
			-- The size of the displayed pixmaps has just
			-- changed.
		do
			--| FIXME IEK Add pixmap scaling code with gtk+ 2
			--| For now, do nothing.
		end

feature {EV_ANY_I} -- Implementation

	scrollable_area: POINTER
		-- Pointer to the GtkScrolledWindow widget used for scrolling the tree view

	interface: EV_TREE;

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




end -- class EV_TREE_IMP

