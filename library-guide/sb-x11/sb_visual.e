-- X Window System Implementation
note
	todo: "[
		Fix dither: Result is ARRAY [ INTEGER ] for SE, and
			ARRAY [ INTEGER ] for ISE; do they need to differ ?
	]"

class SB_VISUAL

inherit
	SB_VISUAL_DEF
		rename
			resource_id as visual,
			color_count as numcolors,
			red_count	as numred,
			green_count as numgreen,
			blue_count	as numblue
		redefine
			visual
		end

	X_GC_CONSTANTS

	X_WINDOW_CONSTANTS
	X11_EXTERNAL_ROUTINES
	SB_ZERO

create
	make

feature
	visual: X_VISUAL

	gc, scroll_gc: X_GC

	colormap: X_COLORMAP

	dither: ARRAY [ INTEGER ]
			-- Standard dither kernel
		do
			Result := << 
			
			--	 0 * 16,  8 * 16,  2 * 16, 10 * 16,
			--	12 * 16,  4 * 16, 14 * 16,  6 * 16,
			--	 3 * 16, 11 * 16,  1 * 16,  9 * 16,
			--	15 * 16,  7 * 16, 13 * 16,  5 * 16,

				(16).to_integer *  0,
				(16).to_integer *  8,  
				(16).to_integer *  2,
				(16).to_integer * 10,
				(16).to_integer * 12, 
				(16).to_integer *  4, 
				(16).to_integer * 14, 
				(16).to_integer *  6,
				(16).to_integer *  3, 
				(16).to_integer * 11,  
				(16).to_integer *  1,  
				(16).to_integer *  9,
				(16).to_integer * 15,  
				(16).to_integer *  7, 
				(16).to_integer * 13, 
				(16).to_integer *  5
			>>
		end

	-- rpix, gpix, bpix are [16][256] C arrays of FXPixel = 32-bit long values
	
	rpix: ARRAY [ INTEGER ] once create Result.make(0, (16 * 256)-0) end
	gpix: ARRAY [ INTEGER ] once create Result.make(0, (16 * 256)-0) end
	bpix: ARRAY [ INTEGER ] once create Result.make(0, (16 * 256)-0) end


	make_imp
		do
		end

	display: X_DISPLAY
		do
			Result := application.display
		end

	create_resource_imp
			-- Initialize
		require else
			display /= Void
		local
			nvi, i, d, dbest: INTEGER
		do
			if visual = Void then

					-- Assume the default
				visual := display.default_visual (application.display.default_screen)
				depth := XDefaultDepth (display.to_external, x_default_screen (display.to_external))
				
			    if (flags & VISUAL_TRUECOLOR) /= 0 then
					-- True color
			--      vitemplate.screen=DefaultScreen(DISPLAY(getApp()));
			--      vi := XGetVisualInfo(DISPLAY(getApp()),VisualScreenMask,&vitemplate,&nvi);
			--      if(vi){
			--        for(i=0,dbest=1000000; i<nvi; i++){
			--          if((vi[i].c_class==DirectColor) || (vi[i].c_class==TrueColor)){
			--            d=vi[i].depth-hint;
			--            if(d<0) d*=-100;         -- Strongly prefer >= hint
			--            if(d<dbest){
			--              dbest=d;
			--              visual=vi[i].visual;
			--              depth=vi[i].depth;
			--              }
			--            }
			--          }
			--        XFree((char*)vi);
			--        }
			--      }
			--
				-- Index color
				elseif (flags & VISUAL_INDEXCOLOR) /= 0 then
			--      vitemplate.screen=DefaultScreen(DISPLAY(getApp()));
			--      vi=XGetVisualInfo(DISPLAY(getApp()),VisualScreenMask,&vitemplate,&nvi);
			--      if(vi){
			--        for(i=0,dbest=1000000; i<nvi; i++){
			--          if((vi[i].c_class==StaticColor) || (vi[i].c_class==PseudoColor)){
			--            d=vi[i].depth-hint;
			--            if(d<0) d*=-100;
			--            if(d<dbest){
			--              dbest=d;
			--              visual=vi[i].visual;
			--              depth=vi[i].depth;
			--              }
			--            }
			--          }
			--        XFree((char*)vi);
			--        }
			--      }
			--
				--    // Gray scale color
				elseif (flags & VISUAL_GRAYSCALE) /= 0 then
			--      vitemplate.screen=DefaultScreen(DISPLAY(getApp()));
			--      vi=XGetVisualInfo(DISPLAY(getApp()),VisualScreenMask,&vitemplate,&nvi);
			--      if(vi){
			--        for(i=0,dbest=1000000; i<nvi; i++){
			--          if((vi[i].c_class==GrayScale) || (vi[i].c_class==StaticGray)){
			--            d=vi[i].depth-hint;
			--            if(d<0) d*=-100;
			--            if(d<dbest){
			--              dbest=d;
			--              visual=vi[i].visual;
			--              depth=vi[i].depth;
			--              }
			--            }
			--          }
			--        XFree((char*)vi);
			--        }
			--      }
				-- Get the best (deepest) visual
				elseif (flags & VISUAL_BEST) /= 0 then
			--		vitemplate.screen := DefaultScreen(DISPLAY(getApp()));
			--		vi := XGetVisualInfo(DISPLAY(getApp()),VisualScreenMask,&vitemplate,&nvi);
			--		if(vi) then
			--			for(i := 0, dbest := 1000000; i < nvi; i++){
			--				d := vi[i].depth - hint;
			--				if(d < 0) then d *= -100; end
			--				if(d < dbest) then
			--					dbest := d;
			--					visual := vi[i].visual;
			--					depth := vi[i].depth;
			--				end
			--			end
			--			XFree(vi);
			--		end

				-- Monochrome visual (for masks and stipples, not for windows)
				elseif (flags & VISUAL_MONOCHROME) /= 0 then
					numcolors := 2
					depth := 1
				else
					-- Visual_default ???
					-- check false end
				end
					-- Initialize colormap
				setup_colormap
					-- Make GC's for this visual
				gc			:= make_gc (False)
				scroll_gc	:= make_gc (True)
			end
		ensure then
			visual /= Void
		end

	destroy_resource_imp
		do
		end

	make_gc (gex: BOOLEAN): X_GC
			-- Make GC for this visual
		local
			gcv: X_GC_VALUES
			drawable: X_PIXMAP
			mask: INTEGER
		do
			create gcv.make
				check gcv.to_external /= default_pointer end
			gcv.set_fill_style (Fill_solid)
			gcv.set_graphics_exposures (gex)
			mask := Gc_fill_style | Gc_graphics_exposures

			-- Monochrome gc; create a temporary pixmap of depth 1
			if (flags & VISUAL_MONOCHROME) /= 0 then
				create drawable.make(display.default_root_window, 1, 1, 1);
				create Result.from_pixmap(drawable, display.default_screen, mask, gcv)
			--	drawable.free
    
			-- For default visual; this is easy as we already have a matching window
			elseif
				true
				--(visual==DefaultVisual(DISPLAY(getApp()),DefaultScreen(DISPLAY(getApp())))) 
					then
    			create Result.make(display.default_root_window, mask, gcv);

			-- For arbitrary visual; create a temporary pixmap of the same depth as the visual
			else
				create drawable.make(display.default_root_window, 1, 1, depth);
				create Result.from_pixmap(drawable, display.default_screen, mask, gcv)
			--	drawable.free
			end

		end


	pixel (clr: INTEGER): INTEGER
         	-- Get device pixel value for color
      	local
      	do
			inspect type
			when VISUALTYPE_TRUE then
				Result := (
						(rpix @ (256 + sbredval  (clr) + 1))
					|  (gpix @ (256 + sbgreenval(clr) + 1))
					|  (bpix @ (256 + sbblueval (clr) + 1)))
												
		--	when VISUALTYPE_INDEX   then	--	return lut[rpix[1][FXREDVAL(clr)]+gpix[1][FXGREENVAL(clr)]+bpix[1][FXBLUEVAL(clr)]];
		--	when VISUALTYPE_GRAY    then	--	return gpix[1][(77*FXREDVAL(clr)+151*FXGREENVAL(clr)+29*FXBLUEVAL(clr))>>8];
		--	when VISUALTYPE_MONO    then	--	return gpix[1][(77*FXREDVAL(clr)+151*FXGREENVAL(clr)+29*FXBLUEVAL(clr))>>8];
		--	when VISUALTYPE_UNKNOWN	then	--	return 0;
			else
				check false end
				Result := 0
			end
		--	edp_trace.start(0, "SB_VISUAL::pixel - clr: ").next(clr.out).next(" => ").next(Result.out).done
      	end

	color (pix: INTEGER): INTEGER
			-- Get color value for device pixel value
      local
		--  XColor color;
		do
		-- TODO
		--  color.pixel=pix;
		--  XQueryColor(application.display.to_external, colormap, $color);
		--  Result := FXRGB((color.red |>> 8), (color.green |>> 8), (color.blue |>> 8));
		ensure
			implemented: false
		end

	findshift(mask: INTEGER): INTEGER
			-- Find shift amount
		local
			sh: INTEGER
			b, t: INTEGER
		do
			from
				b := mask
				t := 1
			until
				(b & t) /= 0
			loop
				t := t |<< 1
				sh := sh + 1
			end
			Result := sh;
--		ensure f: false
		end


	-- Get number of bits in n
--static inline FXuint findnbits(FXPixel n){
--  register FXuint nb=0;
--  while(n){nb+=(n&1);n>>=1;}
--  return nb;
--  }

--	double_1_0: REAL_64 is 1.0	-- SE version
	double_1_0: DOUBLE = 1.0	-- EDP compatibility (at 6-5-2006)

	gamma_adjust(gamma: REAL_64; value, max: INTEGER): INTEGER
			-- Apply gamma correction to an intensity value in [0..max].
			-- SE implementation
		local
			x: REAL_64
			max_d: REAL_64
		do
			-- New SE version
			x := value
			max_d := max
			x := x / max_d
	--		Result := ((max_d * pow(x, double_1_0 / gamma)) + 0.0).floor				-- SE1.1
	--		Result := ((max_d * pow(x, double_1_0 / gamma)) + 0.0).force_to_integer_32	-- SE2.1rc#1
			Result := ((max_d * pow(x, double_1_0 / gamma)) + 0.0).truncated_to_integer	-- GEC
			-- SE version works

--	edp_trace.start(0, "SB_VISUAL::gamma_adjust - x: ")									.next(x.out).done
--	edp_trace.start(0, "SB_VISUAL::gamma_adjust - max_d: ")								.next(max_d.out).done
--	edp_trace.start(0, "SB_VISUAL::gamma_adjust - double_1_0 / gamma: ")				.next((double_1_0 / gamma).out).done
--	edp_trace.start(0, "SB_VISUAL::gamma_adjust - pow(x, double_1_0 / gamma)): ")		.next((pow(x, double_1_0 / gamma)).out).done
--	edp_trace.start(0, "SB_VISUAL::gamma_adjust - max_d * pow(x, double_1_0 / gamma): ").next((max_d * pow(x, double_1_0 / gamma)).out).done
--	edp_trace.start(0, "SB_VISUAL::gamma_adjust - Result: ")							.next((Result).out).done

			-- ISE Version
--			x := value
--			x := x / max
--			max_d := max
--		----	Result := ((x ^ (1.0 / gamma * max_d) + 0.5)).floor
--			Result := (pow(x, ((1.0 / gamma) * max_d)) + 0.5).floor
			
--			edp_trace.start(0, "SB_VISUAL::gamma_adjust - value/max: ").next(value.out).next("/").next(max.out).next(" => ").next(Result.out).done
--		ensure f: false
		end

	left_shift(i, by: INTEGER): INTEGER
		do
			if by = 0 then
				Result := i
			else
				Result := i |<< (by.to_integer_8)
			end
		--	edp_trace.start(0, "SB_VISUAL::left_shift i/by ").next(i.out).next("/").next(by.out).next(" => ").next(Result.out).done
		end


--/*******************************************************************************/

-- True Color is the current default for mbc-linux

	setup_true_color
			-- Setup for true color
		local
			redshift, greenshift, blueshift: INTEGER
			redmask,  greenmask,  bluemask : INTEGER
			redmax,   greenmax,   bluemax  : INTEGER
			i, c, mapsize, d, r,g,b: INTEGER
			gamma: REAL_64
		do
			-- Get gamma
		--	gamma := application.registry.read_real("SETTINGS", "displaygamma", 1.0)
			gamma := 1.0

			-- Get map size
			mapsize := visual.map_entries;
		--	edp_trace.start(0, "visual.map_entries: ").next(mapsize.out).done

			--  // Arrangement of pixels
			redmask  := visual.red_mask;
			greenmask:= visual.green_mask;
			bluemask := visual.blue_mask;
		--	edp_trace.start(0, "red/green/blue masks: ").next(redmask.out).next("/").next(greenmask.out).next("/").next(bluemask.out).done

			redshift  := findshift(redmask);
			greenshift:= findshift(greenmask);
			blueshift := findshift(bluemask);
		--	edp_trace.start(0, "red/green/blue shifts: ").next(redshift.out).next("/").next(greenshift.out).next("/").next(blueshift.out).done

			if redshift /= 0 then
				redmax := redmask |>> (redshift.to_integer_8)
			else
				redmax  := redmask;
			end
			if greenshift /= 0 then
				greenmax := greenmask |>> (greenshift.to_integer_8)
			else
				greenmax:= greenmask;
			end
			if blueshift /= 0 then
				bluemax := bluemask |>> (blueshift.to_integer_8)
			else
				bluemax := bluemask;
			end
		--	fx_trace(0, <<"red/green/blue max: ", redmax.out, "/", greenmax.out, "/", bluemax.out>>)

			numred  := redmax  + 1;
			numgreen:= greenmax+ 1;
			numblue := bluemax + 1;

			numcolors := numred * numgreen * numblue;


	if true then --####
			-- Make dither tables
			from d := 0 until d >= 16 loop
				from i := 0 until i >= 256 loop
					c := gamma_adjust(gamma, i, 255);
			--	fx_trace(0, <<once "gamma_adjust(gamma, ", i.out, once ", 255) = ", c.out>>)
					r := (redmax  * c + dither @ (d + 1)) // 255;
					g := (greenmax* c + dither @ (d + 1)) // 255;
					b := (bluemax * c + dither @ (d + 1)) // 255;
					rpix.put(left_shift(r, redshift  ), (d * 256) + i + 1)
					gpix.put(left_shift(g, greenshift), (d * 256) + i + 1)
					bpix.put(left_shift(b, blueshift ), (d * 256) + i + 1)
				--	fx_trace(0, <<"Table[ ", d.out, " ][ ", i.out, " ] => ", r.out, ", ", (left_shift(r, redshift)).out, 
				--														", ", g.out, ", ", (left_shift(g, greenshift)).out,
				--														", ", b.out, ", ", (left_shift(b, blueshift)).out>>)
				--
				--	fx_trace(0, <<"Table[ ", d.out, " ][ ", i.out, " ] => " , r.out, ", ", (rpix @ ((d * 256) + i + 1)).out, 
				--														", ", g.out, ", ", (gpix @ ((d * 256) + i + 1)).out,
				--														", ", b.out, ", ", (bpix @ ((d * 256) + i + 1)).out >>)
					i := i + 1
				end
				d := d + 1
			end

	end --### if

			-- What did we get
		--  fx_trace(150, <<"True color:"));
		--  fx_trace(150, <<"  visual id    = 0x%02x",((Visual*)visual)->visualid));
		--  fx_trace(150, <<"  depth        = %d",depth));
		--  fx_trace(150, <<"  gamma        = %6f",gamma));
		--  fx_trace(150, <<"  map_entries  = %d",mapsize));
		--  fx_trace(150, <<"  numcolors    = %d",numcolors));
		--  fx_trace(150, <<"  BitOrder     = %s",(BitmapBitOrder(DISPLAY(getApp()))==MSBFirst)?"MSBFirst":"LSBFirst"));
		--  fx_trace(150, <<"  ByteOrder    = %s",(ImageByteOrder(DISPLAY(getApp()))==MSBFirst)?"MSBFirst":"LSBFirst"));
		--  fx_trace(150, <<"  Padding      = %d",BitmapPad(DISPLAY(getApp()))));
		--  fx_trace(150, <<"  redmax       = %3d; redmask   =%08x; redshift   = %-2d",redmax,redmask,redshift));
		--  fx_trace(150, <<"  greenmax     = %3d; greenmask =%08x; greenshift = %-2d",greenmax,greenmask,greenshift));
		--  fx_trace(150, <<"  bluemax      = %3d; bluemask  =%08x; blueshift  = %-2d",bluemax,bluemask,blueshift));
		--
			-- Set type
			type := VISUALTYPE_TRUE;
		end


--*******************************************************************************
--
--
-- Setup direct color

	setup_direct_color
		require
			implemented: false
		local
--  register FXuint  redshift,greenshift,blueshift;
--  register FXPixel redmask,greenmask,bluemask;
--  register FXPixel redmax,greenmax,bluemax;
--  register FXuint  mapsize,maxcols,i,j,r,g,b,emax,rr,gg,bb,rm,gm,bm,em,d;
--  register FXuint  bestmatchr,bestmatchg,bestmatchb;
--  register FXdouble mindist,dist,gamma;
--  register FXbool gottable,allocedcolor;
--  XColor *table,color;
--  FXPixel *alloced;
--
		do
--  // Get gamma
--  gamma=getApp()->reg().readRealEntry("SETTINGS","displaygamma",1.0);
--
--  // Get map size
--  mapsize=((Visual*)visual)->map_entries;
--
--  // Arrangement of pi--xels
--  redmask=((Visual*)visual)->red_mask;
--  greenmask=((Visual*)visual)->green_mask;
--  bluemask=((Visual*)visual)->blue_mask;
--  redshift=findshift(redmask);
--  greenshift=findshift(greenmask);
--  blueshift=findshift(bluemask);
--  redmax=redmask>>redshift;
--  greenmax=greenmask>>greenshift;
--  bluemax=bluemask>>blueshift;
--
--  rm=redmax;
--  gm=greenmax;
--  bm=bluemax;
--  em=FXMAX3(rm,gm,bm);
--
--  // Maximum number of colors to allocate
--  maxcols=FXMIN(maxcolors,mapsize);
--
--  // No more allocations than allowed
--  if(redmax>=maxcols) redmax=maxcols-1;
--  if(greenmax>=maxcols) greenmax=maxcols-1;
--  if(bluemax>=maxcols) bluemax=maxcols-1;
--
--  numred=redmax+1;
--  numgreen=greenmax+1;
--  numblue=bluemax+1;
--  numcolors=numred*numgreen*numblue;
--  emax=FXMAX3(redmax,greenmax,bluemax);
--
--  gottable=0;
--
--  // Allocate color table
--  FXMALLOC(&table,XColor,mapsize);
--  FXMALLOC(&alloced,FXPixel,mapsize);
--
--  // Allocate ramp
--  for(i=r=g=b=0; i<=emax; i++){
--
--    // We try to get gamma-corrected colors
--    color.red=gamma_adjust(gamma,(r*65535)/redmax,65535);
--    color.green=gamma_adjust(gamma,(g*65535)/greenmax,65535);
--    color.blue=gamma_adjust(gamma,(b*65535)/bluemax,65535);
--    color.flags=DoRed|DoGreen|DoBlue;
--
--    // First try just using XAllocColor
--    allocedcolor=XAllocColor(DISPLAY(getApp()),colormap,&color);
--    if(!allocedcolor){
--
--      // Get colors in the map
--      if(!gottable){
--        rr=0;
--        gg=0;
--        bb=0;
--        for(j=0; j<mapsize; j++){
--          table[j].pixel=(rr<<redshift) | (gg<<greenshift) | (bb<<blueshift);
--          table[j].flags=DoRed|DoGreen|DoBlue;
--          if(rr<redmax) rr++;
--          if(gg<greenmax) gg++;
--          if(bb<bluemax) bb++;
--          }
--        XQueryColors(DISPLAY(getApp()),colormap,table,mapsize);
--        gottable=1;
--        }
--
--      // Find best match for red
--      for(mindist=1.0E10,bestmatchr=0,j=0; j<mapsize; j++){
--        dist=fxabs(color.red-table[j].red);
--        if(dist<mindist){ bestmatchr=j; mindist=dist; if(mindist==0.0) break; }
--        }
--
--      // Find best match for green
--      for(mindist=1.0E10,bestmatchg=0,j=0; j<mapsize; j++){
--        dist=fxabs(color.green-table[j].green);
--        if(dist<mindist){ bestmatchg=j; mindist=dist; if(mindist==0.0) break; }
--        }
--
--      // Find best match for blue
--      for(mindist=1.0E10,bestmatchb=0,j=0; j<mapsize; j++){
--        dist=fxabs(color.blue-table[j].blue);
--        if(dist<mindist){ bestmatchb=j; mindist=dist; if(mindist==0.0) break; }
--        }
--
--      // Now try to allocate this color
--      color.red=table[bestmatchr].red;
--      color.green=table[bestmatchg].green;
--      color.blue=table[bestmatchb].blue;
--
--      // Try to allocate the closest match color.  This should only
--      // fail if the cell is read/write.  Otherwise, we're incrementing
--      // the cell's reference count.
--      allocedcolor=XAllocColor(DISPLAY(getApp()),colormap,&color);
--      if(!allocedcolor){
--        color.red=table[bestmatchr].red;
--        color.green=table[bestmatchg].green;
--        color.blue=table[bestmatchb].blue;
--        color.pixel=(table[bestmatchr].pixel&redmask) | (table[bestmatchg].pixel&greenmask) | (table[bestmatchb].pixel&bluemask);
--        }
--      }
--
--    FXTRACE((200,"Alloc %3d %3d %3d (%6d %6d %6d) pixel=%08x\n",r,g,b,color.red,color.green,color.blue,color.pixel));
--
--    alloced[i]=color.pixel;
--
--    if(r<redmax) r++;
--    if(g<greenmax) g++;
--    if(b<bluemax) b++;
--    }
--
--  // Fill dither tables
--  for(d=0; d<16; d++){
--    for(i=0; i<256; i++){
--      rpix[d][i]=alloced[((redmax*i+dither[d])/255)]&redmask;
--      gpix[d][i]=alloced[((greenmax*i+dither[d])/255)]&greenmask;
--      bpix[d][i]=alloced[((bluemax*i+dither[d])/255)]&bluemask;
--      }
--    }
--
--  // Free table
--  FXFREE(&table);
--  FXFREE(&alloced);
--
--  // What did we get
--  FXTRACE((150,"Direct color:\n"));
--  FXTRACE((150,"  visual id    = 0x%02x\n",((Visual*)visual)->visualid));
--  FXTRACE((150,"  depth        = %d\n",depth));
--  FXTRACE((150,"  gamma        = %6f\n",gamma));
--  FXTRACE((150,"  map_entries  = %d\n",mapsize));
--  FXTRACE((150,"  numcolors    = %d\n",numcolors));
--  FXTRACE((150,"  redmax       = %3d; redmask   =%08x; redshift   = %-2d\n",redmax,redmask,redshift));
--  FXTRACE((150,"  greenmax     = %3d; greenmask =%08x; greenshift = %-2d\n",greenmax,greenmask,greenshift));
--  FXTRACE((150,"  bluemax      = %3d; bluemask  =%08x; blueshift  = %-2d\n",bluemax,bluemask,blueshift));
--
--  // Set type
--  type=VISUALTYPE_TRUE;
		end
--
--
--
--/*******************************************************************************/
--
--
--// Setup for pseudo color
	setup_pseudo_color
		require
			implemented: false
		local
--  register FXuint r,g,b,mapsize,bestmatch,maxcols,i,d;
--  register FXdouble mindist,dist,gamma,dr,dg,db;
--  register FXPixel redmax,greenmax,bluemax;
--  register FXbool gottable,allocedcolor;
--  XColor table[256],color;
--
		do
--  // Get gamma
--  gamma=getApp()->reg().readRealEntry("SETTINGS","displaygamma",1.0);
--
--  // Get map size
--  mapsize=((Visual*)visual)->map_entries;
--  if(mapsize>256) mapsize=256;
--
--  // How many colors to allocate
--  maxcols=FXMIN(maxcolors,mapsize);
--
--  // Find a product of r*g*b which will fit the available map.
--  // We prefer b+1>=g and g>=r>=b; start with 6x7x6 or 252 colors.
--  numred=6;
--  numgreen=7;
--  numblue=6;
--  while(numred*numgreen*numblue>maxcols){
--    if(numblue==numred && numblue==numgreen) numblue--;
--    else if(numred==numgreen) numred--;
--    else numgreen--;
--    }
--
--  // We want at most maxcols colors
--  numcolors=numred*numgreen*numblue;
--  redmax=numred-1;
--  greenmax=numgreen-1;
--  bluemax=numblue-1;
--  gottable=0;
--
--  // Allocate color ramp
--  for(r=0; r<numred; r++){
--    for(g=0; g<numgreen; g++){
--      for(b=0; b<numblue; b++){
--
--        // We try to get gamma-corrected colors
--        color.red=gamma_adjust(gamma,(r*65535)/redmax,65535);
--        color.green=gamma_adjust(gamma,(g*65535)/greenmax,65535);
--        color.blue=gamma_adjust(gamma,(b*65535)/bluemax,65535);
--        color.flags=DoRed|DoGreen|DoBlue;
--
--        // First try just using XAllocColor
--        allocedcolor=XAllocColor(DISPLAY(getApp()),colormap,&color);
--        if(!allocedcolor){
--
--          // Get colors in the map
--          if(!gottable){
--            for(i=0; i<mapsize; i++){
--              table[i].pixel=i;
--              table[i].flags=DoRed|DoGreen|DoBlue;
--              }
--            XQueryColors(DISPLAY(getApp()),colormap,table,mapsize);
--            gottable=1;
--            }
--
--          // Find best match
--          for(mindist=1.0E10,bestmatch=0,i=0; i<mapsize; i++){
--            dr=color.red-table[i].red;
--            dg=color.green-table[i].green;
--            db=color.blue-table[i].blue;
--            dist=dr*dr+dg*dg+db*db;
--            if(dist<mindist){
--              bestmatch=i;
--              mindist=dist;
--              if(mindist==0.0) break;
--              }
--            }
--
--          // Return result
--          color.red=table[bestmatch].red;
--          color.green=table[bestmatch].green;
--          color.blue=table[bestmatch].blue;
--
--          // Try to allocate the closest match color.  This should only
--          // fail if the cell is read/write.  Otherwise, we're incrementing
--          // the cell's reference count.
--          allocedcolor=XAllocColor(DISPLAY(getApp()),colormap,&color);
--
--          // Cell was read/write; we can't use read/write cells as some
--          // other app might change our colors and mess up the display.
--          // However, rumor has it that some X terminals and the Solaris
--          // X server have XAllocColor fail even if we're asking for a
--          // color which is known to be in the table; so we'll use this
--          // color anyway and hope nobody changes it..
--          if(!allocedcolor){
--            color.pixel=bestmatch;
--            color.red=table[bestmatch].red;
--            color.green=table[bestmatch].green;
--            color.blue=table[bestmatch].blue;
--            }
--          }
--
--        // Remember this color
--        lut[(r*numgreen+g)*numblue+b]=color.pixel;
--        }
--      }
--    }
--
--  // Set up dither table
--  for(d=0; d<16; d++){
--    for(i=0; i<256; i++){
--      r=(redmax*i+dither[d])/255;
--      g=(greenmax*i+dither[d])/255;
--      b=(bluemax*i+dither[d])/255;
--      rpix[d][i]=r*numgreen*numblue;
--      gpix[d][i]=g*numblue;
--      bpix[d][i]=b;
--      }
--    }
--
--  // What did we get
--  FXTRACE((150,"Pseudo color display:\n"));
--  FXTRACE((150,"  visual id    = 0x%02x\n",((Visual*)visual)->visualid));
--  FXTRACE((150,"  depth        = %d\n",depth));
--  FXTRACE((150,"  gamma        = %6f\n",gamma));
--  FXTRACE((150,"  map_entries  = %d\n",mapsize));
--  FXTRACE((150,"  numcolors    = %d\n",numcolors));
--  FXTRACE((150,"  redmax       = %d\n",redmax));
--  FXTRACE((150,"  greenmax     = %d\n",greenmax));
--  FXTRACE((150,"  bluemax      = %d\n",bluemax));
--
--  // Set type
--  type=VISUALTYPE_INDEX;
		end
--
--
--/*******************************************************************************/
--
--
	setup_static_color
			-- Setup for static color
		require
			implemented: false
		local
--  register FXuint mapsize,bestmatch,i,nr,ng,nb,r,g,b,j,d;
--  register FXdouble mindist,dist,gamma,dr,dg,db;
--  register FXPixel redmax,greenmax,bluemax;
--  FXbool rc[256],gc[256],bc[256];
--  XColor table[256],color;
--
		do
--  // Get gamma
--  gamma=getApp()->reg().readRealEntry("SETTINGS","displaygamma",1.0);
--  mapsize=((Visual*)visual)->map_entries;
--  if(mapsize > 256) mapsize=256;
--
--  // Read back table
--  for(i=0; i<mapsize; i++) table[i].pixel=i;
--  XQueryColors(DISPLAY(getApp()),colormap,table,mapsize);
--
--  // How many shades of r,g,b do we have?
--  for(i=0; i<256; i++){ rc[i]=gc[i]=bc[i]=0; }
--  for(i=0; i<mapsize; i++){
--    rc[table[i].red/257]=1;
--    gc[table[i].green/257]=1;
--    bc[table[i].blue/257]=1;
--    }
--  nr=ng=nb=0;
--  for(i=0; i<256; i++){
--    if(rc[i]) nr++;
--    if(gc[i]) ng++;
--    if(bc[i]) nb++;
--    }
--  FXTRACE((200,"nr=%3d ng=%3d nb=%3d\n",nr,ng,nb));
--
--  // Limit to a reasonable table size
--  if(nr*ng*nb>4096){
--    numred=16;
--    numgreen=16;
--    numblue=16;
--    }
--  else{
--    numred=nr;
--    numgreen=ng;
--    numblue=nb;
--    }
--
--  numcolors=numred*numgreen*numblue;
--  redmax=numred-1;
--  greenmax=numgreen-1;
--  bluemax=numblue-1;
--
--  // Allocate color ramp
--  for(r=0; r<numred; r++){
--    for(g=0; g<numgreen; g++){
--      for(b=0; b<numblue; b++){
--
--        // Color to get
--        color.red=gamma_adjust(gamma,(r*65535)/redmax,65535);
--        color.green=gamma_adjust(gamma,(g*65535)/greenmax,65535);
--        color.blue=gamma_adjust(gamma,(b*65535)/bluemax,65535);
--
--        // Find best match
--        for(mindist=1.0E10,bestmatch=0,j=0; j<mapsize; j++){
--          dr=(color.red-table[j].red);
--          dg=(color.green-table[j].green);
--          db=(color.blue-table[j].blue);
--          dist=dr*dr+dg*dg+db*db;
--          if(dist<mindist){
--            bestmatch=j;
--            mindist=dist;
--            if(mindist==0.0) break;
--            }
--          }
--
--        // Add color into table
--        lut[(r*numgreen+g)*numblue+b]=table[bestmatch].pixel;
--        }
--      }
--    }
--
--  // Set up dither table
--  for(d=0; d<16; d++){
--    for(i=0; i<256; i++){
--      r=(redmax*i+dither[d])/255;
--      g=(greenmax*i+dither[d])/255;
--      b=(bluemax*i+dither[d])/255;
--      rpix[d][i]=r*numgreen*numblue;
--      gpix[d][i]=g*numblue;
--      bpix[d][i]=b;
--      }
--    }
--
--  // What did we get
--  FXTRACE((150,"Static color:\n"));
--  FXTRACE((150,"  visual id    = 0x%02x\n",((Visual*)visual)->visualid));
--  FXTRACE((150,"  depth        = %d\n",depth));
--  FXTRACE((150,"  gamma        = %6f\n",gamma));
--  FXTRACE((150,"  map_entries  = %d\n",mapsize));
--  FXTRACE((150,"  numcolors    = %d\n",numcolors));
--  FXTRACE((150,"  redmax       = %d\n",redmax));
--  FXTRACE((150,"  greenmax     = %d\n",greenmax));
--  FXTRACE((150,"  bluemax      = %d\n",bluemax));
--
--  // Set type
--  type=VISUALTYPE_INDEX;
		end
--
--
--/*******************************************************************************/
--
--
		--// Setup for gray scale
	setup_grayscale
		require
			implemented: false
		local
		--  register FXuint g,bestmatch,mapsize,maxcols,graymax,i,d;
		--  register FXdouble mindist,dist,gamma,dr,dg,db;
		--  register FXbool gottable,allocedcolor;
		--  XColor table[256],color;
		--  FXPixel alloced[256];
		do
		--  // Get gamma
		--  gamma=getApp()->reg().readRealEntry("SETTINGS","displaygamma",1.0);
		--
		--  // Get map size
		--  mapsize=((Visual*)visual)->map_entries;
		--  if(mapsize>256) mapsize=256;
		--
		--  // How many to allocate
		--  maxcols=FXMIN(mapsize,maxcolors);
		--
		--  // Colors
		--  numcolors=maxcols;
		--  graymax=numcolors-1;
		--  gottable=0;
		--
		--  // Allocate gray ramp
		--  for(g=0; g<numcolors; g++){
		--
		--    // We try to allocate gamma-corrected colors!
		--    color.red=color.green=color.blue=gamma_adjust(gamma,(g*65535)/graymax,65535);
		--    color.flags=DoRed|DoGreen|DoBlue;
		--
		--    // First try just using XAllocColor
		--    allocedcolor=XAllocColor(DISPLAY(getApp()),colormap,&color);
		--    if(!allocedcolor){
		--
		--      // Get colors in the map
		--      if(!gottable){
		--        for(i=0; i<mapsize; i++){
		--          table[i].pixel=i;
		--          table[i].flags=DoRed|DoGreen|DoBlue;
		--          }
		--        XQueryColors(DISPLAY(getApp()),colormap,table,mapsize);
		--        gottable=1;
		--        }
		--
		--      // Find best match
		--      for(mindist=1.0E10,bestmatch=0,i=0; i<mapsize; i++){
		--        dr=color.red-table[i].red;
		--        dg=color.green-table[i].green;
		--        db=color.blue-table[i].blue;
		--        dist=dr*dr+dg*dg+db*db;
		--        if(dist<mindist){
		--          bestmatch=i;
		--          mindist=dist;
		--          if(mindist==0.0) break;
		--          }
		--        }
		--
		--      // Return result
		--      color.red=table[bestmatch].red;
		--      color.green=table[bestmatch].green;
		--      color.blue=table[bestmatch].blue;
		--
		--      // Try to allocate the closest match color.  This should only
		--      // fail if the cell is read/write.  Otherwise, we're incrementing
		--      // the cell's reference count.
		--      allocedcolor=XAllocColor(DISPLAY(getApp()),colormap,&color);
		--
		--      // Cell was read/write; we can't use read/write cells as some
		--      // other app might change our colors and mess up the display.
		--      // However, rumor has it that some X terminals and the Solaris
		--      // X server have XAllocColor fail even if we're asking for a
		--      // color which is known to be in the table; so we'll use this
		--      // color anyway and hope nobody changes it..
		--      if(!allocedcolor){
		--        color.pixel=bestmatch;
		--        color.red=table[bestmatch].red;
		--        color.green=table[bestmatch].green;
		--        color.blue=table[bestmatch].blue;
		--        }
		--      }
		--
		--    // Keep track
		--    alloced[g]=color.pixel;
		--    }
		--
		--  // Set up color ramps
		--  for(d=0; d<16; d++){
		--    for(i=0; i<256; i++){
		--      rpix[d][i]=gpix[d][i]=bpix[d][i]=alloced[(graymax*i+dither[d])/255];
		--      }
		--    }
		--
		--  // What did we get
		--  FXTRACE((150,"Gray Scale:\n"));
		--  FXTRACE((150,"  visual id    = 0x%02x\n",((Visual*)visual)->visualid));
		--  FXTRACE((150,"  depth        = %d\n",depth));
		--  FXTRACE((150,"  gamma        = %6f\n",gamma));
		--  FXTRACE((150,"  map_entries  = %d\n",mapsize));
		--  FXTRACE((150,"  numcolors    = %d\n",numcolors));
		--  FXTRACE((150,"  graymax      = %d\n",graymax));
		--
		--  // Set type
		--  type=VISUALTYPE_GRAY;
		end
--
--
--/*******************************************************************************/


	setup_static_gray
			-- Setup for static gray
		require
			implemented: false
		local
		--  register FXuint i,d,c,graymax;
		--  register FXdouble gamma;
		do
		--  // Get gamma
		--  gamma=getApp()->reg().readRealEntry("SETTINGS","displaygamma",1.0);
		--
		--  // Number of colors
		--  numcolors=((Visual*)visual)->map_entries;
		--  graymax=(numcolors-1);
		--
		--  // Set up color ramps
		--  for(d=0; d<16; d++){
		--    for(i=0; i<256; i++){
		--      c=gamma_adjust(gamma,i,255);
		--      rpix[d][i]=gpix[d][i]=bpix[d][i]=(graymax*c+dither[d])/255;
		--      }
		--    }
		--
		--  // What did we get
		--  FXTRACE((150,"Static Gray:\n"));
		--  FXTRACE((150,"  visual id    = 0x%02x\n",((Visual*)visual)->visualid));
		--  FXTRACE((150,"  depth        = %d\n",depth));
		--  FXTRACE((150,"  gamma        = %6f\n",gamma));
		--  FXTRACE((150,"  map_entries  = %d\n",((Visual*)visual)->map_entries));
		--  FXTRACE((150,"  numcolors    = %d\n",numcolors));
		--  FXTRACE((150,"  graymax      = %d\n",graymax));
		--
		--  type=VISUALTYPE_GRAY;
		end

--/*******************************************************************************/

	setup_pixmap_mono
			-- Setup for pixmap monochrome; this one has no colormap!
		require
			implemented: false
		local
			d, i, c: INTEGER
			gamma: REAL_64
		do

--  // Get gamma
--  gamma=getApp()->reg().readRealEntry("SETTINGS","displaygamma",1.0);
--
--  // Number of colors
--  numcolors=2;
--
--  // Set up color ramps
--  for(d=0; d<16; d++){
--    for(i=0; i<256; i++){
--      c=gamma_adjust(gamma,i,255);
--      rpix[d][i]=gpix[d][i]=bpix[d][i]=(c+dither[d])/255;
--      }
--    }
--
--  // What did we get
--  FXTRACE((150,"Pixmap monochrome:\n"));
--  FXTRACE((150,"  depth        = %d\n",depth));
--  FXTRACE((150,"  gamma        = %6f\n",gamma));
--  FXTRACE((150,"  map_entries  = %d\n",2));
--  FXTRACE((150,"  numcolors    = %d\n",2));
--  FXTRACE((150,"  black        = 0\n"));
--  FXTRACE((150,"  white        = 1\n"));
--
--  // Set type
--  type=VISUALTYPE_MONO;
		end
--
--
--
--/*******************************************************************************/
--
--// Try determine standard colormap
--static FXbool getstdcolormap(Display *dpy,VisualID visualid,XStandardColormap& map){
--  XStandardColormap *stdmaps=NULL;
--  int status,count,i;
--  status=XGetRGBColormaps(dpy,RootWindow(dpy,DefaultScreen(dpy)),&stdmaps,&count,XA_RGB_DEFAULT_MAP);
--  if(status){
--    status=FALSE;
--    for(i=0; i<count; i++){
--      FXTRACE((150,"Standarn XA_RGB_DEFAULT_MAP map #%d:\n",i));
--      FXTRACE((150,"  colormap   = %d\n",stdmaps[i].colormap));
--      FXTRACE((150,"  red_max    = %d  red_mult   = %d\n",stdmaps[i].red_max,stdmaps[i].red_mult));
--      FXTRACE((150,"  green_max  = %d  green_mult = %d\n",stdmaps[i].green_max,stdmaps[i].green_mult));
--      FXTRACE((150,"  blue_max   = %d  blue_mult  = %d\n",stdmaps[i].blue_max,stdmaps[i].blue_mult));
--      FXTRACE((150,"  base pixel = %d\n",stdmaps[i].base_pixel));
--      FXTRACE((150,"  visualid   = 0x%02x\n",stdmaps[i].visualid));
--      FXTRACE((150,"  killid     = %d\n",stdmaps[i].killid));
--      if(stdmaps[i].visualid==visualid){
--        FXTRACE((150,"  Matched\n"));
--        map=stdmaps[i];
--        status=1;
--        break;
--        }
--      }
--    }
--  if(stdmaps) XFree(stdmaps);
--  return status;
--  }


	setup_colormap
			-- Determine colormap, then initialize it
		local
			i: INTEGER
		do
			if (flags & VISUAL_MONOCHROME) /= 0 then
			--	colormap := None;
			--	fx_trace(150, <<class_name, "::create: need no colormap">>);
			--	setup_pixmap_mono;
			else
				if false then --((flags & VISUAL_OWNCOLORMAP) /= 0 or else (visual /= DefaultVisual(DISPLAY(getApp()),DefaultScreen(DISPLAY(getApp()))))) then
				--	colormap := x_create_colormap(application.display.to_external, RootWindow(DISPLAY(getApp()),0),((Visual*)visual),AllocNone);
				--	FXTRACE((150,"%s::create: allocate colormap\n",getClassName()));
				--	freemap := True;
				else
					colormap := display.default_colormap(display.default_screen)
				--	fx_trace(150, <<class_name, "::create: use default colormap">>);
				end
				inspect visual.visual_class
				when TrueColor		then setup_true_color;		--	fx_trace(0, <<"setup_colormap: TrueColor"	>> )	-- Current default
				when DirectColor	then setup_direct_color;	--	fx_trace(0, <<"setup_colormap: DirectColor"	>> )
				when PseudoColor	then setup_pseudo_color;	--	fx_trace(0, <<"setup_colormap: PseudoColor"	>> )
				when StaticColor	then setup_static_color;	--	fx_trace(0, <<"setup_colormap: StaticColor"	>> )
				when GrayScale		then setup_grayscale;		--	fx_trace(0, <<"setup_colormap: GrayScale"	>> )
				when StaticGray		then setup_static_gray;		--	fx_trace(0, <<"setup_colormap: StaticGray"	>> )
				end
			end
		end

	class_name: STRING = "SB_VISUAL"


end
