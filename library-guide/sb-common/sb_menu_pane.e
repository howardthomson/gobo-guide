indexing
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

creation

   make,
   make_opts

feature -- class name

	class_name: STRING is
		once
			Result := "SB_MENU_PANE"
		end

feature  -- Creation

   make (ownr: SB_WINDOW) is
         -- Construct menu pane
      do
         make_opts(ownr, Zero);
      end

   make_opts (ownr: SB_WINDOW; opts: INTEGER) is
         -- Construct menu pane
      do
         popup_make_opts(ownr, opts | Frame_raised | Frame_thick, 0,0,0,0);
         create accel_table.make;
      end

feature -- Queries

	contains (parentx, parenty: INTEGER): BOOLEAN is
    		-- Return true if popup contains this point
      	local
         	pt: SB_POINT;
      	do
         	-- Cursor is considered inside when it's in this window, or in 
         	-- any subwindow that's open; we'll find the latter through the 
         	-- cascade menu, by asking it for it's popup window.
         
         	if Precursor(parentx, parenty) then
            	Result := True;
         	else
            	if focus_child /= Void then
               		pt := parent.translate_coordinates_to(Current, parentx, parenty);
               		if focus_child.contains(pt.x, pt.y) then
                  		Result := True;
               		end
            	end
         	end
      	end
end
