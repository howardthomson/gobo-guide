indexing
	description:"Utils"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Partly complete"

class SB_UTILS_DEF

inherit

	SB_ZERO

	SB_MESSAGE_COMMON

	KL_CHARACTER_ROUTINES
		rename
			next as char_next,
			previous as char_previous,
			is_digit as kl_is_digit
		end

	SB_EXPANDED	-- Not permitted as results in SB_UTILS inheritance cycle ...

feature

	is_separator(c: CHARACTER): BOOLEAN is
		do
			Result := c = '+' or else c = '-' or else c = ' ';
		end

	is_digit(c: CHARACTER): BOOLEAN is
		do
			Result := c.code >= ('0').code and then c.code <= ('9').code;
		end

	is_alpha(c: CHARACTER): BOOLEAN is
		do
         	Result := (c.code >= ('a').code and then c.code <= ('z').code)
              or else (c.code >= ('A').code and then c.code <= ('Z').code);
      	end

	is_alnum(c: CHARACTER): BOOLEAN is
      	do
         	Result := is_digit(c) or else is_alpha(c);
      	end

   	is_lower(c: CHARACTER): BOOLEAN is
         	-- Is it some lowercase letter ('a'..'z')?
      	do
         	inspect
            	c
         	when 'a'..'z' then
            	Result := True
         	else
         	end
      	end

   	is_upper(c: CHARACTER): BOOLEAN is
         	-- Is it some uppercase letter ('A'..'Z')?
      	do
         	inspect
            	c
         	when 'A'..'Z' then
            	Result := True
         	else
         	end
      	end

	to_lower(c: CHARACTER): CHARACTER is
		do
         	Result := as_lower(c)
      	end

   	to_upper(c: CHARACTER): CHARACTER is
      	do
         	Result := as_upper(c)	-- c.to_upper;
      	end

   	is_space(c: CHARACTER): BOOLEAN is
      	do
         	Result := c = ' ' or else c = '%T'
      	end

	parse_accel(s: STRING): INTEGER is
			-- Parse for accelerator key codes in a string
      	local
         	i, len, code: INTEGER
         	mods: INTEGER;
      	do
         	if s /= Void then
            	from
               		i := 1
               		len := s.count
            	until
               		i > len or else s.item(i) = '%T' or else s.item(i) ='%N'
            	loop
               		if is_separator(s.item(i)) then
                  		i := i+1;
               		elseif s.item(i).as_lower = 'c' and then s.item(i+1).as_lower = 't'
                  	and then s.item(i+2).as_lower ='l' and then is_separator(s.item(i+3))
                	then
                  		mods := mods | sm.CONTROLMASK;
                  		i := i+4;
               		elseif  s.item(i).as_lower = 'c' and then s.item(i+1).as_lower = 't'
                  	and then s.item(i+2).as_lower ='r' and then s.item(i+3).as_lower ='l'
                  	and then is_separator(s.item(i+4))
                	then
                  		mods := mods | sm.CONTROLMASK;
                  		i := i+5;
               		elseif  s.item(i).as_lower = 'a' and then s.item(i+1).as_lower ='l'
                  	and then s.item(i+2).as_lower ='t' and then is_separator(s.item(i+3))
                	then
                  		mods := mods | sm.ALTMASK;
                  		i := i+4;
               		elseif  s.item(i).as_lower = 's' and then s.item(i+1).as_lower = 'h'
                  	and then s.item(i+2).as_lower ='i' and then s.item(i+3).as_lower ='f'
                  	and then s.item(i+4).as_lower = 't' and then is_separator(s.item(i+5))
                	then
                  		mods := mods | sm.SHIFTMASK;
                  		i := i+6;
               		else
                  		if s.item(i).as_lower = 'f' and then is_digit(s.item(i+1))
                     	and then (i+1 >= len or else s.item(i+2)  = '%T' or else s.item(i+2) = '%N')
                   		then
                     		-- One-digit function key
                     		code := sbk.key_f1 + s.item(i+1).code - ('1').code;
                  		elseif  s.item(i).as_lower = 'f' and then is_digit(s.item(i+1))
                     	and then is_digit(s.item(i+2))
                     	and then (i+2 >= len or else s.item(i+3)  = '%T' or else s.item(i+3) = '%N')
                   		then
                     		-- Two-digit function key
                     		code := sbk.key_f1 + 10*(s.item(i+1).code - ('0').code)
                        		+ (s.item(i+2).code - ('0').code) - 1;
                  		elseif i >= len or else s.item(i+1)  = '%T' or else s.item(i+1) = '%N'
                   		then
                     		-- One final character
                     		if (mods & sm.SHIFTMASK) /= b0 then
                        		code := (s.item(i).as_upper).code + sbk.key_space - (' ').code;
                     		else
                        		code := (s.item(i).as_lower).code + sbk.key_space - (' ').code;
                     		end
                     		--print ("parse_accel:"); print(s); print (" code ="); print (code);
                     		--print ("mods ="); print(mods); print ('%N');
                  		end
                  		Result := mksel(mods, code);
                  		i := len+1;
               		end
            	end
         	end
		end

	parse_hot_key (s: STRING): INTEGER is
        	 -- Parse for hot key in a string
      	local
         	i, len, code: INTEGER
         	mods: INTEGER
         	done: BOOLEAN
      	do
         	if s /= Void then
            	from
               		i := 1
               		len := s.count
            	until
               		done or else i > len or else s.item(i) = '%T'
            	loop
               		if s.item (i) ='&' then
                  		if s.item (i+1) /= '&' then
                     		if is_alnum (s.item (i+1)) then
                        		mods := sm.ALTMASK
                        		code := s.item (i+1).as_lower.code + sbk.key_space - (' ').code
                        		Result := mksel (mods, code)
                     		end
                     		done := True
                  		end
                  		i := i+1
               		end
               		i := i+1
            	end
         	end
      	end

   find_hot_key_offset (s: STRING): INTEGER is
         -- Locate hot key underline offset from begin of string
      local
         len,pos: INTEGER
      do
         if s /= Void then
            from
               pos := 1
               len := s.count
            until
               Result /= 0 or else pos > len
                  or else s.item (pos) = '%T'
            loop
               if s.item (pos) ='&' then
                  if pos+1 > len or else s.item (pos+1) /= '&' then
                     Result := pos
                  else
                     pos := pos + 1
                  end
               end
               pos := pos + 1
            end
         end
      end

   strip_hot_key (s: STRING): STRING is
         -- Strip hot key combination from the string.
         -- For example, stripHotKey("Salt && &Pepper") should
         -- yield "Salt & Pepper".
      local
          len: INTEGER
          i: INTEGER
      do
         create Result.make_empty
         if s /= Void then
            from
               len := s.count
               i := 1
            until
               i > len
            loop
               if s.item(i) = '&' then
                  if i >= len or else s.item (i+1) = '&' then
                     Result.append_character ('&')
                     i := i+2
                  else
                     i := i+1
                  end
               else
                  Result.append_character (s.item (i))
                  i := i+1
               end
            end
         end
      end

   section (str: STRING; delim: CHARACTER; start, num: INTEGER): STRING is
         -- Return num partition(s) of string separated by delimiter delim
      local
          len,i,s,e: INTEGER
          done: BOOLEAN
      do
         create Result.make_empty
         if str /= Void then
            len := str.count
            s := 1
            from
               i := 0
            until
               s > len or else i = start
            loop
               s := s + 1
               if str.item (s - 1) = delim then
                  i := i+1
               end
            end
            if s <= len then
               e := s;
               from
                  i := 0
               until
                  e > len or else i = num
               loop
                  if str.item(e) = delim then
                     i := i+1
                  end
                  if i /= num then
                    e := e + 1
                  end
               end
               Result := str.substring (s, e - 1)
            end
         end
      end

   mid (str: STRING; start, num: INTEGER): STRING is
         -- Get some part in the middle
      require
         str /= Void
      local
          e: INTEGER
          done: BOOLEAN
      do
         create Result.make_empty
         if start >= 1 and then start <= str.count then
            e := ((start + num - 1).max (1)).min (str.count)
            if e >= start then
               Result := str.substring (start, e)
            end
         end
      end

   rfind (str: STRING; c: CHARACTER; start: INTEGER): INTEGER is
         -- Get some part in the middle
      require
         str /= Void
      local
        done: BOOLEAN
      do
         from
            Result := start
         until
            Result <= 0 or done
         loop
            if str.item (Result) = c then
               done := True
            else
               Result := Result - 1
            end
         end
      end

   extract_string (s: STRING; p: INTEGER; delim: CHARACTER): STRING is
         -- Extract partition of string, interpreting escapes
      local
         part, i, len: INTEGER
      do
         create Result.make_empty
         if s /= Void then
            part := p
            from
               i := 1
               len := s.count
            until
               i > len or part = 0
            loop
               if s.item (i) = delim then
                  part := part - 1
               end
               i := i + 1
            end

            if i <= len then
               from
               until
                  i > len or else s.item (i) = delim
               loop
                  Result.append_character (s.item (i))
                  i := i+1
               end
            end
         end
      end

   extract_string_esc (s: STRING; p: INTEGER; delim, esc: CHARACTER): STRING is
         -- Extract partition of string, interpreting escapes
      local
         part, i, len: INTEGER
         skip: BOOLEAN
      do
         create Result.make_empty
         if s /= Void then
            part := p
            from
               i := 1
               len := s.count
            until
               i > len or part = 0
            loop
               if s.item (i) = delim then
                  part := part - 1
               end
               i := i +1
            end

            if i <= len then
               from
               until
                  i > len  or else s.item(i) = delim
               loop
                  if s.item (i) = esc then
                     if i + 1 < len or else s.item (i+1) /= esc then
                        skip := True
                     else
                        i := i+1
                     end
                  end
                  if not skip then
                     Result.append_character (s.item (i))
                  end
                  i := i+1
                  skip := False
               end
            end
         end
      end

   find_forward (s: STRING; cc: CHARACTER; start: INTEGER): INTEGER is
         -- Find a character, searching forward; return position or 0
      local
         len, pos: INTEGER
      do
         if s /= Void and then start > 0 then
            from
               pos := start
               len := s.count
            until
               Result /= 0 or else pos > len
            loop
               if s.item(pos) = cc then
                     Result := pos
               else
                  pos := pos + 1
               end
            end
         end
      end

	make_hilite_color (clr: INTEGER): INTEGER is
			-- Get highlight color
		local
			r, g, b: INTEGER
		do
			r := cm.sbredval (clr)
			g := cm.sbgreenval (clr)
			b := cm.sbblueval (clr)
			r := r.max (31)
			g := g.max (31)
			b := b.max (31)
			r := (133 * r) // 100
			g := (133 * g) // 100
			b := (133 * b) // 100
			Result := cm.sbrgb (r.min (255), g.min (255), b.min (255))
      end


   make_shadow_color (clr: INTEGER): INTEGER is
         -- Get shadow color
      local
         r,g,b: INTEGER
      do
         r := cm.sbredval (clr)
         g := cm.sbgreenval (clr)
         b := cm.sbblueval (clr)
         r := (66 * r) // 100
         g := (66 * g) // 100
         b := (66 * b) // 100
         Result := cm.sbrgb (r, g, b)
      end

end
