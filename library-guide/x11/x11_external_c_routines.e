note
	description: "[
		Eiffel external routine declarations for the
		X Window System Version 11
		This file contains renamed external calls to enable wrapping of the
		actual call for tracing purposes.
	]"
	author:	"Howard Thomson"
	copyright: "Copyright (c) 2006, Howard Thomson"
	license: "Eiffel Forum License v2 (see forum.txt)"
	todo: "[
		For 64-bit compatibility, alter most (?) INTEGER declarations
		to 'like long_anchor', where long_anchor is either INTEGER/INTEGER
		for 32-bit platforms, or INTEGER_64 for 64-bit platforms.
	]"

class X11_EXTERNAL_C_ROUTINES

inherit
	X_PORTABILITY_ROUTINES
	SB_ANY

feature -- X11 Routines and Functions

	c_XFree, c_x_free (ptr: POINTER): INTEGER
			--	extern int XFree(
			--	    void*		/* data */
			--	);
		external "C signature (void *): int use <X11/Xlib.h>"
		alias "XFree"
		end

	c_XOpenDisplay, c_x_open_display(dsp: POINTER): POINTER
		external "C use <X11/Xlib.h>"
		alias "XOpenDisplay"
		end

	c_XAllPlanes, c_x_all_planes: INTEGER
		external "C signature (): unsigned long use <X11/Xlib.h>"
		alias "XAllPlanes"		
		end

	c_XBlackPixel, c_x_black_pixel(display: POINTER; screen: INTEGER): INTEGER
		external "C use <X11/Xlib.h>"	
		alias "XBlackPixel"		
		end

	c_XWhitePixel, c_x_white_pixel(display: POINTER; screen: INTEGER): INTEGER
		external "C use <X11/Xlib.h>"	
		alias "XWhitePixel"		
		end

	c_XConnectionNumber, c_x_connection_number(display: POINTER): INTEGER
		-- The file descriptor by which the X display is accessed
		external "C use <X11/Xlib.h>"	
		alias "XConnectionNumber"		
		end

	c_XDefaultColormap, c_x_default_colormap(display: POINTER; screen: INTEGER): INTEGER
		external "C use <X11/Xlib.h>"	
		alias "XDefaultColormap"		
		end

	c_XDefaultDepth, c_x_default_depth(display: POINTER; screen: INTEGER): INTEGER
		external "C use <X11/Xlib.h>"	
		alias "XDefaultDepth"		
		end

	c_XListDepths, c_x_list_depths(display: POINTER; screen: INTEGER; count_return: POINTER): POINTER
			-- 
		external "C use <X11/Xlib.h>"	
		alias "XListDepths"		
		end

	c_XDefaultGC, c_x_default_gc(display: POINTER; screen: INTEGER): POINTER
		-- This gc should NOT be freed!
		external "C use <X11/Xlib.h>"	
		alias "XDefaultGC"		
		end

	c_XDefaultRootWindow, c_x_default_root_window(display: POINTER): INTEGER
		external "C use <X11/Xlib.h>"	
		alias "XDefaultRootWindow"		
		end

	c_XDefaultScreenOfDisplay, c_x_default_screen_of_display(display: POINTER): POINTER
		external "C use <X11/Xlib.h>"	
		alias "XDefaultScreenOfDisplay"
		end
		
	-- x_screen_of_display
	-- x_default_screen



	c_XInternAtom, c_x_intern_atom (d, s: POINTER; b: BOOLEAN): INTEGER
    	external "C use <X11/Xlib.h>"
    	alias "XInternAtom"
    	end

	c_XGetAtomName, c_x_get_atom_name (d: POINTER; i: INTEGER) : POINTER
    	external "C use <X11/Xlib.h>"
    	alias "XGetAtomName"
    	end

  	c_XCloseDisplay, c_x_close_display (ptr: POINTER)
    	external "C use <X11/Xlib.h>"
    	alias "XCloseDisplay"
    	end
  
	c_XDisplayString, c_x_display_string (ptr: POINTER) : POINTER
		external "C use <X11/Xlib.h>"
    	alias "XDisplayString"
    	end

	c_XScreenCount, c_x_screen_count (disp: POINTER) : INTEGER
		external "C use <X11/Xlib.h>"
		alias "XScreenCount"
		end

	c_XDefaultScreen, c_x_default_screen (disp: POINTER) : INTEGER
    	external "C use <X11/Xlib.h>"
    	alias "XDefaultScreen"
    	end

	c_XDisplayWidth, c_x_display_width (disp : POINTER; scr : INTEGER) : INTEGER
    	external "C use <X11/Xlib.h>"
    	alias "XDisplayWidth"
    	end

  	c_XDisplayHeight, c_x_display_height (disp: POINTER; scr: INTEGER) : INTEGER
   		external "C use <X11/Xlib.h>"
    	alias "XDisplayHeight"
    	end

  	c_XDisplayWidthMM, c_x_display_width_mm (disp: POINTER; scr: INTEGER) : INTEGER
    	external "C use <X11/Xlib.h>"
    	alias "XDisplayWidthMM"
    	end

	c_XDisplayHeightMM, c_x_display_height_mm (disp: POINTER; scr: INTEGER) : INTEGER
    	external "C use <X11/Xlib.h>"
    	alias "XDisplayHeightMM"
    	end

  	c_XDisplayCells, c_x_display_cells (d: POINTER; scr: INTEGER) : INTEGER
    	external "C use <X11/Xlib.h>"
    	alias "XDisplayCells"
    	end

  	c_XDefaultVisual, c_x_default_visual (disp: POINTER; scr: INTEGER) : POINTER
    	external "C use <X11/Xlib.h>"
    	alias "XDefaultVisual"
    	end

--	c_XDefaultDepth, c_x_default_depth (disp: POINTER; scr: INTEGER) : INTEGER is
--    	external "C use <X11/Xlib.h>"
--    	alias "XDefaultDepth"
--    	end

  	c_XRootWindow, c_x_root_window (disp: POINTER; scr: INTEGER) : INTEGER
    	external "C use <X11/Xlib.h>"
    	alias "XRootWindow"
    	end

--	c_XListDepths, c_x_list_depths (disp: POINTER; i: INTEGER; c: POINTER) : POINTER is
--    	external "C use <X11/Xlib.h>"
--    	alias "XListDepths"
--    	end

  	c_XFlush, c_x_flush (disp : POINTER)
    	external "C use <X11/Xlib.h>"
    	alias "XFlush"
    	end

  	c_XSync, c_x_sync (disp : POINTER; b : BOOLEAN)
    	external "C use <X11/Xlib.h>"
    	alias "XSync"
    	end

  	c_XProtocolVersion, c_x_protocol_version (disp : POINTER) : INTEGER
    	external "C use <X11/Xlib.h>"
    	alias "XProtocolVersion"
    	end

  	c_XProtocolRevision, c_x_protocol_revision (disp : POINTER) : INTEGER
    	external "C use <X11/Xlib.h>"
    	alias "XProtocolRevision"
    	end

  	c_XVendorRelease, c_x_vendor_release (disp : POINTER) : INTEGER
    	external "C use <X11/Xlib.h>"
    	alias "XVendorRelease"
    	end

  	c_XServerVendor, c_x_server_vendor (disp : POINTER) : POINTER
    	external "C use <X11/Xlib.h>"
    	alias "XServerVendor"
    	end

  	c_XSetCloseDownMode, c_x_set_close_down_mode (disp : POINTER; i : INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XSetCloseDownMode"
    	end

  	c_XKillClient, c_x_kill_client (disp : POINTER; i : INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XKillClient"
    	end

  	c_XListFonts, c_x_list_fonts (disp, str : POINTER; i : INTEGER; p : POINTER) : POINTER
    	external "C use <X11/Xlib.h>"
    	alias "XListFonts"
    	end

  	c_XGetFontPath, c_x_get_font_path (disp : POINTER; p : POINTER) : POINTER
    	external "C use <X11/Xlib.h>"
    	alias "XGetFontPath"
    	end

  	c_XSetFontPath, c_x_set_font_path (disp : POINTER; p : POINTER; i : INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XSetFontPath"
    	end

  	c_XBell, c_x_bell (disp : POINTER; i : INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XBell"
    	end

  	c_XAutoRepeatOn, c_x_auto_repeat_on (disp : POINTER)
    	external "C use <X11/Xlib.h>"
    	alias "XAutoRepeatOn"
    	end

  	c_XAutoRepeatOff, c_x_auto_repeat_off (disp : POINTER)
    	external "C use <X11/Xlib.h>"
    	alias "XAutoRepeatOff"
    	end

  	c_XScreenOfDisplay, c_x_screen_of_display (disp : POINTER; i : INTEGER) : POINTER
    	external "C use <X11/Xlib.h>"
    	alias "XScreenOfDisplay"
    	end

--  	c_XConnectionNumber, c_x_connection_number (disp : POINTER) : INTEGER is
--    	external "C use <X11/Xlib.h>"
--    	alias "XConnectionNumber"
--    	end

  	c_XMaxRequestSize, c_x_max_request_size (disp : POINTER) : INTEGER
    	external "C use <X11/Xlib.h>"
    	alias "XMaxRequestSize"
    	end

  	c_XExtendedMaxRequestSize, c_x_extended_max_request_size (disp : POINTER) : INTEGER
    	external "C use <X11/Xlib.h>"
    	alias "XExtendedMaxRequestSize"
    	end

  	c_XLastKnownRequestProcessed, c_x_last_known_request_processed (disp : POINTER) : INTEGER
    	external "C use <X11/Xlib.h>"
    	alias "XLastKnownRequestProcessed"
    	end

  	c_XNextRequest, c_x_next_request (disp : POINTER) : INTEGER
    	external "C use <X11/Xlib.h>"
    	alias "XNextRequest"
    	end

	c_XQLength, c_x_q_length (disp : POINTER) : INTEGER
    	external "C use <X11/Xlib.h>"
    	alias "XQLength"
    	end

  	c_XStoreBytes, c_x_store_bytes (disp, buf: POINTER; n : INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XStoreBytes"
    	end

  	c_XFetchBytes, c_x_fetch_bytes (disp, n: POINTER) : POINTER
    	external "C use <X11/Xlib.h>"
    	alias "XFetchBytes"
    	end

  	c_XStoreBuffer, c_x_store_buffer (disp, buf: POINTER; n, nb : INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XStoreBuffer"
    	end

  	c_XFetchBuffer, c_x_fetch_buffer (disp, n: POINTER; nb : INTEGER) : POINTER
    	external "C use <X11/Xlib.h>"
    	alias "XFetchBuffer"
    	end

  	c_XRotateBuffers, c_x_rotate_buffers (disp: POINTER; nb : INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XRotateBuffers"
    	end

feature -- Event Handling

	XNextEvent, c_x_next_event (d, buf: POINTER)
		external "C use <X11/Xlib.h>"
    	alias "XNextEvent"
    	end

	c_XPeekEvent, c_x_peek_event (d, buf: POINTER)
    	external "C use <X11/Xlib.h>"
    	alias "XPeekEvent"
    	end

  	c_XCheckWindowEvent, c_x_check_window_event (d: POINTER; wid, msk : INTEGER; 
                        buf : POINTER) : INTEGER
    	external "C use <X11/Xlib.h>"
    	alias "XCheckWindowEvent"
    	end

  	c_XCheckTypedWindowEvent, c_x_check_typed_window_event (d: POINTER; wid, typ : INTEGER; 
                              buf : POINTER) : INTEGER
    	external "C use <X11/Xlib.h>"
    	alias "XCheckTypedWindowEvent"
    	end

  	c_XCheckMaskEvent, c_x_check_mask_event (d: POINTER; msk : INTEGER; buf : POINTER) : INTEGER
    	external "C use <X11/Xlib.h>"
    	alias "XCheckMaskEvent"
    	end

  	c_XCheckTypedEvent, c_x_check_typed_event (d: POINTER; typ : INTEGER; buf : POINTER) : INTEGER
    	external "C use <X11/Xlib.h>"
    	alias "XCheckTypedEvent"
    	end

  	c_XWindowEvent, c_x_window_event (d: POINTER; wid, msk : INTEGER; buf : POINTER)
    	external "C use <X11/Xlib.h>"
    	alias "XWindowEvent"
    	end

  	c_XMaskEvent, c_x_mask_event (d: POINTER; msk : INTEGER; buf : POINTER)
    	external "C use <X11/Xlib.h>"
    	alias "XMaskEvent"
    	end

  	c_XPutBackEvent, c_x_put_back_event (d: POINTER; buf : POINTER)
    	external "C use <X11/Xlib.h>"
    	alias "XPutBackEvent"
    	end

  	c_XSendEvent, c_x_send_event (d: POINTER; wid : INTEGER; 
                p : BOOLEAN; msk : INTEGER; ev : POINTER) : BOOLEAN
    	external "C use <X11/Xlib.h>"
    	alias "XSendEvent"
    	end

  	c_XAllowEvents, c_x_allow_events (d : POINTER; type, time : INTEGER)
  		external "C use <X11/Xlib.h>"
    	alias "XAllowEvents"
    	end

  	c_XEventsQueued, c_x_events_queued (d: POINTER; m : INTEGER) : INTEGER
    	external "C use <X11/Xlib.h>"
    	alias "XEventsQueued"
    	end

feature -- XContext routines

	c_XrmUniqueQuark, c_x_create_context: INTEGER
		external
			"C use <X11/Xlib.h>"
			alias "XrmUniqueQuark"
		end

	c_XSaveContext, c_x_save_context(disp: POINTER; w, context: INTEGER; pw: POINTER): INTEGER
		external
			"C use <X11/Xlib.h>"
			alias "XSaveContext"
		end

	c_XFindContext, c_x_find_context(disp: POINTER; w, context: INTEGER; pres: POINTER): INTEGER
		external
			"C use <X11/Xlib.h>"
			alias "XFindContext"
		end

	c_XDeleteContext, c_x_delete_context(disp: POINTER; w: INTEGER; context: INTEGER): INTEGER
		external
			"C use <X11/Xlib.h>"
			alias "XDeleteContext"
		end

feature -- GC routines

  	c_XCreateGC, c_x_create_gc (d : POINTER; wid, mask : INTEGER; p : POINTER) : POINTER
    	external "C use <X11/Xlib.h>"
    	alias "XCreateGC"
    	end

  	c_XFreeGC, c_x_free_gc (d, ctxt : POINTER)
    	external "C use <X11/Xlib.h>"
    	alias "XFreeGC"
    	end

  	c_XGetGCValues, c_x_get_gc_values (d, ctxt : POINTER; m : INTEGER; v : POINTER)
    	external "C use <X11/Xlib.h>"
    	alias "XGetGCValues"
    	end

  	c_XChangeGC, c_x_change_gc (d, ctxt : POINTER; m: like long_anchor; v : POINTER)
    	external "C use <X11/Xlib.h>"
    	alias "XChangeGC"
    	end

  	c_XSetFont, c_x_set_font (d, ctxt : POINTER; fid : INTEGER)
   	 	external "C use <X11/Xlib.h>"
    	alias "XSetFont"
    	end

  	c_XSetBackground, c_x_set_background (d, ctxt : POINTER; pix : INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XSetBackground"
    	end

  	c_XSetForeground, c_x_set_foreground (d, ctxt : POINTER; pix : INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XSetForeground"
    	end

  	c_XSetFunction, c_x_set_function (d, ctxt : POINTER; f : INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XSetFunction"
    	end

  	c_XSetLineAttributes, c_x_set_line_attributes (d, ctxt : POINTER; w, l, b, j : INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XSetLineAttributes"
    	end

  	c_XSetArcMode, c_x_set_arc_mode (d, ctxt : POINTER; f : INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XSetArcMode"
    	end

  	c_XSetFillRule, c_x_set_fill_rule (d, ctxt : POINTER; r : INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XSetFillRule"
    	end

  	c_XSetFillStyle, c_x_set_fill_style (d, ctxt : POINTER; s : INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XSetFillStyle"
    	end

  	c_XSetDashes, c_x_set_dashes (d, ctxt : POINTER; o : INTEGER; 
                buf : POINTER; n : INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XSetDashes"
    	end

  	c_XSetStipple, c_x_set_stipple (d, ctxt : POINTER; pid : INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XSetStipple"
    	end

  	c_XSetTile, c_x_set_tile (d, ctxt : POINTER; pid : INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XSetTile"
    	end

  	c_XSetTSOrigin, c_x_set_ts_origin (d, ctxt : POINTER; x, y : INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XSetTSOrigin"
    	end

  	c_XSetClipMask, c_x_set_clip_mask (d, ctxt : POINTER; pid : INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XSetClipMask"
    	end

  	c_XSetClipOrigin, c_x_set_clip_origin (d, ctxt : POINTER; x, y : INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XSetClipOrigin"
    	end

  	c_XSetClipRectangles, c_x_set_clip_rectangles (d, ctxt : POINTER; x, y : INTEGER; 
                         buf : POINTER; size : INTEGER; sort: INTEGER)
    	external "C use <X11/Xlib.h>"
   	 	alias "XSetClipRectangles"
    	end

  	c_XSetSubwindowMode, c_x_set_subwindow_mode (d, ctxt : POINTER; mode : INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XSetSubwindowMode"
    	end

  	c_XSetGraphicsExposures, c_x_set_graphics_exposures (d, ctxt : POINTER; b : BOOLEAN)
    	external "C use <X11/Xlib.h>"
    	alias "XSetGraphicsExposures"
    	end

  	c_XSetRegion, c_x_set_region (d, ctxt, r : POINTER)
    	external "C use <X11/Xlib.h>"
    	alias "XSetRegion"
    	end

feature -- Drawable routines

	c_XDrawPoint, c_x_draw_point (d : POINTER; rid : INTEGER; xgc : POINTER; x, y : INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XDrawPoint"
    	end

	c_XDrawPoints, c_x_draw_points (d : POINTER; rid : INTEGER; xgc : POINTER; 
                 buf : POINTER; n, mode : INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XDrawPoints"
    	end

  	c_XDrawLine, c_x_draw_line (d : POINTER; rid : INTEGER; xgc : POINTER; 
               x1, y1, x2, y2 : INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XDrawLine"
    	end

  	c_XDrawLines, c_x_draw_lines (d : POINTER; rid : INTEGER; xgc : POINTER; 
                buf : POINTER; n, mode : INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XDrawLines"
    	end

  	c_XDrawSegments, c_x_draw_segments (d : POINTER; rid : INTEGER; xgc : POINTER; 
                   buf : POINTER; n : INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XDrawSegments"
    	end

  	c_XDrawArc, c_x_draw_arc (d : POINTER; rid : INTEGER; xgc : POINTER; 
              x, y, w, h, a1, a2 : INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XDrawArc"
    	end

  	c_XDrawArcs, c_x_draw_arcs (d : POINTER; rid : INTEGER; xgc : POINTER; 
               buf : POINTER; n : INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XDrawArcs"
    	end

  	c_XFillArc, c_x_fill_arc (d : POINTER; rid : INTEGER; xgc : POINTER; 
              x, y, w, h, a1, a2 : INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XFillArc"
    	end

  	c_XFillArcs, c_x_fill_arcs (d : POINTER; rid : INTEGER; xgc : POINTER; 
               buf : POINTER; n : INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XFillArcs"
    	end

  	c_XDrawRectangle, c_x_draw_rectangle (d : POINTER; rid : INTEGER; xgc : POINTER; 
                    x, y, w, h : INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XDrawRectangle"
    	end

  	c_XDrawRectangles, c_x_draw_rectangles (d : POINTER; rid : INTEGER; xgc : POINTER; 
                     buf : POINTER; n : INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XDrawRectangles"
    	end

  	c_XFillRectangle, c_x_fill_rectangle (d : POINTER; rid : INTEGER; xgc : POINTER; 
                    x, y, w, h : INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XFillRectangle"
    	end

  	c_XFillRectangles, c_x_fill_rectangles (d : POINTER; rid : INTEGER; xgc : POINTER; 
                     buf : POINTER; n : INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XFillRectangles"
    	end

  	c_XFillPolygon, c_x_fill_polygon (d : POINTER; rid : INTEGER; xgc : POINTER; 
                  buf : POINTER; n, mode1, mode2 : INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XFillPolygon"
    	end

  	c_XDrawString, c_x_draw_string (d : POINTER; rid : INTEGER; xgc : POINTER;
                 x, y : INTEGER; txt : POINTER; len : INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XDrawString"
    	end

  	c_XDrawImageString, c_x_draw_image_string (d : POINTER; rid : INTEGER; xgc : POINTER;
                       x, y : INTEGER; txt : POINTER; len : INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XDrawImageString"
    	end

  	c_XDrawText, c_x_draw_text (d : POINTER; rid : INTEGER; xgc : POINTER;
               x, y : INTEGER; buf : POINTER; n : INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XDrawText"
    	end

  	c_XCopyArea, c_x_copy_area (d : POINTER; oid, rid : INTEGER; xgc : POINTER;
               ox, oy, ow, oh, x, y : INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XCopyArea"
    	end

  	c_XCopyPlane, c_x_copy_plane (d : POINTER; oid, rid : INTEGER; xgc : POINTER;
                ox, oy, ow, oh, x, y, plane_mask : INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XCopyPlane"
    	end

  	c_XPutImage, c_x_put_image (d : POINTER; rid : INTEGER; xgc, xim : POINTER;
	       ox, oy, ow, oh, x, y : INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XPutImage"
    	end

	c_XLookupString, c_x_lookup_string (ev, buf: POINTER; 
		   n: INTEGER;
		   ks, p: POINTER): INTEGER
    	external "C use <X11/Xutil.h>"
    	alias "XLookupString"
    	end

--	c_XWithDrawWindow, c_x_withdraw_window (d: POINTER; rid, scr: INTEGER) is
--		external "C use <X11/Xlib.h>"
--		alias "XWithdrawWindow"
--		end


end
