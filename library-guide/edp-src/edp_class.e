indexing
	copyright: "[
		--|---------------------------------------------------------|
		--| Copyright (c) Howard Thomson 1999,2000					|
		--| 52 Ashford Crescent										|
		--| Ashford, Middlesex TW15 3EB								|
		--| United Kingdom											|
		--|---------------------------------------------------------|
	]"

-- EDP cached information about class text

-- This class relates to class information independent of any connection
-- with other classes

	todo: "[

		Instead of redefining ET_CLASS and its factories, use the 'data' attribute of
		ET_CLASS, which chould reduce the number of modified classes needed ??

		But what about the adapted AST classes ?
	
		Make objects which should be unique for a given file (mount point / inode)
		creatable only from a factory class, which stats the file for uniqueness before
		creating / finding the appropriate object.
	]"

class EDP_CLASS

inherit

	EDP_CLASS_FILE

feature { ANY }

	et_class: ET_CLASS

	set_et_class (a_class: ET_CLASS) is
		do
			et_class := a_class
		end

	filename: STRING is
		do
			Result := et_class.filename
		end

feature { ANY }

	status: INTEGER	-- State with respect to original source file

	Status_null:		INTEGER is 0	-- No content yet defined
	Status_load_failed:	INTEGER is 1	-- File open/read failed
	Status_loaded:		INTEGER is 2	-- File read OK
	Status_scan_fail:	INTEGER is 3	-- Scanned with errors
	Status_scanned:		INTEGER is 4	-- Successfully lexically tokenised
	Status_parse_failed:INTEGER is 5	-- Parse errors found
	Status_parsed:		INTEGER is 6	-- Eiffel parse OK

feature

	status_string: STRING is
			-- current status value as a string
		do
			inspect status
			when Status_null			then Result := once "Null"
			when Status_load_failed		then Result := once "Load Failed"
			when Status_loaded			then Result := once "Loaded OK"
			when Status_scan_fail		then Result := once "Scan Failed"
			when Status_scanned			then Result := once "Scanned OK"
			when Status_parse_failed	then Result := once "Parse Failed"
			when Status_parsed			then Result := once "Parsed OK"
			else
				Result := "UNKNOWN"
			end
		end

feature {NONE} -- Status

	parsed: BOOLEAN is
		do
		end

feature {NONE} -- Redundant routines .... ?

	parse (p: EDP_PROJECT) is
		require
			not_parsed: not parsed
		do
			scan
			if scanned then
				trace_s("Parsing : "); trace_s (class_name_string); trace_s("%N")
				scanner.reset
--				create parse_class.parse (scanner, class_name)
			else
				print("Scan failed ?%N")
			end
			if not parsed then
				print ("ERROR: parse failed: "); print (class_name_string); print("%N")
				p.set_load_failed
			end
		end

--	class_rename (new_name: STRING) is
--		require
--			valid_new_name: new_name /= Void
--				and then new_name.count >= 1
--				and then valid_class_name(new_name)
--			implemented: false
--		do
--			-- Check for existing conflicting class names
--			-- Check for all potential clients/descendants/referents are scanned & parsed
--			-- Update all relevant affexted classes
--			-- Save updated source text to files, or mark for need to save later
--		end

feature -- Window creation/deletion

	class_window: EDP_CLASS_WINDOW

	make_class_window is
		do
			if class_window = Void and then filename /= Void then
				create class_window.make (Current)
			elseif class_window /= Void then
				class_window.deiconify	-- un-minimize
				class_window.raise
			end
		end

	window_destroyed is
		do
			class_window := Void
		end

end -- class EDP_CLASS