note

	description: "[
				Drawable is an abstract base class for any surface that can be
				drawn upon, such as a SB_WINDOW, or SB_IMAGE.
	]"

	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"
	TODO:	"[
		Define set_width and set_height inherited, respectively,
		from SB_PV_WIDTH, SB_PV_HEIGHT
	]"

deferred class
	EV_DRAWABLE_IMP_DEF

inherit

	EV_ANY_IMP
		redefine
			interface
		end

	EV_DRAWABLE_I
		redefine
			interface
		end

	EV_DRAWABLE_CONSTANTS

	DISPOSABLE
		undefine
			copy,
			default_create
		end

	PLATFORM
		undefine
			copy,
			default_create
		end


-----------------------------------
	SB_SERVER_RESOURCE
      	redefine
         	destruct
      	end

	SB_PROPERTIES
		redefine
			add_properties
		end

	SB_PV_WIDTH
	SB_PV_HEIGHT

	SB_COMMON_MACROS

	SB_DEFS

feature {NONE} -- Implementation

--	app_implementation: EV_APPLICATION_IMP is
--			-- Return the instance of EV_APPLICATION_IMP.
--		deferred
--		end

	internal_foreground_color: EV_COLOR
			-- Color used to draw primitives.

	internal_background_color: EV_COLOR
			-- Color used for erasing of canvas.
			-- Default: white.

	flush
			-- Force all queued expose events to be called.
		deferred
		end

	update_if_needed
			-- Force update of `Current' if needed
		deferred
		end

	whole_circle: INTEGER = 23040
		-- Number of 1/64 th degrees in a full circle (360 * 64)

	radians_to_gdk_angle: INTEGER = 3667 --
			-- Multiply radian by this to get no of (1/64) degree segments.

	internal_font_imp: EV_FONT_IMP

	interface: EV_DRAWABLE

feature -- Attributes

	visual: SB_VISUAL
		-- Visual for this window

feature -- Actions

	set_visual (a_visual: SB_VISUAL)
			-- Change visual
		require
			a_visual /= Void
			not is_attached
      	do
      		visual := a_visual
		end

	resize (w, h: INTEGER)
    		--  Resize drawable to the specified width and height
    	do
        	set_width  (w.max (1))
        	set_height (h.max (1))
      	end

feature -- Destruction

	destruct
		do
			visual := Void
			Precursor
		end

feature -- Properties

	add_properties
		do
			Precursor
			add_property_width
			add_property_height
		end


--feature {NONE} -- Implementation

--	make (w, h: INTEGER )
--		do
----print ("Entering SB_DRAWABLE_DEF.make ...%N")
--			init_resource
--			visual := application.default_visual
--			width_sb := w.max (1)
--			height_sb := h.max (1)
----print ("Leaving SB_DRAWABLE_DEF.make ...%N")
--		end

	paint_dc: SB_DC_WINDOW
		once
			create Result.make_once
		end

--invariant
--	good_width: width >= 0
--	good_height: height >= 0
--end

end
