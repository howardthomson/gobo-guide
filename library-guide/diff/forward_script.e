class FORWARD_SCRIPT

inherit
	SCRIPT_BUILDER

feature

--	Scan the tables of which lines are inserted and deleted,
--	producing an edit script in forward order.

	build_script(	changed0: ARRAY [ BOOLEAN ];
					len0: INTEGER;
					changed1: ARRAY [ BOOLEAN ];
					len1: INTEGER;
		): CHANGE is
		local
			script: CHANGE
			i0, i1: INTEGER
			line0, line1: INTEGER
		do

			dump(changed0, len0, changed1, len1)
			
			from
				i0 := len0 + 1
				i1 := len1 + 1
			until
			--	not (i0 >= 0 or else i1 >= 0)
				i0 <= 0 and then i1 <= 0
			loop
				if (changed0 @ (i0 - 1)) or else (changed1 @ (i1 - 1)) then
					line0 := i0;
					line1 := i1;

					-- Find # lines changed here in each file.
					from until not (changed0 @ (i0 - 1)) loop i0 := i0 - 1 end
					from until not (changed1 @ (i1 - 1)) loop i1 := i1 - 1 end
					
					-- Record this change.
					create script.make(i0, i1, line0 - i0, line1 - i1, script)
				end

				-- We have reached lines in the two files that match each other.
				i0 := i0 - 1
				i1 := i1 - 1
			end
			Result := script
		end

end
