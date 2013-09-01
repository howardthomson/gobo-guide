note
	description: "[
				An Icon is an image with two additional server-side resources: a shape
				bitmap, which is used to mask those pixels where the background should
				be preserved during the drawing, and an etch bitmap, which is used to
				draw the icon when it is disabled.
				]"

	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Initial stub implementation"

deferred class SB_ICON_DEF

inherit

	SB_IMAGE
		rename
			make_opts as image_make_opts
		undefine
        	create_resource_imp,
        	destroy_resource_imp,
        	resize_imp
		redefine
        	make,
        	create_resource,
        	destroy_resource,
        	detach_resource,
        	destruct,
        	resize
      	end

feature {SB_DC, SB_DC_WINDOW, SB_DRAWABLE, SB_TOP_WINDOW} -- Attributes, restricted

   shape: like resource_id;
         -- Shape pixmap

   etch: like resource_id;
         -- Etch pixmap

feature -- Creation

	make (a: SB_APPLICATION; pix: ARRAY [ INTEGER_8 ])
    	do
			make_opts (a, pix, 0, Zero, 1, 1);
      	end

  	make_opts (a: SB_APPLICATION; pix: ARRAY [ INTEGER_8 ]; clr: INTEGER; opts: INTEGER; w, h: INTEGER)
         -- Create an icon with an initial pixel buffer pix, a transparent color clr,
         -- and options as in FXImage.  The transparent color is used to detemine which
         -- pixel values are transparent, i.e. need to be masked out in the absence of
         -- a true alpha channel.
         -- If the flag IMAGE_OPAQUE is passed, the shape and etch bitmaps are generated
         -- as if the image is fully opaque, even if it has an alpha channel or transparancy
         -- color.  The flag IMAGE_ALPHACOLOR is used to force a specific alpha color instead
         -- of the alpha color specified in the image file format.
         -- Specifying IMAGE_ALPHAGUESS causes Icon to obtain the alpha color from the background
         -- color of the image.
      	do
         	image_make_opts (a, pix, opts, w,h)
         	shape := default_resource
         	etch := default_resource
         	transparent_color := clr
      	end

feature -- Data

   	transparent_color: INTEGER
		-- Transparency color

feature -- Resource management

	create_resource
			-- Create the icon resource
		do
			if not is_attached then
				if application.initialized then
					create_resource_imp
						-- Render pixels
					render
						-- Zap data
					if (options & IMAGE_KEEP) = Zero and then (options & IMAGE_OWNED) /= Zero then
						options := options & (IMAGE_OWNED).bit_not
						data := Void
					end
				end
			end
		end

	detach_resource
			-- Detach the icon resource
		do
        	visual.detach_resource
         	if is_attached then
            	shape := default_resource
            	etch := default_resource
            	reset_resource_id
            	Precursor
			end
      	end

   destroy_resource
         	-- Destroy the icon resource
		do
         	if not is_attached then
            	if application.initialized then
					destroy_resource_imp
            	end
            	shape := default_resource
            	etch := default_resource
            	reset_resource_id
			end
		end

feature -- Actions

   resize (w_, h_: INTEGER)
         -- Resize pixmap to the specified width and height
      local
         w,h: INTEGER;
      do
         if w_ < 1 then
            w := 1
         else
            w := w_
         end
         if h_ < 1 then
            h := 1
         else
            h := h_
         end
         if width /= w or else height /= h then

            	-- Resize device dependent pixmap
            if is_attached then
				resize_imp (w, h)
            end
            	-- Resize data array iff total size changed
            if data /= Void and then (w * h) /= (width * height) then
               if (options & IMAGE_OWNED) /= Zero then
                  data.resize (1, w * h * channels)
               else
                  create data.make (1, w * h * channels)
                  options := options | IMAGE_OWNED
               end
            end

            	-- Remember new size
  --          width := w
    --        height := h
         end
      end

	set_transparent_color (color: INTEGER)
			-- Change transparency color
		do
			transparent_color := color
		end

feature {SB_DC, SB_DC_WINDOW, SB_DRAWABLE, SB_TOP_WINDOW} -- Implementation

	guesstransp: INTEGER
    	local
			tr, bl, br, best, t: INTEGER
			color: ARRAY [ INTEGER ]
		do
			Result := sbrgb (192, 192, 192)
			create color.make (0, 3)
			if data /= Void and then 0 < width and then 0 < height then
				best := -1
				if (options & IMAGE_ALPHA) /= Zero then
					tr := 4 * (width - 1) + data.lower
					bl := 4 * width * (height - 1) + data.lower
					br := bl + tr - data.lower
				else
					tr := 3 * (width - 1) + data.lower
					bl := 3 * width * (height - 1) + data.lower
					br := bl + tr - data.lower
				end
				color.put (sbrgb (data.item (data.lower  ).to_integer,
								  data.item (data.lower+1).to_integer,
								  data.item (data.lower+2).to_integer), 0)
				color.put (sbrgb (data.item (tr  ).to_integer,
								  data.item (tr+1).to_integer,
								  data.item (tr+2).to_integer), 1)
				color.put (sbrgb (data.item (bl  ).to_integer,
								  data.item (bl+1).to_integer,
								  data.item (bl+2).to_integer), 2)
				color.put (sbrgb (data.item (br  ).to_integer,
								  data.item (br+1).to_integer,
								  data.item (br+2).to_integer), 3)

				if color.item (0) = color.item (1) then t := 1 else t := 0 end
            	if color.item (0) = color.item (2) then t := t + 1 end
            	if color.item (0) = color.item (3) then t := t + 1 end
            	if t > best then
               		Result := color.item (0)
               		best := t
            	end

            	if color.item (1) = color.item (2) then t := 1 else t := 0 end
            	if color.item (1) = color.item (3) then t := t + 1 end
            	if color.item (1) = color.item (0) then t := t + 1 end
            	if  t > best then
            		Result := color.item(1)
            		best := t
            	end

            	if color.item (2) = color.item (3) then t := 1 else t := 0 end
            	if color.item (2) = color.item (0) then t := t + 1 end
            	if color.item (2) = color.item (1) then t := t + 1 end
            	if  t > best then
            		Result := color.item(2)
            		best := t
            	end

            	if color.item (3) = color.item (0) then t := 1 else t := 0 end
            	if color.item (3) = color.item (1) then t := t + 1 end
            	if color.item (3) = color.item (2) then t := t + 1 end
            	if  t > best then
            		Result := color.item (3)
            		best := t
            	end
			end
		end

feature -- Destruction

	destruct
		do
			destroy_resource
			Precursor
		end

end
