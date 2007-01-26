indexing

	description:

		"Options used by receivers implemented as bit flags"

	library: "Gobo Eiffel XPath Library"
	copyright: "Copyright (c) 2004, Colin Adams and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class XM_XPATH_RECEIVER_OPTIONS

inherit

	ANY

	KL_IMPORTED_INTEGER_ROUTINES
		export {NONE} all end

feature -- Access

	Namespace_ok: INTEGER is 1
			-- Namespace (of an element or attribute name) has already been declared;
			--  it does not need to be generated by the namespace fixup process.

	Disinherit_namespaces: INTEGER is 2
			-- Element does not inherit namespaces

	Prefix_check_needed: INTEGER is 4
			-- Element or attribute annotated as an xs:QName or xs:NOTATION
			--  has been lexically checked but still requires a check
			--  that the prefix is in scope

	Reject_duplicates: INTEGER is 8
			-- Duplicate values should be rejected


	No_special_characters: INTEGER is 16
			-- No special charaters needing escaping are present

	Use_null_markers: INTEGER is 32
			-- Attribute value or text node contains null characters
			--  before and after strings generated by character mapping; these strings
			--  are to be output without escaping

	Disable_escaping: INTEGER is 64
			-- Disable output escaping.
	
	is_namespace_declared (a_property_set: INTEGER): BOOLEAN is
			-- Has the element/attribute namespace been declared?
		do
			Result := INTEGER_.bit_and (a_property_set, Namespace_ok) /= 0
		end

	is_disinherit_namespaces (a_property_set: INTEGER): BOOLEAN is
			-- Does `a_property_set' mandate no inheritance of namespaces?
		do
			Result := INTEGER_.bit_and (a_property_set, Disinherit_namespaces) /= 0
		end

	is_prefix_check_needed (a_property_set: INTEGER): BOOLEAN is
			-- Does `a_property_set' indicate a prefix check is needed?
		do
			Result := INTEGER_.bit_and (a_property_set, Prefix_check_needed) /= 0
		end

	are_duplicates_rejected (a_property_set: INTEGER): BOOLEAN is
			-- Are duplicates to be rejected?
		do
			Result := INTEGER_.bit_and (a_property_set, Reject_duplicates) /= 0
		end

	are_no_special_characters (a_property_set: INTEGER): BOOLEAN is
			-- is there an absence of special characters needing escaping?
		do
			Result := INTEGER_.bit_and (a_property_set, No_special_characters) /= 0
		end

	are_null_markers_used (a_property_set: INTEGER): BOOLEAN is
			-- Are null markers to be output without escaping?
		do
			Result := INTEGER_.bit_and (a_property_set, Use_null_markers) /= 0
		end

	is_output_escaping_disabled (a_property_set: INTEGER): BOOLEAN is
			-- is output-escaping disabled?
		do
			Result := INTEGER_.bit_and (a_property_set, Disable_escaping) /= 0
		end

	
end
