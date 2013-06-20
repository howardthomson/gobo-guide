--|---------------------------------------------------------|
--| Copyright (c) Howard Thomson 1999,2000,2001,2006		|
--| 52 Ashford Crescent										|
--| Ashford, Middlesex TW15 3EB								|
--| United Kingdom											|
--|---------------------------------------------------------|
note
	description: "[
		Tree list item specific to Class file status
	]"

	todo: "[
		Fix 'set_expanded' calls, currently commented out ...
		
		Add tick/cross box to open/close editable window for this class
		Open with primary file selected as that of the currently selected project.
		Display status:
			Red:	Invalid
			Orange:	Warnings
			Green:	OK
			??:		Unused
			White:	Undefined
			Yellow: Overridden class
		Show Red for ##Unknown## class, where class text not found &c

		Feature status -- move to feature list item ...
			Immediate / inherited
			Effective / deferred
			Query (attribute or argumentless function) / function (with arguments) / procedure
	]"
	done: "[
		Adjust position of dotted lines of tree info to allow for 'draw_other_icons'
	]"

class EDP_CLASS_LIST_ITEM

inherit

	EV_TREE_ITEM
--		redefine
--			draw_other_icons
--		end

create

	default_create	--make, make_empty

feature -- status

	S_unused	: INTEGER = 0	-- Repository only
	S_name_clash: INTEGER = 1	-- In clusters, multiple files
	S_overridden: INTEGER = 2	-- In clusters but overridden by other class
	S_invalid	: INTEGER = 3	-- Error, scan/parse/validation failed
	S_warnings	: INTEGER = 4	-- Warnings issued
	S_in_system	: INTEGER = 5	-- Is in_system

feature -- Class status values

	--	S_invalid	: Red
	--	S_warnings	: Orange
	--	S_in_system	: Green

feature -- File status values

	--	S_name_clash: Red
	--	S_overridden: Yellow
	--	S_in_system	: Green

	--	ET_CLASS.has_name_clash
	--	ET_CLASS.is_overridden
	--	ET_CLASS.has_syntax_error
	--	ET_CLASS.is_deferred
	--	ET_CLASS.has_ancestors_error
	--	ET_CLASS.has_flattening_error
	--	ET_CLASS.has_interface_error
	--	ET_CLASS.has_implementation_error

	system_status: INTEGER

	set_status (c: ET_CLASS)
			-- Set status of the class_name item
		do
			if system_status = S_invalid then
				-- do nothing
			elseif c.has_syntax_error
				or c.has_ancestors_error
				or c.has_flattening_error
				or c.has_interface_error
				or c.has_implementation_error
			then
				system_status := S_invalid
-- TODO: Fix next line ..., ET_CLASS.has_name_clash no longer available
--			elseif c.has_name_clash then
--				system_status := S_name_clash
			elseif c.in_system then
				system_status := S_in_system
			end
--			if system_status = S_invalid then set_expanded (True) end
		end

	set_file_status (c: ET_CLASS)
			-- Set status of this filename item
		do
			if system_status = S_invalid then
				-- do nothing
			elseif c.filename = Void then
				system_status := S_invalid
-- TODO: Fix next line ..., ET_CLASS.has_name_clash no longer available
--			elseif c.has_name_clash then
--				system_status := S_name_clash
			elseif c.is_overridden then
				system_status := S_overridden
			elseif c.in_system then
				system_status := S_in_system
			end
--			if system_status = S_invalid then set_expanded (True) end
		end

	set_status_from (other: like Current)
		do
			if other.system_status = S_invalid then
				system_status := S_invalid
			elseif system_status = S_invalid then
				-- do nothing
			elseif other.system_status = S_name_clash then
				system_status := S_name_clash
			end
--			if system_status = S_invalid then set_expanded (True) end
		end

	set_status_ok
		do
			system_status := S_in_system
		end

	set_status_invalid
		do
			system_status := S_invalid
		end

feature -- display

--	draw_other_icons (list: SB_GENERIC_TREE_LIST [ SB_TREE_LIST_ITEM ]; dc: SB_DC; a_x, a_y, w, h: INTEGER): INTEGER
--		local
--			l_color: INTEGER
--		do
--			-- Draw item status colour block
--			inspect system_status
--			when S_unused		then l_color := 0x00ffffff	-- White
--			when S_name_clash	then l_color := 0x004890ff	-- Orange
--			when S_overridden	then l_color := 0x0040ffff	-- Yellow ?	255/255/64
--			when S_invalid		then l_color := 0x000000ff	-- Red
--			when S_warnings		then l_color := 0x004890ff	-- Orange ?	255/144/72
--			when S_in_system	then l_color := 0x0000ff00	-- Green
--			end
--         	dc.set_foreground (l_color)
--         	dc.fill_rectangle (a_x + 2, a_y + 4, 5, 9)

--         	-- Draw is_open check-box for class window
--         	-- ...

--			Result := 24
--		end

end
