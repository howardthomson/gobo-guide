note
	description: "Information about the current thread execution"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2009-12-23 14:43:28 -0800 (Wed, 23 Dec 2009) $"
	revision: "$Revision: 81920 $"

class
	THREAD_ENVIRONMENT

feature -- Access

	current_thread_id: POINTER
			-- Thread identifier of the Current thread
		external
			"C inline use <eif_threads.h>"
		alias
			"return eif_thr_thread_id();"
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
