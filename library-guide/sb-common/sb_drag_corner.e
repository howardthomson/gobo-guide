indexing
	description: "[
		A drag corner widget may be placed in the bottom
		right corner so as to allow the window to be resized more easily.
	]"

	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

class SB_DRAG_CORNER

inherit

   SB_WINDOW
      rename
         make as window_make
      redefine
         default_width,
         default_height,
         on_paint,
         on_left_btn_press,
         on_left_btn_release,
         on_motion,
         class_name
      end

creation

   make

feature -- class name

	class_name: STRING is
		once
			Result := "SB_DRAG_CORNER"
		end

feature -- Creation

   make (p: SB_COMPOSITE) is
      do
         window_make(p, Layout_right | Layout_bottom, 0,0,0,0)
         flags := flags | Flag_enabled | Flag_shown
         default_cursor := application.default_cursor (Def_dragbr_cursor)
         drag_cursor := application.default_cursor (Def_dragbr_cursor)
         back_color := application.base_color
         hilite_color := application.hilite_color
         shadow_color := application.shadow_color
         oldw := 0
         oldh := 0
         xoff := 0
         yoff := 0
      end

feature -- Data

   hilite_color: INTEGER
   shadow_color: INTEGER

feature {NONE} -- Implementation

   oldw: INTEGER
   oldh: INTEGER
   xoff: INTEGER
   yoff: INTEGER

feature -- Message processing

   on_paint (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      local
         ev: SB_EVENT;
         dc: SB_DC_WINDOW;
         pt: SB_POINT;
      do
         ev ?= data
         check
            ev /= Void
         end
         dc := paint_dc
         dc.make_event (Current, ev)
         dc.set_foreground (back_color)
         dc.fill_rectangle (ev.rect_x, ev.rect_y, ev.rect_w, ev.rect_h)
         dc.set_foreground (shadow_color)
         dc.draw_line (width - 2, height - 1, width, height - 3)
         dc.draw_line (width - 8, height - 1, width, height - 9)
         dc.draw_line (width - 14, height - 1, width, height - 15)
         dc.set_foreground (hilite_color)
         dc.draw_line (width - 5, height - 1, width, height - 6)
         dc.draw_line (width - 11, height - 1, width, height - 12)
         dc.draw_line (width - 17, height - 1, width, height - 18)
         dc.stop
         Result := True
      end

   on_left_btn_press (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      local
         event: SB_EVENT
         dc: SB_DC_WINDOW
         pt: SB_POINT
      do
         event ?= data
         check
            event /= Void
         end
         dc := paint_dc
         dc.make (get_root)
         grab_mouse
         xoff := width - event.win_x
         yoff := height - event.win_y
         oldw := width
         oldh := height
         dc.clip_children (False)
         dc.set_function (dc.Blt_src_xor_dst)
         dc.set_foreground (sbrgb (255,255,255))
         pt := get_shell.translate_coordinates_to(get_root, 0,0)
         dc.draw_rectangle (pt.x, pt.y, oldw, oldh)
         flags := flags | Flag_pressed
         dc.stop
         Result := True
      end

   on_left_btn_release (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      local
         event: SB_EVENT
         dc: SB_DC_WINDOW
         pt,ptw: SB_POINT
      do
         event ?= data
         check
            event /= Void
         end
         dc := paint_dc
         dc.make(get_root)
         release_mouse
         pt := get_shell.translate_coordinates_to (get_root, 0, 0)
         ptw := translate_coordinates_to (get_shell, event.win_x, event.win_y)
         dc.clip_children (False)
         dc.set_function (dc.Blt_src_xor_dst)
         dc.set_foreground (sbrgb (255,255,255))
         dc.draw_rectangle (pt.x, pt.y, oldw, oldh)
         get_shell.resize (xoff + ptw.x, yoff + ptw.y)
         unset_flags (Flag_pressed)
         dc.stop
         Result := True
      end

   on_motion (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      local
         event: SB_EVENT
         dc: SB_DC_WINDOW
         pt,ptw: SB_POINT
      do
         event ?= data
         check
            event /= Void
         end
         if (flags & Flag_pressed) /= Zero then
         	dc := paint_dc
            dc.make (get_root)
            pt := get_shell.translate_coordinates_to (get_root, 0,0)
            ptw := translate_coordinates_to (get_shell, event.win_x, event.win_y)
            dc.clip_children (False)
            dc.set_function (dc.Blt_src_xor_dst)
            dc.set_foreground (sbrgb (255, 255, 255))
            dc.draw_rectangle (pt.x, pt.y, oldw, oldh)
            oldw := xoff + ptw.x
            oldh := yoff + ptw.y
            dc.draw_rectangle (pt.x, pt.y, oldw, oldh)
            dc.stop
            Result := True
         end
      end

feature -- Queries

   default_width: INTEGER is
         -- Get default width
      do
         Result := CORNERSIZE
      end
      
   default_height: INTEGER is
         -- Get default height
      do
         Result := CORNERSIZE
      end

feature -- Actions

   set_hilite_color (clr: INTEGER) is
         -- Change highlight color
      do
         if hilite_color /= clr then
            hilite_color := clr
            update
         end
      end

      set_shadow_color (clr: INTEGER) is
         -- Change shadow color
      do
         if shadow_color /= clr then
            shadow_color := clr
            update
         end
      end

feature {NONE} -- Implementation

   CORNERSIZE: INTEGER is 17

end
