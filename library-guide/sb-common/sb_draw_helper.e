deferred class SB_DRAW_HELPER

inherit

	SB_WINDOW_CONSTANTS

feature

	draw_border_rectangle(dc: SB_DC_WINDOW; x, y, w, h: INTEGER) is
		do
			dc.set_foreground(border_color);
         	dc.draw_rectangle(x,y,w-1,h-1);
      	end

  	draw_raised_rectangle(dc: SB_DC_WINDOW; x, y, w, h: INTEGER) is
      	do
         	dc.set_foreground(shadow_color);
         	dc.fill_rectangle(x,y+h-1,w,1);
         	dc.fill_rectangle(x+w-1,y,1,h);
         	dc.set_foreground(hilite_color);
         	dc.fill_rectangle(x,y,w,1);
         	dc.fill_rectangle(x,y,1,h);
      	end

  	draw_sunken_rectangle(dc: SB_DC_WINDOW; x, y, w, h: INTEGER) is
      	do
         	dc.set_foreground(shadow_color);
         	dc.fill_rectangle(x,y,w,1);
         	dc.fill_rectangle(x,y,1,h);
         	dc.set_foreground(hilite_color);
         	dc.fill_rectangle(x,y+h-1,w,1);
         	dc.fill_rectangle(x+w-1,y,1,h);
      	end

  	draw_ridge_rectangle(dc: SB_DC_WINDOW; x, y, w, h: INTEGER) is
      	do
         	dc.set_foreground(hilite_color);
         	dc.fill_rectangle(x,y,w,1);
         	dc.fill_rectangle(x,y,1,h);
         	dc.fill_rectangle(x+1,y+h-2,w-2,1);
         	dc.fill_rectangle(x+w-2,y+1,1,h-2);
         	dc.set_foreground(shadow_color);
         	dc.fill_rectangle(x+1,y+1,w-3,1);
         	dc.fill_rectangle(x+1,y+1,1,h-3);
         	dc.fill_rectangle(x,y+h-1,w,1);
         	dc.fill_rectangle(x+w-1,y,1,h);
      	end

  	draw_groove_rectangle(dc: SB_DC_WINDOW; x, y, w, h: INTEGER) is
      	do
         	dc.set_foreground(shadow_color);
         	dc.fill_rectangle(x,y,w,1);
         	dc.fill_rectangle(x,y,1,h);
         	dc.fill_rectangle(x+1,y+h-2,w-2,1);
         	dc.fill_rectangle(x+w-2,y+1,1,h-2);
         	dc.set_foreground(hilite_color);
         	dc.fill_rectangle(x+1,y+1,w-3,1);
         	dc.fill_rectangle(x+1,y+1,1,h-3);
         	dc.fill_rectangle(x,y+h-1,w,1);
         	dc.fill_rectangle(x+w-1,y,1,h);
      	end

  	draw_double_raised_rectangle(dc: SB_DC_WINDOW; x, y, w, h: INTEGER) is
      	do
         	dc.set_foreground(hilite_color);
         	dc.fill_rectangle(x,y,w-1,1);
         	dc.fill_rectangle(x,y,1,h-1);
         	dc.set_foreground(base_color);
         	dc.fill_rectangle(x+1,y+1,w-2,1);
         	dc.fill_rectangle(x+1,y+1,1,h-2);
         	dc.set_foreground(shadow_color);
         	dc.fill_rectangle(x+1,y+h-2,w-2,1);
         	dc.fill_rectangle(x+w-2,y+1,1,h-1);
         	dc.set_foreground(border_color);
         	dc.fill_rectangle(x,y+h-1,w,1);
         	dc.fill_rectangle(x+w-1,y,1,h);
      	end

  	draw_double_sunken_rectangle(dc: SB_DC_WINDOW; x, y, w, h: INTEGER) is
      	do
         	dc.set_foreground(shadow_color);
         	dc.fill_rectangle(x, y, w-1, 1);		-- Top, Outer
         	dc.fill_rectangle(x, y, 1, h-1);		-- Left, Outer
         	dc.set_foreground(border_color);
         	dc.fill_rectangle(x+1, y+1, w-3, 1);	-- Top, Inner
         	dc.fill_rectangle(x+1, y+1, 1, h-3);	-- Left, Inner
         	dc.set_foreground(hilite_color);
         	dc.fill_rectangle(x,y+h-1,w,1);			-- Bottom, Outer
         	dc.fill_rectangle(x+w-1,y,1,h);			-- Right, Outer
         	dc.set_foreground(base_color);
         	dc.fill_rectangle(x+1,y+h-2,w-2,1);		-- Bottom, Inner
         	dc.fill_rectangle(x+w-2,y+1,1,h-2);		-- Right, Inner
      	end

  	draw_frame(dc: SB_DC_WINDOW; x, y, w, h: INTEGER) is
      	local
         	opts: INTEGER;
      	do
         	opts := (options & Frame_mask);
         	if opts =  Frame_line then draw_border_rectangle(dc,x,y,w,h)
         	elseif opts = Frame_sunken then draw_sunken_rectangle(dc,x,y,w,h)
         	elseif opts = Frame_raised then draw_raised_rectangle(dc,x,y,w,h)
         	elseif opts = Frame_groove then draw_groove_rectangle(dc,x,y,w,h)
         	elseif opts = Frame_ridge then draw_ridge_rectangle(dc,x,y,w,h)
         	elseif opts = (Frame_sunken | Frame_thick) then draw_double_sunken_rectangle(dc,x,y,w,h)
         	elseif opts = (Frame_raised | Frame_thick) then draw_double_raised_rectangle(dc,x,y,w,h)
         	end
      	end

feature 

	base_color	: INTEGER is deferred end;
	hilite_color: INTEGER is deferred end;
	shadow_color: INTEGER is deferred end;
	border_color: INTEGER is deferred end;
	options		: INTEGER  is deferred end;
end
