--|---------------------------------------------------------|
--| Copyright (c) Howard Thomson 1999,2000,2001,2006		|
--| 52 Ashford Crescent										|
--| Ashford, Middlesex TW15 3EB								|
--| United Kingdom											|
--|---------------------------------------------------------|
indexing

	description: "Class target for error reporting"
	
deferred class EDP_ERROR_TARGET

feature

	report_error(an_error: UT_ERROR) is
		deferred
		end

	report_warning(a_warning: UT_ERROR) is
		deferred
		end

	report_info(an_info: UT_ERROR) is
		deferred
		end

end