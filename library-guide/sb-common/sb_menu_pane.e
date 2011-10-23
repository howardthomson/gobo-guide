note
	description: "Popup menu pane"

	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

class SB_MENU_PANE

inherit

	SB_POPUP
		rename
			make_opts as popup_make_opts,
			make as popup_make
		redefine
			contains,
			class_name
		end

create

   make,
   make_opts

feature -- class name

	class_name: STRING
		once
			Result := "SB_MENU_PANE"
		end

feature  -- Creation

	make (a_window: SB_WINDOW)
			-- Construct menu pane
		do
			make_opts (a_window, 0)
		end

	make_opts (a_window: SB_WINDOW; opts: INTEGER) is
			-- Construct menu pane
		do
			popup_make_opts (a_window, opts | Frame_raised | Frame_thick, 0,0,0,0)
			create accel_table.make
		end

feature -- Queries

	contains (a_parent_x, a_parent_y: INTEGER): BOOLEAN
    		-- Return true if popup contains this point
      	local
         	l_point: SB_POINT
      	do
         	-- Cursor is considered inside when it's in this window, or in 
         	-- any subwindow that's open; we'll find the latter through the 
         	-- cascade menu, by asking it for it's popup window.
         
         	if Precursor (a_parent_x, a_parent_y) then
            	Result := True
         	else
            	if focus_child /= Void then
               		l_point := parent.translate_coordinates_to (Current, a_parent_x, a_parent_y)
               		if focus_child.contains (l_point.x, l_point.y) then
                  		Result := True
               		end
            	end
         	end
      	end
end
