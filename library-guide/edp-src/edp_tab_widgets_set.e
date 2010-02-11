--|---------------------------------------------------------|
--| Copyright (c) Howard Thomson 1999,2000,2001,2006		|
--| 52 Ashford Crescent										|
--| Ashford, Middlesex TW15 3EB								|
--| United Kingdom											|
--|---------------------------------------------------------|
class EDP_TAB_WIDGETS_SET

feature -- Attributes

	ace_tab				: SB_TREE_LIST
	classes_tab			: EDP_CLASS_TREE_LIST
	features_tab		: SB_TREE_LIST
	cluster_errors_tab	: SB_TREE_LIST
	errors_tab			: SB_TREE_LIST

feature -- Setters

	set_ace_tab(w: like ace_tab) is
		do
			ace_tab := w
		end

	set_classes_tab(w: like classes_tab) is
		do
			classes_tab := w
		end

	set_features_tab(w: like features_tab) is
		do
			features_tab := w
		end

	set_cluster_errors_tab(w: like cluster_errors_tab) is
		do
			cluster_errors_tab := w
		end

	set_errors_tab(w: like errors_tab) is
		do
			errors_tab := w
		end

feature -- Show / Hide

	show is
			-- Show all tabs
		do
			ace_tab.show
			classes_tab.show
			features_tab.show
			errors_tab.show
		end

	hide is
			-- Hide all tabs
		do
			ace_tab.hide
			classes_tab.hide
			features_tab.hide
			errors_tab.hide
		end			

end