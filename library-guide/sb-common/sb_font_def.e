note

		description: "The Font"

	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Partly complete"
	todo: "[
		fix deferred features etc
	]"

deferred class SB_FONT_DEF

inherit

	SB_SERVER_RESOURCE
		redefine
			detach_resource,
			destruct
		end

	SB_FONT_CONSTANTS

feature -- Creation

	make_from_string (a: SB_APPLICATION; nm: STRING)
    		-- Construct a font with given X11 font string
		do
        	init
        	create name.make_from_string (nm)
        	size := 0
			weight := 0
			slant := 0
			encoding := FONTENCODING_DEFAULT
			setwidth := FONTSETWIDTH_DONTCARE
			make_imp
		end

	make_from_description (a: SB_APPLICATION; font_desc: SB_FONT_DESC)
			-- Construct font from font description
      	do
         	init
         	create name.make_from_string (font_desc.face)
         	size := font_desc.size
         	weight := font_desc.weight
         	slant := font_desc.slant
         	encoding := font_desc.encoding
         	setwidth := font_desc.setwidth
         	hints := font_desc.flags       -- We may get system dependent fonts
			make_imp
		end

	make (a: SB_APPLICATION; face: STRING; sz: INTEGER)
			-- Construct a font with given face name, size in points(pixels), weight,
			-- slant, character set encoding, setwidth, and hints
		do
			make_opts(a, face, sz, FONTWEIGHT_NORMAL, FONTSLANT_REGULAR, FONTENCODING_DEFAULT,
				FONTSETWIDTH_DONTCARE, 0)
		end

	make_opts (a: SB_APPLICATION; face: STRING; sz, wt, sl, enc,
                      setw: INTEGER ; h: INTEGER)
         -- Construct a font with:
         --		given face name,
         --		size in points(pixels),
         --		weight,
         -- 	slant,
         --		character set encoding,
         --		setwidth,
         --		and hints
      	require
         	application_not_void: a /= Void
         	face_name_not_void: face /= Void
      	do
         	init
         	create name.make_from_string (face)
         	size := 10 * sz
         	weight := wt
         	slant := sl
         	encoding := enc
         	setwidth := setw
         	hints := h & (FONTHINT_X11).bit_not    -- System-independent method
			make_imp
      	end

	make_imp
		deferred
		end

feature -- Queries

	name    : STRING              -- Name of the font
	size    : INTEGER             -- Font size (points*10)
	weight  : INTEGER             -- Font weight
	slant   : INTEGER             -- Font slant
	encoding: INTEGER             -- Character set encoding
	setwidth: INTEGER             -- Relative setwidth
	hints   : INTEGER             -- Matching hints

	create_resource
			-- Create the font
		do
        	if not is_attached then
            	if application.initialized then
					create_resource_imp
            	end
         	end
      	end

	create_resource_imp
   		deferred
   		end

   	detach_resource
    		-- Detach the font
		do
		end

	destroy_resource
			-- Destroy the font
      	do
      	end

   	get_font_desc: SB_FONT_DESC
    		-- Get font description
      	do
      	end

   	set_font_desc (desc: SB_FONT_DESC)
         	-- Set font description
      	do
      	end

   	is_font_mono: BOOLEAN
         	-- Find out if the font is monotype or proportional
      	deferred
      	end

   has_char (ch: CHARACTER): BOOLEAN
         -- See if font has glyph for ch
      deferred
      end

   get_min_char: INTEGER
         -- Get first character glyph in font
      do
      end

   get_max_char: INTEGER
         -- Get last character glyph in font
      do
      end

--   left_bearing (ch: CHARACTER): INTEGER is
--         -- Left bearing
--      do
--      end

   right_bearing (ch: CHARACTER): INTEGER
         -- Right bearing
      deferred
      end

   get_font_width: INTEGER
         -- Width of widest character in font
		deferred
      end

   get_font_height: INTEGER
         -- Height of highest character in font
		deferred
      end

   ascent, get_font_ascent: INTEGER
         -- Ascent from baseline
		deferred
      end

   descent, get_font_descent: INTEGER
         -- Descent from baseline
		deferred
      end

--	get_font_leading: INTEGER is
--			-- Get font leading [that is lead-ing as in Pb!]
--		do
--		end

--	get_font_spacing: INTEGER is
--         -- Get font line spacing
--      do
--      end

	get_text_width (text: STRING): INTEGER
			-- Calculate width of given text in this font
		require
			valid_text: text /= Void
		do
			Result := get_text_width_offset (text, 1, text.count);
		end

	get_text_width_len (text: STRING; count: INTEGER): INTEGER
			-- Calculate width of given text in this font
		require
			valid_text: text /= Void
			valid_count: count <= text.count
		do
			Result := get_text_width_offset (text, 1, count)
		end

	get_text_width_offset (text: STRING; strt,count: INTEGER): INTEGER
			-- Calculate width of given text in this font
		require
			valid_text: text /= Void
			valid_start: strt > 0
			valid_count: strt+count <= text.count + 1
		deferred
		end

   get_text_height (text: STRING): INTEGER
         -- Calculate height of given text in this font
      do
         Result := get_text_height_offset (text, 1, text.count)
      end

   get_text_height_length (text: STRING; count: INTEGER): INTEGER
         -- Calculate height of given text in this font
      do
         Result := get_text_height_offset (text, 1, count)
      end

	get_text_height_offset (text: STRING; strt, count: INTEGER): INTEGER
			-- Calculate height of given text in this font
		require
			text_not_void: text /= Void
			valid_start_index: strt > 0
			valid_end_index: strt+count <= text.count + 1
		do
			check false end
		end

--	list_fonts (face: STRING; wt, sl, sw, en: INTEGER; h: INTEGER): ARRAY [SB_FONT_DESC] is
--			-- List all fonts matching hints
--		deferred
--		end

feature -- Destruction

	destruct
		do
			destroy_resource
			Precursor
		end

feature {NONE} -- Implementation

--	find_best_font (fontname: STRING): STRING is
--		do
--		end

	fall_back_font: STRING
		do
		end

	find_match(fontname, family: STRING): STRING
		deferred
		end

end -- class SB_FONT
