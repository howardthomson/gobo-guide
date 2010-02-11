deferred class SCRIPT_BUILDER

--	Scan the tables of which lines are inserted and deleted,
--	producing an edit script.
--
--  changed0: true for items in first file which do not match 2nd
--	len0	: number of items in first file
--	changed1: true for items in 2nd file which do not match 1st
--	len1	: number of items in 2nd file
--
--	Result	: a linked list of changes - or Void

feature

	build_script(	changed0: ARRAY [ BOOLEAN ];
					len0: INTEGER;
					changed1: ARRAY [ BOOLEAN ];
					len1: INTEGER;
		): CHANGE is
		deferred
		end

	dump(	changed0: ARRAY [ BOOLEAN ];
			len0: INTEGER;
			changed1: ARRAY [ BOOLEAN ];
			len1: INTEGER;
		) is
		local
			i: INTEGER
			len: INTEGER
			changed: ARRAY [ BOOLEAN ]
		do
			len := len0
			changed := changed0

		--	io.put_string(len.out); io.put_string(": len0%N")
		--	io.put_string(changed.lower.out); io.put_string(": changed0.lower%N")
		--	io.put_string(changed.upper.out); io.put_string(": changed0.upper%N")
		--	from
		--		i := changed.lower
		--	until
		--		i > changed.upper
		--	loop
		--		io.put_string((changed @ i).out); io.put_string("%N")
		--		i := i + 1
		--	end

			len := len1
			changed := changed1

		--	io.put_string(len.out); io.put_string(": len1%N")
		--	io.put_string(changed.lower.out); io.put_string(": changed1.lower%N")
		--	io.put_string(changed.upper.out); io.put_string(": changed1.upper%N")
		--	from
		--		i := changed.lower
		--	until
		--		i > changed.upper
		--	loop
		--		io.put_string((changed @ i).out); io.put_string("%N")
		--		i := i + 1
		--	end

		end

end
