indexing
	description: "EiffelVision pixmap, Slyboots implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "drawable, primitives, figures, buffer, bitmap, picture"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PIXMAP_IMP

inherit
	EV_PIXMAP_I
		rename
--			make as make_drawable
		undefine
--			make
		redefine
			interface,
			flush,
			save_to_named_file
		end

	EV_PRIMITIVE_IMP
		rename
			sb_widget as sb_pixmap_window
		undefine
			foreground_color_internal,
			background_color_internal,
			set_foreground_color,
			set_background_color
		redefine
			make,
			sb_pixmap_window,
			interface,
			width,
			height,
			destroy,
			dispose,
			xwin
		end

	EV_DRAWABLE_IMP
		rename
			sb_drawable as sb_pixmap_window,
			resource_id as xwin
		undefine
			make_drawable,
			resize,
			detach_resource,
			add_properties,
			set_width,
			set_height,
			set_minimum_width,
			set_minimum_height,
			destruct
		redefine
			make,
			sb_pixmap_window,
			interface,
			width,
			height,
			destroy,
			dispose,
			xwin
		end

	EV_PIXMAP_ACTION_SEQUENCES_IMP

create
	make

feature {NONE} -- Implementation Attributes

	sb_pixmap_window: SB_WINDOW
		-- Implementation link

	xwin: X_WINDOW

feature {NONE} -- Initialization

	make is
			-- Initialize `Current'
		local
			l_app_imp: like app_implementation
		do
--			Precursor {EV_PRIMITIVE_IMP}
			l_app_imp := app_implementation

			todo_class_line ("__EV_PIXMAP_IMP__", "__LINE__ 2")

			create sb_pixmap_window.make_ev
			init_default_values
			clear
		end

	init_from_pointer_style (a_pointer_style: EV_POINTER_STYLE) is
			-- Initialize from `a_pointer_style'
		local
			a_pointer_style_imp: EV_POINTER_STYLE_IMP
			l_pixbuf: POINTER
		do
			a_pointer_style_imp ?= a_pointer_style.implementation

			if a_pointer_style_imp.predefined_cursor_code /= -1 then
				-- We are building from a stock cursor.
				inspect
					a_pointer_style_imp.predefined_cursor_code
				when {EV_POINTER_STYLE_CONSTANTS}.busy_cursor then
					set_from_xpm_data ({EV_STOCK_PIXMAPS_IMP}.busy_cursor_xpm)
				when {EV_POINTER_STYLE_CONSTANTS}.wait_cursor then
					set_from_xpm_data ({EV_STOCK_PIXMAPS_IMP}.wait_cursor_xpm)
				when {EV_POINTER_STYLE_CONSTANTS}.crosshair_cursor then
					set_from_xpm_data ({EV_STOCK_PIXMAPS_IMP}.crosshair_cursor_xpm)
				when {EV_POINTER_STYLE_CONSTANTS}.help_cursor then
					set_from_xpm_data ({EV_STOCK_PIXMAPS_IMP}.help_cursor_xpm)
				when {EV_POINTER_STYLE_CONSTANTS}.ibeam_cursor then
					set_from_xpm_data ({EV_STOCK_PIXMAPS_IMP}.ibeam_cursor_xpm)
				when {EV_POINTER_STYLE_CONSTANTS}.no_cursor then
					set_from_xpm_data ({EV_STOCK_PIXMAPS_IMP}.no_cursor_xpm)
				when {EV_POINTER_STYLE_CONSTANTS}.sizeall_cursor then
					set_from_xpm_data ({EV_STOCK_PIXMAPS_IMP}.sizeall_cursor_xpm)
				when {EV_POINTER_STYLE_CONSTANTS}.sizenesw_cursor then
					set_from_xpm_data ({EV_STOCK_PIXMAPS_IMP}.sizenesw_cursor_xpm)
				when {EV_POINTER_STYLE_CONSTANTS}.sizens_cursor then
					set_from_xpm_data ({EV_STOCK_PIXMAPS_IMP}.sizens_cursor_xpm)
				when {EV_POINTER_STYLE_CONSTANTS}.sizenwse_cursor then
					set_from_xpm_data ({EV_STOCK_PIXMAPS_IMP}.sizenwse_cursor_xpm)
				when {EV_POINTER_STYLE_CONSTANTS}.sizewe_cursor then
					set_from_xpm_data ({EV_STOCK_PIXMAPS_IMP}.sizewe_cursor_xpm)
				when {EV_POINTER_STYLE_CONSTANTS}.uparrow_cursor then
					set_from_xpm_data ({EV_STOCK_PIXMAPS_IMP}.uparrow_cursor_xpm)
				when {EV_POINTER_STYLE_CONSTANTS}.standard_cursor then
					set_from_xpm_data ({EV_STOCK_PIXMAPS_IMP}.standard_cursor_xpm)
				else
					set_size (a_pointer_style.width, a_pointer_style.height)
					clear
				end
			else
				todo_class_line ("__EV_PIXMAP_IMP__", "__LINE__ ?")

--				l_pixbuf := a_pointer_style_imp.gdk_pixbuf
--				if l_pixbuf /= default_pointer then
--					set_pixmap_from_pixbuf (a_pointer_style_imp.gdk_pixbuf)
--				else
--					set_size (a_pointer_style.width, a_pointer_style.height)
--					clear
--				end
			end
		end

	init_from_pixel_buffer (a_pixel_buffer: EV_PIXEL_BUFFER) is
			-- Initialize from `a_pixel_buffer'
		local
			l_pixel_buffer_imp: EV_PIXEL_BUFFER_IMP
		do
--			l_pixel_buffer_imp ?= a_pixel_buffer.implementation
--			set_pixmap_from_pixbuf (l_pixel_buffer_imp.gdk_pixbuf)
		end

feature -- Drawing operations

	redraw is
			-- Force `Current' to redraw itself.
		do
			update_if_needed
		end

	flush is
			-- Ensure that the appearance of `Current' is updated on screen
			-- immediately. Any changes that have not yet been reflected will
			-- become visible.
		do
			refresh_now
		end

	update_if_needed is
			-- Update `Current' if needed.
		do
			if is_displayed then
				todo_class_line ("EV_PIXMAP_IMP", "LINE #3")
			end
		end

feature -- Measurement

	width: INTEGER is
			-- Width of the pixmap in pixels.
		local
			a_y: INTEGER
		do
			Result := sb_pixmap_window.width
		end

	height: INTEGER is
			-- height of the pixmap.
		local
			a_x: INTEGER
		do
			Result := sb_pixmap_window.height
		end

feature -- Element change

	read_from_named_file (file_name: STRING_GENERAL) is
			-- Attempt to load pixmap data from a file specified by `file_name'.
		do
			todo_class_line ("__EV_PIXMAP_IMP__", "__LINE__ 6")
		end

	set_with_default is
			-- Initialize the pixmap with the default
			-- pixmap (Vision2 logo)
		do
--			set_from_xpm_data (default_pixmap_xpm)
		end

	stretch (a_x, a_y: INTEGER) is
			-- Stretch the image to fit in size `a_x' by `a_y'.
		local
			a_gdkpixbuf, scaled_pixbuf: POINTER
			a_scale_type: INTEGER
			l_width, l_height: INTEGER
		do
			todo_class_line ("__EV_PIXMAP_IMP__", "__LINE__ 7")
		end

	set_size (a_width, a_height: INTEGER) is
			-- Set the size of the pixmap to `a_width' by `a_height'.
		local
			oldpix, oldmask: POINTER
			l_width, l_height: INTEGER
			pixgc, maskgc: POINTER
			loc_default_pointer: POINTER
		do
			todo_class_line ("__EV_PIXMAP_IMP__", "__LINE__ 8")
		end

	reset_for_buffering (a_width, a_height: INTEGER) is
			-- Resets the size of the pixmap without keeping original image or clearing background.
		local
			gdkpix: POINTER
		do
			if a_width /= width or else a_height /= height then
				todo_class_line ("__EV_PIXMAP_IMP__", "__LINE__ 9")
			end
		end

	set_mask (a_mask: EV_BITMAP) is
			-- Set the GdkBitmap used for masking `Current'.
		local
			a_mask_imp: EV_BITMAP_IMP
		do
			todo_class_line ("__EV_PIXMAP_IMP__", "__LINE__ 10")
		end

feature -- Access

	raw_image_data: EV_RAW_IMAGE_DATA is
		do
			todo_class_line ("__EV_PIXMAP_IMP__", "__LINE__ 11")
		end

feature -- Duplication

	copy_pixmap (other: EV_PIXMAP) is
			-- Update `Current' to have same appearance as `other'.
			-- (So as to satisfy `is_equal'.)
		local
			other_imp: EV_PIXMAP_IMP
		do
			todo_class_line ("__EV_PIXMAP_IMP__", "__LINE__ 12")
		end

feature {EV_STOCK_PIXMAPS_IMP, EV_PIXMAPABLE_IMP, EV_PIXEL_BUFFER_IMP} -- Implementation

	set_pixmap (gdkpix, gdkmask: POINTER) is
			-- Set the GtkPixmap using Gdk pixmap data and mask.
		do
			todo_class_line ("__EV_PIXMAP_IMP__", "__LINE__ 15")
		end

	set_from_xpm_data (a_xpm_data: POINTER) is
			-- Pixmap symbolizing a piece of information.
		require
			xpm_data_not_null: a_xpm_data /= NULL
		local
			gdkpix, gdkmask: POINTER
		do
			todo_class_line ("__EV_PIXMAP_IMP__", "__LINE__ 16")
		end

	set_from_stock_id (a_stock_id: POINTER) is
			-- Pixmap symbolizing a piece of information
		require
			a_stock_id_not_null: a_stock_id /= NULL
		local
			stock_pixbuf: POINTER
		do
			todo_class_line ("__EV_PIXMAP_IMP__", "__LINE__ 17")
		end

feature {EV_INTERMEDIARY_ROUTINES} -- Implementation

	call_expose_actions (a_x, a_y, a_width, a_height: INTEGER) is
			-- Call the expose actions for the drawing area.
		do
			if expose_actions_internal /= Void then
				expose_actions_internal.call ([a_x, a_y, a_width, a_height])
			end
		end

feature {NONE} -- Implementation

	save_to_named_file (a_format: EV_GRAPHICAL_FORMAT; a_filename: FILE_NAME) is
			-- Save `Current' in `a_format' to `a_filename'
		local
			a_gdkpixbuf, stretched_pixbuf: POINTER
			a_gerror: POINTER
--			a_handle, a_filetype: EV_GTK_C_STRING
		do
			if app_implementation.writeable_pixbuf_formats.has (a_format.file_extension.as_upper) then
					-- Perform custom saving with GdkPixbuf
				-- todo_class_line
			else
				-- If Gtk cannot save the file then the default is called
				Precursor {EV_PIXMAP_I} (a_format, a_filename)
			end
		end

	destroy is
			-- Destroy the pixmap and resources.
		do
--			set_pixmap (NULL, NULL)
			-- todo_class_line
			Precursor {EV_PRIMITIVE_IMP}
		end

	dispose is
			-- Clear up resources if needed in object disposal.
		do
			-- TODO
			Precursor {EV_PRIMITIVE_IMP}
		end

feature {NONE} -- Constants

	Default_color_depth: INTEGER = -1
			-- Default color depth, use the one from gdk_root_parent.

	Monochrome_color_depth: INTEGER = 1
			-- Black and White color depth (for mask).

feature {EV_ANY_I} -- Implementation

	interface: EV_PIXMAP;

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

end -- EV_PIXMAP_IMP

