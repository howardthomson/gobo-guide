note
	description: "[
		Base class for Slyboots implementation (_IMP) classes.
		Handles interaction between Eiffel objects and Slyboots objects
		See important notes on memory management at end of class
	]"
	legal: "See notice at end of class."
	keywords: "implementation, gtk, any, base"
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class

	EV_ANY_IMP

inherit

	EV_ANY_I

	IDENTIFIED
		undefine
			is_equal,
			copy
		redefine
			dispose
		end

	SB_ANY
	SB_SHARED_APPLICATION

feature {EV_INTERMEDIARY_ROUTINES, EV_ANY_I, EV_STOCK_PIXMAPS_IMP} -- Implementation

	App_implementation: EV_APPLICATION_IMP
			--
		local
			env: EV_ENVIRONMENT
		once
			create env
			Result ?= env.application.implementation
		end

feature {NONE}

	frozen old_make (an_interface: like interface)
		do
			check false end
		end

	dispose
		do
		end

	TODO_class_line (a_class, a_line: STRING)
		do
			print (once "TODO: Class = ")
			print (a_class)
			print (once ", Line = ")
			print (a_line)
			print (once "%N")
		end

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

end -- class EV_ANY_IMP

