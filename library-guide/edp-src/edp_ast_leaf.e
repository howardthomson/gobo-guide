--|---------------------------------------------------------|
--| Copyright (c) Howard Thomson 1999,2000,2001,2006		|
--| 52 Ashford Crescent										|
--| Ashford, Middlesex TW15 3EB								|
--| United Kingdom											|
--|---------------------------------------------------------|
note

	description: "[
		Additional parent to ET_AST_LEAF to provide for processor to
		update status information in the scanner symbols
	]"
	author: "Howard Thomson"
	date: "25-Oct-2005"

class EDP_AST_LEAF

feature -- Attributes

	scanner_symbol: SCANNER_SYMBOL

feature -- Routines

	set_scanner_symbol(a_symbol: like scanner_symbol)
		do
			scanner_symbol := a_symbol
		end

end	