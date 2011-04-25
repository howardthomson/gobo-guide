indexing
	description: "Objects that ..."
	author: ""
	date: "$Date: 2006-03-22 10:20:08 -0800 (Wed, 22 Mar 2006) $"
	revision: "$Revision: 57600 $"

class
	EV_TOOL_BAR_DROP_DOWN_BUTTON_IMP

inherit
	EV_TOOL_BAR_DROP_DOWN_BUTTON_I
		redefine
			interface
		end

	EV_TOOL_BAR_BUTTON_IMP
		redefine
			interface
		end

create
	make

feature {EV_ANY_I} -- Implementation

	interface: EV_TOOL_BAR_DROP_DOWN_BUTTON;

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

end -- EV_TOOL_BAR_DROP_DOWN_BUTTON_IMP
