note
	description:
		"Eiffel Vision pixmapable. GTK+ implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "pixmap, bitmap, icon, graphic, image"
	date: "$Date: 2006-12-29 15:13:47 -0800 (Fri, 29 Dec 2006) $"
	revision: "$Revision: 65780 $"

deferred class
	EV_PIXMAPABLE_IMP

inherit
	EV_PIXMAPABLE_I
		redefine
			interface
		end

feature -- Initialization

	pixmapable_imp_initialize
			-- Create a GtkHBox to hold a GtkPixmap.
		do
			-- TODO
		end

feature -- Access

	pixmap: EV_PIXMAP
			-- Pixmap shown in `Current'
		do
			if internal_pixmap /= Void then
				Result := internal_pixmap.interface.twin
			end
		end

feature -- Element change

	set_pixmap (a_pixmap: EV_PIXMAP)
			-- Assign `a_pixmap' to `pixmap'.
		do
			internal_pixmap ?= a_pixmap.twin.implementation
			internal_set_pixmap (internal_pixmap, internal_pixmap.width, internal_pixmap.height)
		end

	remove_pixmap
			-- Assign Void to `pixmap'.
		do
			internal_pixmap := Void
			internal_remove_pixmap
		end

feature {EV_ANY_I} -- Implementation

	internal_set_pixmap (a_pixmap_imp: EV_PIXMAP_IMP; a_width, a_height: INTEGER)
			--
		do
			internal_remove_pixmap
			if a_width /= internal_pixmap.width or else a_height /= internal_pixmap.height then
				-- We need to scale pixmap before it is placed in to pixmap holder			
				a_pixmap_imp.stretch (a_width, a_height)
			end
			-- TODO
		end

	internal_remove_pixmap
			-- Remove pixmap from Current
		do
		end

	internal_pixmap: EV_PIXMAP_IMP
			-- Internal stored pixmap.		

feature {EV_ANY_I} -- Implementation

	interface: EV_PIXMAPABLE;

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




end -- EV_PIXMAPABLE_IMP

