-- Win32 Implementation

class SB_CURSOR

inherit

	SB_CURSOR_DEF
	
create
	make_from_stock,
	make_from_bits,
	make_from_bitmap

feature
	
	stock: ARRAY[POINTER]
      	local
         	idc: SB_WAPI_STANDARD_CURSOR_IDS
      	once
         	Result := <<
         		idc.IDC_ARROW,
         		idc.IDC_ARROW,
         		idc.IDC_IBEAM,
         		idc.IDC_WAIT,
         		idc.IDC_CROSS,
         		idc.IDC_SIZENS,
         		idc.IDC_SIZEWE,
         		idc.IDC_SIZEALL
         	>>
      	end

   create_resource
         -- Create cursor
      local
         sif: SB_WAPI_SYSTEM_INFORMATION_FUNCTIONS
         cf: SB_WAPI_CURSOR_FUNCTIONS
         sm: SB_WAPI_GETSYSTEMMETRICS_CODES
         mem: MEMORY
         d: INTEGER
      do
         if not is_attached then
            if application.initialized then
               	-- Building custom cursor
               if glyph = 0 then
                  -- Should have both source and mask
                  if source = Void or mask = Void then
                     -- todo error handling
                  else
                     -- Let's hope it's the correct size!
                     if width > 32 or else height > 32 then
                        -- todo Error handling
                     else
                        if sif.GetSystemMetrics (sm.SM_CXCURSOR) /= 32 or else
                           sif.GetSystemMetrics (sm.SM_CYCURSOR) /= 32
                         then
                           -- todo Error handling
                        else
                           mem.collection_off
                  --   fx_trace(0, <<"SB_CURSOR::create_resource KAPUT!">>)
                   			resource_id := ext_create_cursor (application.display, 
                   											width, height,
                            	                            hot_x, hot_y,
                    										source.area.base_address,
                    	                                	mask.area.base_address)
                           mem.collection_on
                        end
                     end
                  end
               else
                  -- Building stock cursor
                  if glyph > stock.upper then
                     -- todo error handling
                  else
                     resource_id := cf.LoadCursor (default_pointer, stock.item (glyph))
                  end
               end
               if not is_attached then
                  -- todo error handling
               end
            end
         end
      end

   	ext_create_cursor (hInstance: POINTER; width_, height_, hot_x_, hot_y_: INTEGER; source_, mask_: POINTER): POINTER
      	external "C"
      	alias "sb_cursor_create"
      	end

	destroy_resource
         	-- Destroy cursor
      	local
         	cf: SB_WAPI_CURSOR_FUNCTIONS
         	t: INTEGER
      	do
         	if is_attached then
            	if application.initialized then
               			-- Delete cursor
               		t := cf.DestroyCursor (resource_id)
               		resource_id := default_pointer
            	end
         	end
      	end
end