note

	C_struct: "[
		typedef struct tagBITMAPINFOHEADER {
			DWORD	biSize;
			LONG	biWidth;
			LONG	biHeight;
			WORD	biPlanes;
			WORD	biBitCount;
			DWORD	biCompression;
			DWORD	biSizeImage;
			LONG	biXPelsPerMeter;
			LONG	biYPelsPerMeter;
			DWORD	biClrUsed;
			DWORD	biClrImportant;
		} BITMAPINFOHEADER, *LPBITMAPINFOHEADER, *PBITMAPINFOHEADER;
	]"

class SB_WAPI_BITMAPINFOHEADER

inherit

	SB_WAPI_STRUCT
		redefine
			make
		end

create

   make

feature {NONE} -- Initialization

	make
		do
			Precursor
			set_biSize (external_size)
		end

feature

	external_size: INTEGER 
		external
			"C macro use <wingdi.h>"	-- Use ??
		alias
			"sizeof(BITMAPINFOHEADER)"
		end
   

feature -- Access

	biSize: INTEGER
		do
			Result := c_size (ptr)
		end

	biWidth: INTEGER
		do
			Result := c_width (ptr)
		end

	biHeight: INTEGER
		do
			Result := c_height (ptr)
		end

	biPlanes: INTEGER
		do
			Result := c_planes (ptr)
		end

	biBitCount: INTEGER
		do
			Result := c_bit_count (ptr)
		end

	biCompression: INTEGER
		do
			Result := c_compression (ptr)
		end

	biSizeImage: INTEGER
		do
			Result := c_size_image (ptr)
		end

	biXPelsPerMeter: INTEGER
		do
			Result := c_x_pels_per_meter (ptr)
		end

	biYPelsPerMeter: INTEGER
		do
			Result := c_y_pels_per_meter (ptr)
		end

	biClrUsed: INTEGER
		do
			Result := c_clr_used (ptr)
		end

	biClrImportant: INTEGER
		do
			Result := c_clr_important (ptr)
		end

feature -- Update

	set_biSize (a_size: INTEGER)
		do
			c_set_size (ptr, a_size)
		ensure
			value_set: biSize = a_size
		end

	set_biWidth (a_width: INTEGER)
		do
			c_set_width (ptr, a_width)
		ensure
			value_set: biWidth = a_width
		end

	set_biHeight (a_height: INTEGER)
		do
			c_set_height (ptr, a_height)
		ensure
			value_set: biHeight = a_height
		end

	set_biPlanes (a_planes: INTEGER)
		do
			c_set_planes (ptr, a_planes)
		ensure
			value_set: biPlanes = a_planes
		end
      
	set_biBitCount (a_bit_count: INTEGER)
		do
		c_set_bit_count (ptr, a_bit_count)
		ensure
			value_set: biBitCount = a_bit_count
		end

	set_biCompression (a_compression: INTEGER)
		do
			c_set_compression (ptr, a_compression)
		ensure
			value_set: biCompression = a_compression
		end

	set_biSizeImage (a_size_image: INTEGER)
		do
			c_set_size_image (ptr, a_size_image)
		ensure
			value_set: biSizeImage = a_size_image
		end

	set_biXPelsPerMeter (a_pels_per_meter: INTEGER)
		do
			c_set_x_pels_per_meter (ptr, a_pels_per_meter)
		ensure
			value_set: biXPelsPerMeter = a_pels_per_meter
		end

	set_biYPelsPerMeter (a_pels_per_meter: INTEGER)
		do
			c_set_y_pels_per_meter (ptr, a_pels_per_meter)
		ensure
			value_set: biYPelsPerMeter = a_pels_per_meter
		end

	set_biClrUsed (a_clr_used: INTEGER)
		do
			c_set_clr_used (ptr, a_clr_used)
		ensure
			value_set: biClrUsed = a_clr_used
		end

	set_biClrImportant (a_clr_important: INTEGER)
		do
			c_set_clr_important (ptr, a_clr_important)
		ensure
			value_set: biClrImportant = a_clr_important
		end

feature {NONE} -- Implementation

	c_size					(p: POINTER): INTEGER    external "C struct BITMAPINFOHEADER access biSize			use <wingdi.h>" end
	c_width					(p: POINTER): INTEGER    external "C struct BITMAPINFOHEADER access biWidth			use <wingdi.h>" end
	c_height				(p: POINTER): INTEGER    external "C struct BITMAPINFOHEADER access biHeight			use <wingdi.h>" end
	c_planes				(p: POINTER): INTEGER    external "C struct BITMAPINFOHEADER access biPlanes			use <wingdi.h>" end
	c_bit_count				(p: POINTER): INTEGER    external "C struct BITMAPINFOHEADER access biBitCount		use <wingdi.h>" end
	c_compression			(p: POINTER): INTEGER    external "C struct BITMAPINFOHEADER access biCompression	use <wingdi.h>" end
	c_size_image			(p: POINTER): INTEGER    external "C struct BITMAPINFOHEADER access biSizeImage		use <wingdi.h>" end
	c_x_pels_per_meter		(p: POINTER): INTEGER    external "C struct BITMAPINFOHEADER access biXPelsPerMeter	use <wingdi.h>" end
	c_y_pels_per_meter		(p: POINTER): INTEGER    external "C struct BITMAPINFOHEADER access biYPelsPerMeter	use <wingdi.h>" end
	c_clr_used				(p: POINTER): INTEGER    external "C struct BITMAPINFOHEADER access biClrUsed		use <wingdi.h>" end
	c_clr_important			(p: POINTER): INTEGER    external "C struct BITMAPINFOHEADER access biClrImportant	use <wingdi.h>" end
	
	c_set_size				(p: POINTER; i: INTEGER)    external "C struct BITMAPINFOHEADER access biSize			type int use <wingdi.h>" end
	c_set_width				(p: POINTER; i: INTEGER)    external "C struct BITMAPINFOHEADER access biWidth			type int use <wingdi.h>" end
	c_set_height			(p: POINTER; i: INTEGER)    external "C struct BITMAPINFOHEADER access biHeight			type int use <wingdi.h>" end
	c_set_planes			(p: POINTER; i: INTEGER)    external "C struct BITMAPINFOHEADER access biPlanes			type int use <wingdi.h>" end
	c_set_bit_count			(p: POINTER; i: INTEGER)    external "C struct BITMAPINFOHEADER access biBitCount		type int use <wingdi.h>" end
	c_set_compression		(p: POINTER; i: INTEGER)    external "C struct BITMAPINFOHEADER access biCompression		type int use <wingdi.h>" end
	c_set_size_image		(p: POINTER; i: INTEGER)    external "C struct BITMAPINFOHEADER access biSizeImage		type int use <wingdi.h>" end
	c_set_x_pels_per_meter	(p: POINTER; i: INTEGER)    external "C struct BITMAPINFOHEADER access biXPelsPerMeter	type int use <wingdi.h>" end
	c_set_y_pels_per_meter	(p: POINTER; i: INTEGER)    external "C struct BITMAPINFOHEADER access biYPelsPerMeter	type int use <wingdi.h>" end
	c_set_clr_used			(p: POINTER; i: INTEGER)    external "C struct BITMAPINFOHEADER access biClrUsed			type int use <wingdi.h>" end
	c_set_clr_important		(p: POINTER; i: INTEGER)    external "C struct BITMAPINFOHEADER access biClrImportant	type int use <wingdi.h>" end

end

