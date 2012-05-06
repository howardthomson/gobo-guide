class X_KEYMAP_EVENT
  -- Interface to Xlib's XKeymapEvent structure

inherit

	X_ANY_EVENT

create {NONE}

	make

create { X_EVENT }

	from_x_struct

feature -- Access

--	key_vector : C_VECTOR [C_BYTE] is
--		local
--			cb : C_BYTE
--		do
--			create cb.make
--			create Result.from_external (c_key_vector (to_external), 32, cb)
--		ensure
--			Result.count = 32
--		end

feature -- Modification

--	set_key_vector (v : C_VECTOR [C_BYTE]) is
--		require
--			v /= Void
--			v.count = 32
--		do
--			c_set_key_vector (to_external, v.to_external)
--		end

feature { NONE } -- External functions

--	c_key_vector	(p: POINTER): POINTER 	 is	external "C struct XKeymapEvent access key_vector type ??? use <X11/Xlib.h>" end
--	c_set_key_vector(p: POINTER; i: POINTER) is external "C struct XKeymapEvent access key_vector type ??? use <X11/Xlib.h>"	end

end
