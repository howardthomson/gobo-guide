note
	description: "Objects that traverse object graphs starting at the root object in a breadth first manner."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Stephanie Balzer"
	date: "$Date: 2010-03-16 13:03:40 -0700 (Tue, 16 Mar 2010) $"
	revision: "$Revision: 437 $"

class
	OBJECT_GRAPH_BREADTH_FIRST_TRAVERSABLE
	
inherit
	OBJECT_GRAPH_TRAVERSABLE

feature {NONE} -- Implementation

	new_dispenser: ARRAYED_QUEUE [ANY]
			-- Create the dispenser to use for storing visited objects.
		do
			create Result.make (default_size)
		end

note
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"






end
