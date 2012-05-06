indexing
	description: "Eiffel Vision font. GTK implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "character, face, height, family, weight, shape, bold, italic"
	date: "$Date: 2006-12-29 15:13:47 -0800 (Fri, 29 Dec 2006) $"
	revision: "$Revision: 65780 $"

class
	EV_FONT_IMP

inherit
 	EV_FONT_I
		redefine
			interface,
			set_values,
			string_size
		end

	DISPOSABLE

create
	make

feature {NONE} -- Initialization

 	old_make (an_interface: like interface) is
 			-- Create the default font.
		do
			base_make (an_interface)
		end

	make is
			-- Set up `Current'
		local
			l_app_imp: like app_implementation
		do
			l_app_imp := app_implementation
	--#		font_description := {EV_GTK_DEPENDENT_EXTERNALS}.pango_font_description_new
			create preferred_families
			family := Family_sans
	--#		set_face_name (l_app_imp.default_font_name)
	--#		set_height_in_points (l_app_imp.default_font_point_height_internal)
	--#		set_shape (l_app_imp.default_font_style_internal)
	--#		set_weight (l_app_imp.default_font_weight_internal)
			preferred_families.internal_add_actions.extend (agent update_preferred_faces)
			preferred_families.internal_remove_actions.extend (preferred_families.internal_add_actions.first)
			set_is_initialized (True)
		end

feature -- Access

	family: INTEGER
			-- Preferred font category.

	char_set: INTEGER
			-- Charset
			-- This is not meaningful on GTK.

	weight: INTEGER
			-- Preferred font thickness.

	shape: INTEGER
			-- Preferred font slant.

	height: INTEGER
			-- Preferred font height measured in screen pixels.

	height_in_points: INTEGER
			-- Preferred font height measured in points.

feature -- Element change

	set_family (a_family: INTEGER) is
			-- Set `a_family' as preferred font category.
		do
			family := a_family
			update_font_face
		end

	set_face_name (a_face: STRING_GENERAL) is
			-- Set the face name for current.
		local
--			propvalue: EV_GTK_C_STRING
		do
			name := a_face
--			propvalue := app_implementation.c_string_from_eiffel_string (a_face)
--			{EV_GTK_DEPENDENT_EXTERNALS}.pango_font_description_set_family (font_description, propvalue.item)
			calculate_font_metrics
		end

	set_weight (a_weight: INTEGER) is
			-- Set `a_weight' as preferred font thickness.
		do
			weight := a_weight
--			{EV_GTK_DEPENDENT_EXTERNALS}.pango_font_description_set_weight (font_description, pango_weight)
			calculate_font_metrics
		end

	set_shape (a_shape: INTEGER) is
			-- Set `a_shape' as preferred font slant.
		do
			shape := a_shape
--			{EV_GTK_DEPENDENT_EXTERNALS}.pango_font_description_set_style (font_description, pango_style)
			calculate_font_metrics
		end

	set_height (a_height: INTEGER) is
			-- Set `a_height' as preferred font size in screen pixels
		do
--			height_in_points := app_implementation.point_value_from_pixel_value (a_height)
			height  := a_height
--			{EV_GTK_DEPENDENT_EXTERNALS}.pango_font_description_set_size (font_description, height_in_points * {EV_GTK_DEPENDENT_EXTERNALS}.pango_scale)
			calculate_font_metrics
		end

	set_height_in_points (a_height: INTEGER) is
			-- Set `a_height' as preferred font size in screen pixels
		do
--			height_in_points := a_height
--			height := app_implementation.pixel_value_from_point_value (a_height)
--			{EV_GTK_DEPENDENT_EXTERNALS}.pango_font_description_set_size (font_description, height_in_points * {EV_GTK_DEPENDENT_EXTERNALS}.pango_scale)
			calculate_font_metrics
		end

	set_values (a_family, a_weight, a_shape, a_height: INTEGER;
		a_preferred_families: like preferred_families) is
			-- Set `a_family', `a_weight', `a_shape' `a_height' and
			-- `a_preferred_face' at the same time for speed.
		local
			a_agent: PROCEDURE [EV_FONT_IMP, TUPLE [STRING_32]]
		do
			ignore_font_metric_calculation := True
			a_agent := agent update_preferred_faces
			preferred_families.add_actions.wipe_out
			preferred_families.remove_actions.wipe_out
			preferred_families := a_preferred_families
			preferred_families.internal_add_actions.extend (a_agent)
			preferred_families.internal_remove_actions.extend (a_agent)
			set_family (a_family)
			set_weight (a_weight)
			set_shape (a_shape)
			set_height (a_height)
			ignore_font_metric_calculation := False
			calculate_font_metrics
		end

feature -- Status report

	name: STRING_32
			-- Face name chosen by toolkit.

	ignore_font_metric_calculation: BOOLEAN
			-- Should the font metric calculation be ignored?

	calculate_font_metrics is
			-- Calculate metrics for font
		local
			a_str_size: TUPLE [INTEGER, INTEGER, INTEGER, INTEGER, INTEGER]
			a_baseline, a_height: INTEGER
		do
			if not ignore_font_metric_calculation then
				a_str_size := string_size (once "Ag")
				a_baseline := a_str_size.integer_32_item (5)
				a_height := a_str_size.integer_32_item (2)
				ascent := a_baseline
				descent := a_height - ascent
			end
		end

	ascent: INTEGER
			-- Vertical distance from the origin of the drawing operation to the top of the drawn character.

	descent: INTEGER
			-- Vertical distance from the origin of the drawing operation to the bottom of the drawn character.

	width: INTEGER is
			-- Character width of current fixed-width font.
		do
			Result := string_width (once "x")
		end

	minimum_width: INTEGER is
			-- Width of the smallest character in the font.
		do
			Result := string_width (once "l")
		end

	maximum_width: INTEGER is
			-- Width of the biggest character in the font.
		do
			Result := string_width (once "W")
		end

	string_size (a_string: STRING_GENERAL): like reusable_string_size_tuple is
			-- `Result' is [width, height, left_offset, right_offset] in pixels of `a_string' in the
			-- current font, taking into account line breaks ('%N').
		do
			-- TODO
		end

	reusable_string_size_tuple: TUPLE [INTEGER, INTEGER, INTEGER, INTEGER, INTEGER, INTEGER, INTEGER] is
			-- Reusable tuple for `string_size'.
		once
			create Result
		end

	string_width (a_string: STRING_GENERAL): INTEGER is
			-- Width in pixels of `a_string' in the current font.
		do
			-- TODO
		end

	reusable_pango_rectangle_struct: POINTER is
			-- PangoRectangle that may be reused to prevent memory allocation, must not be freed
		once
--			Result := {EV_GTK_DEPENDENT_EXTERNALS}.c_pango_rectangle_struct_allocate
		end

	horizontal_resolution: INTEGER is
			-- Horizontal resolution of screen for which the font is designed.
		do
			Result := 75
		end

	vertical_resolution: INTEGER is
			-- Vertical resolution of screen for which the font is designed.
		do
			Result := 75
		end

	is_proportional: BOOLEAN is
			-- Can characters in the font have different sizes?
		do
			Result := True
		end

feature -- {EV_ANY_I} -- Implementation

	update_font_face is
		do
		end

	update_preferred_faces (a_face: STRING_32) is
		do
		end

feature {NONE} -- Implementation

	app_implementation: EV_APPLICATION_IMP is
			-- Return the instance of EV_APPLICATION_IMP.
		once
			Result ?= (create {EV_ENVIRONMENT}).application.implementation
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_FONT
		-- Interface coupling object for `Current'

	destroy is
			-- Flag `Current' as destroyed
		do
			set_is_destroyed (True)
		end

	dispose is
			-- Clean up `Current'
		do
		end

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




end -- class EV_FONT_IMP

