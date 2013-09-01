-- X Window System Implementation
note

	todo: "[
		Fix deferred features etc
	]"

class SB_FONT

inherit
	SB_FONT_DEF
		rename
			resource_id as xfont
		redefine
			xfont
		end

	X11_EXTERNAL_ROUTINES
--	SB_ZERO

create
	make

feature

	xfont: X_FONT_WITH_STRUCT

	make_imp
		do
			hints := FONTHINT_X11         -- X11 font string method
		end

	create_resource_imp
		do
				-- X11 font specification
			if (hints & FONTHINT_X11) /= 0 then
				check
					-- Should have non-NULL font name
					name_ok: name /= Void and then name.count > 0
				end
				create xfont.make (application.display, name);
			else
					-- Platform independent specification
				check false end
				-- FXTRACE((150,"%s::create: face: %s size: %d weight: %d slant: %d encoding: %d hints: %04x\n",getClassName(),name.text()?name.text():"none",size,weight,slant,encoding,hints));
				-- Try load best font

				-- create xfont.make(application.display, find_best_font);
			end

				-- If we still don't have a font yet, try fallback fonts
			if (xfont = Void) or else not xfont.is_valid then
				if xfont = Void then
					create xfont.make (application.display, fallbackfont);
				else
					xfont.make (application.display, fallbackfont);
				end
			end
		ensure then
			valid_font: xfont /= Void and then xfont.is_attached
		end

	-- XLFD Fields
	XLFD_FOUNDRY      : INTEGER = 1
	XLFD_FAMILY       : INTEGER = 2
	XLFD_WEIGHT       : INTEGER = 3
	XLFD_SLANT        : INTEGER = 4
	XLFD_SETWIDTH     : INTEGER = 5
	XLFD_ADDSTYLE     : INTEGER = 6
	XLFD_PIXELSIZE    : INTEGER = 7
	XLFD_POINTSIZE    : INTEGER = 8
	XLFD_RESOLUTION_X : INTEGER = 9
	XLFD_RESOLUTION_Y : INTEGER = 10
	XLFD_SPACING      : INTEGER = 11
	XLFD_AVERAGE      : INTEGER = 12
	XLFD_REGISTRY     : INTEGER = 13
	XLFD_ENCODING     : INTEGER = 14

	-- Match factors
	ENCODING_FACTOR   : INTEGER = 0x00000100	-- 256
	PITCH_FACTOR      : INTEGER = 0x00000080	-- 128
	RESOLUTION_FACTOR : INTEGER = 0x00000040	-- 64
	SCALABLE_FACTOR   : INTEGER = 0x00000020	-- 32
	POLY_FACTOR       : INTEGER = 0x00000010	-- 16
	SIZE_FACTOR       : INTEGER = 0x00000008	-- 8
	WEIGHT_FACTOR     : INTEGER = 0x00000004	-- 4
	SLANT_FACTOR      : INTEGER = 0x00000002	-- 2
	SETWIDTH_FACTOR   : INTEGER = 0x00000001	-- 1

	FONTHINT_MASK: INTEGER
		once
			Result := (FONTHINT_DECORATIVE | FONTHINT_MODERN | FONTHINT_ROMAN | FONTHINT_SCRIPT | FONTHINT_SWISS | FONTHINT_SYSTEM)
		end

	has_char (ch: CHARACTER): BOOLEAN
			-- A glyph exists for the given character
		do
			-- Need to convert ch to INTEGER ??
	--		Result := (first_char <= ch) and ch <= last_char
		ensure then f: false
		end

	first_char: INTEGER
		do
	--		Result := font_struct.min_char_or_byte2
		ensure then f: false
		end

	last_char: INTEGER
		do
	--		Result := font_struct.max_char_or_byte2
		ensure then f: false
		end

--	/*******************************************************************************/

	weight_from_text (text: STRING): INTEGER
			-- Convert text to font weight
		require
			text /= Void and then text.count >= 2
		local
			c1, c2: CHARACTER
		do
			c1 := (text @ 1).as_lower
			c2 := (text @ 2).as_lower

			if 		c1 = 'l' and c2 = 'i' then Result := FONTWEIGHT_LIGHT;
			elseif 	c1 = 'n' and c2 = 'o' then Result := FONTWEIGHT_NORMAL;
			elseif 	c1 = 'r' and c2 = 'e' then Result := FONTWEIGHT_REGULAR;
			elseif 	c1 = 'm' and c2 = 'e' then Result := FONTWEIGHT_MEDIUM;
			elseif 	c1 = 'd' and c2 = 'e' then Result := FONTWEIGHT_DEMIBOLD;
			elseif 	c1 = 'b' and c2 = 'o' then Result := FONTWEIGHT_BOLD;
			elseif 	c1 = 'b' and c2 = 'l' then Result := FONTWEIGHT_BLACK;
			else							   Result := FONTWEIGHT_DONTCARE;
			end
		end

	slant_from_text (text: STRING): INTEGER
			-- Convert text to slant
		local
			c1, c2: CHARACTER
		do
			c1 := (text @ 1).as_lower
			c2 := (text @ 2).as_lower

			if c1 = 'i' then
				Result :=  FONTSLANT_ITALIC
			elseif c1 = 'o' then
				Result :=  FONTSLANT_OBLIQUE
			elseif c1 = 'r' and c2 = 'i' then
				Result :=  FONTSLANT_REVERSE_ITALIC
			elseif c1 = 'r' and c2 = 'o' then
				Result :=  FONTSLANT_REVERSE_OBLIQUE
			elseif c1 = 'r' then
				Result :=  FONTSLANT_REGULAR
			else
				Result := FONTSLANT_DONTCARE
			end
		end

	set_width_from_text (text: STRING): INTEGER
			-- Convert text to setwidth
		require
			text /= Void and then text.count >= 1
		local
			t0, t1, t2, t3, t4, t5, t6: CHARACTER
		do
			t0 := text @ 1
			if 		t0 = 'm' then				Result := FONTSETWIDTH_MEDIUM;
			elseif	t0 = 'w' then				Result :=  FONTSETWIDTH_EXTRAEXPANDED;
			elseif	t0 = 'r' then				Result :=  FONTSETWIDTH_MEDIUM;
			elseif	t0 = 'c' then				Result :=  FONTSETWIDTH_CONDENSED;
			elseif	text.count >= 2 and then t0 = 'n' then
				t1 := text @ 2
			  	if		t1 = 'a' then		  	Result :=  FONTSETWIDTH_CONDENSED;
			  	elseif	t1 = 'o' then	  		Result :=  FONTSETWIDTH_MEDIUM;
			  	else					  		Result :=  FONTSETWIDTH_DONTCARE;
			  	end
			elseif	text.count >= 3
				and then	 t0 = 'e'
					and text @ 1 = 'x'
					and text @ 2 = 'p' then
												Result :=  FONTSETWIDTH_EXPANDED;
			elseif	text.count >= 6
				and then	t0 = 'e'
					and text @ 1 ='x'
					and text @ 2 ='t'
					and text @ 3 ='r'
					and text @ 4 ='a' then
			  			if		text @ 5 = 'c' then	  	Result :=  FONTSETWIDTH_EXTRACONDENSED;
			  			elseif	text @ 5 = 'e' then 	Result :=  FONTSETWIDTH_EXTRAEXPANDED;
			  			else					  		Result :=  FONTSETWIDTH_DONTCARE;
						end
			elseif text.count >= 6
				and then	t0 = 'u'
					and text @ 1 = 'l'
					and text @ 2 = 't'
					and text @ 3 = 'r'
					and text @ 4 = 'a' then
			  			if		text @ 5 = 'c' then		Result :=  FONTSETWIDTH_ULTRACONDENSED;
			  			elseif	text @ 5 = 'e' then	 	Result :=  FONTSETWIDTH_ULTRAEXPANDED;
						else			  				Result :=  FONTSETWIDTH_DONTCARE;
						end
			elseif text.count >= 6
				and then
					(t0 = 's' or else t0 = 'd')
					and text @ 1 = 'e'
					and text @ 2 = 'm'
					and text @ 3 = 'i' then
			  			if		text @ 5 = 'c' then		Result :=  FONTSETWIDTH_SEMICONDENSED;
			  			elseif	text @ 5 = 'e' then	  	Result :=  FONTSETWIDTH_SEMIEXPANDED;
			  			else			  				Result :=  FONTSETWIDTH_DONTCARE;
						end
			else
				Result :=  FONTSETWIDTH_DONTCARE;
			end
		end

	pitch_from_text (text: STRING): INTEGER
			-- Convert pitch to flags
		require
			text /= Void and then text.count >= 1
		local
			c: CHARACTER
		do
			c := (text @ 1).as_lower;
			if c = 'p' then
				Result := FONTPITCH_VARIABLE;
			elseif c = 'm' or else c = 'c' then
				Result :=  FONTPITCH_FIXED;
			else
				Result :=  FONTPITCH_DEFAULT;
			end
		end

	isISO8859 (text: STRING): BOOLEAN
			-- Test if font is ISO8859
		require
			text /= Void
		do
			if text.count >= 7 then
				Result := (text @ 1).as_lower = 'i'
				and then  (text @ 2).as_lower = 's'
				and then  (text @ 3).as_lower = 'o'
				and then  (text @ 4) = '8'
				and then  (text @ 5) = '8'
				and then  (text @ 6) = '5'
				and then  (text @ 7) = '9'
			end
		end

	isKOI8 (text: STRING): BOOLEAN
			-- Test if font is KOI8
		require
			text /= Void
		do
			Result :=
				text.count >= 4
				and then (text @ 1).as_lower = 'k'
				and then (text @ 2).as_lower = 'o'
				and then (text @ 3).as_lower = 'i'
				and then (text @ 4) = '8'
		end

	is_multi_byte (text: STRING): BOOLEAN
			-- Test if font is multi-byte
		do
			-- Unicode font; not yet ...
		--	if text.count >= 6
		--	and then  (text @ 1).as_lower = 'i'
		--	and then  (text @ 2).as_lower = 's'
		--	and then  (text @ 3).as_lower = 'o'
		--	and then text[3]=='6'
		--	and then text[4]=='4'
		--	and then text[5]=='6') then
				Result := True;
		--	elseif

			-- Japanese font => "jisx..."
			if text.count >= 4
			and then (text @ 1).as_lower = 'j'
			and then (text @ 2).as_lower = 'i'
			and then (text @ 3).as_lower = 's'
			and then (text @ 4) = 'x' then
				Result := True;

			-- Chinese font
			elseif text.count >= 2
			and then (text @ 1).as_lower = 'g'
			and then (text @ 2).as_lower = 'b' then
				Result := True

			-- Another type of chinese font
			elseif text.count >= 4
			and then (text @ 1).as_lower = 'b'
			and then (text @ 2).as_lower = 'i'
			and then (text @ 3).as_lower = 'g'
			and then (text @ 4) = '5' then
				Result := True

			-- Korean
			elseif text.count >= 3
			and then (text @ 1).as_lower = 'k'
			and then (text @ 2).as_lower = 's'
			and then (text @ 3).as_lower = 'c'
			then
				Result := True
			else
				Result := False;
			end
		end


--	/*******************************************************************************/


--	list_font_names (pattern: STRING; nfound: INTEGER_REF): POINTER is
	list_font_names (pattern: STRING; nfound: ANY): POINTER
		require
			implemented: false
		local
			maxfnames: INTEGER
			p: POINTER
			numfnames: INTEGER
		do
			from
				maxfnames := 1024
			--	p := XListFonts(application.display.to_external, pattern.to_external, maxfnames, $numfnames)
			until
				p = default_pointer or else numfnames < maxfnames
			loop
			--	XFreeFontNames(p)
				maxfnames := maxfnames * 2
			--	p := XListFonts(application.display.to_external, pattern.to_external, maxfnames, $numfnames)
			end
			Result := p
	--#		nfound.set_item(numfnames)
		end

	matching_fonts (d: X_DISPLAY; pattern: STRING): INTEGER
			-- Return number of fonts matching name
		require
		--	implemented: false
		local
			fnames: POINTER;
			numfnames: INTEGER_REF;
		do
		--	create numfnames
		--	fnames := list_font_names(pattern, numfnames);
		--	XFreeFontNames(fnames);
		--	if (numfnames.item > 0) then fx_trace(100,<<"matched: ", pattern>>) end
		--	Result := numfnames.item;
		end

	parse_fontname (fname: STRING): BOOLEAN
			-- Parse font name into parts
		local
			f, i, last_i: INTEGER
			fs: STRING
		do
--			if fname /= Void and then (fname @ 1) = '-' then
--				from
--					f := 1;
--					i := 2
--					last_i := i
--				until
--					i > fname.count or Result
--				loop
--					if (fname @ i) = '-' then
--						fs := (fields @ i)
--						fs.copy(fname)
--						fs.shrink(last_i, i - 1)
--						f := f + 1
--						if f > XLFD_ENCODING then
--							Result := True
--						end
--						last_i := i + 1
--					end
--					i := i + 1
--				end
--			end
		ensure then f: false
		end

	fields: ARRAY [ STRING ]
		local
			i: INTEGER
			s: STRING
		once
			create Result.make(1,14)
			from
				i := 1
			until
				i > 14
			loop
				create s.make_empty
				Result.put(s, i)
				i := i + 1
			end
		end

	find_match (a_fontname, family: STRING): STRING
			-- Try find matching font
		local
			pattern: STRING
			fontname: STRING
			fnames: POINTER

			bestf, bestdweight, bestdsize, bestvalue, bestscalable, bestxres, bestyres: INTEGER
			screenres, xres, yres: INTEGER
			dweight, w, scalable, polymorphic, dsize: INTEGER
			numfnames, f, value: INTEGER
			sw, sz, sl, pitch, en: INTEGER -- Unsigned

			p: POINTER
		--	ap: expanded NATIVE_ARRAY [ POINTER ]	-- SE implementation
			ap: ARRAY [ POINTER ]	-- was expanded !
		do
--
--			-- Get fonts matching the pattern
--			pattern := concat(<<"-*-", family, "-*-*-*-*-*-*-*-*-*-*-*-*">>)
--
--			fnames := list_font_names(pattern, numfnames);
--			if fnames = default_pointer then
--				Result := Void
--			else
--
--				-- Init match values
--				bestf := -1;
--				bestvalue := 0;
--				bestdsize := 10000000;
--				bestdweight := 10000000;
--				bestscalable := 0;
--				bestxres := 75;
--				bestyres := 75;
--
--				-- Perhaps override screen resolution via registry
--				screenres := application.registry.read_integer_entry("SETTINGS", "screenres", 100);
--
--					-- Validate
--				if screenres <  50 then screenres :=  50 end
--				if screenres > 200 then screenres := 200 end
--
--				-- Loop over all fonts to find the best match
--				from
--					f := 0
--				until
--					f >= numfnames
--				loop
--				--	strncpy(fname, fnames[f], 299);
--					ap.from_pointer(fnames)
--					fname.from_external_copy(ap @ (f - 1))
--					if parse_fontname(fname) then
--
--						-- This font's match value
--						value := 0;
--						scalable := 0;
--					    polymorphic := 0;
--					    dsize := 1000000;
--					    dweight := 1000;
--
--						-- Match encoding
--					    if encoding = FONTENCODING_DEFAULT then
--					        if not is_multibyte(fields @ XLFD_REGISTRY) then
--								value := value + ENCODING_FACTOR;
--					        end
--					    else
--					        if isISO8859(fields @ XLFD_REGISTRY) then
--					          	en := FONTENCODING_ISO_8859_1 + atoi(fields @ XLFD_ENCODING) - 1;
--
--					        elseif isKOI8(fields @ XLFD_REGISTRY) then
--					          	if ((fields @ XLFD_ENCODING) @ 0).as_lower = 'u' then
--					            	en := FONTENCODING_KOI8_U;
--					          	elseif ((fields @ XLFD_ENCODING) @ 0) = 'r' then
--					            	en := FONTENCODING_KOI8_R;
--					          	else
--					            	en := FONTENCODING_KOI8;
--					          	end
--					        else
--					        	en := FONTENCODING_DEFAULT;
--					        end
--					        if en = encoding then
--								value := value + ENCODING_FACTOR;
--							end
--						end
--
--						-- Check pitch
--					    pitch := pitch_from_text(fields @ XLFD_SPACING);
--					    if (hints & FONTPITCH_FIXED) /= 0 then
--					        if (pitch & FONTPITCH_FIXED) /= 0 then
--								value := value + PITCH_FACTOR;
--					   		end
--					    elseif (hints & FONTPITCH_VARIABLE) /= 0 then
--					        if (pitch & FONTPITCH_VARIABLE) /= 0 then
--								value := value + PITCH_FACTOR;
--							end
--					    else
--					        value := value + PITCH_FACTOR;
--					    end
--
--						-- Scalable
--					    if(EQUAL1(fields @ XLFD_PIXELSIZE, '0') and then EQUAL1(fields @ XLFD_POINTSIZE, '0') and then EQUAL1(fields @ XLFD_AVERAGE, '0')) then
--					        value := value + SCALABLE_FACTOR;
--					        scalable := 1;
--					    else
--					        if (hints & FONTHINT_SCALABLE) = 0 then
--								value := value + SCALABLE_FACTOR;
--							end
--					    end
--
--						-- Polymorphic
--					    if(EQUAL1(fields @ XLFD_WEIGHT, '0') or else EQUAL1(fields @ XLFD_SETWIDTH, '0') or else EQUAL1(fields @ XLFD_SLANT, '0') or else EQUAL1(fields @ XLFD_ADDSTYLE, '0')) then
--					        value := value + POLY_FACTOR;
--					        polymorphic := 1;
--					    else
--					        if (hints & FONTHINT_POLYMORPHIC) = 0 then
--								value := value + POLY_FACTOR;
--							end
--					    end
--
--						-- Check weight
--					    if(weight = FONTWEIGHT_DONTCARE) then
--					        dweight := 0;
--					    else
--					        w := weightfromtext(fields @ XLFD_WEIGHT);
--					        dweight := w - weight;
--					        dweight := FXABS(dweight);
--					    end
--
--						-- Check slant
--					    if(slant = FONTSLANT_DONTCARE) then
--					        value := value + SLANT_FACTOR;
--					    else
--					        sl := slantfromtext(fields @ XLFD_SLANT);
--					        if (sl = slant) then
--								value := value + SLANT_FACTOR;
--							end
--					    end
--
--						-- Check SetWidth
--					    if(setwidth = FONTSETWIDTH_DONTCARE) then
--					    	value := value + SETWIDTH_FACTOR;
--					    else
--					        sw := set_width_from_text(fields @ XLFD_SETWIDTH);
--					        if setwidth = sw then
--					        	value := value + SETWIDTH_FACTOR
--					        end
--					    end
--
--						-- If the font can be rendered at any resolution, we'll render at our actual device resolution
--					    if(EQUAL1(fields @ XLFD_RESOLUTION_X, '0') and then EQUAL1(fields @ XLFD_RESOLUTION_Y, '0')) then
--					        xres := screenres;
--					        yres := screenres;
--						-- Else get the resolution for which the font is designed
--					    else
--					        xres := atoi(fields @ XLFD_RESOLUTION_X);
--					        yres := atoi(fields @ XLFD_RESOLUTION_Y);
--					    end
--
--						-- If scalable, we can of course get the exact size we want
--						-- We do not set dsize to 0, as we prefer a bitmapped font that gets within
--						-- 10% over a scalable one that's exact, as the bitmapped fonts look much better
--						-- at small sizes than scalable ones...
--						if(scalable) then
--							value := value + SIZE_FACTOR;
--							dsize := size // 10;
--
--						-- Otherwise, we try to get something close
--					    else
--
--							-- We correct for the actual screen resolution; if the font is rendered at a
--							-- 100 dpi, and we have a screen with 90dpi, the actual point size of the font
--							-- should be multiplied by (100/90).
--							sz := (yres * atoi(fields @ XLFD_POINTSIZE)) // screenres;
--
--							-- We strongly prefer the largest pointsize not larger than the desired pointsize
--					        if sz <= size then
--					          	value := value + SIZE_FACTOR;
--					          	dsize := size - sz;
--
--							-- But if we can't get that, we'll take anything thats close...
--					        else
--					          	dsize := sz - size;
--					        end
--					    end
--
--						-- How close is the match?
--					    if 		value > bestvalue
--					    		or else	((value = bestvalue) and then (dsize < bestdsize))
--					    		or else ((value = bestvalue) and then (dsize = bestdsize) and then (dweight < bestdweight)) then
--					    	bestvalue := value;
--					    	bestdsize := dsize;
--					    	bestdweight := dweight;
--					    	bestscalable := scalable;
--					    	bestxres := xres;
--					    	bestyres := yres;
--					    	bestf := f;
--					    end
--					end
--				end
--				if 0 <= bestf then
--					if bestscalable = 0 then
--				    --	strncpy(fontname, fnames @ bestf, 299);
--				    else
--				    --	strncpy(fname, fnames @ bestf, 299);
--				    --	parsefontname(field, fname);
--
--						-- Build XLFD, correcting for possible difference between font resolution and screen resolution
--					    fontname := concat(<<"-", fields @ XLFD_FOUNDRY, "-", fields @ XLFD_FAMILY, "-", fields @ XLFD_WEIGHT, "-", fields @ XLFD_SLANT,
--											"-", fields @ XLFD_SETWIDTH, "-", fields @ XLFD_ADDSTYLE, "-*-", ((bestyres*size)/screenres).out,
--											"-", bestxres, "-", bestyres, "-", fields @ XLFD_SPACING, "-*-", fields @ XLFD_REGISTRY, "-", fields @ XLFD_ENCODING>>)
--					end
--					Result := fontname
--				end
--				XFreeFontNames(fnames);
--			end
		ensure then f: false
		end

	concat (a_s: ARRAY [ STRING ]): STRING
		local
			i: INTEGER
		do
			create Result.make_empty
			from
				i := 1
			until
				i > a_s.count
			loop
				Result.append(a_s @ i)
				i := i + 1
			end
		end

	find_best_font (fontname: STRING): STRING
			-- Try load the best matching font
		local
			match: STRING
		do
			-- Try specified font family first
			if name.count > 0 then
				match := find_match(fontname, application.registry.read_string_entry("FONTSUBSTITUTIONS", name, name));
			end

			-- Try swiss if we didn't have a match yet
			if match = Void and then ((hints & (FONTHINT_SWISS | FONTHINT_SYSTEM)) /= 0 or else (hints & FONTHINT_MASK) = 0) then
				match := find_match(fontname, application.registry.read_string_entry("FONTSUBSTITUTIONS", "helvetica", "helvetica"));
			end

			-- Try roman if we didn't have a match yet
			if match = Void and then ((hints & FONTHINT_ROMAN) /= 0 or else (hints & FONTHINT_MASK) = 0) then
				match := find_match(fontname, application.registry.read_string_entry("FONTSUBSTITUTIONS", "times", "times"));
			end

			-- Try modern if we didn't have a match yet
			if match = Void and then ((hints & FONTHINT_MODERN) /= 0 or else (hints & FONTHINT_MASK) = 0) then
			    match := find_match(fontname, application.registry.read_string_entry("FONTSUBSTITUTIONS", "courier", "courier"));
			end

			-- Try decorative if we didn't have a match yet
			if match = Void and then ((hints & FONTHINT_DECORATIVE) /= 0 or else (hints & FONTHINT_MASK) = 0) then
				match := find_match(fontname, application.registry.read_string_entry("FONTSUBSTITUTIONS", "gothic", "gothic"));
			end

		--	  return fontname;
		end

	swiss_fallback: ARRAY[STRING]
			-- Try these fallbacks for swiss hint
		once
			Result := <<
				"-*-helvetica-bold-r-*-*-*-120-*-*-*-*-*-*",
				"-*-lucida-bold-r-*-*-*-120-*-*-*-*-*-*",
				"-*-helvetica-medium-r-*-*-*-120-*-*-*-*-*-*",
				"-*-lucida-medium-r-*-*-*-120-*-*-*-*-*-*",
				"-*-helvetica-*-*-*-*-*-120-*-*-*-*-*-*",
				"-*-lucida-*-*-*-*-*-120-*-*-*-*-*-*"
			>>
		end

	roman_fallback: ARRAY[STRING]
			-- Try these fallbacks for times hint
		once
			Result := <<
				"-*-times-bold-r-*-*-*-120-*-*-*-*-*-*",
				"-*-charter-bold-r-*-*-*-120-*-*-*-*-*-*",
				"-*-times-medium-r-*-*-*-120-*-*-*-*-*-*",
				"-*-charter-medium-r-*-*-*-120-*-*-*-*-*-*",
				"-*-times-*-*-*-*-*-120-*-*-*-*-*-*",
				"-*-charter-*-*-*-*-*-120-*-*-*-*-*-*"
			>>
		end

	modern_fallback: ARRAY[STRING]
			-- Try these fallbacks for modern hint
		once
			Result := <<
				"-*-courier-bold-r-*-*-*-120-*-*-*-*-*-*",
				"-*-lucidatypewriter-bold-r-*-*-*-120-*-*-*-*-*-*",
				"-*-courier-medium-r-*-*-*-120-*-*-*-*-*-*",
				"-*-lucidatypewriter-medium-r-*-*-*-120-*-*-*-*-*-*",
				"-*-courier-*-*-*-*-*-120-*-*-*-*-*-*",
				"-*-lucidatypewriter-*-*-*-*-*-120-*-*-*-*-*-*"
			>>
		end

	final_fallback: ARRAY[STRING]
			-- Try these final fallbacks
		once
			Result := <<
				"7x13",
				"8x13",
				"7x14",
				"8x16",
				"9x15"
			>>
		end

	fallbackfont: STRING
			-- See which fallback font exists
		local
			fname: STRING
			i: INTEGER
		do

		-- Try swiss if we wanted swiss, or if we don't care
		--	  if((hints&FONTHINT_SWISS) || !(hints&FONTHINT_MASK)) then
		--	    while((fname=swiss_fallback @ i)!=NULL){
		--	      if(matching_fonts(DISPLAY(getApp()),fname)>0) break;
		--	      i++;
		--	      }
		--	    }
		--
		--	  // Try roman if we wanted roman, or if we don't care
		--	  if(!fname and then ((hints&FONTHINT_ROMAN) || !(hints&FONTHINT_MASK))) then
		--	    while((fname=roman_fallback @ i)!=NULL){
		--	      if(matching_fonts(DISPLAY(getApp()),fname)>0) break;
		--	      i++;
		--	      }
		--	    }


	if false then --###
			-- Try modern if we wanted modern, or if we don't care
			if fname = Void and then ((hints & FONTHINT_MODERN) /= 0 or else (hints & FONTHINT_MASK) = 0) then
				from
					i := 1
					fname := modern_fallback @ i
				until
					fname = Void or else matching_fonts(application.display, fname) > 0
				loop
					i := i + 1
					if i <= modern_fallback.count then
						fname := modern_fallback @ i
					else
						fname := Void
					end
				end
			end

			-- Try final fallback fonts
			if fname = Void then
				from
					i := 1
					fname := final_fallback @ i
				until
					fname = Void or else matching_fonts(application.display, fname) > 0
				loop
					i := i + 1
					if i <= final_fallback.count then
						fname := final_fallback @ i
					else
						fname := Void
					end
				end
			end
	end --### if false
			if fname = Void then
				fname := "fixed";
			end

			Result := fname;
		end


--	/*******************************************************************************/


	detach
			-- Detach font
		do
			if xfont /= Void then
			--	    // Free font struct w/o doing anything else...
			--	    XFreeFont(DISPLAY(getApp()),(XFontStruct*)font);
			--	    font=NULL;
			--	    xid=0;
			end
		end


	destroy
			-- Destroy font
		do
			if xfont /= Void then
				if application.initialized then
				--	      // Delete font & metrics
				--	      XFreeFont(application.display.to_external, font);
				end
			--	xfont := Void;
			--	xid=0;
			end
		end

--#################################################################################################################

	text_width_offset, get_text_width_offset (text: STRING; start, count: INTEGER): INTEGER
		do
			if text.count = 0 then
				--	Result := 0
			elseif xfont /= Void and then xfont.is_attached then
		--		Result := XTextWidth(xfont.to_external, text.to_external + (start - 1), count)
				Result := xfont.query_font.text_width_n (text, start, count)
			end
		end

	-- Get font leading [that is lead-ing as in Pb!]
	get_font_leading: INTEGER
		do
--			if xfont /= Void then
--				Result := xfont.ascent + xfont.descent - xfont.max_bounds.ascent - xfont.max_bounds.descent;
--			else
--				Result := 0;
--			end
		ensure then f: false
		end

	get_font_spacing: INTEGER
			-- Get font line spacing [height+leading]
		local
			fs: X_FONT_STRUCT
		do
			if xfont /= Void then
				fs := xfont.query_font
				Result := fs.ascent + fs.descent;
			else
				Result := 1;
			end
		end

	left_bearing(ch: CHARACTER): INTEGER
		local
			c: CHARACTER
		do
--			todo("SB_FONT::per_char access")
--
--			c := ch
--			if xfont /= Void then
--				if xfont.per_char /= Void then
--	      			if not has_char(c) then
--	      				c := xfont.default_char;
--	      			end
--	      			--Result := xfont.per_char(ch - xfont.min_char_or_byte2).lbearing;
--				else
--					Result := xfont.max_bounds.lbearing;
--				end
--			else
--				Result := 0;
--			end
		ensure then f: false
		end

	right_bearing(ch: CHARACTER): INTEGER
		local
			c: CHARACTER
		--	xpc: X_CHAR_STRUCT
		do
--			c := ch
--			if xfont /= Void then
--				if xfont.per_char /= Void then
--	      			if not has_char(c) then
--	      				c := xfont.default_char;
--	      			end
--				--	Result := xfont.per_char(ch - xfont.min_char_or_byte2).rbearing;
--				else
--					Result := xfont.max_bounds.rbearing;
--				end
--			else
--				Result := 0;
--			end
		ensure then f: false
		end

	is_font_mono: BOOLEAN
		do
--			if xfont /= Void then
--				Result := xfont.min_bounds.width = xfont.max_bounds.width;
--			else
--				Result := True;	--
--			end
		ensure then f: false
		end

	get_font_width: INTEGER
			-- Get font width
		do
--			if xfont /= Void then
--				Result := xfont.max_bounds.width;
--			else
--				Result := 1;
--			end
		ensure then f: false
		end

	font_height, get_font_height: INTEGER
			-- Get font height
		do
			if xfont /= Void then
			--	    return ((XFontStruct*)font)->ascent+((XFontStruct*)font)->descent;  // This is wrong!
			--	    //return ((XFontStruct*)font)->max_bounds.ascent+((XFontStruct*)font)->max_bounds.descent;  // This is right!
				Result := xfont.query_font.ascent + xfont.query_font.descent
			else
				Result := 1;
			end
		end

	ascent, get_font_ascent: INTEGER
			-- Get font ascent
		do
			if xfont /= Void then
				Result := xfont.query_font.ascent;
			else
				result := 1;
			end
		end

	descent, get_font_descent: INTEGER
			-- Get font descent
		do
			if xfont /= Void then
				Result := xfont.query_font.descent;
			else
				Result := 0;
			end
		end

--	get_text_width(text: STRING, n: INTEGER): INTEGER is
--			-- Text width
--		require
--            text = Void implies n = 0
--            text /= Void implies n <= text.count
--        do
--            if xfont /= Void then
--                Result := x_text_width(xfont.to_external, text.to_external, n);
--            else
--                Result := n;
--            end
--        end


	Xget_text_height(text: STRING; n: INTEGER): INTEGER
			-- Text height
		require
            text = Void implies n = 0
            text /= Void implies n <= text.count
        local
        	 dir, asc, desc: INTEGER
        --	 chst: X_CHAR_STRUCT
		do
			if xfont /= Void then
		--		x_text_extents(xfont.to_external, text.to_external, n, $dir, $asc, $desc, $chst);
	    		Result := asc + desc;
			else
				Result := 1
			end
		end

--	/*******************************************************************************/

	compare_font(a, b: SB_FONT_DESC): INTEGER
			-- Function to sort by name, weight, slant, and size
		local
			cmp: INTEGER
		do
		--	cmp := a.face.compare(b.face)
			if cmp /= 0 then
				Result := cmp
			elseif a.weight /= b.weight then
				Result := a.weight - b.weight
			elseif a.slant /= b.slant then
				Result := a.slant - b.slant
			else
				Result := a.size - b.size;
			end
		end


--	list_fonts(XXXX): BOOLEAN is

	list_fonts(
		fonts: ARRAY [ SB_FONT_DESC ];
--		face: STRING
--    	wt,				-- weight
--    	sl,				-- slant
--    	sw,				-- width
--    	a_en: INTEGER	-- encoding
--    	h: INTEGER	-- Hints
						): BOOLEAN
			-- List all fonts matching hints
		require
--			app_exists: application.instance /= Void
        --    display_is_open: application.display
		local
--			en: INTEGER
--		      l_size, l_weight, slant, encoding, setwidth: INTEGER
--		      flags: INTEGER;
--		      screenres, xres, yres: INTEGER
--			pattern, fname: STRING
--			fields: ARRAY [ STRING ]
--			fnames: ARRAY [ STRING ]
--			scal: STRING;
--			facename: STRING;
--			f, j: INTEGER
--			addit: BOOLEAN
		do
--
--			-- Screen resolution may be overidden by registry
--			screenres := application.registry.read_unsigned_entry("SETTINGS", "screenres", 100);
--
--			-- Validate
--			if screenres <  50 then screenres :=  50 end
--			if screenres > 200 then screenres := 200 end
--
--			en := a_en
--			if en > FONTENCODING_KOI8_UNIFIED then
--				en := FONTENCODING_DEFAULT
--			end
--
--			-- Define pattern to match against
--			if (h & FONTHINT_X11) /= 0 then
--				facename := "*";
--			    if face.count /= 0 then
--					facename := face
--				end
--				pattern := facename;	-- clone ??
--
--			-- Match XLFD fonts; try to limit the number by using
--			-- some of the info we already have acquired.
--			else
--				scal := "*";
--			    if (h & FONTHINT_SCALABLE) /= 0 then
--					scal := "0";
--				end
--			    facename := "*";
--			    if face.count /= 0 then
--					facename := face
--				end
--				pattern := concat(<<"-*-", facename, "-*-*-*-*-", scal, "-", scal, "-*-*-*-", scal, "-*-*">>)
--			end
--
--			-- Get list of all font names
--			fnames := list_font_names(application.display, pattern);
--			if fnames = Void then
--				Result := False
--			else
--				-- Add all matching fonts to the list
--				from
--					f := 1
--				until
--					f > fnames.count
--				loop
--					fname := fnames @ f
--
--					-- XLFD font name; parse out unique face names
--					if parse_font_name(fields, fname) then
--						flags := 0B;
--						-- Get encoding
--						if isISO8859(fields @ XLFD_REGISTRY) then
--			      			encoding := FONTENCODING_ISO_8859_1 + atoi(fields @ XLFD_ENCODING) - 1;
--			      		elseif isKOI8(fields @ XLFD_REGISTRY) then
--			        		if ((fields @ XLFD_ENCODING) @ 0) = 'u' or else ((fields @ XLFD_ENCODING) @ 0) = 'U' then
--			          			encoding := FONTENCODING_KOI8_U;
--			        		elseif ((fields @ XLFD_ENCODING) @ 0) = 'r' or else ((fields @ XLFD_ENCODING) @ 0) = 'R' then
--			          			encoding := FONTENCODING_KOI8_R;
--							else
--					  			encoding := FONTENCODING_KOI8;
--							end
--						else
--							encoding := FONTENCODING_DEFAULT;
--						end
--
--						-- Skip if no match
--						if (en /= FONTENCODING_DEFAULT) and then (en /= encoding) then
--							--continue;
--						end
--
--						-- Get pitch
--						flags := flags or pitch_from_text(fields @ XLFD_SPACING);
--
--						-- Skip this font if pitch does not match
--						if ((h & FONTPITCH_FIXED) /= 0 and then (flags & FONTPITCH_FIXED) = 0) then
--							continue;
--						end
--
--						if((h & FONTPITCH_VARIABLE) /= 0 and then (flags & FONTPITCH_VARIABLE) = 0) then
--							--continue;
--						end
--
--						-- Skip if weight does not match
--						l_weight := weight_from_text(fields @ XLFD_WEIGHT);
--						if((wt /= FONTWEIGHT_DONTCARE) and then (wt /= l_weight)) then
--							--continue;
--						end
--
--						-- Skip if slant does not match
--			      		slant := slant_from_text(fields @ XLFD_SLANT);
--			      		if((sl /= FONTSLANT_DONTCARE) and then (sl /= slant)) then
--							--continue;
--						end
--
--						-- Skip if setwidth does not match
--			      		setwidth := set_width_from_text(fields @ XLFD_SETWIDTH);
--			      		if((sw /= FONTSETWIDTH_DONTCARE) and then (sw /= setwidth)) then
--							--continue;
--						end
--
--						-- Scalable
--			      		if(EQUAL1(fields @ XLFD_PIXELSIZE,'0') and then EQUAL1(fields @ XLFD_POINTSIZE,'0') and then EQUAL1(fields @ XLFD_AVERAGE,'0')) then
--			        		flags := flags | FONTHINT_SCALABLE;
--			      		end
--
--						-- Polymorphic
--			      		if(EQUAL1(fields @ XLFD_WEIGHT,'0') || EQUAL1(fields @ XLFD_SETWIDTH,'0') || EQUAL1(fields @ XLFD_SLANT,'0') || EQUAL1(fields @ XLFD_ADDSTYLE,'0')) then
--			        		flags := flags | FONTHINT_POLYMORPHIC;
--			      		end
--
--						-- Get Font resolution
--			      		if(EQUAL1(fields @ XLFD_RESOLUTION_X,'0') and then EQUAL1(fields @ XLFD_RESOLUTION_Y,'0')) then
--							xres := screenres;
--			        		yres := screenres;
--			      		else
--			        		xres := atoi(fields @ XLFD_RESOLUTION_X);
--			        		yres := atoi(fields @ XLFD_RESOLUTION_Y);
--			      		end
--
--						-- Get size, corrected for screen resolution
--						if((flags and FONTHINT_SCALABLE) = 0) then
--							l_size := (yres * atoi(fields @ XLFD_POINTSIZE)) / screenres;
--			      		else
--			        		l_size := 0;
--			      		end
--
--
--			      		addit := True;
--
--						-- If NULL face name, just list one of each face
--		--	      		if face.empty then
--		--	        		for(j=numfonts-1; j>=0; j--){
--		--	          			if(strcmp(fields @ XLFD_FAMILY, fonts[j].face)==0){
--		--	            			addit=0;
--		--	            			break;
--		--	            		}
--		--	          		}
--		--	      		end
--
--			      		if addit then
--		--	        		strncpy(fonts[numfonts].face,fields @ XLFD_FAMILY],sizeof(fonts[0].face));
--		--	        		fonts[numfonts].size	= l_size;
--		--	        		fonts[numfonts].weight	= l_weight;
--		--	        		fonts[numfonts].slant	= slant;
--		--	        		fonts[numfonts].encoding= encoding;
--		--	        		fonts[numfonts].setwidth= setwidth;
--		--	        		fonts[numfonts].flags	= flags;
--		--	        		numfonts++;
--			        	end
--
--
--					-- X11 font, add it to the list
--			    	else
--		--	      		strncpy(fonts[numfonts].face,fnames[f],sizeof(fonts[0].face));
--		--	      		fonts[numfonts].size	= 0;
--		--	      		fonts[numfonts].weight	= FONTWEIGHT_DONTCARE;
--		--	      		fonts[numfonts].slant	= FONTSLANT_DONTCARE;
--		--	      		fonts[numfonts].encoding= FONTENCODING_DEFAULT;
--		--	      		fonts[numfonts].setwidth= FONTSETWIDTH_DONTCARE;
--		--	      		fonts[numfonts].flags	= FONTHINT_X11;
--		--	      		numfonts++;
--			    	end
--				end
--
--				-- Any fonts found?
--		--	  	if(numfonts==0){
--		--	    return FALSE;
--		--	    }
--		--
--		--
--		--	  	// Sort them by name, weight, slant, and size respectively
--		--	  	qsort(fonts, numfonts, sizeof(FXFontDesc), comparefont);
--		--
--				-- Free the font names
--		--		XFreeFontNames(fnames);
--			end
		ensure f: false
		end

	atoi(s: STRING): INTEGER
		do
			Result := s.to_integer
		end

end
