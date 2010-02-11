class REVERSE_SCRIPT

inherit
	SCRIPT_BUILDER

feature

	build_script(	changed0: ARRAY [ BOOLEAN ];
					len0: INTEGER;
					changed1: ARRAY [ BOOLEAN ];
					len1: INTEGER;
		): CHANGE is
			-- Scan the tables of which lines are inserted and deleted,
			-- producing an edit script in reverse order.
		local
			script: CHANGE
			i0, i1: INTEGER
			line0, line1: INTEGER
		do
			from
				i0 := 0
				i1 := 0
			until
				not (i0 < len0 or else i1 < len1)
			loop
				if (changed0 @ (1 + i0)) or else (changed1 @ (1 + i1)) then
					line0 := i0
					line1 := i1

					-- Find # lines changed here in each file.
					from until not (changed0 @ (1 + i0)) loop i0 := i0 + 1 end
					from until not (changed1 @ (1 + i1)) loop i1 := i1 + 1 end

					-- Record this change.
					create script.make(line0, line1, i0 - line0, i1 - line1, script)
				end

				-- We have reached lines in the two files that match each other.
				i0 := i0 + 1
				i1 := i1 + 1
			end
			Result := script
		end

end
