-- X Window System Implementation

indexing
	description: "[
			Implementation of the
			REGION concept of a drawable area
	]"
	author:	"Howard Thomson"
	platform: "X Window System"
	todo: "[
			Implement currently copied deferred routines
	]"

class SB_REGION

inherit
	SB_REGION_DEF
		undefine
	--		is_equal
		end

	X11_EXTERNAL_ROUTINES
		undefine
			is_equal
		end
	
feature { SB_DC, SB_REGION } -- Implementation attributes

--	region: POINTER;

feature {NONE} -- Creation

	make_empty is
         	-- Construct new empty region
		do
	--		region := XCreateRegion
		end

   	make(x, y, w, h: INTEGER) is
         	-- Construct rectangle region
		local
		--	r: expanded X_RECTANGLE
		do
		--	XRectangle r;
		--	r.x=x; r.y=y; r.width=w; r.height=h;
		--	region := XCreateRegion
		--	XUnionRectWithRegion(&r,(Region)region,(Region)region);
		end

   	make_from_region(r: SB_REGION) is
         	-- Construct new region copied from region r
		do
		--	region := XCreateRegion
  		--	XUnionRegion(r.region, region, region)
		end

   	make_from_points(points: ARRAY [ SB_POINT ]; winding_: BOOLEAN) is
         	-- Construct polygon region
      	require else
         	points /= Void and then not points.is_empty
		do
		ensure then
			implemented: false
		end
		
feature -- Queries

   	is_empty: BOOLEAN is
         	-- Return TRUE if region is empty
		do
		ensure then
			implemented: false
		end

   	contains_point(x, y: INTEGER): BOOLEAN is
         	-- Return TRUE if region contains point
		do
		ensure then
			implemented: false
      	end

   	contains_rectangle(x, y, w, h: INTEGER): BOOLEAN is
         	-- Return TRUE if region contains rectangle
		do
		ensure then
			implemented: false
		end

   	bounds(r: SB_RECTANGLE) is
         	-- sets r to bounding box
    -- 	require else
    --    	r /= Void
		do
		ensure then
			implemented: false
      	end

   	is_equal (r: like Current): BOOLEAN is
   			-- Compare for equality
   		do
	--		Result := XEqualRegion(region, r.region)
      	end

feature -- Actions

   	offset(dx, dy: INTEGER) is
         	-- Offset region by dx,dy
		do
      	end

	union(r: SB_REGION) is
			-- Union region r with this one
	--	require else
	--		r /= Void
		do
		end

   	intersect(r: SB_REGION) is
         	-- Intersect region r with this one
    -- 	require
    --     	r /= Void
		do
      	end

   	subtract(r: SB_REGION) is
         	-- Subtract region r from this one
    --	require
    --		r /= Void
		do
      	end

   	do_xor(r: SB_REGION) is
         	-- Xor region r with this one
    -- 	require
    --     	r /= Void
		do
      	end

   	infix "+" (other: like Current): like Current is
         	-- Union of Current  and other
    -- 	require
    --     	other /= Void
		do
      	end

   	infix "*" (other: like Current): like Current is
         	-- Intersection of Current  and other
    -- 	require
    --     	other /= Void
		do
    	end

	infix "-" (other: like Current): like Current is
         	-- Substract other from Current
    -- 	require
    --		other /= Void
		do
		end

	infix "^" (other: like Current): like Current is
        	-- Xor of Current and other
	--	require
	--		other /= Void
		do
		end


end
