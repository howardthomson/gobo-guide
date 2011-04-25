note
	description:
		"Eiffel Vision colorizable. X11 implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "colorizable"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_COLORIZABLE_IMP

inherit

	EV_COLORIZABLE_I
		redefine
			interface,
			set_default_colors
		end

feature -- Access

	foreground_color_internal: EV_COLOR is
			-- Color of foreground features like text.
		local
			color: POINTER
		do
			if foreground_color_imp /= Void then
				Result := foreground_color_imp.interface.twin
			else
--				color := foreground_color_pointer
				create Result
--				Result.set_rgb_with_16_bit (
--					{EV_GTK_EXTERNALS}.gdk_color_struct_red (color),
--					{EV_GTK_EXTERNALS}.gdk_color_struct_green (color),
--					{EV_GTK_EXTERNALS}.gdk_color_struct_blue (color)
--				)
			end
		end

	background_color_internal: EV_COLOR is
			-- Color of face.
		local
			color: POINTER
		do
			if background_color_imp /= Void then
				Result := background_color_imp.interface.twin
			else
--				color := background_color_pointer
				create Result
--				Result.set_rgb_with_16_bit (
--					{EV_GTK_EXTERNALS}.gdk_color_struct_red (color),
--					{EV_GTK_EXTERNALS}.gdk_color_struct_green (color),
--					{EV_GTK_EXTERNALS}.gdk_color_struct_blue (color)
--				)
			end
		end

feature -- Status setting

	set_foreground_color (a_color: EV_COLOR) is
			-- Assign `a_color' to `foreground_color'
		do
		end

	set_background_color (a_color: EV_COLOR) is
			-- Assign `a_color' to `background_color'
		do
		end

	set_default_colors is
			-- Set foreground and background color to their default values.
		do
			background_color_imp := Void
			foreground_color_imp := Void
--			real_set_foreground_color (visual_widget, Void)
--			real_set_background_color (visual_widget, Void)
		end

feature {NONE} -- Implementation

	background_color_imp: EV_COLOR_IMP
		-- Color used for the background of `Current'

	foreground_color_imp: EV_COLOR_IMP
		-- Color used for the foreground of `Current'

	Prelight_scale: REAL is 1.0909488
		-- Prelight color is this much lighter than `background_color'.

	Highlight_scale: REAL is 0.90912397
		-- Highlight color is this much darker than `background_color'.

feature {EV_ANY_I} -- Implementation

	interface: EV_COLORIZABLE;

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

end -- EV_COLORIZABLE_IMP

