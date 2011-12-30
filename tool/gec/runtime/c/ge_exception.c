/*
	description:

		"C functions used to implement class EXCEPTION"

	system: "Gobo Eiffel Compiler"
	copyright: "Copyright (c) 2007, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2007-03-30 20:58:53 +0100 (Fri, 30 Mar 2007) $"
	revision: "$Revision: 5932 $"
*/

#ifndef GE_EXCEPTION_C
#define GE_EXCEPTION_C

#ifdef __cplusplus
extern "C" {
#endif



#ifndef EIF_EDP_GC

/*
 *	Context of last feature entered containing a rescue clause.
 *	Warning: this is not thread-safe.
 */
GE_rescue * GE_last_rescue;

GE_rescue *GE_get_rescue() {
	return(GE_last_rescue);
}

void GE_set_rescue(GE_rescue *r) {
	GE_last_rescue = r;
}

/*
 *	Raise an exception with code 'code'.
 */
void GE_raise(int code)
{
	GE_rescue *r = GE_last_rescue;
	if (r != 0) {
		GE_last_rescue = r->previous;
		GE_longjmp(r->jb, code);
	}
#ifdef EIF_WINDOWS
	GE_show_console();
#endif
	fprintf(stderr, "Unhandled exception\n");
	exit(1);
}

void *GE_internal_stack;

#else /* EIF_EDP_GC */

/* Raise an exception with code `code'. */
void GE_raise(int code) {
	GE_rescue *r = GE_get_rescue();
	if (r != 0) {
		GE_set_rescue(r->previous);
/* TODO: Fix/unwind GE_stack */
		GE_longjmp(r->jb, code);
	}
	GE_print_stack();
	fprintf(stderr, "Unhandled exception\n");
	exit(1);
}


#ifndef WIN32

static void GE_setup_signal_handling();
#if 1
static void GE_handle_exception(int, struct sigcontext);
#else
static void GE_handle_exception(int, sigcontext_t *, ucontext_t *)
#endif
static void GE_signal_exit();
static void print_stack();

pthread_key_t GE_rescue_key;
pthread_key_t GE_stack_key;

void GE_init_exceptions()
{
	pthread_key_create (&GE_rescue_key, NULL);
	pthread_key_create (&GE_stack_key, NULL);
	GE_set_rescue (NULL);
	GE_setup_signal_handling ();
}

GE_rescue *GE_get_rescue()
{
	return((GE_rescue *) pthread_getspecific(GE_rescue_key));
}

void GE_set_rescue(GE_rescue *g)
{
	pthread_setspecific(GE_rescue_key, (void *) g);
}

/*
	SIG_ERR: Error return code from sigaction()
	SIG_DFL: Signal Default Action value for sa_handler
	SIG_IGN: Signal Ignore Action value for sa_handler
 */

static struct sigaction old_sig_action;
static struct sigaction trap_sig_action;
static struct sigaction ign_sig_action;

static void GE_setup_signal(int sig, int trap)
{
	struct sigaction *p_sig;

	if (sigaction (sig, NULL, &old_sig_action) < 0) {
		GE_signal_exit (1);
	} else {
		if (old_sig_action.sa_handler != SIG_IGN) {
			if (trap) {
				p_sig = &trap_sig_action;
				sigemptyset(&p_sig->sa_mask);		/* ??? */
				sigaddset(&p_sig->sa_mask, sig);		/* ??? */
			} else {
				p_sig = &ign_sig_action;
			}
				/* Maybe use sigfillset + segdelset ??? */
			if (sigaction (sig, p_sig, NULL) < 0) {
				GE_signal_exit (2);
			}
		}
	}
}

void GE_signal_exit(int i)
{
	printf("Signal setup failure! Origin %d\n", i);
	perror("Signal setup failure");
	exit(1);
}

#ifndef True
#define True 1
#endif

#ifndef False
#define False 0
#endif

static void GE_setup_signal_handling()
{

	/* Setup new_sig_action */
#if 1
	trap_sig_action.sa_handler = (void (*)())(GE_handle_exception);
#else
	trap_sig_action.sa_sigaction = (void (*)())(GE_handle_exception);
#endif
	trap_sig_action.sa_flags = SA_RESTART;

	ign_sig_action.sa_handler = SIG_IGN;
	ign_sig_action.sa_flags = 0;

#ifdef SIGHUP
	GE_setup_signal(SIGHUP, True);		/* 1 */
#endif
#ifdef SIGINT
	GE_setup_signal(SIGINT, True);		/* 2 */
#endif
#ifdef SIGQUIT
	GE_setup_signal(SIGQUIT, True);		/* 3 */
#endif
#ifdef SIGILL
	GE_setup_signal(SIGILL, True);		/* 4 */
#endif
#ifdef SIGTRAP
	GE_setup_signal(SIGTRAP, True);		/* 5 */
#endif
#ifdef SIGABRT
	GE_setup_signal(SIGABRT, True);		/* 6 */
#endif
#ifdef SIGBUS
	GE_setup_signal(SIGBUS, True);		/* 7 */
#endif
#ifdef SIGFPE
	GE_setup_signal(SIGFPE, True);		/* 8 */
#endif

/* SIGKILL */							/* 9 */

#ifdef SIGUSR1
	GE_setup_signal(SIGUSR1, True);		/* 10 */
#endif
#ifdef SIGSEGV
	GE_setup_signal(SIGSEGV, True);		/* 11 */
#endif
#ifdef SIGUSR2
	GE_setup_signal(SIGUSR2, True);		/* 12 */
#endif
#ifdef SIGPIPE
	GE_setup_signal(SIGPIPE, False);	/* 13 */
#endif
#ifdef SIGALRM
	GE_setup_signal(SIGALRM, True);		/* 14 */
#endif
#ifdef SIGTERM
	GE_setup_signal(SIGTERM, True);		/* 15 */
#endif
#ifdef SIGSTKFLT
	GE_setup_signal(SIGSTKFLT, True);	/* 16 */
#endif
#if 0
#ifdef SIGCHLD
	GE_setup_signal(SIGCHLD, False);	/* 17 */
#endif
#endif
#ifdef SIGCONT
	GE_setup_signal(SIGCONT, False);	/* 18 */
#endif

/* SIGSTOP */							/* 19 */

#ifdef SIGTSTP
	GE_setup_signal(SIGTSTP, False);	/* 20 */
#endif
#ifdef SIGTTIN
	GE_setup_signal(SIGTTIN, False);	/* 21 */
#endif
#ifdef SIGTTOU
	GE_setup_signal(SIGTTOU, False);	/* 22 */
#endif
#ifdef SIGURG
	GE_setup_signal(SIGURG, False);		/* 23 */
#endif
#ifdef SIGXCPU
	GE_setup_signal(SIGXCPU, True);		/* 24 */
#endif
#ifdef SIGXFSZ
	GE_setup_signal(SIGXFSZ, True);		/* 25 */
#endif
#ifdef SIGVTALRM
	GE_setup_signal(SIGVTALRM, False);	/* 26 */
#endif
#ifdef SIGPROF
	GE_setup_signal(SIGPROF, False);	/* 27 */
#endif
#ifdef SIGWINCH
	GE_setup_signal(SIGWINCH, False);	/* 28 */
#endif
#ifdef SIGIO
	GE_setup_signal(SIGIO, False);		/* 29 */
#endif
#ifdef SIGPWR
	GE_setup_signal(SIGPWR, False);		/* 30 */
#endif
#ifdef SIGSYS
	GE_setup_signal(SIGSYS, True);		/* 31 */
#endif

}
#if 0 /* user.h not included in openSUSE 11.1 */
#include <asm/user.h>
#endif
#if 0
#include <asm/sigcontext.h>
#endif

void print_registers_struct(struct sigcontext *p) {
#ifdef X86_64
	printf("r8 =       %lx\n", p->r8);
	printf("r9 =       %lx\n", p->r9);
	printf("r10 =      %lx\n", p->r10);
	printf("r11 =      %lx\n", p->r11);
	printf("r12 =      %lx\n", p->r12);
	printf("r13 =      %lx\n", p->r13);
	printf("r14 =      %lx\n", p->r14);
	printf("r15 =      %lx\n", p->r15);

	printf("rdi =      %lx\n", p->rdi);
	printf("rsi =      %lx\n", p->rsi);
	printf("rbp =      %lx\n", p->rbp);
	printf("rbx =      %lx\n", p->rbx);
	printf("rdx =      %lx\n", p->rdx);
	printf("rax =      %lx\n", p->rax);
	printf("rcx =      %lx\n", p->rcx);
	printf("rsp =      %lx\n", p->rsp);
	printf("rip =      %lx\n", p->rip);
	printf("eflags =   %lx\n", p->eflags);
	printf("cs =       %lx\n", p->cs);
	printf("gs =       %lx\n", p->gs);
	printf("fs =       %lx\n", p->fs);
#endif

#if 0
	printf("orig_rax = %lx\n", p->orig_rax);
	printf("ss =       %lx\n", p->ss);
	printf("fs_base =  %lx\n", p->fs_base);
	printf("gs_base =  %lx\n", p->gs_base);
	printf("ds =       %lx\n", p->ds);
	printf("es =       %lx\n", p->es);
#endif
}

/* GE_handle_exception needs to be modified to accept up-to-date arguments
 * Specifically, a sigcontext_t and a ucontext_t pointer ...
 */
#if 1
static void GE_handle_exception(int signum, struct sigcontext a_context)
#else
static void GE_handle_exception(int signum, siginfo_t *a_context, ucontext_t *a_user_context)
#endif
{
	printf("Exception no %d\n", signum);
	print_stack();
#if 0
	print_registers_struct(a_context);
#endif
#if 0
	print_line_no_trace();
#endif
	exit(1);
}

void GE_print_stack() {
	print_stack();
}

static void print_stack()
{
	struct {
		void *caller;
		void *current;
#ifdef EIF_EDP_GC
		void *stack_descriptor;
#endif
#ifdef EIF_INSTRUCTION_LOCATION_TRACE
		char *class_and_feature;
		int line_number;
#endif
	} *p;
	gc_item_t *item;

	printf("Printing GE_stack ...\n");
	p = GE_stack_ptr();
	while (p != NULL) {
		printf("gestack_ptr = %x\n", p);
		if (p->current != NULL) {
			printf("   Current = %x\n", p->current);
			printf("   Current->id = %d\n", *((int16_t *)(p->current)));
		}
#ifdef EIF_INSTRUCTION_LOCATION_TRACE
		if (p->class_and_feature != NULL) {
			printf("   Class/feature = %s\n", p->class_and_feature);
			printf("   Line number = %d\n", p->line_number);
		}
#endif
		p = p->caller;
	}
		/* Print details of last item being validated ... */
	if ((item = gc__last_item_validated) != NULL) {
		printf("Last item validated: id = %d\n", item->id);
		printf("Last item validated: flags = %x\n", item->gc_flags);
	}
#ifdef EDP_GC_DEBUG
	printf("About to call gc__dump_arenas() ... ?\n");
	GC__dump_arenas();
#endif
}

#if 1
static void * GE_stack_ptr_base;

void * GE_stack_ptr()
{
	return ((void *)(pthread_getspecific(GE_stack_key)));
}

void GE_set_stack_ptr (void *a_value)
{
	if (GE_stack_ptr_base != NULL) {
		GE_check_stack (pthread_getspecific(GE_stack_key));
	} else {
		GE_stack_ptr_base = a_value;
	}
	pthread_setspecific (GE_stack_key, (void *)(a_value));
}

GE_check_stack (void *a_stack_ptr)
{
	struct {
		void *caller;
		void *current;
#ifdef EIF_EDP_GC
		void *stack_descriptor;
#endif
#ifdef EIF_INSTRUCTION_LOCATION_TRACE
		char *class_and_feature;
		int line_number;
#endif
	} *p;
	gc_item_t *item;

	p = a_stack_ptr;
	while (p != NULL) {
		p = p->caller;
	}
}

#endif
#else /* ifndef WIN32 */

static void GE_setup_signal_handling();
static void GE_handle_exception(int);
static void GE_signal_exit();
static void print_stack();

void *internal_gestack;

#if 0
pthread_key_t gerescue_key;
pthread_key_t gestack_key;
#endif

void geinit_exceptions()
{
#if 0
	pthread_key_create (&gerescue_key, NULL);
	pthread_key_create (&gestack_key, NULL);
#endif
	set_gerescue (NULL);
	GE_setup_signal_handling ();
}

static struct gerescue *internal_gerescue;

struct gerescue *gerescue()
{
	return internal_gerescue;
#if 0
	return((struct gerescue *) pthread_getspecific(gerescue_key));
#endif
}

void set_gerescue(struct gerescue *g)
{
	internal_gerescue = g;
#if 0
	pthread_setspecific(gerescue_key, (void *) g);
#endif
}

/*
	SIG_ERR: Error return code from sigaction()
	SIG_DFL: Signal Default Action value for sa_handler
	SIG_IGN: Signal Ignore Action value for sa_handler
 */
#if 0
static struct sigaction old_sig_action;
static struct sigaction trap_sig_action;
static struct sigaction ign_sig_action;
#endif
static void GE_setup_signal(int sig, int trap)
{
#if 0
	struct sigaction *p_sig;

	if (sigaction (sig, NULL, &old_sig_action) < 0) {
		GE_signal_exit (1);
	} else {
		if (old_sig_action.sa_handler != SIG_IGN) {
			if (trap) {
				p_sig = &trap_sig_action;
				sigemptyset(&p_sig->sa_mask);		/* ??? */
				sigaddset(&p_sig->sa_mask, sig);		/* ??? */
			} else {
				p_sig = &ign_sig_action;
			}
				/* Maybe use sigfillset + segdelset ??? */
			if (sigaction (sig, p_sig, NULL) < 0) {
				GE_signal_exit (2);
			}
		}
	}
#endif
}

void GE_signal_exit(int i)
{
	printf("Signal setup failure! Origin %d\n", i);
	perror("Signal setup failure");
	exit(1);
}

#ifndef True
#define True 1
#endif

#ifndef False
#define False 0
#endif

static void GE_setup_signal_handling()
{
#if 0
	/* Setup new_sig_action */
	trap_sig_action.sa_handler = (void (*)())(GE_handle_exception);
	trap_sig_action.sa_flags = SA_RESTART;

	ign_sig_action.sa_handler = SIG_IGN;
	ign_sig_action.sa_flags = 0;
#endif
#ifdef SIGHUP
	GE_setup_signal(SIGHUP, True);		/* 1 */
#endif
#ifdef SIGINT
	GE_setup_signal(SIGINT, True);		/* 2 */
#endif
#ifdef SIGQUIT
	GE_setup_signal(SIGQUIT, True);		/* 3 */
#endif
#ifdef SIGILL
	GE_setup_signal(SIGILL, True);		/* 4 */
#endif
#ifdef SIGTRAP
	GE_setup_signal(SIGTRAP, True);		/* 5 */
#endif
#ifdef SIGABRT
	GE_setup_signal(SIGABRT, True);		/* 6 */
#endif
#ifdef SIGBUS
	GE_setup_signal(SIGBUS, True);		/* 7 */
#endif
#ifdef SIGFPE
	GE_setup_signal(SIGFPE, True);		/* 8 */
#endif

/* SIGKILL */							/* 9 */

#ifdef SIGUSR1
	GE_setup_signal(SIGUSR1, True);		/* 10 */
#endif
#ifdef SIGSEGV
	GE_setup_signal(SIGSEGV, True);		/* 11 */
#endif
#ifdef SIGUSR2
	GE_setup_signal(SIGUSR2, True);		/* 12 */
#endif
#ifdef SIGPIPE
	GE_setup_signal(SIGPIPE, False);	/* 13 */
#endif
#ifdef SIGALRM
	GE_setup_signal(SIGALRM, True);		/* 14 */
#endif
#ifdef SIGTERM
	GE_setup_signal(SIGTERM, True);		/* 15 */
#endif
#ifdef SIGSTKFLT
	GE_setup_signal(SIGSTKFLT, True);	/* 16 */
#endif
#if 0
#ifdef SIGCHLD
	GE_setup_signal(SIGCHLD, False);	/* 17 */
#endif
#endif
#ifdef SIGCONT
	GE_setup_signal(SIGCONT, False);	/* 18 */
#endif

/* SIGSTOP */							/* 19 */

#ifdef SIGTSTP
	GE_setup_signal(SIGTSTP, False);	/* 20 */
#endif
#ifdef SIGTTIN
	GE_setup_signal(SIGTTIN, False);	/* 21 */
#endif
#ifdef SIGTTOU
	GE_setup_signal(SIGTTOU, False);	/* 22 */
#endif
#ifdef SIGURG
	GE_setup_signal(SIGURG, False);		/* 23 */
#endif
#ifdef SIGXCPU
	GE_setup_signal(SIGXCPU, True);		/* 24 */
#endif
#ifdef SIGXFSZ
	GE_setup_signal(SIGXFSZ, True);		/* 25 */
#endif
#ifdef SIGVTALRM
	GE_setup_signal(SIGVTALRM, False);	/* 26 */
#endif
#ifdef SIGPROF
	GE_setup_signal(SIGPROF, False);	/* 27 */
#endif
#ifdef SIGWINCH
	GE_setup_signal(SIGWINCH, False);	/* 28 */
#endif
#ifdef SIGIO
	GE_setup_signal(SIGIO, False);		/* 29 */
#endif
#ifdef SIGPWR
	GE_setup_signal(SIGPWR, False);		/* 30 */
#endif
#ifdef SIGSYS
	GE_setup_signal(SIGSYS, True);		/* 31 */
#endif

}

static void GE_handle_exception(int signum)
{
	printf("Exception no %d\n", signum);
	print_stack();
	exit(1);
}

static void print_stack()
{
	struct {
		void *caller;
		void *current;
	} *p;

	printf("Printing GE_stack ...\n");
	p = GE_stack_ptr();
	while (p != NULL) {
		printf("gestack_ptr = %x\n", p);
		if (p->current != NULL) {
			printf("   Current->id = %d\n", *((int *)(p->current)));
		}
		p = p->caller;
	}
}

#endif /* Win32 */
#endif /* EIF_EDP_GC */

/*
 *	Check whether the type id of 'obj' is not in 'type_ids'.
 *	If it is, then raise a CAT-call exception. Don't do anything if 'obj' is Void.
 *	'nb' is the number of ids in 'type_ids' and is expected to be >0.
 *	'type_ids' is sorted in increasing order.
 *	Return 'obj'.
 */
EIF_REFERENCE GE_check_catcall(EIF_REFERENCE obj, int type_ids[], int nb)
{
	if (obj) {
		int type_id = obj->id;
		if (type_id < type_ids[0]) {
			/* Done */
		} else if (type_id > type_ids[nb-1]) {
			/* Done */
		} else {
			int i;
			for (i = 0; i < nb; i++) {
				if (type_id == type_ids[i]) {
#ifdef EIF_WINDOWS
					GE_show_console();
#endif
					fprintf(stderr, "CAT-call error!\n");
#ifdef EIF_DEBUG
					{
						char c;
						fprintf(stderr, "Press Enter...\n");
						scanf("%c", &c);
					}
#endif
					GE_raise(24);
					break;
				} else if (type_id < type_ids[i]) {
						/* type-ids are sorted in increasing order. */
					break;
				}
			}
		}
	}
	return (obj);
}

/*
 *	Check whether 'obj' is Void.
 *	If it is, then raise a call-on-void-target exception.
 *	Return 'obj'
 */
EIF_REFERENCE GE_check_void(EIF_REFERENCE obj)
{
	if (!obj) {
#ifdef EIF_WINDOWS
		GE_show_console();
#endif
		fprintf(stderr, "Call on Void target!\n");
#ifdef EIF_DEBUG
		{
			char c;
			fprintf(stderr, "Press Enter...\n");
			scanf("%c", &c);
		}
#endif
		GE_raise(1);
	} else {
#ifdef EIF_EDP_GC
		if (((gc_item_t *)obj)->id <= 0) {
			printf("Accessing %x where id = %d\n", obj, ((gc_item_t *)obj)->id);
		}
#endif
	}
	return (obj);
}

/*
 *	Check whether 'ptr' is a null pointer.
 *	If it is, then raise a no-more-memory exception.
 *	Return 'ptr'
 */
void* GE_check_null(void* ptr)
{
	if (!ptr) {
#ifdef EIF_WINDOWS
		GE_show_console();
#endif
		fprintf(stderr, "No more memory!\n");
#ifdef EIF_DEBUG
		{
			char c;
			fprintf(stderr, "Press Enter...\n");
			scanf("%c", &c);
		}
#endif
		GE_raise(2);
	}
	return (ptr);
}

#ifdef __cplusplus
}
#endif

#endif
