/*
	description:

		"C functions used to implement class EXCEPTION"

	system: "Gobo Eiffel Compiler"
	copyright: "Copyright (c) 2007, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2007-03-30 20:58:53 +0100 (Fri, 30 Mar 2007) $"
	revision: "$Revision: 5932 $"
*/

#ifndef GE_EXCEPTION_H
#define GE_EXCEPTION_H

#include <setjmp.h>
/*
	On Linux glibc systems, we need to use sig* versions of jmp_buf,
	setjmp and longjmp to preserve the signal handling context.
	One way to detect this is if _SIGSET_H_types has
	been defined in /usr/include/setjmp.h.
	NOTE: ANSI only recognizes the non-sig versions.
*/
#if (defined(_SIGSET_H_types) && !defined(__STRICT_ANSI__))
#define GE_jmp_buf sigjmp_buf
#define GE_setjmp(x) sigsetjmp((x),1)
#define GE_longjmp(x,y) siglongjmp((x),(y))
#else
#define GE_jmp_buf jmp_buf
#define GE_setjmp(x) setjmp((x))
#define GE_longjmp(x,y) longjmp((x),(y))
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define	Void_call_target 1
			/* Exception code for feature applied to void reference */

#define	No_more_memory 2
			/* Exception code for failed memory allocation */

#define	Precondition 3
			/* Exception code for violated precondition */

#define	Postcondition 4
			/* Exception code for violated postcondition */

#define	Floating_point_exception 5
			/* Exception code for floating point exception */

#define	Class_invariant 6
			/* Exception code for violated class invariant */

#define	Check_instruction 7
			/* Exception code for violated check */

#define	Routine_failure 8
			/* Exception code for failed routine */

#define	Incorrect_inspect_value	9
			/* Exception code for inspect value which is not one */
			/* of the inspect constants, if there is no Else_part */

#define	Loop_variant 10
			/* Exception code for non-decreased loop variant */

#define	Loop_invariant 11
			/* Exception code for violated loop invariant */

#define	Signal_exception 12
			/* Exception code for operating system signal */

#define	Eiffel_runtime_panic 13
			/* Eiffel run-time panic */

#define	Rescue_exception 14
			/* Exception code for exception in rescue clause */

#define	Out_of_memory 15
			/* Out of memory (cannot be ignored) */

#define	Resumption_failed 16
			/* Resumption failed (retry did not succeed) */

#define	Create_on_deferred 17
			/* Create on deferred */

#define	External_exception 18
			/* Exception code for operating system error */
			/* which does not set the `errno' variable */
			/* (Unix-specific) */

#define	Void_assigned_to_expanded 19
			/* Exception code for assignment of void value */
			/* to expanded entity */

#define	Exception_in_signal_handler 20
			/* Exception in signal handler */

#define	Io_exception 21
			/* Exception code for I/O error */

#define	Operating_system_exception 22
			/* Exception code for operating system error */
			/* which sets the `errno' variable */
			/* (Unix-specific) */

#define	Retrieve_exception 23
			/* Exception code for retrieval error */
			/* may be raised by `retrieved' in `IO_MEDIUM'. */

#define	Developer_exception 24
			/* Exception code for developer exception */

#define	Eiffel_runtime_fatal_error 25
			/* Eiffel run-time fatal error */

#define	Dollar_applied_to_melted_feature 26
			/* $ applied to melted feature */

#define	Runtime_io_exception 27
			/* Exception code for I/O error raised by runtime functions */
			/* such as store/retrieve, file access... */

#define	Com_exception 28
			/* Exception code for a COM error. */

#define	Runtime_check_exception 29
			/* Exception code for runtime check being violated. */

#define	number_of_codes 29
			/* How many codes are there to represent exceptions? */

/*
 *	Information about the feature being executed.
 */
typedef struct GE_call_struct GE_call;
struct GE_call_struct {
	char* feature_name;
	char* type_name;
	GE_call* caller; /* previous feature in the call chain */
};


/*
 *	Context of features containing a rescue clause.
 */
typedef struct GE_rescue_struct GE_rescue;
struct GE_rescue_struct {
	GE_jmp_buf jb;
	GE_rescue * previous; /* previous context in the call chain */
};

/*
 *	Context of last feature entered containing a rescue clause.
 *	Warning: this is not thread-safe.
 */
extern GE_rescue *GE_get_rescue();
extern void GE_set_rescue(GE_rescue *);

extern void GE_init_exceptions();

/*
 *	Context of last feature entered containing a rescue clause.
 *	Warning: this is not thread-safe.
 *	Remove when generation of 'main' adjusted appropriately.
 */
extern GE_rescue * GE_last_rescue;

/*
 *	Raise an exception with code 'code'.
 */
extern void GE_raise(int code);

/*
 *	Check whether the type id of 'obj' is not in 'type_ids'.
 *	If it is, then raise a CAT-call exception. Don't do anything if 'obj' is Void.
 *	'nb' is the number of ids in 'type_ids' and is expected to be >0.
 *	'type_ids' is sorted in increasing order.
 *	Return 'obj'.
 */
#define GE_catcall(obj,type_ids,nb) GE_check_catcall((obj),(type_ids),(nb))
EIF_REFERENCE GE_check_catcall(EIF_REFERENCE obj, int type_ids[], int nb);

/*
 *	Check whether 'obj' is Void.
 *	If it is, then raise a call-on-void-target exception.
 *	Return 'obj'
 */
#define GE_void(obj) (!(obj)?GE_check_void(obj):GE_check_valid(obj))
extern EIF_REFERENCE GE_check_void(EIF_REFERENCE obj);
extern EIF_REFERENCE GE_check_valid(EIF_REFERENCE obj);

/*
 *	Check whether 'ptr' is a null pointer.
 *	If it is, then raise a no-more-memory exception.
 *	Return 'ptr'
 */
#define GE_null(ptr) GE_check_null(ptr)
extern void* GE_check_null(void* ptr);

#ifndef WIN32

#include <pthread.h>
#include <signal.h>

#ifdef EIF_EDP_GC
extern pthread_key_t GE_rescue_key;
extern pthread_key_t GE_stack_key;
#if 0
#define GE_stack_ptr()	(void *)(pthread_getspecific(GE_stack_key))
#define GE_set_stack_ptr(x)	pthread_setspecific(GE_stack_key, (void *)(x))
#else
	void *GE_stack_ptr();
	void GE_set_stack_ptr (void*);
#endif
#else
#define GE_stack_ptr()			GE_internal_stack
#define GE_set_stack_ptr(x)		GE_internal_stack = (x)
extern void *GE_internal_stack;
#endif

#else	/* ifndef WIN32 */

extern void *GE_internal_stack;

#define GE_stack_ptr()			GE_internal_stack
#define GE_set_stack_ptr(x)		GE_internal_stack = (x)

#endif

extern void GE_print_stack();

#ifdef __cplusplus
}
#endif

#endif
