indexing
	description:"Base Frame"

	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

class SB_FRAME

inherit

	SB_WIDGET
    	rename
        	make as make_window,
        	make_ev as make_window_ev
    	redefine
--    		make_ev,
        	on_paint,
        	default_width,
        	default_height,
        	class_name
		end

	SB_DRAW_HELPER
		export {NONE} all
		end

create

	make, make_sb, make_opts, make_ev

feature -- class name

	class_name: STRING
		once
			Result := "SB_FRAME"
		end

feature -- Creation

	make_ev
			-- Make for Eiffel Vision
		do
			make (Void)
		end

   make (p: SB_COMPOSITE)
         -- Construct frame window
      do
         make_opts (p, Frame_normal, 0,0,0,0, Default_pad, Default_pad, Default_pad, Default_pad)
      end

	make_sb (p: SB_COMPOSITE; opts: INTEGER)
		do
			make_opts (p, opts, 0,0,0,0,	Default_pad, Default_pad, Default_pad, Default_pad)
		end

	make_opts_ev (opts: INTEGER; x,y,w,h, pl,pr,pt,pb: INTEGER)
    		-- Construct frame window
    	do
	        make_window_ev
	        flags := flags | Flag_shown   
	        back_color	 := application.base_color
	        base_color	 := application.base_color
	        hilite_color := application.hilite_color
	        shadow_color := application.shadow_color
	        border_color := application.border_color
	        pad_top := pt
	        pad_bottom := pb
	        pad_left := pl
	        pad_right := pr
	        if (options & Frame_thick) /= b0 then
	        	border := 2
	        elseif (options & (Frame_sunken | Frame_raised)) /= b0 then
	        	border := 1
	        else
	        	border := 0
	        end
		end

	make_opts (p: SB_COMPOSITE; opts: INTEGER; x,y,w,h, pl,pr,pt,pb: INTEGER)
    		-- Construct frame window
    	do
	        make_window (p, opts, x,y,w,h)
	        flags := flags | Flag_shown   
	        back_color	 := application.base_color
	        base_color	 := application.base_color
	        hilite_color := application.hilite_color
	        shadow_color := application.shadow_color
	        border_color := application.border_color
	        pad_top := pt
	        pad_bottom := pb
	        pad_left := pl
	        pad_right := pr
	        if (options & Frame_thick) /= b0 then
	        	border := 2
	        elseif (options & (Frame_sunken | Frame_raised)) /= b0 then
	        	border := 1
	        else
	        	border := 0
	        end
		end

feature -- Data

	base_color: INTEGER
			-- Color of base / background

	hilite_color: INTEGER
			-- Color of highlighted text

	shadow_color: INTEGER
			-- Color of XXX

	border_color: INTEGER
			-- Color of border pixels
	
	pad_top: INTEGER
	pad_bottom: INTEGER
	pad_left: INTEGER
	pad_right: INTEGER
	
	border: INTEGER
			-- Border width in pixels

	Default_pad: INTEGER = 2

feature -- Queries

	default_width: INTEGER
    		-- Return default width
    	do
			Result := pad_left + pad_right + (border*2)
		end

   default_height: INTEGER
         -- Return default height
      do
         Result := pad_top + pad_bottom + (border*2)
      end

   get_frame_style: INTEGER
         -- Get current frame style
      do
         Result := (options & Frame_mask)
      end

feature -- Actions

  set_frame_style (style: INTEGER)
         -- Change frame style
      local
         opts: INTEGER
         b: INTEGER
      do
         opts := new_options (style, Frame_mask)
         if options /= opts then
            if (opts & Frame_thick) /= 0 then
               b := 2
            elseif (opts & (Frame_sunken | Frame_raised)) /= 0 then
               b := 1
            else
               b := 0
            end
            options := opts
            if border /= b then
               border := b
               recalc
            end
            update
         end
      end
  
   set_pad_top (pt: INTEGER)
         -- Change top padding
      do
         if pad_top /= pt then
            pad_top := pt
            recalc
            update
         end
      end

   set_pad_bottom (pb: INTEGER)
         -- Change bottom padding
      do
         if pad_bottom /= pb then
            pad_bottom := pb
            recalc
            update
         end
      end

   set_pad_left (pl: INTEGER)
         -- Change left padding
      do
         if pad_left /= pl then
            pad_left := pl
            recalc
            update
         end
      end

   set_pad_right (pr: INTEGER)
         -- Change right padding
      do
         if pad_right /= pr then
            pad_right := pr
            recalc
            update
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

  set_border_color (clr: INTEGER)
         -- Change border color
      do
         if clr /= border_color then
            border_color := clr
            update
         end
      end

  set_base_color (clr: INTEGER)
         -- Change base gui color
      do
         if clr /= base_color then
            base_color := clr
            update
         end
      end

feature -- Message processing

	on_paint (sender: SB_MESSAGE_HANDLER; selector : INTEGER; data: ANY): BOOLEAN
		local
			ev: SB_EVENT
			dc: SB_DC_WINDOW
		do
			ev ?= data
			if ev /= Void then
				dc := paint_dc
            	dc.make_event (Current, ev)
            	dc.set_foreground (back_color)
            	dc.fill_rectangle (border, border, width - border*2, height - border*2)
            	draw_frame (dc, 0,0, width, height)
            	dc.stop
            	Result := True
         	end
		end
end
