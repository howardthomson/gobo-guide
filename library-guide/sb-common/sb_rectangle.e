expanded class SB_RECTANGLE

feature

	x: INTEGER_16
	y: INTEGER_16
	w: INTEGER_16
	h: INTEGER_16

	set, set_xywh (a_x, a_y, a_w, a_h: INTEGER)
    	do
      		x := a_x.to_integer_16
			y := a_y.to_integer_16
      		w := a_w.to_integer_16
      		h := a_h.to_integer_16
      	end

   	set_x (a_x: INTEGER)
      	do	
      		x := a_x.to_integer_16
      	end

   	set_y (a_y: INTEGER)
      	do	
			y := a_y.to_integer_16
      	end

   	set_w (a_w: INTEGER)
      	do	
      		w := a_w.to_integer_16
      	end

   	set_h (a_h: INTEGER)
      	do	
      		h := a_h.to_integer_16
      	end

feature -- Union and Intersection

	intersect (p, q: like Current): like Current
			-- Intersection between rectangles
		local
			xx,yy,ww,hh: INTEGER_16
		do
			xx := p.x.max (q.x)
			ww := (p.x + p.w).min (q.x + q.w) - xx
			
			yy := p.y.max (q.y)
			hh := (p.y + p.h).min (q.y + q.h) - yy
  
  			Result.set_xywh (xx, yy, ww, hh)
  		end

end
