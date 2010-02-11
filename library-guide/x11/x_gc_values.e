indexing
	description: "C Structure -- Xlib XGCValues"

	C_struct: "[
		/*
		 * Data structure for setting graphics context.
		 */
		typedef struct {
			int function;				/* logical operation */
			unsigned long plane_mask;	/* plane mask */
			unsigned long foreground;	/* foreground pixel */
			unsigned long background;	/* background pixel */
			int line_width;				/* line width */
			int line_style;	 			/* LineSolid, LineOnOffDash, LineDoubleDash */
			int cap_style;	  			/* CapNotLast, CapButt, 
						   					CapRound, CapProjecting */
			int join_style;	 			/* JoinMiter, JoinRound, JoinBevel */
			int fill_style;	 			/* FillSolid, FillTiled, 
						   					FillStippled, FillOpaeueStippled */
			int fill_rule;	  			/* EvenOddRule, WindingRule */
			int arc_mode;				/* ArcChord, ArcPieSlice */
			Pixmap tile;				/* tile pixmap for tiling operations */
			Pixmap stipple;				/* stipple 1 plane pixmap for stipping */
			int ts_x_origin;			/* offset for tile or stipple operations */
			int ts_y_origin;
		    Font font;	        		/* default text font for text operations */
			int subwindow_mode;     	/* ClipByChildren, IncludeInferiors */
			Bool graphics_exposures;	/* boolean, should exposures be generated */
			int clip_x_origin;			/* origin for clipping */
			int clip_y_origin;
			Pixmap clip_mask;			/* bitmap clipping; other calls for rects */
			int dash_offset;			/* patterned/dashed line information */
			char dashes;
		} XGCValues;
	]"

	mods_needed: "[
		Lock and Unlock facility, for multiple parameter usage.
		Call reset from routines to which objects of this class can
		be passed, and reset the flags if unlocked, ignore otherwise.
	]"
	
class X_GC_VALUES

inherit 

	X_STRUCT

	X_GC_CONSTANTS
	
create

	make

feature -- GC Debug

	class_name: STRING is
		do
			Result := once "X_GC_VALUES"
		end

feature -- Access

--	function			: INTEGER	is do Result := c_function			(to_external)			end
--	plane_mask			: INTEGER	is do Result := c_plane_mask		(to_external) 			end
--	foreground			: INTEGER	is do Result := c_foreground		(to_external) 			end
--	background			: INTEGER	is do Result := c_background		(to_external) 			end
--	line_width 			: INTEGER	is do Result := c_line_width		(to_external) 			end
--	line_style 			: INTEGER	is do Result := c_line_style		(to_external) 			end
--	cap_style 			: INTEGER	is do Result := c_cap_style			(to_external) 			end
--	join_style 			: INTEGER	is do Result := c_join_style		(to_external) 			end
--	fill_style 			: INTEGER	is do Result := c_fill_style		(to_external) 			end
--	fill_rule 			: INTEGER	is do Result := c_fill_rule			(to_external)			end
--	arc_mode 			: INTEGER	is do Result := c_arc_mode			(to_external)			end
---	tile 				: INTEGER	is ## See Below ##
---	stipple 			: INTEGER	is ## See Below ##
--	ts_x_origin 		: INTEGER	is do Result := c_ts_x_origin		(to_external)			end
--	ts_y_origin 		: INTEGER	is do Result := c_ts_y_origin		(to_external)			end
---	font 				: INTEGER	is ## See Below ##
--	subwindow_mode		: INTEGER	is do Result := c_subwindow_mode	(to_external)			end
--	graphics_exposures	: BOOLEAN	is do Result := c_graphics_exposures(to_external) /= 0 		end
--	clip_x_origin		: INTEGER	is do Result := c_clip_x_origin		(to_external)			end
--	clip_y_origin		: INTEGER	is do Result := c_clip_y_origin		(to_external)			end
---	clip_mask			: INTEGER	is ## See Below ##
--	dash_offset			: INTEGER	is do Result := c_dash_offset		(to_external)			end
--	dashes				: CHARACTER	is do Result := c_dashes			(to_external)			end

--	tile: X_PIXMAP is
--		do
--			Result := c_tile (to_external)
--		end

--	stipple: X_PIXMAP is
--		do
--			Result := c_stipple (to_external)
--		end

--	font: X_FONT is
--		do
--			Result := c_font (to_external)
--		end

--	clip_mask: X_PIXMAP	is
--		do
--			Result := c_clip_mask (to_external)
--		end

feature -- Modification

	set_function			(i: INTEGER)	is do c_set_function		(to_external,	i); set_flag (Gc_function)			end -- ensure function = i 			end
	set_plane_mask			(i: INTEGER)	is do c_set_plane_mask		(to_external,	i); set_flag (Gc_plane_mask)		end -- ensure plane_mask = i 			end
	set_foreground			(i: INTEGER)	is do c_set_foreground		(to_external,	i); set_flag (Gc_foreground)		end -- ensure foreground = i 			end
	set_background			(i: INTEGER)	is do c_set_background		(to_external,	i); set_flag (Gc_background)		end -- ensure background = i 			end
	set_line_width 			(i: INTEGER)	is do c_set_line_width		(to_external,	i); set_flag (Gc_line_width)		end -- ensure line_width = i 			end
	set_line_style 			(i: INTEGER)	is do c_set_line_style		(to_external,	i); set_flag (Gc_line_style)		end -- ensure line_style = i 			end
	set_cap_style 			(i: INTEGER)	is do c_set_cap_style		(to_external,	i); set_flag (Gc_cap_style)			end -- ensure cap_style = i 			end
	set_join_style 			(i: INTEGER)	is do c_set_join_style		(to_external,	i); set_flag (Gc_join_style)		end -- ensure join_style = i 			end
--	set_fill_style 			(i: INTEGER) ## See Below ##
	set_fill_rule 			(i: INTEGER)	is do c_set_fill_rule 		(to_external,	i); set_flag (Gc_fill_rule)			end -- ensure fill_rule = i 			end
	set_arc_mode 			(i: INTEGER)	is do c_set_arc_mode 		(to_external,	i); set_flag (Gc_arc_mode)			end -- ensure arc_mode = i 			end
--	set_tile 				(i: X_PIXMAP) ## See Below ##
--	set_stipple 			(i: X_PIXMAP) ## See Below ##
	set_ts_x_origin 		(i: INTEGER)	is do c_set_ts_x_origin 	(to_external,	i); set_flag (Gc_tile_stip_x_origin)end -- ensure ts_x_origin = i 		end
	set_ts_y_origin 		(i: INTEGER)	is do c_set_ts_y_origin 	(to_external,	i); set_flag (Gc_tile_stip_y_origin)end -- ensure ts_y_origin = i 		end
--	set_font 				(i: X_FONT) ## See Below ##
	set_subwindow_mode		(i: INTEGER)	is do c_set_subwindow_mode 	(to_external,	i); set_flag (Gc_subwindow_mode)	end -- ensure subwindow_mode = i 		end
--	set_graphics_exposures	(i: BOOLEAN) ## See Below ##
	set_clip_x_origin		(i: INTEGER)	is do c_set_clip_x_origin 	(to_external,	i); set_flag (Gc_clip_x_origin)		end -- ensure clip_x_origin = i		end
	set_clip_y_origin		(i: INTEGER)	is do c_set_clip_y_origin 	(to_external,	i); set_flag (Gc_clip_y_origin)		end -- ensure clip_y_origin = i		end
--	set_clip_mask			(i: X_PIXMAP) ## See Below ##
	set_dash_offset			(i: INTEGER)	is do c_set_dash_offset 	(to_external,	i); set_flag (Gc_dash_offset)		end -- ensure dash_offset = i 			end
	set_dashes				(i: INTEGER)	is do c_set_dashes 			(to_external, 	i.to_character); set_flag (Gc_dash_list)	end -- ensure dashes = i				end

	set_fill_style (i: INTEGER)	is
		require
			valid_range: i >= 0 and i <= 3
		do
			c_set_fill_style (to_external, i)
			set_flag (Gc_fill_style)
		ensure
--			set: fill_style = i
		end

	set_tile (p: X_PIXMAP) is
		do
			c_set_tile (to_external, p.id)
			set_flag (Gc_tile)
		ensure
--			tile = i
		end

	set_stipple (p: X_PIXMAP) is
		do
			c_set_stipple (to_external, p.id)
			set_flag (Gc_stipple)
		ensure
--			stipple = p.id
		end

	set_font (f: X_FONT) is
		do
			c_set_font (to_external, f.id)
			set_flag (Gc_font)
		ensure
--			font = i
		end

	set_graphics_exposures	(b: BOOLEAN) is
		local
			v: INTEGER
		do
			if b then v := 1 else v := 0 end
			c_set_graphics_exposures (to_external, v)
			set_flag (Gc_graphics_exposures)
		ensure
--			graphics_exposures = b
		end

	set_clip_mask (p: X_PIXMAP)	is
		do
			c_set_clip_mask	(to_external, p.id)
			set_flag (Gc_clip_mask)
		end

	set_clip_mask_none is
		do
			c_set_clip_mask (to_external, 0)
			set_flag (Gc_clip_mask)
		ensure
--			clip_mask = 0
		end

feature -- flags

	flags: INTEGER

	reset is
		do
			flags := 0
		end

	set_flag (f: INTEGER) is
		do
			if f = 0 then edp_trace.simple(0, "X_GC_VALUES::set_flag - f = 0 !!!") end
			flags := flags | f
		end

feature {NONE}

	size, external_size: INTEGER is
		once
			Result := c_size
		end

	set_buffer_size(a_size: INTEGER) is do end

feature {NONE} -- External functions

	c_size: INTEGER is
		external
			"C macro use <X11/Xlib.h>"
		alias
			"sizeof(XGCValues)"
		end

feature -- {NONE} C getters
	c_function				(p: POINTER): INTEGER is	external "C struct XGCValues access function			 use <X11/Xlib.h>" end
	c_plane_mask			(p: POINTER): INTEGER is	external "C struct XGCValues access plane_mask			 use <X11/Xlib.h>" end
	c_foreground			(p: POINTER): INTEGER is	external "C struct XGCValues access foreground			 use <X11/Xlib.h>" end
	c_background			(p: POINTER): INTEGER is	external "C struct XGCValues access background			 use <X11/Xlib.h>" end
	c_line_width			(p: POINTER): INTEGER is	external "C struct XGCValues access line_width			 use <X11/Xlib.h>" end
	c_line_style			(p: POINTER): INTEGER is	external "C struct XGCValues access line_style			 use <X11/Xlib.h>" end
	c_cap_style				(p: POINTER): INTEGER is	external "C struct XGCValues access cap_style			 use <X11/Xlib.h>" end
	c_join_style			(p: POINTER): INTEGER is	external "C struct XGCValues access join_style			 use <X11/Xlib.h>" end
	c_fill_style			(p: POINTER): INTEGER is	external "C struct XGCValues access fill_style			 use <X11/Xlib.h>" end
	c_fill_rule				(p: POINTER): INTEGER is	external "C struct XGCValues access fill_rule			 use <X11/Xlib.h>" end
	c_arc_mode				(p: POINTER): INTEGER is	external "C struct XGCValues access arc_mode			 use <X11/Xlib.h>" end
	c_tile					(p: POINTER): INTEGER is	external "C struct XGCValues access tile			 	 use <X11/Xlib.h>" end
	c_stipple				(p: POINTER): INTEGER is	external "C struct XGCValues access stipple			 	 use <X11/Xlib.h>" end
	c_ts_x_origin			(p: POINTER): INTEGER is	external "C struct XGCValues access ts_x_origin			 use <X11/Xlib.h>" end
	c_ts_y_origin			(p: POINTER): INTEGER is	external "C struct XGCValues access ts_y_origin			 use <X11/Xlib.h>" end
	c_font					(p: POINTER): INTEGER is	external "C struct XGCValues access font			 	 use <X11/Xlib.h>" end
	c_subwindow_mode		(p: POINTER): INTEGER is	external "C struct XGCValues access subwindow_mode		 use <X11/Xlib.h>" end
	c_graphics_exposures	(p: POINTER): INTEGER is	external "C struct XGCValues access graphics_exposures	 use <X11/Xlib.h>" end
	c_clip_x_origin			(p: POINTER): INTEGER is	external "C struct XGCValues access clip_x_origin		 use <X11/Xlib.h>" end
	c_clip_y_origin			(p: POINTER): INTEGER is	external "C struct XGCValues access clip_y_origin		 use <X11/Xlib.h>" end
	c_clip_mask				(p: POINTER): INTEGER is	external "C struct XGCValues access clip_mask			 use <X11/Xlib.h>" end
	c_dash_offset			(p: POINTER): INTEGER is	external "C struct XGCValues access dash_offset			 use <X11/Xlib.h>" end
	c_dashes				(p: POINTER): CHARACTER is	external "C struct XGCValues access dashes				 use <X11/Xlib.h>" end

feature {NONE} -- C setters

	c_set_function			(p: POINTER; i: INTEGER) is    external "C struct XGCValues access function			 type int use <X11/Xlib.h>" end
	
	c_set_plane_mask		(p: POINTER; i: INTEGER) is    external "C struct XGCValues access plane_mask		 type unsigned long use <X11/Xlib.h>" end
	c_set_foreground		(p: POINTER; i: INTEGER) is    external "C struct XGCValues access foreground		 type unsigned long use <X11/Xlib.h>" end
	c_set_background		(p: POINTER; i: INTEGER) is    external "C struct XGCValues access background		 type unsigned long use <X11/Xlib.h>" end
	c_set_line_width		(p: POINTER; i: INTEGER) is    external "C struct XGCValues access line_width		 type int use <X11/Xlib.h>" end
	c_set_line_style		(p: POINTER; i: INTEGER) is    external "C struct XGCValues access line_style		 type int use <X11/Xlib.h>" end
	c_set_cap_style			(p: POINTER; i: INTEGER) is    external "C struct XGCValues access cap_style		 type int use <X11/Xlib.h>" end
	c_set_join_style		(p: POINTER; i: INTEGER) is    external "C struct XGCValues access join_style		 type int use <X11/Xlib.h>" end
	c_set_fill_style		(p: POINTER; i: INTEGER) is    external "C struct XGCValues access fill_style		 type int use <X11/Xlib.h>" end
	c_set_fill_rule			(p: POINTER; i: INTEGER) is    external "C struct XGCValues access fill_rule		 type int use <X11/Xlib.h>" end
	c_set_arc_mode			(p: POINTER; i: INTEGER) is    external "C struct XGCValues access arc_mode			 type int use <X11/Xlib.h>" end
	c_set_tile				(p: POINTER; i: INTEGER) is    external "C struct XGCValues access tile				 type Pixmap use <X11/Xlib.h>" end
	c_set_stipple			(p: POINTER; i: INTEGER) is    external "C struct XGCValues access stipple			 type Pixmap use <X11/Xlib.h>" end
	c_set_ts_x_origin		(p: POINTER; i: INTEGER) is    external "C struct XGCValues access ts_x_origin		 type int use <X11/Xlib.h>" end
	c_set_ts_y_origin		(p: POINTER; i: INTEGER) is    external "C struct XGCValues access ts_y_origin		 type int use <X11/Xlib.h>" end
	c_set_font				(p: POINTER; i: INTEGER) is    external "C struct XGCValues access font				 type Font use <X11/Xlib.h>" end
	c_set_subwindow_mode	(p: POINTER; i: INTEGER) is    external "C struct XGCValues access subwindow_mode	 type int use <X11/Xlib.h>" end
	c_set_graphics_exposures(p: POINTER; i: INTEGER) is    external "C struct XGCValues access graphics_exposures type int use <X11/Xlib.h>" end
	c_set_clip_x_origin		(p: POINTER; i: INTEGER) is    external "C struct XGCValues access clip_x_origin	 type int use <X11/Xlib.h>" end
	c_set_clip_y_origin		(p: POINTER; i: INTEGER) is    external "C struct XGCValues access clip_y_origin	 type int use <X11/Xlib.h>" end
	
	c_set_clip_mask			(p: POINTER; i: INTEGER) is    external "C struct XGCValues access clip_mask		 type Pixmap use <X11/Xlib.h>" end
	c_set_dash_offset		(p: POINTER; i: INTEGER) is    external "C struct XGCValues access dash_offset		 type int use <X11/Xlib.h>" end
	c_set_dashes			(p: POINTER; i: CHARACTER) is    external "C struct XGCValues access dashes			 type char use <X11/Xlib.h>" end

feature -- Debug tracing

	tracing_enabled: BOOLEAN is False

	trace is
		do
--			if tracing_enabled then
--				if flags = 0 then
--					edp_trace.simple(0, once "X_GC_VALUES::trace - flags = 0 !!!")
--					print_run_time_stack
--				else
--					edp_trace.simple(0, once "X_GC_VALUES::trace")
--					if (flags & Gc_function 			) /= 0 then edp_trace.start(0, once "function " 			).next( function.out			).done end
--					if (flags & Gc_plane_mask 			) /= 0 then edp_trace.start(0, once "plane_mask " 			).next( plane_mask.out			).done end
--					if (flags & Gc_foreground 			) /= 0 then edp_trace.start(0, once "foreground " 			).next( foreground.out			).done end
--					if (flags & Gc_background 			) /= 0 then edp_trace.start(0, once "background " 			).next( background.out			).done end
--					if (flags & Gc_line_width 			) /= 0 then edp_trace.start(0, once "line_width " 			).next( line_width.out			).done end
--					if (flags & Gc_line_style 			) /= 0 then edp_trace.start(0, once "line_style " 			).next( line_style.out			).done end
--					if (flags & Gc_cap_style 			) /= 0 then edp_trace.start(0, once "cap_style " 			).next( cap_style.out			).done end
--					if (flags & Gc_join_style 			) /= 0 then edp_trace.start(0, once "join_style " 			).next( join_style.out			).done end
--					if (flags & Gc_fill_style 			) /= 0 then edp_trace.start(0, once "fill_style " 			).next( fill_style.out			).done end
--					if (flags & Gc_fill_rule 			) /= 0 then edp_trace.start(0, once "fill_rule " 			).next( fill_rule.out			).done end
--					if (flags & Gc_arc_mode 			) /= 0 then edp_trace.start(0, once "arc_mode " 			).next( arc_mode.out			).done end
--					if (flags & Gc_tile 				) /= 0 then edp_trace.start(0, once "tile " 				).next( tile.out				).done end
--					if (flags & Gc_stipple 				) /= 0 then edp_trace.start(0, once "stipple " 				).next( stipple.out				).done end
--					if (flags & Gc_tile_stip_x_origin 	) /= 0 then edp_trace.start(0, once "tile_stip_x_origin " 	).next( ts_x_origin.out			).done end
--					if (flags & Gc_tile_stip_y_origin 	) /= 0 then edp_trace.start(0, once "tile_stip_y_origin " 	).next( ts_y_origin.out			).done end
--					if (flags & Gc_font 				) /= 0 then edp_trace.start(0, once "font " 				).next( font.out				).done end
--					if (flags & Gc_subwindow_mode 		) /= 0 then edp_trace.start(0, once "subwindow_mode " 		).next( subwindow_mode.out		).done end
--					if (flags & Gc_graphics_exposures 	) /= 0 then edp_trace.start(0, once "graphics_exposures " 	).next( graphics_exposures.out	).done end
--					if (flags & Gc_clip_x_origin 		) /= 0 then edp_trace.start(0, once "clip_x_origin " 		).next( clip_x_origin.out		).done end
--					if (flags & Gc_clip_y_origin 		) /= 0 then edp_trace.start(0, once "clip_y_origin " 		).next( clip_y_origin.out		).done end
--					if (flags & Gc_clip_mask 			) /= 0 then edp_trace.start(0, once "clip_mask " 			).next( clip_mask.out			).done end
--					if (flags & Gc_dash_offset 			) /= 0 then edp_trace.start(0, once "dash_offset " 			).next( dash_offset.out			).done end
--					if (flags & Gc_dash_list 			) /= 0 then edp_trace.start(0, once "dash_list " 			).next( dashes.out				).done end
--				end
--			end
		end

end 
