note

	description:
		"Eiffel Vision sensitive. Slyboots implementation."

	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "sensitive"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_SENSITIVE_IMP

inherit
	EV_SENSITIVE_I
		redefine
			interface
		end

feature -- Status report

	is_sensitive: BOOLEAN is
			-- Is the object sensitive to user input.
		do
		end

feature -- Status setting

	enable_sensitive is
			-- Allow the object to be sensitive to user input.
		do
		end

	disable_sensitive is
			-- Set the object to ignore all user input.
		do
		end

feature {EV_ANY_I} -- Implementation

	has_parent: BOOLEAN is
			-- Is `Current' parented?
		do
			Result := parent /= Void
		end

	parent: EV_ANY is
		deferred
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

	interface: EV_SENSITIVE;
			-- Interface object for implementation

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

end -- EV_SENSITIVE_IMP

