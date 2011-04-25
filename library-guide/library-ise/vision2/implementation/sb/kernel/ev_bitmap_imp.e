indexing
	description: "Objects that ..."
	author: ""
	date: "$Date: 2007-01-04 17:20:35 -0800 (Thu, 04 Jan 2007) $"
	revision: "$Revision: 65793 $"

class
	EV_BITMAP_IMP

inherit
	EV_BITMAP_I
		redefine
			interface
		end

	EV_DRAWABLE_IMP
		redefine
			interface,
			clear_rectangle
		end

create
	make

feature -- Initialization

	make (an_interface: like interface) is
			-- Create an empty drawing area.
		do
			base_make (an_interface)
			TODO_class_line ("__EV_BITMAP_IMP__", "make")
		end

	initialize is
			-- Set up action sequence connections and create graphics context.
		do
			TODO_class_line ("__EV_BITMAP_IMP__", "initialize")
			set_default_colors
			init_default_values
			set_is_initialized (True)
		end

feature -- Status Setting

	set_size (a_width, a_height: INTEGER) is
			-- Set the size of the pixmap to `a_width' by `a_height'.
		do
			TODO_class_line ("__EV_BITMAP_IMP__", "set_size")
		end

	clear_rectangle (a_x, a_y, a_width, a_height: INTEGER) is
			-- Erase rectangle specified with `background_color'.
		do
			TODO_class_line ("__EV_BITMAP_IMP__", "clear_rectangle")

			set_default_colors
		end

feature -- Access

	width: INTEGER is
			-- Width in pixels of mask bitmap.
		do
			TODO_class_line ("__EV_BITMAP_IMP__", "width")
		end

	height: INTEGER is
			-- Width in pixels of mask bitmap.
		do
			TODO_class_line ("__EV_BITMAP_IMP__", "height")
		end

feature {EV_PIXMAP_IMP} -- Implementation

--	drawable: POINTER
		-- Pointer to the GdkPixmap objects used for `Current'.

feature {NONE} -- Implementation

	app_implementation: EV_APPLICATION_IMP is
			-- Access to application object implementation.
		local
			env: EV_ENVIRONMENT
		once
			create env
			Result ?= env.application.implementation
			check
				result_not_void: Result /= Void
			end
		end

	redraw is
			-- Redraw the entire area.
		do
			-- Not needed for masking implementation.
		end

	set_default_colors is
			-- Set foreground and background color to their default values.
		do
			TODO_class_line ("__EV_BITMAP_IMP__", "set_default_colors")
		end

	destroy is
		do
			TODO_class_line ("__EV_BITMAP_IMP__", "destroy")
			
			if drawable /= default_pointer then
--				{EV_GTK_EXTERNALS}.gdk_bitmap_unref (drawable)
				drawable := default_pointer
			end
			set_is_destroyed (True)
		end

	dispose is
			-- Cleanup
		do
			TODO_class_line ("__EV_BITMAP_IMP__", "dispose")

			if drawable /= default_pointer then
--				{EV_GTK_EXTERNALS}.gdk_bitmap_unref (drawable)
			end
		end

	flush is
			-- Force all queued draw to be called.
		do
		end

	update_if_needed is
			-- Update `Current' if needed.
		do
		end

	mask: POINTER is
		do
			-- Not applicable
		end

	interface: EV_BITMAP

end -- class EV_SCREEN_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------
