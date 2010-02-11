indexing
	description:"Objects that have a peer on the C side"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

class SB_EXTERNAL_OBJECT

creation

   from_external

feature -- creation

   from_external (external_object : POINTER) is
--      require
--         not_null : external_object /= default_pointer
      do
         object_ptr := external_object
      ensure
         connected : to_external = external_object
      end

feature -- operations

   to_external : POINTER is
      do
         Result := object_ptr
      end

feature {NONE} -- implementations

   object_ptr: POINTER

end
