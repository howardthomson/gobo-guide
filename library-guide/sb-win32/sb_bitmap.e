indexing
	description: "[
   		Bitmap is a one bit/pixel image used for patterning
   		and stippling operations.
   		]"
	author: "Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright: "Copyright (c) 2002, Eugene Melekhov and others"
	license: "Eiffel Forum Freeware License v2 (see forum.txt)"
	status: "Initial stub implementation"

deferred class SB_BITMAP

inherit

   SB_DRAWABLE
      redefine
         destruct
      end

feature -- Destruction

   destruct is
      do
         destroy_resource
         Precursor;
      end

end
