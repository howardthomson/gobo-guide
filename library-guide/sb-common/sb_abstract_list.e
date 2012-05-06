note
	description:"Base list"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

	Mods: "[
		2004-10-2	Added first_item, last_item
	]"

deferred class SB_ABSTRACT_LIST [ GI, GT -> SB_ITEM ]
	-- GI: Generic Index

inherit

	SB_HELP_PROVIDER

	SB_BASE_LIST_CONSTANTS

	SB_SORTABLE_ITEM_CONTAINER [ GI, GT ]

feature -- Basic widget properties

	font			: SB_FONT;	-- Font

	text_color		: INTEGER	-- Text color
	sel_back_color	: INTEGER	-- Selected back color
	sel_text_color	: INTEGER	-- Selected text color

	anchor_item		: GI	-- Anchor item
	current_item	: GI	-- Current item
	extent_item		: GI	-- Extent item
	cursor_item		: GI	-- Cursor item

--	first_item,
--	last_item		: GI

feature -- Settings

   	set_font(fnt: SB_FONT)
         	-- Change text font
      	require
         	fnt /= Void
      	do
         	if font /= fnt then
            	font := fnt
            	recalc
            	update
         	end
      	end

   	set_text_color(clr: INTEGER)
         	-- Change normal text color
      	do
         	if text_color /= clr then
            	text_color := clr
            	update
         	end
      	end

   	set_sel_back_color(clr: INTEGER)
         	-- Change selected text background
      	do
         	if sel_back_color /= clr then
            	sel_back_color := clr
            	update
         	end
      	end

	set_sel_text_color(clr: INTEGER)
			-- Change selected text color
		do
			if sel_text_color /= clr then
				sel_text_color := clr
				update
			end
		end

	is_item_current(index: GI): BOOLEAN
			-- Return True if item is current
		require
			valid_accessor(index)
		do
			Result := index = current_item;
		end

 	find_item_by_name(text: STRING): GI
         	-- Search items for item by name, starting from first item case insensitiv.
      	do
         	Result := find_item_by_name_opts(text, DEFAULT_ACCESSOR, SEARCH_FORWARD | SEARCH_WRAP);
      	end

	find_item_by_name_opts(text: STRING; start_: GI; flgs: INTEGER): GI	--## Original
         	-- Search items for item by name, starting from start item; the
         	-- flags argument controls the search direction, and case 
         	-- sensitivity.
      	deferred
      	end

feature -- Item change


	set_item_text(index: GI; text: STRING)
         	-- Change item text
      	do
         	item(index).set_text(text);
         	recalc;
      	end

	set_item_icon(index: GI; icon: SB_ICON)
         	-- Change item icon
    	local
         	i: SB_ITEM	-- SE BUG? Original text does not work due to renaming
      	do
         	i := item(index); i.set_icon(icon);
			recalc;
      	end

	enable_item(index: GI): BOOLEAN
         	-- Enable item
      	require
         	valid_accessor(index)
      	local
         	ei: like item
      	do
         	ei := item(index);
         	if not ei.is_enabled then
            	ei.set_enabled(True);
            	update_item(index);
            	Result := True;
         	end
         	Result := False;
      	end

	disable_item(index: GI): BOOLEAN
         	-- Disable item
      	require
         	valid_accessor(index)
      	local
         	ei: like item
      	do
         	ei := item (index)
         	if ei.is_enabled then
            	ei.set_enabled (False)
            	update_item (index)
            	Result := True
         	end
         	Result := False
      	end

	do_select_item (index: GI; notify: BOOLEAN)
      	local
         	t: BOOLEAN
      	do
         	t := select_item(index, notify)
      	end

 	select_item (index: GI; notify: BOOLEAN): BOOLEAN
         	-- Select item
      	require
         	valid_accessor(index)
      	deferred
      	end
   
	do_deselect_item (index: GI; notify: BOOLEAN)
      	local
         	t: BOOLEAN
      	do
         	t := deselect_item(index, notify)
      	end

 	deselect_item (index: GI; notify: BOOLEAN): BOOLEAN
         	-- Deselect item
      	require
         	valid_accessor(index)
      	deferred
      	end

	do_toggle_item (index: GI; notify: BOOLEAN)
		local
			t: BOOLEAN
		do
			t := toggle_item(index, notify)
		end

	toggle_item (index: GI; notify: BOOLEAN): BOOLEAN
			-- Toggle item selection state
		require
			valid_accessor(index)
		deferred
		end

	set_current_item (index: GI; notify: BOOLEAN)
			-- Change current item
		require
			index = DEFAULT_ACCESSOR or else valid_accessor(index)
		deferred
		end

	set_anchor_item (index: GI)
			-- Change anchor item
		require
			index = DEFAULT_ACCESSOR or else valid_accessor(index)
		do
			anchor_item := index
			extent_item := index
		end

	do_extend_selection (index: GI; notify: BOOLEAN)
      	local
         	t: BOOLEAN
      	do
         	t := extend_selection(index, notify);
      	end

	extend_selection (index: GI; notify: BOOLEAN): BOOLEAN
         	-- Extend selection from anchor item to index
      	deferred
      	end

	do_kill_selection (notify: BOOLEAN)
			-- Deselect all items
      	local
         	t: BOOLEAN
      	do
         	t := kill_selection(notify)
      	end

   	kill_selection (notify: BOOLEAN): BOOLEAN
         	-- Deselect all items
      	deferred
      	end

feature -- Message processing

   	on_clicked(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      	do
         	if send (SEL_CLICKED, data) then
            	Result := True
         	end
      	end

   	on_double_clicked(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      	do
         	if send (SEL_DOUBLECLICKED, data) then
            	Result := True
         	end
      	end

   	on_triple_clicked(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      	do
         	if send (SEL_TRIPLECLICKED, data) then
            	Result := True
         	end
      	end

   	on_command(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      	do
         	if send (SEL_COMMAND, data) then
            	Result := True
         	end
      	end

feature { NONE } -- Implementation

	update_item(index: GI)	--## Original
      	require
         	valid_accessor(index)
      	deferred
      	end

end
