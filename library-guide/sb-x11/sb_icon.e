-- X Window System Implementation
indexing

	todo: "[
		re-define 'mem: NATIVE_ARRAY' for ISE compatibility
		Consider GC collection of memory allocated to X_IMAGE
	]"

class SB_ICON

inherit

	SB_ICON_DEF
		redefine
			render
		end

	SB_COMMON_CONVERSIONS

creation

	make, make_opts

feature -- Resource management

	create_resource_imp is
		local
			dd: INTEGER	-- Image depth
		do

				-- Initialize visual
			visual.create_resource

				-- Get depth
			dd := visual.depth

				-- Make image pixmap
			create {X_PIXMAP} resource_id.make (application.root_window.xwin, width.max(1), height.max(1), dd)

				-- Make shape pixmap
			create {X_PIXMAP} shape.make (application.root_window.xwin, width.max(1), height.max(1), 1)

				-- Make etch pixmap
			create {X_PIXMAP} etch.make (application.root_window.xwin, width.max(1), height.max(1), 1)
		end

	destroy_resource_imp is
		do
		--	TODO
		end

feature -- Rendering

	sp_fill_with (mp: MANAGED_POINTER; v: CHARACTER) is
			-- Fill the area with the specified value
		local
			i, nb: INTEGER
		do
			from
				i := 0
				nb := mp.count
			until
				i >= nb
			loop
				mp.put_character (v, i)
				i := i + 1
			end
		end

	render is
			-- Render icon X Windows
		local
			vis: X_VISUAL
			xim: X_IMAGE
			shmi: BOOLEAN
			img: INTEGER
			x,y: INTEGER
			tr,tg,tb: INTEGER_8
			gcv: X_GC_VALUES
			gc: X_GC
			sp: MANAGED_POINTER
		do
			if resource_id /= Void then

				-- Render the image pixels
				Precursor

				-- Fill with pixels if there is data
				if data /= Void and then 0 < width and then 0 < height then

						-- Get Visual
					vis := visual.visual;

        				-- Create image
        		--	create xim.make_pointer(application.display, vis, 1, xim.Z_pixmap, 0, default_pointer, width, height, 32, 0)
        			create xim.make_pointer(application.display, vis, 1, 2           , 0, default_pointer, width, height, 32, 0)

        				-- Create temp pixel store
					create sp.make (xim.bytes_per_line * height)
        			xim.set_data (sp.item)

      					-- Make GC
      				create gcv.make
      				gcv.set_foreground (0xffffffff)
      				gcv.set_background (0xffffffff)
      				create gc.from_pixmap (shape, 0, gcv.flags, gcv)

				--	fx_trace(0, <<"bm width = ", 			xim.width.out		>> );
				--	fx_trace(0, <<"bm height = ",			xim.height.out		>> );
				--	fx_trace(0, <<"bm format = ",			xim.format.out		>> );		-- ==XYBitmap?"XYBitmap":xim->format==XYPixmap?"XYPixmap":"ZPixmap"));
				--	fx_trace(0, <<"bm depth = ", 			xim.depth.out		>> );
				
				--	fx_trace(0, <<"bm byte_order = ", 		xim.byte_order.out	>> )	--		-- ==MSBFirst)?"MSBFirst":"LSBFirst"));
				--	fx_trace(0, <<"bm bitmap_unit = ",		xim.bitmap_unit.out	>> )	--));
				--	fx_trace(0, <<"bm bitmap_bit_order = ", xim.bitmap_bit_order.out >> )	-- ==MSBFirst)?"MSBFirst":"LSBFirst"));
				--	fx_trace(0, <<"bm bitmap_pad = ",		xim.bitmap_pad.out		>> );
				--	fx_trace(0, <<"bm bytes_per_line = ",	xim.bytes_per_line.out	>> );
				--	fx_trace(0, <<"bm bits_per_pixel = ",	xim.bits_per_pixel.out	>> );

						-- Fill shape mask
      				if channels = 3 or else (options & IMAGE_OPAQUE) /= Zero then
      					-- Opaque image
        				sp_fill_with (sp, (0xff).to_character)
        				
      				elseif channels = 4 then
	      				if (options & (IMAGE_ALPHACOLOR | IMAGE_ALPHAGUESS)) /= Zero then
	      					-- Transparent color

							check channels = 4 end
					    	tr := int_to_int8 (sbredval   (transparent_color)) 
					    	tg := int_to_int8 (sbgreenval (transparent_color))
					    	tb := int_to_int8 (sbblueval  (transparent_color))
					  --  	fx_trace(0, <<"SB_ICON::render - #2 tr/tg/tb = ", tr.out,"/",tg.out,"/",tb.out>>)
							check data.count <= (width * height * 3) end
					        from img := 1; y := 0 until y >= height loop
					        	from x := 0 until x >= width loop
	          				--		fx_trace(0, <<"SB_ICON::render #2: x/y/img - ", x.out, "/", y.out, "/", img.out>>)

									if  ((data @ (img + 0)) = tr)
									and ((data @ (img + 1)) = tg) 
									and ((data @ (img + 2)) = tb)
									then
										xim.put_pixel (x, y, 0)
									else
										xim.put_pixel (x, y, 0xffffffff)
									end
					            	img := img + channels
					            	x := x + 1
					          	end
					          	y := y + 1
					        end
						else
	      					-- Transparency channel

	      					check channels = 4 end
	        			--	fx_trace(150, <<"Shape from alpha-channel">>);
	        				check data.count <= (width * height * 4) end
	        				from img := 1; y := 0 until y >= height loop
	          					from x := 0 until x >= width loop
	          						fx_trace(0, <<"SB_ICON::render #1: x/y/img - ", x.out, "/", y.out, "/", img.out>>)
	            					if (data @ (img+3)) /= 0 then
	            						xim.put_pixel (x, y, 0xffffffff)
	            					else
	            						xim.put_pixel (x, y, 0)
	            					end
	            					img := img + channels
									x := x + 1
	          					end
	          					y := y + 1
							end
	      				end
	      			end -- channels

						-- Transfer image
					shape.put_image_gc (0,0, xim, gc, 0,0, width, height)	-- gc ??

						-- Fill etch image
					if channels = 3 or else (options & IMAGE_OPAQUE) /= Zero then
				    		-- Opaque image
				        from img := 1; y := 0 until y >= height loop
				        	from x := 0 until x >= width loop
				    			if is_dark_color (data @ (img+0), data @ (img+1), data @ (img+2)) then
									xim.put_pixel (x, y, 0xffffffff)
								else
									xim.put_pixel (x, y, 0)
								end
				            	img := img + channels;
				            	x := x + 1
				            end
				            y := y + 1
				        end
					else
						if (options & (IMAGE_ALPHA | IMAGE_ALPHAGUESS)) /= Zero then
					      	-- Transparency channel
					      	check channels = 4 end
					        from img := 1; y := 0 until y >= height loop
					        	from x := 0 until x >= width loop
									if data @ (img+3) /= 0 and then is_dark_color (data @ (img+0), data @ (img+1), data @ (img+2)) then
										xim.put_pixel (x, y, 0xffffffff)
									else
										xim.put_pixel (x, y, 0)
									end
					         		img := img + channels
					          		x := x + 1
								end
								y := y + 1
							end
						else
					    	-- Transparent color
					      	check channels = 4 end
					    	tr := int_to_int8 (sbredval  (transparent_color))
					    	tg := int_to_int8 (sbgreenval(transparent_color))
					    	tb := int_to_int8 (sbblueval (transparent_color))
					        from img := 1; y := 0 until y >= height loop
					          	from x := 0 until x >= width loop
					            	if not			 ((data @ (img + 0)) = tr)
											and then ((data @ (img + 1)) = tg) 
											and then ((data @ (img + 2)) = tb)
									and then is_dark_color(data @ (img + 0), data @ (img + 1), data @ (img + 2)) then
										xim.put_pixel (x, y, 0xffffffff)
									else
										xim.put_pixel (x, y, 0)
									end
					            	img := img + channels
					            	x := x + 1
					        	end
					        	y := y + 1
					        end
						end
					end

					-- Transfer image
					etch.put_image_gc (0,0, xim, gc, 0,0, width, height)	-- gc ??

					-- Clean up
				--	mem.free	--	FXFREE(&xim->data);
				--	xim.destroy	--	XDestroyImage(xim);
					
					gc.free
				end
			end
		end

	dark_color (r, g, b: INTEGER): INTEGER is
		do
			if   ((r & 0x00ff) 
				+ (g & 0x00ff) 
				+ (b & 0x00ff)) < 382 then
				Result := 0xffffffff
			else
				Result := 0
			end
		end

	is_dark_color (r,g,b: INTEGER): BOOLEAN is
		do
			Result := ((r+g+b) & 0x00ff) < 382
		end
		
	resize_imp(w, h: INTEGER) is
		local
			dd: INTEGER
		do
--
--	      -- Get depth (should use visual!!)
--	      dd := visual.depth;
--
--	      -- Free old pixmaps
--	      resource_id.free		--XFreePixmap(display_ptr, resource_id);
--	      etch.free		--XFreePixmap(display_ptr, etch);
--	      shape.free	--XFreePixmap(display_ptr, shape);
--
--	      -- Make new pixmap
--	      resource_id := XCreatePixmap(display_ptr, XDefaultRootWindow(display_ptr), w, h, dd);
--
--	      -- Make shape pixmap
--	      shape := XCreatePixmap(display_ptr, XDefaultRootWindow(display_ptr), w, h, 1);
--
--	      -- Make etch pixmap
--	      etch := XCreatePixmap(display_ptr, XDefaultRootWindow(display_ptr), w, h, 1);
		ensure then implemented: false
		end

end
