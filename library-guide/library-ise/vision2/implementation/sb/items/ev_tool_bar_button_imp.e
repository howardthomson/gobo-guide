indexing
	description:
		"EiffelVision2 Toolbar button,%
		%a specific button that goes in a tool-bar."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2007-03-22 16:17:43 -0800 (Thu, 22 Mar 2007) $"
	revision: "$Revision: 67481 $"

class
	EV_TOOL_BAR_BUTTON_IMP

inherit
	EV_TOOL_BAR_BUTTON_I
		export
			{EV_GTK_DEPENDENT_INTERMEDIARY_ROUTINES} select_actions_internal
		redefine
			interface
		end

	EV_ITEM_IMP
		undefine
			update_for_pick_and_drop
		redefine
			interface,
--			initialize,
			event_widget,
			set_pixmap	--,
	--		needs_event_box
		end

	EV_DOCKABLE_SOURCE_IMP
		redefine
			interface
		end

--	EV_SENSITIVE_IMP
--		rename
--			enable_sensitive as enable_sensitive_internal,
--			disable_sensitive as disable_sensitive_internal
--		redefine
--			interface,
--			enable_sensitive_internal
--		end

	EV_TOOLTIPABLE_IMP
		redefine
			interface,
			set_tooltip,
			tooltip
		end

	EV_PND_DEFERRED_ITEM
		undefine
			create_drop_actions
		redefine
			interface
		end

create
	make

feature {NONE} -- Initialization

	old_make (an_interface: like interface)
			-- Create the tool bar button.
		do
			assign_interface (an_interface)
--			set_c_object ({EV_GTK_EXTERNALS}.gtk_tool_button_new (NULL, NULL))
		end

	make
			-- Initialization of button box and events.
		do
--			Precursor {EV_ITEM_IMP}
			pixmapable_imp_initialize
			-- TODO ...
			set_is_initialized (True)
		end

	event_widget: POINTER is
			-- Pointer to the Gtk widget that handles the events
		do
--			Result := {EV_GTK_EXTERNALS}.gtk_widget_struct_parent (pixmap_box)
		end

feature -- Access

	text: STRING_32 is
			-- Text of the label.
		local
			a_txt: POINTER
			a_cs: EV_GTK_C_STRING
		do
			-- TODO
		end

	gray_pixmap: EV_PIXMAP
			-- Image displayed on `Current'.

	tooltip: STRING_32 is
			-- Tooltip use for describing `Current'.
		do
			if internal_tooltip /= Void then
				Result := internal_tooltip.twin
			else
				Result := ""
			end
		end

	internal_tooltip: STRING_32
		-- Tooltip for `Current'.

feature -- Element change

	set_text (a_text: STRING_GENERAL) is
			-- Assign `a_text' to `text'.
		local
			a_parent_imp: EV_TOOL_BAR_IMP
		do
			-- TODO
		end

	set_pixmap (a_pixmap: EV_PIXMAP) is
			-- Assign `a_pixmap' to `pixmap'.
		local
			a_parent_imp: EV_TOOL_BAR_IMP
		do
			Precursor {EV_ITEM_IMP} (a_pixmap)
			a_parent_imp ?= parent_imp
			if a_parent_imp /= Void and then a_parent_imp.parent_imp /= Void then
				a_parent_imp.update_toolbar_style
			end
		end

	set_tooltip (a_text: STRING_GENERAL) is
			-- Set `tooltip' to `a_text'.
		local
		do
			internal_tooltip := a_text.twin
	--		a_cs := App_implementation.c_string_from_eiffel_string (a_text)
	--		{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tool_item_set_tooltip (
	--			visual_widget,
	--			app_implementation.tooltips,
	--			a_cs.item,
	--			NULL
	--		)
		end

	set_gray_pixmap (a_gray_pixmap: EV_PIXMAP) is
			-- Assign `a_gray_pixmap' to `gray_pixmap'.
		do
			gray_pixmap := a_gray_pixmap.twin
			--| FIXME IEK Needs proper implementation
		end

	remove_gray_pixmap is
			-- Make `pixmap' `Void'.
		do
			gray_pixmap := Void
			--| FIXME IEK Needs proper implementation
		end

	enable_sensitive is
			 -- Enable `Current'.
		do
			enabled_before := is_sensitive
			enable_sensitive_internal
		end

	disable_sensitive is
			 -- Disable `Current'.
		do
			enabled_before := is_sensitive
			disable_sensitive_internal
		end

feature {NONE}

	enable_sensitive_internal is
			-- Allow the object to be sensitive to user input.
		do
			-- TODO
		end

	disable_sensitive_internal is
			-- Set the object to ignore all user input.
		do
		end

feature -- Status report

	is_sensitive: BOOLEAN is
			-- Is the object sensitive to user input.
		do
			if not is_destroyed then
--				Result := {EV_GTK_EXTERNALS}.gtk_widget_is_sensitive (c_object)
			end
		end

	has_parent: BOOLEAN is
			-- Is `Current' parented?
		do
			Result := parent /= Void
		end

	parent_is_sensitive: BOOLEAN is
			-- Is `parent' sensitive?
		local
			sensitive_parent: EV_SENSITIVE
		do
			sensitive_parent ?= parent
			if sensitive_parent /= Void then
				Result := sensitive_parent.is_sensitive
			end
		end

feature {EV_GTK_DEPENDENT_INTERMEDIARY_ROUTINES} -- Implementation

	call_select_actions is
			-- Call the select_actions for `Current'
		do
			if not in_select_actions_call then
				in_select_actions_call := True
				if select_actions_internal /= Void then
					select_actions_internal.call (Void)
				end
			end
			in_select_actions_call := False
		end

	in_select_actions_call: BOOLEAN
		-- Is `Current' in the process of having its select actions called

feature {EV_ANY_I, EV_GTK_CALLBACK_MARSHAL} -- Implementation

	create_select_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Create a select action sequence.
			-- Attach to GTK "clicked" signal.
		do
			create Result
--			real_signal_connect (c_object, once "clicked", agent (App_implementation.gtk_marshal).new_toolbar_item_select_actions_intermediary (internal_id), Void)
		end

	create_drop_down_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- 	Create a drop down action sequence.
		do
			create Result
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_TOOL_BAR_BUTTON;

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




end -- class EV_TOOL_BAR_BUTTON_IMP

