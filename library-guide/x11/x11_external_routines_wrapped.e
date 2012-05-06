note
	description: "[
		Eiffel external routine declarations for the
		X Window System Version 11
		This file contains wrapper routines to stack trace troublesome calls.
	]"
	author:	"Howard Thomson"
	copyright: "Copyright (c) 2006, Howard Thomson"
	license: "Eiffel Forum License v2 (see forum.txt)"

	todo: "[
		For 64-bit compatibility, alter most (?) INTEGER declarations
		to 'like long_anchor', where long_anchor is either INTEGER/INTEGER
		for 32-bit platforms, or INTEGER_64 for 64-bit platforms.

		Move conditional 'if trace_x' to each routine, avoiding unused <<...>>
		array creation for x_trace calls
	]"

class X11_EXTERNAL_ROUTINES_WRAPPED

inherit
	X11_EXTERNAL_C_ROUTINES
	X_PORTABILITY_ROUTINES

feature -- X11 Tracing facilities

	trace_x: BOOLEAN = False

feature -- X11 Routines and Functions

	XFree, x_free (ptr: POINTER): INTEGER
		do
			if trace_x then edp_trace.st(once "XFree(").n(ptr.out).n(once ")").d end
			Result := c_XFree(ptr)
		end

	XOpenDisplay, x_open_display(dsp: POINTER): POINTER
		do
			if trace_x then edp_trace.st(once "XOpenDisplay: Serial: ").n(c_XNextRequest(dsp).out).d end
			Result := c_XOpenDisplay(dsp)
		end

	XAllPlanes, x_all_planes: INTEGER
		do
			Result := c_XAllPlanes
			if trace_x then edp_trace.st(once "XAllPlanes() = ").n(Result.out).d end
		end

	XBlackPixel, x_black_pixel(display: POINTER; screen: INTEGER): INTEGER
		do
			if screen /= 0 then
				edp_trace.st(once "XBlackPixel -- screen /= 0 !!").d
			--	crash
			end
			Result := c_XBlackPixel(display, screen)
			if trace_x then edp_trace.st(once "XBlackPixel(display = ").n(display.out).n(once ", screen = ").n(screen.out).n(once ") = ").n(Result.out).d end
		end

	XWhitePixel, x_white_pixel(display: POINTER; screen: INTEGER): INTEGER
		do
			Result := c_XWhitePixel(display, screen)
			if trace_x then edp_trace.st(once "XWhitePixel(display = ").n(display.out).n(once ", screen = ").n(screen.out).n(once ") = ").n(Result.out).d end
		end

	XConnectionNumber, x_connection_number(display: POINTER): INTEGER
		-- The file descriptor by which the X display is accessed
		do
			Result := c_XConnectionNumber(display)
		end

	XDefaultColormap, x_default_colormap(display: POINTER; screen: INTEGER): INTEGER
		do
			Result := c_XDefaultColormap(display, screen)
			if trace_x then edp_trace.st(once "XDefaultColormap(display = ").n(display.out).n(once ", screen = ").n(screen.out).n(once ") = ").n(Result.out).d end
		end

	XDefaultDepth, x_default_depth(display: POINTER; screen: INTEGER): INTEGER
		do
			Result := c_XDefaultDepth(display, screen)
			if trace_x then edp_trace.st(once "XDefaultDepth(display = ").n(display.out).n(once ", screen = ").n(screen.out).n(once ") = ").n(Result.out).d end
		end

	XListDepths, x_list_depths(display: POINTER; screen: INTEGER; count_return: POINTER): POINTER
			-- 
		do
			Result := c_XListDepths(display, screen, count_return)
		end

	XDefaultGC, x_default_gc(display: POINTER; screen: INTEGER): POINTER
		-- This gc should NOT be freed!
		do
			Result := c_XDefaultGC(display, screen)
			if trace_x then edp_trace.st(once "XDefaultGC(display = ").n(display.out).n(once ", screen = ").n(screen.out).n(once ") = ").n(Result.out).d end
		end

	XDefaultRootWindow, x_default_root_window(display: POINTER): INTEGER
		do
			Result := c_XDefaultRootWindow(display)
			if trace_x then edp_trace.st(once "XDefaultRootWindow(display = ").n(display.out).n(once ") = ").n(Result.out).d end
		end

	XDefaultScreenOfDisplay, x_default_screen_of_display(display: POINTER): POINTER
		do
			Result := c_XDefaultScreenOfDisplay(display)
			if trace_x then edp_trace.st(once "XDefaultScreenOfDisplay(screen = ").n(display.out).n(once ") = ").n(Result.out).d end
		end
		
	-- x_screen_of_display
	-- x_default_screen

	XInternAtom, x_intern_atom (d, s: POINTER; b: BOOLEAN): INTEGER
		do
			Result := c_XInternAtom(d, s, b)
    	end

	XGetAtomName, x_get_atom_name (d: POINTER; i: INTEGER): POINTER
		do
			Result := c_XGetAtomName(d, i)
    	end

  	XCloseDisplay, x_close_display (ptr: POINTER)
		do
			c_XCloseDisplay(ptr)
    	end
  
	XDisplayString, x_display_string (ptr: POINTER): POINTER
		do
			Result := c_XDisplayString(ptr)
    	end

	XScreenCount, x_screen_count (disp: POINTER): INTEGER
		do
			Result := c_XScreenCount(disp)
		end

	XDefaultScreen, x_default_screen (disp: POINTER): INTEGER
		do
			Result := c_XDefaultScreen(disp)
			if trace_x then edp_trace.st(once "XDefaultScreen(display = ").n(disp.out).n(once ") = ").n(Result.out).d end
    	end

	XDisplayWidth, x_display_width (disp: POINTER; scr: INTEGER): INTEGER
		do
			Result := c_XDisplayWidth(disp, scr)
			if trace_x then edp_trace.st(once "XDisplayWidth(display = ").n(disp.out).n(once ", screen = ").n(scr.out).n(once ") = ").n(Result.out).d end
    	end

  	XDisplayHeight, x_display_height (disp: POINTER; scr: INTEGER): INTEGER
		do
			Result := c_XDisplayHeight(disp, scr)
			if trace_x then edp_trace.st(once "XDisplayHeight(display = ").n(disp.out).n(once ", screen = ").n(scr.out).n(once ") = ").n(Result.out).d end
    	end

  	XDisplayWidthMM, x_display_width_mm (disp: POINTER; scr: INTEGER): INTEGER
		do
			Result := c_XDisplayWidthMM(disp, scr)
			if trace_x then edp_trace.st(once "XDisplayWidthMM(display = ").n(disp.out).n(once ", screen = ").n(scr.out).n(once ") = ").n(Result.out).d end
    	end

	XDisplayHeightMM, x_display_height_mm (disp: POINTER; scr: INTEGER): INTEGER
		do
			Result := c_XDisplayHeightMM(disp, scr)
			if trace_x then edp_trace.st(once "XDisplayHeightMM(display = ").n(disp.out).n(once ", screen = ").n(scr.out).n(once ") = ").n(Result.out).d end
    	end

  	XDisplayCells, x_display_cells (d: POINTER; scr: INTEGER): INTEGER
		do
			Result := c_XDisplayCells(d, scr)
			if trace_x then edp_trace.st(once "XDisplayCells(display = ").n(d.out).n(once ", screen = ").n(scr.out).n(once ") = ").n(Result.out).d end
    	end

  	XDefaultVisual, x_default_visual (disp: POINTER; scr: INTEGER): POINTER
		do
			Result := c_XDefaultVisual(disp, scr)
			if trace_x then edp_trace.st(once "XDefaultVisual(display = ").n(disp.out).n(once ", screen = ").n(scr.out).n(once ") = ").n(Result.out).d end
    	end

--	XDefaultDepth, x_default_depth (disp: POINTER; scr: INTEGER): INTEGER is
--    	external "C use <X11/Xlib.h>"
--    	alias "XDefaultDepth"
--    	end

  	XRootWindow, x_root_window (disp: POINTER; scr: INTEGER): INTEGER
		do
			Result := c_XRootWindow(disp, scr)
			if trace_x then edp_trace.st(once "XRootWindow(display = ").n(disp.out).n(once ", screen = ").n(scr.out).n(once ") = ").n(Result.out).d end
    	end

--	XListDepths, x_list_depths (disp: POINTER; i: INTEGER; c: POINTER): POINTER is
--    	external "C use <X11/Xlib.h>"
--    	alias "XListDepths"
--    	end

  	XFlush, x_flush (disp: POINTER)
		do
			c_XFlush(disp)
    	end

  	XSync, x_sync (disp: POINTER; b: BOOLEAN)
		do
			c_XSync(disp, b)
    	end

  	XProtocolVersion, x_protocol_version (disp: POINTER): INTEGER
		do
			Result := c_XProtocolVersion(disp)
    	end

  	XProtocolRevision, x_protocol_revision (disp: POINTER): INTEGER
		do
			Result := c_XProtocolRevision(disp)
    	end

  	XVendorRelease, x_vendor_release (disp: POINTER): INTEGER
		do
			Result := c_XVendorRelease(disp)
    	end

  	XServerVendor, x_server_vendor (disp: POINTER): POINTER
		do
			Result := c_XServerVendor(disp)
    	end

  	XSetCloseDownMode, x_set_close_down_mode (disp: POINTER; i: INTEGER)
		do
			c_XSetCloseDownMode(disp, i)
			if trace_x then edp_trace.st(once "XSetCloseDownMode(display = ").n(disp.out).n(once ", ?? = ").n(i.out).n(once ")").d end
    	end

  	XKillClient, x_kill_client (disp: POINTER; i: INTEGER)
		do
			c_XKillClient(disp, i)
    	end

  	XListFonts, x_list_fonts (disp, str: POINTER; i: INTEGER; p: POINTER): POINTER
		do
		--	fx_trace(0, <<"XListFonts: Serial: ", c_XNextRequest(disp).out>>)
			Result := c_XListFonts(disp, str, i, p)
    	end

  	XGetFontPath, x_get_font_path (disp: POINTER; p: POINTER): POINTER
		do
			Result := c_XGetFontPath(disp, p)
    	end

  	XSetFontPath, x_set_font_path (disp: POINTER; p: POINTER; i: INTEGER)
		do
			c_XSetFontPath(disp, p, i)
    	end

  	XBell, x_bell (disp: POINTER; i: INTEGER)
		do
			c_XBell(disp, i)
    	end

  	XAutoRepeatOn, x_auto_repeat_on (disp: POINTER)
		do
			c_XAutoRepeatOn(disp)
    	end

  	cc_XAutoRepeatOff, x_auto_repeat_off (disp: POINTER)
    	external "C use <X11/Xlib.h>"
    	alias "XAutoRepeatOff"
    	end

  	cc_XScreenOfDisplay, x_screen_of_display (disp: POINTER; i: INTEGER): POINTER
    	external "C use <X11/Xlib.h>"
    	alias "XScreenOfDisplay"
    	end

--  	cc_XConnectionNumber, x_connection_number (disp: POINTER): INTEGER is
--    	external "C use <X11/Xlib.h>"
--    	alias "XConnectionNumber"
--    	end

  	cc_XMaxRequestSize, x_max_request_size (disp: POINTER): INTEGER
    	external "C use <X11/Xlib.h>"
    	alias "XMaxRequestSize"
    	end

  	cc_XExtendedMaxRequestSize, x_extended_max_request_size (disp: POINTER): INTEGER
    	external "C use <X11/Xlib.h>"
    	alias "XExtendedMaxRequestSize"
    	end

  	cc_XLastKnownRequestProcessed, x_last_known_request_processed (disp: POINTER): INTEGER
    	external "C use <X11/Xlib.h>"
    	alias "XLastKnownRequestProcessed"
    	end

  	cc_XNextRequest, x_next_request (disp: POINTER): INTEGER
    	external "C use <X11/Xlib.h>"
    	alias "XNextRequest"
    	end

	cc_XQLength, x_q_length (disp: POINTER): INTEGER
    	external "C use <X11/Xlib.h>"
    	alias "XQLength"
    	end

  	cc_XStoreBytes, x_store_bytes (disp, buf: POINTER; n: INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XStoreBytes"
    	end

  	cc_XFetchBytes, x_fetch_bytes (disp, n: POINTER): POINTER
    	external "C use <X11/Xlib.h>"
    	alias "XFetchBytes"
    	end

  	cc_XStoreBuffer, x_store_buffer (disp, buf: POINTER; n, nb: INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XStoreBuffer"
    	end

  	cc_XFetchBuffer, x_fetch_buffer (disp, n: POINTER; nb: INTEGER): POINTER
    	external "C use <X11/Xlib.h>"
    	alias "XFetchBuffer"
    	end

  	cc_XRotateBuffers, x_rotate_buffers (disp: POINTER; nb: INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XRotateBuffers"
    	end

feature -- Event Handling

	cc_XNextEvent, x_next_event (d, buf: POINTER)
		external "C use <X11/Xlib.h>"
    	alias "XNextEvent"
    	end

	cc_XPeekEvent, x_peek_event (d, buf: POINTER)
    	external "C use <X11/Xlib.h>"
    	alias "XPeekEvent"
    	end

  	cc_XCheckWindowEvent, x_check_window_event (d: POINTER; wid, msk: INTEGER; 
                        buf: POINTER): INTEGER
    	external "C use <X11/Xlib.h>"
    	alias "XCheckWindowEvent"
    	end

  	cc_XCheckTypedWindowEvent, x_check_typed_window_event (d: POINTER; wid, typ: INTEGER; 
                              buf: POINTER): INTEGER
    	external "C use <X11/Xlib.h>"
    	alias "XCheckTypedWindowEvent"
    	end

  	cc_XCheckMaskEvent, x_check_mask_event (d: POINTER; msk: INTEGER; buf: POINTER): INTEGER
    	external "C use <X11/Xlib.h>"
    	alias "XCheckMaskEvent"
    	end

  	cc_XCheckTypedEvent, x_check_typed_event (d: POINTER; typ: INTEGER; buf: POINTER): INTEGER
    	external "C use <X11/Xlib.h>"
    	alias "XCheckTypedEvent"
    	end

  	cc_XWindowEvent, x_window_event (d: POINTER; wid, msk: INTEGER; buf: POINTER)
    	external "C use <X11/Xlib.h>"
    	alias "XWindowEvent"
    	end

  	cc_XMaskEvent, x_mask_event (d: POINTER; msk: INTEGER; buf: POINTER)
    	external "C use <X11/Xlib.h>"
    	alias "XMaskEvent"
    	end

  	cc_XPutBackEvent, x_put_back_event (d: POINTER; buf: POINTER)
    	external "C use <X11/Xlib.h>"
    	alias "XPutBackEvent"
    	end

  	cc_XSendEvent, x_send_event (d: POINTER; wid: INTEGER; 
                p: BOOLEAN; msk: INTEGER; ev: POINTER): BOOLEAN
    	external "C use <X11/Xlib.h>"
    	alias "XSendEvent"
    	end

  	cc_XAllowEvents, x_allow_events (d: POINTER; type, time: INTEGER)
  		external "C use <X11/Xlib.h>"
    	alias "XAllowEvents"
    	end

  	cc_XEventsQueued, x_events_queued (d: POINTER; m: INTEGER): INTEGER
    	external "C use <X11/Xlib.h>"
    	alias "XEventsQueued"
    	end

feature -- XContext routines

	cc_XrmUniqueQuark, x_create_context: INTEGER
		external
			"C use <X11/Xlib.h>"
			alias "XrmUniqueQuark"
		end

	cc_XSaveContext, x_save_context(disp: POINTER; w, context: INTEGER; pw: POINTER): INTEGER
		external
			"C use <X11/Xlib.h>"
			alias "XSaveContext"
		end

	cc_XFindContext, x_find_context(disp: POINTER; w, context: INTEGER; pres: POINTER): INTEGER
		external
			"C use <X11/Xlib.h>"
			alias "XFindContext"
		end

	cc_XDeleteContext, x_delete_context(disp: POINTER; w: INTEGER; context: INTEGER): INTEGER
		external
			"C use <X11/Xlib.h>"
			alias "XDeleteContext"
		end

feature -- GC routines

  	cc_XCreateGC, x_create_gc (d: POINTER; wid, mask: INTEGER; p: POINTER): POINTER
    	external "C use <X11/Xlib.h>"
    	alias "XCreateGC"
    	end

  	cc_XFreeGC, x_free_gc (d, ctxt: POINTER)
    	external "C use <X11/Xlib.h>"
    	alias "XFreeGC"
    	end

  	cc_XGetGCValues, x_get_gc_values (d, ctxt: POINTER; m: INTEGER; v: POINTER)
    	external "C use <X11/Xlib.h>"
    	alias "XGetGCValues"
    	end

  	XChangeGC, x_change_gc (d, ctxt: POINTER; m: like long_anchor; v: POINTER)
		do
		--	fx_trace(0, <<"XChangeGC: Serial: ", c_XNextRequest(d).out>>)
			c_XChangeGC(d, ctxt, m, v)
    	end

  	cc_XSetFont, x_set_font (d, ctxt: POINTER; fid: INTEGER)
   	 	external "C use <X11/Xlib.h>"
    	alias "XSetFont"
    	end

  	XSetBackground, x_set_background (d, ctxt: POINTER; pix: INTEGER)
		do
		--	fx_trace(0, <<"XSetBackground: Serial: ", c_XNextRequest(d).out>>)
			c_XSetBackground(d, ctxt, pix)
    	end

  	cc_XSetForeground, x_set_foreground (d, ctxt: POINTER; pix: INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XSetForeground"
    	end

  	XSetFunction, x_set_function (d, ctxt: POINTER; f: INTEGER)
		do
			c_XSetFunction(d, ctxt, f)
    	end

  	cc_XSetLineAttributes, x_set_line_attributes (d, ctxt: POINTER; w, l, b, j: INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XSetLineAttributes"
    	end

  	cc_XSetArcMode, x_set_arc_mode (d, ctxt: POINTER; f: INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XSetArcMode"
    	end

  	cc_XSetFillRule, x_set_fill_rule (d, ctxt: POINTER; r: INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XSetFillRule"
    	end

  	XSetFillStyle, x_set_fill_style (d, ctxt: POINTER; s: INTEGER)
		do
			c_XSetFillStyle(d, ctxt, s)
    	end

  	cc_XSetDashes, x_set_dashes (d, ctxt: POINTER; o: INTEGER; 
                buf: POINTER; n: INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XSetDashes"
    	end

  	cc_XSetStipple, x_set_stipple (d, ctxt: POINTER; pid: INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XSetStipple"
    	end

  	cc_XSetTile, x_set_tile (d, ctxt: POINTER; pid: INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XSetTile"
    	end

  	cc_XSetTSOrigin, x_set_ts_origin (d, ctxt: POINTER; x, y: INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XSetTSOrigin"
    	end

  	cc_XSetClipMask, x_set_clip_mask (d, ctxt: POINTER; pid: INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XSetClipMask"
    	end

  	cc_XSetClipOrigin, x_set_clip_origin (d, ctxt: POINTER; x, y: INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XSetClipOrigin"
    	end

  	cc_XSetClipRectangles, x_set_clip_rectangles (d, ctxt: POINTER; x, y: INTEGER; 
                         buf: POINTER; size: INTEGER; sort: INTEGER)
    	external "C use <X11/Xlib.h>"
   	 	alias "XSetClipRectangles"
    	end

  	cc_XSetSubwindowMode, x_set_subwindow_mode (d, ctxt: POINTER; mode: INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XSetSubwindowMode"
    	end

  	cc_XSetGraphicsExposures, x_set_graphics_exposures (d, ctxt: POINTER; b: BOOLEAN)
    	external "C use <X11/Xlib.h>"
    	alias "XSetGraphicsExposures"
    	end

  	cc_XSetRegion, x_set_region (d, ctxt, r: POINTER)
    	external "C use <X11/Xlib.h>"
    	alias "XSetRegion"
    	end

feature -- Drawable routines

	cc_XDrawPoint, x_draw_point (d: POINTER; rid: INTEGER; xgc: POINTER; x, y: INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XDrawPoint"
    	end

	cc_XDrawPoints, x_draw_points (d: POINTER; rid: INTEGER; xgc: POINTER; 
                 buf: POINTER; n, mode: INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XDrawPoints"
    	end

  	cc_XDrawLine, x_draw_line (d: POINTER; rid: INTEGER; xgc: POINTER; 
               x1, y1, x2, y2: INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XDrawLine"
    	end

  	cc_XDrawLines, x_draw_lines (d: POINTER; rid: INTEGER; xgc: POINTER; 
                buf: POINTER; n, mode: INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XDrawLines"
    	end

  	cc_XDrawSegments, x_draw_segments (d: POINTER; rid: INTEGER; xgc: POINTER; 
                   buf: POINTER; n: INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XDrawSegments"
    	end

  	cc_XDrawArc, x_draw_arc (d: POINTER; rid: INTEGER; xgc: POINTER; 
              x, y, w, h, a1, a2: INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XDrawArc"
    	end

  	cc_XDrawArcs, x_draw_arcs (d: POINTER; rid: INTEGER; xgc: POINTER; 
               buf: POINTER; n: INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XDrawArcs"
    	end

  	cc_XFillArc, x_fill_arc (d: POINTER; rid: INTEGER; xgc: POINTER; 
              x, y, w, h, a1, a2: INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XFillArc"
    	end

  	cc_XFillArcs, x_fill_arcs (d: POINTER; rid: INTEGER; xgc: POINTER; 
               buf: POINTER; n: INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XFillArcs"
    	end

  	cc_XDrawRectangle, x_draw_rectangle (d: POINTER; rid: INTEGER; xgc: POINTER; 
                    x, y, w, h: INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XDrawRectangle"
    	end

  	cc_XDrawRectangles, x_draw_rectangles (d: POINTER; rid: INTEGER; xgc: POINTER; 
                     buf: POINTER; n: INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XDrawRectangles"
    	end

  	cc_XFillRectangle, x_fill_rectangle (d: POINTER; rid: INTEGER; xgc: POINTER; 
                    x, y, w, h: INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XFillRectangle"
    	end

  	cc_XFillRectangles, x_fill_rectangles (d: POINTER; rid: INTEGER; xgc: POINTER; 
                     buf: POINTER; n: INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XFillRectangles"
    	end

  	cc_XFillPolygon, x_fill_polygon (d: POINTER; rid: INTEGER; xgc: POINTER; 
                  buf: POINTER; n, mode1, mode2: INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XFillPolygon"
    	end

  	cc_XDrawString, x_draw_string (d: POINTER; rid: INTEGER; xgc: POINTER;
                 x, y: INTEGER; txt: POINTER; len: INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XDrawString"
    	end

  	cc_XDrawImageString, x_draw_image_string (d: POINTER; rid: INTEGER; xgc: POINTER;
                       x, y: INTEGER; txt: POINTER; len: INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XDrawImageString"
    	end

  	cc_XDrawText, x_draw_text (d: POINTER; rid: INTEGER; xgc: POINTER;
               x, y: INTEGER; buf: POINTER; n: INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XDrawText"
    	end

  	XCopyArea, x_copy_area (d: POINTER; oid, rid: INTEGER; xgc: POINTER;
               ox, oy, ow, oh, x, y: INTEGER)
		do
			c_XCopyArea(d, oid, rid, xgc, ox, oy, ow, oh, x, y)
    	end

  	cc_XCopyPlane, x_copy_plane (d: POINTER; oid, rid: INTEGER; xgc: POINTER;
                ox, oy, ow, oh, x, y, plane_mask: INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XCopyPlane"
    	end

  	cc_XPutImage, x_put_image (d: POINTER; rid: INTEGER; xgc, xim: POINTER;
	       ox, oy, ow, oh, x, y: INTEGER)
    	external "C use <X11/Xlib.h>"
    	alias "XPutImage"
    	end

	XLookupString, x_lookup_string (ev, buf: POINTER; 
		   n: INTEGER;
		   ks, p: POINTER): INTEGER
		do
			Result := c_XLookupString(ev, buf, n, ks, p)
    	end

--	XWithDrawWindow, x_withdraw_window (d: POINTER; rid, scr: INTEGER) is
--		external "C use <X11/Xlib.h>"
--		alias "XWithdrawWindow"
--		end

end
