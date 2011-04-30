expanded class SB_MATH

feature {ANY} -- Constants

	pi  : REAL is  3.14159265358979323846
	e   : REAL is  2.71828182845904523536
	deg : REAL is 57.29577951308232087680   -- deg/radian
	phi : REAL is  1.61803398874989484820   -- golden ratio

feature {ANY} -- Functions

--	arccos (x: REAL): REAL is
--		require
--			legal_argument : -1.0 <= x and then x <= 1.0
--		external "C"
--		alias 	"xacos"
--		end

--	arccosh (x: REAL): REAL is
--		require
--			non_negative_argument : x >= 1.0
--		external "C"
--		alias	"xacosh"
--		end

--	arcsin (x: REAL): REAL is
--		require
--			legal_argument : -1.0 <= x and then x <= 1.0
--		external "C"
--		alias "xasin"
--		end

--	arcsinh (x: REAL): REAL is
--		external "C"
--		alias "xasinh"
--		end

--	arctan (x: REAL): REAL is
--			-- Result in the range [-pi/2, pi/2]
--		external "C"
--		alias "xatan"
--		end

--	arctan2 (y, x: REAL): REAL is
--			-- Inverse tangent of y/x in range (-pi, pi]
--			-- Quadrant depends on signs of x, y
--		external "C"
--		alias "xatan2"
--		end

--	arctanh (x: REAL): REAL is
--		require
--			-- non_negative_argument: x >= 0.0
--		external "C"
--		alias "xatanh"
--		end

--	cosh (x: REAL): REAL is
--		external "C"
--		alias "xcosh"
--		end

--	exp (x: REAL): REAL is
--		external "C"
--		alias "xexp"
--		end

--	log (x: REAL): REAL is
--		require
--			positive_argument: x > 0.0
--		external "C"
--		alias "xlog"
--		end

--	sinh (x: REAL): REAL is
--		external "C"
--		alias "xsinh"
--		end

--	tan (x: REAL): REAL is
--		external "C"
--		alias "xtan"
--		end

--	tanh (x: REAL): REAL is
--		external "C"
--		alias "xtanh"
--		end

feature {ANY} -- Random numbers

--	rand: INTEGER is
--		external "C"
--		end

--	srand (seed: INTEGER) is
--		external "C"
--		end

end
