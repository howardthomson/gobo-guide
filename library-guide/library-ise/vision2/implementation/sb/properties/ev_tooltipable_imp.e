note
	description:
		"Eiffel Vision tooltipable. SlyBoots implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "tooltip, popup"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_TOOLTIPABLE_IMP

inherit
	EV_TOOLTIPABLE_I
		redefine
			interface
		end

feature -- Initialization

	tooltip: STRING_32
			-- Tooltip that has been set.
		do
			-- TODO ...
			create Result.make_empty
		end

feature -- Element change

	set_tooltip (a_text: STRING_GENERAL)
			-- Set `tooltip' to `a_text'.
		do
		end

feature {NONE} -- Implementation

	app_implementation: EV_APPLICATION_IMP
		deferred
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_TOOLTIPABLE;

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

end -- EV_TOOLTIPABLE_IMP

