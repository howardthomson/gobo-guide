--|---------------------------------------------------------|
--| Copyright (c) Howard Thomson 1999,2000,2001,2006		|
--| 52 Ashford Crescent										|
--| Ashford, Middlesex TW15 3EB								|
--| United Kingdom											|
--|---------------------------------------------------------|
note

	description:

		"Lace error handlers"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 2001-2002, Eric Bezault and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date: 2003/02/07 13:07:24 $"
	revision: "$Revision: 1.5 $"

class EDP_LACE_ERROR_HANDLER

inherit

	ET_LACE_ERROR_HANDLER

create

	make

feature -- Attributes

	error_target: EDP_ERROR_TARGET

feature -- Creation

	make(an_error_target: EDP_ERROR_TARGET)
		do
			make_null
			error_target := an_error_target
		end

end
