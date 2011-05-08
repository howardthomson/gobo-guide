indexing
	description: "Eiffel Vision tree node. Slyboots implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TREE_NODE_IMP

inherit
	EV_TREE_NODE_I
		redefine
			interface
		end

	EV_ITEM_LIST_IMP [EV_TREE_NODE]
		export
			{EV_TREE_IMP}
				child_array
		redefine
			make,
			interface
		end

	EV_ITEM_ACTION_SEQUENCES_IMP

	EV_PICK_AND_DROPABLE_ACTION_SEQUENCES_IMP

	EV_TREE_NODE_ACTION_SEQUENCES_IMP

	EV_PND_DEFERRED_ITEM
		redefine
			interface
		end

create
	make

feature {EV_TREE_NODE_IMP} -- Implementation Attributes

	sb_item: SB_TREE_LIST_ITEM

feature {NONE} -- Initialization

	destroy is
			-- Clean up `Current'
		do
			if parent_imp /= Void then
				parent_imp.interface.prune (interface)
			end
			set_is_destroyed (True)
		end

	old_make (an_interface: like interface) is
			-- Create the tree item.
		do
			assign_interface (an_interface)
		end

	make
		do
			internal_text := once "TEST"
			create {SB_TREE_LIST_ITEM} sb_item.make_empty
		end

feature -- Status report

	is_selected: BOOLEAN is
			-- Is the item selected?
		local
			a_tree_imp: EV_TREE_IMP
		do
			a_tree_imp := parent_tree_imp
			if a_tree_imp /= Void then
				Result := a_tree_imp.selected_item = interface
			end
		end

	is_expanded: BOOLEAN is
			-- is the item expanded?
		do
			Result := sb_item.is_expanded
		end

feature -- Measurement

	x_position: INTEGER is
			-- Horizontal offset relative to parent `x_position' in pixels.
		local
			l_h_adjust: POINTER
			l_tree_imp: like parent_tree_imp
		do
				-- Return parents horizontal scrollbar offset.
			l_tree_imp := parent_tree_imp
			if l_tree_imp /= Void then
	--			l_h_adjust := {EV_GTK_EXTERNALS}.gtk_scrolled_window_get_hadjustment (l_tree_imp.scrollable_area)
	--			if l_h_adjust /= default_pointer then
	--				Result := - {EV_GTK_EXTERNALS}.gtk_adjustment_struct_value (l_h_adjust).rounded
	--			end
			end
		end

	y_position: INTEGER is
			-- Vertical offset relative to parent `y_position' in pixels.
		local
			l_v_adjust: POINTER
			l_tree_imp: like parent_tree_imp
		do
			l_tree_imp := parent_tree_imp
			if l_tree_imp /= Void then
				Result := (index - 1) * l_tree_imp.row_height
	--			l_v_adjust := {EV_GTK_EXTERNALS}.gtk_scrolled_window_get_vadjustment (l_tree_imp.scrollable_area)
	--			if l_v_adjust /= default_pointer then
	--				Result := Result - {EV_GTK_EXTERNALS}.gtk_adjustment_struct_value (l_v_adjust).rounded
	--			end
			end
		end

	screen_x: INTEGER is
			-- Horizontal offset relative to screen.
		local
			l_tree_imp: like parent_tree_imp
		do
			l_tree_imp := parent_tree_imp
			if l_tree_imp /= Void then
				Result := l_tree_imp.screen_x + x_position
			end
		end

	screen_y: INTEGER is
			-- Vertical offset relative to screen.
		local
			l_tree_imp: like parent_tree_imp
		do
			l_tree_imp := parent_tree_imp
			if l_tree_imp /= Void then
				Result := l_tree_imp.screen_y + y_position
			end
		end

	width: INTEGER is
			-- Horizontal size in pixels.
		local
			l_tree_imp: like parent_tree_imp
		do
			l_tree_imp := parent_tree_imp
			if l_tree_imp /= Void then
				Result := l_tree_imp.width
			end
		end

	height: INTEGER is
			-- Vertical size in pixels.
		local
			l_tree_imp: like parent_tree_imp
		do
			l_tree_imp := parent_tree_imp
			if l_tree_imp /= Void then
				Result := l_tree_imp.row_height
			end
		end

	minimum_width: INTEGER is
			-- Minimum horizontal size in pixels.
		local
			l_tree_imp: like parent_tree_imp
		do
			l_tree_imp := parent_tree_imp
			if l_tree_imp /= Void then
				Result := l_tree_imp.minimum_width
			end
		end

	minimum_height: INTEGER is
			-- Minimum vertical size in pixels.
		local
			l_tree_imp: like parent_tree_imp
		do
			l_tree_imp := parent_tree_imp
			if l_tree_imp /= Void then
				Result := l_tree_imp.row_height
			end
		end

feature {EV_ANY_I} -- Status setting

	enable_select is
			-- Select `Current' in its parent.
		local
			a_selection: POINTER
			par_tree: EV_TREE_IMP
		do
			par_tree := parent_tree_imp
			if par_tree /= Void then
	--			a_selection := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_get_selection (par_tree.tree_view)
	--			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_selection_select_iter (a_selection, list_iter.item)
	--			par_tree.ensure_item_visible (interface)
			end
		end

	disable_select is
			-- Disable selection of `Current' in its parent.
		local
			a_selection: POINTER
			par_tree: EV_TREE_IMP
		do
			par_tree := parent_tree_imp
			if par_tree /= Void then
	--			a_selection := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_get_selection (par_tree.tree_view)
	--			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_selection_unselect_iter (a_selection, list_iter.item)
			end
		end

	set_expand (a_flag: BOOLEAN) is
			-- Expand the item if `flag', collapse it otherwise.
		local
			par_tree: EV_TREE_IMP
		do
			sb_item.set_expanded (a_flag)
		end

	set_text (a_text: STRING_GENERAL) is
			-- Set 'text' to 'a_text'
		local
			par_tree: EV_TREE_IMP
		do
			internal_text := a_text.twin
			par_tree := parent_tree_imp
			if par_tree /= Void then
				par_tree.set_text_on_position (Current, internal_text)
			end
		end

feature -- PND

	enable_transport is
			-- Enable PND transport
		do
			is_transport_enabled := True
			if parent_tree_imp /= Void then
				parent_tree_imp.update_pnd_status
			end
		end

	disable_transport is
			-- Disable PND transport
		do
			is_transport_enabled := False
			if parent_tree_imp /= Void then
				parent_tree_imp.update_pnd_status
			end
		end

	draw_rubber_band is
		do
			check
				do_not_call: False
			end
		end

	erase_rubber_band is
		do
			check
				do_not_call: False
			end
		end

	enable_capture is
		do
			check
				do_not_call: False
			end
		end

	disable_capture is
		do
			check
				do_not_call: False
			end
		end

	start_transport (
        	a_x, a_y, a_button: INTEGER; a_press:BOOLEAN;
        	a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
        	a_screen_x, a_screen_y: INTEGER; a_menu_only: BOOLEAN) is
        	-- Start PND transport (not needed)
		do
			check
				do_not_call: False
			end
		end

	end_transport (a_x, a_y, a_button: INTEGER;
		a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
		a_screen_x, a_screen_y: INTEGER) is
			-- End PND transport (not needed)
		do
			check
				do_not_call: False
			end
		end

	set_pointer_style, internal_set_pointer_style (c: EV_POINTER_STYLE) is
			-- Set 'pointer_style' to 'c' (not needed)
		do
			check
				do_not_call: False
			end
		end

	is_transport_enabled_iterator: BOOLEAN is
			-- Has 'Current' or a child of 'Current' pnd transport enabled?
		local
			a_cursor: CURSOR
			a_tree_node_imp: EV_TREE_NODE_IMP
			i: INTEGER
		do
			if is_transport_enabled then
				Result := True
			elseif count > 0 then
				from
					a_cursor := child_array.cursor
					i := 1
				until
					i > child_array.count or else Result
				loop
					if child_array.i_th (i) /= Void then
						a_tree_node_imp ?= child_array.i_th (i).implementation
						Result := a_tree_node_imp.is_transport_enabled_iterator
					end
					i := i + 1
				end
				child_array.go_to (a_cursor)
			end
		end

feature {EV_TREE_IMP} -- Implementation

	set_pebble_void is
			-- Resets pebble from Tree_Imp.
		do
			pebble := Void
		end

	able_to_transport (a_button: INTEGER): BOOLEAN is
			-- Is the row able to transport data with `a_button' click.
		do
			Result := is_transport_enabled and
			((a_button = 1 and mode_is_drag_and_drop) or
			(a_button = 3 and (mode_is_pick_and_drop or mode_is_target_menu)))
		end

feature {EV_ANY_I} -- Implementation

	set_parent_imp (par_imp: like parent_imp) is
		do
			parent_imp := par_imp
		end

	parent_imp: EV_ITEM_LIST_IMP [EV_TREE_NODE]

	parent_tree_imp: EV_TREE_IMP is
		local
			l_par_tree: like parent_tree
		do
			l_par_tree := parent_tree
			if l_par_tree /= Void then
				Result ?= l_par_tree.implementation
			end
		end

feature {EV_TREE_IMP, EV_TREE_NODE_IMP} -- Implementation

-- Currently, a_parent_node.sb_item is not an appropriate value for the call to create_item_after in the routine below ...

	add_item_and_children_to_parent_tree (a_parent_tree: EV_TREE_IMP; a_parent_node: EV_TREE_NODE_IMP; a_index: INTEGER)  is
			-- Used for setting items within parent tree
		local
			i: INTEGER
			item_imp: EV_TREE_NODE_IMP
			discard_item: SB_TREE_LIST_ITEM
		do
-- TODO: use a_index !
print ("EV_TREE_NODE_IMP::add_item_and_children_to_parent_tree ... "); print (text); print ("%N")
			if a_parent_node /= Void then
print ("(a_parent_node.sb_item = Void) = "); print ((a_parent_node.sb_item = Void).out); print ("%N")
			--	sb_item := a_parent_tree.sb_widget.create_item_after (a_parent_node.sb_item, text, Void, Void, Void, False)
				a_parent_tree.sb_widget.add_item_last (a_parent_node.sb_item, sb_item, False)
			--	a_parent_node.sb_item.set_has_expander (True)
			else
			--	sb_item := a_parent_tree.sb_widget.create_item_last (Void, text, Void, Void, Void, False)
				a_parent_tree.sb_widget.add_item_last (Void, sb_item, False)
			--	discard_item.set_has_expander (True)
			end
		--	a_parent_tree.set_text_on_position (Current, text)
			sb_item.set_text (text)
print ("EV_TREE_NODE_IMP -- 0 %N")
			a_parent_tree.update_row_pixmap (Current)
print ("EV_TREE_NODE_IMP -- 1 %N")
			from
				i := 1
			until
				i > child_array.count
			loop
print ("EV_TREE_NODE_IMP -- 2 %N")
				item_imp ?= (child_array @ i).implementation
				item_imp.add_item_and_children_to_parent_tree (a_parent_tree, Current, i)
				i := i + 1
			end
print ("EV_TREE_NODE_IMP -- 3 %N")
		end

feature {EV_TREE_IMP, EV_TREE_NODE_IMP} -- Implementation

	update_for_pick_and_drop (starting: BOOLEAN)
			-- Pick and drop status has changed so update appearance of
			-- `Current' to reflect available targets.
		do
			-- Do nothing
		end

	ensure_expandable is
			-- Ensure `Current' is displayed as expandable.
		do
			insert_i_th (create {EV_TREE_ITEM}, 1)
				-- Now remove the new item from `child_array'
				-- as we do not wish the item to be accessible from the interface.
			child_array.wipe_out
		end

	remove_expandable is
			-- Ensure `Current' is no longer displayed as expandable.
		local
			l_parent_tree: EV_TREE_IMP
		do
			l_parent_tree ?= parent_imp
			if l_parent_tree /= Void then
				-- Check if 'child_array' count is less than actual count, if so remove last item
			else
				-- Nothing needs to be done if parent tree is Void
			end
		end

	text: STRING_32 is
			-- Text displayed.
		do
			Result := internal_text.twin
		ensure then
			text_not_void: Result /= Void
		end

	tooltip: STRING_32 is
			-- Tooltip if any.
		do
			if internal_tooltip = Void then
				Result := ""
			else
				Result := internal_tooltip.twin
			end
		ensure then
			tooltip_not_void: Result /= Void
		end

	remove_internal_text is
			-- Make `internal_text' Void
		do
			internal_text := Void
		end

	set_internal_text (a_text: STRING_GENERAL) is
			-- Set `internal_text' to `a_text'
		do
			internal_text := a_text
		end

	internal_text: STRING_32
		-- Internal representation of `text'.

	internal_tooltip: STRING_32
		-- Internal representation of `tooltip'.

	set_tooltip (a_text: STRING_GENERAL) is
			-- Set `a_text' to `tooltip'.
		do
			internal_tooltip := a_text
		end

	remove_tooltip is
			-- Remove text of `tooltip'.
		do
			internal_tooltip := ""
		end

	set_pixmap (a_pixmap: EV_PIXMAP) is
			-- Set the pixmap for 'Current'.
		local
			a_pix_imp: EV_PIXMAP_IMP
			par_tree: EV_TREE_IMP
		do
				-- Clean up previous pixmap if any
--			dispose
--			a_pix_imp ?= a_pixmap.implementation
--			gdk_pixbuf := a_pix_imp.pixbuf_from_drawable
--			par_tree := parent_tree_imp
--			if par_tree /= Void then
--				par_tree.update_row_pixmap (Current)
--			end
		end

	pix_width, pix_height: INTEGER
			-- Height and width of pixmap in Tree.

	remove_pixmap is
			-- Remove the pixmap for `Current'
		local
			par_tree: EV_TREE_IMP
		do
			par_tree := parent_tree_imp
			if par_tree /= Void then
				par_tree.update_row_pixmap (Current)
			end
		end

	pixmap: EV_PIXMAP is
			-- Pixmap displayed in 'Current' if any.
		do
			-- TODO
		end

	insert_i_th (v: like item; i: INTEGER) is
			-- Insert `v' at position `i'.
		local
			item_imp: EV_TREE_NODE_IMP
			l_parent_tree_imp: EV_TREE_IMP
		do
print ("EV_TREE_NODE_IMP::insert_i_th ...%N")
if false then
			item_imp ?= v.implementation
			item_imp.set_parent_imp (Current)
			child_array.go_i_th (i)
			child_array.put_left (v)

				-- Using a local prevents recalculation
			l_parent_tree_imp := parent_tree_imp
			if l_parent_tree_imp /= Void then
				item_imp.add_item_and_children_to_parent_tree (l_parent_tree_imp, Current, i)
				if item_imp.is_transport_enabled_iterator then
					l_parent_tree_imp.update_pnd_connection (True)
				end
			end
				-- Resume expansion status from last node removal
			if count = 1 and then l_parent_tree_imp /= Void then
				if expand_actions_internal /= Void then
					expand_actions_internal.block
				end
				set_expand (expanded_on_last_item_removal)
				if expand_actions_internal /= Void then
					expand_actions_internal.resume
				end
			end
end
		end

	remove_i_th (a_position: INTEGER) is
			-- Remove item at `a_position'
		local
			item_imp: EV_TREE_NODE_IMP
			par_tree_imp: EV_TREE_IMP
		do
			if count = 1 then
				if parent_tree /= Void then
					expanded_on_last_item_removal := is_expanded
				else
					expanded_on_last_item_removal := False
				end
			end
			item_imp ?= (child_array @ (a_position)).implementation

				-- Remove from tree if present
			par_tree_imp := parent_tree_imp
--			if par_tree_imp /= Void then
--				{EV_GTK_EXTERNALS}.gtk_tree_store_remove (par_tree_imp.tree_store, item_imp.list_iter.item)
--			end
			item_imp.set_parent_imp (Void)
			child_array.go_i_th (a_position)
			child_array.remove

			if par_tree_imp /= Void then
				par_tree_imp.update_pnd_status
			end
		end

	expanded_on_last_item_removal: BOOLEAN
		-- Was `Current' expanded upon removal of last item

feature {NONE} -- Redundant implementation

	real_pointed_target: EV_PICK_AND_DROPABLE is
		do
			check do_not_call: False end
		end

feature {NONE} -- Implementation

	dispose is
			-- Clean up
		do
			-- TODO
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_TREE_NODE;

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




end -- class EV_TREE_NODE_IMP

