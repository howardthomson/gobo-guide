--|---------------------------------------------------------|
--| Copyright (c) Howard Thomson 1999,2000,2006				|
--| 52 Ashford Crescent										|
--| Ashford, Middlesex TW15 3EB								|
--| United Kingdom											|
--|---------------------------------------------------------|
note

	todo: "[
		Close project

		Layout (of SB_PACKER ?) is currently incorrectly dependent on the order of creation of the GUI elements.
		Specifically, if the SB_STATUS_LINE is created after a widget that is assigned to fill the
		vertical space, then the fill size is calculated incorrectly, and the status line overlaps
		the bottom of the infill widget.

		Add window list and command options to:
			minimize all
			close/minimize/restore etc selected window(s)

		Create intermediate sub-directory nodes when adding file-name to cluster entry
		Also sort entries ?

		Confirm dialog for Quit

		Split window left/right: left = classes tree, right = features tree above, context info below
	]"

-- Project centred information and edit window

-- Information
--
-- Actions
--		Cluster Add (from Repository)
--		Cluster Remove (from Search Paths)
--		Verify
--		Compile
--		Execute
-- Windows

class EDP_PROJECT_WINDOW

inherit

	EV_TITLED_WINDOW
--		rename
--			make as make_main_window,
--			Id_last as main_window_id_last,
--			Shell_id_last as packer_id_last
--		redefine
--			handle_2,
--			class_name
--		end

	EDP_DISPLAY_TARGET
		undefine
			default_create, copy
		end

	EDP_ERROR_TARGET
		undefine
			default_create, copy
		end

	EDP_GLOBAL
		undefine
			default_create, copy
		end

	EV_SHARED_APPLICATION
		undefine
			default_create, copy
		end

create

	make, from_project

feature -- Attributes

	the_project:	EDP_PROJECT

feature -- class name

	class_name: STRING
		once
			Result := "EDP_PROJECT_WINDOW"
		end

feature -- creation routines

	make
			-- New blank project window
		do
			make_window
		end

	from_project (a_project: EDP_PROJECT)
			-- Creation wrt a specific project
		require
			project_not_void: a_project /= Void
		do
			make_window
			the_project := a_project
			the_project.set_display_target (Current)
			get_project_info
		ensure
			project_remembered: the_project = a_project
		end
		-----------------------------------------------

feature -- GUI elements

	vbox:			EV_VERTICAL_BOX
	hbox:			EV_HORIZONTAL_BOX
	hsplit:			EV_HORIZONTAL_SPLIT_AREA
--	menu_bar:		EV_MENU_BAR


	toolbar: EV_TOOL_BAR

	label: EV_LABEL
	button: EV_BUTTON
--	tab_bar: SB_TAB_BAR
	tab_book: EV_NOTEBOOK
	tab_item: EV_NOTEBOOK_TAB

	projects,
	config_tree,
	features_tree,
	windows_list,
	cluster_errors_list,
	errors_list
				: EV_TREE

	repository_tree: EV_TREE

	classes_tree: EDP_CLASS_TREE_LIST

--	tree_list_box: SB_TREE_LIST_BOX

	status_line: EV_STATUS_BAR

--	file_list: SB_FILE_LIST	--###

--	tab_set: ARRAY [ EDP_TAB_WIDGETS_SET ]

	make_window
		local
--			rs: SB_Q_LIST_SORTER [ SB_TREE_LIST_ITEM ]
--			rc: SB_TREE_LIST_ITEM_COMPARATOR
--			s: SB_Q_LIST_SORTER [ EDP_CLASS_LIST_ITEM ]
--			c: EDP_CLASS_LIST_ITEM_COMPARATOR
		do
				-- Initial setup ...
				-- Either:
		--	make_with_title ("Project Window")
				-- or:
			default_create
			set_title ("EDP_PROJECT_WINDOW No 1")
				-- Initial size; set_minimum_size ?
			set_size (550, 500)

				-- Setup menu ...
			make_menu_bar


--			toolbar := make_toolbar (vbox)


--			create tab_set
--			tab_set.set_parent (Current)
--			tab_set.put (create {EDP_TAB_WIDGETS_SET}, 1)

--			create vbox.make (Current)


--			create status_line.make (Current)
--			status_line.set_layout_hints (Layout_side_bottom | Layout_fill_x)

--			create hsplit.make_opts (Current, Void, 0, SPLITTER_HORIZONTAL | Layout_fill_x | Layout_fill_y, 0,0,0,0)

--	--		create file_list.make_opts (hsplit, Void, 0, Layout_fill_y, 0,0,0,0)	--###

--			create tab_book.make (hsplit,
--				--	Layout_side_left |
--				--	Layout_fill_x |
--					Layout_fill_y)
		--	create tab_bar.make (Current, Layout_side_left | Layout_fill_x | Layout_fill_y)
if false then
--			create tab_item.make (tab_book, "Repository")
--			create repository_tree.make (tab_book, 10, Void, 0,
--					Layout_fill_x | Layout_fill_y
--				 | Treelist_root_boxes | Treelist_shows_boxes | Treelist_shows_lines)
--			create rs; repository_tree.set_items_sorter (rs)
--			create rc; repository_tree.set_item_comparator (rc)
--			tab_item.set_target_and_message (tab_book, ID_OPEN_ITEM)

--			create tab_item.make (tab_book, "Windows")
--			create windows_list.make (tab_book, 10, Void, 0, Layout_fill_x | Layout_fill_y)
--			tab_item.set_target_and_message (tab_book, ID_OPEN_ITEM)

--			create tab_item.make (tab_book, "Ace / Config")
--			create config_tree.make (tab_book, 10, Void, 0, Layout_fill_x | Layout_fill_y)
--			tab_item.set_target_and_message (tab_book, ID_OPEN_ITEM)
--			(tab_set @ 1).set_ace_tab (config_tree)
end

-- Working version, without splitter
--			create tab_item.make (tab_book, "Classes")
--			create classes_tree.make (tab_book, 10, Void, 0,
--					Layout_fill_x | Layout_fill_y
--				 | Treelist_root_boxes
--				 | Treelist_shows_boxes | Treelist_shows_lines
--				 | Treelist_boxes_item_opt)
--			create s; classes_tree.set_items_sorter (s) --##
--			create c; classes_tree.set_item_comparator (c)
--			tab_item.set_target_and_message (tab_book, ID_OPEN_ITEM)
--			(tab_set @ 1).set_classes_tab (classes_tree)

--			create tab_item.make (tab_book, "Classes")
--			create classes_tree.make (tab_book, 10, Void, 0,
--					Layout_fill_x | Layout_fill_y
--				 | Treelist_root_boxes
--				 | Treelist_shows_boxes | Treelist_shows_lines
--				 | Treelist_boxes_item_opt)
--			create s; classes_tree.set_items_sorter (s) --##
--			create c; classes_tree.set_item_comparator (c)
--			tab_item.set_target_and_message (tab_book, ID_OPEN_ITEM)
--			(tab_set @ 1).set_classes_tab (classes_tree)
if false then
--			create tab_item.make (tab_book, "Features")
--			create features_tree.make (tab_book, 10, Void, 0, Layout_fill_x | Layout_fill_y)
--			tab_item.set_target_and_message (tab_book, ID_OPEN_ITEM)
--			(tab_set @ 1).set_features_tab (features_tree)
end
--			create tab_item.make (tab_book, "Cluster Errors")
--			create cluster_errors_list.make (tab_book, 10, Void, 0, Layout_fill_x | Layout_fill_y)
--			tab_item.set_target_and_message (tab_book, ID_OPEN_ITEM)
--			(tab_set @ 1).set_cluster_errors_tab (cluster_errors_list)

--			create tab_item.make (tab_book, "Errors")
--			create errors_list.make (tab_book, 10, Void, 0, Layout_fill_x | Layout_fill_y)
--			tab_item.set_target_and_message (tab_book, ID_OPEN_ITEM)
--			(tab_set @ 1).set_errors_tab (errors_list)

		end -- make_window
		---------------------------

	make_menu_bar
			-- Create the menu bar
		local
			l_menu_bar: EV_MENU_BAR
			menu_pane,
			file_menu,
			help_menu:		EV_MENU	-- SB_MENU_PANE
			menu_command:	EV_MENU	-- SB_MENU_COMMAND
			menu_title:		EV_MENU	-- SB_MENU_TITLE
		--	menu_item:		EV_MENU_ITEM
		do
				-- Menubar
--			create Result.make (vbox, Frame_raised)

--				-- File menu
--			create menu_pane.make (Current)
--			create menu_command.make_sb (menu_pane, "&Quit",	Current, Tb_quit);
--			create menu_title.make_opts (Result, "&File", Void,	menu_pane, 0);

--				-- Project menu
--			create menu_pane.make(Current)
--			create menu_command.make_sb (menu_pane, "&New ...",		Current, Tb_new);
--			create menu_command.make_sb (menu_pane, "&Open ...",	Current, Tb_open);
--			create menu_command.make_sb (menu_pane, "&Close",		Current, Tb_close);
--			create menu_title.make_opts (Result, "&Project", Void,	menu_pane, 0);

--				-- Process menu
--			create menu_pane.make (Current)
--			create menu_command.make_sb (menu_pane, "&Load",	Current, Tb_load);
--			create menu_command.make_sb (menu_pane, "&Parse",	Current, Tb_parse);
--			create menu_command.make_sb (menu_pane, "&Validate",Current, Tb_validate);
--			create menu_command.make_sb (menu_pane, "&Generate",Current, Tb_generate);
--			create menu_command.make_sb (menu_pane, "&Compile",	Current, Tb_compile);
--			create menu_command.make_sb (menu_pane, "&Execute",	Current, Tb_execute);
--			create menu_title.make_opts (Result, "&Process", Void, menu_pane, 0);

				-- Test menu
--			create menu_pane.make (Current)
--			create menu_command.make_sb (menu_pane, "&Make Form ...", Current, Tb_make_form);
--			create menu_title.make_opts (Result, "&Test", Void, menu_pane, 0);

		end
		---------------------------

	-- Toolbar item ids
	Tb_new		: INTEGER = 1	-- New Project ...
	Tb_open		: INTEGER = 2	-- Open Project ...
	Tb_close	: INTEGER = 3	-- Close Project

	Tb_load		: INTEGER = 4	-- Identify Eiffel files in repository
	Tb_scan		: INTEGER = 5	-- Load and Scan all files
	Tb_pre_parse: INTEGER = 6	-- Pre-parse clusters and locate/identify classes
	Tb_parse	: INTEGER = 7	-- Parse and load project dependant classes
	Tb_validate	: INTEGER = 8	-- Validate Project for Eiffel correctness
	Tb_generate	: INTEGER = 9	-- Generate interpretable (byte)code
	Tb_compile	: INTEGER = 10	-- Compile to target machine
	Tb_execute	: INTEGER = 11	-- Run the project

--	Tb_stop		: INTEGER = 12	-- Stop long-running action
	Tb_quit		: INTEGER = 13	-- Quit EDP
	Tb_test		: INTEGER = 14	-- TEMP Test tag

	Tb_project_select
				: INTEGER = 15	-- Projects list combo-box selection event

	Tb_make_form: INTEGER = 16	-- Make new Form ...

	Tb_last		: INTEGER = 17

	projects_list_box: EV_COMBO_BOX	-- SB_LIST_BOX

	make_toolbar (a_parent: EV_CONTAINER): EV_TOOL_BAR
		local
			b: EV_BUTTON
		do
--			create Result.make
--			Result.set_parent (a_parent)

--			create projects_list_box.make (Result, 10, 0)	-- Project Selector ListBox
--			projects_list_box.set_target_and_message (Current, Tb_project_select)
--			projects_list_box.append_item (once "NONE", Void, Void)

--	--		create b.make_sb (Result, "Load",	 Current, Tb_load,	 	0)
--			create b.make_sb (Result, "PreParse",Current, Tb_pre_parse,	0)
--	--		create b.make_sb (Result, "Parse",	 Current, Tb_parse,	 	0)
--			create b.make_sb (Result, "Validate",Current, Tb_validate,	0)
--	--		create b.make_sb (Result, "Generate",Current, Tb_generate,	0)
--	--		create b.make_sb (Result, "Compile", Current, Tb_compile, 	0)
--	--		create b.make_sb (Result, "Execute", Current, Tb_execute, 	0)
--	--		create b.make_sb (Result, "Test",	 Current, Tb_test,	 	0)
--			Result.show
		end

	toolbar_execute (tag: INTEGER)
		local
			s: STRING
			done: BOOLEAN
		do
--			if the_project /= Void then
--				inspect tag

--		--		when Tb_load then
--		--			set_status ("Get Universe ...")
--		--			the_project.get_universe
--		--			done := True
--		--			classes_tree.sort_root_items
--		--			repository_tree.sort_recursive

--		--		when Tb_scan then
--		--			set_status ("Scan Universe ...")
--		--			the_project.scan_universe
--		--			done := True

--				when Tb_pre_parse then
--					errors_list.wipe_out
--					the_project.pre_parse
--				--	add_chore (agent the_project.pre_parse)
--					done := True

--				when Tb_parse then
--					set_status ("Parsing ...")
--					the_project.parse_all
--				--	add_chore (agent the_project.parse_all)
--					done := True

--				when Tb_validate then
--					set_status ("Validating ...")
--					errors_list.wipe_out
--					open_in_system_report_file	--# TEMP
--					the_project.validate
--					close_in_system_report_file	--# TEMP
--				--	add_chore (agent the_project.validate)
--					done := True

--			--	when Tb_generate then
--			--		set_status ("Generating ..."	)
--			--		the_project.generate
--			--		done := True

--			--	when Tb_compile then
--			--		set_status ("Compiling ...")
--			--		the_project.compile
--			--		done := True

--				when Tb_execute then
--					set_status ("Execute ...")
--					the_project.execute
--					done := True

--				else
--				end
--				if done then
--					s := status_line.text.twin
--					s.append("  Done")
--					set_status(s)
--				end
--			end

--			inspect tag
--			when Tb_new then

--			when Tb_open then
--				open_project
--			when Tb_make_form then
--				make_new_form
----			when Tb_stop then
----				-- Stop long running routine
----				application.stop_modal(0)
--			when Tb_quit then
--				set_status("Quitting ...")
--				application.exit(0)
--			when Tb_test then
--				--...
--			else
--			end
		end

	add_chore (an_agent: PROCEDURE [ ANY, TUPLE ])
		local
--			c: SB_CHORE
		do
--			create c.make (an_agent)
--			application.add_chore (c)
		end

	make_new_form
			-- Create a new top level Form window
		local
--			f: SB_FORM
		do
--			create f.make_for_design
		end

	open_project
		local
			filename: STRING
			new_project: EDP_PROJECT_GOBO
		do
--			filename := open_filename (Current, once "Open Project... (Ace File)",
--				ff.current_directory, "*.ace", 1)
--			if filename /= Void then
--				-- create and register project from readable Ace file
--				create new_project.make_from_ace_file (filename, Current)
--				if new_project.et_lace_parser.error_count = 0 then
--					-- Ace file parsed OK
--					projects_list_box.append_item (new_project.system_name + ": " + filename, Void, new_project)
--				else
--					projects_list_box.append_item (filename, Void, new_project)
--				end
--				-- Select new project as current
--				projects_list_box.set_current_item (projects_list_box.items_count)
--				the_project := new_project
--				new_project.set_display_target (Current)
--			end
		end

	set_status (s: STRING)
		do
--			status_line.set_text (s)
		end

	get_project_info
		-- Create GUI data from project
		do
		end

	----------------------------------------------------------------------

	add_cluster (c: EDP_CLUSTER)
			-- Add an entry to the repository load paths
		local
			s: STRING
		do
--			s := c.directory_path
--			repository_tree.create_item_last (Void, s, Void, Void, c, False).discard_result
		end

	classes_wipe_out
			-- Clear classes list for current project
		do
			classes_tree.wipe_out
		end

	edp_class (a_class: ET_CLASS): EDP_CLASS
		do
			Result ?= a_class.data
			if Result = Void then
				create Result
				a_class.set_data (Result)
				Result.set_et_class (a_class)
			end
		end

	add_class (c: ET_CLASS)
			-- Add an entry to the cluster subtree and the classes tree
		local
			edpc: EDP_CLASS
			ucs: STRING_8
			fi: EV_TREE_ITEM	-- Found Item, repository tree
			fc: EDP_CLASS_LIST_ITEM	-- Found Item, classes tree
			nc: EDP_CLASS_LIST_ITEM	-- New Item, classes tree
		do
--			edpc := edp_class (c)
--			-- Generate ucs: Upper Class Name
--			ucs := c.name.name.twin
--			ucs.to_upper

--			-- Add to Classes tab
--			fc := classes_tree.find_item_by_name_opts (ucs, Void, 0)
--			if fc /= Void then
--				fc.set_has_expander (True)
--			else
--				fc := classes_tree.create_item_last (Void, ucs, Void, Void, c, False)
--			end
--			fc.set_status (c)
--			if c.filename /= Void then
--				nc := classes_tree.create_item_last (fc, c.filename, Void, Void, Void, False)
--			else
--				nc := classes_tree.create_item_last (fc, once "##Unknown##", Void, Void, Void, False)
--			end
--			nc.set_file_status (c)
--			fc.set_status_from (nc)
--			if c.in_system then
--				add_class_status (c, fc)
--				report_to_file (c)
--			end

			-- Add to Clusters tab
	--		fi := repository_tree.find_item_by_name_opts (c.filename, Void, SEARCH_REV_PREFIX)
	--		if fi /= Void then
	--		--	fx_trace(0, <<"EDP_PROJECT_WINDOW::add_class ", fi.label>>)
	--			repository_tree.create_item_last (fi, c.filename, Void, Void, Void, False).discard_result
	--		else
	--		--	fx_trace(0, <<"EDP_PROJECT_WINDOW::add_class, cluster not found: ", c.file_name>>)
	--		end
		end

	add_class_status (c: ET_CLASS; ti: EDP_CLASS_LIST_ITEM)
			-- Add status items to class item
			-- Called from add_class above
		local
			i, f: EDP_CLASS_LIST_ITEM
			j, nb: INTEGER
			cf: ET_FLATTENED_FEATURE
		do

--				-- Ancestor status
--			i := classes_tree.create_item_last (ti,
--					"Ancestor status", Void, Void, Void, False)
--			if c.has_ancestors_error then
--				i.set_status_invalid
--			elseif c.ancestors_built then
--				i.set_status_ok
--			end

--				-- Flattening status
--			i := classes_tree.create_item_last (ti,
--				"Flattening status", Void, Void, Void, False)
--			if c.has_flattening_error then
--				i.set_status_invalid
--			elseif c.features_flattened then
--				i.set_status_ok
--			end

--				-- Interface status
--			i := classes_tree.create_item_last (ti,
--				"Interface status", Void, Void, Void, False)
--			if c.has_interface_error then
--				i.set_status_invalid
--			elseif c.interface_checked then
--				i.set_status_ok
--			end

--				-- Implementation status
--			i := classes_tree.create_item_last (ti,
--				"Implementation status", Void, Void, Void, False)
--			if c.has_implementation_error then
--				i.set_status_invalid
--			elseif c.implementation_checked then
--				i.set_status_ok
--			end

--				-- Ancestors
--			-- TODO

--				-- Features
--			from
--				i := classes_tree.create_item_last (ti, "Queries", Void, Void, Void, False)
--				nb := c.queries.count
--				j := 1
--			until
--				j > nb
--			loop
--				cf := c.queries.item (j)
--				f := classes_tree.create_item_last (i, cf.name.name, Void, Void, Void, False)
--				if cf.is_immediate then
--					f.set_status_ok	-- Mark as green/immediate (TEMP)
--				end
--				j := j + 1
--			end
--			classes_tree.sort_child_items (i)
--			from
--				i := classes_tree.create_item_last (ti, "Procedures", Void, Void, Void, False)
--				nb := c.procedures.count
--				j := 1
--			until
--				j > nb
--			loop
--				cf := c.procedures.item (j)
--				f := classes_tree.create_item_last (i, cf.name.name, Void, Void, Void, False)
--				if cf.is_immediate then
--					f.set_status_ok	-- Mark as green/immediate (TEMP)
--				end
--				j := j + 1
--			end
--			classes_tree.sort_child_items (i)
		end

	sort_classes
		do
--			classes_tree.sort_root_items
		end

feature -- EDP_DISPLAY_TARGET implementation

	errors_wipe_out (a_project: EDP_PROJECT)
		do
			errors_list.wipe_out
		end

	report_error (an_error: UT_ERROR)
		do
			--	Add to errors tree
--			errors_list.create_item_last (Void, an_error.default_message, Void, Void, Void, False).discard_result
			--	Set current tab as errors tab
		--	.... TODO
		end

	report_warning (a_warning: UT_ERROR)
		do
			print ("EDP_PROJECT_WINDOW.report_warning called%N")
		end

	report_info (an_info: UT_ERROR)
		do
			print ("EDP_PROJECT_WINDOW.report_info called%N")
		end

feature {NONE} -- Save file names if in-system classes

	in_system_file: PLAIN_TEXT_FILE

	open_in_system_report_file
			-- Create/truncate file for in_system filenames
		do
			create {PLAIN_TEXT_FILE} in_system_file.make_create_read_write ("in_system_filenames")
		end

	close_in_system_report_file
			-- Close file for in_system filenames
		do
			if in_system_file /= Void then
				in_system_file.close
			end
		end

	report_to_file (c: ET_CLASS)
			-- Report filenames of classes in_system
			-- to file
		require
			valid_class: c /= Void
		do
			if c.filename /= Void
			and then in_system_file /= Void
			and then not in_system_file.is_closed then
				in_system_file.put_string (c.filename)
				in_system_file.put_character ('%N')
			end
		end

	------------------------------------------------------------------------

--feature -- Properties

---- SB_PROPERTY below may need to be altered to SB_PROPERTY_VALUE

--	property (i: INTEGER): SB_PROPERTY
--		do

--		end

--	XXproperties: ARRAY [ SB_PROPERTY ]
--		require
--			implemented: true
--			enabled: false
--		local
--			p: SB_PROPERTY
--		once
--		--	!!Result.make (1, 0) -- ???
--		--	!EGUIP_NAME!p.make("EDP_PROJECT_WINDOW No 1"); Result.add_last(p)
--		end

--feature -- event handling

--	handle_2 (sender: SB_MESSAGE_HANDLER; type, a_msg: INTEGER; data: ANY): BOOLEAN
--		do
--			if match_functions_2 (SEL_COMMAND, Tb_new, Tb_last, type, a_msg) then
--				toolbar_execute (a_msg)
--			else Result := Precursor (sender, type, a_msg, data)
--			end
--		end

invariant
--	(width = 0) implies rq_trace(<< once "width = 0: ", out>>)
end -- EDP_PROJECT_WINDOW
