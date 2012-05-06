--|---------------------------------------------------------|
--| Copyright (c) Howard Thomson 1999,2000,2001,2006		|
--| 52 Ashford Crescent										|
--| Ashford, Middlesex TW15 3EB								|
--| United Kingdom											|
--|---------------------------------------------------------|
note

	description: "Class target for error reporting"
	
deferred class EDP_ERROR_TARGET

feature

	report_error(an_error: UT_ERROR)
		deferred
		end

	report_warning(a_warning: UT_ERROR)
		deferred
		end

	report_info(an_info: UT_ERROR)
		deferred
		end

end