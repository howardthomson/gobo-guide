/*
	description:

		"C functions used when using the EDP garbage collector"

	system: "Gobo Eiffel Compiler"
	copyright: "Copyright (c) 2007, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2007-08-01 13:00:54 +0100 (Wed, 01 Aug 2007) $"
	revision: "$Revision: 6033 $"
*/

/* TODO:
 * 
 * Free list processing is currently suspect, as at 8-Sep-2009
 * 
 * gc_root free list and gc_arena free-list are currently duplicate ...
 * 	If an item is allocated using the gc-root info, the arena info must
 * 	be updated ...
 * 	
 * Zero memory before returning ...
 * 
 * Decide what to do about what happens when malloc etc can be called from multiple threads.
 * The current assumption is that gc-allocated and gc-collected memory is only accessible from
 * the thread with which it is associated.
 * Should malloc/realloc/free be restricted to use within a single thread ?
 * 
 * Need to track multi-page allocations, to enable unmap after the mutator reference is lost
 * 
 * Need some means of forcing/encouraging other threads to free memory,
 * especially when creating a new thread, or on failure to sys_allocate.
 * 
 * Weak References ...
 * 
 * Report on type-id for objects being collected by the GC.
 * 
 * Calculate no of page allocations before next GC cycle based on the no of
 * pages allocated in total after collection ...
 * 
 * Report run-time in the GC vs runtime not-in-the-GC ...
 */

/* TODO within Eiffel code:
 *	GE_ms8 and GE_ms32 -- provide stack GC info
 *	Likewise for all routines that can call GC directly or indirectly ...
 *		GE_ma... ??
 *	Use temporaries for all reference arguments ...
 *		Such as manifest strings in EDP.make
 *		Multiple reference arguments to a routine where the arguments arise
 *		from a 'create' or a function that does a create, directly or indirectly
 *	Generate mark routines for all once reference values, not just constants ...
 *		See print_gc_mark_once_values_and_inline_constants in ET_LLVM_C_GENERATOR
 *	Generate mark routines for boxed references ...
 *		ANY ...
 *		TUPLE ...
 *		PROCEDURE ... (OK)
 *		AGENT ...
 *
 *	???
 *		TYPED_POINTER [ ANY ] ... Expanded type, need stack walk code
 *	
 *	When sending a message to a different thread, with a proxy reference retained
 *	in the sending thread, need a reference access mechanism in the receiving thread
 *	to detect, and create proxy references for, accesses to objects in the proxied
 *	object set and create, when necessary, a new proxy in the sending thread.
 *	
 *	Investigate implementation of deep_twin, which solves the same marking problem
 *	as the GC needs to contend with ...
 */

/*
 * Design basis:
 * 
 * Memory is requested from the O/S in chunks of 16Mb
 * 
 * The first page is used mainly for card-marking for incremental tracking
 * of actively used pages within the chunk.
 * The next 7 pages contain GC internal structures, and unused space may be used for non-GC
 * related memory malloc/realloc/free etc.
 * 
 * The remaining (4096 - 8) pages are gc-allocated and tracked.
 * 
 * The initial intent is to allocate space on a power-of-2 basis, with a set of
 * free-lists for each allocatable size held in page-1
 */

#ifndef GE_GC_C
#define GE_GC_C

#ifdef EIF_BOEHM_GC
/*
 * Call dispose routine `disp' on object `C'.
 */
void GE_boehm_dispose(void* C, void* disp) {
#ifdef EIF_EXCEPTION_TRACE
	((GE_types[((EIF_REFERENCE)C)->id]).dispose)(0,(EIF_REFERENCE)C);
#else
	((GE_types[((EIF_REFERENCE)C)->id]).dispose)((EIF_REFERENCE)C);
#endif
}

/*========================================================================================================*/

#else /* EIF_BOEHM_GC */

#ifdef EIF_EDP_GC


#include <assert.h>

#define TODO assert(0)

#ifdef COMPILE_STANDALONE

#include <stdlib.h>
#include <sys/mman.h>
#include <stdio.h>
#include <sys/types.h>
#include "ge_gc.h"

/* GC Test routines */

static void * test_roots [4096];
static gc_item_t *test_item_group;

check_group_item() {
		int i;
		gc_item_t *p;
		
		if ((p = test_item_group) != NULL) {
			assert_other(!item__is_free(test_item_group));
			assert_other(test_item_group->gc_reference != NULL);
			assert_other( ! item__is_free(test_item_group->gc_reference));
			for (i = 1; i < 5; i++) {
				assert_other(p->gc_reference != NULL);
				assert_other( ! item__is_free(p->gc_reference));
				p = p->gc_reference;
			}
		}
	}

gc_item_t *last_item_group;

GC__mark_roots (gc_arena_t *pgc) {
	/* locals */
		int i;
		void *p;

	/* do */
		for(i = 0; i < 100; i++)
			test_roots [lrand48() & 4095] = NULL;
		for(i = 0; i < 4096; i++) {
			p = test_roots [i];
			if (p != NULL)
				item__mark (p);
		}
		if (test_item_group != NULL)
			item__mark(test_item_group);
		if (last_item_group != NULL)
			item__mark(last_item_group);
	}

static int gc_test_cycle;
void gc_test_full_collect();

gc_item_t *new_item(int16_t a_id) {
		gc_item_t *R;

		
		R = (gc_item_t *) gealloc_size_id(sizeof(gc_item_t), 0);
		R->id = a_id;
		return (R);
	}

void *new_item_group() {
	/* locals */
		gc_item_t *R;
		gc_item_t *parent, *child;
		int i;
	/* do */
		R = new_item(2);
		last_item_group = R;
		parent = R;
		for(i = 1; i < 4; i++) {
			child = new_item(2);
			parent->gc_reference = child;
			parent = child;
		}
		parent->gc_reference = new_item(1);
		return ((void *)R);
	}

gc_test() {
	/*locals */
		void *R;
		int i;
		int size;
		int id;
		int s;
	/* do */
		i = 0;
		while (1) {
			do {
				size = (lrand48() & ((1 << 11) - 1)) << 4;
				assert_other(size <= 8192*4);
			} while (size == 0);
			assert_other(size != 0);
			s = lrand48() & 1;
			if (s) {
				R = gealloc_size_id (size, 0);
			} else {
				R = new_item_group();
			}
				assert_other(R != NULL);
			test_roots [lrand48() & 4095] = R;

			test_item_group = new_item_group();
		}
	}

int main (int ac, char **av) {
	/* do */
		GE_init_gc();
		gc_test();
	}
#endif /* COMPILE_STANDALONE */

#include <fcntl.h>
#include <unistd.h>
#include <limits.h>
#include <bits/wordsize.h>

#if __WORDSIZE == 64
typedef u_int64_t int_ptr_t;
#elif __WORDSIZE == 32
typedef u_int32_t int_ptr_t;
#else
#error "__WORDSIZE undefined"
#endif

pthread_key_t gc_thread_key;

/* Locking between threads of system memory allocation */
pthread_mutex_t sbrk_lock = PTHREAD_MUTEX_INITIALIZER;

inline void lock_sbrk() {
		pthread_mutex_lock (&sbrk_lock);
	}

inline void unlock_sbrk() {
		pthread_mutex_unlock (&sbrk_lock);
	}

#ifdef COMPILE_STANDALONE
void
gc_test_full_collect() {
		gc_arena_t *pgc;
		
		pgc = (struct gc_arena *) pthread_getspecific (gc_thread_key);
		GC__full_collect (pgc);
}
#endif /* COMPILE_STANDALONE */


/* Forward routine declarations */
void gegc_init_thread();
struct gc_arena *gegc_new_arena();
void read_proc_maps();
int read_proc_map_entry(char *, int);
static void *sys_allocate_16mb(void);
void *GC__alloc_pages(gc_arena_t *, int, int);

void GE_init_gc () {
	/* locals */
		int i;
	/* require */
		assert_require (sizeof (page_info_t) == 6);
		assert_require (sizeof (gc_arena_t) == (4096 * 8));
		assert_require (sizeof (struct ps1_6) <= 48);
		assert_require (sizeof (struct ps7) <= 4096);
		assert_require (sizeof (struct gc_bitmap) == 4096);
		if (sizeof(gc_item_t) > 16)
			printf("sizeof(gc_item_t) = %ld\n", sizeof(gc_item_t));
		assert_require (sizeof (struct gc_item) <= 16);
	/* do */
#ifndef COMPILE_STANDALONE
		GE_init_exceptions();	/* TODO: move to somewhere more appropriate ... */
#endif
		pthread_key_create (&gc_thread_key, NULL);
		gegc_init_thread ();
	}

void gegc_init_thread () {
	/* locals */
		char *cp;
		struct gc_arena *pa;

	/* do */
		cp = (char *) sys_allocate_16mb ();
		pa = (struct gc_arena *) cp;
		pthread_setspecific (gc_thread_key, (void *) pa);
		ARENA__make (pa);
	}

/**************************************************************************
 ************************ mmap memory allocation **************************
 **************************************************************************/

/*
 * This code is Linux, or at least Posix, dependent
 */

static void *sys_allocate_16mb_gc (gc_arena_t *pgc) {
		/* Allocate 16mb aligned data block.
		 * Call GC and repeat if initial failure
		 */
	/* locals */
		void *Result;
	/* do */
		Result = sys_allocate_16mb();
		if (Result == NULL) {
			GC__full_collect (pgc);
			Result = sys_allocate_16mb ();
		}
		if (Result == NULL) {
			/* TODO
			 *	arrange for other threads to free memory ...
			 */
		}
		assert_ensure(Result != NULL);
		return (Result);
	}

static void *sys_allocate_16mb (void) {
	/* locals */
		void *Result;
		void *mmap_result;
		static void *start_hint;
	/* do */
		TRACE_ENTRY(0);
		Result = NULL;
		lock_sbrk ();
		if (start_hint != 0) {
			/* Map a 16Mb region starting from start_hint, which is known to be 16Mb aligned */
			mmap_result = mmap (start_hint, 1 << 24, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
			if (mmap_result != MAP_FAILED) {
				if (((u_int64_t)mmap_result & ((1 << 24) - 1)) != 0) {
					/* mmap_result is NOT 16Mb aligned ... */
					Result = NULL;
					start_hint = NULL;
					munmap (mmap_result, 1 << 24);
				} else {
					Result = mmap_result;
					start_hint = start_hint + (1 << 24);
				}
			} else {
				start_hint = NULL;
			}
		}
		if (Result == NULL) {
			/* Map a 32Mb region, select a 16Mb aligned address within it, and then
			 * unmap (top and tail) the remainder.
			 */ 
			mmap_result = mmap (NULL, 2 << 24, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
			if (mmap_result != MAP_FAILED) {
				Result = (void *)(((u_int64_t)(mmap_result) + ((1 << 24) - 1)) & ~((1 << 24) - 1));
				start_hint = Result + (1 << 24);
				if (Result > mmap_result) {
					munmap (mmap_result, Result - mmap_result);
					munmap (Result + (1 << 24), (1 << 24) - (Result - mmap_result));
				} else {
					munmap (Result + (1 << 24), 1 << 24);
				}
			} else {
				start_hint = NULL;
			}
		}
		
		assert_ensure(((u_int64_t)Result & ((1 << 24) - 1)) == 0);
		unlock_sbrk();
		mapped_space += 4096 * (4096 - 8);
	/* ensure */
		assert_ensure(Result != MAP_FAILED);
		TRACE_EXIT(0);
	/* return */
		return (Result);
	}

/***************************** card__ ... ******************/

inline card__mark (void *p) {
			/* Set the card-mark corresponding to this item address
			 */
		*((char *) (((int_ptr_t)(p) & ~((1 << 24) - 1)) ) + (((int_ptr_t)(p) >> 12) & 0xfff)) = 1;
	}

/* ######################################################################################################*/
/*                                            'item__' routines                                          */
/* ######################################################################################################*/

inline int
item__is_free (gc_item_t *item) {
	/* locals */
		int Result;
	/* require */
		assert_require(item != NULL);
	/* do */
		Result = (item->gc_flags) == 0 && item->id == -1;
	/* return */
		return (Result);
	}

inline void
item__set_free (gc_item_t *item) {
	/* require */
		assert_require(item != NULL);
		assert_require( ! item__is_free(item));
		assert_require(item->id != -1);	/* Was > 0 */
	/* do */
#ifdef EDP_REPORT_GC_ITEM_FREE
		printf("GC Freeing item with type-id = %d at %x\n", item->id, item);
#endif
		item->gc_flags = 0;
		item->id = -1;
		item->gc_item_count = 1;
		item->gc_item_next = 0;
	}

inline void
item__mark_free (gc_item_t *item) {
	/* require */
		assert_require(item != NULL);
	/* do */
		item->gc_flags = 0;
		item->id = -1;
		item->gc_item_count = 1;
		item->gc_item_next = 0;
	}

inline gc_arena_t *
item__to_arena (gc_item_t *item) {
	/* locals */
		gc_arena_t *Result;
	/* require */
		assert_require(item != NULL);
	/* do */
		Result = ((gc_arena_t *) (((int_ptr_t)(item) & ~((((int_ptr_t)(1)) << 24) - 1)) ));
	/* return */
		return (Result);
	}

inline int
item__to_page_no (gc_item_t *item) {
		/* Return the page number of this item,
		 * within its arena
		 */
	/* locals */
		int Result;
	/* require */
		assert_require(item != NULL);
	/* do */
		Result = (((int_ptr_t)(item)) >> 12) & 4095;
	/* return */
		return (Result);
	}

inline gc_item_t *
item__to_page_address (gc_item_t *item) {
		/* Return the base address of the page in
		 * which this item resides.
		 */
	/* locals */
		gc_item_t *Result;
	/* do */
		Result = (gc_item_t *)(((int_ptr_t)(item)) & ~4095);
	/* return */
		return (Result);
	}

inline int item__offset (gc_item_t *p_item) {
		/* Return the byte offset of the item within its page */
	/* locals */
		int Result;
	/* do */
		Result = ((int_ptr_t)(p_item)) & 4095;
	/* return */
		return (Result);
	}

inline void
item__mark (gc_item_t *item) {
	/* do */
		if (item != NULL) {
#if 0
			assert_other(item__validate(item));
#endif
			if ((item->gc_flags & ITEM_IS_MARKED) == 0) {	/* Check for item__has_references ... TODO */
				card__mark (item);
				item->gc_flags |= ITEM_IS_MARKED;
			}
		}
	}

inline int
item__is_marked (gc_item_t *item) {
	/* locals */
		int Result;
	/* require */
		assert_require(item != NULL);
	/* do */
		Result = (item->gc_flags & ITEM_IS_MARKED) != 0;
	/* ensure */
		return (Result);
	}

inline int
item__is_grey (gc_item_t *item) {
	/* locals */
		int Result;
	/* require */
		assert_require(item != NULL);
	/* do */
		Result = (item->gc_flags & ITEM_IS_MARKED) != 0 && (item->gc_flags & ITEM_IS_BLACK) == 0;
	/* ensure */
		return (Result);
	}

inline void
item__set_black (gc_item_t *item) {
	/* require */
		assert_require(item != NULL);
		assert_require(item__is_marked (item));
	/* do */
		item->gc_flags |= ITEM_IS_BLACK;
	/* ensure */
		assert_ensure(item__is_black(item));
	}

inline int
item__is_black (gc_item_t *item) {
	/* locals */
		int Result;
	/* require */
		assert_require(item != NULL);
		assert_require(item__is_marked(item));
	/* do */
		Result = (item->gc_flags & ITEM_IS_BLACK) != 0;
	/* ensure */
		return (Result);
	}

inline void
item__unmark (gc_item_t *p_item) {
		/*
		 * Clear the GC marks for this item.
		 */
	/* require */
		assert_require(p_item != NULL);
	/* do */
		p_item->gc_flags &= ~(ITEM_IS_MARKED | ITEM_IS_BLACK);
	}

inline gc_item_t *
item__indexed (gc_item_t *item, int index, int size) {
		/* Return the address of the item offset indexed by
		 * 'index', for a sized item array of size 'size'
		 */
	/* locals */
		gc_item_t *Result;
	/* do */
		Result = (gc_item_t *)(((char *)(item)) + (index * size));
	/* return */
		return (Result);
	}

#ifndef COMPILE_STANDALONE
void
item__mark_references (gc_item_t *p_item) {
		/* Polymorphic call based on item->id, to mark references
		 * accessible from this item
		 */
	/* locals */
		int id;
		void (*p)(EIF_REFERENCE);
	/* require */
		assert_require(p_item != NULL);
		assert_require(item__validate(p_item));
	/* do */
		TRACE_ENTRY(0);
#if 1
		id = p_item->id;
		assert_other(id > 0);
		p = GE_types[id].gc_mark;
		if (p != NULL) {
#if 0
			printf("Marking references for type id %d\n", id); fflush(stdout);
#endif
			(*p)((EIF_REFERENCE) p_item);
		}
#endif
		TRACE_EXIT(0);
	/* exit */
	}
#else
void
item__mark_references (gc_item_t *p_item) {
		/* Polymorphic call based on item->id, to mark references
		 * accessible from this item.
		 * COMPILE_STANDALONE debug version.
		 */
	/* locals */
		int id;
		gc_item_t *p;
	/* do */
		id = p_item->id;
		if (id == 0) {
			/* do nothing */
		} else if (id == 1) {
			/* Do nothing */
		} else if (id == 2) {
			p = p_item->gc_reference;
			if (p != NULL)
				item__mark (p);
		} else {
			assert_other(0);
		}
	/* exit */
	}
#endif

#ifndef item__validate
item__validate (gc_item_t *item) {
		/* Check that 'item' points to a valid GC item address */
	/* locals */
		gc_arena_t *pa;
		int page_no;
		int page_type;
		int item_size;
	/* do */
		assert_require(item != NULL);
			/* Remember item being checked, in case of assert failure ... */
		gc__last_item_validated = item;
			/* Check within a GC arena */
		pa = item__to_arena(item);
		assert_other(pa->p7.s.arena_magic == ARENA_MAGIC);
			/* Find page_type */
		page_no = item__to_page_no(item);
		assert_other(page_no >= 8);
		page_type = page__type(pa, page_no);
		assert_other(page_type != -1);
		if (page_type >= 0 && page_type <= 7) {
			item_size = 16 << page_type;
			assert_other((item__offset(item) & (item_size - 1)) == 0);
		} else {
			assert_other(item__offset(item) == 0);
			assert_other(page__type(pa, page_no) == page_no);
		}
		assert_ensure(!item__is_free(item) /*1*/);
		return(1);
	}
#endif

#ifndef COMPILE_STANDALONE
#ifndef GE_check_valid
EIF_REFERENCE GE_check_valid(EIF_REFERENCE obj) {
#ifdef EDP_GC_DEBUG
	if (item__validate ((gc_item_t *)obj)) {
		GE_types[((gc_item_t *)obj)->id].gc_flags |= 1;
		return(obj);
	}
#else
		GE_types[((gc_item_t *)obj)->id].gc_flags |= 1;
		return(obj);
#endif
}
#endif
#endif
gc_item_t *gc__last_item_validated;

#if 0
item__mark_if_valid (gc_item_t *p_item) {
		/* Used to conservatively mark references from the stack
		 * No assumptions can be made about the validity of
		 * the argument passed ...
		 */
	/* locals */
		gc_arena_t *pa;
		int page_no;
		int page_type;
		int item_size;
	/* do */
			/* Is it a possible pointer ? */
		if (p_item != NULL && (((int_ptr_t) p_item) & (sizeof(int_ptr_t *) - 1)) == 0) {
				/* Is the page no for this item possible ? */
			page_no = item__to_page_no (p_item);
			if (page_no >= 8) {
					/* Is the corresponding arena valid for this thread ? */
				pa = item__to_arena (p_item);
				if (arena__exists (pa)) {
						/* Check if page is in use ... */
					page_type = page__type (pa, page_no);
					if (page_type >= 0 && page_type <= 7) {
							/* Check if item is on an item aligned boundary */
						item_size = 16 << page_type;
						if ((item__offset(p_item) & (item_size - 1)) == 0)
							item__mark (p_item);
					}
					else if (page_type >= 8) {
							/* Check if item is aligned on page */
						if (item__offset (p_item) == 0 && page__type (pa, page_no) == page_no)
							item__mark (p_item);
					}
				}
			}
		}
	}

int arena__exists (gc_arena_t *a_pa) {
	gc_arena_t *pa;
	int loop_count = 0;
	pa = (struct gc_arena *) pthread_getspecific (gc_thread_key);
	while (pa != NULL) {
		if (pa == a_pa)
			return (1);
		pa = pa->p0.next_arena;
		assert_loop(++loop_count < 10000);
	}
	return (0);
}
#endif

/********************************************************************/


/***************** page__XX *******************************/

inline int
page__type (gc_arena_t *pa, int i);

inline int
page__is_free (gc_arena_t *pa, int i) {
	/* locals */
		int Result;
	/* require */
		assert_require(pa != NULL);
		assert_require(i >= 8 && i <= 4095);
	/* do */
		if (page__type (pa, i) == -1)
			Result = 1;
		else
			Result = 0;
		return (Result);
	}

inline int
page__is_mapped (gc_arena_t *pa, int i) {
	/* locals */
		int Result;
	/* require */
		assert_require(pa != NULL);
		assert_require(i >= 8 && i <= 4095);
		TRACE_ENTRY(1);
	/* do */
		if ((pa->p1_6.page_info[i].s.status & PAGE_NOT_MAPPED) == 0)	/* ???? */
			Result = 1;
		else
			Result = 0;
	/* exit */
		TRACE_EXIT(1);
		assert_ensure(Result);
			/* TEMP, until provision is made to be able to
			 * unmap pages, to return space to the O/S
			 */
		return (Result);
	}

inline int
page__type (gc_arena_t *pa, int page_no) {
		/* Return the type of the page where:
		 *  -1 indicates unused,
		 * 	0..7 indicates single page,
		 * 	8..4094 indicates multiple page, starting at
		 * 	this page number.
		 */
	/* locals */
		int Result;
	/* require */
		assert_require(page__is_mapped (pa, page_no));
	/* do */
		Result = (pa->p1_6.page_info [page_no].s.status & PAGE_TYPE_MASK) - 1;
	/* ensure */
		assert_ensure(Result >= -1);
		assert_ensure(Result <= 4094);
	/* exit */
		return (Result);
	}

inline void
page__set_type (gc_arena_t *pa, int page_no, int p_type) {
	/* locals */
		int16_t status;
	/* require */
		assert_require(pa != NULL);
		assert_require(page_no >= 8 && page_no <= 4095);
		assert_require(p_type >= -1 && p_type <= 4094);
		assert_require((p_type == -1) || page__type (pa, page_no) == -1);
	/* do */
		status = pa->p1_6.page_info [page_no].s.status & ~PAGE_TYPE_MASK;
		pa->p1_6.page_info [page_no].s.status = status | ((p_type + 1) & PAGE_TYPE_MASK);
	/* ensure */
		
	}

inline int
page__has_free (gc_arena_t *pa, int page_no) {
		/* Does this page have any free space ? */
	/* require */
		assert_require(pa != NULL);
		assert_require(page_no >= 8 && page_no <= 4095);
	/* do */
		return (pa->p1_6.page_info[page_no].s.next_free & 1);
	}

inline int
page__next_free (gc_arena_t *pa, int page_no) {
			/* Index of first free item for this page */
	/* require */
		assert_require(pa != NULL);
		assert_require(page_no >= 8 && page_no <= 4095);
		assert_require(pa->p1_6.page_info[page_no].s.next_free & 1);
	/* do */
		return (pa->p1_6.page_info[page_no].s.next_free & ~1);
	}

inline void
page__set_next_free (gc_arena_t *pa, int page_no, int a_next_free) {
			/* Set index of first free object for this page */
	/* require */
		assert_require(pa != NULL);
		assert_require(page_no >= 8 && page_no <= 4095);
		assert_require(a_next_free >= 0 && a_next_free < 4095);
	/* do */
		pa->p1_6.page_info[page_no].s.next_free = a_next_free | 1;
	}

inline void
page__clear_next_free (gc_arena_t *pa, int page_no) {
			/* Clear the available free item index for this page */
	/* require */
		assert_require(pa != NULL);
		assert_require(page_no >= 8 && page_no <= 4095);
	/* do */
		pa->p1_6.page_info[page_no].s.next_free = 0;
	}

inline int
page__free_link (gc_arena_t *pa, int page_no) {
			/* Return the link to the next page with free item(s)
			 * of the same type as this page
			 */
	/* require */
		assert_require(pa != NULL);
		assert_require(page_no >= 8 && page_no <= 4095);
	/* do */
		return(pa->p1_6.page_info[page_no].s.page_link);
	}

inline void
page__set_free_link (gc_arena_t *pa, int page_no, int a_free_link) {
			/* Set the link to the next page with free item(s)
			 * of the same type as this page
			 */
	/* require */
		assert_require(pa != NULL);
		assert_require(page_no >= 8 && page_no <= 4095);
		assert_require(a_free_link >= 0 && a_free_link <= 4095);
	/* do */
		pa->p1_6.page_info[page_no].s.page_link = a_free_link;
	}

inline int
page__is_single (gc_arena_t *pa, int page_no) {
		/* Is page no 'i' of arena 'pa' a single page,
		 * with items of size 2048 bytes or less ?
		 */
	/* require */
		assert_require(page__is_mapped(pa, page_no));
		assert_require(page_no >= 8);
		assert_require(page_no <= 4095);
	/* locals */
		int Result;
		int p_type;
	/* do */
		TRACE_ENTRY(1);

		p_type = page__type (pa, page_no);
		Result = (p_type >= 0) && (p_type <= 7);
	/* exit */
		TRACE_EXIT(1);
		return (Result);
}

void
page__clear_marks (gc_arena_t *pa, int page_no) {
		/* Clear GC marked bit(s) for all items on page no 'page_no'
		 * of arena based at 'pa'
		 */
	/* locals */
		int p_type;
		int i_size;
		int p_offset;
		gc_item_t *p_item;
	/* require */
		assert_require(page_no >= 8);
		assert_require(page_no < 4096);
		assert_require(page__is_mapped(pa, page_no));
	/* do */
		p_type = page__type (pa, page_no);
		assert_other(p_type >= 0 && p_type <= 7);
		i_size = 16 << p_type;
		assert_other(i_size > 0);
		p_offset = 0;
		while (p_offset < 4096) {
			p_item = ARENA__address (pa, page_no, p_offset);
			item__unmark (p_item);
			p_offset += i_size;
		}
		assert_ensure(p_offset == 4096);
	}

int
page__mark_grey (gc_arena_t *pa, int page_no) {	/* RENAME to PAGE__mark ... */
			/*
			 * For each item in the page, if the item is
			 * grey, mark (as grey) items referenced by
			 * this item, and mark this item as black.
			 * Return the no of items marked grey.
			 */
	/* locals */
		int R = 0;
		int p_type;
		int i_size;
		int p_offset;
		gc_item_t *p_item;
	/* require */
		assert_require(pa != NULL);
		assert_require(page__is_single(pa, page_no));
	/* do */
		TRACE_ENTRY(0);
		p_type = page__type (pa, page_no);
		assert_other(p_type >= 0 && p_type <= 7);
		i_size = 16 << p_type;
		assert_other(i_size > 0);
		p_offset = 0;
		while (p_offset < 4096) {
			p_item = ARENA__address (pa, page_no, p_offset);
			if (item__is_free (p_item)) {
				/**/assert_other(p_item->gc_item_count > 0);
				p_offset += p_item->gc_item_count * i_size;
			} else {
				if (item__is_grey(p_item)) {
					item__set_black(p_item);
					item__mark_references (p_item);
					R++;
				}
				p_offset += i_size;
			}
		}
		assert_ensure(p_offset == 4096);
		TRACE_EXIT(0);
		return (R);
	}

/* SUSPECT ROUTINE .... */

void
page__scan_free_single_page (gc_arena_t *pa, int page_no) {
		/* Multiple item page, scan to free
		 * unreachable items after marking
		 * 
		 * Find first free item, and store its index to XXX
		 * 
		 * Link free item-blocks together.
		 */
	/* locals */
		int p_type;	/* Page type */
		int i_size;	/* Item size */
		int p_offset;
		gc_item_t *p_item;
			/* Iterator through items on this page */
		gc_item_t *current_item_group;
			/* If not NULL, pointer to currently accumulating
			 * contiguous free items as a group
			 */
		gc_item_t *previous_item_group;
			/* If not NULL, the previous free item group
			 * to link any subsequent group onto
			 */
		int free_space_found;
			/* Flags for assertion checking on correct
			 * processing of free space metadata
			 */
		int i;
			/* General purpose indexer */
	/* require */
		assert_require(pa != NULL);
		assert_require(page_no >= 8 && page_no <= 4095);
		assert_require(page__is_mapped (pa, page_no));
		assert_require(page__is_single (pa, page_no));
	/* do */
		page__clear_next_free (pa, page_no);
		free_space_found = -1;
		current_item_group = NULL;
		previous_item_group = NULL;
		p_type = page__type (pa, page_no);
		assert_other(p_type >= 0 && p_type <= 7);
		i_size = 16 << p_type;
		p_offset = 0;
		while (p_offset < 4096) {
			p_item = ARENA__address (pa, page_no, p_offset);
			if (item__is_free (p_item)) {
				if (free_space_found == -1)
					free_space_found = p_offset;
				/* Item is already part of the free list */
				free_space += i_size * p_item->gc_item_count;
				/* check forward link */
#if 1
				assert_other((p_item->gc_item_next == 0) || item__is_free (ARENA__address (pa, page_no, p_item->gc_item_next)));
#endif
				p_item->gc_item_next = 0;
				if (current_item_group != NULL) {
					/* Extend current free item group to include
					 * the found existing free item group
					 */
					assert_other ((i_size * current_item_group->gc_item_count + item__offset (current_item_group)) == p_offset);
					current_item_group->gc_item_count += p_item->gc_item_count;
				} else {
					/* ... */
					current_item_group = p_item;
					if (previous_item_group != NULL) {
						assert_other (previous_item_group->gc_item_next == 0);
						previous_item_group->gc_item_next = p_offset;
						previous_item_group = NULL;
					}						
				}

				if(p_item->gc_item_count <= 0) {
					printf("ASSERT --- p_type = %d, p_offset = %d, p_item = %p, gc_item_count = %d\n", p_type, p_offset, p_item, p_item->gc_item_count);
				}
				
				assert_other(p_item->gc_item_count > 0);
				p_offset += p_item->gc_item_count * i_size;
			}
			else if ( ! item__is_marked (p_item)) {	/* Should be item__is_black ... ?? */
				/* This item is currently allocated
				 * and is to be made free
				 */
				if (free_space_found == -1)
					free_space_found = p_offset;
				assert_other(!item__is_free (p_item));
				item__set_free (p_item);
				free_space += i_size;
				if (current_item_group == NULL) {
					/* Start of new item group.
					 * Link it onto previous (if any)
					 */
					current_item_group = p_item;
					p_item->gc_item_next = 0;
					p_item->gc_item_count = 1;
					if (previous_item_group != NULL) {
						previous_item_group->gc_item_next = p_offset;
					}
				} else {
					/* Extension of current item group */
					assert_other(p_item == (gc_item_t *)(((char *)current_item_group)
								+ (i_size * current_item_group->gc_item_count)));
					++current_item_group->gc_item_count;
				}
				p_offset += i_size;
				assert_other(p_item->gc_item_count >= 1);
			} else {
				/* Current item is allocated, not free */
				assert_other ( ! item__is_free (p_item));
				assert_other ( item__is_marked (p_item));
				used_space += i_size;
				if (current_item_group != NULL) {
					/* Finalise current group, and make it the new
					 * previous group
					 */
					assert_other(p_item == (gc_item_t *)(((char *)current_item_group)
								+ (i_size * current_item_group->gc_item_count)));
					previous_item_group = current_item_group;
					current_item_group = NULL;
				} else {
					/* Nothing ... */
				}
				p_offset += i_size;
			}
		}
		assert_other(p_offset == 4096);
		if (current_item_group == ARENA__address (pa, page_no, 0)) {
			/* The whole page consists of a single block of free items */
			page__set_type (pa, page_no, -1);
			free_space_found = -1;
			/* TODO:
			 *		Link free page into metadata ???
			 */
		} else if (free_space_found >= 0) {
			page__set_next_free (pa, page_no, free_space_found);
		} else {
			page__clear_next_free (pa, page_no);
		}
	/* ensure */
	}

inline int
page__scan_free_multi_page (gc_arena_t *pa, int page_no) {
		/* Free one or more pages as a single item.
		 * Return the no. of pages in this group
		 */
	/* locals */
		int i;
		int flag_free;
		gc_item_t *p_item;
	/* require */
		assert_require(pa != NULL);
		assert_require(page_no >= 8);
	/* do */
		p_item = ARENA__address (pa, page_no, 0);
		if (! item__is_marked (p_item)) {
#ifdef EDP_REPORT_GC_ITEM_FREE
			if ( ! item__is_free (p_item)) {
				printf("GC Freeing multi-page item with type-id = %d\n", p_item->id);
			}
#endif
			flag_free = 1;
		} else {
			flag_free = 0;
		}
		i = page_no;
		while (page__type (pa, i) == page_no) {
			assert_other(i < 4096);
			if (flag_free) {
				free_space += 4096;
				page__set_type (pa, i, -1);
			} else {
				used_space += 4096;
			}
			i++;
		}
	/* return */
		return (i - page_no);
	}

int
page__invariant (gc_arena_t *pa, int page_no) {
		/* Check the page for internal consistency */
	/* locals */
		int Result;
		int item_size;
		int p_offset;
		gc_item_t *p_item;
	/* do */
		Result = 1;
		if (page__is_single (pa, page_no) && page__has_free (pa, page_no)) {
			/* Check the free list for this page */
			p_offset = page__next_free (pa, page_no);	//pa->p1_6.page_info [page_no].s.next_free;
			p_item = ARENA__address (pa, page_no, p_offset);
			item_size = 16 << page__type (pa, page_no);
			while (p_item != NULL && item__is_free (p_item)) {
				 p_offset = p_item->gc_item_next;
				 if ( ! (p_offset < 4096)) {
				 	printf("Assertion fail with p_offset = %d\n", p_offset);
				 }
				 assert_other (p_offset < 4096);	/* TODO: Find cause of this assertion's failure ... */
				 if (p_offset != 0)
				 	p_item = ARENA__address (pa, page_no, p_offset);
				 else
				 	p_item = NULL;
			}
		}
	/* return */
		return (Result);
	}

/**************************************************************************/
/************************ ARENA__XXX **************************************/
/**************************************************************************/

ARENA__make (gc_arena_t *pgc) {
	/* 'make' for GC_ARENA */

	/* locals */
	/* do */
		pgc->p7.s.arena_magic = ARENA_MAGIC;
		
	}

inline int
ARENA__free_list (gc_arena_t *pa, int type) {
			/* Return the page_no of the first page having free
			 * space of type 'type'
			 */
		return(pa->p1_6.s.free_list[type]);
	}

inline void
ARENA__set_free_list (gc_arena_t *pa, int type, int page_no) {
			/* Assign the page_no of the first page having free
			 * space of type 'type'
			 */
		pa->p1_6.s.free_list[type] = page_no;
	}

void *
ARENA__alloc_pages (gc_arena_t *pa, int no_pages, int type) {	
		/* Allocate 'no_pages' contiguous pages */

	/* locals */
		void *Result;
		int ri, i, j, k;
		int ri_max;
			/* For a multi-page allocation, the base index of the allocation
			 * may not exceed 4094
			 */
	/* require */
		assert_require(pa != NULL);
		assert_require(no_pages < (4096 - 8));
		assert_require(type == -1 || (type >= 0 && type <= 7));
		assert_require(type == -1 || no_pages == 1);
	/* trace entry */
		TRACE_ENTRY(0);
	/* do */
		Result = NULL;
		ri = 0;
		if (type == -1)
			ri_max = 4094;
		else
			ri_max = 4095;
		i = 8;
		j = 0;
		while (i < 4096 && j < no_pages && (ri + no_pages) < 4096) {
			if (page__is_free (pa, i)) {
				if (ri == 0 && i <= ri_max)
					ri = i;
				j++;
			} else {
				ri = 0;
				j = 0;
			}
			i++;
		}
		if (ri != 0 && j >= no_pages) {
			/* Mark pages as allocated */
			assert_other(j == no_pages);
			if (type == -1) {
				/* Multiple page allocation */
				assert_other(no_pages >= 1);
				for(k = 0; k < j; k++) {
					assert_other(no_pages >= 1);
					assert_other((k + ri) >= 8);
					assert_other((k + ri) <= 4095);
					assert_other(ri <= 4094);
					page__set_type (pa, k + ri, ri);
				}
			} else {
				/* Single page of type 'type' */
				assert_other(type <= 4094);
				page__set_type (pa, ri, type);
			}
			Result = (void *)(((char *)(pa)) + (4096 * ri));
		}
		TRACE_EXIT(0);
		return (Result);
	}

void
ARENA__clear_marks (gc_arena_t *pa) {
		/* Clear all marks for objects within this arena */
	/* locals */
		int i;
		int i_base;
		int last_i;
	/* require */
		assert_require(pa != NULL);
	/* do */
		TRACE_ENTRY(0);
		i = 8;
		while (i < 4096) {
			/* Page is not allocated
			 * OR page is single page of 'small' objects
			 * OR page is first of a multi page object
			 */
			last_i = i;
			if (! page__is_mapped (pa, i)) {
				i++;
				TRACE_LINE_NO(__LINE__);			
			}
			else if (page__type (pa, i) == -1) {
				i++;
				TRACE_LINE_NO(__LINE__);			
			}
			else if (page__is_single (pa, i)) {
				page__clear_marks (pa, i);
				i++;
				TRACE_LINE_NO(__LINE__);			
			}
			else {
				/* unmark the item in this multi-page allocation */
				item__unmark ( ARENA__address (pa, i, 0));
				i_base = i;
				while (page__type (pa, i) == i_base) {
					assert_other(page__is_mapped(pa, i));
					i++;
					TRACE_LINE_NO(__LINE__);			
				}
				assert_loop(i > i_base);
				TRACE_LINE_NO(__LINE__);			
			}
			assert_loop(i > last_i);
		}
		TRACE_EXIT(0);
	}

int
ARENA__scan_mark (gc_arena_t *pa) {
			/*
			 * For each page in the arena, if the page's card is marked,
			 * unmark the card, then for each allocated and marked item
			 * in the page, mark the reachable items.
			 * 
			 * Adapt code to pattern in ARENA__clear_marks
			 * in respect of page indexing ...
			 */
	/* locals */
		int i;
		int i_base;
		int last_i;
		int R = 0;
		gc_item_t *p_item;
	/* do */
		TRACE_ENTRY(0);
		i = 8;
		while (i < 4096) {
			/* Page is not allocated
			 * OR page is single page of 'small' objects
			 * OR page is first of a multi page object
			 */
			last_i = i;
			if (! page__is_mapped (pa, i)) {
				TRACE_LINE_NO(__LINE__);			
				i++;
			}
			else if (page__type (pa, i) == -1) {
				TRACE_LINE_NO(__LINE__);			
				i++;
			}
			else if (page__is_single (pa, i)) {
				TRACE_LINE_NO(__LINE__);			
				if (pa->p0.cards [i] != 0) {
					pa->p0.cards [i] = 0;
					R += page__mark_grey (pa, i);
				}
				i++;
			} else {
				TRACE_LINE_NO(__LINE__);			
				p_item = (gc_item_t *) ARENA__address (pa, i, 0);
				if (item__is_grey(p_item)) {
					item__set_black(p_item);
					item__mark_references (p_item);
					R++;
				}
				i_base = i;
				while (page__type (pa, i) == i_base) {
					assert_other(page__is_mapped(pa, i));
					i++;
					TRACE_LINE_NO(__LINE__);		
				}
				assert_other(i > i_base);
				TRACE_LINE_NO(__LINE__);
			}
			assert_loop(i > last_i);
		}
		TRACE_EXIT(0);
		return (R);
	}

void
ARENA__scan_free (gc_arena_t *pa) {
			/* Scan this arena, freeing any unreachable
			 * but still allocated objects.
			 */
	/* locals */
		int i;
		int last_i;
		int page_type;
	/* require */
		assert_require(pa != NULL);
	/* do */
		i = 0;
		while (i < 8) {
			ARENA__set_free_list (pa, i, 0);
			i++;
		}
		for (i = 8; i < 4096; i++) {
			page__clear_next_free (pa, i);
		}
		i = 8;
		while (i < 4096) {
			TRACE_LINE_NO(__LINE__);
			last_i = i;		
			page_type = page__type (pa, i);
			if (page_type == -1) {
				/* Page is currently free */
				free_space += 4096;
				i++;
				TRACE_LINE_NO(__LINE__);			
			}
			else if (page_type >= 0 && page_type <= 7) {
				/* multiple items on page */
				page__scan_free_single_page (pa, i);
				i++;
				TRACE_LINE_NO(__LINE__);			
			}
			else {
				/* multi-page item */
				assert_other(page_type >= 8);
				i += page__scan_free_multi_page (pa, i);
				TRACE_LINE_NO(__LINE__);			
			}
			assert_loop(i > last_i);
		}
	/* 	TODO; */
	}

inline gc_item_t *
ARENA__address (gc_arena_t *pa, int p, int b) {
		/* Return address within arena, offset by 'p' pages and 'b' bytes */
	/* locals */
		void *Result;
	/* require */
		assert_require(pa != NULL);
		assert_require(p >= 8 && p <= 4095);
		assert_require(b >= 0);
		assert_require(b < (16*1024*1024));
		assert_require((p != 0) ? (b < 4096) : 1);
	/* do */
		TRACE_ENTRY(1);
		Result = (void *)(((char *)(pa)) + (p * 4096) + b);
	/* ensure */
		assert_ensure(Result != NULL);
	/* exit */
		TRACE_EXIT(1);
		return (Result);
	}

/* TODO: Fix page__free_link() */

int
ARENA__has_free_item (gc_arena_t *pa, gc_item_t *p_item) {
		/* Has this arena an item in its free-list
		 * info corresponding to p_item ?
		 */
	/* locals */
		int Result = 0;
		int i, j, k;
		int l_item_page_no;
		int l_item_offset;
		int l_item_type;
		int l_free_list_page_no;
		int l_free_list_offset;
		gc_item_t *l_item;
	/* require */
		assert_require (pa != NULL);
		assert_require (p_item != NULL);
	/* do */
		if (pa == item__to_arena (p_item)) {
			l_item_page_no = item__to_page_no (p_item);
			l_item_offset = item__offset (p_item);
			l_item_type = page__type (pa, l_item_page_no);
			if (l_item_type == -1)
					/* Page is free */
				Result = 1;
			else if (l_item_type >= 8)
					/* Multi-page item */
				Result = 0;
			else {
				l_free_list_page_no = ARENA__free_list (pa, l_item_type);
				if (l_free_list_page_no != 0) {
						/* There is a free list for this type */
					assert_other (page__has_free (pa, l_free_list_page_no));
					while (l_free_list_page_no != 0 && !Result) {
						l_free_list_offset = page__free_link (pa, l_free_list_page_no);
							/* Step through free items on this page */
						assert_other (l_free_list_offset >= 0);
						l_item = ARENA__address (pa, l_free_list_page_no, l_free_list_offset);
						while (l_item != NULL && !Result) {
							if (p_item == l_item)
								Result = 1;
							else if ((l_free_list_offset = l_item->gc_item_next) != 0) {
if(l_free_list_offset < 0) printf("l_free_list_offset = %d at line_no %d\n", l_free_list_offset, __LINE__);
								assert_other (l_free_list_offset >= 0);
								l_item = ARENA__address (pa, l_free_list_page_no, l_free_list_offset);
							} else
								l_item = NULL;
						}
						l_free_list_page_no = page__free_link (pa, l_free_list_page_no);
					}
				}
			}
		}
	/* return */
		return (Result);
	}

int
ARENA__invariant (gc_arena_t *pa) {
		/* Check the Invariant of this Arena
		 */
	/* locals */
		int Result;
		int i;
	/* do */
		Result = 1;
		if (pa->p7.s.arena_magic != ARENA_MAGIC)
			Result = 0;
		i = 8;
		while (Result && i < 4096) {
			if ( !page__invariant (pa, i))
				Result = 0;
			i++;
		}
		for(i = 0; i < 8; i++) {
			if ( !ARENA__check_freelist_for_type (pa, i))
				Result = 0;
		}
	/* return */
		return (Result);
	}

/* TODO: Fix page__free_link() */

int ARENA__check_freelist_for_type (gc_arena_t *pa, int type) {
			/* Check for free list consistency for 'type'
			 * Return True for [apparent] consistency
			 */
	/* locals */
		int Result = 1;
		int l_page;
		int l_offset;
		gc_item_t *l_item;
		int l_next_page;
		int l_next_offset;
	/* do */
		l_page = ARENA__free_list (pa, type);
			/* loop through linked pages with free items of type 'type' */
		while (l_page != 0 && Result) {
			l_next_page = page__free_link (pa, l_page);
				/* loop through free item groups on this page */
			if (page__has_free (pa, l_page)) {
				l_offset = page__next_free (pa, l_page);
				l_item = ARENA__address (pa, l_page, l_offset);
				while (l_item != NULL && Result) {
					l_next_offset = l_item->gc_item_next;
					if (l_next_offset > l_offset) {
						if (l_next_offset >= 4096)
							Result = 0;
						else
							l_item = ARENA__address (pa, l_page, l_next_offset);
					} else {
						Result = 0;
					}
				}
			}
			l_page = page__free_link (pa, l_page);
		}

	/* return */
		return (Result);
	}

/************************** GC__ ... **************************/

gc_arena_t *
GC__make_arena (gc_arena_t *pgc) {
	/* locals */
		gc_arena_t *Result;
	/* require */
		assert_require(pgc != NULL);
		TRACE_ENTRY(0);
	/* do */
		Result = (gc_arena_t *) sys_allocate_16mb_gc (pgc);
		Result->p0.next_arena = pgc->p0.next_arena;
		pgc->p0.next_arena = Result;
		assert_other(Result != NULL);
		ARENA__make (Result);
		TRACE_EXIT(0);
		return (Result);
	}

int invariant__arena_has_free_list(gc_arena_t *pgc) {

	gc_arena_t *pa;
	int i;
	int l_free_index;

	pa = pgc;
	while (pa != NULL) {
		for(i = 0; i < 7; i++) {
			l_free_index = ARENA__free_list(pa, i);
			if (l_free_index != 0)
				assert(page__has_free(pa, l_free_index));
		}
		pa = pa->p0.next_arena;
	}
	return(1);
}

/* SUSPECT ROUTINE .... */

inline gc_item_t *
GC__alloc_type (gc_arena_t *pgc, int type) {
		/* Setup for and allocate an object of (rounded) size '16 << type' */
	/*locals */
		gc_item_t *Result, *l_free_item_block;
		gc_arena_t *pa;
		int l_page_no;
		int l_free_index;
		int l_next_free_index;
		TRACE_ENTRY(0);
	/* require */
		assert_require(pgc != NULL);
		assert_require(type >= 0 && type <= 7);
	/* do */
			/* There are three (?) scenarios to consider:
			 * 1/	A single item, identified from the free list cache, must
			 * 			be removed from the free list.
			 * 2/	An arena with free items must be selected, and a free item removed
			 * 3/	A new page must be allocated, and one item removed.
			 */
		assert_other(pgc->p7.s.free_item_lists[type] == NULL);
		pa = pgc->p7.s.arena_free_cache[type];
		if (pa != NULL) {
			l_free_index = ARENA__free_list (pa, type);
			/**/assert_other(l_free_index != 0);
			/**/assert_other(page__has_free (pa, l_free_index));
			/**/assert_other(invariant__arena_has_free_list(pgc));
		} else {
			pa = pgc;
			l_free_index = 0;
			while (pa != NULL && l_free_index == 0) {
				l_free_index = ARENA__free_list (pa, type);
				if (l_free_index != 0) {
						/* Page has free space of the appropriate size */
					/**/assert_other(page__type (pa, l_free_index) == type);
					/**/assert_other(page__has_free (pa, l_free_index));
				} else {
					pa = pa->p0.next_arena;
				}
			}
			/**/assert_other(invariant__arena_has_free_list(pgc));
		}
		if (pa != NULL) {
				/* Obtain next block of contiguous free items */
			l_free_item_block = ARENA__address (pa, l_free_index, page__next_free (pa, l_free_index));
			/**/assert_other( item__is_free (l_free_item_block));

				/* Update 'pointer' to first free */
			if (l_free_item_block->gc_item_next != 0) {
					/* First free is in this page */
				/**/assert_other(item__is_free(ARENA__address(pa, item__to_page_no (l_free_item_block), l_free_item_block->gc_item_next)));
				/**/assert_other(page__next_free (pa, item__to_page_no(l_free_item_block)) == ((int_ptr_t)l_free_item_block & 4095));

				page__set_next_free (pa, l_free_index, l_free_item_block->gc_item_next);
				assert_other(invariant__arena_has_free_list(pgc));
			} else {
				/**/assert_other(invariant__arena_has_free_list(pgc));
					/* New first free is in linked page, or none */
				l_next_free_index = page__free_link (pa, l_free_index);	/* FIXME */
				ARENA__set_free_list (pa, type, l_next_free_index);
				if (l_next_free_index == 0)
					pgc->p7.s.arena_free_cache[type] = NULL;
				else {
					/**/assert_other(page__has_free (pa, l_free_index));
				}
				page__clear_next_free(pa, l_free_index);

				/**/assert_ensure ( GC__not_in_free_array (pgc, l_free_item_block));
				/**/assert_other(item__is_free(l_free_item_block));
				/**/assert_other(pa == item__to_arena(l_free_item_block));
				assert_other(invariant__arena_has_free_list(pgc));
			}
			assert_other(invariant__arena_has_free_list(pgc));

			if (l_free_item_block->gc_item_count > 1) {
				l_free_item_block->gc_item_count -= 1;
				Result = item__indexed (l_free_item_block, l_free_item_block->gc_item_count, 16 << type);
			} else {
				Result = l_free_item_block;
				l_free_item_block = NULL;
			}
			item__mark_free (Result);
			pgc->p7.s.free_item_lists[type] = l_free_item_block;
		} else {
			/* Allocate a free page ... */
			Result = GC__alloc_pages (pgc, 1, type);
			pgc->p7.s.free_item_lists [ type ] = Result;
				/*
				 * Type 0 => count = 4096 / 16 = 256 >> 0
				 * Type 1 => count = 4096 / 32 = 256 >> 1
				 */
			item__mark_free (Result);
			Result->gc_item_count = 256 >> type;
			Result->gc_item_next = 0;
			Result->gc_item_count -= 1;
			Result = item__indexed (Result, Result->gc_item_count, 16 << type);
			item__mark_free (Result);
			assert_other(item__is_free(Result));
			assert_other(Result->gc_item_count > 0);
			assert_ensure ( GC__not_in_free_array (pgc, Result));
		}
	/* ensure */
		assert_ensure(Result != NULL);
		assert_other(item__is_free(Result));
		TRACE_EXIT(0);
	/* ensure */
		if (Result != NULL) {
			assert_ensure(item__is_free (Result));
#if 0
			assert_other(ARENA__free_list(item__to_arena(Result), type) == 0 || page__has_free(item__to_arena(Result), ARENA__free_list(item__to_arena(Result), type)));
#endif
			assert_invariant(page__invariant (item__to_arena(Result), item__to_page_no(Result)));
			assert_invariant(pa == NULL || ARENA__invariant (pa));
		}
	/* return */
		return(Result);
	}

void
GC__clear_marks (gc_arena_t *pgc) {
		/* Clear all GC marks for this thread
		 */
	/* locals */
		gc_arena_t *pa;
		int loop_count = 0;
	/* require */
		assert_require(pgc != NULL);
	/* do */
		TRACE_ENTRY(0);
		pa = pgc;
		while (pa != NULL) {
			ARENA__clear_marks (pa);
			pa = pa->p0.next_arena;
			assert_loop(++loop_count < 10000);
		}
		TRACE_EXIT(0);
	}

void *gc__root_object;

#ifndef COMPILE_STANDALONE
GC__mark_roots (gc_arena_t *pgc) {
		TRACE_ENTRY(0);
			/* Mark inline-constants and strings */
		gc_mark_constants();
			/* Walk the stack and mark references using
			 * the C stack descriptors (above)
			 */
		GC__mark_stack();
		TRACE_EXIT(0);
	}
#endif

void **stack_bottom;

GC__mark_stack() {
#ifndef COMPILE_STANDALONE
			/* Walk the stack frames of the current thread
			 * and mark all the reference locals, arguments,
			 * temporaries and Result for each frame
			 */
	/* locals */
		struct {
			void *caller;
			void *current;
			void *stack_descriptor;
		} *p;
		GE_stack_t *sdp;
		int i, nb;
		gc_item_t *p_item;
	/* do */
		TRACE_ENTRY(0);
		p = GE_stack_ptr();
		while (p != NULL) {
			sdp = p->stack_descriptor;
			nb = sdp->nb_references;
			for (i = 0; i < nb; i++) {
				p_item = *(gc_item_t **)(((char *)(p)) + sdp->offsets[i]);
				if (p_item != NULL)
					item__mark(p_item);
			}
			p = p->caller;
		}
		TRACE_EXIT(0);
#endif
	}

GC__scan_mark (gc_arena_t *pgc) {
			/* Scan all pages for this thread */
	/* locals */
		gc_arena_t *pa;
		int loop_count = 0;
		int f;
	/* do */
		TRACE_ENTRY(0);
		do {
			f = 0;
			pa = pgc;
			while (pa != NULL) {
				f += ARENA__scan_mark (pa);
				pa = pa->p0.next_arena;
			}
			assert_loop(++loop_count < 100000);
		} while (f != 0);
		TRACE_EXIT(0);
	}

GC__scan_free (gc_arena_t *pgc) {
		/* Scan all pages for this thread,
		 * and add to free metadata all unreachable items
		 */
	/* require */
		assert_require(pgc != NULL);
	/* locals */
		gc_arena_t *pa;
		int i;
	/* do */
		TRACE_ENTRY(0);
		i = 0;
		while (i <= 7) {
			pgc->p7.s.free_item_lists [ i ] = NULL;
			pgc->p7.s.arena_free_cache [ i ] = NULL;
			i++;
		}
		pa = pgc;
		while (pa != NULL) {
			ARENA__scan_free (pa);
			pa = pa->p0.next_arena;
		}
		TRACE_EXIT(0);
	}

static int pages_allocated;	/* TODO -- must be thread specific !! */

GC__collect_pages (gc_arena_t *pgc, int no_requested) {
	/* locals */
	/* do */
		TRACE_ENTRY(0);
#ifndef COMPILE_STANDALONE
		if ((pages_allocated += no_requested) >= GC_PAGE_CYCLE) {
#else
		if ((pages_allocated += no_requested) >= 1000) {
#endif
			pages_allocated = 0;
#if 0
printf("Calling GC__full_collect() ...\n"); fflush(stdout);
			GE_print_stack();
#endif
#if 1
			GC__full_collect (pgc);
#endif
#if 0
			GE_print_stack();
printf("Done GC__full_collect() ...\n"); fflush(stdout);
#endif
		}	
		TRACE_EXIT(0);
	}

int gc_collect_cycle;	/* TODO: Move to per-thread ... */

report_start_full_collect() {
#if 0
	printf("Full Collection Starting ...\n");
#endif
}

report_end_full_collect() {
#if 0
	printf("Full Collection Ended ...\n");
#endif
}

int flag_track_generation_classes;

void enable_class_generation_tracking()
{
	flag_track_generation_classes = 1;
}

void disable_class_generation_tracking()
{
	int i, nb;
#if 0	
	flag_track_generation_classes = 0;
#ifndef COMPILE_STANDALONE
	nb = 1951;
		/* TODO: Make accessible to the runtime code, 
		 * the number of dynamic types in the system
		 */
	for (i = 0; i < nb; i++) {
		if (GE_types[i].gc_flags & 1) {
			/* TODO: Assign a more appropriate flag in the GE_types array ... */
			printf("Class: %s\n", GE_types[i].a1);
		}
	}
#endif
#endif
}

void
GC__full_collect (gc_arena_t *pgc) {
	/* locals */
		long ratio;
	/* do */
		TRACE_ENTRY(0);
		++ gc_collect_cycle;
		free_space = 0;
		used_space = 0;
		report_start_full_collect();
		GC__clear_marks(pgc);
		GC__mark_roots(pgc);
		GC__scan_mark(pgc);
		assert_other(free_space == 0 && used_space == 0);
		GC__scan_free(pgc);
		/**/assert_other(invariant__arena_has_free_list(pgc));
#if 0
		GC__mark_roots(pgc);	/* Check assertions about item__is_allocated */
#endif
		report_end_full_collect();
		printf("gc_collect_cycle = %6d  ", gc_collect_cycle);
		printf("free_space = %10ld, used_space = %10ld, mapped_space = %10ld, diff = %ld, ",
			free_space, used_space, mapped_space,
			free_space + used_space - mapped_space);
		ratio = used_space * 100;
		ratio /= mapped_space;
		printf("used / mapped = %3ld ", ratio);
		printf("\n");
#if 0
		if (gc_collect_cycle == 1) {
			GC__dump_arenas(); exit(0);
		}
#endif
		assert_other((free_space + used_space) == mapped_space);
#ifdef COMPILE_STANDALONE
		check_group_item();
#endif
		TRACE_EXIT(0);
	}

void *
GC__alloc_pages (gc_arena_t *pgc, int no_pages, int type) {	
		/* Allocate 'no_pages' contiguous pages */
	/* locals */
		gc_arena_t *pa;
		void *Result;
		int ri, i, j, k;
		int ri_max;
			/* For a multi-page allocation, the base index of the allocation
			 * may not exceed 4094
			 */
	/* require */
		assert_require(pgc != NULL);
		assert_require(no_pages < (4096 - 8));
		assert_require(type == -1 || (type >= 0 && type <= 7));
		assert_require(type == -1 || no_pages == 1);
	/* trace entry */
		TRACE_ENTRY(0);
	/* do */
		GC__collect_pages (pgc, no_pages);
		pa = pgc;
		Result = NULL;

		while (pa != NULL && Result == NULL) {
			Result = ARENA__alloc_pages (pa, no_pages, type);
			pa = pa->p0.next_arena;
		}
		if (Result == NULL) {
			assert_other(pa == NULL);
			pa = GC__make_arena (pgc);

			Result = ARENA__alloc_pages (pa, no_pages, type);
			assert_other (Result != NULL);
		}
		
		assert_ensure (Result != NULL);
		TRACE_EXIT (0);
		return (Result);
	}

/* end of GC__XXX */

/******************************************************************* Main entry point ****************************************************/

void *
gealloc_size_id (int size, int id) {
	/* locals */
		gc_item_t *Result;
		struct gc_arena *pgc;
		int size_type;
		int size_rounded;
		void *next_limit;

	/* require */
		assert_require(size <= ((1 << 24) - (4096 * 8)));
		TRACE_ENTRY(0);
	/* do */
		/* Retrieve pointer to gc_root */
		pgc = (struct gc_arena *) pthread_getspecific (gc_thread_key);
		assert_require(pgc != NULL);
		assert_require((((int_ptr_t)pgc) & 0xffffff) == 0);
		assert_invariant(GC__invariant (pgc));
		/* Convert size into allocation type */
		if (size > 2048) {

			/* Allocate a multiple of pages ... */
			Result = GC__alloc_pages (pgc, (size + 4095) >> 12, -1);
		} else {
			size_type = 0;
			size_rounded = 16;
			while (size > size_rounded) {
				size_type ++;
				size_rounded <<= 1;
			}
			assert_other(size_type >= 0 && size_type <= 7);
			Result = pgc->p7.s.free_item_lists [ size_type ];
			if (Result != NULL) {
					/* Multiple items in this block; return the last item */
				assert_other(item__is_free (Result));
				Result->gc_item_count -= 1;
				if(Result->gc_item_count > 0)
					Result = item__indexed (Result, Result->gc_item_count, size_rounded);
				else
					pgc->p7.s.free_item_lists [ size_type ] = NULL;
				assert_ensure ( GC__not_in_free_array (pgc, Result));
			} else {
				Result = GC__alloc_type (pgc, size_type);
				assert_ensure ( GC__not_in_free_array (pgc, Result));
			}
		}
		assert_ensure(Result != NULL);
		/* Clear the user area of the object */
		memset (Result, 0, size);
		Result->gc_flags = ITEM_IS_ALLOCATED;
#if 0
		item__set_id ((gc_item_t *)(Result), id);
#endif
		assert_ensure ( ! item__is_free(Result));
		assert_ensure ( GC__not_in_free_array (pgc, Result));
		GC__last_item_allocated = Result;
	/* invariant */
		assert_invariant(GC__invariant (pgc));
		TRACE_EXIT(0);
	/* return*/
		return ((void *) Result);
	}

gc_item_t *GC__last_item_allocated;



/*==================================================
 * Code solely existing for assertion monitoring ...
 *==================================================*/

int
GC__not_in_free_array (gc_arena_t *pgc, void *p_item) {
	/* locals */
		int i;
		gc_arena_t *pa;
		int Result = 1;
	/* ensure */
		assert_require(pgc != NULL);
		assert_require(p_item != NULL);
	/* do */
		TRACE_ENTRY(0);
		i = 0;
		while (i <= 7) {
			if (pgc->p7.s.free_item_lists [ i ] == p_item) {
				Result = 0;
				printf("In pgc->free_item_lists ...\n");
			}
			i++;
		}
		TRACE_EXIT(0);
		return (Result);
	}

int
GC__invariant (gc_arena_t *pgc) {
	/* locals */
		int i;
		gc_item_t *p_item;
		gc_arena_t *pa;
	/* do */
		i = 0;
		while (i <= 7) {
			p_item = pgc->p7.s.free_item_lists [ i ];
			if (p_item != NULL) {
				assert_other (item__is_free (p_item));
				assert_other (p_item->gc_item_count >= 1);
			}
			i++;
		}
		pa = pgc;
		while (pa != NULL) {
			assert_other( ARENA__invariant (pa));
			pa = pa->p0.next_arena;
		}
	/* return */
		return (1);	/* TEMP */
	}

#define LINE_BUFFER_SIZE 1000

int line_no_buffer[LINE_BUFFER_SIZE];
int line_no_index;

void trace_line_no (int line) {
	line_no_buffer [line_no_index++] = line;
	if (line_no_index >= LINE_BUFFER_SIZE) {
		line_no_index = 0;
	}
}

void print_line_no_trace () {
	int i;

	i = line_no_index;
	while (i < LINE_BUFFER_SIZE) {
		printf ("Line No: %d\n", line_no_buffer[i]);
		i++;
	}
	i = 0;
	while (i < line_no_index) {
		printf ("Line No: %d\n", line_no_buffer[i]);
		i++;
	}
}

GC__dump_arenas() {
		/* Dump all arenas to filesystem */
	/* local */
		int fd;
		gc_arena_t *pgc;
		gc_arena_t *pa;
		int written;
	/* do */
		printf ("GC__dump_arenas() called ...\n");
		fd = creat ("./edp_gc_dump_arenas", 0666);
		if (fd > 0) {
			pgc = (struct gc_arena *) pthread_getspecific (gc_thread_key);
			pa = pgc;
			while (pa != NULL) {
				printf ("Dumping arena: %p\n", pa);
				written = write (fd, pa, (1 << 24));
				if (written != (1 << 24)) {
					printf("Write failed: %d\n", written);
					perror ("GC__dump_arenas");
				}
				pa = pa->p0.next_arena;
			}
			close (fd);
		} else {
			printf("Unable to create ./edp_gc_dump_arenas\n");
		}
		GC__dump_arenas_as_text();
	}

GC__dump_arenas_as_text() {
		/* Dump all arenas to filesystem */
	/* local */
		gc_arena_t *pgc;
		gc_arena_t *pa;
		int i;
	/* do */
		printf ("GC__dump_arenas_as_text() called ...\n");
		pgc = (struct gc_arena *) pthread_getspecific (gc_thread_key);
		pa = pgc;
		while (pa != NULL) {
			printf ("Dumping arena: %p\n", pa);
			GC__dump_page_info(pa);
			for(i = 8; i < 4096; i++)
				GC__dump_page(pa, i);
			pa = pa->p0.next_arena;
		}
	}

GC__dump_page_info(gc_arena_t *pa) {
	/* local */
		int i;
	/* do */
		for(i = 0; i < 8; i++) {
			printf("free_list[%d] = %x\n", i, pa->p1_6.s.free_list[i]);
		}
		for(i = 8; i < 4096; i++) {
			printf("Page no: %4d, offset: %4x -- ", i, i << 12);
			printf("Status: %4x, next_free: %6x, free_link: %6x\n",
				pa->p1_6.page_info[i].s.status,
				pa->p1_6.page_info[i].s.next_free,
				pa->p1_6.page_info[i].s.page_link);
		}
	}

GC__dump_page(gc_arena_t *pa, int page_no) {

	}

#else

/* No Garbage Collector */

#endif
#endif
#endif
