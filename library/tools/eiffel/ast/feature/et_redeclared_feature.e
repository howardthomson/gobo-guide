indexing

	description:

		"Eiffel redeclared features"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 2003, Eric Bezault and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class ET_REDECLARED_FEATURE

inherit

	ET_ADAPTED_FEATURE
		redefine
			is_redeclared,
			redeclared_feature
		end

creation

	make

feature {NONE} -- Initialization

	make (a_feature: like flattened_feature; a_parent_feature: like parent_feature) is
			-- Create a new redeclared feature.
		require
			a_feature_not_void: a_feature /= Void
			a_parent_feature_not_void: a_parent_feature /= Void
		do
			flattened_feature := a_feature
			parent_feature := a_parent_feature
			first_seed := a_parent_feature.first_seed
			other_seeds := a_parent_feature.other_seeds
		ensure
			flattened_feature_set: flattened_feature = a_feature
			parent_feature_set: parent_feature = a_parent_feature
		end

feature -- Initialization

	reset (a_feature: like flattened_feature; a_parent_feature: like parent_feature) is
			-- Reset redeclared feature.
		require
			a_feature_not_void: a_feature /= Void
			a_parent_feature_not_void: a_parent_feature /= Void
		do
			flattened_feature := a_feature
			parent_feature := a_parent_feature
			first_seed := a_parent_feature.first_seed
			other_seeds := a_parent_feature.other_seeds
			is_selected := False
			replicated_features := Void
			replicated_seeds := Void
		ensure
			flattened_feature_set: flattened_feature = a_feature
			parent_feature_set: parent_feature = a_parent_feature
		end

feature -- Status report

	is_redeclared: BOOLEAN is True
			-- Is current feature being redeclared?

feature -- Access

	redeclared_feature: ET_REDECLARED_FEATURE is
			-- Current feature viewed as a redeclared feature
		do
			Result := Current
		end

invariant

	is_redeclared: is_redeclared
	no_inherited: not is_inherited

end
