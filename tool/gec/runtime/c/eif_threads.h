/*
	description:

		"C functions used to implement Thread support"

	system: "Gobo Eiffel Compiler"
	copyright: "Copyright (c) 2007-2010, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"
*/

#ifndef EIF_THREADS_H
#define EIF_THREADS_H

#if 1
#include "eif_cecil.h"
#endif

#ifdef __cplusplus
extern "C" {
#endif

#ifndef EIF_THREADS

/*
	Empty stubs for EiffelThread library so that it may be compiled against a non-multithreaded run-time.
*/
#define eif_thr_mutex_create() NULL
#define eif_thr_mutex_lock(a_mutex_pointer)
#define eif_thr_mutex_unlock(a_mutex_pointer)
#define eif_thr_mutex_trylock(a_mutex_pointer) EIF_FALSE
#define eif_thr_mutex_destroy(a_mutex_pointer)
#define eif_thr_cond_create() NULL
#define eif_thr_cond_broadcast(a_cond_ptr)
#define eif_thr_cond_wait(a_cond_ptr,a_mutex_ptr)
#define eif_thr_cond_destroy(a_mutex_ptr)
#define eif_thr_thread_id() NULL
#define eif_thr_last_thread() NULL
#define eif_thr_default_priority() 0
#define eif_thr_create_with_args(current_obj, init_func, priority, policy, detach)
#define eif_thr_sleep(nanoseconds)
#define eif_thr_cond_signal(a_cond_ptr)
#define eif_thr_cond_wait_with_timeout(a_cond_ptr,a_mutex_ptr,a_timeout) 0

#else

/* Declaration for the Threads system */

/* class CONDITION_VARIABLE */

void *	eif_thr_cond_create();
void	eif_thr_cond_broadcast (void *);
void	eif_thr_cond_signal (void *);
void	eif_thr_cond_wait (void *, void *);
int		eif_thr_cond_wait_with_timeout (void *, void *, int);
void	eif_thr_cond_destroy (void *);

/* class THREAD_ENVIRONMENT */

void *
eif_thr_thread_id();

/* class THREAD_CONTROL */

void	eif_thr_join_all();
void	eif_thr_yield();

/* class THREAD */

void	eif_thr_exit();
		/* Exit calling thread. Must be called from the thread itself. */

void	eif_thr_create_with_attr (void *current_obj, void *init_func, void *attr);
			/* Initialize and start thread, after setting its priority
			 * and stack size.
			 */

void	eif_thr_wait (void *term);
			/* The calling C thread waits for the current Eiffel thread to
			 * terminate.
			 */

boolean_t	eif_thr_wait_with_timeout (void *term, uint64_t a_timeout_ms);
			/* The calling C thread waits for the current Eiffel thread to
			 * terminate.
			 */

void *	eif_thr_last_thread();
			/* Returns a pointer to the thread-id of the last created thread. */

/* class MUTEX */

void *		eif_thr_mutex_create();
void		eif_thr_mutex_lock		(void *a_mutex_pointer);
void		eif_thr_mutex_unlock	(void *a_mutex_pointer);
boolean_t	eif_thr_mutex_trylock	(void *a_mutex_pointer);
void		eif_thr_mutex_destroy	(void *a_mutex_pointer);

/* class READ_WRITE_LOCK */

void *	eif_thr_rwl_create();
void	eif_thr_rwl_rdlock (void *an_item);
void	eif_thr_rwl_unlock (void *an_item);
void	eif_thr_rwl_wrlock (void *an_item);
void	eif_thr_rwl_destroy (void *an_item);

/* class SEMAPHORE */

void *		eif_thr_sem_create (int );
void		eif_thr_sem_wait (void *);
void		eif_thr_sem_post (void *);
boolean_t	eif_thr_sem_trywait (void *);
void		eif_thr_sem_destroy (void *);


#endif

#ifdef __cplusplus
}
#endif

#endif
