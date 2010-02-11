class FILE_DATA [ G -> DIFF_SYMBOL ] -- Constraint to be modified

creation
	make

feature -- Attributes

	saved_data: ARRAY [ G ]
		-- The supplied data array

	buffered_symbols: INTEGER
		-- Number of elements (symbols) in this file

	nondiscarded_symbols: INTEGER
		-- Total number of nondiscarded symbols

	equivs: ARRAY [ INTEGER ]
		-- Vector, indexed by line number, containing an equivalence code for
		-- each line.  It is this vector that is actually compared with that
		-- of another file to generate differences

	undiscarded: ARRAY [ INTEGER ]
		-- Vector, like the previous one except that
		-- the elements for discarded symbols have been squeezed out

	realindexes: ARRAY [ INTEGER ]
		-- Vector mapping virtual line numbers (not counting discarded symbols)
		-- to real ones (counting those symbols).  Both are origin-0

	changed_flag: ARRAY [ BOOLEAN ]
		-- Array, indexed by real origin-1 line number,
		-- containing true for a line that is an insertion or a deletion.
		-- The results of comparison are stored here

	equiv_max: INTEGER

feature -- DEBUG

	pnl is
		do
			print(once "%N")
		end

	print_debug is
		local
			i: INTEGER
		do
			print("Buffered_symbols: "); print(buffered_symbols.out); pnl
			print("nondiscarded_symbols: "); print(nondiscarded_symbols.out); pnl
			print("equivs.count: "); print(equivs.count.out); pnl
			print("undiscarded.count: "); print(undiscarded.count.out); pnl
			print("realindexes.count: "); print(realindexes.count.out); pnl
			print("changed_flag.count: "); print(changed_flag.count.out); pnl

			print ("equivs ...%N")
			from i := 1 until i > 10 loop
				print(once "   "); print((equivs @ i).out); pnl
				i := i + 1
			end
				
			print ("undiscarded ...%N")
			from i := 1 until i > 10 loop
				print(once "   "); print((undiscarded @ i).out); pnl
				i := i + 1
			end
				
			print ("realindexes ...%N")
			from i := 1 until i > 10 loop
				print(once "   "); print((realindexes @ i).out); pnl
				i := i + 1
			end
				
			print ("changed_flag ...%N")
			from i := 1 until i > 10 loop
				print(once "   "); print((changed_flag @ i).out); pnl
				i := i + 1
			end
				
		end

feature -- Creation

	make (data: ARRAY [ G ]; h: DS_HASH_TABLE [ INTEGER, G ]; equiv_max_start: INTEGER) is
		local
			i: INTEGER
		do

			equiv_max := equiv_max_start

			buffered_symbols := data.count

			saved_data := data -- for debug printing

			create equivs	  .make (1, buffered_symbols)
			create undiscarded.make (1, buffered_symbols)
			create realindexes.make (1, buffered_symbols)

			from
				i := 1
			until
				i > data.count
			loop
				h.search (data @ i)
				if not h.found then
		--			io.put_string ("FILE_DATA::make h - not found%N")
					equivs.put (equiv_max, i)
					h.put (equiv_max, data @ i)
					equiv_max := equiv_max + 1
				else
		--			io.put_string ("FILE_DATA::make h - found%N")
					equivs.put (h.found_item, i)
				end
				i := i + 1
			end
		--	dump_equivs
		--	io.put_string (equiv_max.out); io.put_string (" : equiv_max%N")
		end
		-----------------------------------------------------------------

	dump_equivs is
		local
			i: INTEGER
		do
			io.put_string ("Equivs DUMP%N")
			from
				i := equivs.lower
			until
				i > equivs.upper
			loop
				io.put_string ((equivs @ i).out); io.put_string ("%N")
				i := i + 1
			end
		end

	set_equiv_max(max: INTEGER) is
		do
			equiv_max := max
		end

	print_file is
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i > buffered_symbols
			loop
--				io.put_string (saved_data @ i);
--				io.put_string ("%N")
				i := i + 1
			end
		end

feature

	clear is
			-- Allocate changed array for the results of comparison.
		do
			-- Allocate a flag for each line of each file, saying whether that line
			-- is an insertion or deletion.
			-- Allocate an extra element, always zero, at each end of each vector.

			create changed_flag.make (0, buffered_symbols + 1);	-- base index ???
		end
		----------------------------------------------------------------------------



	equiv_count: ARRAY [ INTEGER ] is
			-- Return equiv_count[I] as the number of symbols in this file
			-- that fall in equivalence class I.
			-- @return the array of equivalence class counts.
		local
			i: INTEGER
		do
			create Result.make (1, equiv_max);
			from
				i := 1;
			until
				i > buffered_symbols
			loop
				Result.put (1 + Result @ (equivs @ i), equivs @ i)
				i := i + 1
			end
		end
		------------------------------------------------------------

	discard_non_matching_symbols (f: FILE_DATA [ G ]) is
			-- Discard symbols that have no matches in another file.
			--
			-- A line which is discarded will not be considered by the actual
			-- comparison algorithm; it will be as if that line were not in the file.
			-- The file's `realindexes' table maps virtual line numbers
			-- (which don't count the discarded symbols) into real line numbers;
			-- this is how the actual comparison algorithm produces results
			-- that are comprehensible when the discarded symbols are counted.
			--
			-- When we discard a line, we also mark it as a deletion or insertion
			-- so that it will be available in the output.
		local
			discarded: ARRAY [ INTEGER ]
		do
			clear

			-- Set up table of which symbols are going to be discarded.
			discarded := discardable (f.equiv_count)

			-- Don't really discard the provisional symbols except when they occur in
			-- a run of discardables, with nonprovisionals at the beginning and end.

			filter_discards (discarded)

			-- Actually discard the symbols.
			discard (discarded)
		end
		--------------------------------------

feature {DIFF, DIFF_LGPL} -- Implementation, private

	Discard_no	 : INTEGER_8 is 0
	Discard_yes	 : INTEGER_8 is 1
	Discard_maybe: INTEGER_8 is 2

	discardable (counts: ARRAY [ INTEGER ]): ARRAY [ INTEGER ] is
			-- Mark to be discarded each line that matches no line of another file.
			-- If a line matches many symbols, mark it as provisionally discardable.
			-- @see equivCount()
			-- @param counts The count of each equivalence number for the other file.
			-- @return 0=nondiscardable, 1=discardable or 2=provisionally discardable
			-- for each line
		local
			i: INTEGER
			nb: INTEGER
			l_equivs: ARRAY [ INTEGER ]
			many: INTEGER
			tem: INTEGER
			nmatch: INTEGER
		do
			nb := buffered_symbols
			create Result.make (1, nb)
			l_equivs := equivs
			many := 5
			tem := nb // 64

			-- Multiply MANY by approximate square root of number of symbols.
			-- That is the threshold for provisionally discardable symbols.
			from
				tem := tem |>> 2
			until
				tem = 0
			loop
				tem := tem |>> 2
				many := many * 2
			end

			from
				i := 1
			until
				i > nb
			loop
				if (saved_data @ i).is_match_exclude then
					Result.put (Discard_yes, i)
				elseif (l_equivs @ i) /= 0 then
					nmatch := counts @ (l_equivs @ i)
					if nmatch = 0 then
						Result.put (Discard_yes, i)	-- No other matches in either sequence
					elseif (nmatch > many) then
						Result.put (Discard_maybe, i)	-- Multiple matches in sequence pair
					else
						-- Discard_no == default 0
					end
				end
				i := i + 1
			end
		end
		----------------------------------------------------

	filter_discards (discards: ARRAY [ INTEGER ]) is
			-- Don't really discard the provisional symbols except when they occur in
			-- a run of discardables, with nonprovisionals at the beginning and end.
		local
			iend: INTEGER
			i, j: INTEGER
			length: INTEGER;
			provisional: INTEGER
			jdone: BOOLEAN

			consec,
			minimum,
			tem: INTEGER

		do
			iend := buffered_symbols

			from
				i := 1
			until
				i > iend
			loop

				-- Cancel provisional discards not in middle of run of discards.
				if (discards @ i) = Discard_maybe then
					discards.put (Discard_no, i)
				elseif (discards @ i) /= Discard_no then
					-- We have found a nonprovisional discard.

					provisional := 0

					-- Find end of this run of discardable symbols.
					-- Count how many are provisionally discardable.
					from
						jdone := False
						j := i
					until
						jdone or j > iend
					loop
						if (discards @ j) = Discard_no then
							jdone := True
						else
							if (discards @ j) = Discard_maybe then
								provisional := provisional + 1
							end
							j := j + 1
						end
					end

					-- Cancel provisional discards at end, and shrink the run.
					from
					until
						j <= i or else discards @ (j - 1) /= Discard_maybe
					loop
						j := j - 1
						discards.put (Discard_no, j)
						provisional := provisional - 1
					end

					-- Now we have the length of a run of discardable symbols
					-- whose first and last are not provisional.

					length := j - i;

				--	io.put_string ("Filter_discards - length = ")
				--		io.put_string (length.out)
				--		io.put_string ("%N")

					-- If 1/4 of the symbols in the run are provisional,
					-- cancel discarding of all provisional symbols in the run.
					if (provisional * 4) > length then
						from
						until
							j <= i
						loop
							j := j - 1
							if (discards @ j) = Discard_maybe then
								discards.put (Discard_no, j)
							end
						end
					else
						minimum := 1;
						tem := length // 4

						-- MINIMUM is approximate square root of LENGTH/4.
						-- A subrun of two or more provisionals can stand
						-- when LENGTH is at least 16.
						-- A subrun of 4 or more can stand when LENGTH >= 64.
						from
							tem := tem |>> 2
						until
							tem = 0
						loop
							tem := tem |>> 2
							minimum := minimum * 2
						end
						minimum := minimum + 1

						-- Cancel any subrun of MINIMUM or more provisionals
						-- within the larger run.
						from
							j := 0
							consec := 0
						until
							j >= length
						loop
		      				if (discards @ (i + j)) /= Discard_maybe then
								consec := 0;
		      				else
								consec := consec + 1
		      					if minimum = consec then
									-- Back up to start of subrun, to cancel it all.
									j := j - consec
		      					elseif minimum < consec then
									discards.put(Discard_no, (i + j))
								end
							end
							j := j + 1
						end

						-- Scan from beginning of run
						-- until we find 3 or more nonprovisionals in a row
						-- or until the first nonprovisional at least 8 symbols in.
						-- Until that point, cancel any provisionals.

						from
							j := 0
							consec := 0
							jdone := False
						until
							jdone or j >= length
						loop
							if j >= 8 and then (discards @ (i + j)) = Discard_yes then
			  					jdone := True
			  				else
								if (discards @ (i + j)) = Discard_maybe then
			  						consec := 0; discards.put (Discard_no, i + j)
								elseif (discards @ (i + j)) = Discard_no then
			  						consec := 0;
								else
			  						consec := consec + 1
								end
								if consec = 3 then
									jdone := True
								else
									j := j + 1
								end
							end
						end -- loop

						-- I advances to the last line of the run.
						i := i + length - 1;

						-- Same thing, from end.
						from
							j := 0
							consec := 0
							jdone := False
						until
							jdone or j >= length
						loop
							if j >= 8 and then (discards @ (i - j)) = 1 then
			  					jdone := True
							else

								if (discards @ (i - j)) = Discard_maybe then
			  						consec := 0; discards.put(Discard_no, i - j)
								elseif (discards @ (i - j)) = Discard_no then
			  						consec := 0;
								else
			  						consec := consec + 1
								end
								if consec = 3 then
									jdone := True
								else
									j := j + 1
								end
							end

						end -- loop
					end -- if
				end -- if
				i := i + 1
			end -- loop
		end

	no_discards: BOOLEAN is False

	discard (discards: ARRAY [ INTEGER ]) is
			-- Actually discard the symbols.
			-- Status OK
		local
			i, j: INTEGER
			nb: INTEGER
		do
			nb := buffered_symbols
			from
				i := 1
				j := 1
			until
				i > nb
			loop
				if no_discards or else (discards @ i) = Discard_no then
					undiscarded.put (equivs @ i, j)
					realindexes.put (i, j)
					j := j + 1
				else
					changed_flag.put (True, i)
					nondiscarded_symbols := j;
				end
				i := i + 1
			end
		end
		--------------------------------------------------------


-- Adjust inserts/deletes of blank symbols to join changes
-- as much as possible.
--
-- We do something when a run of changed symbols include a blank
-- line at one end and have an excluded blank line at the other.
-- We are free to choose which blank line is included.
-- `compareseq' always chooses the one at the beginning,
-- but usually it is cleaner to consider the following blank line
-- to be the "change".  The only exception is if the preceding blank line
-- would join this change to other changes.

-- @param f the file being compared against

	shift_boundaries (f: like Current) is
		local
			changed, other_changed: ARRAY [ BOOLEAN ]
			i, j: INTEGER
			i_end: INTEGER
			done, done_2: BOOLEAN
			start, runlength, corresponding: INTEGER
		do
			changed := changed_flag;
			other_changed := f.changed_flag;
			i_end := buffered_symbols

			from
				i := 1
				j := 1	-- ???
			until
				done
			loop

				-- Scan forwards to find beginning of another run of changes.
				-- Also keep track of the corresponding point in the other file.

				from
				until
					i > i_end or else changed @ (i)
				loop

					from
					until
						not (other_changed @ j)
					loop
						-- Non-corresponding symbols in the other file
						-- will count as the preceding batch of changes.
						j := j + 1
					end
					j := j + 1
					i := i + 1
				end

				if i = (i_end + 1) then	-- ?????
					done := True
				else

					start := i

					-- Find the end of this run of changes.

					from
						i := i + 1
					until
						not (changed @ i)
					loop
						i := i + 1
					end

					from
					until
						not (other_changed @ j)
					loop
						j := j + 1
					end

					from
						done_2 := False
					until
						done_2
					loop

						-- Record the length of this run of changes, so that
						-- we can later determine whether the run has grown.

						runlength := i - start;

						-- Move the changed region back, so long as the
						-- previous unchanged line matches the last changed one.
						-- This merges with previous changed regions.

	      				from
	      				until
	      					start = 1 or else equivs @ (start - 1) /= equivs @ (i - 1)
	      				loop

							start := start - 1;	changed.put (True, start)
		  					i := i - 1;			changed.put (False, i)

		    				from until not (changed @ (start - 1)) loop
		    					start := start - 1
		    				end

		    				from
		    					j := j - 1
		    				until
		    					not (other_changed @ j)
		    				loop
		    					j := j - 1
		    				end
						end

						-- Set CORRESPONDING to the end of the changed run, at the last
						-- point where it corresponds to a changed run in the other file.
						-- CORRESPONDING == I_END means no such point has been found.

						if other_changed @ (j - 1) then
							corresponding := i
						else
							corresponding := i_end
						end

						-- Move the changed region forward, so long as the
						-- first changed line matches the following unchanged one.
						-- This merges with following changed regions.
						-- Do this second, so that if there are no merges,
						-- the changed region is moved forward as far as possible.

						from
						until
							i = i_end or else equivs @ start /= equivs @ i
						loop
		  					changed.put (False, start); start := start + 1
		  					changed.put (True, i); i := i + 1

							from until not (changed @ i) loop
								i := i + 1
							end
		    				from
		    					j := j + 1
		    				until
		    					not (other_changed @ j)
		    				loop
		    					corresponding := i
		    					j := j + 1
		    				end
						end

						if runlength = (i - start) then
							done_2 := True
						end
					end

					-- If possible, move the fully-merged run of changes
					-- back to a corresponding run in the other file.

					from
					until
						corresponding >= i
					loop
	      				start := start - 1; changed.put (True, start)
	      				i := i - 1; changed.put (False, i)
						from
							j := j - 1
						until
							not (other_changed @ j)
						loop
							j := j - 1
						end
	    			end
				end
			end
		end


	print_changed is
		local
			i: INTEGER
		do
			io.put_string("Changed flags%N")
			from
				i := 1
			until
				i > buffered_symbols
			loop
				io.put_string (i.out);
				io.put_string ("   ")
				io.put_string ((changed_flag @ i).out)
				io.put_string ("%N")
				i := i + 1
			end
		end

end
