indexing
	description: "[
		The set of all file_names known to edp.
	]"
	copyright: "[
		--|---------------------------------------------------------|
		--| Copyright (c) Howard Thomson 1999,2000,2006				|
		--| 52 Ashford Crescent										|
		--| Ashford, Middlesex TW15 3EB								|
		--| United Kingdom											|
		--|---------------------------------------------------------|
	]"
class EDP_FILE_NAMES

creation

	make

feature

	make is
		do
		end

--	strings: MY_STRINGS is
--		once
--			create Result.make
--		end
		
--	files:	FEC_LIST [ EDP_CLASS_FILE ] is
--		once
--			create Result.make
--		end

	find(findex: INTEGER): INTEGER is
		local
			i: INTEGER
		do
--			from i := 1
--			until i > files.count or Result /= 0
--			loop
--				if (files @ i).file_index = findex then
--					Result := i
--				end
--				i := i + 1
--			end
		end
		
	has(findex: INTEGER): BOOLEAN is
		do
			Result := find(findex) > 0
		end
				

end -- class EDP_FILE_NAMES