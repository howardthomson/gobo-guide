note
	description:"Base class for various list/tree etc. items"
	author:		"Eugene Melekhov <eugene_melekhov@mail.ru>"
	copyright:	"Copyright (c) 2002, Eugene Melekhov and others"
	license:	"Eiffel Forum Freeware License v2 (see forum.txt)"
	status:		"Mostly complete"

	todo: "[
		Add code to support multi-line labels
	]"

class SB_ITEM

inherit

	SB_DEFS
	SB_EXPANDED

feature -- Initialization

	make_empty
    	do
         	create label.make_empty
      	end

   	make (text: STRING; ic: SB_ICON; dt: ANY)
      	do
         	if text /= Void then
            	create label.make_from_string (text)
         	else
            	create label.make_empty
         	end
         	icon := ic
         	data := dt
      	end

feature -- Data

	label: STRING

	icon: SB_ICON

	data: ANY

feature -- Queries

	has_focus: BOOLEAN
		do 
         	Result := (state & FOCUS) /= 0
      	end

   	is_selected: BOOLEAN
      	do
         	Result := (state & SELECTED) /= 0
      	end

   	is_enabled: BOOLEAN
      	do
         	Result := (state & DISABLED) = 0
      	end

   	is_draggable: BOOLEAN
      	do 
         	Result := (state & DRAGGABLE) /= 0
      	end

	has_expander: BOOLEAN
		do
			Result := (state & EXPANDABLE) /= 0
		end

feature -- Settings

	set_text (txt: STRING)
		require
			txt /= Void
		do
			create label.make_from_string (txt)
		end

   	set_icon (icn: SB_ICON)
      	do
         	icon := icn
      	end

	set_data (dt: ANY)
    	do
			data := dt
      	end

   	set_focus (a_focus: BOOLEAN)
      	do
         	if a_focus then
            	state := state | FOCUS
         	else
            	state := state & (FOCUS).bit_not
         	end
      	end

   set_selected (a_selected: BOOLEAN)
      do
         if a_selected then
            state := state | SELECTED
         else
            state := state & (SELECTED).bit_not
         end
      end

   set_enabled (enabled: BOOLEAN)
      do
         if enabled then
            state := state & (DISABLED).bit_not
         else
            state := state | DISABLED
         end
      end

   set_draggable (a_draggable: BOOLEAN)
      do
         if a_draggable then
            state := state | DRAGGABLE;
         else
            state := state & (DRAGGABLE).bit_not
         end
      end

	set_has_expander (h: BOOLEAN)
		do
			if not h then	-- !!!
				state := state & (EXPANDABLE).bit_not
			else
				state := state | EXPANDABLE
			end
		end

feature -- Resource management

   	create_resource
      	do
         	if icon /= Void then
            	icon.create_resource
         	end
      	end

   	detach_resource
      	do
         	if icon /= Void then
            	icon.detach_resource
         	end
      	end

	destroy_resource
      	do
	--		if (state & Icon_owned) /= 0 and then icon /= Void then
	--			icon.destroy_resource
	--		end
      	ensure implemented: false
      	end

feature { SB_ITEM, SB_ITEM_CONTAINER }

	state: INTEGER

   	set_state (s: INTEGER)
      	do
         	state := s
      	end

	copy_state (other: like Current)
    	require
        	other /= Void
      	do
         	state := other.state
      	end

feature { NONE } -- Implementation

	SELECTED	: INTEGER = 0x00000001	-- Is Selected ?
	FOCUS		: INTEGER = 0x00000002	-- Has the Focus ?
	DISABLED	: INTEGER = 0x00000004	-- Is it disabled ?
	DRAGGABLE	: INTEGER = 0x00000008	-- Can it be dragged ?
	EXPANDABLE	: INTEGER = 0x00000010	-- Has +/- icon to expand children ?

feature

--	inherited_conflict_mask: INTEGER is
--		do
--		--	Result := 0
--		end

--	conflict_mask: INTEGER is
--		do
--			Result := 0x0000001F	-- OR of all flags above
--		end

invariant
--	no_flags_conflict: conflict_mask & inherited_conflict_mask = 0
end
