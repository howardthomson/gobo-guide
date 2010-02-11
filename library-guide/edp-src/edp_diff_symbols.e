indexing

	description: "Mark Differences between sets of SCANNER_SYMBOLs"

	author: "Howard Thomson"
	copyright: "July 2007"
	license: "MIT License"

class EDP_DIFF_SYMBOLS [ G -> DIFF_SYMBOL ]

inherit

	DIFF [ G ]
		rename
			set as make
		redefine
			equal_tokens
		end

	DIFF_SYMBOL_CONSTANTS

create

	make

feature -- Token equality

	equal_tokens (a, b: G): BOOLEAN is
		local
			la, lb: ET_AST_LEAF
			l, c: INTEGER
			ka, kb: ET_KEYWORD
		do
			if equal (a, b) then
				Result := True
			else
				la ?= a
				lb ?= b
				if la /= Void and then lb /= Void then
					Result := la.has_same_text (lb)
				else
					print (once "FAIL equal_tokens assignment attempt%N")
				end
			end
-- DEBUG
			ka ?= a; kb ?= b
			if not Result and ka /= Void and kb /= Void then
				print (once "Not equal_tokens {ET_KEYWORD}: ")
				print (ka.text)
				print (once " /= ")
				print (kb.text)
				print (once "%N")
			end
		end

feature -- Symbol marking (DIFF from ISE Version)

	diff_compare is
		do
--print ("EDP_DIFF_SYMBOLS.diff_compare%N")
			compute_lcs
--			print_all_matches
		end

	print_all_matches is
		local
			i, nb: INTEGER
		do
			from
				i := 1
				nb := src.count
			until
				i > nb
			loop
				print (once "Match at: ")
				print (all_matches.item (i).out)
				print (once "%N")
				i := i + 1
			end
		end

	pnl is
		do
			print (once "%N")
		end

	mark_symbols is
		local
			i, nb, nb2, si, di: INTEGER
			s: G
		do
--print ("EDP_DIFF_SYMBOLS.mark_symbols%N")
			from
				si := 1
				di := 1
				i := 1
				nb := all_matches.count
			until
				i > nb
			loop
--				print ("#1: i = "); print (i.out); pnl	-- DEBUG
				if all_matches.has (si) then
						-- loop through all the lines that have to be added till we reach the match
					from
						nb2 := all_matches.item (si) - 0
--						print ("#2: nb2 := "); print (nb2.out); pnl	-- DEBUG
					until
						di = nb2
					loop
						s := dst @ di; set_status (s, Match_fail)
						di := di + 1
--						print ("#3: di = "); print (di.out); pnl	-- DEBUG
					end

					s := src @ si; set_status (s, Match_equal)
					s := dst @ di; set_status (s, Match_equal)
					i := i + 1
					di := di + 1
--					print ("#4: i = "); print (i.out); print (" di = "); print (di.out); pnl	-- DEBUG
				else
					s := src @ si; set_status (s, Match_fail)
				end
				si := si + 1
--				print ("#5: si = "); print (si.out); pnl	-- DEBUG
			end

--print ("Main loop ended%N")

				-- now we are at the last match and have to handle the differences up to the file end
			from
			until
				si > src.count
				and
				di > dst.count
			loop
				if si <= src.count then
					s := src @ si; set_status (s, Match_fail)
					si := si + 1
				end
				if di <= dst.count then
					s := dst @ di; set_status (s, Match_fail)
					di := di + 1
				end
			end			
		end

	set_status (s: G; new_status: INTEGER) is
			-- Set new status, unless status is 'ignore'
		do
			if s.is_match_exclude then
				-- Leave as is
			else
				s.set_match_status (new_status)
			end
		end
end