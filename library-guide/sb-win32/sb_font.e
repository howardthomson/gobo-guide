indexing
	description:"The Font"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Partly complete"

class SB_FONT

inherit

	SB_FONT_DEF
		redefine
			get_text_height_offset,
			fall_back_font
		end

	SB_DEFS

create

	make, make_opts, make_from_description, make_from_string

feature -- not implemented

	is_font_mono: BOOLEAN is
		do
			-- TODO
		end

	has_char (c: CHARACTER): BOOLEAN is
		do
		end

	right_bearing (c: CHARACTER): INTEGER is
		do
		end

feature -- Creation

	make_imp is
		do
		end

feature -- Queries

	create_resource_imp is
			-- Create the font
		local
        	dcf	: SB_WAPI_DEVICE_CONTEXT_FUNCTIONS
        	lf	: SB_WAPI_LOGFONT
         	dp	: SB_WAPI_DEVICE_PARAMETERS
         	ff	: SB_WAPI_FONT_AND_TEXT_FUNCTIONS
         	outp: SB_WAPI_FONT_OUTPUT_PRECISION
         	clip: SB_WAPI_FONT_CLIPPING_PRECISION
         	fq	: SB_WAPI_FONT_OUTPUT_QUALITY
         	fp	: SB_WAPI_FONT_PITCH_AND_FAMILY

         	pf	: INTEGER_32
         	t	: INTEGER
         	t1	: POINTER
      	do
        		-- Hang on to this for text metrics functions
        	dc := dcf.CreateCompatibleDC (default_pointer)
            	-- Now fill in the fields
            create lf.make
            lf.set_lfHeight (- MulDiv(size, dcf.GetDeviceCaps (dc, dp.LOGPIXELSY), 720))
            lf.set_lfWidth (0)
            lf.set_lfEscapement (0)
            lf.set_lfOrientation (0)
            lf.set_lfWeight (weight)
            if (slant = FONTSLANT_ITALIC) or (slant = FONTSLANT_OBLIQUE) then
            	lf.set_lfItalic (True)
            else
            	lf.set_lfItalic (False)
            end
            lf.set_lfUnderline (False)
            lf.set_lfStrikeOut (False)

            	-- Character set encoding
        --#	lf.set_lfCharSet(FXFontEncoding2CharSet(encoding));

            	-- Other hints
            lf.set_lfOutPrecision (outp.OUT_DEFAULT_PRECIS);
            if (hints & FONTHINT_SYSTEM) /= Zero then
            	lf.set_lfOutPrecision (outp.OUT_RASTER_PRECIS);
            end
            if (hints & FONTHINT_SCALABLE) /= Zero then
            	lf.set_lfOutPrecision (outp.OUT_TT_PRECIS)
            end
            if (hints & FONTHINT_POLYMORPHIC) /= Zero then
            	lf.set_lfOutPrecision (outp.OUT_TT_PRECIS)
            end

            	-- Clip precision
            lf.set_lfClipPrecision (clip.CLIP_DEFAULT_PRECIS.to_integer)

            	-- Quality
            lf.set_lfQuality (fq.DEFAULT_QUALITY)

            	-- Pitch and Family
            	-- Pitch
            if (hints & FONTPITCH_FIXED) /= Zero then
            	pf := fp.FIXED_PITCH;
            elseif (hints & FONTPITCH_VARIABLE) /= Zero then
            	pf := pf | fp.VARIABLE_PITCH
            else
            	pf := pf | fp.DEFAULT_PITCH
            end
            	-- Family
            if (hints & FONTHINT_DECORATIVE) /= Zero then
            	pf := pf | fp.FF_DECORATIVE
            elseif(hints & FONTHINT_MODERN) /= Zero then
            	pf := pf | fp.FF_MODERN
            elseif (hints & FONTHINT_ROMAN) /= Zero then
            	pf := pf | fp.FF_ROMAN
            elseif (hints & FONTHINT_SCRIPT) /= Zero then
            	pf := pf | fp.FF_SCRIPT
            elseif (hints & FONTHINT_SWISS) /= Zero then
            	pf := pf | fp.FF_SWISS
            else
            	pf := pf | fp.FF_DONTCARE
            end
            lf.set_lfPitchAndFamily (pf)

				-- Font substitution
            if not name.is_empty then
            	lf.set_lfFaceName (application.registry.read_string_entry ("FONTSUBSTITUTIONS", name, name))
            end
            	-- Here we go!
            resource_id := ff.CreateFontIndirect (lf.ptr)

         	if is_attached then
            	create font.make
            		-- Obtain text metrics
            	t1 := dcf.SelectObject (dc, resource_id)
            	t := ff.GetTextMetrics (dc, font.ptr)
            end
		end

	get_font_width: INTEGER is
			-- Width of widest character in font
		do
    		if font /= Void then
				Result := font.tmMaxCharWidth
			else
            	Result := 1
         	end
      	end

   font_height, get_font_height: INTEGER is
         -- Height of highest character in font
      do
         if font /= Void then
            Result := font.tmHeight
         else
            Result := 1
         end
      end

   ascent, get_font_ascent: INTEGER is
         -- Ascent from baseline
      do
         if font /= Void then
            Result := font.tmAscent;
         else
            Result := 1
         end
      end

   descent, get_font_descent: INTEGER is
         -- Descent from baseline
      do
         if font /= Void then
            Result := font.tmDescent
         else
            Result := 1
         end
      end

   text_width_offset, get_text_width_offset (text: STRING; strt, count: INTEGER): INTEGER is
         -- Calculate width of given text in this font
      require else
         non_void_text: text /= Void
         valid_start: strt > 0
         valid_count: strt+count <= text.count + 1
      local
         p: POINTER
         mem: MEMORY
         ff: SB_WAPI_FONT_AND_TEXT_FUNCTIONS
         struct_size: SB_WAPI_SIZE
         t: INTEGER
      do
         if font /= Void then
            if dc /= default_pointer then
               mem.collection_off
               p := text.area.base_address + (strt - 1)
               t := ff.GetTextExtentPoint32 (dc, p, count, struct_size.ptr)
               mem.collection_on
               Result := struct_size.cx
            else
               -- todo Error
            end
         else
            Result := count
         end
      end

   get_text_height_offset (text: STRING; strt, count: INTEGER): INTEGER is
         -- Calculate height of given text in this font
      require else
         text_not_void: text /= Void
         valid_start: strt > 0
         valid_count: strt + count <= text.count + 1
      local
         p: POINTER
         mem: MEMORY
         ff: SB_WAPI_FONT_AND_TEXT_FUNCTIONS
         struct_size: SB_WAPI_SIZE
         t: INTEGER
      do
         if font /= Void then
            if dc /= default_pointer then
               mem.collection_off
               p := text.area.base_address + (strt - 1)
               t := ff.GetTextExtentPoint32 (dc, p, count, struct_size.ptr)
               mem.collection_on
               Result := struct_size.cy
            else
               -- todo Error
            end
         else
            Result := 1
         end
      end

   list_fonts (face: STRING; wt, sl, sw, en: INTEGER; h: INTEGER_32): ARRAY [SB_FONT_DESC] is
         -- List all fonts matching hints
      do
      end

feature {NONE} -- Implementation

   dc: POINTER

   font: SB_WAPI_TEXTMETRIC;
         -- Info about the font

   MulDiv(number, numerator, denominator: INTEGER): INTEGER is
      external "C use <windows.h>"
      alias "MulDiv"
      end

   find_best_font (fontname: STRING): STRING is
      do
      end

   fall_back_font: STRING is
      do
      end

   find_match(fontname, family: STRING): STRING is
      do
      end

end -- class SB_FONT
