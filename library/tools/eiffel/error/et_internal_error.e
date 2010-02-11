indexing

	description:

		"Internal errors"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 2003-2005, Eric Bezault and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date: 2006/04/15 22:03:14 $"
	revision: "$Revision: 1.26 $"

class ET_INTERNAL_ERROR

inherit

	ET_ERROR

create

	make_giaaa, make_giaaa_cl

feature {NONE} -- Initialization

	make_giaaa is
			-- Create a new GIAAA error.
		do
			code := giaaa_template_code
			etl_code := giaaa_etl_code
			default_template := gi_default_template
			create parameters.make (1, 1)
			parameters.put (etl_code, 1)
		ensure
			-- dollar0: $0 = program name
			-- dollar1: $1 = ETL code
		end

	make_giaaa_cl (a_class, a_line: STRING) is
			-- Create a new GIAAA error.
		do
			code := giaaa_template_code
			etl_code := giaaa_etl_code
			default_template := gi_default_template_cl
			create parameters.make (1, 3)
			parameters.put (etl_code, 1)
			parameters.put (a_class, 2)
			parameters.put (a_line, 3)
		ensure
			-- dollar0: $0 = program name
			-- dollar1: $1 = ETL code
			-- dollar2: $2 = Class Name
			-- dollar3: $3 = Line Number (as STRING)
		end

feature {NONE} -- Implementation

	gi_default_template: STRING is "[$1] internal error."
			-- Default templates

	gi_default_template_cl: STRING is "[$1] internal error in class [$2] at line [$3]."
			-- Default templates

	giaaa_etl_code: STRING is "GIAAA"
			-- ETL validity codes

	giaaa_template_code: STRING is "giaaa"
		-- Template error codes

end
