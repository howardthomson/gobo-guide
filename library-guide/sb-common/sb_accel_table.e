note
	description: "[
		The accelerator table sends a message to a specific target
		object when the indicated key and modifier combination is pressed.
	]"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"mostly complete"

class SB_ACCEL_TABLE

inherit

	SB_MESSAGE_HANDLER
		redefine
			handle_2
		end

create

	make

feature  -- Creation

	make
         	-- Construct empty accelerator table
      	do
         	create dictionary.make (10)
      	end

feature -- Queries

   has_accel (hotkey: INTEGER): BOOLEAN
         -- Return true if accelerator specified
      do
         Result := dictionary.has (hotkey)
      end

  accel_target (hotkey: INTEGER): SB_MESSAGE_HANDLER
         -- Return target object of the given accelerator
      local
         key: SB_ACCEL_KEY
      do
         key := find_key (hotkey)
         if key /= Void then
            Result := key.target
         end
      end

feature -- Actions

   add_accel (hotkey : INTEGER; target: SB_MESSAGE_HANDLER; seldn, selup: INTEGER)
         -- Add an accelerator to the table
      require
         target /= Void
      local
         key: SB_ACCEL_KEY
      do
         create key.make (hotkey, target, seldn, selup)
         dictionary.put (key, hotkey)
      end

	remove_accel (hotkey: INTEGER)
			-- Remove mapping for specified hot key
		local
			key: SB_ACCEL_KEY
		do
			if dictionary.has (hotkey) then
			--	dictionary.search (hotkey)
			--	key := dictionary.found_item
				dictionary.remove (hotkey)
			end
		end

feature -- Message processing

	on_key_press (sender: SB_MESSAGE_HANDLER; selector: INTEGER; data: ANY): BOOLEAN
			-- Keyboard press; forward to focus child
		local
			event: SB_EVENT
        	key: SB_ACCEL_KEY
        	code: INTEGER
      	do
         	event ?= data
         	if event /= Void then
            	code := mksel ((event.state & (SHIFTMASK | CONTROLMASK | ALTMASK)), event.code)
            	key := find_key (code)
            	if key /= Void then
               		if key.message_down > 0 and then key.target /= Void then
                  		key.target.do_handle_2 (sender, SEL_KEYPRESS, key.message_down, data)
               		end
               		Result := True
            	end
         	else
            	-- TODO Error handling
         	end
      	end

	on_key_release (sender: SB_MESSAGE_HANDLER; selector : INTEGER; data: ANY): BOOLEAN
			-- Keyboard release; forward to focus child
		local
         	event: SB_EVENT
         	key: SB_ACCEL_KEY
         	code: INTEGER
      	do
         	event ?= data
         	if event /= Void then
            	code := mksel ((event.state & (SHIFTMASK | CONTROLMASK | ALTMASK)), event.code)
            	key := find_key (code)
            	if key /= Void then
               		if key.message_up > 0 and then key.target /= Void then
                  		key.target.do_handle_2 (sender, SEL_KEYRELEASE, key.message_up, data)
               		end
               		Result := True
            	end
         	else
            	-- TODO Error handling
         	end
      	end

	handle_2 (sender: SB_MESSAGE_HANDLER; type, key: INTEGER; data: ANY): BOOLEAN
		do
        	if		match_function_2 (SEL_KEYPRESS,  0, type, key) then Result := on_key_press   (sender, key, data)
        	elseif  match_function_2 (SEL_KEYRELEASE,0, type, key) then Result := on_key_release (sender, key, data)
        	else Result := Precursor (sender, type, key, data)
        	end
      	end

feature { NONE } -- Implementation

	dictionary: HASH_TABLE [SB_ACCEL_KEY, INTEGER]

	find_key (hotkey: INTEGER): SB_ACCEL_KEY
		do
         	dictionary.search (hotkey)
         	if dictionary.found then
            	Result := dictionary.found_item
         	end
      	end

end

