note
	description: "[
		A toolbar grip is used to move its parent [an SB_TOOL_BAR].
		The grip draws either a single or double bar; it is customary to
		use the single bar grip for toolbar-rearrangements only, and use
		the double-bar when the toolbar needs to be floated or docked. The
		toolbar grip is automatically oriented properly by the the toolbar widget.
			]"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

class SB_TOOL_BAR_GRIP

inherit

	SB_WINDOW
    	rename
        	make as window_make
      	redefine
         	default_width,
         	default_height,
         	on_enter,
         	on_leave,
         	on_paint,
         	on_left_btn_press,
         	on_left_btn_release,
         	on_motion,
         	class_name
      	end
      
	SB_TOOL_BAR_GRIP_CONSTANTS

create

   make, make_opts

feature -- class name

	class_name: STRING
		once
			Result := "SB_TOOL_BAR_GRIP"
		end

feature -- Creation

   make(p:SB_TOOL_BAR; opts: INTEGER)
         -- Construct toolbar grip
      do
         make_opts(p, Void, 0, opts, 0,0, 0,0)
      end

   make_opts(p: SB_TOOL_BAR; tgt: SB_MESSAGE_HANDLER; sel: INTEGER; opts: INTEGER; x,y,w,h: INTEGER)
         -- Construct toolbar grip
      do
         window_make(p, opts, x,y, w,h)
         flags := flags | Flag_shown;
         if (options & TOOLBARGRIP_SEPARATOR) = Zero then flags := flags | Flag_enabled end
         message_target := tgt
         message := sel;
         back_color := application.base_color;
         active_color := sbrgb(0, 0, 255)
         if (options & TOOLBARGRIP_SEPARATOR) /= Zero then
            hilite_color := application.shadow_color
            shadow_color := application.hilite_color
         else
            hilite_color := application.hilite_color
            shadow_color := application.shadow_color
         end
      end

feature -- Data

   active_color: INTEGER
         -- Color when active

   hilite_color: INTEGER
         -- Highlight color

   shadow_color: INTEGER
         -- Shadow color

feature -- Queries

   default_width: INTEGER
         -- Return default width
      do
         if (options & TOOLBARGRIP_DOUBLE) /= Zero then
            Result := GRIP_DOUBLE
         else
            Result := GRIP_SINGLE
         end
      end

   default_height: INTEGER
         -- Return default height
      do
         if (options & TOOLBARGRIP_DOUBLE) /= Zero then
            Result := GRIP_DOUBLE
         else
            Result := GRIP_SINGLE
         end
      end

   is_double_bar: BOOLEAN
         -- Return True if toolbar grip is displayed as a double bar
      do
         Result := (options & TOOLBARGRIP_DOUBLE) /= Zero
      end

feature -- Actions

   set_double_bar (dbl: BOOLEAN)
         -- Change toolbar grip to double
      local
         opts: INTEGER
      do
         if dbl then
            opts := options | TOOLBARGRIP_DOUBLE
         else
            opts := options & (TOOLBARGRIP_DOUBLE).bit_not
         end
         if opts /= options then
            options := opts
            recalc
         end
      end

   set_hilite_color (clr: INTEGER)
         -- Change highlight color
      do
         if clr /= hilite_color then
            hilite_color := clr
            update
         end
      end

   set_shadow_color (clr: INTEGER)
         -- Change shadow color
      do
         if clr /= shadow_color then
            shadow_color := clr
            update
         end
      end

   set_active_color(clr: INTEGER)
         -- Set the active color
      do
         if clr /= active_color then
            active_color := clr
            update;
         end
      end

feature -- Message processing

   on_paint(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         ev: SB_EVENT;
         dc: SB_DC_WINDOW;
      do
         ev ?= data check ev /= Void end
         dc := paint_dc
         dc.make_event(Current,ev)
         dc.set_foreground(back_color)
         dc.fill_rectangle(ev.rect_x, ev.rect_y, ev.rect_w, ev.rect_h);
         if width > height then
            if (options & TOOLBARGRIP_DOUBLE) /= Zero then  -- =
               dc.set_foreground(hilite_color)
               dc.fill_rectangle(0,0,1,2)
               dc.fill_rectangle(0,4,1,2)
               dc.fill_rectangle(0,0,width-1,1)
               dc.fill_rectangle(0,4,width-1,1)
               dc.set_foreground(shadow_color)
               dc.fill_rectangle(width-1,0,1,3)
               dc.fill_rectangle(width-1,4,1,3)
               dc.fill_rectangle(0,2,width-1,1)
               dc.fill_rectangle(0,6,width-1,1)
               if (flags & Flag_active)/= Zero then
                  dc.set_foreground(active_color)
                  dc.fill_rectangle(1,1,width-2,1)
                  dc.fill_rectangle(1,5,width-2,1)
               end
            else                                          -- -
               dc.set_foreground(hilite_color)
            dc.fill_rectangle(0,0,1,2)
            dc.fill_rectangle(0,0,width-1,1)
            dc.set_foreground(shadow_color)
            dc.fill_rectangle(width-1,0,1,3)
            dc.fill_rectangle(0,2,width-1,1)
               if (flags & Flag_active) /= Zero then
                  dc.set_foreground(active_color)
                  dc.fill_rectangle(1,1,width-2,1)
               end
            end
         else
            if (options & TOOLBARGRIP_DOUBLE) /= Zero then  -- ||
               dc.set_foreground(hilite_color)
               dc.fill_rectangle(0,0,2,1)
               dc.fill_rectangle(4,0,2,1)
               dc.fill_rectangle(0,0,1,height-1)
               dc.fill_rectangle(4,0,1,height-1)
               dc.set_foreground(shadow_color);
               dc.fill_rectangle(0,height-1,3,1)
               dc.fill_rectangle(4,height-1,3,1)
               dc.fill_rectangle(2,0,1,height-1)
               dc.fill_rectangle(6,0,1,height-1)
               if (flags & Flag_active) /= Zero then
                  dc.set_foreground(active_color)
                  dc.fill_rectangle(1,1,1,height-2)
                  dc.fill_rectangle(5,1,1,height-2)
               end
            else                                             --  | 
               dc.set_foreground(hilite_color)
               dc.fill_rectangle(0,0,2,1);
               dc.fill_rectangle(0,0,1,height-1)
               dc.set_foreground(shadow_color);
               dc.fill_rectangle(0,height-1,3,1)
               dc.fill_rectangle(2,0,1,height-1)
               if (flags & Flag_active) /= Zero then
                  dc.set_foreground(active_color)
                  dc.fill_rectangle(1,1,1,height-2)
               end
            end
         end
         dc.stop
         Result := True
      end

   on_left_btn_press(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         if is_enabled then
            grab_mouse;
            flags := flags | Flag_trydrag
            unset_flags (Flag_update)
         end
         Result := True
      end

   on_left_btn_release(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         if is_enabled then
            if (flags & Flag_dodrag) /= Zero then do_handle_2 (Current, SEL_ENDDRAG, 0, data) end
            release_mouse;
            unset_flags (Flag_trydrag | Flag_dodrag)
            flags := flags | Flag_update
         end
         Result := True
      end

   on_motion(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      local
         ev: SB_EVENT;
      do
         ev ?= data check ev /= Void end
         if (flags & Flag_dodrag) /= Zero then
            do_handle_2 (Current, SEL_DRAGGED, 0, data)
            Result := True
         elseif (flags & Flag_trydrag) /= Zero and then ev.moved then
            if handle_2 (Current, SEL_BEGINDRAG, 0, data) then  flags := flags | Flag_dodrag end
            unset_flags (Flag_trydrag)
            Result := True
         end
      end

   on_enter(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         Result := Precursor(sender,selector,data)
         if is_enabled and then (flags & (Flag_dodrag | Flag_trydrag)) = Zero then
            flags := flags | Flag_active
            update;
         end
         Result := True
      end

   on_leave(sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
      do
         Result := Precursor(sender, selector, data)
         if is_enabled and then (flags & (Flag_dodrag | Flag_trydrag)) = Zero then
            unset_flags (Flag_active)
            update
         end
         Result := True
      end

feature {NONE}

   GRIP_SINGLE: INTEGER = 3
         -- Single grip for arrangable toolbars

   GRIP_DOUBLE: INTEGER = 7
         -- Double grip for dockable toolbars

end
