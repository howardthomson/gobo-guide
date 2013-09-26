note
	description:"Visual describes pixel format of a drawable"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Partly complete"

deferred class SB_VISUAL_DEF

inherit

	SB_SERVER_RESOURCE
      	redefine
         	destruct
      	end

   	SB_VISUAL_CONSTANTS

	SB_COMMON_MACROS
	SB_SHARED_APPLICATION

feature { NONE } -- Creation

	make (a_flags: INTEGER)
		do
			make_with_depth (a_flags, 32)
		end

	make_with_depth (a_flags: INTEGER; a_depth_hint: INTEGER)
		do
			init_resource
			flags := a_flags
			depth_hint := a_depth_hint.max (1)
			maxcolors := 1000000
			type := VISUALTYPE_UNKNOWN
			make_imp
		end

	make_imp
		deferred
		end

feature

	create_resource
			-- Create resource
		do
--print ("Create resource in SB_VISUAL_DEF%N")
			if not is_attached then
				if application.initialized then
					create_resource_imp
				end
			end
		end

	create_resource_imp
		deferred
		end

   destroy_resource
         -- Destroy resource
      do
         if is_attached then
            if application.initialized then
				destroy_resource_imp
            end
            detach_resource
         end
      end

	destroy_resource_imp
		deferred
		end

feature

   set_max_colors (a_maxcols : INTEGER)
         -- Set maximum number of colors to allocate
      do
         if a_maxcols < 2 then
            maxcolors := 2
         else
            maxcolors := a_maxcols
         end
      end

feature -- Destruction

   destruct
      do
         destroy_resource
         Precursor
      end


feature {ANY} -- Implementation

	flags: INTEGER
			-- Visual flags

	depth_hint: INTEGER
			-- Depth Hint

	depth: INTEGER
			-- Visual depth, bits/pixel

	red_count: INTEGER
			-- Number of reds

	green_count: INTEGER
			-- Number of greens

	blue_count: INTEGER
			-- Number of blues

	color_count: INTEGER
			-- Total number of colors

	maxcolors: INTEGER
			-- Maximum number of colors

	rgb_order: INTEGER
			-- Order of red/green/blue

	type: INTEGER
			-- Visual type

end
