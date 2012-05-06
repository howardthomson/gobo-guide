note
   description: "Region"
   author: "Eugene Melekhov <eugene_melekhov@mail.ru>"
   copyright: "Copyright (c) 2002, Eugene Melekhov and others"
   license: "Eiffel Forum Freeware License v2 (see forum.txt)"
   status: "Mostly complete"

class SB_REGION

inherit

   MEMORY
      redefine
         dispose,
         is_equal
      end

--	GENERAL
--		redefine
--			is_equal
--		end

   SB_WAPI_REGION_FUNCTIONS
      export {NONE} all
      redefine
         is_equal
      end

   SB_WAPI_COMBINE_RGN_STYLES
      export {NONE} all
      redefine
         is_equal
      end

   SB_WAPI_POLYGON_FILLING_MODES
      export {NONE} all
      redefine
         is_equal
      end

create

   make_empty, make, make_from_region, make_from_points

feature -- Creation

   make_empty
         -- Construct new empty region
      do
         region := CreateRectRgn(0,0,0,0);
      end

   make(x, y, w, h: INTEGER)
         -- Construct rectangle region
      do
         region := CreateRectRgn(x,y,x+w,y+h);
      end

   make_from_region(r: SB_REGION)
         -- Construct new region copied from region r
      local
         t: INTEGER;
      do
         if region = default_pointer then
            region := CreateRectRgn(0,0,0,0);
         end
         t := CombineRgn(region,r.region,region,RGN_COPY);
      end

   make_from_points(points: ARRAY[SB_POINT]; winding_: BOOLEAN)
         -- Construct polygon region
      require
         points /= Void and then not points.is_empty
      local
         i,e,t: INTEGER;
         p: SB_WAPI_POINT;
         a: ARRAY [ SB_WAPI_POINT ];
         wapi_dcf: SB_WAPI_DEVICE_CONTEXT_FUNCTIONS;
      do
         from 
            create a.make(1,0)
            i := points.lower;
            e := points.upper
         until
            i > e
         loop
            p.set(points.item(i).x, points.item(i).y);
            a.force(p,a.count+1);
            i := i + 1;
         end
         if region /= default_pointer then
             t := wapi_dcf.DeleteObject(region);
         end
         collection_off
         if winding_ then
            region := CreatePolygonRgn(a.to_external, a.count, WINDING);
         else
            region := CreatePolygonRgn(a.to_external, a.count, ALTERNATE);
         end
         collection_on
      end

feature -- Queries

   is_empty: BOOLEAN
         -- Return TRUE if region is empty
      do
         Result := OffsetRgn(region, 0, 0) = NULLREGION;
      end

   contains_point(x, y: INTEGER): BOOLEAN
         -- Return TRUE if region contains point
      do
         Result := region /= default_pointer and then PtInRegion(region, x, y) /= 0;
      end

   contains_rectangle(x, y, w, h: INTEGER): BOOLEAN
         -- Return TRUE if region contains rectangle
      local
         rect: SB_WAPI_RECT;
      do
         rect.set_left(x);
         rect.set_top(y);
         rect.set_right(x + w);
         rect.set_bottom(y + h);
         Result := region /= default_pointer and then RectInRegion(region, rect.ptr) /= 0;
      end

	bounds(r: SB_RECTANGLE)
    		-- sets r to bounding box
    	require
		--	r /= Void
      	local
         	rect: SB_WAPI_RECT;
         	t: INTEGER
      	do
         	t := GetRgnBox(region, rect.ptr);
         	r.set_x(rect.left);
         	r.set_y(rect.top);
         	r.set_w(rect.right - rect.left);
         	r.set_h(rect.bottom - rect.top);
      	end

   is_equal (r: like Current): BOOLEAN
      do
         if r /= Void then
            Result := EqualRgn(region, r.region) /= 0;
         end
      end

feature -- Actions

   offset(dx, dy: INTEGER)
         -- Offset region by dx,dy
      local
         t: INTEGER;
      do
         t := OffsetRgn(region,dx,dy);
      end

   union(r: SB_REGION)
         -- Union region r with this one
      require
         r /= Void
      local
         t: INTEGER;
      do
         t := CombineRgn(region, region, r.region, RGN_OR);
      end

   intersect(r: SB_REGION)
         -- Intersect region r with this one
      require
         r /= Void
      local
         t: INTEGER;
      do
         t := CombineRgn(region, region, r.region, RGN_AND);
      end

   substract(r: SB_REGION)
         -- Substract region r from this one
      require
         r /= Void
      local
         t: INTEGER;
      do
         t := CombineRgn(region, region, r.region, RGN_DIFF);
      end

   do_xor(r: SB_REGION)
         -- Xor region r with this one
      require
         r /= Void
      local
         t: INTEGER
      do
         t := CombineRgn(region, region, r.region, RGN_XOR);
      end

   infix "+" (other: like Current): like Current
         -- Union of Current  and other
      require
         other /= Void
      local
         t: INTEGER
      do 
         create Result.make_empty;
         t := CombineRgn(Result.region, region, other.region, RGN_OR);
      end

   infix "*" (other: like Current): like Current
         -- Intersection of Current  and other
      require
         other /= Void
      local
         t: INTEGER
      do 
         create Result.make_empty;
         t := CombineRgn(Result.region, region, other.region, RGN_AND);
      end

   infix "-" (other: like Current): like Current
         -- Substract other from Current
      require
         other /= Void
      local
         t: INTEGER;
      do 
         create Result.make_empty;
         t := CombineRgn(Result.region, region, other.region, RGN_DIFF);
      end

   infix "^" (other: like Current): like Current
         -- Xor of Current and other
      require
         other /= Void
      local
         t: INTEGER;
      do 
         create Result.make_empty;
         t := CombineRgn(Result.region, region, other.region, RGN_XOR);
      end

feature -- 

   dispose
         -- Destroy region
      local
         t: INTEGER;
         wapi_dcf: SB_WAPI_DEVICE_CONTEXT_FUNCTIONS;
      do
         if region /= default_pointer then
             t := wapi_dcf.DeleteObject(region);
             region := default_pointer;
         end
      end

feature {SB_DC, SB_REGION} -- Implementation

   region: POINTER;

end
