/*
	description:

		"C functions used to implement class IDENTIFIED"

	system: "Gobo Eiffel Compiler"
	copyright: "Copyright (c) 2007, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"
*/

#ifndef GE_IDENTIFIED_C
#define GE_IDENTIFIED_C

#ifdef __cplusplus
extern "C" {
#endif

/*
 * Initialize data to keep track of object ids.
 */
void GE_init_identified(void) {
#if 0
	GE_id_objects = (GE_weak_pointer***) 0;
	GE_id_objects_capacity = 0;
	GE_last_object_id = 0;
#endif
}

/*
	Get a new id for `object', assuming it is NOT in the stack.
*/
EIF_INTEGER GE_object_id(EIF_OBJECT object) {
	return (EIF_INTEGER)object;
}

/*
	Return the object associated with `id'.
*/
EIF_REFERENCE GE_id_object(EIF_INTEGER id) {
	return (EIF_REFERENCE)id;
}

/*
	Remove the object associated with `id' from the stack.
*/
void GE_object_id_free(EIF_INTEGER id) {
	/* Do nothing */
}

#ifdef __cplusplus
}
#endif

#endif
