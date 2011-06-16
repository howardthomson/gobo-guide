note
	description: 
		"GtkTextIter Struct helper class"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	id: "$Id: ev_gtk_text_iter_struct.e 76420 2008-12-29 20:27:11Z manus $"
	date: "$Date: 2008-12-29 12:27:11 -0800 (Mon, 29 Dec 2008) $"
	revision: "$Revision: 76420 $"

class
	EV_GTK_TEXT_ITER_STRUCT

inherit
	MEMORY_STRUCTURE
	
create
	make

feature -- Externals

	frozen structure_size: INTEGER
		external
			"C [macro <gtk/gtk.h>]"
		alias
			"sizeof(GtkTextIter)"
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




end -- EV_GTK_TEXT_ITER_STRUCT

