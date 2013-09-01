note

	description: "Interface to XSizeHints Xlib structure"

	author: "Howard Thomson"
	copyright: "Copyright (c) 1998-2006, Stephane Hillion and Howard Thomson"
	license: "Eiffel Forum License v2 (see forum.txt)"

class X_SIZE_HINTS

inherit

	X_STRUCT

create

	make,
	from_external

feature -- Access

	flags: INTEGER do Result := c_flags (to_external) end

	x			: INTEGER do Result := c_x				(to_external) end
	y			: INTEGER do Result := c_y				(to_external) end
	width		: INTEGER do Result := c_width			(to_external) end
	height		: INTEGER do Result := c_height			(to_external) end
	min_width	: INTEGER do Result := c_min_width		(to_external) end
	min_height	: INTEGER do Result := c_min_height		(to_external) end
	max_width	: INTEGER do Result := c_max_width		(to_external) end
	max_height	: INTEGER do Result := c_max_height		(to_external) end
	width_inc	: INTEGER do Result := c_width_inc		(to_external) end
	height_inc	: INTEGER do Result := c_height_inc		(to_external) end
	min_aspect_x: INTEGER do Result := c_min_aspect_x	(to_external) end
	min_aspect_y: INTEGER do Result := c_min_aspect_y	(to_external) end
	max_aspect_x: INTEGER do Result := c_max_aspect_x	(to_external) end
	max_aspect_y: INTEGER do Result := c_max_aspect_y	(to_external) end
	base_width	: INTEGER do Result := c_base_width		(to_external) end
	base_height : INTEGER do Result := c_base_height		(to_external) end
	win_gravity	: INTEGER do Result := c_win_gravity		(to_external) end

feature { NONE } -- Access implementation GEC/EDP

--	c_flags			(p: POINTER): INTEGER is external "C struct XSizeHints get flags			use <X11/Xutil.h>" end
--	c_x				(p: POINTER): INTEGER is external "C struct XSizeHints get x				use <X11/Xutil.h>" end
--	c_y				(p: POINTER): INTEGER is external "C struct XSizeHints get y				use <X11/Xutil.h>" end
--	c_width			(p: POINTER): INTEGER is external "C struct XSizeHints get width			use <X11/Xutil.h>" end
--	c_height		(p: POINTER): INTEGER is external "C struct XSizeHints get height			use <X11/Xutil.h>" end
--	c_min_width		(p: POINTER): INTEGER is external "C struct XSizeHints get min_width		use <X11/Xutil.h>" end
--	c_min_height	(p: POINTER): INTEGER is external "C struct XSizeHints get min_height		use <X11/Xutil.h>" end
--	c_max_width		(p: POINTER): INTEGER is external "C struct XSizeHints get max_width		use <X11/Xutil.h>" end
--	c_max_height	(p: POINTER): INTEGER is external "C struct XSizeHints get max_height		use <X11/Xutil.h>" end
--	c_width_inc		(p: POINTER): INTEGER is external "C struct XSizeHints get width_inc		use <X11/Xutil.h>" end
--	c_height_inc	(p: POINTER): INTEGER is external "C struct XSizeHints get height_inc		use <X11/Xutil.h>" end
--	c_min_aspect_x	(p: POINTER): INTEGER is external "C struct XSizeHints get min_aspect.x		use <X11/Xutil.h>" end
--	c_min_aspect_y	(p: POINTER): INTEGER is external "C struct XSizeHints get min_aspect.y		use <X11/Xutil.h>" end
--	c_max_aspect_x	(p: POINTER): INTEGER is external "C struct XSizeHints get max_aspect.x		use <X11/Xutil.h>" end
--	c_max_aspect_y	(p: POINTER): INTEGER is external "C struct XSizeHints get max_aspect.y		use <X11/Xutil.h>" end
--	c_base_width	(p: POINTER): INTEGER is external "C struct XSizeHints get base_width	 	use <X11/Xutil.h>" end
--	c_base_height	(p: POINTER): INTEGER is external "C struct XSizeHints get base_height	 	use <X11/Xutil.h>" end
--	c_win_gravity	(p: POINTER): INTEGER is external "C struct XSizeHints get win_gravity	 	use <X11/Xutil.h>" end

feature { NONE } -- Access implementation

	c_flags			(p: POINTER): INTEGER external "C struct XSizeHints access flags			use <X11/Xutil.h>" end
	c_x				(p: POINTER): INTEGER external "C struct XSizeHints access x				use <X11/Xutil.h>" end
	c_y				(p: POINTER): INTEGER external "C struct XSizeHints access y				use <X11/Xutil.h>" end
	c_width			(p: POINTER): INTEGER external "C struct XSizeHints access width			use <X11/Xutil.h>" end
	c_height		(p: POINTER): INTEGER external "C struct XSizeHints access height		use <X11/Xutil.h>" end
	c_min_width		(p: POINTER): INTEGER external "C struct XSizeHints access min_width		use <X11/Xutil.h>" end
	c_min_height	(p: POINTER): INTEGER external "C struct XSizeHints access min_height	use <X11/Xutil.h>" end
	c_max_width		(p: POINTER): INTEGER external "C struct XSizeHints access max_width		use <X11/Xutil.h>" end
	c_max_height	(p: POINTER): INTEGER external "C struct XSizeHints access max_height	use <X11/Xutil.h>" end
	c_width_inc		(p: POINTER): INTEGER external "C struct XSizeHints access width_inc		use <X11/Xutil.h>" end
	c_height_inc	(p: POINTER): INTEGER external "C struct XSizeHints access height_inc	use <X11/Xutil.h>" end
	c_min_aspect_x	(p: POINTER): INTEGER external "C struct XSizeHints access min_aspect.x	use <X11/Xutil.h>" end
	c_min_aspect_y	(p: POINTER): INTEGER external "C struct XSizeHints access min_aspect.y	use <X11/Xutil.h>" end
	c_max_aspect_x	(p: POINTER): INTEGER external "C struct XSizeHints access max_aspect.x	use <X11/Xutil.h>" end
	c_max_aspect_y	(p: POINTER): INTEGER external "C struct XSizeHints access max_aspect.y	use <X11/Xutil.h>" end
	c_base_width	(p: POINTER): INTEGER external "C struct XSizeHints access base_width	use <X11/Xutil.h>" end
	c_base_height	(p: POINTER): INTEGER external "C struct XSizeHints access base_height	use <X11/Xutil.h>" end
	c_win_gravity	(p: POINTER): INTEGER external "C struct XSizeHints access win_gravity	use <X11/Xutil.h>" end

feature -- flags values

	US_position		: INTEGER = 1		-- (1 << 0)
	US_size			: INTEGER = 2		-- (1 << 1)

	P_position		: INTEGER = 4		-- (1 << 2)
	P_size			: INTEGER = 8		-- (1 << 3)
	P_min_size		: INTEGER = 16		-- (1 << 4)
	P_max_size		: INTEGER = 32		-- (1 << 5)
	P_resize_inc	: INTEGER = 64		-- (1 << 6)
	P_aspect		: INTEGER = 128	-- (1 << 7)
	P_base_size 	: INTEGER = 256	-- (1 << 8)
	P_win_gravity	: INTEGER = 512	-- (1 << 9)

feature -- Modification

	set_flags (v : INTEGER)
		local
			t: like v
		do
			t := c_flags (to_external)
			c_set_flags (to_external, t | v)
		end

	reset_flags
		do
			c_set_flags (to_external, 0)
		end

	set_position (nx, ny : INTEGER)
		do
			c_set_x (to_external, nx)
			c_set_y (to_external, ny)
			set_flags (P_position)
		end

	set_size (nw, nh : INTEGER)
		do
			c_set_width  (to_external, nw)
			c_set_height (to_external, nh)
			set_flags (P_size)
		end

	set_min_size (nw, nh : INTEGER)
		do
			c_set_min_width  (to_external, nw)
			c_set_min_height (to_external, nh)
			set_flags (P_min_size)
		end

	set_max_size (nw, nh : INTEGER)
		do
			c_set_max_width  (to_external, nw)
			c_set_max_height (to_external, nh)
			set_flags (P_max_size)
		end

	set_resize_inc (nw, nh : INTEGER)
		do
			c_set_width_inc  (to_external, nw)
			c_set_height_inc (to_external, nh)
			set_flags (P_resize_inc)
		end

	set_aspect (min_xa, min_ya, max_xa, max_ya : INTEGER)
		do
			c_set_min_aspect_x (to_external, min_xa)
			c_set_min_aspect_y (to_external, min_ya)
			c_set_max_aspect_x (to_external, max_xa)
			c_set_max_aspect_y (to_external, max_ya)
			set_flags (P_aspect)
		end

	set_base_size (nw, nh : INTEGER)
		do
			c_set_base_width  (to_external, nw)
			c_set_base_height (to_external, nh)
			set_flags (P_base_size)
		end

	set_win_gravity (i : INTEGER)
		do
			c_set_win_gravity (to_external, i)
			set_flags (P_win_gravity)
		end

feature { NONE } -- Access implementation GEC/EDP

--	c_set_flags			(p: POINTER; v: INTEGER ) is external "C struct XSizeHints set	flags			use <X11/Xutil.h>" end
--	c_set_x				(p: POINTER; v: INTEGER) is external "C struct XSizeHints set 	x				use <X11/Xutil.h>" end
--	c_set_y				(p: POINTER; v: INTEGER) is external "C struct XSizeHints set 	y				use <X11/Xutil.h>" end
--	c_set_width			(p: POINTER; v: INTEGER) is external "C struct XSizeHints set 	width			use <X11/Xutil.h>" end
--	c_set_height		(p: POINTER; v: INTEGER) is external "C struct XSizeHints set 	height			use <X11/Xutil.h>" end
--	c_set_min_width		(p: POINTER; v: INTEGER) is external "C struct XSizeHints set 	min_width		use <X11/Xutil.h>" end
--	c_set_min_height	(p: POINTER; v: INTEGER) is external "C struct XSizeHints set	min_height		use <X11/Xutil.h>" end
--	c_set_max_width		(p: POINTER; v: INTEGER) is external "C struct XSizeHints set 	max_width		use <X11/Xutil.h>" end
--	c_set_max_height	(p: POINTER; v: INTEGER) is external "C struct XSizeHints set 	max_height		use <X11/Xutil.h>" end
--	c_set_width_inc		(p: POINTER; v: INTEGER) is external "C struct XSizeHints set 	width_inc		use <X11/Xutil.h>" end
--	c_set_height_inc	(p: POINTER; v: INTEGER) is external "C struct XSizeHints set 	height_inc		use <X11/Xutil.h>" end
--	c_set_min_aspect_x	(p: POINTER; v: INTEGER) is external "C struct XSizeHints set 	min_aspect.x	use <X11/Xutil.h>" end
--	c_set_min_aspect_y	(p: POINTER; v: INTEGER) is external "C struct XSizeHints set 	min_aspect.y	use <X11/Xutil.h>" end
--	c_set_max_aspect_x	(p: POINTER; v: INTEGER) is external "C struct XSizeHints set 	max_aspect.x	use <X11/Xutil.h>" end
--	c_set_max_aspect_y	(p: POINTER; v: INTEGER) is external "C struct XSizeHints set 	max_aspect.y	use <X11/Xutil.h>" end
--	c_set_base_width	(p: POINTER; v: INTEGER) is external "C struct XSizeHints set 	base_width	 	use <X11/Xutil.h>" end
--	c_set_base_height	(p: POINTER; v: INTEGER) is external "C struct XSizeHints set 	base_height	 	use <X11/Xutil.h>" end
--	c_set_win_gravity	(p: POINTER; v: INTEGER) is external "C struct XSizeHints set 	win_gravity	 	use <X11/Xutil.h>" end

feature { NONE } -- Access implementation

	c_set_flags			(p: POINTER; v: INTEGER) external "C struct XSizeHints access	flags			type long use <X11/Xutil.h>" end
	c_set_x				(p: POINTER; v: INTEGER) external "C struct XSizeHints access 	x				type int use <X11/Xutil.h>" end
	c_set_y				(p: POINTER; v: INTEGER) external "C struct XSizeHints access 	y				type int use <X11/Xutil.h>" end
	c_set_width			(p: POINTER; v: INTEGER) external "C struct XSizeHints access 	width			type int use <X11/Xutil.h>" end
	c_set_height		(p: POINTER; v: INTEGER) external "C struct XSizeHints access 	height			type int use <X11/Xutil.h>" end
	c_set_min_width		(p: POINTER; v: INTEGER) external "C struct XSizeHints access 	min_width		type int use <X11/Xutil.h>" end
	c_set_min_height	(p: POINTER; v: INTEGER) external "C struct XSizeHints access	min_height		type int use <X11/Xutil.h>" end
	c_set_max_width		(p: POINTER; v: INTEGER) external "C struct XSizeHints access 	max_width		type int use <X11/Xutil.h>" end
	c_set_max_height	(p: POINTER; v: INTEGER) external "C struct XSizeHints access 	max_height		type int use <X11/Xutil.h>" end
	c_set_width_inc		(p: POINTER; v: INTEGER) external "C struct XSizeHints access 	width_inc		type int use <X11/Xutil.h>" end
	c_set_height_inc	(p: POINTER; v: INTEGER) external "C struct XSizeHints access 	height_inc		type int use <X11/Xutil.h>" end
	c_set_min_aspect_x	(p: POINTER; v: INTEGER) external "C struct XSizeHints access 	min_aspect.x	type int use <X11/Xutil.h>" end
	c_set_min_aspect_y	(p: POINTER; v: INTEGER) external "C struct XSizeHints access 	min_aspect.y	type int use <X11/Xutil.h>" end
	c_set_max_aspect_x	(p: POINTER; v: INTEGER) external "C struct XSizeHints access 	max_aspect.x	type int use <X11/Xutil.h>" end
	c_set_max_aspect_y	(p: POINTER; v: INTEGER) external "C struct XSizeHints access 	max_aspect.y	type int use <X11/Xutil.h>" end
	c_set_base_width	(p: POINTER; v: INTEGER) external "C struct XSizeHints access 	base_width	 	type int use <X11/Xutil.h>" end
	c_set_base_height	(p: POINTER; v: INTEGER) external "C struct XSizeHints access 	base_height	 	type int use <X11/Xutil.h>" end
	c_set_win_gravity	(p: POINTER; v: INTEGER) external "C struct XSizeHints access 	win_gravity	 	type int use <X11/Xutil.h>" end

feature

	size: INTEGER
		external
			"C inline use <X11/Xutil.h>"
		alias
			"sizeof(XSizeHints)"
		end


end
