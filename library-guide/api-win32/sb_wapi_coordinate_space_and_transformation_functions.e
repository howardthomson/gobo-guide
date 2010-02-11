expanded class SB_WAPI_COORDINATE_SPACE_AND_TRANSFORMATION_FUNCTIONS

feature -- Access

   ClientToScreen (hWnd: POINTER; lppt: POINTER): INTEGER is





      external "C use <windows.h>"
      alias "ClientToScreen"





      end
	---------------------------------
	
   DPtoLP (hDC: POINTER; lpPoints: POINTER; nCount: INTEGER): INTEGER is





      external "C use <windows.h>"
      alias "DPtoLP"





      end
	---------------------------------

   GetMapMode (hDC: POINTER): INTEGER is





      external "C use <windows.h>"
      alias "GetMapMode"





      end
	---------------------------------

   GetViewportOrgEx (hDC: POINTER; lpPoint: POINTER): INTEGER is





      external "C use <windows.h>"
      alias "GetViewportOrgEx"





      end
	---------------------------------

   GetWindowOrgEx (hDC: POINTER; lpPoint: POINTER): INTEGER is





      external "C use <windows.h>"
      alias "GetWindowOrgEx"





      end
	---------------------------------

   GetWorldTransform (hDC: POINTER; lpXform: POINTER): INTEGER is





      external "C use <windows.h>"
      alias "GetWorldTransform"





      end
	---------------------------------

   LPtoDP (hDC: POINTER; lpPoints: POINTER; nCount: INTEGER): INTEGER is





      external "C use <windows.h>"
      alias "LPtoDP"





      end
	---------------------------------

   ModifyWorldTransform (hDC: POINTER; lpXform: POINTER; iMode: INTEGER): INTEGER is





      external "C use <windows.h>"
      alias "ModifyWorldTransform"





      end
	---------------------------------

   ScreenToClient (hWnd: POINTER; lpPoint: POINTER): INTEGER is





      external "C use <windows.h>"
      alias "ScreenToClient"





      end
	---------------------------------

   SetMapMode (hDC: POINTER; fnMapMode: INTEGER): INTEGER is





      external "C use <windows.h>"
      alias "SetMapMode"





      end
	---------------------------------

   SetViewportExtEx (hDC: POINTER; nXExtent, nYExtent: INTEGER; lpSize: POINTER): INTEGER is





      external "C use <windows.h>"
      alias "SetViewportExtEx"





      end
	---------------------------------

   SetViewportOrgEx (hDC: POINTER; X, Y: INTEGER; lpPoint: POINTER): INTEGER is





      external "C use <windows.h>"
      alias "SetViewportOrgEx"





      end
	---------------------------------

   SetWindowExtEx (hDC: POINTER; nXExtent, nYExtent: INTEGER; lpSize: POINTER): INTEGER is





      external "C use <windows.h>"
      alias "SetWindowExtEx"





      end
	---------------------------------

   SetWindowOrgEx (hDC: POINTER; X, Y: INTEGER; lpPoint: POINTER): INTEGER is





      external "C use <windows.h>"
      alias "SetWindowOrgEx"





      end
	---------------------------------

   SetWorldTransform (hDC: POINTER; lpXform: POINTER): INTEGER is





      external "C use <windows.h>"
      alias "SetWorldTransform"





      end
	---------------------------------

end
