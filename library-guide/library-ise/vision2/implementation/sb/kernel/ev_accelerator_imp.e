indexing
	description: "EiffelVision accelerator. Slyboots implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_ACCELERATOR_IMP

inherit
	EV_ACCELERATOR_I
		export
			{EV_INTERMEDIARY_ROUTINES} actions_internal
		redefine
			interface
		end

create
	make

feature {NONE} -- Initialization

	old_make (an_interface: like interface)
			-- Connect interface.
		do
			assign_interface (an_interface)
		end

	make
			-- Setup `Current'
		do
			create key
			set_is_initialized (True)
		end

feature {EV_SB_WINDOW_IMP} -- Implementation

	accel_id: INTEGER
			-- Id of `Current' used for hash table lookup.
		do
			Result := generate_accel_id (key, control_required, alt_required, shift_required)
		end

	generate_accel_id (a_key: EV_KEY; a_control_required, a_alt_required, a_shift_required: BOOLEAN): INTEGER is
		do
			Result := a_key.code
			Result := Result |<< 8
			if a_control_required then
				Result :=  Result + {SB_MODIFIER_MASKS}.CONTROLMASK
			end
			Result := Result |<< 8
			if a_alt_required then
				Result := Result + {SB_MODIFIER_MASKS}.ALTMASK
			end
			Result := Result |<< 8
			if a_shift_required then
				Result := Result + {SB_MODIFIER_MASKS}.SHIFTMASK
			end
		end

feature -- Access

	key: EV_KEY
			-- Representation of the character that must be entered
			-- by the user. See class EV_KEY_CODE

	shift_required: BOOLEAN
			-- Must the shift key be pressed?

	alt_required: BOOLEAN
			-- Must the alt key be pressed?

	control_required: BOOLEAN
			-- Must the control key be pressed?

feature -- Element change

	set_key (a_key: EV_KEY) is
			-- Set `a_key' as new key that has to be pressed.
		do
			key := a_key.twin
		end

	enable_shift_required is
			-- "Shift" must be pressed for the key combination.
		do
			shift_required := True
		end

	disable_shift_required is
			-- "Shift" is not part of the key combination.
		do
			shift_required := False
		end

	enable_alt_required is
			-- "Alt" must be pressed for the key combination.
		do
			alt_required := True
		end

	disable_alt_required is
			-- "Alt" is not part of the key combination.
		do
			alt_required := False
		end

	enable_control_required is
			-- "Control" must be pressed for the key combination.
		do
			control_required := True
		end

	disable_control_required is
			-- "Control" is not part of the key combination.
		do
			control_required := False
		end

feature {NONE} -- Implementation

	interface: EV_ACCELERATOR
		-- Interface object of `Current'

feature {NONE} -- Implementation

	destroy is
			-- Free resources of `Current'
		do
			key := Void
			set_is_destroyed (True)
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EV_ACCELERATOR_IMP
