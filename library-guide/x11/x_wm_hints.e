note

class X_WM_HINTS
  -- Interface to Xlib's XWMHints structure.

inherit

	X_STRUCT

create

	make

create { X_WINDOW }

	from_x_struct

feature -- flag's values

	Input_hint			: INTEGER = 1
	State_hint			: INTEGER = 2
	Icon_pixmap_hint	: INTEGER = 4
	Icon_window_hint	: INTEGER = 8
	Icon_position_hint	: INTEGER = 16
	Icon_mask_hint		: INTEGER = 32
	Window_group_hint	: INTEGER = 64

feature -- Access

	flags:			INTEGER	do	Result := x_flags			(to_external) end

	input:			BOOLEAN	do	Result := x_input			(to_external) /= 0 end
	initial_state:	INTEGER	do	Result := x_initial_state	(to_external) end
	icon_pixmap:	INTEGER	do	Result := x_icon_pixmap		(to_external) end
	icon_window:	INTEGER	do	Result := x_icon_window		(to_external) end
	icon_x:			INTEGER	do	Result := x_icon_x			(to_external) end
	icon_y:			INTEGER	do	Result := x_icon_y			(to_external) end
	icon_mask:		INTEGER	do	Result := x_icon_mask		(to_external) end
	window_group:	INTEGER 	do	Result := x_window_group	(to_external) end

feature -- Setting

	reset_flags
		do
			x_set_flags(to_external, 0)
		end

	set_flags(b: INTEGER)
		local
			f: INTEGER
		do
			f := x_flags(to_external)
			f := f | b
			x_set_flags(to_external, f)
		end

	set_input(b: BOOLEAN)
		do
			if b then
				x_set_input(to_external, 0)
			else
				x_set_input(to_external, 1)
			end
			set_flags(Input_hint)
		end

	set_initial_state(s: INTEGER)
		do
			x_set_initial_state(to_external, s)
			set_flags(State_hint)
		end

--	set_icon_pixmap(pm:

feature { NONE } -- Access implementation

	x_flags			(p: POINTER): INTEGER external "C struct XWMHints access flags			use <X11/Xutil.h>" end
	x_input			(p: POINTER): INTEGER external "C struct XWMHints access input			use <X11/Xutil.h>" end
	x_initial_state	(p: POINTER): INTEGER external "C struct XWMHints access initial_state	use <X11/Xutil.h>" end
	x_icon_pixmap	(p: POINTER): INTEGER external "C struct XWMHints access icon_pixmap	use <X11/Xutil.h>" end
	x_icon_window	(p: POINTER): INTEGER external "C struct XWMHints access icon_window	use <X11/Xutil.h>" end
	x_icon_x		(p: POINTER): INTEGER external "C struct XWMHints access icon_x		use <X11/Xutil.h>" end
	x_icon_y		(p: POINTER): INTEGER external "C struct XWMHints access icon_y		use <X11/Xutil.h>" end
	x_icon_mask		(p: POINTER): INTEGER external "C struct XWMHints access icon_mask		use <X11/Xutil.h>" end
	x_window_group	(p: POINTER): INTEGER external "C struct XWMHints access window_group	use <X11/Xutil.h>" end

feature { NONE } -- Setting implementation

	x_set_flags			(p: POINTER; v: INTEGER) external "C struct XWMHints access flags		 use <X11/Xutil.h>" end
	x_set_input			(p: POINTER; v: INTEGER) external "C struct XWMHints access input		 use <X11/Xutil.h>" end
	x_set_initial_state	(p: POINTER; v: INTEGER) external "C struct XWMHints access initial_state use <X11/Xutil.h>" end
	x_set_icon_pixmap	(p: POINTER; v: INTEGER) external "C struct XWMHints access icon_pixmap	 use <X11/Xutil.h>" end
	x_set_icon_window	(p: POINTER; v: INTEGER) external "C struct XWMHints access icon_window	 use <X11/Xutil.h>" end
	x_set_icon_x		(p: POINTER; v: INTEGER) external "C struct XWMHints access icon_x		 use <X11/Xutil.h>" end
	x_set_icon_y		(p: POINTER; v: INTEGER) external "C struct XWMHints access icon_y		 use <X11/Xutil.h>" end
	x_set_icon_mask		(p: POINTER; v: INTEGER) external "C struct XWMHints access icon_mask	 use <X11/Xutil.h>" end
	x_set_window_group	(p: POINTER; v: INTEGER) external "C struct XWMHints access window_group	 use <X11/Xutil.h>" end

feature -- initial_state values

	Withdrawn_state	: INTEGER = 0
	Normal_state	: INTEGER = 1
	Iconic_state	: INTEGER = 3
--	Inactive_state	: INTEGER is 4

feature -- Modification


feature

	size: INTEGER
    	external
    		"C inline use <X11/Xlib.h>"
    	alias
    		"sizeof(XWMHints)"
    	end


end
