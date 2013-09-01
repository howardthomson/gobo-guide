note
	description:	"[
		An Image is a rectangular array of pixels.  It supports two representations
		of these pixels: a client-side pixel buffer which is stored as an array of
		RGB or RGBA (if IMAGE_ALPHA is true) tuples, and a server-side pixmap which
		is stored in an organization directly compatible with the screen, for fast
		drawing onto the device.  The server-side representation is not directly
		accessible from the current process as it lives in the process of the
		X Server or GDI.
	]"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Initial stub implementation"

deferred class SB_IMAGE_DEF

inherit

	SB_DRAWABLE
		rename
			make as drawable_make
		redefine
			detach_resource,
			destruct,
			resize
		end

	SB_IMAGE_CONSTANTS

	SB_VISUAL_CONSTANTS

	SB_OPTIONS
		rename
			set_options as set_options_unused	-- from SB_OPTIONS
		export {ANY}
			options
		end

	SB_EXPANDED

feature -- Data

	data: ARRAY [ INTEGER_8 ]
			-- Pixel data

	channels: INTEGER
			-- Number of channels 3 or 4

feature -- Creation

	make_ev
		do
			make_opts (Void, Void, Zero, 1, 1)
		end

	make (a: SB_APPLICATION; a_data: ARRAY [ INTEGER_8 ])
			-- Create an image
		do
			make_opts (a, a_data, Zero, 1, 1)
		end

   	make_opts (a: SB_APPLICATION; a_data: ARRAY[ INTEGER_8 ]; opts: INTEGER; w,h: INTEGER)
         	-- Create an image
      	require
         	a /= Void
			a_data /= Void implies (((opts & IMAGE_ALPHA) /= Zero and then a_data.count = w * h * 4)
							 or else((opts & IMAGE_ALPHA)  = Zero and then a_data.count = w * h * 3))
      	do
         	drawable_make (w, h)
         	visual := application.default_visual
         	if (opts & IMAGE_ALPHA) /= Zero then
            	channels := 4
         	else
            	channels := 3
         	end
         	if a_data = Void and then (opts & IMAGE_OWNED) /= Zero then
            	create data.make (1, width * height * channels)
         	else
            	data := a_data
         	end
         	options := opts
      	end

feature -- option routines

    keep_image: BOOLEAN
		do
        	Result := test_options (IMAGE_KEEP)
		end

	data_owned: BOOLEAN
		do
			Result := test_options (IMAGE_OWNED)
		end

	is_opaque: BOOLEAN
		do
			Result := test_options(IMAGE_OPAQUE)
		end

feature -- Queries

	get_pixel (x, y: INTEGER): INTEGER
			-- Get pixel at x,y
		require
			data_not_void: data /= Void
			sufficient_bytes: ((options & IMAGE_ALPHA) /= Zero and then (y * width + x) * 4 + data.lower <= data.upper)
					  or else ((options & IMAGE_ALPHA)  = Zero and then (y * width + x) * 3 + data.lower <= data.upper)
		local
			b1: INTEGER
			b2: INTEGER
			b3: INTEGER
			b4: INTEGER
			t: INTEGER
		do
         	if (options & IMAGE_ALPHA) /= Zero then
      			t := (y * width + x) * 4 + data.lower
            	b1 := data.item(t)
            	b2 := data.item(t+1)
            	b3 := data.item(t+2)
            	b4 := data.item(t+3)
            	Result := (b1
            			 | b2 |<< 8
            			 | b3 |<< 16
            			 | b4 |<< 24)
         	else
            	t := (y * width + x) * 3 + data.lower
            --	Result := sbrgb (data.item(t).to_integer,data.item(t+1).to_integer,
            --			data.item(t+2).to_integer);
         	end
		ensure implemented: false
		end

feature -- Actions

   set_options (opts_: INTEGER)
         -- Change options
      local
         opts: INTEGER
         old_data: ARRAY [ INTEGER_8 ]
         pa, pb, pe: INTEGER
      do
         opts := opts_ & (IMAGE_OWNED).bit_not
         if opts /= options then
            if (opts & IMAGE_ALPHA) /= Zero and then (options & IMAGE_ALPHA) = Zero then
               -- Had no alpha, but now we do
               old_data := data
               create data.make (1, width * height * 4)
               from
                  pa := data.lower
                  pb := old_data.lower
                  pe := width * height * 4
               until
                  pa > pe
               loop
                  data.put (old_data.item (pb + 0), pa + 0)
                  data.put (old_data.item (pb + 1), pa + 1)
                  data.put (old_data.item (pb + 2), pa + 2)
                  data.put (0xff, pa + 3)
                  pa := pa + 4
                  pb := pb + 3
               end
               opts := opts | IMAGE_OWNED
               channels := 4
            elseif (opts & IMAGE_ALPHA) = Zero and then (options & IMAGE_ALPHA) /= Zero then
               -- Had alpha, but now we don't
               old_data := data
               create data.make (1, width * height * 3)
               from
                  pa := 1
                  pb := old_data.lower
                  pe := width * height * 3
               until
                  pa > pe
               loop
                  data.put (old_data.item (pb + 0), pa + 0)
                  data.put (old_data.item (pb + 1), pa + 1)
                  data.put (old_data.item (pb + 2), pa + 2)
                  pa := pa + 3
                  pb := pb + 4
               end
               opts := opts | IMAGE_OWNED
               channels := 3
            end
            -- Set options
            options := opts
         end
      end

   put_pixel,
   set_pixel (x, y, color: INTEGER)
      require
         data /= Void
         	and then (((options & IMAGE_ALPHA) /= Zero
         	and then (y*width+x)*4+data.lower <= data.upper)
            	or else((options & IMAGE_ALPHA) = Zero
                and then (y*width+x)*3+data.lower <= data.upper))
         -- Change pixel at x,y
      local
         t: INTEGER
         c: INTEGER
         b: INTEGER_8
      do
         if (options & IMAGE_ALPHA) /= Zero then
            t := (y * width + x) * 4 + data.lower;

            --	c.from_integer(color);
			--	b.from_integer((c & 0xff).to_integer);
            	data.put(b, t);

            --	b.from_integer((c^8 & 0xff).to_integer);
            	data.put(b, t+1);

            --	b.from_integer((c^16 & 0xff).to_integer);
            	data.put(b, t+2);

            --	b.from_integer((c^24 & 0xff).to_integer);
            	data.put(b, t+3);
         	else
            --	t := (y*width+x)*3 + data.lower;
            --	b.from_integer(sbredval(color));
            	data.put (b, t);
            --	b.from_integer(sbgreenval(color));
            	data.put (b, t+1);
            --	b.from_integer(sbblueval(color));
				data.put (b, t+2);
			end
		ensure implemented: false
		end

   	restore
         -- Restore client-side pixel buffer from image
      	require
         	width >= 1 and height >= 1
		deferred
      	end

   	render
         -- Render the image from client-side pixel buffer
      	require
         	width >= 1 and height >= 1
		deferred
      	end

	save_pixels (store: SB_STREAM)
			-- Save pixel data
		require
			data /= Void
		local
			i, e: INTEGER
		do
			from
				i := data.lower
				e := i + width * height * channels;
			until
				i >= e
			loop
				store.write_byte (data.item (i))
				i := i +1
			end
		end

   load_pixels (store: SB_STREAM)
         -- Load pixel data
      local
         i, e: INTEGER
         size: INTEGER
      do
         size := width * height * channels
         create data.make (1, size)
         from
            i := data.lower
            e := i + size
         until
            i >= e
         loop
            data.put (store.read_byte, i)
            i := i + 1;
         end
         options := options | IMAGE_OWNED
      end

feature -- Resource management

	create_resource
			-- Create image resource
		require else
			application /= Void
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

	create_resource_imp
		deferred
		end

   detach_resource
         -- Detach image resource
      do
         visual.detach_resource;
         if is_attached then
			detach_resource
         end
      end

   destroy_resource
         -- Destroy image resource
      do
         if is_attached then
            if application.initialized then
				destroy_resource_imp
            end
            resource_id := default_resource
         end
      end

	destroy_resource_imp
		deferred
		end

feature -- Transformation

   resize (a_w, a_h: INTEGER)
         -- Resize pixmap to the specified width and height
      local
         w, h: INTEGER
      do
         if a_w < 1 then
            w := 1
         else
            w := a_w
         end
         if a_h < 1 then
            h := 1
         else
            h := a_h
         end

         if width /= w or else height /= h then
            if is_attached then
				resize_imp (w, h)
            end
            if data /= Void then
               if (options & IMAGE_OWNED) = Zero then
                  -- Need to own array
                  create data.make (1, w * h * channels);
                  options := options | IMAGE_OWNED;
               elseif w*h /= width*height then
                  data.resize (1, w * h * channels)
               end
            end
        --    width := w
        --    height := h
         end
      end

	resize_imp (w, h: INTEGER)
		deferred
		end

   scale (a_w, a_h: INTEGER)
         -- Rescale pixels image to the specified width and height
      local
         w, h, ow, oh: INTEGER
         interim: ARRAY[INTEGER_8]
      do
         if a_w < 1 then
            w := 1
         else
            w := a_w
         end
         if a_h < 1 then
            h := 1
         else
            h := a_h
         end

         if w /= width or else h /= height then
            if data /= Void then
               ow := width
               oh := height
               		-- Allocate interim buffer
               create interim.make (1, w * oh * channels)
               		-- Scale horizontally first, placing result into interim buffer
               if w = ow then
                  mem.collection_off
         --#         mem.mem_copy(interim.to_external,data.to_external,w*oh*channels);
                  mem.collection_on
               elseif channels = 4 then
                  hscalergba (interim, data, w, oh, ow, oh)
               else
                  hscalergb (interim, data, w, oh, ow, oh)
               end

               	-- Resize the pixmap and target buffer
               resize (w, h)

               	-- Scale vertically from the interim buffer into target buffer
               if h = oh then
                  mem.collection_off
        --#          mem.mem_copy(data.to_external,interim.to_external,w*h*channels);
                  mem.collection_on
               elseif channels = 4 then
                  vscalergba (data, interim, w, h, w, oh)
               else
                  vscalergb (data, interim, w, h, w, oh)
               end
               render
            else
               resize (w, h)
            end
         end
		ensure implemented: false
      end

   mirror (horizontal, vertical: BOOLEAN)
         -- Mirror image horizontally and/or vertically
      local
         e, paa, pa, pbb, pb: INTEGER
         nbytes, size: INTEGER
         old_data: ARRAY [INTEGER_8]
      do
         if horizontal or else vertical then
            if data /= Void then
               nbytes := channels * width
               size := channels * width * height
               old_data := data
               create data.make (1, size)
               if vertical and then height > 1 then
                  	-- Mirror vertically
                  e := nbytes * height + data.lower
                  paa := data.lower
                  pbb := nbytes * (height - 1) + old_data.lower
                  if channels = 4 then
                     from
                     until
                        paa >= e
                     loop
                        pa := paa
                        paa := paa + nbytes
                        pb := pbb
                        pbb := pbb - nbytes
                        from
                        until
                           pa >= paa
                        loop
                           data.put (old_data.item (pb + 0), pa + 0)
                           data.put (old_data.item (pb + 1), pa + 1)
                           data.put (old_data.item (pb + 2), pa + 2)
                           data.put (old_data.item (pb + 3), pa + 3)
                           pa := pa + 4
                           pb := pb + 4
                        end
                     end
                  else
                     from
                     until
                        paa >= e
                     loop
                        pa := paa
                        paa := paa + nbytes
                        pb := pbb
                        pbb := pbb - nbytes
                        from
                        until
                           pa >= paa
                        loop
                           data.put (old_data.item (pb + 0), pa + 0)
                           data.put (old_data.item (pb + 1), pa + 1)
                           data.put (old_data.item (pb + 2), pa + 2)
                           pa := pa + 3
                           pb := pb + 3
                        end
                     end
                  end
               end
               if horizontal and then  width > 1 then
                  -- Mirror horizontally
                  e := nbytes * height + data.lower
                  paa := data.lower
                  pbb := old_data.lower
                  if channels = 4 then
                     from
                     until
                        paa >= e
                     loop
                        pa := paa
                        paa := paa + nbytes
                        pbb := pbb + nbytes
                        pb := pbb
                        from
                        until
                           pa >= paa
                        loop
                           pb := pb - 4
                           data.put (old_data.item (pb + 0), pa + 0)
                           data.put (old_data.item (pb + 1), pa + 1)
                           data.put (old_data.item (pb + 2), pa + 2)
                           data.put (old_data.item (pb + 3), pa + 3)
                           pa := pa + 4
                        end
                     end
                  else
                     from
                     until
                        paa >= e
                     loop
                        pa := paa
                        paa := paa + nbytes
                        pbb := pbb + nbytes
                        pb := pbb
                        from
                        until
                           pa >= paa
                        loop
                           pb := pb - 3
                           data.put (old_data.item (pb + 0), pa + 0)
                           data.put (old_data.item (pb + 1), pa + 1)
                           data.put (old_data.item (pb + 2), pa + 2)
                           pa := pa + 3
                        end
                     end
                  end
               end
               options := options | IMAGE_OWNED
               render
            end
         end
      end

   rotate (degrees_: INTEGER)
         -- Rotate image by degrees ccw
      local
         degrees: INTEGER;
         e, paa, pa, pbb, pb: INTEGER
         nbytesa, nbytesb, size: INTEGER
         old_data: ARRAY [INTEGER_8]
      do
         degrees := (degrees_ + 360) \\ 360
         if degrees /= 0 and then  width > 1  and then height > 1 then
            if data /= Void then
               size := channels * width * height
               create old_data.make (1, size)
               mem.collection_off;
        --#       mem.mem_copy (old_data.to_external, data.to_external, size);
               mem.collection_on
               inspect degrees
               when 90 then
                  resize (height, width)
                  nbytesa := channels * width
                  nbytesb := channels * height
                  paa := data.lower
                  pbb := channels * (height - 1) + old_data.lower
                  e := size + data.lower
                  if channels = 4 then
                     from
                     until
                        paa >= e
                     loop
                        pa := paa
                        paa := paa + nbytesa
                        pb := pbb
                        pbb := pbb - 4
                        from
                        until
                           pa >= paa
                        loop
                           data.put (old_data.item (pb + 0), pa + 0)
                           data.put (old_data.item (pb + 1), pa + 1)
                           data.put (old_data.item (pb + 2), pa + 2)
                           data.put (old_data.item (pb + 3), pa + 3)
                           pa := pa + 4
                           pb := pb + nbytesb
                        end
                     end
                  else
                     from
                     until
                        paa >= e
                     loop
                        pa := paa
                        paa := paa + nbytesa
                        pb := pbb
                        pbb := pbb - 3
                        from
                        until
                           pa >= paa
                        loop
                           data.put (old_data.item (pb + 0), pa + 0)
                           data.put (old_data.item (pb + 1), pa + 1)
                           data.put (old_data.item (pb + 2), pa + 2)
                           pa := pa + 3
                           pb := pb + nbytesb
                        end
                     end
                  end
               when 180 then
                  resize (width, height)
                  nbytesa := channels * width
                  nbytesb := channels * width
                  paa := data.lower
                  pbb := size + old_data.lower
                  e := size + data.lower
                  if channels = 4 then
                     from
                     until
                        paa >= e
                     loop
                        pa := paa
                        paa := paa + nbytesa
                        pb := pbb
                        pbb := pbb - nbytesb
                        from
                        until
                           pa >= paa
                        loop
                           pb := pb - 4
                           data.put (old_data.item (pb + 0), pa + 0)
                           data.put (old_data.item (pb + 1), pa + 1)
                           data.put (old_data.item (pb + 2), pa + 2)
                           data.put (old_data.item (pb + 3), pa + 3)
                           pa := pa + 4
                        end
                     end
                  else
                     from
                     until
                        paa >= e
                     loop
                        pa := paa
                        paa := paa + nbytesa
                        pb := pbb
                        pbb := pbb - nbytesb
                        from
                        until
                           pa >= paa
                        loop
                           pb := pb - 3
                           data.put (old_data.item (pb + 0), pa + 0)
                           data.put (old_data.item (pb + 1), pa + 1)
                           data.put (old_data.item (pb + 2), pa + 2)
                           pa := pa + 3
                        end
                     end
                  end
               when 270 then
                  resize (height, width)
                  nbytesa := channels * width
                  nbytesb := channels * height
                  paa := data.lower
                  pbb := nbytesb * (width - 1) + old_data.lower
                  e := size + data.lower
                  if channels = 4 then
                     from
                     until
                        paa >= e
                     loop
                        pa := paa
                        paa := paa + nbytesa
                        pb := pbb
                        pbb := pbb + 4
                        from
                        until
                           pa >= paa
                        loop
                           data.put (old_data.item (pb + 0), pa + 0)
                           data.put (old_data.item (pb + 1), pa + 1)
                           data.put (old_data.item (pb + 2), pa + 2)
                           data.put (old_data.item (pb + 3), pa + 3)
                           pa := pa + 4
                           pb := pb - nbytesb
                        end
                     end
                  else
                     from
                     until
                        paa >= e
                     loop
                        pa := paa
                        paa := paa + nbytesa
                        pb := pbb
                        pbb := pbb + 3
                        from
                        until
                           pa >= paa
                        loop
                           data.put (old_data.item (pb + 0), pa + 0)
                           data.put (old_data.item (pb + 1), pa + 1)
                           data.put (old_data.item (pb + 2), pa + 2)
                           pa := pa + 3
                           pb := pb - nbytesb
                        end
                     end
                  end
               else
                  -- TODO: warning
               end
               render
            else
               inspect degrees
               when 90 then
                  resize (height, width)
               when 180 then
                  resize (width, height)
               when 270 then
                  resize (height, width)
               else
                  -- TODO: warning
               end
            end
         end
		ensure implemented: false
      end

   crop (x, y, w, h: INTEGER)
         -- Crop image to given rectangle
      require
         rectangle_insige: w >= 1 and then h >= 1 and then x >= 0 and then y >= 0
                           and then x + w <= width and then y + h <=height
      local
         paa, pbb, e, pa, pb: INTEGER
         size, nbytesa, nbytesb: INTEGER
         old_data: ARRAY [INTEGER_8]
      do
         if data /= Void then
            size := channels * width * height;
            create old_data.make (1, size)
            mem.collection_off;
      --#      mem.mem_copy (old_data.to_external, data.to_external, size);
            mem.collection_on
            nbytesa := channels*w
            nbytesb := channels*width
            pbb := nbytesb * y + channels * x + 1
            resize (w, h)
            paa := data.lower
            e := channels * w * h + data.lower
            if channels = 4 then
               from
               until
                  paa >= e
               loop
                  pa := paa
                  paa := paa + nbytesa
                  pb := pbb
                  pbb := pbb + nbytesb
                  from
                  until
                     pa >= paa
                  loop
                     data.put (old_data.item (pb), pa)
                     data.put (old_data.item (pb + 1), pa + 1)
                     data.put (old_data.item (pb + 2), pa + 2)
                     data.put (old_data.item (pb + 3), pa + 3)
                     pa := pa + 4
                     pb := pb + 4
                  end
               end
            else
               from
               until
                  paa >= e
               loop
                  pa := paa;
                  paa := paa + nbytesa;
                  pb := pbb;
                  pbb := pbb + nbytesb;
                  from
                  until
                     pa >= paa
                  loop
                     data.put (old_data.item (pb), pa)
                     data.put (old_data.item (pb + 1), pa + 1)
                     data.put (old_data.item (pb + 2), pa + 2)
                     pa := pa + 3
                     pb := pb + 3
                  end
               end
            end
            render
         else
            resize (w,h)
         end
		ensure implemented: false
      end


feature -- Destruction

   destruct
      do
         destroy_resource
         data := Void
         Precursor;
      end


feature {NONE} -- Implementation

   hscalergba (dst_, src_: ARRAY[INTEGER_8]; dw, dh, sw, sh: INTEGER)
      local
         fin,fout,ar,ag,ab,aa: INTEGER;
         ss, ds: INTEGER;
         e: INTEGER;
         d, s: INTEGER
         done: BOOLEAN;
         src,dst: INTEGER;
         c: INTEGER_8;
      do
--         ss := 4*sw;
--         ds := 4*dw;
--         e := ds*dh + dst_.lower;
--         src := src_.lower;
--         dst := dst_.lower;
--         from
--         until
--            dst >= e
--         loop
--            s := src;
--            src := src + ss;
--            d := dst;
--            dst := dst + ds;
--            fin := dw;
--            fout := sw;
--            ar := 0; ag := 0; ab := 0; aa := 0;
--            from
--               done := False;
--            until
--               done
--            loop
--               if fin < fout then
--                  ar := ar + fin*src_.item(s).to_integer;
--                  ag := ag + fin*src_.item(s+1).to_integer;
--                  ab := ab + fin*src_.item(s+2).to_integer;
--                  aa := aa + fin*src_.item(s+3).to_integer;
--                  fout := fout - fin;
--                  fin := dw;
--                  s := s + 4;
--               else
--                  ar := ar + fout*src_.item(s).to_integer;
--                  c.from_integer(ar//sw);
--                  dst_.put(c,d)
--                  ar := 0;
--
--                  ag := ag + fout*src_.item(s+1).to_integer;
--                  c.from_integer(ag//sw);
--                  dst_.put(c,d+1)
--                  ag := 0;
--
--                  ab := ab + fout*src_.item(s+2).to_integer;
--                  c.from_integer(ab//sw);
--                  dst_.put(c,d+2)
--                  ab := 0;
--
--                  aa := aa + fout*src_.item(s+3).to_integer;
--                  c.from_integer(aa//sw);
--                  dst_.put(c,d+3)
--                  aa := 0;
--
--                  fin := fin - fout;
--                  fout := sw;
--                  d := d + 4;
--                  if d >= dst then
--                     done := True;
--                  end
--               end
--            end
--         end
		ensure implemented: false
      end

   hscalergb (dst_,src_: ARRAY[INTEGER_8];dw, dh, sw,sh: INTEGER)
      local
         fin,fout,ar,ag,ab: INTEGER;
         ss, ds: INTEGER;
         e: INTEGER;
         d, s: INTEGER
         done: BOOLEAN;
         src,dst: INTEGER;
         c: INTEGER_8;
      do
--         ss := 3*sw;
--         ds := 3*dw;
--         e := ds*dh + dst_.lower;
--         src := src_.lower;
--         dst := dst_.lower;
--         from
--         until
--            dst >= e
--         loop
--            s := src;
--            src := src + ss;
--            d := dst;
--            dst := dst + ds;
--            fin := dw;
--            fout := sw;
--            ar := 0; ag := 0; ab := 0;
--            from
--               done := False;
--            until
--               done
--            loop
--               if fin < fout then
--                  ar := ar + fin*src_.item(s).to_integer;
--                  ag := ag + fin*src_.item(s+1).to_integer;
--                  ab := ab + fin*src_.item(s+2).to_integer;
--                  fout := fout - fin;
--                  fin := dw;
--                  s := s + 3;
--               else
--                  ar := ar + fout*src_.item(s).to_integer;
--                  c.from_integer(ar//sw);
--                  dst_.put(c,d)
--                  ar := 0;
--
--                  ag := ag + fout*src_.item(s+1).to_integer;
--                  c.from_integer(ag//sw);
--                  dst_.put(c,d+1)
--                  ag := 0;
--
--                  ab := ab + fout*src_.item(s+2).to_integer;
--                  c.from_integer(ab//sw);
--                  dst_.put(c,d+2)
--                  ab := 0;
--
--                  fin := fin - fout;
--                  fout := sw;
--                  d := d + 3;
--                  if d >= dst then
--                     done := True;
--                  end
--               end
--            end
--         end
		ensure implemented: false
      end

   vscalergba (dst_,src_: ARRAY[INTEGER_8];dw, dh, sw,sh: INTEGER)
      local
         fin,fout,ar,ag,ab,aa: INTEGER;
         ss, ds: INTEGER;
         e: INTEGER;
         d,dd,dss, s: INTEGER
         done: BOOLEAN;
         src,dst: INTEGER;
         c: INTEGER_8;
      do
--         ss := 4*sw;
--         ds := 4*dw;
--         dss := ds * dh;
--         e := ds + dst_.lower;
--         src := src_.lower;
--         dst := dst_.lower;
--         from
--         until
--            dst >= e
--         loop
--            s := src;
--            src := src + 4;
--            d := dst;
--            dst := dst + 4;
--            dd := d + dss;
--            fin := dh;
--            fout := sh;
--            ar := 0; ag := 0; ab := 0; aa := 0;
--            from
--               done := False;
--            until
--               done
--            loop
--               if fin < fout then
--                  ar := ar + fin*src_.item(s).to_integer;
--                  ag := ag + fin*src_.item(s+1).to_integer;
--                  ab := ab + fin*src_.item(s+2).to_integer;
--                  aa := aa + fin*src_.item(s+3).to_integer;
--                  fout := fout - fin;
--                  fin := dh;
--                  s := s + ss;
--               else
--                  ar := ar + fout*src_.item(s).to_integer;
--                  c.from_integer(ar//sh);
--                  dst_.put(c,d)
--                  ar := 0;
--
--                  ag := ag + fout*src_.item(s+1).to_integer;
--                  c.from_integer(ag//sh);
--                  dst_.put(c,d+1)
--                  ag := 0;
--
--                  ab := ab + fout*src_.item(s+2).to_integer;
--                  c.from_integer(ab//sh);
--                  dst_.put(c,d+2)
--                  ab := 0;
--
--                  aa := aa + fout*src_.item(s+3).to_integer;
--                  c.from_integer(aa//sh);
--                  dst_.put(c,d+3)
--                  aa := 0;
--
--                  fin := fin - fout;
--                  fout := sh;
--                  d := d + ds;
--                  if d >= dd then
--                     done := True;
--                  end
--               end
--            end
--         end
		ensure implemented: false
      end

   vscalergb (dst_, src_: ARRAY [INTEGER_8]; dw, dh, sw, sh: INTEGER)
      local
         fin, fout, ar, ag, ab: INTEGER
         ss, ds: INTEGER
         e: INTEGER
         d,dd,dss, s: INTEGER
         done: BOOLEAN
         src,dst: INTEGER
         c: INTEGER_8
      do
--         ss := 3 * sw
--         ds := 3 * dw
--         dss := ds * dh
--         e := ds + dst_.lower
--         src := src_.lower
--         dst := dst_.lower
--         from
--         until
--            dst >= e
--         loop
--            s := src
--            src := src + 3
--            d := dst
--            dst := dst + 3
--            dd := d + dss
--            fin := dh
--            fout := sh
--            ar := 0; ag := 0; ab := 0
--            from
--               done := False
--            until
--               done
--            loop
--               if fin < fout then
--                  ar := ar + fin*src_.item(s).to_integer
--                  ag := ag + fin*src_.item(s+1).to_integer
--                  ab := ab + fin*src_.item(s+2).to_integer
--                  fout := fout - fin
--                  fin := dh
--                  s := s + ss
--               else
--                  ar := ar + fout*src_.item(s).to_integer
--                  c.from_integer (ar // sh)
--                  dst_.put (c, d)
--                  ar := 0
--
--                  ag := ag + fout * src_.item (s + 1).to_integer
--                  c.from_integer (ag // sh)
--                  dst_.put (c, d + 1)
--                  ag := 0
--
--                  ab := ab + fout*src_.item(s+2).to_integer
--                  c.from_integer(ab//sh)
--                  dst_.put(c,d+2)
--                  ab := 0
--
--                  fin := fin - fout
--                  fout := sh
--                  d := d + ds
--                  if d >= dd then
--                     done := True
--                  end
--               end
--            end
--         end
		ensure implemented: false
      end
end
