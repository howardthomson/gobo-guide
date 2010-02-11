expanded class SB_WAPI_BITMAP_FUNCTIONS

feature -- Access

   CreateBitmap(nWidth,nHeight,cPlanes, cBitsPerPel: INTEGER; lpvBits: POINTER): POINTER is
      external "C use <windows.h>"
      alias "CreateBitmap"
      end
	--------------------------------------------------------
	
   GetPixel (hdc: POINTER; XPos, nYPos: INTEGER): INTEGER is
      external "C use <windows.h>"
      alias "GetPixel"
      end
	--------------------------------------------------------------------------------
	
   StretchDIBits (hdc: POINTER;	XDest: INTEGER;	YDest: INTEGER;	nDestWidth: INTEGER;
                  nDestHeight: INTEGER;	XSrc: INTEGER; YSrc: INTEGER;
                  nSrcWidth: INTEGER; nSrcHeight: INTEGER; lpBits: POINTER;
                  lpBitsInfo: POINTER; iUsage: INTEGER;	dwRop: INTEGER): INTEGER is
      external "C use <windows.h>"
      alias "StretchDIBits"
      end
	------------------------------------------
	
   GetDIBits (hdc,hbmp: POINTER; uStartScan,cScanLines: INTEGER; lpvBits, lpbi: POINTER; uUsage: INTEGER): INTEGER is
      external "C use <windows.h>"
      alias "GetDIBits"
      end
	------------------------------------------------
	
   SetDIBits (hdc, hbmp: POINTER; uStartScan, cScanLines: INTEGER; lpvBits, lpbmi: POINTER; fuColorUse: INTEGER): INTEGER is
      external "C use <windows.h>"
      alias "SetDIBits"
      end
	-------------------------------------------------
	
   BitBlt (hDCDest: POINTER; nXDest, nYDest, nWidth, nHeight: INTEGER; hDCSrc:POINTER; nXSrc, nYSrc, dwRop: INTEGER): INTEGER is
      external "C use <windows.h>"
      alias "BitBlt"
      end
	------------------------------------------------
	
   PatBlt(hDC: POINTER; nXLeft, nYLeft, nWidth, nHeight, dwRop: INTEGER): INTEGER is
      external "C use <windows.h>"
      alias "PatBlt"
      end
	-----------------------------------------------
	
   SetPixel (hdc: POINTER; x, y, crColor: INTEGER): INTEGER is
      external "C use <windows.h>"
      alias "SetPixel"
      end
	-------------------------------------------------
	
   CreateCompatibleBitmap (hDC: POINTER; w, h: INTEGER): POINTER is
      external "C use <windows.h>"
      alias "CreateCompatibleBitmap"
      end

   LoadBitmap (hInstance: POINTER; lpBitmapName: POINTER): POINTER is
      external "C use <windows.h>"
      alias "LoadBitmapA"
      end

end
