note
	description: "[
		The menu separator is a simple decorative groove
		used to delineate items in a popup menu.
	]"
	author: "Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright: "Copyright (c) 2002, Eugene Melekhov and others"
	license: "Eiffel Forum Freeware License v2 (see forum.txt)"
	status: "Mostly complete"

class SB_MENU_SEPARATOR

inherit

	SB_WINDOW
    	rename
        	make as window_make
      	redefine
         	default_width,
         	default_height,
         	on_paint,
         	class_name
      	end

create

	make,
	make_opts

feature -- class name

	class_name: STRING
		once
			Result := "SB_MENU_SEPARATOR"
		end

feature -- Creation

	make(p: SB_COMPOSITE)
			-- Construct a menu separator
		do
			make_opts(p, Zero);
		end

	make_opts(p: SB_COMPOSITE; opts: INTEGER)
			-- Construct a menu separator
		do
			window_make(p, opts, 0,0,0,0);
			flags := flags | Flag_shown;
			default_cursor := application.default_cursor(Def_rarrow_cursor);
			hilite_color := application.hilite_color;
			shadow_color := application.shadow_color;
		end

feature -- Data

	hilite_color: INTEGER;
	shadow_color: INTEGER;

feature -- Queries

	default_width: INTEGER
			-- Return default width
		do
			Result := LEADSPACE + TRAILSPACE;
		end

	default_height: INTEGER
			-- Return default height
		do
        	Result := 2;
      	end

feature -- Actions

	set_hilite_color(clr: INTEGER)
    		-- Change highlight color
    	do
        	if clr /= hilite_color then
            	hilite_color := clr;
            	update;
         	end
      	end

	set_shadow_color(clr: INTEGER)
			-- Change shadow color
      	do
         	if clr /= shadow_color then
            	shadow_color := clr;
            	update;
         	end
      	end

feature -- Message processing

   on_paint (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         ev: SB_EVENT
         dc: SB_DC_WINDOW
      do
         ev ?= data;
         check
            ev /= Void
         end
         dc := paint_dc
         dc.make_event(Current, ev);
         dc.set_foreground(back_color);
         dc.fill_rectangle(ev.rect_x, ev.rect_y, ev.rect_w, ev.rect_h);
         dc.set_foreground(shadow_color);
         dc.fill_rectangle(1, 0, width, 1);
         dc.set_foreground(hilite_color);
         dc.fill_rectangle(1, 1, width, 1);
         dc.stop;
         Result := True;
      end

feature {NONE} -- Implementation

   LEADSPACE: INTEGER = 22;
   TRAILSPACE: INTEGER = 16;

end
