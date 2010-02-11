indexing
	description: "[
				Eiffel translation and adaptation from Diff.java,
				based on GNU diff 1.15
		]"
	author:		"Howard Thomson"
	license: "LGPL: The GNU Lesser General Public License"
	copyright:	"June 2003, 2007"

--
--
--  @author Stuart D. Gathman, translated from GNU diff 1.15
--    Copyright (C) 2000  Business Management Systems, Inc.
--
--    This program is free software; you can redistribute it and/or modify
--    it under the terms of the GNU Lesser General Public License as published by
--    the Free Software Foundation; either version 2, or (at your option)
--    any later version.
--
--    This program is distributed in the hope that it will be useful,
--    but WITHOUT ANY WARRANTY; without even the implied warranty of
--    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--    GNU General Public License for more details.
--
--    You should have received a copy of the [COPYING.txt]
--    GNU Lesser General Public License
--    along with this program; if not, write to the Free Software
--    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.


--	A class to compare arrays of objects.  The result of comparison
--    is a list of 'change' objects which form an
--    edit script.  The objects compared are traditionally symbols
--    of text from two files.  Comparison options such as "ignore
--    whitespace" are implemented by modifying the 'equals'
--    and 'hashcode' methods for the objects compared.
--
--   The basic algorithm is described in:
--   "An O(ND) Difference Algorithm and its Variations", Eugene Myers,
--   Algorithmica Vol. 1 No. 2, 1986, p 251.  


class DIFF_LGPL [ G -> DIFF_SYMBOL ]

inherit

	PLATFORM	-- For Maximum_integer

creation

	make

feature -- Attributes

	equiv_max: INTEGER
		-- 1 more than the maximum equivalence value used for this or its
		-- sibling file.

	heuristic: BOOLEAN
		-- When set to true, the comparison uses a heuristic to speed it up.
		-- With this heuristic, for files with a constant small density
		-- of changes, the algorithm is linear in the file size.

	no_discards: BOOLEAN
		-- When set to true, the algorithm returns a guarranteed minimal
		-- set of changes.  This makes things slower, sometimes much slower.

feature {NONE} -- Attributes private for implementation

	xvec, yvec: ARRAY [ INTEGER ]	-- Vectors being compared.

	fdiag: ARRAY [ INTEGER ]
		-- Vector, indexed by diagonal, containing
		-- the X coordinate of the point furthest
		-- along the given diagonal in the forward
		-- search of the edit matrix.

	bdiag: ARRAY [ INTEGER ]
		-- Vector, indexed by diagonal, containing
		-- the X coordinate of the point furthest
		-- along the given diagonal in the backward
		-- search of the edit matrix.

	fdiagoff, bdiagoff: INTEGER
	
	filevec_0, filevec_1: FILE_DATA [ G ]
	
	cost: INTEGER;

feature -- DEBUG

	print_counts is
		do
			print("equiv_max: "); print(equiv_max.out); pnl
			print("heuristic: "); print(heuristic.out); pnl
			print("no_discards: "); print(no_discards.out); pnl

			print("xvec.count: "); print(xvec.count.out); pnl
			print("yvec.count: "); print(yvec.count.out); pnl

			print("File_data 0:%N"); filevec_0.print_debug
			print("File_data 1:%N"); filevec_1.print_debug
		end
					
	pnl is
		do
			print (once "%N")
		end

feature -- Creation

	make (a, b: ARRAY [ G ]) is
		local
			h: DS_HASH_TABLE [ INTEGER, G ]
		do
			equiv_max := 1
			create h.make (a.count + b.count);
			create filevec_0.make (a, h, 1)
			create filevec_1.make (b, h, filevec_0.equiv_max)
			filevec_0.set_equiv_max (filevec_1.equiv_max)
		end

feature

	print_files is
		do
			io.put_string ("First file:%N")
			filevec_0.print_file
			io.put_string ("Second file:%N")
			filevec_1.print_file
		end

--  	Prepare to find differences between two arrays.  Each element of
--      the arrays is translated to an "equivalence number" based on
--      the result of 'equals'.  The original Object arrays
--      are no longer needed for computing the differences.  They will
--      be needed again later to print the results of the comparison as
--      an edit script, if desired.



feature {NONE} -- Implementation

	diag (xoff, xlim, yoff, ylim: INTEGER): INTEGER is
			--	Find the midpoint of the shortest edit script for a specified
			--     portion of the two files.
			--
			--     We scan from the beginnings of the files, and simultaneously from the ends,
			--     doing a breadth-first search through the space of edit-sequence.
			--     When the two searches meet, we have found the midpoint of the shortest
			--     edit sequence.
			--
			--     The value returned is the number of the diagonal on which the midpoint lies.
			--     The diagonal number equals the number of inserted symbols minus the number
			--     of deleted symbols (counting only symbols before the midpoint).
			--     The edit cost is stored into COST; this is the total number of
			--     symbols inserted or deleted (counting only symbols before the midpoint).
			--
			--     This function assumes that the first symbols of the specified portions
			--     of the two files do not match, and likewise that the last symbols do not
			--     match.  The caller must trim matching symbols from the beginning and end
			--     of the portions it is going to specify.
			--
			--     Note that if we return the "wrong" diagonal value, or if
			--     the value of bdiag at that diagonal is "wrong",
			--     the worst this can do is cause suboptimal diff output.
			--     It cannot cause incorrect diff output.
			--
		local
			fd: ARRAY [ INTEGER ]
			bd: ARRAY [ INTEGER ]
			xv: ARRAY [ INTEGER ]
			yv: ARRAY [ INTEGER ]

			dmin,					-- Minimum valid diagonal.
			dmax,					-- Maximum valid diagonal.
			fmid,					-- Center diagonal of top-down search.
			bmid: INTEGER			-- Center diagonal of bottom-up search.

			fmin, fmax: INTEGER		-- Limits of top-down search.
			bmin, bmax: INTEGER		-- Limits of bottom-up search.
			odd: BOOLEAN

			c,						-- Loop counter (?)
			d: INTEGER				-- Active diagonal.
			big_snake: BOOLEAN

			x, y, oldx,
			tlo,
			thi: INTEGER
			done: BOOLEAN
			dd, dd_abs: INTEGER
			best, bestpos: INTEGER
			k: INTEGER
		do
			fd := fdiag					-- Give the compiler a chance.
			bd := bdiag					-- Additional help for the compiler.
			xv := xvec					-- Still more help for the compiler.
			yv := yvec					-- And more and more . . .
			dmin := xoff - ylim			-- Minimum valid diagonal.
			dmax := xlim - yoff			-- Maximum valid diagonal.
			fmid := xoff - yoff			-- Center diagonal of top-down search.
			bmid := xlim - ylim			-- Center diagonal of bottom-up search.
			fmin := fmid; fmax := fmid	-- Limits of top-down search.
			bmin := bmid; bmax := bmid	-- Limits of bottom-up search.
			
			-- True if southeast corner is on an odd
			-- diagonal with respect to the northwest.
			odd := (fmid - bmid) & 1 /= 0	

			fd.put (xoff, fdiagoff + fmid)
			bd.put (xlim, bdiagoff + bmid)

			from
				c := 1
			until
				done
			loop
				big_snake := false

				-- Extend the top-down search by an edit step in each diagonal.
				if fmin > dmin then
					fmin := fmin - 1
					fd.put(-1, fdiagoff + fmin - 1)
				else
					fmin := fmin + 1
				end
				if fmax < dmax then
					fmax := fmax + 1
					fd.put(-1, fdiagoff + fmax + 1)
				else
					fmax := fmax - 1
				end
				
				from
					d := fmax
				until
					done or d < fmin
				loop
					tlo := fd @ (fdiagoff + d - 1)
					thi := fd @ (fdiagoff + d + 1)

				    if tlo >= thi then
				      	x := tlo + 1
				    else
				      	x := thi
					end
				    oldx := x
				    y := x - d
			
					from
					until
						x >= xlim or else y >= ylim or else (xv @ x) /= yv @ y
					loop
						x := x + 1
						y := y + 1
					end
			
				    if x - oldx > 20 then
				    	big_snake := true
					end
					
				    fd.put(x, fdiagoff + d);
				    if odd and then bmin <= d and then d <= bmax and then (bd @ (bdiagoff + d)) <= (fd @ (fdiagoff + d)) then
						cost := 2 * c - 1
						Result := d
						done := True
					else
						d := d - 2
					end -- if
				end -- loop

				if not done then
			
					-- Similarly extend the bottom-up search.
					if bmin > dmin then
						bmin := bmin - 1
					  	bd.put(Maximum_integer, bdiagoff + bmin - 1)
					else
						bmin := bmin + 1
					end
					if bmax < dmax then
						bmax := bmax + 1
						bd.put(Maximum_integer, bdiagoff + bmax + 1)
					else
						bmax := bmax - 1
					end

					from
						d := bmax
					until
						done or d < bmin
					loop
						tlo := bd @ (bdiagoff + d - 1)
						thi := bd @ (bdiagoff + d + 1)

					    if tlo < thi then
					    	x := tlo
					    else
					    	x := thi - 1
						end
					    oldx := x
					    y := x - d
				
						from
						until
							x <= xoff or else y <= yoff or else (xv @ (x - 1)) /= (yv @ (y - 1))
						loop
							x := x - 1
							y := y - 1
						end
				
					    if oldx - x > 20 then
	 				    	big_snake := true
	 					end
					    bd.put(x, bdiagoff + d)
					    if (not odd) and then fmin <= d and then d <= fmax and then (bd @ (bdiagoff + d)) <= (fd @ (fdiagoff + d)) then
							cost := 2 * c
							Result := d
							done := True
						else
							d := d - 2
						end
					end -- loop
				end
			
				-- Heuristic: check occasionally for a diagonal that has made
				-- lots of progress compared with the edit distance.
				-- If we have any such, find the one that has made the most
				-- progress and return it as if it had succeeded.
				--
				-- With this heuristic, for files with a constant small density
				-- of changes, the algorithm is linear in the file size.
				
				if not done then

					if c > 200 and then big_snake and then heuristic then
					    best := 0;
					    bestpos := -1

						from
							d := fmax
						until
							d < fmin
						loop
							dd := d - fmid;
							dd_abs := dd.abs
							if ((fd @ (fdiagoff + d) - xoff)*2 - dd > 12 * (c + dd_abs)) then
						    	if (fd @ (fdiagoff + d) * 2 - dd > best
								and then fd @ (fdiagoff + d) - xoff > 20
								and then fd @ (fdiagoff + d) - d - yoff > 20) then
									x := fd @ (fdiagoff + d)
				
									-- We have a good enough best diagonal;
							   		-- now insist that it end with a significant snake.
							   		
							    	from
							    		k := 1
							    	until
							    		k > 20 or else (xvec @ (x - k)) /= (yvec @ (x - d - k))
							    	loop
							    		k := k + 1
							    	end

									if k = 21 then
							    		best := (fd @ (fdiagoff + d)) * 2 - dd
							    		bestpos := d
							  		end
						      	end
						  	end
						  	d := d - 2
					    end
					    if best > 0 then
							cost := 2 * c - 1
							Result := bestpos
							done := true
						else				
				
						    best := 0;
							from
								d := bmax
							until
								d < bmin
							loop
								dd := d - bmid
								dd_abs := dd.abs
								if ((xlim - bd @ (bdiagoff + d))*2 + dd > 12 * (c + dd_abs)) then
							    	if ((xlim - bd @ (bdiagoff + d)) * 2 + dd > best
									and then xlim - bd @ (bdiagoff + d) > 20
									and then ylim - (bd @ (bdiagoff + d) - d) > 20) then

										-- We have a good enough best diagonal;
										-- now insist that it end with a significant snake.
										x := bd @ (bdiagoff + d)
					
										from
											k := 0
										until
											k >= 20 or else (xvec @ (x + k)) /= (yvec @ (x - d + k))
										loop
											k := k + 1
										end
										if k = 20 then
								    		best := (xlim - bd @ (bdiagoff + d)) * 2 + dd
								    		bestpos := d
										end
									end
								end
							end
							if best > 0 then
								cost := 2 * c - 1
								Result := bestpos
								done := True
							else
								d := d - 2
							end
						end
					end
				end
				c := c + 1
			end -- loop
		end
		-----------------------------------------------------------------

	compareseq (a_xoff, a_xlim, a_yoff, a_ylim: INTEGER) is
			--  Compare in detail contiguous subsequences of the two files
			--  which are known, as a whole, to match each other.
			--
			--  The results are recorded in the vectors filevec[N].changed_flag, by
			--  storing a 1 in the element for each symbol that is an insertion or deletion.
			--
			--  The subsequence of file 0 is [XOFF, XLIM) and likewise for file 1.
			--
			--  Note that XLIM, YLIM are exclusive bounds.
			--  All symbol numbers are origin-0 and discarded symbols are not counted.
		require
			a_xoff >= 1
			a_yoff >= 1
		--	a_xlim <= xvec.upper
		--	a_ylim <= yvec.upper
		local
			xoff, xlim, yoff, ylim: INTEGER
			d, c, f, b: INTEGER
		do
			xoff := a_xoff
			xlim := a_xlim
			yoff := a_yoff
			ylim := a_ylim

			-- Slide down the bottom initial diagonal.
			from
			until
				xoff >= xlim or else yoff >= ylim or else (xvec @ xoff) /= yvec @ yoff
			loop
				xoff := xoff + 1;
				yoff := yoff + 1;
			end

			-- Slide up the top initial diagonal.
			from
			until
				xlim <= xoff or else ylim <= yoff or else xvec @ (xlim - 1) /= yvec @ (ylim - 1)
			loop
				xlim := xlim - 1;
				ylim := ylim - 1;
			end

			-- Handle simple cases.
			if xoff = xlim then
				from
				until
					yoff >= ylim
				loop
					filevec_1.changed_flag.put (True, filevec_1.realindexes @ yoff)
					yoff := yoff + 1
				end
			elseif yoff = ylim then
				from
				until
					xoff >= xlim
				loop
					filevec_0.changed_flag.put (True, filevec_0.realindexes @ xoff)
					xoff := xoff + 1
				end
			else

				-- Find a point of correspondence in the middle of the files.

				d := diag(xoff, xlim, yoff, ylim)
				c := cost
				f := fdiag @ (fdiagoff + d)
				b := bdiag @ (bdiagoff + d)

				if c = 1 then

					-- This should be impossible, because it implies that
					-- one of the two subsequences is empty,
					-- and that case was handled above without calling `diag'.
					-- Let's verify that this is true.

				--	throw new IllegalArgumentException("Empty subsequence");

				else

					-- Use that point to split this problem into two subproblems.
					compareseq (xoff, b, yoff, b - d)

					-- This used to use f instead of b,
					-- but that is incorrect!
					-- It is not necessarily the case that diagonal d
					-- has a snake from b to f.
					compareseq (b, xlim, b - d, ylim)
				end
			end
		end


feature { NONE }

	discard_non_matching_symbols is
			-- Discard symbols from one file that have no matches in the other file.
		do
			filevec_0.discard_non_matching_symbols (filevec_1)
			filevec_1.discard_non_matching_symbols (filevec_0)
		end
		--------------------------------------------------------

	inhibit: BOOLEAN

	shift_boundaries is
			-- Adjust inserts/deletes of blank symbols to join changes
			-- as much as possible.
		do
			if not inhibit then
				filevec_0.shift_boundaries(filevec_1);
				filevec_1.shift_boundaries(filevec_0);
			end
		end
		---------------------------------------------------------------------------

	forward_script: FORWARD_SCRIPT is
		once
			create Result
		end

	reverse_script: REVERSE_SCRIPT is
		once
			create Result
		end

feature

	diff_2 (reverse: BOOLEAN): CHANGE is
			-- Report the differences of two files.
			-- DEPTH is the current directory depth.
		do
			if reverse then
				Result := diff (reverse_script)
			else
				Result := diff (forward_script)
			end
		end


--	Get the results of comparison as an edit script.  The script 
--  is described by a list of changes.  The standard ScriptBuilder
--  implementations provide for forward and reverse edit scripts.
--  Alternate implementations could, for instance, list common elements 
--  instead of differences.
--  @param bld	an object to build the script from change flags
--  @return the head of a list of changes


	diff (bld: SCRIPT_BUILDER): CHANGE is
		local
			diags: INTEGER
		do

			diff_compare

			-- Modify the results slightly to make them prettier
			-- in cases where that can validly be done.

			shift_boundaries

			-- Get the results of comparison in the form of a chain
			-- of `struct change's -- an edit script.

			Result := bld.build_script(
				filevec_0.changed_flag,
				filevec_0.buffered_symbols,
				filevec_1.changed_flag,
				filevec_1.buffered_symbols)
		end

	diff_compare is
		local
			diags: INTEGER
		do

			-- Some symbols are obviously insertions or deletions
			-- because they don't match anything.  Detect them now,
			-- and avoid even thinking about them in the main comparison algorithm.

			discard_non_matching_symbols

			-- Now do the main comparison algorithm, considering just the
			-- undiscarded symbols.

			xvec := filevec_0.undiscarded
			yvec := filevec_1.undiscarded

			diags := filevec_0.nondiscarded_symbols + filevec_1.nondiscarded_symbols + 3

			fdiagoff := filevec_1.nondiscarded_symbols + 1
			bdiagoff := filevec_1.nondiscarded_symbols + 1

			create fdiag.make (0, diags)
			create bdiag.make (0, diags)

			compareseq (1, filevec_0.nondiscarded_symbols + 1,
						1, filevec_1.nondiscarded_symbols + 1)
			fdiag := Void
			bdiag := Void
		end

	print_changed is
		do
			filevec_0.print_changed
			filevec_1.print_changed
		end

end
