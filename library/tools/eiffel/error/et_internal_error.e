note

	description:

		"Internal errors"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 2003-2011, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

	edp_mods: "[
		Added make_giaaa_cl with __CLASS__, __LINE__ arguments
	]"

class ET_INTERNAL_ERROR

inherit

	ET_ERROR

create

	make_giaaa, make_giaaa_cl

feature {NONE} -- Initialization

	make_giaaa
			-- Create a new GIAAA error.
		do
			code := giaaa_template_code
			etl_code := giaaa_etl_code
			default_template := gi_default_template
			create parameters.make_filled (empty_string, 1, 1)
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

	gi_default_template: STRING = "[$1] internal error."
			-- Default templates

	gi_default_template_cl: STRING - "[$1] internal error in class [$2] at line [$3]."
			-- Default templates

	giaaa_etl_code: STRING = "GIAAA"
			-- ETL validity codes

	giaaa_template_code: STRING = "giaaa"
		-- Template error codes

end
