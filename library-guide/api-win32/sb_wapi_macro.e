expanded class SB_WAPI_MACRO

feature -- Conversion

   LOWORD (value : INTEGER) : INTEGER
         -- The LOWORD retrieves the low-order word
         -- from the given 32-bit value










      external "C inline"
      alias "(LOWORD($value))"
      end


   HIWORD (value : INTEGER) : INTEGER
         -- The HIWORD retrieves the high-order word
         -- from the given 32-bit value










      external "C inline"
      alias "(HIWORD($value))"
      end


   LOBYTE (value : INTEGER) : INTEGER
         -- The LOBYTE retrieves the low-order byte
         -- from the given 16-bit value










      external "C inline"
      alias "(LOBYTE($value))"
      end


   HIBYTE (value : INTEGER) : INTEGER
         -- The HIBYTE retrieves the high-order byte
         -- from the given 16-bit value










      external "C inline"
      alias "(HIBYTE($value))"
      end


   MAKEWORD (low, high : INTEGER) : INTEGER
         -- The MAKEWORD creates an unsigned 16-bit integer by concatenating
         -- two given unsigned character values.






      external "C inline"
      alias "(MAKEWORD($low,$high))"
      end


   MAKELONG (low, high : INTEGER) : INTEGER
         -- The MAKELONG creates an unsigned 32-bit value by concatenating
         -- two given 16-bit values.






      external "C inline"
      alias "(MAKELONG($low,$high))"
      end


   MAKEWPARAM (low, high : INTEGER) : INTEGER






      external "C inline"
      alias "(MAKEWPARAM($low,$high))"
      end


   MAKELPARAM (low, high : INTEGER) : INTEGER
         -- The MAKELPARAM creates an unsigned 32-bit value for use as an
         -- lParam parameter in a message. This function concatenates two given
         -- 16-bit values.






      external "C inline"
      alias "(MAKELPARAM($low,$high))"
      end


   RGB (red, green, blue: INTEGER) : INTEGER
         -- The RGB selects a red, green, blue (RGB) color
         -- based on the arguments supplied and the color capabilities
         -- of the output device















      external "C inline"
      alias "(RGB($red,$green,$blue))"
      end


   GetRValue (rgb_ : INTEGER) : INTEGER
         -- The `GetRValue' macro retrieves an intensity value for the red component
         -- of a 32-bit red, green, blue (RGB) value.









      external "C inline"
      alias "(GetRValue($rgb_))"
      end


   GetGValue (rgb_ : INTEGER) : INTEGER
         -- The `GetGValue' macro retrieves an intensity value for the green
         -- component of a 32-bit red, green, blue (RGB) value.









      external "C inline"
      alias "(GetGValue($rgb_))"
      end


   GetBValue (rgb_ : INTEGER) : INTEGER
         -- The `GetBValue' macro retrieves an intensity value for the blue
         -- component of a 32-bit red, green, blue (RGB) value.









      external "C inline"
      alias "(GetBValue($rgb_))"
      end


   PALETTERGB (red, green, blue: INTEGER) : INTEGER









      external "C inline"
      alias "(PALETTERGB($red,$green,$blue))"
      end


   PALETTEINDEX (i: INTEGER): INTEGER









      external "C inline"
      alias "(PALETTEINDEX($index))"
      end


   MAKEINTRESOURCE (i : INTEGER) : POINTER
         -- The MAKEINTRESOURCE converts an integer value to a resource type
         -- compatible with Win32 resource-management functions. This function
         -- is used in place of a string containing the name of the resource.









      external "C inline"
      alias "(MAKEINTRESOURCE($i))"
      end


   INT_TO_PTR (i : INTEGER) : POINTER
         -- The INT_TO_PTR converts the given INTEGER type to the POINTER type






      external "C inline"
      alias "((void*)($i))"
      end


   PTR_TO_INT (p : POINTER) : INTEGER
         -- The PTR_TO_INT converts the given POINTER type to the INTEGER type






      external "C inline"
      alias "((int)($p))"
      end


   GET_X_LPARAM (value : INTEGER) : INTEGER
         -- The The GET_X_LPARAM retrieves the signed x-coordinate 
         -- from the low word of the given 32-bit value













      external "C inline use <windowsx.h>"
      alias "(GET_X_LPARAM($value))"
      end


   GET_Y_LPARAM (value : INTEGER) : INTEGER
         -- The The GET_Y_LPARAM retrieves the signed y-coordinate 
         -- from the hi word of the given 32-bit value













      external "C inline use <windowsx.h>"
      alias "(GET_Y_LPARAM($value))"
      end


feature -- Temporary workaround for SmallEiffel implementation limitation

   ZERO: INTEGER_32 = 0

end
