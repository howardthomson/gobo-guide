note
    description: "[
            -- X Window System implementation code for SB_APP
	]"
	todo: "[
			Modify add_repaint &c to not export X internals to cross-platform
			classes and code
			Re-code get_next_event et-al to ensure that blocking actions only occur after processing of
			currently accumulated events after the expiration of the last blocking action.
	]"

	done: "[
			FIXGC: cross_bits etc once routines currently return a POINTER as the once value. The once value
			should be a reference to the manifest array, so that the GC will not collect it, making the
			currently available POINTER value invalid.
	]"

class SB_APPLICATION

inherit

EV_APPLICATION_IMP

end
