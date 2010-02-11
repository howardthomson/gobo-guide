indexing
	description:"Base class for message handler/sender"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

class SB_MESSAGE_COMMON

feature {NONE} -- Constants for handle... dispatch handling

   minkey, mintype: INTEGER is 0
   maxkey, maxtype: INTEGER is 65535

feature {NONE} -- Matching routines for handle... dispatch

	match_type_2 (type, sel_type, sel_id: INTEGER): BOOLEAN is
   			-- Match the SEL type code, ignore ID
    	do
        	Result := type = sel_type
      	end

	match_types_2 (typelow, typehi, sel_type, sel_id: INTEGER): BOOLEAN is
			-- Match range of SEL type codes, ignore ID
    	do
    		Result := sel_type >= typelow and then sel_type <= typehi
    	end

	match_function_2 (type, func, sel_type, sel_id: INTEGER): BOOLEAN is
			-- Match SEL type and function ID
    	do
        	Result := type = sel_type and then func = sel_id
      	end

	match_functions_2 (type, funclow, funchi, sel_type, sel_id: INTEGER): BOOLEAN is
			-- Match SEL type and range of IDs
		do
			Result := type = sel_type and then (sel_id >= funclow and sel_id <= funchi)
		end

feature -- 

	mksel (type, id: INTEGER): INTEGER is
		do
			Result := (type * 65536) + id;
		end

	selid (s: INTEGER): INTEGER is
			-- Get ID from selector
		do
			Result := s & 0x0000ffff
			-- Note that 0xffff is sign extended to 0xffffffff by SmartEiffel,
			-- because 0xffff is regarded as an INTEGER_16 prior to the promotion
			-- to INTEGER for the '&' operation with 's'
		ensure
			Result <= 65535
		end

end
