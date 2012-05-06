class DIFF_SYMBOL_CONSTANTS

feature

	Match_equal: INTEGER = 0
		-- Default, matches other symbol
		
	Match_exclude: INTEGER = 1
		-- Ignore in matching process
		
	Match_fail: INTEGER = 2
		-- Differs from other symbol

end