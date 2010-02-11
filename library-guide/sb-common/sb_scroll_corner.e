indexing
	description:"Corner between scroll bars"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

class SB_SCROLL_CORNER

inherit

	SB_WINDOW
    	rename
			make as window_make
		redefine
			enable,
			disable,
			on_paint,
			class_name
		end

creation
	make

feature -- class name

	class_name: STRING is
		once
			Result := "SB_SCROLL_CORNER"
		end

feature -- Creation

	make (p: SB_COMPOSITE) is
		do
			window_make (p, Zero, 0,0, 0,0)
			back_color := application.base_color
			flags := flags | Flag_enabled | Flag_shown
		end

feature -- Actions

   	enable is
         	-- Can not be enabled
      	do
      	end

   	disable is
         	-- Can not be disabled
      	do
      	end

feature -- Message processing

   	on_paint (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN is
      	local
         	ev: SB_EVENT
         	dc: SB_DC_WINDOW
         	pt: SB_POINT
      	do
         	ev ?= data
         	check
            	ev /= Void
         	end
         	dc := paint_dc
         	dc.make_event (Current, ev)
         	dc.set_foreground (back_color)
         	dc.fill_rectangle (ev.rect_x, ev.rect_y, ev.rect_w, ev.rect_h)
         	dc.stop
         	Result := True
      	end
end
