indexing
	description:
		"Eiffel Vision cell, Slyboots implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_CELL_IMP

inherit
	EV_CELL_I
		undefine
			propagate_foreground_color,
			propagate_background_color
		redefine
			interface
		end

	EV_CONTAINER_IMP
		redefine
			make,
			interface,
			replace
		end

	EV_DOCKABLE_TARGET_IMP
		redefine
			interface
		end

create
	make

feature -- initialization

	make
			-- Connect interface and initialize `c_object'.
		do
			create {SB_FRAME} sb_widget.make_ev
		end

feature -- Access

	has (v: like item): BOOLEAN
			-- Does `Current' include `v'?
		do
			Result := not is_destroyed and (v /= Void and then item = v)
		end

	count: INTEGER_32
			-- Number of elements in `Current'.
		do
			if item /= Void then
				Result := 1
			end
		end

	item: EV_WIDGET
			-- Current item.

feature -- Element change

	replace (v: like item)
			-- Replace `item' with `v'.
		local
			v_imp: EV_WIDGET_IMP
			l_composite: SB_COMPOSITE
		do
			Precursor {EV_CONTAINER_IMP} (v)
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_CELL;
			-- Provides a common user interface to possibly dependent
			-- functionality implemented by `Current'.

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

end -- class EV_CELL_IMP

