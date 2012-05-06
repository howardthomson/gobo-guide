expanded class SB_WAPI_CLIPPING_FUNCTIONS

feature

   ExcludeClipRect (hdc: POINTER; nLeftRect, nTopRect, nRightRect, nBottomRect: INTEGER): INTEGER
         -- Creates a new clipping region that consists of the existing 
         -- clipping region minus the specified rectangle.





      external "C use <windows.h>"
      alias "ExcludeClipRect"





      end

   --ExtSelectClipRgn
      -- Combines the specified region with the current clipping region 
      --  using the specified mode. 

   --GetClipBox
      -- Retrieves the dimensions of the tightest bounding rectangle that can 
      -- be  drawn around the current visible area on the device. 
   --GetClipRgn
      -- Retrieves a handle identifying the current application-defined 
      -- clipping  region for the specified device context. 

   --GetMetaRgn
      -- Retrieves the current metaregion for the specified device context. 

   --GetRandomRgn
      -- Copies the system clipping region of a specified device 
      -- context to a specific region. 

   --IntersectClipRect
      -- Creates a new clipping region from the intersection of the current 
      -- clipping  region and the specified rectangle. 

   --OffsetClipRgn
      -- Moves the clipping region of a device context by the 
      -- specified offsets. 

   --PtVisible 
      -- Determines whether the specified point is within the clipping region 
      --  of a device context. 

   --RectVisible
      --  Determines whether any part of the specified rectangle lies 
      --  within the clipping region of a device context. 

   --SelectClipPath 
      -- Selects the current path as a clipping region for a device context, 
      -- combining the new region with any existing clipping region by 
      -- using the specified mode. 
   
   SelectClipRgn(hdc, hrgn: POINTER): INTEGER
         -- Selects a region as the current clipping region for the specified 
         --  device context. 





      external "C use <windows.h>"
      alias "SelectClipRgn"





      end

   --SetMetaRgn 
      -- Intersects the current clipping region for the specified device context 
      --  with the current metaregion and saves the combined region as 
      --  the new metaregion for the specified device context

end

