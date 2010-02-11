class DIFF_SYMBOL_CONSTANTS

feature

	Match_equal: INTEGER is 0
		-- Default, matches other symbol
		
	Match_exclude: INTEGER is 1
		-- Ignore in matching process
		
	Match_fail: INTEGER is 2
		-- Differs from other symbol

end