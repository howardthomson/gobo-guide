/* Copyright (C) Howard Thomson 2006 */
/* License: Eiffel Forum Freeware License V2 (See License-EFFL-V2) */

void *sb_application;

int (*sb_x_error_handler)();
int (*sb_x_io_handler)();

extern void XSetErrorHandler();
extern void XSetIOErrorHandler();

extern int c_x_error_handler();
extern int c_x_io_error_handler();


static int xerrorhandler(void* dpy, void* eev){

	return((*sb_x_error_handler)(sb_application, dpy, eev));
//	return(c_x_error_handler(sb_application, dpy, eev));
}


// Fatal error (e.g. lost connection)
static int xfatalerrorhandler(void* dpy){
	return((*sb_x_io_handler)(sb_application, dpy));
//	return(c_x_io_error_handler(sb_application, dpy));
}


void sb_set_x_error_handler(void *app, int (*f_err)(), int (*f_io_err)())
{

	sb_application = app;

	sb_x_error_handler = f_err;
	sb_x_io_handler = f_io_err;

	/* Set error handler */
	XSetErrorHandler(xerrorhandler);

	/* Set fatal handler */
	XSetIOErrorHandler(xfatalerrorhandler);
}

