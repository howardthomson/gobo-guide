--	The result of comparison is an "edit script": a chain of change objects.
--  Each change represents one place where some lines are deleted
--  and some are inserted.
--     
--  LINE0 and LINE1 are the first affected lines in the two files (origin 0).
--  DELETED is the number of lines deleted here from file 0.
--  INSERTED is the number of lines inserted here in file 1.
--
--  If DELETED is 0 then LINE0 is the number of the line before
--  which the insertion was done; vice versa for INSERTED and LINE1.

class CHANGE

creation
	make

feature


	link: CHANGE	-- Previous or next edit command.

	inserted: INTEGER	-- # lines of file 1 changed here.
	deleted: INTEGER	-- # lines of file 0 changed here.

	line0: INTEGER;		-- Line number of 1st deleted line.
	line1: INTEGER		-- Line number of 1st inserted line.
	

-- Cons an additional entry onto the front of an edit script OLD.
-- LINE0 and LINE1 are the first affected lines in the two files (origin 0).
-- DELETED is the number of lines deleted here from file 0.
-- INSERTED is the number of lines inserted here in file 1.

-- If DELETED is 0 then LINE0 is the number of the line before
-- which the insertion was done; vice versa for INSERTED and LINE1.

	make(a_line0, a_line1, a_deleted, a_inserted: INTEGER; old_link: CHANGE) is
		do
			line0 := a_line0
			line1 := a_line1
			inserted := a_inserted
			deleted := a_deleted;
			link := old_link
		end

end