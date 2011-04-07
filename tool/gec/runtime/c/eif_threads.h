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
