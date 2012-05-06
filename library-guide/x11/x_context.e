note

	description: "Interface to Xlib's find/delete X context routines"

	author: "Stephane Hillion"
	copyright: "Copyright (c) 1998-2006, Stephane Hillion and Howard Thomson"
	license: "GNU Public License (see COPYING)"

class X_CONTEXT

inherit

	X11_EXTERNAL_ROUTINES

create

	make

feature

	table: DS_HASH_TABLE [ SB_WINDOW, INTEGER ]

	make
		do
			create table.make (1000)
		end

	put (w: SB_WINDOW)
		do
			table.put (w, w.xwin.id)
		end

	item (key: INTEGER): SB_WINDOW
		do
			Result := table.item (key)
		end

	remove (w: SB_WINDOW)
		do
			table.remove (w.xwin.id)
		end

end