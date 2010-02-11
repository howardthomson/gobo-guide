--------------------------------------------------------------------------------
-- FEC -- Native Eiffel Compiler for SUN/SPARC
--
--  Copyright (C) 1997 Fridtjof Siebert
--    EMail: fridi@gr.opengroup.org
--    SMail: Fridtjof Siebert 
--           5b rue du 26 mai 1944
--           38940 St. Martin le Vinoux
--           Grenoble
--
--  This program is free software; you can redistribute it and/or modify
--  it under the terms of the GNU Lesser General Public License as published by
--  the Free Software Foundation; Version 2.
--
--  This program is distributed in the hope that it will be useful,
--  but WITHOUT ANY WARRANTY; without even the implied warranty of
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--  GNU Lesser General Public License for more details.
--
--  You should have received a copy of the GNU Lesser General Public License
--  along with this program; if not, write to the Free Software
--  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
--
--------------------------------------------------------------------------------
indexing
	description: "Position information stored with a scanned symbol"

	implementation: "[
		Based on the class defined in the FEC Eiffel compiler, but very
		substantially altered, to allow for editable symbols after scanning.

		Column is relative to previous symbol, for easy symbol editing, etc.
		Line is cached and validated against a modification sequence number.
		Class file ID is static and joins to instances of EDP_CLASS_FILE (??)
		Sequence_id validates the line number against the value in the class info.
		Bits:
			8	Column
			24	Line
			24	Class ID
			8	Sequence ID
	]"

	todo: "[
		Alter usage to only record relative column w.r.t. previous symbol
			0	 => Start of new line
			>= 1 => (n - 1) column gap from end of previous symbol
		Remove reference per symbol (!) to scanner index
		Change to recover line number from previous symbol(s)
		Add cache tag for line number validity

		Re-implement to use one 64-bit packed attribute instead of
		3x 32-bit attributes as at present.
	]"
	notes: "[
		Due to the inability of EiffelStudio to cope with the previous expanded class representation,
		whereas SmartEiffel and Gobo could, the current class has been rearranged as a set of routines
		to operate on a single INTEGR_64 which can be copied as a supported expanded type, which now works
		for ES finalize mode, but still crashes in Work (?) mode (W_CODE).
	]"
			
class POSITION_ROUTINES

create

	-- No creation

feature {NONE} -- Implementation constants

	pos_max_column: INTEGER is 255						-- 8 bits
	pos_max_line  : INTEGER is 16777216	-- 16*1024*1024	-- 24 bits
	
	pos_column (packed: INTEGER_64): INTEGER is 
		do
			Result := (packed & 0x000000ff).to_integer 
		end
	
	pos_line (packed: INTEGER_64): INTEGER is
		do
			Result := ((packed |>> 8) & 0x00ffffff).to_integer
		end

	pos_init (l, c: INTEGER): INTEGER_64 is
		local
			ll, lc: INTEGER; 
		do
			ll := l; lc := c;
			if ll > pos_max_line   then ll := pos_max_line   end
			if lc > pos_max_column then lc := pos_max_column end
			Result := (lc.to_integer_64)
					| (ll.to_integer_64 |<<  8)
		end

	pos_less_than (a, b: INTEGER_64): BOOLEAN is
		do
			if pos_line (a) < pos_line (b) or else
						(pos_line (a) = pos_line (b) and then pos_column (a) < pos_column (b)) then
				Result := True
			end
		end

--	line_s(s: SCANNER): INTEGER is
--		do
--			if sequence_id /= s.edit_sequence_id then
--				s.update_line_numbers
--			end
--			Result := ((packed |>> 8) & 0x00ffffff).to_integer
--		end; -- line

--	class_id (packed: INTEGER_64): INTEGER is
--			-- ID of EDP_CLASS_FILE for this POSITION
--		do
--			Result := ((packed |>> 32) & 0x00ffffff).to_integer
--		end

--	sequence_id (packed: INTEGER_64): INTEGER is
--			-- Validation sequence ID for the line number
--		do
--			Result := ((packed |>> 56) & 0x000000ff).to_integer
--		end
	
end -- POSITION_ROUTINES
	
