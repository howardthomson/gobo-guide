-- X Window System Implementation
note
	todo: "[
		Fix NATIVE_ARRAY SE dependence
		Fix signed vs unsigned sign extension problems with INTEGER_8
	]"

class SB_IMAGE

inherit
	SB_IMAGE_DEF
		redefine
			resource_id
		end

	X_H

create

	make, make_opts, make_ev

feature

	data_p: POINTER
		do
			Result := data.area.item_address (0)
		end

	resource_id: X_PIXMAP

	restore
		do
			todo ("SB_IMAGE::restore")
		ensure then
			implemented: false
		end

	create_resource_imp
		do
				-- Initialize visual
			visual.create_resource

				-- Make pixmap
			create {X_PIXMAP} resource_id.make (application.root_window.xwin, width.max (1), height.max (1), visual.depth)
		end
		
	destroy_resource_imp
		do
--###		resource_id.free_pixmap
			resource_id := default_resource
		ensure then
			implemented: false
		end
		
	render
			-- Render into pixmap
		local
			xim: X_IMAGE
			vis: X_VISUAL
			dd: INTEGER		-- depth
			gcv: X_GC_VALUES
			gc: X_GC
			mode: INTEGER
			c_ptr: C_POINTER
		do
		
			if resource_id /= Void then

		--		fx_trace(100, <<"SB_IMAGE::render image">> );

					-- Fill with pixels if there is data
				if data /= Void and 0 < width and 0 < height then

      					-- Make GC
      				create gcv.make
      				gcv.set_foreground(application.display.black_pixel(application.display.default_screen));
      				gcv.set_background(application.display.white_pixel(application.display.default_screen));
      				create gc.from_pixmap(resource_id, 0, gcv.flags, gcv)

					-- Get Visual
	      			vis := visual.visual

					dd := visual.depth

					if dd = 1 then
						mode := 1	-- xim.Xy_pixmap
					else
						mode := 2	-- xim.Z_pixmap
					end
    					-- Try create image
    				create xim.make_pointer (application.display, vis, dd, mode, 0, default_pointer, width, height, 32, 0)

    					-- Try to create temp pixel store
    				c_ptr.set_item (xim.x_alloc (xim.bytes_per_line * height))
    				xim.set_data (c_ptr.item)

	      				-- Determine what to do
	      			inspect visual.type
	      			
	        		when VISUALTYPE_TRUE then

	        		--	fx_trace(0, <<"SB_IMAGE::render - VISUALTYPE_TRUE, bpp = ", xim.bits_per_pixel.out>>)
						inspect xim.bits_per_pixel
						
	            		when 32 then
	              			render_true_32 (xim, data_p)
	            		when 24 then
	              			render_true_24 (xim,data_p)
	            		when 15, 16 then
	              			if (options & IMAGE_NEAREST) /= Zero then
	              				fx_trace(0, <<"render_true_16_fast">>)
	                			render_true_16_fast (xim, data_p);
	              			else
	              				fx_trace(0, <<"render_true_16_dither">>)
	                			render_true_16_dither (xim, data_p);
							end
	            		when 8 then
	              			if (options & IMAGE_NEAREST) /= Zero then
	                			render_true_8_fast (xim, data_p);
	              			else
	                			render_true_8_dither (xim, data_p);
	              			end
	            		else
	              			if (options & IMAGE_NEAREST) /= Zero then
	                			render_true_N_fast (xim, data_p);
	              			else
	                			render_true_N_dither (xim, data_p);
	              			end
	            		end
	            		
	        		when VISUALTYPE_GRAY then

	        		--	fx_trace(0, <<"SB_IMAGE::render - VISUALTYPE_GRAY, bpp = ", xim.bits_per_pixel.out>>)
	          			inspect xim.bits_per_pixel
	          			
	            		when 1 then
	              			if (options & IMAGE_NEAREST) /= Zero then
	                			render_mono_1_fast(xim, data_p);
	              			else
	                			render_mono_1_dither(xim, data_p);
	              			end
	            		when 8 then
	              			if (options & IMAGE_NEAREST) /= Zero then
	                			render_gray_8_fast(xim, data_p);
	              			else
	                			render_gray_8_dither(xim, data_p);
	              			end
	            		else
	              			if (options & IMAGE_NEAREST) /= Zero then
	                			render_gray_N_fast(xim, data_p);
	              			else
	                			render_gray_N_dither(xim, data_p);
	              			end
	            		end

	        		when VISUALTYPE_INDEX then
	        		
	        		--	fx_trace(0, <<"SB_IMAGE::render - VISUALTYPE_INDEX, bpp = ", xim.bits_per_pixel.out>>)
	          			inspect xim.bits_per_pixel
	          			
	            		when 4 then
	              			if (options & IMAGE_NEAREST) /= Zero then
	                			render_index_4_fast(xim, data_p);
	              			else
	                			render_index_4_dither(xim, data_p);
	              			end
	            		when 8 then
	              			if (options & IMAGE_NEAREST) /= Zero then
	                			render_index_8_fast(xim, data_p);
	              			else
	                			render_index_8_dither(xim, data_p);
	              			end
	            		else
	              			if (options & IMAGE_NEAREST) /= Zero then
	                			render_index_N_fast(xim, data_p);
	              			else
	                			render_index_N_dither(xim, data_p);
	              			end
	            		end

        			when VISUALTYPE_MONO then
	        		--	fx_trace(0, <<"SB_IMAGE::render - VISUALTYPE_MONO">>)
          				if (options & IMAGE_NEAREST) /= Zero then
            				render_mono_1_fast(xim, data_p);
          				else
            				render_mono_1_dither(xim, data_p);
            			end
            			
        			when VISUALTYPE_UNKNOWN then
	        			fx_trace(0, <<"SB_IMAGE::render - VISUALTYPE_UNKNOWN">>)

        			end -- inspect

      				-- Transfer image
        			resource_id.put_image_gc(0,0, xim, gc, 0,0, width,height)

        		--	xim.free_data	--	FXFREE(&xim->data);
        		--	xim.destroy		--	XDestroyImage(xim);
   					gc.free			--	XFreeGC(DISPLAY(getApp()),gc);
   				end
   			end
		end

feature -- Transformation

	resize_imp (w, h: INTEGER)
         	-- Resize pixmap to the specified width and height
    	do
			todo ("SB_IMAGE::resize_imp")
		ensure then
			implemented: false
      	end

feature { NONE } -- X implementation

	render_true_N_fast (xim: X_IMAGE; a_img: POINTER)
			-- True generic mode
		require
			implemented: false
		local
			x, y: INTEGER;
			img: C_POINTER
		do
			img.set_item (a_img)
		--	fx_trace(150, <<"True MSB/LSB N bpp render nearest">> )
			from y := 0 until y >= height loop
				from x := 0 until x >= width loop
				--	XPutPixel(((XImage*)xim), x, y, visual->rpix[1][img[0]] | visual->gpix[1][img[1]] | visual->bpix[1][img[2]]);
      			--	img.advance(channels);
					x := x + 1
				end
				y := y + 1
			end
		end

	render_true_N_dither (xim: X_IMAGE; a_img: POINTER)
			-- True generic dither mode
		require
			implemented: false
		local
			x, y: INTEGER
			d	: INTEGER	-- dither value
			img : C_POINTER
		do
		--	fx_trace(150, <<"True MSB/LSB N bpp render dither">> )
			img.set_item(a_img)
			from
				y := 0
			until
				y >= height
			loop
				from
					x := 0
				until
					x >= width
				loop
				--	d := ((h & 3) |<< 2) or (w & 3)
      			--	XPutPixel(((XImage*)xim), x, y, visual->rpix[d][img[0]] | visual->gpix[d][img[1]] | visual->bpix[d][img[2]]);
      				img.advance(channels)
      				x := x + 1
				end
				y := y + 1
			end
		end

	render_true_24 (xim: X_IMAGE; a_img: POINTER)
			-- True 24 bit color
		require
			implemented: false
		local
			jmp: INTEGER
			pix: C_POINTER
			img: C_POINTER
			val: INTEGER
			w, h: INTEGER
		do	
			jmp := xim.bytes_per_line - (width * 3)
			pix.set_item(xim.data)
			img.set_item(a_img)
			  
			if xim.byte_order = MSBFirst then		-- MSB
			--	fx_trace(150, <<"True MSB 24bpp render">> )
				from
					h := height - 1
				until
					h < 0
				loop
					from
						w := width - 1
					until
						w < 0
					loop

						val := ((visual.rpix) @ ((1 |<< 8) + img.get_byte_at(0) + 1))
							 | ((visual.gpix) @ ((1 |<< 8) + img.get_byte_at(1) + 1))
							 | ((visual.bpix) @ ((1 |<< 8) + img.get_byte_at(2) + 1));
						pix.put_byte_at(0, val |>> 16)	--	pix[0]= (val |>> 16);
						pix.put_byte_at(1, val |>> 8)	--	pix[1]= (val |>> 8);
						pix.put_byte_at(2, val)			--	pix[2]= val;
						img.advance(channels);
						pix.advance(3)
						w := w - 1
					end
					pix.advance(jmp)
					h := h - 1
				end

			else
				-- LSB
		    --	fx_trace(150, <<"True LSB 24bpp render">> )
				from
					h := height - 1
				until
					h < 0
				loop
					from
						w := width - 1
					until
						w < 0
					loop
						val := ((visual.rpix) @ ((1 |<< 8) + img.get_byte_at(0) + 1))
							 | ((visual.gpix) @ ((1 |<< 8) + img.get_byte_at(1) + 1))
							 | ((visual.bpix) @ ((1 |<< 8) + img.get_byte_at(2) + 1));
						pix.put_byte_at(0, val)			--	pix[0]=(FXuchar)val;
						pix.put_byte_at(1, val |>> 8)	--	pix[1]=(FXuchar)(val>>8);
						pix.put_byte_at(2, val |>> 16)	--	pix[2]=(FXuchar)(val>>16);
						img.advance(channels);
						pix.advance(3);
						w := w - 1
					end
					pix.advance(jmp)	--	pix += jmp
					h := h - 1
				end
			end
		end

	render_true_32(xim: X_IMAGE; a_img: POINTER)
			-- True 32 bit color
		require
--			implemented: false
		local
			pix: C_POINTER
			jmp: INTEGER
			val: INTEGER
			w, h: INTEGER
			img: C_POINTER
		do
			jmp := xim.bytes_per_line - (width |<< 2)
			pix.set_item(xim.data)
			img.set_item(a_img)
			
			-- Byte order matches
			if xim.byte_order = fox_bigendian then
		    --	fx_trace(150, <<"True MSB/LSB 32bpp render">> )
				from
		    		h := height - 1
				until
					h < 0
				loop
					from
						w := width - 1
					until
						w < 0
					loop
						pix.put_long( ((visual.rpix) @ ((1 |<< 8) + img.get_byte_at(0) + 1))
									| ((visual.gpix) @ ((1 |<< 8) + img.get_byte_at(1) + 1))
									| ((visual.bpix) @ ((1 |<< 8) + img.get_byte_at(2) + 1)));
						img.advance(channels)
						pix.advance(4)
						w := w - 1
					end
					pix.advance(jmp)
					h := h - 1
				end

			-- MSB Byte order
			elseif xim.byte_order = MSBFirst then
			--	fx_trace(150, <<"True MSB 32bpp render">> )
				from
					h := height - 1
				until
					h < 0
				loop
					from
						w := width - 1
					until
						w < 0
					loop
						val := ((visual.rpix) @ ((1 |<< 8) + img.get_byte_at(0) + 1))
							 | ((visual.gpix) @ ((1 |<< 8) + img.get_byte_at(1) + 1))
							 | ((visual.bpix) @ ((1 |<< 8) + img.get_byte_at(2) + 1));
						pix.put_byte_at(0, val |>> 24)
						pix.put_byte_at(1, val |>> 16)
						pix.put_byte_at(2, val |>> 8)
						pix.put_byte_at(3, val)
						img.advance(channels)
						pix.advance(4)
						w := w - 1
					end
					pix.advance(jmp)
					h := h - 1
				end
				
			-- LSB Byte order
			else
			--	fx_trace(150, <<"True LSB 32bpp render">> )
				from
					h := height - 1
				until
					h < 0
				loop
					from
						w := width - 1
					until
						w < 0
					loop
						val := ((visual.rpix) @ ((1 |<< 8) + img.get_byte_at(0) + 1))
							 | ((visual.gpix) @ ((1 |<< 8) + img.get_byte_at(1) + 1))
							 | ((visual.bpix) @ ((1 |<< 8) + img.get_byte_at(2) + 1));
						pix.put_byte_at(0, val)
						pix.put_byte_at(1, val |>> 8)
						pix.put_byte_at(2, val |>> 16)
						pix.put_byte_at(3, val |>> 24)
						img.advance(channels)
						pix.advance(4)
						w := w - 1
					end
					pix.advance(jmp)
					h := h - 1
				end
			end
		end

	render_true_16_fast(xim: X_IMAGE; a_img: POINTER)
			-- True 16 bit color
		local
			jmp: INTEGER	-- FXuint jmp=((XImage*)xim)->bytes_per_line-(width<<1);
			pix: C_POINTER	-- FXuchar *pix=(FXuchar*)((XImage*)xim)->data;
			val: INTEGER	-- FXPixel val;
			w, h: INTEGER	-- FXint w,h;
			img: C_POINTER
		do
			img.set_item(a_img)
				-- Byte order matches
			if xim.byte_order = fox_bigendian then
		    --	fx_trace(150, <<"True MSB/LSB 16bpp 5,6,5/5,5,5 render nearest">> )
				from
					h := height - 1
				until
					h < 0
				loop
					from
						w := width - 1
					until
						w < 0
					loop
						pix.put_short(((visual.rpix) @ ((1 |<< 8) + img.get_byte_at(0) + 1))
									| ((visual.gpix) @ ((1 |<< 8) + img.get_byte_at(1) + 1))
									| ((visual.bpix) @ ((1 |<< 8) + img.get_byte_at(2) + 1)));
						img.advance(channels)
						pix.advance(2)
						w := w - 1
					end

					pix.advance(jmp)
					h := h - 1
				end
		
			-- MSB Byte order
			elseif xim.byte_order = MSBFirst then
			--	fx_trace(150, <<"True MSB 16bpp 5,6,5/5,5,5 render nearest">> )
				from
					h := height - 1
				until
					h < 0
				loop
					from
						w := width - 1
					until
						w < 0
					loop
						val := ((visual.rpix) @ ((1 |<< 8) + img.get_byte_at(0) + 1))
							 | ((visual.gpix) @ ((1 |<< 8) + img.get_byte_at(1) + 1))
							 | ((visual.bpix) @ ((1 |<< 8) + img.get_byte_at(2) + 1));
						pix.put_byte_at(0, val |>> 8)
						pix.put_byte_at(1, val)
						img.advance(channels)
						pix.advance(2)
						w := w - 1
					end
					pix.advance(jmp)
					h := h - 1
				end
				
			-- LSB Byte order
			else
			--	fx_trace(150, <<"True LSB 16bpp 5,6,5/5,5,5 render nearest">> )
				from
		    		h := height - 1
				until
					h < 0
				loop
					from
						w := width - 1
					until
						w < 0
					loop
						val := ((visual.rpix) @ ((1 |<< 8) + img.get_byte_at(0) + 1))
							 | ((visual.gpix) @ ((1 |<< 8) + img.get_byte_at(1) + 1))
							 | ((visual.bpix) @ ((1 |<< 8) + img.get_byte_at(2) + 1));
						pix.put_byte_at(0, val)
						pix.put_byte_at(1, val |>> 8)
						img.advance(channels)
						pix.advance(2)
						w := w - 1
					end
					pix.advance(jmp)
					h := h - 1
				end
			end
		end

	fox_bigendian: INTEGER
			-- LSBfirst on Intel
		do
			Result := LSBFirst
		end

	render_true_16_dither(xim: X_IMAGE; a_img: POINTER)
			-- True 16 bit color, dithered
		require
		--	implemented: false
			xim /= Void and then xim.data /= default_pointer
			a_img /= default_pointer
		local
			jmp: INTEGER	--		  register FXuint jmp=((XImage*)xim)->bytes_per_line-(width<<1);
			img: C_POINTER
			pix: C_POINTER	--		  register FXuchar *pix=(FXuchar*)((XImage*)xim)->data;
			val: INTEGER	-- FXPixel val;
			w, h: INTEGER
			d: INTEGER		-- dither
			
		do
			jmp := xim.bytes_per_line - (width |<< 1)
			img.set_item(a_img)
			pix.set_item(xim.data)
			-- Byte order matches
			if xim.byte_order = fox_bigendian then
			--	fx_trace(150, <<"True MSB/LSB 16bpp 5,6,5/5,5,5 render dither">> )
				from
					h := height - 1
				until
					h < 0
				loop
					from
						w := width - 1
					until
						w < 0
					loop
						d := ((h & 3) |<< 2) | (w & 3)
					--	*((FXushort*)pix)=visual->rpix[d][img[0]] | visual->gpix[d][img[1]] | visual->bpix[d][img[2]];
					
						pix.put_short( ((visual.rpix) @ ((d |<< 8) + img.get_ubyte_at(0) + 1))	-- Red
									|  ((visual.gpix) @ ((d |<< 8) + img.get_ubyte_at(1) + 1))	-- Green
									|  ((visual.bpix) @ ((d |<< 8) + img.get_ubyte_at(2) + 1)))	-- Blue

					--	fx_trace(0, <<"SB_IMAGE::render -- x,y: ", w.out, "/", h.out, " ", pix.get_short.out>> )
					
						img.advance(channels)
						pix.advance(2)
						w := w - 1
					end
					pix.advance(jmp)
					h := h - 1
				end
			--	fx_trace(0, <<"start/end image writing: ", xim.data.out, pix.item.out>> )
				
			-- MSB Byte order
			elseif xim.byte_order = MSBFirst then
			--	fx_trace(150, <<"True MSB 16bpp 5,6,5/5,5,5 render dither">> )
				from
					h := height - 1
				until
					h < 0
				loop
					from
						w := width - 1
					until
						w < 0
					loop
						d := ((h & 3) |<< 2) | (w & 3)
						val := ((visual.rpix) @ ((d |<< 8) + img.get_byte_at(0) + 1))
							 | ((visual.gpix) @ ((d |<< 8) + img.get_byte_at(1) + 1))
							 | ((visual.bpix) @ ((d |<< 8) + img.get_byte_at(2) + 1));
						pix.put_byte_at(0, val |>> 8);
						pix.put_byte_at(1, val);
						img.advance(channels);
						pix.advance(2);
						w := w - 1
					end
					pix.advance(jmp)
					h := h - 1
				end

			-- LSB Byte order
			else
		    --	fx_trace(150, <<"True LSB 16bpp 5,6,5/5,5,5 render dither">> )
				from
					h := height - 1
				until
					h < 0
				loop
					from
						w := width - 1
					until
						w < 0
					loop
						d := ((h & 3) |<< 2) | (w & 3)
						val := ((visual.rpix) @ ((d |<< 8) + img.get_byte_at(0) + 1))
							 | ((visual.gpix) @ ((d |<< 8) + img.get_byte_at(1) + 1))
							 | ((visual.bpix) @ ((d |<< 8) + img.get_byte_at(2) + 1));
						pix.put_byte_at(0, val);
						pix.put_byte_at(1, val |>> 8);
						img.advance(channels);
						pix.advance(2);
						w := w - 1
					end
					pix.advance(jmp)
					h := h - 1
				end
			end
		end

	render_true_8_fast(xim: X_IMAGE; a_img: POINTER)
			-- True 8 bit color
		require
			implemented: false
		local
			jmp: INTEGER	-- register FXuint jmp=((XImage*)xim)->bytes_per_line-width;
			pix: C_POINTER	-- register FXuchar *pix=(FXuchar*)((XImage*)xim)->data;
			img: C_POINTER
			w, h: INTEGER
		do
			jmp := xim.bytes_per_line - width
			pix.set_item(xim.data)
			img.set_item(a_img)
		--	fx_trace(150, <<"True MSB/LSB 8bpp render nearest">> )
			from
				h := height - 1
			until
				h < 0
			loop
				from
					w := width - 1
				until
					w < 0
				loop
					pix.put_byte(	((visual.rpix) @ ((1 |<< 8) + img.get_byte_at(0) + 1))
								  | ((visual.gpix) @ ((1 |<< 8) + img.get_byte_at(1) + 1))
								  | ((visual.bpix) @ ((1 |<< 8) + img.get_byte_at(2) + 1)))
					img.advance(channels)
					pix.advance(1)
					w := w - 1
				end
				pix.advance(jmp)
				h := h - 1
			end
		end

	render_true_8_dither(xim: X_IMAGE; a_img: POINTER)
			-- True 8 bit color, dithered
		require
			implemented: false
		local
			jmp: INTEGER	-- register FXuint jmp=((XImage*)xim)->bytes_per_line-width;
			pix: C_POINTER	-- register FXuchar *pix=(FXuchar*)((XImage*)xim)->data;
			img: C_POINTER
			w, h: INTEGER
			d: INTEGER	-- dither index
		do
			jmp := xim.bytes_per_line - width
			pix.set_item(xim.data)
			img.set_item(a_img)
		--	fx_trace(150, <<"True MSB/LSB 8bpp render dither">> )
			from
				h := height - 1
			until
				h < 0
			loop
				from
					w := width - 1
				until
					w < 0
				loop
					d := ((h & 3) |<< 2) | (w & 3)
				--	pix.put_byte(visual->rpix[d][img[0]] | visual->gpix[d][img[1]] | visual->bpix[d][img[2]])
					pix.put_byte(	((visual.rpix) @ ((d |<< 8) + img.get_byte_at(0) + 1))
								  | ((visual.gpix) @ ((d |<< 8) + img.get_byte_at(1) + 1))
								  | ((visual.bpix) @ ((d |<< 8) + img.get_byte_at(2) + 1)))
					img.advance(channels)
					w := w - 1
					pix.advance(1)
				end
				pix.advance(jmp)
				h := h - 1
			end
		end

	
	render_index_4_fast(xim: X_IMAGE; img: POINTER)
			-- Render 4 bit index color mode
		local
			pix: C_POINTER		-- FXuchar *pix=(FXuchar*)((XImage*)xim)->data;
			jmp: INTEGER		-- FXuint jmp=((XImage*)xim)->bytes_per_line-width;
			val, half: INTEGER	-- FXuint val,half;
			w, h: INTEGER		-- FXint w,h;
		do
			jmp := xim.bytes_per_line - width
			pix.set_item(xim.data)
			
		--	if(((XImage*)xim)->byte_order==MSBFirst){	--  MSB
			if xim.byte_order = MSBFirst then
	--		    FXTRACE((150,"Index MSB 4bpp render nearest\n"));
	--		    h := height - 1;
	--		    do{
	--		      w := width - 1;
	--		      half := 0;
	--		      do {
	--		        val := visual->lut[visual->rpix[1][img[0]]
	--								+  visual->gpix[1][img[1]]
	--								+  visual->bpix[1][img[2]]];
	--		        if(half) *pix++|=val;
	--		        else *pix=val<<4;
	--		        half ^= 1;
	--		        img += channels;
	--		        }
	--		      while(--w>=0);
	--		      pix += jmp;
	--		      }
	--		    while(--h >= 0);
	--		    }
			else	-- LSB
	--		    FXTRACE((150,"Index LSB 4bpp render nearest\n"));
	--			h := height - 1;
	--		    do{
	--		      w := width - 1;
	--		      half := 0;
	--		      do {
	--		        val := visual->lut[visual->rpix[1][img[0]]
	--								+  visual->gpix[1][img[1]]
	--								+  visual->bpix[1][img[2]]];
	--		        if(half) *pix++|=val<<4;
	--		        else *pix=val;
	--		        half^=1;
	--		        img+=channels;
	--		        }
	--		      while(--w>=0);
	--		      pix+=jmp;
	--		      }
	--		    while(--h>=0);
			end
		end


	render_index_4_dither(xim: X_IMAGE; a_img: POINTER)
			-- Render 4 bit index color mode
		local
			pix: C_POINTER		--	FXuchar *pix=(FXuchar*)((XImage*)xim)->data;
			img: C_POINTER
			jmp: INTEGER		--	FXuint jmp=((XImage*)xim)->bytes_per_line-width;
			val, half, d: INTEGER	--	FXuint val,half,d;
			w, h: INTEGER		--	FXint w,h;
		do
			pix.set_item(xim.data)
			img.set_item(a_img)
			
--		  if(((XImage*)xim)->byte_order==MSBFirst){    // MSB
--		    FXTRACE((150,"Index MSB 4bpp render dither\n"));
--		    h := height - 1;
--		    do{
--		      w=width-1;
--		      half=0;
--		      do{
--		        d=((h&3)<<2)|(w&3);
			--	d := ((h & 3) |<< 2) or (w & 3)
--		        val=visual->lut[visual->rpix[d][img[0]]+visual->gpix[d][img[1]]+visual->bpix[d][img[2]]];
--		        if(half) *pix++|=val;
--		        else *pix=val<<4;
--		        half^=1;
--		        img+=channels;
--		        }
--		      while(--w>=0);
--		      pix+=jmp;
--		      }
--		    while(--h>=0);
--		    }
--		  else{                               // LSB
--		    FXTRACE((150,"Index LSB 4bpp render dither\n"));
--		    h=height-1;
--		    do{
--		      w=width-1;
--		      half=0;
--		      do{
--		        d=((h&3)<<2)|(w&3);
			--	d := ((h & 3) |<< 2) or (w & 3)
--		        val=visual->lut[visual->rpix[d][img[0]]+visual->gpix[d][img[1]]+visual->bpix[d][img[2]]];
--		        if(half) *pix++|=val<<4;
--		        else *pix=val;
--		        half^=1;
--		        img+=channels;
--		        }
--		      while(--w>=0);
--		      pix+=jmp;
--		      }
--		    while(--h>=0);
--		    }
		end
--		
--		
--		
	render_index_8_fast(xim: X_IMAGE; img: POINTER)
			-- Render 8 bit index color mode
		local
--		  FXuint jmp=((XImage*)xim)->bytes_per_line-width;
--		  FXuchar *pix=(FXuchar*)((XImage*)xim)->data;
--		  FXint w,h;
		do
--		  FXTRACE((150,"Index MSB/LSB 8bpp render nearest\n"));
--		  h=height-1;
--		  do{
--		    w=width-1;
--		    do{
--		      *pix=visual->lut[visual->rpix[1][img[0]]+visual->gpix[1][img[1]]+visual->bpix[1][img[2]]];
--		      img+=channels;
--		      pix++;
--		      }
--		    while(--w>=0);
--		    pix+=jmp;
--		    }
--		  while(--h>=0);
		end


	render_index_8_dither(xim: X_IMAGE; img: POINTER)
			-- Render 8 bit index color mode
		local
--		  FXuint jmp=((XImage*)xim)->bytes_per_line-width;
--		  FXuchar *pix=(FXuchar*)((XImage*)xim)->data;
--		  FXint w,h,d;
		do
--		  FXTRACE((150,"Index MSB/LSB 8bpp render dither\n"));
--		  h=height-1;
--		  do{
--		    w=width-1;
--		    do{
--		      d=((h&3)<<2)|(w&3);
--						d := ((h & 3) |<< 2) or (w & 3)
--		      *pix=visual->lut[visual->rpix[d][img[0]]+visual->gpix[d][img[1]]+visual->bpix[d][img[2]]];
--		      img+=channels;
--		      pix++;
--		      }
--		    while(--w>=0);
--		    pix+=jmp;
--		    }
--		  while(--h>=0);
		end


	render_index_N_fast(xim: X_IMAGE; img: POINTER)
			-- Render generic N bit index color mode
		local
--		  FXint x,y;
		do
--		  FXTRACE((150,"Index MSB/LSB N bpp render nearest\n"));
--		  y=0;
--		  do{
--		    x=0;
--		    do{
--		      XPutPixel(((XImage*)xim),x,y,visual->lut[visual->rpix[1][img[0]]+visual->gpix[1][img[1]]+visual->bpix[1][img[2]]]);
--		      img+=channels;
--		      }
--		    while(++x<width);
--		    }
--		  while(++y<height);
		end


	render_index_N_dither(xim: X_IMAGE; img: POINTER)
			-- Render generic N bit index color mode
		local
			x, y, d: INTEGER
		do
--		  FXTRACE((150,"Index MSB/LSB N bpp render dither\n"));
--		  y=0;
--		  do{
--		    x=0;
--		    do{
--		      d=((y&3)<<2)|(x&3);
--						d := ((h & 3) |<< 2) or (w & 3)
--		      XPutPixel(((XImage*)xim),x,y,visual->lut[visual->rpix[d][img[0]]+visual->gpix[d][img[1]]+visual->bpix[d][img[2]]]);
--		      img+=channels;
--		      }
--		    while(++x<width);
--		    }
--		  while(++y<height);
		end

	
	render_gray_8_fast(xim: X_IMAGE; img: POINTER)
			-- Render 8 bit gray mode
		local
--		  FXuchar *pix=(FXuchar*)((XImage*)xim)->data;
--		  FXuint jmp=((XImage*)xim)->bytes_per_line-width;
--		  FXint w,h;
		do
--		  FXTRACE((150,"Gray MSB/LSB 8bpp render nearest\n"));
--		  h=height-1;
--		  do{
--		    w=width-1;
--		    do{
--		      *pix=visual->gpix[1][(77*img[0]+151*img[1]+29*img[2])>>8];
--		      img+=channels;
--		      pix++;
--		      }
--		    while(--w>=0);
--		    pix+=jmp;
--		    }
--		  while(--h>=0);
		end

	
	render_gray_8_dither(xim: X_IMAGE; img: POINTER)
			-- Render 8 bit gray mode
		local
--		  FXuchar *pix=(FXuchar*)((XImage*)xim)->data;
--		  FXuint jmp=((XImage*)xim)->bytes_per_line-width;
			w, h: INTEGER
		do
		--	fx_trace(150, <<"Gray MSB/LSB 8bpp render dither">> )
			from h := height - 1 until h < 0 loop
				from w := width - 1 until w < 0 loop
				--	*pix=visual.gpix[ ((h&3)<<2)|(w&3) ][(77 * img[0] + 151 * img[1] + 29 * img[2]) >> 8];
				--	img += channels;
				--	pix++
					w := w - 1 
				end
				h := h - 1
			--	pix += jmp;
			end
		end


	render_gray_N_fast(xim: X_IMAGE; img: POINTER)
			-- Render generic N bit gray mode
		local
			x, y: INTEGER	-- FXint x,y;
		do
--		  fx_trace((150, <<"Gray MSB/LSB N bpp render nearest">> )
--		  y=0;
--		  do{
--		    x=0;
--		    do{
--		      XPutPixel(((XImage*)xim),x,y,visual->gpix[1][(77*img[0]+151*img[1]+29*img[2])>>8]);
--		      img+=channels;
--		      }
--		    while(++x<width);
--		    }
--		  while(++y<height);
		end


	render_gray_N_dither(xim: X_IMAGE; img: POINTER)
			-- Render generic N bit gray mode
		local
			x, y: INTEGER
			d	: INTEGER
		do
		--	fx_trace(150, <<"Gray MSB/LSB N bpp render dither">> )
			from y := 0 until y >= height loop
				from x := 0 until x >= width loop
				--	d := ((h & 3) |<< 2) or (w & 3)
				--	XPutPixel(((XImage*)xim),x,y,visual->gpix[d][(77 * img[0] + 151 * img[1] + 29 * img[2]) >> 8]);
				--	img += channels;
					x := x + 1
				end
				y := y + 1
			end
		end
		

	render_mono_1_fast(xim: X_IMAGE; img: POINTER)
			-- Render monochrome mode
		local
			x, y: INTEGER
		do
		--	fx_trace(150, <<"Monochrome MSB/LSB 1bpp render nearest">> );
			from y := 0 until y >= height loop
				from x := 0 until x >= width loop
				--	XPutPixel(((XImage*)xim), x,y, visual->gpix[1][(77 * img[0] + 151 * img[1] + 29 * img[2]) >> 8]);
				--	img += channels
					x := x + 1
				end
				y := y + 1
			end
		end


	render_mono_1_dither(xim: X_IMAGE; img: POINTER)
			-- Render monochrome mode
		local
			x, y: INTEGER
			d	: INTEGER
		do
		--	fx_trace(150, <<"Monochrome MSB/LSB 1bpp render dither">> );
			from y := 0 until y >= height loop
				from x := 0 until x >= width loop
				--	d := ((h & 3) |<< 2) or (w & 3)
				--	XPutPixel(((XImage*)xim),x,y,visual->gpix[((y&3)<<2)|(x&3)][(77 * img[0] + 151 * img[1] + 29 * img[2]) >> 8]);
				--	img.advance(channels)
					x := x + 1
				end
				y := y + 1
			end
		end


end
