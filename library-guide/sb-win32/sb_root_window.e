-- Win32 Implementation

class SB_ROOT_WINDOW

inherit

	SB_ROOT_WINDOW_DEF
		redefine
			default_width,
			default_height
		end

create

	make

feature

	create_resource_imp
      	local
         	df: SB_WAPI_DEVICE_CONTEXT_FUNCTIONS
         	dp: SB_WAPI_DEVICE_PARAMETERS
         	wf: SB_WAPI_WINDOW_FUNCTIONS
         	hdc: POINTER
         	t: INTEGER
         	c: SB_WINDOW
      	do            
            resource_id := wf.GetDesktopWindow
            hdc := df.GetDC (resource_id)
            width := df.GetDeviceCaps (hdc, dp.HORZRES)
            height := df.GetDeviceCaps (hdc, dp.VERTRES)
            t := df.ReleaseDC (resource_id, hdc)
      	end

	detach_resource_imp
		do
		end

	destroy_resource_imp
		do
		end

	default_width: INTEGER
      	local
         	df: SB_WAPI_DEVICE_CONTEXT_FUNCTIONS
         	dp: SB_WAPI_DEVICE_PARAMETERS
         	wf: SB_WAPI_WINDOW_FUNCTIONS
         	hdc: POINTER
         	t: INTEGER
      	do
            hdc := df.GetDC (wf.GetDesktopWindow)
            Result := df.GetDeviceCaps (hdc, dp.HORZRES)
            t := df.ReleaseDC (resource_id, hdc)
      	end

   	default_height: INTEGER
      	local
         	df: SB_WAPI_DEVICE_CONTEXT_FUNCTIONS
         	dp: SB_WAPI_DEVICE_PARAMETERS
         	wf: SB_WAPI_WINDOW_FUNCTIONS
         	hdc: POINTER
         	t: INTEGER
      	do
            hdc := df.GetDC (wf.GetDesktopWindow)
            Result := df.GetDeviceCaps (hdc, dp.VERTRES)
            t := df.ReleaseDC (resource_id, hdc)
      	end

end