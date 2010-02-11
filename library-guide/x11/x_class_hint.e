indexing

	author: "Stephane Hillion"
	copyright: "Copyright (c) 1998-2006, Stephane Hillion and Howard Thomson"
	license: "GNU Public License (see COPYING)"

	TODO: "[
		Check/modify to_external for STRING to pass null terminated
		character sequence to C routine. OK for SmartEiffel

		Use MEMORY and 'dispose' to avoid memory leaks

		Check for 'gec' bug:
			c_set_res_name  (p: POINTER; v: POINTER) is	external "C struct XClassHint access res_name  type char* use <X11/Xutil.h>" end
		does not result in <X11/Xutil.h> being #included
	]"

class X_CLASS_HINT
  -- This class is an interface to Xlib's XClassHint.

inherit 

	X_STRUCT
	
creation 

	make

creation { X_WINDOW }

	from_x_struct

feature -- GC Debug

	class_name: STRING is
		do
			Result := once "X_CLASS_HINT"
		end

feature -- Access

	res_name: STRING is
			-- returns the application name.
		require
			to_external /= default_pointer
		local
			p: POINTER
		do
			p := c_res_name (to_external)
			if p /= default_pointer then
				create Result.make_from_c (p)
			end
		end

	res_class: STRING is
			-- returns the application class.
		require
			to_external /= default_pointer
		local
			ptr : POINTER
		do
			ptr := c_res_class (to_external)
			if ptr /= default_pointer then
				create Result.make_from_c (ptr)
			end
		end

feature -- Modification

	set_res_name (val: STRING) is
			-- sets the 'res_name' attribute.
		require
			val /= Void
			to_external /= default_pointer
		do
--			set_pointer(Base_name, val.area.item_address (0)) -- NUL terminated for 'C' ??
			c_set_res_name (to_external, val.area.item_address (0)) -- NUL terminated for 'C' ??
		ensure
--			res_name.is_equal (val)
		end

	set_res_class (val: STRING) is
			-- sets the 'res_class' attribute.
		require
			val /= Void
			to_external /= default_pointer
		do
--			set_pointer(Base_class, val.area.item_address (0)) -- NUL terminated for 'C' ??
			c_set_res_class (to_external, val.area.item_address (0)) -- NUL terminated for 'C' ??
		ensure
--			res_class.is_equal (val)
		end

feature { NONE }

	size: INTEGER is
		external
			"C macro use <X11/Xutil.h>"
		alias
			"sizeof(XClassHint)"
		end

	c_res_name  (p: POINTER): POINTER is	external "C struct XClassHint access res_name 	  use <X11/Xutil.h>"     end
	c_res_class (p: POINTER): POINTER is	external "C struct XClassHint access res_class 	  use <X11/Xutil.h>"     end

	c_set_res_name  (p: POINTER; v: POINTER) is	external "C struct XClassHint access res_name  type char* use <X11/Xutil.h>"     end
	c_set_res_class (p: POINTER; v: POINTER) is	external "C struct XClassHint access res_class type char* use <X11/Xutil.h>"     end

end 
