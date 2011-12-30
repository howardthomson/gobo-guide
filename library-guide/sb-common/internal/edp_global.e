--|---------------------------------------------------------|
--| Copyright (c) Howard Thomson 1999,2000,2001,2006		|
--| 52 Ashford Crescent										|
--| Ashford, Middlesex TW15 3EB								|
--| United Kingdom											|
--|---------------------------------------------------------|
indexing
	description:"Global facilities class for EDP based programs"
	author:		"Howard Thomson"

	todo: "[
		As the shared 'gobo_strings' do not, in fact, contain the shared retrievable
		strings for editing, do they need to be shared between projects ?
	]"

class EDP_GLOBAL

feature {NONE} -- shared strings

	shared_gobo_strings: EDP_GOBO_STRINGS

	gobo_strings: DS_HASH_TABLE [INTEGER, STRING] is
		once
			Result := shared_gobo_strings.gobo_strings
		end
	
feature -- Tracing

	trace_start is
		do
		end

	trace_stop is
		do
		end

feature -- Repository

	repository: EDP_REPOSITORY is
		once
			create Result.make
		end

end