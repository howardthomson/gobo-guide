note
	description: "[
		SB_SETTINGS is a key-value database.  This is normally used
		as part of SB_REGISTRY, but can also be used separately in
		application that need to maintain a key-value database of
		their own.
	]"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Initial stub implementation"

class SB_SETTINGS_DEF

feature

	read_integer_entry (section, key: STRING; default_value: INTEGER): INTEGER
    	do
        	-- TODO
        	Result := default_value;
      	end
   
	read_string_entry (section, key: STRING; default_value: STRING): STRING
    	do
        	-- TODO
        	Result := default_value;
		end
   
	read_color_entry (section, key: STRING; default_value: INTEGER): INTEGER
      	do
         	-- TODO
         	Result := default_value;
      	end

   	write_integer_entry (section, key: STRING; value: INTEGER)
      	do
      	end

   	write_string_entry (section, key: STRING; value: STRING)
      	do
      	end

   	write_color_entry (section, key: STRING; value: INTEGER)
      	do
      	end

end
