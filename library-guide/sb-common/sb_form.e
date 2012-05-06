note

	todo: "[
		Establish class type for client in make_from_tuple
	]"

class SB_FORM

inherit
	SB_MAIN_WINDOW
		rename
			make as make_main_window
		redefine
			class_name,
			handle_2,
			destruct,
			on_paint
		end
		
	SB_WIDGET_SELECTORS
	SB_SHARED_APPLICATION
	
create
	make_for_design

feature -- Attributes

	design_mode: BOOLEAN

feature -- class name

	class_name: STRING
		once
			Result := "SB_FORM"
		end

feature -- Creation

	make_for_design
		do
			make_main_window (application, "NEW -- for Design")
			show
			design_mode := True
			flags := flags | Flag_enabled
			make_design_menu
		end

	destruct
		do
			design_menu.destruct
			Precursor
		end

feature -- Menu creation

	design_menu: SB_MENU_PANE

	make_design_menu
			-- Popup menu pane for right click in design mode
		local
		--	sub_menu: SB_MENU_
			command: SB_MENU_COMMAND
		--	title: SB_MENU_TITLE
		do
			create design_menu.make (Current)

			create command.make_sb (design_menu, "Open Widgets Window", application, 2)
		end
			

feature -- Event handling

	handle_2 (sender: SB_MESSAGE_HANDLER; type, sel: INTEGER; data: ANY): BOOLEAN
		local
			ev: SB_EVENT
		do
			ev ?= data
			if type = Sel_rightbuttonpress then
				design_menu.pop_up (Void, ev.root_x, ev.root_y, 0,0)
				update
			elseif type = Sel_rightbuttonrelease then
				-- Do Nothing, at present
			else
				Result := Precursor (sender, type, sel, data)
			end
		end

	on_paint (sender: SB_MESSAGE_HANDLER; sel: INTEGER; data: ANY): BOOLEAN
		do
			Result := Precursor (sender, sel, data)
		end
		
end
