note
	description:
		"EiffelVision application, Slyboots implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "application"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_SB_DEPENDENT_APPLICATION_IMP

inherit
	IDENTIFIED
		undefine
			is_equal,
			copy
		end

	EV_APPLICATION_ACTION_SEQUENCES_IMP

	EXECUTION_ENVIRONMENT
		rename
			launch as ee_launch
		end

	PLATFORM

	EV_ANY_HANDLER

feature -- Initialize

	sb_dependent_initialize
			-- Slyboots dependent code for `initialize'
		do
				-- Initialize custom styles for gtk.
			initialize_combo_box_style
			initialize_tool_bar_style
		end

	sb_dependent_launch_initialize
			-- Slyboots dependent code for `launch'
		do
		end

feature -- Implementation

	pixel_value_from_point_value (a_point_value: INTEGER): INTEGER
			-- Returns the number of screen pixels represented by `a_point_value'
		do
			Result := ((a_point_value / 3 * 4) + 0.5).truncated_to_integer
		end

	point_value_from_pixel_value (a_pixel_value: INTEGER): INTEGER
			-- Returns the number of points represented by `a_pixel_value' screen pixels value
		do
			Result := ((a_pixel_value / 4 * 3) + 0.5).truncated_to_integer
		end

	writeable_pixbuf_formats: ARRAYED_LIST [STRING_32]
			-- Array of GdkPixbuf formats that Vision2 can save to on the gtk2.4.x platform
		once
			Result := pixbuf_formats (True)
			Result.compare_objects
		end

	readable_pixbuf_formats: ARRAYED_LIST [STRING_32]
			-- Array of GdkPixbuf formats that Vision2 can load to on the gtk2.4.x platform
		once
			Result := pixbuf_formats (False)
			Result.compare_objects
		end

	pixbuf_formats (a_writeable: BOOLEAN): ARRAYED_LIST [STRING_32]
			-- List of the readable formats available with current Gtk 2.0 library
		local
			formats: POINTER
			i,format_count: INTEGER
			format_name: STRING_32
			pixbuf_format: POINTER
			a_cs: EV_GTK_C_STRING
		do
			create Result.make (0)

			-- TODO
		end

	initialize_default_font_values
			-- Initialize values use for creating our default font
		local
			font_desc: STRING_32
			font_names, font_names_as_lower: ARRAYED_LIST [STRING_32]
			exit_loop: BOOLEAN
			split_values: LIST [STRING_32]
			i, l_font_names_count: INTEGER
			l_font_item: STRING_32
			l_sans: STRING_32
		do
			from
				font_desc := default_font_description.as_lower
				font_names_as_lower := font_names_on_system_as_lower
				font_names := font_names_on_system
				i := 1
				l_font_names_count := font_names.count
					-- A default is needed should no enumerable fonts be found on the system.
				l_sans := once "Sans"
				default_font_name_internal := l_sans
			until
				exit_loop or else i > l_font_names_count
			loop
				l_font_item := font_names_as_lower [i]
				if font_desc.substring_index (l_font_item, 1) = 1 then
					if default_font_name_internal = l_sans or else l_font_item.count > default_font_name_internal.count then
							default_font_name_internal := font_names [i]
					end
					exit_loop := default_font_name_internal.count = font_desc.count
						-- If the match is perfect then we exit, otherwise we keep looping for the best match.
				end
				i := i + 1
			end

			split_values := font_desc.split (' ')
			split_values.compare_objects
			default_font_point_height_internal := split_values.last.to_integer

			if split_values.has (once "italic") or else split_values.has (once "oblique") then
				default_font_style_internal := {EV_FONT_CONSTANTS}.shape_italic
			else
				default_font_style_internal := {EV_FONT_CONSTANTS}.shape_regular
			end

			if split_values.has (once "bold") then
				default_font_weight_internal := {EV_FONT_CONSTANTS}.weight_bold
			elseif split_values.has (once "light") then
				default_font_weight_internal := {EV_FONT_CONSTANTS}.weight_thin
			elseif split_values.has (once "superbold") then
				default_font_weight_internal := {EV_FONT_CONSTANTS}.weight_black
			else
				default_font_weight_internal := {EV_FONT_CONSTANTS}.weight_regular
			end
		end

	default_font_name: STRING_32
			-- Face name of the default font
		do
			if font_settings_changed then
				initialize_default_font_values
			end
			Result := default_font_name_internal
		end

	default_font_name_internal: STRING_32

	default_font_point_height: INTEGER
			-- Size of the default font in points
		do
			if font_settings_changed then
				initialize_default_font_values
			end
			Result := default_font_point_height_internal
		end

	default_font_point_height_internal: INTEGER

	default_font_style: INTEGER
			-- Style of the default font
		do
			if font_settings_changed then
				initialize_default_font_values
			end
			Result := default_font_style_internal
		end

	default_font_style_internal: INTEGER

	default_font_weight: INTEGER
			-- Weight of the default font
		do
			if font_settings_changed then
				initialize_default_font_values
			end
			Result := default_font_weight_internal
		end

	default_font_weight_internal: INTEGER

	font_settings_changed: BOOLEAN
			-- Have the default font settings been changed by the user
		do
			Result := False	-- FIXME
		end

	previous_font_settings: POINTER
		-- Pointer to the previous gtk-settings font value.

	c_strcmp (ptr1, ptr2: POINTER): INTEGER
		external
			"C inline use <string.h>"
		alias
			"return strcmp ((const char*) $ptr1, (const char*) $ptr2);"
		end

	default_font_description: STRING_32
			-- Description string of the current font used
		local
			font_name_ptr: POINTER
			a_cs: EV_GTK_C_STRING
		do
			-- FIXME

			if Result = Void or else Result.is_empty then
				Result := once "Sans 10"
			end
		end

	font_names_on_system: ARRAYED_LIST [STRING_32]
			-- Retrieve a list of all the font names available on the system
		local
			a_name_array: POINTER
			i, n_array_elements: INTEGER
			utf8_string: EV_GTK_C_STRING
		once
			retrieve_available_fonts (default_gtk_window, $a_name_array, $n_array_elements)
			create Result.make_filled (n_array_elements)
			from
				i := 1
					-- Create an initialize our reusable pointer.
				create utf8_string.set_with_eiffel_string ("")
			until
				i > n_array_elements
			loop
				utf8_string.share_from_pointer (gchar_array_i_th (a_name_array, i))
				Result.put_i_th (utf8_string.string, i)
				i := i + 1
			end
			Result.compare_objects
			a_name_array.memory_free
		end

	font_names_on_system_as_lower: ARRAYED_LIST [STRING_32]
			-- Retrieve a list of all the font names available on the system in lower case
			-- This is needed for easy case insensitive lookup in EV_FONT_IMP.
		local
			i, l_font_count: INTEGER
			l_font_names: like font_names_on_system
		once
			from
				i := 1
				l_font_names := font_names_on_system
				l_font_count := l_font_names.count
				create Result.make_filled (l_font_count)
			until
				i > l_font_count
			loop
				Result [i] := (l_font_names [i]).as_lower
				i := i + 1
			end
			Result.compare_objects
		end

	window_manager_name: STRING
			-- Name of Window Manager currently running.
		local
			l_display, l_screen, l_wm_name: POINTER
		do
--			l_display := {EV_GTK_EXTERNALS}.gdk_display_get_default
--			l_screen := {EV_GTK_EXTERNALS}.gdk_display_get_default_screen (l_display)
--			l_wm_name := {EV_GTK_EXTERNALS}.gdk_x11_screen_get_window_manager_name (l_screen)
--			create Result.make_from_c (l_wm_name)
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




end -- class EV_SB_DEPENDENT_APPLICATION_IMP

