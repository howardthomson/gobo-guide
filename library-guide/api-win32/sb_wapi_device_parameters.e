expanded class SB_WAPI_DEVICE_PARAMETERS

feature -- Class data

   DRIVERVERSION   : INTEGER =   0; -- Device driver version
   TECHNOLOGY      : INTEGER =   2; -- Device classification
   HORZSIZE        : INTEGER =   4; -- Horizontal size in millimeters
   VERTSIZE        : INTEGER =   6; -- Vertical size in millimeters
   HORZRES         : INTEGER =   8; -- Horizontal width in pixels
   VERTRES         : INTEGER =  10; -- Vertical height in pixels
   BITSPIXEL       : INTEGER =  12; -- Number of bits per pixel
   PLANES          : INTEGER =  14; -- Number of planes
   NUMBRUSHES      : INTEGER =  16; -- Number of brushes the device has
   NUMPENS         : INTEGER =  18; -- Number of pens the device has
   NUMMARKERS      : INTEGER =  20; -- Number of markers the device has
   NUMFONTS        : INTEGER =  22; -- Number of fonts the device has
   NUMCOLORS       : INTEGER =  24; -- Number of colors the device supports
   PDEVICESIZE     : INTEGER =  26; -- Size required for device descriptor
   CURVECAPS       : INTEGER =  28; -- Curve capabilities
   LINECAPS        : INTEGER =  30; -- Line capabilities
   POLYGONALCAPS   : INTEGER =  32; -- Polygonal capabilities
   TEXTCAPS        : INTEGER =  34; -- Text capabilities
   CLIPCAPS        : INTEGER =  36; -- Clipping capabilities
   RASTERCAPS      : INTEGER =  38; -- Bitblt capabilities
   ASPECTX         : INTEGER =  40; -- Length of the X leg
   ASPECTY         : INTEGER =  42; -- Length of the Y leg
   ASPECTXY        : INTEGER =  44; -- Length of the hypotenuse

   LOGPIXELSX      : INTEGER =  88; -- Logical pixels/inch in X
   LOGPIXELSY      : INTEGER =  90; -- Logical pixels/inch in Y

   SIZEPALETTE     : INTEGER = 104; -- Number of entries in physical palette
   NUMRESERVED     : INTEGER = 106; -- Number of reserved entries in palette
   COLORRES        : INTEGER = 108; -- Actual color resolution

feature -- Printing related DeviceCaps. These replace the appropriate Escapes

   PHYSICALWIDTH   : INTEGER = 110; -- Physical Width in device units
   PHYSICALHEIGHT  : INTEGER = 111; -- Physical Height in device units
   PHYSICALOFFSETX : INTEGER = 112; -- Physical Printable Area x margin
   PHYSICALOFFSETY : INTEGER = 113; -- Physical Printable Area y margin
   SCALINGFACTORX  : INTEGER = 114; -- Scaling factor x
   SCALINGFACTORY  : INTEGER = 115; -- Scaling factor y

feature -- Display driver specific
   VREFRESH        : INTEGER = 116; -- Current vertical refresh rate of the
         -- display device (for displays only) in Hz
   DESKTOPVERTRES  : INTEGER = 117; -- Horizontal width of entire desktop in
         -- pixels
   DESKTOPHORZRES  : INTEGER = 118; -- Vertical height of entire desktop in
         -- pixels
   BLTALIGNMENT    : INTEGER = 119; -- Preferred blt alignment

end
