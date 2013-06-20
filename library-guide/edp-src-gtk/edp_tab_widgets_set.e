--|---------------------------------------------------------|
--| Copyright (c) Howard Thomson 1999,2000,2001,2006		|
--| 52 Ashford Crescent										|
--| Ashford, Middlesex TW15 3EB								|
--| United Kingdom											|
--|---------------------------------------------------------|
class EDP_TAB_WIDGETS_SET

feature -- Attributes

	ace_tab				: EV_TREE
	classes_tab			: EDP_CLASS_TREE_LIST
	features_tab		: EV_TREE
	cluster_errors_tab	: EV_TREE
	errors_tab			: EV_TREE

feature -- Setters

	set_ace_tab(w: like ace_tab)
		do
			ace_tab := w
		end

	set_classes_tab(w: like classes_tab)
		do
			classes_tab := w
		end

	set_features_tab(w: like features_tab)
		do
			features_tab := w
		end

	set_cluster_errors_tab(w: like cluster_errors_tab)
		do
			cluster_errors_tab := w
		end

	set_errors_tab(w: like errors_tab)
		do
			errors_tab := w
		end

feature -- Show / Hide

	show
			-- Show all tabs
		do
			ace_tab.show
			classes_tab.show
			features_tab.show
			errors_tab.show
		end

	hide
			-- Hide all tabs
		do
			ace_tab.hide
			classes_tab.hide
			features_tab.hide
			errors_tab.hide
		end

end
