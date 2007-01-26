indexing

	description:

		"Values that are accessible through keys"

	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 2004, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

deferred class KL_VALUES [G, K]

inherit

	ANY -- Needed for SE 2.1b1.

feature -- Access

	value (k: K): G is
			-- Item associated with `k';
			-- Return default value if no such item
		require
			k_not_void: k /= Void 
		deferred
		end

end
