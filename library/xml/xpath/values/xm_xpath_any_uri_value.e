indexing

	description:

		"XPath anyURI values"

	library: "Gobo Eiffel XPath Library"
	copyright: "Copyright (c) 2004, Colin Adams and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class XM_XPATH_ANY_URI_VALUE

inherit

	XM_XPATH_STRING_VALUE
		rename
			make as make_string
		redefine
			is_any_uri, as_any_uri, convert_to_type, item_type, same_expression,
			is_comparable, is_convertible, display, three_way_comparison
		end

	KL_IMPORTED_STRING_ROUTINES

		-- Although anyURI is not a sub-type of xs:string, it is convenient
		-- to implement it as such.

create

	make

feature {NONE} -- Initialization

	make (a_value: STRING) is
			-- Establish invariant
		require
			value_not_void: a_value /= Void
		do
			make_atomic_value
			value := trimmed_white_space (a_value)
		ensure
			value_set: STRING_.same_string (value, a_value)
			static_properties_computed: are_static_properties_computed
		end

feature -- Access

	is_any_uri: BOOLEAN is
			-- Is `Current' an anyURI value?
		do
			Result := True
		end

	as_any_uri: XM_XPATH_ANY_URI_VALUE is
			-- `Current' seen as an anyURI value
		do
			Result := Current
		end

	item_type: XM_XPATH_ITEM_TYPE is
			-- Data type
		do
			Result := type_factory.any_uri_type
			if Result /= Void then
				-- Bug in SE 1.0 and 1.1: Make sure that
				-- that `Result' is not optimized away.
			end
		end

feature -- Comparison

	same_expression (other: XM_XPATH_EXPRESSION): BOOLEAN is
			-- Are `Current' and `other' the same expression?
		do
			if other.is_any_uri then
				Result := STRING_.same_string (string_value, other.as_any_uri.string_value)
			end
		end

	three_way_comparison (other: XM_XPATH_ATOMIC_VALUE): INTEGER is
			-- Compare `Current' to `other'
		do

			-- N.B. This implementatation won't be used, as ST_COLLATOR's version
			-- will be used for comparing strings (TODO: ? - check this out).			

			Result := string_value.three_way_comparison (other.as_string_value.string_value)
		end

feature -- Status report

	is_comparable (other: XM_XPATH_ATOMIC_VALUE): BOOLEAN is
			-- Is `other' comparable to `Current'?
		do
			Result := other.is_string_value
		end
	
	display (a_level: INTEGER) is
			-- Diagnostic print of expression structure to `std.error'
		local
			a_string: STRING
		do
			a_string := STRING_.appended_string (indentation (a_level), "anyURI (%"")
			a_string := STRING_.appended_string (a_string, string_value)
			a_string := STRING_.appended_string (a_string, "%")")
			std.error.put_string (a_string)
			std.error.put_new_line
		end

	is_convertible (a_required_type: XM_XPATH_ITEM_TYPE): BOOLEAN is
			-- Is `Current' convertible to `a_required_type'?
		do
			todo ("is-convertible", False)
		end

feature -- Conversion

	convert_to_type (a_required_type: XM_XPATH_ITEM_TYPE): XM_XPATH_ATOMIC_VALUE is
			-- Convert `Current' to `a_required_type'
		do
				todo ("convert-to-type", False)				
		end

invariant
	value_not_void: value /= Void

end
