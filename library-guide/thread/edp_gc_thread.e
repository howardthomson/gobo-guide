note

	description: "'guide' GC co-ordination thread"

class EDP_GC_THREAD

inherit

	THREAD

	EDP_ZEROMQ_SHARED_CONTEXT
	
create

	make

feature -- Attributes

feature {NONE} -- Creation

	make (

feature

	execute
			-- This implements the deferred feature in THREAD that is
			-- executed when this thread starts ...
		do

		end