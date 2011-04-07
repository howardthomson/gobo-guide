note
	description: "Class defining an Eiffel thread of execution using an agent for its internal action."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2010-01-27 12:14:26 -0800 (Wed, 27 Jan 2010) $"
	revision: "$Revision: 82180 $"

class
	WORKER_THREAD

inherit
	THREAD
		rename
			execute as execute_procedure
		end

create
	make, make_with_procedure

feature {NONE} -- Initialization

	make (a_action: PROCEDURE [ANY, TUPLE])
			-- Create worker thread for `a_action'.
		require
			thread_capable: {PLATFORM}.is_thread_capable
		do
			thread_procedure := a_action
		end

feature -- Initialization

	execute_procedure
		do
			thread_procedure.call (Void)
		end

feature {NONE} -- Implementation

	thread_procedure: PROCEDURE [ANY, TUPLE];
			-- Action executed when thread starts its execution.

note
	copyright: "Copyright (c) 1984-2010, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end

