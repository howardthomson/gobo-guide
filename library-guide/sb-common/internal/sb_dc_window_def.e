indexing
   description: "[
                Window Device Context The Window Device Context allows drawing
                into an SB_DRAWABLE, such as an on-screen window (SB_WINDOW and derivatives)
                or an off-screen image (SB_IMAGE and its derivatives). Because certain hardware
                resources are locked down, only one SB_DC_WINDOW may be locked on a
                drawable at any one time.
                ]"
   
   author:      "Eugene Melekhov <eugene_melekhov@mail.ru>"
   copyright:   "Copyright (c) 2002, Eugene Melekhov and others"
   license:     "Eiffel Forum Freeware License v2 (see forum.txt)"
   status:      "partly complete"

deferred class SB_DC_WINDOW_DEF

inherit

	SB_DC
		rename
			make as dc_make
		redefine
			ok_to_draw
		end

	SB_COMMON_MACROS
	SB_SHARED_APPLICATION

feature { ANY } -- Require clause access

   surface: SB_DRAWABLE
         -- Drawable surface
         
feature { NONE } -- Implementation

	visual: SB_VISUAL
			-- Visual of drawable

	rect_x,
	rect_y,
	rect_w,
	rect_h: INTEGER

feature -- Creation

	make_once is
		do
		end

	make (drawable: SB_DRAWABLE) is
			-- Construct for normal drawing;
			-- This sets clip rectangle to the whole drawable
		do
			dc_make (drawable.application)
			start (drawable)
			make_def
		end

	make_def is
		deferred
    	end

	make_event (drawable: SB_DRAWABLE; event: SB_EVENT) is
    		-- Construct for painting in response to expose;
         	-- This sets the clip rectangle to the exposed rectangle
      	require
         	drawable /= Void
         	event /= Void
      	do
         	dc_make (drawable.application)
         	start (drawable)
         	
			rect_x := event.rect_x
			rect_y := event.rect_y
			rect_w := event.rect_w
			rect_h := event.rect_h
			
			clip_x := event.rect_x
			clip_y := event.rect_y
			clip_w := event.rect_w
			clip_h := event.rect_h
			
         	make_event_def (drawable, event)
      	end

	make_event_def (drawable: SB_DRAWABLE; event: SB_EVENT) is
    	deferred
    	end

  	start (drawable: SB_DRAWABLE) is
         	-- Begin locks in a drawable surface
      	require
         	drawable /= Void and then drawable.is_attached
		deferred
      	end

   	stop is
         	-- End unlock the drawable surface
		deferred
    	end

	ok_to_draw: BOOLEAN is
		do
			if surface /= Void and then surface.is_attached then
				Result := True
			end
		end

end
