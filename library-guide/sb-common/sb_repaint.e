indexing

		description: "Repaint event record"

	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v1 (see forum.txt)"
	status:		"Initial stub implementation"

class SB_REPAINT

inherit
	SB_RAW_EVENT_DEF
	X_EVENT_TYPES

feature

	next: SB_REPAINT

	set_next (new_next: SB_REPAINT) is
		do
			next := new_next
		end

feature -- Processing

	process (app: SB_APPLICATION) is
		local
			ev: SB_RAW_EVENT
			ev_expose: X_EXPOSE_EVENT
		do
			ev := app.invocation.ev
			ev_expose := ev.xexpose
			
			ev.set_type (Expose)
			ev.set_window (window)
			ev_expose.set_x (rect_x)
			ev_expose.set_y (rect_y)
			ev_expose.set_width (rect_w)
			ev_expose.set_height (rect_h)
			ev_expose.set_count (0)
			
		--	fx_trace(0, <<"Processing repaint:", ev.out, ", ", ev.xexpose.x.out,"/",ev.xexpose.y.out, " ", ev.xexpose.width.out,"/",ev.xexpose.height.out>>)
			check ev_expose.width /= 0 and ev_expose.height /= 0 end
			check   ev.xexpose.x 	  = rect_x
				and ev.xexpose.y 	  = rect_y
				and ev.xexpose.width  = rect_w
				and ev.xexpose.height = rect_h
				and ev.xexpose.window = window
			end
			app.dispatch_event (ev)
		end

feature

	window: INTEGER
			-- Window ID of the dirty window

	rect_x, rect_y,
	rect_w, rect_h : INTEGER
			-- Dirty rectangle
	
	hint: INTEGER
			-- Hint for compositing

	is_synth: BOOLEAN
			-- Synthetic expose event or real one?

	set_window (win: INTEGER) is
  		do
  			window := win
  		end

  	set_xywh (x,y,w,h: INTEGER) is
  		do
  			rect_x := x
  			rect_y := y
  			rect_w := w
  			rect_h := h
  		end

  	set_hint (new_hint: INTEGER) is
  		do
  			hint := new_hint
  		end

  	set_synth (new_synth: BOOLEAN) is
  		do
  			is_synth := new_synth
  		end

  	inc_x (by: INTEGER) is
  		do
  			rect_x := rect_x + by
  		end

  	inc_y (by: INTEGER) is
  		do
  			rect_y := rect_y + by
  		end

  	inc_w (by: INTEGER) is
  		do
  			rect_w := rect_w + by
  		end

  	inc_h (by: INTEGER) is
  		do
  			rect_h := rect_h + by
  		end

end
