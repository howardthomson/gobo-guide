class POINTER_ACCESS

feature

	-- Pointer offset calculation

--	c_at_offset(p: POINTER; offset: INTEGER): POINTER is external "C" end

	c_at_offset(p: POINTER; offset: INTEGER): POINTER is
		do
			Result := p + offset
		end

	-- Memory read access routines

	c_get_char  (p: POINTER; offset: INTEGER): CHARACTER  is external "C" end
	c_get_byte  (p: POINTER; offset: INTEGER): INTEGER_8  is external "C" end
	c_get_short (p: POINTER; offset: INTEGER): INTEGER_16 is external "C" end
	c_get_long  (p: POINTER; offset: INTEGER): INTEGER	  is external "C" end
	c_get_quad  (p: POINTER; offset: INTEGER): INTEGER_64 is external "C" end
	c_get_float (p: POINTER; offset: INTEGER): REAL_32	  is external "C" end
	c_get_double(p: POINTER; offset: INTEGER): REAL_64	  is external "C" end

--	c_get_int8  (p: POINTER; offset: INTEGER): INTEGER_8  is external "C" alias "c_get_byte"  end
--	c_get_int16 (p: POINTER; offset: INTEGER): INTEGER_16 is external "C" alias "c_get_short" end

	-- Memory write routines

	c_put_char   (p: POINTER; offset: INTEGER; value: CHARACTER ) is external "C" end
	c_put_byte   (p: POINTER; offset: INTEGER; value: INTEGER   ) is external "C" end
	c_put_short  (p: POINTER; offset: INTEGER; value: INTEGER   ) is external "C" end
	c_put_long   (p: POINTER; offset: INTEGER; value: INTEGER   ) is external "C" end
	c_put_quad   (p: POINTER; offset: INTEGER; value: INTEGER_64) is external "C" end
	c_put_float  (p: POINTER; offset: INTEGER; value: REAL_32   ) is external "C" end
	c_put_double (p: POINTER; offset: INTEGER; value: REAL_64   ) is external "C" end

	-- Memory Compare
	c_cmp_char  (from_p: POINTER; to_p: POINTER; count: INTEGER): INTEGER is external "C" end
	c_cmp_byte  (from_p: POINTER; to_p: POINTER; count: INTEGER): INTEGER is external "C" end
	c_cmp_short (from_p: POINTER; to_p: POINTER; count: INTEGER): INTEGER is external "C" end
	c_cmp_long  (from_p: POINTER; to_p: POINTER; count: INTEGER): INTEGER is external "C" end
	c_cmp_quad  (from_p: POINTER; to_p: POINTER; count: INTEGER): INTEGER is external "C" end
	c_cmp_float (from_p: POINTER; to_p: POINTER; count: INTEGER): INTEGER is external "C" end
	c_cmp_double(from_p: POINTER; to_p: POINTER; count: INTEGER): INTEGER is external "C" end

	-- Memory Move
	c_move_char  (from_p: POINTER; to_p: POINTER; count: INTEGER) is external "C" end
	c_move_byte  (from_p: POINTER; to_p: POINTER; count: INTEGER) is external "C" end
	c_move_short (from_p: POINTER; to_p: POINTER; count: INTEGER) is external "C" end
	c_move_long  (from_p: POINTER; to_p: POINTER; count: INTEGER) is external "C" end
	c_move_quad  (from_p: POINTER; to_p: POINTER; count: INTEGER) is external "C" end
	c_move_float (from_p: POINTER; to_p: POINTER; count: INTEGER) is external "C" end
	c_move_double(from_p: POINTER; to_p: POINTER; count: INTEGER) is external "C" end

	c_cmp_pointer(p1, p2: POINTER): INTEGER is external "C" end

end -- POINTER_ACCESS
