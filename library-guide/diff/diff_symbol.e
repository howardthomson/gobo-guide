deferred class DIFF_SYMBOL

inherit

	HASHABLE

	DIFF_SYMBOL_CONSTANTS

feature -- Match status

	match_status : INTEGER

	set_match_status (i: INTEGER)
		do
			match_status := i
		end

	set_match_exclude
		do
			match_status := Match_exclude
		end

	is_match_exclude: BOOLEAN
		do
			Result := match_status = Match_exclude
		end

	is_match_fail: BOOLEAN
		do
			Result := match_status = Match_fail
		end
end