note
	description:
		"EiffelVision toggle tool bar, implementation interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2007-03-22 16:17:43 -0800 (Thu, 22 Mar 2007) $"
	revision: "$Revision: 67481 $"

class
	EV_TOOL_BAR_TOGGLE_BUTTON_IMP

inherit
	EV_TOOL_BAR_TOGGLE_BUTTON_I
		redefine
			interface
		end

	EV_TOOL_BAR_BUTTON_IMP
		redefine
			interface,
			make
		end

create
	make

feature -- Initialization

	make
			-- Create the tool-bar toggle button.
		do
			TODO_class_line ("EV_TOOL_BAR_TOGGLE_BUTTON_IMP::make", "__LINE__")
		end

feature -- Status setting

	disable_select
			-- Unselect `Current'.
		do
			if is_selected then
				TODO_class_line ("EV_TOOL_BAR_TOGGLE_BUTTON_IMP::disable_select", "__LINE__")
			end
		end

	enable_select
			-- Select `Current'.
		do
			if not is_selected then
				TODO_class_line ("EV_TOOL_BAR_TOGGLE_BUTTON_IMP::enable_select", "__LINE__")
			end
		end

feature -- Status report

	is_selected: BOOLEAN
			-- Is `Current' selected.
		do
				TODO_class_line ("EV_TOOL_BAR_TOGGLE_BUTTON_IMP::is_selected", "__LINE__")
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_TOOL_BAR_TOGGLE_BUTTON;

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




end -- class EV_TOOL_BAR_TOGGLE_BUTTON_IMP

