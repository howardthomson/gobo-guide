note
	platform:	"Win32"

deferred class SB_DRAWABLE

inherit

	 SB_DRAWABLE_DEF

feature {SB_DC} -- Implementation

   get_dc: POINTER
      do
      end

   release_dc(dc: POINTER): INTEGER
      do
      end
	
end
