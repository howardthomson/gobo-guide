note
   description: "SB_SPINNER constants"
   author: "Eugene Melekhov <eugene_melekhov@mail.ru>"
   copyright: "Copyright (c) 2002, Eugene Melekhov and others"
   license: "Eiffel Forum Freeware License v2 (see forum.txt)"
   status: "mostly complete"

class SB_SPINNER_CONSTANTS

inherit

   SB_PACKER_CONSTANTS

feature -- Spinner Options

   SPIN_NORMAL: INTEGER = 0         	-- Normal, non-cyclic
   SPIN_CYCLIC: INTEGER = 0x00020000	-- Cyclic spinner
   SPIN_NOTEXT: INTEGER = 0x00040000	-- No text visible
   SPIN_NOMAX : INTEGER = 0x00080000	-- Spin all the way up to infinity
   SPIN_NOMIN : INTEGER = 0x00100000	-- Spin all the way down to -infinity

end
