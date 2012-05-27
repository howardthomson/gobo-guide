/*
	description:

		"C functions used to implement class FILE_64"

	system: "Gobo Eiffel Compiler"
	copyright: "Copyright (c) 2006-2007, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"
*/

/* Note: This file can NOT be included into eif_file.c
 * This is because the required use of #defines to access
 * the 64-bit definitions of 'stat buf' etc re-define the
 * implementations of the 32-bit implementations in eif_file.c
 * Which is not what is wanted ...
 */

#ifndef EIF_FILE_64_C
#define EIF_FILE_64_C

#define _FILE_OFFSET_BITS 64

#include "ge_eiffel.h"
#include "eif_except.h"

#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#ifdef EIF_WINDOWS
#include <sys/utime.h>
extern int utime(const char *, struct utimbuf *); /* Needed for lcc-win32 */
#include <io.h> /* for access, chmod */
#include <direct.h> /* for (ch|mk|rm)dir */
#else
#include <utime.h>
#include <unistd.h>
#include <pwd.h>
#include <grp.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#include <inttypes.h>
#include <errno.h>
#include <sys/stat.h>

/*
 * Size of file `fp'.
 * 64-bit version
 */
EIF_INTEGER_64 eif_file_size_64(FILE *fp) {
	struct stat buf;

	errno = 0;
	if (fflush (fp) != 0) {
		esys();
	}
	if (fstat64(fileno(fp), &buf) == -1) {
		esys();
		return (EIF_INTEGER_64)0;
	} else {
		return (EIF_INTEGER_64)(buf.st_size);
	}
}

/*
 * Current position within file as 64-bit integer.
 */
EIF_INTEGER_64 file_tell_64(FILE *f) {

	if (f == (FILE *) 0) {
		eraise("invalid file pointer", EN_EXT);
	}
	return (EIF_INTEGER_64)(ftello64(f));
	
}

/*
 * Go to absolute position `pos' counted from start.
 * 64-bit version
 */
void file_go_64(FILE *f, EIF_INTEGER_64 pos) {
	errno = 0;
	if (fseeko64(f, pos, SEEK_SET) != 0) {
		esys();
	}
	clearerr(f);
}

/*
 * Go to absolute position `pos' counted from end.
 */
void file_recede_64(FILE *f, EIF_INTEGER_64 pos) {
	errno = 0;
	if (fseeko64(f, -pos, SEEK_END) != 0) {
		esys();
	}
	clearerr(f);
}

/*
 * Go to absolute position `pos' counted from current position.
 */
void file_move_64(FILE *f, EIF_INTEGER_64 pos) {
	errno = 0;
	if (fseeko64(f, pos, SEEK_CUR) != 0) {
		esys();
	}
	clearerr(f);
}

#ifdef __cplusplus
}
#endif

#endif