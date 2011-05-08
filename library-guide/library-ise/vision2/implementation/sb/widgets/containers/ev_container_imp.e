note

	description: "Eiffel Vision container, Slyboots implementation."

	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "container"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_CONTAINER_IMP

inherit
	EV_CONTAINER_I
		redefine
			interface,
			propagate_foreground_color,
			propagate_background_color
		end

	EV_WIDGET_IMP
		redefine
			make,
			interface,
			initialize,
			destroy,
			set_parent_imp
		end

	EV_CONTAINER_ACTION_SEQUENCES_IMP

	PLATFORM

feature {NONE} -- Initialization

	make
		do
		end

	initialize is
			-- Create `shared_pointer' for radio groups.
		do
			Precursor {EV_WIDGET_IMP}
		end

feature -- Access

	client_width: INTEGER is
			-- Width of the client area of container.
			-- Redefined in children.
		do
			Result := width
		end

	client_height: INTEGER is
			-- Height of the client area of container
			-- Redefined in children.
		do
			Result := height
		end

	background_pixmap: EV_PIXMAP
			-- the background pixmap

feature -- Element change

	replace (v: like item) is
			-- Replace `item' with `v'.
		local
			w: EV_WIDGET_IMP
		do
			if not interface.is_empty then
				w ?= interface.item.implementation
				on_removed_item (w)
			end
			if v /= Void then
				w ?= v.implementation
				on_new_item (w)
			end
		end

feature -- Status setting

	connect_radio_grouping (a_container: EV_CONTAINER) is
			-- Join radio grouping of `a_container' to `Current'.
		local
			l: ARRAYED_LIST [POINTER]
			peer: EV_CONTAINER_IMP
		do
			-- TODO
		end

	unconnect_radio_grouping (a_container: EV_CONTAINER) is
			-- Remove Join of `a_container' to radio grouping of `Current'.
		do
			-- TODO
		end

	add_radio_button (a_widget_imp: EV_WIDGET_IMP) is
			-- Called every time a widget is added to the container.
		require
			a_widget_imp_not_void: a_widget_imp /= Void
		local
			r: EV_RADIO_BUTTON_IMP
		do
			r ?= a_widget_imp
			if r /= Void then
	--			if radio_group /= NULL then
	--				{EV_GTK_EXTERNALS}.gtk_radio_button_set_group (r.visual_widget, radio_group)
	--			else
	--				{EV_GTK_EXTERNALS}.gtk_toggle_button_set_active (r.visual_widget, False)
	--			end
	--			set_radio_group ({EV_GTK_EXTERNALS}.gtk_radio_button_group (r.visual_widget))
			end
		end

	remove_radio_button (a_widget_imp: EV_WIDGET_IMP) is
			-- Called every time a widget is removed from the container.
		require
			a_widget_imp_not_void: a_widget_imp /= Void
		local
			r: EV_RADIO_BUTTON_IMP
			a_max_index: INTEGER
			a_item_index: INTEGER
			an_item_imp: EV_RADIO_BUTTON_IMP
		do
		end

	set_background_pixmap (a_pixmap: EV_PIXMAP) is
			-- Set the container background pixmap to `pixmap'.
		do
			background_pixmap := a_pixmap.twin
			internal_set_background_pixmap (a_pixmap)
		end

	remove_background_pixmap is
			-- Make background pixmap Void.
		local
			a_style, mem_ptr: POINTER
			i: INTEGER
		do
			internal_set_background_pixmap (Void)
			background_pixmap := Void
		end

	internal_set_background_pixmap (a_pixmap: EV_PIXMAP) is
			-- Set the container background pixmap to `pixmap'.
		do
		--	TODO
		end

feature -- Basic operations

	propagate_foreground_color is
			-- Propagate the current foreground color of the
			-- container to the children.
		do
			Precursor {EV_CONTAINER_I}
--			propagate_foreground_color_internal (foreground_color, c_object)
		end

	propagate_background_color is
			-- Propagate the current background color of the
			-- container to the children.
		do
			Precursor {EV_CONTAINER_I}
--			propagate_background_color_internal (background_color, c_object)
		end

feature -- Command

	destroy is
			-- Render `Current' unusable.
		do
			if interface.prunable then
				interface.wipe_out
			end
			Precursor {EV_WIDGET_IMP}
		end

feature -- Event handling

	on_new_item (an_item_imp: EV_WIDGET_IMP) is
			-- Called after `an_item' is added.
		do
			add_radio_button (an_item_imp)
--print ("EV_CONTAINER_IMP::on_new_item ... Calling set_parent_imp%N")
			an_item_imp.set_parent_imp (Current)
--			if new_item_actions_internal /= Void then
--				new_item_actions_internal.call ([an_item])
--			end
		end

	on_removed_item (an_item_imp: EV_WIDGET_IMP) is
			-- Called just before `an_item' is removed.
		do
			an_item_imp.set_parent_imp (Void)
			remove_radio_button (an_item_imp)
		end

feature {EV_WIDGET_IMP} -- Implementation

	child_has_resized (a_widget_imp: EV_WIDGET_IMP) is
			--
		do
			-- By default do nothing
		end

	set_parent_imp (a_parent_imp: EV_CONTAINER_IMP) is
			--
		local
			l_composite: SB_COMPOSITE
		do
			Precursor {EV_WIDGET_IMP} (a_parent_imp)
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_CONTAINER;
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

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

end -- class EV_CONTAINER_IMP

