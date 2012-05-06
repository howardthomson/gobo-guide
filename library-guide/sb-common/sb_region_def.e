note
	description: "[
			Ancestor class to Win32 and Xwin implementations of the
			REGION concept of a drawable area
			]"
	author:	"Howard Thomson"
	
deferred class SB_REGION_DEF

inherit
	ANY
		undefine
			is_equal
		end

feature {NONE} -- Creation

	make_empty
         	-- Construct new empty region
		deferred
		end

   	make(x, y, w, h: INTEGER)
         	-- Construct rectangle region
		deferred
		end

   	make_from_region(r: SB_REGION)
         	-- Construct new region copied from region r
		deferred
		end

   	make_from_points(points: ARRAY[SB_POINT]; winding_: BOOLEAN)
         	-- Construct polygon region
      	require
         	points /= Void and then not points.is_empty
		deferred
		end
		
feature -- Queries

   	is_empty: BOOLEAN
         	-- Return TRUE if region is empty
		deferred
		end

   	contains_point(x, y: INTEGER): BOOLEAN
         	-- Return TRUE if region contains point
		deferred
      	end

   	contains_rectangle(x, y, w, h: INTEGER): BOOLEAN
         	-- Return TRUE if region contains rectangle
		deferred
		end

   	bounds(r: SB_RECTANGLE)
         	-- sets r to bounding box
      	require
--        	r /= Void	-- SB_RECTANGLE is expanded!?
		deferred
      	end

   	is_equal (r: like Current): BOOLEAN
		deferred
      	end

feature -- Actions

   	offset(dx, dy: INTEGER)
         	-- Offset region by dx,dy
		deferred
      	end

   	union(r: SB_REGION)
    		-- Union region r with this one
      	require
         	r /= Void
		deferred
      	end

   	intersect(r: SB_REGION)
         	-- Intersect region r with this one
      	require
         	r /= Void
		deferred
      	end

   	subtract(r: SB_REGION)
         	-- Subtract region r from this one
      	require
         	r /= Void
		deferred
      	end

   	do_xor(r: SB_REGION)
         	-- Xor region r with this one
      	require
         	r /= Void
		deferred
      	end

   	infix "+" (other: like Current): like Current
         	-- Union of Current  and other
      	require
         	other /= Void
		deferred
      	end

   	infix "*" (other: like Current): like Current
         	-- Intersection of Current  and other
      	require
         	other /= Void
		deferred
    	end

	infix "-" (other: like Current): like Current
         	-- Substract other from Current
      	require
        	other /= Void
		deferred
		end

	infix "^" (other: like Current): like Current
        	-- Xor of Current and other
		require
			other /= Void
		deferred
		end


feature { SB_DC, SB_REGION } -- Implementation

   region: POINTER;

end
