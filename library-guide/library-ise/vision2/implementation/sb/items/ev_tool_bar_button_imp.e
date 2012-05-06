note
	description: "EiffelVision2 Toolbar button,%
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
		rename
			make_ev as make_window_ev
		undefine
			update_for_pick_and_drop,
			make_sb_window,
			handle_2,
			on_focus_in,
			on_focus_out,
			on_paint,
			on_left_btn_press,
			on_left_btn_release,
			on_key_press,
			on_key_release,
			on_enter,
			on_leave,
		--	on_grabbed,
			on_ungrabbed,
			create_resource,
			detach_resource,
			destruct,
			can_focus,
			set_focus_sb,
			kill_focus,
			class_name,
			on_update,
			enable,
			disable,
			default_width_sb,
			default_height_sb,
			set_default
		redefine
			make,
			interface,
			set_pixmap
		end

	EV_DOCKABLE_SOURCE_IMP
		redefine
			interface
		end

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

	SB_BUTTON
		rename
			make_window as make_sb_window,
			make as make_button_sb,
			show as show_sb,
			hide as hide_sb,
			set_focus as set_focus_sb,
	--		width as width_sb,
	--		height as height_sb,
	--		set_width as set_width_sb,
	--		set_height as set_height_sb,
	--		minimum_width as minimum_width_sb,
	--		minimum_height as minimum_height_sb,
	--		set_minimum_width as set_minimum_width_sb,
	--		set_minimum_height as set_minimum_height_sb,
			has_focus as has_focus_sb,
			parent as parent_sb,
			move as move_sb,
			drag_cursor as drag_cursor_sb,
			raise as raise_sb,
			lower as lower_sb,
			x_offset as x_offset_sb,
			y_offset as y_offset_sb,
			flush as flush_sb,
			selected as selected_sb,
			has_selection as has_selection_sb,
			default_width as default_width_sb,
			default_height as default_height_sb,
	--		enable as enable_sb,
	--		disable as disable_sb
			set_text as set_text_sb
	--		set_default as set_default_sb
		undefine
			set_minimum_width,
			set_minimum_height
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization of button box and events.
		do
--			Precursor {EV_ITEM_IMP}
			pixmapable_imp_initialize
			-- TODO ...
			print ("EV_TOOL_BAR_BUTTON_IMP::make TODO ...%N")
			make_ev
			set_is_initialized (True)
		end

feature -- Access

	text: STRING_32
			-- Text of the label.
		local
			a_txt: POINTER
		do
			-- TODO
		end

	gray_pixmap: EV_PIXMAP
			-- Image displayed on `Current'.

	tooltip: STRING_32
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

	set_text (a_text: STRING_GENERAL)
			-- Assign `a_text' to `text'.
		local
			a_parent_imp: EV_TOOL_BAR_IMP
		do
			-- TODO
		end

	set_pixmap (a_pixmap: EV_PIXMAP)
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

	set_tooltip (a_text: STRING_GENERAL)
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

	set_gray_pixmap (a_gray_pixmap: EV_PIXMAP)
			-- Assign `a_gray_pixmap' to `gray_pixmap'.
		do
			gray_pixmap := a_gray_pixmap.twin
			--| FIXME IEK Needs proper implementation
		end

	remove_gray_pixmap
			-- Make `pixmap' `Void'.
		do
			gray_pixmap := Void
			--| FIXME IEK Needs proper implementation
		end

	enable_sensitive
			 -- Enable `Current'.
		do
			enabled_before := is_sensitive
			enable_sensitive_internal
		end

	disable_sensitive
			 -- Disable `Current'.
		do
			enabled_before := is_sensitive
			disable_sensitive_internal
		end

feature {NONE}

	enable_sensitive_internal
			-- Allow the object to be sensitive to user input.
		do
			-- TODO
		end

	disable_sensitive_internal
			-- Set the object to ignore all user input.
		do
		end

feature -- Status report

	is_sensitive: BOOLEAN
			-- Is the object sensitive to user input.
		do
			if not is_destroyed then
--				Result := {EV_GTK_EXTERNALS}.gtk_widget_is_sensitive (c_object)
			end
		end

	has_parent: BOOLEAN
			-- Is `Current' parented?
		do
			Result := parent /= Void
		end

	parent_is_sensitive: BOOLEAN
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

	call_select_actions
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
		-- Is `Current' in the process of having its select actions called ?

feature {EV_ANY_I, EV_GTK_CALLBACK_MARSHAL} -- Implementation

	create_select_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Create a select action sequence.
			-- Attach to GTK "clicked" signal.
		do
			create Result
--			real_signal_connect (c_object, once "clicked", agent (App_implementation.gtk_marshal).new_toolbar_item_select_actions_intermediary (internal_id), Void)
		end

	create_drop_down_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- 	Create a drop down action sequence.
		do
			create Result
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_TOOL_BAR_BUTTON;

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

end -- class EV_TOOL_BAR_BUTTON_IMP

