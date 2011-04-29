note

	description: "[
		Window for browsing/editing the source text(s) for an Eiffel Class.
		Highlight differences between multiple source texts for the class.
		Display change set history for a class text.
		
		Associated information being: (In Project Window ?)
			Class Ancestors, Suppliers, Clients, Descendants
			Attributes, Routines, Constants, etc
	]"
	author:	"Howard Thomson"
	copyright: "[
		--|---------------------------------------------------------|
		--| Copyright (c) Howard Thomson 1999,2000					|
		--| 52 Ashford Crescent										|
		--| Ashford, Middlesex TW15 3EB								|
		--| United Kingdom											|
		--|---------------------------------------------------------|
	]"
	todo: "[
		Adapt to display multiple instances of a named class:
			One, or two editable panes
			Combo-box selection of current content
			Differential comparison options between selected files
		Expand/collapse regions of code: routine, feature_list, inheritance, indexing etc
			Substructure: if/else/endif, loop, inspect/when, etc, index_tag/multi-line-string
	]"
	done: "[
		Notify corresponding EDP_CLASS object of window closure and deletion.
	]"
	window_layout: "[
		Class centred information and edit window

		Top_window
			v_box
				menu-bar
				tool-bar
				h_box
				1/	Feature tree
				2/	tab_multi_window
					scroll_window	\
					scanner_view	/ ...
				status_line
	]"

class EDP_CLASS_WINDOW

inherit

	SB_TOP_WINDOW
		rename
			make as make_top_window
		redefine
			destruct
		end

	SB_SPLITTER_CONSTANTS

creation {EDP_CLASS, EDP_REPOSITORY}

	make

feature -- creation routines

	the_class	: EDP_CLASS
	the_class_2 : EDP_CLASS

	make (a_class: EDP_CLASS) is
		-- Creation wrt a specific class
		require
			class_not_void: a_class /= Void
		do
			the_class := a_class
			the_class.scan
			make_window
		ensure
			class_remembered: the_class = a_class
		end

feature -- destruction

	destruct is
		do
			the_class.window_destroyed
			Precursor
		end

feature -- window structure

	vbox		: SB_VERTICAL_FRAME
	menu_bar	: SB_MENU_BAR
	tool_bar	: SB_TOOL_BAR
	status_line	: SB_STATUS_BAR
--	hbox		: SB_HORIZONTAL_FRAME
	split		: SB_SPLITTER
	editor		: EDP_SYMBOL_EDITOR
	editor_2	: EDP_SYMBOL_EDITOR
	
	make_window is
		do
			make_top_title (get_app, new_title)

			resize (600, 800)
			flags := flags | Flag_enabled
			if the_class.et_class.overridden_class /= Void then
				make_comparison_window
			else
				create vbox.make (Current)
				vbox.set_layout_hints (Layout_fill_x | Layout_fill_y)
				create status_line.make (vbox)
				status_line.set_layout_hints (Layout_fill_x | Layout_bottom)
				status_line.status_line.set_text ("Filename: " + the_class.filename)
				create editor.make (vbox, the_class.scanner)
				editor.set_layout_hints (Layout_fill_x | Layout_fill_y)
				show
			end
		end

	make_comparison_window is			
		do
				-- Setup for the second class
			the_class_2 ?= the_class.et_class.overridden_class.data
			the_class_2.scan
				-- Create the vertical box
			create vbox.make (Current)
			vbox.set_layout_hints (Layout_fill_x | Layout_fill_y)
			create status_line.make (vbox)
			status_line.set_layout_hints (Layout_fill_x | Layout_bottom)
			status_line.status_line.set_text ("Filename: " + the_class.filename)
				-- Create the splitter to contain the two editable windows
			create split.make_sb (vbox, Splitter_horizontal | Layout_fill_x | Layout_fill_y)
				-- Create the first (left-hand) edit window
			create editor.make (split, the_class.scanner)
			editor.set_layout_hints (Layout_fill_x | Layout_fill_y)
				-- Create the second (right-hand) edit window
			create editor_2.make (split, the_class_2.scanner)
			editor_2.set_layout_hints (Layout_fill_x | Layout_fill_y)
			mark_differences
			show
		end

-- TODO: provide access to the Universe for this ET_CLASS for the
-- creation routine below.
-- Could it be Void ?? Invariant, I think, requires non-Void
-- In that case, it should not be a Once function ....

	class_processor: GECMP_AST_PROCESSOR is
		once
			create Result.make (Void)
		end

	mark_differences is
			-- Mark the symbols where different
		local
			as1, as2: ARRAY [ SCANNER_SYMBOL ]
			diff: EDP_DIFF_SYMBOLS_LGPL [ SCANNER_SYMBOL ]
		do
			as1 := the_class.scanner.symbols.to_array
			as2 := the_class_2.scanner.symbols.to_array
			create diff.make (as1, as2)
			diff.diff_compare
			diff.mark_symbols
		end

	new_title: STRING is
		do
			create Result.make(20)
			Result.append(the_class.et_class.name.name)
			Result.append(" (EDP)")

		--	Result.append(" status: ")
		--	Result.append(the_class.status_string)
		end

end -- EDP_CLASS_WINDOW