note
	description: "[
		Bitmap is a one bit/pixel image used for patterning and
		stippling operations.
	]"
	author: "Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright: "Copyright (c) 2002, Eugene Melekhov and others"
	license: "Eiffel Forum Freeware License v2 (see forum.txt)"
	status: "Initial stub implementation"

deferred class SB_BITMAP_DEF

inherit

	SB_DRAWABLE
		rename
			make as make_drawable
    	redefine
   -- 		make,
        	destruct
      	end

	SB_OPTIONS

feature -- Creation

	make (a: SB_APPLICATION; pix: POINTER; opts: INTEGER; w,h: INTEGER)
		do
--			make_drawable (a, w,h)
--			visual := application.mono_visual
--			if pix /= default_pointer then
--				options := opts & (Bitmap_owned).bit_not
--			else
--				options := opts
--			end
--			data := pix
		ensure implemented: false
		end

feature -- Destruction

   	destruct
      	do
         	destroy_resource
         	Precursor
      	end

end
