expanded class SB_WAPI_DEVICE_PARAMETERS

feature -- Class data

   DRIVERVERSION   : INTEGER is   0; -- Device driver version
   TECHNOLOGY      : INTEGER is   2; -- Device classification
   HORZSIZE        : INTEGER is   4; -- Horizontal size in millimeters
   VERTSIZE        : INTEGER is   6; -- Vertical size in millimeters
   HORZRES         : INTEGER is   8; -- Horizontal width in pixels
   VERTRES         : INTEGER is  10; -- Vertical height in pixels
   BITSPIXEL       : INTEGER is  12; -- Number of bits per pixel
   PLANES          : INTEGER is  14; -- Number of planes
   NUMBRUSHES      : INTEGER is  16; -- Number of brushes the device has
   NUMPENS         : INTEGER is  18; -- Number of pens the device has
   NUMMARKERS      : INTEGER is  20; -- Number of markers the device has
   NUMFONTS        : INTEGER is  22; -- Number of fonts the device has
   NUMCOLORS       : INTEGER is  24; -- Number of colors the device supports
   PDEVICESIZE     : INTEGER is  26; -- Size required for device descriptor
   CURVECAPS       : INTEGER is  28; -- Curve capabilities
   LINECAPS        : INTEGER is  30; -- Line capabilities
   POLYGONALCAPS   : INTEGER is  32; -- Polygonal capabilities
   TEXTCAPS        : INTEGER is  34; -- Text capabilities
   CLIPCAPS        : INTEGER is  36; -- Clipping capabilities
   RASTERCAPS      : INTEGER is  38; -- Bitblt capabilities
   ASPECTX         : INTEGER is  40; -- Length of the X leg
   ASPECTY         : INTEGER is  42; -- Length of the Y leg
   ASPECTXY        : INTEGER is  44; -- Length of the hypotenuse

   LOGPIXELSX      : INTEGER is  88; -- Logical pixels/inch in X
   LOGPIXELSY      : INTEGER is  90; -- Logical pixels/inch in Y

   SIZEPALETTE     : INTEGER is 104; -- Number of entries in physical palette
   NUMRESERVED     : INTEGER is 106; -- Number of reserved entries in palette
   COLORRES        : INTEGER is 108; -- Actual color resolution

feature -- Printing related DeviceCaps. These replace the appropriate Escapes

   PHYSICALWIDTH   : INTEGER is 110; -- Physical Width in device units
   PHYSICALHEIGHT  : INTEGER is 111; -- Physical Height in device units
   PHYSICALOFFSETX : INTEGER is 112; -- Physical Printable Area x margin
   PHYSICALOFFSETY : INTEGER is 113; -- Physical Printable Area y margin
   SCALINGFACTORX  : INTEGER is 114; -- Scaling factor x
   SCALINGFACTORY  : INTEGER is 115; -- Scaling factor y

feature -- Display driver specific
   VREFRESH        : INTEGER is 116; -- Current vertical refresh rate of the
         -- display device (for displays only) in Hz
   DESKTOPVERTRES  : INTEGER is 117; -- Horizontal width of entire desktop in
         -- pixels
   DESKTOPHORZRES  : INTEGER is 118; -- Vertical height of entire desktop in
         -- pixels
   BLTALIGNMENT    : INTEGER is 119; -- Preferred blt alignment

end
