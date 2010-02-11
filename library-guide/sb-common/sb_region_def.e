indexing
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

	make_empty is
         	-- Construct new empty region
		deferred
		end

   	make(x, y, w, h: INTEGER) is
         	-- Construct rectangle region
		deferred
		end

   	make_from_region(r: SB_REGION) is
         	-- Construct new region copied from region r
		deferred
		end

   	make_from_points(points: ARRAY[SB_POINT]; winding_: BOOLEAN) is
         	-- Construct polygon region
      	require
         	points /= Void and then not points.is_empty
		deferred
		end
		
feature -- Queries

   	is_empty: BOOLEAN is
         	-- Return TRUE if region is empty
		deferred
		end

   	contains_point(x, y: INTEGER): BOOLEAN is
         	-- Return TRUE if region contains point
		deferred
      	end

   	contains_rectangle(x, y, w, h: INTEGER): BOOLEAN is
         	-- Return TRUE if region contains rectangle
		deferred
		end

   	bounds(r: SB_RECTANGLE) is
         	-- sets r to bounding box
      	require
--        	r /= Void	-- SB_RECTANGLE is expanded!?
		deferred
      	end

   	is_equal (r: like Current): BOOLEAN is
		deferred
      	end

feature -- Actions

   	offset(dx, dy: INTEGER) is
         	-- Offset region by dx,dy
		deferred
      	end

   	union(r: SB_REGION) is
    		-- Union region r with this one
      	require
         	r /= Void
		deferred
      	end

   	intersect(r: SB_REGION) is
         	-- Intersect region r with this one
      	require
         	r /= Void
		deferred
      	end

   	subtract(r: SB_REGION) is
         	-- Subtract region r from this one
      	require
         	r /= Void
		deferred
      	end

   	do_xor(r: SB_REGION) is
         	-- Xor region r with this one
      	require
         	r /= Void
		deferred
      	end

   	infix "+" (other: like Current): like Current is
         	-- Union of Current  and other
      	require
         	other /= Void
		deferred
      	end

   	infix "*" (other: like Current): like Current is
         	-- Intersection of Current  and other
      	require
         	other /= Void
		deferred
    	end

	infix "-" (other: like Current): like Current is
         	-- Substract other from Current
      	require
        	other /= Void
		deferred
		end

	infix "^" (other: like Current): like Current is
        	-- Xor of Current and other
		require
			other /= Void
		deferred
		end


feature { SB_DC, SB_REGION } -- Implementation

   region: POINTER;

end
