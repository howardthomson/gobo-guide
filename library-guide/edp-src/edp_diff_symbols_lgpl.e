note

	description: "Mark Differences between sets of SCANNER_SYMBOLs"

	author: "Howard Thomson"
	copyright: "July 2007"
	license: "MIT License"

class EDP_DIFF_SYMBOLS_LGPL [ G->DIFF_SYMBOL ]

inherit

	DIFF_LGPL [ G ]

	DIFF_SYMBOL_CONSTANTS

create

	make

feature -- Symbol marking

	mark_symbols
		do
			mark_symbols_in (filevec_0)
			mark_symbols_in (filevec_1)
		end
			
	mark_symbols_in (f: FILE_DATA [ G ])			
			-- Mark the symbols that don't match
		local
			s: G
			sa: ARRAY [ G ]
			i, nb: INTEGER
		do
			sa := f.saved_data
			nb := sa.count
			from
				i := 1
			until
				i > nb
			loop
				s := sa @ i
				if s.match_status = Match_exclude then
					-- Do nothing
				elseif f.changed_flag @ i then
					s.set_match_status (Match_fail)
				else
					s.set_match_status (Match_equal)
				end
				i := i + 1
			end
		end
end