class SB_WIDGET_SELECTORS

feature -- Top Level Windows

		Sb_main_window,
		Sb_top_window,
		Sb_popup,
		Sb_tool_bar_shell
			: INTEGER = unique

feature -- Dialogs

feature -- Widgets

	-- Static images &c

		Sb_w_bitmap,
		Sb_w_image,		-- ??
			Sb_w_icon,
				Sb_w_bmp_icon,
				Sb_w_gif_icon,
				Sb_w_jpeg_icon,
				Sb_w_pcx_icon,
				Sb_w_png_icon,
				Sb_w_rgb_icon,
				Sb_w_targa_icon,
				Sb_w_tiff_icon,
				Sb_w_xpm_icon,

	-- Screen area organisation
		Sb_w_frame,
		Sb_w_canvas,

		Sb_w_4splitter,
		Sb_w_splitter,

		Sb_w_tab_bar,
		Sb_w_switcher,

		Sb_w_horizontal_frame,
		Sb_w_vertical_frame,

		Sb_w_horizontal_separator,
		Sb_w_vertical_separator,

		Sb_w_menu_bar,
		Sb_w_tool_bar,

		Sb_w_scroll_corner,
		Sb_w_tool_bar_grip,

	-- Labelling / Information
		Sb_w_label,
		Sb_w_header,

	-- Action: Buttons etc
		Sb_w_button,
		Sb_w_arrow_button,

		Sb_w_check_button,
		Sb_w_toggle_button,

	-- Selection

	-- Display

	-- Entry / Display

		Sb_w_dialog_box,
		Sb_w_drag_corner,
		Sb_icon_list,
		Sb_w_input_dialog,
		
		Sb_w_list,
		Sb_w_list_box,
		
		Sb_w_menu_check,
		Sb_w_menu_radio,
		Sb_w_packer,

		Sb_w_combo_box,
		Sb_w_group_box,

		Sb_w_ruler,

	-- Dialogs

	-- Menu elements

	-- MDI elements
		Sb_w_mdi_maximise_button,
		Sb_w_mdi_minimize_button,
		Sb_w_mdi_restore_button,
		Sb_w_mdi_delete_button,

		Sb_w_mdi_child,
		Sb_w_mdi_client,
		Sb_w_mdi_menu,
		Sb_w_mdi_window_button,

	-- Items, for lists of all types
	-- These are not widgets for screen design
	--	Sb_w_item,
	--	Sb_w_list_item,
	--	Sb_w_tree_list_item,
	--	Sb_w_header_item,
	--	Sb_w_dir_list_item,
	--	Sb_w_icon_list_item,
	--
	--	Sb_w_file_list_item,

-- #### Unsorted...
		Sb_w_dialog,
		Sb_w_file_list,
		Sb_w_groupbox,
		Sb_w_icon_list,
		Sb_w_mdi_buttons,
		Sb_w_mdi_test,
		Sb_w_message_server,
		Sb_w_option,
		Sb_w_popup,
		Sb_w_progress_bar,
		Sb_w_radio_button,
		Sb_w_scribble,
		Sb_w_spinner,
		Sb_w_status_bar,
		Sb_w_tab_book,
		Sb_w_text_field,
		Sb_w_tree,
		Sb_w_tree_list_box
--###

		: INTEGER = unique




end